import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar Stateful Builder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final listRingtones = <String>[
    'None',
    'Callisto',
    'Ganymede',
    'Luna',
    'Mash-up',
    'School\'s out',
    'Zen too',
  ];
  late String selectedRingtone;

  @override
  void initState() {
    selectedRingtone = listRingtones.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build parent');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Stateful Builder'),
      ),
      body: InkWell(
        onTap: () async {
          final resultSelectedRingtone = await showDialog<String?>(
            context: context,
            builder: (context) {
              // Versi 1 menggunakan class StatefulWidget
              /*return DialogPhoneRingtone(
                listRingtones: listRingtones,
                defaultSelectedRingtone: selectedRingtone,
              );*/

              // Versi 2 menggunakan StatefulBuilder
              return buildDialogPhoneRingtone();
            },
          );
          if (resultSelectedRingtone != null) {
            setState(() {
              selectedRingtone = resultSelectedRingtone;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Phone ringtone',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  selectedRingtone,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDialogPhoneRingtone() {
    return StatefulBuilder(
      builder: (context, setState) {
        debugPrint('build stateful builder');
        final mediaQueryData = MediaQuery.of(context);
        final widthScreen = mediaQueryData.size.width;
        final heightScreen = mediaQueryData.size.height;
        return AlertDialog(
          title: const Text(
            'Phone ringtone',
            textAlign: TextAlign.start,
          ),
          titlePadding: const EdgeInsets.only(
            left: 16,
            top: 16,
          ),
          contentPadding: const EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: widthScreen / 1.2,
                height: heightScreen / 2,
                child: ListView(
                  shrinkWrap: true,
                  children: listRingtones.map((element) {
                    return Row(
                      children: [
                        Radio<String>(
                          value: element,
                          groupValue: selectedRingtone,
                          onChanged: (_) {
                            setState(() {
                              selectedRingtone = element;
                            });
                          },
                        ),
                        Text(
                          element,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Colors.grey[900],
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('CANCEL'),
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('OK'),
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Navigator.pop(context, selectedRingtone);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class DialogPhoneRingtone extends StatefulWidget {
  final List<String> listRingtones;
  final String defaultSelectedRingtone;

  const DialogPhoneRingtone({
    Key? key,
    required this.listRingtones,
    required this.defaultSelectedRingtone,
  }) : super(key: key);

  @override
  State<DialogPhoneRingtone> createState() => _DialogPhoneRingtoneState();
}

class _DialogPhoneRingtoneState extends State<DialogPhoneRingtone> {
  late String selectedRingtone;

  @override
  void initState() {
    selectedRingtone = widget.defaultSelectedRingtone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final widthScreen = mediaQueryData.size.width;
    final heightScreen = mediaQueryData.size.height;
    return AlertDialog(
      title: const Text(
        'Phone ringtone',
        textAlign: TextAlign.start,
      ),
      titlePadding: const EdgeInsets.only(
        left: 16,
        top: 16,
      ),
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: widthScreen / 1.2,
            height: heightScreen / 2,
            child: ListView(
              shrinkWrap: true,
              children: widget.listRingtones.map((element) {
                return Row(
                  children: [
                    Radio<String>(
                      value: element,
                      groupValue: selectedRingtone,
                      onChanged: (_) {
                        setState(() {
                          selectedRingtone = element;
                        });
                      },
                    ),
                    Text(
                      element,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.grey[900],
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('CANCEL'),
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('OK'),
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.pop(context, selectedRingtone);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
