#!/usr/bin/ruby
# Reads CSV file with headers Name | User | Password into an xml file
# that can be used to import many servers into FileZilla
# Currently unoptimised, and just prints out in terminal
HOST = "HOSTNAME"
require "csv"
require "base64"
parsed_file = CSV.parse(File.read("FTP.csv"), headers: true)
puts "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
puts "<FileZilla3 version=\"3.30.0\" platform=\"mac\">"
puts "<Servers>"
puts "<Folder expanded=\"1\">My Sites<Server>"
# Loop through each row in CSV
parsed_file.each { |site|
  # Encode password using Base64 - which is used by FileZilla to store passwords
  b64pass = Base64.encode64(site["Password"].to_s)
  # Required on all but first iteration
  if site != 0
    puts "<Server>"
  end
  puts "<Host>#{HOST}</Host>"
  puts "<Port>21</Port>"
  puts "<Protocol>0</Protocol>"
  puts "<Type>0</Type>"
  puts "<User>#{site["User"]}</User>"
  puts "<Pass encoding=\"base64\">#{b64pass}</Pass>"
  puts "<Logontype>1</Logontype>"
  puts "<TimezoneOffset>0</TimezoneOffset>"
  puts "<PasvMode>MODE_DEFAULT</PasvMode>"
  puts "<MaximumMultipleConnections>0</MaximumMultipleConnections>"
  puts "<EncodingType>Auto</EncodingType>"
  puts "<BypassProxy>0</BypassProxy>"
  puts "<Name>#{site["Name"]}</Name>"
  puts "<Comments />"
  puts "<Colour>0</Colour>"
  puts "<LocalDir />"
  puts "<RemoteDir />"
  puts "<SyncBrowsing>0</SyncBrowsing>"
  puts "<DirectoryComparison>0</DirectoryComparison>"
  puts "</Server>"
}
puts "</Folder>"
puts "</Servers>"
puts "</Filezilla>"
# Prevent terminal from auto-closing
done = gets