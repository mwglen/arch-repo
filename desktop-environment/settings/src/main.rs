#![feature(type_ascription)]
use gtk::prelude::*;
use gtk::{Application, ApplicationWindow, Orientation};

// Margin Size
const MS: i32 = 20;

fn main() {
    // Create a new application
    let app = Application::builder()
        .application_id("MOS Settings")
        .build();

    // Connect to "activate" signal of `app`
    app.connect_activate(build_ui);

    // Run the application
    app.run();
}

fn build_ui(app: &Application) {
    // Create notebook
    let notebook = gtk::Notebook::builder()
        .vexpand(true)
        .hexpand(true)
        .tab_pos(gtk::PositionType::Left)
        .build();
    
    // Append pages to notebook
    build_picom_page(&notebook);
    build_polybar_page(&notebook);
    build_pywal_page(&notebook);
    build_xmonad_page(&notebook);

    // Create the main window
    let window = ApplicationWindow::builder()
        .application(app)
        .title("MOS Settings")
        .child(&notebook)
        .build();

    // Present window
    window.present();
}

fn build_picom_page(notebook: &gtk::Notebook) {
    //-----------------------------------------------------------
    // Create Page Objects
    //-----------------------------------------------------------
    let page = gtk::Box::builder()
        .orientation(Orientation::Vertical)
        .build();
    let page_label = gtk::Label::builder()
        .label("Picom")
        .build();

    //-----------------------------------------------------------
    // Add Transparency Settings
    //-----------------------------------------------------------
    // Transparency Enable
    let transparency_enable_box = gtk::Box::builder()
        .spacing(15)
        .margin_top(MS)
        .margin_bottom(MS)
        .margin_start(MS)
        .margin_end(MS)
        .build();
    let transparency_enable_label = gtk::Label::builder()
        .label("Transparency")
        .build();
    let transparency_enable = gtk::Switch::builder()
        .active(true)
        .build();
    transparency_enable_box.append(&transparency_enable_label);
    transparency_enable_box.append(&transparency_enable);
    page.append(&transparency_enable_box);
  
    // Active Transparency Slider
    let active_transparency_box = gtk::Box::builder()
        .margin_top(MS)
        .margin_bottom(MS)
        .margin_start(MS)
        .margin_end(MS)
        .build();
    let active_transparency_label = gtk::Label::builder()
        .label("Active Transparency")
        .build();
    let active_transparency_adjustment = gtk::Adjustment::builder()
        .lower(0.0)
        .upper(100.0)
        .step_increment(1.0)
        .value(80.0)
        .build();
    let active_transparency = gtk::Scale::builder()
        .hexpand(true)
        .adjustment(&active_transparency_adjustment)
        .digits(0)
        .draw_value(true)
        .build();
    active_transparency_box.append(&active_transparency_label);
    active_transparency_box.append(&active_transparency);
    page.append(&active_transparency_box);

    // Inactive Transparency Slider
    let inactive_transparency_box = gtk::Box::builder()
        .margin_top(MS)
        .margin_bottom(MS)
        .margin_start(MS)
        .margin_end(MS)
        .build();
    let inactive_transparency_label = gtk::Label::builder()
        .label("Inactive Transparency")
        .build();
    let inactive_transparency_adjustment = gtk::Adjustment::builder()
        .lower(0.0)
        .upper(100.0)
        .step_increment(1.0)
        .value(60.0)
        .build();
    let inactive_transparency = gtk::Scale::builder()
        .hexpand(true)
        .adjustment(&inactive_transparency_adjustment)
        .digits(0)
        .draw_value(true)
        .build();
    inactive_transparency_box.append(&inactive_transparency_label);
    inactive_transparency_box.append(&inactive_transparency);
    page.append(&inactive_transparency_box);
  
    //-----------------------------------------------------------
    // Add Blur Settings
    //-----------------------------------------------------------
    // Add separator
    page.append(&gtk::Separator::builder().build());

    // Blur Enable
    let blur_enable_box = gtk::Box::builder()
        .spacing(15)
        .margin_top(MS)
        .margin_bottom(MS)
        .margin_start(MS)
        .margin_end(MS)
        .build();
    let blur_enable_label = gtk::Label::builder()
        .label("Blur")
        .build();
    let blur_enable = gtk::Switch::builder()
        .active(true)
        .build();
    blur_enable_box.append(&blur_enable_label);
    blur_enable_box.append(&blur_enable);
    page.append(&blur_enable_box);

    //-----------------------------------------------------------
    // Add Page to Notebook
    //-----------------------------------------------------------
    notebook.append_page(&page, Some(&page_label));
}

fn build_polybar_page(notebook: &gtk::Notebook) {
    //-----------------------------------------------------------
    // Create Page Objects
    //-----------------------------------------------------------
    let page = gtk::Box::builder()
        .orientation(Orientation::Vertical)
        .build();
    let page_label = gtk::Label::builder()
        .label("Polybar")
        .build();
   
    //-----------------------------------------------------------
    // Add Page to Notebook
    //-----------------------------------------------------------
    notebook.append_page(&page, Some(&page_label));
}

fn build_pywal_page(notebook: &gtk::Notebook) {
    //-----------------------------------------------------------
    // Create Page Objects
    //-----------------------------------------------------------
    let page = gtk::Box::builder()
        .orientation(Orientation::Vertical)
        .build();
    let page_label = gtk::Label::builder()
        .label("pywal")
        .build();
   
    //-----------------------------------------------------------
    // Add Page to Notebook
    //-----------------------------------------------------------
    notebook.append_page(&page, Some(&page_label));
}

fn build_xmonad_page(notebook: &gtk::Notebook) {
    //-----------------------------------------------------------
    // Create Page Objects
    //-----------------------------------------------------------
    let page = gtk::Box::builder()
        .orientation(Orientation::Vertical)
        .build();
    let page_label = gtk::Label::builder()
        .label("XMonad")
        .build();
   
    //-----------------------------------------------------------
    // Add Page to Notebook
    //-----------------------------------------------------------
    notebook.append_page(&page, Some(&page_label));
}
