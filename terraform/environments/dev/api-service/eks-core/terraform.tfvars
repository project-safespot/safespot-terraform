project = "safespot"
env     = "dev"

remote_state_bucket = "safespot-terraform-state"
network_state_key   = "environments/dev/network/terraform.tfstate"

cluster_name    = "safespot-dev-eks"
cluster_version = "1.34"

cluster_endpoint_public_access  = true
cluster_endpoint_private_access = true

# Phase 1 bootstrap: keep false until eks-sg-rules has been applied.
# Phase 3: change to true and re-apply eks-core to create the managed node group.
create_managed_node_group = false

node_instance_types = ["t3.medium"]

eks_managed_node_group_name = "baseline"

node_min_size     = 2
node_max_size     = 3
node_desired_size = 2

node_iam_role_name = "safespot-dev-mng-role"
