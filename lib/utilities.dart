/// A few utilities to help with dart and svg dom usages.
///
/// Suggest you import this namespaced:
///
/// > import 'package:aphorica_dartutils/utilities.dart' as AphUtils;
///
library dartutils;

import 'dart:html';
import 'package:d3/selection.dart' as d3;

/// Follow the parent Element chain until either a parent with
/// the parentClass is found or we run out.  Returns the found
/// parent or null if not found.
///
/// Args:
///   child -- the child class to start with.
///   parentClass -- the parent class to search for.
///
/// Returns:
///   (if found) -- the parent Element found
///   (else)     -- null
///
Element getParentElementOfClass(Element child, String parentClass) {
    for (Element parent = child.parent; parent != null; parent = parent.parent)
      if (parent.classes.contains(parentClass))
        return parent;

    return null;
}

/// Get the coordinates from the event depending on whether a touch
/// or mouse event.
///
/// Args:
///   evt -- the event from which to retrieve coords
///
Point getCoordsFromEvent(Event evt) {
  if (evt is MouseEvent) {
     return evt.client;
  }

  else if (evt is TouchEvent) {
    TouchEvent tevt  = evt;
    if (tevt.changedTouches.length > 0)
      return tevt.changedTouches.last.client;
  }

  return new Point(-1, -1);
}

/// Get svg attribute setting from this node or from child
/// node if not set here.  Returns first node with this
/// attribute set.  Mainly used for 'desc' in hover touches,
/// but could be useful, so generalizing.
///
/// Args:
///   node -- the node to follow.
///   NOTE 1: In d3, This is not the
///           d3.Selection, but the [selection].js.node() member.
///           Use searchAttrFromD3ParentNode (next)
///   NOTE 2: the node can not be the top level svg node.
/// 
///   attr -- the attribute to check on recursive node traversal
///
/// Returns:
///   (found) -- the attribute value found
///   (else)  -- empty string
///
String searchAttrFromParentNode(dynamic node, String attr)
{
    String retStr = node.getAttribute(attr);
    if (retStr != null)
      return retStr;

    for (int ix = 0; ix < node.nodes.length; ix++) {
      retStr = searchAttrFromParentNode(node.nodes[ix], attr);
      if (retStr != null)
        return retStr;
    }
      
    return ''; 
}

/// Same as above, but takes a (single) d3 selection.
/// 
String searchAttrFromD3ParentSelection(d3.Selection sel, String attr) {
  return searchAttrFromParentNode(sel.js.node(), attr);
}
