import 'package:flutter/material.dart';
import 'package:flutter_i18n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//        title: 'Flutter Demo',
        onGenerateTitle: (context) {
          return AppLocalizations.of(context).translate('text');
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),

        //Lista de todas los lenguajes soportados
        supportedLocales: kSupportedLocales,

        //Los delegates son los encargados de realizar las traducciones y demas ajustes para la localización de los widgets y textos
        localizationsDelegates: [
          //Encargado de las traducciones de los widgets por ejemplo el selector de fechas
          GlobalMaterialLocalizations.delegate,
          //Encargado de determinar la dirección del texto, de izquierda a oerecha o viceversa según sea necesario.
          GlobalWidgetsLocalizations.delegate,
          //Nuestro delegate
          AppLocalizations.delegate
        ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context);
    var aValue = 333.2232;

    var locale = Localizations.localeOf(context);
    var formatter = NumberFormat.simpleCurrency(locale: '${locale.languageCode}_${locale.countryCode}');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              l.translate('hello world'),
            ),
            SizedBox(height: 10,),
            Text(
              formatter.format(aValue)
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text(l.translate('pick a date')),
              onPressed: () {
                showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2021, 8));
              },
            )
          ],
        ),
      ),
    );
  }
}
