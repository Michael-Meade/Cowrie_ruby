require_relative 'lib/cowrie'

=begin
	
	outputs a piechart both SUCCESS and FAILED login attempts.
	Top-password = title
	Saves output as: 9-16-2020-Top-Password.png

=end

Cowrie::TopTen.success_both("cowrie.json")


=begin
	
	Outputs piechart of just failed attemps to login.
	Saves output as: 9-16-2020-Top-Password.png

=end


#Cowrie::TopTen.success_failed("cowrie-9-12-2020.json")


=begin

	Outs a piechart of success attemps to login.
	Saves output as: 9-16-2020-Top-Password.png

=end


#Cowrie::TopTen.success_success("9-23-2020-cowrie.json")