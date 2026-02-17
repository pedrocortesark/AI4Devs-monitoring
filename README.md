# 🔍 LTI Monitoring - AWS Infrastructure con Datadog

![Terraform](https://img.shields.io/badge/Terraform-1.x-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-EC2%20%7C%20IAM%20%7C%20S3-FF9900?logo=amazon-aws)
![Datadog](https://img.shields.io/badge/Datadog-Agent%207-632CA6?logo=datadog)
![IaC](https://img.shields.io/badge/IaC-100%25-success)

## 📋 Tabla de Contenidos

- [Introducción](#-introducción)
- [Arquitectura](#-arquitectura)
- [Cambios Realizados](#-cambios-realizados)
- [Prompt Engineering](#-prompt-engineering)
- [Desafíos y Soluciones](#-desafíos-y-soluciones)
- [Guía de Uso](#-guía-de-uso)
- [Evidencias](#-evidencias)
- [Estructura del Proyecto](#-estructura-del-proyecto)

---

## 🎯 Introducción

Este proyecto extiende la infraestructura existente de **LTI Recruiter** para implementar un sistema de **monitorización completo** utilizando **Datadog** como plataforma de observabilidad. La solución está completamente automatizada mediante **Infrastructure as Code (IaC)** con Terraform, garantizando reproducibilidad y trazabilidad.

### Objetivos del Proyecto

1. **Integración AWS-Datadog**: Configurar la conexión bidireccional entre AWS y Datadog mediante IAM Roles y External ID.
2. **Despliegue de Agentes**: Instalar Datadog Agent 7 en las instancias EC2 mediante scripts `user_data`.
3. **Visualización de Métricas**: Crear un dashboard personalizado con 15+ widgets organizados en 6 secciones temáticas.
4. **IaC Completo**: Toda la infraestructura definida en Terraform (reproducible y versionable).

### Stack Tecnológico

- **Cloud Provider**: AWS (us-east-1)
- **IaC**: Terraform 1.x
- **Monitoring**: Datadog Agent 7 (región EU)
- **Compute**: Amazon Linux 2 (AMI ami-075d39ebbca89ed55)
- **Identity**: AWS IAM + External ID para Datadog
- **Storage**: S3 para artefactos de código

---

## 🏗️ Arquitectura

### Diagrama de Componentes

```
┌─────────────────────────────────────────────────────────────────┐
│                      AWS Infrastructure                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────────┐        ┌─────────────────────┐        │
│  │ EC2 Backend         │        │ EC2 Frontend        │        │
│  │ i-0a06e794b5e6d4a92 │        │ i-0b392c10d66e0ce98 │        │
│  │ t2.micro            │        │ t2.medium           │        │
│  │ 54.91.78.197        │        │ 98.89.46.199        │        │
│  ├─────────────────────┤        ├─────────────────────┤        │
│  │ Datadog Agent 7     │        │ Datadog Agent 7     │        │
│  │ DD_SITE=EU          │        │ DD_SITE=EU          │        │
│  │ Tags: backend       │        │ Tags: frontend      │        │
│  │ Host: lti-backend   │        │ Host: lti-frontend  │        │
│  └──────────┬──────────┘        └──────────┬──────────┘        │
│             │                              │                     │
│  ┌──────────┴──────────────────────────────┴──────────┐        │
│  │         S3 Bucket (Code Artifacts)                  │        │
│  │  ai4devs-project-code-bucket-197538345061           │        │
│  │  - backend.zip                                      │        │
│  │  - frontend.zip                                     │        │
│  └─────────────────────────────────────────────────────┘        │
│                                                                   │
│  ┌─────────────────────────────────────────────────────┐        │
│  │              IAM Roles & Policies                    │        │
│  │  - ec2_role (S3 Read Access)                        │        │
│  │  - DatadogIntegrationRole (SecurityAudit Policy)    │        │
│  │    * Trust Policy: External ID = datadog_app_key    │        │
│  └─────────────────────────────────────────────────────┘        │
│                                                                   │
└───────────────────────────┬───────────────────────────────────────┘
                            │ HTTPS (Port 443)
                            │ Datadog Agent Metrics
                            ▼
         ┌──────────────────────────────────────────┐
         │       Datadog EU API                     │
         │       api.datadoghq.eu                   │
         │                                          │
         │  ┌────────────────────────────────────┐ │
         │  │   AWS Integration                  │ │
         │  │   Account: 197538345061            │ │
         │  │   Role: DatadogIntegrationRole     │ │
         │  └────────────────────────────────────┘ │
         │                                          │
         │  ┌────────────────────────────────────┐ │
         │  │   Dashboard: LTI Monitoring        │ │
         │  │   ID: wy2-7xn-fu3                  │ │
         │  │   Widgets: 15+                     │ │
         │  │   - CPU Performance                │ │
         │  │   - Memory Usage                   │ │
         │  │   - Disk I/O                       │ │
         │  │   - Network Traffic                │ │
         │  │   - System Load                    │ │
         │  │   - Host Map                       │ │
         │  └────────────────────────────────────┘ │
         └──────────────────────────────────────────┘
```

### Flujo de Datos

1. **EC2 → Datadog Agent → API EU**: Métricas del sistema (CPU, Memory, Disk, Network, Load)
2. **Datadog → AWS CloudWatch**: Metadata de servicios AWS vía IAM Role
3. **Dashboard → Usuario**: Visualización en tiempo real en consola Datadog EU

---

## 🔧 Cambios Realizados

### 1. Gestión de Secretos y Variables

Variables marcadas como `sensitive` en `tf/variables.tf` para protección de credenciales.

### 2. Integración AWS-Datadog

- IAM Role con Trust Policy usando External ID (`datadog_app_key`)
- SecurityAudit policy para lectura de metadata AWS
- Recurso `datadog_integration_aws` vinculando cuenta con Dashboard

### 3. Aprovisionamiento de EC2 con Datadog Agent

Scripts `user_data` configurados con:
- DD_SITE="datadoghq.eu" (región EU)
- Hostnames descriptivos: `lti-backend-prod`, `lti-frontend-prod`
- Tags personalizados: `project:lti-monitoring`, `env:dev`, `service`, `component`
- API Key inyectada dinámicamente desde variables sensibles

### 4. Dashboard de Monitorización

Dashboard con **6 secciones temáticas** y **15+ widgets**:

1. **🖥️ CPU Performance**: user/system/idle + query value
2. **💾 Memory Usage**: timeseries + bytes/percentage
3. **💿 Disk I/O**: read/write time + usage
4. **🌐 Network Traffic**: bytes sent/received
5. **⚖️ System Load**: 1m/5m/15m averages
6. **📊 Host Map**: Visual por service

### 5. Modernización de S3

- Bucket con nombre único usando `account_id`
- Eliminado ACL deprecated (S3 privado por defecto)
- Migrado de `aws_s3_bucket_object` a `aws_s3_object`

---

## 🤖 Prompt Engineering

### Archivo de Trazabilidad

**Ubicación**: `prompts/datadog-aws-prompts.md`

Documenta **15 interacciones** siguiendo protocolo `AGENTS.md`:
- Formato ID: `YYYYMMDD-HHMM-SSS`
- Prompt original completo
- Resumen técnico de acción
- Estado visual (✅/⏳/❌)

### Memory Bank Architecture

Sistema de estado compartido en `memory-bank/`:
- projectbrief.md, techContext.md, systemPatterns.md
- activeContext.md, plan.md, progress.md
- productContext.md

---

## 🚧 Desafíos y Soluciones

### 1. Error 403 - Autenticación Datadog

**Problema**: `403 Forbidden` al conectar con API Datadog

**Solución**: Configurar `api_url` parametrizable para región EU
```hcl
provider "datadog" {
  api_url = var.datadog_api_url  # https://api.datadoghq.eu
}
```

### 2. S3 Bucket - Conflicto de Nombres

**Problema**: `BucketAlreadyExists` por nombres no únicos

**Solución**: Sufijo con account_id
```hcl
bucket = "ai4devs-project-code-bucket-${data.aws_caller_identity.current.account_id}"
```

### 3. Desfase del Terraform State

**Problema**: Recursos eliminados manualmente causan drift

**Solución**: Script de limpieza con `terraform state rm`

### 4. User Data - Solo Ejecución en Creación

**Problema**: Cambios en `user_data` no se aplican

**Solución**: `terraform taint` para forzar recreación

### 5. Recursos S3 Deprecated

**Problema**: Warnings de deprecation

**Solución**: Migrar a `aws_s3_object`, eliminar ACL

---

## 🚀 Guía de Uso

### Prerequisitos

- Terraform v1.x
- AWS CLI v2 configurado
- Cuenta Datadog EU
- Credenciales Datadog (API Key + APP Key)

### Paso 1: Configurar Credenciales

```bash
cd tf/
cp terraform.tfvars.example terraform.tfvars

# Editar terraform.tfvars con credenciales reales
```

### Paso 2: Validar y Planificar

```bash
terraform init
terraform validate
terraform plan
```

### Paso 3: Desplegar

```bash
terraform apply
# Confirmar con: yes
```

### Paso 4: Verificar

```bash
# Obtener URL del dashboard
terraform output dashboard_url

# Acceder a: https://app.datadoghq.eu/infrastructure/map
# Filtrar por: project:lti-monitoring
```

### Paso 5: Debugging (Opcional)

```bash
ssh ec2-user@54.91.78.197
sudo systemctl status datadog-agent
sudo datadog-agent status
```

---

## 📸 Evidencias

### Dashboard en Producción

**URL**: https://app.datadoghq.eu/dashboard/wy2-7xn-fu3

![Dashboard](./imgs/Dashboard.png)

### Host Map

![Host Map](./imgs/HostMap.png)

### Métricas en Tiempo Real

**CPU Performance**:
![CPU Performance](./imgs/cpuPerformance.png)

**Memory Usage**:
![Memory Usage](./imgs/MemoryUsage.png)

**Disk I/O**:
![Disk I/O](./imgs/DiskIO.png)

---

## 📁 Estructura del Proyecto

```
15-monitorizacion/
├── README.md                          # Este archivo
├── AGENTS.md                          # Protocolo de operación
├── .gitignore                         # Exclusiones
├── memory-bank/                       # Estado compartido
├── prompts/
│   └── datadog-aws-prompts.md         # Trazabilidad definitiva
├── tf/                                # IaC
│   ├── provider.tf
│   ├── variables.tf
│   ├── iam.tf
│   ├── ec2.tf
│   ├── s3.tf
│   ├── datadog.tf
│   ├── dashboard.tf
│   └── scripts/
│       ├── backend_user_data.sh
│       └── frontend_user_data.sh
├── backend/
└── frontend/
```

---

## 🎓 Lecciones Aprendidas

1. Verificar región Datadog (US vs EU) en provider y agent
2. S3 buckets requieren nombres globalmente únicos
3. User data solo ejecuta en creación (usar `terraform taint`)
4. Mantener sincronizado terraform state
5. Actualizar recursos deprecated periódicamente
6. External ID mejora seguridad en integraciones
7. Tags facilitan filtrado en dashboards
8. Hostnames descriptivos mejoran trazabilidad

---

## 👥 Autores

- **Pedro Cortés Nogales** - Implementación completa
- **Architect Agent** - Asistencia técnica

---

## 🔗 Enlaces Útiles

- **Dashboard**: https://app.datadoghq.eu/dashboard/wy2-7xn-fu3
- **Terraform AWS Provider**: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- **Terraform Datadog Provider**: https://registry.terraform.io/providers/DataDog/datadog/latest/docs
- **Datadog Agent**: https://docs.datadoghq.com/agent/

---

## 💼 Sobre el Proyecto LTI (Aplicación Base)

Este sistema de monitorización se implementó sobre **LTI - Sistema de Seguimiento de Talento**, una aplicación full-stack para gestión de candidatos y procesos de reclutamiento.

### Stack de la Aplicación

- **Frontend**: React (Create React App), TypeScript
- **Backend**: Node.js, Express, TypeScript
- **Database**: PostgreSQL
- **ORM**: Prisma
- **Containerization**: Docker, Docker Compose

### Arquitectura del Código

```
backend/
├── src/
│   ├── index.ts                    # Punto de entrada
│   ├── application/                # Lógica de aplicación
│   ├── domain/                     # Modelos de dominio
│   ├── infrastructure/             # Comunicación con BD
│   ├── presentation/               # Controladores
│   ├── routes/                     # Definición de rutas
│   └── tests/                      # Testing
└── prisma/
    ├── schema.prisma               # Esquema de datos
    └── seed.ts                     # Datos de ejemplo

frontend/
├── src/                            # Código fuente React
├── public/                         # Assets estáticos
└── build/                          # Build de producción
```

### Desarrollo Local

#### 1. Instalación de Dependencias

```bash
# Frontend
cd frontend
npm install

# Backend
cd backend
npm install
```

#### 2. Configurar Base de Datos

**Iniciar PostgreSQL con Docker**:
```bash
# Desde la raíz del proyecto
docker-compose up -d

# Verificar que está corriendo
docker-compose ps
```

**Conexión a PostgreSQL**:
- Host: `localhost`
- Port: `5432`
- User: `postgres`
- Password: `password`
- Database: `mydatabase`

#### 3. Configurar Prisma

```bash
cd backend

# Generar cliente Prisma
npx prisma generate

# Ejecutar migraciones
npx prisma migrate dev

# Poblar con datos de ejemplo
ts-node seed.ts
```

**Nota**: Si tienes problemas con `DATABASE_URL`, edita directamente el campo `url` en `prisma/schema.prisma`.

#### 4. Ejecutar la Aplicación

**Terminal 1 - Backend**:
```bash
cd backend
npm run build
npm start

# Backend disponible en: http://localhost:3010
```

**Terminal 2 - Frontend**:
```bash
cd frontend
npm run build
npm start

# Frontend disponible en: http://localhost:3000
```

### Ejemplo de API

**Crear Candidato**:
```bash
POST http://localhost:3010/candidates
Content-Type: application/json

{
    "firstName": "Albert",
    "lastName": "Saelices",
    "email": "albert.saelices@gmail.com",
    "phone": "656874937",
    "address": "Calle Sant Dalmir 2, 5ºB. Barcelona",
    "educations": [
        {
            "institution": "UC3M",
            "title": "Computer Science",
            "startDate": "2006-12-31",
            "endDate": "2010-12-26"
        }
    ],
    "workExperiences": [
        {
            "company": "Coca Cola",
            "position": "SWE",
            "description": "",
            "startDate": "2011-01-13",
            "endDate": "2013-01-17"
        }
    ],
    "cv": {
        "filePath": "uploads/1715760936750-cv.pdf",
        "fileType": "application/pdf"
    }
}
```

### Documentación Adicional

- **Buenas Prácticas**: [ManifestoBuenasPracticas.md](./backend/ManifestoBuenasPracticas.md)
- **API Specification**: [api-spec.yaml](./backend/api-spec.yaml)
- **Modelo de Datos**: [ModeloDatos.md](./backend/ModeloDatos.md)

### Comandos Útiles de Docker

```bash
# Ver logs de PostgreSQL
docker-compose logs -f

# Detener servicios
docker-compose down

# Limpiar volúmenes (⚠️ elimina datos)
docker-compose down -v
```

---

**📊 Estado**: ✅ COMPLETADO - Sistema operativo en producción

**📅 Última actualización**: 2026-02-17 16:25 UTC

