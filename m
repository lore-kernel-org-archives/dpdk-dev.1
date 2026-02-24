Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41133E9B258
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:48:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 793B84027D;
	Tue, 24 Feb 2026 13:48:30 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 050C140270;
 Tue, 24 Feb 2026 13:48:29 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DDDC8206CD;
 Tue, 24 Feb 2026 13:48:27 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/bonding: clamp Rx free threshold for small rings
Date: Tue, 24 Feb 2026 13:48:24 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6574B@smartserver.smartshare.dk>
In-Reply-To: <20260224121358.3102740-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/bonding: clamp Rx free threshold for small rings
Thread-Index: AdylhxyZWx3lhrIhTiGoj62wGubZhAABByYg
References: <20260224121358.3102740-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: <stable@dpdk.org>, "Chas Williams" <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 "Chaoyong He" <chaoyong.he@corigine.com>, "Long Wu" <long.wu@corigine.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Tuesday, 24 February 2026 13.14
>=20
> The bonding driver creates a minimal-sized Rx ring as part of the
> setup,
> using the driver default parameters as it does so. However, for some
> cases the default values need adjustment for absolute minimal sized
> rings which can cause failures - for example, having an free threshold
> of 32 is too large for a ring of size 64.
>=20
> Unfortunately, the drivers themselves cannot properly handle this by
> adjusting their defaults because:
> a) the defaults are returned from info_get which gets called before =
the
> desired ring-size is known
> b) the replacement of the NULL rxconf value, which indicates use of
> defaults, happens at the ethdev level, so the driver is unaware of the
> source of the requested parameters - whether they are explicitly set =
by
> the user or substituted by ethdev layer.
>=20
> Therefore, we modify the bonding PMD to clamp the free thresh value to
> ring_size / 4 which should work in all cases.

I have complained about the inability to rely on drivers' capability =
reporting in edge cases before.
Here's another reason for complaining about it.
It's not easy pleasing everyone. ;-)

From an application perspective, this is black magic, and should be =
documented.
E.g. like:
https://elixir.bootlin.com/dpdk/v25.11/source/lib/ethdev/rte_ethdev.h#L63=
22

Anyway, this patch is better than being broken, so:
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

