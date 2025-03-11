import 'package:flutter/material.dart';

import '../services/info_provider.dart';
import '../widgets/back_next_button_set.dart';
import '../widgets/quantity_button_set.dart';

class SnackScreen extends StatefulWidget {
	final Function() onBackPressed;
	final Function(List<(String, int)>) onNextPressed;

	const SnackScreen({super.key, required this.onBackPressed, required this.onNextPressed});

	@override
	State<SnackScreen> createState() => _SnackScreenState();
}

class _SnackScreenState extends State<SnackScreen> with AutomaticKeepAliveClientMixin<SnackScreen> {
	final List<(String, int)> _products = [];

	@override
	bool get wantKeepAlive => true;

	@override
	Widget build(BuildContext context) {
		super.build(context);
		return Scaffold(
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: [
					const Padding(
						padding: EdgeInsets.all(12.0),
						child: Text(
							'¿Algo para acompañar?',
							style: TextStyle(
								fontSize: 30,
								fontWeight: FontWeight.w900,
							),
						)
					),
					Flexible(
						flex: 2,
						child: GridView.builder(
							gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
								crossAxisCount: 2,
								crossAxisSpacing: 4.0,
								mainAxisSpacing: 4.0,
							),
							itemCount: InfoProvider.products.length,
							itemBuilder: (BuildContext context, int index) {
								var product = InfoProvider.products[index];
								return Column(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										SizedBox(
											height: 50,
											width: 50,
											child: Image.asset(
												'images/${product['image']}',
												fit: BoxFit.fitHeight
											),
										),
										Text(
											product['name'] as String,
											style: const TextStyle(
												fontSize: 15,
												fontWeight: FontWeight.w600
											),
											textAlign: TextAlign.center,
										),
										Text(
											'\$${product['price']}',
											style: const TextStyle(
												fontSize: 15,
												fontWeight: FontWeight.w600
											),
											textAlign: TextAlign.center,
										),
										QuantityButtonSet(
											onQuantityChanged: (int quantity) {
												var element = _products.where(((String, int) element) {
													var (id, __previousQuantity) = element;
													return product['id'] == id;
												}).firstOrNull;
												if (element != null) {
													var index = _products.indexOf(element);
													if (quantity == 0) {
														_products.removeAt(index);
													}
													else {
														_products[index] = (element.$1, quantity);
													}
												}
												else {
													_products.add((product['id'] as String, quantity));
												}
											}
										),
									],
								);
							}
						)
					),
					Flexible(
						flex: 1,
						child: BackNextButtonSet(
							onBackPressed: widget.onBackPressed,
							onNextPressed: () => widget.onNextPressed(_products)
						)
					)
				],
			),
		);
	}
}