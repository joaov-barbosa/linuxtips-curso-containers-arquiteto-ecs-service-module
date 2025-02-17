variable "region" {
  type        = string
  description = "Região onde os recursos do AWS serão provisionados."
}

variable "service_name" {
  type        = string
  description = "Nome do serviço a ser utilizado no ECS ou identificador similar."
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster ECS onde o serviço será implantado."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC onde os recursos relacionados ao serviço serão provisionados."
}

variable "private_subnets" {
  type        = list(string)
  description = "Lista de IDs das subnets privadas onde o serviço será implantado."
}

variable "service_port" {
  type        = number
  description = "Porta na qual o serviço estará acessível."
}

variable "service_cpu" {
  type        = number
  description = "Quantidade de CPU alocada para o serviço, especificada em unidades de CPU do ECS."
}

variable "service_memory" {
  type        = number
  description = "Quantidade de memória alocada para o serviço, especificada em MB."
}

variable "service_listener" {
  type        = string
  description = "ARN do listener do Application Load Balancer que será usado pelo serviço."
}

variable "service_task_execution_role" {
  type        = string
  description = "ARN da role de execução de tarefas do ECS que o serviço usará para executar."
}

#variable "service_launch_type" {
 # type        = string
  #description = "Tipo de lançamento para o serviço no ECS, como 'FARGATE' ou 'EC2'."
#}
variable "service_launch_type" {
  type        = list(object({
    capacity_provider = string
    weight = number
  }))
  default = [ {
     capacity_provider = "FARGATE"
     weight            = 100
  } ]
  description = "Tipo de lançamento para o serviço no ECS, como 'FARGATE' ou 'EC2'."
}
variable "service_task_count" {
  type        = number
  description = "Número de instâncias da tarefa a serem executadas simultaneamente no serviço."
}

variable "service_hosts" {
  type        = list(string)
  description = "Lista de hosts associados ao serviço, geralmente especificados para configurações DNS."
}

variable "service_healthcheck" {
  type        = map(any)
  description = "Configuração do health check do serviço, incluindo caminho e protocolo."
}

variable "environment_variables" {
  type        = list(map(string))
  description = "Lista de variáveis de ambiente que serão passadas para o serviço."
}

variable "capabilities" {
  type        = list(string)
  description = "Lista de capacidades necessárias para a execução do serviço, como 'CAP_SYS_ADMIN' para recursos Linux específicos."
}
variable "scale_type" {}
variable "task_minimum" {}
variable "task_maximum" {}
variable "scale_out_cpu_threshold" {}
variable "scale_out_adjustment" {}
variable "scale_out_comparison_operator" {}
variable "scale_out_statistic" {}
variable "scale_out_period" {}
variable "scale_out_evaluation_periods" {}
variable "scale_out_cooldown" {}

variable "scale_in_cpu_threshold" {
  type        = number
  description = "Valor de limiar de utilização de CPU que, quando abaixo, aciona uma ação de escala para baixo, em percentual."
  default     = 30
}

variable "scale_in_adjustment" {
  type        = number
  description = "Quantidade de tarefas para reduzir durante uma ação de escala para baixo."
  default     = -1
}

variable "scale_in_comparison_operator" {
  type        = string
  description = "Operador de comparação usado para a condição de escala para baixo, como 'LessThanOrEqualToThreshold'."
  default     = "LessThanOrEqualToThreshold"
}

variable "scale_in_statistic" {
  type        = string
  description = "Estatística usada para a condição de escala para baixo, como 'Average' ou 'Sum'."
  default     = "Average"
}

variable "scale_in_period" {
  type        = number
  description = "Duração do período de avaliação para escala para baixo, em segundos."
  default     = 120
}

variable "scale_in_evaluation_periods" {
  type        = number
  description = "Número de períodos de avaliação necessários para acionar uma escala para baixo."
  default     = 3
}

variable "scale_in_cooldown" {
  type        = number
  description = "Período de cooldown após uma ação de escala para baixo, em segundos."
  default     = 120
}

#TRACKING CPU
variable "scale_tracking_cpu" {
  type        = number
  description = "Valor de utilização de CPU alvo para o rastreamento de escala, em percentual."
  default     = 80
}

variable "alb_arn" {
  type        = string
  description = "ARN do Application Load Balancer usado para rastreamento de solicitações."
  default     = null
}

variable "scale_tracking_requests" {
  type        = number
  description = "Número alvo de solicitações por segundo (TPS) para o rastreamento de escala."
  default     = 0
}

variable "container_image" {
  default = "nginx:latest"
}