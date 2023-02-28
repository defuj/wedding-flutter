import 'package:carousel_slider/carousel_slider.dart';
import 'package:wedding/repositories.dart';

Widget carouselSliderHome({required List<String> banner}) {
  return banner.isNotEmpty
      ? Container(
          margin: const EdgeInsets.only(top: 16, bottom: 8),
          child: CarouselSlider.builder(
            options: CarouselOptions(
              aspectRatio: 16 / 7,
              autoPlay: true,
              initialPage: 1,
            ),
            itemCount: banner.length,
            itemBuilder: (context, index, realIndex) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: banner[index],
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/no_image_placeholder.png',
                            fit: BoxFit.cover,
                          ),
                          httpHeaders: const {
                            'Allow-Control-Allow-Origin': '*',
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      : Container();
}

class CarouselSliderHome extends StatefulWidget {
  final List<String> banner;
  const CarouselSliderHome({super.key, required this.banner});

  @override
  State<CarouselSliderHome> createState() => _CarouselSliderHomeState();
}

class _CarouselSliderHomeState extends State<CarouselSliderHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 8),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          aspectRatio: 16 / 6,
          autoPlay: true,
          initialPage: 1,
        ),
        itemCount: widget.banner.length,
        itemBuilder: (context, index, realIndex) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.banner[index],
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/no_image_placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
