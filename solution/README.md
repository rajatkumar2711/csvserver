# infracloudio-csvserver
Developer of csvserver team

PART 1 :
=====
- docker run -p 9393:9300 --rm -it infracloudio/csvserver:latest bash

```
[root@c910af780f9e csvserver]# cat > gencsv.sh
#!/bin/bash
if [ -f "inputFile" ]; then
  rm -rf inputFile
fi
for ((i=0 ; i < $1 ; i++))
do
   echo "$i, $RANDOM" >> inputFile
done
```

- chmod -R 755 inputFile

- ./gencsv.sh 10

- cp inputFile /csvserver/inputdata

- export CSVSERVER_BORDER=Orange

- ./csvserver
```
[root@c910af780f9e csvserver]# ./csvserver
2021/12/20 13:00:31 listening on ****
```

- curl localhost:9300

- curl -o ./part-1-output http://localhost:9393/raw

```
$ cat part-1-output
Y3N2c2VydmVyIGdlbmVyYXRlZCBhdDogMTY0MDAwNTM3MQ==
CSVSERVER_BORDER: Orange
0,  25471
1,  10976
2,  871
3,  31626
4,  19685
5,  27033
6,  19122
7,  1320
8,  9464
9,  12155
```

- docker logs c910af780f9e >& part-1-logs

```
$ cat part-1-logs
[root@c910af780f9e csvserver]# cat > gencsv.sh
#!/bin/bash
if [ -f "inputFile" ]; then
  rm -rf inputFile
fi
for ((i=0 ; i < $1 ; i++))
do
   echo "$i, $RANDOM" >> inputFile
done

chmod -R 755 inputFile
^C
[root@c910af780f9e csvserver]#
[root@c910af780f9e csvserver]#
[root@c910af780f9e csvserver]# chmod 755 gencsv.sh
[root@c910af780f9e csvserver]# ./gencsv.sh 10
[root@c910af780f9e csvserver]# cp inputFile /csvserver/inputdata
[root@c910af780f9e csvserver]# export CSVSERVER_BORDER=Orange
[root@c910af780f9e csvserver]# ./csvserver
2021/12/20 13:20:25 listening on ****
```

PART 2 :
=====
```
$ cat docker-compose.yml
version: "3.9"
services:
  csvserver:
    build: .
    ports:
      - "9393:9300"
```

```
$ cat Dockerfile
FROM infracloudio/csvserver:latest
COPY gencsv.sh gencsv.sh
RUN ./gencsv.sh 10
ENV CSVSERVER_BORDER=Orange
EXPOSE 9300
CMD ["./csvserver"]
```

PART 3 :
=====
```
$ cat docker-compose.yml
version: "3.9"
services:
  csvserver:
    build: .
    ports:
      - "9393:9300"
  prom:
    image: prom/prometheus:v2.22.0
    ports:
      - "9090:9090"
```
-  curl localhost:9090
