variable "db_sg_id" {}
variable "subnet5a_id" {}
variable "subnet6b_id" {}
variable "db_username" {}
variable "db_password" {}
variable "db_sub_name" {
    default = "db-subnet-a-b"
}
variable "db_name" {
    default = "testdb"
}