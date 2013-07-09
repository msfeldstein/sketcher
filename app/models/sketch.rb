class Sketch < ActiveRecord::Base
  attr_accessible :name, :script, :artwork
  has_many :swatches

  def as_json(options={})
    hash = super(options)
    hash[:swatches_data] = swatches.as_json
    hash
  end
end
