Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD6C5DF7E
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 12:10:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FE054027C;
	Tue, 18 Aug 2026 14:10:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BE56840269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 14:10:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7EDB2202E1;
 Tue, 18 Aug 2026 14:10:26 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v12 16/26] net/dpaa: add Tx rate limiting API
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 18 Aug 2026 14:10:25 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659F8@smartserver.smartshare.dk>
In-Reply-To: <20260818111730.801760-17-hemant.agrawal@nxp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v12 16/26] net/dpaa: add Tx rate limiting API
Thread-Index: Ad0vA2Wc+4SKX2jcSYa7QxzhTNzeegABjUTA
References: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-17-hemant.agrawal@nxp.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Hemant Agrawal" <hemant.agrawal@nxp.com>, <stephen@networkplumber.org>,
 <thomas@monjalon.net>, <dev@dpdk.org>
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

> From: Hemant Agrawal [mailto:hemant.agrawal@nxp.com]
> Sent: Tuesday, 18 August 2026 13.17
> To: stephen@networkplumber.org; thomas@monjalon.net; dev@dpdk.org
> Subject: [PATCH v12 16/26] net/dpaa: add Tx rate limiting API
>=20
> Add a DPAA PMD API to configure the transmit rate limit (rate and
> burst) on a DPAA port, using the FMAN port rate limiter.
>=20
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---
> diff --git a/drivers/net/dpaa/rte_pmd_dpaa.h
> b/drivers/net/dpaa/rte_pmd_dpaa.h
> index 0a57e2097a..680ff387f8 100644
> --- a/drivers/net/dpaa/rte_pmd_dpaa.h
> +++ b/drivers/net/dpaa/rte_pmd_dpaa.h
> @@ -1,11 +1,12 @@
>  /* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright 2018 NXP
> + * Copyright 2018,2022 NXP
>   */
>=20
>  #ifndef _PMD_DPAA_H_
>  #define _PMD_DPAA_H_
>=20
>  #include <stdint.h>
> +#include <rte_compat.h>
>=20
>  /**
>   * @file rte_pmd_dpaa.h
> @@ -33,4 +34,24 @@
>  int
>  rte_pmd_dpaa_set_tx_loopback(uint16_t port, uint8_t on);
>=20
> +/**
> + * Set TX rate limit
> + *
> + * @param port_id
> + *    The port identifier of the Ethernet device.
> + * @param burst
> + *    Max burst size(KBytes) of the Ethernet device.
> + *    0 - Disable TX rate limit.
> + * @param rate
> + *    Max rate(Kb/sec) of the Ethernet device.
> + *    0 - Disable TX rate limit.
> + * @return
> + *    0 - if successful.
> + *    <0 - if failed, with proper error code.
> + */
> +__rte_experimental
> +int
> +rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
> +				 uint32_t rate);
> +
>  #endif /* _PMD_DPAA_H_ */
> --
> 2.25.1

We already have a generic API for per-queue TX rate limit: =
rte_eth_set_queue_rate_limit().

Let's have a generic API for per-port TX rate limit, instead of a =
device-specific API.

The per-queue API doesn't support burst size, but the per-port API =
could.
It could be noted in the API description that if a port doesn't support =
burst capacity, the "burst" parameter will be ignored.

