library noise_scroll_view;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class NoiseScrollView extends StatefulWidget {

  final Widget child;
  final double width;
  final double height;
  final double contentWidth;
  final double contentHeight;
  late final  LinkedScrollControllerGroup? verticalScrollGroup;
  late final LinkedScrollControllerGroup? horizontalScrollGroup;

  NoiseScrollView({Key? key,
    required this.child,
    required this.contentWidth,
    required this.contentHeight,
    this.width = double.infinity,
    this.height = double.infinity,
    LinkedScrollControllerGroup? verticalScrollGroup,
    LinkedScrollControllerGroup? horizontalScrollGroup,
  }) : super(key: key){
    this.verticalScrollGroup = verticalScrollGroup ?? LinkedScrollControllerGroup();
    this.horizontalScrollGroup = horizontalScrollGroup ?? LinkedScrollControllerGroup();
  }

  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<NoiseScrollView> {
  late ScrollController vController = widget.verticalScrollGroup!.addAndGet();
  late ScrollController vBarController =widget.verticalScrollGroup!.addAndGet();
  late ScrollController hController = widget.horizontalScrollGroup!.addAndGet();
  late ScrollController hBarController = widget.horizontalScrollGroup!.addAndGet();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          buildContent(),
          Positioned(
              bottom: 0,
              child: buildHorizontalBar()),
          Positioned(
              right: 0,
              child: buildVerticalScrollBar())
        ],
      ),
    );
  }

  Widget buildContent() {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child:SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: hController,
            child: SizedBox(
              width: widget.contentWidth,
              height: widget.height,
              child:  SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: vController,
                child:  Container(
                  color: Colors.red,
                  width: widget.contentWidth,
                  height: widget.contentHeight,
                  child: widget.child,
                ),
              ),
            )
        )
    );
  }

  Widget buildVerticalScrollBar() {
    return SizedBox(
      height: widget.height,
      child: Scrollbar(
          controller: vBarController,
          isAlwaysShown: true,
          child: SingleChildScrollView(
              controller: vBarController,
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: 16,
                height: widget.contentHeight,
              )
          )
      ),
    );
  }

  Widget buildHorizontalBar() {
    return SizedBox(
      width: widget.width,
      child: Scrollbar(
          controller: hBarController,
          isAlwaysShown: true,
          child: SingleChildScrollView(
              controller: hBarController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: widget.contentWidth,
                height:16,
              )
          )
      ),
    );
  }
}

