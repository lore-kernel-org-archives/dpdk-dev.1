Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A0C35FF1
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B0B3402D9;
	Fri, 14 Mar 2025 00:36:19 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 29B6440289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 00:36:18 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-300f92661fcso2635053a91.3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741908977; x=1742513777; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4QGR4l+UPGrdlujOaxKXFVnznY4ARCwgROQmdMqoido=;
 b=OKGibR8LMN2DfNUE+BV9deZxNNachJ50M73OD177qZmjaOGy8RiYPiOMl68VUInJzz
 z6hyq2IobImsb5HoIp7GQrEP2LAUh0sVbrT45mI7XIAcNVWcWuzhLDAIpqIEgDKYcF89
 Px7lB1WcUAyv3oOv3S5buBfSdZ36TyvPNt1R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741908977; x=1742513777;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4QGR4l+UPGrdlujOaxKXFVnznY4ARCwgROQmdMqoido=;
 b=U9eZL7eCUqF39eXmPenbyNIaXWV10i9B2mDyi8uomULA6Yy8YbUJPLgyJoFDwqi684
 qkbwshJtcyMnDODyN/qho7A23PNHWeFjg3wRyHPdE2znhZcanlfVb8My7iCw4c8rlinQ
 M9JKpXc7C2kCu0YbrO3lRCUN7lkYX8SEmtLvhhXEnYGK/8VbF2yzJcnrsvDF/x2C6oqb
 70RQHNf3CtHH2i7KS03RY8l7qOQUh8lijNonCQP0kYhos+1J8bkpU030oQoefCkDWLnG
 Sj2j8s5HOZKVNhE3DYiizIXQf75OaZvWPc9leHIzHY33vRy96I8CXt5GRbe1HqmWS+aq
 Y5eA==
X-Gm-Message-State: AOJu0YwwRBAAAfS6f55ULDGd4kVYMi3nZpSIExSDssEAyTmfRW7qgSll
 bFttAFjN5xjXNXDKqFbDJphl+ybm8EQbuv4kqQMAEEiA3VK8HNZFWK58ngD0icqEd1OMLMG1lO1
 XN7B907FbzyChF2/lhiymjwRXW6KxYjOjktXsAvtYtMTxlBv6SWQfvA==
X-Gm-Gg: ASbGnctl4ExllEe+Zv4hcCI8keycOrba5ilY8h3jakUi308IMndmXhjUUpsoYqa9ryn
 UBNimBMANnBdTX2aFKamf6dTgMD8tyY03pOgu8ChqPCzLMWh5+ZUUncXtBOE7cNVbONc/RzvE2M
 8J7gesxS/o/z5NQHb4HentfW2p20/rqo15/i2DP23ic2DyM1xvAYIVzd4wStg=
X-Google-Smtp-Source: AGHT+IH07vhCCA0CLUvn3ODgtb+7V7GRrrxhcPzi0D8E8t51y99NScFdissPekF0vnIvQB08GKYbHBZWbnq3Zxx6MAs=
X-Received: by 2002:a17:90b:4c4a:b0:2ff:5a9d:9390 with SMTP id
 98e67ed59e1d1-30151c999d1mr485112a91.8.1741908976469; Thu, 13 Mar 2025
 16:36:16 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 19:32:34 -0400
X-Gm-Features: AQ5f1Jp6OTEZawV67UTNSPoGkV2Jnc6pMCXhKnAgnqSgj7Wy4mqzF-Aqe0hVt7I
Message-ID: <CAJvnSUC9RQVCHTki5y01tRwnnBTV-jy+_TnGJrd89ocOq5ossg@mail.gmail.com>
Subject: DTS WG Meeting Minutes - March 13, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c62646063041c996"
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

--000000000000c62646063041c996
Content-Type: text/plain; charset="UTF-8"

#####################################################################
March 13, 2025
Attendees
* Patrick Robb
* Paul Szczepanek
* Luca Vizzarro

#####################################################################
Minutes
General Discussion
* The DTS talk for Prague was accepted
   * CFP writeup:
https://docs.google.com/document/d/1Bb-JDAGzn5BjEvypafG0azQqhVBxXuF8klFZ1xiUnmo/edit?usp=sharing
* Roadmap check in:
   * TREX/TG support is pushed to next release, but Nick is working on this
currently
   * VF support has a V5 but will not be merged with this release.

=====================================================================
Patch discussions
* Per testsuite configuration:
   * 1 monolithic testsuite config file
   * Merged
* VF port support patch and new questions:
   * 1. Can we just destroy all VFs at DTS testrun setup?
   * 2. Does creating the max number of vfs make the framework too slow?
      * Patrick should look through the existing testplans and see what the
VF # requirements are (i.e. are they 1:1 with PFs in all cases)
      * Perhaps the testsuites themselves should act as the source of truth
for number of VFs created
* TREX perf TG support:
   * Some of the methods in the traffic_generator class are really for
capturing traffic generators - Nick is redefining the abstractions, has
stubbed out methods needed for perf TGs, and is implementing those in
trex.py
* Dean is refactoring some old testsuites:
   * Port stats check: done (Patrick still needs to review)
   * rx/tx_offload: Nearly done
* Ethertype:
   * Luca will no longer pick this up (Nick can do this during 25.07)
   * VLAN/TPID Filtering testcases for the ethertype testsuite cannot be
run on some devices in the UNH lab due to
https://bugs.dpdk.org/show_bug.cgi?id=1464
      * UNH guys will work with the Intel and Broadcom PMD maintainers to
resolve these filtering issues, and then circle back to this testsuite for
25.07
* Packet capturing improvements:
   * Current implementation provides arg for filtering. We have chosen to
not allow usage of packet filtering so far.
   * Luca wants to modify the sniffing so that it will run during the
entire testrun instead of starting and stopping - packets can be pulled
from the sniffer as needed.

=====================================================================
Bugzilla discussions
*

=====================================================================
Any other business
* Roadmap status:
https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=t.0
* Next meeting is Mar 13, 2025

--000000000000c62646063041c996
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>######################################################=
###############<br>March 13, 2025<br>Attendees<br>* Patrick Robb<br>* Paul =
Szczepanek<br>* Luca Vizzarro<br><br>######################################=
###############################<br>Minutes<br>General Discussion<br>* The D=
TS talk for Prague was accepted<br>=C2=A0 =C2=A0* CFP writeup: <a href=3D"h=
ttps://docs.google.com/document/d/1Bb-JDAGzn5BjEvypafG0azQqhVBxXuF8klFZ1xiU=
nmo/edit?usp=3Dsharing">https://docs.google.com/document/d/1Bb-JDAGzn5BjEvy=
pafG0azQqhVBxXuF8klFZ1xiUnmo/edit?usp=3Dsharing</a><br>* Roadmap check in:<=
br>=C2=A0 =C2=A0* TREX/TG support is pushed to next release, but Nick is wo=
rking on this currently<br>=C2=A0 =C2=A0* VF support has a V5 but will not =
be merged with this release.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>Patch discussions<br>* Per testsuite configuration:<b=
r>=C2=A0 =C2=A0* 1 monolithic testsuite config file<br>=C2=A0 =C2=A0* Merge=
d<br>* VF port support patch and new questions:<div>=C2=A0 =C2=A0* 1. Can w=
e just destroy all VFs at DTS testrun setup?<br>=C2=A0 =C2=A0* 2. Does crea=
ting the max number of vfs make the framework too slow?<br>=C2=A0 =C2=A0 =
=C2=A0 * Patrick should look through the existing testplans and see what th=
e VF # requirements are (i.e. are they 1:1 with PFs in all cases)<br>=C2=A0=
 =C2=A0 =C2=A0 * Perhaps the testsuites themselves should act as the source=
 of truth for number of VFs created<br>* TREX perf TG support:<br>=C2=A0 =
=C2=A0* Some of the methods in the traffic_generator class are really for c=
apturing traffic generators - Nick is redefining the abstractions, has stub=
bed out methods needed for perf TGs, and is implementing those in trex.py<b=
r>* Dean is refactoring some old testsuites:<br>=C2=A0 =C2=A0* Port stats c=
heck: done (Patrick still needs to review)<br>=C2=A0 =C2=A0* rx/tx_offload:=
 Nearly done<br>* Ethertype:<br>=C2=A0 =C2=A0* Luca will no longer pick thi=
s up (Nick can do this during 25.07)<br>=C2=A0 =C2=A0* VLAN/TPID Filtering =
testcases for the ethertype testsuite cannot be run on some devices in the =
UNH lab due to <a href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1464">htt=
ps://bugs.dpdk.org/show_bug.cgi?id=3D1464</a><br>=C2=A0 =C2=A0 =C2=A0 * UNH=
 guys will work with the Intel and Broadcom PMD maintainers to resolve thes=
e filtering issues, and then circle back to this testsuite for 25.07<br>* P=
acket capturing improvements:<br>=C2=A0 =C2=A0* Current implementation prov=
ides arg for filtering. We have chosen to not=C2=A0allow=C2=A0usage of pack=
et=C2=A0filtering so far.<br>=C2=A0 =C2=A0* Luca wants to modify the sniffi=
ng so that it will run during the entire testrun instead of starting and st=
opping - packets can be pulled from the sniffer as needed.<br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzilla discussions<br=
>* <br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>An=
y other business<br>* Roadmap status: <a href=3D"https://docs.google.com/do=
cument/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0">https=
://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/=
edit?tab=3Dt.0</a><br>* Next meeting is Mar 13, 2025<br></div></div>

--000000000000c62646063041c996--
