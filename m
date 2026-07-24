Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E68C531CC
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 01:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91365402A7;
	Fri, 24 Jul 2026 03:52:57 +0200 (CEST)
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
 by mails.dpdk.org (Postfix) with ESMTP id A57D94029B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 03:52:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=2662; q=dns/txt;
 s=iport01; t=1784857975; x=1786067575;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GbvzVvcJKS4eLuloMfsK6GSJ3X3Hr8f5PXsL1u7vBZY=;
 b=A7e6BIyUda8W4jvDnUsnqTiFeHVclCj64wfd9/PCAmrJcn7w9UsYhUgE
 4ncz9xhGaNDyouDDbFtHQdcw99H0eG2Z6ykoXtSY5qfcj4fbCk1FU/vW4
 ki37qv568etNkufaxFl8mk1uH5gckGJjXZFXP4gFC8PExxat8Dv0mKXCQ
 Us9eNrb4ZXb9p6rV+4i8t+VHw2q+vO5W7Ss56IsYZoLzDDyWaVGz/fMTe
 qzNrDrmT4ra81Ssx9LgDSujfaYGZmCODv5xy2k0HZ2n6/VplxP9zT06sW
 CNbgBkuUjYlRENNCSo1oF4wGCVnfcYqrJ1ubP2M6YZVuKg8jgUcWH7i37 A==;
X-CSE-ConnectionGUID: H+2sJ87tT9y0cKihcFFF8A==
X-CSE-MsgGUID: c3EcGWiuSsKxKbesIo2SLQ==
X-IPAS-Result: =?us-ascii?q?A0AKBACbxGJq/43/Ja1aHgEBCxIMZYEgC4FuU4IZEkmII?=
 =?us-ascii?q?wOFK4h8nhuBfg8BAQENAlEEAQGFBQKNXwImNAkOAQIEAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QELAQEFAQEBAgEHBYEOE4ZchloBAQEBAxIoPwwEAgEIEQQBAR8QMR0IAgQBD?=
 =?us-ascii?q?QUIGoVVAwECtmABgT0Ciip4gTSBAeA3FAGBOIU/gxwBAYQ8gSIZhHwnG4FJR?=
 =?us-ascii?q?IEVQoJpPoRFhBOCMASCIoEMki5SeBwDWSwBVRMXCwcFgSMQMwMqLy0jSwUtH?=
 =?us-ascii?q?XAMJxIPHRcWHlgbBwUSICpBRSMDQTY4C0MFgVYCgXg/Ix8DOX+BL3VKdy1pA?=
 =?us-ascii?q?QIQF0o4JINJAoE3AwttPTcGDhkDBIE1BY1hI4I/AYEOgURlk26zRgqEHaIRF?=
 =?us-ascii?q?6psmQgjqHUCBAIEBQIQAQEGgWg8gVlwFYMiUxkP3G15PwcCBw8Ck3EBAQ?=
IronPort-PHdr: A9a23:d1JxVRNSBDCeSqwKAJ4l6nc2WUAX0o4cdiYP4ZYhzrVWfbvmptLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:7ISEo6q5sDfCj9a6PFq1QDubWcBeBmJcZBIvgKrLsJaIsI4StFCzt
 garIBnVOP6PNDT3etF3bdu/9kwEvZSBn4A1Tgs5rHpkRitHouPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgLNNwJcaDpOtfrc8k834JwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0sY0W3psp
 aMEFGEcNhughuK97pyVGsA506zPLOGzVG8ekmtrwTecCbMtRorOBv2Wo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LUfrSn8/w7pX7Wz1Jr1SWpK8f6GnIxws327/oWDbQUoHTGJ0PwhfJ9
 goq+UzyWTwRG+Oe1AGe0WKPjOLUvCShY6YrQejQGvlCxQf7KnYoIBEbS3O3ufW6zEmkVLpix
 1c84CEiq+02sUesVNS4B0H+q3+ftRlaUN1VewEn1DywJmPvy1/xLkAPTyVKb5ots8peeNDg/
 gbhcw/BbdC3jICodA==
IronPort-HdrOrdr: A9a23:zjtyv6+7dNxOnrYKPUhuk+HXdr1zdoMgy1knxilNoENuA6+lfp
 GV/MjziyWUtN9IYgBfpTnhAsW9qXO1z+8S3WBjB8bSYOCAghrmEGgC1/qv/9SOIVyFygcw79
 YFT0E6MqyOMbEYt7e13ODbKadc/DDvysnB7omurQYJcegpUdAd0+4TMHfjLqQCfng8OXNPLu
 vl2iMonUvGRV0nKu6AKj0uWe/Fq9fXlJTgTyInKnccgjWmvHeD0pK/NwKX8Cs/flp0rIsKwC
 zoggb57qKsv7WBzAPA12jc1pJSmNHw4NpODs6Bh6EuW3TRYwCTC7hJavmnhnQYseuv4FElnJ
 3nuBE7Jfl+7HvXYyWcvQbt8xOI6kds11bSjXujxVfzq83wQzw3T+Bbg5hCTxff4008+Plhza
 Nw2X6DvZY/N2KDoM293amMa/hZrDvynZMQq59Us5WZa/pGVFZll/1awKqSKuZZIMu10vF9LA
 AkNrCt2B8fSyLoU5mehBgu/PWcGlIuAxyBXk8O/uaR0zRQgTRF6nFw/r1Eop/Fn6hNF6WtII
 //Q/lVvaALQckMYa1nAuAdBcOxF2zWWBrJdHmfOFL9Ccg8SjnwQrPMkfwIDduRCdQ15Yp3nI
 6EXEJTtGY0dU6rAcqS3IdT+hSIRGmmRzzixsxX+pA849THNffWGDzGTEprn9qrov0ZDMGeU/
 GvOIhOC/umKWf1A45G0wD3RpEXI3gDV88evMo9Rju104j2A5yvsvaefOfYJbLrHzphUmTjAm
 EbVDy2P8lE5lDDYA6PvPEQYQKbRqXSx+MFLEGBxZlg9GEkDPw4jjQo
X-Talos-CUID: =?us-ascii?q?9a23=3A5rfNh2vsNj4PpD4AEzoG/NoG6IsFMSfG7iePP3P?=
 =?us-ascii?q?pGD5ia7yVQnG+1vNNxp8=3D?=
X-Talos-MUID: 9a23:YF70GQqDGlCkb5nDWvkezzo5GcxH3KWzM1sugbYMttKlMnZLHw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-04.cisco.com ([173.37.255.141])
 by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 24 Jul 2026 01:52:54 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-04.cisco.com (Postfix) with ESMTPS id 48449180005DD
 for <dev@dpdk.org>; Fri, 24 Jul 2026 01:52:54 +0000 (GMT)
X-CSE-ConnectionGUID: FAUun+Q2SP+/QtW8m6Su+Q==
X-CSE-MsgGUID: xEqxdE4kScq8Cj5GTGqfYQ==
Authentication-Results: rcdn-opgw-1.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; d="scan'208";a="65701137"
Received: from mail-westcentralusazon11013033.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.33])
 by rcdn-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 24 Jul 2026 01:52:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQlLMcvsikWGo0EDxADe7ZIUQyVc/BnM1tdGxck0HQZdE6Ea2Z7jPInvpwkmh7s1CXHwo8BkriQAh5JGnwYR/G+/GglqdeasnGXrJrkd2oCTSYI+vpuUjupts40KKVK287kt4RHebW3gLt2N/56Gxu7bnxTn381oRWGi0qyMCL+cl4pBbpmABdyGkOqJs35hWzx+fhVhENgtkCTjVuOyKkT5ORx36mp9AYBgQfWAbUn8fkP+ooObwA6+6Pjngx3A4zT7xRsSvJXdj0XqMbL2V5kM2o2UP97oBza7eJGz5DIeBJK5UJDHfVh/5JGSE0nDHPolRipPv2EK/oMZJ458YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbvzVvcJKS4eLuloMfsK6GSJ3X3Hr8f5PXsL1u7vBZY=;
 b=I/qdtvv6YFMzUTJejvDCVAP4rp/zZd93EmHK3mBPOscvGA5Rv5ODCnp6nZPzBWPMPtISBe2mTtSDTwTT5MSBrpOtoXy45UAYGNGzS7OqxcfYsUjPHMWUAii1yZ0/opASMLxQxNsiEVdF2icGLl/grsR/tfflAa6pAXaMabpLKZXStsZY3KgVPfENaVn8dxUxfSrvaj0gUrEkURFs0FTsrBPqkEsk1HrCNdfKczkKyfVpdMzSmCdGdKHJs4BRA5hKWdRK87m+06r+bapU1lmYlcFe3/GQoemEBep4EzYyWSFgWp/FK6RA02uP/yDnSRcFkHJzSyKp1J9hkJTLuOqbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18)
 by SJ5PPF3A51834D3.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::821) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 01:52:51 +0000
Received: from IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925]) by IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925%3]) with mapi id 15.21.0223.017; Fri, 24 Jul 2026
 01:52:51 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "John Daley (johndale)" <johndale@cisco.com>
Subject: RE: [PATCH v2 3/9] net/enic: remove unneeded ops initialization
Thread-Topic: [PATCH v2 3/9] net/enic: remove unneeded ops initialization
Thread-Index: AQHdGuIH1WgTTVOwfUezR3w3PeHRbLZ76ESw
Date: Fri, 24 Jul 2026 01:52:51 +0000
Message-ID: <IA3PR11MB89874A608588B5012CFE52A9BFCF2@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
 <20260723202936.378793-4-stephen@networkplumber.org>
In-Reply-To: <20260723202936.378793-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8987:EE_|SJ5PPF3A51834D3:EE_
x-ms-office365-filtering-correlation-id: 70866f4f-efe8-410f-057e-08dee926454e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|376014|1800799024|6133799003|11063799006|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: ZH5B7cOiC04aS1a58fzy6lDvNCbEP4XEH2MrCeD/TuwfeXWKIPKzJfjKHtbmryXuBGIcGofZVQpXqM+4aXVlqv3Ockxa3Ux+RSA35mkLUWtSPyjnLn4tdiEqmVT7lk9zQylaGwf5plvat+KNromdo+6uumuVqry0qY01IT8Afb2tKB70brQJTKAgrkk0iRrp1mUq3cU5MrkSv4Am1hFPJHXHodZoe9F3LpXHjoJ/ex26x/nYuZ86Znu1SZkqeiAcrUIRYBQvXrl7vQt1WqG0FVdJhjOOz8jCYDDjb5zv0/zfYZRMmGcaB6rkqm9bj7Pa+bBT8G6umwKdxgINQWSJWdkuxyJnbltG9BX3S4SVfdkRkZ+ZKKCdifB5wCzFjDCGK7z0XeQgJJX/+Z+Pi+5UOv/T0R1zBunIdVJR0jqx8sg3yzQWIM/Rx2exeqrH+cNB09fsPdFgGBMwrmQ9h3TxXN4Vv1ILWHyTuZsgvpuMcwYuRVgm4bvtAK3M7sEN6SaRgOdjQ9uPBaP8WeT+PNQgcDshu6BkjD4PqwfcLj7RrJdcQwjs+WdKy7rWlOJSdywnr9knAaB0p1O9rWKU8P2RVi8CSKGiDJRHi1DyXGxKzuUVgfbcTY2psDFeG+LKd6pZS++HZ4egcm5DLe1T0ksQbxAFObsoTTlGWaps3Tg3Lp5LqDf26imEkbVAArCyzduzukFAqo335BrfftxugdzW4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bXLf5PZmz6RjcG24/Mh/3GpuztZc6It/Z7yuRgG/WXbGYztXe3FhzNO/pJpO?=
 =?us-ascii?Q?MeEus56XX0tndJAaB4WIOerNtv1LJWz/KTRdoRlUpjcf4xS1ihSwzCU4oEXY?=
 =?us-ascii?Q?/qHdsCnU5+0o4KGyW/gN3rzuvdBsIxK81aDafLhRH933p0NnVx0nDfksgVRZ?=
 =?us-ascii?Q?VjA9sX1eVtzl8IZjm7Jt04NBsHHrUqGBa7kxAj4Gpzk/uFeRkZjBnC7GFMts?=
 =?us-ascii?Q?Li+yW4zly9NJwXoU+XnisB/q8q8hskFJN8drzUXHLSfsFQ1ddSUW0mdTyPHO?=
 =?us-ascii?Q?2x05a4TkOhRxOlOTEfABA+2MLb12nWTBbmXTZj+5dzR6aEtgNad1AAqc7H5Z?=
 =?us-ascii?Q?bnv14LcLkkgl8DgrfPZ1k54kDArW1cxu4j3VnBep8F9EeVrpfq39NT2NKk1Z?=
 =?us-ascii?Q?0AdhRAG/plwoljlOBsPV/2FJXsw+oVYfeU9FF8G9pq3uhY0DCJkCG9/TMg3w?=
 =?us-ascii?Q?hyGMe40jUX08hJ5NVTQL5omNG7sfk8w8F8aOxrQpFrgszbWqjL8HqzsnWX0T?=
 =?us-ascii?Q?6ouGWKFwuYaUz2a8AC038kfmZz9ZDs7UhkQ/vlmDWIv0PP4yck8+GTHfYevo?=
 =?us-ascii?Q?59n4o3PjE5aWEOM3pmHfvoQjK60fP9FwHJq0HqLKRMNsmNtaXAdZKTJnQ9gp?=
 =?us-ascii?Q?Qp1XXn1tBfRP5/YuPE5OELwhZUQDIummvQo8InD2Jac5R3Xde1L6Tsngi5eU?=
 =?us-ascii?Q?1C/QiV1xGylI3KYyIIqwzkbX+Q4Ww3z5j3pymHb96deZ6SAfN5vtCQDOmXWU?=
 =?us-ascii?Q?LWY31VBiGiUG0inFsB0jKHVofcUgkx55jpfq56Lt/ObYUxo/1nxNaCpPOZzA?=
 =?us-ascii?Q?TzpNsMlwWbl6far1kQDsiW5+z8nZb22UZI0e0rnrK4q0lcDEZxm37IJQ1Ffo?=
 =?us-ascii?Q?DswBlH7E0+qPKpZ5epqau37z1VO8TP/bMhpGwfrZWWNnfdbR37+akEZqkxOt?=
 =?us-ascii?Q?cOd8l53By8f8spaRzxIcDDOQUMuoP+RFXCujNQzjLMcrVx2Cniej4LqPDdIQ?=
 =?us-ascii?Q?zoZBtrAV5+XJ2wAtbu7k+V3BgJENb1dIfuQms4PjekW8du8N5axhZSPbyk3t?=
 =?us-ascii?Q?Np4A3rJI9NYqJljUHiLBhET1jc02ptHgC4hw39/nJD6PtMUHpmNwMMfl4UIn?=
 =?us-ascii?Q?R0wJyhnxdEMgQT2HsxalSmbMzq/EofaWzRfYxOQtARWLK46jKLkj2aBzUo8h?=
 =?us-ascii?Q?c03apTuD0+bebRUM5GJl6ZO31OQDuFvt9haaQumkzycPMfSJqOBmgu8VB9Q/?=
 =?us-ascii?Q?5MrWcZFP4MsD0Ra1FkMbA4a6ua5FBetseVS3VjEEPYpMny7SCc2RXGnP6KS/?=
 =?us-ascii?Q?CdYFpSeR9nxP45esYNW00f2Py5TtFqx6cZ+arYdIuTjFuAKlpfupxKBArgxb?=
 =?us-ascii?Q?zHwKDK3pPdsgB40Fajl+FHSZJWLC+ty9rw+lfETLtM15x1GCYBZF8hbT2vqo?=
 =?us-ascii?Q?ATVr923d0n6TDc8VeSDCGTjrrBMFU6007/dERk5toiZIMh1RRuJ0rM/QXghH?=
 =?us-ascii?Q?Ak7ZxhIF1idu6RqBmgdSXlwYRwY234MOcBtTEQfdVRpf1tkLG44ucwv7eXvA?=
 =?us-ascii?Q?gT0kb9wneBIA1cGOrbsVZZjrLtp8eqgKAjbQEJXDgNUsb79mMc7r6Mdja6/m?=
 =?us-ascii?Q?k7QFCeP/Le3VgJ428mdINle33f/m1qPwaBzD51CYn4+GNlrD8xSlhJU5pOhj?=
 =?us-ascii?Q?cGRfVNieUMXzrmbvtfcFwj7tfDJLt1z6KiynvYCm/iGcSJd8NIBy8qrRbgBP?=
 =?us-ascii?Q?qwOW+dkIERVF1TjINtskjBR4h2046xEgSLR49hCiD6vacq5JhaAj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pHjAzGjbaaelKAKaMnnDVS2F4OKbiu0qkYQdQPOzK4WDVfO6EWyvbDUyy5vnaSvw9oQwLDkWpmFy3RSDO5ivxst8xknbvb+hMU/MDXdYg0zIVgsBCbwi9LLNEgLnfQk7Ns0jVnV+sfYVF6vM+rO2/zGWybDry1rOV3fvlJG+JpQE7ycTrBQKcQG4/wJF61TCKsZi3TGiF4q6fh5wkQyZHuBTwRQgW1sEIYRKjabUTjIpqqSbClkbd4qOkVP+9iOGJYtZPXvzLLktA+77G0wSEMgHpOMe/N69SNB0p8VOZax6vJCx4vbSTt92htdp6ZSbpaA91+Z3tRh2o3Rn+UToRw==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70866f4f-efe8-410f-057e-08dee926454e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 01:52:51.3661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hggnmyEhFVooj++pvdhmNL3q0ZM5hme7UhVqFSE6qONFsC1uq1bOEkFUVHuaLgPXrP+3KK5hN7n7tjzrXt14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3A51834D3
X-Outbound-Client-TLS: ANONYMOUS; rcdn-opgw-1.cisco.com [72.163.7.162]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: rcdn-l-core-04.cisco.com
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, July 24, 2026 5:28 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; John Daley
> (johndale) <johndale@cisco.com>; Hyong Youb Kim (hyonkim)
> <hyonkim@cisco.com>
> Subject: [PATCH v2 3/9] net/enic: remove unneeded ops initialization
>=20
> Better to just let compiler initialize fields to NULL since then
> if fields change that driver doesn't use, the driver source
> will not need to be changed.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/enic/enic_ethdev.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/net/enic/enic_ethdev.c b/drivers/net/enic/enic_ethde=
v.c
> index 2e5cd186f9..648aa67a85 100644
> --- a/drivers/net/enic/enic_ethdev.c
> +++ b/drivers/net/enic/enic_ethdev.c
> @@ -1119,8 +1119,6 @@ static const struct eth_dev_ops
> enicpmd_eth_dev_ops =3D {
>  	.dev_configure        =3D enicpmd_dev_configure,
>  	.dev_start            =3D enicpmd_dev_start,
>  	.dev_stop             =3D enicpmd_dev_stop,
> -	.dev_set_link_up      =3D NULL,
> -	.dev_set_link_down    =3D NULL,
>  	.dev_close            =3D enicpmd_dev_close,
>  	.promiscuous_enable   =3D enicpmd_dev_promiscuous_enable,
>  	.promiscuous_disable  =3D enicpmd_dev_promiscuous_disable,
> @@ -1129,14 +1127,10 @@ static const struct eth_dev_ops
> enicpmd_eth_dev_ops =3D {
>  	.link_update          =3D enicpmd_dev_link_update,
>  	.stats_get            =3D enicpmd_dev_stats_get,
>  	.stats_reset          =3D enicpmd_dev_stats_reset,
> -	.queue_stats_mapping_set =3D NULL,
>  	.dev_infos_get        =3D enicpmd_dev_info_get,
>  	.dev_supported_ptypes_get =3D enicpmd_dev_supported_ptypes_get,
>  	.mtu_set              =3D enicpmd_mtu_set,
> -	.vlan_filter_set      =3D NULL,
> -	.vlan_tpid_set        =3D NULL,
>  	.vlan_offload_set     =3D enicpmd_vlan_offload_set,
> -	.vlan_strip_queue_set =3D NULL,
>  	.rx_queue_start       =3D enicpmd_dev_rx_queue_start,
>  	.rx_queue_stop        =3D enicpmd_dev_rx_queue_stop,
>  	.tx_queue_start       =3D enicpmd_dev_tx_queue_start,
> @@ -1151,11 +1145,6 @@ static const struct eth_dev_ops
> enicpmd_eth_dev_ops =3D {
>  	.txq_info_get         =3D enicpmd_dev_txq_info_get,
>  	.rx_burst_mode_get    =3D enicpmd_dev_rx_burst_mode_get,
>  	.tx_burst_mode_get    =3D enicpmd_dev_tx_burst_mode_get,
> -	.dev_led_on           =3D NULL,
> -	.dev_led_off          =3D NULL,
> -	.flow_ctrl_get        =3D NULL,
> -	.flow_ctrl_set        =3D NULL,
> -	.priority_flow_ctrl_set =3D NULL,
>  	.mac_addr_add         =3D enicpmd_add_mac_addr,
>  	.mac_addr_remove      =3D enicpmd_remove_mac_addr,
>  	.mac_addr_set         =3D enicpmd_set_mac_addr,
> --
> 2.53.0

Acked-by: Hyong Youb Kim <hyonkim@cisco.com>

Thanks.
-Hyong

