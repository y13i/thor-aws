require "thor"
require "thor/aws"

class MyAwsCLI < Thor
  include Thor::Aws

  desc :list, "Show list of EC2 instance"

  def list
    p ec2.instances.to_a
  end

  desc :showkey, "Show access key ID for testing"

  def showkey
    p ec2.client.config.credentials.access_key_id
  end

  desc :showregion, "Show region for testing"

  def showregion
    p ec2.client.config.region
  end
end
