import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'modules/admin/pages/admin_dashboard_page.dart';
import 'modules/admin/pages/admin_finance_page.dart';
import 'modules/admin/pages/admin_plan_form_page.dart';
import 'modules/admin/pages/admin_plans_page.dart';
import 'modules/admin/pages/admin_users_page.dart';
import 'modules/appointments/pages/appointments_list_page.dart';
import 'modules/appointments/pages/client_create_appointment_page.dart';
import 'modules/appointments/pages/client_history_page.dart';
import 'modules/auth/pages/splash_page.dart';
import 'modules/auth/pages/login_page.dart';
import 'modules/auth/pages/forgot_password_page.dart';
import 'modules/barbershops/pages/barbershop_config_page.dart';
import 'modules/barbershops/pages/barbershop_details_page.dart';
import 'modules/home/pages/home_selector.dart';
import 'modules/home/pages/client_home_page.dart';
import 'modules/home/pages/barber_home_page.dart';
import 'modules/profile/pages/barber_profile_page.dart';
import 'modules/profile/pages/client_profile_page.dart';
import 'modules/profile/pages/plan_details_page.dart';
import 'modules/services/pages/list_services_page.dart';
import 'modules/services/pages/select_service_page.dart';
import 'modules/services/pages/service_form_page.dart';
import 'modules/appointments/pages/create_appointment_page.dart';
import 'modules/settings/pages/barber_settings_page.dart';

void main() {
  runApp(const MeuBarbeiroApp());
}

class MeuBarbeiroApp extends StatelessWidget {
  const MeuBarbeiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Barbeiro',
      theme: AppTheme.darkTheme,
      initialRoute: '/splash',
      routes: {
        // AUTH
        '/splash': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/forgot-password': (_) => const ForgotPasswordPage(),
        '/home': (_) => const HomeSelectorPage(),

        // BARBEIRO
        '/home-barber': (_) => const BarberHomePage(),
        '/services': (_) => const ListServicesPage(),
        '/service-form': (_) => const ServiceFormPage(),
        '/select-service': (_) => const SelectServicePage(),
        '/appointments': (_) => const AppointmentsListPage(),
        '/create-appointment': (_) => const CreateAppointmentPage(),
        '/profile': (_) => const BarberProfilePage(),
        '/plan-details': (_) => const PlanDetailsPage(),
        '/settings': (_) => const BarberSettingsPage(),
        '/barbershop-config': (_) => const BarbershopConfigPage(),

        // CLIENTE
        '/home-client': (_) => const ClientHomePage(),
        '/barbershop-details': (_) => const BarbershopDetailsPage(),
        '/client-create-appointment': (_) =>
            const ClientCreateAppointmentPage(),
        '/profile-client': (_) => const ClientProfilePage(),
        '/history-client': (_) => const ClientHistoryPage(),

        // ADMIN
        '/admin-home': (_) => const AdminDashboardPage(),
        '/admin-users': (_) => const AdminUsersPage(),
        '/admin-plans': (_) => const AdminPlansPage(),
        '/admin-plan-form': (_) => const AdminPlanFormPage(),
        '/admin-finance': (_) => const AdminFinancePage(),
      },
    );
  }
}
