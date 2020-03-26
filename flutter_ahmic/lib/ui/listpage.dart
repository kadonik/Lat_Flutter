import 'package:flutter/material.dart';
import 'package:flutter_ahmic/api/api_ide_proposal.dart';
import 'package:flutter_ahmic/models/ide_proposal.dart';
import 'package:flutter_ahmic/models/det_ide_proposal.dart';

class ListPage extends StatefulWidget {
  final String title;

  ListPage({Key key, this.title}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ApiIdeProposal apiIdeProposal;

  @override
  void initState() {
    super.initState();
    apiIdeProposal = ApiIdeProposal();
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: SafeArea(
        child: FutureBuilder(
            future: apiIdeProposal.getStatusIp(),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<IdeProposal>> snapshot,
            ) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                      "Something wrong with message: ${snapshot.error.toString()}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<IdeProposal> ipList = snapshot.data;
                print(ipList.map((i) => i.VDOCNO).toString());
                return _buildListView(ipList);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );

    // Scaffold(
    //   backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    //   appBar: topAppBar,
    //   body: _buildCard(),
    // );
  }

  Widget _buildListView(List<IdeProposal> ipList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: ListView.builder(
          itemCount: ipList.length,
          itemBuilder: (context, index) {
            IdeProposal ip = ipList[index];
            return Card(
              elevation: 8.0,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => DetailPageIp(ip)),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("No. Registrasi"),
                              Divider(
                                height: 5.0,
                              ),
                              Text(ip.VDOCNO),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("Tema Proposal"),
                              Divider(
                                height: 5.0,
                              ),
                              Text(ip.VTEMAIP),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("Tgl. Pengajuan"),
                              Divider(
                                height: 5.0,
                              ),
                              Text(ip.DSUBMIT),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text("Status"),
                                      Divider(
                                        height: 5.0,
                                      ),
                                      Text(ip.VSTATUS),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text("Grade"),
                                      Divider(
                                        height: 5.0,
                                      ),
                                      Text(ip.VGRADE ?? "-"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class DetailPageIp extends StatefulWidget {
  final IdeProposal ip;

  DetailPageIp(this.ip);

  @override
  _DetailPageIpState createState() => _DetailPageIpState();
}

class _DetailPageIpState extends State<DetailPageIp> {
  ApiIdeProposal apiIdeProposal;

  @override
  void initState() {
    super.initState();
    apiIdeProposal = ApiIdeProposal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Detail Ide Proposal"),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: apiIdeProposal.getDetailIp(widget.ip.VDOCNO),
            builder: (
              BuildContext context,
              AsyncSnapshot<DetIdeProposal> snapshot,
            ) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                      "Something wrong with message: ${snapshot.error.toString()}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                DetIdeProposal detailIp = snapshot.data;
                print(detailIp.VDOCNO.toString());
                return _buildDetailView(detailIp);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget _buildDetailView(DetIdeProposal detailIp) {
    var att = detailIp.ATTACTHMENTS;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: <Widget>[
            Card(
               elevation: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(title: Text("Tema Proposal"),subtitle: Text(detailIp.VTEMAIP)),
                ],
              ),
            ),
            Card(
              elevation: 10.0,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[                
                    ListTile(title: Text("Ide Berdampak Pada"),subtitle: Text("Kualitas/Biaya/Pengiriman/Keselamatan/Moral")),
                    ListTile(title: Text("Kualitas"),subtitle: Text(detailIp.VQUALITY ?? "-")),
                    ListTile(title: Text("Biaya"),subtitle: Text(detailIp.VCOST ?? "-")),
                    ListTile(title: Text("Pengiriman"),subtitle: Text(detailIp.VDELIVERY ?? "-")),
                    ListTile(title: Text("Keselamatan"),subtitle: Text(detailIp.VSAFETY ?? "-")),
                    ListTile(title: Text("Moral"),subtitle: Text(detailIp.VMORAL ?? "-")),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: att.length,
                itemBuilder: (context, index) {
                  Attachment _attachment = att[index];
                  return Card(
                    elevation: 10.0,
                    child: Column(
                      children: <Widget>[
                        CustomListItemTwo(
                          title: 'Lampiran',
                          subtitle: _attachment.VCOND,
                          author: _attachment.VATTCHNAMEID.substring(
                              _attachment.VATTCHNAMEID.indexOf("_") + 1,
                              _attachment.VATTCHNAMEID.length),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '$author',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.thumbnail,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
