import 'package:find_my_waifu/view/tap_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

Widget CardStack(
    BuildContext context, List<String> imageList, Function onSwipe) {
  CardController controller; //Use this to trigger swap.

  double containerHeight = MediaQuery.of(context).size.height * 0.6;

  double maxHeight = MediaQuery.of(context).size.width * 0.9;
  double minHeight = MediaQuery.of(context).size.width * 0.8;
  double maxWidth = MediaQuery.of(context).size.width * 0.9;
  double minWidth = MediaQuery.of(context).size.width * 0.8;

  return Center(
    child: Container(
      height: containerHeight,
      child: TinderSwapCard(
        orientation: AmassOrientation.TOP,
        totalNum: imageList.length,
        stackNum: 4,
        swipeEdge: 4.0,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        minWidth: minWidth,
        minHeight: minHeight,
        cardBuilder: (context, index) => Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: TapImageNetwork(
                key: Key('${imageList[index]}'),
                photo: '${imageList[index]}',
                width: maxWidth,
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
                              child: TapImageNetwork(
                                key: Key('${imageList[index]}'),
                                photo: '${imageList[index]}',
                                width: 1000.0,
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )),
                      );
                    },
                  ));
                })),
        cardController: controller = CardController(),
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          /// Get swiping card's alignment
          if (align.x < 0) {
            //Card is LEFT swiping
          } else if (align.x > 0) {
            //Card is RIGHT swiping
          }
        },
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          onSwipe(orientation, index);
        },
      ),
    ),
  );
}
