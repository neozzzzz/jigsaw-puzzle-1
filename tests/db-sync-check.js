const fs = require('fs');
const path = require('path');
const assert = require('assert');

const html = fs.readFileSync(path.join(__dirname, '..', 'index.html'), 'utf8');

function expect(pattern, message) {
  assert.match(html, pattern, message);
}

expect(/select=client_user_id,name,created_at,progress/, 'DB load query should request progress data');
expect(/function buildUserPayload\(user\)[\s\S]*?progress:\s*user\.progress\s*\|\|\s*\{/, 'User payload builder should include progress for DB persistence');
expect(/async function syncUserToDb\(/, 'A DB sync function should exist for user updates');
expect(/await persistUserToDb\(user\)/, 'User creation should persist to DB');
expect(/queueUserSync\(user\)/, 'User progress mutations should sync to DB');
expect(/visibilitychange[\s\S]*refreshUsersFromDb/, 'App should refresh users from DB when returning to the tab');

console.log('db-sync-check: PASS');
