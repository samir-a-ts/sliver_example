import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StationsPage extends StatelessWidget {
  const StationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            expandedHeight: 150,
            backgroundColor: Colors.black87,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Chillllll'),
              expandedTitleScale: 1.5,
              background: Image.network(
                'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          const TestSliverWidget(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text('Tile $index'),
              ),
              childCount: 10,
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Text('Tile $index'),
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class TestSliverWidget extends LeafRenderObjectWidget {
  const TestSliverWidget({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderTest();
  }
}

class RenderTest extends RenderSliver {
  @override
  void performLayout() {
    const childExtent = 150.0;

    final double paintedChildSize = calculatePaintOffset(constraints, from: 0.0, to: childExtent);

    final double cacheExtent = calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    geometry = SliverGeometry(
      /// Пространство, что выделяется движком на весь виджет. Оно влияет на то,
      /// где будет отрисовываться следующий сливер
      // layoutExtent: 50,

      /// Пространство, что выделяется движком на этот виджет
      scrollExtent: childExtent,

      /// Пространство, что видно пользователю
      paintExtent: paintedChildSize,

      /// Пространство, что не видно пользователем
      cacheExtent: cacheExtent,

      /// Отступ, где будет нарисован виджет
      // paintOrigin: -30,

      /// Максимальное количесвто места, что может быть видно отрисовщиком
      maxPaintExtent: childExtent,

      /// Пространство, что отлавливает нажатия
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent || constraints.scrollOffset > 0.0,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    var rotateValue = geometry!.paintExtent / geometry!.maxPaintExtent;

    if (rotateValue < 0.5) {
      rotateValue = 0.5;
    }

    context.canvas.rotate(
      rotateValue * 2 * pi,
    );

    context.canvas.drawRect(
      Rect.fromCenter(
        center: offset + Offset(75, constraints.cacheOrigin + 75),
        width: 150,
        height: 150,
      ),
      paint,
    );
  }
}
