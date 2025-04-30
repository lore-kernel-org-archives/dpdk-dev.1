Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DA6C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 07:26:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16460402A3;
	Wed, 30 Apr 2025 09:26:58 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B9BF74026C
 for <dev@dpdk.org>; Wed, 30 Apr 2025 09:26:56 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 46FFA20D6E;
 Wed, 30 Apr 2025 09:26:55 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] ethdev: remove callback checks from fast path
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 30 Apr 2025 09:26:51 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC16@smartserver.smartshare.dk>
In-Reply-To: <20250429181132.2544771-1-skori@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ethdev: remove callback checks from fast path
Thread-Index: Adu5MixOGWzQ3swnRQWR1HPji4f9fwAaHesQ
References: <20250429181132.2544771-1-skori@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Sunil Kumar Kori" <skori@marvell.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
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

> From: Sunil Kumar Kori <skori@marvell.com>
> Sent: Tuesday, 29 April 2025 20.12
>=20
> rte_eth_fp_ops contains ops for fast path APIs. Each API
> validates availability of callback and then invoke it.
>=20
> Removing these NULL checks instead using dummy callbacks.

The description should mention the motivation for this patch: mbuf =
recycling performance optimization.

A few nits below.

> +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_rx_queue_count_dummy)
> +uint32_t
> +rte_eth_rx_queue_count_dummy(void *queue __rte_unused)
> +{
> +	return -ENOTSUP;
> +}

Instead of type casting back and forth, change the type of the RX queue =
count callback [1]:
-typedef uint32_t (*eth_rx_queue_count_t)(void *rxq);
+typedef int (*eth_rx_queue_count_t)(void *rxq);

So it resembles the TX queue count callback, eth_tx_queue_count_t, which =
already returns int.

[1]: =
https://elixir.bootlin.com/dpdk/v25.03/source/lib/ethdev/rte_ethdev_core.=
h#L48

Although my suggestion is formally an API change, I suppose changing =
from unsigned to signed should be acceptable.

> =
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_recycle_rx_descriptors_refill_dummy
> )
> +void
> +rte_eth_recycle_rx_descriptors_refill_dummy(void *queue __rte_unused,
> +		uint16_t nb __rte_unused)
> +{
> +

This empty line looks strange. Perhaps add a comment /* No action. */ to =
indicate that no code is missing here.

> +}

