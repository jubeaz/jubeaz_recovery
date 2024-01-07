
# todo
calculer automatiquement les gmsa accessibles pour un host donné
`installed_gmsa: ["ichi", "heimdall"]`

revoir la manière dont est géré les trusts

# laps
Test sync phase for child domain before applying acl on ou
in `ssh://yoki/etc/ansible/roles/windows_domain/laps/dc/tasks/install.yml`

```
- name: "synchronizes all domains"
  win_shell: repadmin /syncall /Ade
  become: yes
  become_method: runas
  become_user: "{{domain_username}}"
  vars:
    ansible_become_pass: "{{domain_password}}"
```

# gmsa

## to do


ichi n'est pas installé sur fenris alors que hemdall oui
