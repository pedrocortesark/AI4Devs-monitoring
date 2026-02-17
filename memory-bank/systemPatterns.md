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
