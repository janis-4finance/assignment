require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "user must have a name" do
		user = User.new
		assert_not user.save
	end
	test "user must have a phone" do
		user = User.new
		user.name = "John Doe"
		assert_not user.save
	end
	test "user must have an iban" do
		user = User.new
		user.name = "John Doe"
		user.phone = "+371 12345678"
		assert_not user.save
	end
	test "valid user can be created" do
		user = User.new
		user.name = "John Doe"
		user.phone = "+371 12345678"
		user.iban = "LV80BANK0000435195001"
		assert user.save
	end
	test "iban must be unique" do
		user_one = User.new
		user_one.name = "John One"
		user_one.phone = "+371 11111111"
		user_one.iban = "LV80BANK0000435195001"
		user_one.save
		user_two = User.new
		user_two.name = "John Two"
		user_two.phone = "+371 22222222"
		user_two.iban = "LV80BANK0000435195001"
		assert_not user_two.save
	end
	test "empty user without validations can be created" do
		user = User.new
		assert user.save( :validate => false )
	end
	
end
