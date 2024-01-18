import 'package:flutter/material.dart';
import 'package:fooderapp/utils/helpers.dart';
import 'package:fooderapp/widgets/genre_grid_view.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 15, 0),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    isSearching = value.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.black, size: 28.0),
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Find your recipe",
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 15, 0),
              child: Text(
                isSearching ? 'Search Results' : 'Genres',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Visibility(
              visible: !isSearching,
              child: Expanded(
                child: GenreGridView(),
              ),
            ),
            Visibility(
              visible: isSearching,
              child: Expanded(
                child: Column(
                  children: [
                    // The new row to be displayed above the search results
                    Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[800],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Music',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const HorizontalSpacer(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[800],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Podcasts & Shows',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),

                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Search results for: ${_searchController.text}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
