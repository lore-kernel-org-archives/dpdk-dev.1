Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9884C3ABBB
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 16:13:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C176D4025D;
	Mon,  5 May 2025 18:13:14 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 43D7E4003C
 for <dev@dpdk.org>; Mon,  5 May 2025 18:13:13 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b1fcb97d209so1202249a12.1
 for <dev@dpdk.org>; Mon, 05 May 2025 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1746461592; x=1747066392; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0ee7OrYF6Q21sbYiM4LTSrtdXHuNolNL4RLGShjOm+g=;
 b=cguPcoouZz0Mv25kJbbDvnjKbPZYmJ9S5KVlASC5Z6DDAzoo492bPDFxa44QvGlY9/
 kE8OORfgVXFrMO31JaYMlXB9OmjJ/pwoTbfUZn1uE092ai2TUjuj+XIZ3Hs/JAiZGiiA
 Emr/8YCcnLmsxeCUlo9HXJ74ZfAWxHIt0TlFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746461592; x=1747066392;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ee7OrYF6Q21sbYiM4LTSrtdXHuNolNL4RLGShjOm+g=;
 b=TmqKYufNCIN9T9E9bqMV8aSZPtu3OP+OzlYGHYUNx2ZrcUJWtALJmxZrBxhPj+ve+R
 i4qGk/H+5ZsRkOlI0qB1fbWD00dFW6A6l8QfFvmdsehlwX4DH0qmuvpTJ4S9aiX2d5U+
 e62bDBnDBnDiw+fg6Rja2HAlLLE/4ub/X9MWm3POMjPCF4nREuE1nCXUSJykDpO1/F50
 b/Bhuv04eUu6hURwQP6PRQcYjTNxw3Fg0sV0wvhwt75MUhuXH4KzVZ/oWpuxL0fmiGzf
 ixKbDBKFK91lGLzGVThmep/+OQA/SOkbHD+RjisRfnUw1blhbntPc7KJvdSbdSrZfTtO
 lI5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGTZQmNxpvN184OARs5KotclJozqosP5ivQ4LFcMgF4i03ZCb8/4OBHCYoWkqyUnagXhY=@dpdk.org
X-Gm-Message-State: AOJu0YyUwinIeokUM7dyZMB69xhYi0EFs2iAR0AnfGDy6A8XqT3gxgaR
 k5C1odMkd6OUrRwA/qjoBK4h7zHsFSMxbHH0GnOh/5iku5NtxPpE+C+J9lypykIJmIKxJab/7Px
 XOfSm+MEWs/akqGqdAsflqGD4P98rBLCahrJGmw==
X-Gm-Gg: ASbGncsv8L6WluyDYv7OmX9FfB1/oa+c3LLxy7Mwp59TjaAza5OxmVIOiyTachAiW/a
 rUCxXe7ZpF7hI6wkXcUTyQR0zVBhpTdH8OtUZf/9CBYegPC/6Uqe5wI1QEka9kIZd1FxuhMS9aV
 TsS4iK8R7yek8QHGgj3CRpz7Z3vkFPkpREv6KC
X-Google-Smtp-Source: AGHT+IFv9yEdGG8MWsestdL+lKcNBP6nfw4xh5mqx/PwhlQ38sWdk8I8XCPSZgUjtaUOHIGjkXr0oV1qJrdcYJxfJEA=
X-Received: by 2002:a17:90b:2b4b:b0:2fb:fe21:4841 with SMTP id
 98e67ed59e1d1-30a7bad8dcamr103139a91.8.1746461592068; Mon, 05 May 2025
 09:13:12 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 5 May 2025 12:08:37 -0400
X-Gm-Features: ATxdqUHpZWeW9Ns1xcOxj1r4OGmUvfmYmOxsahsqkuI6RJS0mNSMRUkBzd9RpQw
Message-ID: <CAJvnSUDfGsKk0c7Mk9jsRMxh4wO6M32quitrnkDPWHHiTZEiCA@mail.gmail.com>
Subject: Polling for patchseries in DPDK - the /series/ and /events/ endpoints
To: Aaron Conole <aconole@redhat.com>
Cc: ci@dpdk.org, dev <dev@dpdk.org>, Ali Alnubani <alialnu@nvidia.com>, 
 "Brandes, Shai" <shaibran@amazon.com>, zhoumin <zhoumin@loongson.cn>, 
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>
Content-Type: multipart/alternative; boundary="000000000000cf3e54063465c6ad"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--000000000000cf3e54063465c6ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There was some discussion at last week's CI meeting about usage of the
Patchwork /events/ endpoint for polling for patches, and issues with that
process. Here is a relevant blurb, explaining some issues Aaron has run
into using the dpdk-ci repo "poll-pw.sh" shell script:

----------------

* Discussion pertaining to looking at polling for series using the events
API. This events endpoint (with series created event) returns info that a
series has been created, but returns a limited set of data in the payload,
and this necessitates a followup request to patchwork. So, this seems like
it would actually increase the amount of requests made to the patchwork
server. Some related issues discussed are:
   * You cannot query the events endpoint for only events from a particular
project (this matters for patchwork instances with many projects under
them). For DPDK there are only 4 projects under DPDK patchwork, so it=E2=80=
=99s not
a huge deal, but still a small issue.
   * The datetime that the series-created event returns is the datetimes of
one of the commits in the series, not the datetime of when the series was
submitted. So, this means that if you amend a commit (this does not update
commit datetime) and resubmit a patchseries, the datetime on the
series-created record will not be =E2=80=9Cupdated=E2=80=9D. This can cause=
 us to miss
series when polling via the events endpoint.

------------------

And for context, poll-pw.sh will check the /events/ endpoint for new series
created events like so:

--------------------

URL=3D"${URL}/events/?category=3D${resource_type}-completed"

callcmd () # <patchwork id>
{
	eval $cmd
}

while true ; do
	date_now=3D$(date --utc '+%FT%T')
	since=3D$(date --utc '+%FT%T' -d $(cat $since_file | tr '\n' ' '))
	page=3D1
	while true ; do
		ids=3D$(curl -s "${URL}&page=3D${page}&since=3D${since}" |
			jq "try ( .[] | select( .project.name =3D=3D \"$project\" ) )" |
			jq "try ( .payload.${resource_type}.id )")
		[ -z "$(echo $ids | tr -d '\n')" ] && break
		for id in $ids ; do
			if grep -q "^${id}$" $poll_pw_ids_file ; then
				continue
			fi
			callcmd $id
			echo $id >>$poll_pw_ids_file


-------------------

But, as was discussed at the meeting, once you have the series ids, then
you need to make a followup request to /series/{id}.

UNH has a download_patchset.py polling script very much like poll-pw.sh
except that, because we store extra info about our processed patchseries in
a database (to facilitate lab.dpdk.org filtering functions), we use our
database to get the most recently processed patchseries, instead of the
"since_file." Our process (running every 10 minutes from Jenkins) is like
this:

1. get the "since_id" from our database
2. get the "newest_id" from https://patchwork.dpdk.org/api/
events/?category=3Dseries-completed. Get the [0] index of the json response
(the most recent patchseries) and save that series id.
3. for seriesID in range(since_id, newest_id): get patch from
https://patchwork.dpdk.org/api/series/{id}.

So, both poll-pw.sh and our UNH script follow the process of making a
request to /events/, and then followup requests for /series/. Thus the
total number of requests being made on patchwork is (number of new
patchseries + 1).

-The most consequential difference in the two implementations is that
poll-pw.sh makes a request to /events/ with the &since=3D${since} parameter=
,
passing in a since datetime, and UNH does not. As Aaron explained at the CI
meeting, because the datetime provided in the /events/ payload is not what
one would expect (it gives the datetime of the commit, not when the series
was submitted) this means that poll-pw-sh can miss series. With the UNH lab
polling script we don't have this issue because we don't make use of the
since parameter in our /events/ request. I think the options for poll-pw.sh
going forward would be:
1. Update patchwork so that the datetime provided in the /events/ payload
is what is "expected" i.e. the datetime that the series was submitted at.
2. Adopt the UNH process of discarding the &since=3D${since} parameter, and
rely solely on tracking the most recently processed patchseries id, get the
newest patchseries id from /events/, and traverse the range of (since_id,
newest_id).

-I agree it makes sense for /events/ to support a "project" param.

Thanks Aaron for raising this conversation. We can continue the
conversation over email, or also in person at DPDK Prague!

--000000000000cf3e54063465c6ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>There was some discussion at last week&#39;s CI meeti=
ng about usage of the Patchwork /events/ endpoint for polling for patches, =
and issues with that process. Here is a relevant blurb, explaining some iss=
ues Aaron has run into using the dpdk-ci repo &quot;poll-pw.sh&quot; shell =
script:=C2=A0<br><br>----------------<br><br>* Discussion pertaining to loo=
king at polling for series using the events API. This events endpoint (with=
 series created event) returns info that a series has been created, but ret=
urns a limited set of data in the payload, and this necessitates a followup=
 request to patchwork. So, this seems like it would actually increase the a=
mount of requests made to the patchwork server. Some related issues discuss=
ed are:<br>=C2=A0 =C2=A0* You cannot query the events endpoint for only eve=
nts from a particular project (this matters for patchwork instances with ma=
ny projects under them). For DPDK there are only 4 projects under DPDK patc=
hwork, so it=E2=80=99s not a huge deal, but still a small issue.<br>=C2=A0 =
=C2=A0* The datetime that the series-created event returns is the datetimes=
 of one of the commits in the series, not the datetime of when the series w=
as submitted. So, this means that if you amend a commit (this does not upda=
te commit datetime) and resubmit a patchseries, the datetime on the series-=
created record will not be =E2=80=9Cupdated=E2=80=9D. This can cause us to =
miss series when polling via the events endpoint.<br><br>------------------=
</div><div><br></div><div>And for context, poll-pw.sh will check the /event=
s/ endpoint for new series created events like so:</div><div><br></div><div=
>--------------------</div><div><br></div><div><pre style=3D"padding:0px;ma=
rgin-top:0px;margin-bottom:0px;color:rgb(0,0,0);font-size:13.3333px"><code>=
<font face=3D"arial, sans-serif">URL=3D&quot;${URL}/events/?category=3D${re=
source_type}-completed&quot;

callcmd () # &lt;patchwork id&gt;
{
	eval $cmd
}

while true ; do
	date_now=3D$(date --utc &#39;+%FT%T&#39;)
	since=3D$(date --utc &#39;+%FT%T&#39; -d $(cat $since_file | tr &#39;\n&#3=
9; &#39; &#39;))
	page=3D1
	while true ; do
		ids=3D$(curl -s &quot;${URL}&amp;page=3D${page}&amp;since=3D${since}&quot=
; |
			jq &quot;try ( .[] | select( .<a href=3D"http://project.name">project.na=
me</a> =3D=3D \&quot;$project\&quot; ) )&quot; |
			jq &quot;try ( .payload.${resource_type}.id )&quot;)
		[ -z &quot;$(echo $ids | tr -d &#39;\n&#39;)&quot; ] &amp;&amp; break
		for id in $ids ; do
			if grep -q &quot;^${id}$&quot; $poll_pw_ids_file ; then
				continue
			fi
			callcmd $id
			echo $id &gt;&gt;$poll_pw_ids_file</font></code></pre></div><div><br></d=
iv><div>-------------------</div><div><br></div><div>But, as was discussed =
at the meeting, once you have the series ids, then you need to make a follo=
wup request to /series/{id}.</div><div><br></div><div>UNH has a download_pa=
tchset.py polling script very much like poll-pw.sh except that, because we =
store extra info about our processed patchseries in a database (to facilita=
te <a href=3D"http://lab.dpdk.org">lab.dpdk.org</a> filtering functions), w=
e use our database to get the most recently processed patchseries, instead =
of the &quot;since_file.&quot; Our process (running every 10 minutes from J=
enkins) is like this:</div><div><br></div><div>1. get the &quot;since_id&qu=
ot; from our database</div><div>2. get the &quot;newest_id&quot; from <a hr=
ef=3D"https://patchwork.dpdk.org/api/">https://patchwork.dpdk.org/api/</a><=
span style=3D"font-family:arial,sans-serif;color:rgb(0,0,0);font-size:13.33=
33px">events/?category=3Dseries-completed</span>. Get the [0] index of the =
json response (the most recent patchseries) and save that series id.<br></d=
iv><div>3. for seriesID in range(since_id, newest_id): get patch from <a hr=
ef=3D"https://patchwork.dpdk.org/api/series/{id}">https://patchwork.dpdk.or=
g/api/series/{id}</a>.</div><div><br></div><div>So, both poll-pw.sh and our=
 UNH script follow the process of making a request to /events/, and then fo=
llowup requests for /series/. Thus the total number of requests being made =
on patchwork is (number of new patchseries=C2=A0+ 1).</div><div><br></div><=
div>-The most consequential difference in the two implementations is that p=
oll-pw.sh makes a request to /events/ with the=C2=A0&amp;since=3D${since} p=
arameter, passing in a since datetime, and UNH does not. As Aaron explained=
 at the CI meeting, because the datetime provided in the /events/ payload i=
s not what one would expect (it gives the datetime of the commit, not when =
the series was submitted) this means that poll-pw-sh can miss series. With =
the UNH lab polling script we don&#39;t have this issue because we don&#39;=
t make use of the since parameter in our /events/ request. I think the opti=
ons for poll-pw.sh going forward would be:</div><div>1. Update patchwork so=
 that the datetime provided in the /events/ payload is what is &quot;expect=
ed&quot; i.e. the datetime that the series was submitted at.</div><div>2. A=
dopt the UNH process of discarding the=C2=A0<span style=3D"color:rgb(0,0,0)=
;font-size:13.3333px">&amp;since=3D${since} parameter, and rely solely on t=
racking the most recently processed patchseries id, get the newest patchser=
ies id from /events/, and traverse the range of=C2=A0</span>(since_id, newe=
st_id).</div><div><br></div><div>-I agree it makes sense for /events/ to su=
pport a &quot;project&quot; param.</div><div><br></div><div>Thanks Aaron fo=
r raising this conversation. We can continue the conversation over email, o=
r also in person at DPDK Prague!</div><div><br></div><div><br></div></div>

--000000000000cf3e54063465c6ad--
