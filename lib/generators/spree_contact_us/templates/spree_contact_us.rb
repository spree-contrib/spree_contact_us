# Use this initializer to configure the contact mailer.

SpreeContactUs.setup do |config|

  # ==> Mailer Configuration

  # Configure the e-mail address which email notifications should be sent from.  If emails must be sent from a verified email address you may set it here.
  # Example:
  # config.mailer_from = "contact@please-change-me.com"
  config.mailer_from = nil # nil for use Spree current MailMethod (or contact.email)

  # Configure the e-mail address which should receive the contact form email notifications.
  # config.mailer_to = "contact@please-change-me.com"
  config.mailer_to = nil # nil for use Spree current MailMethod

  # ==> Form Configuration

  # Configure the form to ask for the users name.
  config.require_name = false

  # Configure the form to ask for a subject.
  config.require_subject = false

end
