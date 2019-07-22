# Scripts Execution Instructions

## Export group ruts

First go to loomio-deploy folder in the deploy server 
(https://asamblea.revoluciondemocratica.cl) 
```bash
cd /home/loomio-deploy
```
Once in there execute 
rails console

```bash
docker-compose run loomio rails c
```
In rails load the export_group_ruts.rb from the script 
folder

```ruby
#Dir.entries('.')
#Dir.entries('./script')
load './script/export_group_ruts.rb'
#Dir.entries('.')
```
The script will create a comma separated file (csv) named
data.csv in the project root folder. This file need to be copy
to the public folder to serve it in the web page

```ruby
FileUtils.mv('./data.csv', './public/system/asistencias_DDMMYYY.csv')
```

Now you can download the file at the url: 
https://asamblea.revoluciondemocratica.cl/system/asistencias_DDMMYYY.csv

