class Spree::ContactUs::ContactMailer < ActionMailer::Base
  def contact_email(contact)
    @contact = contact

    mail :from     => (SpreeContactUs.mailer_from || @contact.email),
         :reply_to => @contact.email,
         :subject  => (SpreeContactUs.require_subject ? @contact.subject : t('subject', :email => @contact.email)),
         :to       => SpreeContactUs.mailer_to
  end
end
