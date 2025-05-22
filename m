Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111D4C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 03:31:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B52354027A;
	Thu, 22 May 2025 05:31:39 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
 by mails.dpdk.org (Postfix) with ESMTP id 8BA2F40144
 for <dev@dpdk.org>; Thu, 22 May 2025 05:31:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDdiAm4YEhTyChgU1nDWm4wWHqxynrbXav/sYd2uKP4c2BrtiL+KEmCK+5ikEeI2rmXyxfAE5CQWq1BT7iDZcviWPQJdGfXpeFmY0unowy/Fgb3m1MJW9Is0D9oAQdzLuJAgt6npipsdoWPvKEv17MFHtmR9J6iFnT/1GWSVMS/mpSoPxn1ROhugtB4iAEs1aIxwPWvoRjwXuKyqvL/W3s2jsTzjPOo2ksooTpfbMrn/T6q+53sYMOv85xri7/cdMaido8yr4cKnbSfpVK3o3Zy6Jq0pzZOnONTLoa5GgnbnU4MiaXAbEQoilpwfvgkJvL9muIoGaK5cOOS0KmxT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zOO9zPksl1ActhtDi8KypQlsjZ6cyUUYAWD21UPoF8=;
 b=EQNPA6H6EUYqV2sPpqfndoa9FRmddThtT6uBdx1QqJS46qwxYQWwRlfQfZ/VNzSlropj5Rxn7RrqedjMSrEpEOTXqRo6Mcp59G7IfG3Z9XA15qdjvkJFBMU/cvhktXkO0YUKWByWiAjG/wARnuKwE4S25+6LOUYW4FD5cJ7YT/7wVY+lqE+p/DyRS49Lbod1pPHInyF+IB+kwV9s2onKeyAglCHbV/ZkVOV8p3Jq8c6OXL0snw2J3Hc4xi4/db2iUbLBh6eYGs9AVnZUna+zLw60u0HJdeTNiZLjj/6GDy+ktsJvuFfSdFbYUTl9dznZUFBhLpgzOZ0WcXUTy8dNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zOO9zPksl1ActhtDi8KypQlsjZ6cyUUYAWD21UPoF8=;
 b=MLju948S6XffxHt7LlF5v78E4avvjU4GGq5BMAZmkuguDKK21GlFRb5Y06ZEAG0qQI7u5MXsryPGeqWaC2gLnAQ9FEsoMeoLdbRK3VDx7lpwImzuiU4reMu9UGJhEXpT/w7CkIpDs6HhL1wMYqDZIshg/ZJ+zj1zEf4p5yejf34Y3PtgZk/lv8p3BqmaerPSJBDo4cSWqQrna+UPQz1hQk6rDVPXGhanZjhlDmr1e7/fJSiYKPU7srNsKekBJ6xwRkKLGC9FoKQZhJ2QqUBlkmOcOyIRJ5MKZzfeYe1poBhhnvpLHloF4ng0Yoo/FI5tGnFKIGWxYW8JUWlcGE7izw==
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB7703.eurprd04.prod.outlook.com (2603:10a6:20b:23c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 03:31:37 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 03:31:37 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [EXTERNAL] [PATCH v2 0/9] DPAA2 crypto driver changes
Thread-Topic: [EXTERNAL] [PATCH v2 0/9] DPAA2 crypto driver changes
Thread-Index: AQHbyh2UrG1jMT7uEk+Vku5S6eAAprPc+2IAgAECs0A=
Date: Thu, 22 May 2025 03:31:37 +0000
Message-ID: <AS8PR04MB8198984B70F1BDAEC88F55FBE199A@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
 <CO6PR18MB4484957133F63EF2E58F9169D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484957133F63EF2E58F9169D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8198:EE_|AS8PR04MB7703:EE_
x-ms-office365-filtering-correlation-id: 078fa294-aa59-433d-fe0d-08dd98e1289e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yymDX/1V+jybDjDU3h50Iwy3jw5X4ja7nmojiXVmMEcmicTDpA2snVw4oN7c?=
 =?us-ascii?Q?x1/EnOK5ncSe/R9DiEviGWbM2+ztYsLNdJSVzsOgcIj2lFmHJZR1VP5cxpCG?=
 =?us-ascii?Q?mBp4C7D/B3XYM355ydz0mAwaouxKbncJcq9PN93gpcehvCfLC3P88C3CYzZd?=
 =?us-ascii?Q?btEqQIJYvsUqSgLzPgVNqDeUxlBn2+nmcd1y1C8i/lzalb3Gx1OYHqQqJUJb?=
 =?us-ascii?Q?1NUwsI4LI/fToPuxq7jSNy4AVPhr6hK/CEasLzvbZLqddo4rfRMvsm7Rm8N9?=
 =?us-ascii?Q?IrSFEpfAlQyMlFahn9Jq4lkZDXsUvROOnafPIteg+60x42+EsbWJqZxIWfpB?=
 =?us-ascii?Q?C+kIbkCd2KsRmU9rK/pm/pi2ysGRmetBHVeYRLT5Rt+MiXCFbha2MdO217f2?=
 =?us-ascii?Q?yZXCSYW8AVQ6uv9NDl8gMUfzs7d+HTkXTE12P+DNn5XQfBU5oWgoDIm9skKC?=
 =?us-ascii?Q?ygGdxA1WgFBXTWjEUH+DEzHXj0/DFDbM7rA/+r2j7CVSxldpTzqniTA+2hLj?=
 =?us-ascii?Q?7qdMdNUd4fF3KrE0Qv54LZNiyzPHpVl5kLoftr1bpuNJq6uQ2Ov8q3K2FJOn?=
 =?us-ascii?Q?wCpRxh/gAabSA63ItafRK7vcFJVhPflHOoH7iY3E+EjIyufkU7vonM8OMstZ?=
 =?us-ascii?Q?cfGrsx1GwbeV8SollTL38si8kvhqXX0vFtsA4OuS04E+xDQ0b5Qtk3ApsJ/h?=
 =?us-ascii?Q?hq/Or79aUhsDxEGt/mFUXrqpq9xvyT/ccda01ZfvIhm4Wd7pA9vMPeeJFfZF?=
 =?us-ascii?Q?XRaWpkMHFo6amc4v9+t21FDfl28F8pixuxdx2yvzJsyZwMJqHhzeoJ4e52I0?=
 =?us-ascii?Q?6FV2gMtSiOBuca5JTuv8S6UFrMMaEBlKyRbXOYezHn60tvKVFMNI8N4XNXXS?=
 =?us-ascii?Q?UyZoHjl6y52uEWoyA2fEqH3EYb7b4mG1Y77DsNkB79Gfbs8eVQtEEjfqHSTy?=
 =?us-ascii?Q?5dLhwuJAN8efQyOjlvrcrM4hjON3t2ploYJKiNY5bUN1t9kLhUhPDGgGjkgV?=
 =?us-ascii?Q?QY5b7cg2OwCT+5BtXZVUkSJ7QxPsgRGu7Vm4JksJKFL2hVW1ejg5oEcaFJt/?=
 =?us-ascii?Q?UVIah7xMwmPPiQ+GeoAMzorzkhUUbL/SP4H1IKYnKqPhHRixxP8wMwdSR0qY?=
 =?us-ascii?Q?p9i2gA23Ky9HPxOVEBFBofhzcBwraDY/TyEVZErkQMitgMlXlBSoL1SUCBmq?=
 =?us-ascii?Q?XKsmIRcc+uMq0BZ/282kthjOKhczcu8DysqYnb/ofWJPhU4IyzQeq4jQH3Li?=
 =?us-ascii?Q?TYlSqFgtyNxNdtMfYuaECcRP5/GRxdknsfCADbso/0NoR0gUrh+3vpXhCt4A?=
 =?us-ascii?Q?4JQn+/e3nZ1gtH5ahVTKgSFs1Y0XvxE8FRTlQ9Ztvwb6p2jb0IerCrWDDEcq?=
 =?us-ascii?Q?gY4muBzNn1aE1mZfzW2J57uaNq2eWvsn4ckIFCStDgMX8jtHXDtQsH7n+pem?=
 =?us-ascii?Q?9bt0EHSiPmT2f/NfhzHqeUYNmZ/1AP7pdvRasYuIDKwf9VQTguR85w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eARQQyjfcXveDE7VvqjqcZ4nKt9JfCfo4zicqQ5cBoIuyssYizWautBaexo7?=
 =?us-ascii?Q?TJIUtL2UdlMQYq4eNq0ao+GrFZoUBtmJBQREEKfyGicxpAWWTXQNJu3xm2v2?=
 =?us-ascii?Q?rrWWkMKqG3/EKnsdHyjVMW0j7sq/r9cbmEFKyoNS/pDBTWzFWwN7EdqCIWaD?=
 =?us-ascii?Q?9wXAWZUBQ3Pa2mjrJkHDp5LsWOcwxAN1H+FtZkjbHncEva5MHwaNclxclEy/?=
 =?us-ascii?Q?SShSBvhp1vW/XPCrgDjR9qi+/mMdjJH5cW6saXqIrujNwt9HqpM58P5YtLD+?=
 =?us-ascii?Q?xmXyAC89ouOMYS/JFmLglaOXnVvWkbgSsHtySK9DG7Wfa/ZEDc/dlakBlaka?=
 =?us-ascii?Q?5RFUqOwGxb6nrF7lPCPXRYprQMYP/qgQNjODWAqaysUBvr6SM2n+D1tovQ80?=
 =?us-ascii?Q?djgx+3UsuJfRg43xfLO2iICBsCbkWbQLgq+vjM0NTijnT3TDftrqXV0sacWT?=
 =?us-ascii?Q?3C+ed75GL1Gkxg/xITuz2TWvXJ+dcl27FB1rQsWKIPwpqZiMPWAvaEIENkUu?=
 =?us-ascii?Q?JsZLI9FXDfBINwubZc0DeSMQ6pBDuorEYQ7NaPyQ2Urxm/2t+RAYga67jAMc?=
 =?us-ascii?Q?7BNtA9cZot3AVosB1odhKg9Cedw9dSARfZCtIeBtKd6DGg8/wLSohb1fkRbG?=
 =?us-ascii?Q?EfPAmyz1WFkRUsl8yiQAVSZP09WbPlks4AvN2gHNPIA1F3P1fu3xvm0auG0N?=
 =?us-ascii?Q?RLjKJF0B0fp1F5YjyotGw8rQEKmq+c6A5NFagpzoNGeB+ts+UxBINLuNpQ/1?=
 =?us-ascii?Q?dQZeYP/KUxG5uvxpAkVw7a0l6Igq0WDs99i9RR6lgUzGLpe+6OaJSBXYLWxN?=
 =?us-ascii?Q?OPxjNVp3FL6RlsQP4Bgz1QmtSLdN9huWMYPoCk96ErapsJ5bG7EktGuynZA7?=
 =?us-ascii?Q?cGLcdkKt+5NB4IkMP1cKyzei+Js6mr9kgPGL7wGZ+D17U13U8sxeCdO9cAjD?=
 =?us-ascii?Q?LxV2yF3qYBoecCWOabCmRGTF3JnikPshYLt/a47H9sdUOguIBJ66kRUQPWiK?=
 =?us-ascii?Q?EbL1R4+ZUXDJRTbjCPLOFDoAIdMfPf7XhXTLjsXtG3z4XbpEG6NoHF/YRtDT?=
 =?us-ascii?Q?IiQ8diZM7Wmjtd+iEjkW1PwNI3wr3f3yGQw1MK1LRLataTeCTmgMAIWSjDFx?=
 =?us-ascii?Q?GGaJ9QgdjP2NRckJ02AoT2uuQQPk5hDuKUfWmQVQdlZSDXwtLkKBidHpS0fa?=
 =?us-ascii?Q?Mhn82yTJKyMbCUD0+qTGUwozR8pNbukLncQL7S7cS2svQSTV1014cwc9R0Qo?=
 =?us-ascii?Q?Op9Ro6submP7xYWgY3+Ajh4EM6+lCKnvA280B+3qHuDCrTuJwC+7A27HnmY9?=
 =?us-ascii?Q?jmG8izwvJb8Q3c8FL1CA+t6IhID5qoHW7fHCA+qLn2cyxnMmeYAtUGCXQtRm?=
 =?us-ascii?Q?C4JEuw+eboMO1uqlqEaUeGTNGeo6zrPpPoUePkzHaEyAhV3zdTPhDuQWI7IC?=
 =?us-ascii?Q?UmedGkSjG23+dNOmsiCz+PWj688ebdUb7U0sUSMT67JCHihus6HV0x//d+e1?=
 =?us-ascii?Q?QxRKZ0ID5z06cOnPFbE8toyZEApyirZR8hi2/XqzlE007I+ZWECS3R1GFqgW?=
 =?us-ascii?Q?IVasAHZ9PVUtb66r8Ck=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078fa294-aa59-433d-fe0d-08dd98e1289e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 03:31:37.2446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIDSAZGCDIw/yfnzlTs23LnECDF7edveUZzsmtUzPLbpl4vqYAGjAftofp48/+lo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7703
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

Hi,

> -----Original Message-----
> From: Akhil Goyal <gakhil@marvell.com>
> Sent: Wednesday, May 21, 2025 5:30 PM
> To: Gagandeep Singh <G.Singh@nxp.com>; dev@dpdk.org
> Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
> Subject: RE: [EXTERNAL] [PATCH v2 0/9] DPAA2 crypto driver changes
>=20
> > V2 changes:
> >  - fix checkpatch warning
> >  - fix 32 bit compilation error
> >  - fix a commit message
> >  - update document
> >
> > Gagandeep Singh (5):
> >   common/dpaax: fix invalid key command error
> >   common/dpaax: fix for PDCP AES only 12bit SN case
> >   common/dpaax: support 12bit SN in pdcp uplane
> >   crypto/dpaa2_sec: change custom device API to standard
> >   crypto/dpaa2_sec: add null algo capability
> >
> > Jun Yang (3):
> >   net/dpaa2: configure buffer layout
> >   mempool/dpaa2: mempool operation index
> >   crypto/dpaa2_sec: add support for simple IPsec FD
> >
> > Vanshika Shukla (1):
> >   crypto/dpaa2_sec: fix coverity Issues
>=20
> Split the patchset for appropriate trees. There are patches for net and m=
empool
> which will not go in crypto tree. And I don't see them as dependent patch=
es for
> crypto.

The patch "crypto/dpaa2_sec: add support for simple IPsec FD" is dependent =
on
both " net/dpaa2: configure buffer layout " and " mempool/dpaa2: mempool op=
eration index ".
using API " rte_dpaa2_mpool_get_ops_idx " and Macro " DPAA2_DYN_TX_MIN_FD_O=
FFSET "
defined in these two patches.
Without these patches build will break.

>=20
> >
> >  doc/guides/cryptodevs/dpaa2_sec.rst          |   2 +
> >  doc/guides/cryptodevs/features/dpaa2_sec.ini |   2 +
> >  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h      |  10 +
> >  drivers/common/dpaax/caamflib/desc/pdcp.h    |  31 +++-
> >  drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c  | 182 ++++++++++++-------
> >  drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h    |  45 ++++-
> >  drivers/crypto/dpaa2_sec/meson.build         |   3 +-
> >  drivers/crypto/dpaa_sec/dpaa_sec.c           |  42 ++---
> >  drivers/mempool/dpaa2/dpaa2_hw_mempool.c     |  20 +-
> >  drivers/mempool/dpaa2/dpaa2_hw_mempool.h     |   5 +-
> >  drivers/net/dpaa2/base/dpaa2_hw_dpni.c       |  18 +-
> >  drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h |   6 +
> >  drivers/net/dpaa2/dpaa2_ethdev.h             |   6 +-
> >  13 files changed, 263 insertions(+), 109 deletions(-)
> >
> > --
> > 2.25.1

