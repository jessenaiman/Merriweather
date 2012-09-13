module Merriweather
  class Alert < ActiveResource::Base
    self.site = 'http://alerts.merriweathercommerce.com/'
    self.format = :json

    def self.current(host)
      find(:all, :params => { :version => merriweather.version,
                              :name => Merriweather::Config[:site_name],
                              :host => host,
                              :rails_env => Rails.env,
                              :rails_version => Rails.version })
    end
  end
end
