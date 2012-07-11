require 'spec_helper'

describe Spree::ContactUs::ContactsController do
  before(:each) do
    @contact_attributes = { :email => "Valid@Email.com", :message => "Test" }
  end

  context "if conversion code preference is empty" do
    before do
      Spree::ContactUs::Config.contact_tracking_message = ''
    end

    it "should redirect to root path with no contact tracking flash message" do
      spree_post :create, :contact_us_contact => @contact_attributes
      flash[:notice].should_not be_nil
      flash[:contact_tracking].should be_nil
      response.should redirect_to(spree.root_path)
    end
  end

  context "if conversion code preference is not empty" do
    before(:each) do
      Spree::ContactUs::Config.contact_tracking_message = 'something'
    end

    it "should redirect to root path with both notice and conversion flash messages" do
      spree_post :create, :contact_us_contact => @contact_attributes
      flash[:notice].should_not be_nil
      flash[:contact_tracking].should == 'something'
      response.should redirect_to(spree.root_path)
    end
  end
end