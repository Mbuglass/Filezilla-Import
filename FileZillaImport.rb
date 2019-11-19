#!/usr/bin/ruby
# Reads CSV file with headers Name | User | Password into an xml file
# that can be used to import many servers into FileZilla
# Currently unoptimised, untested and just prints out in terminal
HOST = "HOSTNAME"
require "csv"
require "base64"
parsed_file = CSV.parse(File.read("FTP.csv"), headers: true)
puts "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
puts "<FileZilla3 version=\"3.30.0\" platform=\"mac\">"
puts "<Servers>"
puts "<Folder expanded=\"1\">My Sites<Server>"
  b64pass = Base64.encode64(parsed_file[0]["Password"].to_s)
  puts "<Server>"
  puts "<Host>#{HOST}</Host>"
  puts "<Port>21</Port>"
  puts "<Protocol>0</Protocol>"
  puts "<Type>0</Type>"
  puts "<User>#{parsed_file[0]["User"]}</User>"
  puts "<Pass encoding=\"base64\">#{b64pass}</Pass>"
  puts "<Logontype>1</Logontype>"
  puts "<TimezoneOffset>0</TimezoneOffset>"
  puts "<PasvMode>MODE_DEFAULT</PasvMode>"
  puts "<MaximumMultipleConnections>0</MaximumMultipleConnections>"
  puts "<EncodingType>Auto</EncodingType>"
  puts "<BypassProxy>0</BypassProxy>"
  puts "<Name>#{parsed_file[0]["Name"]}</Name>"
  puts "<Comments />"
  puts "<Colour>0</Colour>"
  puts "<LocalDir />"
  puts "<RemoteDir />"
  puts "<SyncBrowsing>0</SyncBrowsing>"
  puts "<DirectoryComparison>0</DirectoryComparison>"
  puts "</Server>"
puts "</Folder>"
puts "</Servers>"
puts "</Filezilla>"
done = gets