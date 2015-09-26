# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
data = ['NEW', "ACTIVE", "INACTIVE", "DELETE"]
data.each do |c|
	status = Status.find_or_initialize_by(name: c)
	if status.new_record?
		status.save!
	else
		puts "#{c} exists"
	end
end

puts "Finished Status "

data1 = ['NEW', "EXPIRED", "COMPLETED", "DELETED", "REJECTED"]
data1.each do |c|
	status = Posts::Status.find_or_initialize_by(name: c)
	if status.new_record?
		status.save!
	else
		puts "#{c} exists"
	end
end

puts "Finished Posts Status"

data2 = ['Travel', "Food", "Drinks", "Fun", "Movie"]
data2.each do |c|
	status = Posts::Category.find_or_initialize_by(name: c)
	if status.new_record?
		status.save!
	else
		puts "#{c} exists"
	end
end

puts "Finished Category Status"