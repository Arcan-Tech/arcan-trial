package arcan_server.authz

import future.keywords.every
import future.keywords.in

default allow = false

metadata_discovery(url) := result {
	print("metadata_discovery_url", url)
	result = http.send({
		"url": url,
		"method": "GET",
		"force_cache": true,
		"force_cache_duration_seconds": 86400,
	}).body
	# Cache response for 24 hours

	print("metadata_discovery_result", result)
}

jwks_request(url) := http.send({
	"url": url,
	"method": "GET",
	"force_cache": true,
	"force_cache_duration_seconds": 3600, # Cache response for an hour
})

check_or_refresh_licence(url) := http.send({
	"url": url,
	"method": "POST",
	"cache": true,
})

auth_server_url := opa.runtime().env.AUTH_SERVER_URL

auth_realm := opa.runtime().env.AUTH_REALM

metadata_url := concat("", [auth_server_url, "/realms/", auth_realm, "/.well-known/openid-configuration"])

metadata := metadata_discovery(metadata_url)

#jwks_endpoint := metadata.jwks_uri
#the uri from jwks_uri does not work because it is an external one, not reachable by the opa container.
jwks_endpoint := concat("", [auth_server_url, "/realms/", auth_realm, "/protocol/openid-connect/certs"])

jwks := jwks_request(jwks_endpoint).raw_body

token := {"valid": valid, "header": header, "payload": payload} {
	constraints := {
		"cert": jwks,
		"iss": metadata.issuer,
		"aud": "account",
	}

	[valid, header, payload] := io.jwt.decode_verify(input.jwt, constraints)
	valid == true
}

licence_url := concat("", [opa.runtime().env.LICENCE_SERVER_URL, "/floating-licences?userId=", token.payload.sub])

role_exists(role) {
	token.payload.resource_access["react-auth"].roles[_] == role
}

get_admin_role(group) = admin_role {
	group_no_suffix := trim_suffix(group, "/Admin")
	admin_role_prefix := sprintf("%s-admin", [group_no_suffix])
	admin_role := trim_prefix(admin_role_prefix, "/")
}

get_membership_role(group) = membership_role {
	membership_role_prefix := sprintf("%s-membership", [group])
	membership_role := trim_prefix(membership_role_prefix, "/")
}
trim_suffix(s, suffix) = result {
	endswith(s, suffix)
	result := substring(s, 0, count(s) - count(suffix))
}

trim_suffix(s, suffix) = s {
    not endswith(s, suffix)
}

trim_prefix(s, prefix) = result {
	startswith(s, prefix)
	result := substring(s, count(prefix), count(s))
}

trim_prefix(s, prefix) = s {
    not startswith(s, prefix)
}

allow {
	allow_none
}

allow {
	allow_read_all
}

allow {
	allow_read
}

allow {
	allow_create
}

allow {
	allow_update_or_delete
}

allow_read_all {
    has_valid_floating_licence
	is_token_valid
	is_read_all_operation
}

allow_read {
	has_valid_floating_licence
	is_token_valid
	is_read_operation
	has_role_member_in_resource_group
}

allow_create {
	has_valid_floating_licence
	is_token_valid
	is_create_operation
	has_role_member_in_operation_group
	has_role_admin_in_operation_group
}

allow_update_or_delete {
	has_valid_floating_licence
	is_token_valid
	is_update_or_delete_operation
	has_role_admin_in_resource_group
}

allow_none {
	has_valid_floating_licence
	is_token_valid
	is_none_operation
}

has_valid_floating_licence {
	response := check_or_refresh_licence(licence_url)
	response.status_code == 200
}

is_token_valid {
	token.valid
}

is_read_all_operation {
	input.type in ["READ_ALL"]
}

is_read_operation {
	input.type in ["READ"]
}

is_create_operation {
	input.type in ["CREATE"]
}

is_update_or_delete_operation {
	input.type in ["UPDATE", "DELETE"]
}

is_none_operation {
	input.type == "NONE"
}

has_role_member_in_resource_group {
	role_exists(get_membership_role(input.resourceGroupId))
}

has_role_member_in_operation_group {
	role_exists(get_membership_role(input.operationGroupId))
}

has_role_admin_in_operation_group {
	role_exists(get_admin_role(input.operationGroupId))
}

has_role_admin_in_resource_group {
	role_exists(get_admin_role(input.resourceGroupId))
}