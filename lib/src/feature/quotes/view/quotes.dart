import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app/src/feature/quotes/controller/quotes_controller.dart';

class Quotes extends ConsumerStatefulWidget {
  const Quotes({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuotesState();
}

class _QuotesState extends ConsumerState<Quotes> {
  @override
  Widget build(BuildContext context) {
    final quotesController = ref.watch(quotesControllerProvider);
    return FutureBuilder(
      future: quotesController.getAllQuotes(context: context),
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Data Fetch Failed'),
          );
        }
//quotesController.getQuote().text
        if (snapshot.connectionState == ConnectionState.done) {
          if (data != null) {
            return Center(
              child: SizedBox(
                height: 300,
                width: 400,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          '${ref.watch(quotesControllerProvider).getQuote().text}')
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Error displaying data'),
            );
          }
        }

        return const Placeholder();
      },
    );
  }
}
