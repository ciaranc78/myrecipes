require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(name: "ciri", email: "ciri@chef.com")
  end
  
  test "Chef should be valid" do
    assert @chef.valid?
  end
    
  test "name must be present" do
    @chef.name = "  "
    assert_not @chef.valid?
  end
  
  test "name must be between 3-40 charactrers" do
    @chef.name = 'a' * 100
    assert_not @chef.valid?
    @chef.name = 'a'
    assert_not @chef.valid?
  end
  
  test "email must be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email must be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email must be less than 100 characters" do
    @chef.email = "a" * 100 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "should accept valid email addresses" do
    valid_addresses = %w[ user@valid.com R_TDD-df@stillvalid.org first.last@wooky.com ]
    valid_addresses.each do |address|
      @chef.email = address
      assert @chef.valid?, '#{address.inspect} should be valid'
    end
  end
  
  test "should reject invalid email addresses" do
    invalid_addresses = %w[user@valid,com R_TDD-df@still_valid.org first.lastwooky.com]
    invalid_addresses.each do |address|
      @chef.email = address
      assert_not @chef.valid?, '#{address.inspect} should be valid'
    end
  end
  
end