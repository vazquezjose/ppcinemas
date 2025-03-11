import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'screens/account.dart';
import 'screens/checkout_process.dart';
import 'screens/movie_selection.dart';
import 'screens/login.dart';
import 'screens/register.dart';

void main() {
	runApp(const PpCinemasApp());
}

final GoRouter _router = GoRouter(
	routes: <RouteBase>[
		GoRoute(
			path: '/',
			builder: (BuildContext context, GoRouterState state) {
				return const LoginScreen();
			},
			routes: <RouteBase>[
				GoRoute(
					path: 'register',
					builder: (BuildContext context, GoRouterState state) {
						return const RegisterScreen();
					},
				),
				GoRoute(
					path: 'movie-selection',
					builder: (BuildContext context, GoRouterState state) {
						return const MovieSelectionScreen();
					},
				),
				GoRoute(
					path: 'my-account',
					builder: (BuildContext context, GoRouterState state) {
						return const AccountScreen();
					},
				),
				GoRoute(
					path: 'checkout/:movieId',
					builder: (BuildContext context, GoRouterState state) {
						return CheckoutProgressScreen(
							movieId: state.pathParameters['movieId']!,
						);
					},
				),
			],
		),
	],
);

class PpCinemasApp extends StatelessWidget {
	const PpCinemasApp({super.key});
	
	@override
	Widget build(BuildContext context) {
		return MaterialApp.router(
			title: 'PPCinemas',
			theme: ThemeData(
				colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
			),
			routerConfig: _router,
		);
	}
}