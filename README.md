# README

## Start server

* Development
  
  for development: slow, reload, can reset database

* Integration
 
  for running tests: fast, reset database

## Assets Compiling

npm install 
yarn install
rake RAILS_ENV=XX assets:precompile


Production mode: static files not turned on by default, can be set by environment variable: RAILS_SERVE_STATIC_FILES

### Clean ... 
rm -rf node_modules
rake webpacker:clobber
npm install
yarn --check-files
rake webpacker:compile