#!/bin/bash

# hello
echo "SOON"

# name
echo "Enter project name: "
read projname

# directory
mkdir $projname
cd $projname

# gemset
. rvm gemset create $projname
. rvm gemset use $projname
echo "rvm gemset use $projname" > .rvmrc

# rails
gem install rails
rails new ../$projname --skip-test-unit

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
end >> config/environments/development.rb

# git
git init
git add .
git commit -am 'first commit'
git log

# bye
echo "Project $projname created!"
