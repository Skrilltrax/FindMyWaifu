import 'package:find_my_waifu/blocs/image_bloc.dart';
import 'package:find_my_waifu/models/image_response.dart';
import 'package:find_my_waifu/networking/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageCard extends StatefulWidget {
  final ImageBloc bloc;

  ImageCard({required this.bloc});

  @override
  _ImageCardState createState() => _ImageCardState(bloc: bloc);
}

class _ImageCardState extends State<ImageCard> {
  final ImageBloc bloc;

  _ImageCardState({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RefreshIndicator(
          onRefresh: () => bloc.fetchImage(),
          child: StreamBuilder<ApiResponse<ImageResponse>>(
            stream: bloc.imageStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return LoadingWidget();
                    break;
                  case Status.COMPLETED:
                    return Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      margin: EdgeInsets.symmetric(
                          vertical: 64, horizontal: 32),
                      child: Image.network(
                        snapshot.data!.data!.url,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    );
                    break;
                  case Status.ERROR:
                    return LoadingWidget();
                    break;
                }
              } else {
                return LoadingWidget();
              }
            },
          ),
        ));
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
