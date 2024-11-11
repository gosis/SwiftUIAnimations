# Swift UI Animations
Test app implementing 4 tabs with different matchedGeometry effects in each tab


## Overview
A tabbar app with simple routing system rendering a stack of Views for 4 tabs.
Stack of Views for each tab uses `matchedGeometryEffect` for transitions
A `Router` and `AnimationCoordinator` are used as `.environmentObjects` to coordinate transitions and their elements.

* HomeView
Transition from a logo to a List with the same logo displayed as paralax header
* SearchView
Displays a vertical stack of Horizontal scrollers. A tap on a scroller transitions item to fullscreen
* NotificationsView
Displays a List of cells with avatar and title. Cell tap transitions both elements in 3 new Detail Views continuously and back
* SettingsView
A table of cells where each cell opens with a tap displaying a picture and open button.
Opening the cell transitions all cell elements and animates a navigation bar.

## Transition management
**AnimationCoordinator**
* A simple dictionary of `matchedGeometryEffect` identifiers and the name of corresponding View.
* When a transition happens the `matchedGeometry` id and `String` of the View name are  added to the set ussing `addState`.
* In the next rendering pass the elements are hidden from source view checking `isActive`
* When transition back happens the View and its `matchedGeometryEffect` id are removed from Coordinator using `removeState`

**Router**
* Simple routing system holding and array of Navigation Enums for each state

`Router` and `AnimationCoordinator` used in combination allows to decouple View components while using `matchedGeometryEffect` between transitions. It also minimises transition information that each new View needs to hold to make a forth and back transition.

[Tap to see example video](https://youtube.com/shorts/HgaloYT__hk)

