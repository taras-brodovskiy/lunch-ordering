require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  
  def setup
    @item = Item.new(name: "Pasta", price: 4.99,
                     kind: "main")
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "name should be present" do
    @item.name = " "
    assert_not @item.valid?
  end

  test "price should be present" do
    @item.price = nil
    assert_not @item.valid?
  end

  test "kind should be present" do
    @item.kind = " "
    assert_not @item.valid?
  end

  test "kind validation should accept valid kinds" do
    valid_kinds = %W[first main drink]
    valid_kinds.each do |valid_kind|
      @item.kind = valid_kind
      assert @item.valid?
    end
    @item.kind = "another"
    assert_not @item.valid?
  end


  test "name should not be too long" do
    @item.name = "a" * 51
    assert_not @item.valid?
  end

  test "price validation should accept valid prices" do
    valid_prices = %w[0.01 12.34 1.2]
    valid_prices.each do |valid_price|
      @item.price = valid_price.to_f
      assert @item.valid?, "#{valid_price.inspect} should be valid"
    end
  end

  test "price validation should reject invalid prices" do
    invalid_prices = %w[0.0 101. -1.]
    invalid_prices.each do |invalid_price|
      @item.price = invalid_price.to_f
      assert_not @item.valid?, "#{invalid_price.inspect} should be invalid"
    end
  end
  
  test "name should be unique" do
    duplicate_item = @item.dup
    duplicate_item.name = @item.name.upcase
    @item.save
    assert_not duplicate_item.valid?
  end
end
