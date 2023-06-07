import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class ImageNetworkCoordinatorPage extends StatefulWidget {
  const ImageNetworkCoordinatorPage({Key? key}) : super(key: key);

  @override
  State<ImageNetworkCoordinatorPage> createState() =>
      _ImageNetworkCoordinatorPageState();
}

class _ImageNetworkCoordinatorPageState
    extends State<ImageNetworkCoordinatorPage> {
  late _ImageNetworkCoordinatorNotifier _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = _ImageNetworkCoordinatorNotifier();
  }

  Future<void> _fetchImages(List<ImageProvider> imageProviders) async {
    final futures = <Future<void>>[];
    for (final provider in imageProviders) {
      futures.add(
        precacheImage(provider, context),
      );
    }

    await Future.wait(futures);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image network coordinator'),
      ),
      body: ChangeNotifierProvider<_ImageNetworkCoordinatorNotifier>(
        create: (_) => _viewModel,
        builder: (context, _) {
          context.select<_ImageNetworkCoordinatorNotifier, bool>(
            (i) => i.v,
          );

          final hasData =
              context.select<_ImageNetworkCoordinatorNotifier, bool>(
            (i) => i.hasData,
          );

          if (!hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final imageProviders = context
              .select<_ImageNetworkCoordinatorNotifier, List<ImageProvider>>(
            (i) => i.imageProvider,
          );

          return FutureBuilder(
            future: _fetchImages(imageProviders),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              final widgets = <Widget>[];
              for (final imageProvider in imageProviders) {
                widgets.add(
                  Image(
                    image: imageProvider,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                );
              }

              return Wrap(
                children: widgets,
              );

              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) {
                        return Image(
                          image: imageProviders[index],
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        );
                        return CachedNetworkImage(
                          imageUrl:
                              _ImageNetworkCoordinatorNotifier.imagesUrl[index],
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          placeholder: (_, __) =>
                              const CircularProgressIndicator(),
                        );
                      },
                      childCount:
                          _ImageNetworkCoordinatorNotifier.imagesUrl.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<_ImageNetworkCoordinatorNotifier>()
                            .changeV();
                      },
                      child: Text('Pressss'),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _ImageNetworkCoordinatorNotifier extends ChangeNotifier {
  _ImageNetworkCoordinatorNotifier() {
    Future.microtask(_fetchImages);
  }

  static const imagesUrl = [
    'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    'https://cdn.spacetelescope.org/archives/images/wallpaper2/heic2017a.jpg',
    'https://cdn.spacetelescope.org/archives/images/wallpaper2/heic2007a.jpg',
    'https://cdn.spacetelescope.org/archives/images/wallpaper2/heic1509a.jpg',
    'https://images.unsplash.com/photo-1542438408-abb260104ef3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80',
    'https://images.unsplash.com/photo-1542466500-dccb2789cbbb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=386&q=80',
    'https://images.unsplash.com/photo-1542442828-287217bfb87f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1542442828-287217bfb87f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1542451542907-6cf80ff362d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1221&q=80',
    'https://images.unsplash.com/photo-1542451313056-b7c8e626645f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=327&q=80',
    'https://images.unsplash.com/photo-1542395975-1913c2900823?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1542401886-65d6c61db217?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1542378151504-0361b8ec8f93?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1542397284385-6010376c5337?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80',
    'https://images.unsplash.com/photo-1542397284385-6010376c5337?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80',
    'https://images.unsplash.com/photo-1542379653-b928db1b4956?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1542370285-b8eb8317691c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1126&q=80',
  ];

  bool _hasData = false;
  bool get hasData => _hasData;

  bool v = true;

  List<ImageProvider> imageProvider = [];

  Future<void> _fetchImages() async {
    const urls = _ImageNetworkCoordinatorNotifier.imagesUrl;

    /*for (final imageUrl in urls) {
      imageProvider.add(CachedNetworkImageProvider(imageUrl));
    }*/

    for (final imageUrl in urls) {
      await NetworkImage(imageUrl).evict();
      imageProvider.add(NetworkImage(imageUrl));
    }

    _hasData = true;
    notifyListeners();
  }

  void changeV() {
    v = !v;
    notifyListeners();
  }
}
