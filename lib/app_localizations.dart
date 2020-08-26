import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Lenguajes soportados
const kSupportedLocales = [
    Locale('en', 'US'),
    Locale('es', 'ES'),
  Locale('ja', 'JP')
];

class AppLocalizations {

  final Locale _locale;
  Map<String, dynamic> _localizedMessages = Map();

  AppLocalizations(this._locale);

  static AppLocalizations of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations);

  static LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  //Esta función se encarga de cargar nuestro json a memoria, para que este disponible para las traducciones
  Future<void> loadMessages() async {
    String jsonMessages;

    try {
      jsonMessages = await rootBundle.loadString("assets/lang/${_locale.languageCode}.json");
    } catch (_) {
      //Hacemos algo con el error.
      jsonMessages = await rootBundle.loadString("assets/lang/es.json");
    }

    //Decodificamos el json a mapa
    _localizedMessages = json.decode(jsonMessages);
  }

  //Esta función busca una traducción en los mensajes y la regresa
  String translate(String key) {
    if (_localizedMessages.containsKey(key)) {
      return _localizedMessages[key];
    } else {
      var value = key;
      assert(() {
        value = 'Missing $key';
        return true;
      } ());

      return value;
    }
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {

  //La funcion determina que locales son soportados por el delegate
  @override
  bool isSupported(Locale locale) {
    try {
      kSupportedLocales.firstWhere((element) => element.languageCode == locale.languageCode);
      return true;
    } catch(_) {}

    return false;
  }

  //La funcion carga y devuelve la localizacion a la que responde el delegate
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.loadMessages();

    return appLocalizations;
  }

  //Si debe o no recargar la localizacion
  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;

}