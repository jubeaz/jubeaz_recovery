# notes

## usefull commands
### ssh
```bash
sshpass -p vagrant ssh vagrant@192.168.2.100
```

### rdp
```bash
xfreerdp /cert:ignore /v:172.16.0.1 /u:vagrant /p:vagrant /h:1024 /w:1640 /drive:share,./ +drives
```
```bash
xfreerdp /cert:ignore /v:172.16.0.1 /u:administrator@haas.local /p:'Jubeaz12345+-' /h:1024 /w:1640 /drive:share,./ +drives
xfreerdp /cert:ignore /v:172.16.1.1 /u:administrator@weyland.local /p:'Jubeaz12345+-' /h:1024 /w:1640 /drive:share,./ +drives
xfreerdp /cert:ignore /v:172.16.2.1 /u:administrator@research.weyland.local /p:'Jubeaz12345+-' /h:1024 /w:1640 /drive:share,./ +drives
```
```bash
xfreerdp /cert:ignore /v:172.16.0.12 /u:HAAS\\mhendrik /p:'b_QNoDKoVJTjU3gq' /h:1024 /w:1640 /drive:share,./ +drives
```

### rbcd
```powershell
$id = (get-adcomputer -identity ws01).DistinguishedName
(ActiveDirectory\Get-ADObject -Identity $Id  -properties msDS-AllowedToActOnBehalfOfOtherIdentity).'msDS-AllowedToActOnBehalfOfOtherIdentity'.Access

# Get the user object and retrieve the UserAccountControl attribute
$userObject = ActiveDirectory\Get-ADObject -Identity $Id  -Properties UserAccountControl
# Display the UserAccountControl attribute value
Write-Host "UserAccountControl for $($userObject.SamAccountName): $($userObject.UserAccountControl)"
```


# docs

https://docs.ansible.com/ansible/latest/collections/microsoft/ad/index.html
https://docs.ansible.com/ansible/latest/collections/community/windows/index.html
https://docs.ansible.com/ansible/latest/collections/ansible/windows/index.html


# inprogress

# todo

## mssql gmsa

## ansible script and firewall
### windows server
```bash
    nrunner_dc02: Verifying WinRM service.
    nrunner_dc02: PS Remoting is already enabled.
    nrunner_dc02: Self-signed SSL certificate generated; thumbprint: ADAF1EF9CE5F9F78C83950BB2EDA479D5FC2BEAA
    nrunner_dc02: Enabling SSL listener.
    nrunner_dc02:
    nrunner_dc02:
    nrunner_dc02: wxf                 : http://schemas.xmlsoap.org/ws/2004/09/transfer
    nrunner_dc02: a                   : http://schemas.xmlsoap.org/ws/2004/08/addressing
    nrunner_dc02: w                   : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
    nrunner_dc02: lang                : en-US
    nrunner_dc02: Address             : http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous
    nrunner_dc02: ReferenceParameters : ReferenceParameters
    nrunner_dc02:
    nrunner_dc02: Basic auth is already enabled.
    nrunner_dc02: Adding firewall rule to allow WinRM HTTPS.
    nrunner_dc02: Ok.
    nrunner_dc02:
    nrunner_dc02: HTTP: Disabled | HTTPS: Enabled
    nrunner_dc02:
    nrunner_dc02:
```

avant la jonction au domaine:
```powershell
winrm get winrm/config

Config
    MaxEnvelopeSizekb = 500
    MaxTimeoutms = 1800000
    MaxBatchItems = 32000
    MaxProviderRequests = 4294967295
    Client
        NetworkDelayms = 5000
        URLPrefix = wsman
        AllowUnencrypted = false
        Auth
            Basic = true
            Digest = true
            Kerberos = true
            Negotiate = true
            Certificate = true
            CredSSP = false
        DefaultPorts
            HTTP = 5985
            HTTPS = 5986
        TrustedHosts
    Service
        RootSDDL = O:NSG:BAD:P(A;;GA;;;BA)(A;;GR;;;IU)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)
        MaxConcurrentOperations = 4294967295
        MaxConcurrentOperationsPerUser = 1500
        EnumerationTimeoutms = 240000
        MaxConnections = 300
        MaxPacketRetrievalTimeSeconds = 120
        AllowUnencrypted = true
        Auth
            Basic = true
            Kerberos = true
            Negotiate = true
            Certificate = false
            CredSSP = false
            CbtHardeningLevel = Relaxed
        DefaultPorts
            HTTP = 5985
            HTTPS = 5986
        IPv4Filter = *
        IPv6Filter = *
        EnableCompatibilityHttpListener = false
        EnableCompatibilityHttpsListener = false
        CertificateThumbprint
        AllowRemoteAccess = true
    Winrs
        AllowRemoteShellAccess = true
        IdleTimeout = 7200000
        MaxConcurrentUsers = 2147483647
        MaxShellRunTime = 2147483647
        MaxProcessesPerShell = 2147483647
        MaxMemoryPerShellMB = 800
        MaxShellsPerUser = 2147483647

```

### windows 11
```bash
```

## ACL
ajouter la possibilité d'avoir des ACL avec des foreigns
traiter `roles/windows_domain/user_group_ou_computer/group/tasks/add_foreign.yml` via Get6ADObject

## add group foreign members
traiter `roles/windows_domain/user_group_ou_computer/group/tasks/add_foreign.yml` via Get6ADObject

```powershell
        $DC = (Get-ADDomainController -Discover -Domain $DomainName).Name
        #Write-Warning "Get-ADObject -Filter {(objectClass -eq $Type) -and (Name -eq $Identity) }  -Server $DC.$DomainName"
        #$Obj = Get-ADObject -Filter {("objectClass -eq '$Type'") -and ("Name -eq '$Identity'") }  -Server "$DC.$DomainName"
```

## gmsa
calculer automatiquement les gmsa accessibles pour un host donné
`installed_gmsa: ["ichi", "heimdall"]`

## trust
IL Y A ENCORE DES TRUCS A FAIRE SUR LE BIDIRECTIONNEL VS INBOUND

# bug

si les DC ont le même nom a priori il faudrait creer un Site (`New-ADReplicationSite`)

` Install-ADDSDomain
-SiteName

Specifies the name of an existing site where you can place the new domain controller. The default value is the site that is associated with the subnet that includes the IP address of this server. If no such site exists, the default is the site of the replication source domain controller.
`
```json
            {
                "category_info": {
                    "activity": "Install-ADDSDomain",
                    "category": "NotSpecified",
                    "category_id": 0,
                    "reason": "DCPromoExecutionException",
                    "target_name": "",
                    "target_type": ""
                },
                "error_details": {
                    "message": "The operation failed because:\r\n\r\nActive Directory Domain Services could not determine if this directory server name CN=NTDS Settings,CN=DC01,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=weyland,DC=local is unique on the remote directory server dc01.weyland.local. If this name is not unique, rename this directory server.\r\n\r\n\"A domain controller with the specified name already exists.\"\r\n",
                    "recommended_action": ""
                },
                "exception": {
                    "help_link": null,
                    "hresult": -2146233088,
                    "inner_exception": null,
                    "message": "The operation failed because:\r\n\r\nActive Directory Domain Services could not determine if this directory server name CN=NTDS Settings,CN=DC01,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=weyland,DC=local is unique on the remote directory server dc01.weyland.local. If this name is not unique, rename this directory server.\r\n\r\n\"A domain controller with the specified name already exists.\"\r\n",
                    "source": null,
                    "type": "Microsoft.DirectoryServices.Deployment.DCPromoExecutionException"
                },
                "fully_qualified_error_id": "DCPromo.General.54,Microsoft.DirectoryServices.Deployment.PowerShell.Commands.InstallADDSDomainCommand",
                "output": "Install-ADDSDomain : The operation failed because:\r\n\r\nActive Directory Domain Services could not determine if this directory server name CN=NTDS \r\nSettings,CN=DC01,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=weyland,DC=local is unique on the \r\nremote directory server dc01.weyland.local. If this name is not unique, rename this directory server.\r\n\r\n\"A domain controller with the specified name already exists.\"\r\n\r\nAt line:37 char:3\r\n+   Install-ADDSDomain -Credential $Cred -SkipPreChecks -NewDomainName  ...\r\n+   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\r\n    + CategoryInfo          : NotSpecified: (:) [Install-ADDSDomain], DCPromoExecutionException\r\n    + FullyQualifiedErrorId : \r\nDCPromo.General.54,Microsoft.DirectoryServices.Deployment.PowerShell.Commands.InstallADDSDomainCommand\r\n",
                "pipeline_iteration_info": [
                    0,
                    1
                ],
                "script_stack_trace": "at <ScriptBlock>, <No file>: line 37",
                "target_object": null
            }

```

## microsoft.ad.group 
`microsoft.ad.group` fail to add foreign members

https://github.com/ansible-collections/microsoft.ad/issues/56

```json
    "L_LAPS_READER" : {
        "scope": "domainlocal", # universal, global or domainlocal default domainlocal
        "managed_by" : "Domain Admins",
        "path" : "OU=Groups,OU=IT,OU=Argus,DC=weyland,DC=local",
        "members" : [
            "G_LAPS_READER", 
            "haas.local\\emoon"
```


{"msg": "The conditional check 'item.value.domain_name != domain_name and item.value.domain_name != domain_trust_remote_domain_name and '.'.join(item.value.domain_name.split('.')[1:]) != domain_name and item.value.domain_name != '.'.join(domain_name.split('.')[1:])' failed. The error was: error while evaluating conditional (item.value.domain_name != domain_name and item.value.domain_name != domain_trust_remote_domain_name and '.'.join(item.value.domain_name.split('.')[1:]) != domain_name and item.value.domain_name != '.'.join(domain_name.split('.')[1:])): 'dict object' has no attribute 'domain_name'. 'dict object' has no attribute 'domain_name'\n\nThe error appears to be in '/etc/ansible/lab_playbooks/books/compute-inventory.yml': line 109, column 7, but may\nbe elsewhere in the file depending on the exact syntax problem.\n\nThe offending line appears to be:\n\n  tasks:\n    - name: search for other domains\n      ^ here\n"}

