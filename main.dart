import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoanCalculatorBloc extends Cubit<double> {
  LoanCalculatorBloc() : super(8355.92);

  void calculateEMI(double principal, double rate, int term) {
    double interest = rate / 1200;
    double emi = principal *
        interest *
        pow(1 + interest, term) /
        (pow(1 + interest, term) - 1);
    emit(emi);
  }
}

class LoanCalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan EMI Calculator'),
      ),
      body: BlocProvider(
        create: (context) => LoanCalculatorBloc(),
        child: LoanCalculatorForm(),
      ),
    );
  }
}

class LoanCalculatorForm extends StatefulWidget {
  @override
  _LoanCalculatorFormState createState() => _LoanCalculatorFormState();
}

class _LoanCalculatorFormState extends State<LoanCalculatorForm> {
  final _formKey = GlobalKey<FormState>();
  double _principal = 100000;
  double _rate = 0.5;
  double _term = 12;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Principal Amount: $_principal'),
            Slider(
              value: _principal,
              min: 100000,
              max: 10000000,
              divisions: 990,
              label: _principal.toStringAsFixed(0),
              onChanged: (value) {
                setState(() {
                  _principal = value;
                });
              },
            ),
            Text('Interest Rate (%): $_rate'),
            Slider(
              value: _rate,
              min: 0.5,
              max: 15,
              divisions: 295,
              label: _rate.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _rate = value;
                });
              },
            ),
            Text('Loan Term (Years): ${_term ~/ 12}'),
            Slider(
              value: _term,
              min: 12,
              max: 360,
              divisions: 29,
              label: '${(_term ~/ 12).toString()}',
              onChanged: (value) {
                setState(() {
                  _term = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context
                    .read<LoanCalculatorBloc>()
                    .calculateEMI(_principal, _rate, _term.toInt());
              },
              child: Text('Calculate EMI'),
            ),
            SizedBox(height: 20),
            BlocBuilder<LoanCalculatorBloc, double>(
              builder: (context, state) {
                return Text(
                  'EMI: ${state.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoanCalculatorPage(),
  ));
}
