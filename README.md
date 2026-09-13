# End-to-End FinTech CDC Lakehouse

A production-style data engineering project that processes simulated
e-commerce order changes using AWS S3, Databricks, PySpark, Delta Lake,
Auto Loader and Unity Catalog.

## Architecture

```mermaid
flowchart LR
    A[CDC Event Generator] --> B[AWS S3]
    B --> C[Bronze Auto Loader]
    C --> D[Silver CDC Merge]
    D --> E[Gold KPI Tables]
    E --> F[Databricks SQL]
