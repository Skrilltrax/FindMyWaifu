import 'package:find_my_waifu/blocs/image_bloc.dart';
import 'package:find_my_waifu/blocs/image_list_bloc.dart';
import 'package:find_my_waifu/models/image_list_response.dart';
import 'package:find_my_waifu/models/image_response.dart';
import 'package:find_my_waifu/networking/api_response.dart';
import 'package:find_my_waifu/view/card_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageStack extends StatefulWidget {
  final ImageListBloc bloc;

  ImageStack({required this.bloc});

  @override
  _ImageStackState createState() => _ImageStackState(bloc: bloc);
}

class _ImageStackState extends State<ImageStack> {
  final ImageListBloc bloc;

  _ImageStackState({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RefreshIndicator(
          onRefresh: () => bloc.fetchImageList(),
          child: StreamBuilder<ApiResponse<ImageListResponse>>(
            stream: bloc.imageStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return LoadingWidget();
                    break;
                  case Status.COMPLETED:
                    return CardStack(context, snapshot.data!.data!.files, () => { print("Card Swiped")});
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
