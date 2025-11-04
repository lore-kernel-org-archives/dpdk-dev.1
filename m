Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3DACCFA03
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 03:35:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1F53402EE;
	Tue,  4 Nov 2025 04:35:31 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id EF2C9402ED
 for <dev@dpdk.org>; Tue,  4 Nov 2025 04:35:29 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-294fc62d7f4so47426615ad.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 19:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762227329; x=1762832129; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OYwswrq1Wb1lxRTBvxJzP5wsXyRZGQHxwMlpPnsAzmM=;
 b=MvLBeOL8xNVhqKopD++DkEQEdl/AdGhj/xwXcm+cAlhlK3HutFAyPpzixYvLd4alju
 lFAxti2i/ozUGMnObKwv74Rw6lyUDYHd853B4FIUr2fX5csBN4jY3Wwr9RG51knzGzPK
 WvihowtSygyEyqxfXy/qb8hzQfZbAp4WpDa6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762227329; x=1762832129;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OYwswrq1Wb1lxRTBvxJzP5wsXyRZGQHxwMlpPnsAzmM=;
 b=CZXkLXxpXmodNYRZCawha1WvNSriP+FlKGZe08XTatT/yhuU4Gh9drFCSUN0gbuzeY
 d1/xilmb8sEhopI8NaPEYuIJby2neWWYaghf5osk0OW7hCz7sCcuyM2fBcYUjo0gc53F
 YTjljDnjvvSh1gkCJ5Doe4UFphb9U5FHvYDUhVW0mlfe/yyAh6WXkanY053e80w6NG2N
 PTtBfwV0YgS+gJLGMBCq6bfTSOkzUo9N3BQAzAqoyVvhDUzGqCAfFk8evO5/kKnD3bHU
 hD1BGnAvz9zgiYvvhsLlSICSJLY6Xl8P25E/Lsd2a+qflsJ6voG0v1jGrkFBxO4/7ZyI
 vd0g==
X-Gm-Message-State: AOJu0YyD+nyE979Vk5rmjgsVPNsJuTn19AcWPyG7dPn6b9SG+4UognPs
 7FqDSvfa4sJtEee+B7H4Pw2cX41T7Bmp5XdnBO3kIMXbbLV6bpS+AXr0SgkM1xTyUp0YSlslTbq
 IuiDdn6xsS4Ww90stQzTCxYLcceMLGCYpc6lZ26stOA==
X-Gm-Gg: ASbGncsf33a5CRPKjUYD52q2QNlZYorIrPe6ucH1giVyUBiySM1kmRjtZe9UbwrSSWB
 OYnFiEk7GjyhsKFoXBrFjx3UNnV/aBcGHeX+YwcayKqmp/ekptY9qALE24dwzMZtTU8XV5ptHfW
 y/N1uB/0y3bW5pDheHK3tyzh8fsUv23QAJU5Hzcz3AwE9xiZXbE1aZS2l+t+h4Je+VhfXxhAmZ6
 lN4seD3+5P03MmAPe50zact/8X9bLc0B8ST2Z6jvtoWIzoTKoWp6Z4dp/qZ0/rPDAhQ5QDW6AzO
X-Google-Smtp-Source: AGHT+IGb33JDg5kByB5mrYwNtFeQZuaSbhV7qODpWMOcfMHbccrQa1mEEUisLOOeFoEyQUQiKHCH+5CtR1Es7JEUnPc=
X-Received: by 2002:a17:902:d2cc:b0:276:76e1:2e84 with SMTP id
 d9443c01a7336-2951a371b57mr192122325ad.3.1762227328723; Mon, 03 Nov 2025
 19:35:28 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 3 Nov 2025 22:34:23 -0500
X-Gm-Features: AWmQ_bmDXOZRpoWyauTdQoVTr52UYEL4CE5isS2GCO183ajwQsLXOztIfRly-dQ
Message-ID: <CAJvnSUChg=D1NoWDO7yXsFNiziiTz2q1LaE88HkhqTz5hkKE7g@mail.gmail.com>
Subject: Community CI Meeting Minutes - October 16, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000f13e1c0642bc85b9"
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

--000000000000f13e1c0642bc85b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
October 16, 2025
Attendees
   4. Patrick Robb
   5. Luca Vizzarro
   6. Indira K
   7. Andrew Bailey
   8. Aaron Conole

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
   * Mbuf_fast_free
   * Tech board has voted that this feature will be reverted back to it=E2=
=80=99s
25.07 default behavior, meaning it will be enabled by default at start, and
it is not mutually exclusive with MULTI_SEGS flag
   * Proposed new tag for reporting AI bot reviews:
      * Instead of linking to an email which contains the github link, link
directly from the patchwork report to Github.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
AWS Lab
   * Looks like their test results are a little behind - Patrick to check
this after the meeting.

---------------------------------------------------------------------
UNH-IOL Community Lab
   * Community Lab retrospective for 2025:
https://docs.google.com/document/d/1b-Jhbne_ucd1YIAK8BjKWWbTyvFTwUrWjAJaoJD=
makg/edit?tab=3Dt.0#heading=3Dh.k82m3uansnww
   * The new Windows server 2025 machine is working. Most importantly, it
is able to build DPDK with devx libraries included from meson, something we
could not do from windows server 2022.
   * Dean is building a spreadsheet with all of the DTS testcase failures
for various network cards at the Lab.
   * Some of the docs for meeting dependencies for the windows compiler
toolchains are wrong (linking you to the wrong version) so Andrew will
email Andre Muezerie asking if the docs can be updated.
   * Patrick needs to stand up pw-ci and also needs to review the
preliminary series Aaron had sent for porting over the bash scripts from
Python.

---------------------------------------------------------------------
Intel Lab
   * Technically, this team can re-enable their tx_offload testcases which
were originally disabled due to the upcoming mbuf_fast_free change. But, it
is probably not worth doing so given that tech board is going to re-assess
fast free again in 26.03.
Github Actions Robot
   * None

---------------------------------------------------------------------
Loongson Lab
   * Min Zhou has sent a MAINTAINERS patch removing himself and adding
another Loongson employee. I am asking whether he is also transferring
Loongarch CI testing duties to this new person.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
   * Test and Packet API:
      * Just 1 docstring update needed
      * Reviewed by and approved by Patrick
   * Single_core_forward_perf:
      * For the next version, have added the new TestSuite function for
adding an arbitrary dict of performance metrics and writing it to testsuite
specific output files.
      * Of course this will come from API at the end of the day.
      * Also need to add the shell pool exception for traffic generators so
they can be instantiated within testcases and persist beyond the testcases
stages
   * QinQ Test:
      * There are quite a few comments on the patches, Dean needs to send a
v2
      * Patrick to merge this
   * Single link topology
      * Docs failure is coming from circular imports between framework
capabilities.py and api capability.py - Dean to look at this closer after
his work on the QinQ series is complete.
   * add test case docstring checks to format script
      * There are a number of comments, Dean to send a v3
   * Testsuite docstring updates:
      * Unclear if this series from Dean is overlapping with work Thomas
Wilks had also done updating testcase docstrings during this release.
Patrick to check and discuss with Dean.
   * RSS Testsuite:
      * Pending final review from Patrick
   * Virtio vhost series:
      * Luca and Patrick both need to review
   * Testpmd API:
https://patchwork.dpdk.org/project/dpdk/patch/20250910152103.976383-2-paul.=
szczepanek@arm.com/
   * Before, when a test was skipped due to a missing capability, the
capability name was printed in the logs =E2=80=9Creason=E2=80=9D field. Now=
, it just prints
the number ID for the capability since capabilities were updated to an
IntEnum

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
      * Next Meeting is Oct 29, 2025

--000000000000f13e1c0642bc85b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">#########################################=
############################<br>October 16, 2025<br>Attendees<br>=C2=A0 =C2=
=A04. Patrick Robb<br>=C2=A0 =C2=A05. Luca Vizzarro<br>=C2=A0 =C2=A06. Indi=
ra K<br>=C2=A0 =C2=A07. Andrew Bailey<br>=C2=A0 =C2=A08. Aaron Conole<br><b=
r>#####################################################################<br>=
Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>General Announcements<br>=C2=A0 =C2=A0* Mbuf_fast_free<br>=C2=A0 =C2=A0* T=
ech board has voted that this feature will be reverted back to it=E2=80=99s=
 25.07 default behavior, meaning it will be enabled by default at start, an=
d it is not mutually exclusive with MULTI_SEGS flag<br>=C2=A0 =C2=A0* Propo=
sed new tag for reporting AI bot reviews:<br>=C2=A0 =C2=A0 =C2=A0 * Instead=
 of linking to an email which contains the github link, link directly from =
the patchwork report to Github.<br>=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status<br><br>------------------=
---------------------------------------------------<br>AWS Lab<br>=C2=A0 =
=C2=A0* Looks like their test results are a little behind - Patrick to chec=
k this after the meeting.<br>=C2=A0 =C2=A0<br>-----------------------------=
----------------------------------------<br>UNH-IOL Community Lab<br>=C2=A0=
 =C2=A0* Community Lab retrospective for 2025: <a href=3D"https://docs.goog=
le.com/document/d/1b-Jhbne_ucd1YIAK8BjKWWbTyvFTwUrWjAJaoJDmakg/edit?tab=3Dt=
.0#heading=3Dh.k82m3uansnww" target=3D"_blank">https://docs.google.com/docu=
ment/d/1b-Jhbne_ucd1YIAK8BjKWWbTyvFTwUrWjAJaoJDmakg/edit?tab=3Dt.0#heading=
=3Dh.k82m3uansnww</a><br>=C2=A0 =C2=A0* The new Windows server 2025 machine=
 is working. Most importantly, it is able to build DPDK with devx libraries=
 included from meson, something we could not do from windows server 2022.<b=
r>=C2=A0 =C2=A0* Dean is building a spreadsheet with all of the DTS testcas=
e failures for various network cards at the Lab.<br>=C2=A0 =C2=A0* Some of =
the docs for meeting dependencies for the windows compiler toolchains are w=
rong (linking you to the wrong version) so Andrew will email Andre Muezerie=
 asking if the docs can be updated.<br>=C2=A0 =C2=A0* Patrick needs to stan=
d up pw-ci and also needs to review the preliminary series Aaron had sent f=
or porting over the bash scripts from Python.<br>=C2=A0 =C2=A0<br>---------=
------------------------------------------------------------<br>Intel Lab<b=
r>=C2=A0 =C2=A0* Technically, this team can re-enable their tx_offload test=
cases which were originally disabled due to the upcoming mbuf_fast_free cha=
nge. But, it is probably not worth doing so given that tech board is going =
to re-assess fast free again in 26.03. <br>Github Actions Robot<br>=C2=A0 =
=C2=A0* None<br><br>-------------------------------------------------------=
--------------<br>Loongson Lab<br>=C2=A0 =C2=A0* Min Zhou has sent a MAINTA=
INERS patch removing himself and adding another Loongson employee. I am ask=
ing whether he is also transferring Loongarch CI testing duties to this new=
 person.<br>=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>DTS Improvements &amp; Test Development<br>=C2=A0 =C2=A0* T=
est and Packet API:<br>=C2=A0 =C2=A0 =C2=A0 * Just 1 docstring update neede=
d<br>=C2=A0 =C2=A0 =C2=A0 * Reviewed by and approved by Patrick<br>=C2=A0 =
=C2=A0* Single_core_forward_perf:<br>=C2=A0 =C2=A0 =C2=A0 * For the next ve=
rsion, have added the new TestSuite function for adding an arbitrary dict o=
f performance metrics and writing it to testsuite specific output files.<br=
>=C2=A0 =C2=A0 =C2=A0 * Of course this will come from API at the end of the=
 day.<br>=C2=A0 =C2=A0 =C2=A0 * Also need to add the shell pool exception f=
or traffic generators so they can be instantiated within testcases and pers=
ist beyond the testcases stages<br>=C2=A0 =C2=A0* QinQ Test:<br>=C2=A0 =C2=
=A0 =C2=A0 * There are quite a few comments on the patches, Dean needs to s=
end a v2<br>=C2=A0 =C2=A0 =C2=A0 * Patrick to merge this<br>=C2=A0 =C2=A0* =
Single link topology<br>=C2=A0 =C2=A0 =C2=A0 * Docs failure is coming from =
circular imports between framework capabilities.py and api capability.py - =
Dean to look at this closer after his work on the QinQ series is complete.<=
br>=C2=A0 =C2=A0* add test case docstring checks to format script<br>=C2=A0=
 =C2=A0 =C2=A0 * There are a number of comments, Dean to send a v3<br>=C2=
=A0 =C2=A0* Testsuite docstring updates:<br>=C2=A0 =C2=A0 =C2=A0 * Unclear =
if this series from Dean is overlapping with work Thomas Wilks had also don=
e updating testcase docstrings during this release. Patrick to check and di=
scuss with Dean.<br>=C2=A0 =C2=A0* RSS Testsuite:<br>=C2=A0 =C2=A0 =C2=A0 *=
 Pending final review from Patrick<br>=C2=A0 =C2=A0* Virtio vhost series:<b=
r>=C2=A0 =C2=A0 =C2=A0 * Luca and Patrick both need to review<br>=C2=A0 =C2=
=A0* Testpmd API: <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/=
20250910152103.976383-2-paul.szczepanek@arm.com/" target=3D"_blank">https:/=
/patchwork.dpdk.org/project/dpdk/patch/20250910152103.976383-2-paul.szczepa=
nek@arm.com/</a><br>=C2=A0 =C2=A0* Before, when a test was skipped due to a=
 missing capability, the capability name was printed in the logs =E2=80=9Cr=
eason=E2=80=9D field. Now, it just prints the number ID for the capability =
since capabilities were updated to an IntEnum<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>=C2=A0 =C2=A0=
 =C2=A0 * Next Meeting is Oct 29, 2025</div>
</div>

--000000000000f13e1c0642bc85b9--
