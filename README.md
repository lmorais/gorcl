# GORCL
GORCL is an app example running on Docker that connects to an Oracle database 


## Running
To get this app example up and running is too simple. Follow bellow steps:

```shell
$ git clone git@github.com:lmorais/gorcl.git
$ cd gorcl
$ docker build -t gorcl .
$ docker run -e DB_USER=<YOUR-DB-USER> -e DB_PASSWD=<YOUR-DB-PASSWORD> -e DB_HOST=<YOUR-DB-HOST> -it --rm gorcl
```