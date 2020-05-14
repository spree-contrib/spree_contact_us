require 'spec_helper'.freeze

describe Spree::ContactUs::ContactsController, type: :controller do
  before do
    create(:store)
  end

  before(:each) do
    SpreeContactUs.mailer_to = 'test@example.com'
    @contact_attributes = { email: 'Valid@Email.com', message: 'Test' }
  end

  context 'if conversion code preference is empty' do
    before do
      Spree::ContactUs::Config.contact_tracking_message = ''
    end

    it 'should redirect to root path with no contact tracking flash message' do
      post :create, params: { contact_us_contact: @contact_attributes }
      expect(flash[:notice]).to_not be_nil
      expect(flash[:contact_tracking]).to be_nil
      expect(response).to redirect_to(spree.root_path)
    end
  end

  context 'if conversion code preference is not empty' do
    before(:each) do
      Spree::ContactUs::Config.contact_tracking_message = 'something'
    end

    it 'should redirect to root path with both notice and conversion flash messages' do
      post :create, params: { contact_us_contact: @contact_attributes }
      expect(flash[:notice]).to_not be_nil
      expect(flash[:contact_tracking]).to eql('something')
      expect(response).to redirect_to(spree.root_path)
    end
  end

  context 'prevent malicious posts' do
    it 'should not error when contact_us_contact is not present' do
      expect do
        post :create, params: {
          'utf8' => 'a',
          'g=contact_us_contact' => { 'nam' => '' },
          'xtcontact_us_contact' => { 'emai' => '' },
          'ilcontact_us_contact' => { 'messag' => 'ea_n' },
          'l_comm' => 'itSend Messa'
        }
      end.to_not raise_error
    end
  end
end
