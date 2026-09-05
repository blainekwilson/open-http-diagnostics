#!/usr/bin/env python3
"""Check relative Markdown links within the repository."""
from __future__ import annotations
import re
import sys
from pathlib import Path

root = Path(__file__).resolve().parents[2]
pattern = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
errors = []
for md in root.rglob("*.md"):
    text = md.read_text(encoding="utf-8")
    for target in pattern.findall(text):
        target = target.strip().split("#", 1)[0]
        if not target or "://" in target or target.startswith("mailto:"):
            continue
        path = (md.parent / target).resolve()
        try:
            path.relative_to(root.resolve())
        except ValueError:
            errors.append(f"{md.relative_to(root)}: link leaves repository: {target}")
            continue
        if not path.exists():
            errors.append(f"{md.relative_to(root)}: missing target: {target}")
if errors:
    print("\n".join(errors), file=sys.stderr)
    raise SystemExit(1)
print("PASS: relative Markdown links")
