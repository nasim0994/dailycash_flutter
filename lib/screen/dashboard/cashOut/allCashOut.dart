import 'package:dailycash/api/adminApi.dart';
import 'package:dailycash/screen/dashboard/cashOut/addCashOutScreen.dart';
import 'package:dailycash/screen/dashboard/cashOut/editCashOutScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../layout/AppLayout.dart';
import '../../../style/commonStyle.dart';

class AllCashOut extends StatefulWidget {
  const AllCashOut({super.key});
  @override
  State<AllCashOut> createState() => _AllCashOutState();
}

class _AllCashOutState extends State<AllCashOut> {
  List cashOutList = [];
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    loadCashOut();
  }

  Future<void>loadCashOut()async{
    Map res = await getCashOutReq();
    if(res["success"] == true){
      setState(() {
        isLoading = false;
        cashOutList=res["data"];
      });
    }else{
      showErrorToast(res["message"]);
      setState(() => isLoading = false);
    }
  }

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd - MM - yy').format(parsedDate);
  }

  Future<void> handleDelete(Map cashOut) async {
    bool isDeleteLoading = false;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Delete CashOut'),
              content: isDeleteLoading
                  ? const SizedBox(height: 50, child: Center(child: CircularProgressIndicator()))
                  : Text("Are you sure to delete this CashOut?"),
              actions: isDeleteLoading
                  ? []
                  : [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                TextButton(
                  onPressed: () async {
                    setStateDialog(() => isDeleteLoading = true);
                    Map res = await deleteCashOutReq(cashOut['_id']);

                    if (res["success"] == true) {
                      showSuccessToast("cashOut deleted");
                      setState(() {
                        cashOutList.removeWhere((item) => item["_id"] == cashOut["_id"]);
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      showErrorToast(res["message"]);
                      setStateDialog(() => isDeleteLoading = false);
                    }
                  },
                  child: const Text("Delete", style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
    );
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
                    'Cash Out',
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
                  _buildGridItem("Account", "${data["account"]["name"]}"),
                  _buildGridItem("Account Type", "${data["account"]["type"]}"),
                  _buildGridItem("Date", "${DateFormat('dd MMM yyyy').format(DateTime.parse(data["date"]))}"),
                  _buildGridItem("Amount", "৳${data["amount"].toStringAsFixed(2)}"),

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
                    children: [
                      const Text("Note", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 6),
                      Text("${data["note"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
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
                        onPressed: () async{
                          Navigator.pop(context);
                          final shouldReload = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditCashOut(
                                cashOutId: data["_id"],
                              ),
                            ),
                          );
                          if (shouldReload == true) {
                            await loadCashOut();
                          };
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
                          handleDelete(data);
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
      title: "Cash Out",
      currentRoute: '/cashout',
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final shouldReload = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCashOut()),
          );
          if (shouldReload == true) {
            await loadCashOut();
          }
        },

        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      child: isLoading ? Center(child: CircularProgressIndicator()) :  RefreshIndicator(
        onRefresh: () async{await loadCashOut(); },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: cashOutList.length,
          separatorBuilder: (context, index) =>
          const Divider(height: 1, color: Colors.black12),
          itemBuilder: (context, index) {
            final item = cashOutList[index];

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
                            item['account']["name"],
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
      ),
    );
  }
}
