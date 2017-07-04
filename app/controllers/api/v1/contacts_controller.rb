module Api::V1
  class ContactsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :validate_user!, except: [:list]

  # GET /contacts
  def index
    response = Contact.list_organization_contacts params[:org_id]
    unless response.body.nil?
      render json: response.body
    else
      render json: { status: 'error', errors: ["Could not show contacts"] }, status: :unprocessable_entity
    end
  end

  def list
    response = Contact.list_all_contacts current_api_v1_user
    unless response.blank?
      render json: response
    else
      render json: { status: 'error', errors: ["Could not show contacts"] }, status: :unprocessable_entity
    end
  end

  # GET /contacts/1
  def show
    response = Contact.show_contact params[:contact_id]
    unless response.body.nil?
      render json: response.body
    else
      render json: { status: 'error', errors: ["Could not show contact"] }, status: :unprocessable_entity
    end
  end

  # POST /contacts
  def create
    response = Contact.create_contact contact_params, params[:org_id]
    unless response.body.nil?
      render json: response.body, status: :created
    else
      render json: { status: 'error', errors: ["Could not create contact"] }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    response = Contact.update_contact contact_params, params[:org_id], params[:contact_id]
    unless response.body.nil?
      render json: response.body
    else
      render json: { status: 'error', errors: ["Could not update contact"] }, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    response = Contact.delete_contact params[:contact_id]
    render json: { message: "Contact deleted" }
  end

  private

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:full_name, :phone, :address, :city)
    end

    def validate_user!
      unless current_api_v1_user.organizations.ids.include? params[:org_id].to_i
        render json: { status: 'error', errors: ["You are not allowed to manage contacts in this organization"] },
               status: :unauthorized
      end
    end
  end
end
