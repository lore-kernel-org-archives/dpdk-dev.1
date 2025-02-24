Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101C1C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 07:25:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57FCB40652;
	Mon, 24 Feb 2025 08:25:13 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BCBCF40299
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:25:11 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O513sM002576
 for <dev@dpdk.org>; Sun, 23 Feb 2025 23:25:11 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45007b1rr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 23 Feb 2025 23:25:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geayyFMiz4c9jNmV2s2UzhkyuYlFZ8HdscfYxL3pvgbRWwo1i/61ZxWPWU7Osp4e4KfSz1FZBeppV+Q2zLVXzR5Ni4/YGBmkBtaKerwI29SGUuC/cpuP3rJ1ZF7oGe2PvUlYFaMGIxQqFfS5GUnDhim8+AsZaXxcaDl/fY+tLFWDRaBvR+Y5s1/+GEn0c4jOcTKBy6fKQidtiEuaR9BSkV+4BHplWPe/XXurbSd4Ry3YxSAlGL+eQYCoyzRM4EK0CFlXX06cWIqIYepkmvFxEXsz8gUmOVM5nZusOfwguYFHDbIxbQEyz2qx2W8RFHwDkbvdpQzTAjTwmoIcYj+BNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXZrsg7M83p0f4vhqwRdUqxAo9WOzdHOGxG44+d/EyA=;
 b=LQQqbvwKzwKg2qBLO1jp0zyKYYUTchxuzw7CS7GvmX2nE7hHVcmZvAS0gwqm8OLcSweyyIBBQIaPeGxs7rPKY97aImWV7Oet0MBDYvnIz1tYOJ7vipUQzDKd5oWQ0tLxWdaCvdePuoqlssjD0/BvHfzlAJUHJg5+f3yOlAvP8dnLKLVt1U6IGw/6G5PEZWO6ZSa8LWYzc9YlCvNKxyKBXSai9YczFtPALGPAetHoLdSbVpTsPnyA6WPW6K7UclPZ7tfuTpui+u7Js/buZzcWO/DAcl4+XH0FN6v5EckHUgsiLLO9OIUdV4eK4D2/ntGnR4UhI/25qTEJSc9QuIpabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXZrsg7M83p0f4vhqwRdUqxAo9WOzdHOGxG44+d/EyA=;
 b=MjU5elstEtbJrBqOw5tVwFafK8sMuCTJBLHFvsBfvFKHJ22QrT35L5oXC7bQ/ygSg7JPO2sOipZcvOl59KB1ZsF03vUVXV9DCMIaqQPz4KnWcuEEIAOZmQA0RFn5EMbjMKo02eHCgrauPhQGQx01uzWMdWotTSn6o1aX1vhuazg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO6PR18MB3793.namprd18.prod.outlook.com (2603:10b6:5:345::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.21; Mon, 24 Feb 2025 07:25:04 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 07:25:04 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [v4 0/6] crypto/virtio: enhancements for RSA and vDPA
Thread-Topic: [v4 0/6] crypto/virtio: enhancements for RSA and vDPA
Thread-Index: AQHbhQqNWtqg4epR4k+44iGA276fB7NWECwQ
Date: Mon, 24 Feb 2025 07:25:04 +0000
Message-ID: <CO6PR18MB4484F1B716E1E306295F1FC9D8C02@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <cover.1740156584.git.gmuthukrishn@marvell.com>
 <cover.1740212415.git.gmuthukrishn@marvell.com>
In-Reply-To: <cover.1740212415.git.gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO6PR18MB3793:EE_
x-ms-office365-filtering-correlation-id: 07253f4b-8821-4a18-db38-08dd54a45bac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?I8a4LL/BVS2gheMWhdjK6tKKCrirdkVq1cSKdroMZDrPZpgC+wpkbgghEqzp?=
 =?us-ascii?Q?3DoyFqHRcrBqWn1I5zGOLYeNt07eLJSWWIoMFSa1BsYtEwrV0Cv+f7FqrGfh?=
 =?us-ascii?Q?0XFLyj6pcP41uGl2T7qHvYoJ8/VRkGWqa4CHE2C99Mnfj2z5E66XmO6HUtDX?=
 =?us-ascii?Q?Y5QhHCTlFbwUNXa0PLxok+Pe8tKCBuF/f1uiBIsnSaA3ZIqSuj8Dkx4ofjhN?=
 =?us-ascii?Q?0bm04AJjLAjBDQ+myglv+r6lXWhLGek6nPwuo5iFhZtQeCrWE2HdYPw+EEq7?=
 =?us-ascii?Q?X/Hw0tP/lfTvf0U48JvuKX++/7CK6DDgwk6I5v19BotxF+pMs5gzrqZ7ZuSm?=
 =?us-ascii?Q?FPsGpsaJKIY0IpPPVEduqrP6vB2xWNb2gN6ABeuSki2gyKKYNA5J7Iq4pd2B?=
 =?us-ascii?Q?EM9ePNuOvHFCWaBeEhEzaP6caW61V5UfFY5cHUsAl8MIUWKg1Jyuad3YqKNI?=
 =?us-ascii?Q?gPiM52J4HIPi2CLCWMf7rbu+oNhchW/gVZKYCcR457nMicHjtzPoJ+PhSPqD?=
 =?us-ascii?Q?1AuTonNo0QsJTMHY1z0Un5WXrgKOUFH1M0+guQ6QwAwwME4GtK5BoR0rOqz5?=
 =?us-ascii?Q?emHRvknCCLhp3uDd92MG1Bpsd/wPfVmBJRoPaE1I/uo1aKEll/x5sSomd7IX?=
 =?us-ascii?Q?Mvd1QIb8WEAymW57k+ml7qcXwfBHV8Czz2G+9Jpu+1iioEeRIgZrBGStjAfC?=
 =?us-ascii?Q?ye+10KEd5CeaAf7k5quWZucdGWSoSkkfZBKDDPbnWzWLr/icyu/OOB1HmPYu?=
 =?us-ascii?Q?iiPLAXjloKP54ccgIkw1tWe67t+cuJRUZ9cPT+CV0jBBpZch2ds0adl9Uzde?=
 =?us-ascii?Q?8hSw5XcQcDdVi7soKG2EA9wbKoWPvs+F0jCnKsxugHf7xApKJcIck4VLWMdw?=
 =?us-ascii?Q?YkRotgh+B16AremGL0PNaxVuboNUHqB3KCLUbLqgtPrvjCpVRAwI9SYEaS+U?=
 =?us-ascii?Q?OCf/3AvKOHRL57LYD8fGQSwJ09hcW6iZPKAgn7qzITnsaKe8k+dLv8b2BDHB?=
 =?us-ascii?Q?Qwjp7+SLwlZnx+1G8FRq2tPqPv3s6M+CYQOU2EtZJM3C57aaefq/FKBmEibv?=
 =?us-ascii?Q?BFsbYOez2KCxlq3+lAQ+3sE50csRQ1DNP/WNURcNZdu6VIFbsCr+yLoqMEEl?=
 =?us-ascii?Q?Lam4J5cwDsbllqA2uXG0okoUatSkbRljSeJYVEcMYY9O4xmBVebNJAybwv/1?=
 =?us-ascii?Q?/3Pik2rSwojQhjpoRgnP+yrVPmzgmIx+49fXyrcR4WHBN2xCBQpebyXcJuXh?=
 =?us-ascii?Q?XD6VV70qIdjTZcW7GBLagsyo6hmNSRb3cjR7Xy7Cy5V6dGdcPxGrCCGagoLn?=
 =?us-ascii?Q?uDABRQRmqmr7GVRib0njnoe6wEst3rsuhQktYpKJaWIRsPar3x5+QNcxGfC0?=
 =?us-ascii?Q?ax1/bPR1k09lIVBsNRTcVYDV+AvLe0LxiWmgrSORtQIdDBFb0POb/eA38gbb?=
 =?us-ascii?Q?0TJrcxud7kORQFz0CdbAyyzz/Ui8jgi9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XF7tw3xe7OcqLDu2nLYbuykwntL9eotf2rxbuyQybLbcAoRLxy2BiLG66rmK?=
 =?us-ascii?Q?y0UBdIO5cK3PwRt3Nnn8ezKtUSpDOvRIJ8VXoHBTTszfupEA3GrL7z7k8Pz9?=
 =?us-ascii?Q?7Mw4MSqxL5vkFXktq1cqm+rwGUYREUJleTWI13prSvtyF5xhB9+NPxJv6tnP?=
 =?us-ascii?Q?t1PqlrGC0+Ufsng6+4t/Wds9F72FY4heEqL7bR19ioKpfkQQxxoIB9mfIIkv?=
 =?us-ascii?Q?RtYG0RJp33eqy7+xt+6o9rlVSxtYyYjWW4/QjHqb0CfC02QoLYJ0254iS19t?=
 =?us-ascii?Q?Z8J8Tcx61Cei5VpVAyPOeNLceNWkBjQH0Il98Sgj2CBwq2JJP4Uv1WSZPjLx?=
 =?us-ascii?Q?IMq+czG3rYKm34m8Op1Z510ThOPURmzrkpd+NTr2PyfUtw0VJZ6BztfTgQY/?=
 =?us-ascii?Q?J6/AuC9rrYA5qHDRQncVg2j4VsHPU3kCyzZ+yuU/u3toPufi+J9vZRgDJ5jx?=
 =?us-ascii?Q?qD7my7buRtnx/+lSw2pZF69vIJYqT1aECD1adjOtgsLnTdcUtR7WjCbaTVyb?=
 =?us-ascii?Q?JI9QOLS/ztw0c4OpKPuoHpSwyZYTlHiOFh4JRpjrHdNJygfQT5CY1QNFQeov?=
 =?us-ascii?Q?b1FE7GeX1NaDumR/JVZOZ1H6dRCXlRi2pPv+Vlty7NhT60mDovP/UfkZbtpo?=
 =?us-ascii?Q?pWntdc2+eFoWYG0R80p5SYSQU+ZfoMV6IiHUrE8ar8ZWBnJlZTdlhc/vU53v?=
 =?us-ascii?Q?EPwW+jryvRWLOCF436bvO07O4Bb6EMaCfWghwkllAFImO7IHgdA6DB/PyFF/?=
 =?us-ascii?Q?ZSjx8vavjAFJnaGfU/wuCgvQIzRKlUTgcbcf5nSueRRv+a96KR8sEWK3p4lW?=
 =?us-ascii?Q?GxX7vmvZ2jGuthmN3icXgzcpxGF6lLCrIQ+1fv52Q3Cf5m8CLSVRl/5vk+9F?=
 =?us-ascii?Q?jh1PLl0+DXLk9i7YZQ/uZpGOHbsy68E5c8KpH0XL6ewBeDBQHFcJUe7bNUg3?=
 =?us-ascii?Q?DL8sxgjREzLYiwCWULVYACMirShRe0Vw5rysUzcRydbuccXrDdP86RdT9/Dl?=
 =?us-ascii?Q?QYuHVSUVPsIVlAIOOV8TsHjFQ14hgQkOsKm1Jm1InyEt34drm2J2DML4heDj?=
 =?us-ascii?Q?9IxghcjmK9QO418EpNVYKHdzIO9ZSON3qB8lTrLclXbWO6W/EcB9iGo8AykH?=
 =?us-ascii?Q?JaMNGH3Oi1yGqMlkw4Z52TercBHMGbz/sUJSE/o//iBk9G1lzGoqp7tJKmw6?=
 =?us-ascii?Q?Hm4SrgXhCDEyO57qYYyzrP4ZOmobMAa90Jo/ErSN+EnYoBXf9KFpjexm7Y/3?=
 =?us-ascii?Q?VCnZcp2LZT1L0ohkgoGE06alnKSIfGlfnH7PPBsNQmRBL1iZFixgpfI9gjbf?=
 =?us-ascii?Q?FKLDIix88rc0Kiv+ugf0ab3gigBBaIvNp0vRK4xl/XladNO24Vtqtzz9yshM?=
 =?us-ascii?Q?XXJvVjQBU9IA411Sqbz72o0wYmLOcz7XSHw8zKor+AaA4w/hf55GZX1++IVH?=
 =?us-ascii?Q?O/xQChAd6G20ZZ79mPd7rHpKu0RAa3tr5kWyKtgOD2GxgREwEVuANE1EXWXU?=
 =?us-ascii?Q?GRgpTjwJSUpA3389eIqe8iOMMxoxccG7ZXBWCulv8Yh/ERFfMZxBwyby7RcO?=
 =?us-ascii?Q?b7+yu0eDg3T0v/zb9D5seQt6F61iuOrNpvsx6YGX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07253f4b-8821-4a18-db38-08dd54a45bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 07:25:04.5591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYV0RGUAPeaSQcvkgxYPUIhXOy3s0x5OdrN0pLfr8gOtvG7qmtur40YwiHJ87mQmuIsptmPSoyMCBsDKEi/B/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3793
X-Proofpoint-ORIG-GUID: hlgBOXMNuvjzGdtZ1OoFsIlVJTyNrP2e
X-Proofpoint-GUID: hlgBOXMNuvjzGdtZ1OoFsIlVJTyNrP2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
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

> -----Original Message-----
> From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Sent: Saturday, February 22, 2025 2:47 PM
> To: dev@dpdk.org
> Cc: Anoob Joseph <anoobj@marvell.com>; Akhil Goyal <gakhil@marvell.com>;
> Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Subject: [v4 0/6] crypto/virtio: enhancements for RSA and vDPA
>=20
> This patch series enhances virtio crypto PMD to:
>  * support RSA
>  * support packed virtio ring
>  * support vDPA backend
>=20
> v4:
>  - CI issue fixed.
>=20
> Depends-on: series-34682 ("vhost: add RSA support")
>=20
> Gowrishankar Muthukrishnan (6):
>   crypto/virtio: add asymmetric RSA support
>   crypto/virtio: refactor queue operations
>   crypto/virtio: add packed ring support
>   crypto/virtio: add vDPA backend
>   test/crypto: add asymmetric tests for virtio PMD
>   test/crypto: add tests for virtio user PMD
>=20
>  app/test/test_cryptodev.c                     |    7 +
>  app/test/test_cryptodev.h                     |    1 +
>  app/test/test_cryptodev_asym.c                |   43 +
>  drivers/crypto/virtio/meson.build             |    8 +
>  drivers/crypto/virtio/virtio_crypto_algs.h    |    2 +-
>  .../virtio/virtio_crypto_capabilities.h       |   19 +
>  drivers/crypto/virtio/virtio_cryptodev.c      | 1060 +++++++++++------
>  drivers/crypto/virtio/virtio_cryptodev.h      |   18 +-
>  drivers/crypto/virtio/virtio_cvq.c            |  228 ++++
>  drivers/crypto/virtio/virtio_cvq.h            |   33 +
>  drivers/crypto/virtio/virtio_logs.h           |    6 +-
>  drivers/crypto/virtio/virtio_pci.h            |   38 +-
>  drivers/crypto/virtio/virtio_ring.h           |   65 +-
>  drivers/crypto/virtio/virtio_rxtx.c           |  721 ++++++++++-
>  drivers/crypto/virtio/virtio_rxtx.h           |   13 +
>  drivers/crypto/virtio/virtio_user/vhost.h     |   90 ++
>  .../crypto/virtio/virtio_user/vhost_vdpa.c    |  710 +++++++++++
>  .../virtio/virtio_user/virtio_user_dev.c      |  749 ++++++++++++
>  .../virtio/virtio_user/virtio_user_dev.h      |   85 ++
>  drivers/crypto/virtio/virtio_user_cryptodev.c |  575 +++++++++
>  drivers/crypto/virtio/virtqueue.c             |  229 +++-
>  drivers/crypto/virtio/virtqueue.h             |  221 +++-
>  lib/cryptodev/cryptodev_pmd.h                 |    6 +
>  23 files changed, 4435 insertions(+), 492 deletions(-)
>  create mode 100644 drivers/crypto/virtio/virtio_cvq.c
>  create mode 100644 drivers/crypto/virtio/virtio_cvq.h
>  create mode 100644 drivers/crypto/virtio/virtio_rxtx.h
>  create mode 100644 drivers/crypto/virtio/virtio_user/vhost.h
>  create mode 100644 drivers/crypto/virtio/virtio_user/vhost_vdpa.c
>  create mode 100644 drivers/crypto/virtio/virtio_user/virtio_user_dev.c
>  create mode 100644 drivers/crypto/virtio/virtio_user/virtio_user_dev.h
>  create mode 100644 drivers/crypto/virtio/virtio_user_cryptodev.c
>=20
Add documentation and release notes updates.

