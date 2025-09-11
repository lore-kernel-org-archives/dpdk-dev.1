Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BD5CAC58D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 09:41:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEB97402D3;
	Thu, 11 Sep 2025 11:41:45 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AD15A402C4
 for <dev@dpdk.org>; Thu, 11 Sep 2025 11:41:44 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 528A920CE7;
 Thu, 11 Sep 2025 11:41:44 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH v11 1/1] ethdev: add link connector type
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Sep 2025 11:41:42 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FEE0@smartserver.smartshare.dk>
In-Reply-To: <20250911084943.2383151-1-skori@marvell.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v11 1/1] ethdev: add link connector type
Thread-Index: Adwi+QtzjHWz3vtgRDqdyctpsL7ZngABaqrw
References: <20250908085256.1866407-1-skori@marvell.com>
 <20250911084943.2383151-1-skori@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Sunil Kumar Kori" <skori@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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
>=20
> Adding link connector parameter to provide the type
> of connection for a port like twisted pair, fiber etc.
>=20
> Also added an API to convert the RTE_ETH_LINK_CONNECTOR_XXX
> to a readable string.
>=20
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---

[...]

> +* **Added ethdev API to get link connector.**
> +
> +  * Added API to report type of link connection for a port.
> +    The following connectors are enumerated:
> +
> +   * NONE
> +   * TP
> +   * FIBER
> +   * BNC
> +   * DAC
> +   * XFI, SFI
> +   * MII, SGMII, QSGMII
> +   * AUI, XLAUI, GAUI, AUI, CAUI, LAUI
> +   * SFP, SFP_PLUS, SFP28, SFP_DD
> +   * QSFP, QSFP_PLUS, QSFP28, QSFP56, QSFP_DD
> +   * OTHER

Please use the string names, not the enum name, here.
E.g. Twisted Pair instead of TP, and SFP+ instead of SFP_PLUS.

> +
> +    By default, it reports ``RTE_ETH_LINK_CONNECTOR_NONE``
> +    unless driver specifies it.
> +
>  * **Added speed 800G.**
>=20
>    Added Ethernet link speed for 800 Gb/s as it is well standardized =
in
> IEEE,
> @@ -124,6 +144,9 @@ ABI Changes
>  * eal: The structure ``rte_mp_msg`` alignment has been updated to 8
> bytes to limit unaligned
>    accesses in messages payload.
>=20
> +* ethdev: Added ``link_connector`` field to ``rte_eth_link`` =
structure
> +  to report type of link connection for a port.

connection -> connector

[...]

>  /**
>   * A structure used to retrieve link-level information of an Ethernet
> port.
>   */
> @@ -343,6 +382,7 @@ struct rte_eth_link {
>  			uint16_t link_duplex  : 1;  /**<
> RTE_ETH_LINK_[HALF/FULL]_DUPLEX */
>  			uint16_t link_autoneg : 1;  /**<
> RTE_ETH_LINK_[AUTONEG/FIXED] */
>  			uint16_t link_status  : 1;  /**<
> RTE_ETH_LINK_[DOWN/UP] */
> +			uint16_t link_connector : 5;  /**<
> RTE_ETH_LINK_CONNECTOR_XXX */

Please use 6 bits instead of 5, so it is more future proof.
With the connector types already defined, 5 bits only leaves room for =
six more connector types.

Remember to update the value of RTE_ETH_LINK_CONNECTOR_OTHER from 31 to =
63.

-Morten

