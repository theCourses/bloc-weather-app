import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController textEditingController;
  final _formKey = GlobalKey<FormState>();
  String? _city;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  autofocus: true,
                  style: const TextStyle(fontSize: 18.0),
                  validator: (String? input) {
                    if (input == null || input.trim().length < 2) {
                      return 'City name must be at least 2 character';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'City name',
                      hintText: 'More than 2 characters',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder()),
                  onSaved: (String? input) {
                    _city = input;
                  },
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  autovalidateMode = AutovalidateMode.always;
                });
                final form = _formKey.currentState;
                if (form != null && form.validate()) {
                  form.save();
                  Navigator.pop(context, _city!.trim());
                }
              },
              child: const Text("show weather"),
            )
          ],
        )),
      ),
    ));
  }
}
