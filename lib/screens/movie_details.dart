import 'package:flutter/material.dart';

import '../services/info_provider.dart';

class MovieDetailsScreen extends StatefulWidget {
	final String movieId;
	final Function(int, String) onMovieFunctionSelected;

	const MovieDetailsScreen({super.key, required this.movieId, required this.onMovieFunctionSelected});

	@override
	State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> with
	AutomaticKeepAliveClientMixin<MovieDetailsScreen>, SingleTickerProviderStateMixin {
	
	final weekdays = [ 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo' ];

	late TabController _tabController;

	@override
	bool get wantKeepAlive => true;

	@override
	void initState() {
		super.initState();
		_tabController = TabController(length: 3, vsync: this);
	}

	@override
	void dispose() {
		_tabController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		super.build(context);
		var movie = InfoProvider.movies.where((element) => element['id'] == widget.movieId).first;
		return Column(
			children: [
				Padding(
					padding: const EdgeInsets.all(8.0),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Image.asset(
								'images/movies/${movie['poster'] as String}',
								height: 200
							),
							SizedBox(
								width: MediaQuery.of(context).size.width / 2,
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Padding(
											padding: const EdgeInsets.symmetric(vertical: 10.0),
											child: Text(
												movie['title'] as String,
												style: const TextStyle(
													fontSize: 20,
													fontWeight: FontWeight.bold,
												)
											)
										),
										RichText(
											textAlign: TextAlign.left,
											text: TextSpan(
												children: [
													const TextSpan(
														text: 'Género(s)',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
													TextSpan(
														text: ': ${(movie['genres'] as List<String>).join(', ')}\n',
													),
													const TextSpan(
														text: 'Duración',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
													TextSpan(
														text: ': ${movie['duration']} minutos\n',
													),
													const TextSpan(
														text: 'Director',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
													TextSpan(
														text: ': ${movie['director'] as String}\n',
													),
													const TextSpan(
														text: 'Actores',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
													TextSpan(
														text: ': ${(movie['cast'] as List<String>).join(', ')}',
													),
												]
											),
										),
									]
								)
							),
						]
					),
				),
				Padding(
					padding: const EdgeInsets.all(12.0),
					child: Text(movie['synopsis'] as String),
				),
				TabBar(
					controller: _tabController,
					indicatorColor: Theme.of(context).primaryColor,
					labelColor: Colors.black,
					labelStyle: const TextStyle(
						fontWeight: FontWeight.w500
					),
					tabs: [
						Tab(text: '${weekdays[DateTime.now().weekday - 1]} ${DateTime.now().day}'),
						Tab(text: '${weekdays[DateTime.now().add(const Duration(days: 1)).weekday - 1]} ${DateTime.now().add(const Duration(days: 1)).day}'),
						Tab(text: '${weekdays[DateTime.now().add(const Duration(days: 2)).weekday - 1]} ${DateTime.now().add(const Duration(days: 2)).day}'),
					],
				),
				Expanded(
					child: TabBarView(
						controller: _tabController,
						children: [
							...List.generate(3, (int tabIndex) {
								return Padding(
									padding: const EdgeInsets.all(4.0),
									child: ListView.separated(
										itemCount: InfoProvider.branches.length,
										itemBuilder: (BuildContext context, int branchIndex) {
											return Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Padding(
														padding: const EdgeInsets.symmetric(vertical: 8.0),
														child: Text(
															'Sucursal ${InfoProvider.branches[branchIndex]}',
															style: const TextStyle(
																fontWeight: FontWeight.w500
															),
														),
													),
													Wrap(
														spacing: 8.0,
														runSpacing: 6.0,
														children: [
															...List.generate(6, (movieFunctionIndex) {
																return GestureDetector(
																	onTap: () {
																		int selectedBranchId = tabIndex;
																		String selectedMovieFunction = '${10 + movieFunctionIndex*2}:00';
																		widget.onMovieFunctionSelected(selectedBranchId, selectedMovieFunction);
																	},
																	child: Chip(
																		backgroundColor: Theme.of(context).primaryColor,
																		label: Padding(
																			padding: const EdgeInsets.all(3.0),
																			child: Text(
																				'${10 + movieFunctionIndex*2}:00',
																				textAlign: TextAlign.center,
																				style: const TextStyle(
																					color: Colors.white,
																					fontWeight: FontWeight.w600,
																				),
																			),
																		),
																	),
																);
															}),
														]
													),
												],
											);
										},
										separatorBuilder: (BuildContext context, int index) {
											return const SizedBox(
												height: 10
											);
										},
									),
								);
							}),
						],
					),
				),
			]
		);
	}
}