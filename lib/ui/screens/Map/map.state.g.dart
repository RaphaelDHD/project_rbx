// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MapStateCWProxy {
  MapState places(PlaceEntity? places);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MapState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MapState(...).copyWith(id: 12, name: "My name")
  /// ````
  MapState call({
    PlaceEntity? places,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMapState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMapState.copyWith.fieldName(...)`
class _$MapStateCWProxyImpl implements _$MapStateCWProxy {
  const _$MapStateCWProxyImpl(this._value);

  final MapState _value;

  @override
  MapState places(PlaceEntity? places) => this(places: places);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MapState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MapState(...).copyWith(id: 12, name: "My name")
  /// ````
  MapState call({
    Object? places = const $CopyWithPlaceholder(),
  }) {
    return MapState(
      places: places == const $CopyWithPlaceholder()
          ? _value.places
          // ignore: cast_nullable_to_non_nullable
          : places as PlaceEntity?,
    );
  }
}

extension $MapStateCopyWith on MapState {
  /// Returns a callable class that can be used as follows: `instanceOfMapState.copyWith(...)` or like so:`instanceOfMapState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MapStateCWProxy get copyWith => _$MapStateCWProxyImpl(this);
}
