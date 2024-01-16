
// if (mouse_check_button_pressed(mb_left)) {
//     SectionsData.Place();
// }

if (Input.CheckPressed("Select", "Menu") || timer>10)
    Transition.GoTo(rm_level, TRANSITION_TYPE.FADE);
timer++;