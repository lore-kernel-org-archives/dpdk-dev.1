Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F8D59D8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 19:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43697402F0;
	Fri, 12 Dec 2025 20:51:42 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 584844027D
 for <dev@dpdk.org>; Fri, 12 Dec 2025 20:51:41 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-298145fe27eso23029535ad.1
 for <dev@dpdk.org>; Fri, 12 Dec 2025 11:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765569100; x=1766173900; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=am+7Vkkf0oml7aXWS/j34p9toESEizOTzvv2uESaYVQ=;
 b=dwW5OZgCYdYp9kxoFyoYV7zap5EImvl59/vAhUv1J9DE/E9laj8zt/Y2nJ91KciNzA
 D1QdWqyEqpD/MXUH8yOAsyXqdRSzhBlrtu8etjbN+9w2zGx1rmdBbGkNcTLZNdO4n9wN
 5cULqxRcb4l1XfjvNKF9IcRrNlhBvChNtHf+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765569100; x=1766173900;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=am+7Vkkf0oml7aXWS/j34p9toESEizOTzvv2uESaYVQ=;
 b=haDzKN1gAWNtuqn3NI45C0rNICxfi/ZiN/uOAJrP2qUQ74yCRu1a8P+VKlzFN2UQ8W
 ZqLCZ6ld2RTpWZ8mQQl8rBPDgX+9AEiLSjiPFfPjtPfLkPobnTxFltny3tahirpLLt17
 2hWtpybBdqkm2erexLcftIYtNmNp2q6L1JoShxEzU1NckjFhgsUziyAZaLACNztZ/GYK
 zco3ybTOjDcKu8H3sAXqYQ7RgECdM+G7Pj73TV6siyKc7GLNQEV02KnAs1iW/GpqokJc
 kIdOb8WwfVgJ77QwFV2+zkPV0r7/LVpR0ppFK5c3JocLyT9JbhyzttOWkrYNb6q/3OLz
 3LzQ==
X-Gm-Message-State: AOJu0Yxvpnh5yEzyckGKYlM/o4ENYa3SqWM2WQ/Iy6rPz5E3tsYbIOjl
 Sq9VRv8lx90+Ogk8vMIuYak51bDxlnMufobPSIbUfL7Wa5Wxm8lspaThVFmk4MwfEjbTyfIkA8X
 dLDpNqaAUmAgv4z2E6TqM5jznmvfQtv66y6oJkUYta1F5/DPLbL1+qzqqiQ==
X-Gm-Gg: AY/fxX7nOcMf4eejgdJMnK3weAL3jCGeXFi1Hodc1drjLaCnF2PLw0021g7ByzPT7RQ
 6nsH14meVOF9n4cJtY9SfUnqG2bEMyYC+08MBPuWOqBggGwh90yEYYFquwsXRtEga/Wdkz5WU8L
 7TAOTKZXSFDRYIfRRsqel0VGDB6DwRG7/BAO5rPjoZUIXZweM+dISF9U/YmbnzRUqwOBBzlNR1l
 zTBa7P3jgP8Bm7xuY0fIhIENON2obQ66usUNnFEiNyUd2R379Y1qx/Ozt2p+A/ScGrnAU6wr1Zi
 ivvDui3Id6IChNVOk2Dz7Ls3tcl6
X-Google-Smtp-Source: AGHT+IHXeVYq/gnuzjxu+jcV+bM8ahOdGAYlTxy4VjqaWKN79BmnzFigOdSoKJtCuvTjGFajRT4AlmTwTNsGgrfwcfY=
X-Received: by 2002:a05:7022:3b8b:b0:119:e56b:c749 with SMTP id
 a92af1059eb24-11f34bc7971mr2603137c88.14.1765569100145; Fri, 12 Dec 2025
 11:51:40 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 12 Dec 2025 14:49:56 -0500
X-Gm-Features: AQt7F2rtTSDbUs2OUltDnVxg-TjsHgT86sJe5l_iw0rdNKUivz_MnYyWV_dfXuk
Message-ID: <CAJvnSUBnV5aPjrcysV0BS9c4H-j8rfvfAA=da7c9ZW0H5FmvCg@mail.gmail.com>
Subject: DTS WG Meeting Minutes - November 6, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000000a82d40645c69787"
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

--0000000000000a82d40645c69787
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

November 6, 2025

Attendees
* Patrick Robb
* Luca Vizzarro
* Andrew Bailey
* Paul Szczepanek

Minutes

General Discussion
* RC2 will release at the end of the week
* DPDK build fails if pydantic is installed, because there are pydantic
warnings with DTS:
   * idea A is to have pydantic installed and do a doc build before sending
a patch, then fix any warnings if they exist
      * If we want to test the DTS build in CI, we would have to install
the DTS dependencies and run a dpdk build
      * BaseConfig testsuite configuration is causing a build failure this
week, as it is not loaded except for at runtime (so, not the doc build)
   * No, we don=E2=80=99t have any new ideas.
* We got feedback that docs need clarification regarding the API vs
Framework usage.
   * Realistically, given the RC timeline, we will need to update docs
noting that the API is in a transitionary period
   * Otherwise, keep plugging away at removing framework imports and then
this problem will be solved.

Patch discussions
* Mbuf fast release testcase / tx_offload:
   * Merged
* add test case docstring checks to format script
   * Dean is updating this series
* doc: add test case docstring example to dts rst
   * Patrick to merge the first patch. The second patch is superseded and
won=E2=80=99t be merged.
* Virtio:
   * We are transmitting 100 packets to the SUT (should go from physical
nic to virtio frontend to vhost backend, then back through to the TG again
for sniffing) but we are seeing ~350 packets forwarded in the vhost backend
which seems wrong.
      * Paul has suggested that we check that the extra packets aren=E2=80=
=99t
coming from another source other than the TG scapy.
* [v2] dts: testpmd link check on port start
   * Andrew reviewing. Can be applied ASAP.
* Single_core_fwd_perf:
   * New version sent. Need to resolve a build issue with the Intel CI Lab.
   * V6 just addresses some nits from Luca and Andrew
* API:
   * Artifact series is merged
   * Further changes:
* RSS:
   * Patrick has tested
   * Imports have to be updated for /api/, but this can be done by Patrick
at merge time if no further change are required.
   * Patrick to merge
* QinQ:
   * Dean has tested and it is working
   * Patrick will also do a test, and a final review
   * TCI:
      * During the 26.03 release, Dean to add a secondary part to this
testsuite that not only checks that packets are modified correctly by vlan
and qinq stripping, but that the TCI and OUTER_TCI fields are being written
to correctly.

Bugzilla discussions
* None

Any other business
* Next meeting is Nov 20, 2025

--0000000000000a82d40645c69787
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">November 6, 2025<div><br>Attendees<br>* Patrick Robb<br>* =
Luca Vizzarro<br>* Andrew Bailey<br>* Paul Szczepanek<br><br>Minutes<br><br=
>General Discussion<br>* RC2 will release at the end of the week<br>* DPDK =
build fails if pydantic is installed, because there are pydantic warnings w=
ith DTS:<br>=C2=A0 =C2=A0* idea A is to have pydantic installed and do a do=
c build before sending a patch, then fix any warnings if they exist<br>=C2=
=A0 =C2=A0 =C2=A0 * If we want to test the DTS build in CI, we would have t=
o install the DTS dependencies and run a dpdk build<br>=C2=A0 =C2=A0 =C2=A0=
 * BaseConfig testsuite configuration is causing a build failure this week,=
 as it is not loaded except for at runtime (so, not the doc build)<br>=C2=
=A0 =C2=A0* No, we don=E2=80=99t have any new ideas.<br>* We got feedback t=
hat docs need clarification regarding the API vs Framework usage.<br>=C2=A0=
 =C2=A0* Realistically, given the RC timeline, we will need to update docs =
noting that the API is in a transitionary period<br>=C2=A0 =C2=A0* Otherwis=
e, keep plugging away at removing framework imports and then this problem w=
ill be solved.<br><br>Patch discussions<br>* Mbuf fast release testcase / t=
x_offload:<br>=C2=A0 =C2=A0* Merged<br>* add test case docstring checks to =
format script<br>=C2=A0 =C2=A0* Dean is updating this series<br>* doc: add =
test case docstring example to dts rst<br>=C2=A0 =C2=A0* Patrick to merge t=
he first patch. The second patch is superseded and won=E2=80=99t be merged.=
<br>* Virtio:<br>=C2=A0 =C2=A0* We are transmitting 100 packets to the SUT =
(should go from physical nic to virtio frontend to vhost backend, then back=
 through to the TG again for sniffing) but we are seeing ~350 packets forwa=
rded in the vhost backend which seems wrong.<br>=C2=A0 =C2=A0 =C2=A0 * Paul=
 has suggested that we check that the extra packets aren=E2=80=99t coming f=
rom another source other than the TG scapy.<br>* [v2] dts: testpmd link che=
ck on port start<br>=C2=A0 =C2=A0* Andrew reviewing. Can be applied ASAP.<b=
r>* Single_core_fwd_perf:<br>=C2=A0 =C2=A0* New version sent. Need to resol=
ve a build issue with the Intel CI Lab.<br>=C2=A0 =C2=A0* V6 just addresses=
 some nits from Luca and Andrew<br>* API:<br>=C2=A0 =C2=A0* Artifact series=
 is merged<br>=C2=A0 =C2=A0* Further changes: <br>* RSS:<br>=C2=A0 =C2=A0* =
Patrick has tested<br>=C2=A0 =C2=A0* Imports have to be updated for /api/, =
but this can be done by Patrick at merge time if no further change are requ=
ired.<br>=C2=A0 =C2=A0* Patrick to merge<br>* QinQ:<br>=C2=A0 =C2=A0* Dean =
has tested and it is working<br>=C2=A0 =C2=A0* Patrick will also do a test,=
 and a final review<br>=C2=A0 =C2=A0* TCI:<br>=C2=A0 =C2=A0 =C2=A0 * During=
 the 26.03 release, Dean to add a secondary part to this testsuite that not=
 only checks that packets are modified correctly by vlan and qinq stripping=
, but that the TCI and OUTER_TCI fields are being written to correctly.<br>=
<br>Bugzilla discussions<br>* None<br><br>Any other business<br>* Next meet=
ing is Nov 20, 2025<br></div></div>

--0000000000000a82d40645c69787--
