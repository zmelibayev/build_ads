import 'package:build_ads/edit_screen.dart';
import 'package:build_ads/home_page.dart';
import 'package:build_ads/model.dart';
import 'package:build_ads/provider_fb.dart';
import 'package:build_ads/provider_pick_img.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final AdsModel details;
  const DetailScreen({required this.details, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final imgUrl = widget.details.adsImgUrl;
    //------------------------------------------------
    Future<void> showDeleteDialog(BuildContext context) async {
      return showDialog<void>(
        context: context, // Передаем контекст
        barrierDismissible:
            false, // Пользователь должен нажать кнопку для закрытия
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '"${widget.details.adsName.toUpperCase().trim()}"',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Ushbu e\'lonni o\'chirmoqchimisiz?',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                  fontSize: 18,
                )),
                child: const Text('Ha'),
                onPressed: () {
                  Provider.of<AdsProvider>(context, listen: false)
                      .deleteAdsPrv(widget.details.id);

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));

                  Provider.of<ImagePickProvider>(context, listen: false)
                      .clearImage();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                  fontSize: 18,
                )),
                child: const Text('Yo\'q'),
                onPressed: () {
                  Navigator.of(context).pop(); // Закрываем диалог
                },
              ),
            ],
          );
        },
      );
    }

    //-----------------------------------------------

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                boxShadow: kElevationToShadow[2],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back_ios_rounded)),
                        const Text(
                          'Details Page',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        //--------------------------------------------------------------------------------
                        IconButton(
                          onPressed: () async {
                            //----------------------
                            Provider.of<ImagePickProvider>(context,
                                    listen: false)
                                .clearImage();
                            //----------------------
                            // Открываем экран редактирования и ждем результат
                            final updatedAds =
                                await Navigator.of(context).push<AdsModel>(
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditScreen(adsItem: widget.details),
                              ),
                            );

                            // Если пользователь сохранил изменения, обновляем экран
                            if (updatedAds != null) {
                              setState(() {
                                widget.details.adsName = updatedAds.adsName;
                                widget.details.adsPrice = updatedAds.adsPrice;
                                widget.details.housePlace =
                                    updatedAds.housePlace;
                                widget.details.homeScale = updatedAds.homeScale;
                                widget.details.adsDescription =
                                    updatedAds.adsDescription;
                                widget.details.adsImgUrl = updatedAds.adsImgUrl;
                              });
                            }
                          },
                          icon: const Icon(Icons.mode_edit_outline),
                        ),
                      ],
                    ),
                    //----------------------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.amber),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              onPressed: () {
                                //---------------
                                showDeleteDialog(context);
                              },
                              icon: const Icon(
                                Icons.delete,
                              )),
                        ),
                      ],
                    ),

                    Center(
                      child: Container(
                        decoration:
                            BoxDecoration(boxShadow: kElevationToShadow[8]),
                        height: 180,
                        width: 180,
                        child: Image.network(
                          imgUrl.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //------------------------------------------------------------
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Text(
                        widget.details.adsName.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    txtStyle('Narxi:', widget.details.adsPrice),
                    const SizedBox(
                      height: 10,
                    ),
                    txtStyle('Umumiy maydoni:', widget.details.housePlace),
                    const SizedBox(
                      height: 10,
                    ),
                    txtStyle('O\'lchamlari:', widget.details.homeScale),
                    const SizedBox(
                      height: 10,
                    ),
                    txtStyle(
                        'To\'liq ma\'limot:', widget.details.adsDescription),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget txtStyle(String txtName, String text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(txtName),
      const SizedBox(
        height: 5,
      ),
      Text(
        text.toString(),
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.lightGreen),
      ),
    ],
  );
}
