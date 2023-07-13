import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FormDatePickerWidget extends StatelessWidget {
  final TextEditingController fromDateTextEditingController;
  final DateRangePickerController formDateRangePickerController;
  final DateTime today;

  const FormDatePickerWidget({
    super.key,
    required this.fromDateTextEditingController,
    required this.formDateRangePickerController,
    required this.today,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return TextFormField(
      controller: fromDateTextEditingController,
      readOnly: true,
      onTap: () {
        FormDateOicker(context, height);
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please Pick a date';
        }
        return null;
      },
      decoration: InputDecoration(
        // label: Text('Employee name'),
        hintText: 'Today',
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
          borderSide: const BorderSide(color: Colors.grey, width: .3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.grey, width: .3),
        ),
      ),
    );
  }

  Future<dynamic> FormDateOicker(BuildContext context, double height) {
    String headerString = '';
    DateTime selDate = formDateRangePickerController.selectedDate!;
    String selectedDate = DateFormat('dd MMMM yyyy').format(selDate).toString();
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                              formDateRangePickerController.selectedDate =
                                  today;
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
                              int todayRemainder1 = today.day % 7; //1

                              int mondayRemainder = 3; //3

                              int difference =
                                  mondayRemainder - todayRemainder1; //2

                              if (difference == 0) {
                                difference = 7;
                              }

                              formDateRangePickerController.selectedDate =
                                  today.add(
                                Duration(days: difference),
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
                              formDateRangePickerController.selectedDate =
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
                              formDateRangePickerController.selectedDate =
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            setState(() {
                              formDateRangePickerController.backward!();
                            });
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
                        Text(
                          headerString,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            setState(() {
                              formDateRangePickerController.forward!();
                            });
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
                      controller: formDateRangePickerController,
                      view: DateRangePickerView.month,
                      headerHeight: 0,
                      selectionMode: DateRangePickerSelectionMode.single,
                      onViewChanged: (DateRangePickerViewChangedArgs args) {
                        final DateTime visibleStartDate =
                            args.visibleDateRange.startDate!;
                        final DateTime visibleEndDate =
                            args.visibleDateRange.endDate!;
                        final int totalVisibleDays = (visibleStartDate
                            .difference(visibleEndDate)
                            .inDays);
                        final DateTime midDate = visibleStartDate
                            .add(Duration(days: totalVisibleDays ~/ 2));
                        headerString =
                            DateFormat('MMMM yyyy').format(midDate).toString();

                        SchedulerBinding.instance!
                            .addPostFrameCallback((duration) {
                          setState(() {});
                        });
                      },
                      onSelectionChanged: (DateRangePickerSelectionChangedArgs
                          dateRangePickerSelectionChangedArgs) {
                        final DateTime selDate =
                            dateRangePickerSelectionChangedArgs.value;

                        selectedDate = DateFormat('d MMMM yyyy')
                            .format(selDate)
                            .toString();

                        setState(() {});
                      },
                    ),

                    //* * * * * * * * bottom
                    SizedBox(
                      height: height * .05,
                    ),
                    Divider(),
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
                            Text(selectedDate),
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
                                style:
                                    TextStyle(color: ThemeData().primaryColor),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(elevation: 0),
                              onPressed: () {
                                String headerString = DateFormat('dd MMMM yyyy')
                                    .format(formDateRangePickerController
                                        .selectedDate!)
                                    .toString();

                                fromDateTextEditingController.text =
                                    headerString;

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
              ),
            );
          },
        );
      },
    );
  }
}
