import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
	const LoginScreen({super.key});

	@override
	State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
	final _formKey = GlobalKey<FormState>();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Column(
				mainAxisAlignment: MainAxisAlignment.spaceAround,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: [
					Form(
						key: _formKey,
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								const Text(
									'PPCINEMAS',
									textAlign: TextAlign.center,
									style: TextStyle(
										fontSize: 40,
										fontWeight: FontWeight.bold,
									),
								),
								Icon(
									Icons.movie_filter,
									color: Theme.of(context).primaryColor,
									size: 120,
								),
								const SizedBox(height: 60),
								const Text(
									'Inicia sesión',
									textAlign: TextAlign.center,
									style: TextStyle(
										fontSize: 30,
										fontWeight: FontWeight.bold,
									),
								),
								const SizedBox(height: 20),
								Padding(
									padding: const EdgeInsets.all(10.0),
									child: TextFormField(
										autocorrect: false,
										decoration: const InputDecoration(
											border: UnderlineInputBorder(),
											labelText: 'Correo electrónico'
										),
										validator: (String? value) {
											if (value!.trim().isEmpty
												|| !value.contains('@')
												|| !value.contains('.')
												|| value.length < 6) {
												return 'Correo electrónico inválido';
											}
											return null;
										},
									),
								),
								Padding(
									padding: const EdgeInsets.all(10.0),
									child: TextFormField(
										autocorrect: false,
										enableSuggestions: false,
										obscureText: true,
										decoration: const InputDecoration(
											border: UnderlineInputBorder(),
											labelText: 'Contraseña'
										),
										validator: (String? value) {
											if (value!.trim().isEmpty
												|| value.length < 6) {
												return 'Contraseña inválida';
											}
											return null;
										},
									),
								),
								ElevatedButton(
									onPressed: () {
										if (_formKey.currentState!.validate()) {
											showDialog<void>(
												context: context,
												barrierDismissible: false,
												builder: (BuildContext context) {
													return const AlertDialog(
														title: Text('Iniciando sesión...'),
														content: IntrinsicWidth(
															child: IntrinsicHeight(
																child: Center(
																	child: CircularProgressIndicator(),
																),
															),
														),
													);
												},
											);
											Future.delayed(const Duration(seconds: 3), () {
												Navigator.of(context).pop();	// closes the dialog
												
												context.go('/movie-selection');
											});
										}
									},
									style: ElevatedButton.styleFrom(
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(20.0),
										),
									),
									child: Container(
										padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
										child: const Text(
											'ENTRAR',
											textAlign: TextAlign.center,
										),
									),
								),
							],
						),
					),
					ElevatedButton(
						onPressed: () {
							context.go('/register');
						},
						style: ElevatedButton.styleFrom(
							backgroundColor: Colors.white,
							shape: RoundedRectangleBorder(
								borderRadius: BorderRadius.circular(20.0),
							),
						),
						child: Container(
							padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
							child: const Text(
								'REGISTRO',
								textAlign: TextAlign.center,
								style: TextStyle(
									color: Colors.black
								),
							),
						),
					),
				]
			),
		);
	}
}