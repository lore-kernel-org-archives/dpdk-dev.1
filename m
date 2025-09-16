Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C96CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 13:54:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 745324066E;
	Tue, 16 Sep 2025 15:54:39 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id E9D5E40612
 for <dev@dpdk.org>; Tue, 16 Sep 2025 15:54:36 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so4377445b3a.0
 for <dev@dpdk.org>; Tue, 16 Sep 2025 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758030876; x=1758635676; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Zk7Su9Cq9YZu8H4MHE4VRmIPVfq3BfUY+k/tJvugwfc=;
 b=gLIVwfZI3cVUdF7RtopCm/VuFCi2gGPO7kJgzSyuOomRViOvCUNOoKwFFCHZDpoacp
 lMKeYJyNtm6na1+oKNKM5f6fizUvWa5q2hWMR77ksujoC9yBsAlrp1iBnFbiJH4Tg4rR
 ffetxNPv18WcqN8R3NGzSLqFIajKm3HSM98PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758030876; x=1758635676;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zk7Su9Cq9YZu8H4MHE4VRmIPVfq3BfUY+k/tJvugwfc=;
 b=bsToOcMy7nmEDPwW7sidGuvkqfPeN/VVxFSmUQFhZ000QdFc5PPRSQaK9P2OFmQW56
 h9E2/4qEXX7zZiXYoXcz4i4RsUoqM+PsmVZ1T+64dT7wlcI1aqQw3fY5lLwsaSzYm9OF
 Hp5scrxGwL0fYFHwTbtoTNcS5Az3Csdrun0qs7acvIaRf2iJSvseRQvLdn2s+PevtvS+
 ueGjyTIal9ssgy8iR+8NhM16r4oHec9dBdwBpmFEIpdZll6z3elntyJ6pZW/0bPoRNjF
 vd252h/ucs2Lgfm1cT9c4KwnDAX+8l/zDLGQIxUeUe1EGe1fs0uBBNibSGmwzLDeM2Qc
 uA4g==
X-Gm-Message-State: AOJu0Yzlw9QvILzuUfxsDovyutv+mY52f44IoNGQFxJLuFLh80dpkMUy
 OHhumj0XSDyVAQkHad5tNJ3f321MDRzZMTxz2hd7not8RTtOubyNK/dJU8InoGwiQeqfqlIgXPR
 OlKwGaP2tO4a6xRqUC63o+oekqIcczdMJVtq0SXgg/V9OyimFq52h3+E=
X-Gm-Gg: ASbGncutjHTo8mBhdyyoo4j0+p7DjbK8IV0j0e33/bsPSLesRbkpKioOS3SFL45SB/7
 20rzReAx8AmP9uk6fSIoDTJhuhByPIrdT45q1O/ivSZea4h9hwUzTJpScos3e831Q/b4zX6V29D
 TUg4Fhj6YoqgUjCh6Jd4wptISe7ixlJSe5nNAfqbJzR/tUBP1X328iACojSL4rAXFt+XhsmEWMk
 +fIuSd0BvFprjPuQvkmuXfwanlyKebIFA5DRNY9
X-Google-Smtp-Source: AGHT+IE1coxi/wdPajEClxDOGIc7RV7HPPk1/aiUtREsbrMyxBzbqWw52tRwZ6lMJTkzNeZzgbM9DVHc2VtHsG2EkAY=
X-Received: by 2002:a17:903:1b10:b0:252:50ad:4e6f with SMTP id
 d9443c01a7336-25d27038fcdmr234047955ad.54.1758030875858; Tue, 16 Sep 2025
 06:54:35 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 16 Sep 2025 09:47:30 -0400
X-Gm-Features: AS18NWAnC3l9JMSn47k_zSSv5_r_cm4rORYRQhb2xyWLATqK6BGf7TtsiAQRPPA
Message-ID: <CAJvnSUBYCQmnHQwWWgZsnqooTVyo7UMPtMsbm4jSa6ErJG7X6g@mail.gmail.com>
Subject: Community CI Meeting Minutes - September 4, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000dc29c4063eeb7542"
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

--000000000000dc29c4063eeb7542
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
September 4, 2025
Attendees
1. Patrick Robb
2. Aaron Conole
3. Andrew Bailey
4. Luca Vizzarro

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* Tech board discussed 32 bit testing yesterday:
   * Will continue to do this for 1-2 years more. Tech board will discuss
again in 6 months.
   * Patrick will collect the unit testing results for an x86_64 system
running with the cross compiled 32 bit unit tests

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
AWS Lab
* Running fine

---------------------------------------------------------------------
UNH-IOL Community Lab
* DTS: We threw in 100 dry run testruns and looked at all the results to
get a better understanding, and:
   * Scatter (drop rx packets rarely)
   * Vlan (rarely error trying to add a vlan)
      * Going to change from DTS testcase Error - > failure on patchwork to
DTS Error -> no result submitted to patchwork and UNH guys get an email
saying go look at the testrun
   * Packet_capture
      * Rarely fail on RX packet does not match TX
   * UNH team to remove these from CI temporarily and check their packet
matching scheme for an implementation issue
* Maintenance
   * We were doing some system migrations recently which have been
successful but required some overnight downtime on 2 nights.
   * Will require 1 more night of downtime to move 1 more service (the
community lab dashboard) off of an old system
* Ajit Khaparde helped us update our broadcom driver/firmware update
procedure

---------------------------------------------------------------------
Intel Lab
* None
* Now that the mbuf_fast_free testcase in DTS is submitted, we need to CC
those guys in. (they recently disabled the mbuf_fast_free testcase in
legacy DTS)

---------------------------------------------------------------------
Github Actions Robot
* Automated PR for AI code review: https://github.com/ovsrobot/dpdk/pulls
   * DPDK project is moving ahead with this
   * Example: https://github.com/ovsrobot/dpdk/pull/1
   * There might be some rate limiting issue or similar - Aaron is debuggin=
g
   * The other benefit is there could be other services that operate
according to the GH pull request model, and now that we have this staged it
would be easy to start integration those services too

---------------------------------------------------------------------
Loongson Lab
* David did merge the dpdk-web patch this morning which updates the recheck
support blurb indicating the new loongson support

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Arg and return type type hints
   * This was merged with Luca=E2=80=99s fixup suggestion
* File Artifacts:
   * V2 is submitted
   * Corrects the issue with there being duplicate testsuite log files and
testcase log files which overlapped with testsuite log files
   * Pcaps were previously not being correctly placed (they were all just
dumped into the top level output dir) so they are now being put in the
testsuite specific folders
* DTS API Series:
   * It is an incremental approach
   * First, Paul is dealing with testpmd shell
* Virtio testing: Dean is working on a virtio forwarding testsuite to start
   * Contains virtio testing testcases both with the backend vhost in
=E2=80=93no-pci mode and also others that have the backend vhost forward pa=
ckets
from physical NICs
* Mbuf_fast_free
   * There are some opportunities to improve offload configuration parsing
and classifying queue offloads vs port offloads. We have a rejected series
from last year that was also adding tx_offload support to DTS and we can
pull some ideas from it:
https://patchwork.dpdk.org/project/dpdk/patch/20240903194642.24458-4-jspewo=
ck@iol.unh.edu/
* Single_core_forwarding
   * Must now enable mbuf_fast_free explicitly in the testcase because
Morten has a series in which change the default from enabled to disabled
and if it=E2=80=99s disabled, forwarding is like -20% MPPS
   * Otherwise, Patrick has worked on some Luca=E2=80=99s comments and rema=
ining
work is minimal
*
https://patchwork.dpdk.org/project/dpdk/patch/20250828123758.20451-1-abaile=
y@iol.unh.edu/
   * We need to refactor the bound_for_kernel logic

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
   * Next Meeting is Sep 18, 2025
   * We will be getting Sourcery reviews for the DTS patches going forward:
https://github.com/ovsrobot/dpdk/pull/2

--000000000000dc29c4063eeb7542
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>September 4, 2025<br>Attendees<br>1. Patrick Robb<br>2. Aaro=
n Conole<br>3. Andrew Bailey<br>4. Luca Vizzarro<br><br>###################=
##################################################<br>Minutes<br><br>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcement=
s<br>* Tech board discussed 32 bit testing yesterday: <br>=C2=A0 =C2=A0* Wi=
ll continue to do this for 1-2 years more. Tech board will discuss again in=
 6 months.<br>=C2=A0 =C2=A0* Patrick will collect the unit testing results =
for an x86_64 system running with the cross compiled 32 bit unit tests<br>=
=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>CI Status<br><br>------------------------------------------------------=
---------------<br>AWS Lab<br>* Running fine<br><br>-----------------------=
----------------------------------------------<br>UNH-IOL Community Lab<br>=
* DTS: We threw in 100 dry run testruns and looked at all the results to ge=
t a better understanding, and:<br>=C2=A0 =C2=A0* Scatter (drop rx packets r=
arely)<br>=C2=A0 =C2=A0* Vlan (rarely error trying to add a vlan)<br>=C2=A0=
 =C2=A0 =C2=A0 * Going to change from DTS testcase Error - &gt; failure on =
patchwork to DTS Error -&gt; no result submitted to patchwork and UNH guys =
get an email saying go look at the testrun<br>=C2=A0 =C2=A0* Packet_capture=
<br>=C2=A0 =C2=A0 =C2=A0 * Rarely fail on RX packet does not match TX<br>=
=C2=A0 =C2=A0* UNH team to remove these from CI temporarily and check their=
 packet matching scheme for an implementation issue<br>* Maintenance<br>=C2=
=A0 =C2=A0* We were doing some system migrations recently which have been s=
uccessful but required some overnight downtime on 2 nights.<br>=C2=A0 =C2=
=A0* Will require 1 more night of downtime to move 1 more service (the comm=
unity lab dashboard) off of an old system<br>* Ajit Khaparde helped us upda=
te our broadcom driver/firmware update procedure<br><br>-------------------=
--------------------------------------------------<br>Intel Lab<br>* None<b=
r>* Now that the mbuf_fast_free testcase in DTS is submitted, we need to CC=
 those guys in. (they recently disabled the mbuf_fast_free testcase in lega=
cy DTS)<br><br>------------------------------------------------------------=
---------<br>Github Actions Robot<br>* Automated PR for AI code review: <a =
href=3D"https://github.com/ovsrobot/dpdk/pulls">https://github.com/ovsrobot=
/dpdk/pulls</a><br>=C2=A0 =C2=A0* DPDK project is moving ahead with this<br=
>=C2=A0 =C2=A0* Example: <a href=3D"https://github.com/ovsrobot/dpdk/pull/1=
">https://github.com/ovsrobot/dpdk/pull/1</a><br>=C2=A0 =C2=A0* There might=
 be some rate limiting issue or similar - Aaron is debugging<br>=C2=A0 =C2=
=A0* The other benefit is there could be other services that operate accord=
ing to the GH pull request model, and now that we have this staged it would=
 be easy to start integration those services too<br><br>-------------------=
--------------------------------------------------<br>Loongson Lab<br>* Dav=
id did merge the dpdk-web patch this morning which updates the recheck supp=
ort blurb indicating the new loongson support<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Develop=
ment<br>* Arg and return type type hints<br>=C2=A0 =C2=A0* This was merged =
with Luca=E2=80=99s fixup suggestion<br>* File Artifacts:<br>=C2=A0 =C2=A0*=
 V2 is submitted<br>=C2=A0 =C2=A0* Corrects the issue with there being dupl=
icate testsuite log files and testcase log files which overlapped with test=
suite log files<br>=C2=A0 =C2=A0* Pcaps were previously not being correctly=
 placed (they were all just dumped into the top level output dir) so they a=
re now being put in the testsuite specific folders<br>* DTS API Series:<br>=
=C2=A0 =C2=A0* It is an incremental approach<br>=C2=A0 =C2=A0* First, Paul =
is dealing with testpmd shell<br>* Virtio testing: Dean is working on a vir=
tio forwarding testsuite to start<br>=C2=A0 =C2=A0* Contains virtio testing=
 testcases both with the backend vhost in =E2=80=93no-pci mode and also oth=
ers that have the backend vhost forward packets from physical NICs<br>* Mbu=
f_fast_free<br>=C2=A0 =C2=A0* There are some opportunities to improve offlo=
ad configuration parsing and classifying queue offloads vs port offloads. W=
e have a rejected series from last year that was also adding tx_offload sup=
port to DTS and we can pull some ideas from it: <a href=3D"https://patchwor=
k.dpdk.org/project/dpdk/patch/20240903194642.24458-4-jspewock@iol.unh.edu/"=
>https://patchwork.dpdk.org/project/dpdk/patch/20240903194642.24458-4-jspew=
ock@iol.unh.edu/</a><br>* Single_core_forwarding<br>=C2=A0 =C2=A0* Must now=
 enable mbuf_fast_free explicitly in the testcase because Morten has a seri=
es in which change the default from enabled to disabled and if it=E2=80=99s=
 disabled, forwarding is like -20% MPPS<br>=C2=A0 =C2=A0* Otherwise, Patric=
k has worked on some Luca=E2=80=99s comments and remaining work is minimal<=
br>* <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/2025082812375=
8.20451-1-abailey@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/pat=
ch/20250828123758.20451-1-abailey@iol.unh.edu/</a><br>=C2=A0 =C2=A0* We nee=
d to refactor the bound_for_kernel logic<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>Any other business<br>=C2=A0 =C2=A0* Next Meeting is Sep 18=
, 2025<br>=C2=A0 =C2=A0* We will be getting Sourcery reviews for the DTS pa=
tches going forward: <a href=3D"https://github.com/ovsrobot/dpdk/pull/2">ht=
tps://github.com/ovsrobot/dpdk/pull/2</a><br>=C2=A0 =C2=A0</div>

--000000000000dc29c4063eeb7542--
