class Game < ApplicationRecord
  before_save :set_url_hashes


  private

  def set_url_hashes
    self.players_url_hash = unique_url_hash(:players_url_hash)
    self.owners_url_hash = unique_url_hash(:owners_url_hash)
  end

  def unique_url_hash(field)
    hash = SecureRandom.urlsafe_base64(8)

    Game.find_by(field => hash) ? unique_url_hash(field) : hash
  end
end
