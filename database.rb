require 'lotus/model'

class Event
  include Lotus::Entity
  attributes :id, :name, :starts_at, :ends_at

  def to_hash
    {
      id: id,
      name: name,
      starts_at: starts_at,
      ends_at: ends_at
    }
  end
end

class EventRepository
  include Lotus::Repository

  def self.all(limit = 50)
    query do
      order(:starts_at)
    end.limit(limit)
  end
end

Lotus::Model.configure do
  adapter type: :sql, uri: ENV['DATABASE_URL']

  mapping do
    collection :events do
      entity     Event
      repository EventRepository

      attribute :id,   Integer
      attribute :name, String
      attribute :starts_at, DateTime
      attribute :ends_at, DateTime
    end
  end
end

Mutex.new.synchronize do
  Lotus::Model.load!
end
