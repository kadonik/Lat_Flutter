import 'dart:convert';

import 'package:flutter_ahmic/ui/listpage.dart';

class AjaxResponse {
  String status;
  String message;
  String redirect_url;
  String redirect_formid;
  DetIdeProposal data;

  AjaxResponse({
    this.status,
    this.message,
    this.redirect_url,
    this.redirect_formid,
    this.data,
  });

  factory AjaxResponse.fromJson(Map<String, dynamic> map) {  
    return AjaxResponse(
      status: map["status"],
      message: map["message"],
      redirect_url: map["redirect_url"],
      redirect_formid: map["redirect_formid"],
      data: DetIdeProposal.fromJson(map["data"]),
    );
  }
}

//DETAIL IP
class DetIdeProposal {
  String NID;
  String VPERIODID;
  String VNRP;
  String VTEMAIP;
  String DSUBMITTED;
  String NTOTALNILAI;
  String NCOSTDOWN;
  String NREWARD;
  String VDOCNO;
  String VGRADE;
  String VCREA;
  String DCREA;
  String VMODI;
  String DMODI;
  String VSTATUS;
  String VPROCESS;
  String VIMPACT;
  String VQUALITY;
  String VCOST;
  String VDELIVERY;
  String VSAFETY;
  String VMORAL;
  String VSTANDARD;
  String VCOMMENTSUP;
  String VGRADESUP;
  String VCOMMENTIC;
  String VWFGUID;
  String DAPPROVE;
  List<Attachment> ATTACTHMENTS;

  DetIdeProposal({
    this.NID,
    this.VPERIODID,
    this.VNRP,
    this.VTEMAIP,
    this.DSUBMITTED,
    this.NTOTALNILAI,
    this.NCOSTDOWN,
    this.NREWARD,
    this.VDOCNO,
    this.VGRADE,
    this.VCREA,
    this.DCREA,
    this.VMODI,
    this.DMODI,
    this.VSTATUS,
    this.VPROCESS,
    this.VIMPACT,
    this.VQUALITY,
    this.VCOST,
    this.VDELIVERY,
    this.VSAFETY,
    this.VMORAL,
    this.VSTANDARD,
    this.VCOMMENTSUP,
    this.VGRADESUP,
    this.VCOMMENTIC,
    this.VWFGUID,
    this.DAPPROVE,
    this.ATTACTHMENTS,
  });

  factory DetIdeProposal.fromJson(Map<String, dynamic> map) {
    var list = map["ATTACTHMENTS"] as List;
    print(list.runtimeType);
    List<Attachment> attachmentList =
        list.map((i) => Attachment.fromJson(i)).toList();

    return DetIdeProposal(
      NID: map["NID"].toString(),
      VPERIODID: map["VPERIODID"],
      VNRP: map["VNRP"],
      VTEMAIP: map["VTEMAIP"],
      DSUBMITTED: map["DSUBMITTED"].toString(),
      NTOTALNILAI: map["NTOTALNILAI"].toString(),
      NCOSTDOWN: map["NCOSTDOWN"].toString(),
      NREWARD: map["NREWARD"].toString(),
      VDOCNO: map["VNODOC"],
      VGRADE: map["VGRADE"],
      VCREA: map["VCREA"],
      DCREA: map["DCREA"].toString(),
      VMODI: map["VMODI"],
      DMODI: map["DMODI"].toString(),
      VSTATUS: map["VSTATUS"],
      VPROCESS: map["VPROCESS"],
      VIMPACT: map["VIMPACT"],
      VQUALITY: map["VQUALITY"],
      VCOST: map["VCOST"],
      VDELIVERY: map["VDELIVERY"],
      VSAFETY: map["VSAFETY"],
      VMORAL: map["VMORAL"],
      VSTANDARD: map["VSTANDARD"],
      VCOMMENTSUP: map["VCOMMENTSUP"],
      VGRADESUP: map["VGRADESUP"],
      VCOMMENTIC: map["VCOMMENTIC"],
      VWFGUID: map["VWFGUID"],
      DAPPROVE: map["DAPPROVE"].toString(),
      ATTACTHMENTS: attachmentList,
    );
  }
}

class Attachment {
  String XIP_VNODOC;
  String NBEFAFT;
  String NSEQ;
  String VCOND;
  String VATTCHNAMEID;
  String VFILE;

  Attachment({
    this.XIP_VNODOC,
    this.NBEFAFT,
    this.NSEQ,
    this.VCOND,
    this.VATTCHNAMEID,
    this.VFILE,
  });

  factory Attachment.fromJson(Map<String, dynamic> map) {
    return Attachment(
      XIP_VNODOC: map["XIP_VNODOC"],
      NBEFAFT: map["NBEFAFT"].toString(),
      NSEQ: map["NSEQ"].toString(),
      VCOND: map["VCOND"],
      VATTCHNAMEID: map["VATTCHNAMEID"],
      VFILE: map["VFILE"],
    );
  }
}
//END DETAIL IP

DetIdeProposal detIpFromJson(String jsonData) {
  final data = json.decode(jsonData);
  AjaxResponse jsonResponse = new AjaxResponse.fromJson(data);
  return jsonResponse.data;
  //List<AjaxResponse>.from(data.map((item) => AjaxResponse.fromJson(item)));
}
