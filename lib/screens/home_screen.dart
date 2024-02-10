import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE7626C),
              ),
            ),
          ),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF232B55),
              ),
            ),
          ),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE7626C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
