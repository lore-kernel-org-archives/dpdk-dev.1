Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0A7C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 12:47:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF89540287;
	Mon,  7 Jul 2025 14:47:21 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AC0BB4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 14:47:20 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5994A208ED;
 Mon,  7 Jul 2025 14:47:20 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2] mbuf: add new ptype for slow protocols
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 7 Jul 2025 14:47:17 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD94@smartserver.smartshare.dk>
In-Reply-To: <20250707075100.15034-1-kuka@cesnet.cz>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] mbuf: add new ptype for slow protocols
Thread-Index: AdvvE+mZMXoA9vxsTmmFoHsa6ymedQAJz/cA
References: <20250704084502.237979-1-kuka@cesnet.cz>
 <20250707075100.15034-1-kuka@cesnet.cz>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Mario Kuka" <kuka@cesnet.cz>,
	<dev@dpdk.org>
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

> From: Mario Kuka [mailto:kuka@cesnet.cz]
> Sent: Monday, 7 July 2025 09.51
>=20
> Introduce a new ptype for identifying slow protocol packets.
>=20
> Signed-off-by: Mario Kuka <kuka@cesnet.cz>

>   * <'ether type'=3D[0x8847|0x8848]>
>   */
>  #define RTE_PTYPE_L2_ETHER_MPLS             0x0000000a
> +/**
> + * Ethernet packet type for Slow Protocols.
> + *
> + * Packet format:
> + * <'destination mac'=3D01-80-C2-00-00-02, 'ether type'=3D0x8809>
> + */
> +#define RTE_PTYPE_L2_ETHER_SLOW             0x0000000b

I'm not sure that we want to register individual packet types for Layer =
2 control protocol type packets, where the packet rate is very low.

Consider the endless list of vendor proprietary Layer 2 control =
protocols, such as Cicso Link Layer Protocols, Realtek Layer 2 =
Protocols, MikroTik RoMON, etc. The list would explode if we started =
adding these.

IMO, only data carrying packet types (IPv4, IPv6, PPPoE, etc.) should be =
registered as individual packet types. The rest should be sorted =
manually by the application.

