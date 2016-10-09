require 'rails_helper'

RSpec.describe Warning, type: :model do

  it 'should be shown in public mode' do

    w1 = FactoryGirl.create(:warning)
    w1.public = true

    expect(w1.public).to eq(true)
  end

  it 'should be hide from public and stay private' do

    w1 = FactoryGirl.create(:warning, public: true)
    w1.public = false

    expect(w1.public).to eq(false)
  end
end