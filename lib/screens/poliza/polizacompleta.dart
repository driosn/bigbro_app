import 'package:flutter/material.dart';
import 'package:mibigbro/screens/poliza/revision.dart';

class PolizaCompleta extends StatelessWidget {
  final appTitle = 'Póliza completa';
  @override
  static const TextStyle info = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);
  static const TextStyle titulo = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 20.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff1D2766), //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(appTitle, style: TextStyle(color: Color(0xff1D2766))),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: 50,
                          width: 240,
                          child: TextField(
                            decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff1D2766), width: 2.0),
                              ),
                              hintText: 'Buscar ...',
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.all(2),
                          width: 50,
                          child: TextButton(
                            // color: Color(0xff1D2766),
                            // textColor: Colors.white,
                            // disabledColor: Colors.grey,
                            // disabledTextColor: Colors.black,
                            // padding: EdgeInsets.all(8.0),
                            // splashColor: Colors.blueAccent,
                            onPressed: () {},
                            child: Icon(
                              Icons.search,
                              size: 25.0,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                  SizedBox(height: 30),
                  Text("Sección 1 de la Póliza",
                      style: titulo, textAlign: TextAlign.center),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet commodo nulla facilisi nullam. Consequat nisl vel pretium lectus quam id. Ipsum faucibus vitae aliquet nec ullamcorper sit amet risus nullam. Sociis natoque penatibus et magnis dis parturient montes. Viverra nibh cras pulvinar mattis nunc sed blandit libero volutpat. Dis parturient montes nascetur ridiculus mus mauris vitae ultricies. Eget gravida cum sociis natoque penatibus et. Suspendisse interdum consectetur libero id faucibus. Ipsum faucibus vitae aliquet nec ullamcorper sit. Bibendum at varius vel pharetra vel. Elementum tempus egestas sed sed risus pretium quam vulputate. At urna condimentum mattis pellentesque id nibh. Odio eu feugiat pretium nibh ipsum consequat.",
                            style: info,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Sección 2 de la Póliza",
                      style: titulo, textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet commodo nulla facilisi nullam. Consequat nisl vel pretium lectus quam id. Ipsum faucibus vitae aliquet nec ullamcorper sit amet risus nullam. Sociis natoque penatibus et magnis dis parturient montes. Viverra nibh cras pulvinar mattis nunc sed blandit libero volutpat. Dis parturient montes nascetur ridiculus mus mauris vitae ultricies. Eget gravida cum sociis natoque penatibus et. Suspendisse interdum consectetur libero id faucibus. Ipsum faucibus vitae aliquet nec ullamcorper sit. Bibendum at varius vel pharetra vel. Elementum tempus egestas sed sed risus pretium quam vulputate. At urna condimentum mattis pellentesque id nibh. Odio eu feugiat pretium nibh ipsum consequat.",
                            style: info,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        // color: Color(0xff1D2766),
                        // textColor: Colors.white,
                        // disabledColor: Colors.grey,
                        // disabledTextColor: Colors.black,
                        // padding: EdgeInsets.all(8.0),
                        // splashColor: Colors.blueAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RevisionPoliza()),
                          );
                        },
                        child: Text(
                          "Descargar",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      TextButton(
                        // color: Color(0xff1D2766),
                        // textColor: Colors.white,
                        // disabledColor: Colors.grey,
                        // disabledTextColor: Colors.black,
                        // padding: EdgeInsets.all(8.0),
                        // splashColor: Colors.blueAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RevisionPoliza()),
                          );
                        },
                        child: Text(
                          "Volver",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
