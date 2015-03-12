# Thor::Aws

[![Gem Version](https://img.shields.io/gem/v/thor-aws.svg)](http://rubygems.org/gems/thor-aws) [![Build Status](https://travis-ci.org/y13i/thor-aws.svg)](https://travis-ci.org/y13i/thor-aws)

Thor extension for building CLI to deal with AWS.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thor-aws'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install thor-aws
```

## Usage

Just add `include Thor::Aws` to your CLI class. Then you can use private methods such as `#ec2` or `#rds` to call a instance of `Aws::EC2::Resource` or so in your CLI.

Also, `--access-key-id`, `--secret-access-key`, `--region` and `--profile` options will be added to your CLI (of course, these credentials are used by Aws clients).

## Example

```ruby
require "thor"
require "thor/aws"

class MyAwsCLI < Thor
  include Thor::Aws

  desc :list, "Show list of EC2 instance"

  def list
    p ec2.instances.to_a
  end
end
```

## Changelog

**0.0.3**: Add `--shared-credentials-path` option.

## Testing

```
bundle install --path vendor/bundle
bundle exec rake spec
```

## Contributing

1. [Fork it](https://github.com/y13i/thor-aws/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
