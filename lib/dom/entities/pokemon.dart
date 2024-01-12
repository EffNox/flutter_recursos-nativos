import 'package:isar/isar.dart';

part 'pokemon.g.dart';

@collection
class Pokemon {
  final Id idX = Isar.autoIncrement;

  final int id;
  final String name;
  final String springFront;

  Pokemon({required this.id, required this.name, required this.springFront});
}
