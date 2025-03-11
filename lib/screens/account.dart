import 'package:flutter/material.dart';

import '../services/info_provider.dart';
import '../widgets/main_layout.dart';

class AccountScreen extends StatefulWidget {
	const AccountScreen({super.key});

	@override
	State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
	@override
	Widget build(BuildContext context) {
		return MainLayout(
			accountButton: false,
			child: Column(
				children: [
					Column(
						children: [
							CircleAvatar(
								backgroundColor: Theme.of(context).primaryColor,
								radius: 90,
								child: const Text(
									'NA',
									style: TextStyle(
										fontSize: 60
									),
								)
							),
							const Padding(
								padding: EdgeInsets.all(12.0),
								child: Text(
									'Nombre Apellido',
									style: TextStyle(
										fontWeight: FontWeight.bold,
										fontSize: 30
									),
								)
							)
						]
					),
					const Padding(
						padding: EdgeInsets.all(6.0),
						child: Align(
							alignment: Alignment.centerLeft,
							child: Text(
								'Historial de compras',
								textAlign: TextAlign.left,
								style: TextStyle(
									fontSize: 25
								),
							),
						),
					),
					Expanded(
						child: ListView.builder(
							shrinkWrap: true,
							itemCount: InfoProvider.movies.length,
							itemBuilder: (BuildContext context, int index) {
								return Card(
									child: SizedBox(
										width: MediaQuery.of(context).size.width * 0.9,
										child: Padding(
											padding: const EdgeInsets.all(8.0),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceBetween,
												children: [
													Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: [
															Padding(
																padding: const EdgeInsets.symmetric(vertical: 8.0),
																child: Text(
																	InfoProvider.movies[index]['title'] as String,
																	style: const TextStyle(
																		fontWeight: FontWeight.w500
																	),
																),
															),
															const Text('x1 Entrada (Adulto)'),
														],
													),
													Image.asset(
														'images/qr-code.png',
														height: 50,
														width: 50,
													)
												],
											)
										)
									)
								);
							}
						),
					)
			  	],
			),
		);
	}
}