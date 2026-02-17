# Tech Context

## Technology Stack
-   **Frontend**: React, TypeScript (assumed based on backend), HTML/CSS.
-   **Backend**: Node.js, Express, TypeScript.
-   **Database**: PostgreSQL.
-   **ORM**: Prisma.
-   **Containerization**: Docker, Docker Compose.
-   **Infrastructure as Code**: Terraform.
-   **Monitoring**: Datadog (Agent & Provider).

## Development Environment
-   **Package Manager**: `npm`.
-   **Testing**: Cypress (E2E), Jest (Backend Unit Tests).
-   **Linting/Formatting**: ESLint, Prettier.
-   **Terraform**: Version 1.x.
-   **Cloud Provider**: AWS (us-east-1).

## AWS Authentication
-   **Method**: AWS CLI V2 (modern authentication).
-   **Setup**: 
    ```bash
    # For standard profiles
    aws configure
    
    # For SSO users
    aws configure sso
    aws sso login --profile <profile-name>
    ```
-   **Terraform Integration**: Uses AWS CLI credentials automatically.
-   **Profile**: Default profile used unless specified in provider.tf.
-   **Security**: No static access keys in code - credentials managed by AWS CLI.

## Deployment Workflow
-   **Prerequisites**: 
    1. AWS credentials configured via CLI (`aws configure` or `aws sso login`).
    2. Copy `tf/terraform.tfvars.example` to `tf/terraform.tfvars` and fill in Datadog secrets.
-   **Plan**: `cd tf && terraform plan`
-   **Apply**: `cd tf && terraform apply`
-   **Note**: Never commit `terraform.tfvars` to the repository.


-   **Testing**: Cypress (E2E), Jest (Backend Unit Tests).
-   **Linting/Formatting**: ESLint, Prettier.

## Key Commands
-   **Start Backend**: `cd backend && npm start` (Runs on port 3010).
-   **Start Frontend**: `cd frontend && npm start` (Runs on port 3000).
-   **Database Setup**: `docker-compose up -d`, `npx prisma migrate dev`, `ts-node seed.ts`.
-   **Build**: `npm run build` in respective directories.

## Constraints & Standards
-   Follow the layered architecture in the backend.
-   Ensure type safety with TypeScript.
-   Use `prompts.md` for task logging as per `AGENTS.md`.

## File Management
-   **Terraform State**: All `.tfstate` and backup files are excluded from version control via `.gitignore`.
-   **Sensitive Files**: `terraform.tfvars` contains secrets and must never be committed.
-   **IDE Configuration**: `.vscode/settings.json` hides noise files from workspace explorer.
