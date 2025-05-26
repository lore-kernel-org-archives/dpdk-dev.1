Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E11C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 14:13:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1FA3402ED;
	Mon, 26 May 2025 16:13:37 +0200 (CEST)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com
 [207.171.188.204])
 by mails.dpdk.org (Postfix) with ESMTP id 02953402ED
 for <dev@dpdk.org>; Mon, 26 May 2025 16:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1748268816; x=1779804816;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=hEhsU+RM/5YNjX0VTcsrmf9S0r422W6kB+2IfkxESRY=;
 b=pOXxUPGavAcZ2yjg6BqCbQnZpgk2m84naeTBmkDuwKSyeCQkFZEzD4O0
 xwgMP7zQQ7XnJDJXqFpVUwGtljeaDdgJM7/5t166Sr2HqqeG88/VnUttK
 jkLJWkb7iOwUtbAqxf0yxZ4rTmzzM059eZ5iKIkwggBxIwJOGQSMPaKYh
 DlywnxUZfGHetZtWzEZCMidgHf1z/omoy0wHnYTf5NP9FO3ppYex1HxOm
 VwPgRo7eMbiFFocx8zPJ0+5K55/XdHm47Zo1MhTkosyDF8brhfjugCJd2
 Rxej1itchV0UbFtVrzq5GnJNK99AWCfT3tr0sIC7aNxkSXmTap0AJC6cE A==;
X-IronPort-AV: E=Sophos;i="6.15,316,1739836800"; d="scan'208";a="23797368"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9105.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 14:13:29 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:5674]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.17:2525]
 with esmtp (Farcaster)
 id 832dce83-ebc8-4629-8b13-d389bc6da218; Mon, 26 May 2025 14:13:27 +0000 (UTC)
X-Farcaster-Flow-ID: 832dce83-ebc8-4629-8b13-d389bc6da218
Received: from EX19D007EUA003.ant.amazon.com (10.252.50.8) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 14:13:27 +0000
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19D007EUA003.ant.amazon.com (10.252.50.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 14:13:27 +0000
Received: from EX19D007EUA002.ant.amazon.com ([fe80::1295:20d9:141e:47cc]) by
 EX19D007EUA002.ant.amazon.com ([fe80::1295:20d9:141e:47cc%3]) with
 mapi id 15.02.1544.014; Mon, 26 May 2025 14:13:27 +0000
From: "Brandes, Shai" <shaibran@amazon.com>
To: "stephen@networkplumber.org" <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 0/7] net/ena: release 2.13.0 
Thread-Topic: [PATCH v3 0/7] net/ena: release 2.13.0 
Thread-Index: AdvOR64x56ent1vhTgWxs29UAOPS6Q==
Date: Mon, 26 May 2025 14:13:27 +0000
Message-ID: <2dfaa5f5cb1a44d8bbb001d19b72211e@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.212.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Hi Stephen, and apologies for the multiple patchsets.

We had a bug in our CI that prevented failed runs from showing up correctly=
 in the report, this has just been identified and fixed.
While rechecking, we discovered that one of the patches in the latest v3 pa=
tchset is currently failing to compile. The problematic line was replaced i=
n a later patch within the same set, so when applied as a whole, the series=
 passed in our directed tests.

Problematic patch: [v3,4/7] net/ena: support fragment bypass mode https://p=
atches.dpdk.org/project/dpdk/patch/20250522132614.3379-5-shaibran@amazon.co=
m
Failure on the entire patchset is now visible under https://patches.dpdk.or=
g/project/dpdk/patch/20250522133029.3575-1-shaibran@amazon.com/=20

Since we aim for each patch to compile independently, we'll need to abandon=
 this patchset.
Could you please advise whether you'd prefer to abandon it yourself, since =
it's already marked as *Awaiting Upstream* and it appear on the remote "for=
-main" branch, or should we just change the state to *Superseded*?
Thanks again for your time and help!

Shai

> -----Original Message-----
> From: Brandes, Shai <shaibran@amazon.com>
> Sent: Thursday, May 22, 2025 4:26 PM
> To: stephen@networkplumber.org
> Cc: dev@dpdk.org; Brandes, Shai <shaibran@amazon.com>
> Subject: [PATCH v3 0/7] net/ena: release 2.13.0
>=20
> This patchset includes an upgrade of the ENA HAL, introduces a new featur=
e,
> and addresses three bug fixes.
>=20
> Thank you in advance to the net maintainers and community members for
> your time and effort reviewing the code.
>=20
> Best regards,
> Shai Brandes
> AWS Elastic Network Adapter team
>=20
> ---
> v2:
> Removed patch "net/ena: fix virtual address calc for unaligned BARs"
> which contained a problematic casting when compiling with 32-bit system
>=20
> v3:
> no change, there was some technical issue when sending the emails where
> part of the patches apeared on different series.
>=20
> Shai Brandes (7):
>   net/ena/base: avoid recalculating desc per entry
>   net/ena/base: coding style changes
>   net/ena: separate doorbell logic for Rx and Tx
>   net/ena: support fragment bypass mode
>   net/ena: fix unhandled interrupt config failure
>   net/ena: fix aenq timeout with low poll interval
>   net/ena: upgrade driver version to 2.13.0
>=20
>  doc/guides/nics/ena.rst                       | 13 ++-
>  doc/guides/rel_notes/release_25_07.rst        |  9 ++
>  drivers/net/ena/base/ena_com.c                | 39 +++++++-
>  drivers/net/ena/base/ena_com.h                |  8 ++
>  .../net/ena/base/ena_defs/ena_admin_defs.h    | 15 +++
>  drivers/net/ena/base/ena_eth_com.c            |  6 +-
>  drivers/net/ena/base/ena_eth_com.h            | 15 ++-
>  drivers/net/ena/ena_ethdev.c                  | 98 +++++++++++++++----
>  drivers/net/ena/ena_ethdev.h                  |  5 +-
>  9 files changed, 177 insertions(+), 31 deletions(-)
>=20
> --
> 2.17.1

