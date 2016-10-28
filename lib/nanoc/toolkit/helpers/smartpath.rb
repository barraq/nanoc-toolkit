module Nanoc::Toolkit::Helpers
  # Contains functions for smart path management.
  module SmartPath
    # Check whether or not `string` is an item unique id.
    #
    # @return [Boolean] True if valid id; False otherwise
    def uuid?(string)
      !/\A#{uuid_pattern}\z/.match(string).nil?
    end

    # @return [Nanoc::Item] Return item from id or filename
    def item_from(identifier)
      if uuid? identifier
        item_from_uuid identifier
      else
        item_from_filename identifier
      end
    end

    private

    # Return item from uuid
    #
    # @param [String] id SecureRandom.uuid
    # @return [Nanoc::Item] Item matching the `uuid`, nil otherwise
    def item_from_uuid(id)
      @items.find { |i| i[:id].to_s == id } || raise("Unable to resolve item for uuid '#{id}'")
    end

    # Return item from filename
    #
    # @param [String] filename Filename for the item
    # @return [Nanoc::Item] Item matching the `filename`, nil otherwise
    def item_from_filename(filename)
      identifier = Nanoc::Identifier.from(expand_volume_path(filename))
      @items[identifier] || raise("Unable to resolve item for file '#{filename}'")
    end

    # @return [String] Return mount root path
    def mount_root_path
      @config[:mount][:root] || '/'
    end

    # @return [Hash] Return hash of volumes
    def mount_volumes
      @config[:mount][:volumes] || {}
    end

    # @param [String] volume Name of the volume
    # @return [String] Return volume path
    def mount_path_for(volume)
      segment = ['/', mount_root_path]
      segment.push(mount_volumes[volume]) if mount_volumes.key? volume
      File.join(segment)
    end

    # @return [Regexp] Return uuid pattern
    def uuid_pattern
      /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/x
    end

    # @return [Regexp] Return volume pattern
    def volume_pattern
      %r{(?<volume>#{mount_volumes.values.join('|')})((?:\/[\w\.\-]+)+)}x
    end

    # Expand `path` with volume path if volume path
    #
    # @param [String] path Path to expend
    # @return [String] Expended path
    def expand_volume_path(path)
      return path if path.start_with? '/'

      # Retrieve volume for the path
      volume = volume_pattern.match path

      unless volume
        raise "Unable to expend path '#{path}': make sure your path is absolute " \
        "or that it starts with one of the volume names [#{mount_volumes.values.join(',')}]"
      end

      File.join(mount_path_for(volume), path)
    end
  end
end
