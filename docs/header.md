AutoCloud Azure Enterprise Application
======================================

## Overview

Description of what the module does

This module provisions an Azure Application Registration and an Enterprise Application (Service Principal) granting cross account read-only access rights for AutoCloud's services to ingest your infrastructure.


## Specifications

* azuread_application - Cross Account Application Registration
* azuread_service_principal - Cross Account Service Principal
* azuread_application_password - Client Secret needed to authenticate with the Application Registration 
* azurerm_role_assignment - Role Assignment of permissions to the Application



