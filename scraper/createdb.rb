require 'sqlite3'

# Open a SQLite 3 database file
db = SQLite3::Database.new 'cs.db'

# Create a table
result = db.execute <<-SQL
  CREATE TABLE user (
    id VARCHAR(30),
    lastname VARCHAR(30),
    firstname VARCHAR(30),
    age INTEGER,
    created TEXT,
    modified TEXT,
    rating INTEGER,
    send_date TEXT,
    reply_date TEXT,
    city_id VARCHAR(30),
    photo BLOB,
    UNIQUE(id)
  );
SQL

result = db.execute <<-SQL2
  CREATE TABLE message  (
    id VARCHAR(30),
    userid VARCHAR(30),
    message TEXT,
    created TEXT,
    modified TEXT,
    to_me INTEGER,
    UNIQUE(id)
  );
SQL2

result = db.execute <<-SQL3
  CREATE TABLE city (
    id VARCHAR(30),
    name VARCHAR(50),
    CREATED TEXT,
    MODIFIED TEXT,
    UNIQUE(id)
  );
SQL3
