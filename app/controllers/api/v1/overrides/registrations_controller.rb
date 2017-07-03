module Api::V1::Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    before_action :check_orgs_exist, only: [:create, :update]
    after_action :assign_organizations, only: [:create, :update]

    protected
    def assign_organizations
      @resource.organizations = @organizations
      binding.pry
    end

    def check_orgs_exist
      begin
        @organizations = Organization.find(params[:organizations_ids])
      rescue ActiveRecord::RecordNotFound
        render json: { status: 'error', errors: ["One or more organizations ids weren't found"] }
      end
    end
  end
end
