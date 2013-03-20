require 'spec_helper'

describe Spree::ContactUs::ContactsController do
  before(:each) do
    SpreeContactUs.mailer_to = 'test@example.com'
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

  context "prevent malicious posts" do
    it "should not error when contact_us_contact is not present" do
      lambda do
      spree_post :create, {"utf8"=>"a", "g=contact_us_contact"=>{"nam"=>""}, "xtcontact_us_contact"=>{"emai"=>""}, "ilcontact_us_contact"=>{"messag"=>"ea_n"}, "l_comm"=>"itSend Messa"}
      end.should_not raise_error
    end
  end
end
