import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  TextEditingController beratC = TextEditingController();

  List<Costs> costs = [];

  RxBool isLoading = false.obs;

  RxString provAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString cityTujuanId = "0".obs;
  RxString codeKurir = "".obs;

  void cekOngkir() async {
    if (provAsalId.value != "0" &&
        provTujuanId.value != "0" &&
        cityAsalId.value != "0" &&
        cityTujuanId.value != "0" &&
        beratC.text != "" &&
        codeKurir.value != "") {
      try {
        isLoading.value = true;
        var response = await http.post(
            Uri.parse("https://api.rajaongkir.com/starter/cost"),
            headers: {
              'key': '',
              "content-type": "application/x-www-form-urlencoded"
            },
            body: {
              'origin': provAsalId.value,
              'destination': provTujuanId.value,
              'weight': beratC.text,
              'courier': codeKurir.value
            });
        isLoading.value = false;
        List ongkir =jsonDecode(response.body)['rajaongkir']['results'][0]['costs'];
        costs = ongkir.map((e) => Costs.fromJson(e)).toList();

        Get.defaultDialog(
          radius: 10,
          backgroundColor: Colors.white,
          titleStyle: TextStyle(color: Colors.green),
          middleTextStyle: TextStyle(color: Colors.black),
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          buttonColor: Colors.green,
          onConfirm: () => Get.back(),
          title: "Ongkos Kirim",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: costs.map((e) => ListTile(
              title: Text("${e.service!.toUpperCase()}"),
              subtitle: Text("${e.description}"),
              trailing: Text("Rp.${e.cost?[0].value}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),), )).toList(),
          )
        );

      } catch (e) {
        print(e);
        Get.defaultDialog(
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.red),
            middleTextStyle: TextStyle(color: Colors.black),
            textConfirm: "OK",
            confirmTextColor: Colors.white,
            buttonColor: Colors.red,
            onConfirm: () => Get.back(),
            title: "Error",
            middleText: "Data Tidak Benaar");
      }
    } else {
      Get.defaultDialog(
          backgroundColor: Colors.white,
          titleStyle: TextStyle(color: Colors.red),
          middleTextStyle: TextStyle(color: Colors.black),
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          buttonColor: Colors.red,
          onConfirm: () => Get.back(),
          title: "Error",
          middleText: "Data Tidak Lengkap");
    }
  }
}
