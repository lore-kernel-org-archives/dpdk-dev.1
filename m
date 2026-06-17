Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045F6CD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EE004027F;
	Wed, 17 Jun 2026 13:48:41 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6BF8940276
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:48:40 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 31DF3201E4;
 Wed, 17 Jun 2026 13:48:40 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v1 0/5] prefix lcore role enum values
Date: Wed, 17 Jun 2026 13:48:37 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260617102834.2343356-1-lihuisong@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 0/5] prefix lcore role enum values
Thread-Index: Adz+RGnh2wA+8nooTuewF4oluTUqhAACr7Sw
References: <20260617102834.2343356-1-lihuisong@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Huisong Li" <lihuisong@huawei.com>,
	<thomas@monjalon.net>
Cc: <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, <zhanjie9@hisilicon.com>
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

> From: Huisong Li [mailto:lihuisong@huawei.com]
> Sent: Wednesday, 17 June 2026 12.28
>=20
> Add the RTE_LCORE_ prefix to the lcore role enum values in
> rte_lcore_role_t
> to follow DPDK naming conventions.
>=20
> - ROLE_RTE      -> RTE_LCORE_ROLE_RTE
> - ROLE_OFF      -> RTE_LCORE_ROLE_OFF
> - ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
> - ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL
>=20
> Old names are kept as macros aliasing to the new names to preserve
> backward compatibility.
>=20

Series-Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

