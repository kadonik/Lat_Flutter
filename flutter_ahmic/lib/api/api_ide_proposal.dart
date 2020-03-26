import 'dart:convert';
import 'package:flutter_ahmic/models/ide_proposal.dart';
import 'package:flutter_ahmic/models/det_ide_proposal.dart';
import 'package:http/http.dart' show Client;

class ApiIdeProposal {
  final String baseUrl =
      "https://mobiledev.ahm.co.id/oneheart/app/ahmic/handlers/AHMHRIRS021.ashx";
  Client client = Client();

  Future<List<IdeProposal>> getStatusIp() async {
    Map<String, dynamic> mapBody = {
      "token": "686e8103-e917-4706-a0e6-ff6f40910cb3",
      "action": "getstatusip",
      "periodid": "2020-2021",
      "vnrp": "52021",
      "vstatus": "1",
    };

    final response = await client.post(baseUrl,
        body: mapBody,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      return ideProposalFromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<DetIdeProposal> getDetailIp(String noreg) async {
    Map<String, dynamic> mapBody = {
      "token": "686e8103-e917-4706-a0e6-ff6f40910cb3",
      "action": "getdetip",
      "ahmhrirs021_vnrp": "15501",
      "ahmhrirs021_vnoreg": "00003/IP/4/01/2020",
    };

    final response = await client.post(baseUrl,
        body: mapBody,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      return detIpFromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
