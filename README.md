# Terraform Module: S3 + CloudFront Static Website Hosting

Este proyecto utiliza Terraform para desplegar una arquitectura de alojamiento web estático en AWS. Los archivos estáticos se almacenan en un bucket de S3 y se publican utilizando Amazon CloudFront, proporcionando un CDN de alto rendimiento, baja latencia y disponibilidad global. Esta configuración está diseñada para escalar y servir contenido rápidamente a nivel mundial.

A continuación, se incluye una representación visual de la arquitectura implementada:

<div align="center">
  <img src="./architecture.jpg" alt="Arquitectura" />
</div>

---

## Características principales
- **Almacenamiento de archivos estáticos:** Un bucket de S3 dedicado que almacena contenido estático como HTML, CSS, JS e imágenes.
- **Distribución global:** Amazon CloudFront se utiliza para distribuir el contenido de manera eficiente, con caching en múltiples ubicaciones geográficas.
- **Seguridad:** Políticas de bucket S3 configuradas para permitir acceso solo a través de CloudFront.
- **Configuración modular:** Uso de módulos reutilizables para simplificar la administración y escalabilidad.

---

## Requisitos previos
Antes de comenzar, asegúrate de tener lo siguiente instalado en tu máquina:
- Terraform (>= 1.5.0)
- Credenciales configuradas para AWS CLI con permisos suficientes para gestionar S3, CloudFront y políticas de acceso.

---

## Instrucciones de uso

### 1. Almacenar los archivos estáticos
Coloca tus archivos estáticos (HTML, CSS, JS, imágenes, etc.) dentro de la carpeta `frontend`. Esta carpeta se utilizará para cargar los archivos al bucket de S3 creado durante la ejecución del plan de Terraform.

### 2. Inicializar Terraform
Ejecuta el siguiente comando en la raíz del proyecto para inicializar los módulos y proveedores necesarios:
```bash
terraform init
```

### 3. Aplicar la infraestructura
Para crear todos los recursos (S3, CloudFront y las políticas necesarias), ejecuta el siguiente comando:

```bash
terraform apply
```

### 4. Verificar la URL generada
Al final del despliegue, Terraform proporcionará una salida con la URL de CloudFront. Usa esta URL para acceder a tu contenido estático.

### 5. Actualizar archivos estáticos
Si realizas cambios en los archivos estáticos dentro de la carpeta frontend, solo necesitas ejecutar nuevamente el siguiente comando para que los cambios se reflejen en el hosting:

```bash
terraform apply
```

### 6. Eliminar recursos (Importante)
Cuando ya no necesites los recursos y desees evitar costos adicionales, puedes destruir toda la infraestructura creada con el siguiente comando:

```bash
terraform destroy
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ./modules/cloudfront | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |
| <a name="module_s3_bucket_policy"></a> [s3\_bucket\_policy](#module\_s3\_bucket\_policy) | ./modules/s3_bucket_policy | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where the S3 bucket is located. | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 bucket used as the origin for CloudFront. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_url"></a> [url](#output\_url) | The URL of the CloudFront Distribution. |
