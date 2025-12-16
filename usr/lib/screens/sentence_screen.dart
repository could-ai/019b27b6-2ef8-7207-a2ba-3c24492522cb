import 'package:flutter/material.dart';
import '../services/mock_nlp_service.dart';

class SentenceScreen extends StatefulWidget {
  const SentenceScreen({super.key});

  @override
  State<SentenceScreen> createState() => _SentenceScreenState();
}

class _SentenceScreenState extends State<SentenceScreen> {
  final TextEditingController _inputController = TextEditingController();
  final MockNLPService _nlpService = MockNLPService();
  String _output = '';
  String _selectedOption = 'Classify';

  final List<String> _options = [
    'Classify',
    'Sentiment',
    'Error Check',
  ];

  void _processSentence() {
    final sentence = _inputController.text.trim();
    if (sentence.isEmpty) {
      setState(() {
        _output = 'Please enter a sentence.';
      });
      return;
    }

    String result = '';
    switch (_selectedOption) {
      case 'Classify':
        result = _nlpService.classifySentence(sentence);
        break;
      case 'Sentiment':
        result = _nlpService.analyzeSentiment(sentence);
        break;
      case 'Error Check':
        result = _nlpService.checkSentenceErrors(sentence);
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
        title: const Text('Sentence Analysis'),
        backgroundColor: Colors.green.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter a sentence:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'e.g., The quick brown fox jumps over the lazy dog.',
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
              onPressed: _processSentence,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Analyze Sentence'),
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
