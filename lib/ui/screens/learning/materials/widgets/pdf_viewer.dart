import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewer extends StatelessWidget {
  final String url;

  const PdfViewer({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDF().cachedFromUrl(
      url,
      placeholder: (progress) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('$progress %'),
          ],
        ),
      ),
      errorWidget: (error) => Center(child: Text(error.toString())),
    );
  }
}
