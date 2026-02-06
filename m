Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F359CEE2085
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 10:47:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 192154029A;
	Fri,  6 Feb 2026 11:47:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7C17A40293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 11:47:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770374834; x=1801910834;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Dd99aShVTbjyTuy6FPbE/h/VkTFkgQ+h028RvmHInUA=;
 b=CAh+5fOZtnwW3Yaob9unl+itskNpbAtGBS19Cj+YX7s/3cv5HYhy+KKb
 fUCrxt7llVeTdAlz1zHgkdMzBDBNPm/GtO9Ra7sxS0bYg4Zy783Yxx4Ml
 4+jiupG17bC582hd2eL6oRcIemp6AWylNuAA2Li9iUzNyreX/mJBRbREF
 jhcWRqrOHhwjcq3V7DpfYch/f5vbv1J8/xrsLfDzzOavjlt3LgfJw/4EC
 874RHGj6DB87gLSCVsCY3FrqcT48JC4PGXjcRsecU4hefWT1399IsiaB/
 LXH227DjBA2fDTgoR/UmqVN17v3lJrOkw56Qsy2+qb5gXbKmlUO6alP+X A==;
X-CSE-ConnectionGUID: mpLqDZ8dQJa1p6wQOu0qmw==
X-CSE-MsgGUID: rJxB1mW/Sd+aCoinyldQgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="81898811"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="81898811"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:47:13 -0800
X-CSE-ConnectionGUID: OQ3/qOjcT/uWR2rmECsyfQ==
X-CSE-MsgGUID: XK87QRInSxqn1UjMSwyRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="210730727"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:47:13 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:47:13 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 02:47:13 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:47:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoTcFJ02dGGpdmq+NbB5zfukWm5K+tYUL7ZAucYlOCWqqFs3kqIwIdpjZeHC7w3p2mhLjX7gm+uRutk2Gdok132kJaKFj1YK9Qn5Hcy2eXNShXFO0tNYDko/73WkAQRjKy2SpuQiQUVMjjHC0LfCkkEwlEMpk4LV4y523dV8i8u+w0dkiBOsjL/s3FE9u4hR6aPiMDxZGO+niUI5J2nACNA2OrQfa6W4iQofyDZR95H4ZjX8UXAuK1k7wnq1bQRGKifhU5m9SH1WzSGaFOTLTNj5coTi7dk9nkxSusaZR3rFpaxvdUkwGgroYsxKzlw33xlhn+q3TMuUQh9365ZOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmlJhRWeWkaAkR3wqYCWTfyJhYPvB4Dyt+RSM20JWd4=;
 b=xP2DgKD6l2KqOdDHS/cWIjuzLh6tmW9e38SlrY4X4cxhu4EdTTbNjO72NB1WQo7M7E7N8lKrJDkxrsWulDXvl88QivAk70ewP0eEOYq4s9xQg0qhf4nqf0aS4W7U1PJz6jSX0pXzv0kXKzIhfSr1c/qhjbVSU32cZGw8I6GkqfkdHwty4mTJRIRuXip+inb0dIzWxUbfUF8eY7gWMMimVyxXErUaRLEvfXSBC+0oUh/+95WYwi6wak9d8CGPxo5taqYwk8TFJ0VddWKnbHRZ837BUsX0h2h+z9RM9Ghd19F2knEiCUIjRNymJ2qknot2HaO3SlvR2yzV93BmWURIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SA7PR11MB9542.namprd11.prod.outlook.com
 (2603:10b6:806:4d0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 10:47:11 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 10:47:11 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3 07/36] net/ice: refactor context descriptor handling
Thread-Topic: [PATCH v3 07/36] net/ice: refactor context descriptor handling
Thread-Index: AQHckd2q+Yu9/hGiNU6ZtVqguNumebV1gkBg
Date: Fri, 6 Feb 2026 10:47:11 +0000
Message-ID: <DM3PPF7D18F34A1224BFADE205E81D651D98E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-8-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-8-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SA7PR11MB9542:EE_
x-ms-office365-filtering-correlation-id: ddb3d383-54a2-4ffe-c039-08de656d1521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?SnDsQbyQG0wk++WlJfmFod3LadhZpw/MVpUF6Ww88xPsuhBwD2GlCJ7ZNcV4?=
 =?us-ascii?Q?jniK6XZh3kLDx3K03fw3i0eIReYVQkJT1tMs8ag5H6FPggzf7rjPu+K/Yt7V?=
 =?us-ascii?Q?YMLZKuo4MoX0S58PHQr6RtoU70EfoNy6JHmYYwkhzvBVN08MVaDQrxP93enr?=
 =?us-ascii?Q?ZUVGdDw4Y4OeKBXC2gu2rnstYqhHRZ9nvAwpyOnrrEdeQawwzz5YiX9wUm0n?=
 =?us-ascii?Q?KcmhzeclMeLHlKsWFcsamHaxjVvxy2GsXJgjmHuApjudbqptwllJaZZU2gzD?=
 =?us-ascii?Q?sKDreira7ixqcub2A2+3UO2ibojUk8zJ/lvxcRyzcIj+ioN61cLAMSBXe85s?=
 =?us-ascii?Q?WUmFJRLNLjSYq0HejKzX7k6HO+bUTrE6Fy3dpJAs5N9JwUhLb+V/BaBglFnA?=
 =?us-ascii?Q?iQaheRLTRtXGrBFjbMYDFiRteAjdugw6CP/X9C3Bx86P4Z8cSbtOFgTFX77i?=
 =?us-ascii?Q?Ti5/+e/N9iMs3UAIU1AL1q4ku44X/NEdRel+pap8/OF4dmkoIFVrPB50NASG?=
 =?us-ascii?Q?rC9flc3pcYH4ELW444sGsJ33SJtzQO1PTl/ovsdJ6hwnr/sS1cDsC847PeSA?=
 =?us-ascii?Q?4hkpVg2yVW+z11OQuO9gB4wKCg0Gk61oDVHL/Pq1Imy8X/iEAHExQRgX24QQ?=
 =?us-ascii?Q?waeLW1Pw8DyfJK2X2NSwYn+/j+Ik1kmI69NM9nzcZTj7ecgDTFj3v6ecU/hV?=
 =?us-ascii?Q?zO3Kzt+ZxmsvE5G13q1oDSRJ9Nnmux34fJvwgLhnBxmjZTaFXeoKWZNO0sri?=
 =?us-ascii?Q?GbaUQhhHY/bOIIxhZuG2kjvZWoxyzmqjwji1WDmoWvhMUBqYTihNek9TlD8L?=
 =?us-ascii?Q?8fhAIJ4zgJ2+QTbNlAYXA6XMxAQ/Isr717V88ipyxOopygIiChJKoy/44Hg1?=
 =?us-ascii?Q?jUpK9ZJ540rbUk1ldkAnudUVBC6Rq9Dte+ACAwaHDrZ43RYwyTHfd2opHRla?=
 =?us-ascii?Q?3wfCNvUfU9OPTzR0/glHOwrQ/oMr5k0btmEvL2gP/zKYwurgmTjHLgvOYT4O?=
 =?us-ascii?Q?fzrh0uvDy6lCbplwzovURMdhR7c0G3KHj784ehxD5UNOOX+oopUXdcuxllpv?=
 =?us-ascii?Q?NlPMxcrKo5iOdnBTM+CzU57uF8mEdwdM55DDLnKoojsAQS6UXbrp67Y/cDyg?=
 =?us-ascii?Q?CRSOyWu2ypt5peN665uRU+Xbi1LwyS+kyfnLtnRgHXuDJuuzQKrJTYp375mD?=
 =?us-ascii?Q?gckZ3fSxzaW1nJQqPlPNsLrtOYXPBqnxgOEysmYbOoFX64ixxXLFdp/mu0cM?=
 =?us-ascii?Q?SHaWpX4l/fERkm9LBeAn0r0ibufvqP7ks3ekw7QAsMJEMCEFm7sE0BxWfFke?=
 =?us-ascii?Q?c8NAr/VmlTLG24tE5gbXLlX2mAm3hvfg18uEEJ1OXkL9HxWhgXPif44qzVPe?=
 =?us-ascii?Q?un92SESV4HiAV8Lk4F97RLwizVpnOOEcnP9QAl5yCAgkqeAjoETniIMGxP3v?=
 =?us-ascii?Q?jSY2IdZ/0z0tLzznCoOcC7PakoLWPE31NVVy+FZVwH6O/+l5n0tOU8AnZj/G?=
 =?us-ascii?Q?p5ixvNFttHRqNjdAGTrEUxfUH65TD7Mo4FRJ2Jc5IB4i7re5gY76hK/yw5EU?=
 =?us-ascii?Q?Lvqz/jFCuSGwJTf3eJuFSeKPKpViEj2tXWFTp6lI8smo6LDI5QCoTEQ8ZhKb?=
 =?us-ascii?Q?CFrTln7IZWFZjY7/87Hdn2I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iDdA/EFuwOLya6UYHA0S3Lu3Aqxf0Oy4ns+HbuWHD0ErQwzMaHAqtTK64fbR?=
 =?us-ascii?Q?DnY+DCrtVZgGt9hu7n9ZZOyYq8ae7i27Ubs7+UDXApOBBmrKeeGMtKtXfZRf?=
 =?us-ascii?Q?orXyVMt/heNAuR24o8DG/O+TPjkJglpYN/aVI9yS72UIiFKVmfNxLtnkYaNP?=
 =?us-ascii?Q?yEjzgmdBJMWUAF/+lHvup8CN8PaMm+A70GXoStHlE8qhXK8DXk0Q8NN4vju8?=
 =?us-ascii?Q?Rdqd02daE8892K7DRYtT16wYYLQJ1neTS28v+Cx+HHdy3uMbAFQerH1uMcoD?=
 =?us-ascii?Q?ULMEb2SUVIfkl1+wkujNg+z70GodqgRe0LiRnYCSYPSgjJyrWLcoGajkMGD6?=
 =?us-ascii?Q?6WHMOTmvxNXSTiZk/rl84bvdDriULIJzB912gRg+G1hrHgT3uLoUAHIUia1h?=
 =?us-ascii?Q?f7u7LONmuP7YJ5tcki8nvN25e9lT5HTrH86l9gotzXBxncgjLaTWVtsO+J6A?=
 =?us-ascii?Q?Mkvw8IY4WwRlI+01sPoksS84457mVqMs6yBAjG69BlYBGJh+pT5dUw+duBGy?=
 =?us-ascii?Q?daCFctkog+EiNv7acOyQcGn7Sf/dUH4jfwllzfNoaOC6xm+eVaPNtGnv9UQ6?=
 =?us-ascii?Q?XY5pABeLDcBcLUnmLQgI2d60DnOeSNfT8NKdNmPXdtsthF3nvatRylsYwNUe?=
 =?us-ascii?Q?ivmXq8SMQFWj3QcH5Cab3V4498B3TamETR9S1O2QdyQKxyS/a0nbJmIJVW/K?=
 =?us-ascii?Q?OC+0ds9uJgHEUEJVazBBBhY4P+SFkLOoQxJywga2MI2e4wHGaFkuamqSTiS3?=
 =?us-ascii?Q?vmbcACOhRZLBTKmVmOm+oBUR+ckS77ItadcstSpNpmSWvN3S8GEuWDcwxif+?=
 =?us-ascii?Q?IpurqLOibrJOnrNL++JIz0SQ24nxxxM5fHAtXKck48u2d0iN2OgbEry/L+Ol?=
 =?us-ascii?Q?c9k83VzD9pPcjIAYkKSeIqjkcL7eamulh5jKIHtgtklnXmDUBOf4lwZCXmiD?=
 =?us-ascii?Q?gZwVUFch/pQJwUUGeU7Hi1CcexrqvjKMIshH+ZKU2EOJf6k6wkbXo5PUuPyK?=
 =?us-ascii?Q?gFVJwTe2MSJN+iwD+qnG+2F4EgPk/zDll5+1NdqbEFV5izFxb5GGIB8Y8kny?=
 =?us-ascii?Q?t905gTzLXqB5mERNyA1Fgg8+87LF4crsk/crGq5W/nbybBkk2RK1QypGsuEQ?=
 =?us-ascii?Q?G5Pq8eAM0CO2JNPQtcAraXnZLnbaEbsHEk1my/x4a5A0q7YyymcriVGMRSnA?=
 =?us-ascii?Q?rLOftgzNh5bQDR26P+rfyFA/y997CnLkFIUMJ8T12M/T3/7CKh4udWTqW5hr?=
 =?us-ascii?Q?rANnfRflwcBcrDuVPp0XIyARPU5ygmBUholZw4ptWIgE3MDO/xtiBM2SnUwc?=
 =?us-ascii?Q?RINk1EagjLINRpGmLN3DKnmUErlyFiibJLw+ckgkar/m9lq8CR2D4BplPiTM?=
 =?us-ascii?Q?0Bj3xQCp0EHv1PuF9Ok/euLZoQSFHACnh2xcxPgi8X0e6fHAc6CcEmALzvNr?=
 =?us-ascii?Q?fUh2zgtvZzK8gJ0l6C3QsSC/acDjc7RI4JBhQsWJvQ1J4uN/1TcGR9iovpDw?=
 =?us-ascii?Q?6eTdiDe8c5RPjgVBFaao1cgS782LEvo0alO94K8U1tN/GRmD/+44w2ixcQuT?=
 =?us-ascii?Q?OlyvkjWuFsV/qAxJIcbLrHZ1g0taA1RIiozhXy3l7SxlF7igk308VWAI3JCI?=
 =?us-ascii?Q?RGEDcWxstjBbmQr+WCjF0GnN5pifrjCfCtIZNz/9l1QT0HMwWvR6Yi4+wtvi?=
 =?us-ascii?Q?JkUXrp+CTlUzoN7JjCm3hdkzPNfZbNAF3PyI/VwlEo2ure94tVaI5jvYu0k2?=
 =?us-ascii?Q?Cuf9dE9fNw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb3d383-54a2-4ffe-c039-08de656d1521
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 10:47:11.2938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnsAulbdCUt+CE0EpncTiwMKCXrtdTtdO5Aviu3FwUbTqe4JgMjf3vv2bQABkgdit7gnVryrGVTboNhyYU2ueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9542
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

> Subject: [PATCH v3 07/36] net/ice: refactor context descriptor handling
>=20
> Create a single function to manage all context descriptor handling,
> which returns either 0 or 1 depending on whether a descriptor is needed
> or not, as well as returning directly the descriptor contents if
> relevant.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx.c | 104 +++++++++++++++++--------------
>  1 file changed, 57 insertions(+), 47 deletions(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice=
_rxtx.c
> index 2a53b614b2..cc442fed75 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -2966,10 +2966,6 @@ ice_txd_enable_checksum(uint64_t ol_flags,
>  			uint32_t *td_offset,
>  			union ci_tx_offload tx_offload)
>  {
> -	/* Set MACLEN */
> -	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
> -		*td_offset |=3D (tx_offload.l2_len >> 1)
> -			<< CI_TX_DESC_LEN_MACLEN_S;
>=20
>  	/* Enable L3 checksum offloads */
>  	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
> @@ -3052,7 +3048,7 @@ ice_calc_context_desc(uint64_t flags)
>=20
>  /* set ice TSO context descriptor */
>  static inline uint64_t
> -ice_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
> +ice_set_tso_ctx(uint64_t ol_flags, const struct rte_mbuf *mbuf, union
> ci_tx_offload tx_offload)
>  {
>  	uint64_t ctx_desc =3D 0;
>  	uint32_t cd_cmd, hdr_len, cd_tso_len;
> @@ -3063,7 +3059,7 @@ ice_set_tso_ctx(struct rte_mbuf *mbuf, union
> ci_tx_offload tx_offload)
>  	}
>=20
>  	hdr_len =3D tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len;
> -	hdr_len +=3D (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
> +	hdr_len +=3D (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
>  		   tx_offload.outer_l2_len + tx_offload.outer_l3_len : 0;
>=20
>  	cd_cmd =3D CI_TX_CTX_DESC_TSO;
> @@ -3075,6 +3071,49 @@ ice_set_tso_ctx(struct rte_mbuf *mbuf, union
> ci_tx_offload tx_offload)
>  	return ctx_desc;
>  }
>=20
> +/* compute a context descriptor if one is necessary based on the ol_flag=
s
> + *
> + * Returns 0 if no descriptor is necessary.
> + * Returns 1 if one is necessary and the contents of the descriptor are
> returned
> + *   in the values pointed to by qw0 and qw1. td_offset may also be modi=
fied.

Regarding the comment above, "td_offset" is not a variable in this function=
, I
assume the comment is obsolete.

> + */
> +static __rte_always_inline uint16_t
> +get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
> +	const union ci_tx_offload *tx_offload, const struct ci_tx_queue *txq,
> +	uint64_t *qw0, uint64_t *qw1)
> +{
> +	uint16_t cd_l2tag2 =3D 0;
> +	uint64_t cd_type_cmd_tso_mss =3D ICE_TX_DESC_DTYPE_CTX;
> +	uint32_t cd_tunneling_params =3D 0;
> +	uint64_t ptp_tx_index =3D txq->ice_vsi->adapter->ptp_tx_index;
> +
> +	if (ice_calc_context_desc(ol_flags) =3D=3D 0)
> +		return 0;
> +
> +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> +		ice_parse_tunneling_params(ol_flags, *tx_offload,
> &cd_tunneling_params);
> +
> +	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
> RTE_MBUF_F_TX_UDP_SEG))
> +		cd_type_cmd_tso_mss |=3D ice_set_tso_ctx(ol_flags, tx_pkt,
> *tx_offload);
> +	else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
> +		cd_type_cmd_tso_mss |=3D
> +			((uint64_t)CI_TX_CTX_DESC_TSYN <<
> CI_TXD_QW1_CMD_S) |
> +			((ptp_tx_index << ICE_TXD_CTX_QW1_TSYN_S) &
> ICE_TXD_CTX_QW1_TSYN_M);
> +
> +
> +	/* TX context descriptor based double VLAN insert */
> +	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
> +		cd_l2tag2 =3D tx_pkt->vlan_tci_outer;
> +		cd_type_cmd_tso_mss |=3D
> ((uint64_t)CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S);
> +	}
> +
> +	*qw0 =3D rte_cpu_to_le_32(cd_tunneling_params) |
> +		((uint64_t)rte_cpu_to_le_16(cd_l2tag2) << 32);
> +	*qw1 =3D rte_cpu_to_le_64(cd_type_cmd_tso_mss);
> +
> +	return 1;
> +}
> +
>  uint16_t
>  ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkt=
s)
>  {
> @@ -3085,7 +3124,6 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  	struct ci_tx_entry *txe, *txn;
>  	struct rte_mbuf *tx_pkt;
>  	struct rte_mbuf *m_seg;
> -	uint32_t cd_tunneling_params;
>  	uint16_t tx_id;
>  	uint16_t ts_id =3D -1;
>  	uint16_t nb_tx;
> @@ -3096,6 +3134,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  	uint32_t td_tag =3D 0;
>  	uint16_t tx_last;
>  	uint16_t slen;
> +	uint16_t l2_len;
>  	uint64_t buf_dma_addr;
>  	uint64_t ol_flags;
>  	union ci_tx_offload tx_offload =3D {0};
> @@ -3114,20 +3153,25 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  		(void)ci_tx_xmit_cleanup(txq);
>=20
>  	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
> +		uint64_t cd_qw0, cd_qw1;
>  		tx_pkt =3D *tx_pkts++;
>=20
> +		ol_flags =3D tx_pkt->ol_flags;
>  		td_cmd =3D 0;
>  		td_tag =3D 0;
> -		td_offset =3D 0;
> -		ol_flags =3D tx_pkt->ol_flags;
> +		l2_len =3D ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK ?
> +				tx_pkt->outer_l2_len : tx_pkt->l2_len;
> +		td_offset =3D (l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
> +
>  		tx_offload.l2_len =3D tx_pkt->l2_len;
>  		tx_offload.l3_len =3D tx_pkt->l3_len;
>  		tx_offload.outer_l2_len =3D tx_pkt->outer_l2_len;
>  		tx_offload.outer_l3_len =3D tx_pkt->outer_l3_len;
>  		tx_offload.l4_len =3D tx_pkt->l4_len;
>  		tx_offload.tso_segsz =3D tx_pkt->tso_segsz;
> +
>  		/* Calculate the number of context descriptors needed. */
> -		nb_ctx =3D ice_calc_context_desc(ol_flags);
> +		nb_ctx =3D get_context_desc(ol_flags, tx_pkt, &tx_offload, txq,
> &cd_qw0, &cd_qw1);
>=20
>  		/* The number of descriptors that must be allocated for
>  		 * a packet equals to the number of the segments of that
> @@ -3169,15 +3213,6 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  			td_tag =3D tx_pkt->vlan_tci;
>  		}
>=20
> -		/* Fill in tunneling parameters if necessary */
> -		cd_tunneling_params =3D 0;
> -		if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
> -			td_offset |=3D (tx_offload.outer_l2_len >> 1)
> -				<< CI_TX_DESC_LEN_MACLEN_S;
> -			ice_parse_tunneling_params(ol_flags, tx_offload,
> -						   &cd_tunneling_params);
> -		}
> -
>  		/* Enable checksum offloading */
>  		if (ol_flags & ICE_TX_CKSUM_OFFLOAD_MASK)
>  			ice_txd_enable_checksum(ol_flags, &td_cmd,
> @@ -3185,11 +3220,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>=20
>  		if (nb_ctx) {
>  			/* Setup TX context descriptor if required */
> -			volatile struct ice_tx_ctx_desc *ctx_txd =3D
> -				(volatile struct ice_tx_ctx_desc *)
> -					&ci_tx_ring[tx_id];
> -			uint16_t cd_l2tag2 =3D 0;
> -			uint64_t cd_type_cmd_tso_mss =3D
> ICE_TX_DESC_DTYPE_CTX;
> +			uint64_t *ctx_txd =3D RTE_CAST_PTR(uint64_t *,
> &ci_tx_ring[tx_id]);
>=20
>  			txn =3D &sw_ring[txe->next_id];
>  			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
> @@ -3198,29 +3229,8 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  				txe->mbuf =3D NULL;
>  			}
>=20
> -			if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
> RTE_MBUF_F_TX_UDP_SEG))
> -				cd_type_cmd_tso_mss |=3D
> -					ice_set_tso_ctx(tx_pkt, tx_offload);
> -			else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
> -				cd_type_cmd_tso_mss |=3D
> -					((uint64_t)CI_TX_CTX_DESC_TSYN <<
> -					CI_TXD_QW1_CMD_S) |
> -					 (((uint64_t)txq->ice_vsi->adapter-
> >ptp_tx_index <<
> -					 ICE_TXD_CTX_QW1_TSYN_S) &
> ICE_TXD_CTX_QW1_TSYN_M);
> -
> -			ctx_txd->tunneling_params =3D
> -				rte_cpu_to_le_32(cd_tunneling_params);
> -
> -			/* TX context descriptor based double VLAN insert */
> -			if (ol_flags & RTE_MBUF_F_TX_QINQ) {
> -				cd_l2tag2 =3D tx_pkt->vlan_tci_outer;
> -				cd_type_cmd_tso_mss |=3D
> -					((uint64_t)CI_TX_CTX_DESC_IL2TAG2
> <<
> -					 CI_TXD_QW1_CMD_S);
> -			}
> -			ctx_txd->l2tag2 =3D rte_cpu_to_le_16(cd_l2tag2);
> -			ctx_txd->qw1 =3D
> -				rte_cpu_to_le_64(cd_type_cmd_tso_mss);
> +			ctx_txd[0] =3D cd_qw0;
> +			ctx_txd[1] =3D cd_qw1;
>=20
>  			txe->last_id =3D tx_last;
>  			tx_id =3D txe->next_id;
> --
> 2.51.0

