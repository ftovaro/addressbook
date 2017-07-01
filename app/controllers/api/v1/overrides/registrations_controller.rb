module Api::V1::Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    after_action :assign_organizations, only: [:create, :update]

    protected
    def assign_organizations
      @resource.organizations = Organization.find(params[:organizations_ids])
    end
  end
end
