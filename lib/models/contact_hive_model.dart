import 'package:hive/hive.dart';
part 'contact_hive_model.g.dart';
@HiveType(typeId: 0)
class ContactHiveModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String number;

  ContactHiveModel(this.id, this.name, this.number);
}
