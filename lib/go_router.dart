import 'package:future_hub_test/pages/create/create_page.dart';
import 'package:future_hub_test/pages/home/home_page.dart';
import 'package:future_hub_test/pages/update/update_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: "/home_page",
  routes: <RouteBase>[
    GoRoute(
      name: "/home_page",
      path: "/home_page",
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      name: "/update_page",
      path: "/update_page",
      builder: (context, state) {
        final Map<String, dynamic>? extraData =
        state.extra as Map<String, dynamic>?;
        final int appointmentId = extraData?['appointmentId'] ?? 'Unknown';
        return UpdatePage(
          appointmentId: appointmentId,
        );
      },
    ),
    GoRoute(
      name: "/create_page",
      path: "/create_page",
      builder: (context, state) {
        return const CreatePage();
      },
    ),

  ],
);
