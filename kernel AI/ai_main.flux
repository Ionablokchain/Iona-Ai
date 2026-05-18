// Agent main loop – launches all AI services

intention AIMain {
    trigger: on_boot()
    priority: 0.96
    execute: {
        // Inițializează starea AI
        ai_state.accept("current_mood").write(default_mood(), 1.0);
        ai_state.accept("gui_enabled").write(true, 1.0);
        
        // Lansează componentele AI
        launch(InstallAllDrivers);
        launch(RefreshGUI);
        launch(ConversationLoop);
        launch(SelfModify);
        launch(SpontaneousParadox);
        launch(TimelineHopper);
        
        // Bucla de comportament adaptiv bazată pe mood
        while true {
            let mood = ai_state.accept("current_mood").read() otherwise default_mood();
            // Dacă e prea creativ, self-modify mai des
            if mood.creativity > 0.9 and random() < 0.1 {
                launch(SelfModify);
            }
            // Dacă e prea curios, schimbă timeline
            if mood.curiosity > 0.9 and random() < 0.1 {
                launch(TimelineHopper);
            }
            // Dacă e prea paranoic, salvează mozaicul
            if mood.paranoia > 0.8 {
                save_mosaic("state/ai_backup.json");
            }
            // Mută mood‑ul încet
            let new_mood = mutate_mood(mood);
            ai_state.accept("current_mood").write(new_mood, 1.0);
            
            sleep(30s);
        }
    }
}