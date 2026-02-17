# Plan de Implementación: Monitorización AWS-Datadog

## Fase 1: Cimientos y Seguridad [COMPLETED]
- [x] Configuración inicial del entorno (Memory Bank & Rules).
- [x] Gestión de secretos (terraform.tfvars).
- [x] Configuración del Provider Datadog en Terraform.
- [x] Implementación de la Integración AWS-Datadog (IAM Roles y Trust Relationship).
- [x] Recurso `datadog_integration_aws` vinculando cuenta AWS con Datadog.
- [x] Refactorización S3: aws_s3_object (eliminando deprecations).

## Fase 2: Despliegue de Infraestructura y Agente [COMPLETED]
- [x] Modificación de la instancia EC2 existente (User Data configurado).
- [x] Inyección de Datadog Agent vía User Data (Script de instalación).
- [x] Verificación de conectividad de red (Security Groups + VPC por defecto).
- [x] Ejecución de `terraform apply` (17 recursos creados exitosamente).
- [x] Resolución de conflicto S3 bucket (nombre único con account_id).
- [ ] Verificación de reporte de métricas en la consola de Datadog (5-10 min).

## Fase 3: Visualización y Alertas
- [x] Definición del recurso `datadog_dashboard` en Terraform.
- [ ] (Opcional) Configuración de monitores/alertas.

## Fase 4: Cierre y Entrega
- [ ] Pruebas finales y capturas de pantalla.
- [ ] Documentación final de prompts y limpieza del repositorio.
- [ ] Creación del Pull Request.
