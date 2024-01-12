import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get appTheme => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.blue,
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserratAlternates(),
        titleMedium: GoogleFonts.montserratAlternates(fontSize: 35),
      ),
    );
