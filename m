Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697CDC8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:22:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94B2840264;
	Mon, 30 Jun 2025 13:22:15 +0200 (CEST)
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com
 [52.119.213.150])
 by mails.dpdk.org (Postfix) with ESMTP id F1AF24025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751282534; x=1782818534;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yR1fNWdfBfdZ5u+eKYF9Rdbz8ZmSx7s99+y73BU6hgs=;
 b=VybEk0cupxxdA4+kXOEq08mER1lrRa4KHZ3ociyY+KJzMKaFM5700JCF
 y5sVS9+wH/8QWqr1u/Z/kkpZWgt25pLbwuCiXvqWzez1+fDygWeXlyI1I
 yF2ZOxRorJHLupNK+XD8xlDXiWHX/uR6nBg9JMX0y9t6aHMs7V6Q2Ts+Y
 V+YHodfzReiNW/cth2BeLx9A1xIJq/xiedcHcPB0Mys6jMPkIySNq6JmV
 u86zVkij8fckISp7UlYvaK+V5jmFwz+8UsQvgd7zKswonBKu+Ci0hNvqG
 dXQSOEwtq3gnQ564cquStwvrO6oMAi6cRSv5GRjsSFGrFu4KOPJ/y2koA Q==;
X-IronPort-AV: E=Sophos;i="6.16,277,1744070400"; d="scan'208";a="737822759"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52002.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:22:12 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:11170]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.108:2525]
 with esmtp (Farcaster)
 id cc77f9b9-b3c4-41c9-9c11-32da3f563ae2; Mon, 30 Jun 2025 11:22:09 +0000 (UTC)
X-Farcaster-Flow-ID: cc77f9b9-b3c4-41c9-9c11-32da3f563ae2
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:22:09 +0000
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:22:09 +0000
Received: from EX19D007EUA002.ant.amazon.com ([fe80::1295:20d9:141e:47cc]) by
 EX19D007EUA002.ant.amazon.com ([fe80::1295:20d9:141e:47cc%3]) with
 mapi id 15.02.1544.014; Mon, 30 Jun 2025 11:22:09 +0000
From: "Brandes, Shai" <shaibran@amazon.com>
To: "stephen@networkplumber.org" <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 0/7] net/ena: release 2.13.0
Thread-Topic: [PATCH 0/7] net/ena: release 2.13.0
Thread-Index: AQHb6bAlJIfdEg3ANkWDepWgEArCorQbjeOw
Date: Mon, 30 Jun 2025 11:22:08 +0000
Message-ID: <21bfbaca7d7249e7a28808fc5c51bacb@amazon.com>
References: <20250630111358.3476-1-shaibran@amazon.com>
In-Reply-To: <20250630111358.3476-1-shaibran@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.213.9]
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

Hi Stephen, this is the revised patchset that cleanly applies on top of dpd=
k-next-net origin/main branch after aligning the release notes.
I noticed that rc2 has already been released - we would greatly appreciate =
it if you could include the ENA changes in rc3.
ENA is a self-contained module, and the previous maintainer approved that m=
ode of operation.
Hopefully, an exception can be made in this case as we originally submitted=
 the patchset over a month ago, and it has been in the "awaiting upstream" =
state since then.
Thanks again for your time and continued support.

> -----Original Message-----
> From: Brandes, Shai <shaibran@amazon.com>
> Sent: Monday, June 30, 2025 2:14 PM
> To: stephen@networkplumber.org
> Cc: dev@dpdk.org; Brandes, Shai <shaibran@amazon.com>
> Subject: [PATCH 0/7] net/ena: release 2.13.0
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
> v4:
> Each patch in the series should compile independently.
> Patch 4/7 causes a compile error that was missed, as the full series pass=
ed our
> directed tests when applied together
>=20
> v5:
> Reworked the patchset so it applies cleanly on origin/main due to release
> notes mismatch.
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
>  drivers/net/ena/base/ena_com.c                | 40 +++++++-
>  drivers/net/ena/base/ena_com.h                |  7 ++
>  .../net/ena/base/ena_defs/ena_admin_defs.h    | 14 +++
>  drivers/net/ena/base/ena_eth_com.c            |  6 +-
>  drivers/net/ena/base/ena_eth_com.h            | 15 ++-
>  drivers/net/ena/ena_ethdev.c                  | 98 +++++++++++++++----
>  drivers/net/ena/ena_ethdev.h                  |  4 +-
>  9 files changed, 175 insertions(+), 31 deletions(-)
>=20
> --
> 2.17.1

