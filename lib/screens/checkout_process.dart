import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/main_layout.dart';
import 'card_info.dart';
import 'confirm_purchase.dart';
import 'movie_details.dart';
import 'movie_seat_amount_selection.dart';
import 'movie_seat_selection.dart';
import 'snack.dart';

class CheckoutProgressScreen extends StatefulWidget {
	final String movieId;
	
	const CheckoutProgressScreen({super.key, required this.movieId});

	@override
	State<CheckoutProgressScreen> createState() => _CheckoutProgressScreenState();
}

class _CheckoutProgressScreenState extends State<CheckoutProgressScreen> with AutomaticKeepAliveClientMixin<CheckoutProgressScreen> {
	final PageController _pageController = PageController();

	int _selectedBranchId = 0, _adultTickets = 0, _childTickets = 0;
	String _selectedMovieFunction = '';
	List<String> _selectedSeatNames = [];
	List<(String, int)> _selectedProducts = [];

	void _onBackPressed() => _pageController.previousPage(
		duration: const Duration(milliseconds: 400),
		curve: Curves.easeOut,
	);

	void _onNextPressed() => _pageController.nextPage(
		duration: const Duration(milliseconds: 400),
		curve: Curves.easeIn,
	);

	@override
	bool get wantKeepAlive => true;
	
	@override
	void dispose() {
		_pageController.dispose();
		super.dispose();
	}
	
	@override
	Widget build(BuildContext context) {
		super.build(context);
		return MainLayout(
			child: PageView(
				controller: _pageController,
				physics: const NeverScrollableScrollPhysics(),
				children: [
					MovieDetailsScreen(	
						movieId: widget.movieId,
						onMovieFunctionSelected: (int selectedBranch, String selectedMovieFunction) {
							_selectedBranchId = selectedBranch;
							_selectedMovieFunction = selectedMovieFunction;
							_onNextPressed();
						}
					),
					MovieSeatAmountSelectionScreen(
						onBackPressed: () => _onBackPressed(),
						onNextPressed: (int adultTickets, int childTickets) {
							setState(() {	// yes, setState is needed here, don't remove
								_adultTickets = adultTickets;
								_childTickets = childTickets;
							});
							_onNextPressed();
						},
					),
					MovieSeatSelectionScreen(
						totalSeats: _adultTickets + _childTickets,
						onBackPressed: () => _onBackPressed(),
						onNextPressed: (List<String> selectedSeats) {
							setState(() {	// yes, setState is needed here, don't remove
								_selectedSeatNames = selectedSeats;
							});
							_onNextPressed();
						}
					),
					SnackScreen(
						onBackPressed: () => _onBackPressed(),
						onNextPressed: (List<(String, int)> products) {
							setState(() {	// yes, setState is needed here, don't remove
								_selectedProducts = products;
							});
							_onNextPressed();
						}
					),
					CardInfoScreen(
						onBackPressed: () => _onBackPressed(),
						onNextPressed: () {
							_onNextPressed();
						}
					),
					ConfirmPurchaseScreen(
						movieId: widget.movieId,
						branchId: _selectedBranchId,
						movieFunction: _selectedMovieFunction,
						adultTickets: _adultTickets,
						childTickets: _childTickets,
						seatNames: _selectedSeatNames,
						products: _selectedProducts,
						onBackPressed: () => _onBackPressed(),
						onNextPressed: () {
							showDialog<void>(
								context: context,
								barrierDismissible: false,
								builder: (BuildContext context) {
									return const AlertDialog(
										title: Text('Realizando compra...'),
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
								Navigator.of(context).pop(); // closes the dialog

								showDialog<void>(
									context: context,
									barrierDismissible: false,
									builder: (BuildContext context) {
										return AlertDialog(
											title: const Text('¡Compra realizada!'),
											content: SingleChildScrollView(
												child: Column(
													mainAxisAlignment: MainAxisAlignment.center,
													children: [
														const Text('Muestra este código en la sala 5:'),
														SizedBox(
															height: 100,
															width: 100,
															child: Image.asset('images/qr-code.png'),
														),
														ElevatedButton(
															onPressed: () {	
																context.go('/movie-selection');
															},
															child: const Text('Aceptar'),
														),
													],
												),
											)
										);
									},
								);
							});
						},
					),
				],
			),
		);
	}
}