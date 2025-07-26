class Artwork < ApplicationRecord
    belongs_to :gallery, optional: true

    def as_json(options = {})

      json = super(options.except(:base_url))

      if self.image_url.present? && options[:base_url].present?
        json[:image_url] = "#{options[:base_url]}/#{self.image_url}"
      elsif self.image_url.present?
        json[:image_url] = self.image_url
      else
        json[:image_url] = nil
      end

      json
    end
end
