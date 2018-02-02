class Card::CardSender
  def self.send_email(email, card)
    welcome_message = card.welcome_message
    message = card.message
    CardMailer.card_email(email, welcome_message, message).deliver_now
  end
  def self.send_confirmation_email(sender_email)
    CardMailer.confirmation_email(sender_email).deliver_now
  end
end
