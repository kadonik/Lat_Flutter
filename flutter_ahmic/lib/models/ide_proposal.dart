import 'dart:convert';

//LIST IP
class AjaxResponse {
  String status;
  String message;
  String redirect_url;
  String redirect_formid;
  List<IdeProposal> data;

  AjaxResponse({
    this.status,
    this.message,
    this.redirect_url,
    this.redirect_formid,
    this.data,
  });

  factory AjaxResponse.fromJson(Map<String, dynamic> map) {
    var list = map["data"] as List;
    print(list.runtimeType);
    List<IdeProposal> ipList =
        list.map((i) => IdeProposal.fromJson(i)).toList();

    return AjaxResponse(
      status: map["status"],
      message: map["message"],
      redirect_url: map["redirect_url"],
      redirect_formid: map["redirect_formid"],
      data: ipList,
    );
  }
}

class IdeProposal {
  String NID;
  String VPERIODID;
  String VDOCNO;
  String DSUBMIT;
  String VTEMAIP;
  String VSTATUS;
  String VGRADE;

  IdeProposal(
      {this.NID,
      this.VPERIODID,
      this.VDOCNO,
      this.DSUBMIT,
      this.VTEMAIP,
      this.VSTATUS,
      this.VGRADE});

  factory IdeProposal.fromJson(Map<String, dynamic> map) {
    return IdeProposal(
      NID: map["NID"].toString(),
      VPERIODID: map["VPERIODID"],
      VDOCNO: map["VDOCNO"],
      DSUBMIT: map["DSUBMIT"].toString(),
      VTEMAIP: map["VTEMAIP"],
      VSTATUS: map["VSTATUS"],
      VGRADE: map["VGRADE"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "NID": NID,
      "VPERIODID": VPERIODID,
      "VDOCNO": VDOCNO,
      "DSUBMIT": DSUBMIT,
      "VTEMAIP": VTEMAIP,
      "VSTATUS": VSTATUS,
      "VGRADE": VGRADE,
    };
  }
}
//END LIST IP

List<IdeProposal> ideProposalFromJson(String jsonData) {
  final data = json.decode(jsonData);
  AjaxResponse jsonResponse = new AjaxResponse.fromJson(data);
  return jsonResponse.data;
  //List<AjaxResponse>.from(data.map((item) => AjaxResponse.fromJson(item)));
}

String ideProposalToJson(IdeProposal data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
