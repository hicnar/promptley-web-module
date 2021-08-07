import 'dart:async';

import '../web_request_handler.dart';

class RemoteHandler extends WebRequestHandler{

    static RemoteHandler _instance;
  RemoteHandler._();

  factory RemoteHandler() => _instance ?? (_instance = RemoteHandler._());

  @override
  FutureOr<dynamic> doGet(req, res) async {

    final remoteJson = {
      'title' : 'Webowy pilot zdalnego sterowania',
      'buttons' : {
        'web-button-0' : _buttonJson('digit-0', 'Start/Stop','', false),

        'web-button-1' : _buttonJson('digit-1', 'Następny Cue Punkt',
            'Skacze do następnego cue punktu lub przewija 75% ekranu w górę, jeśli w skrypcie nie ma zdefiniowanych cue punktów', true),

        'web-button-2' : _buttonJson('digit-2', 'Poprzedni Cue Punkt',
            'Skacze do poprzedniego cue punktu lub przewija 75% ekranu w dół, jeśli w skrypcie nie ma zdefiniowanych cue punktów', true),

        'web-button-3' : _buttonJson('digit-3', 'Zwiększ Prędkość',
            'Zwiększa prędkość o jeden punkt, albo przewija 10% ekranu w górę jeśli skrypt nie jest aktualnie odtwarzany', true, repeatKey: true),

        'web-button-4' : _buttonJson('digit-4', 'Zmniejsz Prędkość',
            'Zmniejsza prędkość o jeden punkt, albo przewija 10% ekranu w dół jeśli skrypt nie jest aktualnie odtwarzany', true, repeatKey: true),

        'web-button-5' : _buttonJson('digit-5', 'Skocz na Początek', '', false),

        'web-button-6' : _buttonJson('digit-6', 'Skocz na Koniec', '', false),
      },
      'sliders': {
        'seek' : {
          'min': -300,
          'max': 300,
          'value': 0,
          'step': 10
        },
        'speed' : {
          'min': 1,
          'max': 100,
          'value': 10,
          'step': 1
        }
      }
    };

    remoteJson['statusBox'] = {
      'message': "Aby przypisać akcje do pilota internetowego, w aplikacji przejdź do Ustawienia > Pilot, następnie najpierw wybierz akcję, po czym naciśnij przycisk na pilocie internetowym, do którego chcesz przypisać daną akcję.",
      'hint': "Wskazówka"
    };

    return res.render('remote', remoteJson);
  }

  Map<String, dynamic> _buttonJson(String action, String label, String tooltip, bool hasTooltip, {bool repeatKey = false}) => {
      'action': action,
      'label': label,
      'tooltip': tooltip,
      'hasTooltip': hasTooltip,
      'repeatKey': repeatKey
    };
}

