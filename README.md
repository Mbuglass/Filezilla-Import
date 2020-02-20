# FileZilla-Import

Ruby CSV reader for bulk importing servers into FileZilla. Depending on your platform and version, you may need to edit some of the metadata in the file, specifically in the following tag:

    <FileZilla3 version="3.39.0" platform="*nix">
You can get this information from your FileZilla client by inpecting the sites.xml file generated when selecting the export option from the Site Manager window (right click on the folder you want to export).

The Host is also hardcoded (for now), so the following line will need to be editied to include your hostname:

    HOST = "HOSTNAME"

By default, the script will look for the file "FTP.csv", but this can be changed by editing this line:

    parsed_file = CSV.parse(File.read("FTP.csv"), headers: true)

The CSV file being read should be in the following format:
|Name|User|Password|
|--|--|--|
| Site Name | Username | Password (Plaintext) |

The site name is what will appear in the "My Sites" folder when listing available servers.
Password can only be read in plain text and will be converted to Base64, which is used by FileZilla for storage. The ability to import encrypted passwords is something that could be added in future.

## To-do

- [ ] Allow version and platform to be entered at runtime
- [ ] Allow filename to be entered at runtime
- [ ] Read Host from csv or allow to be entered at runtime
- [ ] Option to read encrypted passwords
