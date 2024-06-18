import 'package:flutter/material.dart';

import 'drawer_list.dart';
import 'sidebar_footer.dart';
import 'sidebar_header.dart';
import 'sidebar_single_drawer_menu.dart';
import 'user_options.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SidebarHeader(),
          const UserOptions(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: kDrawerList
                      .map(
                        (drawer) => SidebarSingleDrawerMenu(
                          drawer: drawer,
                        ),
                      )
                      .toList(),
                ),
                const SidebarFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
