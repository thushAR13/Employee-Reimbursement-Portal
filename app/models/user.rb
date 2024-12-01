class User < ApplicationRecord
    has_many :companies, dependent: :destroy
end
