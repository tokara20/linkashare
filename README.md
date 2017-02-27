# Linkashare

A link sharing site written on Ruby on Rails.

## Features
* Share links publicly with different users.
* Automatically fetch submitted link's metadata.
* Visit submitted links.
* Approve links.
* Comment on links.
* Filter for submitted and approved links.
* Search for links.

## Linkashare requires
* imagemagick
* libmagickwand-dev
* phantomjs-prebuilt  # for RSpec testing

## Required environment variables
The following environment variables are required for the app to run:

cloud_name=\<Cloudinary cloud name\>

api_key=\<Cloudinary api key\>

api_secret=\<Cloudinary api secret\>

generic_password=\<Password used when seeding users\>

Put the environment variable=value pair in your .bashrc file, then restart
your terminal.

Example:

export cloud_name=mycloudname123


## To run
rails db:migrate

rails db:seed  # optional to seed initial data

rails server

