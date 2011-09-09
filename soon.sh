#!/bin/bash

PROJ_NAME=$1

# hello
echo "SOON: $1"

# name
#echo "Enter project name: "
#read PROJ_NAME

# directory
mkdir $PROJ_NAME
cd $PROJ_NAME

# gemset
. rvm gemset create $PROJ_NAME
. rvm gemset use $PROJ_NAME
echo "rvm gemset use $PROJ_NAME" > .rvmrc

# rails
gem install rails
rails new ../$PROJ_NAME --skip-test-unit

# specs
echo "
group :test, :development do
  gem 'rspec-rails' # rspec for rails
  gem 'rr' # double ruby test double framework
  gem 'faker' # fake data generator
  gem 'machinist' # blueprints
  gem 'spork' # faster tests
  gem 'cucumber' # acceptance tests
  gem 'pry' # irb replacement
  gem 'gist' # gist code snippets with ease
end" >> Gemfile
bundle
rails g rspec:install

# rails console with pry
echo "silence_warnings do
  require 'pry'
  IRB = Pry
end" >> config/environments/development.rb

# git
git init
git add .
git commit -am 'first commit'
git log

# bye
echo "Project $PROJ_NAME created!"
