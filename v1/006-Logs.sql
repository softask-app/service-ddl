CREATE TABLE IF NOT EXISTS logs.task_log
(
  join_id  BIGINT      NOT NULL
    REFERENCES joins.user_to_task (join_id) ON DELETE CASCADE,
  started  TIMESTAMPTZ NOT NULL DEFAULT now(),
  finished TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS logs.step_log
(
  join_id  BIGINT      NOT NULL
    REFERENCES joins.user_to_task (join_id) ON DELETE CASCADE,
  step_id  BIGINT      NOT NULL
    REFERENCES tasks.step (step_id) ON DELETE CASCADE,

  started  TIMESTAMPTZ NOT NULL DEFAULT now(),

  finished TIMESTAMPTZ
);