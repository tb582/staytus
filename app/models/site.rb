# == Schema Information
#
# Table name: sites
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :string(255)
#  domain             :string(255)
#  support_email      :string(255)
#  website_url        :string(255)
#  time_zone          :string(255)
#  crawling_permitted :boolean          default("0")
#  email_from_name    :string(255)
#  email_from_address :string(255)
#

class Site < ActiveRecord::Base

  validates :title, :presence => true
  validates :description, :presence => true
  validates :domain, :presence => true
  validates :support_email, :presence => true, :email => true
  validates :website_url, :url => true
  validates :time_zone, :presence => true

  default_value :time_zone, -> { 'UTC' }

  attachment :logo
  attachment :cover_image

  florrick do
    string :title
    string :description
    string :domain
    string :domain_with_protocol
    string :support_email
    string :website_url
    string :time_zone
    string(:logo) { logo ? logo.path : nil }
    string(:cover_image) { cover_image ? cover_image.path : nil }
  end

  def domain_with_protocol
    "http://#{domain}"
  end

end
