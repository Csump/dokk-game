select 
	decisions.id as id,
	players.name as name,
	to_char(players.created_at, 'YYYY. MM. DD. HH24:MI') AS created,
	to_char(players.completed_at, 'YYYY. MM. DD. HH24:MI') AS completed,
	to_char(decisions.timestamp, 'YYYY. MM. DD. HH24:MI') AS timestamp,
	choices.choice_text as choice
from decisions
inner join players on players.id=decisions.player_id
inner join choices on choices.id=decisions.choice_id
order by decisions.timestamp desc;