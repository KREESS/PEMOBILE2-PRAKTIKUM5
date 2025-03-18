import 'package:flutter/material.dart';
import 'package:praktikum_5/services/api_service.dart';
import 'package:praktikum_5/models/banner_model.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({Key? key}) : super(key: key);

  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late Future<List<BannerModel>> _futureBanners;

  @override
  void initState() {
    super.initState();
    _futureBanners = ApiService.getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada data banner'));
        } else {
          return AspectRatio(
            aspectRatio: 2,
            child: PageView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final BannerModel banner = snapshot.data![index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://polindra.cicd.my.id/assets/${banner.image}',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
