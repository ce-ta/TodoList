class List < ApplicationRecord
    belongs_to :user

    validates :content, presence: true, length: {maximum: 30}

end