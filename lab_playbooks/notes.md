# notes

## usefull commands

rbcd
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


# inprogress
security


# todo

security on srv02

## gmsa
calculer automatiquement les gmsa accessibles pour un host donné
`installed_gmsa: ["ichi", "heimdall"]`

revoir la manière dont est géré les trusts

## trust
IL Y A ENCORE DES TRUCS A FAIRE SUR LE BIDIRECTIONNEL VS INBOUND

# bug

## computer

il semble y avoir un soucis avec les vrai ordinateurs lorsque  l'on passe les actions domain-data

essai en changeant 
```
  when: action |default('creation') == "add_delegates" and item.value.delegates | default([]) | lenght > 0
========================================
  when: action |default('creation') == "add_delegates" and item.value.delegates | default([]) | lenght > 0
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

