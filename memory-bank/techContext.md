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

## Deployment Workflow
-   **Configuration**: Copy `tf/terraform.tfvars.example` to `tf/terraform.tfvars` and fill in your secrets.
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
