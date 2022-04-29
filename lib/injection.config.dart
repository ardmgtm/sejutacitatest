// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/data_source/api_data_source.dart' as _i3;
import 'data/data_source/cache_data_source.dart' as _i4;
import 'data/repository/search_repository_impl.dart' as _i7;
import 'domain/repository/search_repository.dart' as _i6;
import 'presentation/bloc/search/search_bloc.dart' as _i9;
import 'presentation/bloc/search_mode/search_mode_bloc.dart' as _i5;
import 'presentation/bloc/view_mode/view_mode_bloc.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ApiDataSource>(() => _i3.ApiDataSource());
  gh.lazySingleton<_i4.CacheDataSource>(() => _i4.CacheDataSource());
  gh.factory<_i5.SearchModeBloc>(() => _i5.SearchModeBloc());
  gh.lazySingleton<_i6.SearchRepository>(() => _i7.SearchRepositoryImpl(
      get<_i3.ApiDataSource>(), get<_i4.CacheDataSource>()));
  gh.factory<_i8.ViewModeBloc>(() => _i8.ViewModeBloc());
  gh.factory<_i9.SearchBloc>(() => _i9.SearchBloc(get<_i6.SearchRepository>()));
  return get;
}
