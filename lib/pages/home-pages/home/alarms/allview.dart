import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/providers/alarm.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../../../configs/app_colors.dart';
import '../../../../configs/config.dart';
import '../../../../models/notes/get_all_notes_response_model.dart';
import '../../../../services/api_service.dart';
import '../notes_views/curved_box.dart';
import '../notes_views/edit_notes.dart';
import 'edit.dart';

enum _MenuValues {
  remove,
  edit,
}

class AlarmAllView extends StatefulWidget {
  late List<Notes>? notes;
  AlarmAllView({Key? key, this.notes}) : super(key: key);

  @override
  State<AlarmAllView> createState() => _AlarmAllViewState();
}

class _AlarmAllViewState extends State<AlarmAllView> {
  bool isApiCallProcess = true;
  @override
  void initState() {
    super.initState();
  }

  AlarmProvider get state => Provider.of(context, listen: false);

  List<AnimationConfiguration> buildAnimatedGrid(
      int i, BuildContext context, List<Alarm> alarms) {
    List<AnimationConfiguration> animatedGrid = [];
    for (int j = 0; j < alarms.length; j++) {
      animatedGrid.add(
        AnimationConfiguration.staggeredGrid(
            duration: const Duration(milliseconds: 700),
            position: i,
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: i == j
                    ? Stack(children: [
                        CurvedBox(
                          children: [
                            Text(
                              "${alarms[j].time.hour} h: ${alarms[j].time.minute}m",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(alarms[j].name),
                            const SizedBox(
                              height: 16,
                            ),
                            DateFooter(
                                date: '.',
                                footerText: alarms[j].repeat.toString())
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Switch(
                            value: alarms[j].active,
                            activeColor: Color(0xFF6200EE),
                            onChanged: (bool value) {
                              alarms[j].cancelTimer();
                            },
                          ),
                        )
                      ])
                    : const SizedBox.shrink(),
              ),
            )),
      );
    }
    return animatedGrid;
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < state.alarms.length; i++) {
      if (state.alarms[i].active) {
        state.alarms[i].activateTimer();
      }
    }
    print(state.alarms);

    // if (data == null) {
    //   print("null");
    // } else {
    //
    // }

    if (isApiCallProcess == true) {
      APIService.getUserNotes().then(
        (response) {
          setState(() {
            isApiCallProcess = false;
          });
          print("ALARMS");
          print(response.notes);
          widget.notes = response.notes;

          if (response.toString().isEmpty) {
            FormHelper.showSimpleAlertDialog(
              context,
              Config.appName,
              "error in fetching notes",
              "OK",
              () {
                Navigator.of(context).pop();
              },
            );
          } else {}
        },
      );
    }

    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditAlarm(),
          ));
        },
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "NOTES",
          textAlign: TextAlign.center,
        ),
      ),
      body: ProgressHUD(
        child: isApiCallProcess
            ? Container()
            : SafeArea(
                child: AnimationLimiter(
                  child: MasonryGridView.count(
                      padding: const EdgeInsets.all(16),
                      crossAxisCount: 1,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      itemCount: widget.notes?.length,
                      itemBuilder: (context, i) {
                        return Stack(
                            children: state.alarms.isEmpty
                                ? []
                                : buildAnimatedGrid(i, context, state.alarms));
                      }),
                ),
              ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }
}

class _ListTileRow extends StatelessWidget {
  const _ListTileRow({Key? key, required this.isChecked, required this.text})
      : super(key: key);
  final String text;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 32,
          width: 16,
          child: Checkbox(
            shape: const CircleBorder(
              side: BorderSide(
                width: 2,
                color: AppColors.white,
              ),
            ),
            value: isChecked,
            activeColor: AppColors.white,
            checkColor: AppColors.grey,
            onChanged: (bool? val) {},
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  decoration: isChecked ? TextDecoration.lineThrough : null)),
        )
      ],
    );
  }
}

class DateFooter extends StatelessWidget {
  const DateFooter({Key? key, required this.date, required this.footerText})
      : super(
          key: key,
        );
  final String date, footerText;
  final TextStyle style = const TextStyle(color: AppColors.lightGrey);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date,
          style: style,
        ),
        Text(
          footerText,
          style: style,
        ),
      ],
    );
  }
}
