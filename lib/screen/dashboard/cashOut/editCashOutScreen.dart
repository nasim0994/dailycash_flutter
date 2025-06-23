import 'package:dailycash/api/adminApi.dart';
import 'package:dailycash/layout/AppLayout.dart';
import 'package:dailycash/style/commonStyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditCashOut extends StatefulWidget {
  final String cashOutId;
  const EditCashOut({super.key, required this.cashOutId});
  @override
  State<EditCashOut> createState() => _EditCashOutState();
}

class _EditCashOutState extends State<EditCashOut> {
  List accountLists = [];
  Map<String, dynamic> FormValue = {
    "date":"",
    "amount":0,
    "account":"",
    "note":"",
  };

  bool isBtnLoading = false;
  bool isLoading = false;
  String? selectedValue;
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCashOutDetails(widget.cashOutId);
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
      showErrorToast(context,res["message"]);
    }
  }

  Future<void>fetchCashOutDetails(String id) async {
    setState(() => isLoading = true);
    Map res = await getCashOutByIdReq(id);
    if (res["success"] == true) {
      Map data = res["data"];
      setState(() {
        FormValue["date"] = data["date"];
        FormValue["amount"] = data["amount"];
        FormValue["account"] = data["account"]["_id"];
        FormValue["note"] = data["note"];

        selectedValue = data["account"]["_id"];
        dateController.text = DateFormat('dd MMM yyyy').format(DateTime.parse(data["date"]));
        amountController.text = data["amount"].toString();
        noteController.text = data["note"] ? data["note"].toString() : "";
      });
    } else {
      showErrorToast(context,res["message"]);
      print(res);
    }
    setState(() => isLoading = false);
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
    setState(() => isBtnLoading = true);
    String? date = FormValue["date"];
    int amount = FormValue["amount"];
    String? account = FormValue["account"];

    if (date == null || date.trim().isEmpty) {
      showErrorToast(context,"Date is required");
    } else if (amount <= 0) {
      showErrorToast(context,"Amount must be greater than 0");
    } else if (account == null || account.trim().isEmpty) {
      showErrorToast(context,"Account Type is required");
    } else {
      Map res = await editCashOutReq(widget.cashOutId,FormValue);
      if(res["success"] == true){
        showSuccessToast(context,"Cash Out add success");
        setState(() => isBtnLoading = false);
        Navigator.pop(context, true);
      }else{
        showErrorToast(context,res["message"]);
        setState(() => isBtnLoading = false);
      }
    }
    setState(() => isBtnLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
        title: "Edit Cash Out",
        currentRoute: "/edit-cashout",
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
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: AppInputStyle("Amount"),
                onChanged: (value)=>{handleChangeInput("amount", value)},
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: noteController,
                decoration: AppInputStyle("Note"),
                onChanged: (value)=>{handleChangeInput("note", value)},
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isBtnLoading ? null : (){handleFormSubmit();},
                  style: AppBtnStyle(),
                  child: isBtnLoading  ?
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
