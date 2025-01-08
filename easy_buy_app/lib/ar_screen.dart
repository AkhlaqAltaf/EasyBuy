import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import 'common/drawer/drawer.dart';

class ArView extends StatefulWidget {
  @override
  _ArViewState createState() => _ArViewState();
}

class _ArViewState extends State<ArView> {
  ArCoreController? arCoreController;
  bool isArAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkArCoreAvailability();
  }

  Future<void> _checkArCoreAvailability() async {
    final isArCoreAvailable = await ArCoreController.checkArCoreAvailability();
    final isArServicesInstalled =
    await ArCoreController.checkIsArCoreInstalled();

    if (isArCoreAvailable && isArServicesInstalled) {
      setState(() {
        isArAvailable = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'ARCore not available or Google Play Services for AR needs to be updated.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: const Text('IN DEVELOPMENT...'),
      ),
      body: isArAvailable
          ? ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      )
          : Center(
          child: Text("AR features are not available on this device.")),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    // Add your GLB model
    _addModel(arCoreController!);
  }

  void _addModel(ArCoreController controller) {
    final node = ArCoreReferenceNode(
      name: "model",
      objectUrl: "assets/model.glb", // Path to your GLB model
      position: vector.Vector3(0, 0, -1.5), // Position in AR space
      scale: vector.Vector3(0.1, 0.1, 0.1), // Scale the model if necessary
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}