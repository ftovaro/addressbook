class CardMailer < ApplicationMailer
  def card_email(email, welcome_message, message)
    @welcome_message = welcome_message
    @message = message
    mail to: email, subject: 'You have received a card! 🌽'
  end

  def confirmation_email(sender_email)
    mail to: sender_email, subject: 'Your card was sent correctly! ✉️'
  end
end
