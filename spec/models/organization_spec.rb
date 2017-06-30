require 'rails_helper'

RSpec.describe Organization, type: :model do
  it 'has a valid factory' do
    expect(build(:organization)).to be_valid
  end
  describe 'name' do
    context 'when nil' do
      it 'is invalid' do
        expect(build(:organization, name: nil)).not_to be_valid
      end
    end

    context 'when empty' do
      it 'is invalid' do
        expect(build(:organization, name: '')).not_to be_valid
      end
    end
  end

end
