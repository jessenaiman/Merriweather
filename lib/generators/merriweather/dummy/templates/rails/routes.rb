Rails.application.routes.draw do
  <%= 'mount Merriweather::Core::Engine => "/"' if defined?(Merriweather::Core) %>
end
