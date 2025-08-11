Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23300C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 09:41:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6404D4025D;
	Mon, 11 Aug 2025 11:41:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 40B14400D5;
 Mon, 11 Aug 2025 11:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754905258; x=1786441258;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=NtPV9iMzaNwAr6tG8ULCEn9TaGKeLoNDXxp7q00pzGk=;
 b=b+Ck3XXXPcG86n+DalNrfKcw157RfKDhOhCMm9qfAVFY2hCRHVocO/zR
 Y58lsreZT+JqYvx86sxusBRClI1BDbGENtYsIdZ01cDHWrw046SCVo+WQ
 9l60B7LFxlRK0M8DX29sZM+84mXmi7Zeof+Ki0xCHzlEqAXMX+xwrDnnT
 PGbu/8A28LFAnu63D2ju/ziQtjvNjzUZRX7IwgukjSSI5bujkIWWh9yus
 lyfT0wS2t2AZPa2Xje7BbbnozbmFtIO74t4+ipbQ4f6FLDo7lJMp5oMpi
 yvzqwfGFfLHMo+oaU0ffTSrPl8PmQbGrxCPucgagfKFh4yKWx6AtRH2Qr w==;
X-CSE-ConnectionGUID: hhIKd3asSumYMxdVgMiHSA==
X-CSE-MsgGUID: 6oOsuC7NQUGqNpH8MbQ78w==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="59765544"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208,217";a="59765544"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 02:40:57 -0700
X-CSE-ConnectionGUID: sDblHeI0Swu6N9YCGAizTA==
X-CSE-MsgGUID: ElxdjYbQRi6me7edqFgxLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
 d="scan'208,217";a="166278371"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 02:40:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 02:40:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 02:40:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.40)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 02:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3zK0N6BMTgWvUg/+ojArXGWyngfTG+k+lc0r7mT0ZmGOWAYU+7cbG990fBNsa8JkcB0jcBTe663cndSlX3yfQ7mK+KxZKMLgPTm2PcKf1wiEMBiA/8PGXEO64uY+Oe0oDlfljUsqP9d59GV9XiiNE/Gf+mrqVgix17RWT1AyijlgkFJxk0GEH1qDNU1kpxJ/mgEUXN27wWBFXW9SXYqpHsHjnFbLWkwXumnspRX57oxVyJV/2YI4RGhF1tstf6rNFK/KupbJrOBgCEdEEh+dMy+7hyK0Blj6OOOQirILoyg6sZvDjeaxxMNrLk3bSGiUd2r3pKUtW9JibfCFCRhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FMsbxqwVOU6V4BgZ2bcUznOX5fWjU8HW6oCCLTund0=;
 b=ttygYo2H2a0Q8/G/rufa1ETs0rSjwo3VSbAf+N+mpOP/c3RFXNpywynznFpIzM5fllOBA92rCtATYzFswcpk1TU0DAJ3ztpiwp9B71pMH5b3VQOPSzTW4Ijeys1guOJYfbfm7NG+5G5DsaGmE0oWLrubRr19120l8Muhq6t1SWMTDfLXF95DHUXuNeJLf4HtowYXG9ek44DzAWB+NVtdYfdyO0ZI+T6DdjxJzfXEWM2cRlCorewv7DGgTNL2UlR2Qv3rqLwKmlulOzBO6QHZCqsnOG+QBiKKmy0ewOjAmkN1Szo5LZdU73XtACPxc/vudgUSdBwsZU93tbuT1lhjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 09:40:54 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 09:40:53 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: Re: [PATCH] crypto/qat: fix source buffer alignment
Thread-Topic: [PATCH] crypto/qat: fix source buffer alignment
Thread-Index: AQHcBuE2pHxapGhrUECng1RDkL1vMrRdOi7j
Date: Mon, 11 Aug 2025 09:40:53 +0000
Message-ID: <DS0PR11MB745868D172453A9F1AA4DE0B8128A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250806144832.3507786-1-radu.nicolau@intel.com>
In-Reply-To: <20250806144832.3507786-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|MW4PR11MB6838:EE_
x-ms-office365-filtering-correlation-id: 712cde7e-698b-44de-39c5-08ddd8bb2a68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|42112799006|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5R2wA+ZyW3k7VbSHMcHtwZVCBJ8vMhiJaPsVZMlxNoVwGyCgkbsd3WTV8E5j?=
 =?us-ascii?Q?mc/XvWKGItk5AIzbSqHhxDCwchWPm6g9fd2aJBzHhQROdmyO1tPtB4Y8J8Cu?=
 =?us-ascii?Q?9m+TX99ukvcYW61Qjk4NNU1vLWjRIR5hBQp4dSuDUEWAgxcRlybHAuVYMe0E?=
 =?us-ascii?Q?PBIsoHpcZF0/T0mqAOTNZDqjaNzPzNH3wFTirjiHX/FRa+tZesQULtB0mqso?=
 =?us-ascii?Q?59toYO1zqc4obWy4EeWIa6KRIrVyHqYuTHEMJZ4yGMPaIFJ1/rDxnoxE1Crn?=
 =?us-ascii?Q?aecJv2pcJ+UZ611lATFxqW+hCBAyzexNR65VCjgaUhgGqAzWnnhGKOPVPtNU?=
 =?us-ascii?Q?KU6LKTWZV3B7ZQCUKH7CfaPw35Fk47DR9KgYdHai6h2JyPiy+v3k9VaFaMJ0?=
 =?us-ascii?Q?53hyy/s2nhyOBKQ5rf0gYeVQ8RTayWwI5R5g87BsqDdpEe4k010AVlr4Ea9K?=
 =?us-ascii?Q?3QFovTvBAQy5uqnTu3Oe5j8eS8fNgfaVGJ7I/2hwBOBVqB8WRtQHMH+nKdlV?=
 =?us-ascii?Q?JVHuMGrn7Gb7paB/1bFgwQz9fRJrHVDFMfBLdJFJ+jW8VZvAu14+10EnpPO9?=
 =?us-ascii?Q?lXAowMF8jsnxD+TlZAj42kc1UVgknUe9J29qbUYArmjooakrrQ+wVd6/W4LN?=
 =?us-ascii?Q?Q384PS7oAet/9gfr2UKgHTZtxq1hfL+DXegKwI95TlVOrHtCNQE+8h6qtJ7a?=
 =?us-ascii?Q?cKbI1AwGGwgj5oowGDbnxzvbGTgwIkOzAlCxyu9SZlPKQdPxEOaWcfWu67wh?=
 =?us-ascii?Q?SJAU6IuO/Y49DkbjdjE/DD6jZ2CC6QshFiXmC2/SKrEr8FxH8m+qWMMYbT2a?=
 =?us-ascii?Q?1CEQXU/sZsbuDVRJxtG/1Wz/TIYcUqXi5GEfE+qBIVaBxfk2nmNQ5MJypHq8?=
 =?us-ascii?Q?+PcKEYnXdmS5wWcwzm43JiUgiA4CEV08ZUp0Pd2idgRRw6/c2ivsKOAQOeRD?=
 =?us-ascii?Q?EP6DgyCOLgNV9o4fXT83ylzMHZ+QSOnYcO6ZBlqZP1TX6xf1UZTVmmpbPJ2O?=
 =?us-ascii?Q?et9OB3BZp/r3+u0MQLHtySdVuJyYvryWvD6ZMZ9QS6ZW2nSJNcvr2bkJE9nM?=
 =?us-ascii?Q?4ZEiLZTnPDE1fj4xM+e3pFleKVq9THq1c3iKP+V2ywJX8BW4yOiRYBkEmOAu?=
 =?us-ascii?Q?Srw54RzO0zhUt5JEGQfdfPNSXClL4PInkDIFf9VnD5x+VO5Uict7E60NxQS1?=
 =?us-ascii?Q?cCQrb6pPpKvBXhHqSxlgwqSqLzrI5sTGif7DoWY64Vtqt9BWHamBD1XtCuop?=
 =?us-ascii?Q?cJbU3/oSPhWWD9qb2LLkR2YaBFGCjH3gjPx9O8+7lxFIr7xAzLNcWIPaOQxh?=
 =?us-ascii?Q?FLn+XMJCXiw0jpbgJUZ2Lj7Jpx7PF5TrC5bVV1YzgRaAGRiisRC/8fr3sKGX?=
 =?us-ascii?Q?vMzh/+W2PivvRXdLexewCtn/g8zjwks7C0JKtRoDB4KqqMiuK4uJSfNSAqF0?=
 =?us-ascii?Q?4lktAPb5uC1xNcrEdG0q7ciWLoakmFu9BYqslXeFfQI9KBmYM0LlJw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(42112799006)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ies5N9lUE0WkpW87FApuxS27ypm3tXjnLwP7v3dWjYnvZj4Q7SoSmSItgMt3?=
 =?us-ascii?Q?9vwy+BjCyFhAUFfQ1tqU6XUqEwNu9zHbmLIAFkp03yqWgBVmIMdLVQW+pbkg?=
 =?us-ascii?Q?hukcVfNdINESl89W/omqkI/6Y6Sjwx1GNM6aeIa8BsyeEjzwUoF7h5QrlgzJ?=
 =?us-ascii?Q?WP3FKIlk7mKad4goZZEOhccyzvX3NHw3q+Typ3KV82yVzfd4ZRJLSQR5SPcO?=
 =?us-ascii?Q?Khrf9bADZ9cQv4oY8Hjul4gJmCbrHjESevA+UKyo33u0GXKG4lCeZ86B116I?=
 =?us-ascii?Q?bcC1d4pT5nDZGbDMXdMkoiV0HfypWW63/CsxTE5hip3W11VA7QHyeBmQWvz3?=
 =?us-ascii?Q?ARZRCZnjEvktAKFn/Ows7uhP5iHALZ0xl6xiSgoxCoJXwEV9lnQRya7q10SA?=
 =?us-ascii?Q?fzA2kFDEQnRKZQZFXrbYyeNGiVDfqb6Q7ofIie95pwGF2o+36XNte2hfXpR6?=
 =?us-ascii?Q?iMZz8Y6XYdA8nf7HCYG0zJot61Cr9i4bBjlsRoDvOfM8OYeZizVVCBSoXaW9?=
 =?us-ascii?Q?Xv0JNZfT4iDnrvxuka25NooIliciYVMfgXJ4FW7yiwkaod4Oy4qetEuwOuBL?=
 =?us-ascii?Q?Jz7pYTffpG02uefOuxAwvtD1Fle8k5Pl35mPyZj89HRNwwgb9/A/BKNiIJAy?=
 =?us-ascii?Q?KShXHoly7GEhRBeTv4iJu8dv2UxoXSm858lEDJSSMSAo3JqDgotX9idhPkgb?=
 =?us-ascii?Q?MFvpzCVVecXtsA3fypLvUjTuAqUu02nnx3+QozG5/vJ5LcWegR/itd2rXZVP?=
 =?us-ascii?Q?bly80iq4f0AIGqSJKsUtvSPFZbUPKX4OZ8Cp3fxCKjeHbYSn4lrUTmMOnMro?=
 =?us-ascii?Q?jiL99e7D5FZXNFPSlPOWHScjMQ4EWB+RYz4nvVciRUpellD2kmbM5XNKwCxq?=
 =?us-ascii?Q?vd7KLnkA67wxIRRGxUXhIXpPKEKBu5/v7sDKySROW4pjvIm685JQ92w9ZQdh?=
 =?us-ascii?Q?W8dAgSpyZZ+ADJXC80idlTma13sTBRpfbTCTGRZEazrLWL391CH/wwJYZ08y?=
 =?us-ascii?Q?aRzyuxI/cMcwDZuKxrphYxyb/doP5vyBUO/SSQcKl9XZdnGm5tMox1nCdLqL?=
 =?us-ascii?Q?hQDwq7aKu7Q5d85WkjftDI9/fa0lQdx+Z19j/iiMOTI4GZWZnLP+E3Jrucss?=
 =?us-ascii?Q?cIzxSLHOWHE9rQVklwOlo3bzyKhe4rZOA5R9EgSP1ah91W6LA3CJjwYdhZNB?=
 =?us-ascii?Q?Gh8sURQkY9M7pfkEJ2qlXAZM5NzvET1uE5+sam5tfSU5LvWGe3DUQweHG959?=
 =?us-ascii?Q?hZX0Oc1e4mOJML4KXMDjY3FAo/BxotYUA0KrzEuiPMjw4azCHGoh1Lj1l0UN?=
 =?us-ascii?Q?KU5rDrXlPHWjRjKXUHuRTk67Ehu3Q3i+hNLUa59CiPK5EhKZWpmZE+oeGNnL?=
 =?us-ascii?Q?1B0sxzxSranCoMesCFtCK6bVLeP7NSqJlsN8prFFDeCPx6v93kSeXTWdwZ71?=
 =?us-ascii?Q?DytM+XrnjT2A73L/v8Qcd/TCTwHIFvG+OZpIUnltrOV61xprE/XEWJRVsx5T?=
 =?us-ascii?Q?Q1xt1yEWXcFD1sUrQc2+4Bp+0Yv00FrhL0zDK/Czno5+dsjhHMmQ2ibAvQN9?=
 =?us-ascii?Q?8/XZf2tqaoCYWU2BAl+eJH7924y6Du570avlDJq0qDpFTtlSD5pvSVR+Eirv?=
 =?us-ascii?Q?rqd+MqGXXftWZT2uQ0kuEsQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB745868D172453A9F1AA4DE0B8128ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712cde7e-698b-44de-39c5-08ddd8bb2a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 09:40:53.8200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 380/03AIexL+zbQQclSIMDth96Un4g7mhXN2JpZJyjhBIzVQq7lGOs6BUhmADnWo89Wc8FOi1xw02k8rpGvRaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com
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

--_000_DS0PR11MB745868D172453A9F1AA4DE0B8128ADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: 06 August 2025 15:48
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; stable@dpdk.org <stable@dpdk.or=
g>; Ji, Kai <kai.ji@intel.com>; Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH] crypto/qat: fix source buffer alignment

Fix performance regression resulting from using non cache-aligned
source buffers when using cryptodev API.

Fixes: fb3b9f492205 ("crypto/qat: rework burst data path")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 14 ++++++------
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c |  6 ++---
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 21 ++++++++++++++++-
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c    | 24 ++++++++++----------
 4 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen3.c
index 0dcb5a7cb4..c196cf3cdb 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -422,7 +422,7 @@ qat_sym_build_op_aead_gen3(void *in_op, struct qat_sym_=
session *ctx,
         }

         total_len =3D qat_sym_build_req_set_data(req, in_op, cookie,
-                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &=
ofs, op);
         if (unlikely(total_len < 0)) {
                 op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
                 return -EINVAL;
@@ -466,7 +466,7 @@ qat_sym_build_op_auth_gen3(void *in_op, struct qat_sym_=
session *ctx,
         }

         total_len =3D qat_sym_build_req_set_data(req, in_op, cookie,
-                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &=
ofs, op);
         if (unlikely(total_len < 0)) {
                 op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
                 return -EINVAL;
@@ -564,7 +564,7 @@ qat_sym_dp_enqueue_single_aead_gen3(void *qp_data, uint=
8_t *drv_ctx,
         rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
         rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
         data_len =3D qat_sym_build_req_set_data(req, user_data, cookie,
-                       data, n_data_vecs, NULL, 0);
+                       data, n_data_vecs, NULL, 0, NULL, NULL);
         if (unlikely(data_len < 0))
                 return -1;

@@ -623,7 +623,7 @@ qat_sym_dp_enqueue_aead_jobs_gen3(void *qp_data, uint8_=
t *drv_ctx,
                         data_len =3D qat_sym_build_req_set_data(req,
                                 user_data[i], cookie,
                                 vec->src_sgl[i].vec,
-                               vec->src_sgl[i].num, NULL, 0);
+                               vec->src_sgl[i].num, NULL, 0, NULL, NULL);
                 }

                 if (unlikely(data_len < 0) || error)
@@ -677,7 +677,7 @@ qat_sym_dp_enqueue_single_auth_gen3(void *qp_data, uint=
8_t *drv_ctx,
         rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
         rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
         data_len =3D qat_sym_build_req_set_data(req, user_data, cookie,
-                       data, n_data_vecs, NULL, 0);
+                       data, n_data_vecs, NULL, 0, NULL, NULL);
         if (unlikely(data_len < 0))
                 return -1;

@@ -732,12 +732,12 @@ qat_sym_dp_enqueue_auth_jobs_gen3(void *qp_data, uint=
8_t *drv_ctx,
                         data_len =3D qat_sym_build_req_set_data(req,
                                 user_data[i], cookie,
                                 vec->src_sgl[i].vec, vec->src_sgl[i].num,
-                               vec->dest_sgl[i].vec, vec->dest_sgl[i].num)=
;
+                               vec->dest_sgl[i].vec, vec->dest_sgl[i].num,=
 NULL, NULL);
                 } else {
                         data_len =3D qat_sym_build_req_set_data(req,
                                 user_data[i], cookie,
                                 vec->src_sgl[i].vec,
-                               vec->src_sgl[i].num, NULL, 0);
+                               vec->src_sgl[i].num, NULL, 0, NULL, NULL);
                 }

                 if (unlikely(data_len < 0))
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen4.c
index 638da1a173..f42ce7c178 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -219,7 +219,7 @@ qat_sym_build_op_aead_gen4(void *in_op, struct qat_sym_=
session *ctx,
         }

         total_len =3D qat_sym_build_req_set_data(qat_req, in_op, cookie,
-                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &=
ofs, op);
         if (unlikely(total_len < 0)) {
                 op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
                 return -EINVAL;
@@ -376,7 +376,7 @@ qat_sym_dp_enqueue_single_aead_gen4(void *qp_data, uint=
8_t *drv_ctx,
         rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
         rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
         data_len =3D qat_sym_build_req_set_data(req, user_data, cookie,
-                       data, n_data_vecs, NULL, 0);
+                       data, n_data_vecs, NULL, 0, NULL, NULL);
         if (unlikely(data_len < 0))
                 return -1;

@@ -435,7 +435,7 @@ qat_sym_dp_enqueue_aead_jobs_gen4(void *qp_data, uint8_=
t *drv_ctx,
                         data_len =3D qat_sym_build_req_set_data(req,
                                 user_data[i], cookie,
                                 vec->src_sgl[i].vec,
-                               vec->src_sgl[i].num, NULL, 0);
+                               vec->src_sgl[i].num, NULL, 0, NULL, NULL);
                 }

                 if (unlikely(data_len < 0) || error)
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gens.h
index 1f19c69f88..67dc889b50 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -430,7 +430,8 @@ static __rte_always_inline int32_t
 qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_req *req,
                 void *opaque, struct qat_sym_op_cookie *cookie,
                 struct rte_crypto_vec *src_vec, uint16_t n_src,
-               struct rte_crypto_vec *dst_vec, uint16_t n_dst)
+               struct rte_crypto_vec *dst_vec, uint16_t n_dst,
+               union rte_crypto_sym_ofs *ofs, struct rte_crypto_op *op)
 {
         struct qat_sgl *list;
         uint32_t i;
@@ -502,6 +503,24 @@ qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_r=
eq *req,
                         dst_data_start =3D src_data_start;
         }

+       /* For crypto API only try to align the in-place buffers*/
+       if (op !=3D NULL && likely(n_dst =3D=3D 0)) {
+               uint16_t offset =3D src_data_start & RTE_CACHE_LINE_MASK;
+               if (offset) {
+                       rte_iova_t buff_addr =3D rte_mbuf_iova_get(op->sym-=
>m_src);
+                       /* make sure src_data_start is still within the buf=
fer */
+                       if (src_data_start - offset >=3D buff_addr) {
+                               src_data_start -=3D offset;
+                               dst_data_start =3D src_data_start;
+                               ofs->ofs.auth.head +=3D offset;
+                               ofs->ofs.cipher.head +=3D offset;
+                               tl_src +=3D offset;
+                               total_len_src =3D tl_src;
+                               total_len_dst =3D tl_src;
+                       }
+               }
+       }
+
         req->comn_mid.src_data_addr =3D src_data_start;
         req->comn_mid.dest_data_addr =3D dst_data_start;
         req->comn_mid.src_length =3D total_len_src;
diff --git a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c b/drivers/crypto/qat=
/dev/qat_sym_pmd_gen1.c
index 8cb85fd8df..6da0f6c645 100644
--- a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
@@ -242,7 +242,7 @@ qat_sym_build_op_cipher_gen1(void *in_op, struct qat_sy=
m_session *ctx,
         }

         total_len =3D qat_sym_build_req_set_data(req, in_op, cookie,
-                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &=
ofs, op);
         if (unlikely(total_len < 0)) {
                 op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
                 return -EINVAL;
@@ -294,7 +294,7 @@ qat_sym_build_op_auth_gen1(void *in_op, struct qat_sym_=
session *ctx,
                                 req->comn_hdr.serv_specif_flags, 0);

         total_len =3D qat_sym_build_req_set_data(req, in_op, cookie,
-                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &=
ofs, op);
         if (unlikely(total_len < 0)) {
                 op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
                 return -EINVAL;
@@ -339,7 +339,7 @@ qat_sym_build_op_aead_gen1(void *in_op, struct qat_sym_=
session *ctx,
         }

         total_len =3D qat_sym_build_req_set_data(req, in_op, cookie,
-                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &=
ofs, op);
         if (unlikely(total_len < 0)) {
                 op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
                 return -EINVAL;
@@ -384,7 +384,7 @@ qat_sym_build_op_chain_gen1(void *in_op, struct qat_sym=
_session *ctx,
         }

         total_len =3D qat_sym_build_req_set_data(req, in_op, cookie,
-                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+                       in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &=
ofs, op);
         if (unlikely(total_len < 0)) {
                 op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
                 return -EINVAL;
@@ -512,7 +512,7 @@ qat_sym_dp_enqueue_single_cipher_gen1(void *qp_data, ui=
nt8_t *drv_ctx,
         rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);

         data_len =3D qat_sym_build_req_set_data(req, user_data, cookie,
-                       data, n_data_vecs, NULL, 0);
+                       data, n_data_vecs, NULL, 0, NULL, NULL);
         if (unlikely(data_len < 0))
                 return -1;

@@ -571,7 +571,7 @@ qat_sym_dp_enqueue_cipher_jobs_gen1(void *qp_data, uint=
8_t *drv_ctx,
                         data_len =3D qat_sym_build_req_set_data(req,
                                 user_data[i], cookie,
                                 vec->src_sgl[i].vec,
-                               vec->src_sgl[i].num, NULL, 0);
+                               vec->src_sgl[i].num, NULL, 0, NULL, NULL);
                 }

                 if (unlikely(data_len < 0 || error))
@@ -623,7 +623,7 @@ qat_sym_dp_enqueue_single_auth_gen1(void *qp_data, uint=
8_t *drv_ctx,
         rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
         rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
         data_len =3D qat_sym_build_req_set_data(req, user_data, cookie,
-                       data, n_data_vecs, NULL, 0);
+                       data, n_data_vecs, NULL, 0, NULL, NULL);
         if (unlikely(data_len < 0))
                 return -1;

@@ -690,7 +690,7 @@ qat_sym_dp_enqueue_auth_jobs_gen1(void *qp_data, uint8_=
t *drv_ctx,
                         data_len =3D qat_sym_build_req_set_data(req,
                                 user_data[i], cookie,
                                 vec->src_sgl[i].vec,
-                               vec->src_sgl[i].num, NULL, 0);
+                               vec->src_sgl[i].num, NULL, 0, NULL, NULL);
                 }

                 if (unlikely(data_len < 0 || error))
@@ -747,7 +747,7 @@ qat_sym_dp_enqueue_single_chain_gen1(void *qp_data, uin=
t8_t *drv_ctx,
         rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
         rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
         data_len =3D qat_sym_build_req_set_data(req, user_data, cookie,
-                       data, n_data_vecs, NULL, 0);
+                       data, n_data_vecs, NULL, 0, NULL, NULL);
         if (unlikely(data_len < 0))
                 return -1;

@@ -815,7 +815,7 @@ qat_sym_dp_enqueue_chain_jobs_gen1(void *qp_data, uint8=
_t *drv_ctx,
                         data_len =3D qat_sym_build_req_set_data(req,
                                 user_data[i], cookie,
                                 vec->src_sgl[i].vec,
-                               vec->src_sgl[i].num, NULL, 0);
+                               vec->src_sgl[i].num, NULL, 0, NULL, NULL);
                 }

                 if (unlikely(data_len < 0 || error))
@@ -877,7 +877,7 @@ qat_sym_dp_enqueue_single_aead_gen1(void *qp_data, uint=
8_t *drv_ctx,
         rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
         rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
         data_len =3D qat_sym_build_req_set_data(req, user_data, cookie,
-                       data, n_data_vecs, NULL, 0);
+                       data, n_data_vecs, NULL, 0, NULL, NULL);
         if (unlikely(data_len < 0))
                 return -1;

@@ -936,7 +936,7 @@ qat_sym_dp_enqueue_aead_jobs_gen1(void *qp_data, uint8_=
t *drv_ctx,
                         data_len =3D qat_sym_build_req_set_data(req,
                                 user_data[i], cookie,
                                 vec->src_sgl[i].vec,
-                               vec->src_sgl[i].num, NULL, 0);
+                               vec->src_sgl[i].num, NULL, 0, NULL, NULL);
                 }

                 if (unlikely(data_len < 0) || error)
--
2.50.1


--_000_DS0PR11MB745868D172453A9F1AA4DE0B8128ADS0PR11MB7458namp_
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
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicolau, Radu &lt;rad=
u.nicolau@intel.com&gt;<br>
<b>Sent:</b> 06 August 2025 15:48<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; stable@dpdk.org &l=
t;stable@dpdk.org&gt;; Ji, Kai &lt;kai.ji@intel.com&gt;; Fan Zhang &lt;fanz=
hang.oss@gmail.com&gt;<br>
<b>Subject:</b> [PATCH] crypto/qat: fix source buffer alignment</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix performance regression resulting from using no=
n cache-aligned<br>
source buffers when using cryptodev API.<br>
<br>
Fixes: fb3b9f492205 (&quot;crypto/qat: rework burst data path&quot;)<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 14 ++++++------<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c |&nbsp; 6 ++---<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 21 ++++++++++++++++-<b=
r>
&nbsp;drivers/crypto/qat/dev/qat_sym_pmd_gen1.c&nbsp;&nbsp;&nbsp; | 24 ++++=
++++++----------<br>
&nbsp;4 files changed, 42 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen3.c<br>
index 0dcb5a7cb4..c196cf3cdb 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c<br>
@@ -422,7 +422,7 @@ qat_sym_build_op_aead_gen3(void *in_op, struct qat_sym_=
session *ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len =3D qat_sym_buil=
d_req_set_data(req, in_op, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num, &amp;ofs, op);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(total_len &lt=
; 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; op-&gt;status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -466,7 +466,7 @@ qat_sym_build_op_auth_gen3(void *in_op, struct qat_sym_=
session *ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len =3D qat_sym_buil=
d_req_set_data(req, in_op, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num, &amp;ofs, op);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(total_len &lt=
; 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; op-&gt;status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -564,7 +564,7 @@ qat_sym_dp_enqueue_single_aead_gen3(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_mov128((uint8_t *)req,=
 (const uint8_t *)&amp;(ctx-&gt;fw_req));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_prefetch0((uint8_t *)t=
x_queue-&gt;base_addr + tail);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat_sym_build=
_req_set_data(req, user_data, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt;=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
@@ -623,7 +623,7 @@ qat_sym_dp_enqueue_aead_jobs_gen3(void *qp_data, uint8_=
t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len =3D qat_sym_build_req_set_data(req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0, NULL, NULL=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt; 0) || error)<br>
@@ -677,7 +677,7 @@ qat_sym_dp_enqueue_single_auth_gen3(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_mov128((uint8_t *)req,=
 (const uint8_t *)&amp;(ctx-&gt;fw_req));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_prefetch0((uint8_t *)t=
x_queue-&gt;base_addr + tail);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat_sym_build=
_req_set_data(req, user_data, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt;=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
@@ -732,12 +732,12 @@ qat_sym_dp_enqueue_auth_jobs_gen3(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len =3D qat_sym_build_req_set_data(req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].vec, vec-&gt;=
src_sgl[i].num,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;dest_sgl[i].vec, vec-&gt;dest_sgl[i=
].num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;dest_sgl[i].vec, vec-&gt;dest_sgl[i=
].num, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len =3D qat_sym_build_req_set_data(req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0, NULL, NULL=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt; 0))<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen4.c<br>
index 638da1a173..f42ce7c178 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c<br>
@@ -219,7 +219,7 @@ qat_sym_build_op_aead_gen4(void *in_op, struct qat_sym_=
session *ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len =3D qat_sym_buil=
d_req_set_data(qat_req, in_op, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num, &amp;ofs, op);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(total_len &lt=
; 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; op-&gt;status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -376,7 +376,7 @@ qat_sym_dp_enqueue_single_aead_gen4(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_mov128((uint8_t *)req,=
 (const uint8_t *)&amp;(ctx-&gt;fw_req));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_prefetch0((uint8_t *)t=
x_queue-&gt;base_addr + tail);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat_sym_build=
_req_set_data(req, user_data, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt;=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
@@ -435,7 +435,7 @@ qat_sym_dp_enqueue_aead_jobs_gen4(void *qp_data, uint8_=
t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len =3D qat_sym_build_req_set_data(req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0, NULL, NULL=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt; 0) || error)<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gens.h<br>
index 1f19c69f88..67dc889b50 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h<br>
@@ -430,7 +430,8 @@ static __rte_always_inline int32_t<br>
&nbsp;qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_req *req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; void *opaque, struct qat_sym_op_cookie *cookie,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct rte_crypto_vec *src_vec, uint16_t n_src,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_crypto_vec *dst_vec, uint16_t n_dst)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_crypto_vec *dst_vec, uint16_t n_dst,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; union rte_crypto_sym_ofs *ofs, struct rte_crypto_op *op)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qat_sgl *list;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
@@ -502,6 +503,24 @@ qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_r=
eq *req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_d=
ata_start =3D src_data_start;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For crypto API only try to align t=
he in-place buffers*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (op !=3D NULL &amp;&amp; likely(n_=
dst =3D=3D 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint16_t offset =3D src_data_start &amp; RTE_CACHE_LINE_MASK;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (offset) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_iova_t buff_=
addr =3D rte_mbuf_iova_get(op-&gt;sym-&gt;m_src);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* make sure src=
_data_start is still within the buffer */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (src_data_sta=
rt - offset &gt;=3D buff_addr) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src_data_start -=3D offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_data_start =3D src_data_start;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ofs-&gt;ofs.auth.head +=3D offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ofs-&gt;ofs.cipher.head +=3D offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tl_src +=3D offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len_src =3D tl_src;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len_dst =3D tl_src;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;comn_mid.src_data_=
addr =3D src_data_start;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;comn_mid.dest_data=
_addr =3D dst_data_start;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;comn_mid.src_lengt=
h =3D total_len_src;<br>
diff --git a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c b/drivers/crypto/qat=
/dev/qat_sym_pmd_gen1.c<br>
index 8cb85fd8df..6da0f6c645 100644<br>
--- a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c<br>
+++ b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c<br>
@@ -242,7 +242,7 @@ qat_sym_build_op_cipher_gen1(void *in_op, struct qat_sy=
m_session *ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len =3D qat_sym_buil=
d_req_set_data(req, in_op, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num, &amp;ofs, op);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(total_len &lt=
; 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; op-&gt;status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -294,7 +294,7 @@ qat_sym_build_op_auth_gen1(void *in_op, struct qat_sym_=
session *ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;comn_hdr.serv_specif_fla=
gs, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len =3D qat_sym_buil=
d_req_set_data(req, in_op, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num, &amp;ofs, op);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(total_len &lt=
; 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; op-&gt;status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -339,7 +339,7 @@ qat_sym_build_op_aead_gen1(void *in_op, struct qat_sym_=
session *ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len =3D qat_sym_buil=
d_req_set_data(req, in_op, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num, &amp;ofs, op);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(total_len &lt=
; 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; op-&gt;status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -384,7 +384,7 @@ qat_sym_build_op_chain_gen1(void *in_op, struct qat_sym=
_session *ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len =3D qat_sym_buil=
d_req_set_data(req, in_op, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_sgl.vec, in_s=
gl.num, out_sgl.vec, out_sgl.num, &amp;ofs, op);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(total_len &lt=
; 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; op-&gt;status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -512,7 +512,7 @@ qat_sym_dp_enqueue_single_cipher_gen1(void *qp_data, ui=
nt8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_prefetch0((uint8_t *)t=
x_queue-&gt;base_addr + tail);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat_sym_build=
_req_set_data(req, user_data, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt;=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
@@ -571,7 +571,7 @@ qat_sym_dp_enqueue_cipher_jobs_gen1(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len =3D qat_sym_build_req_set_data(req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0, NULL, NULL=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt; 0 || error))<br>
@@ -623,7 +623,7 @@ qat_sym_dp_enqueue_single_auth_gen1(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_mov128((uint8_t *)req,=
 (const uint8_t *)&amp;(ctx-&gt;fw_req));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_prefetch0((uint8_t *)t=
x_queue-&gt;base_addr + tail);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat_sym_build=
_req_set_data(req, user_data, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt;=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
@@ -690,7 +690,7 @@ qat_sym_dp_enqueue_auth_jobs_gen1(void *qp_data, uint8_=
t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len =3D qat_sym_build_req_set_data(req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0, NULL, NULL=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt; 0 || error))<br>
@@ -747,7 +747,7 @@ qat_sym_dp_enqueue_single_chain_gen1(void *qp_data, uin=
t8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_mov128((uint8_t *)req,=
 (const uint8_t *)&amp;(ctx-&gt;fw_req));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_prefetch0((uint8_t *)t=
x_queue-&gt;base_addr + tail);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat_sym_build=
_req_set_data(req, user_data, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt;=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
@@ -815,7 +815,7 @@ qat_sym_dp_enqueue_chain_jobs_gen1(void *qp_data, uint8=
_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len =3D qat_sym_build_req_set_data(req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0, NULL, NULL=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt; 0 || error))<br>
@@ -877,7 +877,7 @@ qat_sym_dp_enqueue_single_aead_gen1(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_mov128((uint8_t *)req,=
 (const uint8_t *)&amp;(ctx-&gt;fw_req));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_prefetch0((uint8_t *)t=
x_queue-&gt;base_addr + tail);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat_sym_build=
_req_set_data(req, user_data, cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, n_data_vec=
s, NULL, 0, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt;=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
@@ -936,7 +936,7 @@ qat_sym_dp_enqueue_aead_jobs_gen1(void *qp_data, uint8_=
t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len =3D qat_sym_build_req_set_data(req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0, NULL, NULL=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt; 0) || error)<br>
-- <br>
2.50.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB745868D172453A9F1AA4DE0B8128ADS0PR11MB7458namp_--
