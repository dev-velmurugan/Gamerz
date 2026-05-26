import 'package:flutter/foundation.dart';
import '../data/models/game_model.dart';
import '../data/services/api_service.dart';

enum GameStatus { initial, loading, loaded, error }

class GameProvider extends ChangeNotifier {
  final ApiService _apiService;

  GameStatus _status = GameStatus.initial;
  List<MatchModel> _matches = [];
  String? _errorMessage;
  double _walletBalance = 200.0;

  GameProvider({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  GameStatus get status => _status;
  List<MatchModel> get matches => _matches;
  String? get errorMessage => _errorMessage;
  double get walletBalance => _walletBalance;
  bool get isLoading => _status == GameStatus.loading;

  Future<void> loadMatches({String? category}) async {
    _status = GameStatus.loading;
    notifyListeners();

    try {
      final data = await _apiService.getMatches(category: category);
      _matches = data
          .map((json) => MatchModel.fromJson(json))
          .toList();
      _status = GameStatus.loaded;
      _errorMessage = null;
    } catch (e) {
      _status = GameStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  Future<void> loadWalletBalance() async {
    try {
      final data = await _apiService.getWalletBalance();
      _walletBalance = (data['balance'] as num).toDouble();
      notifyListeners();
    } catch (_) {}
  }

  // Game categories
  List<Map<String, dynamic>> get gameCategories => [
        {'icon': '🃏', 'label': 'Card', 'route': '/card'},
        {'icon': '⚽', 'label': 'Sports', 'route': '/sports'},
        {'icon': '🎰', 'label': 'Lottery', 'route': '/lottery'},
        {'icon': '🎲', 'label': 'Casino', 'route': '/casino'},
        {'icon': '🐎', 'label': 'Horse', 'route': '/horse-racing'},
      ];

  List<Map<String, dynamic>> get pureLuckGames => [
        {'label': 'Game 01', 'title': 'More Slots', 'badge': 'HOT'},
        {'label': 'Game 02', 'title': 'E-Gaming', 'badge': 'NEW'},
        {'label': 'Game 03', 'title': 'Marbles Lobby', 'badge': null},
        {'label': 'Game 04', 'title': 'Play Now', 'badge': 'LIVE'},
        {'label': 'Game 05', 'title': 'Winfinity', 'badge': null},
        {'label': 'Game 06', 'title': 'Asia Gaming', 'badge': null},
        {'label': 'Game 07', 'title': 'Ezugi', 'badge': null},
        {'label': 'Game 08', 'title': 'Vivo Gaming', 'badge': null},
      ];
}
