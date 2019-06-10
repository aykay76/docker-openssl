# Create the root certificate (self-signed) - this must be done offline and the keys protected appropriately
if [ "$1" == "" ]; then
    echo "You need to specify a password to protect the root private key"
    echo "Run again with the password specified on the command line"
    exit
fi

# set root path to match dir variable in cnf file
root_path="/opt/pki"
password="$1"

# create the root key pair
mkdir $root_path
#cat root.cnf | sed -E "s~dir = {{dir}}~dir = ${root_path}~g" > $root_path/ca.cnf
cp ../wwwroot/assets/root.cnf $root_path/ca.cnf

mkdir $root_path/newcerts
mkdir $root_path/certs
mkdir $root_path/private
chmod 700 $root_path/private
> $root_path/index
echo 1000 > $root_path/serial

openssl genrsa -aes256 -out $root_path/private/ca.key.pem -passout pass:$password 4096

openssl req -config $root_path/ca.cnf \
    -key $root_path/private/ca.key.pem \
    -new -x509 -days 7300 -sha256 \
    -passin pass:$password \
    -extensions v3_ca \
    -out $root_path/certs/ca.cert.pem \
    -subj "/O=MyOrganisation/OU=MyDepartment/CN=Authority"

