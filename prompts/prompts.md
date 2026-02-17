- Prompts
    
    Eres un Senior devsecops engineer y se te ha solicitado realizar la
    infraestructura para los proyectos de backend y frontend de la
    compañía lti recruiter.
    
    - La infraestructura consta de 2 instancias EC2 del tipo t2.micro
    - te seran provistos los archivos frontend.zip y backend.zip en la raiz del proyecto
    - Un bucket S3 que aloja en su raiz un archivo zip para el backend y uno para el frontend, se llamarán frontend.zip y backend.zip
    - Las instancias EC2 deben leer los archivos desde S3 y tener permisos para hacerlo, podrias usar un IAM policy.
    - el @backend debe ser accesible por medio del puerto 8080
    - el @frontend debe ser accesible por medio del puerto 3000
    - No es necesario solicitar nombres de keys ya que ya se encuentran configuradas con aws configure
    - Utiliza terraform en la carpeta @tf
    
    - prompt 2
        
        Las imágenes que estas usando para los EC2 parecen incorrectas, actualiza el script para que use un data y obtenga las imágenes automáticamente.
        
    - prompt 3
        
        ayúdame a generar un Dockerfile para frontend que instale dependencias y lo ejecute exponiendo el puerto 3000 y usa node 18 como base
        
    - prompt 4
        
        Genera un Dockerfile para backend que ejecute las migraciones de prisma haga build y ejecute el codigo exponiendo el puerto 8080 y usa node 18 como base
        
    - Prompt 5
        
        Genera un Codigo en sh para crear un nuevo zip de la carpeta frontend y uno de la carpeta backend reemplazando los zip existentes
        
   

## [20260217-1200-001] - Inicialización del Entorno de Monitorización AWS-Datadog
**Fecha:** 2026-02-17 12:00
**Prompt Original:**
> # ROLE: Architect Agent & Terraform Expert
> Actúa como Architect Agent experto en Terraform, AWS y Datadog. Tu objetivo es inicializar el entorno de trabajo para el ejercicio de monitorización basándote en el repositorio @workspace.
>
> ## 1. FASE DE LOGGING (Protocolo AGENTS.md)
> Antes de proponer código o crear archivos:
> 1. Crea el archivo `prompts.md` en la raíz si no existe.
> 2. Registra esta interacción inicial con el ID: `20260217-1200-001`.
> 3. Título: "Inicialización del Entorno de Monitorización AWS-Datadog".
> 4. Contenido: Documenta que este archivo servirá como la bitácora principal de Prompt Engineering para el ejercicio.
>
> ## 2. FASE DE MEMORY BANK (Estado Compartido)
> Analiza el código base del repositorio y genera la carpeta `/memory-bank/` con los siguientes archivos:
> - **projectbrief.md**: Define el objetivo de extender la infraestructura actual para integrar monitorización con Datadog.
> - **techContext.md**: Identifica versiones de Terraform, proveedores necesarios (AWS y Datadog) y la estrategia de variables de entorno para las API Keys.
> - **systemPatterns.md**: Esboza la arquitectura técnica: IAM Role para Datadog, instalación del Agente en EC2 vía User Data y creación del Dashboard.
> - **activeContext.md**: Estado: "Fase de inicialización completada. Preparado para configurar el Provider de Datadog y Recursos IAM".
>
> ## 3. FASE DE REGLAS (.agent/rules)
> Crea `.agent/rules/00-memory-bank.md` con prioridad crítica para asegurar que cualquier interacción futura respete este contexto compartido.
>
> ## 4. PLAN DE TRABAJO (Backlog Inicial)
> Presenta un plan de pasos numerados para abordar los objetivos del ejercicio:
> 1. Configuración del Provider Datadog en Terraform.
> 2. Implementación de la integración AWS-Datadog (IAM Roles/Policy).
> 3. Script de instalación del Agent en el recurso EC2.
> 4. Definición del Dashboard de Datadog.
>
> ¿Entendido? Hazme alguna pregunta si tienes dudas. Procede con la creación de la estructura del Memory Bank y el registro en prompts.md. Confírmame cuando el sistema esté activo.

**Resumen de Acción:**
Inicialización del Memory Bank para el ejercicio de monitorización. Definición de arquitectura, stack tecnológico y plan de trabajo para integración AWS-Datadog.
---

## [20260217-1230-002] - Automatización de credenciales Datadog mediante .tfvars
**Fecha:** 2026-02-17 12:30
**Prompt Original:**
> # ROLE: Architect Agent
> # TASK: Refactor de Variables y Automatización de Credenciales
>
> Actúa como Architect Agent. Vamos a estandarizar la gestión de secretos para evitar el uso de flags manuales en la terminal, cumpliendo con el protocolo de seguridad y automatización.
>
> ## 1. REGISTRO EN BITÁCORA (Protocolo AGENTS.md)
> - Registra esta tarea en `prompts.md` con el ID: `20260217-1230-002`.
> - **Título**: Automatización de credenciales Datadog mediante .tfvars y variables sensibles.
> - **Resumen**: Configuración de variables HCL y actualización de la documentación técnica para despliegue automatizado.
>
> ## 2. CONFIGURACIÓN TÉCNICA (Terraform)
> - **variables.tf**: Asegúrate de que las variables `datadog_api_key` y `datadog_app_key` estén definidas y marcadas como `sensitive = true`.
> - **terraform.tfvars.example**: Crea este archivo en la carpeta de Terraform con los campos necesarios vacíos para que sirva de plantilla.
> - **.gitignore**: Verifica o añade `*.tfvars` para asegurar que mis llaves reales nunca se suban al repositorio.
>
> ## 3. ACTUALIZACIÓN DEL SHARED STATE (Memory Bank)
> - **memory-bank/techContext.md**: Actualiza la sección de "Comandos de Despliegue". Elimina la instrucción de pasar variables por CLI y añade que el flujo estándar ahora es usar un archivo `terraform.tfvars` local.
> - **memory-bank/activeContext.md**: Actualiza el estado actual a: "Infraestructura de variables lista. Preparado para iniciar la configuración de la integración AWS-Datadog".
>
> ## 4. EXPLORACIÓN DEL REPOSITORIO
> - Una vez aplicados estos cambios, realiza un escaneo completo de los archivos `.tf` existentes para identificar dónde debemos inyectar el Agente de Datadog y el Dashboard.
>
> ¿Entendido? Procede con la creación y modificación de los archivos. Confírmame cuando el "Cerebro del Proyecto" esté actualizado con esta nueva mecánica de trabajo.

**Resumen de Acción:**
Refactorización de la gestión de logs y secretos. Creación de `terraform.tfvars.example`, actualización de `.gitignore` y documentación de despliegue en Memory Bank.
---
