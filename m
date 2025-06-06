Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB57C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 09:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C50254068E;
	Fri,  6 Jun 2025 11:54:58 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 026044068E
 for <dev@dpdk.org>; Fri,  6 Jun 2025 11:54:56 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C3D3520467;
 Fri,  6 Jun 2025 11:54:56 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 1/1] ethdev: add support to provide link type
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 6 Jun 2025 11:54:52 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCD0@smartserver.smartshare.dk>
In-Reply-To: <20250606092904.3145608-1-skori@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/1] ethdev: add support to provide link type
Thread-Index: AdvWxXpMUAYtLOyuTLuZ1xoYbQhUSQAAeI0g
References: <20250605113159.3035480-1-skori@marvell.com>
 <20250606092904.3145608-1-skori@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <skori@marvell.com>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Cc: <dev@dpdk.org>, "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 <jerinj@marvell.com>
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

> From: skori@marvell.com [mailto:skori@marvell.com]
> Sent: Friday, 6 June 2025 11.28
>=20
> From: Sunil Kumar Kori <skori@marvell.com>
>=20
> Adding link type parameter to provide the type
> of port like twisted pair, fibre etc.
>=20
> Also added an API to convert the RTE_ETH_LINK_TYPE_XXX
> to a readable string.
>=20
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---
> +/**@{@name PORT type
> + * Ethernet port type
> + */
> +#define RTE_ETH_LINK_TYPE_NONE  0x00 /**< Not defined */
> +#define RTE_ETH_LINK_TYPE_TP    0x01 /**< Twisted Pair */
> +#define RTE_ETH_LINK_TYPE_AUI   0x02 /**< Attachment Unit Interface =
*/
> +#define RTE_ETH_LINK_TYPE_MII   0x03 /**< Media Independent Interface
> */
> +#define RTE_ETH_LINK_TYPE_FIBRE 0x04 /**< Fibre */
> +#define RTE_ETH_LINK_TYPE_BNC   0x05 /**< BNC */
> +#define RTE_ETH_LINK_TYPE_DA    0x06 /**< Direct Attach copper */
> +#define RTE_ETH_LINK_TYPE_OTHER 0x1F /**< Other type */
> +/**@}*/

I don't see the use case for this patch, when only ancient interface =
types are defined.
How about RMII, GMII, RGMII, XGMII, XAUI, XAUI4, CAUI4, SFP, SFP+, =
SFP28, etc.

Please don't blindly port stuff from Linux to DPDK.


