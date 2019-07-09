# _MySQL_ OMG Microservice

[![Open Microservice Guide](https://img.shields.io/badge/OMG%20Enabled-👍-green.svg?)](https://microservice.guide)

Interact with a MySQL database.

## Direct usage in [Storyscript](https://storyscript.io/):

### Create table
```coffee
mysql createTable table: 'books' columns: {
  'id': 'serial primary key',
  'title': 'varchar(100)'
}
```

### Insert an entry
```coffee
mysql insert table: 'books' values: {'title': 'Ulysses'}
# result: [1, 'Ulysses']
```

### Insert multiple entries
```coffee
mysql insert table: 'books' values: [{'title': 'Moby Dick'}, {'title': 'War and Peace'}]
# result: [[2, 'Ulysses'], [3, 'War and Peace']]
```

### Select entries
- `$and` and `$or` can be used to combine queries
- `$lt`, `$lte`, `$gt`, `$gte` and `$eq` can be used as comparison operators
- if no comparison operators is provided, the query will match on equality

```coffee
mysql select table: 'books' where: {'title': 'Moby Dick'}
# result: [[2, 'Moby Dick']
```

```coffee
mysql select table: 'books' where: {'$or': {title: 'Moby Dick', 'id': {'$lt': 2}}}
# result: [[1, 'Ulysses'], [2, 'Moby Dick']]
```

### Update entries
```coffee
mysql update table: 'books' values: {'title': 'UPDATED'} where: {'id': {'$gt': 2}}
# result: [[3, 'UPDATED']]
```

The where query is optional, but without it _all_ columns will be updated:
```coffee
mysql update table: 'books' values: {'title': 'UPDATED'}
# result: [
#     [1, 'Ulysses'],
#     [2, 'Ulysses'],
#     [3, 'War and Peace']
# ]
```

### Delete entries
`delete` uses a `where` select query and will return the deleted columns:
```coffee
mysql delete table: 'books' where: {'title': 'Moby Dick'}
# result: [[2, 'Moby Dick']]
```
The where query is optional, but without it _all_ columns will be deleted.

### Drop table
An entire table can be dropped with `drop_table`:
```coffee
mysql dropTable table: 'books'
```

### Execute
```coffee
result = mysql exec query: 'select * from my_table where name=%(username)s' data: {'username': 'jill'}
# result is an array, with records as JSON objects inside it.
```

Curious to [learn more](https://docs.storyscript.io/)?

✨🍰✨

## Usage with [OMG CLI](https://www.npmjs.com/package/omg)

### Create table
```shell
$ omg run createTable -a table=<TABLE> -a columns=<MAP_OF_COLUMNS> -e MYSQL_HOST=<MYSQL_HOST> -e MYSQL_USER=<MYSQL_USER> -e MYSQL_PASSWORD=<MYSQL_PASSWORD> -e MYSQL_DATABASE=<MYSQL_DATABASE> -e MYSQL_PORT=<MYSQL_PORT>
```
### Insert an entry
```shell
$ omg run insert -a table=<TABLE> -a values=<LIST_OF_MAP_VALUES> -e MYSQL_HOST=<MYSQL_HOST> -e MYSQL_USER=<MYSQL_USER> -e MYSQL_PASSWORD=<MYSQL_PASSWORD> -e MYSQL_DATABASE=<MYSQL_DATABASE> -e MYSQL_PORT=<MYSQL_PORT>
```
### Select entries
```shell
$ omg run select -a table=<TABLE> -a where=<PARAMETERS_TO_FILTER> -e MYSQL_HOST=<MYSQL_HOST> -e MYSQL_USER=<MYSQL_USER> -e MYSQL_PASSWORD=<MYSQL_PASSWORD> -e MYSQL_DATABASE=<MYSQL_DATABASE> -e MYSQL_PORT=<MYSQL_PORT>
```
### Update entries
```shell
$ omg run update -a table=<TABLE> -a values=<LIST_OF_MAP_VALUES> -a where=<PARAMETERS_TO_FILTER> -e MYSQL_HOST=<MYSQL_HOST> -e MYSQL_USER=<MYSQL_USER> -e MYSQL_PASSWORD=<MYSQL_PASSWORD> -e MYSQL_DATABASE=<MYSQL_DATABASE> -e MYSQL_PORT=<MYSQL_PORT>
```
### Delete entries
```shell
$ omg run delete -a table=<TABLE> -a where=<PARAMETERS_TO_FILTER> -e MYSQL_HOST=<MYSQL_HOST> -e MYSQL_USER=<MYSQL_USER> -e MYSQL_PASSWORD=<MYSQL_PASSWORD> -e MYSQL_DATABASE=<MYSQL_DATABASE> -e MYSQL_PORT=<MYSQL_PORT>
```
### Drop table
```shell
$ omg run dropTable -a table=<TABLE> -e MYSQL_HOST=<MYSQL_HOST> -e MYSQL_USER=<MYSQL_USER> -e MYSQL_PASSWORD=<MYSQL_PASSWORD> -e MYSQL_DATABASE=<MYSQL_DATABASE> -e MYSQL_PORT=<MYSQL_PORT>
```
### Execute
```shell
$ omg run exec -a query=<QUERY> -a data=<MAP_DATA> -e MYSQL_HOST=<MYSQL_HOST> -e MYSQL_USER=<MYSQL_USER> -e MYSQL_PASSWORD=<MYSQL_PASSWORD> -e MYSQL_DATABASE=<MYSQL_DATABASE> -e MYSQL_PORT=<MYSQL_PORT>
```

**Note**: The OMG CLI requires [Docker](https://docs.docker.com/install/) to be installed.

## License
[MIT License](https://github.com/omg-services/mysql/blob/master/LICENSE).
