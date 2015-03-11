require "thor"
require "thor/aws/version"
require "aws-sdk"

module Thor::Aws
  DEFAULT_REGION         = "us-east-1"
  DEFAULT_REGION_TIMEOUT = 3

  def self.included klass
    klass.class_eval do
      class_option(:profile,
        desc:    "Load credentials by profile name from shared credentials file (~/.aws/credentials).",
        aliases: [:p],
      )

      class_option(:access_key_id,
        desc:    "AWS access key id.",
        aliases: [:k],
      )

      class_option(:secret_access_key,
        desc:    "AWS secret access key.",
        aliases: [:s],
      )

      class_option(:region,
        desc:    "AWS region.",
        aliases: [:r],
      )
    end
  end

  private

  def aws_configuration
    hash = {}

    [:profile, :access_key_id, :secret_access_key, :region].each do |option|
      hash.update(option => options[option]) if options[option]
    end

    hash.update(region: own_region) if hash[:region].nil? && ENV["AWS_REGION"].nil?
    hash
  end

  def own_region
    @own_region ||= begin
      require "net/http"

      timeout DEFAULT_REGION_TIMEOUT do
        Net::HTTP.get("169.254.169.254", "/latest/meta-data/placement/availability-zone").chop
      end
    rescue
      DEFAULT_REGION
    end
  end

  def instance_variable_get_or_set(name, object)
    instance_variable_get(name) or instance_variable_set(name, object)
  end

  {
    autoscaling:          Aws::AutoScaling::Resource,
    cloudformation:       Aws::CloudFormation::Resource,
    cloudfront:           Aws::CloudFront::Resource,
    cloudhsm:             Aws::CloudHSM::Resource,
    cloudsearch:          Aws::CloudSearch::Resource,
    # cloudsearchdomain:    Aws::CloudSearchDomain::Resource, # Pending 'cause '`missing required option :endpoint`
    cloudtrail:           Aws::CloudTrail::Resource,
    cloudwatch:           Aws::CloudWatch::Resource,
    cloudwatchlogs:       Aws::CloudWatchLogs::Resource,
    codedeploy:           Aws::CodeDeploy::Resource,
    cognitoidentity:      Aws::CognitoIdentity::Resource,
    cognitosync:          Aws::CognitoSync::Resource,
    configservice:        Aws::ConfigService::Resource,
    datapipeline:         Aws::DataPipeline::Resource,
    directconnect:        Aws::DirectConnect::Resource,
    dynamodb:             Aws::DynamoDB::Resource,
    ec2:                  Aws::EC2::Resource,
    ecs:                  Aws::ECS::Resource,
    elasticache:          Aws::ElastiCache::Resource,
    elasticbeanstalk:     Aws::ElasticBeanstalk::Resource,
    elasticloadbalancing: Aws::ElasticLoadBalancing::Resource,
    elastictranscoder:    Aws::ElasticTranscoder::Resource,
    emr:                  Aws::EMR::Resource,
    glacier:              Aws::Glacier::Resource,
    iam:                  Aws::IAM::Resource,
    importexport:         Aws::ImportExport::Resource,
    kinesis:              Aws::Kinesis::Resource,
    kms:                  Aws::KMS::Resource,
    lambda:               Aws::Lambda::Resource,
    opsworks:             Aws::OpsWorks::Resource,
    rds:                  Aws::RDS::Resource,
    redshift:             Aws::Redshift::Resource,
    route53:              Aws::Route53::Resource,
    route53domains:       Aws::Route53Domains::Resource,
    s3:                   Aws::S3::Resource,
    ses:                  Aws::SES::Resource,
    simpledb:             Aws::SimpleDB::Resource,
    sns:                  Aws::SNS::Resource,
    sqs:                  Aws::SQS::Resource,
    storagegateway:       Aws::StorageGateway::Resource,
    sts:                  Aws::STS::Resource,
    support:              Aws::Support::Resource,
    swf:                  Aws::SWF::Resource,
  }.each do |name, klass|
    define_method name do
      instance_variable_get_or_set :"@#{name}", klass.new(aws_configuration)
    end
  end
end
