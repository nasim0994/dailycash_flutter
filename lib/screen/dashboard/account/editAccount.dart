import 'package:dailycash/layout/AppLayout.dart';
import 'package:flutter/material.dart';

import '../../../api/adminApi.dart';
import '../../../style/commonStyle.dart';

class EditAccount extends StatefulWidget {
  final String accountId;
  const EditAccount({super.key, required this.accountId});
  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final Map<String, String> paymentMethods = {
    'Bank': 'bank',
    'Mobile Banking': 'mobileBanking',
  };
  bool isBtnLoading = false;
  bool isLoading = false;
  String? selectedValue;
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController balanceController = TextEditingController();


  Map<String, dynamic> FormValue = {
    "name":"",
    "type":"",
    "accountNumber":"",
    "accountHolderName":"",
    "bankName":"",
    "branchName":"",
    "balance":0,
  };

  @override
  void initState() {
    super.initState();
    getAccountById(widget.accountId);
  }

  Future<void>getAccountById(String id) async {
    setState(() => isLoading = true);
    Map res = await getAccountByReq(id);
    if (res["success"] == true) {
      Map data = res["data"];
      setState(() {
        FormValue["name"] = data["name"];
        FormValue["type"] = data["type"];
        FormValue["accountNumber"] = data["accountNumber"];
        FormValue["accountHolderName"] = data["accountHolderName"];
        FormValue["bankName"] = data["bankName"];
        FormValue["branchName"] = data["branchName"];
        FormValue["balance"] = data["balance"];

        selectedValue=data["type"];
        nameController.text = data["name"].toString();
        accountNumberController.text = data["accountNumber"].toString();
        accountHolderNameController.text = data["accountHolderName"].toString();
        bankNameController.text = data["bankName"].toString();
        branchNameController.text = data["branchName"].toString();
        balanceController.text = data["balance"].toString();
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
      Map res = await editAccountReq(widget.accountId,FormValue);
      if(res["success"] == true){
        showSuccessToast(context,"Account edit success");
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
        title: "Edit Account",
        currentRoute: "edit-account", 
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
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
              TextFormField(
                controller: accountNumberController,
                decoration: AppInputStyle("account number"),
                onChanged: (value)=>{handleChangeInput("accountNumber", value)},
              ),
              SizedBox(height: 10,),
              TextFormField(controller: accountHolderNameController,
                decoration: AppInputStyle("account holder name"),
                onChanged: (value)=>{handleChangeInput("accountHolderName", value)},
              ),
              SizedBox(height: 10,),
              if (selectedValue == 'bank') ...[
                TextFormField(
                  controller: bankNameController,
                  decoration: AppInputStyle("bank name"),
                  onChanged: (value)=>{handleChangeInput("bankName", value)},
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: branchNameController,
                  decoration: AppInputStyle("branch name"),
                  onChanged: (value)=>{handleChangeInput("branchName", value)},
                ),
                const SizedBox(height: 10),
              ],
              TextFormField(controller: balanceController,
                decoration: AppInputStyle("initial balance"),
                onChanged: (value)=>{handleChangeInput("balance", value)},
                enabled: false,
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
