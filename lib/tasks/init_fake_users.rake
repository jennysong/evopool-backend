namespace :init do
  task :fake_users => :environment do
    100.times do
      User.create email: Faker::Internet.email, password: 'password'
    end
  end
end