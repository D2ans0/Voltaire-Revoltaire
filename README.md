# Voltaire

**Voltaire** is a discord bot that allows you to send messages anonymously. It supports sending messages to server channels as well as sending DMs to members of the server it has been added to. Voltaire has several admin settings (which can be viewed with `/volt-admin help`) to allow admins to best fit the bot to their use case. When Voltaire is added to your server, type `/volt-help` to get a list of commands.

[Add Voltaire to Your Server](https://discordapp.com/oauth2/authorize?client_id=425833927517798420&permissions=2147998784&scope=bot%20applications.commands)

[Official Voltaire Discord](https://discord.gg/xyzMyJH)

## Built With

* [Discord.net](https://github.com/RogueException/Discord.Net) - Bot Framework

## Deploy via script
Only requires docker and docker-compose

1) Download deploy.sh
```bash
wget https://raw.githubusercontent.com/D2ans0/Voltaire-Revoltaire/master/deploy.sh
```
or
```
curl https://raw.githubusercontent.com/D2ans0/Voltaire-Revoltaire/master/deploy.sh -O deploy.sh
```
2) Change the placeholder value in APP_TOKEN and DB_PASSWORD
3) Make the file executable
```bash
chmod 0700 deploy.sh
```
4) Run the script
```
sudo ./deploy.sh
```
5) Enjoy

## Contributing

Pull requests are welcome!

#### Development setup

To get running locally:
1. Create a [discord bot user](https://discordapp.com/developers/applications/)
2. Set up a sql database
3. Create a appsettings.json file within the project's "Voltaire" directory (see example below)
4. Run migrations
5. (OPT) Build using 'docker-compose build --build-arg BRANCH=$(git branch --show-current)'
6. Be excellent to eachother

```
// appsettings.json
{
  "discordAppToken": "F5OCongcjYOMXmEgrTmGDFy1Te5CUZy5ignm2DLoUUwJ1QsbfqEeOpyWBhe",
  // the emoji the bot will use when a message is sent
  "sent_emoji": "<:message_sent:491776018970050570>",
  // a 256 bit key used to generate response codes and usernames
  "encryptionKey": "PSVJQRk9QTEpNVU1DWUZCRVFGV1VVT0ZOV1RRU1NaWQ=",
  "ConnectionStrings": {
    "sql": "Server=(localdb)\\mssqllocaldb;Database=Voltaire;Trusted_Connection=True;"
  }
}
```



## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
