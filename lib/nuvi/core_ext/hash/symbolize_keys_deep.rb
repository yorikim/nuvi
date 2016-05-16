class Hash
  def symbolize_keys_deep!
    keys.each do |key|
      key_symbol = key.to_sym
      self[key_symbol] = delete key
      self[key_symbol].symbolize_keys_deep! if self[key_symbol].is_a? Hash
    end

    self
  end
end
