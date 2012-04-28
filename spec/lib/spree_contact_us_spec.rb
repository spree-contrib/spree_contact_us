require 'spec_helper'

describe SpreeContactUs do

  after do
    SpreeContactUs.mailer_from = nil
    SpreeContactUs.mailer_to = nil
    SpreeContactUs.require_name = false
    SpreeContactUs.require_subject = false
  end

  it "should be valid" do
    SpreeContactUs.should be_a(Module)
  end

  describe 'setup block' do
    it 'should yield self' do
      SpreeContactUs.setup do |config|
        SpreeContactUs.should eql(config)
      end
    end
  end

  describe 'mailer_from' do
    it 'should be configurable' do
      SpreeContactUs.mailer_from = "contact@please-change-me.com"
      SpreeContactUs.mailer_from.should eql("contact@please-change-me.com")
    end
  end

  describe 'mailer_to' do
    it 'should be configurable' do
      SpreeContactUs.mailer_to = "contact@please-change-me.com"
      SpreeContactUs.mailer_to.should eql("contact@please-change-me.com")
    end
  end

  describe 'require_name' do
    it 'should be configurable' do
      SpreeContactUs.require_name = true
      SpreeContactUs.require_name.should eql(true)
    end
  end

  describe 'require_subject' do
    it 'should be configurable' do
      SpreeContactUs.require_subject = true
      SpreeContactUs.require_subject.should eql(true)
    end
  end

end
