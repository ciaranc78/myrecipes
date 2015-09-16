require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create(name: "bob", email: "bob@chef.com")
    @recipe = @chef.recipes.build(name: "Thai Curry", summary: "This is spicy", description: "Green curry made with lemongrass and ginger, mmmmmmmmm!")
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name=" "
    assert_not @recipe.valid?
  end
  
  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "name should be between 5-100 charactrers" do
    @recipe.name = 'a' * 105
    assert_not @recipe.valid?
    @recipe.name = "a"
    assert_not @recipe.valid?
  end

  test "summary must be present" do
    @recipe.summary=" "
    assert_not @recipe.valid?
  end
  
  test "summary must be between 10-150 characters" do
    @recipe.summary = 'a' * 155
    assert_not @recipe.valid?
    @recipe.summary = "a"
    assert_not @recipe.valid?
  end
  
  test "description must be present" do
    @recipe.description=" "
    assert_not @recipe.valid?
  end
  
  test "description must be between 20-500 characters" do
    @recipe.description = 'a' * 555
    assert_not @recipe.valid?
    @recipe.description = "a"
    assert_not @recipe.valid?
  end
end