# lib/tasks/factory_girl.rake
namespace :factory_girl do
  require 'database_cleaner'

  desc "Verify that all FactoryGirl factories are valid"
  task lint: :environment do
    if !Rails.env.production?
      begin
        DatabaseCleaner.start
        FactoryGirl.lint traits: true
      ensure
        DatabaseCleaner.clean
      end
    else
      system("bundle exec rake factory_girl:lint RAILS_ENV='test'")
    end
  end
end