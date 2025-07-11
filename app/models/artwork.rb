class Artwork < ApplicationRecord
    belongs_to :gallery, optional: true
end
