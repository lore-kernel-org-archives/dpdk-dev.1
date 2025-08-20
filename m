Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26485CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 12:51:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B699402CC;
	Wed, 20 Aug 2025 14:51:18 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C74614027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 14:51:16 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7E7C020F9E;
 Wed, 20 Aug 2025 14:51:16 +0200 (CEST)
Subject: RE: [PATCH v6 1/1] ethdev: add support to provide link type
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Aug 2025 14:51:13 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE56@smartserver.smartshare.dk>
In-Reply-To: <20250820111350.2992591-1-skori@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v6 1/1] ethdev: add support to provide link type
Thread-Index: AdwRw4gTy+MUBbJ2SgGW0jIoMbuKiAABHDlw
X-MimeOLE: Produced By Microsoft Exchange V6.5
References: <20250819055126.2745262-1-skori@marvell.com>
 <20250820111350.2992591-1-skori@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <skori@marvell.com>
Cc: <dev@dpdk.org>, "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
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

Search-replace link_type by link_connector in this patch.
There are still variables, functions and other names using link_type in =
the patch.

> +/**
> + * @enum rte_eth_link_connector
> + * @brief Ethernet port link connector type
> + *
> + * This enum defines the possible types of Ethernet port link =
connectors.
> + */
> +enum rte_eth_link_connector {
> +	RTE_ETH_LINK_CONNECTOR_NONE =3D 0,     /**< Not defined */
[...]
> +	RTE_ETH_LINK_CONNECTOR_OTHER =3D 31,   /**< non-physical interfaces =
like
> virtio, ring etc */

For clarity, please add to the CONNECTOR_OTHER description that it also =
includes unknown connector types, i.e. physical connectors not yet =
defined in this list of connector types.
So CONNECTOR_NONE is only used like a NULL value, and not for any other =
purposes.

> +};
> +

