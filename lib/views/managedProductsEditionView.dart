import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:string_validator/string_validator.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../config/owaspRegexInputs.dart';
import '../config/routes.dart';
import '../config/titlesIconsMessages/general.dart';
import '../config/titlesIconsMessages/views/managedProductsEditionView.dart';
import '../entities/product.dart';
import '../services/managedProductsStore.dart';

class ManagedProductsEditionView extends StatefulWidget {
  String _id;

  ManagedProductsEditionView([this._id]);

  @override
  _ManagedProductsEditionViewState createState() =>
      _ManagedProductsEditionViewState();
}

class _ManagedProductsEditionViewState
    extends State<ManagedProductsEditionView> {
  bool _isInit = true;

  final _focusPrice = FocusNode();
  final _focusDescript = FocusNode();

  final _imgUrlController = TextEditingController();
  final _focusImgUrlNode = FocusNode();

  final _form = GlobalKey<FormState>();
  Product _product = Product();

  final _store = Modular.get<ManagedProductsStoreInt>();

  @override
  void initState() {
    _focusImgUrlNode.addListener(() => _previewImageUrl());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      //var idToEdit = ModalRoute.of(context).settings.arguments as String;
      //iD CHEGANDO DIRETO PELO CONSTRUCTOR
      _product = widget._id == null ? Product() : _store.getById(widget._id);

      //CONTROLLER e incompativel com INITIAL_VALUE
      _imgUrlController.text = _product.get_imageUrl();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void _previewImageUrl() {
    var urlPattern =
        r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";

    var result = new RegExp(urlPattern, caseSensitive: false)
        .firstMatch(_imgUrlController.text.trim());

    if (!_focusImgUrlNode.hasFocus) {
      if (_imgUrlController.text == null || result == null) {
        return null;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    if (_product.get_id() == null) _store.add(_product);
    if (_product.get_id() != null) _store.update(_product);
    Modular.to.popAndPushNamed(MANAGPRODUCT_ROUTE);
  }

  @override
  void dispose() {
    _focusPrice.dispose();
    _focusDescript.dispose();

    _focusImgUrlNode.removeListener(() => _previewImageUrl());
    _focusImgUrlNode.dispose();
    _imgUrlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(MAN_ADD_APPBAR_TIT), actions: <Widget>[
          IconButton(icon: MAN_ICO_SAVE_FORM_APPBAR, onPressed: _saveForm)
        ]),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _form,
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  TextFormField(
                      initialValue: _product.get_title(),
                      decoration: InputDecoration(labelText: MAN_FLD_TIT),
                      textInputAction: TextInputAction.next,
                      maxLength: 15,
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _product.set_title(value),
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(_focusPrice),
                      validator: Validators.compose([
                        Validators.required(MSG_VALID_EMPTY),
                        Validators.patternString(SAFE_TEXT, MSG_VALID_TEXT),
                        Validators.minLength(5, MSG_MIN_SIZE_TIT)
                      ])),
                  TextFormField(
                      initialValue: _product.get_price() == null
                          ? ZERO$AMOUNT
                          : _product.get_price().toString(),
                      decoration: InputDecoration(labelText: MAN_FLD_PRICE),
                      textInputAction: TextInputAction.next,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      onSaved: (value) =>
                          _product.set_price(double.parse(value)),
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_focusDescript),
                      validator: Validators.compose([
                        Validators.required(MSG_VALID_EMPTY),
                        Validators.patternString(SAFE_NUMBER, MSG_VALID_NUMBER),
                        Validators.min(0, MSG_VALID_NEG)
                      ])),
                  TextFormField(
                      initialValue: _product.get_description(),
                      decoration: InputDecoration(labelText: MAN_FLD_DESCR),
                      textInputAction: TextInputAction.next,
                      maxLength: 30,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (value) => _product.set_description(value),
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_focusImgUrlNode),
                      validator: Validators.compose([
                        Validators.required(MSG_VALID_EMPTY),
                        Validators.patternString(SAFE_TEXT, MSG_VALID_TEXT),
                        Validators.minLength(10, MSG_MIN_SIZE_DESCR)
                      ])),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: <
                      Widget>[
                    Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 20, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey)),
                        child: Container(
                            child: _imgUrlController.text.isEmpty
                                ? Center(child: Text(MAN_BOX_IMG_TIT))
                                : FittedBox(
                                    child: Image.network(_imgUrlController.text,
                                        fit: BoxFit.cover)))),
                    Expanded(
                        child: TextFormField(
                            //CONTROLLER e incompativel com INITIAL_VALUE
                            //initialValue: _product.get_imageUrl().toString(),
                            decoration:
                                InputDecoration(labelText: MAN_FLD_IMG_URL),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            focusNode: _focusImgUrlNode,
                            //CONTROLLER e incompativel com INITIAL_VALUE
                            controller: _imgUrlController,
                            onSaved: (value) => _product.set_imageUrl(value),
                            onFieldSubmitted: (_) => _saveForm(),
                            validator: (value) {
                              if (!isURL(value)) return MSG_VALID_URL;
                              return null;
                            }))
                  ])
                ])))));
  }
}
