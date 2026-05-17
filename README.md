# Terraform ACI Network Blueprint

This project demonstrates how to build a Cisco ACI logical network model using Terraform and the Cisco ACI provider.

The configuration creates a reusable ACI blueprint including a Tenant, VRF, Bridge Domain, Subnet, Application Profile, EPGs, and Contract-based communication.

> All IP addressing and credentials in this project are part of a simulated lab environment.

---

## Project Purpose

The goal of this lab is to show how Cisco ACI infrastructure can be managed using Infrastructure as Code.

Instead of manually creating ACI objects from the APIC GUI, this project uses Terraform to define and deploy the logical network model in a repeatable and structured way.

---

## Logical Design

This design represents a basic Cisco ACI application network blueprint:

- A dedicated Tenant is created for logical separation.
- A VRF provides Layer 3 routing context.
- A Bridge Domain defines Layer 2 forwarding and subnet association.
- Multiple EPGs are created dynamically using Terraform variables.
- A contract is attached to the EPGs to allow controlled communication.

---

## Tools and Technologies

- Terraform
- Cisco ACI
- Cisco APIC
- CiscoDevNet ACI Terraform Provider
- Infrastructure as Code
- GitHub

---

## Key Terraform Concepts Used

This project demonstrates:

- Provider configuration
- Variables
- Sensitive variables
- Resource dependencies
- Dynamic resource creation using for_each
- Reusable configuration structure
- Infrastructure as Code for network automation
