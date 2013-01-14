require 'spec_helper'

describe Domain do

  it "should reverse the domain name" do
    domain = Domain.create({:hostname => 'usa.gov' })
    domain.hostname_reversed.should eq 'gov.usa.'
  end
  
  it "should right the reversed hostname" do
    domain = Domain.create({:hostname => 'usa.gov' })
    domain.hostname.should eq 'usa.gov'
  end
  
  it "should properly hash the hostname" do
    domain = Domain.create({:hostname => 'usa.gov'})
    domain.hostname_hash.should eq( Digest::MD5.hexdigest( 'usa.gov' ) )
  end
  
  it "should not allow .com domains" do
    domain = Domain.create({:hostname => 'zombo.com'})
    expect { domain.save! }.to raise_error
  end

  it "should not allow .foreign domains domains" do
    domain = Domain.create({:hostname => 'zombo.co.uk'})
    expect { domain.save! }.to raise_error
  end

  it "should allow .govs" do
    domain = Domain.create({:hostname => 'zombo.gov'})
    expect { domain.save! }.to_not raise_error
  end  

  it "should allow .mils" do
    domain = Domain.create({:hostname => 'zombo.mil'})
    expect { domain.save! }.to_not raise_error
  end  

  it "should allow .si.edu" do
    domain = Domain.create({:hostname => 'zombo.si.edu'})
    expect { domain.save! }.to_not raise_error
  end  
  
  it "should allow .fed.us" do
    domain = Domain.create({:hostname => 'zombo.fed.us'})
    expect { domain.save! }.to_not raise_error
  end  
  
end