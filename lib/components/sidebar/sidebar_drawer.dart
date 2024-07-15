import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
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
          FadeInUp(
            duration: const Duration(milliseconds: 300),
            child: const SidebarHeader(),
          ),
          FadeInUp(
            duration: const Duration(milliseconds: 400),
            child: const UserOptions(),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: kDrawerList
                      .mapIndexed(
                        (index, drawer) => SidebarSingleDrawerMenu(
                          drawer: drawer,
                          index: index,
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
