import 'package:flutter/material.dart';
import 'package:flutter33_hava_durumu_app/bloc/weather_bloc.dart';
import 'package:flutter33_hava_durumu_app/const/input_setts.dart';
import 'package:flutter33_hava_durumu_app/const/interval_tools.dart';
import 'package:flutter33_hava_durumu_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchAppBarPod extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBarPod({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize;

  @override
  State<SearchAppBarPod> createState() => _SearchAppBarPodState();
}

class _SearchAppBarPodState extends State<SearchAppBarPod> {
  final _key = GlobalKey<FormFieldState>();
  bool _searchOpen = false;
  final TextEditingController _controller = TextEditingController();
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
                (route) => false);
          },
          icon: const Icon(Icons.arrow_back)),
      actions: [
        !_searchOpen
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _searchOpen = !_searchOpen;
                  });
                },
                icon: const Icon(Icons.search))
            : IconButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    _key.currentState!.save();
                    setState(() {
                      _searchOpen = !_searchOpen;
                    });
                    _key.currentState!.reset();
                  }
                },
                icon: const Icon(Icons.send)),
      ],
      title: !_searchOpen
          ? const Text("Bloc Hava Durumu")
          : Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                  TextFormField(
                key: _key,
                onSaved: (input) {
                  ref.read(weatherProvider.notifier).getWeather(input!);
                },
                decoration: InputSetts.searcAppBarInput,
                controller: _controller,
                validator: (input) {
                  if (input!.contains(RegExp('[0-9]'))) {
                    return "Lütfen Harf Giriniz";
                  }
                },
              ),
            ),
    );
  }
}
