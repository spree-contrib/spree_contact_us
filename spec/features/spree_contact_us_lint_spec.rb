require 'spec_helper'

describe 'Contact Us page', js: true do

  after do
    ActionMailer::Base.deliveries = []
    SpreeContactUs.mailer_from = nil
    SpreeContactUs.mailer_to = nil
    SpreeContactUs.require_name = false
    SpreeContactUs.require_subject = false
  end

  before do
    ActionMailer::Base.deliveries = []
    SpreeContactUs.mailer_to = 'contact@please-change-me.com'
  end

  it 'displays default contact form properly' do
    visit spree.contact_us_path
    within "form#new_contact_us_contact" do
      page.should have_selector "input#contact_us_contact_email"
      page.should have_selector "textarea#contact_us_contact_message"
      page.should_not have_selector "input#contact_us_contact_name"
      page.should_not have_selector "input#contact_us_contact_subject"
      page.should have_selector "input#contact_us_contact_submit"
    end
  end

  context "Submitting the form" do

    before do
      visit spree.contact_us_path
    end

    context "when valid" do
      before do
        fill_in 'Email', :with => 'test@example.com'
        fill_in 'Message', :with => 'howdy'
        click_button 'Submit'
      end

      it "I should be redirected to the homepage" do
        current_path.should == "/"
      end

      it "The email should have been sent with the correct attributes" do
        mail = ActionMailer::Base.deliveries.last
        mail.to.should == ['contact@please-change-me.com']
        mail.from.should == ['test@example.com']
        mail.text_part.body.should match 'howdy'
        ActionMailer::Base.deliveries.size.should == 1
      end
    end

    context "when invalid" do
      context "Email and message are invalid" do
        before do
          fill_in 'Email', :with => 'a'
          fill_in 'Message', :with => ''
          click_button 'Submit'
        end

        it "I should see two error messages" do
          page.should have_content "Please enter a valid email address"
          page.should have_content "This field is required"
        end

        it "An email should not have been sent" do
          ActionMailer::Base.deliveries.size.should == 0
        end
      end
    end
  end

  context 'with name and subject configuration' do

    after do
      SpreeContactUs.require_name    = false
      SpreeContactUs.require_subject = false
    end

    before do
      SpreeContactUs.require_name    = true
      SpreeContactUs.require_subject = true
      visit spree.contact_us_path
    end

    it "displays an input for name and subject" do
      page.should have_selector "input#contact_us_contact_name"
      page.should have_selector "input#contact_us_contact_subject"
    end

    context "Submitting the form" do
      context "when valid" do
        before do
          fill_in 'Email', :with => 'test@example.com'
          fill_in 'Message', :with => 'howdy'
          fill_in 'contact_us_contact[name]', :with => 'Jeff'
          fill_in 'contact_us_contact[subject]', :with => 'Testing contact form.'
          click_button 'Submit'
        end

        it "I should be redirected to the homepage" do
          current_path.should == "/"
        end

        it "The email should have been sent with the correct attributes" do
          mail = ActionMailer::Base.deliveries.last
          mail.text_part.body.should match 'howdy'
          mail.text_part.body.should match 'Jeff'
          mail.from.should == ['test@example.com']
          mail.subject.should match 'Testing contact form.'
          mail.to.should == ['contact@please-change-me.com']
          ActionMailer::Base.deliveries.size.should == 1
        end
      end

      context "when name and subject are blank" do
        before do
          click_button 'Submit'
        end

        it "I should see error messages" do
          page.should have_content "This field is required"
        end

        it "An email should not have been sent" do
          ActionMailer::Base.deliveries.size.should == 0
        end
      end
    end
  end

end
