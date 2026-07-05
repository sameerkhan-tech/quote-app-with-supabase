import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_app_with_supabase/features/quote/model/quote_model.dart';
import 'package:quote_app_with_supabase/features/quote/view_model/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchQuotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes - that inspire'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            debugPrint(state.stateStatus.toString());
            debugPrint("error message - ${state.errorMessage}");
            if (state.isLoading && state.data.isEmpty) {
              return Center(
                child: const CircularProgressIndicator(color: Colors.black),
              );
            }

            if (state.isSuccess && state.data.isEmpty) {
              return const Center(child: Text('There are no quotes available'));
            }

            if (state.data.isNotEmpty) {
              return quotePageViewUi(state);
            }
            if (state.isFailure) {
              return errorUi(state, context);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  PageView quotePageViewUi(HomeState state) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: state.data.length,
      itemBuilder: (context, index) {
        final QuoteModel quote = state.data[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Text(
                  "\"${quote.quote}\"",
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.anybody(fontSize: 18),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "~  ${quote.author ?? 'Unknown'}",
                    maxLines: 2,
                    style: GoogleFonts.akayaTelivigala(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Center errorUi(HomeState state, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.errorMessage!, maxLines: 5),
          FilledButton(
            onPressed: () {
              context.read<HomeBloc>().add(FetchQuotes());
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
