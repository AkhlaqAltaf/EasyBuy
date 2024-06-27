import 'package:flutter/material.dart';

void flashMessage(BuildContext context, String type, String message) {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry? overlayEntry;
  Color backgroundColor = type == 'success' ? Colors.green : Colors.red;

  overlayEntry = OverlayEntry(builder: (context) {
    return Positioned(
        top: 50.0,
        left: 20.0,
        right: 20.0,
        child: GestureDetector(
          onTap: () {
            overlayEntry!.remove();
          },
          child: Material(
            color: backgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15.0),
            ),
            child: Dismissible(
              key: ValueKey(message),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Wrap content
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  });

  overlayState.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 20), () => overlayEntry!.remove());
}
