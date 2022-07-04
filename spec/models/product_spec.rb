require "rails_helper"

RSpec.describe Product, type: :model do
  subject do
    @cat1 = Category.find_or_create_by! name: "Evergreens"
    @product =
      @cat1.products.create(
        name: "test",
        price: 111,
        quantity: 1,
        description: "test description"
      )
  end
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid if it doesn't contain a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if it doesn't contain a price" do
      subject.price = false
      expect(subject).to_not be_valid
    end

    it "is not valid if it doesn't contain a quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if it doesn't contain a category" do
      @product =
        Product.new(
          name: "test",
          price: 111,
          quantity: 1,
          description: "test description"
        )
      expect(@product).to_not be_valid
    end
  end
end
