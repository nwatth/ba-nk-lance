require 'openssl'
require 'base64'

SPLITER  = ';PASSWORD{'

bank_name = ARGV[0]
username  = ARGV[1]
password  = ARGV[2]

public_key_file = "keys/#{bank_name}_public.pem"

public_key = OpenSSL::PKey::RSA.new(File.read(public_key_file))
encrypted_string = Base64.encode64(public_key.public_encrypt("#{username}#{SPLITER}#{password}"))

print encrypted_string, "\n"
