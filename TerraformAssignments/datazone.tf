module "datazone" {
  source = "./modules/datazone"

  datazone_name = var.datazone_name
  bucket_prefix = var.bucket_prefix
  tags          = var.tags
}
