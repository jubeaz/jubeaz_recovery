# penbox

# share tun0 on lan
```bash
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/99-forward.conf

# NAT traffic through tun0
sudo iptables -t nat -A POSTROUTING  -o tun0 -j MASQUERADE # -s 192.168.1.0/24
sudo iptables -t nat -L -n -v
# sudo iptables -t nat -D POSTROUTING -o tun0 -j MASQUERADE # -s 192.168.1.0/24

# allow forwarding from lan to tun0
sudo iptables -A FORWARD -i eth1 -o tun0 -j ACCEPT
# allow answer
sudo iptables -A FORWARD -i tun0 -o eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT

sudo iptables -L FORWARD -n -v
# sudo iptables -D FORWARD -i eth1 -o tun0 -j ACCEPT
# sudo iptables -D FORWARD tun0 -o eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT
```

# pentest infra (2 ports to rule them all)
* `haproxy` port `80`
    * redirect http to `127.0.0.1:880` (nginx)
    * redirect not http `127.0.0.1:4444` (penelope) 
* `nginx`: 
    * port `8880`
        * `/sharp/`
        * `/win/`
        * `/lin/`
        * `/obf/`           redirect to port `127.0.0.1:8881` (`obf_server`)
        * `/lab/`           redirect to port `127.0.0.1:8884` (`uploadserver`)
        * `/sliver/`        redirect to port `127.0.0.1:8890`
        * `/sl_debug/`      redirect to port `127.0.0.1:8870`  (stage listener)
        * `/sl_debug_ssl/`  redirect to port `127.0.0.1:8871`  (stage listener)
        * `/sl_prod/`       redirect to port `127.0.0.1:8872` (stage listener)
        * `/sl_prod_ssl/`   redirect to port `127.0.0.1:8873` (stage listener)
    * port `443`
        * `/sharp/`
        * `/win/`
        * `/lin/`
        * `/obf/`           redirect to port `127.0.0.1:8881`  (`obf_server`)
        * `/lab/`           redirect to port `127.0.0.1:8884`  (`uploadserver`)
        * `/sliver/`        redirect to port `127.0.0.1:8890`
        * `/sl_debug/`      redirect to port `127.0.0.1:8870`  (stage listener)
        * `/sl_debug_ssl/`  redirect to port `127.0.0.1:8871`  (stage listener)
        * `/sl_prod/`       redirect to port `127.0.0.1:8872`  (stage listener)
        * `/sl_prod_ssl/`   redirect to port `127.0.0.1:8873`  (stage listener)
        * `/msf(.*) `        redirect to port `127.0.0.1:4445` (metasploit)      
        * `/ligolo/`        redirect to port `127.0.0.1:11602` (ligolo-ng)  
* `ligolo-ng` port `11602` (`sudo proxy  -selfcert -laddr https://127.0.0.1:11602`)
* `obf_server` port `8881`:
    * gzip && base64 files from `/sharp/`, `/win/`, `/lin/`
* `uploadserver`  port `8884`
* `penelope` port `4444`
* `sliver`:
    * listener `http` port `8890`
    * stage listener `887x`
        * `8870`: stage listener to `http://<lan_ip>:80/sliver/pwn`
        * `8871`: stage listener to `https://<lan_ip>:443/sliver/pwn`
        * `8872`: stage listener to `http://<tun0_ip>:80/sliver/pwn`
        * `8873`: stage listener to `https://<tun0_ip>:443/sliver/pwn`
```bash
sliver > profiles

 Profile Name        Implant Type   Platform        Command & Control                           Debug   Format      Obfuscation   Limitations
=================== ============== =============== =========================================== ======= =========== ============= =============
 cybernetics         beacon         windows/amd64   [1] http://10.10.14.17:80/sliver/pwn        false   SHELLCODE   disabled
 cybernetics_https   beacon         windows/amd64   [1] https://10.10.14.17:443/sliver/pwn      false   SHELLCODE   disabled
 jubeaz              beacon         windows/amd64   [1] http://192.168.10.21:80/sliver/pwn      false   SHELLCODE   disabled
 jubeaz_https        beacon         windows/amd64   [1] https://192.168.10.21:443/sliver/pwn    false   SHELLCODE   disabled

sliver > jobs

 ID   Name   Protocol   Port   Stage Profile
==== ====== ========== ====== =================================================
 21   http   tcp        8890
 22   http   tcp        8870   jubeaz (Sliver name: AGGRESSIVE_MAIL)
 23   http   tcp        8871   jubeaz_https (Sliver name: INCLINED_READING)
 24   http   tcp        8872   cybernetics (Sliver name: COOL_BROILER)
 25   http   tcp        8873   cybernetics_https (Sliver name: BACK_MOTORBOAT)
```