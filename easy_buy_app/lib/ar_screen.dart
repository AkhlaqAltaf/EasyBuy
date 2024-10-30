import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

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
      // Display error message if ARCore is unavailable or services need installation
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
    _addSphere(arCoreController!);
    _addCylindre(arCoreController!);
    _addCube(arCoreController!);
  }

  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(color: Color.fromARGB(120, 66, 134, 244));
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(node);
  }

  void _addCylindre(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
    );
    final cylindre = ArCoreCylinder(
      materials: [material],
      radius: 0.5,
      height: 0.3,
    );
    final node = ArCoreNode(
      shape: cylindre,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );
    controller.addArCoreNode(node);
  }

  void _addCube(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      metallic: 1.0,
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(-0.5, 0.5, -3.5),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
