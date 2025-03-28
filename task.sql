with
    base as (
        select
            'a' as segment_id,
            1 as road_sequence_id,
            0.0 as start_position,
            0.1 as end_position,
            'with' as direction
        union
        select
            'a' as segment_id,
            1 as road_sequence_id,
            0.1 as start_position,
            0.15 as end_position,
            'with' as direction
        union
        select
            'a' as segment_id,
            1 as road_sequence_id,
            0.15 as start_position,
            0.2 as end_position,
            'with' as direction
        union
        select
            'a' as segment_id,
            1 as road_sequence_id,
            0.25 as start_position,
            0.5 as end_position,
            'with' as direction
        union
        select
            'a' as segment_id,
            1 as road_sequence_id,
            0.3 as start_position,
            0.4 as end_position,
            'against' as direction
        union
        select
            'a' as segment_id,
            1 as road_sequence_id,
            0.45 as start_position,
            0.7 as end_position,
            'with' as direction
        union
        select
            'a' as segment_id,
            1 as road_sequence_id,
            0.8 as start_position,
            1.00 as end_position,
            'with' as direction
        union
        select
            'b' as segment_id,
            2 as road_sequence_id,
            0.0 as start_position,
            1.00 as end_position,
            'with' as direction            
    )

select *
from base
order by segment_id, direction, start_position
