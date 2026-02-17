# Plan de Implementación: Monitorización AWS-Datadog

## Fase 1: Cimientos y Seguridad [COMPLETED]
- [x] Configuración inicial del entorno (Memory Bank & Rules).
- [x] Gestión de secretos (terraform.tfvars).
- [x] Configuración del Provider Datadog en Terraform.
- [x] Implementación de la Integración AWS-Datadog (IAM Roles y Trust Relationship).
- [x] Recurso `datadog_integration_aws` vinculando cuenta AWS con Datadog.

## Fase 2: Despliegue de Infraestructura y Agente
- [ ] Modificación de la instancia EC2 existente.
- [x] Inyección de Datadog Agent vía User Data (Script de instalación).
- [ ] Verificación de reporte de métricas en la consola de Datadog.

## Fase 3: Visualización y Alertas
- [x] Definición del recurso `datadog_dashboard` en Terraform.
- [ ] (Opcional) Configuración de monitores/alertas.

## Fase 4: Cierre y Entrega
- [ ] Pruebas finales y capturas de pantalla.
- [ ] Documentación final de prompts y limpieza del repositorio.
- [ ] Creación del Pull Request.
