module Puppet::Parser::Functions
    newfunction(:extract_ssh_key, :type => :rvalue) do |args|
        filename = args[0]
        split_key = []

        File.open(filename, 'r') do |f|
            split_key = f.gets.split
        end

        type, key, comment = split_key
        return type.strip, key.strip, comment.strip
    end
end
