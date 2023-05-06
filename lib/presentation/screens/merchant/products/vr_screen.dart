import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class VRScreen extends StatelessWidget {
  const VRScreen({
    Key? key,
    required this.name,
    required this.modelUrl,
  }) : super(key: key);

  final String name;
  final String modelUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(
          text: name,
        ),
      ),
      body: ModelViewer(
        src: Urls.filesUrl + modelUrl,
        alt: name,
        ar: true,
        autoRotate: true,
        cameraControls: true,
        backgroundColor: ColorManager.white,
      ),
    );
  }
}
