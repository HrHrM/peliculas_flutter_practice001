import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({
    Key? key,
    required this.peliculas,
  }) : super(key: key);

  final List<dynamic> peliculas;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      // padding: const EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: const AssetImage('assets/imgs/no-image.jpg'),
              image: NetworkImage(
                peliculas[index].getPosterImg(),
              ),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: 3,
        // pagination: const SwiperPagination(),
        // control: const SwiperControl(),
      ),
    );
  }
}
