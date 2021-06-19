import 'package:find_my_waifu/blocs/saved_image_list_bloc.dart';
import 'package:find_my_waifu/networking/response.dart';
import 'package:find_my_waifu/view/tap_image_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageGrid extends StatefulWidget {
  final SavedImageBloc bloc;

  ImageGrid({required this.bloc});

  @override
  _ImageGridState createState() => _ImageGridState(bloc: bloc);
}

class _ImageGridState extends State<ImageGrid> {
  final SavedImageBloc bloc;

  _ImageGridState({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<Response<List<String>>>(
        stream: bloc.imageStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                return LoadingWidget();
              case Status.COMPLETED:
                return GridWidget(images: snapshot.data!.data!);
              case Status.ERROR:
                return LoadingWidget();
            }
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
  }
}

class GridWidget extends StatelessWidget {
  final List<String> images;

  GridWidget({required this.images});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: images.map((image) {
        return GridItem(imagePath: image);
      }).toList(),
    );
  }
}

class GridItem extends StatelessWidget {
  final String imagePath;

  GridItem({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return TapImageLocal(
        key: Key(imagePath),
        photo: imagePath,
        width: MediaQuery.of(context).size.width * 0.25,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Scaffold(
                body: Container(
                    // The blue background emphasizes that it's a new route.
                    color: Colors.black,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.topLeft,
                    child: Center(
                      child: TapImageLocal(
                        key: Key(imagePath),
                        photo: imagePath,
                        width: 1000.0,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )),
              );
            },
          ));
        });
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
