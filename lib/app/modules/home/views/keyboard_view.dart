import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class KeyboardView extends StatefulWidget {
  const KeyboardView({Key? key}) : super(key: key);

  @override
  State<KeyboardView> createState() => _KeyboardViewState();
}

class _KeyboardViewState extends State<KeyboardView> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 277,
            height: 70,
            child: PinCodeTextField(
              controller: controller,
              keyboardType: TextInputType.none,
              autoFocus: true,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 70,
                fieldWidth: 40,
                selectedColor: Colors.blue,
                activeColor: Colors.orange,
                inactiveColor: Colors.grey,
                activeFillColor: Colors.blue,
              ),
              animationDuration: const Duration(milliseconds: 200),
              backgroundColor: Colors.white,
              enableActiveFill: false,
              onCompleted: (v) {
                debugPrint("Completed");
              },
              onChanged: (value) {
                debugPrint(value);
                setState(() {});
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: context,
            ),
          ),
          CustomKeyboard(
            controller: controller,
            buttonColor: Colors.black,
          )
        ],
      ),
    ));
  }
}

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({
    Color? buttonColor,
    Key? key,
    required this.controller,
  })  : _buttonColor = buttonColor,
        super(key: key);
  final Color? _buttonColor;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return KeyboardWidget(
      buttonColor: _buttonColor,
      onTextInput: (myText) {
        _insertText(myText);
      },
      onBackspace: () {
        _backspace();
      },
    );
  }

  void _insertText(String myText) {
    final text = controller.text;
    final textSelection = controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    controller.text = newText;
    controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {
    final text = controller.text;
    final textSelection = controller.selection;
    final selectionLength = textSelection.end - textSelection.start;
    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      controller.text = newText;
      controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }
    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }
    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    controller.text = newText;
    controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }
}

class KeyboardWidget extends StatelessWidget {
  const KeyboardWidget({
    Key? key,
    Color? buttonColor,
    required this.onTextInput,
    required this.onBackspace,
  })  : _buttonColor = buttonColor,
        super(key: key);

  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;
  final Color? _buttonColor;

  void _textInputHandler(String text) => onTextInput.call(text);
  void _backspaceHandler() => onBackspace.call();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextKey(
                  text: "1",
                  onTextInput: _textInputHandler,
                  buttonColor: _buttonColor),
              TextKey(
                  text: "4",
                  onTextInput: _textInputHandler,
                  buttonColor: _buttonColor),
              TextKey(
                  text: "7",
                  onTextInput: _textInputHandler,
                  buttonColor: _buttonColor),
              BackspaceKey(
                  onBackspace: _backspaceHandler, buttonColor: _buttonColor)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextKey(
                  text: "2",
                  onTextInput: _textInputHandler,
                  buttonColor: _buttonColor),
              TextKey(
                  text: "5",
                  onTextInput: _textInputHandler,
                  buttonColor: _buttonColor),
              TextKey(
                  text: "8",
                  onTextInput: _textInputHandler,
                  buttonColor: _buttonColor),
              TextKey(
                  text: "0",
                  onTextInput: _textInputHandler,
                  buttonColor: _buttonColor),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextKey(
                  text: "3",
                  onTextInput: _textInputHandler,
                  buttonColor: _buttonColor),
              TextKey(
                  text: "6",
                  onTextInput: _textInputHandler,
                  buttonColor: _buttonColor),
              TextKey(
                  text: "9",
                  onTextInput: _textInputHandler,
                  buttonColor: _buttonColor),
              const SizedBox.square(dimension: 65)
            ],
          ),
        ],
      ),
    );
  }
}

class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    Color? buttonColor,
    required this.text,
    required this.onTextInput,
  })  : _buttonColor = buttonColor,
        super(key: key);
  final String text;
  final ValueSetter<String> onTextInput;
  final Color? _buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor,
          fixedSize: Size(65, 65),
          shape: CircleBorder()),
      onPressed: () {
        onTextInput.call(text);
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key? key,
    Color? buttonColor,
    required this.onBackspace,
  })  : _buttonColor = buttonColor,
        super(key: key);
  final VoidCallback onBackspace;
  final Color? _buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor,
          fixedSize: Size(65, 65),
          shape: CircleBorder(),
        ),
        onPressed: () {
          onBackspace.call();
        },
        child: Icon(
          Icons.backspace,
          size: 18,
        ));
  }
}
