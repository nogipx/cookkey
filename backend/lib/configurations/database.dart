import 'package:angel_framework/angel_framework.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Db> configureDatabase({Angel app}) async {
  final db = await Db.create(
    "mongodb+srv://nogipx:D916YsuhHrIAl4Lt@nogipx-mongo-cluster.bgkud.mongodb.net/cookkey_prod",
  );
  await db.open();
  return db;
}
