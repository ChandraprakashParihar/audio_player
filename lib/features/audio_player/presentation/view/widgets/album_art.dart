import 'package:flutter/material.dart';

/// Displays the album artwork as the background image.
class AlbumArt extends StatelessWidget {
  const AlbumArt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.62,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images8.alphacoders.com/506/thumb-1920-506270.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
