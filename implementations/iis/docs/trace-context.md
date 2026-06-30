# IIS Trace Context Notes

IIS W3C logging can log the `traceparent` request header using custom logging fields.

Creating a `traceparent` header when missing is not a standard IIS W3C logging feature. Level 2 support can be provided by:

- An upstream proxy
- ASP.NET Core middleware
- An IIS module
- URL Rewrite or ARR if sufficient for the deployment design
