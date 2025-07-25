class User < ApplicationRecord
    has_secure_password
    has_many :galleries
    has_one :personal_gallery, ->{ where(name: 'My Personal Gallery') }, class_name: 'Gallery'

    validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

    validates :hasSeenWelcomeModal, inclusion: { in: [true, false] }
    validates :hasSeenWelcomeModal, exclusion: { in: [nil] }    

    validates :coins, presence: true, numericality: { greather_than_or_equal_to: 0 }

    after_create :create_default_personal_gallery

    private

    def create_default_personal_gallery
      self.galleries.find_or_create_by(name: 'My personal Gallery')
    end
end
