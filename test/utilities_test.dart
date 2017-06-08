@TestOn("dartium")

import 'dart:html' as Html;
import 'package:d3/d3.dart' as D3;

import 'package:test/test.dart';
import 'package:aphorica_dartutils/utilities.dart';

void main() {
  D3.Selection _svg, _parent;

  D3.Selection getSvg() {
    print('in getSvg...');
    if (_svg == null) {
      _svg = new D3.Selection('body');
      _parent = _svg.append('g');
      _parent.append('circle')
          ..attr['fill'] = 'black';
    }

    return _svg;
  }

  D3.Selection getNode() {
    getSvg();
    return _parent;
  }

  group('Html', () {
    test(".getParentElementOfClass() - expect isEqual", () {
      Html.Element child = Html.querySelector('.bottom-level');
      expect(getParentElementOfClass(child, 'top-level').id, equals('top-level'));
      });

    test(".getParentElementOfClass() - expect isNull", () {
      Html.Element child = Html.querySelector('.bottom-level');
      expect(getParentElementOfClass(child, 'zoobah'), isNull);
      });
  });

  group('Svg', () {
    test(".searchAttributeFromParentNode() -- expect isEqual", () {
      expect(searchAttrFromParentNode(getNode().js.node(), 'fill'), equals('black'));
      });

    test(".searchAttributeFromParentNode() -- expect isEmpty", () {
      expect(searchAttrFromParentNode(getNode().js.node(), 'cx'), isEmpty);
      });

    test(".searchAttributeFromParentNode(svg root) -- expect exception", () {
      expect((){searchAttrFromParentNode(getSvg().js.node(), 'fill');}, throwsNoSuchMethodError);
      });
  });

  group('D3 Svg', () {
    test(".searchAttributeFromD3ParentSelection() -- expect isEqual", () {
      expect(searchAttrFromD3ParentSelection(getNode(), 'fill'), equals('black'));
      });

    test(".searchAttributeFromD3ParentSelection() -- expect isEmpty", () {
      expect(searchAttrFromD3ParentSelection(getNode(), 'cx'), isEmpty);
      });

    test(".searchAttributeFromD3ParentSelection(svg root) -- expect exception", () {
      expect((){searchAttrFromD3ParentSelection(getSvg(), 'fill');}, throwsNoSuchMethodError);
      });
  });
}