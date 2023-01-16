import 'package:flutter/material.dart';
import 'package:mibigbro/screens/home/contacto.dart';
import 'package:mibigbro/screens/home/historial.dart';
import 'package:mibigbro/screens/home/ofertas.dart';
import 'package:mibigbro/screens/home/pagos.dart';
import 'package:mibigbro/screens/home/pendientes.dart';
import 'package:mibigbro/screens/login/login.dart';
import 'package:mibigbro/utils/storage.dart';
import 'package:mibigbro/widgets/bottom_navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'inicio.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Home extends StatefulWidget {
  final String? title;

  const Home({Key? key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late String _title;

  /*  List<Widget> _widgetOptions = <Widget>[
    Inicio(irHistorial),
    Historial(),
    Ofertas(),
    Contacto(),
  ]; */

  void irHistorial() {
    print("ir historial");
    setState(() {
      _selectedIndex = 1;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        _launchLlamada();
        return;
      }

      _selectedIndex = index;
    });
  }

  _launchLlamada() async {
    const url = "tel:800103070";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  initState() {
    super.initState();
    _title = 'Inicio';
    StorageUtils.init();

    //print(StorageUtils.getInteger('id_usuario'));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Color(0xff1D2766),
          //   automaticallyImplyLeading: false,
          //   centerTitle: true,
          //   title: Text(_title),
          //   actions: <Widget>[
          //     Padding(
          //         padding: EdgeInsets.only(right: 20.0),
          //         child: GestureDetector(
          //           onTap: () {},
          //           child: Icon(
          //             Icons.notifications,
          //             size: 26.0,
          //           ),
          //         )),
          //     if (StorageUtils.getString('email') != "usertest@email.com")
          //       Padding(
          //           padding: EdgeInsets.only(right: 20.0),
          //           child: GestureDetector(
          //             onTap: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(builder: (context) => Pagos()),
          //               );
          //             },
          //             child: Image.asset(
          //               'assets/img/icon_pago.png',
          //               width: 30,
          //               fit: BoxFit.fitWidth,
          //             ),
          //           ))
          //   ],
          // ),
          body: Center(
            child: [
              Inicio(
                irHistorial,
                onTapIndex: _onItemTapped,
              ),
              Historial(),
              Container(),
              Pendientes(),
              Contacto(),
            ].elementAt(_selectedIndex),
          ),
          // bottomNavigationBar: BottomNavigationBarCustom(),
          // bottomNavigationBar: ConvexAppBar(
          //   height: 80,
          //   style: TabStyle.fixedCircle,
          //   backgroundColor: Theme.of(context).primaryColor,
          //   activeColor: Colors.white,
          //   color: Colors.white,
          //   items: [
          //     TabItem(icon: Icons.home, title: 'Home'),
          //     TabItem(icon: Icons.content_paste, title: 'Historial'),
          //     TabItem(
          //       icon: Icons.call,
          //       activeIcon: Icon(
          //         Icons.call,
          //         color: Color(0xffEC1C24),
          //         size: 38,
          //       ),
          //       title: 'Add',
          //     ),
          //     TabItem(icon: Icons.priority_high_outlined, title: 'Pendientes'),
          //     TabItem(icon: Icons.message, title: 'Contacto'),
          //   ],
          //   onTap: _onItemTapped,
          // ),
          bottomNavigationBar: Container(
            height: 80,
            width: double.infinity,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.content_paste),
                  label: 'Historial',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.priority_high_outlined,
                    color: Colors.transparent,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.priority_high_outlined),
                  label: 'Pendientes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  label: 'Contacto',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 40,
          bottom: 20,
          child: GestureDetector(
            onTap: () {
              _onItemTapped(2);
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 10,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.call,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
