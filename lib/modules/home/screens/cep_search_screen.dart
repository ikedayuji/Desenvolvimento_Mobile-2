import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'cep_model.dart';
import 'cep_repository.dart';

class CepSearchScreen extends StatefulWidget {
  const CepSearchScreen({Key? key}) : super(key: key);

  @override
  _CepSearchScreenState createState() => _CepSearchScreenState();
}

class _CepSearchScreenState extends State<CepSearchScreen> {
  final TextEditingController _cepController = TextEditingController();
  Cep? _addressData;
  String? _currentAddress;

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placemark = placemarks.first;
      setState(() {
        _currentAddress =
            '${placemark.thoroughfare}, ${placemark.subThoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
      });
    } catch (e) {
      print('Erro ao obter localização: $e');
    }
  }

  void _compareAddresses() {
    String addressFromCep = _addressData?.logradouro ?? '';
    String addressFromGPS = _currentAddress ?? '';

    if (addressFromCep.isNotEmpty && addressFromGPS.isNotEmpty) {
      if (addressFromCep == addressFromGPS) {
        _showModal('Você está na mesma localização do CEP digitado');
      } else {
        _showModal('Você não está na mesma localização do CEP digitado');
      }
    }
  }

  void _showModal(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Comparação de Localizações'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _buscarCep() async {
    String cep = _cepController.text.trim();
    if (cep.isEmpty) return;

    try {
      Cep cepData = await CepRepository().fetchCep(cep);
      setState(() {
        _addressData = cepData;
      });
    } catch (e) {
      print('Erro ao buscar CEP: $e');
    }
  }

  Future<void> _abrirGoogleMaps() async {
    String address = _cepController.text.trim();
    if (address.isEmpty) {
      return;
    }

    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        String mapsUrl =
            'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}';
        if (await canLaunch(mapsUrl)) {
          await launch(mapsUrl);
        } else {
          throw 'Não foi possível abrir o Google Maps';
        }
      } else {
        throw 'Endereço não encontrado';
      }
    } catch (e) {
      print('Erro ao abrir o Google Maps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca de CEP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cepController,
              decoration: InputDecoration(labelText: 'Digite o CEP'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _buscarCep,
              child: Text('Buscar CEP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _getCurrentLocation();
                _abrirGoogleMaps();
              },
              child: Text('Abrir no Google Maps'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getCurrentLocation();
                _compareAddresses();
              },
              child: Text('Comparar com Localização Atual'),
            ),
            if (_addressData != null) ...[
              Text('CEP: ${_addressData!.cep}'),
              Text('Logradouro: ${_addressData!.logradouro}'),
              Text('Complemento: ${_addressData!.complemento}'),
              Text('Bairro: ${_addressData!.bairro}'),
              Text('Localidade: ${_addressData!.localidade}'),
              Text('UF: ${_addressData!.uf}'),
              Text('IBGE: ${_addressData!.ibge}'),
              Text('GIA: ${_addressData!.gia}'),
              Text('DDD: ${_addressData!.ddd}'),
              Text('SIAFI: ${_addressData!.siafi}'),
            ],
          ],
        ),
      ),
    );
  }
}
