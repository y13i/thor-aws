require "thor"
require "thor/aws"

class MyAwsCLI < Thor
  include Thor::Aws

  desc :list, "Show list of EC2 instance"

  def list
    p ec2.instances.to_a
  end
end
