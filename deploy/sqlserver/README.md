## README

1. 进入容器并连接数据库
```sh
docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U SA -P Mssql0173!
```

2. 数据库操作

```SQL
-- 查看所有数据库
SELECT Name FROM Master..SysDatabases ORDER BY Name
GO

-- 附加分离的数据库
exec sp_attach_db  @dbname =  'tb_test' ,  @filename1 =  '/opt/tb_test.mdf',  @filename2 =  '/opt/tb_test_log.ldf'
GO

```

3. 命令行执行代码

```sh
sqlcmd -S 127.0.0.1,1433 -U sa -P Mssql0173! -Q "CREATE DATABASE test; CREATE TABLE test(id int, name varchar(10));"
```

4. 修改SA密码

```sh
/opt/mssql-tools/bin/sqlcmd \
   -S localhost -U SA -P Mssql0173! \
   -Q 'ALTER LOGIN SA WITH PASSWORD="<YourNewStrong!Passw0rd>"'
```

4. [more information](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-overview?view=sql-server-2017)