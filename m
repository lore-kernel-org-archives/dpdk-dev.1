Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FA3C83F05
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 09:38:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACCE14028B;
	Fri,  4 Jul 2025 11:38:22 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AA68B40267
 for <dev@dpdk.org>; Fri,  4 Jul 2025 11:38:21 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5F96B20544;
 Fri,  4 Jul 2025 11:38:21 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] mbuf: add new ptype for slow protocols
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 4 Jul 2025 11:38:21 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD8C@smartserver.smartshare.dk>
In-Reply-To: <20250704084502.237979-1-kuka@cesnet.cz>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: add new ptype for slow protocols
Thread-Index: Advsv/ldEg1lO9LfTbCFjg+36intgAABqMsg
References: <20250704084502.237979-1-kuka@cesnet.cz>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Mario Kuka" <kuka@cesnet.cz>, "Paul Szczepanek" <paul.szczepanek@arm.com>,
 "Patrick Robb" <probb@iol.unh.edu>
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

> diff --git a/lib/mbuf/rte_mbuf_ptype.h b/lib/mbuf/rte_mbuf_ptype.h
> index c46a94f89f..66c4eeb954 100644
> --- a/lib/mbuf/rte_mbuf_ptype.h
> +++ b/lib/mbuf/rte_mbuf_ptype.h
> @@ -144,6 +144,13 @@ extern "C" {
>   * <'ether type'=3D[0x8847|0x8848]>
>   */
>  #define RTE_PTYPE_L2_ETHER_MPLS             0x0000000a
> +/**
> + * Ethernet packet type for Slow Protocols.
> + *
> + * Packet format:
> + * <'ether type'=3D[0x8809]>
> + */
> +#define RTE_PTYPE_L2_ETHER_SLOW             0x0000000b

Matching 'ether type' doesn't suffice.
Slow protocols also require 'destination mac'=3D01-80-C2-00-00-02.


