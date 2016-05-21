class Array
  def create_hash
    length_based_hash = Hash.new
    for value in self
      length_based_hash[value.to_s.length] = (length_based_hash[value.to_s.length] || []).push value
    end
    empty_hash = {:odd => [], :even => []}
    final_hash = length_based_hash.inject(empty_hash) do |temp_hash, (key, value)|
      key.even? ? (temp_hash[:even].push value) : (temp_hash[:odd].push value)
      temp_hash
    end
    final_hash
  end
end
print [1,"ac","abc","hjkhf","cd"].create_hash 