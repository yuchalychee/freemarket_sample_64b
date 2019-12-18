class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :sns_credentials, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :address
  accepts_nested_attributes_for :address
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  has_one :card 
  accepts_nested_attributes_for :card

  has_one :card 
  accepts_nested_attributes_for :card

  has_one :card 
  accepts_nested_attributes_for :card

  has_one :card 
  accepts_nested_attributes_for :card

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  validates :nickname, presence: true, uniqueness: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true, uniqueness: true
  # validates :encrypted_password, presence: true
  # validates :birth_year, presence: true
  # validates :birth_month, presence: true
  # validates :birth_day, presence: true
  # validates :phone_number, presence: true, uniqueness: true
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
    end

   def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
   end

   def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end





  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birthyear 
  belongs_to_active_hash :birthmonth
  belongs_to_active_hash :birthday
end
