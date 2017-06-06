/// A few utilities to help with dart and svg usages
///
/// Suggest you import this namespaced:
///
///   import 'package:dartutils/utilities.dart' as DartUtils;
///
library dartutils;

import 'dart:html';

/// Follow the parent chain until either a parent with the parentClass
/// is found or we run out.  Returns the found parent or null if not found
///
/// Args:
///   Element child -- the child class to start with.
///   String parentClass -- the parent class to search for.
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
///   Event evt -- the event from which to retrieve coords
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

/// get svg attribute setting from this node or from child
/// node if not set here.  Returns first node with this
/// attribute set.  Mainly used for 'desc' in hover touches,
/// but could be useful, so generalizing.
///
/// Args:
///   dynamic node -- the node to follow
///   String attr -- the attribute to check on recursive
///                  node traversal
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
