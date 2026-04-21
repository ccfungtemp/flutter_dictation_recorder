import 'ui/add_dictation_screen.dart';
import 'ui/dictation_detail_screen.dart';
import 'ui/home_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const AddDictationScreen(),
        ),
        GoRoute(
          path: 'edit/:id',
          builder: (context, state) =>
              AddDictationScreen(dictationId: state.pathParameters['id']),
        ),
        GoRoute(
          path: 'dictation/:id',
          builder: (context, state) =>
              DictationDetailScreen(dictationId: state.pathParameters['id']!),
        ),
      ],
    ),
  ],
);
