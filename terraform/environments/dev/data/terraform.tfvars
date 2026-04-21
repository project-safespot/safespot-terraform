aws_region  = "ap-northeast-2"
project     = "safespot"
environment = "dev"

# ── Aurora ──────────────────────────────────────────────
rds_engine_version  = "15.6"
rds_instance_class  = "db.t3.medium"
rds_instance_count  = 2        # dev: writer 1 + reader 1 (필요시 늘리기)
db_name             = "safespot"
# db_username, db_password 는 여기에 절대 작성하지 말 것!
# 아래 방법 중 하나로 주입:
#   1) terraform apply -var="db_username=xxx" -var="db_password=yyy"
#   2) export TF_VAR_db_username=xxx && export TF_VAR_db_password=yyy
#   3) AWS Secrets Manager / SSM Parameter Store 연동

rds_backup_retention_period = 7
rds_deletion_protection     = false
rds_skip_final_snapshot     = true

# ── Redis ────────────────────────────────────────────────
# master 1 + replica 3 = 총 4대 (모듈 내 고정)
redis_engine_version           = "7.1"
redis_node_type                = "cache.t3.micro"
redis_snapshot_retention_limit = 1
