import 'package:flutter/material.dart';
import '../../core/responsive.dart';
import '../../widgets/side_menu.dart';
import 'widgets/dashboard_content.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(), // Para el drawer en móvil
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mostramos el menú lateral solo en desktop
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            const Expanded(
              flex: 5,
              child: DashboardContent(),
            ),
          ],
        ),
      ),
    );
  }
}
