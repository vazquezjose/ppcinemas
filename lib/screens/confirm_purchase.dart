import 'package:flutter/material.dart';

import '../services/info_provider.dart';
import '../widgets/back_next_button_set.dart';

class ConfirmPurchaseScreen extends StatefulWidget {
	final String movieId;
	final int branchId;
	final String movieFunction;
	final int adultTickets, childTickets;
	final List<String> seatNames;
	final List<(String, int)> products;

	final Function() onBackPressed;
	final Function() onNextPressed;

	const ConfirmPurchaseScreen({super.key, required this.movieId, required this.branchId, required this.movieFunction, required this.adultTickets, required this.childTickets, required this.seatNames, required this.products, required this.onBackPressed, required this.onNextPressed});

	@override
	State<ConfirmPurchaseScreen> createState() => _ConfirmPurchaseScreenState();
}

class _ConfirmPurchaseScreenState extends State<ConfirmPurchaseScreen> {
	num _getProductTotal() {
		num total = 0;
		for (var iteratedProduct in widget.products) {
			var (productId, quantity) = iteratedProduct;
			var product = InfoProvider.products.where((element) => element['id'] == productId).first;
			total += (product['price'] as num) * quantity;
		}
		total += widget.adultTickets * InfoProvider.adultTicketCost + widget.childTickets * InfoProvider.childTicketCost;
		return total;
	}

	List<String> _buildProductList() {
		List<String> result = [];
		for (var iteratedProduct in widget.products) {
			var (productId, quantity) = iteratedProduct;
			var product = InfoProvider.products.where((element) => element['id'] == productId).first;
			result.add('x$quantity ${product['name']}');
		}
		return result;
	}

	@override
	Widget build(BuildContext context) {
		var movie = InfoProvider.movies.where((element) => element['id'] == widget.movieId).first;
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				const Text(
					'Resumen de compra',
					textAlign: TextAlign.center,
					style: TextStyle(
						fontSize: 30,
						fontWeight: FontWeight.bold,
					),
				),
				const SizedBox(height: 10),
				Padding(
					padding: const EdgeInsets.all(8.0),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Image.asset(
								'images/${movie['poster'] as String}',
								height: 200,
							),
							SizedBox(
								width: MediaQuery.of(context).size.width / 2,
								child:Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Padding(
											padding: const EdgeInsets.symmetric(vertical: 10.0),
											child: Text(
												movie['title'] as String,
												style: const TextStyle(
													fontSize: 20,
													fontWeight: FontWeight.bold,
												),
											),
										),
										RichText(
											textAlign: TextAlign.left,
											text: TextSpan(
												children: [
													const TextSpan(
														text: 'Sucursal',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
													TextSpan(
														text: ': ${InfoProvider.branches[widget.branchId]}\n',
													),
													const TextSpan(
														text: 'Hora',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
													TextSpan(
														text: ': ${widget.movieFunction}\n',
													),
													const TextSpan(
														text: 'Asientos',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
													TextSpan(
														text: ': ${widget.seatNames.join(', ')}\n',
													),
													const TextSpan(
														text: 'Alimentos',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
													TextSpan(
														text: ':\n${_buildProductList().join('\n')}\n',
													),
													const TextSpan(
														text: 'Total',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
													TextSpan(
														text: ': \$${_getProductTotal()}',
													),
												]
											),
										),
									]
								),
							),
						]
					),
				),
				BackNextButtonSet(
					onBackPressed: () {
						widget.onBackPressed();
					},
					onNextPressed: () {
						widget.onNextPressed();
					},
					isFinalStage: true
				),
			]
		);
	}
}