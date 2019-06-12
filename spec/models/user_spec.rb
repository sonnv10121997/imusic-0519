require "rails_helper"

RSpec.describe User, type: :model do
  subject {FactoryBot.create :user}

  describe ".create" do
    it {is_expected.to be_valid}
  end

  describe ".from_omniauth" do
    auth_hash = OmniAuth::AuthHash.new({
      provider: "facebook",
      uid: "1234",
      info: {
        email: "user@example.com",
        name: "Justin Bieber"
      }
    })

    it do
      user = User.new(
        name: "Justin Bieber",
        provider: "facebook",
        uid: 1234,
        email: "user@example.com",
        confirmed_at: Date.today,
        password: "password"
      )
      user.save
      omniauth_user = User.from_omniauth auth_hash
      expect(user).to eq omniauth_user
    end

    it {expect{User.from_omniauth(auth_hash)}.to change(User, :count).by 1}
  end

  context "validates" do
    describe "#name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of :name}
    end

    describe "#email" do
      it {is_expected.to validate_presence_of :email}
    end
  end
end
