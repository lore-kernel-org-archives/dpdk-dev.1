Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE614C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 10:42:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0863C40EE4;
	Mon, 10 Feb 2025 11:42:21 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
 by mails.dpdk.org (Postfix) with ESMTP id 376EE40268
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:42:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb2ad5+rl2/AVy0lq21mwpQCQBblt66aDOUtXROol7qKyuxY1lqW3SbuuqCdEe0zONrpsDiYSpOLgq8RiqrRrfB8szpVABT15Mnbhf7fX/de3Qe1hxoINvPXsCBR497iQUifMLXKR4R+37VhDEgWGRE9vo8WK0NiAEAYeir0Y+VW3j73J3aso7emgJF9Hb5nptVwRL5Z2vXvx7wQ+Ln2LTIpbQJdJBm/Xh1XDeDVL34XH3rLrT0kNBuYGO8vZYJuXZXz/lboabrTE/Gjdv/7Rd6kxTDAx3uWJoO0f+v/znMPgwgVEH0c0c7cY9lnaX4bXWdwAF386cOUn51qS0WpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=VDZTJQfOpF1qEBDqR+txycRsgszvBzX1/ai/eansZ8Mw2tsJlLyLbPbN31+clSu1FDj/sAeNB0hWPHX+IxLM35cMDBt/1Jg31eAh5KkamvZJkiAtlSeX1n7EEteOq1pPhSxCifMcpNvZ0I80cDyJYrzvWivzzIZnh9Nh7F/wDpnOzyJQppRk/QjqhP+0aAM5zHtk4jq9gTQK55WqddcN7qY6W9tbMy5RG9EdYhxofcxUv6MJ6pNKnT+zGntVY+6Aaj+2TlSgCqertIU//p0wxKz44XSdQpFgs3dsoMfn67GMRkp+97tKatr6c3QAKC4z934URDtv6dEKajISXmoetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=BCtG7N4TyJXd4NW6BU+gqwdnz5irHwNRiM87ou4xK5P3JsDX7TnL5bEF02ylyEIVS+O+BmWe2bmXbm1tTUITT6mLznBxuDbfRl0KJZgkptwYd1psfvx/5eBj7jf0PrNafmuY/BSEVOe92fJ7op5Xv3oTN20pxzajySp6mgaawOskWrYURos0YlDYOjenBeI45S6J9GjrsBXKKlOn6IQlmfErxssWs+9Qs3ZZpr5xppuguZ7LCnSyivm2sn2wg5Nf7B0WekITkEtTO/8iZMG0MyqZFJSCFXcxQ6Y+CULGSAcBgXwiG+xNMe5+BddD/rcIBlNlOoxjk8qGy/ZnIqEpwg==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 10:42:18 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:42:18 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Gagandeep Singh <G.Singh@nxp.com>
Subject: RE: [PATCH 05/32] dma/dpaa2: replace memcpy with assignment
Thread-Topic: [PATCH 05/32] dma/dpaa2: replace memcpy with assignment
Thread-Index: AQHbemiDrPHvu+B8+USNKuJYhHTfy7NAXBDg
Date: Mon, 10 Feb 2025 10:42:18 +0000
Message-ID: <PAXPR04MB93283AAF1DF430F9E8792E1489F22@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20250208203142.242284-1-stephen@networkplumber.org>
 <20250208203142.242284-6-stephen@networkplumber.org>
In-Reply-To: <20250208203142.242284-6-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|AM9PR04MB8274:EE_
x-ms-office365-filtering-correlation-id: 00c82172-72e4-4bf8-6ef2-08dd49bf97ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IaQ7O92yc4qUa9un09m/FRgPhlug7X5lfwRTCau+TQgdv4B8dRvkWiGZzZvV?=
 =?us-ascii?Q?FdmgYSjnqCtsRf+D8J0tQKsF+OMWXwlsDn4xwbXLnSxodP3Vufj76H7lRvJe?=
 =?us-ascii?Q?eestncw3whakXwPOK7lCO8XKiAahqNEXcTGTZt0ihKD/ft003sws1p462o6l?=
 =?us-ascii?Q?G2hnCKP2+eqEvzr0JnG6+Oifz/4U1qiC9CUbo2dC7TtCXjZsofzqm1Vlry81?=
 =?us-ascii?Q?7dF7Nk7xbft90kqTjw00p6eQZ/oaQkNaqQmhmh1t9P8OeKFsbsLt+a3zNAFO?=
 =?us-ascii?Q?FGNhjmswtZsVdcCBeOF8TmA3rUbZLNCI8GOzqG5r+H+JiLBKB/kjuizD80xy?=
 =?us-ascii?Q?Ytq8vkyG3cFO5ec16egXvM5Ir/wLmYwSuZ2ciDJtVxBMXaY07xqh1ZeiSsPI?=
 =?us-ascii?Q?4JK+hooeStVMlOmbyVS2RZVx19t0IzkTx40kD9jdMqfBHu2VVr9RUBTXLyuH?=
 =?us-ascii?Q?SxpFokxvmJLqJ3TaRCao58wWPcuxsM4QGIs7H0cUZ8lHOlfSztnNrNKjxrdJ?=
 =?us-ascii?Q?Ujx0J/m2Cj21F/hZXejD9+PUFvfUvzcZ/X9Pmnxo357P5D8Gx2cdlaruaEG+?=
 =?us-ascii?Q?rY/wX5y/eFniJAKxkb6iwfJf+L/zXj3s4BFUSP83mtmPxAHwNJDpbBaL34s0?=
 =?us-ascii?Q?kycd/G9vjLSzGM1tMueEMwYzwY/d99WE9EDwiSSzaRALbkxTmebuTSJQXKUH?=
 =?us-ascii?Q?f+ToSPcoi0xtICIa7Lfv53sVK6+h2bkBYgaPxe3wK4JxLGowhHHw1uIFsLvb?=
 =?us-ascii?Q?vuM4qyfQTNkyf4naprwK6A0g2aaXYcyApOH9H/7+cvbgFfXvu6ImDgO3HBqP?=
 =?us-ascii?Q?w4C7Ojdj7qQmZQuhbOOnQCWWdR2dwAvi5C7tx0bKfbnoMkge5B/RSetT8fDj?=
 =?us-ascii?Q?axlpDiD0/7G/m05Pa6NyLDuUY9PMilv7a1RLZ31h6O0+NkEUJX/YkgUsPYJF?=
 =?us-ascii?Q?U0oxCQ3oRnYRCTMXN/hmf+QEQyTosN918Z4I0Q2jq62U7c2f9KdXJYlJL2yu?=
 =?us-ascii?Q?fFYGAYyBHmKfNGcXsYrPy86b+S5xfj9X/hXCtnQImkOJVitAAWGhxNMKAy7B?=
 =?us-ascii?Q?u0PcLPP4TPM/MgXRtYdLX8hTzQXmpPgc71fRP8tzuNQUwJLT0rR/VBOb7Cml?=
 =?us-ascii?Q?pGaRBDRefwLbOBR25yAGEK68XwNa9yttdwC9rFi4Rr8t5ssKvnwsQkIoR4Kg?=
 =?us-ascii?Q?iq+jy622CYrVtFYU5vC9IgZ7Z2orJ6JQbwLsw7HdQLXyJxz8bIjoLgm3P3Hs?=
 =?us-ascii?Q?DmnO4BrulpgDknPijSSn2SF962Levb49XzQJvVfce0FoZRh/cw23P07G4tha?=
 =?us-ascii?Q?cEctpOdCdiKFzAU5SO3eNqhGVGAghlr4s9fLDFxqKe2Ee97Z4mgf1+c/WA2p?=
 =?us-ascii?Q?AtTUwgwDDhh4oISmsx55fQLg0T3tOwJR4SRjSliKBiWxzTPnvjqUoe0nMPmB?=
 =?us-ascii?Q?b5wC/mBVgyd813mcKR0YHmapozzHoGQM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ca4qNE77qlGW5MPrtoo8SzDECl0uk14ro7w927Uup5AYkCJhkrT6QaHdvNO?=
 =?us-ascii?Q?RlZBX7hi/ucVNVK8Y+DPI5kKZajXtcbIQmfBnle2uydqdPuwXmrCtp9F5EUx?=
 =?us-ascii?Q?7xGAbpfLigD2HwaE/Y054M3ds3ga4RnqWJD/PY0Zm2jVh82SSns56eAb6Y42?=
 =?us-ascii?Q?QAYhWYGv3zs262JT6C8JV2r1Ub4Iiqk8Ms90LfEVqRVxB/ALVvOnJva4KiOc?=
 =?us-ascii?Q?Z+VyDTFpylKSF4X+zuWmvzEMo6yPps+re9KBzrn5UhOoHVGZO2lrseKNLCRi?=
 =?us-ascii?Q?998ahNbY+xuSHbFxV0qHA3m46HTtXTAtItzDp30AHxEQB70SRuYfwyAVY9re?=
 =?us-ascii?Q?oVQqrrz7Rup0xJIz6Fj3ZQIjVI8vDS2HiSTz9wQcfE14dMqKBWxthv9EYkks?=
 =?us-ascii?Q?p9lT9WfcvD3LqVTzzuusbenVackm/reQW5KBGxTEFTVClANjc3MtSmwoM6Iu?=
 =?us-ascii?Q?z7BUEwjzbrIk1y2czvFh58m6RDccGM7Rs3Yn3zOUXsyci0oF1+S0yWxLANKl?=
 =?us-ascii?Q?BB6HEnbBtl1mOfcZRExSl7RGv5raMoEhnWPtIYHaPJ2U2ehmzNbvQFJlNw+L?=
 =?us-ascii?Q?iteoZLF5fQNd6tCmtd7iohYu+GDY93DJX7zUAINF71EY7XAYjK70a9PpSDNf?=
 =?us-ascii?Q?I5BNkyYC+bl3oN2m+QjW7gI9n3gbPyg0jNAtzWywvb7wLNoy9cLnBptLmWl+?=
 =?us-ascii?Q?qyW6Kb/hpOcG8LMVKuWpem64nD8FBL5kfiNSHsBFJaErNB50sLQ0Os51iDX/?=
 =?us-ascii?Q?opXn2hq9qrDXC40PzqTKp4rzQrBuj0kBpoU4TMcu7kEFZtwnC7HTu3O3zqex?=
 =?us-ascii?Q?O6WXy6RYsTpE4/aFQfbST2p+efxZFN+wsGOpq7mVxohq9apKMb+pCURqvXMw?=
 =?us-ascii?Q?JXJaHObcDbwkOjTjNzauo+/kDFc95z6zFJ14iSA7hd/uilRYJDbAD4fVdQap?=
 =?us-ascii?Q?Vnk/szH6jq9viRewAKiD8VfrF0+lyMlUxHgT5KO8TrFctkrk1j6bPCsg15CU?=
 =?us-ascii?Q?uXsxPZvVyAroQbXtYGziSJdZ+E8xW7EKiuw1SlEjoVTtKJeEXc8PpzxeunDS?=
 =?us-ascii?Q?0w6nI0JdRIB3JOswEEP8ydX4/e9xL69yfAxT/SoZJ0baHnnVSrXWoUpfFyQ7?=
 =?us-ascii?Q?u4sHLljWDJKugCw+0vQ9wIZKA1BouqSDaxggYh5q0AEkN7rTWhHkvmqJS+JZ?=
 =?us-ascii?Q?hIZa+RAlgYWPzZG18q411cry1v9sauVMymfHs05+cVChIGAsPKQnFT1pJ3Ql?=
 =?us-ascii?Q?/SxNQiuYlldxDq7LJAzkefMZ7vVpWdOB2ePlMqGzl+SnZtdbaF0UJfr8a++g?=
 =?us-ascii?Q?uPAvGnFW0L1zqOhOcxrQQHVLsd6p2R0hcQZ4DohtTOrjNthRh6+/BUdKOLJX?=
 =?us-ascii?Q?qh8v7P1mjJn4CaWIJonlnWzBZF2zdDqWTAeSDFMmZFNkIvsBgTTjCeBar/yk?=
 =?us-ascii?Q?Cfs2CB1wklr/pOXG0tCkDKnAN3+JJODFadZxgHv5hVDMoGyLCT1JOdd379n7?=
 =?us-ascii?Q?yuFwut98dDVD9v7hQSBjNHvDI3fBpqR6AQQXjhtdtGIXKk+5TF+pFvbOD3Qb?=
 =?us-ascii?Q?ofd40zbb9Nh1qIWZE6KJ7zmx2X0IuPwAsNrgjXFK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c82172-72e4-4bf8-6ef2-08dd49bf97ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 10:42:18.8524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aw/uF1J+CtzB8gQLFXDzw1wzX11g+Q6TyWgdy7MnvStIskzuugXPYzyHMULD9MJJ47u6aAoqwYdJu6tMl1HwYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8274
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
