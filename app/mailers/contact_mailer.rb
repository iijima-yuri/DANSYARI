class ContactMailer < ApplicationMailer
  default from: ENV['MAIL_ADDRESS']
  layout 'mailer'

  def send_mail(contact)
    @contact = contact
    mail to:   ENV['MAIL_ADDRESS'], subject: "【お問い合わせ】#{@contact.content}"
  end
end
