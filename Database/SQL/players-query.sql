SELECT
  name,
  energy,
  selfreflection,
  competency,
  initiative,
  creativity,
  cooperation,
  motivation,
  to_char(created_at, 'YYYY. MM. DD. HH24:MI') AS created_at,
  (energy + selfreflection + competency + initiative + creativity + cooperation + motivation) AS score_sum,
  to_char(completed_at - created_at, 'HH24:MI:SS') AS completion_time
FROM players
ORDER BY score_sum DESC;
