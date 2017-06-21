# YTSR Status Tester

Proof of concept for using Elixir + Phoenix to hit the Google YouTube Content API
with distribution song ISRCs to determine if they were delivered to YouTube.

## To hit the API

* Get and store the Google API default credentials. Ask Sophie or Andrew for these creds.
  * Create a file, `default_google_creds.json` and paste in the credentials
  * Export an environemnt variable set equal to the path to this file

  ```
  $ export GOOGLE_APPLICATION_CREDENTIALS=/path/to/default/creds/file.json
  ```

* Run the console

```elixir
$ iex -S mix
```

* Paste in:

```elixir
{:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/youtubepartner")
token        = token.token
headers      = ["Authorization": "Bearer #{token}"]

#One ISRC
url = "https://www.googleapis.com/youtube/partner/v1/assetSearch?isrcs=TCACD1542277&type=sound_recording&ownershipRestriction=none"

#Many ISRCs
url = "https://www.googleapis.com/youtube/partner/v1/assetSearch?isrcs=TCACD1542277%2C%20TCACD1542278%2C%20TCACD1542280%2C%20TCACE1504357%2C%20TCACE1504359%2C%20TCACE1504360%2C%20TCACE1504362%2C%20TCACE1504366%2C%20TCACE1504370%2C%20TCACE1504371%2C%20TCACE1504373%2C%20TCACE1504374%2C%20TCACE1504376%2C%20TCACE1538738%2C%20TCACE1538739%2C%20TCACE1538740%2C%20TCACE1538741%2C%20TCACE1538742%2C%20TCACE1538743%2C%20TCACE1538746%2C%20TCACE1538747%2C%20TCACE1538750%2C%20TCACE1538761%2C%20TCACE1538762%2C%20US6YC1500003%2C%20US6YC1500004%2C%20US6YC1500005%2C%20US6YC1500006%2C%20US6YC1500007%2C%20US6YC1500008%2C%20US6YC1500009%2C%20US6YC1500010%2C%20US6YC1500011&ownershipRestriction=none&type=sound_recording"

{:ok, response} = HTTPoison.get(url, headers)
{:ok, body}     = Poison.decode(response.body)

=> %{"items" => [%{"id" => "A746127890905901", "isrc" => "TCACD1542277",
     "kind" => "youtubePartner#assetSnippet",
     "timeCreated" => "2015-02-06T18:35:01.000Z", "title" => "Damn Fool",
     "type" => "sound_recording"}], "kind" => "youtubePartner#assetSnippetList",
  "pageInfo" => %{"totalResults" => 1}}
```
