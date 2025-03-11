import 'package:flutter/material.dart';

class BackNextButtonSet extends StatefulWidget {
	final Function()? onBackPressed;
	final Function()? onNextPressed;
	final bool isFinalStage;

	const BackNextButtonSet({super.key, required this.onBackPressed, required this.onNextPressed, this.isFinalStage = false});

	@override
	State<BackNextButtonSet> createState() => _BackNextButtonSetState();
}

class _BackNextButtonSetState extends State<BackNextButtonSet> {
	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.all(12.0),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: [
					FilledButton(
						onPressed: widget.onBackPressed,
						child: const Text('Atrás')
					),
					FilledButton(
						onPressed: widget.onNextPressed,
						child: Text(
							widget.isFinalStage ? 'Finalizar compra'
							: 'Siguiente'
						)
					),
				]
			)
		);
	}
}