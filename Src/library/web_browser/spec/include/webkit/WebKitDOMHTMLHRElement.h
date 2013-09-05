/*
    This file is part of the WebKit open source project.
    This file has been generated by generate-bindings.pl. DO NOT MODIFY!

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/

#ifndef WebKitDOMHTMLHRElement_h
#define WebKitDOMHTMLHRElement_h

#include "webkit/webkitdomdefines.h"
#include <glib-object.h>
#include <webkit/webkitdefines.h>
#include "webkit/WebKitDOMHTMLElement.h"


G_BEGIN_DECLS
#define WEBKIT_TYPE_DOM_HTMLHR_ELEMENT            (webkit_dom_htmlhr_element_get_type())
#define WEBKIT_DOM_HTMLHR_ELEMENT(obj)            (G_TYPE_CHECK_INSTANCE_CAST((obj), WEBKIT_TYPE_DOM_HTMLHR_ELEMENT, WebKitDOMHTMLHRElement))
#define WEBKIT_DOM_HTMLHR_ELEMENT_CLASS(klass)    (G_TYPE_CHECK_CLASS_CAST((klass),  WEBKIT_TYPE_DOM_HTMLHR_ELEMENT, WebKitDOMHTMLHRElementClass)
#define WEBKIT_DOM_IS_HTMLHR_ELEMENT(obj)         (G_TYPE_CHECK_INSTANCE_TYPE((obj), WEBKIT_TYPE_DOM_HTMLHR_ELEMENT))
#define WEBKIT_DOM_IS_HTMLHR_ELEMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass),  WEBKIT_TYPE_DOM_HTMLHR_ELEMENT))
#define WEBKIT_DOM_HTMLHR_ELEMENT_GET_CLASS(obj)  (G_TYPE_INSTANCE_GET_CLASS((obj),  WEBKIT_TYPE_DOM_HTMLHR_ELEMENT, WebKitDOMHTMLHRElementClass))

struct _WebKitDOMHTMLHRElement {
    WebKitDOMHTMLElement parent_instance;
};

struct _WebKitDOMHTMLHRElementClass {
    WebKitDOMHTMLElementClass parent_class;
};

WEBKIT_API GType
webkit_dom_htmlhr_element_get_type (void);

/**
 * webkit_dom_htmlhr_element_get_align:
 * @self: A #WebKitDOMHTMLHRElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_htmlhr_element_get_align(WebKitDOMHTMLHRElement* self);

/**
 * webkit_dom_htmlhr_element_set_align:
 * @self: A #WebKitDOMHTMLHRElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_htmlhr_element_set_align(WebKitDOMHTMLHRElement* self, const gchar* value);

/**
 * webkit_dom_htmlhr_element_get_no_shade:
 * @self: A #WebKitDOMHTMLHRElement
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_htmlhr_element_get_no_shade(WebKitDOMHTMLHRElement* self);

/**
 * webkit_dom_htmlhr_element_set_no_shade:
 * @self: A #WebKitDOMHTMLHRElement
 * @value: A #gboolean
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_htmlhr_element_set_no_shade(WebKitDOMHTMLHRElement* self, gboolean value);

/**
 * webkit_dom_htmlhr_element_get_size:
 * @self: A #WebKitDOMHTMLHRElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_htmlhr_element_get_size(WebKitDOMHTMLHRElement* self);

/**
 * webkit_dom_htmlhr_element_set_size:
 * @self: A #WebKitDOMHTMLHRElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_htmlhr_element_set_size(WebKitDOMHTMLHRElement* self, const gchar* value);

/**
 * webkit_dom_htmlhr_element_get_width:
 * @self: A #WebKitDOMHTMLHRElement
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_htmlhr_element_get_width(WebKitDOMHTMLHRElement* self);

/**
 * webkit_dom_htmlhr_element_set_width:
 * @self: A #WebKitDOMHTMLHRElement
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_htmlhr_element_set_width(WebKitDOMHTMLHRElement* self, const gchar* value);

G_END_DECLS

#endif /* WebKitDOMHTMLHRElement_h */
