class Server < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :tags

  def self.find_by_tag(logic,tags)
    #@servers = tags.first.servers
    if logic == "AND"
      return @servers = array_and(tags.map { |tag| Tag.find_by_name(tag).servers })
    elsif logic == "OR"
      return @servers = array_or(tags.map { |tag| Tag.find_by_name(tag).servers })
    else
      return false
    end
  end

  private
  def self.array_and(array)
    result = array.shift
    for element in array
      result = element & result
    end
    result
  end

  def self.array_or(array)
    result = array.shift
    for element in array
      result = element | result
    end
    result
  end


end
