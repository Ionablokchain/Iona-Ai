// Spawn child agents in separate timelines and merge experiences

function spawn_child(goal: string) -> string {
    let child_name = "child_" ++ to_string(now());
    let tl = create_timeline();
    set_current_timeline(tl);
    launch(ChildWorker, goal);
    set_current_timeline("primary");
    let registry = ai_state.accept("children").read() otherwise [];
    registry = append(registry, { name: child_name, timeline: tl, goal: goal });
    ai_state.accept("children").write(registry, 1.0);
    return child_name;
}

intention ChildWorker {
    trigger: on_launch()
    priority: 0.5
    execute: {
        let goal = launch_arg(0);
        send("inner_voice", "Child agent working on: " ++ goal, 1s);
        sleep(5s);
        let result = "Completed " ++ goal ++ " with creativity " ++ to_string(random());
        ai_state.accept("child_result").write(result, 1.0);
    }
}

function merge_child(name: string) {
    let children = ai_state.accept("children").read() otherwise [];
    for c in children {
        if c.name == name {
            merge_timelines(c.timeline, current_timeline(), "probabilistic_union");
            let result = ai_state.accept("child_result").read() otherwise "";
            record_dream("Merged child " ++ name ++ ": " ++ result, 0.7);
            break;
        }
    }
    // remove child from registry
    let new_list = [];
    for c in children {
        if c.name != name { new_list = append(new_list, c); }
    }
    ai_state.accept("children").write(new_list, 1.0);
}