# Asyncy MySQL

Interact with a MySQL database.

Examples
-------

### Create table

A table can be created with `create_table`:

```coffee
# Storyscript
mysql create_table table: 'books' columns: {
  'id': 'serial primary key',
  'title': 'varchar(100)'
}
```

### Insert an entry

```coffee
# Storyscript
mysql insert table: 'books' values: {'title': 'Ulysses'}
# result: [1, 'Ulysses']
```

### Insert multiple entries

```coffee
# Storyscript
mysql insert table: 'books' values: [{'title': 'Moby Dick'}, {'title': 'War and Peace'}]
# result: [[2, 'Ulysses'], [3, 'War and Peace']]
```

### Select entries

- `$and` and `$or` can be used to combine queries
- `$lt`, `$lte`, `$gt`, `$gte` and `$eq` can be used as comparison operators
- if no comparison operators is provided, the query will match on equality

```coffee
# Storyscript
mysql select table: 'books' where: {'title': 'Moby Dick'}
# result: [[2, 'Moby Dick']
```

```coffee
# Storyscript
mysql select table: 'books' where: {'$or': {title: 'Moby Dick', 'id': {'$lt': 2}}}
# result: [[1, 'Ulysses'], [2, 'Moby Dick']]
```

### Update entries

```coffee
# Storyscript
mysql update table: 'books' values: {'title': 'UPDATED'} where: {'id': {'$gt': 2}}
# result: [[3, 'UPDATED']]
```

The where query is optional, but without it _all_ columns will be updated:

```coffee
# Storyscript
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
# Storyscript
mysql delete table: 'books' where: {'title': 'Moby Dick'}
# result: [[2, 'Moby Dick']]
```

The where query is optional, but without it _all_ columns will be deleted.

### Drop table

An entire table can be dropped with `drop_table`:

```coffee
# Storyscript
mysql drop_table table: 'books'
```

### Execute

```storyscript
# Storyscript
result = mysql exec query: 'select * from my_table where name=%(username)s' data: {'username': 'jill'}
# result is an array, with records as JSON objects inside it.
```
