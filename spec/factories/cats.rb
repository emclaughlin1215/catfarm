FactoryGirl.define do
  def date_string(n, m = 1)
    n_int = n.to_i * m
    year = n_int.years.ago.strftime("%Y").to_i
    month = n_int.years.ago.strftime("%m").to_i
    day = n_int.years.ago.strftime("%d").to_i
    Date.new(year, month, day)
  end

  sequence(:rescue_id) { |n| "testcat_#{n}" }
  sequence(:name) { |n| "testcat_#{n}" }
  # sequence(:image)
  sequence(:sex) { ['F', 'M', 'N', 'S'].sample }
  # sequence(:curr_foster)
  # sequence(:contact
  # sequence(:availability)
  sequence(:date_fostered) { |n| "#{date_string(n, 2)}" }
  sequence(:date_adopted) { |n| "#{date_string(n)}" }
  sequence(:birthdate) { |n| "#{date_string(n, 3)}" }
  # sequence(:paper_location)
  sequence(:notes) { |n| "#{n}. Some text for the notes" }

  factory :basest_cat, class: Cat do
    rescue_id 'basest_cat'
  end

  factory :testcat, class: Cat do
    rescue_id
    name
    # image
    sex
    # curr_foster
    # contact
    # availability
    date_fostered
    date_adopted
    birthdate
    # paper_location
    notes

    trait :no_name do
      name nil
    end

    # trait :no_no_image do
    #   image nil
    # end

    trait :no_sex do
      sex nil
    end

    # trait :no_curr_foster do
    #   curr_foster nil
    # end

    # trait :no_contact do
    #   contact nil
    # end

    # trait :no_availability do
    #   availability nil
    # end

    trait :no_date_fostered do
      date_fostered nil
    end

    trait :no_date_adopted do
      date_adopted nil
    end

    trait :no_birthdate do
      birthdate nil
    end

    # trait :paper_location do
    #   paper_location nil
    # end

    trait :no_notes do
      notes nil
    end
  end
end