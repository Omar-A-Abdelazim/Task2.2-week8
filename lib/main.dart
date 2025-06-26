import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(home: Homepage()));
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DateTime date = DateTime.now();
  List<String> items = [];
  List<String> time = [];
  List<bool> correct = []; // نفس عدد العناصر في items
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 31, left: 18),
                    child: Text(
                      "To do List",
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 31, left: 16),
                    child: Image.asset("assets/true.png"),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 32),
                width: 150,
                height: 100,
                child: MaterialButton(
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1960),
                      lastDate: DateTime(2050),
                    );
                    if (newDate == null) return;
                    setState(() {
                      date = newDate;
                    });
                  },
                  splashColor: Colors.transparent, // إلغاء تأثير الـ splash
                  highlightColor:
                      Colors.transparent, // إلغاء تأثير الـ highlight
                  hoverColor:
                      Colors.transparent, // إلغاء تأثير الماوس/الـ hover

                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Text(date.day.toString()),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Text(DateFormat.MMM().format(date)),
                      ),
                      Icon(Icons.calendar_month, size: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.black12),
                  ),
                  elevation: 2,
                  color: Colors.white,
                  child: ListTile(
                    title: Text(items[i]),
                    subtitle: Text(time[i]),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete!"),
                              content: Text(
                                "Are you sure want to delete this task",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      items.removeAt(i);
                                      time.removeAt(i);
                                      correct.removeAt(i);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete_outline, color: Colors.red),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        setState(() {
                          correct[i] = !correct[i];
                        });
                      },
                      icon: Icon(
                        correct[i]
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: correct[i] ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.clear();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("hello"),
                content: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Enter your note here",
                    border: UnderlineInputBorder(),
                  ),
                ),

                actions: [
                  TextButton(
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        final now = DateTime.now();
                        final finalTime = DateFormat.jm().format(now);
                        setState(() {
                          items.add(_controller.text.trim());
                          time.add(finalTime);
                          correct.add(false);
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Ok"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text("Cancel"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.indigo[900],
        shape: CircleBorder(),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row();
  }
}
