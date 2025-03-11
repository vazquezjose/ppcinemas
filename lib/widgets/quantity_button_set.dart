import 'package:flutter/material.dart';

class QuantityButtonSet extends StatefulWidget {
	final Function(int) onQuantityChanged;

	const QuantityButtonSet({super.key, required this.onQuantityChanged});

	@override
	State<QuantityButtonSet> createState() => _QuantityButtonSetState();
}

class _QuantityButtonSetState extends State<QuantityButtonSet> {
	static const _minQuantity = 0;

	int _quantity = 0;

	@override
	Widget build(BuildContext context) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				IconButton(
					onPressed: () {
						if (_quantity > _minQuantity) {
							setState(() {
								_quantity--;
							});
							widget.onQuantityChanged(_quantity);
						}
					},
					icon: Icon(
						Icons.remove_circle,
						color: _quantity > _minQuantity ? Theme.of(context).primaryColor : Colors.grey,
						size: 30,
					)
				),
				Padding(
					padding: const EdgeInsets.all(15.0),
					child: Text(
						_quantity.toString(),
						style: const TextStyle(
							fontSize: 30,
							fontWeight: FontWeight.bold
						),
					),
				),
				IconButton(
					onPressed: () {
						setState(() {
							_quantity++;
						});
						widget.onQuantityChanged(_quantity);
					},
					icon: Icon(
						Icons.add_circle,
						color: Theme.of(context).primaryColor,
						size: 30,
					)
				),
			],
		);
	}
}