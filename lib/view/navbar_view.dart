import 'package:chanda_finance/res/components/app_url.dart';
import 'package:chanda_finance/utils/constants.dart';
import 'package:chanda_finance/utils/routes_name.dart';
import 'package:chanda_finance/view_model/auth_view_model.dart';
import 'package:chanda_finance/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(loginName),
            accountEmail: const Text("chandafinanceco@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: GestureDetector(
                // get tap location
                onTap: () {
                  Navigator.of(context).pushNamed(
                    'profilepic',
                  );
                },
                child: ClipOval(
                  child: Image.asset(logoSrc,
                      width: 100, height: 100, fit: BoxFit.cover),
                ),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/profilebg.jpg'), fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => {
              // Pushing a named route
              // Navigator.of(context).pushAndRemoveUntil(RoutesName.home);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesName.home, (Route route) => false)
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text("Cash Entry"),
            onTap: () => {
              // Pushing a named route
              Navigator.pushNamed(
                context,
                RoutesName.createCashEntry,
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text("Daybook"),
            onTap: () => {Navigator.of(context).pushNamed('daybook')},
          ),

          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Creditors"),
            onTap: () =>
                {Navigator.of(context).pushNamed('creditorslist_view')},
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_sharp),
            title: const Text("Ledger"),
            onTap: () => {
              Navigator.pushNamed(context, RoutesName.ledgerView,
                  arguments: ["0", "0", "0", "0"])
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favourites"),
            onTap: () => {Navigator.of(context).pushNamed('lastpayments')},
          ),

          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Change Theme"),
            onTap: () => {Navigator.of(context).pushNamed('themechanger_view')},
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Sign Up"),
            onTap: () => {Navigator.of(context).pushNamed('signup')},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Request"),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: const Center(
                  child: Text(
                    "8",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () => Navigator.pushNamed(context, RoutesName.settings),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Log out"),
            onTap: () {
              Provider.of<UserViewModel>(context, listen: false).remove();
              Navigator.of(context).pushReplacementNamed(
                RoutesName.login,
                // arguments: 'Hello there from the first page!',
              );
            },
          ),
          // ),
        ],
      ),
    );
  }
}
