class Book < ApplicationRecord
    validates :title, presence: true
    validates :author, presence: true
    validates :abstract, presence: true
    has_many :rent_logs
end
