import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mibigbro/utils/key.dart' as utils;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Aviso', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
            // shape: new RoundedRectangleBorder(
            // borderRadius: new BorderRadius.circular(30.0)))
          ],
        );
      });
}

class DialogoProgreso {
  String? mensaje;
  late ProgressDialog pr;
  //static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  DialogoProgreso(BuildContext context, String mensaje) {
    this.mensaje = mensaje;
    this.pr = new ProgressDialog(context, isDismissible: true);

    this.pr.style(
        message: mensaje,
        borderRadius: 5.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 10.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));
  }

  mostrarDialogo() async {
    await this.pr.show();
  }

  ocultarDialogo() async {
    await this.pr.hide();
  }

  estadoDialogo() {
    this.pr.isShowing();
  }
}

class DialogDocument {
  static const String _urlDocumentBase = utils.Key.BASEURL_DOCUMENT;
  String launch(String nameDocument) {
    String nameDocEncod = base64Url.encode(utf8.encode(nameDocument));
    String urlDocument = _urlDocumentBase + nameDocEncod;
    return urlDocument;
  }
}
