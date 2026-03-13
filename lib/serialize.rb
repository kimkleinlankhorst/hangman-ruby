require 'yaml'

# Module to make and load serialized games
module SaveLoad
  # Function to serialize to marshal format
  def make_marshal(game_object, file_to_write_to)
    Dir.mkdir('lib/saved_games') unless Dir.exist?('lib/saved_games')
    full_path = File.join('lib/saved_games', file_to_write_to)
    File.open(full_path, 'w+') do |f|
      Marshal.dump(game_object, f)
    end
  end

  # Function to deserialize from a file with marshal format
  def load_marshal(file_to_read_from)
    full_path = File.join('lib/saved_games', file_to_read_from)
    File.open(full_path, 'r') do |f|
      Marshal.load(f)
    end
  end

  # Function to serialize to YAML format
  def make_yaml(game_object, file_to_write_to)
    Dir.mkdir('lib/saved_games') unless Dir.exist?('lib/saved_games')
    full_path = File.join('lib/saved_games', file_to_write_to)
    File.write(full_path, game_object.to_yaml)
  end

  # Function to deserialize from a file with YAML format
  def load_yaml(file_to_read_from)
    full_path = File.join('lib/saved_games', file_to_read_from)
    YAML.safe_load_file(full_path, permitted_classes: [Game])
  end

  def list_saved_games
    Dir.mkdir('lib/saved_games') unless Dir.exist?('lib/saved_games')
    Dir.glob('lib/saved_games/*').map { |f| File.basename(f) }
  end

  module_function :make_marshal, :load_marshal, :make_yaml, :load_yaml, :list_saved_games
end
