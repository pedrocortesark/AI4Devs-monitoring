# Data source to get current AWS account ID
data "aws_caller_identity" "current" {}

# AWS Integration with Datadog
resource "datadog_integration_aws" "main" {
  account_id = data.aws_caller_identity.current.account_id
  role_name  = aws_iam_role.datadog_integration_role.name
}

resource "datadog_dashboard" "system_metrics" {
  title       = "LTI System Metrics"
  description = "Dashboard for EC2 System Metrics (CPU, Memory, Disk)"
  layout_type = "ordered"

  widget {
    timeseries_definition {
      title = "CPU Usage"
      request {
        q = "avg:system.cpu.user{*}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Memory Usage"
      request {
        q = "avg:system.mem.used{*}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Disk Usage"
      request {
        q = "avg:system.disk.in_use{*}"
        display_type = "line"
      }
    }
  }
}
