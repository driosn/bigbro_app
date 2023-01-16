import 'package:flutter/material.dart';
import 'onboard3.dart';

class Onboard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D2766),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                'assets/img/onboard2.png',
                width: 250,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Fácil, rápido y seguro",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Nunca antes que tu automóvil este protegido  fue tan sencillo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff9ED1FF),
                  ),
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 36,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Onboard3()),
                  );
                },
                child: Text(
                  "Siguiente",
                  style: TextStyle(color: Color(0xff1D2766)),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xff1D2766),
      body: Center(
        child: Padding(
            padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/img/onboard2.png',
                    width: 150,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Cuando más lo necesites",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  TextButton(
                    // color: Color(0xff9ED1FF),
                    // textColor: Color(0xff1D2766),
                    // disabledColor: Colors.grey,
                    // disabledTextColor: Colors.black,
                    // padding: EdgeInsets.all(8.0),
                    // splashColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Onboard3()),
                      );
                    },
                    child: Text(
                      "Siguiente",
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Adquiere el paquete de días que más te conviene.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  )
                ])),
      ),
    );
  }
}
