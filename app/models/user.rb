class User < ApplicationRecord
  OMNIAUTH_PROVIDERS = %W(#{Settings.omniauth.facebook}
    #{Settings.omniauth.google_oauth2}).freeze

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable, :omniauthable,
    omniauth_providers: OMNIAUTH_PROVIDERS.map(&:to_sym)

  has_many :lyrics
  has_many :comments
  has_many :favourites

  validates :name, length: {maximum: Settings.user.name.max_length},
    presence: true

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[Settings.min_friendly_token,
          Settings.max_friendly_token]
        user.name = auth.info.name
        user.skip_confirmation!
      end
    end

    def new_with_session params, session
      super.tap do |user|
        OMNIAUTH_PROVIDERS.each do |provider|
          if data = session["devise.#{provider}_data"] &&
            session["devise.#{provider}_data"]["extra"]["raw_info"]
            next unless user.email.blank?
            user.email = data["email"]
            break
          end
        end
      end
    end
  end
end
