# Cowrie_ruby
Most current version

# Installing needed gems
```gem install gruff```


# Top Success

```
Cowrie::TopTen.success_both("9-23-2020-cowrie.json")
```
This method will output a piechart for both SUCCESS and FAILED login attemps.

```
Cowrie::TopTen.success_failed("cowrie-9-12-2020.json")
```
This method will output a piechart of the failed login attemps.
```
Cowrie::TopTen.success_success("9-23-2020-cowrie.json")
```
This method will output a piechart of the success login attemps.


# Commands
```
puts Cowrie::Commands.get_links("9-18-2020-cowrie.json")
```
This will get all the links that was entered.
```
Cowrie::Commands.get_commands("cowrie-9-11-2020.json")
```
This will get all the commands that was entered in the shell. 
```
Cowrie::Commands.all("cowrie-9-11-2020.json")
```
This method will get both the commands and the links and save it in one file

# Time
 ```
Cowrie::Time.date("9-23-2020-cowrie.json")
```
 This will method will create a json file with amount of successful login attemps for that day.
 ``` ```
 
# Top Password
```
Cowrie::TopTen.top_password("9-20-2020-cowrie.json")
```
WIll get the top ten passwords. Output a pie chart of the data as a image with the filename: 09-11-2020-Top Password.png".
By default it uses the event_id of "cowrie.login.success".

```
Cowrie::TopTen.daily("9-23-2020-cowrie.json", "password", "cowrie.login.success")
```
This method is like Cowrie::TopTen.top_password but this will save all the data each time it is ran into a single json formated file. The key is of the hash
is the date it was ran, the values of the hash is an array with the password and the amount of times it was used. 
This method will outputs a json file as 'top_ten_daily_password.json'. The "password" argument in the method can also take "username".  But unlike "Cowrie::TopTen.top_password" it does not output a pie chart.
