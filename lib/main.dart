import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HabitsPage(),
    );
  }
}

class HabitsPage extends StatefulWidget {
  const HabitsPage({super.key});

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  bool isDone1 = false;
  bool isDone2 = false;
  bool isDone3 = false;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _userName = '';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _buildHabitCard({
    required String title,
    required String time,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(value: value, onChanged: onChanged),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text(_userName.isEmpty ? 'Мой день' : 'Привет, $_userName!'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          _buildHabitCard(
            title: 'Зарядка',
            time: '07:00',
            value: isDone1,
            onChanged: (v) {
              setState(() => isDone1 = v ?? false);
            },
          ),
          _buildHabitCard(
            title: 'Чтение книги',
            time: '19:00',
            value: isDone2,
            onChanged: (v) {
              setState(() => isDone2 = v ?? false);
            },
          ),
          _buildHabitCard(
            title: 'Прогулка',
            time: '21:00',
            value: isDone3,
            onChanged: (v) {
              setState(() => isDone3 = v ?? false);
            },
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Имя или новая цель дня',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Поле не должно быть пустым';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _userName = _nameController.text.trim();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Сохранить'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
