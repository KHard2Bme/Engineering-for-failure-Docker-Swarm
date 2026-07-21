############################################
# cloudwatch.tf
# CloudWatch resources for Engineering for Failure
############################################

resource "aws_cloudwatch_log_group" "docker_logs" {
  name              = "/engineering-for-failure/docker"
  retention_in_days = 14

  tags = {
    Name = "engineering-for-failure-docker-logs"
  }
}

resource "aws_cloudwatch_log_metric_filter" "container_failure" {
  name           = "ContainerFailureCount"
  log_group_name = aws_cloudwatch_log_group.docker_logs.name

  # Matches common Docker/container failure messages
  pattern = "?ERROR ?Failed ?failed ?exited ?OOMKilled"

  metric_transformation {
    name      = "ContainerFailureCount"
    namespace = "EngineeringForFailure"
    value     = "1"
    unit      = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "worker_failure" {
  name           = "WorkerNodeFailureCount"
  log_group_name = aws_cloudwatch_log_group.docker_logs.name

  pattern = "?node ?unreachable ?docker.service ?Failed"

  metric_transformation {
    name      = "WorkerNodeFailureCount"
    namespace = "EngineeringForFailure"
    value     = "1"
    unit      = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "manager_failure" {
  name           = "ManagerNodeFailureCount"
  log_group_name = aws_cloudwatch_log_group.docker_logs.name

  pattern = "?raft ?quorum ?leader ?manager"

  metric_transformation {
    name      = "ManagerNodeFailureCount"
    namespace = "EngineeringForFailure"
    value     = "1"
    unit      = "Count"
  }
}