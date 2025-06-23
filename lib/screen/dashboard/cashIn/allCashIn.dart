import 'package:dailycash/screen/dashboard/cashIn/addCashInScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../layout/AppLayout.dart';

class AllCashIn extends StatefulWidget {
  const AllCashIn({super.key});

  @override
  State<AllCashIn> createState() => _AllCashInState();
}

class _AllCashInState extends State<AllCashIn> {
  final List<Map<String, dynamic>> cashInList = [
    {
      "note": "Travello App",
      "date": "2025-06-21",
      "amount": 4946.0,
      "account": "Cash",
      "addedBy":"Nasim"
    },
    {
      "note": "Creative Studios",
      "date": "2025-06-20",
      "amount": 5428.0,
      "account": "Bank - DBBL",
      "addedBy":"Nahida"
    },
    {
      "note": "Book Hub Society",
      "date": "2025-06-19",
      "amount": 2876.0,
      "account": "Mobile Banking - bKash",
      "addedBy":"Nasim"
    },
  ];

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd - MM - yy').format(parsedDate);
  }

  void showDetailsBottomSheet(Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Cash In',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildGridItem("Account", "${data["account"]}"),
                  _buildGridItem("Date", "08:15pm ${DateFormat('dd/MM/yy').format(DateTime.parse(data["date"]))}"),
                  _buildGridItem("Amount", "৳${data["amount"].toStringAsFixed(2)}"),
                  _buildGridItem("চার্জ", "৳240.50"),
                ],
              ),

              const SizedBox(height: 10),


              Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 5, 0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Note", style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 6),
                      Text("CFM94E95F7", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text("Edit", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    SizedBox(width: 4,),
                    Expanded(
                      flex: 50,
                      child:ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: const Text("Delete", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridItem(String title, String value) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 2,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "Cash In",
      currentRoute: '/cashin',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCashIn()),);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: cashInList.length,
        separatorBuilder: (context, index) =>
        const Divider(height: 1, color: Colors.black12),
        itemBuilder: (context, index) {
          final item = cashInList[index];

          return InkWell(
            onTap: () => showDetailsBottomSheet(item),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "৳ ${item['amount'].toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          item['account'],
                          style:
                          const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatDate(item['date']),
                        style:
                        const TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      SizedBox(height: 4),
                      Icon(
                          Icons.arrow_forward_ios,
                          size: 14, color: Colors.grey
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
