import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/pages/home-pages/home/notes_views/edit_notes.dart';
import 'package:flutter_login_register_nodejs/pages/home-pages/home/home_page.dart';
import 'package:flutter_login_register_nodejs/pages/home-pages/profile/profile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../../../configs/app_colors.dart';
import '../../../../configs/config.dart';
import '../../../../models/notes/get_all_notes_response_model.dart';
import '../../../../services/api_service.dart';
import 'curved_box.dart';
import 'home_view.dart';

enum _MenuValues {
  remove,
  edit,
  chickens,
}

class AllView extends StatefulWidget {
  late List<Notes>? notes;
  AllView({Key? key, this.notes}) : super(key: key);

  @override
  State<AllView> createState() => _AllViewState();
}

class _AllViewState extends State<AllView> {
  bool isApiCallProcess = true;
  @override
  void initState() {
    super.initState();
  }

  List<AnimationConfiguration> buildAnimatedGrid(
      int i, BuildContext context, List<Notes> notes) {
    List<AnimationConfiguration> animatedGrid = [];
    for (int j = 0; j < notes.length; j++) {
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
                              notes[j].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(notes[j].note),
                            const SizedBox(
                              height: 16,
                            ),
                            DateFooter(date: 'Jan 21', footerText: "important")
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: PopupMenuButton<_MenuValues>(
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                child: Text('edit'),
                                value: _MenuValues.edit,
                              ),
                              const PopupMenuItem(
                                child: Text('remove'),
                                value: _MenuValues.remove,
                              ),
                            ],
                            onSelected: (value) {
                              switch (value) {
                                case _MenuValues.remove:
                                  APIService.deleteNote(notes[j].id).then(
                                    (response) {
                                      if (response.message != null) {
                                        FormHelper.showSimpleAlertDialog(
                                          context,
                                          Config.appName,
                                          response.message,
                                          "OK",
                                          () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeView(),
                                            ));
                                          },
                                        );
                                      } else {
                                        FormHelper.showSimpleAlertDialog(
                                          context,
                                          Config.appName,
                                          response.message,
                                          "OK",
                                          () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      }
                                    },
                                  );
                                  break;
                                default:
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (c) => Edit(
                                          editable: true,
                                          title: notes[j].title,
                                          content: notes[j].note,
                                          id: notes[j].id)));
                                  break;
                              }
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
    if (isApiCallProcess == true) {
      APIService.getUserNotes().then(
        (response) {
          setState(() {
            isApiCallProcess = false;
          });
          print("notes");
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
            builder: (context) => Edit(),
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
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      itemCount: widget.notes?.length,
                      itemBuilder: (context, i) {
                        return Stack(
                            children:
                                buildAnimatedGrid(i, context, widget.notes!));
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
