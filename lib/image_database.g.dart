// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorImageDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ImageDatabaseBuilder databaseBuilder(String name) =>
      _$ImageDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ImageDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ImageDatabaseBuilder(null);
}

class _$ImageDatabaseBuilder {
  _$ImageDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ImageDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ImageDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ImageDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ImageDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ImageDatabase extends ImageDatabase {
  _$ImageDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ImageDao? _imageDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Image` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `key` TEXT NOT NULL, `url` TEXT NOT NULL, `relativePath` TEXT NOT NULL, `eTag` TEXT NOT NULL, `validTill` REAL NOT NULL, `touched` REAL NOT NULL, `length` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ImageDao get imageDao {
    return _imageDaoInstance ??= _$ImageDao(database, changeListener);
  }
}

class _$ImageDao extends ImageDao {
  _$ImageDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _imageInsertionAdapter = InsertionAdapter(
            database,
            'Image',
            (Image item) => <String, Object?>{
                  'id': item.id,
                  'key': item.key,
                  'url': item.url,
                  'relativePath': item.relativePath,
                  'eTag': item.eTag,
                  'validTill': item.validTill,
                  'touched': item.touched,
                  'length': item.length
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Image> _imageInsertionAdapter;

  @override
  Future<Image?> getImage(String key) async {
    return _queryAdapter.query('SELECT * FROM Image WHERE key = ?1',
        mapper: (Map<String, Object?> row) => Image(
            row['id'] as int?,
            row['key'] as String,
            row['url'] as String,
            row['relativePath'] as String,
            row['eTag'] as String,
            row['validTill'] as double,
            row['touched'] as double,
            row['length'] as int),
        arguments: [key]);
  }

  @override
  Future<void> insertImage(Image image) async {
    await _imageInsertionAdapter.insert(image, OnConflictStrategy.abort);
  }
}
