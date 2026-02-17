# System Patterns

## Architecture Overview
The project follows a **Monorepo** structure with clear separation between frontend and backend.

### Backend (`/backend`)
-   **Framework**: Express with TypeScript.
-   **Layered Architecture**:
    -   `presentation/`: Controllers and API routes.
    -   `application/`: Core business logic and use cases.
    -   `domain/`: Entities and domain models.
    -   `infrastructure/`: Database access (Prisma) and external services.
-   **Data Access**: Prisma ORM connecting to PostgreSQL.

### Frontend (`/frontend`)
-   **Framework**: React (Create React App).
-   **State Management**: React state / Context (implied).
-   **Routing**: React Router (implied).
-   **Styling**: CSS/SCSS (to be confirmed).

## Deployment & Infrastructure
-   **Docker**: Docker Compose manages the PostgreSQL database and application containers.
-   **Build Process**: Separate build scripts for frontend and backend (`npm run build`).

## Design Patterns
-   **Repository Pattern**: Used in the backend infrastructure layer to abstract data access.
-   **Dependency Injection**: Likely used to decouple layers in the backend.
-   **RESTful API**: Communication between frontend and backend.

## Monitoring Architecture
-   **Datadog Agent**: Installed on EC2 instances via User Data script using API Key injection.
    -   **Installation Script**: [backend_user_data.sh](../tf/scripts/backend_user_data.sh) / [frontend_user_data.sh](../tf/scripts/frontend_user_data.sh)
    -   **Agent Version**: Datadog Agent 7 (latest stable)
    -   **API Key Injection**: `var.datadog_api_key` (marked as sensitive)
    -   **Site Configuration**: DD_SITE="datadoghq.com" (US region)
    -   **Hostname**: Uses EC2 default hostname (not customized)
    -   **Tags**: Not configured (default AWS tags only)
-   **AWS-Datadog Integration**: Bidirectional connection established via:
    -   **IAM Role**: `DatadogIntegrationRole` with SecurityAudit policy.
    -   **Trust Relationship**: External ID validated using `datadog_app_key`.
    -   **Datadog Resource**: `datadog_integration_aws` links AWS Account ID with IAM Role.
-   **Network Configuration**:
    -   **VPC**: Default VPC (includes Internet Gateway)
    -   **Security Groups**: Egress rule 0.0.0.0/0 allows outbound traffic to Datadog endpoints
    -   **Datadog Endpoints**: US region (datadoghq.com) - ports 443 (HTTPS)
-   **Data Flow**:
    -   **EC2 Agents → Datadog API (US)**: System metrics via Agent over HTTPS
        - CPU, Memory, Disk, Network I/O
        - Process monitoring
        - Log collection (if configured)
    -   **Datadog → AWS CloudWatch**: AWS service metrics via IAM Role
        - EC2 instance metadata
        - S3 bucket metrics
        - IAM activity (CloudTrail if enabled)
-   **Dashboards**:
    -   **System Metrics**: CPU, RAM, Disk I/O (Dashboard ID: 96v-e57-ws8).
    -   **Custom Metrics**: Application-specific business metrics (future).

