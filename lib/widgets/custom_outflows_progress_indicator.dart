import 'package:finances/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:provider/provider.dart';

class CustomOutflowProgressIndicator extends StatelessWidget {
  const CustomOutflowProgressIndicator({super.key});

  static Color orangeColor = Color(0xFFffd463);
  static Color purpleColor = Color(0xFF68548e);

  static Color boxColor = Colors.white;
  static double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    int freePers = financeProvider.freePers.toInt();
    double progress = financeProvider.percentageExpense;

    var textStyleGray = const TextStyle(color: Color(0xff959595), fontSize: 16);
    var textStyleFree = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );

/*|
*/

    return Padding(
      padding: EdgeInsets.all(30),
      child: DashedCircularProgressBar.aspectRatio(
        aspectRatio: 1.1,
        progress: progress,
        startAngle: 225,
        sweepAngle: 270,
        foregroundColor: orangeColor,
        backgroundColor: purpleColor,
        foregroundStrokeWidth: 4,
        backgroundStrokeWidth: 15,
        seekSize: 10,
        seekColor: Color(0xffeeeeee),
        animation: true,
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Monto disponible actual', style: textStyleGray),
              SizedBox(height: 15),
              Text('S/ $freePers', style: textStyleFree),
              SizedBox(height: 15),
              Text(
                'Porcentaje consumido: ${progress.toInt()}%',
                style: textStyleGray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
