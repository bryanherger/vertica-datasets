-- DDL for ADSB data. Table name "dump1090new" refers to collection method: ADS-B traffic broadcasts on 1090MHz and is captured using utility "dump1090"
CREATE TABLE public.dump1090new
(
    message_type varchar(80),
    transmission_type int,
    session_id varchar(80),
    aircraft_id varchar(80),
    hex_ident varchar(80),
    flight_id varchar(80),
    generated timestamp NOT NULL,
    logged timestamp,
    callsign varchar(80),
    altitude int,
    ground_speed int,
    track int,
    lat float,
    lon float,
    vertical_rate int,
    squawk varchar(80),
    alert boolean,
    emergency boolean,
    spi boolean,
    is_on_ground boolean,
    date_generated date NOT NULL
)
PARTITION BY (date(dump1090new.generated));

-- fix this to point to the actual location of the four bzip data files.
COPY dump1090new FROM '/path/to/adsb/datafiles/*.bz2' BZIP;
