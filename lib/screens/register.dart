import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
	const RegisterScreen({super.key});

	@override
	State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
	final _formKey = GlobalKey<FormState>();
	DateTime _selectedDate = DateTime.now();

	Future<void> _selectDate(BuildContext context) async {
		final DateTime? picked = await showDatePicker(
			context: context,
			initialDate: _selectedDate,
			firstDate: DateTime(1900),
			lastDate: DateTime.now(),
		);
		if (picked != null && picked != _selectedDate) {
			setState(() {
				_selectedDate = picked;
			});
		}
	}

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
									'Registro',
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
										keyboardType: TextInputType.text,
										inputFormatters: [
											FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
										],
										decoration: const InputDecoration(
											border: UnderlineInputBorder(),
											labelText: 'Nombre(s)'
										),
										validator: (String? value) {
											if (value!.trim().isEmpty
												|| value.length < 2
												|| !RegExp(r'^[a-zA-Z\s]*$').hasMatch(value)) {
												return 'Nombre inválido';
											}
											return null;
										},
									)
								),
								Padding(
									padding: const EdgeInsets.all(10.0),
									child: TextFormField(
										autocorrect: false,
										keyboardType: TextInputType.text,
										inputFormatters: [
											FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
										],
										decoration: const InputDecoration(
											border: UnderlineInputBorder(),
											labelText: 'Apellido(s)'
										),
										validator: (String? value) {
											if (value!.trim().isEmpty
												|| value.length < 2
												|| !RegExp(r'^[a-zA-Z\s]*$').hasMatch(value)) {
												return 'Apellido inválido';
											}
											return null;
										},
									)
								),
								Padding(
									padding: const EdgeInsets.all(10.0),
									child: TextFormField(
										autocorrect: false,
										keyboardType: TextInputType.number,
										inputFormatters: [
											FilteringTextInputFormatter.digitsOnly
										],
										decoration: const InputDecoration(
											border: UnderlineInputBorder(),
											labelText: 'Número de teléfono'
										),
										validator: (String? value) {
											if (value!.trim().isEmpty
												|| value.length < 10) {
												return 'Número de teléfono inválido';
											}
											return null;
										},
									)
								),
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
									)
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
									)
								),
								GestureDetector(
									onTap: () => _selectDate(context),
									child: Padding(
										padding: const EdgeInsets.all(10.0), // same padding of the TextFormField or else their rendering messes up
										child: Container(
											padding: const EdgeInsets.all(10.0),
											decoration: BoxDecoration(
												border: Border.all(color: Colors.grey),
												borderRadius: BorderRadius.circular(5.0),
											),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													const Text('Fecha de nacimiento'),
													const SizedBox(
														height: 6
													),
													Row(
														children: [
															const Icon(Icons.calendar_today),
															const SizedBox(
																width: 10
															),
															Text(
																'${_selectedDate.toLocal()}'.split(' ')[0],
																style: const TextStyle(
																	fontSize: 16
																),
															),
														],
													)
												]
											)
										)
									)
								),
								ElevatedButton(
									onPressed: () {
										if (_formKey.currentState!.validate()) {
											showDialog<void>(
												context: context,
												barrierDismissible: false,
												builder: (BuildContext context) {
													return const AlertDialog(
														title: Text('Registrando...'),
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
												// closes the dialog
												Navigator.of(context).pop();
												
												// goes back to the previous screen
												Navigator.of(context).pop();
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
											'REGISTRARME',
											textAlign: TextAlign.center,
										)
									)
								),
							],
						)
					),
				]
			),
		);
	}
}