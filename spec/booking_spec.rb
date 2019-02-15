require_relative '../app/lib/space.rb'
require_relative '../app/lib/user.rb'
require_relative '../app/lib/booking.rb'
require 'database_helper'

describe Booking do

  before(:each) do
  User.create(
    username: "MakersPerson",
    email:"Awesome@aol.com",
    pass_hash: "DoesntKnow"
  )
  Space.create(
    space_name: "Makers",
    description:"Awesome",
    price: 25.00,
    owner_id: User.find_by(username: "MakersPerson")
  )
  end

  it 'can make a booking'do
  booking = Booking.new(
    user_id: User.find_by(username: "MakersPerson").id,
    space_id: Space.find_by(space_name: "Makers").id,
    booking_date: Time.parse("14/02/2019")
  )
  end

  it 'can persist a booking object' do
    new_table_row = Booking.create(
      user_id: User.find_by(username: "MakersPerson").id,
      space_id: Space.find_by(space_name: "Makers").id,
      booking_date: Time.parse("14/02/2019")
    )
    expect(Booking.all).to include(new_table_row)
  end

  it 'checks if a booking exists and returns true or false' do
    Booking.create(
      user_id: User.find_by(username: "MakersPerson").id,
      space_id: Space.find_by(space_name: "Makers").id,
      booking_date: Time.parse("14/02/2019")
    )
    date = Time.parse("14/02/2019")
    date1 = Time.parse("14/03/2019")
    expect(Booking.available?(Space.find_by(space_name: "Makers").id, date)).to eq(false)
    expect(Booking.available?(Space.find_by(space_name: "Makers").id, date1)).to eq(true)
  end

end
