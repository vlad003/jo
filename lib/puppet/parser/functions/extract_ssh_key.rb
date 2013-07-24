module Puppet::Parser::Functions
    newfunction(:extract_ssh_key, :type => :rvalue) do |args|
        filename = args[0]

        File.open(filename) do |f|
            type, key, comment = f.gets.split
            type.strip, key.strip, comment.strip
        end
    end
end
