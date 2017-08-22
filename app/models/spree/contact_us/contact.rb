module Spree
  module ContactUs
    class Contact

      include ActiveModel::Conversion
      include ActiveModel::Validations

      attr_accessor :email, :message, :name, :subject

      EMAIL_REGEX = /\A
        [^\s@]+ # non-at-sign characters, at least one
          @     # at-sign
        [^\s.@] # non-at-sign and non-period character
        [^\s@]* # 0 or more non-at-sign characters, accepts any number of periods
         \.     # period
        [^\s@]* # 0 or more non-at-sign characters, accepts any number of periods
        [^\s.@] # non-at-sign and non-period character
      \z/x

      validates :email,   :format => { :with => EMAIL_REGEX },
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
          Spree::ContactUs::ContactMailer.contact_email(self).deliver_now
          return true
        end
        false
      end

      def persisted?
        false
      end
    end
  end
end
