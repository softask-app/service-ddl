/*--------------------------------------------------------*\
| App Users                                                |
\*--------------------------------------------------------*/
CREATE TABLE IF NOT EXISTS users.user
(
  -- Sequential user id
  user_id      BIGSERIAL PRIMARY KEY,

  -- User display name
  display_name VARCHAR(64) NOT NULL
    CONSTRAINT user_display_name_min_len CHECK (length(display_name) >= 3),

  -- Twofish encrypted user email
  email        BYTEA       NOT NULL UNIQUE,

  -- Sha256 hashed user password
  password     BYTEA       NOT NULL,

  -- user creation date
  created      TIMESTAMPTZ NOT NULL DEFAULT now()
);

/*--------------------------------------------------------*\
| User Devices                                             |
|                                                          |
| Records the mobile devices from which a user has used    |
| the app along with whether or not that device is trusted |
| and may skip the user auth process.                      |
|                                                          |
| When set to "trust", a device will be issued a 64 digit  |
| token value.  That value in combination with the user    |
| ID and the device ID will be used to validate that the   |
| auto-auth request is allowed                             |
\*--------------------------------------------------------*/
CREATE TABLE IF NOT EXISTS users.device
(
  -- ID of the user the device belongs to
  user_id   BIGINT      NOT NULL
    REFERENCES users.user (user_id) ON DELETE CASCADE,

  -- Unique ID for an instance of the mobile app.
  device_id CHAR(32) NOT NULL UNIQUE,

  -- Auto auth token.  Generated and sent to the device to
  -- enable that device to skip password authentication.
  auto_auth CHAR(64)
);
