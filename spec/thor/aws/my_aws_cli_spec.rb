require_relative "my_aws_cli"

describe MyAwsCLI do
  it "is a instance of the class which has a superclass Thor" do
    expect(subject.class.superclass).to be Thor
  end

  it "is a instance of the class including Thor::Aws" do
    expect(subject.class.included_modules).to include Thor::Aws
  end

  {
    autoscaling:          Aws::AutoScaling::Resource,
    cloudformation:       Aws::CloudFormation::Resource,
    cloudfront:           Aws::CloudFront::Resource,
    cloudhsm:             Aws::CloudHSM::Resource,
    cloudsearch:          Aws::CloudSearch::Resource,
    # cloudsearchdomain:    Aws::CloudSearchDomain::Resource,
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
    it "has private method ##{name} that returns #{klass} instance" do
      expect(subject.send name).to be_a klass
    end
  end

  context "when invoked from shell" do
    subject do
      MyAwsCLI.new.help
    end

    it {expect {subject}.to output(/--access-key-id/).to_stdout}
    it {expect {subject}.to output(/--secret-access-key/).to_stdout}
    it {expect {subject}.to output(/--region/).to_stdout}
    it {expect {subject}.to output(/--profile/).to_stdout}
  end
end
