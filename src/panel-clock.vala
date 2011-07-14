using Gtk;

public class PanelClock : Label {
	
	public PanelClock () {
		Timeout.add (1000 * 30, update);
        update ();
	}
	
	private bool update () {
		char buffer[20];
		Time t = Time.local (time_t ());
		t.strftime (buffer, "%I:%M");
		set_markup ("<big><big>" + (string) buffer + "</big></big>");
		return true;
	}
	
}

public class ClockWindow : PanelAbstractWindow {
    private PanelClock clock;
    public ClockWindow () {
        set_type_hint (Gdk.WindowTypeHint.DOCK);
        set_visual (this.screen.get_rgba_visual ());
        Gdk.RGBA c = Gdk.RGBA();
        c.red = 0.0;
        c.blue = 0.0;
        c.green = 0.0;
        c.alpha = 0.0;
        override_background_color(StateFlags.NORMAL, c);
        set_app_paintable(true);

        clock = new PanelClock ();
        add (clock);
        show_all ();
        screen_size_changed.connect (() => {
            reposition ();
        });
    }

    public override bool map_event (Gdk.Event event) {
        reposition ();
        return true;
    }

    public new void reposition () {
        int w = clock.get_allocated_width ();
        int h = clock.get_allocated_height ();
        set_size_request (w, h);

        move (rect ().width - w - (w / 2), rect ().y + h / 2);
        queue_resize ();
    }

}
