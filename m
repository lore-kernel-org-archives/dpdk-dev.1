Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D9C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 22:25:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA80340B8F;
	Sat, 19 Jul 2025 00:25:09 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id AFCC4402B5
 for <dev@dpdk.org>; Sat, 19 Jul 2025 00:25:08 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b3bad2f99f5so2154161a12.1
 for <dev@dpdk.org>; Fri, 18 Jul 2025 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752877507; x=1753482307; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=afG+Lb8//iIIQuKOVmfPTR8wCEVvxlMfiHTEImWolQA=;
 b=W8xc6c0BxSc/MaelGhv3X/2WUL33EPCYjzytC6SmcyLgv+TIiGCz5qhC2YpdZwr96g
 LpyuwQYYUi3Til9MuIwChzIo4bFJ+Nnt5ANFk60EtUFdkp0X94nqcyNHs/Ob26StcwG2
 2gxJhrKk1OJ5kJesdPyHT/vkbuQz6gxm3fcMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752877507; x=1753482307;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=afG+Lb8//iIIQuKOVmfPTR8wCEVvxlMfiHTEImWolQA=;
 b=tBylPW56KUwoBHJvO4ZXPfxisyDzDYLoCA3E8AC+nd6S9jT/9jcyRRzmjl6rB2mHql
 QDfeYkt1nMct5KCWUsvvLSiF8WY53aE1rC2Xy0rdeQ6MEwALF3/gQf+K2DFijATZUMif
 wut1MWdlv0qMTfkRKrwKV0Yd+vQDIIGCXZ6LCkk/Gqzpcbmh/mvqrgDiixNd6FjSgxFO
 1YnFZl0MbvxKhQvsq+0wZhbX7j9CcikgAC1onhOCs7NPjA4rotnnZ2UOtLXOXHId+0Zj
 Se1HmgXLGBnZW2o/JIPA6mWIj30osMn9wsogpC0scVedny32wx05GBReEMZo8vfldng6
 gPUA==
X-Gm-Message-State: AOJu0YwVoLGMnAcmQzIcH23+ftrA/NCSmALfmk4A/q3LaElUPWGU23MB
 6f4lbz3KodTrS6w43UT0VJgbjaf3NZYQ9fJLwssNl8SzV+MpCPvNVCYSHJTmIyyRh8/z2mlAUTO
 qoQDvfO2boMnXDIqqIL5EiXcAccC2GjmAt2HwyoDXgEfd5Cew0xKiEP8=
X-Gm-Gg: ASbGncuyQ5zOU4cTlJqG29tEx7WpHkdbMj3o8i1PjyMIp+g9TRGCnrHHHxyDt0far/c
 vTpeK7nPjqBiqxX9sAfKQYgXM4MKOpMzB+F/oKy7dNVfO2dLNbdhTUEdKVr+1Z0Rqdcsez4zt09
 5MNd7ntJ0cBrhRNXWYXufyRzVakX/qM3i0nQdCxsMJgc5Fo3qdwQKtq5m0d1syEGIxadyNUJNAj
 9plcKe5SHna/iheWjrLUQ==
X-Google-Smtp-Source: AGHT+IG72q79FrtDDfE5e7Pmp10gT1l7ZMqgCDxyJcwdcgbwCnf7xnV4ZWy9f3yFAXG6F5M0Upd97fu9wurBMWaR/Wo=
X-Received: by 2002:a17:90b:5203:b0:315:f6d6:d29c with SMTP id
 98e67ed59e1d1-31cc045a515mr8426232a91.15.1752877507315; Fri, 18 Jul 2025
 15:25:07 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 18 Jul 2025 18:19:13 -0400
X-Gm-Features: Ac12FXzOx94l_VWgzz-6CErhL-AeZSIKYjV0sCNfBrxOek4PYGY55KP84B9b9pg
Message-ID: <CAJvnSUAjL7kpnn3nx-fdf=QBD4OZ5r83wc=5ErE5Cs1R7+Hfdw@mail.gmail.com>
Subject: DTS WG Meeting Minutes - July 17, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org, Dean Marx <dmarx@iol.unh.edu>, 
 Paul Szczepanek <Paul.Szczepanek@arm.com>,
 Luca Vizzarro <Luca.Vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="00000000000028a530063a3b9938"
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

--00000000000028a530063a3b9938
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
July 17, 2025
Attendees
* Patrick Robb
* Manit Mahajan
* Dean Marx
* Luca Vizzarro
* Paul Szczepanek

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* 25.07 will be released very soon, and then we are onto DTS development
for 25.11:
   * DTS Bugzilla:
https://bugs.dpdk.org/buglist.cgi?quicksearch=3Dcomponent%3Adts&list_id=3D9=
444
   * Patchwork:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D&submitter=3D&state=
=3D&q=3Ddts&archive=3D&delegate=3D
* DPDK Santa Clara is cancelled
   * No significant effect on DTS.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* Merged since last meeting:
   * README and dts.rst update:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35724&state=3D*
* Current development:
   * Single_core_forwarding perf test:
      * Moved to 25.11
   * QinQ Testsuite:
      * Dean is working with Bruce to standardize VLAN Strip and QinQ Strip
functions in DPDK (along with how we test them in DTS)
      * Where we currently are for tag stripping testcases:
      * Vlan Strip ON and QinQ Strip OFF:
1. Single VLAN:
   Expected result: VLAN Stripped
2. Double VLAN:
   Expected result: Should strip outer VLAN
3. Single 0x88a8 tag only:
   Expected result: 0x88a8 tag stripped
4. Single VLAN + 1 0x88a8 tag:
   Expected result: 0x88a8 tag stripped, inner VLAN untouched
     * Vlan Strip ON and QinQ Strip ON:
1. Single VLAN:
   Expected result: VLAN stripped
2. Double VLAN:
   Expected result: Unknown (Outer VLAN stripped?)
3. Single 0x88a8 tag only:
   Expected result: Unknown (0x88a8 tag stripped?)
4. Single VLAN + 1 0x88a8 tag:
   Expected result: Unknown (0x88a8 tag stripped and VLAN tag stripped?)
     * Current PMD support for stripping:
Intel: Support VLAN Strip, QinQ Strip
Mellanox: Supports VLAN Strip
Broadcom: According to docs, supports VLAN Strip, but when you try to
enable it, ethdev reports it is unsupported. We emailed Ajit (brcm
maintainer) yesterday asking about this and he says it should be supported
and he will check.
   * Artifacts/file management
      * Patch nearly complete
      * Adding an Artifact class that can contain any file, and can be SFTP
copied to any node
   * RSS test suite
      * Thomas Wilks is rebasing
      * Testcases are not working currently:
         * Thomas says the hashing algorithm is consistent on Intel, but
inconsistent on Mellanox
         * The testsuite uses a testpmd command to find supported
algorithms, but it appears that this is not returning the true supported
list (is just returning default each time)
   * Patrick Robb and luca.vizzarro@arm.comto review change requested
patches on the DTS project next meeting to ensure that in setting aside
pending patches for 25.07 we have not dropped anything

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
* Review bugzilla tickets:
   *
https://bugs.dpdk.org/buglist.cgi?quicksearch=3Dcomponent%3Adts&list_id=3D9=
444
   * Marked a number of tickets as resolved
* Tickets to be created after the meeting:
   * Patrick Robb make a ticket for reviewing which testsuites actually
require @requires_2_link
   * Patrick Robb Maybe make a ticket about setting up single dual port
loopback topology
      * Could be as simple as adding a clarifying comment on how to setup
DTS for this =E2=80=9Ctopology=E2=80=9D
   * Patrick Robb Remove optional poetry docs build option

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* 25.11 Roadmap:
   * Some items we would like to cover are:
      * VM tests:
         * Sriov with VF passthrough
         * vHost Tests
      * DTS API
         * Paul has sent a design description (a module of stateless
functions) to the mailing list. Most of it comes from ctx.
         * He is looking for responses to his proposal.
         * Paul asked if it is okay that his implementation will force only
1 testpmd shell at a time, and the group confirmed that this is okay.
      * Packet Forwarding Performance tests:
         * Mostly complete, should be done early in the release
      * Cryptodev tests
      * Will add more items at next week's ci meeting.
* Next meeting is August 1, 2025

--00000000000028a530063a3b9938
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>July 17, 2025<br>Attendees<br>* Patrick Robb<br>* Manit Maha=
jan<br>* Dean Marx<br>* Luca Vizzarro<br>* Paul Szczepanek<br><br>#########=
############################################################<br>Minutes<br>=
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General =
Discussion<br>* 25.07 will be released very soon, and then we are onto DTS =
development for 25.11:<br>=C2=A0 =C2=A0* DTS Bugzilla: <a href=3D"https://b=
ugs.dpdk.org/buglist.cgi?quicksearch=3Dcomponent%3Adts&amp;list_id=3D9444">=
https://bugs.dpdk.org/buglist.cgi?quicksearch=3Dcomponent%3Adts&amp;list_id=
=3D9444</a><br>=C2=A0 =C2=A0* Patchwork: <a href=3D"https://patchwork.dpdk.=
org/project/dpdk/list/?series=3D&amp;submitter=3D&amp;state=3D&amp;q=3Ddts&=
amp;archive=3D&amp;delegate=3D">https://patchwork.dpdk.org/project/dpdk/lis=
t/?series=3D&amp;submitter=3D&amp;state=3D&amp;q=3Ddts&amp;archive=3D&amp;d=
elegate=3D</a><br>* DPDK Santa Clara is cancelled<br>=C2=A0 =C2=A0* No sign=
ificant effect on DTS. <br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>Patch discussions<br>* Merged since last meeting:<br>=C2=
=A0 =C2=A0* README and dts.rst update: <a href=3D"https://patchwork.dpdk.or=
g/project/dpdk/list/?series=3D35724&amp;state=3D*">https://patchwork.dpdk.o=
rg/project/dpdk/list/?series=3D35724&amp;state=3D*</a><br>* Current develop=
ment:<br>=C2=A0 =C2=A0* Single_core_forwarding perf test:<br>=C2=A0 =C2=A0 =
=C2=A0 * Moved to 25.11<br>=C2=A0 =C2=A0* QinQ Testsuite:<br>=C2=A0 =C2=A0 =
=C2=A0 * Dean is working with Bruce to standardize VLAN Strip and QinQ Stri=
p functions in DPDK (along with how we test them in DTS)<br>=C2=A0 =C2=A0 =
=C2=A0 * Where we currently are for tag stripping testcases:<br>=C2=A0 =C2=
=A0 =C2=A0 * Vlan Strip ON and QinQ Strip OFF:<br>		1. Single VLAN:<br>		 =
=C2=A0 =C2=A0Expected result: VLAN Stripped<br>		2. Double VLAN:<br>		 =C2=
=A0 =C2=A0Expected result: Should strip outer VLAN<br>		3. Single 0x88a8 ta=
g only:<br>		 =C2=A0 =C2=A0Expected result: 0x88a8 tag stripped<br>		4. Sin=
gle VLAN + 1 0x88a8 tag:<br>		 =C2=A0 =C2=A0Expected result: 0x88a8 tag str=
ipped, inner VLAN untouched<br>		 =C2=A0 =C2=A0 =C2=A0* Vlan Strip ON and Q=
inQ Strip ON:<br>		1. Single VLAN:<br>		 =C2=A0 =C2=A0Expected result: VLAN=
 stripped<br>		2. Double VLAN:<br>		 =C2=A0 =C2=A0Expected result: Unknown =
(Outer VLAN stripped?)<br>		3. Single 0x88a8 tag only:<br>		 =C2=A0 =C2=A0E=
xpected result: Unknown (0x88a8 tag stripped?)<br>		4. Single VLAN + 1 0x88=
a8 tag:<br>		 =C2=A0 =C2=A0Expected result: Unknown (0x88a8 tag stripped an=
d VLAN tag stripped?)<br>		 =C2=A0 =C2=A0 =C2=A0* Current PMD support for s=
tripping:<br>		Intel: Support VLAN Strip, QinQ Strip<br>		Mellanox: Support=
s VLAN Strip<br>		Broadcom: According to docs, supports VLAN Strip, but whe=
n you try to enable it, ethdev reports it is unsupported. We emailed Ajit (=
brcm maintainer) yesterday 	asking about this and he says it should be supp=
orted and he will check.<br>=C2=A0 =C2=A0* Artifacts/file management<br>=C2=
=A0 =C2=A0 =C2=A0 * Patch nearly complete<br>=C2=A0 =C2=A0 =C2=A0 * Adding =
an Artifact class that can contain any file, and can be SFTP copied to any =
node<br>=C2=A0 =C2=A0* RSS test suite<br>=C2=A0 =C2=A0 =C2=A0 * Thomas Wilk=
s is rebasing<br>=C2=A0 =C2=A0 =C2=A0 * Testcases are not working currently=
:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Thomas says the hashing algorithm =
is consistent on Intel, but inconsistent on Mellanox<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* The testsuite uses a testpmd command to find supported a=
lgorithms, but it appears that this is not returning the true supported lis=
t (is just returning default each time)<br>=C2=A0 =C2=A0* Patrick Robb and =
luca.vizzarro@arm.comto review change requested patches on the DTS project =
next meeting to ensure that in setting aside pending patches for 25.07 we h=
ave not dropped anything<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>Bugzilla discussions<br>* Review bugzilla tickets:<br>=
=C2=A0 =C2=A0* <a href=3D"https://bugs.dpdk.org/buglist.cgi?quicksearch=3Dc=
omponent%3Adts&amp;list_id=3D9444">https://bugs.dpdk.org/buglist.cgi?quicks=
earch=3Dcomponent%3Adts&amp;list_id=3D9444</a><br>=C2=A0 =C2=A0* Marked a n=
umber of tickets as resolved<br>* Tickets to be created after the meeting:<=
br>=C2=A0 =C2=A0* Patrick Robb make a ticket for reviewing which testsuites=
 actually require @requires_2_link<br>=C2=A0 =C2=A0* Patrick Robb Maybe mak=
e a ticket about setting up single dual port loopback topology<br>=C2=A0 =
=C2=A0 =C2=A0 * Could be as simple as adding a clarifying comment on how to=
 setup DTS for this =E2=80=9Ctopology=E2=80=9D<br>=C2=A0 =C2=A0* Patrick Ro=
bb Remove optional poetry docs build option<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* 25.11 Roadmap:=
<br>=C2=A0 =C2=A0* Some items we would like to cover are:<br>=C2=A0 =C2=A0 =
=C2=A0 * VM tests:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Sriov with VF pas=
sthrough<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* vHost Tests<br>=C2=A0 =C2=
=A0 =C2=A0 * DTS API<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Paul has sent a=
 design description (a module of stateless functions) to the mailing list. =
Most of it comes from ctx.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* He is loo=
king for responses to his proposal.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =
Paul asked if it is okay that his implementation will force only 1 testpmd =
shell at a time, and the group confirmed that this is okay.<br>=C2=A0 =C2=
=A0 =C2=A0 * Packet Forwarding Performance tests:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* Mostly complete, should be done early in the release<br>=C2=
=A0 =C2=A0 =C2=A0 * Cryptodev tests<br>=C2=A0 =C2=A0 =C2=A0 * Will add more=
 items at next week&#39;s ci meeting.<br>* Next meeting is August 1, 2025<b=
r></div>

--00000000000028a530063a3b9938--
