# Terraform Beginner Bootcamp 2023 - Week 2

## Diving into Ruby

### Bundler: Your Ruby Package Manager

Bundler serves as Ruby's primary package manager. Through it, you can easily manage and install Ruby packages, commonly referred to as "gems".

#### Setting Up and Installing Gems

To start, create a `Gemfile` to specify which gems are required for your project.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Next, execute the `bundle install` command. 

This action installs the mentioned gems globally on your system. It's different from Node.js, where packages are installed locally within a directory called `node_modules`.

A `Gemfile.lock` will be generated after installation, which helps to pin the specific versions of gems your project is using.

#### Running Ruby Scripts with Bundler

For your Ruby scripts to utilize the gems you've installed, prefix commands with `bundle exec`. This ensures your scripts are executed in the correct context.

### A Glimpse at Sinatra

Sinatra stands out as a lightweight web-framework for Ruby, to build web applications.

It's an excellent choice for developmental mock servers or even for straightforward web projects. Impressively, you can set up a web server with just a single file.

Learn more about Sinatra [here](https://sinatrarb.com/).

## Terratowns Mock Server

### Getting Your Web Server Up and Running

To launch your web server, just follow the steps below:

```rb
bundle install
bundle exec ruby server.rb
```

All essential code for this server can be found within the `server.rb` file.

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete