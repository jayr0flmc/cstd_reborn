-- This function initializes the game mode and is called before anyone loads into the game.
-- It can be used to pre-initialize any values/tables that will be needed later.
function EDT_Core:_InitGameMode()
	-- Setup rules
	GameRules:SetHeroRespawnEnabled(ENABLE_HERO_RESPAWN)
	GameRules:SetUseUniversalShopMode(UNIVERSAL_SHOP_MODE)
	GameRules:SetSameHeroSelectionEnabled(ALLOW_SAME_HERO_SELECTION)
	
	GameRules:SetHeroSelectionTime(HERO_SELECTION_TIME)
	GameRules:SetPreGameTime(PRE_GAME_TIME)
	GameRules:SetPostGameTime(POST_GAME_TIME)
	GameRules:SetTreeRegrowTime(TREE_REGROW_TIME)
	
	GameRules:SetGoldPerTick(GOLD_PER_TICK)
	GameRules:SetGoldTickTime(GOLD_TICK_TIME)
	
	GameRules:SetHeroMinimapIconScale(MINIMAP_ICON_SIZE)
	GameRules:SetCreepMinimapIconScale(MINIMAP_CREEP_ICON_SIZE)
	GameRules:SetRuneMinimapIconScale(MINIMAP_RUNE_ICON_SIZE)
	
	GameRules:SetRuneSpawnTime(RUNE_SPAWN_TIME)
	
	GameRules:SetFirstBloodActive(ENABLE_FIRST_BLOOD)
	GameRules:SetHideKillMessageHeaders(HIDE_KILL_BANNERS)
	
	--[[
	GameRules:
	SetCreepMinimapIconScale
	SetCustomGameEndDelay
	SetCustomGameSetupAutoLaunchDelay
	SetCustomGameSetupRemainingTime
	SetCustomGameSetupTimeout
	
	]]--
	
	
	
	-- This is multiteam configuration stuff
	if(USE_AITMATIC_PLAYERS_PER_TEAM) then
		local num = math.floor(10 / MAX_NUMBER_OF_TEAMS)
		local count = 0
		
		for team, number in pairs(TEAM_COLORS) do
			if(count >= MAX_NUMBER_OF_TEAMS) then
				GameRules:SetCustomGameTeamMaxPlayers(team, 0)
			else
				GameRules:SetCustomGameTeamMaxPlayers(team, num)
			end
			
			count = count + 1
		end
	else
		local count = 0
		
		for team, number in pairs(CUSTOM_TEAM_PLAYER_COUNT) do
			if(count >= MAX_NUMBER_OF_TEAMS) then
				GameRules:SetCustomGameTeamMaxPlayers(team, 0)
			else
				GameRules:SetCustomGameTeamMaxPlayers(team, number)
			end
			
			count = count + 1
		end
	end
	
	if(USE_CUSTOM_TEAM_COLORS) then
		for team, color in pairs(TEAM_COLORS) do
			SetTeamCustomHealthbarColor(team, color[1], color[2], color[3])
		end
	end
	DebugPrint('[EDT GameMode] GameRules set.')
	
	
	
	-- Event Hooks
	-- All of these events can potentially be fired by the game, though only the uncommented ones have had
	-- functions supplied for them.
	-- If you are interested in the other events, you can uncomment the ListenToGameEvent line
	-- and add function to handle the event.
	--ListenToGameEvent('', Dynamic_Wrap(EDT_Core, ''), self)
	
	-- Core team events
	--ListenToGameEvent('team_info', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('team_score', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('team_broadcast_audio', Dynamic_Wrap(EDT_Core, ''), self)
	
	-- Player events
	--ListenToGameEvent('player_team', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_class', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_death', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_hurt', Dynamic_Wrap(EDT_Core, ''), self)
	ListenToGameEvent('player_chat', Dynamic_Wrap(EDT_Core, 'OnPlayerChat'), self)
	--ListenToGameEvent('player_score', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_spawn', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_shoot', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_use', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_changename', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_hintmessage', Dynamic_Wrap(EDT_Core, ''), self)
	ListenToGameEvent('player_connect', Dynamic_Wrap(EDT_Core, 'OnPlayerConnect'), self)
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(EDT_Core, 'OnPlayerConnectFull'), self)
	ListenToGameEvent('player_disconnect', Dynamic_Wrap(EDT_Core, 'OnPlayerDisconnect'), self)
	ListenToGameEvent('player_reconnected', Dynamic_Wrap(EDT_Core, 'OnPlayerReconnected'), self)
	ListenToGameEvent('player_changename', Dynamic_Wrap(EDT_Core, 'OnPlayerChangeName'), self)
	
	-- Game events
	ListenToGameEvent('game_init', Dynamic_Wrap(EDT_Core, 'OnGameInit'), self)
	--ListenToGameEvent('game_newmap', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('game_start', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('game_end', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('round_start', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('round_end', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('round_start_pre_entity', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('teamplay_round_start', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('hostname_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('finale_start', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('game_message', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('break_breakable', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('break_prop', Dynamic_Wrap(EDT_Core, ''), self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(EDT_Core, 'OnNPCSpawned'), self)
	--ListenToGameEvent('npc_replaced', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('entity_killed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('entity_hurt', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('bonus_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_stats_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('achievement_event', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('achievement_earned', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('achievement_write_failed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('physgun_pickup', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('flare_ignite_npc', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('helicopter_grenade_punt_miss', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('user_data_downloaded', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('ragdoll_dissolved', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('gameinstructor_draw', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('gameinstructor_nodraw', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('map_transition', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('instructor_server_hint_create', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('instructor_server_hint_stop', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('chat_new_message', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('chat_members_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(EDT_Core, ''), self)
	
	-- Economy events
	--ListenToGameEvent('inventory_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('cart_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('store_pricesheet_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('gc_connected', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('item_schema_initialized', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('drop_rate_modified', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('event_ticket_modified', Dynamic_Wrap(EDT_Core, ''), self)
	
	-- ModEvents
	--ListenToGameEvent('modifier_event', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_kill', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_deny', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_barracks_kill', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_tower_kill', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_roshan_kill', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_courier_lost', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_courier_respawned', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_glyph_used', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_super_creeps', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_item_purchased', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_item_gifted', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_rune_pickup', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_rune_spotted', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_item_spotted', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_no_battle_points', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_chat_international', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_action_item', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_chat_ban_notification', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_chat_event', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_chat_timed_reward', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_pause_event', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_chat_kill_streak', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_chat_first_blood', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_update_selected_unit', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_update_query_unit', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_update_killcam_unit', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_take_tower_damage', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_hud_error_message', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_action_success', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_starting_position_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_money_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_enemy_money_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_portrait_unit_stats_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_portrait_unit_modifiers_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_force_portrait_update', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_inventory_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_inventory_item_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_ability_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_portrait_ability_layout_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_inventory_item_added', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_inventory_changed_query_unit', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_link_clicked', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_set_quick_buy', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_quick_buy_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_shop_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_show_killcam', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_show_minikillcam', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('gc_user_session_created', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('team_data_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('guild_data_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('guild_open_parties_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('fantasy_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('fantasy_league_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('fantasy_score_info_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_info_updated', Dynamic_Wrap(EDT_Core, ''), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(EDT_Core, 'OnGameRulesStateChange'), self)
	--ListenToGameEvent('match_history_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('match_details_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('live_games_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('recent_matches_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('news_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('persona_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('tournament_state_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('party_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('lobby_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dashboard_caches_cleared', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('last_hit', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_completed_game', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_reconnected', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('nommed_tree', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_rune_activated_server', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_used_ability', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_non_player_used_ability', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_ability_channel_finished', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_holdout_revive_complete', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_player_killed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('bindpanel_open', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('bindpanel_close', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('keybind_changed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_item_drag_begin', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_item_drag_end', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_shop_item_drag_begin', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_shop_item_drag_end', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_item_purchased', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_item_used', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_item_auto_purchase', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_unit_event', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_quest_started', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_quest_completed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('gameui_activated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('gameui_hidden', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_fullyjoined', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_spectate_hero', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_match_done', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_match_done_client', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('set_instructor_group_enabled', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('joined_chat_channel', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('left_chat_channel', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('gc_chat_channel_list_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('today_message_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('file_downloaded', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('player_report_counts_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('scaleform_file_download_complete', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('item_purchased', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('gc_mismatched_version', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('demo_skip', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('demo_start', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('demo_stop', Dynamic_Wrap(EDT_Core, ''), self)
	
	--ListenToGameEvent('map_shutdown', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_workshop_fileselected', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_workshop_filecanceled', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('rich_presence_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_hero_random', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_rd_chat_turn', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('dota_favorite_heroes_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('profile_closed', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('item_preview_closed', Dynamic_Wrap(EDT_Core, ''), self)
	
	
	
	--[[
	-- This block is only used for testing events handling in the event that valve adds more in the future
	Convars:RegisterCommand('events_test', function()
		GameMode:StartEventTest()
	end, 'events test', 0)
	]]--
	
	
	
	-- Change random seed
	
	-- Initialized tabled for tracking state
	self.bSeenWaitForPlayers = false
	self.vUserIDs = {}
	
	DebugPrint('[EDT GameMode] Done loading EDT GameMode.\n\n')
end