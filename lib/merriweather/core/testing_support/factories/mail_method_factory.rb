FactoryGirl.define do
  factory :mail_method, :class => Merriweather::MailMethod do
    environment { Rails.env }
    active true
  end
end
