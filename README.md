[![Travis](https://api.travis-ci.org/yorikim/nuvi.svg)](https://travis-ci.org/yorikim/nuvi)
[![Code Climate](https://codeclimate.com/github/yorikim/nuvi/badges/gpa.svg)](https://codeclimate.com/github/yorikim/nuvi)


# Nuvi

This gem downloads all of the zip files, extract out the xml files and publish the content of each xml file to a redis list called “NEWS_XML”.
Application is idempotent.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nuvi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nuvi

## Usage

```bash
nuvi_grabber -c config.yml
```

## Sample config
```yaml
url: 'http://bitly.com/nuvi-plz'
dir: '/tmp/nuvi/'

redis:
  host: '127.0.0.1'
  port: 6379
  password: 'secret'
```
