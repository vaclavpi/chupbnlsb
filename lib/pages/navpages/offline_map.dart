import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class OfflineMapController {
  late DefaultCacheManager _cacheManager;

  OfflineMapController() {
    _cacheManager = DefaultCacheManager();
  }

  Future<void> downloadMapTiles() async {
    // implementujte kód pro stahování mapových dlaždic
  }

  Future<void> waitForTilesDownloaded() async {
    // implementujte kód pro čekání na dokončení stahování dlaždic
  }
}
