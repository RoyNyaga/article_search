class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :saved_searches, dependent: :destroy

  def saved_search_exist?(search_data)
    self.saved_searches.where(search_params: search_data).present?
  end
end
