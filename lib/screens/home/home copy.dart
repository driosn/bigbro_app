// import 'package:flutter/material.dart';
// import 'package:mibigbro/screens/home/contacto.dart';
// import 'package:mibigbro/screens/home/historial.dart';
// import 'package:mibigbro/screens/home/ofertas.dart';
// import 'package:mibigbro/screens/home/pagos.dart';
// import 'package:mibigbro/screens/home/pendientes.dart';
// import 'package:mibigbro/screens/login/login.dart';
// import 'package:mibigbro/utils/storage.dart';
// import 'inicio.dart';

// class Home extends StatefulWidget {
//   final String? title;

//   const Home({Key? key, this.title}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _selectedIndex = 0;
//   late String _title;

//   /*  List<Widget> _widgetOptions = <Widget>[
//     Inicio(irHistorial),
//     Historial(),
//     Ofertas(),
//     Contacto(),
//   ]; */

//   void irHistorial() {
//     print("ir historial");
//     setState(() {
//       _selectedIndex = 1;
//     });
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       switch (index) {
//         case 0:
//           {
//             _title = 'Inicio';
//           }
//           break;
//         case 1:
//           {
//             _title = 'Historial';
//           }
//           break;
//         case 2:
//           {
//             _title = 'Pendientes';
//           }
//           break;
//         case 3:
//           {
//             _title = 'Contacto';
//           }
//           break;
//       }
//     });
//   }

//   @override
//   initState() {
//     super.initState();
//     _title = 'Inicio';
//     StorageUtils.init();

//     //print(StorageUtils.getInteger('id_usuario'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff1D2766),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(_title),
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                 onTap: () {},
//                 child: Icon(
//                   Icons.notifications,
//                   size: 26.0,
//                 ),
//               )),
//           if (StorageUtils.getString('email') != "usertest@email.com")
//             Padding(
//                 padding: EdgeInsets.only(right: 20.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Pagos()),
//                     );
//                   },
//                   child: Image.asset(
//                     'assets/img/icon_pago.png',
//                     width: 30,
//                     fit: BoxFit.fitWidth,
//                   ),
//                 ))
//         ],
//       ),
//       body: Center(
//         child: [
//           Inicio(irHistorial),
//           Historial(),
//           Pendientes(),
//           Contacto(),
//         ].elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             title: Text('Inicio'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.content_paste),
//             title: Text('Historial'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.priority_high_outlined),
//             title: Text('Pendientes'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat_bubble_outline),
//             title: Text('Contacto'),
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Color(0xffE52121),
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
