import 'package:dailycash/api/adminApi.dart';
import 'package:dailycash/layout/AppLayout.dart';
import 'package:dailycash/style/commonStyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddCashOut extends StatefulWidget {
  const AddCashOut({super.key});
  @override
  State<AddCashOut> createState() => _AddCashOutState();
}

class _AddCashOutState extends State<AddCashOut> {
  List accountLists = [];
  Map<String, dynamic> FormValue = {
    "date":"",
    "amount":0,
    "account":"",
    "note":"",
  };

  bool isLoading = false;
  String? selectedValue;
  TextEditingController dateController = TextEditingController();


  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  Future<void>loadAccounts()async{
    Map res = await getAccountReq();
    if(res["success"] == true){
      setState(() {
        isLoading = false;
        accountLists=res["data"];
      });
    }else{
      showErrorToast(res["message"]);
    }
  }

  void handleChangeInput(String key, String value) {
    setState(() {
      if (FormValue.containsKey(key)) {
        if (key == "amount") {
          FormValue[key] = int.tryParse(value) ?? 0;
        } else {
          FormValue[key] = value;
        }
      }
    });
  }

  void handleFormSubmit()async{
    setState(() => isLoading = true);
    String? date = FormValue["date"];
    int amount = FormValue["amount"];
    String? account = FormValue["account"];

    if (date == null || date.trim().isEmpty) {
      showErrorToast("Date is required");
    } else if (amount <= 0) {
      showErrorToast("Amount must be greater than 0");
    } else if (account == null || account.trim().isEmpty) {
      showErrorToast("Account Type is required");
    } else {
      Map res = await addCashOutReq(FormValue);
      if(res["success"] == true){
        showSuccessToast("Cash Out add success");
        setState(() => isLoading = false);
        Navigator.pop(context, true);
      }else{
        showErrorToast(res["message"]);
        setState(() => isLoading = false);
      }
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
        title: "Add Cash Out",
        currentRoute: "/add-cashout",
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: AppInputStyle("Select Date"),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
                    setState(() {
                      dateController.text = formattedDate;
                      handleChangeInput("date", formattedDate);
                    });
                  }
                },
              ),
              SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                decoration: AppInputStyle("Select Account"),
                value: FormValue["account"]!.isNotEmpty ? FormValue["account"] : null,
                items: accountLists.map((item) {
                  return DropdownMenuItem<String>(
                    value: item["_id"],
                    child: Text("${item["name"]} - ${item["type"]}"),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue!;
                    FormValue["account"] = newValue;
                  });
                },
                validator: (value) =>
                value == null || value.isEmpty ? 'Please select an account' : null,
              ),
              SizedBox(height: 10,),
              TextFormField(decoration: AppInputStyle("Amount"),
                onChanged: (value)=>{handleChangeInput("amount", value)},
              ),
              SizedBox(height: 10,),
              TextFormField(decoration: AppInputStyle("Note"),
                onChanged: (value)=>{handleChangeInput("note", value)},
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : (){handleFormSubmit();},
                  style: AppBtnStyle(),
                  child: isLoading  ?
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ) : Text("Submit"),),
              ),
            ],
          ),
        )
    );
  }
}
