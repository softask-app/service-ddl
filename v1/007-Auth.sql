SET SEARCH_PATH = "auth";

CREATE TABLE IF NOT EXISTS session
(
  user_id BIGINT      NOT NULL
    REFERENCES users."user" (user_id) ON DELETE CASCADE,

  api_key BYTEA       NOT NULL,

  started TIMESTAMPTZ NOT NULL DEFAULT now(),

  active  TIMESTAMPTZ NOT NULL DEFAULT now()
);

/*--------------------------------------------------------*\
| User Password Reset Requests                             |
|                                                          |
| Holds time-sensitive entries for user password reset     |
| requests.                                                |
\*--------------------------------------------------------*/
CREATE TABLE IF NOT EXISTS pw_resets
(
  -- Unique token assigned to each user password reset
  -- request.  Will be used in conjunction with the user's
  -- email address to help ensure baddies won't take over
  -- another user's password reset.
  token   CHAR(64)    NOT NULL UNIQUE,

  -- ID of the user that requested a password reset email.
  user_id BIGINT      NOT NULL
    REFERENCES users.user (user_id) ON DELETE CASCADE,

  -- Timestamp the request was created.
  created TIMESTAMPTZ NOT NULL DEFAULT now()
);
