# notes

## usefull commands

### rdp
```bash
xfreerdp /cert:ignore /v:172.16.0.1 /u:vagrant /p:vagrant /h:1024 /w:1640 /drive:share,./ +drives
```
```bash
xfreerdp /cert:ignore /v:172.16.0.1 /u:administrator@haas.local /p:'Jubeaz12345+-' /h:1024 /w:1640 /drive:share,./ +drives
xfreerdp /cert:ignore /v:172.16.1.1 /u:administrator@weyland.local /p:'Jubeaz12345+-' /h:1024 /w:1640 /drive:share,./ +drives
xfreerdp /cert:ignore /v:172.16.2.1 /u:administrator@research.weyland.local /p:'Jubeaz12345+-' /h:1024 /w:1640 /drive:share,./ +drives
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

## ACL
ajouter la possibilité d'avoir des ACL avec des foreigns
traiter `roles/windows_domain/user_group_ou_computer/group/tasks/add_foreign.yml` via Get6ADObject


## add group foreign members
traiter `roles/windows_domain/user_group_ou_computer/group/tasks/add_foreign.yml` via Get6ADObject

## gmsa
calculer automatiquement les gmsa accessibles pour un host donné
`installed_gmsa: ["ichi", "heimdall"]`

revoir la manière dont est géré les trusts

## trust
IL Y A ENCORE DES TRUCS A FAIRE SUR LE BIDIRECTIONNEL VS INBOUND

# bug


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

