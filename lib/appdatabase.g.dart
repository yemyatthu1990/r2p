// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appdatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CategoryDao? _categoryDaoInstance;

  SubCategoryDao? _subCategoryDaoInstance;

  DetailDao? _detailDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `Category` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SubCategory` (`id` TEXT NOT NULL, `icon` TEXT NOT NULL, `name` TEXT NOT NULL, `catId` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Detail` (`id` TEXT NOT NULL, `catSubCatId` TEXT NOT NULL, `image` TEXT NOT NULL, `body` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  SubCategoryDao get subCategoryDao {
    return _subCategoryDaoInstance ??=
        _$SubCategoryDao(database, changeListener);
  }

  @override
  DetailDao get detailDao {
    return _detailDaoInstance ??= _$DetailDao(database, changeListener);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'Category',
            (Category item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  @override
  Future<List<Category>> getAllCategories() async {
    return _queryAdapter.queryList('SELECT * FROM Category',
        mapper: (Map<String, Object?> row) =>
            Category(row['id'] as String, row['name'] as String));
  }

  @override
  Stream<List<Category>> getAllCategoriesAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Category',
        mapper: (Map<String, Object?> row) =>
            Category(row['id'] as String, row['name'] as String),
        queryableName: 'Category',
        isView: false);
  }

  @override
  Stream<Category?> getCategoryById(String id) {
    return _queryAdapter.queryStream('SELECT * FROM Category WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Category(row['id'] as String, row['name'] as String),
        arguments: [id],
        queryableName: 'Category',
        isView: false);
  }

  @override
  Future<void> insertCategory(Category category) async {
    await _categoryInsertionAdapter.insert(category, OnConflictStrategy.abort);
  }
}

class _$SubCategoryDao extends SubCategoryDao {
  _$SubCategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _subCategoryInsertionAdapter = InsertionAdapter(
            database,
            'SubCategory',
            (SubCategory item) => <String, Object?>{
                  'id': item.id,
                  'icon': item.icon,
                  'name': item.name,
                  'catId': item.catId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SubCategory> _subCategoryInsertionAdapter;

  @override
  Stream<List<SubCategory>> getSubCategoriesAsStream(String catId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM SubCategory WHERE catId = ?1',
        mapper: (Map<String, Object?> row) => SubCategory(
            row['id'] as String,
            row['icon'] as String,
            row['name'] as String,
            row['catId'] as String),
        arguments: [catId],
        queryableName: 'SubCategory',
        isView: false);
  }

  @override
  Future<void> insertSubCategory(SubCategory subCategory) async {
    await _subCategoryInsertionAdapter.insert(
        subCategory, OnConflictStrategy.abort);
  }
}

class _$DetailDao extends DetailDao {
  _$DetailDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _detailInsertionAdapter = InsertionAdapter(
            database,
            'Detail',
            (Detail item) => <String, Object?>{
                  'id': item.id,
                  'catSubCatId': item.catSubCatId,
                  'image': item.image,
                  'body': item.body
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Detail> _detailInsertionAdapter;

  @override
  Future<Detail?> getDetail(String catSubCatId) async {
    return _queryAdapter.query('SELECT * FROM Detail WHERE catSubCatId = ?1',
        mapper: (Map<String, Object?> row) => Detail(
            row['id'] as String,
            row['catSubCatId'] as String,
            row['image'] as String,
            row['body'] as String),
        arguments: [catSubCatId]);
  }

  @override
  Future<void> insertDetail(Detail detail) async {
    await _detailInsertionAdapter.insert(detail, OnConflictStrategy.abort);
  }
}
