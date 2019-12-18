import 'package:flutter/material.dart';
import 'package:reminder/core/static/c_s_styles.dart';
import 'package:reminder/features/prescriptions/presentation/widgets/f_presc_form_widget.dart';

class PrescriptionPage extends StatefulWidget {
  PrescriptionPage({Key key}) : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Text("hello"),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: MaterialButton(
              height: 60.0,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: FPrescFormWidget(),
                    );
                  },
                );
              },
              color: Colors.blue,
              shape: CircleBorder(),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
