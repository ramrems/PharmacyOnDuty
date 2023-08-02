import 'package:flutter/material.dart';

class AppBar extends StatefulWidget {
  const AppBar({super.key});

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  final double height;

  _AppBarState(this.height);

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return new Container(
        color: Colors.transparent,
        child: Stack(fit: StackFit.loose, children: <Widget>[
          Container(
              color: Colors.transparent,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: height,
              child: CustomPaint(
                painter: CustomToolbarShape(lineColor: Colors.deepOrange),
              )),
          Align(
              alignment: Alignment(0.0, 1.25),
              child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 14.5,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                            // shadow
                            spreadRadius: .5,
                            // set effect of extending the shadow
                            offset: Offset(
                              0.0,
                              5.0,
                            ),
                          )
                        ],
                      ),
                      child: TextField(
                          onSubmitted: (submittedText) {

                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black38,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(25)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1),
                                  borderRadius:
                                  BorderRadius.circular(25))))))),
          Align(
              alignment: Alignment(0.9, 0.0),
              child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 13,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 13,
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.local_mall,
                      color: Colors.black,
                    ),
                  ))),
          Align(
              alignment: Alignment(-0.9, 0.0),
              child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 13,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 13,
                  child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      )))),
        ])
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
