# Module to make and load serialized games
module SaveLoad
  def make_serialized(game_object, file_to_write_to)
    Dir.mkdir('lib/saved_games') unless Dir.exist?('lib/saved_games')
    full_path = File.join('lib/saved_games', file_to_write_to)
    File.open(full_path, 'w+') do |f|
      Marshal.dump(game_object, f)
    end
  end

  def load_serialized(file_to_read_from)
    full_path = File.join('lib/saved_games', file_to_read_from)
    File.open(full_path, 'r') do |f|
      Marshal.load(f)
    end
  end

  def list_saved_games
    Dir.mkdir('lib/saved_games') unless Dir.exist?('lib/saved_games')
    Dir.glob('lib/saved_games/*').map { |f| File.basename(f) }
  end

  module_function :make_serialized, :load_serialized, :list_saved_games
end
