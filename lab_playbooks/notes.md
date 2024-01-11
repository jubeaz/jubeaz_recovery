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
https://docs.ansible.com/ansible/latest/collections/community/windows/index.html
https://docs.ansible.com/ansible/latest/collections/ansible/windows/index.html


# inprogress

je ne sais pas comment faire pour que le DC prenne son IP interne plutot que son IP publique.

https://petri.com/configure-dns-on-domain-controller-two-ip-addresses/


regarder si ce n'est pas cela qui pose problème
```
- name: "disable the registration of the {{nat_adapter}} interface (NAT address) in DNS"
  ansible.windows.win_shell:
    Get-NetAdapter {{nat_adapter | ansible.windows.quote(shell='powershell')}} | Set-DNSClient -RegisterThisConnectionsAddress $False
  when: two_adapters == true
  ```

# todo

security on srv02

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


