require_relative 'lib/cowrie'


=begin

	Saves the output in the: password/09-11-2020-password.json
	Also outputs a image as: "09-11-2020-Top Password.png"
	By default the it uses the event_id of "cowrie.login.success"

=end

 
 #Cowrie::TopTen.top_password(File.join("cowrie_logs", "9-20-2020-cowrie.json"))



################################


=begin

This is similar to: Cowrie::TopTen.top_password("cowrie-9-11-2020.json") but it saves all the data in 
one file. The key of the hash is the date it was ran, the value of the hash is an array with the passwords and its count wrapped in
a hash. This does not output an pie chart!

Saves output in: top_ten_daily_password.json

EX: {"09-11-2020":[{"admin":111,"1234":2,"p@ss@123":1,"1qaz2wsx!QAZ@WSX":1}]}

It shoud append the file each time it is ran.
DOES NOT OUTPUT A IMAGE. 

=end

Cowrie::TopTen.daily(File.join("cowrie_logs", "9-23-2020-cowrie.json"), "password", "cowrie.login.success")




################################