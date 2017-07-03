module Api::V1
  class OrganizationsController < ApplicationController
    before_action :authenticate_api_v1_user!, except: [:index]
    before_action :authenticate_admin!, except: [:index]
    before_action :set_organization, only: [:show, :update, :destroy]
    before_action :validate_user!, except: [:index, :create]

    # GET /organizations
    def index
      @organizations = Organization.all
      render json: @organizations
    end

    # GET /organizations/1
    def show
      render json: @organization
    end

    # POST /organizations
    def create
      @organization = Organization.new(organization_params)

      if @organization.save
        @organization.assign_user current_api_v1_user
      else
        render json: @organization.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /organizations/1
    def update
      if @organization.update(organization_params)
      else
        render json: @organization.errors, status: :unprocessable_entity
      end
    end

    # DELETE /organizations/1
    def destroy
      @organization.destroy
      render json: { message: 'Organization deleted' }, status: :ok
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_organization
        @organization = Organization.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def organization_params
        params.require(:organization).permit(:name, :firebase_id)
      end

      def authenticate_admin!
        unless current_api_v1_user.has_role?(:admin)
          render json: { status: 'error', errors: ["You are not allowed to manage organizations"] },
                 status: :unprocessable_entity
        end
      end

      def validate_user!
        unless current_api_v1_user.organizations.ids.include? params[:id].to_i
          render json: { status: 'error', errors: ["You are not allowed to manage this organization"] },
                 status: :unprocessable_entity
        end
      end
  end
end
