require "rails_helper"

RSpec.describe User, type: :model do
  describe "Validations" do
    it "must be created with a first name" do
      user =
        User.new(
          first_name: nil,
          last_name: "Sticks",
          password: "test",
          password_confirmation: "test",
          email: "test@example.com"
        )
      user.save
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "must be created with a name" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: nil,
          password: "test",
          password_confirmation: "test",
          email: "test@example.com"
        )
      user.save
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "must be created with an email" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          password: "test",
          password_confirmation: "test",
          email: nil
        )
      user.save
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "must be created with a unique email (case sensitive)" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          password: "test",
          password_confirmation: "test",
          email: "test@example.com"
        )
      user1 =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          password: "test",
          password_confirmation: "test",
          email: "Test@example.com"
        )
      user.save
      user1.save
      expect(user1.errors.full_messages).to include(
        "Email has already been taken"
      )
    end

    it "must be a valid email" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          password: "test",
          password_confirmation: "test",
          email: "test"
        )
      user.save
      expect(user.errors.full_messages).to include("Email is invalid")
    end

    it "must be created with a password" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          password: nil,
          password_confirmation: "test",
          email: "test@example.com"
        )
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it "must be created with a password and a password_confirmation being identical" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          password: "test1",
          password_confirmation: "test",
          email: "test@example.com"
        )
      user.save
      expect(user.errors.full_messages).to include(
        "Password confirmation doesn't match Password"
      )
    end
    it "must be created with a password over 4 characters" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          password: "tes",
          password_confirmation: "tes",
          email: "test@example.com"
        )
      user.save
      expect(user.errors.full_messages).to include(
        "Password is too short (minimum is 4 characters)"
      )
    end

    it "must be created with a password & password_confirmation" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          password: "test",
          password_confirmation: nil,
          email: "test@example.com"
        )
      user.save
      expect(user.errors.full_messages).to include(
        "Password confirmation can't be blank"
      )
    end
  end

  describe ".authenticate_with_credentials" do
    it "should find the user with valid credentials" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          email: "test@test.com",
          password: "test",
          password_confirmation: "test"
        )
      user.save
      result = User.authenticate_with_credentials("test@test.com", "test")
      expect(result).to match(user)
    end

    it "should not pass with invalid credentials" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          email: "test@test.com",
          password: "test",
          password_confirmation: "test"
        )
      user.save
      result = User.authenticate_with_credentials("test@test.com", "str")
      expect(result).to be(nil)
    end

    it "should pass with caps in email" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          email: "test@test.com",
          password: "test",
          password_confirmation: "test"
        )
      user.save
      result = User.authenticate_with_credentials("tEst@Test.com", "test")
      expect(result).not_to be(nil)
    end

    it "should validate an email with whitespace" do
      user =
        User.new(
          first_name: "Jamie",
          last_name: "Sticks",
          password: "test",
          password_confirmation: "test",
          email: " test@example.com "
        )
      user.save
      expect(user).to be_valid
    end
  end
end
