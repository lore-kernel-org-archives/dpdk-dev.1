Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845DEC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 12:36:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE7DB409FA;
	Thu,  9 Jul 2026 14:36:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4D158402EA;
 Thu,  9 Jul 2026 14:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783600571; x=1815136571;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qwLmBk9fijz/uXPf+QX3WGUbl7OWU1Qym1wSLFvzYlA=;
 b=G4l0u9DCxb2SMRYakSBYpN8yFlYtrcLFSkbRxTFupx1ANLU0Leqdn9pk
 KaPCeA8iOirQUI0jQI/ehUQ1V1lSLkAGr6OfAtnJrpVfGGbN1nSgYuSLZ
 U13uEjWIohEZ9JPs+oQEv68iKpfxhh3T97CM2XkImF5mc2PrxOtuty+84
 AX6GVOxrFdYSf8PJmZn12yrOsKrarvl1MBah8LEkJaqZ0q0cvdRvjjaV/
 +atA+rMp9WHZvkPWxvg8dlXYBFWEOdXUlXeVOgiFshhzdSCGZP5gsywlM
 /SFpsv2LEuhQh3zQo83IaS/fgMkIZAur1zITP7j9uxLg2S7ym3sUdvWAQ g==;
X-CSE-ConnectionGUID: O/lC66f+R9KOHDJXSzSNnw==
X-CSE-MsgGUID: 7RXP3kVaRmCIb7YQkpF8ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84058581"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84058581"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 05:35:54 -0700
X-CSE-ConnectionGUID: kI/+YwNFR8C+AdmO8qwYRQ==
X-CSE-MsgGUID: 4Gf9MxlgS3eD4W3w1Z3fGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="284691042"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 05:35:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 05:35:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 05:35:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 05:35:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyT+2ojyIPl+sgUndiampOmywOKBhSSkQEoi6Ulsy7b1UtNXxIFfdMkC6YImFtH1Xe7p91VSRyxZGechPRnDatPl84r6pOPLOz6WwPI1t0vqAltnnf2XXvyAURr9iJLkm4lhbC9hY+7AZ+73Q3PB5W1Wdz9mkEKoKPuE/JP8QN2JW7z9DHFuYuF60Pkso5+ltkg/UCY3UJT1D8KPaoxxs66gF1UC6P0bMVFI1AFw0FqspTkvm6z+Afcf3OY7gd+s+p8yH85+CDTuilDXsbCWLw8UQvXiW1t3vxbRbcVW8mZtMSVvSHbFCmhqVlYSvnegAC3cd4Ob/da3n8a17y5zBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xePLYYlKLIpD57JtJdEZ+YZ1RUpWg+jijaQoq4KlrRY=;
 b=eklDEICnX/jXTj7rGu0YVBNesVDe6fM1aCIYE5LartE41Zn8P0RfXwcZXng2yEKPMtP4XsI6gaUDI/9YENajE8VsB7k06YsOErT5f/zvr5b8qMcZtQ91dzKjZyUMrd6tUrx009PJlFCPO3o+wK/u3CXMMwfWD4gDqJ+qiNmnEuIy01yyZvx9G3KsR9QWouZ2tg2QkCmrLr8rwXbimY83CwIl0GNPJ55xe26UBFKxh9HqJiS7fxAvdC/44mf3c/cytbNwiPgvbzIdQ6Kbwm4/NHnstQ6fJ+H1d1uOA2kX1w6J4jpSQvSl+OeGHx5QOJCvXSs2YmoROBub5mdjHsQicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF6915D992B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::29) by CY8PR11MB7268.namprd11.prod.outlook.com
 (2603:10b6:930:9b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 12:35:50 +0000
Received: from DS4PPF6915D992B.namprd11.prod.outlook.com
 ([fe80::805b:a539:5daf:e3d9]) by DS4PPF6915D992B.namprd11.prod.outlook.com
 ([fe80::805b:a539:5daf:e3d9%8]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:35:49 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>,
 "Yang, Qiming" <qiming.yang@intel.com>, "Zhang, Qi Z" <qi.z.zhang@intel.com>
Subject: RE: [PATCH v2 3/6] net/iavf: fix memory leak on error when adding
 flow parser
Thread-Topic: [PATCH v2 3/6] net/iavf: fix memory leak on error when adding
 flow parser
Thread-Index: AQHdCu66IvcRcemqpU2q7vC957xpYLZlJ4VA
Date: Thu, 9 Jul 2026 12:35:49 +0000
Message-ID: <DS4PPF6915D992B38BFE75A8872B19698F48EFE2@DS4PPF6915D992B.namprd11.prod.outlook.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260703131921.4102325-1-bruce.richardson@intel.com>
 <20260703131921.4102325-4-bruce.richardson@intel.com>
In-Reply-To: <20260703131921.4102325-4-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF6915D992B:EE_|CY8PR11MB7268:EE_
x-ms-office365-filtering-correlation-id: b4fac352-52e9-4813-4bfd-08deddb69ba5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|22082099003|18002099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: Aa8dMJa920P38NIjh2ub/AMf/jmbhLnt48Pi3FuSh3AJ4rU3/cQeIL+nqHMjo742giqZCSKacxYtSvufy0C8T5r4eNvWs2tqoNBr+jcqeoVUWKV/KQj3cF87+3zHEc7ALIGZU6V9KUYiBWFcH1Fb2Ah5WzqXm5xd3TWFk5NKtUtHPq0Pl/N1zrcYiVQ2l0NXWw6lL/4HLb0ZX+GpOL4/W8rXpwtvHLlb3hCIwFEbnSapTRmxPYB6rOmzS3Vnha+wzeXRQNJXiProKzbX8tqYq7CXWLdo75lbhnGOSD3Ku7tcNIsW57LwbTwLElCxAbyPSpJaIs631R2UulAYmRUBQKt57KZcNTfdt/PvJ3iGNItUhe7mlEa7LJncgVa4go5cnqx7VDqZssZzcJFs51aUyG9ZpzcUlo6CE1uNJRrNRPL1grDrPQ3uiTncZIWdXwL04HYvQF3Db/Vw3Xm5rGIsT2mZA6gUf9brC0QheAdSzqlV6W8USLaQkFp1CCKjvGCiqRtuQ6pgtj7cXF1HOYI6IIbjIJpvNCnnwn4rWd9FnbG3Ny1xzZGAQvfegW+cbVPDzmrj1tE2rAlY3M50TjU/044TdPbc4LomI1AENBtC1xn6epF5SgNdsTyjvDJbEwrWezbeDPEYGlAbbYBI4Ca6b5PHonfZuetrT3zDeI4SWTOHY0Sd/OwuRHQsoUXPH4qjYCjZ/oya6nXvjfgKST2iEV6LAdUbZPYwRnhRyVEEhIU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF6915D992B.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H0xfHaihd2u0yHr5/Z9HR8KtTuY8KCtTaNVR6OxL0sGolgVCUkdUkj6LfHUh?=
 =?us-ascii?Q?hDNcpECAXoZM2hq5quIPxsLJEWm4jxQl2Vu1RsqHQ6wHxw1Zb1OIyL22i2q1?=
 =?us-ascii?Q?RNtWvdMiL+QxjpOBGKUrjmj//tQdM9PBTpGnLyt0YhzH509GytsugoeXq+WC?=
 =?us-ascii?Q?XmWjnWhCu1a7Z9vIurtZW4LdIPJa8YI1yFplP/N+yw4NW4dvUmXkx47MC7mV?=
 =?us-ascii?Q?lEJbGzTeqIvdP9KwQkum9x+MpXTQohiv4mZNb4YCg1O3IdXMwIbSWoFunbCg?=
 =?us-ascii?Q?5zNNLpSjeyG+8z8GD2Jo4Z72waW3hSlMOMBSprIo+7R8J0vuzgniEp3eyBo2?=
 =?us-ascii?Q?u8sCrmdGPdvbKIBef4D671MeV9rV1RHYDtdtYKMvjoRBtG/3ooaE5X3OWPQd?=
 =?us-ascii?Q?YHWqTSQEIZ9SYFtlcB467zLhlgJTbHw8REnIOjTwPYDXH+yPtn1DXX4bdBtG?=
 =?us-ascii?Q?+BGDKQ9dx2W4o4ce9DUjzLI1qSEv8HWVohsijsbygheSKoXNIIlhKiL/QjaT?=
 =?us-ascii?Q?9XImkueW7nyZifskp0IAmF425XkJQHYPF2F0kRVAsK8n3sAk8U/phhrbTJq3?=
 =?us-ascii?Q?Jl2N9QKd/fPDQlSCrVib5cxhWS/l8BI067+YFb3WdsQCk7OeaIyMQ7NqZzi/?=
 =?us-ascii?Q?LeRrHj/0r8XJCwGcdtN9bIFIjMnJATTzynyFiquxR2cQrlihQkk5UP0TkJ8f?=
 =?us-ascii?Q?EggJnFANl+ZJL7ahwkqmeoe64dwsrfqCiCZXDPNvp1zuRDzUdZMY1qnSGqaX?=
 =?us-ascii?Q?ARSopTKwsjK4AdXrtwkjJn5ijh+Zm7eqEe0ytinptoqkgaHstjMmpS2npPwd?=
 =?us-ascii?Q?01VYJqsRV6H4ldxV0UtXfJAZcpNmRGqMHl0TEGPNoE09VFvMYWtXEQwe2GTZ?=
 =?us-ascii?Q?NxHwZFyqR2g3sogAC9vpKHDRIzuJcRaAAM/SfXJ/EKCfhDjZ8OrIMo4SN/b2?=
 =?us-ascii?Q?V3G916KI6a70WGv1qC+QUgGCojPZcyO0Iyb5LAfbdQ2D5Hyb/WD6AaURj/F5?=
 =?us-ascii?Q?N+xGD31cjUBrqecx+k3HzdDbERBf62FUxC5AWqYCZ1iN83IKr+jP+iG8c5Ze?=
 =?us-ascii?Q?Uh08bgCcTreUcb1KWW9/epldbJffmlZqp/2wuExN0oUZp8uZCiholK4f6U+g?=
 =?us-ascii?Q?HvRlbGgUVU5nKazONDUhK6oOig3isUc9EeylRxPjZXskLbQX93eSJGDC9G9u?=
 =?us-ascii?Q?zH6Vn2pEsUr4iQbd8sylvn4a4Yv+XM2zPYU1/PbgtZaLt8aAZ6ct+UmlcAhU?=
 =?us-ascii?Q?TW4p45zNX7/0i7yKARgd0DolQVMz/daNiPw3Utv5ZKod160se1b3/rqe5aIF?=
 =?us-ascii?Q?6mj+RA3DA48O/AO4ODK86N/tFBu3Wv4bx2unjpHNMSavsNPVp1mL+8tfQKGp?=
 =?us-ascii?Q?FwEgYNlwO3lqrhpfou81OiFLOb0c8vXeTFLJHRKLHdMIvvPJwqGBdD97qsVq?=
 =?us-ascii?Q?DjMSVt0P9x3dfmnZVfTuChkVadEgre2snlHcLBScJUVIlmPeFYfqV2SkEXeZ?=
 =?us-ascii?Q?ywJnWaRNc0DEssWTxP2/XbSoKoeZIicEfWX2xtMEhvEXTbXj+hNB4WBFQo5Y?=
 =?us-ascii?Q?OxYRrqVFFhj5a88YA7QxLrO54uBohB9+E2Pr5dmDIurY/0Qr4M7uh58ZbBC2?=
 =?us-ascii?Q?DQes5ysvL/urn8KlD3KjsZUWL5he4r4eHgOUCSdRslLVRRSM5RbFMBalnWLe?=
 =?us-ascii?Q?EVZjpeXInNCT0KfCb7sOv76vfcrOJCe47Ee0FvuSV3jo6VpGODMnK38sjfaI?=
 =?us-ascii?Q?o52TiTwL5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MpYbkKNhfofEDStvJJvuAZ8ihj89avwprAsDs/p+7mkrW1oTTTa4dSgl1n6GKsWXriVgWjQ4gapSSn/1B7Kpug671WIYuRZvwWwTacFOWGpGnA5bnRBUib1vXK7IIiLsV5+PgZ9d5Grb1sw1j2Ema3gYqJKx+l4MGcvoz6YzTOdzUeBBYjgjnTFivx1PuWhPKrjHr9UtlLiJu9xXX5RIy7QryWuI3kW4eU2H1NuZyqexNmPPzQQwfloZUWMyOAFyeyzLZ/4twdbOVvPhg1eAjbSrZqixRdqMSxbD8yauw0mCbndYcg24eTHPeLK5KadEaHWwgApB/ylZiSBAOEgWcg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF6915D992B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fac352-52e9-4813-4bfd-08deddb69ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 12:35:49.7781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cV5o/ejWLEFGe+M4ylZmEuYqwkUFFSIJDdIirI7uQ5gcLnPjuADAUnIwWFilyeTLqs8S7B1ntNsY2eyA63Li9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7268
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

> Subject: [PATCH v2 3/6] net/iavf: fix memory leak on error when adding fl=
ow
> parser
>=20
> In iavf_register_flow_parser, the final "else" branch is an error leg

This should read "iavf_register_parser" instead of
"iavf_register_flow_parser".

Other than that

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> which returns immediately, without adding the newly allocated
> parser_node to a TAILQ. Add a free call for that parser_node in the
> error case to avoid leaking memory.
>=20
> Fixes: ff2d0c345c3b ("net/iavf: support generic flow API")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_generic_flow.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c
> b/drivers/net/intel/iavf/iavf_generic_flow.c
> index 84bb161bd1..92ca20031c 100644
> --- a/drivers/net/intel/iavf/iavf_generic_flow.c
> +++ b/drivers/net/intel/iavf/iavf_generic_flow.c
> @@ -1911,6 +1911,7 @@ iavf_register_parser(struct iavf_flow_parser
> *parser,
>  		list =3D &vf->dist_parser_list;
>  		TAILQ_INSERT_HEAD(list, parser_node, node);
>  	} else {
> +		rte_free(parser_node);
>  		return -EINVAL;
>  	}
>=20
> --
> 2.53.0

