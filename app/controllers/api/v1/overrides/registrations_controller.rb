module Api::V1::Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    before_action :check_orgs_exist, only: [:create, :update]
    after_action :assign_organizations, only: [:create, :update]

    protected
    def assign_organizations
      @resource.organizations = @organizations
    end

    def check_orgs_exist
      if params[:organizations_ids].blank?
        render json: { status: 'error', errors: ["Organizations not specified"] },
               status: :unprocessable_entity
        return
      end
      begin
        @organizations = Organization.find(params[:organizations_ids])
      rescue ActiveRecord::RecordNotFound
        render json: { status: 'error', errors: ["One or more organizations ids weren't found"] },
               status: :unprocessable_entity
      end
    end
  end
end
