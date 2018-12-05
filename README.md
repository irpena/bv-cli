# bv-cli
##Ejemplo de creacion de adapter

Sin publicacion en git
./bv-cli.sh --name bv-customer-products-query --type adapter --port 9618 

Con publicacion en git
./bv-cli.sh --name bv-customer-products-query --type adapter --port 9618 -g https://github.com/bancodebogota/bv-customer-products-query-adapter.git

## Ejemplo de creacion de manager

Sin publicacion en git
./bv-cli.sh --name bv-customer-products-query --type manager --port 9618

Con publicacion en git
./bv-cli.sh --name bv-customer-products-query --type manager --port 9618 -g https://github.com/bancodebogota/bv-customer-products-query-mngr.git
