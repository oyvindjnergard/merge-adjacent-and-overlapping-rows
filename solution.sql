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
    ),

    generate_merge_key as (
        select
            *,
            case
                when
                    start_position > coalesce(
                        lag(end_position) over (
                            partition by segment_id, road_sequence_id, direction
                            order by start_position
                        ),
                        -1
                    )
                then 1
                else 0
            end as merge_key
        from base
    ),

    generate_merge_group as (
        select
            *,
            sum(merge_key) over (
                partition by segment_id, road_sequence_id, direction
                order by start_position
            ) as merge_group
        from generate_merge_key
    ),

    merge_rows as (
        select
            segment_id,
            road_sequence_id,
            min(start_position) as start_position,
            max(end_position) as end_position,
            direction
        from generate_merge_group
        group by segment_id, road_sequence_id, direction, merge_group
    )

select *
from merge_rows
order by segment_id,direction, start_position
