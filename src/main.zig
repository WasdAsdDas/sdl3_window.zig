const std = @import("std");
const log = std.log.scoped(.app);

const c = @cImport({
    @cInclude("SDL3/SDL.h");
});

pub fn main() !void {
    if (!c.SDL_SetAppMetadata("App name", "v0.0.0", "com.example")) {
        log.err("Failed to set app meta data {s}", .{c.SDL_GetError()});
    }

    if (!c.SDL_Init(c.SDL_INIT_VIDEO)) {
        log.err("Failed to initilaize SDL {s}", .{c.SDL_GetError()});
    }
    defer c.SDL_Quit();

    const main_window = c.SDL_CreateWindow("SDL Window", 1920, 1080, c.SDL_WINDOW_RESIZABLE);
    if (main_window == null) {
        log.err("Failed to create window {s}", .{c.SDL_GetError()});
    }
    defer c.SDL_DestroyWindow(main_window);

    while (true) {
        if (!handle_Events()) break;
        if (!update()) break;
        if (!render()) break;
    }
}

fn handle_Events() bool {
    var event: c.SDL_Event = undefined;
    while (c.SDL_PollEvent(&event)) {
        if (event.type == c.SDL_EVENT_QUIT) {
            return false;
        }
    }

    return true;
}

fn update() bool {
    return true;
}

fn render() bool {
    return true;
}