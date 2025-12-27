# penbox

# pentest infra

* `haproxy` port `80`
    * redirect http to nginx
    * redirect not http to penelope
* `nginx`: 
    * port `8880`
        * `/sharp/`
        * `/win/`
        * `/lin/`
        * `/lab/`
        * `/sliver/`
        * `/sl_cyber/` redirect to port `8870` (sliver stage listener)
        * `/sl_test/` redirect to port `8871` (sliver stage listener)
        * `/obf/` redirect to port `8881` (obf_server)
* `obf_server` port `8881`:
    * gzip && base64 files from `/sharp/`, `/win/`, `lin`
* `penelope` port 444
* `sliver`:
    * listener http port `8890`
    * stage listener `887x` 