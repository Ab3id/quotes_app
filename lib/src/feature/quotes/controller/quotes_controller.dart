import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app/src/feature/quotes/repository/quotes_repo.dart';
import 'package:quotes_app/src/models/quote.dart';

final quotesControllerProvider = ChangeNotifierProvider((ref) {
  final repo = ref.watch(quotesRepoProvider);
  return QuotesController(repo);
});

class QuotesController extends ChangeNotifier {
  final QuotesRepo _quotesRepo;

  QuotesController(this._quotesRepo);

  List<Quote>? quotes = [];

  int _currentIndex = 0;

  Future<List<Quote>?> getAllQuotes({BuildContext? context}) async {
    final result = await _quotesRepo.getQuotes();
    if (result.failure != null) {
      return null;
    }
    quotes = result.quotes;
    return result.quotes;
  }

  Quote getQuote() {
    return quotes![_currentIndex];
  }

  void changeCurrentIndex() {
    quotes!.length == _currentIndex ? _currentIndex = 0 : _currentIndex++;
    print('Current index changed $_currentIndex >>> ${getQuote().text}');
    notifyListeners();
  }
}
