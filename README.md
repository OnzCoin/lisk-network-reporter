Onz Network Reporter
============
This is the backend service which runs along with Onz and tracks the network status, fetches information through api and connects through WebSockets to [onz-network-stats](https://github.com/OnzCoin/onz-network-stats) to feed information.

## Prerequisite
* onz up and running
* node
* npm

## Installation
<pre>git clone https://github.com/OnzCoin/onz-network-reporter/ && cd onz-network-reporter && bash build.sh</pre>

## Configuration
<pre>nano app.json</pre>
And modify

<pre>
[
  {
    "name"              : "onz-network-reporter",
    "script"            : "app.js",
    "log_date_format"   : "YYYY-MM-DD HH:mm Z",
    "merge_logs"        : false,
    "watch"             : false,
    "max_restarts"      : 10,
    "exec_interpreter"  : "node",
    "exec_mode"         : "fork_mode",
    "env":
    {
      "NODE_ENV"        : "production",
      "RPC_HOST"        : "localhost",
      "RPC_PORT"        : "11000", <- 11000 for mainnet, 10998 testnet
      "LISTENING_PORT"  : "11000", <- 11000 for mainnet, 10998 testnet
      "INSTANCE_NAME"   : "", <- add your onz address here or a custom name if you do voluntary work
      "CONTACT_DETAILS" : "", <- contact details, email or nick on OnzCoin discord to contact in case any failure
      "NETWORK_MODE"    : "main",
      "WS_SERVER"       : "ws://stats.onzcoin.com:3000",
      "WS_SECRET"       : "Go to OnzCoin discord and ask around",
      "VERBOSITY"       : 0
    }
  }
]
</pre>

## Run
Starting
<pre>
pm2 start app.json --watch
</pre>

Checking logs
<pre>
pm2 logs onz-network-reporter
</pre>

Stopping
<pre>
pm2 stop onz-network-reporter
</pre>

## Generating a startup script

Before generating a startup script, make sure your Onz node has also a startup mechanism on reboot (with crontab for example).

Now, let pm2 detect available init system, generate configuration and enable startup system:

<pre>
pm2 startup
</pre>

Now follow the instruction. For example on ubuntu 14.04 LTE (with systemd as default init system) :

<pre>
[PM2] Init System found: systemd
[PM2] To setup the Startup Script, copy/paste the following command:
sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u [user] --hp /home/[user]
</pre>

Copy-paste the last command. Now, *if you didn't before*, run the application with ```pm2 start app.json --watch``` and then:
<pre>
pm2 save
</pre>

This last command will save the process list and execute them on reboot.

If you want to remove the init script, execute:
<pre>
pm2 unstartup [initsystem]
</pre>

For more information:  [Official PM2 Startup Script page](http://pm2.keymetrics.io/docs/usage/startup/#generating-a-startup-script)

## Docker
You can run this container via docker by executing:

```
docker run -d -e RPC_HOST='your onz node ip or hostname' -e INSTANCE_NAME='your onz address' -e WS_SECRET="the onzstats secret" -e CONTACT_DETAILS="your contact details" -v /etc/localtime:/etc/localtime:ro docker-onz-network-reporter:latest
```

Confurable ENV variables:

NODE_ENV
RPC_HOST
RPC_PORT
LISTENING_PORT
INSTANCE_NAME
CONTACT_DETAILS
NETWORK_MODE
WS_SECRET
IS_FORGING
VERBOSITY


## Credits
1. To [cuberdo](https://github.com/cubedro/) and his [eth-net-intelligence-api](https://github.com/cubedro/eth-net-intelligence-api). It's foundation used for onz-network-reporter.
2. [5an1ty](https://github.com/5an1ty/) for creating support for Docker.
3. [hirishh](https://github.com/hirishh) for pm2 auto startup guide.
4. [karek314](https://github.com/karek314) for providing all those related information.
