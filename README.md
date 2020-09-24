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
