Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767BBCCFA03
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 03:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A81E7402B1;
	Tue,  4 Nov 2025 04:37:04 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1512240299
 for <dev@dpdk.org>; Tue,  4 Nov 2025 04:37:03 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so4792760b3a.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 19:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762227422; x=1762832222; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=v5+YPr+5jhjRUqC4frvZbFFJFG5+EiAytRPynETDwGo=;
 b=HhCUx/xCo4DULdPVbO/cXjHe5gbV9nLNSORVAbEVydkW/II5yJq2cFh0nFChkxyxYH
 cyS916CBc4KWmJ6lPo8Z01PmaqsOBO4W26WxMiNhOkl1DL2p00FEKnvqedrHy0xAKSuh
 nwGUPKQ6n/gDtYYgvCSCz/9jZQhfDCQ11T2ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762227422; x=1762832222;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v5+YPr+5jhjRUqC4frvZbFFJFG5+EiAytRPynETDwGo=;
 b=euleNpBw9Jf3h1DT6G65OcoQslNZ0cg9Agal/SIJFxC+X46cjOQwcRbFH28h+lrfkd
 oftXIhDcTvLUWuq3kV+DqnCxjQFd+lUhf57WIgItvJxxJGhSbdQ3HMbb3g60l7V2lIlr
 vvOvVrFtp8bDvPbNwOskkDY0YSWtR91tIi0rqnrRyzK/d0lq5mSpIV+P1OLXSg0iPEWL
 S9djHFNu6SbYBLWQeNUKQ+J8mDPvFQTlZRBlpFD2WPO8u/q+pRXYzZI9y2czoVJ2/N+I
 /eB7vn261HL3fniPCG24ZjaXggWcz3K6eUkdr1hR3aI2CZaITizb3qrn84J8GCpLhGkD
 SiCw==
X-Gm-Message-State: AOJu0Yy0KN8ORPur+Wq5p90uOPDmbVADVm5aGqzDgyubKlfn0dv5rqQu
 qE86+X14d3YzaBz6HIwQhOFxZPMFIjfEhuBuNVu0LESTOG0CYXNFmp7V3i5JJPSgaZz7aDXYc2K
 m6mXYj+fMJJsjHYwOHvsei6kjkvXsceGIESQfoqEw0nVGJOHr9u+MN/w=
X-Gm-Gg: ASbGncteB9DpqaXBEmCY3vbizXK//O5A78T9BeyvUISymAtcnBgEwBpSvYfz8us+rh/
 B3GF0U+i4femI+Cv90AyWlxHN0UJtymje6vyeRvXdBezIonif9cYw1G6pAFeJ3L4zt8WDWWpg54
 lMXr8RP6pOaTdbOsgeu6mO/RP1Snw8fsjkU6xdun4B7yUIegFX881K/jajS/DiyKvSYmUcxTzUY
 krbSpr0ef4LE3Q6MhMGFxtwBT4ZTUi2jEFo3VXP1iDt5MTVvrQ+bWSo6l3X8uKc0+hgEcNx3WGB
X-Google-Smtp-Source: AGHT+IEWNVX5VJgbW0sDBe1OqLPBoctqzli/F363XuWqStgXXlklzVNYVrZTSNWe8hTYzqjeMDN9u3MAqkdPsTptVAc=
X-Received: by 2002:a17:903:187:b0:290:9332:eed1 with SMTP id
 d9443c01a7336-2951a4933f0mr211382405ad.34.1762227421741; Mon, 03 Nov 2025
 19:37:01 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 3 Nov 2025 22:35:56 -0500
X-Gm-Features: AWmQ_bnmnPZtHcJcZ8KMsbgBHjCmbvyED5nOpnNPWi71B7nLXmaBwjq1QZ0bU3E
Message-ID: <CAJvnSUCBMiS=WAk7HgR7t_mfsj27ALmN4S3yViA57qVX=Q2DOQ@mail.gmail.com>
Subject: Community CI Meeting Minutes - October 30, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000007cae810642bc8bb0"
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

--0000000000007cae810642bc8bb0
Content-Type: text/plain; charset="UTF-8"

#####################################################################
October 30, 2025
Attendees
1. Patrick Robb
2. Andrew Bailey
3. Aaron

#####################################################################
Minutes

=====================================================================
General Announcements
* Release Candidate 2 (RC2) will be released by the end of next week.
* DPDK Tech board voted on UNH Community Lab priorities for 2026, and we
discussed the goals at tech board yesterday:
https://docs.google.com/spreadsheets/d/1VXfO2vhiUwlRoGldEtHaKuyIa-tZ05QvPsuMUZNlJck/edit?gid=0#gid=0
   * DTS:
      * priority on pushing DTS out to broader use by the community
         * To this end, Patrick to submit a patch with an edit to the DPDK
contribution guidelines, adding a new requirement that ethdev patches come
in with DTS testcase additions/updates for the patch. We did not define a
timeline for merging this (I gathered it would not be during 25.11) but it
makes sense to get the patch ready.
      * Priority on reducing the barrier of entry for writing testsuites /
reducing lines of code required. We have already done some work to
facilitate this but it makes sense to take another pass at it and see what
further improvements are possible.
         * Patrick should forward to Andrew the old thread with Gregory,
Thomas, Honnappa etc. about dpdk unit test, parsing YAML to tests (an idea
we did not adopt), and the broad goal of reducing lines of code required to
write a test
* OvS/OvN conference is happening in a few weeks, and Aaron is working on
finalizing his talk etc. so he will be fairly busy in the next few weeks.

=====================================================================
CI Status

---------------------------------------------------------------------
AWS Lab
* None

---------------------------------------------------------------------
UNH-IOL Community Lab
* Pw-ci
   * UNH experimenting with a jenkins_mon jenkins provider for CI testing
in the pw-ci framework
   * Patrick provided a review back to Aaron for the initial pw-ci port
from Bash to Python
   * Open question about having a distinct jenkins_mon (current attempt
from UNH) vs handling everything on 1 Jenkins machine
* We started running new DTS testsuites on E810 on Arm Grace a couple weeks
ago - there have been some failures (not really DTS related) where the
network interfaces will not bind to DPDK or kernel drivers. We rebooted the
system and send in retests yesterday.
* We are standing up a dev version of a new results dashboard which we are
using broadly at UNH (beyond the DPDK project) and pushing DPDK results to
it. There are some remaining requirements for the DPDK project which we are
working on providing via this dashboard.

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions Robot
* In Q1 of next year, Aaron will be working to upgrade their current bash
based instance of pw-ci to python scripting
* Need to update the label for the post results script.
* Proposing a new format for reporting the direct URLs to the results page.

---------------------------------------------------------------------
Loongson Lab
* None

=====================================================================
DTS Improvements & Test Development
* Mbuf_fast_free testcase is merged
* Single_core_forward_perf:
   * Andrew is providing a review
   * Dean has tested the series.
      * Dean can you add a tested-by tag if you are done?
* UNH lab to pick up moving over more of the existing framework calls to
the testsuite API
* Virtio testsuite:
   * Fully virtual testsuites look good
   * Physical virtual physical testsuite is showing more packets forwarded
than expected. Dean is reviewing whether packets are being looped or
similar.
* QinQ testsuite:
   * New version sent on Friday

=====================================================================
Any other business
   * Next Meeting is Nov 13, 2025
   * The November 27 meeting is on American Thanksgiving, so it will be
cancelled.

--0000000000007cae810642bc8bb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">#########################################=
############################<br>October 30, 2025<br>Attendees<br>1. Patrick=
 Robb<br>2. Andrew Bailey<br>3. Aaron<br><br>##############################=
#######################################<br>Minutes<br><br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<br>* Re=
lease Candidate 2 (RC2) will be released by the end of next week.<br>* DPDK=
 Tech board voted on UNH Community Lab priorities for 2026, and we discusse=
d the goals at tech board yesterday: <a href=3D"https://docs.google.com/spr=
eadsheets/d/1VXfO2vhiUwlRoGldEtHaKuyIa-tZ05QvPsuMUZNlJck/edit?gid=3D0#gid=
=3D0" target=3D"_blank">https://docs.google.com/spreadsheets/d/1VXfO2vhiUwl=
RoGldEtHaKuyIa-tZ05QvPsuMUZNlJck/edit?gid=3D0#gid=3D0</a><br>=C2=A0 =C2=A0*=
 DTS:<br>=C2=A0 =C2=A0 =C2=A0 * priority on pushing DTS out to broader use =
by the community<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* To this end, Patric=
k to submit a patch with an edit to the DPDK contribution guidelines, addin=
g a new requirement that ethdev patches come in with DTS testcase additions=
/updates for the patch. We did not define a timeline for merging this (I ga=
thered it would not be during 25.11) but it makes sense to get the patch re=
ady.<br>=C2=A0 =C2=A0 =C2=A0 * Priority on reducing the barrier of entry fo=
r writing testsuites / reducing lines of code required. We have already don=
e some work to facilitate this but it makes sense to take another pass at i=
t and see what further improvements are possible. <br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* Patrick should forward to Andrew the old thread with Gregory=
, Thomas, Honnappa etc. about dpdk unit test, parsing YAML to tests (an ide=
a we did not adopt), and the broad goal of reducing lines of code required =
to write a test<br>* OvS/OvN conference is happening in a few weeks, and Aa=
ron is working on finalizing his talk etc. so he will be fairly busy in the=
 next few weeks.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>CI Status<br><br>------------------------------------------------=
---------------------<br>AWS Lab<br>* None<br><br>-------------------------=
--------------------------------------------<br>UNH-IOL Community Lab<br>* =
Pw-ci<br>=C2=A0 =C2=A0* UNH experimenting with a jenkins_mon jenkins provid=
er for CI testing in the pw-ci framework<br>=C2=A0 =C2=A0* Patrick provided=
 a review back to Aaron for the initial pw-ci port from Bash to Python<br>=
=C2=A0 =C2=A0* Open question about having a distinct jenkins_mon (current a=
ttempt from UNH) vs handling everything on 1 Jenkins machine<br>* We starte=
d running new DTS testsuites on E810 on Arm Grace a couple weeks ago - ther=
e have been some failures (not really DTS related) where the network interf=
aces will not bind to DPDK or kernel drivers. We rebooted the system and se=
nd in retests yesterday.<br>* We are standing up a dev version of a new res=
ults dashboard which we are using broadly at UNH (beyond the DPDK project) =
and pushing DPDK results to it. There are some remaining requirements for t=
he DPDK project which we are working on providing via this dashboard. <br><=
br>---------------------------------------------------------------------<br=
>Intel Lab<br>* None<br><br>-----------------------------------------------=
----------------------<br>Github Actions Robot<br>* In Q1 of next year, Aar=
on will be working to upgrade their current bash based instance of pw-ci to=
 python scripting<br>* Need to update the label for the post results script=
.<br>* Proposing a new format for reporting the direct URLs to the results =
page.<br><br>--------------------------------------------------------------=
-------<br>Loongson Lab<br>* None<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Development<br>* Mb=
uf_fast_free testcase is merged<br>* Single_core_forward_perf:<br>=C2=A0 =
=C2=A0* Andrew is providing a review<br>=C2=A0 =C2=A0* Dean has tested the =
series.<br>=C2=A0 =C2=A0 =C2=A0 * Dean can you add a tested-by tag if you a=
re done?<br>* UNH lab to pick up moving over more of the existing framework=
 calls to the testsuite API<br>* Virtio testsuite: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>=C2=A0 =C2=A0* Fully virtual testsuites look good<br>=C2=A0 =C2=A0* =
Physical virtual physical testsuite is showing more packets forwarded than =
expected. Dean is reviewing whether packets are being looped or similar.<br=
>* QinQ testsuite:<br>=C2=A0 =C2=A0* New version sent on Friday<br>=C2=A0 =
=C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>An=
y other business<br>=C2=A0 =C2=A0* Next Meeting is Nov 13, 2025<br>=C2=A0 =
=C2=A0* The November 27 meeting is on American Thanksgiving, so it will be =
cancelled.<br>=C2=A0 =C2=A0</div>
</div>

--0000000000007cae810642bc8bb0--
