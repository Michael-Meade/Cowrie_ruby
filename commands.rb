require_relative 'lib/cowrie'


=begin

	Combines Cowrie::Commands.get_commands("cowrie-9-11-2020.json") AND Cowrie::Commands.get_links("cowrie-9-11-2020.json")
	Saves files as: commands-9-11-2020.json

=end


# Cowrie::Commands.all("cowrie-9-11-2020.json")


################################


=begin
	
	


=end

puts Cowrie::Commands.get_links(File.join("cowrie_logs", "9-18-2020-cowrie.json"))