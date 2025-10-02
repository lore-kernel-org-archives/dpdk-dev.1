Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D18CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 20:00:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C30C74042E;
	Thu,  2 Oct 2025 22:00:13 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 2C48F402A6
 for <dev@dpdk.org>; Thu,  2 Oct 2025 22:00:12 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-26d0fbe238bso9305375ad.3
 for <dev@dpdk.org>; Thu, 02 Oct 2025 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759435211; x=1760040011; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KcpoUSmwXi1o7OkmTitq678Lhs1d+CcaVJqJMS96kNk=;
 b=HjKZ/M0FnnTXdpPdWxdFD1ddBSg8f4J2y6YucT7DVfZ4OWnm+pmXMcqs/C8skZjFXx
 Y/z9jFwMxV6QJNTaNUx3zyr8cJOPf5G7Hwu36SnSfbGP7P3dLJSqImKgrdr6Vg4TRERE
 GYkLp/10VFZBT2WpPxalCYTud60apEg2FYD5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435211; x=1760040011;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KcpoUSmwXi1o7OkmTitq678Lhs1d+CcaVJqJMS96kNk=;
 b=QnV9nHgdUZAR1Muw4FsxHJzflNGePJ5pJms1ixcq7gZ4VJXbXYAnVtaXlNyYPWAWSg
 ebswH8mOgFE0gzzhLDzrtEF3lvbNTaONTYu126/gZDfczjFYD614JHHID5rEL8RIVIAm
 naxRaQCxQi3kGukZjyshE7oXLlG5/6gEJT6goGyRxJcgH1yegjAAL2TGRnXrwTrsTItq
 5l9uc2xuWbSviOOcHBo/SraFJ4m3ObSJW5IUAy5LwU61yHBOIov0pTM0aFm1/YtSqCO1
 lahyprNO+zVSmu6ihl9bOuwZioHJh12z2l+43GnQ3xnKlbWTboBmYh2VkANVtuJ4astp
 5U+g==
X-Gm-Message-State: AOJu0YxBJ1L9aD9b9pK3zoOeCmAmFZzs073M04jvHZJPqZLVYfl1umZU
 DowmA1i+08tM7Pj9lfpwvccBySxsn4qV6kJc5oDG6Om31Z8mXC4USIf/SZ15DofrgoHG7slK/x2
 otLYrLmoqyXW2yDalJ08tGSxIurT9w+CnNBEJgy6Qz59xdKXYLwDwQ74A4w==
X-Gm-Gg: ASbGnctcNkkQeaxyk0PLKwV77RHVOSNugtowAJqH+5+3LOj8yFkAcTnRwZfiUIkeXMt
 6/GbLxAJ2vPgoSIXAQFttH2CsU/saYCMghHA72eq7lUzZxplMYpiCrMIFgPJSDUPC139Nl/beJA
 H79bYWrKWGJNnX6Hebc/Gm6IJzF1v3uLYhvZyZT3iJ6yDbC/y8j51ccuBRBgdR7a2v3OTgiL4K+
 tlb8Hd/Y68CfycPD0TA6LT78/2w30MPWWvlFPNfQT4ximGbJ2hp6McDhSYEDMPU
X-Google-Smtp-Source: AGHT+IHZTKhrLq8TC9m0XcwOkdi3Ih2Bpv+XUGwGA2hG+xhcti2Li1ZynfjzdoxIWaDKFFeqoPbiFQW72x9eQmZ2TIo=
X-Received: by 2002:a17:903:4b48:b0:288:e46d:b318 with SMTP id
 d9443c01a7336-28e9a65634emr5132775ad.40.1759435209573; Thu, 02 Oct 2025
 13:00:09 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 2 Oct 2025 15:59:37 -0400
X-Gm-Features: AS18NWANUIjlp6JxRswlUvN5eORKWfw86Jk8WBJlj2tt9cZzRtUfZPhh8YF5XJw
Message-ID: <CAJvnSUAjhhRvkBgDQLzAre8QYGg+u91Q+zvkQnh9yGa3=Kyd3w@mail.gmail.com>
Subject: Community CI Meeting Minutes - October 2, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000ac1a570640326e68"
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

--000000000000ac1a570640326e68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
October 2, 2025
Attendees
1. Patrick Robb
2. Luca Vizzarro
3. Paul Szczepanek
4. Andrew Bailey
5. Aaron Conole

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* There is a new member of the DTS slack, Zack Vonler, who is implementing
a new PMD and would like to use DTS to validate his new PMD is conforming
to DPDK

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
AWS Lab
* None

---------------------------------------------------------------------
UNH-IOL Community Lab
* PW-CI: Working on standing up an instance of pw-ci, so we can start to
poll for some patches and better understand if this can be used in our lab
   * Adam and Patrick still need to stand up a working instance of the
current (bash) pw-ci
   * Aaron has noted that he wants to decouple the components used for
entering results into the DB and the component involved in sending reports
   * Aaron can help if we are stuck with the setup.
      * We can add some additional documentation based on this (if indeed
there is missing info)
* Windows server 2025:
   * We are moving over the 3 compiler toolchains and automated builds to
the new Windows server VM
* Missing stdin on some log files:
   * Addin stdin to log files where that is missing (i.e. make sure to
capture meson args used in setup)
* Mbuf_fast_free
   * Patrick needs to make sure we are able to add in the manual enable of
mbuf fast release when the default behavior (changing from default on to
default off) is modified in dpdk main

---------------------------------------------------------------------
Intel Lab
* Sadashiva Rao is a new contact that we should CC on discussions relating
to the Intel lab.
Github Actions Robot
* Coderabbit feedback:
   * It is a mixed bag. Sometimes it can catch real issues, and other times
it makes suggestions that are just nitpicking, and other times the feedback
is just =E2=80=9Cnonsense.=E2=80=9D There is some discussion about moving t=
o a different
tool
   * David submitted a patch in an attempt to tailor it further
      * It is tailored through an entry YAML
      * If the project is moving away from coderabbit anyways, it=E2=80=99s=
 unclear
whether it makes sense to add a coderabbit artifact to the tree.
   * Sourcery was not very useful
* Cirrus CI:
   * On David=E2=80=99s fork, he used it for freebsd build testing
* Aaron is working on porting the pw-ci project from bash scripts to Python

---------------------------------------------------------------------
Loongson Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Tx offloads
   * Is reviewed by Luca
   * V6 is out
   * Patrick and Andrew to look at this together.
* Single core forwarding test
   * V4 is sent out
   * There is a blocker for enabling mbuf_fast_free here, due to a
dependency on the tx_offloads series.
      * When that series is merged, I will rebase, send a v5 with
mbuf_fast_free enabled
   * Most of Luca=E2=80=99s comments from the V3 should be resolved.
   * Default params: I think that we should encourage testsuite writers to
always include defaults for the testsuite specific params, and allow users
to override those values from tests_config.yaml as needed.
   * Right now, after running all packet combinations, we print a big table
at the end in the console. But, we are not writing this to a file in
/output/single_core_forwarding. Patrick to add some structured file here to
store the latest MPPS results.
* RSS
   * For debugging, Dean is printing the predicted table, the RETA table
returned by testpmd, and all the packet/queue combos to understand whether
the testsuite is failing due to the mellanox PMD/device or because of our
python code
* Virtio/Vhost
   * Dean is writing a v2 based on Luca=E2=80=99s comments
   * Patrick needs to do a review
* QinQ:
   * We still need to collect the Broadcom results
   * Should be able to merge soon after sharing those out

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
   * Next Meeting is Oct 16, 2025
   * DPDK RC1 is out next week, so let=E2=80=99s keep it up on reviews :)

--000000000000ac1a570640326e68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>October 2, 2025<br>Attendees<br>1. Patrick Robb<br>2. Luca V=
izzarro<br>3. Paul Szczepanek<br>4. Andrew Bailey<br>5. Aaron Conole<br><br=
>#####################################################################<br>M=
inutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>General Announcements<br>* There is a new member of the DTS slack, Zack Vo=
nler, who is implementing a new PMD and would like to use DTS to validate h=
is new PMD is conforming to DPDK<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status<br><br>------------------------------=
---------------------------------------<br>AWS Lab<br>* None<br><br>-------=
--------------------------------------------------------------<br>UNH-IOL C=
ommunity Lab<br>* PW-CI: Working on standing up an instance of pw-ci, so we=
 can start to poll for some patches and better understand if this can be us=
ed in our lab<br>=C2=A0 =C2=A0* Adam and Patrick still need to stand up a w=
orking instance of the current (bash) pw-ci<br>=C2=A0 =C2=A0* Aaron has not=
ed that he wants to decouple the components used for entering results into =
the DB and the component involved in sending reports<br>=C2=A0 =C2=A0* Aaro=
n can help if we are stuck with the setup.<br>=C2=A0 =C2=A0 =C2=A0 * We can=
 add some additional documentation based on this (if indeed there is missin=
g info)<br>* Windows server 2025:<br>=C2=A0 =C2=A0* We are moving over the =
3 compiler toolchains and automated builds to the new Windows server VM<br>=
* Missing stdin on some log files:<br>=C2=A0 =C2=A0* Addin stdin to log fil=
es where that is missing (i.e. make sure to capture meson args used in setu=
p)<br>* Mbuf_fast_free<br>=C2=A0 =C2=A0* Patrick needs to make sure we are =
able to add in the manual enable of mbuf fast release when the default beha=
vior (changing from default on to default off) is modified in dpdk main<br>=
=C2=A0 =C2=A0<br>----------------------------------------------------------=
-----------<br>Intel Lab<br>* Sadashiva Rao is a new contact that we should=
 CC on discussions relating to the Intel lab.<br>Github Actions Robot<br>* =
Coderabbit feedback:<br>=C2=A0 =C2=A0* It is a mixed bag. Sometimes it can =
catch real issues, and other times it makes suggestions that are just nitpi=
cking, and other times the feedback is just =E2=80=9Cnonsense.=E2=80=9D The=
re is some discussion about moving to a different tool<br>=C2=A0 =C2=A0* Da=
vid submitted a patch in an attempt to tailor it further<br>=C2=A0 =C2=A0 =
=C2=A0 * It is tailored through an entry YAML<br>=C2=A0 =C2=A0 =C2=A0 * If =
the project is moving away from coderabbit anyways, it=E2=80=99s unclear wh=
ether it makes sense to add a coderabbit artifact to the tree.<br>=C2=A0 =
=C2=A0* Sourcery was not very useful<br>* Cirrus CI:<br>=C2=A0 =C2=A0* On D=
avid=E2=80=99s fork, he used it for freebsd build testing<br>* Aaron is wor=
king on porting the pw-ci project from bash scripts to Python<br><br>------=
---------------------------------------------------------------<br>Loongson=
 Lab<br>* None<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>DTS Improvements &amp; Test Development<br>* Tx offloads<br>=C2=
=A0 =C2=A0* Is reviewed by Luca<br>=C2=A0 =C2=A0* V6 is out<br>=C2=A0 =C2=
=A0* Patrick and Andrew to look at this together.<br>* Single core forwardi=
ng test<br>=C2=A0 =C2=A0* V4 is sent out<br>=C2=A0 =C2=A0* There is a block=
er for enabling mbuf_fast_free here, due to a dependency on the tx_offloads=
 series.<br>=C2=A0 =C2=A0 =C2=A0 * When that series is merged, I will rebas=
e, send a v5 with mbuf_fast_free enabled<br>=C2=A0 =C2=A0* Most of Luca=E2=
=80=99s comments from the V3 should be resolved.<br>=C2=A0 =C2=A0* Default =
params: I think that we should encourage testsuite writers to always includ=
e defaults for the testsuite specific params, and allow users to override t=
hose values from tests_config.yaml as needed.<br>=C2=A0 =C2=A0* Right now, =
after running all packet combinations, we print a big table at the end in t=
he console. But, we are not writing this to a file in /output/single_core_f=
orwarding. Patrick to add some structured file here to store the latest MPP=
S results.<br>* RSS<br>=C2=A0 =C2=A0* For debugging, Dean is printing the p=
redicted table, the RETA table returned by testpmd, and all the packet/queu=
e combos to understand whether the testsuite is failing due to the mellanox=
 PMD/device or because of our python code<br>* Virtio/Vhost<br>=C2=A0 =C2=
=A0* Dean is writing a v2 based on Luca=E2=80=99s comments<br>=C2=A0 =C2=A0=
* Patrick needs to do a review<br>* QinQ:<br>=C2=A0 =C2=A0* We still need t=
o collect the Broadcom results<br>=C2=A0 =C2=A0* Should be able to merge so=
on after sharing those out<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>Any other business<br>=C2=A0 =C2=A0* Next Meeting is Oct 16, 2025<br>=C2=
=A0 =C2=A0* DPDK RC1 is out next week, so let=E2=80=99s keep it up on revie=
ws :)</div>

--000000000000ac1a570640326e68--
