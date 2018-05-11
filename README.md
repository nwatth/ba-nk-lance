### Generate Keys

1. Install `pwgen` and generate pass phrase
```
$ brew install pwgen
$ pwgen 10 5
```



2. Generate private key and enter pass phrase from above
```
$ openssl genrsa -des3 -out keys/<bank_name>_private.pem 2048
```



3. Generate public key from private key
```
$ openssl rsa -in keys/<bank_name>_private.pem -out keys/<bank_name>_public.pem -outform PEM -pubout
```



4. Run `generate_token.rb` with bank, username and password
```
$ ruby generate_token.rb <bank_name> <username> <password>
```
