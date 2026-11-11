# Recipes

Snippets that worked in practice. Adapt names, paths and stacks; the shape is
what matters. Examples use Laravel + Docker for the backend and a React SPA in
the built-in browser, because that's where they were first used.

## Contents

- Run a script inside a container
- Seed script skeleton (local-only, prefixed, deterministic)
- Check effective config without reading `.env`
- Confirm a mail reached Mailpit
- Simulate a signed webhook
- Permission check as a restricted user (API)
- Browser: stub `window.confirm`
- Browser: capture a download
- Browser: keyboard drag-and-drop
- Browser: find untranslated strings in an RTL/other-language UI
- Compare UI numbers with the DB

## Run a script inside a container

Keep scripts in the scratchpad, copy them in, run with the app's REPL:

```bash
docker cp <scratchpad>/seed.php <app_container>:/tmp/seed.php
docker exec <app_container> php artisan tinker /tmp/seed.php
docker exec -e CAMPAIGN_ID=45 <app_container> php artisan tinker /tmp/events.php   # pass args via env
```

One-liners: `php artisan tinker --execute='...'`.

## Seed script skeleton

```php
<?php
use Illuminate\Support\Facades\DB;

if (! app()->environment('local')) {
    throw new RuntimeException('Refusing to seed outside APP_ENV=local.');
}

mt_srand(42);                         // same data on every rerun
$db = DB::connection('admin_db');

// Replace only our own rows. Check first that nothing hand-made matches.
$db->table('campaigns')->where('name', 'like', '[Demo]%')->delete();

foreach (range(1, 20) as $i) {
    $db->table('campaigns')->insert([
        'name' => sprintf('[Demo] Campaign %02d', $i),
        // spread over months, every status, realistic ratios between counters
    ]);
}
echo "Seeded.\n";
```

Notes:
- `(array) array_rand($items, $n)`: with `$n = 1` it returns a scalar.
- Fill every table the screen reads (daily stats, per-country, per-hour
  engagement…), not just the parent row.

## Check effective config without reading `.env`

```bash
docker exec <app> php artisan tinker --execute='echo json_encode([
  app()->environment(), config("mail.default"), config("mail.mailers.smtp.host"),
  config("<feature>.mailer"), config("<feature>.quota_driver")
]), PHP_EOL;'
```

Print only non-secret values. An `env()` call returns `""` (not the default)
when the key exists but is empty — a common cause of "relative URL" or
"missing host" bugs.

## Confirm a mail reached Mailpit

From inside the Mailpit container (its port may not be published to the host):

```bash
docker exec <mailpit> wget -qO- "http://localhost:8025/api/v1/search?query=subject:%22<words>%22" \
  | grep -oE '"Subject":"[^"]*"|"Address":"[^"]*"|"messages_count":[0-9]+'
docker exec <mailpit> wget -qO- "http://localhost:8025/api/v1/message/<ID>"   # full HTML
```

To prove *which* version was sent (e.g. builder vs code), compare large static
chunks of the stored HTML with the received HTML.

## Simulate a signed webhook

If the endpoint verifies real provider signatures (SNS, Stripe…), don't try
to fake the HTTP call. Dispatch the job the controller queues, with an event
shaped like the provider's:

```php
ProcessSesEventJob::dispatch([
  'eventType' => 'Open',
  'mail' => ['messageId' => 'fake-1', 'destination' => [$email],
             'tags' => ['campaign_id' => [(string) $id]]],
  'open' => ['timestamp' => now()->toIso8601ZuluString(), 'ipAddress' => '8.8.8.8'],
]);
```

Report that the signature check itself was not exercised.

## Permission check as a restricted user (API)

Create a role with only the permissions under test, a user with a random
password nobody sees, issue a token through the app's own token service, and
call the routes through the HTTP kernel:

```php
$user = User::firstOrCreate(['email' => 'demo-viewer@example.test'], [
  'password' => Hash::make(Str::random(40)), 'is_staff' => true, /* … */ ]);
$user->syncRoles(['demo_viewer']);
$token = app(TokenService::class)->issueAccessToken($user, ['pwd', 'mfa']);
$req = Request::create('/api/<route>', 'POST', [], [], [], [
  'HTTP_AUTHORIZATION' => "Bearer $token", 'HTTP_ACCEPT' => 'application/json']);
echo app(Illuminate\Contracts\Http\Kernel::class)->handle($req)->getStatusCode();
```

Expect 200 on what the role allows and 403 on the rest.

## Browser: stub `window.confirm`

```js
window.__origConfirm = window.confirm;
window.confirm = (m) => { window.__lastConfirm = m; return true; };
// … click …
const m = window.__lastConfirm; window.confirm = window.__origConfirm; m
```

## Browser: capture a download

```js
window.__dl = [];
window.__origClick = HTMLAnchorElement.prototype.click;
HTMLAnchorElement.prototype.click = function () {
  if (this.download) {
    window.__dl.push(fetch(this.href).then(r => r.text())
      .then(t => ({ name: this.download, size: t.length, head: t.slice(0, 15) })));
    return;
  }
  return window.__origClick.call(this);
};
// … click Export …
const r = await Promise.all(window.__dl);
HTMLAnchorElement.prototype.click = window.__origClick; r
```

## Browser: keyboard drag-and-drop

Synthetic pointer drags are often ignored. With dnd-kit's KeyboardSensor:
focus the draggable (`el.focus()`), press `space`, arrow keys to move,
`space` to drop. Verify by counting blocks/handles before and after, then undo.

## Browser: untranslated strings

```js
const t = document.querySelector('main').innerText;
({ dir: document.documentElement.dir, lang: document.documentElement.lang,
   latin: [...new Set(t.split('\n').map(s => s.trim())
     .filter(s => /[A-Za-z]{4,}/.test(s) && !/\[Demo\]|@|https?:/.test(s)))] })
```

What remains is usually data (names stored in the DB), not missing keys.

## Compare UI numbers with the DB

Read the page text (or the API response body from the network log), run the
same aggregate in the DB with the same filters, and compare value by value.
Do it for the unfiltered totals and at least one combination of filters.
