module Merriweather
  class Activator < ActiveRecord::Base
    cattr_accessor :event_names

    self.event_names = [
      'merriweather.cart.add',
      'merriweather.order.contents_changed',
      'merriweather.user.signup'
    ]

    def self.register_event_name(name)
      self.event_names << name
    end

    scope :event_name_starts_with, lambda{ |name| where('event_name LIKE ?', "#{name}%") }

    def self.active
      where('(starts_at IS NULL OR starts_at < ?) AND (expires_at IS NULL OR expires_at > ?)', Time.now, Time.now)
    end

    def activate(payload)
    end

    def expired?
      starts_at && Time.now < starts_at ||
      expires_at && Time.now > expires_at
    end
  end
end
