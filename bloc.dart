import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoanCalculatorBloc extends Cubit<double> {
  LoanCalculatorBloc() : super(0.0);

  void calculateEMI(double principal, double rate, int term) {
    double interest = rate / 1200;
    double emi = principal *
        interest *
        pow(1 + interest, term) /
        (pow(1 + interest, term) - 1);
    emit(emi);
  }
}
