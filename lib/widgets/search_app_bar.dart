import 'package:flutter/material.dart';
import 'package:flutter33_hava_durumu_app/bloc/weather_bloc.dart';
import 'package:flutter33_hava_durumu_app/const/input_setts.dart';
import 'package:flutter33_hava_durumu_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final _key = GlobalKey<FormFieldState>();
  bool _searchOpen = false;
  final TextEditingController _controller = TextEditingController();
  @override
  PreferredSizeWidget build(BuildContext context) {
    WeatherBloc _blocObj = BlocProvider.of<WeatherBloc>(context);
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
          : TextFormField(
              key: _key,
              onSaved: (input) {
                _blocObj.add(GetWeatherEvent(sehir: input!));
              },
              decoration: InputSetts.searcAppBarInput,
              controller: _controller,
              validator: (input) {
                if (input!.contains(RegExp('[0-9]'))) {
                  return "Lütfen Harf Giriniz";
                }
              },
            ),
    );
  }
}
