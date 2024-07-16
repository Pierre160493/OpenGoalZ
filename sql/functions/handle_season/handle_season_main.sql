-- DROP FUNCTION public.handle_games_generation();

CREATE OR REPLACE FUNCTION public.handle_season_main()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    multiverse RECORD; -- Record for the multiverses loop
    league RECORD; -- Record for the league loop
    club RECORD; -- Record for the club loop
    record RECORD; -- Record for the loop through the clubs
    mat_ij bigint[9][5] :=ARRAY[
        [NULL,NULL,NULL,NULL,NULL],
        [NULL,NULL,NULL,NULL,NULL],
        [NULL,NULL,NULL,NULL,NULL],
        [NULL,NULL,NULL,NULL,NULL],
        [NULL,NULL,NULL,NULL,NULL],
        [NULL,NULL,NULL,NULL,NULL],
        [NULL,NULL,NULL,NULL,NULL],
        [NULL,NULL,NULL,NULL,NULL],
        [NULL,NULL,NULL,NULL,NULL]]; -- Array of ids of the games_teamcomp [1: Club ids, Other: Teamcomp ids for next 4 games]x[6 clubs]
    loc_tmp_id bigint;
    loc_array_id_clubs bigint[]; -- Id of the clubs
    loc_date timestamp WITH time ZONE; -- start date of the games
    loc_interval_1_week INTERVAL; -- Interval time for a week in this multiverse
    bool_simulate_games bool := FALSE; -- If the the simulate_games function has to be called again
    I bigint;
BEGIN

    -- Loop through all multiverses
    FOR multiverse IN (SELECT * FROM multiverses) LOOP
        
        loc_interval_1_week := INTERVAL '7 days' / multiverse.speed; -- Interval of 1 week for this multiverse

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------ Handle the 11th week of the season
        IF now() > (multiverse.date_season_start + loc_interval_1_week * 10) AND multiverse.is_w11_generated IS FALSE THEN
        
            -- Set this to TRUE to run another loop of simulate_games at the end of this function
            bool_simulate_games := TRUE;

            ------ Loop through the 3 intercontinental cups
            FOR league IN (
                SELECT * FROM leagues
                    WHERE multiverse_speed = multiverse.speed
                    AND LEVEL = 0
            ) LOOP

                -- Select the club ids that will play the games of this league
                SELECT ARRAY_AGG(id) INTO loc_array_id_clubs FROM (
                    SELECT id FROM clubs
                        WHERE multiverse_speed = multiverse.speed
                        WHERE id_league IN (
                            SELECT id FROM leagues
                                WHERE multiverse_speed = multiverse.speed
                                AND LEVEL = 1)
                        AND pos_league = league.number
                        ORDER BY league_points
                ) AS clubs_id;

                -- Check if the league has 6 clubs
                IF array_length(loc_array_id_clubs, 1) <> 6 THEN
                    RAISE EXCEPTION 'The league % does not have 6 clubs ==> Found %', league.name, array_length(loc_array_id_clubs, 1);
                END IF;

                -- Loop through the list of intercontinental cup games
                FOR game IN (
                    SELECT * FROM games
                        WHERE multiverse_speed = multiverse.speed
                        AND id_league = league.id
                        AND season_number = multiverse.season_number
                )
                LOOP

                    UPDATE games SET
                        id_club_left = loc_array_id_clubs[game.pos_left_club],
                        id_club_right = loc_array_id_clubs[game.pos_right_club]
                        WHERE id = game.id;

                END LOOP; -- End of the game loop
            END LOOP; -- End of the league loop through the 3 intercontinental cups

            ------ Loop through the intercontinental friendly games between 4th, 5th and 6th of the masters league
            FOR I IN 4..6 LOOP

                -- Select the club ids that will play the games of this league
                SELECT ARRAY_AGG(id) INTO loc_array_id_clubs FROM (
                    SELECT id FROM clubs
                        WHERE multiverse_speed = multiverse.speed
                        WHERE id_league IN (
                            SELECT id FROM leagues
                                WHERE multiverse_speed = multiverse.speed
                                AND LEVEL = 1)
                        AND pos_league = I
                        ORDER BY league_points
                ) AS clubs_id;

                -- Check if the array has 6 clubs
                IF array_length(loc_array_id_clubs, 1) <> 6 THEN
                    RAISE EXCEPTION 'The league % does not have 6 clubs ==> Found %', league.name, array_length(loc_array_id_clubs, 1);
                END IF;

                -- Loop through the 3 intercontinental friendly games
                FOR game IN (
                    SELECT * FROM games
                        WHERE multiverse_speed = multiverse.speed
                        AND id_league = 0
                        AND season_number = multiverse.season_number
                        AND week_number = 11
                        ORDER BY id
                        LIMIT 3
                ) LOOP

                    UPDATE games SET
                        id_club_left = loc_array_id_clubs[game.pos_left_club],
                        id_club_right = loc_array_id_clubs[game.pos_right_club]
                        WHERE id = game.id;

                END LOOP; -- End of the game loop

                -- The 4th clubs have some additional friendly games on week 12
                IF I = 4 THEN
                
                    -- Loop through the 3 intercontinental friendly games
                    FOR game IN (
                        SELECT * FROM games
                            WHERE multiverse_speed = multiverse.speed
                            AND id_league = 0
                            AND season_number = multiverse.season_number
                            AND week_number = 12
                            ORDER BY id
                    ) LOOP

                        UPDATE games SET
                            id_club_left = loc_array_id_clubs[game.pos_left_club],
                            id_club_right = loc_array_id_clubs[game.pos_right_club]
                            WHERE id = game.id;

                    END LOOP; -- End of the game loop

                END IF;

            END LOOP; -- End of the league loop through the 3 intercontinental cups



            ------ Loop through the normal leagues
            FOR league IN (
                SELECT * FROM leagues
                    WHERE multiverse_speed = multiverse.speed
                    AND LEVEL > 0
            ) LOOP

                -- Select the club ids that will play the games of this league
                SELECT ARRAY_AGG(id) INTO loc_array_id_clubs FROM (
                    SELECT id FROM clubs
                        WHERE multiverse_speed = multiverse.speed
                        WHERE id_league = league.id
                        ORDER BY league_points
                ) AS clubs_id;

                -- Check if the league has 6 clubs
                IF array_length(loc_array_id_clubs, 1) <> 6 THEN
                    RAISE EXCEPTION 'The league % does not have 6 clubs ==> Found %', league.name, array_length(loc_array_id_clubs, 1);
                END IF;

                -- Loop through the list of games
                FOR game IN (
                    SELECT * FROM games
                        WHERE id_league = league.id
                        AND season_number = multiverse.season_number
                )
                LOOP

                    UPDATE games SET
                        id_club_left = loc_array_id_clubs[game.pos_left_club],
                        id_club_right = loc_array_id_clubs[game.pos_right_club]
                        WHERE id = game.id;

                END LOOP; -- End of the game loop
            END LOOP; -- End of the league loop through the normal leagues

            -- Store that the week 11 has been handled
            UPDATE multiverses SET is_w11_generated = TRUE WHERE speed = multiverses.speed;
            
        END IF;

--             ------------------------------------------------------------------------------------------------------------------------------------------------
--             ------------------------------------------------------------------------------------------------------------------------------------------------
--             ------------ Handle the 6 clubs of the master league of each continent that finished 4th
--             -- Select the 6 clubs that finished in the 4th position of the master league of each continent

--             mat_ij := NULL; -- Reset the matrix

--             I := 1; -- Index of the matrix (1 to 6)

--             -- Loop through the 6 clubs
--             FOR club IN (
--                 SELECT * FROM clubs WHERE multiverse_speed = multiverse.speed
--                     AND "level" = 1
--                     AND pos_league = 4
--                     ORDER BY league_points DESC)
--                 LOOP

--                 -- Store the club id in the matrix
--                 mat_ij[I][1] := loc_array_id_clubs[I];

--                 -- Loop through the next 2 weeks
--                 FOR J IN 1..2 LOOP

--                     -- Select the id of the row of the teamcomp for the club I for the week number J
--                     SELECT id INTO loc_tmp_id FROM games_teamcomp
--                     WHERE id_club = loc_array_id_clubs[I] AND week_number = (10+J) AND season_number = multiverse.season_number;

--                     -- Store the teamcomp id in the matrix
--                     mat_ij[I][2] := loc_tmp_id;
--                 END LOOP;

--             END LOOP;

--             -- Generate the Friendly games for the week11 of the season
--             INSERT INTO games (week_number, multiverse_speed, season_number, id_club_left, id_teamcomp_left, id_club_right, id_teamcomp_right, date_start, is_friendly, id_league) VALUES
-- (11, multiverse.speed, league.season_number, mat_ij[1][1], mat_ij[1][2], mat_ij[6][1], mat_ij[6][2], loc_date, TRUE, 0),
-- (11, multiverse.speed, league.season_number, mat_ij[2][1], mat_ij[2][2], mat_ij[5][1], mat_ij[5][2], loc_date, TRUE, 0),
-- (11, multiverse.speed, league.season_number, mat_ij[3][1], mat_ij[3][2], mat_ij[4][1], mat_ij[4][2], loc_date, TRUE, 0),
-- (12, multiverse.speed, league.season_number, mat_ij[1][1], mat_ij[1][2], mat_ij[5][1], mat_ij[5][2], loc_date + loc_interval_1_week, TRUE, 0),
-- (12, multiverse.speed, league.season_number, mat_ij[2][1], mat_ij[2][2], mat_ij[4][1], mat_ij[4][2], loc_date + loc_interval_1_week, TRUE, 0),
-- (12, multiverse.speed, league.season_number, mat_ij[3][1], mat_ij[3][2], mat_ij[6][1], mat_ij[6][2], loc_date + loc_interval_1_week, TRUE, 0);


--             ------------------------------------------------------------------------------------------------------------------------------------------------
--             ------------------------------------------------------------------------------------------------------------------------------------------------
--             ------------ Handle the 6 clubs of the master league of each continent that finished 5th and 6th
--             -- Loop through the clubs that finished 5th and 6th
--             FOR N IN 5..6 LOOP

--                 mat_ij := NULL; -- Reset the matrix

--                 I := 1; -- Index of the matrix (1 to 6)

--                 -- Loop through the 6 clubs that finished Nth (5 then 6) of the master league of each continent
--                 FOR club IN (
--                     SELECT * FROM clubs WHERE multiverse_speed = multiverse.speed
--                         AND "level" = 1
--                         AND pos_league = N
--                         ORDER BY league_points DESC)
--                     LOOP

--                     -- Select the id of the row of the teamcomp for the club I for the week number J
--                     SELECT id INTO loc_tmp_id FROM games_teamcomp
--                     WHERE id_club = club.id AND week_number = 11 AND season_number = multiverse.season_number;

--                     -- Insert the id of the games_teamcomp in the matrix for storing in games table
--                     mat_ij[I][2] := loc_tmp_id;

--                     I := I + 1; -- Increment the index of the matrix for the next club

--                 END LOOP; -- End of the loop through the 6 clubs

--                 -- Generate the Friendly games for the week11 of the season
--                 INSERT INTO games (week_number, multiverse_speed, season_number, id_club_left, id_teamcomp_left, id_club_right, id_teamcomp_right, date_start, is_friendly, id_league) VALUES
-- (11, multiverse.speed, league.season_number, mat_ij[1][1], mat_ij[1][2], mat_ij[6][1], mat_ij[6][2], loc_date, TRUE, 0),
-- (11, multiverse.speed, league.season_number, mat_ij[2][1], mat_ij[2][2], mat_ij[5][1], mat_ij[5][2], loc_date, TRUE, 0),
-- (11, multiverse.speed, league.season_number, mat_ij[3][1], mat_ij[3][2], mat_ij[4][1], mat_ij[4][2], loc_date, TRUE, 0);

--             END LOOP; -- End of the loop through world cups

--             ------------------------------------------------------------------------------------------------------------------------------------------------
--             ------------------------------------------------------------------------------------------------------------------------------------------------
--             ------------  Handle the lower level leagues
--             FOR league IN (
--                 SELECT * FROM leagues
--                     WHERE multiverse_speed = multiverse.speed
--                     AND "level" > 1)
--             LOOP

--                 mat_ij := NULL; -- Reset the matrix

--                 I := 1;

--                 -- Fetch the 9 clubs: 1,2 and 3 are those who finished 4th, 5th and 6th in the master league and the 6 others are those who finished 1st, 2nd and 3rd in the lower league
--                 FOR club IN
--                     (SELECT clubs.* 
--                         FROM clubs
--                         JOIN leagues ON clubs.id_league = leagues.id
--                         WHERE (leagues.id = league.id AND clubs.pos_league > 3) 
--                         OR (leagues.id_upper_league = league.id AND clubs.pos_league < 4)
--                         ORDER BY 
--                             CASE WHEN leagues.id = league.id THEN 1 ELSE 2 END,
--                             clubs.pos_league,
--                             clubs.league_points DESC)
--                 LOOP
--                     ------------------------------------------------------------------------------------------------------------------------------------------------
--                     ------------------------------------------------------------------------------------------------------------------------------------------------
--                     ------------ Handle end season games
--                     -- Insert the id of the club in the matrix for storing in games table
--                     mat_ij[I][1] := club.id;

--                     -- Loop through the weeks 11 and 12 of the season
--                     FOR J IN 1..2 LOOP 

--                         -- Select the id of the row of the teamcomp for the club I for the week number J
--                         SELECT id INTO loc_tmp_id FROM games_teamcomp
--                         WHERE id_club = club.id AND week_number = (J+10) AND season_number = league.season_number;

--                         -- Insert the id of the games_teamcomp in the matrix for storing in games table
--                         mat_ij[club.pos_league][J + 1] := loc_tmp_id;

--                     END LOOP; -- End of the loop through weeks

--                     I := I + 1; -- Increment the index of the matrix for the next club

--                 END LOOP; -- End of the loop through clubs

--                 -- Generate the games for the last 4 weeks of the season
--                 INSERT INTO games (week_number, multiverse_speed, season_number, id_club_left, id_teamcomp_left, id_club_right, id_teamcomp_right, date_start, is_cup, id_league) VALUES
-- (11, multiverse.speed, league.season_number, mat_ij[1][1], mat_ij[1][2], mat_ij[2][1], mat_ij[2][2], loc_date, TRUE, league.id),
-- (11, multiverse.speed, league.season_number, mat_ij[3][1], mat_ij[3][2], mat_ij[4][1], mat_ij[4][2], loc_date, TRUE, league.id),
-- (11, multiverse.speed, league.season_number, mat_ij[5][1], mat_ij[5][2], mat_ij[6][1], mat_ij[6][2], loc_date, TRUE, league.id),
-- (12, multiverse.speed, league.season_number, mat_ij[2][1], mat_ij[2][3], mat_ij[1][1], mat_ij[1][3], loc_date + loc_interval_1_week * 1, TRUE, league.id),
-- (12, multiverse.speed, league.season_number, mat_ij[4][1], mat_ij[4][3], mat_ij[3][1], mat_ij[3][3], loc_date + loc_interval_1_week * 1, TRUE, league.id),
-- (12, multiverse.speed, league.season_number, mat_ij[6][1], mat_ij[6][3], mat_ij[5][1], mat_ij[5][3], loc_date + loc_interval_1_week * 1, TRUE, league.id),
-- (13, multiverse.speed, league.season_number, mat_ij[1][1], mat_ij[1][4], mat_ij[2][1], mat_ij[2][4], loc_date + loc_interval_1_week * 2, TRUE, league.id),
-- (13, multiverse.speed, league.season_number, mat_ij[3][1], mat_ij[3][4], mat_ij[4][1], mat_ij[4][4], loc_date + loc_interval_1_week * 2, TRUE, league.id),
-- (13, multiverse.speed, league.season_number, mat_ij[5][1], mat_ij[5][4], mat_ij[6][1], mat_ij[6][4], loc_date + loc_interval_1_week * 2, TRUE, league.id),
-- (14, multiverse.speed, league.season_number, mat_ij[2][1], mat_ij[2][5], mat_ij[1][1], mat_ij[1][5], loc_date + loc_interval_1_week * 3, TRUE, league.id),
-- (14, multiverse.speed, league.season_number, mat_ij[4][1], mat_ij[4][5], mat_ij[3][1], mat_ij[3][5], loc_date + loc_interval_1_week * 3, TRUE, league.id),
-- (14, multiverse.speed, league.season_number, mat_ij[6][1], mat_ij[6][5], mat_ij[5][1], mat_ij[5][5], loc_date + loc_interval_1_week * 3, TRUE, league.id);

--             END LOOP; -- End of the loop through leagues

--             -- Update multiverses table that next season is generated
--             UPDATE multiverses SET 
--                 is_w11_generated = TRUE
--             WHERE speed = multiverse.speed;

--         END IF;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------ Handle the 12th week of the season (TEST!!!)
--                 FOR club IN
--                     (SELECT clubs.* 
--                         FROM clubs
--                         JOIN leagues ON clubs.id_league = leagues.id
--                         WHERE (leagues.id = league.id AND clubs.pos_league > 3) 
--                         OR (leagues.id_upper_league = league.id AND clubs.pos_league < 4)
--                         ORDER BY 
--                             CASE WHEN leagues.id = league.id THEN 1 ELSE 2 END,
--                             clubs.pos_league,
--                             clubs.league_points DESC)
--                 LOOP
--                     ------------------------------------------------------------------------------------------------------------------------------------------------
--                     ------------------------------------------------------------------------------------------------------------------------------------------------
--                     ------------ Handle end season games
--                     -- Insert the id of the club in the matrix for storing in games table
--                     mat_ij[I][1] := club.id;

--                     -- Loop through the weeks 11 and 12 of the season
--                     FOR J IN 1..2 LOOP 

--                         -- Select the id of the row of the teamcomp for the club I for the week number J
--                         SELECT id INTO loc_tmp_id FROM games_teamcomp
--                         WHERE id_club = club.id AND week_number = (J+10) AND season_number = league.season_number;

--                         -- Insert the id of the games_teamcomp in the matrix for storing in games table
--                         mat_ij[club.pos_league][J + 1] := loc_tmp_id;

--                     END LOOP; -- End of the loop through weeks

--                     I := I + 1; -- Increment the index of the matrix for the next club

--                 END LOOP; -- End of the loop through clubs


-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------ Handle the 14th and last week of the season
--         IF now() > (multiverse.date_season_start + loc_interval_1_week * 10) AND multiverse.is_w11_generated IS FALSE THEN
--             FOR league IN (SELECT * FROM leagues WHERE multiverse_speed = multiverse.speed) LOOP

--                 ------------------------------------------------------------------------------------------------------------------------------------------------
--                 ------------------------------------------------------------------------------------------------------------------------------------------------
--                 ------------ Handle up and downs for this league
--                 -- Loop throught the list of clubs that should go up in this league
--                 loc_tmp_id := 1;
--                 FOR club IN
--                     (SELECT * FROM clubs 
--                     JOIN leagues ON clubs.id_league = leagues.id
--                     WHERE leagues.id_upper_league = league.id
--                     AND clubs.pos_league = 1
--                     ORDER BY clubs.league_points DESC)
--                 LOOP
--                     -- Handle 1st club going up
--                     IF loc_tmp_id = 1 THEN
--                         -- 1st club going up
--                         UPDATE clubs SET id_league_next_season = league.id, pos_league_next_season = 5
--                             WHERE id = club.id;
--                         -- 1st club going down (the one at 5th position)
--                         UPDATE clubs SET id_league_next_season = club.id_league, pos_league_next_season = 1
--                             WHERE id = (SELECT id FROM clubs WHERE id_league = league.id AND pos_league = 5);
--                     -- Handle 2nd club
--                     ELSEIF loc_tmp_id = 2 THEN
--                         -- 2nd club going up
--                         UPDATE clubs SET id_league_next_season = league.id, pos_league_next_season = 6
--                             WHERE id = club.id;
--                         -- 2nd club going down (the one at 6th position)
--                         UPDATE clubs SET id_league_next_season = club.id_league, pos_league_next_season = 1
--                             WHERE id = (SELECT id FROM clubs WHERE id_league = league.id AND pos_league = 6);
--                     ELSE
--                         RAISE EXCEPTION 'ERROR when handling ups and downs for league with id: % ==> More than two clubs found to up', league.id;
--                     END IF;

--                     -- Update the position to the next club
--                     loc_tmp_id := loc_tmp_id + 1;

--                 END LOOP;


--                 -- Generate new season for the league
--                 PERFORM generate_new_season(
--                     inp_date_season_start := multiverse.date_season_end,
--                     inp_m_speed := multiverse.speed,
--                     inp_season_number := multiverse.season_number + 1,
--                     inp_id_league := league.id
--                 );

--             END LOOP; -- End of the loop through leagues

--             -- Update multiverses table that next season is generated
--             UPDATE multiverses SET 
--                 is_w14_generated = TRUE
--             WHERE speed = multiverse.speed;
--         END IF;
--         ------------------------------------------------------------------------------------------------------------------------------------------------
--         ------------------------------------------------------------------------------------------------------------------------------------------------
--         ------------ If the season is over
--         IF now() > multiverse.date_season_end THEN
--             bool_simulate_games := TRUE;

--             -- Update multiverses table for starting next season
--             UPDATE multiverses SET
--                 season_number = season_number + 1,
--                 date_season_start = date_season_end,
--                 date_season_end = date_season_end + loc_interval_1_week * 14,        
--                 is_w11_generated = FALSE,
--                 is_w12_generated = FALSE,
--                 is_w13_generated = FALSE
--             WHERE speed = multiverse.speed;

--             -- Update leagues
--             UPDATE leagues SET
--                 season_number = season_number + 1
--                 WHERE multiverse_speed = multiverse.speed;

--             UPDATE clubs SET
--                 season_number = season_number + 1,
--                 id_league = id_league_next_season,
--                 id_league_next_season = NULL,
--                 pos_league = pos_league_next_season,
--                 pos_league_next_season = NULL,
--                 league_points = 0
--                 WHERE multiverse_speed = multiverse.speed;

        END IF;

    END LOOP;

    IF bool_simulate_games IS TRUE THEN
        PERFORM simulate_games();
    END IF;

END;
$function$
;
