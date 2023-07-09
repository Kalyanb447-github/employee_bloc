import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ToDatePickerWidget extends StatelessWidget {
  ToDatePickerWidget({super.key, this.toDateTextEditingController});

  final toDateTextEditingController;

  final DateRangePickerController _toDateRangePickerController =
      DateRangePickerController();

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return TextFormField(
      controller: toDateTextEditingController,
      readOnly: true,
      onTap: () {
        // FormDateOicker(context, height);
      },
      decoration: InputDecoration(
        // label: Text('Employee name'),
        hintText: 'To Data',
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.all(15),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(5),
        // ),
        prefixIcon: Icon(
          Icons.calendar_month_outlined,
          color: Theme.of(context).primaryColor,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.grey, width: .3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.grey, width: .3),
        ),
      ),
    );
  }

  Future<dynamic> FormDateOicker(BuildContext context, double height) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            insetPadding: EdgeInsets.all(20),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 221, 238, 248),
                              elevation: 0),
                          onPressed: () {
                            _toDateRangePickerController.selectedDate = today;
                          },
                          child: Text(
                            'Today',
                            style: TextStyle(color: ThemeData().primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            int nextWeekDay = today.day + 7;
                            int mondayCount = today.day - 3;

                            int nextMonday = nextWeekDay - mondayCount;

                            _toDateRangePickerController.selectedDate =
                                DateTime.now().add(
                              Duration(days: nextMonday),
                            );
                          },
                          child: const Text('Next Monday'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 221, 238, 248),
                              elevation: 0),
                          onPressed: () {
                            _toDateRangePickerController.selectedDate =
                                DateTime.now().add(
                              Duration(days: 7),
                            );
                          },
                          child: Text(
                            'Next Tuesday',
                            style: TextStyle(color: ThemeData().primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 221, 238, 248),
                              elevation: 0),
                          onPressed: () {
                            _toDateRangePickerController.selectedDate =
                                DateTime.now().add(
                              Duration(days: 7),
                            );
                          },
                          child: Text(
                            'After 1 week',
                            style: TextStyle(color: ThemeData().primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // _controller?.displayDate?.month == null
                  //     ? DateFormat('MMMM yyyy').format(today).toString()
                  //     : DateFormat('MMMM yyyy')
                  //         .format(_controller!.displayDate)
                  //         .toString(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          _toDateRangePickerController.backward!();
                        },
                        icon: const Icon(
                          Icons.arrow_left,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'June 2007',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          _toDateRangePickerController.forward!();
                        },
                        icon: const Icon(
                          Icons.arrow_right,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SfDateRangePicker(
                    controller: _toDateRangePickerController,
                    view: DateRangePickerView.month,
                    headerHeight: 0,
                    onViewChanged: (DateRangePickerViewChangedArgs args) {
                      final DateTime visibleStartDate =
                          args.visibleDateRange.startDate!;
                      final DateTime visibleEndDate =
                          args.visibleDateRange.endDate!;
                      final int totalVisibleDays =
                          (visibleStartDate.difference(visibleEndDate).inDays);
                      final DateTime midDate = visibleStartDate
                          .add(Duration(days: totalVisibleDays ~/ 2));
                      String headerString =
                          DateFormat('MMMM yyyy').format(midDate).toString();
                      SchedulerBinding.instance
                          .addPostFrameCallback((duration) {});
                    },
                  ),

                  //* * * * * * * * bottom
                  SizedBox(
                    height: height * .05,
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined,
                              color: ThemeData().primaryColor),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('5 sep 2023'),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 221, 238, 248),
                                elevation: 0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: ThemeData().primaryColor),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 0),
                            onPressed: () {
                              String headerString = DateFormat('dd MMMM yyyy')
                                  .format(_toDateRangePickerController
                                      .selectedDate!)
                                  .toString();

                              toDateTextEditingController.text = headerString;

                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Save',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // actions,
                ],
              ),
            ));
      },
    );
  }
}
