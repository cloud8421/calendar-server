class Event
  @events = [
    {
      id: 1,
      name: 'Dentist',
      starts_at: Time.new(2015,6,1,10,30,0),
      ends_at:   Time.new(2015,6,1,11,30,0)
    },
    {
      id: 2,
      name: 'Important meeting',
      starts_at: Time.new(2015,6,8,10,30,0),
      ends_at:   Time.new(2015,6,8,11,30,0)
    },
    {
      id: 3,
      name: 'Someone\'s birthday',
      starts_at: Time.new(2015,6,10,10,30,0),
      ends_at:   Time.new(2015,6,10,11,30,0)
    },
    {
      id: 4,
      name: 'Pub Night',
      starts_at: Time.new(2015,7,10,17,30,0),
      ends_at:   Time.new(2015,7,10,18,30,0)
    },
    {
      id: 5,
      name: 'Coffee with friends',
      startsAt: Time.new(2015,6,10,9,30,0),
      endsAt:   Time.new(2015,6,10,10,30,0)
    }
  ]

  def self.all
    @events
  end
end
