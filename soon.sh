#!/bin/bash

# hello
echo "SOON: $1"

# setup
echo "Setup"
PROJ_NAME=$1
LOG_NAME="$PROJ_NAME.soon.log"

# directory
echo "Creating directory"
mkdir $PROJ_NAME
cd $PROJ_NAME

# gemset
echo "Creating gemset"
. rvm gemset create $PROJ_NAME >> $LOG_NAME 2>&1
. rvm gemset use $PROJ_NAME >> $LOG_NAME 2>&1
. rvm gemset list >> $LOG_NAME 2>&1
echo "rvm gemset use $PROJ_NAME" > .rvmrc

# rails
echo "Installing rails"
gem install rails >> $LOG_NAME 2>&1
rails new ../$PROJ_NAME --skip-test-unit >> $LOG_NAME 2>&1

# specs
echo "Installing specs"
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
bundle >> $LOG_NAME 2>&1
rails g rspec:install >> $LOG_NAME 2>&1

echo "Configuring rails console with pry"
# rails console with pry
echo "silence_warnings do
  require 'pry'
  IRB = Pry
end" >> config/environments/development.rb

# git
echo "Initializing repo"
git init >> $LOG_NAME 2>&1
echo "
*.log
.DS_STORE
" >> .gitignore
git add . >> $LOG_NAME 2>&1
git commit -am 'first commit' >> $LOG_NAME 2>&1
git log >> $LOG_NAME 2>&1

# bye
echo "Project $PROJ_NAME created!"
