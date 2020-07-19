# Define Cognito resources.
# https://aws.amazon.com/cognito

# https://www.terraform.io/docs/providers/aws/r/cognito_user_pool.html
# User pools are user directories that provide sign-up and sign-in
# options for your app users.
resource "aws_cognito_user_pool" "main" {
  # The name of the user pool.
  name = "main"

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  username_configuration {
    case_sensitive = false
  }

  password_policy {
    minimum_length = 8

    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true

    temporary_password_validity_days = 2
  }

  # Multi-Factor Authentication (MFA) configuration for the User Pool.
  # Valid values: 'OFF', 'ON', or 'OPTIONAL'
  mfa_configuration = "ON"

  software_token_mfa_configuration {
    enabled = true
  }

  # (Optional) - A container with the schema attributes of a
  #   user pool. Schema attributes from the standard attribute
  #   set only need to be specified if they are different from
  #   the default configuration. Maximum of 50 attributes.
  schema {
    # (Required) - The name of the attribute.
    name = "email"

    # (Required) - The attribute data type. (Boolean, Number, String, or DateTime)
    attribute_data_type = "String"

    # (Optional) - Specifies whether a user pool attribute is required.
    #   If the attribute is required and the user does not provide a value,
    #   registration or sign-in will fail.
    required = true
  }

  # # (Optional) - Specifies the string constraints.
  # schema {
  #   name = "username"

  #   attribute_data_type = "String"

  #   required = true

  #   string_attribute_constraints {
  #     max_length = 25
  #     min_length = 3
  #   }
  # }
}
