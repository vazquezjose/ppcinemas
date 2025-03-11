import 'package:flutter/material.dart';

import '../services/info_provider.dart';
import '../widgets/back_next_button_set.dart';
import '../widgets/quantity_button_set.dart';

class MovieSeatAmountSelectionScreen extends StatefulWidget {
	final Function() onBackPressed;
	final Function(int, int) onNextPressed;

	const MovieSeatAmountSelectionScreen({super.key, required this.onBackPressed, required this.onNextPressed});

	@override
	State<MovieSeatAmountSelectionScreen> createState() => _MovieSeatAmountSelectionScreenState();
}

class _MovieSeatAmountSelectionScreenState extends State<MovieSeatAmountSelectionScreen> with AutomaticKeepAliveClientMixin<MovieSeatAmountSelectionScreen> {
	int adultTickets = 0, childTickets = 0;

	@override
	bool get wantKeepAlive => true;

	@override
	Widget build(BuildContext context) {
		super.build(context);
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					const Text(
						'Selecciona tus boletos',
						style: TextStyle(
							fontSize: 30,
							fontWeight: FontWeight.w900,
						),
					),
					Padding(
						padding: const EdgeInsets.all(16.0),
						child: Container(
							color: const Color.fromARGB(255, 233, 233, 233),
							padding: const EdgeInsets.all(4.0),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: [
									const Text(
										'Adulto',
										style: TextStyle(
											fontSize: 30,
											fontWeight: FontWeight.w600
										),
									),
									const Text(
										'\$${InfoProvider.adultTicketCost}',
										style: TextStyle(
											fontSize: 30,
										),
									),
									QuantityButtonSet(
										onQuantityChanged: (int quantity) {
											setState(() {
												adultTickets = quantity;
											});
										}
									),
								],
							),
						),
					),
					Padding(
						padding: const EdgeInsets.all(16.0),
						child: Container(
							color: const Color.fromARGB(255, 233, 233, 233),
							padding: const EdgeInsets.all(4.0),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: [
									const Text(
										'Menor',
										style: TextStyle(
											fontSize: 30,
											fontWeight: FontWeight.w600
										),
									),
									const Text(
										'\$${InfoProvider.childTicketCost}',
										style: TextStyle(
											fontSize: 30,
										),
									),
									QuantityButtonSet(
										onQuantityChanged: (int quantity) {
											setState(() {
												childTickets = quantity;
											});
										}
									),
								],
							),
						),
					),
					BackNextButtonSet(
						onBackPressed: () {
							widget.onBackPressed();
						},
						onNextPressed: (adultTickets + childTickets) > 0 ? () {
							widget.onNextPressed(adultTickets, childTickets);
						} : null
					),
				],
			),
		);
	}
}