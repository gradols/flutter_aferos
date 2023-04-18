import 'package:flutter/material.dart';

class DraggableCard extends StatefulWidget {
  final Widget child;

  const DraggableCard({Key? key, required this.child}) : super(key: key);

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  Offset position = Offset.zero;
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_animationController);

    _animationController.addListener(() {
      setState(() {
        position = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateCard(Offset endPosition) {
    _animation = Tween<Offset>(
      begin: position,
      end: endPosition,
    ).animate(_animationController);

    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double threshold = screenWidth * 0.55;

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: Material(
          type: MaterialType.transparency,
          child: widget.child,
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          if (details.offset.distance > threshold) {
            // Si se ha deslizado lo suficiente, anima la tarjeta hacia fuera de la pantalla
            Offset endPosition = Offset(
                details.offset.dx > 0 ? screenWidth : -screenWidth,
                details.offset.dy);
            _animateCard(endPosition);

            // Aquí puedes agregar la funcionalidad de "Me gusta" y "Nope"
          } else {
            // Si no se ha deslizado lo suficiente, anima la tarjeta de vuelta a su posición original
            _animateCard(Offset.zero);
          }
        },
        child: widget.child,
      ),
    );
  }
}
