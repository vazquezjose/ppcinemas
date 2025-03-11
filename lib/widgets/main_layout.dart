import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
	final Widget child;
	final bool accountButton;

	const MainLayout({super.key, required this.child, this.accountButton = true});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.yellow,
				actions: accountButton ? [
					IconButton(
						icon: const Icon(Icons.account_circle),
						tooltip: 'Mi cuenta',
						onPressed: () => context.push('/my-account')
					),
				] : [],
			),
			body: child
		);
	}
}