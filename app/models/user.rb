class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  validates :email, presence: true, uniqueness: true
  validate :password_presence_on_create

  has_many :lists, dependent: :destroy

  def update_without_current_password(params, *options)
    # パスワードが空の場合、paramsからパスワード関連のキーを削除
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    # 更新処理を行う
    result = update(params, *options)
    clean_up_passwords
    result
  end

  private

  def password_presence_on_create
    if new_record? && password.blank?
      errors.add(:password, :blank)
    end
  end
end
