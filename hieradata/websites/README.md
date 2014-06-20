Place your website yaml files here.

Example:

engine: html

bertha::sites:
  preview:
    host: furrylogic.sixsquarestudio.com
    ftp_host: ftp.sixsquarestudio.com
    ftp_user: furrylogic_preview@sixsquarestudio.com
    ftp_password: password1
  live:
    host: furrylogic.ca
    ftp_host: ftp.sixsquarestudio.com
    ftp_user: furrylogic@sixsquarestudio.com
    ftp_password: password2

bertha::include_frameworks:
  css:
    - cssreset
  scss:
    - grid
    - typeplate
  js:
    - jquery-1.11.1.js