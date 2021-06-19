import 'package:find_my_waifu/blocs/saved_image_list_bloc.dart';
import 'package:find_my_waifu/view/image_grid.dart';
import 'package:flutter/material.dart';

class SavedImagePage extends StatefulWidget {
  SavedImagePage({Key? key}) : super(key: key);

  final String title = "Meet Your Waifus";

  @override
  _SavedImagePage createState() => _SavedImagePage();
}

class _SavedImagePage extends State<SavedImagePage> {
  late SavedImageBloc _bloc;

  @override
  void initState() {
    _bloc = SavedImageBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: ImageGrid(bloc: _bloc),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
