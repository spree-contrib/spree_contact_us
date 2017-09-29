require 'spec_helper'

describe Spree::ContactUs::Contact do

  it_should_behave_like 'ActiveModel'

  describe "building" do
    it "methods" do
      params = {:email => "test@example.com", :message => "message"}
      params.default = "foo"
      contact = described_class.new(params)
      contact.subject.should_not == "foo"
    end

    it "should scrub attributes" do
      lambda {
        described_class.new(:email => "test@example.com", :message => "foo", :destroy => true)
      }.should_not raise_error
    end

    it "should not allow bypass of validation" do
      v = described_class.new(:email => "test@example.com", :message => "foo", "validation_context" => "update")
      v.validation_context.should_not == "update"
    end
  end

  describe "Validations" do

    context 'with name and subject settings' do

      after do
        SpreeContactUs.require_name = false
        SpreeContactUs.require_subject = false
      end

      before do
        SpreeContactUs.require_name = true
        SpreeContactUs.require_subject =true
      end

    end

  end

  describe 'Methods' do

    describe '#read_attribute_for_validation' do
      it 'should return attributes set during initialization' do
        contact = Spree::ContactUs::Contact.new(:email => "Valid@Email.com", :message => "Test")
        contact.read_attribute_for_validation(:email).should eql("Valid@Email.com")
        contact.read_attribute_for_validation(:message).should eql("Test")
      end
    end

    describe '#save' do

      it 'should return false if records invalid' do
        contact = Spree::ContactUs::Contact.new(:email => "Valid@Email.com", :message => "")
        contact.save.should eql(false)
      end

      it 'should send email and return true if records valid' do
        mail = Mail.new(:from=>"Valid@Email.com", :to => "test@test.com")
        mail.stub(:deliver_now).and_return(true)
        contact = Spree::ContactUs::Contact.new(:email => "Valid@Email.com", :message => "Test")
        Spree::ContactUs::ContactMailer.should_receive(:contact_email).with(contact).and_return(mail)
        contact.save.should eql(true)
      end

    end

    describe '#to_key' do
      it { subject.should respond_to(:to_key) }
    end

  end

end
