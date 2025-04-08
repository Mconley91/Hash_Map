class HashMap
  attr_accessor :load_factor, :capacity, :buckets
  
  def initialize (load_factor, capacity)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = []
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord}
    hash_code
  end

  #has no collision handling, does not grow bucket array... yet.
  def set (key, value)
    hash = hash(key)
    @buckets.each_with_index do |current_obj, index|
      #required to restrict bucket size
      raise IndexError if index.negative? || index >= @buckets.length
      if current_obj.key?(hash) 
        @buckets[index] = {hash => {key => value}}
        return
      end
    end
    @buckets.push({hash => {key => value}})
  end

  def get(key)
    hash = hash(key)
    @buckets.each do |current_obj|
      if current_obj.key?(hash) 
        return current_obj.dig(hash, key)
      end
    end
    nil
  end

  def has?(key)
    hash = hash(key)
    @buckets.each do |current_obj|
      if current_obj.key?(hash) 
        return true
      end
    end
    return false
  end

end


#testing zone
my_hash_map = HashMap.new(0.5,8)

my_hash_map.set('Link', '1')
my_hash_map.set('Mario', '2')
my_hash_map.set('Bomberman', '3')
p my_hash_map.has?('Link')
p my_hash_map.has?('Zelda')

# puts my_hash_map.buckets