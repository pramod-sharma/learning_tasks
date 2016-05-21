class Array
  def to_hash
    self.group_by {|value| value.to_s.length}
  end
end