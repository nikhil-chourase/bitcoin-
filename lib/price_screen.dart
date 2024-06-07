import 'package:flutter/cupertino.dart';
import 'package:bitcoin/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String? currValue;

  String selectedCurrency = 'AUD';



  Map<String, String> coinValues = {};
  //7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
  bool isWaiting = false;






  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI();
  }


  void updateUI() async{

    isWaiting = true;

    try{
       var content = await CoinData().getCoinData(selectedCurrency);
      //7. Third, as soon the above line of code completes, we now have the data and no longer need to wait. So we can set isWaiting to false.
      isWaiting = false;

       setState(() {
         coinValues = content;
        });
    }catch(e){
      print(e);
    }


    
    print(selectedCurrency);







  }
  


  DropdownButton<String> getDropDownItems(){

     List<DropdownMenuItem<String>> dropDownItems = [];

    for(int i=0;i< currenciesList.length;i++ ){
      String curText = currenciesList[i];

      var newItem =  DropdownMenuItem(child: Text(curText),value: curText,);

      dropDownItems.add(newItem);
    }



    return  DropdownButton<String>(
              items: dropDownItems,
              value: currValue!=null ? currValue : 'USD',

              onChanged: (value) { 
                setState(() {
                   currValue = value;
                });

               },
            );
  }


  

  List<Widget> getDropTextItems(){

    List<Widget> dropDownItems = [];

    for(int i=0;i< currenciesList.length;i++ ){
      String curText = currenciesList[i];

      var newItem =  Text(curText);

      dropDownItems.add(newItem);
    }

    return dropDownItems;

  }


  CupertinoPicker getCupertinoPicker(){

    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          updateUI();
        });
      },
      children: pickerItems,
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
           CryptoCard(
                cryptoCurrency: 'BTC',
                //7. Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
                value: isWaiting ? '?' : coinValues['BTC'].toString(),
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'ETH',
                value: isWaiting ? '?' : coinValues['ETH'].toString(),
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'LTC',
                value: isWaiting ? '?' : coinValues['LTC'].toString(),
                selectedCurrency: selectedCurrency,
              ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getCupertinoPicker(),
          ),
        ],
      ),
    );
  }
}



class CryptoCard extends StatelessWidget {
  //2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
  const CryptoCard({
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


