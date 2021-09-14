# README

## Set up

rm -rf node_modules
rake webpacker:clobber
npm install
yarn --check-files
rake webpacker:compile