class Card < ApplicationRecord
  enum category: [ :christmas, :birthday, :motherday ]

  def self.send_card email, card_category
    card = Card.find_by(category: card_category)
    Card::CardSender.send_email email, card
  end
  def self.send_confirmation sender_email
    Card::CardSender.send_confirmation_email sender_email
  end
end
