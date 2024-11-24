---
title: Hashicorp Vault Approle Auth
date: 2020-08-11
categories: ["code"]
tags: [approle, auth, microservice architecture, authentication, automation, cicd, cloud, cloud engineering, code, devops, hashicorp, hashicorp-vault, tech, vault]
skills: [Hashicorp Vault, Cloud Development, Microservices]
series: []
DisableComments: true
draft: false
---

Hashicorp [vault](https://www.vaultproject.io/) has various ways of authentication and since I've been playing around with some at work I decided to also put them here for reference. AppRole auth is one of the ways that Vault offers programmatic access to itself for machines/jobs/automation etc. Think Jenkins or Ansible trying to access credentials to run some deploy jobs without requiring someone to pass in the vault token manually. This page details both configuration of AppRole and authentication using vault/curl commands. For the most part the client use-cases tend to be through curl as you may not want to setup vault binaries on all your machines.

AppRole auth needs to be configured before it can be used for authentication. The steps below assume you have a working vault cluster setup. If not, use the in-memory dev mode for Vault.

### Configuring AppRole Auth

Note: Configuration is usually done by the vault admin or sysadmin as part of initial setup for environment.

```bash
# Create a vault auth approle method at path approle/ 
# This is the same as using `vault auth enable approle`
vault auth enable -path=approle/ approle

# If you want to enable at a custom path (say myapproles/), pass it in the path flag
vault auth enable -path=myapproles/ approle

# Verify role is created
vault auth list
#Path           Type       Accessor                 Description
#---- ---- -------- -----------
#myapproles/    approle    auth_approle_d60fcfe8    n/a

# Create a role for your application (say, Jenkins)
vault write auth/myapproles/role/jenkins-role secret_id_ttl=10m token_num_uses=10 token_ttl=20m token_max_ttl=30m secret_id_num_uses=40
# Success! Data written to: auth/myapproles/role/jenkins-role

# Get the role id of the named role you just created
vault read auth/myapproles/role/jenkins-role/role-id
# role_id    3ca916cd-e9dd-f958-72ba-f68f874325b8

# Generate a secret-id against the AppRole
vault write -f auth/myapproles/role/jenkins-role/secret-id
#secret_id             fccfd62f-361a-eb1b-ad09-00d83c8cef7c
#secret_id_accessor    060f906a-d972-1030-0165-dcf7f83a85f9
```

### Authentication via AppRole

Authentication via the API (curl) hits the endpoint at `auth/<role-name>/login`. This should point to the path where your role is created. The role to which you're authenticating is identified by the `role_id` passed in as credentials.

```bash
curl --request POST --data '{"role_id":"3ca916cd-e9dd-f958-72ba-f68f874325b8", "secret_id":"fccfd62f-361a-eb1b-ad09-00d83c8cef7c"}' <http://127.0.0.1:8200/v1/auth/myapproles/login> | jq .

{
  "auth": {
    "client_token": "s.Wz9B3wpeRr7umIElR45dRpSu",
    "accessor": "D15A2qsPDrZF2kie1DAxuMMF",
    "policies": [
      "default"
    ],
    "token_policies": [
      "default"
    ],
    "metadata": {
      "role_name": "jenkins-role"
    },
    "lease_duration": 1200,
    "renewable": true,
    "entity_id": "8856c6b9-89de-393f-bdb3-aac36f05df3a",
    "token_type": "service",
    "orphan": true
  }
}
```

The `client_token` obtained above gives you access to Vault as that AppRole. This can be tested simply by running `vault login` command and passing that token when prompted and checking the role assigned to you (`token_meta_role_name`) when logged in.

```bash
vault login
Token (will be hidden):

Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                     Value
--- -----
token                   s.Wz9B3wpeRr7umIElR45dRpSu
token_accessor          D15A2qsPDrZF2kie1DAxuMMF
token_duration          16m35s
token_renewable         true
token_policies          ["default"]
identity_policies       []
policies                ["default"]
token_meta_role_name    jenkins-role
```

We're now successfully logged in as the `jenkins-role` app role.

<br>
