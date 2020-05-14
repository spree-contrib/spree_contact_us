require 'spec_helper'

describe Spree::ContactUs::ContactMailer do

  describe '#contact_email' do

    before do
      SpreeContactUs.mailer_to = 'contact@please-change-me.com'
      @contact = Spree::ContactUs::Contact.new(email: 'test@email.com', message: 'Thanks!')
    end

    it 'should render successfully' do
      expect(
        -> { Spree::ContactUs::ContactMailer.contact_email(@contact) }
      ).not_to raise_error
    end

    it 'should use the ContactUs.mailer_from setting when it is set' do
      SpreeContactUs.mailer_from = 'contact@please-change-me.com'
      @mailer = Spree::ContactUs::ContactMailer.contact_email(@contact)
      expect(@mailer.from).to eq([SpreeContactUs.mailer_from])
      SpreeContactUs.mailer_from = nil
    end

    describe 'rendered without error' do

      before do
        @mailer = Spree::ContactUs::ContactMailer.contact_email(@contact)
      end

      it 'should have the initializers to address' do
        expect(@mailer.to).to eq([SpreeContactUs.mailer_to])
      end

      it 'should use the users email in the from field when ContactUs.mailer_from is not set' do
        expect(@mailer.from).to eq([@contact.email])
      end

      it 'should use the users email in the reply_to field' do
        expect(@mailer.reply_to).to eq([@contact.email])
      end

      it 'should have users email in the subject line' do
        expect(@mailer.subject).to eq("Contact Us message from #{@contact.email}")
      end

      it 'should have the message in the body' do
        expect(@mailer.body).to have_content('Thanks!')
      end

      it 'should deliver successfully' do
        expect(
          -> { Spree::ContactUs::ContactMailer.contact_email(@contact).deliver }
        ).not_to raise_error
      end

      describe 'and delivered' do
        it 'should be added to the delivery queue' do
          expect(
            -> { Spree::ContactUs::ContactMailer.contact_email(@contact).deliver }
          ).to change(ActionMailer::Base.deliveries, :size).by(1)
        end
      end
    end
  end
end
