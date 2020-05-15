class Spree::ContactUs::ContactMailer < Spree::BaseMailer
  def contact_email(contact)
    @contact = contact

    mail from: (SpreeContactUs.mailer_from || @contact.email),
         reply_to: @contact.email,
         subject: (SpreeContactUs.require_subject ? @contact.subject : Spree.t(:subject, email: @contact.email)),
         to: SpreeContactUs.mailer_to
  end
end
