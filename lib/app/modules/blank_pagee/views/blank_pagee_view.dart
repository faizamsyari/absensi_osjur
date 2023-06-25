import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/blank_pagee_controller.dart';

class BlankPageeView extends GetView<BlankPageeController> {
  const BlankPageeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlankPageeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BlankPageeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
