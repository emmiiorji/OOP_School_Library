require 'json'

class Storage
  def to_hash(object)
    object.instance_variables.to_h { |var|
      hash = object.instance_variable_get(var)
      [var.to_s[1..], hash.instance_variables.empty? ? hash : (to_hash(hash)) ]
    }
  end

  def save_data(data, file_name)
    hash_data = data.map { |entry| to_hash(entry) }
    serialized_hash = JSON.pretty_generate(hash_data)
    File.write("#{file_name}.json", serialized_hash)
  end

  def load_data(file_name)
    full_name = "#{file_name}.json"

    File.exist?(full_name) ? JSON.parse(File.read(full_name)) : []
  end
end
