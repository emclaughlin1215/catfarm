class Cat < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/cats/:style/missing.png"
  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
    size: { less_than: 1.megabytes }
  validates :rescue_id, presence: true
  validate :rescue_id_not_changed

  def id_string
    if name.blank?
      rescue_id
    else
      "#{name} (#{rescue_id})"
    end
  end

  private
    def rescue_id_not_changed
      if rescue_id_changed? && self.persisted?
        errors.add(:rescue_id, "Change of rescue_id not allowed!")
      end
    end
end
