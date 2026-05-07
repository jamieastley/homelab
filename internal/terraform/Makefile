TF_PLAN_NAME = tf_plan

init:
	op run --env-file=".env" -- terraform init

init_upgrade:
	terraform init -upgrade

plan:
	op run --env-file=".env" -- terraform plan -out=$(TF_PLAN_NAME)

apply:
	op run --env-file=".env" -- terraform apply $(TF_PLAN_NAME)

destroy:
	op run --env-file=".env" -- terraform destroy