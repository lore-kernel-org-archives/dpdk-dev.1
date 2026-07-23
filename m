Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5097BC531D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 14:11:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 714024067A;
	Thu, 23 Jul 2026 16:11:26 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
 by mails.dpdk.org (Postfix) with ESMTP id ACA4B40679
 for <dev@dpdk.org>; Thu, 23 Jul 2026 16:11:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfxneJio4QZ6AUBtZbraUIkNuZAfDc97tZ2/pIBYICKNDsWNKfY5C0GYRjP/V+cyMexjhOYOXQapuxtZGxGWmOdo8a3iNdvY7WctbBH2B1e52J9vIwQQtKlbKKGRmGKQik+7+9J3fm6N45IwgrgLCj7VX7dCVeFX6iZnATgqdP3biWARh7FZlIhU8RRjcCACDp8lSkSxIs9iA6fjCA4hrF35MdNM4Vty81HfrnDMELlB7Um2NVy1zRs+WPqR+x3zvAVqkZYWzNSByMJg7ZmdNSAAyE1DQc82nxpcAYe3fBJwGn2YgvHo109ZuMKf5NTDzG8YkSgAJKTxWjPZ4u7XgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkMp3HBuHjh5+80AuPD2xf/Uu8e55gASrZ7tY/T61w8=;
 b=k78Pkq389hkdLIRoObdhMJiKN0z1cp4ZZY0+d2eUmisnw1ci8uwwl8WnS5rWUROdmSupgSrBsdIFuxEUygQcxXCR6XrXVE6e3iA1uj172BYqN4afRG8JdYBThUOzDguWoQcSNwyPDyDfeHun7sXtjgWbdZt32y5dLLHL4deA6z2w9+NFMlW8yxLuVjYJr2gYMGfj7akvbpmcFNPB2Yax+Pi+9eidB5O6Hz48hHNEcx3S+b5Hdkr9KktQKY1Wyn7QwgRqdQP3gDvB11Lr2taR4gLTKhcI51hFWM/PzB7eNWW6kNssLvW3gh+kbaHuq56O8oy9LnnE5bWv8jwE34aPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkMp3HBuHjh5+80AuPD2xf/Uu8e55gASrZ7tY/T61w8=;
 b=OTUQZLFjtH0lMmqj+MTA0/g+bqhsCb+o0hIECe+Pn4u0ZtsqCYcdcfoTqlSXaD33KWVh8bWVZe26kQ58EB9fl4s8qTyyQspJRNODUoQCyNUvnA5z5hbuNamWygIjMwZuO0mq4V1jDyCeso8QEXjXYuZ+M+fab7eS6gHPXk9MhdGWKRLQMIUH6kPHf38giT79yHgcHhdFGYlChq4Or0hDweqlX0GeHoQKfuzxxY0UcEfWYczvHh1V5bY+mBlD9Ugp8uZmHagMzNELwB3x1DtStzedYjkC5D9YdcqeG6IX7aaihOub97JMZti6v0N5nnTaNN6i1llucWHklFGn/0SmcQ==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AS4PR04MB9649.eurprd04.prod.outlook.com
 (2603:10a6:20b:4cc::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 14:11:24 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 14:11:23 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC 00/11] Device unplug and bus cleanup refactoring for NXP
Thread-Topic: [RFC 00/11] Device unplug and bus cleanup refactoring for NXP
Thread-Index: AQHdGqrBQQdTguvFZUapKxk3t1yEWbZ7JNnw
Date: Thu, 23 Jul 2026 14:11:23 +0000
Message-ID: <GV1PR04MB10750F000EEB3E024D8BB456C89C02@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|AS4PR04MB9649:EE_
x-ms-office365-filtering-correlation-id: 89f8523c-0227-4827-8279-08dee8c44726
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|10070799003|23010399003|366016|18002099003|22082099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: lTyU3x2uuegfmURnk1xF6+E5ue8hmtV8wsFMcmET5dqtBDJ3BCeqjsvw7PuZeEhIWbNcSfGB4GUGYW92+5qRoPkUNaBSC5TH9xFupK/WGzW52xQcrL0B0camuIz5mGcGsJ+edBtopl2R85Iu9A4P1oUDBzQSEenJbmcyMUniBhps73lfokgDO18LCg4/2ZZ5RIJWapj91RCv87UKsbi2c12Wg6gh+kjhe2TiwE1dQU0y1IciYSbUNzJLkPJyD6xkblUwcS0DofnZvxfpZB1gxNTBchrjZMvscBlEGTfSnwKstz0BlrsMroBd8+yCk7WWsjBQl1QHjY5gMH0aouUd2NWZw6GmsPCinzkcoyGlT2OxQ7gAhF7D6nN9YKAv3DLzn1sQJ0b+7CefA0t39jE8XDw6vaxEa/M36v1Aem0yOmHG/lVAkY8NCwrIqXDn78v3/Jk4k27A0g9c1VuXH4V+PPkwB2EUp4OGRyfAJzxkYdD8E8HTpx6MTATVKqK4APwaFiMm+ajQQ5CEJm1nlE8vEpIhasickp+Tnk00XvFBL2nYn/ZHMri68Fp1fy93hIZrbXGGASDEtMQ2Q5l/FpbtnZQgpt3kyaMGKm3eC0plhuFyw4lpXSFsDBaRByWB0X+qCPCcR5/xHmSX1WwoqQ39TTYzTZAMUbBTJSK06ZVaq4mTv0vWcgVZSW4AsBmsrcALGOMHR+35IFuHgZ5oZuW2nKV0zYuLWXlhU0n5ceEqHgw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FdSQGIO2dr/e0e+gzVUFST3qDajoz4KLTNnlax3Wkw9qjwA/cvVnDRdB1aek?=
 =?us-ascii?Q?UWWoHnqSwyDnOauIPCy3cs6bF0gNLffbZ/Ox8Du9lCDudYzVUwTBOcAZy0LX?=
 =?us-ascii?Q?5uBZ/eyMtmGHsoe/Zl/J+XGyfVtfITj2f33JuHNqSsO5wTf2QAFJKey8bJ9T?=
 =?us-ascii?Q?oGjAyHcOdpgOfYShIBcMQuMqXO8VC9y4u/8So7GEd0Hm5fciXg0vanx+0m0z?=
 =?us-ascii?Q?el0roriJlMDEi6JJTSmZO9wO2mgYpsTo4wSjgezw67TWUYuXNThUczOMGem0?=
 =?us-ascii?Q?+ov2zg6YkSXJ5AlzBzU9aebxtNPM76Wyqzau36fHy1KNOq1WQEH9/hvaG124?=
 =?us-ascii?Q?l0+kRI5fDa9qyYYb3MLz+HTx+lmKNxUw7O4Wi4a5UMAF09SLSBpSNueU89pP?=
 =?us-ascii?Q?pj7jY9x9NZVaMXFSOtdeZ9jW0JisgNvPdxJ2BEMYXX0MPETOO9csTcI8uXxs?=
 =?us-ascii?Q?JaLMyYFkb3jIVSlp8gV1tXUbQY7ziB54a0mPcy6spzDuJWO1R/xhXAZ+No7i?=
 =?us-ascii?Q?s+hWrc5RMitnF95dDcutGK4KdSyCbO+Ahvl7mOBufFZZd/Ve5i8JK/11j68K?=
 =?us-ascii?Q?5mOkLavpwhPiLzlBrwFeG8FpXDkk/hngJQ1zMiGkevn72WWQUjnF0ORUfNtm?=
 =?us-ascii?Q?pV/wJhAs/Qtm6jybHu4YMKS2ALL3SMK9UqSkpLnvI2Avg+dwLSOgqKR2UhwN?=
 =?us-ascii?Q?FMCYWiVefbLuf5n3kWmHkXdQfYQ1Ad7w0unYNVHMmWtVuw9+66R74qUKvP43?=
 =?us-ascii?Q?7YkMjfzhoP8jZckUoYWuZzix+xfa3cJ7iRhuToMMl06Vtc6bG1TASR7xbnC3?=
 =?us-ascii?Q?iq5dX+68pqF0u8Bz9I4Sg2BgED/fOg0OuPwD9PNnk/ncnIhch92r4tP1dz31?=
 =?us-ascii?Q?SIvAxolceQ0MaGQC+eINhsHdnw4qCK283+dCoZVYEzjs+QLcBkOhvKBskA8J?=
 =?us-ascii?Q?A84O0bYVnoxUZOFlqBNm0rzII9DpXDni3qBsH+MDLXkMfRt/48fzysJFcloF?=
 =?us-ascii?Q?nggbQ2Tckrx/rXGksky00IHsU1z/Y5pgNz6rVlbx7EqJpF+fwSPgxwb+S44Y?=
 =?us-ascii?Q?T874ws87lm4+qPC2jEJYtiPcjPP4WNLhwOvUkhuy5AkfJy6p1vzb0QzciaVW?=
 =?us-ascii?Q?eUwz5Mq08RKYE5FOWNpsnhjOiHXdBl+PXCIUhDjHCei/t9M5rqMRfmSrJ5fh?=
 =?us-ascii?Q?ZHBnWDptDkRin2J4C2xQoPPsWcmy/z5B/lSMJ+5aQZDkR7Gb2j7JPsZaNxsZ?=
 =?us-ascii?Q?T36Jek9s6ltLJArAKwMsAjmhKywej64GyCOcrizUZrDlxvCpk+ia4WL4uP9N?=
 =?us-ascii?Q?NmqUJaTc5NEt6bLPttJ28vAgxmiES1WJJyrdxC2cAdbWlMrEBZkF1m96SiL1?=
 =?us-ascii?Q?1NZx/Q6mGMYv/w889gcYVuOJjRbqXiXBLFc7IbUVmWQTfiRdVhTsGNKn83qO?=
 =?us-ascii?Q?MuyO7Q6vMfnckm+DN1jSpmeMaJJeknqWZNdapr+o9dVv3ujbrLJ3Jfopp1gB?=
 =?us-ascii?Q?vIGMW3YOGmhebpQjhjemi/WlBn38Wj+ou9AF90GhmwXRqLCy0DAp369IAFx2?=
 =?us-ascii?Q?k6WevYMhSYtaGlDvLzam8xWc+crSZTuD/2+6hjwAWHDwZKnIzB4e76+ShNgs?=
 =?us-ascii?Q?PVnxtvcALklnOQ2dKIziGpK9aHfwxUX7Y3DWfLXH8CNvUy5dW/ziwqLUobxI?=
 =?us-ascii?Q?b5Nq0bzAIaCzST3i1Gu9ycJrht1f7KXyuO5vRwwOrm628JnRfv6ArihGS/75?=
 =?us-ascii?Q?jNOtHAMsaGLJy7HYnBE5B0iSOauku5E3QNT4Uvq9p3AMlfhPMzEV4MWVi4+X?=
x-ms-exchange-antispam-messagedata-1: JsN0+wmD2ATKwA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f8523c-0227-4827-8279-08dee8c44726
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 14:11:23.7548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3QC7SNEPNLNsnM+C8Obu/40++fp3AB5Oi5hrRJhB9l8zokhcoTfxy6JaB2IgHZPjQh4e+uxUy9xvVS8P5Uabw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9649
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

HI David,
	Thanks for the work. We will test it soon.

Regards
Hemant

> -----Original Message-----
> From: David Marchand <david.marchand@redhat.com>
> Sent: 23 July 2026 19:24
> To: Hemant Agrawal <hemant.agrawal@nxp.com>; dev@dpdk.org
> Subject: [RFC 00/11] Device unplug and bus cleanup refactoring for NXP
> Importance: High
>=20
> Hello Hemant,
>=20
> This is a followup to the refactoring started in 26.07.
>=20
> I took some time with my best AI friend to cleanup DPAA and FSLMC bus dri=
vers.
>=20
> Like the last time, only compilation has been checked.
> I have no hardware to test runtime.
>=20
> One thing that could be broken is either the order of devices initialisat=
ion, or bugs
> in the device filtering that I tried to simplify.
>=20
> I think it is worth testing and fixing, as it will make the two NXP bus d=
rivers similar
> to other bus drivers (but keep the special IO devices handling internal t=
o the
> FSLMC bus for example).
>=20
>=20
> --
> David Marchand
>=20
> David Marchand (11):
>   drivers/bus: cleanup device freeing in NXP bus scan
>   bus/dpaa: allocate interrupt during probing
>   bus/dpaa: support unplug and use generic cleanup
>   bus/fslmc: fix memory leaks in scan
>   bus/fslmc: fix per type device count
>   bus/fslmc: simplify device parsing in scan
>   bus/fslmc: refactor device filtering for multiprocess
>   bus/fslmc: move unplug for some device out of VFIO
>   bus/fslmc: call VFIO setup for some device from bus layer
>   bus/fslmc: allocate interrupt during probing
>   bus/fslmc: use generic cleanup
>=20
>  doc/guides/rel_notes/release_26_11.rst   |   4 +
>  drivers/bus/dpaa/dpaa_bus.c              | 134 +++++-----
>  drivers/bus/fslmc/fslmc_bus.c            | 295 +++++++++++++++--------
>  drivers/bus/fslmc/fslmc_vfio.c           | 255 +++++++-------------
>  drivers/bus/fslmc/fslmc_vfio.h           |   5 +
>  drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |   1 +
>  drivers/bus/fslmc/private.h              |   2 +
>  7 files changed, 368 insertions(+), 328 deletions(-)
>=20
> --
> 2.54.0

