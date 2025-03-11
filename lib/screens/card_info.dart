import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/back_next_button_set.dart';

class CardInfoScreen extends StatefulWidget {
	final Function() onBackPressed;
	final Function() onNextPressed;

	const CardInfoScreen({super.key, required this.onBackPressed, required this.onNextPressed});

	@override
	State<CardInfoScreen> createState() => _CardInfoScreenState();
}

class _CardInfoScreenState extends State<CardInfoScreen> with AutomaticKeepAliveClientMixin<CardInfoScreen> {
	final _formKey = GlobalKey<FormState>();

	@override
	bool get wantKeepAlive => true;

	@override
	Widget build(BuildContext context) {
		super.build(context);
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				Form(
					key: _formKey,
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							const Text(
								'Ingresa tu información de pago',
								textAlign: TextAlign.center,
								style: TextStyle(
									fontSize: 30,
									fontWeight: FontWeight.bold,
								),
							),
							const SizedBox(height: 10),
							Padding(
								padding: const EdgeInsets.all(10.0),
								child: TextFormField(
									maxLength: 19,
									keyboardType: const TextInputType.numberWithOptions(
										signed: false,
										decimal: false
									),
									inputFormatters: [
										FilteringTextInputFormatter.digitsOnly,
										LengthLimitingTextInputFormatter(19),
										CreditCardNumberInputFormatter(),
									],
									decoration: const InputDecoration(
										border: UnderlineInputBorder(),
										prefixIcon: Icon(Icons.credit_card),
										labelText: 'Número de tarjeta',
										counterText: ""		// hides character counter
									),
									validator: (String? value) {
										if (value!.trim().isEmpty || value.length < 19) {
											return 'Número de tarjeta inválido';
										}
										return null;
									},
								),
							),
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Expanded(
										flex: 4,
										child: Padding(
											padding: const EdgeInsets.all(10.0),
											child: TextFormField(
												maxLength: 5,
												keyboardType: const TextInputType.numberWithOptions(
													signed: false,
													decimal: false
												),
												inputFormatters: [
													FilteringTextInputFormatter.digitsOnly,
													LengthLimitingTextInputFormatter(5),
													DateInputFormatter(),
												],
												decoration: const InputDecoration(
													border: UnderlineInputBorder(),
													prefixIcon: Icon(Icons.event),
													labelText: 'Mes y año de vencimiento',
													counterText: ""		// hides character counter
												),
												validator: (String? value) {
													if (value!.trim().isEmpty || value.length < 5) {
														return 'Fecha de vencimiento inválida';
													}
													return null;
												},
											),
										),
									),
									Expanded(
										flex: 3,
										child: Padding(
											padding: const EdgeInsets.all(10.0),
											child: TextFormField(
												maxLength: 3,
												decoration: const InputDecoration(
													border: UnderlineInputBorder(),
													prefixIcon: Icon(Icons.lock),
													labelText: 'CVV',
													counterText: ""		// hides character counter
												),
												validator: (String? value) {
													if (value!.trim().isEmpty
														|| value.length < 3) {
														return 'CVV inválido';
													}
													return null;
												},
											)
										),
									),
								]
							),
							BackNextButtonSet(
								onBackPressed: () {
									widget.onBackPressed();
								},
								onNextPressed: () {
									if (_formKey.currentState!.validate()) {
										widget.onNextPressed();
									}
								}
							),
						]
					)
				),
			]
		);
	}
}

class CreditCardNumberInputFormatter extends TextInputFormatter {
	@override
	TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
		// remove non-digit characters, just to make sure it's a valid input
		final cleanText = newValue.text.replaceAll(RegExp(r'\D'), '');

		String formattedText = '';
		for (int i = 0; i < cleanText.length; i++) {
			if (i > 0 && i % 4 == 0) {
				formattedText += ' ';	// adds a space after every fourth character
			}
			formattedText += cleanText[i];
		}

		return TextEditingValue(
			text: formattedText,
			selection: TextSelection.collapsed(offset: formattedText.length),
		);
	}
}

class DateInputFormatter extends TextInputFormatter {
	@override
	TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
		// remove non-digit characters, just to make sure it's a valid input
		final cleanText = newValue.text.replaceAll(RegExp(r'\D'), '');

		String formattedText = '';
		for (int i = 0; i < cleanText.length; i++) {
			if ((i == 2 || i == 4) && i < 5) {
				formattedText += '/';	// adds a slash after the second character of the month and year
			}
			formattedText += cleanText[i];
		}

		return TextEditingValue(
			text: formattedText,
			selection: TextSelection.collapsed(offset: formattedText.length),
		);
	}
}