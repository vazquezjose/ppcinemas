import 'package:flutter/material.dart';

import '../services/info_provider.dart';
import '../widgets/back_next_button_set.dart';

class MovieSeatSelectionScreen extends StatefulWidget {
	final int totalSeats;
	final Function() onBackPressed;
	final Function(List<String>) onNextPressed;

	const MovieSeatSelectionScreen({super.key, required this.totalSeats, required this.onBackPressed, required this.onNextPressed});

	@override
	State<MovieSeatSelectionScreen> createState() => _MovieSeatSelectionScreenState();
}

class _MovieSeatSelectionScreenState extends State<MovieSeatSelectionScreen> with AutomaticKeepAliveClientMixin<MovieSeatSelectionScreen> {
	/*
	static const int seatsPerRow = 9;
	static const int seatRows = 10;

	List<String> _selectedSeatNames = [];

	static int _getSeatRowNumber(int seatIndex) => seatIndex ~/ seatsPerRow;

	static String _getAlphabetLetterFromIndex(int index) => String.fromCharCode(_getSeatRowNumber(index) + 65);

	static List<String> _getSortedSeatNames(List<String> seatNames) {
		var newList = List<String>.from(seatNames);	// clones the list to avoid modifying the original one
		// having respect for the original list is essential because of the autoremoving first selected seat feature
		newList.sort((a, b) => a.compareTo(b));	// sorts alphabetically
		return newList;
	}
	*/

	static String _getAlphabetLetterFromIndex(int index) => String.fromCharCode(index + 65);

	final List<(int, int)> _selectedSeats = [];

	static List<String> _getSortedSeats(List<(int, int)> seatNames) {
		List<(int, int)> newList = List.from(seatNames);	// clones the list to avoid modifying the original one
		// having respect for the original list is essential because of the autoremoving first selected seat feature
		newList.sort(
			((int, int) a, (int, int) b) {
				return (a.$1 + a.$2).compareTo(b.$1 + b.$2);
			}
		);	// sorts by order

		List<String> result = [];

		for ((int, int) seat in newList) {
			result.add(_getAlphabetLetterFromIndex(seat.$1) + seat.$2.toString());
		}
		return result;
	}

	@override
	bool get wantKeepAlive => true;

	Widget _buildFunctionSeats() {
		final functionSeatsInfo = InfoProvider.functionSeats;

		List<List<Widget>> rows = [];

		for (int rowIndex = 0; rowIndex < functionSeatsInfo.length; rowIndex++) {
			final rowString = functionSeatsInfo[rowIndex];

			final rowName = _getAlphabetLetterFromIndex(rowIndex);

			List<Widget> rowWidgets = [
				SizedBox(
					width: 50,
					height: 50,
					child: FittedBox(
						child: Center(
							child: Text(rowName)
						)
					)
				),
			];

			for (int seatIndex = 0; seatIndex < rowString.length; seatIndex++) {
				final seatIdentifier = rowString[seatIndex];

				final seat = (rowIndex, seatIndex+1);

				Widget seatWidget;

				switch (seatIdentifier) {
					case 'A':
						// regular seat
						seatWidget = Container(
							height: 50,
							width: 50,
							margin: const EdgeInsets.all(5.0),
							child: FittedBox(
								child: Icon(
									_selectedSeats.contains(seat) ? Icons.chair : Icons.chair_outlined,
									color: _selectedSeats.contains(seat) ? Theme.of(context).primaryColor : Colors.grey,
								),
							)
						);
						break;
					case 'X':
						// occupied seat
						seatWidget = Container(
							height: 50,
							width: 50,
							margin: const EdgeInsets.all(5.0),
							child: const FittedBox(
								child: Icon(
									Icons.chair,
									color: Colors.black,
								),
							)
						);
						break;
					case 'W':
						// wheelchair
						seatWidget = Container(
							height: 50,
							width: 50,
							margin: const EdgeInsets.all(5.0),
							decoration: BoxDecoration(
								border: Border.all(
									color: Colors.black,
									width: 2.0
								),
								borderRadius: BorderRadius.circular(10.0),
								color: _selectedSeats.contains(seat) ? Theme.of(context).primaryColor : Colors.blue,
							),
							child: const FittedBox(
								child: Icon(
									Icons.accessible,
									color: Colors.white,
								)
							)
						);
						break;
					case 'O':
					default:
						// space
						seatWidget = Container(
							height: 50,
							width: 50,
							margin: const EdgeInsets.all(5.0),
						);
						break;
				}

				rowWidgets.add(
					GestureDetector(
						onTap: () {
							if (seatIdentifier == 'A' || seatIdentifier == 'W') {	// if the seat is unoccupied...
								setState(() {
									if (_selectedSeats.contains(seat)) {
										_selectedSeats.remove(seat);
									}
									else {
										if (_selectedSeats.length >= widget.totalSeats) {
											_selectedSeats.removeAt(0);	// remove the first selected seat
										}
										_selectedSeats.add(seat);
									}
								});
							}
						},
						child: seatWidget
					)
				);
			}
			rows.add(rowWidgets);
		}
		return FittedBox(
			child: Column(
				children: [
					for (List<Widget> row in rows)
						Row(children: row)
				]
			)
		);
	}
	
	@override
	Widget build(BuildContext context) {
		super.build(context);
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				const Padding(
					padding: EdgeInsets.all(12.0),
					child: Text(
						'Selecciona tus asientos',
						style: TextStyle(
							fontSize: 30,
							fontWeight: FontWeight.w900,
						),
					)
				),
				
				const Text('PANTALLA'),

				// seat rows
				Padding(
					padding: const EdgeInsets.all(12.0),
					child: Expanded(
						child: InteractiveViewer(
							child: _buildFunctionSeats()
						)
					)
				),
				/*
				InteractiveViewer(
					child: GridView.count(
						shrinkWrap: true,
						crossAxisCount: seatsPerRow,	// seats per row
						children: List.generate(seatRows * seatsPerRow,	// total seats
							(int index) {
								String rowName = _getAlphabetLetterFromIndex(index);

								if (index % seatsPerRow == 0) {	// is it the first element of the row? if so,
									return Center(
										child: Text(rowName),	// letter row indicator
									);
								}
								else {
									int columnIndex = index - _getSeatRowNumber(index) * seatsPerRow;
									String seatName = rowName + columnIndex.toString();
									return GestureDetector(
										onTap: () {
											setState(() {
												if (_selectedSeatNames.contains(seatName)) {
													_selectedSeatNames.remove(seatName);
												}
												else {
													if (_selectedSeatNames.length >= widget.totalSeats) {
														_selectedSeatNames.removeAt(0);	// remove the first selected seat
													}
													_selectedSeatNames.add(seatName);
												}
											});
										},
										child: Container(
											margin: const EdgeInsets.all(5.0),
											decoration: BoxDecoration(
												border: Border.all(
													color: Colors.black,
													width: 2.0
												),
												borderRadius: BorderRadius.circular(10.0),
												color: _selectedSeatNames.contains(seatName) ? Theme.of(context).primaryColor : Colors.white,
											),
										)
									);
								}
							}
						),
					),
				),
				*/

				const Text('SALIDA'),
				
				Padding(
					padding: const EdgeInsets.all(12.0),
					child: RichText(
						textAlign: TextAlign.center,
						text: TextSpan(
							children: [
								const TextSpan(
									text: 'Asientos seleccionados',
									style: TextStyle(
										fontSize: 20,
										fontWeight: FontWeight.w900,
									),
								),
								TextSpan(
									text: ': ${_getSortedSeats(_selectedSeats).join(', ')}',
									style: const TextStyle(
										fontSize: 20,
										fontWeight: FontWeight.normal,
									),
								),
							]
						),
					)
				),

				BackNextButtonSet(
					onBackPressed: () {
						widget.onBackPressed();
					},
					onNextPressed: _selectedSeats.length == widget.totalSeats ? () {
						widget.onNextPressed(_getSortedSeats(_selectedSeats));
					} : null
				),
			],
		);
	}
}