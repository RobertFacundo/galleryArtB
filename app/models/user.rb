class User < ApplicationRecord
    has_secure_password
    has_many :galleries

    validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

    validates :hasSeenWelcomeModal, inclusion: { in: [true, false] }
    validates :hasSeenWelcomeModal, exclusion: { in: [nil] }    

    validates :coins, presence: true, numericality: { only_integer: true, greather_than_or_equal_to: 0 }
end
