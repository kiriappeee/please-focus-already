# Please Focus Already

A simple script to automatically block the usual suspects of distracting websites from 8 am to 7 pm monday to friday

To use this, clone the repo, navigate to the directory, and run:

`./setup.sh`

Since this script requires the machine password it's only right that I take the time to explain what happens

1. A directory is created at the path `/Users/Shared/.scripts/pleasefocusalready`
2. Inside that directory another directory called hosts is created
3. The script `copyhosts.sh` is copied from the scripts folder in the repo to `/Users/Shared/.scripts/pleasefocusalready`
4. Two new hosts files, `hosts.default.custom`, and `hosts.peak.custom` are created in the hosts directory in the repo
5. All the files in the hosts directory in the repo are copied over to `/Users/Shared/.scripts/pleasefocusalready/hosts`
6. The schedules to be used with `launchctl` are copied from the schedules folder in the repo to `~/Library/LaunchAgents`. These schedule files simply call the `copyhosts.sh` script at 8 in the morning and 7 in the night (the copying uses sudo)
7. The plist files are loaded into launchctl (also uses sudo)
8. The script ends by asking if you want to activate the no distraction mode immediately

## Activating no distractions

The script `copyhosts.sh` is run at the start and end of the times that we would not want to be distracted. i.e 8 am and 7 pm. The script runs as follows. It takes in a variable that tells it if it's peak time or offpeak time. If the value is "peak", the script will concatenate all the details of `hosts.default`, `hosts.default.custom`, `hosts.peak`, `hosts.peak.custom` in that order and copy the result to /etc/hosts

If it receives the value "offpeak" it will concatenate **only** `hosts.default`, and `hosts.default.custom` in that order and copy the result to /etc/hosts

Just in case something screws up, the first step in both cases is to copy the existing `/etc/hosts` file to `/Users/Shared/.scripts/pleasefocusalready/hosts/hosts.bak`.

## Customizing the block/allow list

The hosts.peak contains some of the most common and most distracting list of sites. This will not change. If you want to override this, you should edit you `/etc/hosts` directly

The `hosts.default` contains the most basic stuff that any `/etc/hosts` file would have. 

But there are two more files created. `hosts.default.custom` and `hosts.peak.custom`.

If you want to add more sites to the distracting list (I for example have added several local news sites and some blogs like marco.org) you can add these sites to `hosts.peak.custom` in the following format

```
127.0.0.1     distractingsite.com
127.0.0.1     www.distractingsite.com
```

No strict formatting rules here. Just making sure I'm being explicit in the docs :)

The `hosts.default.custom` is super important if you have any hosts entries you already include in your `/etc/hosts` file. You can add a list of them into this file and this will ensure this list is always included in peak or offpeak (no distractions/distractions allowed) time. I for example have several entries such as `127.0.0.1   local.buffer.com` that must be included at all times

After you edit the custom hosts files, run `./setup.sh` again to reload the list

## What's coming next

Custom times. That I think will be the first thing anyone might want. I think 8 am to 7 pm covers a lot of cases. If you do want to change times, simply edit the schedules in the schedules directory and run `./setup.sh` to reload it. That said, this will get overwritten the next time you choose to pull the latest update :) . Super sorry about the inconvenience here and I'll try and have at the very least, a solution that lets you add your custom schedule files in and make the script pick those up if they exist :)
