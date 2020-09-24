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
