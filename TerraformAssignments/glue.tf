module "glue" {
  source = "./modules/glue"
  glue_job_name         = var.glue_job_name
  glue_role_name        = var.glue_role_name
  glue_script_location  = var.glue_script_location
  crawler_name          = var.crawler_name
  database_name         = var.database_name
  s3_target_path        = var.s3_target_path
  log_group_name        = var.log_group_name
  vpc_subnet_id         = var.vpc_subnet_id
  security_group_id     = var.security_group_id
  availability_zone     = var.availability_zone
  tags                  = var.tags
}
