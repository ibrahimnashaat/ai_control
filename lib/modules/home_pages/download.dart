
import 'package:ai_control/models/pdf_model/customer.dart';
import 'package:ai_control/models/pdf_model/invoice.dart';
import 'package:ai_control/models/pdf_model/supplier.dart';
import 'package:ai_control/modules/pdf_api/pdf_api.dart';
import 'package:ai_control/modules/pdf_api/pdf_invoice_api.dart';
import 'package:ai_control/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../bloc/main_cubit/main_states.dart';
import '../../bloc/main_cubit/mian_cubit.dart';
import '../../models/class_user_model.dart';
import '../../shared/constatnts/constants.dart';



class Download extends StatelessWidget {
   Download({Key? key}) : super(key: key);


   // UserModel? model;





  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStutes>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state)  {


        // final uId = FirebaseAuth.instance.currentUser?.uid;
        //
        // FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
        //   model = UserModel.fromJson(value.data()!);
        // });
         final model = SocialCubit.get(context).userModel;




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
                              'Patient Informations!',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 6, right: 4, bottom: 10),
                            child: Text(
                              'please connect the ECG device before you click on the start button!',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
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
                                'Patient Name : ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                             Expanded(
                                child: Text(
                                 '${model?.name}',
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
                                'Patient age : ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                              Text(
                                '21',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                'Patient gender : ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                              Text(
                                'Male',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                'Patient phone number : ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                              Expanded(
                                child: Text(
                                  '${model?.phone}',
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
                                'Patient location : ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                              Expanded(
                                child: Text(
                                  'Abu Hammad, Asharqia, Egypt',
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
                                'Patient state : ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                              Text(
                                'Negative',
                                style: TextStyle(color: Colors.blueGrey),
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
                              name: 'Zagazig University',
                              address: 'The university supervising the project',
                              paymentInfo: 'ai.control@gmail.com',
                            ),
                            customer: Customer(
                              name: 'DR/ Amr abdellatife',
                              address: 'The doctor supervising the project',
                            ),
                            info: InvoiceInfo(
                              date: date,
                              dueDate: dueDate,
                              description: 'our beautiful team',
                              number: '${DateTime.now().year}-9999',
                            ),
                            items: [
                              InvoiceItem(
                                description: 'Patient Name',
                                date: DateTime.now(),
                                information:model?.name ?? 'loading..',

                              ),
                              InvoiceItem(
                                description: 'Patient Age',
                                date: DateTime.now(),
                                information:  '21',

                              ),
                              InvoiceItem(
                                description: 'Patient Gender',
                                date: DateTime.now(),
                                information:'Male' ,

                              ),
                              InvoiceItem(
                                description: 'Patient Phone Number',
                                date: DateTime.now(),
                                information:  model?.phone ?? 'loading..',


                              ),
                              InvoiceItem(
                                description: 'Patient Location',
                                date: DateTime.now(),
                                information: 'Abu Hammad, Asharqia,Egypt',
                              ),
                              InvoiceItem(
                                description: 'Patient State',
                                date: DateTime.now(),
                               information: 'Negative'
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
                              "Download",
                              style: TextStyle(fontSize: 28),
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
