import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme.dart';
import '../../../core/responsive.dart';
import '../../auth/auth_provider.dart';
import '../appointments_provider.dart';

class DashboardContent extends ConsumerWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authProvider);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, userState.name),
          const SizedBox(height: 32),
          const DashboardGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String userName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'), // Sutil textura
          opacity: 0.05,
          alignment: Alignment.topRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hola, $userName',
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Bienvenida de vuelta',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontSize: Responsive.isMobile(context) ? 28 : 40,
                ),
              ),
            ],
          ),
          if (!Responsive.isMobile(context))
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white24,
              child: Text('ML', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return Responsive(
      mobile: _buildVerticalLayout(),
      desktop: _buildGridLayout(),
    );
  }

  Widget _buildGridLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            children: [
              const QuickActionsGrid(),
              const SizedBox(height: 32),
              const UpcomingAppointmentCard(),
            ],
          ),
        ),
        const SizedBox(width: 32),
        const Expanded(
          flex: 5,
          child: SideInfoCard(),
        ),
      ],
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      children: [
        const QuickActionsGrid(),
        const SizedBox(height: 24),
        const UpcomingAppointmentCard(),
        const SizedBox(height: 24),
        const SideInfoCard(),
      ],
    );
  }
}

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          _buildActionCard(
            context,
            "Agendar",
            "Nueva cita médica",
            Icons.calendar_add_on_outlined,
            AppColors.brandBlue,
            AppColors.brandBlueLight,
          ),
          const SizedBox(width: 20),
          _buildActionCard(
            context,
            "Análisis",
            "Ver mis resultados",
            Icons.clipboard_list_outlined,
            Colors.orange,
            Color(0xFFFFF7ED),
          ),
          if (constraints.maxWidth > 600) ...[
            const SizedBox(width: 20),
            _buildActionCard(
              context,
              "Historial",
              "Consultas anteriores",
              Icons.history,
              Colors.green,
              Color(0xFFF0FDF4),
            ),
          ]
        ],
      );
    });
  }

  Widget _buildActionCard(BuildContext context, String title, String subtitle, IconData icon, Color color, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.bgSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 24),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class UpcomingAppointmentCard extends ConsumerWidget {
  const UpcomingAppointmentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextAppointment = ref.watch(nextAppointmentProvider);
    
    if (nextAppointment == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.brandBlue, Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Próxima Cita',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(nextAppointment.status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(nextAppointment.doctorName, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
          Text(nextAppointment.specialty, style: const TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildInfoRow(Icons.calendar_today, nextAppointment.date),
                const SizedBox(height: 16),
                _buildInfoRow(Icons.location_on_outlined, nextAppointment.location),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class SideInfoCard extends StatelessWidget {
  const SideInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildListHeader("MIS MÉDICOS", "Ver todos"),
          const SizedBox(height: 20),
          _buildDoctorItem("Dr. Méndez", "Cardiólogo", "CM", Colors.blue, Color(0xFFEFF6FF)),
          _buildDoctorItem("Dra. Sosa", "Dermatóloga", "AS", Colors.orange, Color(0xFFFFF7ED)),
          _buildDoctorItem("Dr. Torres", "Pediatra", "IT", Colors.green, Color(0xFFECFDF5)),
          const SizedBox(height: 40),
          _buildListHeader("CERCA DE TI", ""),
          const SizedBox(height: 20),
          _buildPlaceItem("Centro Médico Central", "A 1.2 km", Icons.local_hospital_outlined),
        ],
      ),
    );
  }

  Widget _buildListHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 13, letterSpacing: 1.2, fontWeight: FontWeight.bold)),
        if (action.isNotEmpty)
          Text(action, style: const TextStyle(color: AppColors.brandBlue, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildDoctorItem(String name, String specialty, String initials, Color color, Color bgColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: bgColor,
            child: Text(initials, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text(specialty, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: AppColors.border),
        ],
      ),
    );
  }

  Widget _buildPlaceItem(String name, String distance, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.bgMain, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: AppColors.textMuted, size: 24),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text(distance, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
          ],
        ),
      ],
    );
  }
}
