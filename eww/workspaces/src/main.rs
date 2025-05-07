use std::cell::RefCell;
use std::rc::Rc;

use hyprland::event_listener::EventListener;
use hyprland::data::{Monitor, Workspaces};
use hyprland::prelude::*;
use hyprland::shared::HyprError;

const N_WORKSPACES: i32 = 5;
const FOCUSED_WORKSPACE: &str = "(label \
                                    :text \"\" \
                                 )";
const ACTIVE_WORKSPACE: &str = "(label \
                                    :text \"\" \
                                )";
const INACTIVE_WORKSPACE: &str = "(label \
                                    :text \"\" \
                                  )";
const LABEL_BUTTON: &str = "(button \
                            :onclick \"hyprctl dispatch workspace {id}\" \
                            :onrightclick \"hyprctl dispatch workspace {id} && hyprctl dispatch togglespecialworkspace magic\" \
                            :class \"button-dark\" \
                            {label} \
                         )";
const OUTER_BOX: &str = "(box \
                             :orientation \"horizontal\" \
                             :class \"workspaces\" \
                             :spacing 5 \
                             {} \
                          )";

#[derive(Copy, Clone, Debug)]
enum WorkspaceState {
    Active,
    Inactive,
    Focused,
}

fn get_workspaces_state() -> Result<Vec<WorkspaceState>, HyprError> {

    let mut workspaces = vec![WorkspaceState::Inactive; N_WORKSPACES as usize];

    for w in Workspaces::get()? {
        if w.id > 0 && w.id <= N_WORKSPACES {
            workspaces[(w.id - 1) as usize] = WorkspaceState::Active;
        }
    }

    let client_workspace_id = Monitor::get_active()?.active_workspace.id;
    if client_workspace_id > 0 && client_workspace_id <= N_WORKSPACES {
        workspaces[(client_workspace_id - 1) as usize] = WorkspaceState::Focused;
    }

    Ok(workspaces)
}

fn get_widgets(workspaces: Vec<WorkspaceState>) -> String {
    OUTER_BOX.replace("{}", &workspaces.iter().enumerate().fold(String::new(), |acc, (i, w)| {
        let w = match w {
            WorkspaceState::Focused => LABEL_BUTTON.replace("{label}", FOCUSED_WORKSPACE),
            WorkspaceState::Active => LABEL_BUTTON.replace("{label}", ACTIVE_WORKSPACE),
            WorkspaceState::Inactive => LABEL_BUTTON.replace("{label}", INACTIVE_WORKSPACE),
        };

        let inner_box = w.replace("{id}", &(i + 1).to_string());

        acc + &inner_box
    }))
}

fn print_widgets(special_active: bool) {
    if let Ok(w) = get_workspaces_state() {
        let mut widgets = get_widgets(w);

        if special_active {
            widgets = widgets.replace("", "");
        }

        println!("{}", widgets);
    }
}

fn main() -> hyprland::Result<()> {
    // print so eww can get an initial value
    print_widgets(false);

    let special_active = Rc::new(RefCell::new(false));

    let mut event_listener = EventListener::new();

    let new_ref = Rc::clone(&special_active);
    event_listener.add_workspace_changed_handler(move |_data| {
        if let Ok(special_active) = new_ref.try_borrow() {
            print_widgets(*special_active);
        }
    });

    let new_ref = Rc::clone(&special_active);
    event_listener.add_workspace_added_handler(move |_data| { 
        if let Ok(special_active) = new_ref.try_borrow() {
            print_widgets(*special_active);
        }
    });

    let new_ref = Rc::clone(&special_active);
    event_listener.add_workspace_moved_handler(move |_data| {
        if let Ok(special_active) = new_ref.try_borrow() {
            print_widgets(*special_active);
        }
    });

    let new_ref = Rc::clone(&special_active);
    event_listener.add_workspace_deleted_handler(move |_data| {
        if let Ok(special_active) = new_ref.try_borrow() {
            print_widgets(*special_active);
        }
    });

    let new_ref = Rc::clone(&special_active);
    event_listener.add_changed_special_handler(move |_data| { 
        if let Ok(mut special_active) = new_ref.try_borrow_mut() {
            *special_active = true;
            print_widgets(true);
        }
    });


    let new_ref = Rc::clone(&special_active);
    event_listener.add_special_removed_handler(move |_data| {
        if let Ok(mut special_active) = new_ref.try_borrow_mut() {
            *special_active = false;
            print_widgets(false);
        }
    });

    event_listener.start_listener()?;

    Ok(())
}
