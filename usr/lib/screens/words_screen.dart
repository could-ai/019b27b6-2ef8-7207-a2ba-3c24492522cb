import 'package:flutter/material.dart';
import '../services/mock_nlp_service.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({super.key});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  final TextEditingController _inputController = TextEditingController();
  final MockNLPService _nlpService = MockNLPService();
  String _output = '';
  String _selectedOption = 'Definition';

  final List<String> _options = [
    'Pluralize',
    'Singularize',
    'Type',
    'Form if verb',
    'Definition',
    'Correct Spelling',
  ];

  void _processWord() {
    final word = _inputController.text.trim();
    if (word.isEmpty) {
      setState(() {
        _output = 'Please enter a word.';
      });
      return;
    }

    // Basic validation to ensure it's a single word
    if (word.contains(' ')) {
      setState(() {
        _output = 'Please enter only a single word.';
      });
      return;
    }

    String result = '';
    switch (_selectedOption) {
      case 'Pluralize':
        result = _nlpService.pluralize(word);
        break;
      case 'Singularize':
        result = _nlpService.singularize(word);
        break;
      case 'Type':
        result = _nlpService.getWordType(word);
        break;
      case 'Form if verb':
        result = _nlpService.getVerbBaseForm(word);
        break;
      case 'Definition':
        result = _nlpService.getDefinition(word);
        break;
      case 'Correct Spelling':
        result = _nlpService.correctSpelling(word);
        break;
    }

    setState(() {
      _output = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Analysis'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter a single word:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'e.g., Apple, Run, Happy',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Operation:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedOption,
                  isExpanded: true,
                  items: _options.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedOption = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _processWord,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Analyze Word'),
            ),
            const SizedBox(height: 30),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _output.isEmpty ? 'Result will appear here' : _output,
                style: TextStyle(
                  fontSize: 16,
                  color: _output.isEmpty ? Colors.grey : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
