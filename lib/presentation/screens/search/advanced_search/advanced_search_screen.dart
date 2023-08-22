import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(text: AppStrings.search),
      ),
    );
  }
}
