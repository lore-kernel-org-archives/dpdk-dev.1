Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B16C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 10:15:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75ABE40C35;
	Wed,  2 Jul 2025 12:15:09 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
 by mails.dpdk.org (Postfix) with ESMTP id C67CC40A87
 for <dev@dpdk.org>; Wed,  2 Jul 2025 12:15:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPEfWAwyFjPQrStGqbK/YxvB9ixPyTGDrTHmdJ+I4x1tq0vpEAHnBR1J21RV/Lrd16kzv5+hTgzwJwtKDyYBALIQJx+XiQTi49lfyaxIZQDA8D+n/FHPY1WyKMLRTe1aqahMl94wULrcrYCIGc/h+jegLdjLShrBqi2f3H+s8sN5/c705fcXwoo8rrdfptiHeWBB22QNew/ixhAKZnVSWyN+skhvgqiGsCcG6dkpa0W5OpmTBsGsSsCKboBhiv1QZ7Xb7x46Xz6MeuPshdYRU96s7LVzupYo/xf8Q0DUF8eBTwfXuRmp1RKznlwZuKX/tL3oxegf7z1XOqKbLviLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+osyZ9sFhstSXxVYcoVTe5XyDor2UPHYu3/cZIdtew4=;
 b=eOc+mDmoC5H9jouM0nZw4vbMLoP+8DUJgGnO5+LL6k3dWAxHSPypNTtLIx33qIz/j2b3BYxsTBQ2Uo2W52b9fmSLgjQv6ryP8hln4H4nVe23tidFCFTMqCF3ZFTP46+cWXNY0g40AJVLukDzZADtB3xnvH+ngy+DS3Lko4T96gZ01bpvVLEoDr4N7UkjFGZeobGH7iN1Ava4BHK4qe4MvlGrfNoq67QleLA9G/Z8omyTU8M2K5fQHMVt5Wrf2HJoveGz2IuZJMu2ZMLr1uquQJinpoVu+NWeI8KNMcYFKM5Z0U0x5BIh1v3Mn55ajkLPN2iD9lH3HHh3ICf8BCNPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+osyZ9sFhstSXxVYcoVTe5XyDor2UPHYu3/cZIdtew4=;
 b=RqPR6ZMcDBQADrpNNR/mEY0aKyGwgVTcBqgNsYMOSM6NT1rUgVd3z/GzPRPpOxsoxDtcqRRCTIfFyn/AP7Fii7xgey22opQ4HsIF4jMlSEAN32MOtQ9/8o4CUXl52jWU+xTB3CRjHCM9ErwyEEWErnNFw7pfizp0QnupwkZTFONhQepvJRkjSlOTbifij5lymlEdySb8RbmFwwRkw7DFQOo3RjE+GbmkQaKbdn/4qkFkukYy5He30U6sqpVLFjNugp/AeviI2xAA7dIzHa3DnfGX5F+MXw9bI6+vucIqMVGbDd6AhOv9S85DT7kBH2SgOc66DBhz6XASbCQFU8r3lw==
Received: from AS8PR04MB8979.eurprd04.prod.outlook.com (2603:10a6:20b:42e::7)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 10:15:06 +0000
Received: from AS8PR04MB8979.eurprd04.prod.outlook.com
 ([fe80::d766:4f5d:d928:866a]) by AS8PR04MB8979.eurprd04.prod.outlook.com
 ([fe80::d766:4f5d:d928:866a%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 10:15:05 +0000
From: Vanshika Shukla <vanshika.shukla@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
Subject: RE: [EXT] Re: [v5 6/9] net/dpaa: add Tx rate limiting DPAA PMD API
Thread-Topic: [EXT] Re: [v5 6/9] net/dpaa: add Tx rate limiting DPAA PMD API
Thread-Index: AQHb6nyBAKkD2p01/kOXIn1l96ARYLQdS1KAgAFT5fA=
Date: Wed, 2 Jul 2025 10:15:05 +0000
Message-ID: <AS8PR04MB897997C36FAE22B044E0DF6FF440A@AS8PR04MB8979.eurprd04.prod.outlook.com>
References: <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250701113707.2793004-1-vanshika.shukla@nxp.com>
 <20250701113707.2793004-7-vanshika.shukla@nxp.com>
 <20250701065757.1b41fe30@hermes.local>
In-Reply-To: <20250701065757.1b41fe30@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8979:EE_|PAXPR04MB8846:EE_
x-ms-office365-filtering-correlation-id: eeb4cf1a-d256-43fa-562d-08ddb95150ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EQ6VMyzExGuGkw3Y6QJ62tywRdqJCHZSB2oBqV+UrLICAPRf+9fgyw18I3qw?=
 =?us-ascii?Q?ETMIyYRKOq29JlCHCgy61ZRZcsOH0GNFP9MgW2oVCjxE/pFF8UtiYu5S3q7s?=
 =?us-ascii?Q?MQZ0cqOSYY6AMtxiW1elgyW5kHRaRSSAkRK4YuiTzVZVP5ff/DbIDbZhi8w0?=
 =?us-ascii?Q?nPQ+hKnluJyUFvL0Y7V4auyb7AoVhZNLuGkPYSVZesmQFCH48Qq4IydJYbf3?=
 =?us-ascii?Q?rPEKa/9i42WeWqDBK7zFkhp1RmZPhlZZcOZGDHV85qAztCRs+GW7xX7N5vuw?=
 =?us-ascii?Q?0YyTaTOt5bkqPpVXSgoisr8EqiOeLlmn3PXEO1wj7iej8mJ5NQDxX2rYcMln?=
 =?us-ascii?Q?4MqpjsmYVs7ByQepR+2d1wMpMOsXw7wNqDxUvVPcKgFwMHUfXEnqmRxH7Cq3?=
 =?us-ascii?Q?Exg5E/YY4jGPWXRoX67A5RzCFxSnDgZBymJMOcuEiYIiGRXSBdIpAmNHfxaz?=
 =?us-ascii?Q?ISb6gXlH8VWzFaBt4YXBeTGzl/mzk2s3b+d1CRl12IeQBCIevEgIqyYitZYH?=
 =?us-ascii?Q?cInblsStjPSaK+m/jSQ5/X0VGnMY5S1lNy7wNVGyD8JO1JcTtmMXzD2nCGaB?=
 =?us-ascii?Q?HFplp5LOLSW86c31GUZepJsP8izJhY6dwxNAfOU9ebMMSGaN3jtaLDBpylux?=
 =?us-ascii?Q?iT//yEm78naoiYf6VgyctgzojB/ei+3gCrv87yhV8GPDLNfl6967b0UwciNs?=
 =?us-ascii?Q?yWLXUogTr01GfGS+Z9F9TaoU4OFIN/00Er2MvSNisjKXiOO5DOHkxhBbNLCU?=
 =?us-ascii?Q?WlXlJwT5ZO/9Q8TTRSxBELO4rjmuw1WXEbsUiOvGhvzMsR7WHLrBUmCTolf7?=
 =?us-ascii?Q?m6vbeBxXbJJxOxRRCAzGAX5L56I1tS/i/JROYRsUewn69LTNYalTQ7TIIP2/?=
 =?us-ascii?Q?NPKCw8/dZ0K/5AHgvWNUhfRbEmnTmvZ8QLUk+Fu3glT9aGMUmOGGc7xRENH3?=
 =?us-ascii?Q?p/vWH46ucsfhLavP9NZLp80imHlsi9GOyI2KFLAbf8zvvSuMi16Jt58bHqKt?=
 =?us-ascii?Q?e3crGwE2xUiVLgOqNg4oArLgnAk0X1YsNvi8McnUPBakOzASUekWXxNhrCgF?=
 =?us-ascii?Q?AyeiG9QluJTiPflCxY6PAois1Fi/8hjYLAt/uejewXY6NFA8PSaOeqSxbgoQ?=
 =?us-ascii?Q?DlkqBhI6KJu+aneGZjcqpnjV/ot62T5CD8Dncc7V82o5AXPGjCn53UiuBMFd?=
 =?us-ascii?Q?nNVYCU4AShPLTMfifkn/cQA4dLOlUTexrelU+1ZJhitb3bVR6v9D58O0MWwv?=
 =?us-ascii?Q?Dl8ScriwWSUGYsYRwKlB4/akFD0ikD0UGS5v9rCLnEdh6FJXKZTNBBdPyHJU?=
 =?us-ascii?Q?Oyih1RjanqXUOlU6TNtzMXp2lkaa1Eir4a/1aJKPWCQA9HjG0ahW+d9ttuhU?=
 =?us-ascii?Q?cAxTRUD6gQewqBrlIz1WCeweBO+GyMwPO1XJY3YN0cVY7eZFgzLouIu4fDxq?=
 =?us-ascii?Q?XRTEwzQ95b5MsY7hECU8OPPEpU8NYPascwDLkUffa6hfiCTfa0MKzKB0Hmpn?=
 =?us-ascii?Q?tvSwlu5dBXAgfe4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8979.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HFKD3sfAVaFNWgZbLOrlAq2MsXsRXVvBkq4MtCweL3wGeA4RRc1gmaWX/tDs?=
 =?us-ascii?Q?5nI3hkGVGyMYR703MHNqpv8288xt2IgUz3/6cqkjM4fBmS7+QPQ1BovmXNIe?=
 =?us-ascii?Q?xn11D6lfJ8g5AJzbdYjC6GKb0Bbl25+n8lfwkFoiQWonJ22Q5zYbq4Hw/+kx?=
 =?us-ascii?Q?JkqFzef8YKnaP5P+6+zwSNmIPLvNrbvYsbP8sTQ+sGSzhLKkI155pQY0wxNB?=
 =?us-ascii?Q?QelhPF5kbJR35zE4nVCo6pya8z0CKoAx32/CIY4eLbtSNYA73meM3w/awwwl?=
 =?us-ascii?Q?tLcn7Iht0xB6t+eNVMM3uryG+fkvOqI+oyphlSJAPuswxk2XsMTCFeTDPIuP?=
 =?us-ascii?Q?A+hL1Dfo+djG471tvHI5egW8J576JWVYFRXuTJli9XYuWDDUE+Dqc7UvRFIm?=
 =?us-ascii?Q?fQl2jlydOj9iNxW1P+MCPvuxU0xpLkNqI67MMjiC1xCS1mTsvpryuXRb+DvJ?=
 =?us-ascii?Q?FTCXEILSsMu11a8L59QV2pP1DWTMdsvahD9P4NcFqF4AjfwOyX2vG4mUsD4L?=
 =?us-ascii?Q?CsTYVIyrzXw8Rnp7nQLv11P6/+Ch2dIpxioq9VpPv6CsCb1zlgGHPH9SXCAe?=
 =?us-ascii?Q?2clRZdYvtVXvrWd3Zsz12igRtcZKpV8v0f+pamXAvbp993dLCbgDqEWS1utJ?=
 =?us-ascii?Q?OV5IXhyS2FnjxzoyA4TwyFFqztmxGrFLZfRsjXXRJ2BRqcIv/0A+APF94U2y?=
 =?us-ascii?Q?Eqa/ThU1u1pkgrCYenpvzwLOsopf+6MJDE1hBc8Kll5RyAicftXz2HH3Ilb5?=
 =?us-ascii?Q?xar1ItrgXPmJTE5VuLBkCAhSvUU13owpkvuq0S2WoUaQ9gdjI3IIz2fXJyBy?=
 =?us-ascii?Q?O9oMIWtyfQkgMaRicQwPKrg2Nrh1UfgoWP1npEthqPYHejVJkN3dIJwGzW66?=
 =?us-ascii?Q?uh8hi/ry3cJP80uXX0QJRZe9bJKOuxtLoUEdx0a6IzBX6cM6h/FVTyHKcPWc?=
 =?us-ascii?Q?BiVjJZiYkT+agMJSGABaVE/enSa46b0qp78XSzKAWI9HGVfCOvOfyyBw+04P?=
 =?us-ascii?Q?wckOupd4ONt+4T8tJcLTCgc4RErKQ3v3Pgu0ij8TnpaVJjE5uSPh/2qQo7kn?=
 =?us-ascii?Q?Pws0wJe7AXBm8huJmibjj7mkT2SYdUNvjh0Mk3ncmkonbkS813y0AQzohm5T?=
 =?us-ascii?Q?xHNq/44mMVDNJCH7iIzPJasB814YNvozuA67Ndo51jXu4zL0Xo41Wbb2SF3T?=
 =?us-ascii?Q?8XW478mWVeKfJKihbLIkGq4UYSceDzMgq1MlvJgDrPlRjx9hyD+BEAuZ3DWk?=
 =?us-ascii?Q?68il8FGds8eiKkntGC+N0MmUPRWDG6JyGKq2wlbIU7ta8tjQ+6IOcgP9lgAD?=
 =?us-ascii?Q?CNNRcIdfckFCU+ZlxH5SDVDDgptrsdxgdXtEm/bEZ0gVfO2IKIIHfx3QR+U+?=
 =?us-ascii?Q?o8ndm56BYIHU+EcI14/9evaufTI+fuM1WIO1xTl15XRaU6SMQa3Ut+bAxQzh?=
 =?us-ascii?Q?53J90ej/1JVvJNGqrDpJikYbzT87pPazTyW7pB584lL+yz30ENFUeEbOMjCU?=
 =?us-ascii?Q?11RCgJCCSRNNS1OvUyk0XboBHVOFzR1ceH+gD6KESAtdV1e3UbbL3zkRuD1Y?=
 =?us-ascii?Q?loMAXKHX63XoX/tlDhNWZCbYEr2U93CduyIGIXob?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb4cf1a-d256-43fa-562d-08ddb95150ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 10:15:05.8461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3aL7hkQ9em9xZl2O3LDDBWftfYyuUc2EGCNQEBSJZhdCHi5l/BXzIQc7GvRzhFi5yF4eO4DCa3RzYoUx83fVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846
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

We have dropped this patch for now. We will submit it for the next release.

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 01 July 2025 19:28
> To: Vanshika Shukla <vanshika.shukla@nxp.com>
> Cc: dev@dpdk.org; Thomas Monjalon <thomas@monjalon.net>; Hemant
> Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
> <sachin.saxena@nxp.com>; Vinod Pullabhatla
> <vinod.pullabhatla@nxp.com>
> Subject: [EXT] Re: [v5 6/9] net/dpaa: add Tx rate limiting DPAA PMD API
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue,  1 Jul 2025 17:07:04 +0530
> vanshika.shukla@nxp.com wrote:
>=20
> > +/**
> > + * Set TX rate limit
> > + *
> > + * @param port_id
> > + *    The port identifier of the Ethernet device.
> > + * @param burst
> > + *    Max burst size(KBytes) of the Ethernet device.
> > + *    0 - Disable TX rate limit.
> > + * @param rate
> > + *    Max rate(Kb/sec) of the Ethernet device.
> > + *    0 - Disable TX rate limit.
> > + * @return
> > + *    0 - if successful.
> > + *    <0 - if failed, with proper error code.
> > + */
> > +int
> > +rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
> > +                              uint32_t rate);
> > +
>=20
> Too late in 25.07 cycle to accept new features.
> Please resubmit for 25.11 and either figure out how to do this using exis=
ting
> ethdev API, or mark new function experimental and add test-pmd case for
> it.
