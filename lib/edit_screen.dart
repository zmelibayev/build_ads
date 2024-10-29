import 'package:build_ads/provider_fb.dart';
import 'package:build_ads/provider_pick_img.dart';
import 'package:flutter/material.dart';
import 'package:build_ads/model.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final AdsModel adsItem;

  const EditScreen({required this.adsItem, super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController homePlaceController;
  late TextEditingController homeScaleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.adsItem.adsName);
    priceController = TextEditingController(text: widget.adsItem.adsPrice);
    homePlaceController =
        TextEditingController(text: widget.adsItem.housePlace);
    homeScaleController = TextEditingController(text: widget.adsItem.homeScale);
    descriptionController =
        TextEditingController(text: widget.adsItem.adsDescription);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    homePlaceController.dispose();
    homeScaleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final updImageUrl = widget.adsItem.adsImgUrl;
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Provider.of<ImagePickProvider>(context,
                                      listen: false)
                                  .clearImage();
                            },
                            icon: const Icon(Icons.arrow_back_ios_rounded)),
                        const Text(
                          'Edit Page',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              // Обновление данных
                              final updatedAd = AdsModel(
                                  id: widget.adsItem.id,
                                  adsName: nameController.text,
                                  adsPrice: priceController.text,
                                  housePlace: homePlaceController.text,
                                  homeScale: homeScaleController.text,
                                  adsDescription: descriptionController.text,
                                  adsImgUrl: Provider.of<ImagePickProvider>(
                                          context,
                                          listen: false)
                                      .downloadURL! // Используем старый URL картинки
                                  );
                              Provider.of<AdsProvider>(context, listen: false)
                                  .updateAdsPrv(widget.adsItem.id, updatedAd);
                              // Возвращаем обновленные данные
                              Navigator.of(context).pop(updatedAd);

                              Provider.of<ImagePickProvider>(context,
                                      listen: false)
                                  .clearImage();
                            },
                            icon: const Icon(
                              Icons.check,
                              size: 30,
                            ))
                      ],
                    ),

//----------------------------------------------------------------------------
                    SizedBox(
                      height: 220,
                      width: 220,
                      child: Stack(
                        children: [
                          Center(
                            child: Consumer<ImagePickProvider>(
                              builder: (context, imageProvider, child) {
                                return imageProvider.pickedImage != null
                                    ? Container(
                                        decoration: BoxDecoration(
                                            boxShadow: kElevationToShadow[8]),
                                        height: 180,
                                        width: 180,
                                        child: Image.file(
                                          imageProvider.pickedImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            boxShadow: kElevationToShadow[8]),
                                        height: 180,
                                        width: 180,
                                        child: Image.network(
                                          updImageUrl,
                                          fit: BoxFit.cover,
                                        ));
                              },
                            ),
                          ),
                          //--------------------------------------------
                          Positioned(
                            left: 170,
                            bottom: 0,
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                color: Colors.black38,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Provider.of<ImagePickProvider>(context,
                                          listen: false)
                                      .pickImage();
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

//-----------------------------------------------------------------------------------------
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'House Name',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'House Price',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: homePlaceController,
                      decoration: const InputDecoration(
                        labelText: 'House Place',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: homeScaleController,
                      decoration: const InputDecoration(
                        labelText: 'House Scale',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descriptionController,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
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
