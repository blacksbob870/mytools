**.PFX file Generator**
https://www.interssl.com/en/ssl-tools-pfxconverter.php

**OpenSSL Command Line .P7B + .KEY -> .PFX:**
openssl pkcs7 -print_certs -in cert.p7b -out cert.cer
openssl pkcs12 -export -in cert.cer -inkey cert.key -out cert.pfx -certfile cert.cer


**OpenSSL Command Line .CER + .KEY -> .PFX:**
openssl pkcs12 -export -in cert.cer -inkey private.key -out cert.pfx -certfile CACert.cer


**OpenSSL Command Line .CRT + .KEY + .CA_BUNDLE -> .PFX:**
# PositiveSSL:
openssl pkcs12 -export -in cert.crt -inkey private.key -out cert.pfx -certfile cert.ca_bundle

**# RapidSSL:**
openssl pkcs12 -export -in ServerCert.cer -inkey private.key -out cert.pfx -certfile CABundle.ca-bundle


**OpenSSL Command Line .CRT + .KEY + COMODORSADomainValidationSecureServerCA.crt + COMODORSAAddTrustCA.crt -> .PFX:**
# Certificates issued after Jan 14th 2019, use this command:
openssl pkcs12 -export -in cert.crt -inkey private.key -out cert.pfx \
  -certfile SectigoRSADomainValidationSecureServerCA.crt -certfile USERTrustRSAAddTrustCA.crt

# Certificates issued before Jan 14th 2019, use this command:
openssl pkcs12 -export -in cert.crt -inkey private.key -out cert.pfx \
  -certfile COMODORSADomainValidationSecureServerCA.crt -certfile COMODORSAAddTrustCA.crt


**OpenSSL Command Line .PFX -> .CRT / .KEY**
openssl pkcs12 -in cert.pfx -nocerts -out cert.key
openssl pkcs12 -in cert.pfx -clcerts -nokeys -out cert.crt
openssl pkcs12 -in cert.pfx -nodes -nokeys -passin pass:mypassword -out ca_bundle.pem

**out**
openssl pkcs12 -in cert.pfx -nocerts -nodes -passin pass:meningparolim -out cert.key
openssl pkcs12 -in cert.pfx -clcerts -nokeys -passin pass:meningparolim -out cert.crt
openssl pkcs12 -in cert.pfx -cacerts -nokeys -passin pass:meningparolim -out ca_bundle.pem

