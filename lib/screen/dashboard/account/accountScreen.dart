import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../api/adminApi.dart';
import '../../../layout/AppLayout.dart';
import '../../../style/commonStyle.dart';
import 'addAccountScreen.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});
  @override
  State<Accounts> createState() => AccountsState();
}

class AccountsState extends State<Accounts> {
  List accountList = [];
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    loadAccounts();
  }

  Future<void>loadAccounts()async{
    Map res = await getAccountReq();
    if(res["success"] == true){
      setState(() {
        isLoading = false;
        accountList=res["data"];
      });
    }else{
      showErrorToast(res["message"]);
      setState(() => isLoading = false);
    }
  }
  void handleEdit(Map account) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit tapped for ${account['name']}')),
    );
  }
  Future<void> handleDelete(Map account) async {
    bool isDeleteLoading = false;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Delete Account'),
              content: isDeleteLoading
                  ? const SizedBox(height: 50, child: Center(child: CircularProgressIndicator()))
                  : Text("Are you sure to delete '${account['name']}'?"),
              actions: isDeleteLoading
                  ? []
                  : [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                TextButton(
                  onPressed: () async {
                    setStateDialog(() => isDeleteLoading = true);
                    Map res = await deleteAccountReq(account['_id']);

                    if (res["success"] == true) {
                      showSuccessToast("Account delete success");
                    } else {
                      showErrorToast(res["message"]);
                    }

                    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "Accounts",
      currentRoute: '/accounts',
      child: isLoading ? Center(child: CircularProgressIndicator()) : RefreshIndicator(
        onRefresh: () async{await loadAccounts(); },
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: accountList.length,
          itemBuilder: (context, index) {
            final account = accountList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Slidable(
                key: Key(account['_id']),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) => handleEdit(account),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                      borderRadius: BorderRadius.circular(10),
                    ),
                    SizedBox(width: 2,),
                    SlidableAction(
                      onPressed: (_) => handleDelete(account),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 85,
                              child: Row(
                                children: [
                                  const Icon(Icons.account_balance_wallet, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text(
                                    account['name'],
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 15,
                              child: Text(account["isActive"] == true ? "Active" :"Close", style: TextStyle(color: account["isActive"] == true ? Colors.green : Colors.red),),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text("Type: ${account['type']}"),
                        Text("Holder: ${account['accountHolderName']}"),
                        Text("Account No: ${account['accountNumber']}"),
                        const SizedBox(height: 8),
                        Text(
                          "Balance: ৳${account['balance']}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAccount()),);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}