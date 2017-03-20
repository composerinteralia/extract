module Extract
  def self.call(&blk)
    Extract.instance_eval(&blk)
  end

  def self.extract!(obj, *attrs)
    if obj.respond_to?(:each)
      obj.map { |item| extract!(item, *attrs) }
    else
      attrs.each_with_object({}) do |attr, result|
        if Hash === attr
          attr.each { |key, vals| result[key] = extract!(obj.send(key), *vals) }
        else
          result[attr] = obj.send(attr)
        end
      end
    end
  end
end
