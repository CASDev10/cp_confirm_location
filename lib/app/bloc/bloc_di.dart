import 'package:cp_confirm_location/modules/dashboard/cubit/confirm_location/confirm_location_cubit.dart';
import 'package:cp_confirm_location/modules/dashboard/cubit/order_detail/order_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/service_locator.dart';
import '../../modules/dashboard/cubit/current_location/current_location_cubit.dart';
import '../../modules/dashboard/cubit/geocoding/geocoding_cubit.dart';
import '../../modules/dashboard/repositories/current_location_repository.dart';

class BlocDI extends StatelessWidget {
  const BlocDI({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => CurrentLocationCubit(CurrentLocationRepository()),
        ),
        BlocProvider(
          create: (context) => GeocodingCubit(CurrentLocationRepository()),
        ),
        BlocProvider(create: (context) => OrderDetailCubit(sl())),
        BlocProvider(create: (context) => UpdateLocationCubit(sl())),
      ],
      child: child,
    );
  }
}
