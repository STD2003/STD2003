resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description 'STD_bodywrap'

version '0.1'

client_scripts {
  "config.lua",
  "client/main.lua"
}

server_script {
  "config.lua",
  "server/server.lua"
}
