import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app_with_supabase/app.dart';
import 'package:quote_app_with_supabase/core/constants/env.dart';
import 'package:quote_app_with_supabase/features/quote/data/datasources/quote_remote_datasource_impl.dart';
import 'package:quote_app_with_supabase/features/quote/data/repositories/quote_repository_impl.dart';
import 'package:quote_app_with_supabase/features/quote/view_model/home_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Env.supabaseUrl,
    publishableKey: Env.publishableKey,
  );
  runApp(
    BlocProvider(
      create: (context) =>
          HomeBloc(QuoteRepositoryImpl(QuotesRemoteDatasourceImpl())),
      child: const MainApp(),
    ),
  );
}


