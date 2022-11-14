import 'package:ai_control/app_localizations.dart';
import 'package:ai_control/models/pdf_model/customer.dart';
import 'package:ai_control/models/pdf_model/invoice.dart';
import 'package:ai_control/models/pdf_model/supplier.dart';
import 'package:ai_control/modules/pdf_api/pdf_api.dart';
import 'package:ai_control/modules/pdf_api/pdf_invoice_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../bloc/main_cubit/main_states.dart';
import '../../bloc/main_cubit/mian_cubit.dart';

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStutes>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var model = SocialCubit.get(context).userModel;

        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: HexColor('#2888ff'),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 6, top: 10),
                            child: Text(
                              "Patient Informations!".tr(context),
                              style: Theme.of(context).textTheme.headline4
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 6, right: 4, bottom: 10),
                            child: Text(
                              "please connect the ECG device before you click on the start button!".tr(context),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Patient Name : ".tr(context),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Expanded(
                                child: Text(
                                  model?.name ?? "loading..".tr(context),
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Patient age : ".tr(context),
                                style:  Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                '21',
                                style:  TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Patient gender : ".tr(context),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "Male".tr(context),
                                style:  TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Patient phone number : ".tr(context),
                                style: Theme.of(context).textTheme.bodyText1
                              ),
                              Expanded(
                                child: Text(
                                  model?.phone ?? 'loading..'.tr(context),
                                  style:  TextStyle(color: Colors.blueGrey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Patient location : ".tr(context),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Expanded(
                                child: Text(
                                  "Abu Hammad, Asharqia, Egypt".tr(context),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Patient state : ".tr(context),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                               "Negative".tr(context),
                                style:  TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color: Colors.blue,
                            )),
                        onPressed: () async {
                          final date = DateTime.now();
                          final dueDate = date.add(Duration(days: 7));

                          final invoice = Invoice(
                            supplier: Supplier(
                              name: "Zagazig University".tr(context),
                              address: "The university supervising the project".tr(context),
                              paymentInfo: 'ai.control@gmail.com',
                            ),
                            customer: Customer(
                              name: "DR/ Amr abdellatife".tr(context),
                              address: "The doctor supervising the project".tr(context),
                            ),
                            info: InvoiceInfo(
                              date: date,
                              dueDate: dueDate,
                              description: "our beautiful team".tr(context),
                              number: '${DateTime.now().year}-9999',
                            ),
                            items: [
                              InvoiceItem(
                                description: "Patient Name".tr(context),
                                date: DateTime.now(),
                                information:model?.name ??"loading..".tr(context),

                              ),
                              InvoiceItem(
                                description: "Patient Age".tr(context),
                                date: DateTime.now(),
                                information:  '21',

                              ),
                              InvoiceItem(
                                description: "Patient Gender".tr(context),
                                date: DateTime.now(),
                                information:"Male".tr(context) ,

                              ),
                              InvoiceItem(
                                description: "Patient Phone Number".tr(context),
                                date: DateTime.now(),
                                information:  model?.phone ?? "loading..".tr(context),


                              ),
                              InvoiceItem(
                                description: "Patient Location".tr(context),
                                date: DateTime.now(),
                                information: "Abu Hammad, Asharqia,Egypt".tr(context),
                              ),
                              InvoiceItem(
                                description: "Patient State".tr(context),
                                date: DateTime.now(),
                               information: "Negative".tr(context)
                              ),

                            ],
                          );

                          final pdfFile = await PdfInvoiceApi.generate(invoice);

                          PdfApi.openFile(pdfFile);
                        },
                        color: HexColor('#2888ff'),
                        textColor: Theme.of(context).scaffoldBackgroundColor,
                        child: Row(
                          children: [
                            Icon(Icons.download_sharp),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Download".tr(context),
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
