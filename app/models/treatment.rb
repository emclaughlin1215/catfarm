class Treatment < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255 }
  validates :courses, presence: true,
                      numericality: { only_integer: true, greater_than: 0 }
  with_options if: "#{:courses}.to_i > 1" do |treatment|
    treatment.validates :min_spacing_weeks, presence: true,
                                            numericality: { only_integer: true,
                                                           greater_than: 0 }
    treatment.validates :max_spacing_weeks, presence: true,
                                            numericality: { only_integer: true,
                                                           greater_than: 0 }
  end
  with_options if: "#{:courses}.to_i <= 1" do |treatment|
    treatment.validates :min_spacing_weeks, absence: true
    treatment.validates :max_spacing_weeks, absence: true
  end
end
