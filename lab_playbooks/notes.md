# docs

https://docs.ansible.com/ansible/latest/collections/microsoft/ad/index.html


# inprogress




## user delegation
user and delegation

### unconstrain
done

### constrained
done


### ressource based 
géré en natif (delegates) ?

## computer 
# unconstained
géré par le module

### constrained
```powershell
# Import the Active Directory module
Import-Module ActiveDirectory

# Specify the computer name and service account
$computerName = "YourComputer"
$serviceAccount = "ServiceAccount"

# Get the computer and service account
$computer = Get-ADComputer -Identity $computerName
$service = Get-ADUser -Identity $serviceAccount

# Enable constrained delegation for the computer
Set-ADComputer -Identity $computer -PrincipalsAllowedToDelegateTo $service
```


### ressource based

```powershell
# Import the Active Directory module
Import-Module ActiveDirectory

# Specify the usernames for the user and the computer account
$userToDelegate = "UserToDelegate"
$resourceComputer = "ResourceComputer"

# Get the user and computer account
$user = Get-ADUser -Identity $userToDelegate
$computer = Get-ADComputer -Identity $resourceComputer

# Enable resource-based constrained delegation for the user
Set-ADUser -Identity $user -PrincipalsAllowedToDelegateTo $computer
Set-ADComputer -Identity $computer -PrincipalsAllowedToDelegateTo $user
```
# todo

## delegation computer

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


