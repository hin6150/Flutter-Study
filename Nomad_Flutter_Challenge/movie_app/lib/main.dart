import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Future<List<MovieModel>> popularMovies =
      ApiService.getMovies("popular");
  final Future<List<MovieModel>> nowPlayingMovies =
      ApiService.getMovies("now-playing");
  final Future<List<MovieModel>> commingSoonMovies =
      ApiService.getMovies("coming-soon");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                "Popular Movies",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FutureBuilder(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 300,
                      child: makeList(snapshot, true),
                    );
                  } else if (snapshot.hasError) {
                    throw Error();
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              // const Row(children: [],),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Now in Cinemas",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FutureBuilder(
                future: nowPlayingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 300,
                      child: makeList(snapshot, false),
                    );
                  } else if (snapshot.hasError) {
                    throw Error();
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const Text(
                "Coming soon",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FutureBuilder(
                future: commingSoonMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 300,
                      child: makeList(snapshot, false),
                    );
                  } else if (snapshot.hasError) {
                    throw Error();
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

ListView makeList(AsyncSnapshot<List<MovieModel>> snapshot, type) {
  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.symmetric(
      vertical: 30,
    ),
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      var movie = snapshot.data![index];
      return type
          ? MovieThumb(
              movie: movie,
              width: 300,
              height: 300,
            )
          : MovieBox(movie: movie);
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: 10,
    ),
  );
}

class MovieBox extends StatelessWidget {
  const MovieBox({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieThumb(movie: movie, width: 150, height: 150),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 150,
          child: Text(
            movie.title,
            softWrap: true,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class MovieThumb extends StatelessWidget {
  const MovieThumb({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
  });

  final MovieModel movie;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              id: movie.id,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<SingleMovieModal> movieInfo;
  @override
  void initState() {
    super.initState();
    movieInfo = ApiService.getMovie("movie?id=${widget.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: movieInfo,
          builder: (context, snapshot) {
            late int hour = (snapshot.data!.runtime / 60).floor();
            late int min = snapshot.data!.runtime % 60;

            late List<dynamic> genres = snapshot.data!.genres
                .where((map) => map.containsKey("name"))
                .map((map) => map["name"]!)
                .toList();

            late int starRate = (snapshot.data!.voteAverage / 2).floor();

            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.network(
                              "https://image.tmdb.org/t/p/w500/${snapshot.data!.posterPath}")
                          .image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 64,
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.keyboard_arrow_left,
                                  size: 36,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              const Text(
                                "Back to list",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) {
                                    if (index < starRate) {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.white38,
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.8)),
                                child: Row(
                                  children: [
                                    Text(
                                      '${hour}h ${min}min',
                                    ),
                                    const Text(' | '),
                                    Text(genres.join(', ')),
                                  ],
                                ),
                              ),
                              Text(
                                snapshot.data!.adult ? "adult" : "non adult",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.8)),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "Storyline",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data!.overView,
                                softWrap: true,
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 300,
                                  height: 60,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Buy Ticket",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  static Future<List<MovieModel>> getMovies(endPoint) async {
    List<MovieModel> movieInstances = [];

    final url = Uri.parse('$baseUrl/$endPoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies =
          jsonDecode(utf8.decode(response.bodyBytes))['results'];
      for (var movie in movies) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<SingleMovieModal> getMovie(endPoint) async {
    final url = Uri.parse('$baseUrl/$endPoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(utf8.decode(response.bodyBytes));

      return SingleMovieModal.fromJson(movie);
    }
    throw Error();
  }
}

class MovieModel {
  final String backdropPath, title;
  final int id;

  MovieModel.fromJson(Map<String, dynamic> json)
      : backdropPath = json['backdrop_path'],
        title = json['title'],
        id = json['id'];
}

class SingleMovieModal {
  final String title, overView, posterPath;
  final List<dynamic> genres;
  final int runtime;
  final bool adult;
  final double voteAverage;

  SingleMovieModal.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        genres = json['genres'],
        overView = json['overview'],
        posterPath = json['poster_path'],
        runtime = json['runtime'],
        adult = json['adult'],
        voteAverage = json['vote_average'].toDouble();
}
