variable "env" {
  type = string
  default = "dev"
}

# Project name
variable "project_name" {
  type = string
}

# Applications
variable "applications" {
  type = list(string)
  default = ["backend", "frontend"]
}

variable "task_definitions" {
    type = list(object({
        name         = string
        image        = string
        cpu          = number
        memory       = number
        essential    = bool
        portMappings = list(object({
            containerPort = number
            hostPort      = number
        }))
    }))
    default = [
        {
            name = "backend"
            cpu = 10
            memory = 512
            essential = true
            image = "hungtran679/volunteerwork-backend"
            portMappings = [ {
                containerPort = 8080
                hostPort = 80
            } ]
        },
        {
            name = "frontend"
            cpu = 10
            memory = 512
            essential = true
            image = "hungtran679/volunteerwork-frontend"
            portMappings = [ {
                containerPort = 3000
                hostPort = 80
            } ]
        }
    ]

}