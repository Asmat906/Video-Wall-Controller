import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:shimmer/shimmer.dart';

import 'customWidgets.dart';

Widget shimmer() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (_, __) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTileShimmer(
          isDarkMode: false,
          // padding: EdgeInsets.only(right: 20),
          margin: const EdgeInsets.only(left: 6.0),
        ),
      ],
    ),
    itemCount: 20,
  );
}

Widget shimmerheading() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (_, __) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTileShimmer(
          isDarkMode: false,
          // padding: EdgeInsets.only(right: 20),
          margin: const EdgeInsets.only(left: 6.0),
        ),
      ],
    ),
    itemCount: 1,
  );
}

Widget playStoreShimmer() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (_, __) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PlayStoreShimmer(
          isDarkMode: false,
          // padding: EdgeInsets.only(right: 20),
          margin: const EdgeInsets.only(left: 6.0),
        ),
      ],
    ),
    itemCount: 20,
  );
}

Widget videoListShimmer() {
  return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
    Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.green,
        enabled: _enabled,
        period: const Duration(milliseconds: 1500),
        direction: ShimmerDirection.ltr,
        loop: 0,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Container(
                //   width: 48.0,
                //   height: 48.0,
                //   color: Colors.white,
                // ),
                Container(
                  color: Colors.white,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 100,
                      minHeight: 100,
                      maxWidth: 100,
                      minWidth: 100
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 6,
        ),
      ),
    )
  ]);
}

bool _enabled = true;
Widget buildMovieShimmer() => ListTile(
  leading: CustomWidget.rectangular(height: 64, width: 64),
  title: Align(
    alignment: Alignment.centerLeft,
    child: CustomWidget.rectangular(
      height: 16,
      width: 4,
    ),
  ),
  subtitle: CustomWidget.rectangular(height: 14),
);
Widget shimmer2() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (_, __) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade400,
          enabled: _enabled,
          child: Card(
            child: Container(
              height: 200,
              width: double.infinity,
            ),
          ),
          // padding: EdgeInsets.only(right: 20),
          // margin: const EdgeInsets.only(left:6.0),
        ),
      ],
    ),
    itemCount: 1,
  );
}

Widget shimmer3() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (_, __) => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      enabled: _enabled,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Container(
            height: 308,
            width: double.infinity,
            child: Container(
              //height: 30,
              width: double.infinity,
            ),
          ),
        ),
      ),
      // padding: EdgeInsets.only(right: 20),
      // margin: const EdgeInsets.only(left:6.0),
    ),
    itemCount: 1,
  );
}

Widget shimmer4() {
  return ListView.builder(
    padding: EdgeInsets.only(top: 10),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (_, __) => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      enabled: _enabled,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Card(
          child: Container(
            height: 20,
            width: double.infinity,
            child: Container(),
          ),
        ),
      ),
      // padding: EdgeInsets.only(right: 20),
      // margin: const EdgeInsets.only(left:6.0),
    ),
    itemCount: 14,
  );
}

Widget friendReqShimmer() {
  return ListView.builder(
    padding: EdgeInsets.only(top: 10),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (_, __) => ListTileShimmer(
      isDisabledAvatar: true,
      isDisabledButton: true,
      isRectBox: true,
    ),
    itemCount: 14,
  );
}

Widget smallShimmer() {
  return ListView.builder(
    padding: EdgeInsets.only(top: 10),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (_, __) => ListTileShimmer(
      isDisabledAvatar: true,
      isDisabledButton: true,
      isRectBox: true,
    ),
    itemCount: 1,
  );
}

Widget friendProfileShimmer() {
  return ListView.builder(
    padding: EdgeInsets.only(top: 10),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (_, __) => Column(
      children: [
        ProfilePageShimmer(),
        ListTileShimmer(
          isDisabledAvatar: true,
          isDisabledButton: true,
          isRectBox: true,
        ),
        ListTileShimmer(
          isDisabledAvatar: true,
          isDisabledButton: true,
          isRectBox: true,
        ),
        ListTileShimmer(
          isDisabledAvatar: true,
          isDisabledButton: true,
          isRectBox: true,
        ),
        ListTileShimmer(
          isDisabledAvatar: true,
          isDisabledButton: true,
          isRectBox: true,
        ),
        ListTileShimmer(
          isDisabledAvatar: true,
          isDisabledButton: true,
          isRectBox: true,
        ),
        ListTileShimmer(
          isDisabledAvatar: true,
          isDisabledButton: true,
          isRectBox: true,
        ),
      ],
    ),
    itemCount: 1,
  );
}

Widget gridShimmer() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (_, __) => Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              enabled: _enabled,
              child: Card(
                child: Container(
                  height: 150,
                  width: 150,
                ),
              ),
              // padding: EdgeInsets.only(right: 20),
              // margin: const EdgeInsets.only(left:6.0),
            ),
            SizedBox(
              width: 10,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              enabled: _enabled,
              child: Card(
                child: Container(
                  height: 150,
                  width: 150,
                ),
              ),
              // padding: EdgeInsets.only(right: 20),
              // margin: const EdgeInsets.only(left:6.0),
            ),
          ],
        ),
      ],
    ),
    itemCount: 10,
  );
}
