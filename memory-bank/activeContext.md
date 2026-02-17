# Active Context

## Current Focus
-   **Phase**: Monitoring Implementation / Refactoring.
-   **Goal**: Standardize credential management and prepare for deployment.

## Recent Changes
-   Refactored credential management to use `.tfvars`.
-   Updated `.gitignore` to exclude sensitive files.


## Active Tasks
-   [x] Configure Datadog Provider in Terraform.
-   [x] Create IAM Resources for Datadog.
-   [x] Update User Data for Datadog Agent installation.
-   [x] Define Datadog Dashboard in Terraform.
-   [ ] Run `terraform plan` & `apply` (User Action Required).

## Next Steps (from `plan.md`)
-   [ ] Modificación de la instancia EC2 existente.
-   [ ] Verificación de reporte de métricas en la consola de Datadog.


## Open Questions/Issues
-   User needs to provide `DATADOG_API_KEY` and `DATADOG_APP_KEY`.
