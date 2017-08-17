# Generate the key file
openssl genrsa -out key.txt 2048
# Generate the encrypted file
echo "<clear text string>" | openssl rsautl -inkey key.txt -encrypt > pass.bin
# Decrypt file
openssl rsautl -inkey key.txt -decrypt < pass.bin
