-- DROP FUNCTION public.players_create_player(int8, int8, int8, _float8, float8, int8, text);

CREATE OR REPLACE FUNCTION public.players_create_player(
    inp_id_multiverse bigint,
    inp_id_club bigint,
    inp_id_country bigint,
    inp_age double precision,
    inp_shirt_number bigint DEFAULT NULL::bigint,
    inp_notes text DEFAULT NULL::text,
    inp_stats double precision[] DEFAULT NULL)
 RETURNS bigint
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
    loc_new_player_id bigint; -- Variable to store the inserted player's ID
    loc_top_two_stats double precision[];
    loc_training_coef double precision[];
    loc_tmp double precision; -- Temporary variable for calculations
BEGIN

    ------ Check if the player creation is from scouts
    IF inp_notes = 'Young Scouted' THEN
        IF (SELECT scouts_weight FROM clubs WHERE id = inp_id_club) < 7000 THEN
            RAISE EXCEPTION 'The club does not have enough scout network strength to scout a new player';
        ELSE
            UPDATE clubs SET scouts_weight = scouts_weight - 7000 WHERE id = inp_id_club;
        END IF;
    END IF;

    ------ If the inp_stats array is NULL, generate random stats based on the player's age and inp_notes
    IF inp_stats IS NULL THEN
        loc_tmp := 3.0 * (inp_age - 15); -- Age: (15 ==> 35) ==> Value: [0 ==> 60]
        ---- Goalkeepers
        IF inp_shirt_number IN (1, 12) THEN
            inp_stats := ARRAY[
                loc_tmp + 10 * (1 + random()), -- Keeper: BaseValue(age) + Random(10 ==> 20)
                loc_tmp + 10 * random(), -- Defense: BaseValue(age) + Random(0 ==> 5)
                loc_tmp + 10 * random(), -- Passes: BaseValue(age) + Random(0 ==> 5)
                loc_tmp * random(), -- Playmaking: Random(0 ==> BaseValue(age))
                loc_tmp * random(), -- Winger: Random(0 ==> BaseValue(age))
                loc_tmp * random(), -- Scoring: Random(0 ==> BaseValue(age))
                loc_tmp + 10 * random()]; -- Freekick
        ---- Back Wingers
        ELSIF inp_shirt_number IN (2, 3, 13) THEN
            inp_stats := ARRAY[
                0, -- Keeper
                loc_tmp + 10 * (1 + random()), -- Defense
                loc_tmp + 10 * random(), -- Passes
                loc_tmp + 10 * random(), -- Playmaking
                loc_tmp + 10 * random(), -- Winger
                0, -- Scoring
                0]; -- Freekick
        ---- Central Backs
        ELSIF inp_shirt_number IN (4, 5, 14) THEN
            inp_stats := ARRAY[
                0, -- Keeper
                loc_tmp + 10 * (1 + random()), -- Defense
                loc_tmp + 10 * random(), -- Passes
                loc_tmp * 10 * random(), -- Playmaking
                0, -- Winger
                0, -- Scoring
                0]; -- Freekick
        ---- Midfielders
        ELSIF inp_shirt_number IN (6, 10, 15) THEN
            inp_stats := ARRAY[
                0, -- Keeper
                loc_tmp + 10 * random(), -- Defense
                loc_tmp + 10 * (1 + random()), -- Passes
                loc_tmp + 10 * (1 + random()), -- Playmaking
                0, -- Winger
                0, -- Scoring
                0]; -- Freekick
        ---- Wingers
        ELSIF inp_shirt_number IN (7, 8, 16) THEN
            inp_stats := ARRAY[
                0, -- Keeper
                loc_tmp + 10 * random(), -- Defense
                loc_tmp + 10 * random(), -- Passes
                loc_tmp + 10 * random(), -- Playmaking
                loc_tmp + 10 * (1 + random()), -- Winger
                loc_tmp + 10 * random(), -- Scoring
                0]; -- Freekick
        ---- Strikers
        ELSIF inp_shirt_number IN (9, 11, 17) THEN
            inp_stats := ARRAY[
                0, -- Keeper
                0, -- Defense
                loc_tmp + 10 * random(), -- Passes
                loc_tmp + 10 * random(), -- Playmaking
                loc_tmp + 10 * random(), -- Winger
                loc_tmp + 10 * (1 + random()), -- Scoring
                0]; -- Freekick
        ELSE
            RAISE EXCEPTION 'Invalid shirt_number when creating a player with no stats given (must be between 1 and 17)';
        END IF;
    END IF;

    -- Find the two highest values in inp_stats
    loc_top_two_stats := (
        SELECT ARRAY(
            SELECT val
            FROM unnest(inp_stats) AS val
            ORDER BY val DESC
            LIMIT 2
        )
    );

    -- Create the training_coef array with 1 for the two highest stats and 0 for the others
    loc_training_coef := ARRAY[
        CASE WHEN inp_stats[1] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,
        CASE WHEN inp_stats[2] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,
        CASE WHEN inp_stats[3] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,
        CASE WHEN inp_stats[4] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,
        CASE WHEN inp_stats[5] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,
        CASE WHEN inp_stats[6] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,
        CASE WHEN inp_stats[7] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END
    ];

    ------------------------------------------------------------------------
    ------------------------------------------------------------------------
    ------ Create player
    INSERT INTO players (
        id_multiverse, id_club, id_country,
        date_birth, experience,
        keeper, defense, passes, playmaking, winger, scoring, freekick,
        training_coef,
        shirt_number, notes, notes_small
    ) VALUES (
        inp_id_multiverse, inp_id_club, inp_id_country,
        players_calculate_date_birth(inp_id_multiverse := inp_id_multiverse, inp_age := inp_age), 3.0 * (inp_age - 15.0),
        inp_stats[1], inp_stats[2], inp_stats[3], inp_stats[4], inp_stats[5], inp_stats[6], inp_stats[7],
        loc_training_coef,
        inp_shirt_number,
        -- Notes (if not given use the shirt number to determine the player's position)
        CASE
            WHEN inp_notes IS NOT NULL THEN inp_notes
            WHEN inp_shirt_number IN (1, 12) THEN 'GoalKeeper'
            WHEN inp_shirt_number IN (2, 3, 13) THEN 'Back Winger'
            WHEN inp_shirt_number IN (4, 5, 14) THEN 'Central Back'
            WHEN inp_shirt_number IN (6, 10, 15) THEN 'Midfielder'
            WHEN inp_shirt_number IN (7, 8, 16) THEN 'Winger'
            WHEN inp_shirt_number IN (9, 11, 17) THEN 'Striker'
            ELSE NULL
        END,
        -- Small notes
        CASE
            WHEN inp_notes IS NOT NULL THEN
            CASE
                WHEN inp_notes = 'Experienced GoalKeeper' THEN 'GK1'
                WHEN inp_notes = 'Young GoalKeeper' THEN 'GK2'
                WHEN inp_notes = 'Experienced Back Winger' THEN 'BW1'
                WHEN inp_notes = 'Intermediate Age Back Winger' THEN 'BW2'
                WHEN inp_notes = 'Young Back Winger' THEN 'BW3'
                WHEN inp_notes = 'Experienced Central Back' THEN 'CB1'
                WHEN inp_notes = 'Intermediate Age Central Back' THEN 'CB2'
                WHEN inp_notes = 'Young Central Back' THEN 'CB3'
                WHEN inp_notes = 'Experienced Midfielder' THEN 'MF1'
                WHEN inp_notes = 'Intermediate Age Midfielder' THEN 'MF2'
                WHEN inp_notes = 'Young Midfielder' THEN 'MF3'
                WHEN inp_notes = 'Experienced Winger' THEN 'WG1'
                WHEN inp_notes = 'Intermediate Age Winger' THEN 'WG2'
                WHEN inp_notes = 'Young Winger' THEN 'WG3'
                WHEN inp_notes = 'Experienced Striker' THEN 'ST1'
                WHEN inp_notes = 'Intermediate Age Striker' THEN 'ST2'
                WHEN inp_notes = 'Young Striker' THEN 'ST3'
                WHEN inp_notes = 'Old Experienced player' THEN 'OLDXP'
                WHEN inp_notes = 'Youngster 1' THEN 'YOUNG1'
                WHEN inp_notes = 'Youngster 2' THEN 'YOUNG2'
                WHEN inp_notes = 'Young Scouted' THEN 'SCOUT'
                ELSE 'None ???' END
            WHEN inp_shirt_number IS NOT NULL THEN
            CASE
                WHEN inp_shirt_number IN (1, 12) THEN 'GK'
                WHEN inp_shirt_number IN (2, 3, 13) THEN 'BW'
                WHEN inp_shirt_number IN (4, 5, 14) THEN 'CB'
                WHEN inp_shirt_number IN (6, 10, 15) THEN 'MF'
                WHEN inp_shirt_number IN (7, 8, 16) THEN 'WG'
                WHEN inp_shirt_number IN (9, 11, 17) THEN 'ST'
                ELSE 'None ??' END
            ELSE 'None ?'
        END)
    RETURNING id INTO loc_new_player_id;

    ------ Log player history
    INSERT INTO players_history (id_player, id_club, description)
    VALUES (loc_new_player_id, inp_id_club,
    'Joined ' || string_parser(inp_id_club, 'idClub') ||
    CASE
        WHEN inp_notes = 'Young Scouted' THEN ' as a young scouted player'
        WHEN inp_notes = 'Old Experienced player' THEN ' as an old experienced player'
        ELSE ' as a free player'
    END);

    ------ Send a message to the club for scouted players
    IF inp_notes = 'Young Scouted' THEN
        INSERT INTO messages_mail (id_club_to, sender_role, title, message)
            VALUES
                (inp_id_club, 'Scout',
                'New Scouted Player: ' || string_parser(loc_new_player_id, 'idPlayer'),
                string_parser(loc_new_player_id, 'idPlayer') || ' joined the squad, check him out, i''ve been keeping an eye on him for a while and given some good training he might be a future star !');
    END IF;
    
    ------ Return the new player's ID
    RETURN loc_new_player_id;
END;
$function$
;
