import 'package:flutter/material.dart';

class MessageField extends StatelessWidget {
  final ValueChanged<String> onValue;
  const MessageField({Key? key, required this.onValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final textControloer = TextEditingController();
    final focus = FocusNode();

    final outlinedInput = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40)
    );

    return TextFormField(
      focusNode: focus,
      onTapOutside: (event) => focus.unfocus(),
      controller: textControloer,
      decoration: InputDecoration(
        hintText: "Send msg",
        enabledBorder: outlinedInput,
        focusedBorder: outlinedInput,
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(Icons.send_outlined),
          onPressed: (){
            final value = textControloer.value.text;
            onValue(value);
            textControloer.clear();
            
          },
        )
      ),
      onFieldSubmitted: (value) {
        onValue(value);
        textControloer.clear();
        focus.requestFocus();
      },
    );
  }
}