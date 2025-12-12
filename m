Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C48D59D8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 19:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 685454027D;
	Fri, 12 Dec 2025 20:52:43 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8AE6940268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 20:52:41 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7bb3092e4d7so1634409b3a.0
 for <dev@dpdk.org>; Fri, 12 Dec 2025 11:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765569161; x=1766173961; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dDeYBlzbqiHJB1N47OGME0c9jQcb/0drtWAmfUH2SU8=;
 b=YCb65Apygd6Fh5ttAKwFpI9X9SOnOWR8GhuI9tJZomk1zl1ERgxXKv162jksAh4x/0
 VqqygIoQ++GRVWDBthNc5EmlH9rVAa7WNSzkGSHn2wjVZDY6ZLsQAhDwE6TFM7qxTXcg
 TLjJPEnjv4GehG173QQqRp/vN+86qMsNv/5ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765569161; x=1766173961;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dDeYBlzbqiHJB1N47OGME0c9jQcb/0drtWAmfUH2SU8=;
 b=OrIjuGRTQbS6OZPCUhJkVOCM75CTmIFDcfZL1ZjoRZa6SkJtT+kbQyqPCfSvTSk+1x
 PIlr+4dngxOZEB8mkULQhQPt4wFSjj9ZZBMpZb8mcZs/4+sd27OrewP0/opUKtFAFFuv
 COQ/vvgLcoFSPy7M0SZepXIt+WR+8OfK4YEnBmoNcC3SqGLCgNNp8oKLw3OjOS4ByIhj
 RXqvE3/XHO5seNUh1bbBcGOzE+YACIHRPv/V1NYVZjrsKryhANgQtg5f2Hyst3d4MwGg
 u8UaB5fWeuhr/MxMpRDRKrk1Q5JNL5I7j5qOnhIFCZetu/eQcJdbpFiAVwRJrCC4uv9U
 6Stg==
X-Gm-Message-State: AOJu0Yx4jIAbjWPq+aDgUFiHNvbzqu3IZyYmk9Sh5jBsDEEZIkbuyNP3
 PgTPuMh85xape3oGvf0okqdc8qRSBsQNavhDMd5HwZy4X0IKK60jrZzFCmachuZBPQjlfDCm5N8
 2yu045SdomQ7UPmP9YWOmKrwydZuc0vANwd2eMUH7aMLgGKckLDsEraaong==
X-Gm-Gg: AY/fxX53dAJJzHqBCo0HoiCgZBwPa1VMuPINKAO6C8WjqFzTrhV7iXufp+2agpws76S
 H4znYmlcrldPjx3NRWBL0rX4VkEmk8xC+Oqlgx+/QttRyynkJxxHaBNNOYMYI7N6L8UBWMmq/sq
 3GrBsPXaNryaGgyoysdM0Vz+3CTTUZfL882oi7Uavsva4yYENKiPULZ5F7WbIKLv287e/c4LvYw
 fWFFLHmQmD/hBakqdGvBpK990a22/3eDPdixEH6iSDD9szDR8AclzyzSLjRdIqRxoRYuBORps9V
 B+huHYEbeU/EjXCr+rSXC7xlmaD1
X-Google-Smtp-Source: AGHT+IFpQgjUjEdotqOG7lX70C8lKRVzx8jmV5N+ykLNoBBKA6q7eQrNlCrptPKGyn5lkCjO4C/4zaTFpnRJkmxH9Ok=
X-Received: by 2002:a05:7022:4393:b0:119:e569:fb96 with SMTP id
 a92af1059eb24-11f354776a3mr2986652c88.5.1765569160525; Fri, 12 Dec 2025
 11:52:40 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 12 Dec 2025 14:50:57 -0500
X-Gm-Features: AQt7F2oVE665o-kZUGza5Cd4eqO5tWPBGeJA7MEx_aWlVmE7drvLaNbQWvxdGtw
Message-ID: <CAJvnSUB9Sjd-VBbJNaybZog5Bq9NCNyaemDnVOhQa8tMutO-=A@mail.gmail.com>
Subject: Community CI Meeting Minutes - November 13, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000a3ca460645c69a79"
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

--000000000000a3ca460645c69a79
Content-Type: text/plain; charset="UTF-8"

November 13, 2025

Attendees
   1. Patrick Robb
   2. Andrew Bailey
   3. Aaron Conole
   4. Luca Vizzarro
   5. Paul Szczepanek

Minutes

General Announcements
   * Release Candidate 3 (RC3) will be released on Monday
   * Patrick to present the proposal for new DTS work to DPDK Governing
board on Tuesday. The focus of the work would be cryptodev, virtio, and
flow offload testing, per discussion with tech board. Other areas of focus
are:
    * Adding further QoL improvements or documentation to facilitate single
host DTS runs
    * Further reduce the lines required for testsuites or otherwise
simplify the testsuite writing process
CI Status

AWS Lab
   * None

UNH-IOL Community Lab
   * SPDK has a build failure on their DPDK branch which they have been
slow to resolve, which was causing all new patches to get WARNs for their
SPDK build job. So, tech board instructed us to disable the SPDK build on
per-patch testing and leave it enabled for nightly builds of mainline. In
the future when SPDK branch is in a good state we can revert.
   * We had some downtime for ACVP FIPS testing last week, due to our
certificate with NIST expiring. We have renewed our certificate as of end
of last week and caught up on results.
   * For our new windows server 2025 build machine, Clang builds with mlnx
devx are successful but MSVC is not. After switching to the MSVC developer
shell, it appears that Meson is not using the MSVC compiler, which might be
the issue. Anyhow, Andre from Microsoft is helping in this thread:
https://inbox.dpdk.org/ci/CAJvnSUDtn4e0k3TNFD-jWYHdOhw-jSui2faABMveUmK9gEbsWw@mail.gmail.com/T/#u
   * Runs of the single core forwarding test will be moved over to new DTS
from legacy DTS after this release (as that testsuite is being merged in
for 25.11)

Intel Lab
   * Patrick emailed them about a build failure on one of his patchseries:
https://inbox.dpdk.org/ci/f7tbjlej6me.fsf@redhat.com/T/#t
    * They are excluding doc/* when applying patches because doc/* changes
may conflict with the main tree
    * Does proper usage of dpdk-ci/pw_maintainers_cli.py mitigate this
issue?
    * Patrick can ask about the reasons why they have to exclude the doc dir

Github Actions Robot
   * None

Loongson Lab
   * None

DTS Improvements & Test Development
   * Virtio testsuite is merged
   * Single_core_forward_perf:
    * Sent a v7 (should be final)
    * Contains a missing SPDX license tag
    * Includes appending c_args="-DRTE_NET_INTEL_USE_16BYTE_DESC" to
mesonargs when using an ice driver NIC (required for the best throughput)
    *
https://patchwork.dpdk.org/project/dpdk/patch/20251113012732.1059669-4-probb@iol.unh.edu/
    * -The Intel doc build fail is included here, but as discussed
previously this is a false failure
   * UNH lab to pick up moving over more of the existing framework calls to
the testsuite API during 26.03
    * Otherwise, we need to document the current state of API in dts.rst
for this release. That should be the final patch we send, and should be
minimal so that we can merge it soon.
   * Thomas recommended that we rename some testsuites to be more clear,
which has been ticketed.
   * QinQ testsuite:
    * Looks good, Patrick to do final testing
   * DTS check format script:
    * https://patches.dpdk.org/project/dpdkNov. 13, 2025, 1:27 a.m.
UTC/patch/20251106181355.209706-1-dmarx@iol.unh.edu/
   * Will start drafting the 26.03 roadmap next Thursday at the DTS meeting
   * When pydantic is installed on your environment that you build DPDK on,
it shows warnings for /dts/. Although this is not a part of how docs are
built in CI, it is ideal if we can resolve these warnings. Patrick to look.

Any other business
      * The November 27 meeting is on American Thanksgiving, so it will be
cancelled.

--000000000000a3ca460645c69a79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">November 13, 2025<br><br>Attendees<br>=C2=A0 =C2=A01. Patr=
ick Robb<br>=C2=A0 =C2=A02. Andrew Bailey<br>=C2=A0 =C2=A03. Aaron Conole<b=
r>=C2=A0 =C2=A04. Luca Vizzarro<br>=C2=A0 =C2=A05. Paul Szczepanek<br>=C2=
=A0 =C2=A0<br>Minutes<br><br>General Announcements<br>=C2=A0 =C2=A0* Releas=
e Candidate 3 (RC3) will be released on Monday<br>=C2=A0 =C2=A0* Patrick to=
 present the proposal for new DTS work to DPDK Governing board on Tuesday. =
The focus of the work would be cryptodev, virtio, and flow offload testing,=
 per discussion with tech board. Other areas of focus are:<br>=C2=A0 =C2=A0=
	* Adding further QoL improvements or documentation to facilitate single ho=
st DTS runs<br>=C2=A0 =C2=A0	* Further reduce the lines required for testsu=
ites or otherwise simplify the testsuite writing process<br>CI Status<br><b=
r>AWS Lab<br>=C2=A0 =C2=A0* None<br>=C2=A0 =C2=A0<br>UNH-IOL Community Lab<=
br>=C2=A0 =C2=A0* SPDK has a build failure on their DPDK branch which they =
have been slow to resolve, which was causing all new patches to get WARNs f=
or their SPDK build job. So, tech board instructed us to disable the SPDK b=
uild on per-patch testing and leave it enabled for nightly builds of mainli=
ne. In the future when SPDK branch is in a good state we can revert.<br>=C2=
=A0 =C2=A0* We had some downtime for ACVP FIPS testing last week, due to ou=
r certificate with NIST expiring. We have renewed our certificate as of end=
 of last week and caught up on results.<br>=C2=A0 =C2=A0* For our new windo=
ws server 2025 build machine, Clang builds with mlnx devx are successful bu=
t MSVC is not. After switching to the MSVC developer shell, it appears that=
 Meson is not using the MSVC compiler, which might be the issue. Anyhow, An=
dre from Microsoft is helping in this thread: <a href=3D"https://inbox.dpdk=
.org/ci/CAJvnSUDtn4e0k3TNFD-jWYHdOhw-jSui2faABMveUmK9gEbsWw@mail.gmail.com/=
T/#u">https://inbox.dpdk.org/ci/CAJvnSUDtn4e0k3TNFD-jWYHdOhw-jSui2faABMveUm=
K9gEbsWw@mail.gmail.com/T/#u</a><br>=C2=A0 =C2=A0* Runs of the single core =
forwarding test will be moved over to new DTS from legacy DTS after this re=
lease (as that testsuite is being merged in for 25.11)<br><br>Intel Lab<br>=
=C2=A0 =C2=A0* Patrick emailed them about a build failure on one of his pat=
chseries: <a href=3D"https://inbox.dpdk.org/ci/f7tbjlej6me.fsf@redhat.com/T=
/#t">https://inbox.dpdk.org/ci/f7tbjlej6me.fsf@redhat.com/T/#t</a><br>=C2=
=A0 =C2=A0	* They are excluding doc/* when applying patches because doc/* c=
hanges may conflict with the main tree<br>=C2=A0 =C2=A0	* Does proper usage=
 of dpdk-ci/pw_maintainers_cli.py mitigate this issue?<br>=C2=A0 =C2=A0		* =
Patrick can ask about the reasons why they have to exclude the doc dir<br><=
br>Github Actions Robot<br>=C2=A0 =C2=A0* None<br><br>Loongson Lab<br>=C2=
=A0 =C2=A0* None<br><br>DTS Improvements &amp; Test Development<br>=C2=A0 =
=C2=A0* Virtio testsuite is merged<br>=C2=A0 =C2=A0* Single_core_forward_pe=
rf:<br>=C2=A0 =C2=A0	* Sent a v7 (should be final)<br>=C2=A0 =C2=A0	* Conta=
ins a missing SPDX license tag<br>=C2=A0 =C2=A0	* Includes appending c_args=
=3D&quot;-DRTE_NET_INTEL_USE_16BYTE_DESC&quot; to mesonargs when using an i=
ce driver NIC (required for the best throughput)<br>=C2=A0 =C2=A0	* <a href=
=3D"https://patchwork.dpdk.org/project/dpdk/patch/20251113012732.1059669-4-=
probb@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/patch/202511130=
12732.1059669-4-probb@iol.unh.edu/</a><br>=C2=A0 =C2=A0		* -The Intel doc b=
uild fail is included here, but as discussed previously this is a false fai=
lure<br>=C2=A0 =C2=A0* UNH lab to pick up moving over more of the existing =
framework calls to the testsuite API during 26.03<br>=C2=A0 =C2=A0	* Otherw=
ise, we need to document the current state of API in dts.rst for this relea=
se. That should be the final patch we send, and should be minimal so that w=
e can merge it soon.<br>=C2=A0 =C2=A0* Thomas recommended that we rename so=
me testsuites to be more clear, which has been ticketed.<br>=C2=A0 =C2=A0* =
QinQ testsuite:<br>=C2=A0 =C2=A0	* Looks good, Patrick to do final testing<=
br>=C2=A0 =C2=A0* DTS check format script: <br>=C2=A0 =C2=A0	* <a href=3D"h=
ttps://patches.dpdk.org/project/dpdkNov">https://patches.dpdk.org/project/d=
pdkNov</a>. 13, 2025, 1:27 a.m. UTC/patch/<a href=3D"http://20251106181355.=
209706-1-dmarx@iol.unh.edu/">20251106181355.209706-1-dmarx@iol.unh.edu/</a>=
<br>=C2=A0 =C2=A0* Will start drafting the 26.03 roadmap next Thursday at t=
he DTS meeting<br>=C2=A0 =C2=A0* When pydantic is installed on your environ=
ment that you build DPDK on, it shows warnings for /dts/. Although this is =
not a part of how docs are built in CI, it is ideal if we can resolve these=
 warnings. Patrick to look.<br><br>Any other business<br>=C2=A0 =C2=A0 =C2=
=A0 * The November 27 meeting is on American Thanksgiving, so it will be ca=
ncelled.</div>

--000000000000a3ca460645c69a79--
