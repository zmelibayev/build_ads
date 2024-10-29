import 'dart:ui';

import 'package:build_ads/model.dart';
import 'package:build_ads/provider_fb.dart';
import 'package:build_ads/provider_pick_img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  ImagePicker imgPick = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController homePlaceController = TextEditingController();
  TextEditingController homeScaleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
//  dispose() ва initStat() StatefulWidget га тегишли
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
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
                        const SizedBox(
                          height: 45,
                        ),
                        //---------------------------------------------------------------
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
                                                boxShadow:
                                                    kElevationToShadow[8]),
                                            height: 180,
                                            width: 180,
                                            child: Image.file(
                                              imageProvider.pickedImage!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SizedBox(
                                                height: 180,
                                                width: 180,
                                                child: Image.asset(
                                                  'assets/avatar.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                height: 220,
                                                width: 220,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black38,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          );
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
                        //---------------------------------------------------------------
                        const SizedBox(height: 15),
                        TextField(
                          controller: nameController,
                          decoration:
                              const InputDecoration(hintText: 'House Name'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: priceController,
                          decoration:
                              const InputDecoration(hintText: 'House price'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: homePlaceController,
                          decoration:
                              const InputDecoration(hintText: 'House place'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: homeScaleController,
                          decoration:
                              const InputDecoration(hintText: 'House scale'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: descriptionController,
                          maxLines: 8,
                          decoration: const InputDecoration(
                              hintText: 'House Description'),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final newItem = AdsModel(
                              adsName: nameController.text,
                              housePlace: homePlaceController.text,
                              homeScale: homeScaleController.text,
                              adsDescription: descriptionController.text,
                              adsPrice: priceController.text,
                              adsImgUrl: Provider.of<ImagePickProvider>(context,
                                      listen: false)
                                  .downloadURL!,
                            );

                            Provider.of<AdsProvider>(context, listen: false)
                                .addAdsPrv(newItem);

                            Navigator.pop(context);

                            Provider.of<ImagePickProvider>(context,
                                    listen: false)
                                .clearImage();
                          },
                          child: const Text('Add ads'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 80,
            color: Colors.amber,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/builder.jpg', fit: BoxFit.cover),
                ClipRRect(
                  // Clip it cleanly.
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.grey.withOpacity(0.1),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Provider.of<ImagePickProvider>(context,
                                          listen: false)
                                      .clearImage();
                                },
                                icon: const Icon(Icons.arrow_back)),
                            const Text(
                              'Yangi e\'lonlar q\'shish',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.check,
                                  size: 30,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
