include SecureRandom

class Url < ActiveRecord::Base
  before_create :shorten_url
  # validates :url, :format => URI::regexp(%w(http https))
  validate :url_format
  # validates_format_of :long, :with => URI::regexp(%w(http https))
  
  private

  def shorten_url
    self.short = SecureRandom.hex(7)
  end

  def url_format
    link = URI.parse(self.long)
    self.errors.add(:long, "Invalid URL please go back and try again") unless link.kind_of?(URI::HTTP)
  end

end
