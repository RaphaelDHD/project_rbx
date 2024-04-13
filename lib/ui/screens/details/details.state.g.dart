// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DetailsStateCWProxy {
  DetailsState isFavorite(bool isFavorite);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  DetailsState call({
    bool? isFavorite,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDetailsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDetailsState.copyWith.fieldName(...)`
class _$DetailsStateCWProxyImpl implements _$DetailsStateCWProxy {
  const _$DetailsStateCWProxyImpl(this._value);

  final DetailsState _value;

  @override
  DetailsState isFavorite(bool isFavorite) => this(isFavorite: isFavorite);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  DetailsState call({
    Object? isFavorite = const $CopyWithPlaceholder(),
  }) {
    return DetailsState(
      isFavorite:
          isFavorite == const $CopyWithPlaceholder() || isFavorite == null
              ? _value.isFavorite
              // ignore: cast_nullable_to_non_nullable
              : isFavorite as bool,
    );
  }
}

extension $DetailsStateCopyWith on DetailsState {
  /// Returns a callable class that can be used as follows: `instanceOfDetailsState.copyWith(...)` or like so:`instanceOfDetailsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DetailsStateCWProxy get copyWith => _$DetailsStateCWProxyImpl(this);
}
