resource "rabbitmq_vhost" "my_vhost" {
  for_each = toset(local.ns)
  name     = each.key
}

resource "vault_rabbitmq_secret_backend" "rabbitmq" {
  connection_uri            = "${aws_mq_broker.rabbitmq.instances.0.console_url}:443"
  username                  = local.mq_username
  password                  = random_password.rabbitmq_password.result
  default_lease_ttl_seconds = 600
  max_lease_ttl_seconds     = 28800
}
resource "vault_rabbitmq_secret_backend_role" "rabbitmq_role" {
  for_each = toset(local.ns)
  backend  = "rabbitmq"
  name     = each.key
  tags     = "administrator"
  vhost {
    host      = "/"
    configure = ".*"
    read      = ".*"
    write     = ".*"
  }
  vhost {
    host      = each.key
    configure = ".*"
    read      = ".*"
    write     = ".*"
  }
  depends_on = [
    vault_rabbitmq_secret_backend.rabbitmq
  ]
}

resource "vault_rabbitmq_secret_backend" "rabbitmq_user" {
  for_each          = toset(local.ns)
  path              = "${each.key}/rabbitmq"
  connection_uri    = "${aws_mq_broker.rabbitmq.instances.0.console_url}:443"
  username          = local.mq_username
  password          = random_password.rabbitmq_password.result
  username_template = "{{.RoleName}}-{{unix_time}}"
}
resource "vault_rabbitmq_secret_backend_role" "rabbitmq_user_role" {
  for_each = toset(local.ns)
  backend  = "${each.key}/rabbitmq"
  name     = "${each.key}_mq_htb"
  tags     = "administrator"
  vhost {
    host      = "/"
    configure = ".*"
    read      = ".*"
    write     = ".*"
  }
  vhost {
    host      = each.key
    configure = ".*"
    read      = ".*"
    write     = ".*"
  }
  depends_on = [
    vault_rabbitmq_secret_backend.rabbitmq_user
  ]
}
resource "vault_kv_secret_v2" "mq_root" {
  mount               = vault_mount.secrets.path
  name                = "mq_root"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      mq_root_username = local.mq_username,
      mq_root_password = random_password.rabbitmq_password.result,
    }
  )
}

resource "random_password" "htb_password" {
  for_each = toset(local.ns)
  length   = 36
  special  = false
}
resource "rabbitmq_user" "htb" {
  for_each = toset(local.ns)
  name     = "${each.key}_mq_htb"
  password = random_password.htb_password[each.key].result
  tags     = ["administrator"]
}
resource "rabbitmq_permissions" "htb" {
  for_each = toset(local.ns)
  user     = rabbitmq_user.htb[each.key].name
  vhost    = rabbitmq_vhost.my_vhost[each.key].name

  permissions {
    configure = ".*"
    write     = ".*"
    read      = ".*"
  }
}
resource "vault_kv_secret_v2" "mq_app" {
  mount               = vault_mount.secrets.path
  name                = "mq_for_app"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      for ns in local.ns : "${ns}_mq_htb" => random_password.htb_password[ns].result
    }
  )
}
output "htb_password" {
  value = {
    for ns in local.ns : "${ns}_mq_htb" => nonsensitive(random_password.htb_password[ns].result)
  }
}
