Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972DBC5AC67
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 07:51:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3F5A40ED9;
	Tue, 11 Aug 2026 09:50:59 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
 by mails.dpdk.org (Postfix) with ESMTP id 8E6A040E18
 for <dev@dpdk.org>; Tue, 11 Aug 2026 09:50:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnfFYezrHu00JhwOX2ssVHfELEsHScWvWiBtf8SRHWZxy0/5nAIogwxrHh/XzarabJ5zrLcHcL5tcV1xtfTltP3o89XeK11cYKdGMXqjliVy+FNTpJL5G01IEOiN3jhoiVpB984UT8RxIq8CMF8joteUVsAU4J9/3YpfY+mNdubmI763VMkQki8W3PbKeB6QtmAGNA3myxg+MpRwZec39ReqqCYYNIHiK+rZx+Zz9aVF93/KSlfxylA7nzEesdyL/aSncwJ+qG0lc/rUDcu6PLHcNaL0MTREnnA06o0YEOYfdcUaSz7oJDxIta1NB4yphLVB9shfYBFuaqd2J1bUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qHvkKNbMT/8CpQhzyoguv+504JIvd4JxNujfiT0K6w=;
 b=rGOVwtoLNZbUPAoBgHmEwN/Bj8mBBQnWJq4i2GvnFAtWHA97l5xJI5h+fbWb9owtRNloBmlWVhYL3AGzYjnJDCJEJTE+LKCDwrGULNZ3/f+kyiotra3L4WAdk6Y9RBxEhYllFz7STZqT0RY9rNecPQnxuzgvgXpKuA3Oot5A0W2TLqQvuo0iS7R3/vrXHwbXpYJ5rH4d1KaSeY8NFTGUW3LJ+OBNKASPUjgRotx49Wr0XVvE4w8Q1QiQy8W9+KA1QECOMXCMbFlj8sWMHE3NPolRsn8FoS/NhpFdMldXwEIcsVBOMbEYNeBgyVHX3J2nByBcFYD6VDYoKcxM7QF4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qHvkKNbMT/8CpQhzyoguv+504JIvd4JxNujfiT0K6w=;
 b=BSJaX6oiuSHpJYyOUVQpHoaeyE7j4fWw82PlKK/8E7xV6+DWTd+LFTGL5FPY8rI2pgi0ZPavc+K6k868OVyWEojz3HKF7WoCxsS33ag9Xu+4TbhcFaonukuOfg/Q5mSnN0MpoblgRQ9CmRr8D6/+s+Az7uGf90ULRYXIPvAfYOjgHabzjyeO7L7FML3U+Pecc0RcOK0+GL7rCZ1sFfyI02gJE6ZayFJ4XNeYPcM/tjFLjci2c2isWO8aUlFUA4WvR1oqXrAcmCXW1PdBtDlFEH5jQtx4/M09fpfFaSzisWQAgCSlmkz/zyiXBotG+BtP9f3f6saCISBpY7nvH7rmRQ==
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 (2603:10a6:20b:725::21) by AS8PR04MB8593.eurprd04.prod.outlook.com
 (2603:10a6:20b:424::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 07:50:56 +0000
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf]) by AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 07:50:56 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "gakhil@marvell.com" <gakhil@marvell.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH 6/6] crypto/dpaa2_sec: add support for env variables
Thread-Topic: [PATCH 6/6] crypto/dpaa2_sec: add support for env variables
Thread-Index: AQHdKLuS8esGGTDBSkqFsPh3ZpJAW7aXZO0AgAEVCUA=
Date: Tue, 11 Aug 2026 07:50:56 +0000
Message-ID: <AMBPR04MB12281C70CC79EB21582EBC4F8E1DD2@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260810112951.2879825-1-g.singh@nxp.com>
 <20260810112951.2879825-7-g.singh@nxp.com>
 <20260810081620.1a1753f8@phoenix.local>
In-Reply-To: <20260810081620.1a1753f8@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12281:EE_|AS8PR04MB8593:EE_
x-ms-office365-filtering-correlation-id: ed32d53b-0535-438e-6fbd-08def77d46ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|366016|376014|38070700021|11063799006|56012099006|10067099003|4143699003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: Ji4VFvuQtTQ/ZFDFUQwHpFkCycziYIEDSiGf/pXPRZ5Kxm7CBlIYSUk0eMjb/3OxaVV0SBR1jEjJAF7DQ7ox5KaR4ybGyr0AlKaFzelDzPLwrEY5bnvZF+p0VGesK6U4mGoFgejeyICjuIJdQcnrAvikBJUTAsE9c0qAF+bx24dtdU54UeeTDfU2YBmXW3lgtHDpzJNngL7bKPWPXtX4B0z01XTmfttNP/ze87vDaW6PZvCP2Wt0WOdUPuFb3mM2/0dvnFrq327R+CpuTBI7c/iqyNgOJItghYwYUQHfurMUmLBL7wlIntQ6sDMcK05e9oABSloyRtrok9ZVFv8WDCsOQxdtXw8mOxyohE0Y/VHYeGBu1mGLz7O7qJdeRL5fpnsJTiWk8YHY6lMDdx7NaWGZyCD8rv7We0a1nxf2jvJxC+WxW7ab7QGQyKt5Cha9tChGGj+VHnRoQwZhMGd1nKeMyxuPUaFSOq1LKmLEN2Nf2yOK0m1vpFPxmxm2bGnfivNGfXXeCfuNc2UK+LiCKB3NPSIKS3XjUJXRFVmKuyARqTMXdU8upKXWpgmHPflpkRKPytkXa2fuOwu7Q/EwEuilIpbCpl0sww3nY3iHJChZSoLkEFaK3QiA1OAG26J6KHNWbfHFArWgDbRPT00nqLZnHPJe1vBBm4e/cen4d3495kq5GdXCVzbuil6FTc0IyUSVVV0w362FVWJR7Qk6qQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12281.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lo2vbk8JgCXidd4GtH2I9tXwTS9fI79UWr1Wa0cpdJXhsX1ToLpLnWpCVuaZ?=
 =?us-ascii?Q?gwhjctUImOjwdeWw60xw0Ek1KdCrJDURgo2EOXRLd4LA3gzaGozRLryngdec?=
 =?us-ascii?Q?1XVcBUqD5I0lZR4Vi6FDtXUlzXjCg78aOBj+cdrOiYL50PPtykI2TLebIHBe?=
 =?us-ascii?Q?30f/81g+xSaJZFVknV+zSUlT7bm+UjhYCZ5+dJ9t8VDluRpXnFBn2ItYc6Md?=
 =?us-ascii?Q?c5cZPC8JpQN6A6AaM4err+lMAmolAy+QLX6zapbF/ghg/aCc2qkDRA86/iF4?=
 =?us-ascii?Q?ROMdNvcgf/NGU32MZ4XEfrXiyZ6RVMGuDy4Gtdd4rLZYMjyfxGGCIJaOqcFl?=
 =?us-ascii?Q?a65pPN9eJpyqutCnP6ZC7q9E1hJJ4f8d5ncPRWkAZoGpWH0DrBGO8vgFhG1j?=
 =?us-ascii?Q?PU0HUZ56JDrI7Ky5BlYc0gsm5J1TjsSYX6vS+4KLVwFFNuBywqZuumC5HVfG?=
 =?us-ascii?Q?K5frIUQ7zN2pE42OzgT4C5EBRkEV+O5wB5SPKkSfBUAyhI6fHE+DJ1pYCDnY?=
 =?us-ascii?Q?rQkQDMIoyg+XYMrcl4T4C6O1enM2rQj++2yfTNv5uZxcDVmKmet7EJfDMYxz?=
 =?us-ascii?Q?/5LsTOZaOObuxU/4HXuXoJsIjg9qy/epiywRAxjroJvaIaysR0zUgdk5JtgH?=
 =?us-ascii?Q?ugGe9Ct4ZD+/0+pKY9kIeenmCRcJ+1Q+trCoO9CzapJgC2vOnluEutfjKRwr?=
 =?us-ascii?Q?tGlfUiPCLrV89cFMXsWZbnrGCbvxtEn2Srosk7xBP7rUlxPXWRSs1QZrvS6t?=
 =?us-ascii?Q?Tkb+O8rDi19vnFyLUhuwwfbVsFkVPm+wTns49XsFPGejMC33hZ6bMDUkimAz?=
 =?us-ascii?Q?ANcq1cBd+Ct2IVhEbPcw7ogLNNPWaus2yhHsoO/jgLvXsglkPH8iUqb/jwaO?=
 =?us-ascii?Q?H/k1ykkIu/txUuLqw6aA8LGIEZhXOzhPudvNHcfgVVeI2eRbzJgCaxQOLxYb?=
 =?us-ascii?Q?2YMBdGYumZ+8x/7ZxFUsaWGOuCSiyGjowmAZ1Fig20x2QR2prNxxrLEGvtFg?=
 =?us-ascii?Q?PIcXdn4xRG+rd3XPJAz+RGHhtA5AjOZ3gqPi6ttx3lVGxzLWhga8fpBk9u3c?=
 =?us-ascii?Q?BQHVAPThY0ZpAFBO+skzFj7dmdltQEOZQQ3guzz557U1XaigdYvTzOsVPdYM?=
 =?us-ascii?Q?7Lt7ySXNjOrCZ4VeX/MyKbrHpzilXpvWXOxpD69/yxc08pxsM4kTcr88StP0?=
 =?us-ascii?Q?fgMog2el29N5vla8RpkQXxMJzHN8iOk+N9Y4dM83SkvC/ZJPS8fyVlPWJTK2?=
 =?us-ascii?Q?ojBrgCJJW51Yn39XdGVl3//GSPfpSJ9db6psMy/ty9x5Oy0gYtJtOSxP/2SD?=
 =?us-ascii?Q?rVF4btspKExBDPjiEkBFcceFrfC+gc1tWEsUsZjkZ982/jqm1p2ode5azAP7?=
 =?us-ascii?Q?DYtc5cYyF/Lv8nP2abKmhgBRKhuU8Pf7WgCEyOgPSu2H8rAV1HGJpMPatD4X?=
 =?us-ascii?Q?fsrH9+h4fLtOjeySR3SQfDer2sNq725cTbUsazSFc+t9OQn1zftj8c0KYWDe?=
 =?us-ascii?Q?BnefkPp9rN7Cl6W/HLna3oWyfGlppZhibTPakF0yE9vl3q4gZduE+O8lKkFT?=
 =?us-ascii?Q?CTr/w58eBSDz8iQxShn9BAwE9ldM/3nKTVeu9lSzfKidZ9q3KNtmmFm443YN?=
 =?us-ascii?Q?p7aNQi5SKsk1sz65rGdGcRLFefAVAl5JzX1JQZp/2hHY4hvoE3+m3bhgrUv2?=
 =?us-ascii?Q?zEKmrHlmyLA/2183cxNbyW3Iy27r7w5o80VqobTDEcD8aOeV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12281.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed32d53b-0535-438e-6fbd-08def77d46ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 07:50:56.1489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5DeV/R9msa/2N7TVumjDhiw5Qm6q0xdf3yMGwpdEGPd1cSfyBSuLMcwZQ/lNgQt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8593
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, August 10, 2026 8:46 PM
> To: Gagandeep Singh <G.Singh@nxp.com>
> Cc: dev@dpdk.org; gakhil@marvell.com; Hemant Agrawal
> <hemant.agrawal@nxp.com>
> Subject: Re: [PATCH 6/6] crypto/dpaa2_sec: add support for env variables
>=20
> On Mon, 10 Aug 2026 16:59:51 +0530
> Gagandeep Singh <g.singh@nxp.com> wrote:
>=20
> > Allow driver configuration via environment variables as a fallback
> > when devargs are not provided. After processing devargs (or when
> > devargs are absent), check DRIVER_STRICT_ORDER and
> DRIVER_DUMP_MODE
> > environment variables to set en_loose_ordered and dpaa2_sec_dp_dump.
> >
> > This lets users configure the driver without modifying EAL arguments,
> > useful in environments where command-line access is restricted.
> >
> > Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
>=20
> No. This is bad precedent. DPDK has a method for configuration.
> Adding AdHoc environment variables creates chaos.

I understand the concern. The devargs are already presents. The motivation =
was mainly customer support. In many deployments,
users cannot easily modify EAL/devargs but can set environment variables wi=
thout the need to update and recompile
their binaries, making it easier to enable temporary debugging in the field=
.
