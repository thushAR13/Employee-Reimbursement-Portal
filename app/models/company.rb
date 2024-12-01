class Company < ApplicationRecord
    belongs_to :user
    has_many :employees, dependent: :destroy

    validates :name, presence: true, uniqueness: { scope: :user_id, message: 'should be unique per user' }
end
