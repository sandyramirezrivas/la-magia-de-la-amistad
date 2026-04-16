import 'package:flutter/material.dart';
import '../core/theme.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: AppColors.bgSurface,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Icon(Icons.bolt, color: AppColors.brandBlue, size: 32),
                const SizedBox(width: 12),
                Text(
                  'MedCentral',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.brandBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: ListView(
              children: [
                DrawerListTile(
                  title: "Inicio",
                  icon: Icons.dashboard_outlined,
                  press: () {},
                  isActive: true,
                ),
                DrawerListTile(
                  title: "Citas",
                  icon: Icons.calendar_today_outlined,
                  press: () {},
                ),
                DrawerListTile(
                  title: "Análisis",
                  icon: Icons.assignment_outlined,
                  press: () {},
                ),
                DrawerListTile(
                  title: "Médicos",
                  icon: Icons.people_outline,
                  press: () {},
                ),
                DrawerListTile(
                  title: "Notificaciones",
                  icon: Icons.notifications_none_outlined,
                  press: () {},
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.border, height: 1),
          DrawerListTile(
            title: "Configuración",
            icon: Icons.settings_outlined,
            press: () {},
          ),
          DrawerListTile(
            title: "Cerrar Sesión",
            icon: Icons.logout_outlined,
            press: () {},
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
    this.isActive = false,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: isActive ? AppColors.brandBlue : AppColors.textMuted,
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? AppColors.brandBlue : AppColors.textMuted,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      tileColor: isActive ? AppColors.brandBlueLight : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
