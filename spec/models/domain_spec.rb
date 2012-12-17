require 'spec_helper'

describe Domain do

  it "should reverse the domain name" do
    domain = Domain.create({:hostname => 'usa.gov' })
    domain.hostname_reversed.should eq 'gov.usa'
  end
  
  it "should right the reversed hostname" do
    domain = Domain.create({:hostname => 'usa.gov' })
    domain.hostname.should eq 'usa.gov'
  end
  
  it "should properly hash the hostname" do
    domain = Domain.create({:hostname => 'usa.gov'})
    domain.hostname_hash.should eq( Digest::MD5.hexdigest( 'usa.gov' ) )
  end
end