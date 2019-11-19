#!/usr/bin/ruby
# Reads CSV file with headers Name | User | Password into an xml file
# that can be used to import many servers into FileZilla
# Currently unoptimised, and just prints out in terminal
HOST = "HOSTNAME"
require "csv"
require "base64"
parsed_file = CSV.parse(File.read("FTP.csv"), headers: true)
output_file = File.open("sites.xml","w")
output_file.puts "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
output_file.puts "<FileZilla3 version=\"3.30.0\" platform=\"mac\">"
output_file.puts "<Servers>"
output_file.puts "<Folder expanded=\"1\">My Sites<Server>"
# Loop through each row in CSV
parsed_file.each { |site|
  # Encode password using Base64 - which is used by FileZilla to store passwords
  b64pass = Base64.encode64(site["Password"].to_s)
  # Required on all but first iteration
  if site != 0
    output_file.puts "<Server>"
  end
  output_file.puts "<Host>#{HOST}</Host>"
  output_file.puts "<Port>21</Port>"
  output_file.puts "<Protocol>0</Protocol>"
  output_file.puts "<Type>0</Type>"
  output_file.puts "<User>#{site["User"]}</User>"
  output_file.puts "<Pass encoding=\"base64\">#{b64pass}</Pass>"
  output_file.puts "<Logontype>1</Logontype>"
  output_file.puts "<TimezoneOffset>0</TimezoneOffset>"
  output_file.puts "<PasvMode>MODE_DEFAULT</PasvMode>"
  output_file.puts "<MaximumMultipleConnections>0</MaximumMultipleConnections>"
  output_file.puts "<EncodingType>Auto</EncodingType>"
  output_file.puts "<BypassProxy>0</BypassProxy>"
  output_file.puts "<Name>#{site["Name"]}</Name>"
  output_file.puts "<Comments />"
  output_file.puts "<Colour>0</Colour>"
  output_file.puts "<LocalDir />"
  output_file.puts "<RemoteDir />"
  output_file.puts "<SyncBrowsing>0</SyncBrowsing>"
  output_file.puts "<DirectoryComparison>0</DirectoryComparison>"
  output_file.puts "</Server>"
}
output_file.puts "</Folder>"
output_file.puts "</Servers>"
output_file.puts "</Filezilla>"
# Prevent terminal from auto-closing
puts "Done"
done = gets