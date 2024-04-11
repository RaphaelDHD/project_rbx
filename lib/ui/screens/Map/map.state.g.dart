// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MapStateCWProxy {
  MapState places(PlaceEntity? places);

  MapState markers(List<MarkerEntity> markers);

  MapState selectedMarker(MarkerEntity? selectedMarker);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MapState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MapState(...).copyWith(id: 12, name: "My name")
  /// ````
  MapState call({
    PlaceEntity? places,
    List<MarkerEntity>? markers,
    MarkerEntity? selectedMarker,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMapState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMapState.copyWith.fieldName(...)`
class _$MapStateCWProxyImpl implements _$MapStateCWProxy {
  const _$MapStateCWProxyImpl(this._value);

  final MapState _value;

  @override
  MapState places(PlaceEntity? places) => this(places: places);

  @override
  MapState markers(List<MarkerEntity> markers) => this(markers: markers);

  @override
  MapState selectedMarker(MarkerEntity? selectedMarker) =>
      this(selectedMarker: selectedMarker);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MapState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MapState(...).copyWith(id: 12, name: "My name")
  /// ````
  MapState call({
    Object? places = const $CopyWithPlaceholder(),
    Object? markers = const $CopyWithPlaceholder(),
    Object? selectedMarker = const $CopyWithPlaceholder(),
  }) {
    return MapState(
      places: places == const $CopyWithPlaceholder()
          ? _value.places
          // ignore: cast_nullable_to_non_nullable
          : places as PlaceEntity?,
      markers: markers == const $CopyWithPlaceholder() || markers == null
          ? _value.markers
          // ignore: cast_nullable_to_non_nullable
          : markers as List<MarkerEntity>,
      selectedMarker: selectedMarker == const $CopyWithPlaceholder()
          ? _value.selectedMarker
          // ignore: cast_nullable_to_non_nullable
          : selectedMarker as MarkerEntity?,
    );
  }
}

extension $MapStateCopyWith on MapState {
  /// Returns a callable class that can be used as follows: `instanceOfMapState.copyWith(...)` or like so:`instanceOfMapState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MapStateCWProxy get copyWith => _$MapStateCWProxyImpl(this);
}
