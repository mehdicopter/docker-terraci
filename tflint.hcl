config {
  module = true
  deep_check = false
  force = false
}

rule "terraform_dash_in_resource_name" {
  enabled = false
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}
