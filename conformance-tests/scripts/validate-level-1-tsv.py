#!/usr/bin/env python3
"""Validate OHD Level 1 TSV metadata, field count, and trace relationships."""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

EXPECTED = [
    "timestamp", "client_ip", "method", "host", "path", "status", "duration",
    "traceparent", "tracestate", "ohd_trace_id", "query", "protocol",
    "bytes_sent", "referer", "user_agent",
]
TRACEPARENT_V00 = re.compile(r"^00-([0-9a-f]{32})-([0-9a-f]{16})-([0-9a-f]{2})$")
TRACE_ID = re.compile(r"^[0-9a-f]{32}$")


def fail(message: str) -> None:
    raise ValueError(message)


def validate(path: Path, enforce_relationship: bool) -> int:
    lines = path.read_text(encoding="utf-8").splitlines()
    fields = None
    records = []
    for lineno, line in enumerate(lines, 1):
        if not line:
            continue
        if line.startswith("#Fields:"):
            fields = line.split(":", 1)[1].strip().split()
        elif not line.startswith("#"):
            records.append((lineno, line.split("\t")))

    if fields is None:
        fail("missing #Fields metadata")
    if fields != EXPECTED:
        fail(f"field list differs from OHD 0.4 expected order: {fields!r}")
    if not records:
        fail("no data records found")

    for lineno, values in records:
        if len(values) != len(fields):
            fail(f"line {lineno}: expected {len(fields)} columns, found {len(values)}")
        record = dict(zip(fields, values))
        tp = record["traceparent"]
        ohd = record["ohd_trace_id"]

        if tp != "-":
            match = TRACEPARENT_V00.fullmatch(tp)
            if not match:
                fail(f"line {lineno}: prototype validator supports only valid version 00 traceparent values")
            if match.group(1) == "0" * 32 or match.group(2) == "0" * 16:
                fail(f"line {lineno}: traceparent contains an all-zero identifier")
            if enforce_relationship and ohd != "-" and ohd != match.group(1):
                fail(f"line {lineno}: ohd_trace_id does not match traceparent trace ID")

        if ohd != "-" and (not TRACE_ID.fullmatch(ohd) or ohd == "0" * 32):
            fail(f"line {lineno}: invalid ohd_trace_id")

    print(f"PASS: {path} ({len(records)} record(s))")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("path", type=Path)
    parser.add_argument(
        "--enforce-trace-relationship",
        action="store_true",
        help="require a present OHD trace ID to equal the version 00 traceparent trace ID",
    )
    args = parser.parse_args()
    try:
        return validate(args.path, args.enforce_trace_relationship)
    except (OSError, ValueError) as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
