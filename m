Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578C606A337
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ja9YQC5S
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA1CE40278;
	Mon,  9 Nov 2026 17:00:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 1F2CF40270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:00:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794240036; x=1825776036;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=5iAmN7zK3n37QZfJ2d3fe1G2I94Lqn+YNHjPnW/u/jg=;
 b=ja9YQC5SxNpjdTQYiBJy9ttUg9xAqgDjOmjXyKqkoGtR5VwPDHWevbFK
 BSEK6e/X12ClqGQ7JecE96n+IiMvJJd4gNRAB7iVTAArCvSCLAHXbleUI
 3nRGCQmeFUjA0gwdM8in0wBGt+NcCHKRBBEEZmbVBEp65WnPwSF4gA9LW
 rIy3ZbvGF3bs3imc+FytTw0eIcbCbPVNKPMreRfos4erd0q9x4y1orAK8
 eu2zEsZaf4r7lJ6AD/O1a1uBNfawtsA2BULpB5ByuR2J/PI7Njr/kqjCM
 02Ygvnqi0pTX/a3OvQs3ogoq1oZ/NSgaVcTNehiaEOId1UcplTj9omhrB g==;
X-CSE-ConnectionGUID: F4RqJM03QQmfSvcFD2W6hA==
X-CSE-MsgGUID: FOMNeFmwQkiu6q9hKy5e3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2843387"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; d="scan'208,217";a="2843387"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 08:00:30 -0800
X-CSE-ConnectionGUID: ZE4xc1NZQUyo5D6OfmQ5Mw==
X-CSE-MsgGUID: 9n/pJ+xURUmaCGCP6ZUFKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; d="scan'208,217";a="8223769"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 08:00:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 08:00:29 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 08:00:29 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.50)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 08:00:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1RGfwDu98TSfDob9CoSqqxee77vP4jPV3/pln4wsVJBjRNjEMCoViBMngKhcq1jpuhtdPwC8QvZuqVAh5k7r3pr8Mhj+kc7oUo0xLsYiFuzA60wbDT3QIlFew0DpsWrwIaDt3LpIBKkVXLBMBkeso8GA6p+Vubnzb4XDUGBgyOcBEgP9owU9gAGcwvykknQykzhJ1Xpgx1lBZFT8nnXmzh5JTltkO/3GG+CTpvCpyJzDAng5SDTAkAve/wOwwLB87dPGDNF1k+xNoSjdkM8i0ScgsH18ZJBLf5GU9R29n9J8Bxudu2zoQCCUOgEL8Jvyz97pO7BID2lf5pJjFx8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fTbtw2g3zIM9M5QK2a7UE9jwi51m3QJu+KIDgkmr1k=;
 b=utr80R6DYWVZGGFl1cy5zGhfp49Qy7tRbwqSlFmvVotcZ6ihVTRcgSkj/3/RAogiBsn8Nq98daihfLc+dbJMapPLvWoXEKyNIV7bI55G8S/igOJZiUC9Yq4Q4NCr9PpLjg5wT9lcgYPX21Bab3hs+30U6pGjsp+QiVNXlW6oAS+B/rIdR09930aYPdfOULhsvJZS4Qn6hO/jMkdaVYneJLKN6ZGoqNC2N8JbCj1IkrUyzGz5rZ1chbEfQ5xLyZFSv7e8yaWvmHb3UbeK4F1MTcCvGboOLAfa9+7KfMC2kncreM1zvLT5iSNEdzinuX74NYCi54q0f7sdFPu4oMAtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by DSM1PF21183B112.namprd11.prod.outlook.com (2603:10b6:f:fc02::145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 16:00:26 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 16:00:26 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: Re: [dpdk-dev v11 1/2] app: move FIPS validation under app/
Thread-Topic: [dpdk-dev v11 1/2] app: move FIPS validation under app/
Thread-Index: AQHdbgn31XrGQ51zH0e/jBr7doirmbcl6ebw
Date: Mon, 9 Nov 2026 16:00:26 +0000
Message-ID: <LV2PR11MB6045A8858EDE873F626A0F1281732@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261105163151.3744179-1-kai.ji@intel.com>
 <20261106161441.3818963-1-kai.ji@intel.com>
 <20261106161441.3818963-2-kai.ji@intel.com>
In-Reply-To: <20261106161441.3818963-2-kai.ji@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|DSM1PF21183B112:EE_
x-ms-office365-filtering-correlation-id: 1ead6fde-820b-44aa-5f85-08df3e7a9205
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|23010399003|42112799006|13003099007|22082099003|38070700021|18002099003|4143699003|11063799006|261028144727099003|261026121527099003|260925021911599003|56012099006|260925022911599003|261009223027099003|8096899003|261102123227099003|261021135927099003|261022075727099003|261021123027099003|261021130227099003|261021121427099003|261022113327099003|261022115727099003|261026130827099003|261026140227099003|261022105027099003|261026135527099003|10067099003|6133799003|260925021311599003;
x-microsoft-antispam-message-info: H1ehgaiBvik6GUEpQB50nNmii54qALp9oGh9xpkm6RlgnvUNq7qlYsakEah4K0Madq8NIDVmLMHl4aEo8TGtDZwNCtg1XMi4NKgjASLdzTojktpjKVA18a84mesa8uJNWHlI8Gs75tPEnGkXZQyq5Z5pbES4CCenad7ZjuVJdMWnBJpEMayfhj6zIhHE2pJzy8l005YVw5KjTqWfO+9gBRQyl+hT+MQq7Rf5HXub+EyYPy/FkqmOy+Q+qMTzqIYeTzmVeO4AlLshdEcGWVJY818Z1N4kQC/dU3YZeB8UM71rL9TokP27bu+NdS0PiHdJsGulD2Ydi0Q8QhfszJ80q9+/Wm3ZtuDXWlLQ4IwTibVu38C4i3OZfsfG1+jq0VdzyklL8F88VXk4xlQ7aZs1uY4HT5rErejlaJSTYS/lus/3ju+LaGgsoex/EfvisKnDHSIZ9XUcha9qaeuAUL0xiKwdGUYCSq4ta7knqPQFjhxu81gcgPigp4oPaZP1irrYKQu+0Y0XX2qZvgiJmk55KdBIDIq4HepzyPEfkVyyK1e8eS6rnNdh+U945WDg5xu/XngpzNBcNnToLJAAzJdhYZdJqgx0bkG3m3hiv8aY8BbFe/7GiewLS1IiHW4o9EjlkOT2nQPKUaNEtOJElkBJV5ZUyFxsGRsBAyxIvnpHRgQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(23010399003)(42112799006)(13003099007)(22082099003)(38070700021)(18002099003)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(260925021911599003)(56012099006)(260925022911599003)(261009223027099003)(8096899003)(261102123227099003)(261021135927099003)(261022075727099003)(261021123027099003)(261021130227099003)(261021121427099003)(261022113327099003)(261022115727099003)(261026130827099003)(261026140227099003)(261022105027099003)(261026135527099003)(10067099003)(6133799003)(260925021311599003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8MRLzRGZxzGAiUI+EDBBJvoDQmPCdr3p650rHjqh+n6H9WadPGUL8lr1RSzN?=
 =?us-ascii?Q?E+9eqpYEfj1saoLacbWX1al9MX0PyghSA2LuQ2nUio2+KuBBz01rx2zbnQIV?=
 =?us-ascii?Q?dalLWwndJfSDTOaGLOZmbS8xGbVBESVqpboidGxk7JVq9QVYPY30BFi7g77I?=
 =?us-ascii?Q?uzlFLUe/z+K94nDRXugefTijMGzaVxVnLL3t5dsP69Aqx+YgLABej7z6USkM?=
 =?us-ascii?Q?QYnLKzJY0Hptt2njlBeOWfOcoPbsKTH2UK6NHqdYtxqUUUwVgjmnlU8XGiqD?=
 =?us-ascii?Q?k0/MlIxk4mx5KzURZBby3pI//TLkspRLt9AOaOSrO9Z5vvmJKrTxbGqceUPI?=
 =?us-ascii?Q?N+oGtu+JOSp+ij6yAGyC+FX6NG9lfAZb/as/ozR4zoAOz5qi6jIlWvwyVaHJ?=
 =?us-ascii?Q?XQ15ywjVbA1f+4zeJvh/hKLwKYbH0KJmKOIovHf8ObFGE4V2EsU0PYMrrMkp?=
 =?us-ascii?Q?xY0VhlpO1tzoyWAY1XtfCfdH5CXwFhWW1/jZS2f3dvDtKHIq14Fl4XCPtH2F?=
 =?us-ascii?Q?40m0eAecGVeFiw2OCqnHS33yy7q6nX1455y1F38Nxgr7979n2gmkBsYyn1fP?=
 =?us-ascii?Q?tLQfAyQ6yoMWq6eJo5KLwLLup/4Updco7nTDHk8vO6+lMXleHLZ495zhBTQQ?=
 =?us-ascii?Q?wd98ZMGZITYsaoJXVUDmsOt2ugXREmAqOjZNVBvdwLK3l2/2wJCj788VjE1x?=
 =?us-ascii?Q?zlRGrDce4uiZelNNRuxup30hXcn7K6Ci4E9rpFFFBAGjy+gDkSUhZNOV55Zn?=
 =?us-ascii?Q?cWV7X79uJzvd/KioAulD+H9GEI0e/tUSeix5cOV+Ar15bxeyPsa0PtPl/UHl?=
 =?us-ascii?Q?qYNgle4JiSjwAypZqF5tFYiRc4DS35P3K/Zw8DQfHdRB4RSD9TgSeLG4oQ9G?=
 =?us-ascii?Q?s1O765jFt1yrFBaDyBT7cGWCtUrb5WBho1UALUEei+p19Ef85JGFpFsBvo6N?=
 =?us-ascii?Q?+5Y+tU6x7ObXIjJf/pneIkj+AlC87Yi6yprRO8VDb0ovImbB11mUqKTgSmWA?=
 =?us-ascii?Q?1d1rK+tyOuaS+kYtBcT4MDNo2njXzhe+Fn85eYv5lE8N/94LiVdegV539JhX?=
 =?us-ascii?Q?IpMWEaAw8D0za6CMpvDHWmRpq7CLn22keaFrp1xGMeFIWSD2TakC+/oKn3SO?=
 =?us-ascii?Q?PSqT44TJpzYn6frbx2btTzWwikKUsbBDkryYpLLUisHOAy11o+UZyrcmgNvK?=
 =?us-ascii?Q?ExQUPPiNVLr+20YrYI1A6+/h5crEp4ZDEiBdHTm2H871APu5MgHjGEiAn1Og?=
 =?us-ascii?Q?s3qvNng99jLgQr7St09Uzx7V7Y4i17N8ehpe7PDrD3xbMsotzlyOEBz0bGWK?=
 =?us-ascii?Q?rSniKk+7fa0ARlziS7YA1M/LXIhWlCubq9eTNmsftxaCdrDzT3ClbaW+b3bw?=
 =?us-ascii?Q?yipDyZW0He02HqcvhXwlDkT/il3gfYQ/v5MHcnXt8wASm72Mk8xJ5vJT+GXV?=
 =?us-ascii?Q?CMBVa1jFRMIYhUKZlRmv2q7th+HTc8miC4QNo9+Gnasxpmklf1MHydStu2iH?=
 =?us-ascii?Q?LaCTKNV9Q/urxoIimpCooOZS7zn+MW4tXmU58rKbWm2COaKa8vdXU57S5F+G?=
 =?us-ascii?Q?MNNOuipfHIHV1qikHeJRP0pe2DkS0Qm/8Uo01tF+VDLwZiy6qum/3/BChUno?=
 =?us-ascii?Q?psIrJfSp7qnsDRz5DW2ubcDbFkv6BSsBn3B9RF5En/BBNEylkaF7uWu+5CX0?=
 =?us-ascii?Q?7f8Ee3BQwKDLh55+OOBE9r+oMQnCG4XZfEPIHTIzwHJPY2wswvX8SmBg03Xw?=
 =?us-ascii?Q?BYLj7foaTBZ6/y01G+nA6/b5SDbxSR+KraJecmQMyO2Fj40QtZdH?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB6045A8858EDE873F626A0F1281732LV2PR11MB6045namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1W7hYlxizBgMSyCCK70ajqfXK7bn4dEaqW/ImaP41jx1kK/x9tbuLFvCwfvfyUo5kfiwWZI5zR+KwcqayC97ZhNKGU4A1Pgg1YcJBfBOWDKfslKg8ao3t7SFbJumk1pXS+ECYzX09/0y/uixN1hSV/xvLN5+ii662nN0gyeOANQgz9iIDJNFSSLuxwl1+NSAWAWLrPkCiGddTK8U+zwfAS4GH+xcDeQV+PqAdt83u2CH6iKrP8VfPFTtcv4aFUtiXmCIx9thVFuS85fvWp47/6hd+96GAcQ9k2al8qyMswne4OeXYoiLAS85LIXx+BTaWXfFvOOlTzd37fVW0gm05Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ead6fde-820b-44aa-5f85-08df3e7a9205
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 16:00:26.6003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+UQ7sEegDBEk2e+U7vVO3VGHh2xVk4TH1I3CXfANDX2s6HTh5Hfu7DaYm5pZUO6o+2lFjSJeS7PdJEz5Wmcfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF21183B112
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_LV2PR11MB6045A8858EDE873F626A0F1281732LV2PR11MB6045namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ci fix: https://patchwork.dpdk.org/project/ci/patch/20261109154059.3874106-=
1-kai.ji@intel.com/
________________________________
From: Ji, Kai <kai.ji@intel.com>
Sent: 06 November 2026 16:14
To: dev@dpdk.org <dev@dpdk.org>
Cc: Ji, Kai <kai.ji@intel.com>; Thomas Monjalon <thomas@monjalon.net>; Gowr=
ishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [dpdk-dev v11 1/2] app: move FIPS validation under app/

Rename the sample guide to crypto_validation.rst and make FIPS
validation its first section. Update the app registration and guide
references to match the new location.

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 MAINTAINERS                                   |  6 +-
 .../fips_validation/fips_dev_self_test.c      |  0
 .../fips_validation/fips_dev_self_test.h      |  0
 .../fips_validation/fips_validation.c         |  0
 .../fips_validation/fips_validation.h         |  0
 .../fips_validation/fips_validation_aes.c     |  0
 .../fips_validation/fips_validation_ccm.c     |  0
 .../fips_validation/fips_validation_cmac.c    |  0
 .../fips_validation/fips_validation_ecdsa.c   |  0
 .../fips_validation/fips_validation_eddsa.c   |  0
 .../fips_validation/fips_validation_gcm.c     |  0
 .../fips_validation/fips_validation_hmac.c    |  0
 .../fips_validation/fips_validation_rsa.c     |  0
 .../fips_validation/fips_validation_sha.c     |  0
 .../fips_validation/fips_validation_tdes.c    |  0
 .../fips_validation/fips_validation_xts.c     |  0
 {examples =3D> app}/fips_validation/main.c      |  0
 {examples =3D> app}/fips_validation/meson.build | 12 ++--
 app/meson.build                               |  1 +
 doc/guides/rel_notes/release_22_11.rst        |  2 +-
 ...s_validation.rst =3D> crypto_validation.rst} | 34 ++++++----
 doc/guides/sample_app_ug/index.rst            |  2 +-
 examples/fips_validation/Makefile             | 62 -------------------
 examples/meson.build                          |  1 -
 24 files changed, 34 insertions(+), 86 deletions(-)
 rename {examples =3D> app}/fips_validation/fips_dev_self_test.c (100%)
 rename {examples =3D> app}/fips_validation/fips_dev_self_test.h (100%)
 rename {examples =3D> app}/fips_validation/fips_validation.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation.h (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_aes.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_ccm.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_cmac.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_ecdsa.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_eddsa.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_gcm.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_hmac.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_rsa.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_sha.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_tdes.c (100%)
 rename {examples =3D> app}/fips_validation/fips_validation_xts.c (100%)
 rename {examples =3D> app}/fips_validation/main.c (100%)
 rename {examples =3D> app}/fips_validation/meson.build (79%)
 rename doc/guides/sample_app_ug/{fips_validation.rst =3D> crypto_validatio=
n.rst} (90%)
 delete mode 100644 examples/fips_validation/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d865ffd46..736f39c70e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2040,10 +2040,10 @@ Ethtool example
 F: examples/ethtool/
 F: doc/guides/sample_app_ug/ethtool.rst

-FIPS validation example
+FIPS validation application
 M: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
-F: examples/fips_validation/
-F: doc/guides/sample_app_ug/fips_validation.rst
+F: app/fips_validation/
+F: doc/guides/sample_app_ug/crypto_validation.rst

 Flow filtering example
 M: Ori Kam <orika@nvidia.com>
diff --git a/examples/fips_validation/fips_dev_self_test.c b/app/fips_valid=
ation/fips_dev_self_test.c
similarity index 100%
rename from examples/fips_validation/fips_dev_self_test.c
rename to app/fips_validation/fips_dev_self_test.c
diff --git a/examples/fips_validation/fips_dev_self_test.h b/app/fips_valid=
ation/fips_dev_self_test.h
similarity index 100%
rename from examples/fips_validation/fips_dev_self_test.h
rename to app/fips_validation/fips_dev_self_test.h
diff --git a/examples/fips_validation/fips_validation.c b/app/fips_validati=
on/fips_validation.c
similarity index 100%
rename from examples/fips_validation/fips_validation.c
rename to app/fips_validation/fips_validation.c
diff --git a/examples/fips_validation/fips_validation.h b/app/fips_validati=
on/fips_validation.h
similarity index 100%
rename from examples/fips_validation/fips_validation.h
rename to app/fips_validation/fips_validation.h
diff --git a/examples/fips_validation/fips_validation_aes.c b/app/fips_vali=
dation/fips_validation_aes.c
similarity index 100%
rename from examples/fips_validation/fips_validation_aes.c
rename to app/fips_validation/fips_validation_aes.c
diff --git a/examples/fips_validation/fips_validation_ccm.c b/app/fips_vali=
dation/fips_validation_ccm.c
similarity index 100%
rename from examples/fips_validation/fips_validation_ccm.c
rename to app/fips_validation/fips_validation_ccm.c
diff --git a/examples/fips_validation/fips_validation_cmac.c b/app/fips_val=
idation/fips_validation_cmac.c
similarity index 100%
rename from examples/fips_validation/fips_validation_cmac.c
rename to app/fips_validation/fips_validation_cmac.c
diff --git a/examples/fips_validation/fips_validation_ecdsa.c b/app/fips_va=
lidation/fips_validation_ecdsa.c
similarity index 100%
rename from examples/fips_validation/fips_validation_ecdsa.c
rename to app/fips_validation/fips_validation_ecdsa.c
diff --git a/examples/fips_validation/fips_validation_eddsa.c b/app/fips_va=
lidation/fips_validation_eddsa.c
similarity index 100%
rename from examples/fips_validation/fips_validation_eddsa.c
rename to app/fips_validation/fips_validation_eddsa.c
diff --git a/examples/fips_validation/fips_validation_gcm.c b/app/fips_vali=
dation/fips_validation_gcm.c
similarity index 100%
rename from examples/fips_validation/fips_validation_gcm.c
rename to app/fips_validation/fips_validation_gcm.c
diff --git a/examples/fips_validation/fips_validation_hmac.c b/app/fips_val=
idation/fips_validation_hmac.c
similarity index 100%
rename from examples/fips_validation/fips_validation_hmac.c
rename to app/fips_validation/fips_validation_hmac.c
diff --git a/examples/fips_validation/fips_validation_rsa.c b/app/fips_vali=
dation/fips_validation_rsa.c
similarity index 100%
rename from examples/fips_validation/fips_validation_rsa.c
rename to app/fips_validation/fips_validation_rsa.c
diff --git a/examples/fips_validation/fips_validation_sha.c b/app/fips_vali=
dation/fips_validation_sha.c
similarity index 100%
rename from examples/fips_validation/fips_validation_sha.c
rename to app/fips_validation/fips_validation_sha.c
diff --git a/examples/fips_validation/fips_validation_tdes.c b/app/fips_val=
idation/fips_validation_tdes.c
similarity index 100%
rename from examples/fips_validation/fips_validation_tdes.c
rename to app/fips_validation/fips_validation_tdes.c
diff --git a/examples/fips_validation/fips_validation_xts.c b/app/fips_vali=
dation/fips_validation_xts.c
similarity index 100%
rename from examples/fips_validation/fips_validation_xts.c
rename to app/fips_validation/fips_validation_xts.c
diff --git a/examples/fips_validation/main.c b/app/fips_validation/main.c
similarity index 100%
rename from examples/fips_validation/main.c
rename to app/fips_validation/main.c
diff --git a/examples/fips_validation/meson.build b/app/fips_validation/mes=
on.build
similarity index 79%
rename from examples/fips_validation/meson.build
rename to app/fips_validation/meson.build
index 6c29b535cb..d7055eca64 100644
--- a/examples/fips_validation/meson.build
+++ b/app/fips_validation/meson.build
@@ -1,13 +1,15 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Intel Corporation

-# meson file, for building this example as part of a main DPDK build.
-#
-# To build this example as a standalone application with an already-instal=
led
-# DPDK instance, use 'make'
+# meson file, for building this application as part of a main DPDK build.
+
+if is_windows
+    build =3D false
+    reason =3D 'not supported on Windows'
+    subdir_done()
+endif

 deps +=3D ['cryptodev']
-allow_experimental_apis =3D true
 sources =3D files(
         'fips_validation_aes.c',
         'fips_validation.c',
diff --git a/app/meson.build b/app/meson.build
index 24fadc1963..927f79d0b3 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -14,6 +14,7 @@ endif

 apps =3D [
         'dumpcap',
+        'fips_validation',
         'graph',
         'pdump',
         'proc-info',
diff --git a/doc/guides/rel_notes/release_22_11.rst b/doc/guides/rel_notes/=
release_22_11.rst
index a8d48344c3..f5d47de741 100644
--- a/doc/guides/rel_notes/release_22_11.rst
+++ b/doc/guides/rel_notes/release_22_11.rst
@@ -273,7 +273,7 @@ New Features
 * **Updated FIPS validation sample application.**

   Added support for asymmetric crypto algorithms.
-  See the :doc:`/sample_app_ug/fips_validation` for more details.
+  See the :doc:`/sample_app_ug/crypto_validation` for more details.

 * **Rewrote pmdinfo script.**

diff --git a/doc/guides/sample_app_ug/fips_validation.rst b/doc/guides/samp=
le_app_ug/crypto_validation.rst
similarity index 90%
rename from doc/guides/sample_app_ug/fips_validation.rst
rename to doc/guides/sample_app_ug/crypto_validation.rst
index 613c5afd19..67b9e2d351 100644
--- a/doc/guides/sample_app_ug/fips_validation.rst
+++ b/doc/guides/sample_app_ug/crypto_validation.rst
@@ -1,11 +1,14 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2018 Intel Corporation.

-Federal Information Processing Standards (FIPS) CryptoDev Validation
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Cryptographic Validation Applications
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+FIPS Validation
+---------------

 Overview
---------
+~~~~~~~~

 Federal Information Processing Standards (FIPS) are publicly announced sta=
ndards
 developed by the United States federal government for use in computer syst=
ems by
@@ -22,10 +25,10 @@ and FIPS 140-3 (in case of ACVP) and must successfully =
complete the
 cryptographic algorithm validation process.

 Limitations
------------
+~~~~~~~~~~~

 CAVP
-----
+^^^^

 * The version of request file supported is ``CAVS 21.0``.
 * If the header comment in a ``.req`` file does not contain a Algo tag
@@ -52,7 +55,7 @@ CAVP
       VarText

 ACVP
-----
+^^^^

 * The application does not supply the test vectors. The user is expected t=
o
   obtain the test vector files from `ACVP  <https://pages.nist.gov/ACVP>`_
@@ -76,7 +79,7 @@ ACVP


 Application Information
------------------------
+~~~~~~~~~~~~~~~~~~~~~~~

 If a ``.req`` is used as the input file after the application is finished
 running it will generate a response file or ``.rsp``. Differences between =
the
@@ -93,11 +96,16 @@ validating if the application has done the operation co=
rrectly.


 Compiling the Application
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~

 * Compile Application

-    To compile the sample application see :doc:`compiling`.
+    From the DPDK source tree, build the application with Meson:
+
+    .. code-block:: console
+
+       meson setup build -Denable_apps=3Dfips_validation
+       meson compile -C build

 *  Run ``dos2unix`` on the request files

@@ -112,13 +120,13 @@ Compiling the Application
          dos2unix SHA/req/*

 Running the Application
------------------------
+~~~~~~~~~~~~~~~~~~~~~~~

 The application requires a number of command line options:

     .. code-block:: console

-         ./dpdk-fips_validation [EAL options]
+         ./build/app/dpdk-fips_validation [EAL options]
          -- --req-file FILE_PATH/FOLDER_PATH
          --rsp-file FILE_PATH/FOLDER_PATH
          [--cryptodev DEVICE_NAME] [--cryptodev-id ID] [--path-is-folder]
@@ -149,7 +157,7 @@ file for crypto_aesni_mb PMD, issue the command:

 .. code-block:: console

-    $ ./dpdk-fips_validation --vdev crypto_aesni_mb --
+    $ ./build/app/dpdk-fips_validation --vdev crypto_aesni_mb --
     --req-file /PATH/TO/REQUEST/FILE.req --rsp-file ./PATH/TO/RESPONSE/FIL=
E.rsp
     --cryptodev crypto_aesni_mb

@@ -158,7 +166,7 @@ data files in one folder for crypto_aesni_gcm PMD, issu=
e the command:

 .. code-block:: console

-    $ ./dpdk-fips_validation --vdev crypto_aesni_gcm0 --
+    $ ./build/app/dpdk-fips_validation --vdev crypto_aesni_gcm0 --
     --req-file /PATH/TO/REQUEST/FILE/FOLDER/
     --rsp-file ./PATH/TO/RESPONSE/FILE/FOLDER/
     --cryptodev-id 0 --path-is-folder
diff --git a/doc/guides/sample_app_ug/index.rst b/doc/guides/sample_app_ug/=
index.rst
index 28c4c9a5b2..a71d14f83f 100644
--- a/doc/guides/sample_app_ug/index.rst
+++ b/doc/guides/sample_app_ug/index.rst
@@ -50,7 +50,7 @@ Sample Applications User Guides
     vm_power_management
     ptpclient
     ptp_tap_relay_sw
-    fips_validation
+    crypto_validation
     ipsec_secgw
     bbdev_app
     ntb
diff --git a/examples/fips_validation/Makefile b/examples/fips_validation/M=
akefile
deleted file mode 100644
index 4864966e77..0000000000
--- a/examples/fips_validation/Makefile
+++ /dev/null
@@ -1,62 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2018 Intel Corporation
-
-# binary name
-APP =3D fips_validation
-
-# all source are stored in SRCS-y
-SRCS-y :=3D fips_validation.c
-SRCS-y +=3D fips_validation_aes.c
-SRCS-y +=3D fips_validation_hmac.c
-SRCS-y +=3D fips_validation_tdes.c
-SRCS-y +=3D fips_validation_gcm.c
-SRCS-y +=3D fips_validation_cmac.c
-SRCS-y +=3D fips_validation_ccm.c
-SRCS-y +=3D fips_validation_sha.c
-SRCS-y +=3D fips_dev_self_test.c
-SRCS-y +=3D fips_validation_xts.c
-SRCS-y +=3D fips_validation_rsa.c
-SRCS-y +=3D fips_validation_ecdsa.c
-SRCS-y +=3D fips_validation_eddsa.c
-SRCS-y +=3D main.c
-
-PKGCONF ?=3D pkg-config
-
-# Build using pkg-config variables if possible
-ifneq ($(shell $(PKGCONF) --exists libdpdk && echo 0),0)
-$(error "no installation of DPDK found")
-endif
-
-all: shared
-.PHONY: shared static
-shared: build/$(APP)-shared
-       ln -sf $(APP)-shared build/$(APP)
-static: build/$(APP)-static
-       ln -sf $(APP)-static build/$(APP)
-
-PC_FILE :=3D $(shell $(PKGCONF) --path libdpdk 2>/dev/null)
-CFLAGS +=3D -O3 $(shell $(PKGCONF) --cflags libdpdk)
-LDFLAGS_SHARED =3D $(shell $(PKGCONF) --libs libdpdk)
-LDFLAGS_STATIC =3D $(shell $(PKGCONF) --static --libs libdpdk)
-
-JANSSON :=3D $(shell $(PKGCONF) --exists jansson; echo $$?)
-ifeq ($(JANSSON), 0)
-LDFLAGS +=3D $(shell $(PKGCONF) --libs jansson)
-CFLAGS +=3D -DUSE_JANSSON
-endif
-
-CFLAGS +=3D -DALLOW_EXPERIMENTAL_API
-
-build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
-       $(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_SHARED)
-
-build/$(APP)-static: $(SRCS-y) Makefile $(PC_FILE) | build
-       $(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_STATIC)
-
-build:
-       @mkdir -p $@
-
-.PHONY: clean
-clean:
-       rm -f build/$(APP) build/$(APP)-static build/$(APP)-shared
-       test -d build && rmdir -p build || true
diff --git a/examples/meson.build b/examples/meson.build
index 544ec5eadd..4b739c9b82 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -15,7 +15,6 @@ all_examples =3D [
         'dma',
         'ethtool',
         'eventdev_pipeline',
-        'fips_validation',
         'flow_filtering',
         'helloworld',
         'ip_fragmentation',
--
2.34.1


--_000_LV2PR11MB6045A8858EDE873F626A0F1281732LV2PR11MB6045namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Ci fix: <a href=3D"https://patchwork.dpdk.org/project/ci/patch/202611091540=
59.3874106-1-kai.ji@intel.com/">
https://patchwork.dpdk.org/project/ci/patch/20261109154059.3874106-1-kai.ji=
@intel.com/</a></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ji, Kai &lt;kai.ji@in=
tel.com&gt;<br>
<b>Sent:</b> 06 November 2026 16:14<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Ji, Kai &lt;kai.ji@intel.com&gt;; Thomas Monjalon &lt;thomas@mon=
jalon.net&gt;; Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com&gt;<=
br>
<b>Subject:</b> [dpdk-dev v11 1/2] app: move FIPS validation under app/</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Rename the sample guide to crypto_validation.rst a=
nd make FIPS<br>
validation its first section. Update the app registration and guide<br>
references to match the new location.<br>
<br>
Signed-off-by: Kai Ji &lt;kai.ji@intel.com&gt;<br>
---<br>
&nbsp;MAINTAINERS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 6 +-<br>
&nbsp;.../fips_validation/fips_dev_self_test.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 0<br>
&nbsp;.../fips_validation/fips_dev_self_test.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 0<br>
&nbsp;.../fips_validation/fips_validation.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 0<br>
&nbsp;.../fips_validation/fips_validation.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 0<br>
&nbsp;.../fips_validation/fips_validation_aes.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 0<br>
&nbsp;.../fips_validation/fips_validation_ccm.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 0<br>
&nbsp;.../fips_validation/fips_validation_cmac.c&nbsp;&nbsp;&nbsp; |&nbsp; =
0<br>
&nbsp;.../fips_validation/fips_validation_ecdsa.c&nbsp;&nbsp; |&nbsp; 0<br>
&nbsp;.../fips_validation/fips_validation_eddsa.c&nbsp;&nbsp; |&nbsp; 0<br>
&nbsp;.../fips_validation/fips_validation_gcm.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 0<br>
&nbsp;.../fips_validation/fips_validation_hmac.c&nbsp;&nbsp;&nbsp; |&nbsp; =
0<br>
&nbsp;.../fips_validation/fips_validation_rsa.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 0<br>
&nbsp;.../fips_validation/fips_validation_sha.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 0<br>
&nbsp;.../fips_validation/fips_validation_tdes.c&nbsp;&nbsp;&nbsp; |&nbsp; =
0<br>
&nbsp;.../fips_validation/fips_validation_xts.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 0<br>
&nbsp;{examples =3D&gt; app}/fips_validation/main.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 0<br>
&nbsp;{examples =3D&gt; app}/fips_validation/meson.build | 12 ++--<br>
&nbsp;app/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;doc/guides/rel_notes/release_22_11.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;...s_validation.rst =3D&gt; crypto_validation.rst} | 34 ++++++----<br=
>
&nbsp;doc/guides/sample_app_ug/index.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;examples/fips_validation/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 62 -------------------<br>
&nbsp;examples/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 -<br>
&nbsp;24 files changed, 34 insertions(+), 86 deletions(-)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_dev_self_test.c (1=
00%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_dev_self_test.h (1=
00%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation.c (100%=
)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation.h (100%=
)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_aes.c (=
100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_ccm.c (=
100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_cmac.c =
(100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_ecdsa.c=
 (100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_eddsa.c=
 (100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_gcm.c (=
100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_hmac.c =
(100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_rsa.c (=
100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_sha.c (=
100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_tdes.c =
(100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/fips_validation_xts.c (=
100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/main.c (100%)<br>
&nbsp;rename {examples =3D&gt; app}/fips_validation/meson.build (79%)<br>
&nbsp;rename doc/guides/sample_app_ug/{fips_validation.rst =3D&gt; crypto_v=
alidation.rst} (90%)<br>
&nbsp;delete mode 100644 examples/fips_validation/Makefile<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 1d865ffd46..736f39c70e 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -2040,10 +2040,10 @@ Ethtool example<br>
&nbsp;F: examples/ethtool/<br>
&nbsp;F: doc/guides/sample_app_ug/ethtool.rst<br>
&nbsp;<br>
-FIPS validation example<br>
+FIPS validation application<br>
&nbsp;M: Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com&gt;<br>
-F: examples/fips_validation/<br>
-F: doc/guides/sample_app_ug/fips_validation.rst<br>
+F: app/fips_validation/<br>
+F: doc/guides/sample_app_ug/crypto_validation.rst<br>
&nbsp;<br>
&nbsp;Flow filtering example<br>
&nbsp;M: Ori Kam &lt;orika@nvidia.com&gt;<br>
diff --git a/examples/fips_validation/fips_dev_self_test.c b/app/fips_valid=
ation/fips_dev_self_test.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_dev_self_test.c<br>
rename to app/fips_validation/fips_dev_self_test.c<br>
diff --git a/examples/fips_validation/fips_dev_self_test.h b/app/fips_valid=
ation/fips_dev_self_test.h<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_dev_self_test.h<br>
rename to app/fips_validation/fips_dev_self_test.h<br>
diff --git a/examples/fips_validation/fips_validation.c b/app/fips_validati=
on/fips_validation.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation.c<br>
rename to app/fips_validation/fips_validation.c<br>
diff --git a/examples/fips_validation/fips_validation.h b/app/fips_validati=
on/fips_validation.h<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation.h<br>
rename to app/fips_validation/fips_validation.h<br>
diff --git a/examples/fips_validation/fips_validation_aes.c b/app/fips_vali=
dation/fips_validation_aes.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_aes.c<br>
rename to app/fips_validation/fips_validation_aes.c<br>
diff --git a/examples/fips_validation/fips_validation_ccm.c b/app/fips_vali=
dation/fips_validation_ccm.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_ccm.c<br>
rename to app/fips_validation/fips_validation_ccm.c<br>
diff --git a/examples/fips_validation/fips_validation_cmac.c b/app/fips_val=
idation/fips_validation_cmac.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_cmac.c<br>
rename to app/fips_validation/fips_validation_cmac.c<br>
diff --git a/examples/fips_validation/fips_validation_ecdsa.c b/app/fips_va=
lidation/fips_validation_ecdsa.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_ecdsa.c<br>
rename to app/fips_validation/fips_validation_ecdsa.c<br>
diff --git a/examples/fips_validation/fips_validation_eddsa.c b/app/fips_va=
lidation/fips_validation_eddsa.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_eddsa.c<br>
rename to app/fips_validation/fips_validation_eddsa.c<br>
diff --git a/examples/fips_validation/fips_validation_gcm.c b/app/fips_vali=
dation/fips_validation_gcm.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_gcm.c<br>
rename to app/fips_validation/fips_validation_gcm.c<br>
diff --git a/examples/fips_validation/fips_validation_hmac.c b/app/fips_val=
idation/fips_validation_hmac.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_hmac.c<br>
rename to app/fips_validation/fips_validation_hmac.c<br>
diff --git a/examples/fips_validation/fips_validation_rsa.c b/app/fips_vali=
dation/fips_validation_rsa.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_rsa.c<br>
rename to app/fips_validation/fips_validation_rsa.c<br>
diff --git a/examples/fips_validation/fips_validation_sha.c b/app/fips_vali=
dation/fips_validation_sha.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_sha.c<br>
rename to app/fips_validation/fips_validation_sha.c<br>
diff --git a/examples/fips_validation/fips_validation_tdes.c b/app/fips_val=
idation/fips_validation_tdes.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_tdes.c<br>
rename to app/fips_validation/fips_validation_tdes.c<br>
diff --git a/examples/fips_validation/fips_validation_xts.c b/app/fips_vali=
dation/fips_validation_xts.c<br>
similarity index 100%<br>
rename from examples/fips_validation/fips_validation_xts.c<br>
rename to app/fips_validation/fips_validation_xts.c<br>
diff --git a/examples/fips_validation/main.c b/app/fips_validation/main.c<b=
r>
similarity index 100%<br>
rename from examples/fips_validation/main.c<br>
rename to app/fips_validation/main.c<br>
diff --git a/examples/fips_validation/meson.build b/app/fips_validation/mes=
on.build<br>
similarity index 79%<br>
rename from examples/fips_validation/meson.build<br>
rename to app/fips_validation/meson.build<br>
index 6c29b535cb..d7055eca64 100644<br>
--- a/examples/fips_validation/meson.build<br>
+++ b/app/fips_validation/meson.build<br>
@@ -1,13 +1,15 @@<br>
&nbsp;# SPDX-License-Identifier: BSD-3-Clause<br>
&nbsp;# Copyright(c) 2018 Intel Corporation<br>
&nbsp;<br>
-# meson file, for building this example as part of a main DPDK build.<br>
-#<br>
-# To build this example as a standalone application with an already-instal=
led<br>
-# DPDK instance, use 'make'<br>
+# meson file, for building this application as part of a main DPDK build.<=
br>
+<br>
+if is_windows<br>
+&nbsp;&nbsp;&nbsp; build =3D false<br>
+&nbsp;&nbsp;&nbsp; reason =3D 'not supported on Windows'<br>
+&nbsp;&nbsp;&nbsp; subdir_done()<br>
+endif<br>
&nbsp;<br>
&nbsp;deps +=3D ['cryptodev']<br>
-allow_experimental_apis =3D true<br>
&nbsp;sources =3D files(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'fips_validation_aes.c',<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'fips_validation.c',<br>
diff --git a/app/meson.build b/app/meson.build<br>
index 24fadc1963..927f79d0b3 100644<br>
--- a/app/meson.build<br>
+++ b/app/meson.build<br>
@@ -14,6 +14,7 @@ endif<br>
&nbsp;<br>
&nbsp;apps =3D [<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dumpcap',<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'fips_validation',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'graph',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'pdump',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'proc-info',<br>
diff --git a/doc/guides/rel_notes/release_22_11.rst b/doc/guides/rel_notes/=
release_22_11.rst<br>
index a8d48344c3..f5d47de741 100644<br>
--- a/doc/guides/rel_notes/release_22_11.rst<br>
+++ b/doc/guides/rel_notes/release_22_11.rst<br>
@@ -273,7 +273,7 @@ New Features<br>
&nbsp;* **Updated FIPS validation sample application.**<br>
&nbsp;<br>
&nbsp;&nbsp; Added support for asymmetric crypto algorithms.<br>
-&nbsp; See the :doc:`/sample_app_ug/fips_validation` for more details.<br>
+&nbsp; See the :doc:`/sample_app_ug/crypto_validation` for more details.<b=
r>
&nbsp;<br>
&nbsp;* **Rewrote pmdinfo script.**<br>
&nbsp;<br>
diff --git a/doc/guides/sample_app_ug/fips_validation.rst b/doc/guides/samp=
le_app_ug/crypto_validation.rst<br>
similarity index 90%<br>
rename from doc/guides/sample_app_ug/fips_validation.rst<br>
rename to doc/guides/sample_app_ug/crypto_validation.rst<br>
index 613c5afd19..67b9e2d351 100644<br>
--- a/doc/guides/sample_app_ug/fips_validation.rst<br>
+++ b/doc/guides/sample_app_ug/crypto_validation.rst<br>
@@ -1,11 +1,14 @@<br>
&nbsp;..&nbsp; SPDX-License-Identifier: BSD-3-Clause<br>
&nbsp;&nbsp;&nbsp;&nbsp; Copyright(c) 2018 Intel Corporation.<br>
&nbsp;<br>
-Federal Information Processing Standards (FIPS) CryptoDev Validation<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+Cryptographic Validation Applications<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+FIPS Validation<br>
+---------------<br>
&nbsp;<br>
&nbsp;Overview<br>
---------<br>
+~~~~~~~~<br>
&nbsp;<br>
&nbsp;Federal Information Processing Standards (FIPS) are publicly announce=
d standards<br>
&nbsp;developed by the United States federal government for use in computer=
 systems by<br>
@@ -22,10 +25,10 @@ and FIPS 140-3 (in case of ACVP) and must successfully =
complete the<br>
&nbsp;cryptographic algorithm validation process.<br>
&nbsp;<br>
&nbsp;Limitations<br>
------------<br>
+~~~~~~~~~~~<br>
&nbsp;<br>
&nbsp;CAVP<br>
-----<br>
+^^^^<br>
&nbsp;<br>
&nbsp;* The version of request file supported is ``CAVS 21.0``.<br>
&nbsp;* If the header comment in a ``.req`` file does not contain a Algo ta=
g<br>
@@ -52,7 +55,7 @@ CAVP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VarText<br>
&nbsp;<br>
&nbsp;ACVP<br>
-----<br>
+^^^^<br>
&nbsp;<br>
&nbsp;* The application does not supply the test vectors. The user is expec=
ted to<br>
&nbsp;&nbsp; obtain the test vector files from `ACVP&nbsp; &lt;<a href=3D"h=
ttps://pages.nist.gov/ACVP">https://pages.nist.gov/ACVP</a>&gt;`_<br>
@@ -76,7 +79,7 @@ ACVP<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;Application Information<br>
------------------------<br>
+~~~~~~~~~~~~~~~~~~~~~~~<br>
&nbsp;<br>
&nbsp;If a ``.req`` is used as the input file after the application is fini=
shed<br>
&nbsp;running it will generate a response file or ``.rsp``. Differences bet=
ween the<br>
@@ -93,11 +96,16 @@ validating if the application has done the operation co=
rrectly.<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;Compiling the Application<br>
--------------------------<br>
+~~~~~~~~~~~~~~~~~~~~~~~~~<br>
&nbsp;<br>
&nbsp;* Compile Application<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; To compile the sample application see :doc:`compiling`.=
<br>
+&nbsp;&nbsp;&nbsp; From the DPDK source tree, build the application with M=
eson:<br>
+<br>
+&nbsp;&nbsp;&nbsp; .. code-block:: console<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; meson setup build -Denable_apps=3Dfip=
s_validation<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; meson compile -C build<br>
&nbsp;<br>
&nbsp;*&nbsp; Run ``dos2unix`` on the request files<br>
&nbsp;<br>
@@ -112,13 +120,13 @@ Compiling the Application<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dos2unix SHA/req/*<b=
r>
&nbsp;<br>
&nbsp;Running the Application<br>
------------------------<br>
+~~~~~~~~~~~~~~~~~~~~~~~<br>
&nbsp;<br>
&nbsp;The application requires a number of command line options:<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; .. code-block:: console<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ./dpdk-fips_validation [E=
AL options]<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ./build/app/dpdk-fips_val=
idation [EAL options]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- --req-file FILE_P=
ATH/FOLDER_PATH<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --rsp-file FILE_PATH=
/FOLDER_PATH<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [--cryptodev DEVICE_=
NAME] [--cryptodev-id ID] [--path-is-folder]<br>
@@ -149,7 +157,7 @@ file for crypto_aesni_mb PMD, issue the command:<br>
&nbsp;<br>
&nbsp;.. code-block:: console<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; $ ./dpdk-fips_validation --vdev crypto_aesni_mb --<br>
+&nbsp;&nbsp;&nbsp; $ ./build/app/dpdk-fips_validation --vdev crypto_aesni_=
mb --<br>
&nbsp;&nbsp;&nbsp;&nbsp; --req-file /PATH/TO/REQUEST/FILE.req --rsp-file ./=
PATH/TO/RESPONSE/FILE.rsp<br>
&nbsp;&nbsp;&nbsp;&nbsp; --cryptodev crypto_aesni_mb<br>
&nbsp;<br>
@@ -158,7 +166,7 @@ data files in one folder for crypto_aesni_gcm PMD, issu=
e the command:<br>
&nbsp;<br>
&nbsp;.. code-block:: console<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; $ ./dpdk-fips_validation --vdev crypto_aesni_gcm0 --<br=
>
+&nbsp;&nbsp;&nbsp; $ ./build/app/dpdk-fips_validation --vdev crypto_aesni_=
gcm0 --<br>
&nbsp;&nbsp;&nbsp;&nbsp; --req-file /PATH/TO/REQUEST/FILE/FOLDER/<br>
&nbsp;&nbsp;&nbsp;&nbsp; --rsp-file ./PATH/TO/RESPONSE/FILE/FOLDER/<br>
&nbsp;&nbsp;&nbsp;&nbsp; --cryptodev-id 0 --path-is-folder<br>
diff --git a/doc/guides/sample_app_ug/index.rst b/doc/guides/sample_app_ug/=
index.rst<br>
index 28c4c9a5b2..a71d14f83f 100644<br>
--- a/doc/guides/sample_app_ug/index.rst<br>
+++ b/doc/guides/sample_app_ug/index.rst<br>
@@ -50,7 +50,7 @@ Sample Applications User Guides<br>
&nbsp;&nbsp;&nbsp;&nbsp; vm_power_management<br>
&nbsp;&nbsp;&nbsp;&nbsp; ptpclient<br>
&nbsp;&nbsp;&nbsp;&nbsp; ptp_tap_relay_sw<br>
-&nbsp;&nbsp;&nbsp; fips_validation<br>
+&nbsp;&nbsp;&nbsp; crypto_validation<br>
&nbsp;&nbsp;&nbsp;&nbsp; ipsec_secgw<br>
&nbsp;&nbsp;&nbsp;&nbsp; bbdev_app<br>
&nbsp;&nbsp;&nbsp;&nbsp; ntb<br>
diff --git a/examples/fips_validation/Makefile b/examples/fips_validation/M=
akefile<br>
deleted file mode 100644<br>
index 4864966e77..0000000000<br>
--- a/examples/fips_validation/Makefile<br>
+++ /dev/null<br>
@@ -1,62 +0,0 @@<br>
-# SPDX-License-Identifier: BSD-3-Clause<br>
-# Copyright(c) 2018 Intel Corporation<br>
-<br>
-# binary name<br>
-APP =3D fips_validation<br>
-<br>
-# all source are stored in SRCS-y<br>
-SRCS-y :=3D fips_validation.c<br>
-SRCS-y +=3D fips_validation_aes.c<br>
-SRCS-y +=3D fips_validation_hmac.c<br>
-SRCS-y +=3D fips_validation_tdes.c<br>
-SRCS-y +=3D fips_validation_gcm.c<br>
-SRCS-y +=3D fips_validation_cmac.c<br>
-SRCS-y +=3D fips_validation_ccm.c<br>
-SRCS-y +=3D fips_validation_sha.c<br>
-SRCS-y +=3D fips_dev_self_test.c<br>
-SRCS-y +=3D fips_validation_xts.c<br>
-SRCS-y +=3D fips_validation_rsa.c<br>
-SRCS-y +=3D fips_validation_ecdsa.c<br>
-SRCS-y +=3D fips_validation_eddsa.c<br>
-SRCS-y +=3D main.c<br>
-<br>
-PKGCONF ?=3D pkg-config<br>
-<br>
-# Build using pkg-config variables if possible<br>
-ifneq ($(shell $(PKGCONF) --exists libdpdk &amp;&amp; echo 0),0)<br>
-$(error &quot;no installation of DPDK found&quot;)<br>
-endif<br>
-<br>
-all: shared<br>
-.PHONY: shared static<br>
-shared: build/$(APP)-shared<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -sf $(APP)-shared build/$(APP)<br>
-static: build/$(APP)-static<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -sf $(APP)-static build/$(APP)<br>
-<br>
-PC_FILE :=3D $(shell $(PKGCONF) --path libdpdk 2&gt;/dev/null)<br>
-CFLAGS +=3D -O3 $(shell $(PKGCONF) --cflags libdpdk)<br>
-LDFLAGS_SHARED =3D $(shell $(PKGCONF) --libs libdpdk)<br>
-LDFLAGS_STATIC =3D $(shell $(PKGCONF) --static --libs libdpdk)<br>
-<br>
-JANSSON :=3D $(shell $(PKGCONF) --exists jansson; echo $$?)<br>
-ifeq ($(JANSSON), 0)<br>
-LDFLAGS +=3D $(shell $(PKGCONF) --libs jansson)<br>
-CFLAGS +=3D -DUSE_JANSSON<br>
-endif<br>
-<br>
-CFLAGS +=3D -DALLOW_EXPERIMENTAL_API<br>
-<br>
-build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDF=
LAGS) $(LDFLAGS_SHARED)<br>
-<br>
-build/$(APP)-static: $(SRCS-y) Makefile $(PC_FILE) | build<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDF=
LAGS) $(LDFLAGS_STATIC)<br>
-<br>
-build:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @mkdir -p $@<br>
-<br>
-.PHONY: clean<br>
-clean:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rm -f build/$(APP) build/$(APP)-stati=
c build/$(APP)-shared<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test -d build &amp;&amp; rmdir -p bui=
ld || true<br>
diff --git a/examples/meson.build b/examples/meson.build<br>
index 544ec5eadd..4b739c9b82 100644<br>
--- a/examples/meson.build<br>
+++ b/examples/meson.build<br>
@@ -15,7 +15,6 @@ all_examples =3D [<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dma',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'ethtool',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'eventdev_pipeline',<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'fips_validation',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'flow_filtering',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'helloworld',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'ip_fragmentation',<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_LV2PR11MB6045A8858EDE873F626A0F1281732LV2PR11MB6045namp_--
