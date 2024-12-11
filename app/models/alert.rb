class Alert < ApplicationRecord
  belongs_to :location
  has_many :alert_zones

  validates :area_desc, :headline, :description, :instruction, :effective, :expires, :severity, uniqueness: { scope: [:area_desc, :headline, :description, :instruction, :effective, :expires, :severity], message: "Duplicate alert detected" }

  def as_json(options = {})
    super(options).tap do |alert_hash|
      alert_hash.delete('location_id')
      
      # Create a new hash with 'state' as the first key
      if location.present?
        state_hash = { "state" => location.state }
        # Merge state_hash first to ensure 'state' comes first
        alert_hash.replace(state_hash.merge(alert_hash))
      end
    end
  end
end
