# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'faker'

#=> CREATE USERS
100.times do
  begin
    name_f = Faker::Name.first_name
    name_l = Faker::Name.last_name
    address_full = Faker::Address
    User.create!(
      first_name: name_f,
      last_name: name_l,
      email: name_f + name_l + "@embloy.com",
      password: Faker::Alphanumeric.alpha(number: 10),
      longitude: Faker::Number.decimal,
      latitude: Faker::Number.decimal,
      country_code: address_full.country_code,
      postal_code: address_full.postcode,
      city: address_full.city,
      address: address_full.street_address,
      date_of_birth: DateTime.parse(Time.at(rand * Time.now.to_i).to_s),
      created_at: Faker::Date.to_s,
      updated_at: Faker::Date.to_s,
      activity_status: [0, 1].sample
    )
  rescue Exception => exception
    puts exception.message
  end
end
puts "FINISHED CREATING USERS"

#=> CREATE JOBS
100.times do |i|
  begin
    if Job.find_by("job_id", i).nil?
      address_full = Faker::Address
      Job._query_by_sql(
        "INSERT INTO `jobdata`.`jobs` (`job_id`, `job_type`, `job_status`, `user_id`, `duration`, `code_lang`, `title`, `position`, `description`, `key_skills`, `salary`, `currency`, `start_slot`, `longitude`, `latitude`, `country_code`, `postal_code`, `city`, `address`, `view_count`, `created_at`, `updated_at`)
VALUES ('#{i}', '#{Faker::Job.field}', '0', '#{(Faker::Number.number % User.count) + 1}', '#{Faker::Number.number(digits: 4)}', '#{address_full.country_code}', '#{Faker::Job.title}', '#{Faker::Job.position}', '#{Faker::GreekPhilosophers.quote}', '#{Faker::Job.key_skill}', '#{Faker::Number.decimal}', '#{Faker::Currency.name}', '#{DateTime.parse(Time.at(rand * Time.now.to_i).to_s)}',
'#{Faker::Number.decimal}', '#{Faker::Number.decimal}', '#{address_full.country_code}', '#{address_full.postcode}', '#{address_full.city}', '#{address_full.street_address}', '#{Faker::Number.decimal(l_digits: 3)}', '#{DateTime.parse(Time.at(rand * Time.now.to_i).to_s)}', '#{DateTime.parse(Time.at(rand * Time.now.to_i).to_s)}');")
    end
  rescue Exception => exception
    puts exception.message
  end
end
puts "FINISHED CREATING JOBS"

#=> APPLICATIONS
100.times do
  begin
    response = [Faker::Quote.yoda, nil].sample
    a_id = (Faker::Number.number % User.count) + 1
    j_id = (Faker::Number.number % Job.count)
    if Application.find_by(applicant_id: a_id, job_id: j_id).nil?
      Application.create!(
        applicant_id: a_id,
        job_id: j_id,
        application_text: "Dear #{Faker::GreekPhilosophers.name}, I am writing to express my interest in #{Faker::Job.position} that was advertised on embloy.com. I am a highly #{Faker::Adjective.positive} and #{Faker::Adjective.positive} with #{rand(max = 30)} years of experience in #{Faker::Job.field}. As you will see from my attached resume, I have a strong track record of #{Faker::Marketing.buzzwords}, #{Faker::Marketing.buzzwords} as well as #{Faker::Marketing.buzzwords}. I believe that my skills and experience make me an ideal candidate for the position and I am excited about the opportunity to contribute to your company and its goals. #{Faker::GreekPhilosophers.quote}. Thank you for considering my application. I look forward to hearing from you soon.",
        application_documents: Faker::Internet.url,
        response: response,
        applied_at: DateTime.now,
        status: response.nil? ? 0 : ([-1, 1].sample)
      )
    end
  rescue Exception => exception
    puts exception.message
  end
end
puts "FINISHED CREATING APPLICATIONS"
