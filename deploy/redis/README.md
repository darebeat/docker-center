```sh
docker exec -it redis sh
redis-cli -h 127.0.0.1 -p 6379 -a 123 --raw
set test 1
get test
```