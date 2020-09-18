library firstacess;

import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstAcess {

  static const FIRST_ACESS   = 1;
  static const APP_UPDATE    = 2;

  static Future<int> getAcessInfo(String appKey) async {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

      final prefs = await _prefs;

      String keyFirstAcess = "acess-${appKey}";
      String keyVersionApp = "versionApp-${appKey}";
      String versionAppCurrent;

      await PackageInfo.fromPlatform().then((value) => versionAppCurrent = value.version);

      // Caso contenha a key (acess) o usuário já acessou o aplicativo.
      if(prefs.containsKey(keyFirstAcess)) {
        if(prefs.get(keyVersionApp) != versionAppCurrent) { // Se a versão salva no shared, for diferente da versão instalada.
          prefs.setString(keyVersionApp, versionAppCurrent);
          return APP_UPDATE;
        }
      } else { // Caso seja o primeiro acesso, cria a key e version app.
        prefs.setBool(keyFirstAcess, true);
        prefs.setString(keyVersionApp, versionAppCurrent);
        return FIRST_ACESS;
      }
  }
}
