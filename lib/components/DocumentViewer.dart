
// import 'dart:html';
import 'dart:io' show Directory, File, Platform;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/constants.dart';
import 'package:nic/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocViewer extends StatefulWidget {
  final String? path;
  final String? title;

  DocViewer({this.title, this.path});

  @override
  _DocViewerState createState() => _DocViewerState(this.title, this.path);
}

class _DocViewerState extends State<DocViewer> {
  String? title;
  String? path;
  bool downloading = false;
  String downloadingStr = "No data";
  String savePath = "";
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double downloadingNum = 0;
  double download = 0.0;
  // PDFDocument? document;

  _DocViewerState(this.title, this.path);

  @override
  void initState() {
    super.initState();
  }

  Future downloadFile(String? imageUrl, String? title) async {

    dynamic saved;
    try {
      DateTime time = DateTime.now();
      var milSec = time.millisecondsSinceEpoch;
      String fileName = "${title}_${milSec}.pdf";

      saved = await saveFile(imageUrl,fileName);
      print("saved-----:${saved}");
      if (saved) {
        setState(() {
          downloading = false;
          downloadingStr = "Download Completed";
          downloadingNum = 1;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(
                  width: 3.0,
                ),
                Flexible(
                  child: Text(
                    "${downloadingStr}",
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              ],
            ),
            duration: Duration(seconds: 6),
          ),
        );
      }
    } catch (e) {
      print("Error message--:${e.toString()}");
    }
  }
  Future<bool> saveFile(url,uniqueFileName) async {
    String path = '';
    Directory? dir;
    String newPath = "";
    Dio dio = Dio();

    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          dir = await getExternalStorageDirectory();
          List<String> folders = dir!.path.split("/");
          for (int x = 1; x < folders.length; x ++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          String? p = '/storage/emulated/0/NIC_Kiganjani';
          dir = Directory(p);
          path = dir.path;
        }else{
          return false;
        }
      }
      else {
        if (await _requestPermission(Permission.storage)) {
          dir = await getApplicationDocumentsDirectory();
          path = dir.path + '/01 Policy Documents';
        } else {
          return false;
        }
      }

      if (await dir.exists()) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }

        File saveFile = File(path + "/${uniqueFileName}");
        await dio.download(url!, saveFile.path, onReceiveProgress: (rec, total) {
          setState(() {
            downloading = true;
            download = (rec / total) * 100;
            downloadingStr = "Downloading Image : $rec" ;
            downloadingNum = 0;
          });
        } );
      }
      print("end-------${download}");
      return true;
    } catch(e){
      print('error for 1111--:${e}');
    }
    return false;
  }
  Future<bool> _requestPermission(Permission permission) async {
    if(await permission.isGranted){
      return true;
    }else{
      var result = await permission.request();
      if(result == PermissionStatus.granted){
        return true;
      }else{
        return false;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    String pathData = this.path!.replaceAll("FalseFalse", "False").replaceAll("TrueTrue", "True").replaceAll("http", "https").replaceAll("httpss", "https");
    // pathData = "http://imis.nictanzania.co.tz/reports/output?__report=invoice_taxinvoice.rptdesign&__navigationbar=true&&__format=pdf&__pageoverflow=0&__overwrite=false&CustomerPolicyId=475899&corporate=False";
    // print(pathData);

    return
      RoundedHeaderPage(
        // showBackButton: true,
        title: widget.title,
        floatButton: FloatingActionButton(
          onPressed: () {
            downloadFile(pathData,title);
          },
          backgroundColor: Constants.primaryColor,
          foregroundColor: colorScheme(context).onSecondaryContainer,
          shape: const CircleBorder(),
          child: downloading? const SizedBox(
              width:25,
              height: 20,
              child:CircularProgressIndicator(
                  backgroundColor: Colors.white
              )
          ) :  const Icon(Icons.download,color: Colors.white)
        ),
        child: SfPdfViewer.network(pathData),
      );
  }

}
