variable "bucket_name" {
  type       = string 
  default    = "" 
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}