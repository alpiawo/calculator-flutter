import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
            color: Colors.white,
          ))),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  // class ini mrmaiaki statefull widget karena salalu memiliki nnilai yang selau berubah ketika tombol ditekan
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output =
      "0"; // variable untuk menampung hasil dari perhitungan ayau menampung nilai yang akan ditampilkan

  void buttonPressed(String buttonText) {
    // fungsi buttonPressed akan dipanggil ketika tombol ditekan
    setState(() {
      if (buttonText == "C") {
        // Jika C ditekan, akan menghasilkan nilai output menjadi 0
        output = "0";
      } else if (buttonText == "=") {
        // Jika = ditekan, akan melakukan perhitungan yang telah disimpan di output
        try {
          output = evaluateExpression(
            output.replaceAll('x', '*'));
        } catch (e) {
          // jika terjadi kesalahan dalam perhitungan maka akan menampilkan pesan kesalahan atau bagian ini menangani kesalahan
          output = "error";
        }
      } else {
        if (output == "0") {
          output = buttonText;
        } else {
          output += buttonText;
        }
      }
    });
  }

  String evaluateExpression(String expressions) {
    // fungsi ini akan mengubah ekspresi hasil perhitungan
    final parsedExpressions = Expression.parse(expressions);
    // mengonversi string untuk dipahami oleh system
    final evaluator = ExpressionEvaluator();
    final result = evaluator.eval(parsedExpressions, {});
    // untuk mengevaluasi expression dan mengembalikan nilai sebagai String
    return result.toString();
    // mengembalikan nilai kepada String
  }

  Widget buildButton(String buttonText, Color color,
      {double widthFactor = 1.0}) {
    return Expanded(
      // membuat tombol dapat mengisi ruang horizontal yang terssedia dalam 1 row
      flex: widthFactor.toInt(),
      // untuk menentukan lebar tombol menjadi 1. flex digunakan menentukan proporsi lebar tombol dalam row
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          // digunakan untuk membuat tombol dengan gaya tertentu
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 22),
            // untuk menentukan jarak dalam tombol secara vertical
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              // menentukan radius kotak tombol
            ),
            elevation: 0,
            // mengatur bayangan tombol menjadi 0, tampak datar
          ),
          onPressed: () => buttonPressed(buttonText),
          // fungsi ini akan dipanggil ketika ditekan, dan dipanggil dengan paraameter bttonText
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              // mengatur ukuran huruf dan font tombol
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext contex) {
    // tampilan utama
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // untuk menyesuaikan lebar tombol, agar tidak lebar sesuai textnta masing-masing
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 24, bottom: 24),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 80, color: Colors.white),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  buildButton("C", Colors.grey.shade600),
                  buildButton("+/-", Colors.grey.shade600),
                  buildButton("%", Colors.grey.shade600),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("7", Colors.grey.shade800), 
                  buildButton("8", Colors.grey.shade800),
                  buildButton("9", Colors.grey.shade800), 
                  buildButton("x", Colors.orange), 
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", Colors.grey.shade800), 
                  buildButton("5", Colors.grey.shade800),
                  buildButton("6", Colors.grey.shade800), 
                  buildButton("-", Colors.orange), 
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", Colors.grey.shade800), 
                  buildButton("2", Colors.grey.shade800),
                  buildButton("3", Colors.grey.shade800), 
                  buildButton("+", Colors.orange), 
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("0", Colors.grey.shade800, widthFactor: 2), 
                  buildButton(".", Colors.grey.shade800),
                  buildButton("=", Colors.orange), 
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
