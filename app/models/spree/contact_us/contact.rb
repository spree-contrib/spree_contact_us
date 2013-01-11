module Spree
  module ContactUs
    class Contact

      include ActiveModel::Conversion
      include ActiveModel::Validations

      attr_accessor :email, :message, :name, :subject

      validates :email,   :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i },
                          :presence => true
      validates :message, :presence => true
      validates :name,    :presence => {:if => Proc.new{SpreeContactUs.require_name}}
      validates :subject, :presence => {:if => Proc.new{SpreeContactUs.require_subject}}

      def initialize(attributes = {})
        [:email, :message, :name, :subject].each do |attribute|
          self.send("#{attribute}=", attributes[attribute]) if attributes and attributes.has_key?(attribute)
        end
      end

      def save
        if self.valid?
          Spree::ContactUs::ContactMailer.contact_email(self).deliver
          return true
        end
        return false
      end

      def persisted?
        false
      end

    end
  end
end
