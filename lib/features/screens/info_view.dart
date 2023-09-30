import 'package:crud_riverpod/Providers/firebase_provider.dart';
import 'package:crud_riverpod/models/detialsModel.dart';
import 'package:crud_riverpod/theme/color_bundel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

class InfoView extends ConsumerStatefulWidget {
  final DetailModel data;
   InfoView({super.key,required this.data});

  @override
  ConsumerState<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends ConsumerState<InfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: w * 0.18,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 10),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Figma(),
                              ));
                        },
                        child: Icon(
                          CupertinoIcons.back,
                          size: w * 0.08,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: h * 0.8,
                width: w * 1,
                decoration: BoxDecoration(
                    color: ColorBundle.themeColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const []),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: w * 0.06,
                    ),
                    Container(
                      height: w * 0.06,
                      width: w * 0.18,
                      decoration: BoxDecoration(
                        color: ColorBundle.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(
                      height: w * 0.06,
                    ),
                    Container(
                      height: w * 0.6,
                      width: w * 0.6,

                      decoration: BoxDecoration(
                        color: ColorBundle.white,

                        image: DecorationImage(image: NetworkImage(widget.data.imageUrl.toString()),fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      height: w * 0.06,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Name :${widget.data.firstName+widget.data.lastName}",
                                style: TextStyle(color: ColorBundle.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: w * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("E_mail : ${widget.data.email}",
                                  style: TextStyle(color: ColorBundle.white)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: w * 0.03,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     children: [
                        //       Text("Phone : ${widget.data.address}",
                        //           style: TextStyle(color: ColorBundle.white)),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: w * 0.03,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Address : ${widget.data.address}",
                                  style: TextStyle(color: ColorBundle.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
