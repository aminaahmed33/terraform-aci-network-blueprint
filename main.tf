terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "2.19.0"
    }
  }
}

provider "aci" {
  username = var.username
  password = var.password
  url = "https://192.168.1.204"
}

resource "aci_tenant" "AcmeCorp_Tenant" {
  name = "AcmeCorp_Production_608"
  description = "AcmeCorp production tenant configured using Terraform"
}

resource "aci_vrf" "AcmeCorp_VRF" {
  parent_dn = aci_tenant.AcmeCorp_Tenant.id
  name = "AcmeCorp_Global_VRF"
}

resource "aci_bridge_domain" "AcmeCorp_BD" {
  parent_dn = aci_tenant.AcmeCorp_Tenant.id
  name = "AcmeCorp_Web_BD"
  relation_to_vrf = {
    vrf_name = aci_vrf.AcmeCorp_VRF.name
  }
  #arp_flooding = yes
  #unicast_routing = yes
}

resource "aci_subnet" "AcmeCorp_Subnet" {
  parent_dn = aci_bridge_domain.AcmeCorp_BD.id
  description = "Web subnet for AcmeCorp"
  ip = "10.10.10.1/24"
  scope = ["public"]
}

resource "aci_application_profile" "AcmeCorp_App" {
  parent_dn = aci_tenant.AcmeCorp_Tenant.id
  name = "AcmeCorp_Ecommerce_App"
}

resource "aci_application_epg" "AcmeCorp_EPG" {
  for_each = toset(var.epg_names)
  parent_dn = aci_application_profile.AcmeCorp_App.id
  name = each.value
  relation_to_bridge_domain = {
    bridge_domain_name = aci_bridge_domain.AcmeCorp_BD.name
  }
  relation_to_consumed_contracts = [
    {
      contract_name = aci_contract.allow_icmp.name
    }
  ]
  relation_to_provided_contracts = [
    {
      contract_name = aci_contract.allow_icmp.name
    }
  ]
}

resource "aci_contract" "allow_icmp" {
  tenant_dn = aci_tenant.AcmeCorp_Tenant.id
  name = "Allow_ICMP"
}