Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1A9D59D8E
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 19:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB9074027D;
	Fri, 12 Dec 2025 20:57:23 +0100 (CET)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0A2F440268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 20:57:22 +0100 (CET)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso2412528b3a.2
 for <dev@dpdk.org>; Fri, 12 Dec 2025 11:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765569441; x=1766174241; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IrnI+aMowYYVQzcdVzo2ftCRResb9Bl+GzIPTMdJgcM=;
 b=DaRW1EVMZI16qVmPwbgayd5o6lPF87J6mkljtsmIfrB6G4R5LwTfSCFR0WgF8xd2Iw
 30Xii+S6GYYKntC5O7eHqMuHpbs5Dr5p2uFtY/2JIKKmUsvIMJeTCE+AQSI3aJB4OzRh
 oxiiCgW/vHCaHto1msKxEYmKq2zs5/ES+uGpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765569441; x=1766174241;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IrnI+aMowYYVQzcdVzo2ftCRResb9Bl+GzIPTMdJgcM=;
 b=W0/T/4TujJjjznP9FXMS8z4Ldq/JRSsUw9kqS3mGOghUzSmUMrxn1MAyODFPom4hXl
 D9FbSHOWV4dCh21k5Jg+BS1w/IrvJld/WkGLNYKJgP+LhebG1TutsVR2kzXZACJCxRSA
 J9zqBKqsY2boyw/g9G+lVT+Abpbd617uRzam35C1nYNIYaNSJt35BRi9Jc5wsgaefgJU
 Fiy2etVlWOk51uPqSHxapr4yIUl0uz4OpZ+cUsz7KezZQMiimceIUB0Bl2lGjY9gBVdo
 vI1oZ9AXSe1WhXfo00Zu3d3OijO1nV96czHbAhv6vf+5qxDmJXRnm8kIlo1QYRYoHI+1
 QhVA==
X-Gm-Message-State: AOJu0YzOSO/5i9FK4bF7d4LAH8kTS3dX0fBgr18ERZF78uiOcT7Lf7gA
 Em4X75ncTdoQtglFnCv8k9UeOGy5vHArNzbLYAfnCcsOMkYfsjPHcNAy1R99QBznNia3iCURMoT
 AsWvwsH4trOiMBG58E65yaXs+783DW+jJYQrq8xIJMg==
X-Gm-Gg: AY/fxX6Mp9rG/JrKWBlmE2ofkAO5pgx3/duQEkARKoKH/pJShxEEdIsxqZzYBYE/vwg
 IkSr8fa731PfU8Jkkh50KqJVL7hBuKhRte5TfcXtJl32nQcsMtHFyYMrp04xBNxU3Ryqtesooq8
 xKeBcTZ+jl9ozGSrKD01d/nQ2AA8xcYO4KJZ6xg1iEsgPh3VSWcfePUKdbYEac9oFnxrAmExsF5
 lfOQCtyENfg1Um2ziT88Sd2rj8gM4E3VP4H32a4L9+GC3lcC6DKXz6B65+So/FyDeGsN5RvKpM6
 7DG4L9FAufCbd3y0PrjmiFtoClya
X-Google-Smtp-Source: AGHT+IHBWEuDyZ+R+XS9TlQ+gEKRjW5Wwo4eF25VFA6NKEB7h0lnkfoQ2qbresO1sK2bpn2rzRCT8715VRYbtVkzUe4=
X-Received: by 2002:a05:701b:2202:b0:11a:49bd:be28 with SMTP id
 a92af1059eb24-11f34ac5359mr1876724c88.4.1765569440848; Fri, 12 Dec 2025
 11:57:20 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 12 Dec 2025 14:55:37 -0500
X-Gm-Features: AQt7F2oq2skMUgXOCSoAgZ0EpN0Npua_Xf4HucOoSrDkRIF7l3KSuggroBYwqwI
Message-ID: <CAJvnSUA87p9d2psgpKA_sFL3HVZnxDB48R5R=mkaweL_g4UAgw@mail.gmail.com>
Subject: Community CI Meeting Minutes - December 11, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000592edb0645c6ab53"
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

--000000000000592edb0645c6ab53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

December 11, 2025

Attendees
1. Patrick Robb
2. Aaron Conole
3. Paul Szczepanek
4. Luca Vizzarro

Minutes

General Announcements
* Upcoming meetings:
   * 12/25 CI meeting: Canceled because of Christmas
   * 01/01 DTS meeting: Canceled because of New Year's Day
* Patchwork API requests: Ali who maintains the patchwork instance has
reached out to various labs asking if they can reduce the amount of
requests they are making to patchwork.
   * UNH:
      * Adding a trailing =E2=80=9C/=E2=80=9D to the URL for requests, so t=
here is no 301
redirect: Will deploy today
      * Properly increment the =E2=80=9Csince=E2=80=9D timestamp arg for th=
e test recheck
request script - deploying Friday.
      * Will check in with Ali at the end of the week to make sure we are
good to go
   * Github Robot:
      * Ozlabs patchwork instance has also instated some new policies which
affect the robot
      * The robot was working by monitoring series until that series was
moved into a different state (i.e. new, accepted, superseded, etc.)
         * Since the robot started running about 7 years ago, there have
been about 1000 series that are =E2=80=9Cincomplete,=E2=80=9D meaning only =
a subsection of
the patches in a series were actually submitted. These got marked as
archived, which meant that the robot continued to track these, resulting in
a significant amount of unnecessary requests being made.
            * Going forward, the robot drops a patchseries from
consideration once it=E2=80=99s age gets beyond 30 days
      * Ozlabs: Now enforcing we are using https instead of http
         * The robot has been updated to use https now
      * The robot has been running for 7 years with minimal downtime. So,
it has various older software package, including sqlite3, etc. Aaron=E2=80=
=99s
version of sqlite3 requires strict SQL syntax, but the version of sqllite
on the server does not accept this syntax. So, Aaron made a bunch of
changes, but the robot is not functioning properly due to this sql issue
      * There are now some failures which Aaron is debugging but which are
confusing, i.e. an echo command failing
      * There may be some bad records in the database now. Aaron is looking
through these and will resolve the remaining bugs before correcting the
database / rolling back.
      * There may be some downtime or a need to reboot the server hosting
the CI system
   * Loongson:
      * Bibo is the new maintainer, and is looking at the requests that Ali
has mentioned.
      * Patrick will offer to look at the dpdk-ci scripting with Bibo if he
has issues identifying where the inadvertent requests are coming from
   * AWS: Seems like there are no issues with requests to patchwork API

* CI Status

AWS Lab
* They had a false failure last week due to a conflict on 2 jobs using the
same meson dir concurrently. Waleej from AWS has resolved this and put in a
retest.

UNH-IOL Community Lab
* ABI Testing:
   * We have built the 26.0 ABI reference from the 25.11 release and begun
ABI testing for the 26.03 release
   * In addition, we are also running ABI testing on 22.11-staging,
23.11-staging, 24.11-staging, and 25.11-staging, against the ABI references
of their respective releases.
* ARM Grace:
   * Testing will run fine for some weeks, then at some point the NIC gets
into a bad state and performance drops significantly
   * Weird behavior: NIC insterface 0 showin as /dev/fb0, rebinding to ICE
at the end now results in input/output error, etc.
* We are distro upgrading and/or reprovisioning some of our servers in the
CI Lab in the next week, which will cause some small downtime
   * If there is any significant downtime Patrick can update on Slack or
the mailing list
* DTS:
   * We are working on enabling the new single core forwarding test on our
testbeds, which will mean these can stop running legacy DTS on our servers
for this test.
   * Otherwise, the only remaining reason to use legacy DTS is cryptodev
testing, which is being worked on for the current DTS framework right now
and should have coverage arriving in 26.03
   * Dean at UNH needs to reach out to John Mcnamera and ask about what
information we can share from runs on the flow offload test

Intel Lab
* None

Github Actions Robot
* Aaron is actively working on an LLM integration into the pipeline that is
not coderabbit or sourcery
   * Using Sonnet4 (which seems to be working better than sonnet4.5)
   * It is providing some fairly high quality reviews
   * Aaron did post some related patches to the ovs dev mailing list. This
is applicable to DPDK as well
      *
https://mail.openvswitch.org/pipermail/ovs-dev/2025-November/427871.html
      * It should be possible to apply this to the DPDK tree eleven though
it was targeting OvS
      * Example review:
https://mail.openvswitch.org/pipermail/ovs-dev/2025-November/427836.html
         * The replies are inline properly and are raising relevant
questions
      * The downside is the cost (but it should be manageable)
   * With properly tailored prompts, Aaron is seeing much higher quality in
the reviews, now there is a reasonable ratio of good review comments vs
=E2=80=9Cbogus=E2=80=9D comments
   * To save money, one option is to run the normal testing first, and then
only do an LLM review if the initial testing is passing. That should save
on requests to the LLM service.

Loongson Lab
* Bibo is looking at the dpdk-ci scripting to reduce their requests being
made to the Patchwork API

DTS Improvements & Test Development
* Roadmap: We will use the roadmap we finalized last Thursday
* Virtio: We sent Maxime an email asking about what additional test
coverage is needed for virtio - we will proceed when we have his feedback.
   * Otherwise, Dean is working on an addition pvvp testcase currently.

Any other business
   * Next meeting is January 8, 2026

--000000000000592edb0645c6ab53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">December 11, 2025<br><br>Attendees<br>1. Patrick Robb<br>2=
. Aaron Conole<br>3. Paul Szczepanek<br>4. Luca Vizzarro<br><br>Minutes<br>=
<br>General Announcements<br>* Upcoming meetings:<br>=C2=A0 =C2=A0* 12/25 C=
I meeting: Canceled because of Christmas<br>=C2=A0 =C2=A0* 01/01 DTS meetin=
g: Canceled because of New Year&#39;s Day<br>* Patchwork API requests: Ali =
who maintains the patchwork instance has reached out to various labs asking=
 if they can reduce the amount of requests they are making to patchwork.<br=
>=C2=A0 =C2=A0* UNH:<br>=C2=A0 =C2=A0 =C2=A0 * Adding a trailing =E2=80=9C/=
=E2=80=9D to the URL for requests, so there is no 301 redirect: Will deploy=
 today<br>=C2=A0 =C2=A0 =C2=A0 * Properly increment the =E2=80=9Csince=E2=
=80=9D timestamp arg for the test recheck request script - deploying Friday=
.<br>=C2=A0 =C2=A0 =C2=A0 * Will check in with Ali at the end of the week t=
o make sure we are good to go<br>=C2=A0 =C2=A0* Github Robot:<br>=C2=A0 =C2=
=A0 =C2=A0 * Ozlabs patchwork instance has also instated some new policies =
which affect the robot<br>=C2=A0 =C2=A0 =C2=A0 * The robot was working by m=
onitoring series until that series was moved into a different state (i.e. n=
ew, accepted, superseded, etc.)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Sinc=
e the robot started running about 7 years ago, there have been about 1000 s=
eries that are =E2=80=9Cincomplete,=E2=80=9D meaning only a subsection of t=
he patches in a series were actually submitted. These got marked as archive=
d, which meant that the robot continued to track these, resulting in a sign=
ificant amount of unnecessary requests being made.<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 * Going forward, the robot drops a patchseries from co=
nsideration once it=E2=80=99s age gets beyond 30 days<br>=C2=A0 =C2=A0 =C2=
=A0 * Ozlabs: Now enforcing we are using https instead of http<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0* The robot has been updated to use https now<br=
>=C2=A0 =C2=A0 =C2=A0 * The robot has been running for 7 years with minimal=
 downtime. So, it has various older software package, including sqlite3, et=
c. Aaron=E2=80=99s version of sqlite3 requires strict SQL syntax, but the v=
ersion of sqllite on the server does not accept this syntax. So, Aaron made=
 a bunch of changes, but the robot is not functioning properly due to this =
sql issue<br>=C2=A0 =C2=A0 =C2=A0 * There are now some failures which Aaron=
 is debugging but which are confusing, i.e. an echo command failing<br>=C2=
=A0 =C2=A0 =C2=A0 * There may be some bad records in the database now. Aaro=
n is looking through these and will resolve the remaining bugs before corre=
cting the database / rolling back.<br>=C2=A0 =C2=A0 =C2=A0 * There may be s=
ome downtime or a need to reboot the server hosting the CI system<br>=C2=A0=
 =C2=A0* Loongson:<br>=C2=A0 =C2=A0 =C2=A0 * Bibo is the new maintainer, an=
d is looking at the requests that Ali has mentioned.<br>=C2=A0 =C2=A0 =C2=
=A0 * Patrick will offer to look at the dpdk-ci scripting with Bibo if he h=
as issues identifying where the inadvertent requests are coming from<br>=C2=
=A0 =C2=A0* AWS: Seems like there are no issues with requests to patchwork =
API<br><br>* CI Status<br><br>AWS Lab<br>* They had a false failure last we=
ek due to a conflict on 2 jobs using the same meson dir concurrently. Walee=
j from AWS has resolved this and put in a retest.<br><br>UNH-IOL Community =
Lab<br>* ABI Testing:<br>=C2=A0 =C2=A0* We have built the 26.0 ABI referenc=
e from the 25.11 release and begun ABI testing for the 26.03 release<br>=C2=
=A0 =C2=A0* In addition, we are also running ABI testing on 22.11-staging, =
23.11-staging, 24.11-staging, and 25.11-staging, against the ABI references=
 of their respective releases.<br>* ARM Grace: <br>=C2=A0 =C2=A0* Testing w=
ill run fine for some weeks, then at some point the NIC gets into a bad sta=
te and performance drops significantly<br>=C2=A0 =C2=A0* Weird behavior: NI=
C insterface 0 showin as /dev/fb0, rebinding to ICE at the end now results =
in input/output error, etc.<br>* We are distro upgrading and/or reprovision=
ing some of our servers in the CI Lab in the next week, which will cause so=
me small downtime<br>=C2=A0 =C2=A0* If there is any significant downtime Pa=
trick can update on Slack or the mailing list<br>* DTS: <br>=C2=A0 =C2=A0* =
We are working on enabling the new single core forwarding test on our testb=
eds, which will mean these can stop running legacy DTS on our servers for t=
his test.<br>=C2=A0 =C2=A0* Otherwise, the only remaining reason to use leg=
acy DTS is cryptodev testing, which is being worked on for the current DTS =
framework right now and should have coverage arriving in 26.03<br>=C2=A0 =
=C2=A0* Dean at UNH needs to reach out to John Mcnamera and ask about what =
information we can share from runs on the flow offload test<br><br>Intel La=
b<br>* None<br><br>Github Actions Robot<br>* Aaron is actively working on a=
n LLM integration into the pipeline that is not coderabbit or sourcery<br>=
=C2=A0 =C2=A0* Using Sonnet4 (which seems to be working better than sonnet4=
.5)<br>=C2=A0 =C2=A0* It is providing some fairly high quality reviews<br>=
=C2=A0 =C2=A0* Aaron did post some related patches to the ovs dev mailing l=
ist. This is applicable to DPDK as well<br>=C2=A0 =C2=A0 =C2=A0 * <a href=
=3D"https://mail.openvswitch.org/pipermail/ovs-dev/2025-November/427871.htm=
l">https://mail.openvswitch.org/pipermail/ovs-dev/2025-November/427871.html=
</a><br>=C2=A0 =C2=A0 =C2=A0 * It should be possible to apply this to the D=
PDK tree eleven though it was targeting OvS<br>=C2=A0 =C2=A0 =C2=A0 * Examp=
le review: <a href=3D"https://mail.openvswitch.org/pipermail/ovs-dev/2025-N=
ovember/427836.html">https://mail.openvswitch.org/pipermail/ovs-dev/2025-No=
vember/427836.html</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The replies a=
re inline properly and are raising relevant questions<br>=C2=A0 =C2=A0 =C2=
=A0 * The downside is the cost (but it should be manageable)<br>=C2=A0 =C2=
=A0* With properly tailored prompts, Aaron is seeing much higher quality in=
 the reviews, now there is a reasonable ratio of good review comments vs =
=E2=80=9Cbogus=E2=80=9D comments<br>=C2=A0 =C2=A0* To save money, one optio=
n is to run the normal testing first, and then only do an LLM review if the=
 initial testing is passing. That should save on requests to the LLM servic=
e.<br><br>Loongson Lab<br>* Bibo is looking at the dpdk-ci scripting to red=
uce their requests being made to the Patchwork API<br><br>DTS Improvements =
&amp; Test Development<br>* Roadmap: We will use the roadmap we finalized l=
ast Thursday<br>* Virtio: We sent Maxime an email asking about what additio=
nal test coverage is needed for virtio - we will proceed when we have his f=
eedback. <br>=C2=A0 =C2=A0* Otherwise, Dean is working on an addition pvvp =
testcase currently.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <br>Any other business<br>=C2=A0 =C2=A0* Next meeting is January 8, 202=
6<br>=C2=A0 =C2=A0</div>

--000000000000592edb0645c6ab53--
