-- DROP FUNCTION public.leagues_create_league(int8, int8, continents, int8, int8, int8, int8);

CREATE OR REPLACE FUNCTION public.leagues_create_league(
    inp_id_multiverse bigint,
    inp_season_number bigint,
    inp_continent continents,
    inp_level bigint,
    inp_number bigint,
    inp_id_upper_league bigint,
    inp_id_league_to_create bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    upper_league RECORD; -- Record for the upper league
    loc_id_league bigint; -- id of the created league
BEGIN

    ------ Insert a new row in the leagues table
    INSERT INTO leagues (id, id_multiverse, season_number, continent, level, number, name, id_upper_league)
    VALUES (COALESCE(inp_id_league_to_create, nextval('leagues_id_seq')), inp_id_multiverse, inp_season_number, inp_continent, inp_level, inp_number, 
        ---- Name of the league
        CASE
            WHEN inp_continent = 'Africa' THEN 'AF'
            WHEN inp_continent = 'North America' THEN 'NA'
            WHEN inp_continent = 'South America' THEN 'SA'
            WHEN inp_continent = 'Asia' THEN 'AS'
            WHEN inp_continent = 'Europe' THEN 'EU'
            WHEN inp_continent = 'Oceania' THEN 'OC'
            ELSE inp_continent || '???'
        END || inp_level || CASE WHEN inp_level = 1 THEN '' ELSE '(' || inp_number || ')' END,
        inp_id_upper_league)
    RETURNING id INTO loc_id_league;

    -- Create the new clubs for this new league
    FOR I IN 1..6 LOOP
        PERFORM clubs_create_club( -- Function to create new club
            inp_id_multiverse := inp_id_multiverse, -- Id of the multiverse
            inp_id_league := loc_id_league, -- Id of the league
            inp_continent := inp_continent, -- Continent of the club
            inp_number := I); -- Number creation
    END LOOP;

    -- Update the multiverse cash printed
    UPDATE multiverses SET
        cash_printed = cash_printed + (SELECT cash_last_season FROM leagues WHERE id = loc_id_league)
        WHERE id = inp_id_multiverse;

    -- Return the id of the newly created league
    RETURN loc_id_league;
END;
$function$
;
