module "sagemaker" {
  source                        = "./modules/sagemaker"
  subnet_id                     = var.subnet_id
  security_group_ids            = var.security_group_ids
  tags                          = var.tags
}
