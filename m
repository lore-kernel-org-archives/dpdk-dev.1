Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0674C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 14:15:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CEB140279;
	Fri, 25 Apr 2025 16:15:16 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id BF7D64025E
 for <dev@dpdk.org>; Fri, 25 Apr 2025 16:15:14 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so2212599a91.1
 for <dev@dpdk.org>; Fri, 25 Apr 2025 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745590514; x=1746195314; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BLAZhfBrrCDYt/bee7wb6b9V0OTjMfOyzjv9HDIvuRk=;
 b=NbHXtonLV6ZHKv3LRwpBYAWIIq65+NMWfw7vi2nrNZ+N+5wV3OQFDE2Zq7zo1+Xzso
 uyowi9xolHjkggx3tTAujayn6l3caLygFvQN8XbJPv6jTcqVd6KNU04UnkSTCVAXovHv
 U0H+SZwlDLiXhLxKiTv2x1MYBvQdEyfLfqlv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745590514; x=1746195314;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BLAZhfBrrCDYt/bee7wb6b9V0OTjMfOyzjv9HDIvuRk=;
 b=J+YJUkfqBAI3HNxAhqNVdvPWl5WBW43ZGKjgCIuHXIBXj50g0z6MUfbKwGH+3kOEUu
 0HRyIto3iRBrwAgELgw2T+XgmrCN5QTz+NP5wwcyKCEjb9zvscWqW2Zv/mZMYmpznfxP
 NZSWj6H7yL3/0eFEkVyUVhh1ZY6D7lGTaLbgLBAqR7j/gIuyppVkxqNq0dUVHDeHyesd
 oroBUdxJyZB9Vu2Dv3OWuf07ht9KR79ZuesEQgnuqEXhdL1MulSLJ23TeGW7oFDUfBrj
 mYHeLK2f8JocvtHeqXk6FiA4SytMmHP0Je+CdR9uU+BNScGmvCexCPeukUWIlvc5aTZo
 JL2w==
X-Gm-Message-State: AOJu0Yxb0RQxe7PDbORTgAaDF1sUXoZCkA6uIXOqwsaM9QpyrFm/T4Q4
 Pdsn9uN1SAEoJZ6fmyrB+e4vZoPdPDxAt8dqjvsAaKUMv43/aNVpFrjms1/7HhumIlsLSB1+Aan
 XJqWCGC+I5ydYzHYDc6T79W1FolCGwV6kFLSXWKcqxvRD0fXmGpQ=
X-Gm-Gg: ASbGncupqVmu6qOjgmv85VMygnjR+DuDbM8mMSyr0KHIQjUZnjLqXf1Xs60U4UOshmC
 1YqCBZWmS8Nr34Nz05bNZoPC4yDAb3VVD8C4PpC1y4rqrYv2Fx/kHm1ciTUjlLRt4S1J+ev/GaS
 Xwkcpc73O7KyZn1l0WwlXDGIt7CE59g+qs998Y/i47GMMWzFBpvu4yTntQf5x5C7A7SQ==
X-Google-Smtp-Source: AGHT+IH//unro5/XJ83QFKuHDkFY37lxAKNs5s5urGI5z8aR6r/YgWR+65DmhvsXk+lepf43aucfflyAo1zSJOzoJAQ=
X-Received: by 2002:a17:90b:524f:b0:2ff:4e90:3c55 with SMTP id
 98e67ed59e1d1-309f7e67d73mr4035939a91.27.1745590512956; Fri, 25 Apr 2025
 07:15:12 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 25 Apr 2025 10:10:48 -0400
X-Gm-Features: ATxdqUH-jGfaSFEbTE4-9wvvfOH_iSLeeeMIkZW1wd6BNrCj3Np7V5o5MdFvW7Q
Message-ID: <CAJvnSUB-rDP66K4a5_ZRAbW6_BvEXQLTtT2BH7CXxhUZ7TqjgA@mail.gmail.com>
Subject: Community CI Meeting Minutes - April 17, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000072d81306339af6ea"
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

--00000000000072d81306339af6ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
April 17, 2025
Attendees
1. Patrick Robb
2. Paul Szczepanek
3. Luca Vizzarro
4. Aaron Conole
5. Manit Mahajan

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* DPDK Summit Prague is May 8-9
   * Patrick will share out his presentation to the DTS group when its read=
y
   * Aaron has the metrics he needs for his presentation

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* Intel Quickassist crypto tests: John McNamara gave us a contact for this
- Kai Ji (who is the quickassist maintainer for DPDK). UNH still needs to
pull together the performance metrics to share with Kai before we turn on
the reporting for this test.
* Environment info for reports:
   * There was some discussion on Slack about what environment information
is reported alongside tests, and what can be seen from the dashboard. Some
basic info (distro, kernel, compiler version) is included on the test
report emails, and can also be found on the dashboard like:
https://lab.dpdk.org/results/dashboard/test-matrix/105/
   * But, there are some improvements the lab can do, like extending the
amount of environment information included (so far Bruce suggested
including libc version) and also automatically updating the environment
info more frequently
   * Manit is working on running a python script on Jenkins every 48 hours
which will collect system info for a test environment and update the
respective environment=E2=80=99s fields in our database
   * We can also start inserting more environment info directly into the
top of the test log files which our dashboard hosts for download/view on
test results. This will be a follow up task.
*  Baremetal updates:
   * Cody is working on updates to our testbeds, either on a software level
or moving some NICs to new systems.
* UNH will perform a Jenkins migration in the next couple weeks which will
likely result in a few hours of lab downtime. This will be communicated
ahead of time.
* DTS:
   * Dean is adding some new network cards, and has made some small
improvements to our jenkins scripting which handles starting the DTS
execution and handling the output etc. We will be able to talk about this
some at the DTS presentation at DPDK Prague.
* Patch depends-on support:
   * The patchwork server series is approved and will be in the next releas=
e
   * The associated git-pw patch is also merged now:
https://github.com/getpatchwork/git-pw/pull/77
   * So we are on track to use this once the next patchwork patch is
released and we upgrade the dpdk.org patchwork instance
      * Patrick should email Ali now to start this conversation

---------------------------------------------------------------------
Intel Lab
* Patrick will have to schedule a sync with the people that touch these
testbeds in the Summer to help them setup the DTS framework on their
systems.

---------------------------------------------------------------------
Github Actions
* None

---------------------------------------------------------------------
AWS
* They have been running their Build and Unit tests on x86 and ARM systems
for 2 weeks, and sending test reports to an external email (not the dpdk
test report mailing list). They are scheduled to begin sending the reports
to the dpdk test report mailing list this week.

---------------------------------------------------------------------
Loongarch Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Thomas M has provided some feedback on the rte_flow testsuite,
identifying what are the most common items and actions the rules tested
should be based on: https://inbox.dpdk.org/dev/5050697.TLnPLrj5Ze@thomas/
   *  Items:
      * - RTE_FLOW_ITEM_TYPE_ETH
      * - RTE_FLOW_ITEM_TYPE_IPV4 / RTE_FLOW_ITEM_TYPE_IPV6
      * - RTE_FLOW_ITEM_TYPE_UDP
      * - RTE_FLOW_ITEM_TYPE_TCP
      * - RTE_FLOW_ITEM_TYPE_VLAN
   * Actions:
      * - RTE_FLOW_ACTION_TYPE_QUEUE
      * - RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT
      * - RTE_FLOW_ACTION_TYPE_RSS (Dean make sure you check which RSS
rules are validated from the RSS testsuites which are currently under
review)
      * - RTE_FLOW_ACTION_TYPE_DROP
* Reviews needed:
   * Shell improvements:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34865
      * Patrick and Nick please see this series
   * RSS functions:
      * Partial review from Patrick. Looks pretty good so far except for
some syntax errors and we need to agree where the RSS functions should be
kept (in a dedicated file to be imported to testsuites, or just in the
testsuite class)
   * Smoke tests:
      * Paul will do a review
   * Old patches from UNH: Various patches need to be rebased and
resubmitted. Patrick needs to mark these as rework required on Patchwork
* ICMP filtering:
   * Looks good, can be merged
* Thomas submitted a patch about creating dirs on nodes
* Packet capture test suite:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20250331155800.449823-2-thoma=
s.wilks@arm.com/
   * Stephen has raised that dpdk-pdump is deprecated, and this testsuite
should be rewritten from dpdk-dumpcap which is its replacement
* There will be =E2=80=9Cbirds of a feather=E2=80=9D sessions at DPDK Pragu=
e for discussion
on various subjects, and it would be ideal if we can have a discussion for
DTS interested people

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting May 1, 2025

--00000000000072d81306339af6ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>#####################################################=
################</div><div>April 17, 2025<br>Attendees<br>1. Patrick Robb<b=
r>2. Paul Szczepanek<br>3. Luca Vizzarro<br>4. Aaron Conole<br>5. Manit Mah=
ajan</div><div><br></div><div>#############################################=
########################<br>Minutes</div><div><br></div><div>=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<br>*=
 DPDK Summit Prague is May 8-9<br>=C2=A0 =C2=A0* Patrick will share out his=
 presentation to the DTS group when its ready<br>=C2=A0 =C2=A0* Aaron has t=
he metrics he needs for his presentation</div><div><br></div><div>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status</div><div><br=
></div><div>---------------------------------------------------------------=
------<br>UNH-IOL Community Lab<br>* Intel Quickassist crypto tests: John M=
cNamara gave us a contact for this - Kai Ji (who is the quickassist maintai=
ner for DPDK). UNH still needs to pull together the performance metrics to =
share with Kai before we turn on the reporting for this test.<br>* Environm=
ent info for reports:<br>=C2=A0 =C2=A0* There was some discussion on Slack =
about what environment information is reported alongside tests, and what ca=
n be seen from the dashboard. Some basic info (distro, kernel, compiler ver=
sion) is included on the test report emails, and can also be found on the d=
ashboard like: <a href=3D"https://lab.dpdk.org/results/dashboard/test-matri=
x/105/">https://lab.dpdk.org/results/dashboard/test-matrix/105/</a><br>=C2=
=A0 =C2=A0* But, there are some improvements the lab can do, like extending=
 the amount of environment information included (so far Bruce suggested inc=
luding libc version) and also automatically updating the environment info m=
ore frequently<br>=C2=A0 =C2=A0* Manit is working on running a python scrip=
t on Jenkins every 48 hours which will collect system info for a test envir=
onment and update the respective environment=E2=80=99s fields in our databa=
se<br>=C2=A0 =C2=A0* We can also start inserting more environment info dire=
ctly into the top of the test log files which our dashboard hosts for downl=
oad/view on test results. This will be a follow up task.<br>* =C2=A0Baremet=
al updates:<br>=C2=A0 =C2=A0* Cody is working on updates to our testbeds, e=
ither on a software level or moving some NICs to new systems.<br>* UNH will=
 perform a Jenkins migration in the next couple weeks which will likely res=
ult in a few hours of lab downtime. This will be communicated ahead of time=
.<br>* DTS:<br>=C2=A0 =C2=A0* Dean is adding some new network cards, and ha=
s made some small improvements to our jenkins scripting which handles start=
ing the DTS execution and handling the output etc. We will be able to talk =
about this some at the DTS presentation at DPDK Prague.<br>* Patch depends-=
on support:<br>=C2=A0 =C2=A0* The patchwork server series is approved and w=
ill be in the next release<br>=C2=A0 =C2=A0* The associated git-pw patch is=
 also merged now: <a href=3D"https://github.com/getpatchwork/git-pw/pull/77=
">https://github.com/getpatchwork/git-pw/pull/77</a><br>=C2=A0 =C2=A0* So w=
e are on track to use this once the next patchwork patch is released and we=
 upgrade the <a href=3D"http://dpdk.org">dpdk.org</a> patchwork instance<br=
>=C2=A0 =C2=A0 =C2=A0 * Patrick should email Ali now to start this conversa=
tion<br><br></div><div>----------------------------------------------------=
-----------------</div><div>Intel Lab<br>* Patrick will have to schedule a =
sync with the people that touch these testbeds in the Summer to help them s=
etup the DTS framework on their systems.</div><div><br></div><div>---------=
------------------------------------------------------------<br>Github Acti=
ons<br>* None</div><div><br></div><div>------------------------------------=
---------------------------------<br>AWS<br>* They have been running their =
Build and Unit tests on x86 and ARM systems for 2 weeks, and sending test r=
eports to an external email (not the dpdk test report mailing list). They a=
re scheduled to begin sending the reports to the dpdk test report mailing l=
ist this week.</div><div><br></div><div>-----------------------------------=
----------------------------------<br>Loongarch Lab<br>* None</div><div><br=
></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DT=
S Improvements &amp; Test Development<br>* Thomas M has provided some feedb=
ack on the rte_flow testsuite, identifying what are the most common items a=
nd actions the rules tested should be based on: <a href=3D"https://inbox.dp=
dk.org/dev/5050697.TLnPLrj5Ze@thomas/">https://inbox.dpdk.org/dev/5050697.T=
LnPLrj5Ze@thomas/</a><br>=C2=A0 =C2=A0* =C2=A0Items: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 * - RTE_FLOW_ITEM_TYPE_ETH<br>=C2=A0 =C2=A0 =
=C2=A0 * - RTE_FLOW_ITEM_TYPE_IPV4 / RTE_FLOW_ITEM_TYPE_IPV6<br>=C2=A0 =C2=
=A0 =C2=A0 * - RTE_FLOW_ITEM_TYPE_UDP<br>=C2=A0 =C2=A0 =C2=A0 * - RTE_FLOW_=
ITEM_TYPE_TCP<br>=C2=A0 =C2=A0 =C2=A0 * - RTE_FLOW_ITEM_TYPE_VLAN<br>=C2=A0=
 =C2=A0* Actions:<br>=C2=A0 =C2=A0 =C2=A0 * - RTE_FLOW_ACTION_TYPE_QUEUE<br=
>=C2=A0 =C2=A0 =C2=A0 * - RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT<br>=C2=A0 =
=C2=A0 =C2=A0 * - RTE_FLOW_ACTION_TYPE_RSS (Dean make sure you check which =
RSS rules are validated from the RSS testsuites which are currently under r=
eview)<br>=C2=A0 =C2=A0 =C2=A0 * - RTE_FLOW_ACTION_TYPE_DROP<br>* Reviews n=
eeded:<br>=C2=A0 =C2=A0* Shell improvements: <a href=3D"https://patchwork.d=
pdk.org/project/dpdk/list/?series=3D34865">https://patchwork.dpdk.org/proje=
ct/dpdk/list/?series=3D34865</a><br>=C2=A0 =C2=A0 =C2=A0 * Patrick and Nick=
 please see this series<br>=C2=A0 =C2=A0* RSS functions:<br>=C2=A0 =C2=A0 =
=C2=A0 * Partial review from Patrick. Looks pretty good so far except for s=
ome syntax errors and we need to agree where the RSS functions should be ke=
pt (in a dedicated file to be imported to testsuites, or just in the testsu=
ite class)<br>=C2=A0 =C2=A0* Smoke tests:<br>=C2=A0 =C2=A0 =C2=A0 * Paul wi=
ll do a review<br>=C2=A0 =C2=A0* Old patches from UNH: Various patches need=
 to be rebased and resubmitted. Patrick needs to mark these as rework requi=
red on Patchwork<br>* ICMP filtering:<br>=C2=A0 =C2=A0* Looks good, can be =
merged<br>* Thomas submitted a patch about creating dirs on nodes<br>* Pack=
et capture test suite:<br>=C2=A0 =C2=A0* <a href=3D"https://patchwork.dpdk.=
org/project/dpdk/patch/20250331155800.449823-2-thomas.wilks@arm.com/">https=
://patchwork.dpdk.org/project/dpdk/patch/20250331155800.449823-2-thomas.wil=
ks@arm.com/</a><br>=C2=A0 =C2=A0* Stephen has raised that dpdk-pdump is dep=
recated, and this testsuite should be rewritten from dpdk-dumpcap which is =
its replacement<br>* There will be =E2=80=9Cbirds of a feather=E2=80=9D ses=
sions at DPDK Prague for discussion on various subjects, and it would be id=
eal if we can have a discussion for DTS interested people</div><div><br></d=
iv><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any o=
ther business<br>* Next Meeting May 1, 2025<br><br></div><div><br></div></d=
iv>

--00000000000072d81306339af6ea--
