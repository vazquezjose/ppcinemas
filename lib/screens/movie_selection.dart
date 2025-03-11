import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../services/info_provider.dart';
import '../widgets/main_layout.dart';

class MovieSelectionScreen extends StatefulWidget {
	const MovieSelectionScreen({super.key});

	@override
	State<MovieSelectionScreen> createState() => _MovieSelectionScreenState();
}

class _MovieSelectionScreenState extends State<MovieSelectionScreen> {
	List<String> _filteredMovies = [], _movieTitles = [];
	final TextEditingController _searchController = TextEditingController();

	@override
	void initState() {
		/*
		// only needed if the movie posters are Image.network images
		WidgetsBinding.instance.addPostFrameCallback((_) {
			images.forEach((imageUrl) {
				precacheImage(NetworkImage(imageUrl), context);
			});
		});
		*/

		super.initState();

		_movieTitles = InfoProvider.movies.map((Map<String, Object> movie) => movie['title'] as String).toList();
		_filteredMovies = _movieTitles;
	}

	@override
	Widget build(BuildContext context) {
		return MainLayout(
			child: Column(
				children: [
					Expanded(
						flex: 2,
						child: CarouselView.weighted(
							controller: CarouselController(
								initialItem: (InfoProvider.movies.length / 2).round()	// begins in the middle
							),
							scrollDirection: Axis.horizontal,
							flexWeights: const <int>[1,2,1],	// visible items scaling
							itemSnapping: true,		// allows focus on one item at a time
							enableSplash: false,	// hides ink well
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
							children: List<Widget>.generate(
								InfoProvider.movies.length,
								(int index) {
									return GestureDetector(
										onTap: () {
											context.push('/checkout/${InfoProvider.movies[index]['id']}');
										},
										child: Image.asset('images/movies/${InfoProvider.movies[index]['poster'] as String}')
									);
								}
							)
						)
					),
					
					Padding(
						padding: const EdgeInsets.all(8.0),
						child: TextField(
							controller: _searchController,
							onChanged: (value) {
								setState(() {
									_filteredMovies = _movieTitles
										.where((movie) =>
											movie.toLowerCase().contains(value.toLowerCase()))
										.toList();
									}
								);
							},
							decoration: const InputDecoration(
								labelText: 'Buscar película...',
								border: OutlineInputBorder(),
							),
						),
					),
					Expanded(
						flex: 3,
						child: GridView.builder(
							gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
								crossAxisCount: 2,
								crossAxisSpacing: 4.0,
								mainAxisSpacing: 4.0,
							),
							itemCount: _filteredMovies.length,
							itemBuilder: (BuildContext context, int index) {
								var movie = InfoProvider.movies.where((element) => _filteredMovies[index] == element['title']).first;
								return GridTile(
									child: GestureDetector(
										onTap: () {
											context.push('/checkout/${movie['id']}');
										},
										child: Image.asset('images/movies/${movie['poster'] as String}')
									)
								);
							},
						),
					),
				],
			),
		);
	}
}