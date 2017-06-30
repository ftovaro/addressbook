require 'rails_helper'

RSpec.describe "Organizations", type: :request do
  describe 'GET api/v1/organizations' do
    context 'when there is no organizations' do
      it 'returns an empty array' do
        get api_v1_organizations_path
        expect(response).to have_http_status(200)
        organizations = JSON.parse(response.body)
        expect(organizations).to be_a_kind_of Array
        expect(organizations).to be_empty
      end
    end

    context 'when there is an organization' do
      let!(:existing_organization) { create :organization }
      it 'returns an array with the organization' do
        get api_v1_organizations_path
        expect(response).to have_http_status(200)
        organizations = JSON.parse(response.body)
        expect(organizations.length).to eq 1
        expect(organizations.first['id']).to eq existing_organization.id
        expect(organizations.first['name']).to eq existing_organization.name
      end
    end
  end

  describe 'GET /v1/organizations/:id' do
    let(:existing_organization) { create :organization }
    context 'when id is valid' do
      it 'returns the organization' do
        get api_v1_organization_path(existing_organization.id)
        expect(response).to have_http_status(200)
        found_organization = JSON.parse(response.body)
        expect(found_organization['id']).to eq existing_organization.id
        expect(found_organization['name']).to eq existing_organization.name
      end
    end

    context 'when id is invalid' do
      it 'raises a RecordNotFound' do # No way to get the 404.
        expect do
          get api_v1_organization_path('non-existing-id')
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'POST /v1/organizations' do
    let(:body) { attributes_for :organization }
    context 'when all attributes are valid' do
      it 'creates the organization' do
        post api_v1_organizations_path, { params: { organization: body } }
        expect(response).to have_http_status(201)
        created_organization = JSON.parse(response.body)
        expect(created_organization['name']).to eq body[:name]
      end
    end

    context 'when name is not present' do
      it 'returns a 422' do
        body[:name] = nil
        post api_v1_organizations_path, { params: { organization: body } }
        expect(response).to have_http_status(422)
      end
    end

    context 'when name is empty' do
      it 'returns a 422' do
        body[:name] = ''
        post api_v1_organizations_path, { params: { organization: body } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /v1/organizations' do
    let(:existing_organization) { create :organization }
    let(:body) do
      { name: Faker::Company.name }
    end
    context 'when updating an existing organization' do
      context 'when new name is valid' do
        it 'updates the organization' do
          patch api_v1_organization_path(existing_organization.id), { params: { organization: body } }
          expect(response).to have_http_status(200)
          updated_organization = JSON.parse(response.body)
          expect(updated_organization['name']).to eq body[:name]
        end
      end

      context 'when name is nil' do
        it 'returns a 422' do
          body[:name] = nil
          patch api_v1_organization_path(existing_organization.id), { params: { organization: body } }
          expect(response).to have_http_status(422)
        end
      end

      context 'when name is empty' do
        it 'returns a 422' do
          body[:name] = ''
          patch api_v1_organization_path(existing_organization.id), { params: { organization: body } }
          expect(response).to have_http_status(422)
        end
      end
    end
    
    context 'when updating a non-existing organization' do
      it 'raises a RecordNotFound' do # No way to get the 404.
        expect do
          patch api_v1_organization_path('non-existing-id')
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'DELETE /v1/organizations' do
    context 'when deleting an existing organization' do
      let(:existing_organization) { create :organization }
      it 'returns a 200' do
        delete api_v1_organization_path(existing_organization.id)
        expect(response).to have_http_status(200)
      end
    end

    context 'when deleting a non-existing organization' do
      it 'raises a RecordNotFound' do # No way to get the 404.
        expect do
          delete api_v1_organization_path('non-existing-id')
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
