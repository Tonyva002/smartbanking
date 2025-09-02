
import 'package:flutter/material.dart';

class InputDecorations{

  //Componente usuario y contraseña login
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
}){
    return  InputDecoration(
         enabledBorder: UnderlineInputBorder(
           borderSide: BorderSide(
                color: Colors.deepPurple
            )
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.deepPurple,
                width: 2
            )
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
            color: Colors.grey
        ),
        prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, color: Colors.deepPurple)
            : null
    );
  }

//Componente usuario y contraseña registro
  static InputDecoration authInputDecoration2({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }){
    return  InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
            color: Colors.grey
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.deepPurple)
            : null
    );
  }


  //Componente TextFormField
  static TextFormField authTextFormField({
    required String labelText,
    required String hintText,
    final String? helperText,
    final IconData? prefixIcon,
    final TextInputType? emailAddress,
    final bool obscureText = false,
    final bool? enabled,
    required final String formProperty,
    required final Map<String, String> formValues,
}){

    return TextFormField(
      autofocus: false,
      initialValue: '',
      textCapitalization: TextCapitalization.words,
      keyboardType: emailAddress,
      obscureText: obscureText,
      enabled: enabled,
      onChanged: (value) => formValues[formProperty] = value,
      validator: (value) {
        if (value == null) return "Requerido";
        return value.length < 3 ? "Minimo 3 letras" : null;


      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            color: Colors.grey
        ),
        hintText: hintText,
        helperText: helperText,

          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.deepPurple)
              : null
      ),
    );
  }

}