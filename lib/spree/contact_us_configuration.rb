class Spree::ContactUsConfiguration < Spree::Preferences::Configuration
  preference :flash_message_on_contact_sent, :string, :default => ''
end
