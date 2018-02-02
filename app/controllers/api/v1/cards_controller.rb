module Api::V1
  class CardsController < ApplicationController
    before_action :authenticate_api_v1_user!
    def list
      response = Card.all
      unless response.blank?
        render json: response
      else
        render json: { status: 'error', errors: ["Could not find cards"] }, status: :unprocessable_entity
      end
    end
    def send_email
      begin
        Card.send_card params[:email], params[:card_cateogry]
        Card.send_confirmation current_api_v1_user.email
        render json: { message: "Card sent to #{params[:email]}" }
      rescue Exception
        render json: { status: 'error', errors: ["Could not send email"] }, status: :unprocessable_entity
      end
    end
  end
end
