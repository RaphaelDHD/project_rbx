// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dao_impl.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteDaoImplAdapter extends TypeAdapter<FavoriteDaoImpl> {
  @override
  final int typeId = 1;

  @override
  FavoriteDaoImpl read(BinaryReader reader) {
    return FavoriteDaoImpl();
  }

  @override
  void write(BinaryWriter writer, FavoriteDaoImpl obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteDaoImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
