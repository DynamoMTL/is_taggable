class Tag < ActiveRecord::Base
  class << self
    def find_or_initialize_with_name_like_and_kind(name, kind)
      with_name_like_and_kind(name, kind).first || new(:name => name, :kind => kind)
    end
  end

  has_many :taggings, :dependent => :destroy

  translates :name

  # TODO: Resolve translations
  # validates :name, 
  #   :presence => true,
  #   :uniqueness => { :scope => :kind }

  scope :with_name_like_and_kind, lambda { |name, kind| joins(:translations).where("tag_translations.name like ? AND kind = ?", name, kind) }
  scope :of_kind,                 lambda { |kind| where(:kind => kind) }
end
