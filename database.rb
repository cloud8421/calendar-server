require 'lotus/model'
require 'lotus/validations'

class Event
  include Lotus::Entity
  include Lotus::Validations

  attribute :id, type: Integer
  attribute :name, type: String, presence: true
  attribute :starts_at, type: DateTime, presence: true
  attribute :ends_at, type: DateTime, presence: true

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
