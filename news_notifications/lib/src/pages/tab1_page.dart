import 'package:flutter/material.dart';
import 'package:news_notifications/src/services/news_service.dart';
import 'package:news_notifications/src/widgets/lista_noticia.dart';
import 'package:provider/provider.dart';

class Page1Screen extends StatefulWidget {
  const Page1Screen({Key? key}) : super(key: key);

  @override
  State<Page1Screen> createState() => _Page1ScreenState();
}

class _Page1ScreenState extends State<Page1Screen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final headLines = Provider.of<NewsService>(context).headLines;

    return Scaffold(
      body: (headLines.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListaNoticias(noticias: headLines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
