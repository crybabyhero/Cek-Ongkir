import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/city_model.dart';

import '../controllers/home_controller.dart';
import '../../../data/models/province_model.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:
            const Text('Ongkos Kirim', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Provinsi Asal",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          DropdownSearch<Province>(
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => ListTile(
                  title: Text("${item.province}"),
                ),
                listViewProps: ListViewProps(),
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Provinsi Asal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  'https://api.rajaongkir.com/starter/province',
                  queryParameters: {'key': '59bc32ad3f3b7e757474d1b77bd23e09'},
                );
                return Province.fromJsonList(
                    response.data['rajaongkir']['results']);
              },
              onChanged: (value) =>
                  controller.provAsalId.value = value!.provinceId.toString()),
          const SizedBox(height: 20),
          DropdownSearch<City>(
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => ListTile(
                  title: Text("${item.type} ${item.cityName}"),
                ),
                listViewProps: ListViewProps(),
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Kota Asal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  'https://api.rajaongkir.com/starter/city?province=${controller.provAsalId.value}',
                  queryParameters: {
                    'key': '59bc32ad3f3b7e757474d1b77bd23e09',
                  },
                );
                return City.fromJsonList(
                    response.data['rajaongkir']['results']);
              },
              onChanged: (value) =>
                  controller.cityAsalId.value = value!.cityId.toString()),
          const SizedBox(height: 10),
          Text(
            "Provinsi Tujuan",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          DropdownSearch<Province>(
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => ListTile(
                  title: Text("${item.province}"),
                ),
                listViewProps: ListViewProps(),
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Provinsi Tujuan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  'https://api.rajaongkir.com/starter/province',
                  queryParameters: {'key': '59bc32ad3f3b7e757474d1b77bd23e09'},
                );
                return Province.fromJsonList(
                    response.data['rajaongkir']['results']);
              },
              onChanged: (value) =>
                  controller.provTujuanId.value = value!.provinceId.toString()),
          const SizedBox(height: 20),
          DropdownSearch<City>(
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => ListTile(
                  title: Text("${item.type} ${item.cityName}"),
                ),
                listViewProps: ListViewProps(),
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Kota Tujuan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  'https://api.rajaongkir.com/starter/city?province=${controller.provTujuanId.value}',
                  queryParameters: {
                    'key': '59bc32ad3f3b7e757474d1b77bd23e09',
                  },
                );
                return City.fromJsonList(
                    response.data['rajaongkir']['results']);
              },
              onChanged: (value) =>
                  controller.cityTujuanId.value = value!.cityId.toString()),
          const SizedBox(height: 10),
          Text(
            "Berat (gram)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.beratC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Berat (gram)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Kurir",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          DropdownSearch<Map<String, dynamic>>(
              items: [
                {
                  "code": "jne",
                  "name": "JNE",
                },
                {
                  "code": "tiki",
                  "name": "TIKI",
                },
                {
                  "code": "pos",
                  "name": "POS Indonesia",
                },
              ],
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => ListTile(
                  title: Text("${item['name']}"),
                ),
                listViewProps: ListViewProps(),
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              dropdownBuilder: (context, selectedItem) =>
                  Text("${selectedItem?['name'] ?? "Pilih Kurir"}"),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Pilih Kurir',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onChanged: (value) =>
                  controller.codeKurir.value = value!['code'] ?? ""),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                if (controller.isLoading.value == false) {
                  controller.cekOngkir();
                }
              },
              child: Obx(() => Text(
                    controller.isLoading.value ? "Loading..." : "Cek Ongkir",
                    style: TextStyle(color: Colors.white),
                  ))),
        ],
      ),
    );
  }
}
