# README

```SQL
CREATE DATABASE azkaban CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci'
create user 'azkaban'@'%' identified by 'azkaban';
grant all privileges on `azkaban`.* to `azkaban`@`%`;
flush privileges;
```

GRANT Alter ON `azkaban`.* TO `azkaban`@`%`;