CREATE OR REPLACE FUNCTION public.main_handle_season(
    inp_multiverse RECORD
)
RETURNS void
LANGUAGE plpgsql
AS $function$
DECLARE
    game RECORD; -- Record for the game loop
BEGIN

    ------------------------------------------------------------------------
    ------------------------------------------------------------------------
    ------------ Handle the weeks of the season
    CASE
        ---- Handle the 10th week of the season
        WHEN inp_multiverse.week_number = 10 THEN
            -- Update the normal leagues to say that they are finished
            UPDATE leagues SET is_finished = TRUE
            WHERE id_multiverse = inp_multiverse.id AND level > 0;

            -- Update each club by default staying at their position
            UPDATE clubs SET
                pos_league_next_season = pos_league,
                id_league_next_season = id_league,
                pos_last_season = pos_league
            WHERE id_multiverse = inp_multiverse.id;

        ---- Handle the 13th week of the season ==> Intercontinental Cup Leagues are finished
        WHEN inp_multiverse.week_number = 13 THEN
            -- Update the special leagues to say that they are finished
            UPDATE leagues SET is_finished = TRUE
            WHERE id_multiverse = inp_multiverse.id AND level = 0;

        ---- Handle the 14th week of the season ==> Season is over, start a new one
        WHEN inp_multiverse.week_number = 14 THEN
            -- Generate the games_teamcomp and the games of the next season
            PERFORM main_generate_games_and_teamcomps(
                inp_id_multiverse := inp_multiverse.speed,
                inp_season_number := inp_multiverse.season_number + 2,
                inp_date_start := inp_multiverse.date_season_end + (14 * INTERVAL '7 days' / inp_multiverse.speed)
            );

            -- Update multiverses table for starting next season
            UPDATE multiverses SET
                date_season_start = date_season_end,
                date_season_end = date_season_end + (14 * INTERVAL '7 days' / inp_multiverse.speed),
                season_number = season_number + 1,
                week_number = 0
            WHERE id = inp_multiverse.id;

            -- Update leagues
            UPDATE leagues SET
                season_number = season_number + 1,
                is_finished = NULL,
                cash_last_season = (cash / 1400) * 1400,
                cash = cash - (cash / 1400) * 1400
            WHERE id_multiverse = inp_multiverse.id;

            -- Update clubs
            UPDATE clubs SET
                season_number = season_number + 1,
                id_league = id_league_next_season,
                id_league_next_season = NULL,
                lis_sponsors = lis_sponsors || (
                    (SELECT cash_last_season FROM leagues WHERE id = id_league) * 
                    CASE 
                        WHEN pos_league = 1 THEN 0.20
                        WHEN pos_league = 2 THEN 0.18
                        WHEN pos_league = 3 THEN 0.17
                        WHEN pos_league = 4 THEN 0.16
                        WHEN pos_league = 5 THEN 0.15
                        WHEN pos_league = 6 THEN 0.14
                        ELSE 0
                    END
                ) / 14,
                pos_league = pos_league_next_season,
                pos_league_next_season = NULL,
                league_points = 0
            WHERE id_multiverse = inp_multiverse.id;

            -- Update players
            UPDATE players SET
                expenses_expected = expenses_expected || 
                    FLOOR((expenses_expected[array_length(expenses_expected, 1)] + 100 + keeper + defense + playmaking + passes + winger + scoring + freekick) * 0.5)
            WHERE id_multiverse = inp_multiverse.id;

        ELSE
    END CASE;

    ------------------------------------------------------------------------
    ------------------------------------------------------------------------
    ------------ Try to populate the games for weeks greater than 10
    IF inp_multiverse.week_number >= 10 THEN
        ------ Loop through the list of games that can be populated
        FOR game IN (
            SELECT games.* FROM games
            JOIN games_description ON games.id_games_description = games_description.id
            WHERE id_multiverse = inp_multiverse.id
            AND season_number = (SELECT season_number FROM multiverses WHERE speed = inp_multiverse.speed)
            AND games_description.week_number = (SELECT week_number FROM multiverses WHERE id = inp_multiverse.id)
            AND (id_club_left IS NULL OR id_club_right IS NULL)
            ORDER BY games.id
        ) LOOP
            PERFORM main_populate_game(game.id);
        END LOOP; --- End of the game loop
    END IF; -- End of the week_number check

END;
$function$;