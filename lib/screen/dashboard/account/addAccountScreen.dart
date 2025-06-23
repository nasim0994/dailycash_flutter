import 'package:dailycash/api/adminApi.dart';
import 'package:dailycash/layout/AppLayout.dart';
import 'package:dailycash/style/commonStyle.dart';
import 'package:flutter/material.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});
  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final Map<String, String> paymentMethods = {
    'Bank': 'bank',
    'Mobile Banking': 'mobileBanking',
  };
  bool isLoading = false;
  String? selectedValue;
  Map<String, dynamic> FormValue = {
    "name":"",
    "type":"",
    "accountNumber":"",
    "accountHolderName":"",
    "bankName":"",
    "branchName":"",
    "balance":0,
  };

  void handleChangeInput(String key, String value) {
    setState(() {
      if (FormValue.containsKey(key)) {
        if (key == "balance") {
          FormValue[key] = double.tryParse(value) ?? 0;
        } else {
          FormValue[key] = value;
        }
      }
    });
  }

  void handleFormSubmit()async{
    setState(() => isLoading = true);
    String? name = FormValue["name"];
    String? type = FormValue["type"];
    String? accountNumber = FormValue["accountNumber"];
    String? accountHolderName = FormValue["accountHolderName"];

    if (name == null || name.trim().isEmpty) {
      showErrorToast(context,"Name is required");
    } else if (type == null || type.trim().isEmpty) {
      showErrorToast(context,"Account Type is required");
    } else if (accountNumber == null || accountNumber.trim().isEmpty) {
      showErrorToast(context,"account Number Type is required");
    } else if (accountHolderName == null || accountHolderName.trim().isEmpty) {
      showErrorToast(context,"Account Holder Name is required");
    } else {
      Map res = await addAccountReq(FormValue);
      if(res["success"] == true){
        showSuccessToast(context,"Account add success");
        setState(() => isLoading = false);
        Navigator.pop(context, true);
      }else{
        showErrorToast(context,res["message"]);
        setState(() => isLoading = false);
      }
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
        title: "Crate Account",
        currentRoute: "/add-account",
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                decoration: AppInputStyle("name"),
                onChanged: (value)=>{handleChangeInput("name", value)},
              ),
              SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                decoration: AppInputStyle("Select Method"),
                value: selectedValue,
                items: paymentMethods.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue!;
                    FormValue["type"] = newValue;
                  });
                },
                validator: (value) =>
                value == null ? 'Please select an option' : null,
              ),
              SizedBox(height: 10,),
              TextFormField(decoration: AppInputStyle("account number"),
                onChanged: (value)=>{handleChangeInput("accountNumber", value)},
              ),
              SizedBox(height: 10,),
              TextFormField(decoration: AppInputStyle("account holder name"),
                onChanged: (value)=>{handleChangeInput("accountHolderName", value)},
              ),
              SizedBox(height: 10,),
              if (selectedValue == 'bank') ...[
                TextFormField(
                  decoration: AppInputStyle("bank name"),
                  onChanged: (value)=>{handleChangeInput("bankName", value)},
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: AppInputStyle("branch name"),
                  onChanged: (value)=>{handleChangeInput("branchName", value)},
                ),
                const SizedBox(height: 10),
              ],
              TextFormField(decoration: AppInputStyle("initial balance"),
                onChanged: (value)=>{handleChangeInput("balance", value)},
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
