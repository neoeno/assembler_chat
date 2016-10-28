module ChatHelper
  def random_username
    (Faker::Commerce.color + " " + Faker::Company.profession).titleize
  end
end
