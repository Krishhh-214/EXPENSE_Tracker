import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
class NewExpense extends StatefulWidget  {
  const NewExpense({super.key,required this.onAddExpense});
  final void Function(Expense expense ) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  /*this is provide by flutter*/
  // iske baad dispose method call karna hai
//   function for Date picker
  DateTime ? _selectedDate;
  Category _selectedCategory = Category.leisure ;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year-1, now.month , now.day );
    final lastDate = DateTime(now.year+1, now.month,now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate :now ,
      firstDate: firstDate ,
        lastDate: lastDate,
    );
    print(pickedDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData () {
    final enteredAmount = double.tryParse(_amountController.text);
  //   tryParse('Hello')=>null, tryParse('1.12')=>1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0 ;
  if ( _titleController.text.trim().isEmpty || amountIsInvalid ||
      _selectedDate==null) {
  //   show error message
  //   show Dailog Function
    showDialog(
      context: context, builder: (ctx) =>  AlertDialog(
      title:const  Text('Invalid input'),
      content: const Text('Please make sure valid title,amount and entered'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
          child:const Text('Okay'),
             ),
      ],
    ), );
    return ;
  }
  widget.onAddExpense(Expense(title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!, /*wont be null*/
      category: _selectedCategory),
  );
  Navigator.pop(context);
  // this is for save expense pe click karne ke baad exit hona
  }

@override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  // var _enteredTitle = '' ;
  //
  // void _saveTitleInput(String inputValue){
  //   _enteredTitle = inputValue;


    @override
  Widget build(BuildContext context) {
    /*widget methods me aake for responsive*/
      final keyboardSpace =  MediaQuery.of(context).viewInsets.bottom;
    return  SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(/*padding me new widget add*/
        child: Padding(
          // padding: const EdgeInsets.fromLTRB(16,48,16,16),
          padding:  EdgeInsets.fromLTRB(16,48,16,keyboardSpace+16),
          child: Column(
            children: [
              TextField(
                // onChanged: _saveTitleInput,iski jagha ab nice wala
                controller: _titleController,
                maxLength: 50,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('Title')
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      // onChanged: _saveTitleInput,iski jagha ab nice wala
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixText: '\Rs ',
                          label: Text('Amount')
                      ),
                    ),
                  ),


                const SizedBox(
                 width: 16,
                  ),
               Expanded(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Text(_selectedDate == null ? 'No Date Selected' : formatter.format(_selectedDate!),),
                    IconButton(
                      onPressed: _presentDatePicker,
                        icon: const Icon(
                            Icons.calendar_month
                        ),
                    ),
                  ],
                ),
              ),
          ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                      items: Category.values.map(
                              (category) =>DropdownMenuItem(
                                value: category,
                                child:
                                  Text(category.name.toUpperCase(),),
                              ), ).toList(),
                      onChanged: (value) {
                        if(value == null ){
                          return;
                        }
                      setState(() {
                        _selectedCategory = value;
                      });
                      } ),
                const Spacer(),
                TextButton(
                  onPressed: (){
                 Navigator.pop(context);
                },
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Save Expense'),
                ),
              ],
              )
              // TextField(
              //   maxLength: 50,
              //   keyboardType: TextInputType.phone,
              //   decoration: InputDecoration(
              //       label: Text('Title')
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}