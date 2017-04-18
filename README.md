# README

## Requirement

- ruby 2.4.1
- postgresql

## Setup

- postgresql
  ```sh
  $ brew install postgresql
  $ bin/pg init
  $ bin/pg start
  ```
- rails
  ```
  $ bundle install
  $ bundle exec rails db:migrate
  $ bundle exec rails s
  ```
