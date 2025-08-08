Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B83C87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 09:33:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47F68402B3;
	Fri,  8 Aug 2025 11:33:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1FBFB402AB
 for <dev@dpdk.org>; Fri,  8 Aug 2025 11:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754645607; x=1786181607;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QkeJWJVg/75x9nGqbOJzD6Vn9ZBqnEUVQV77bNEJdxg=;
 b=cLUZk24XQQhrAWVEi7kzkDx/Lmu541uuk5cZAfppM6/6ZSTXzZrcXEog
 hwXhfolZZ/ILowLJVRT5kpGk2pcbxGXxZfFfhFm6JUkz31KN8uDAb7RQr
 uxwG8Lnef2BC1ZohxuCOEsps6o12qw92TldnhDbdjW6B7to3D/NWo/eJd
 v1fjrSH9Upewyn3TIQoDgH3GIxpy3T2sR+G3ijz+QDZZulFkh6Q9azzCk
 6y2uMKNlbIMvmsinLMivSGFcWZQWpgrypBQTe5jFxYYVACLn/cKNBmDUA
 q911w8xBB9niTEJn/LHyjZM4IUKtblFOeLwlFzoqp+B7Q9xxxq7vkw2vr w==;
X-CSE-ConnectionGUID: e24klggZS7m6fN9O1xcCTQ==
X-CSE-MsgGUID: m0gibF7XSAivhZQ+VR2yRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74568315"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="74568315"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 02:33:26 -0700
X-CSE-ConnectionGUID: b5Z1pRXEQlORgbQU7qdWEg==
X-CSE-MsgGUID: b0daoy0pS7anpq5CsRyXgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="202455598"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 02:33:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 02:33:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 02:33:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 02:33:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI2coU9g8zXTU8AvzOpKmcC/g+MIQZsIPYO19IbhoikEi1BmNRlOK+OWsGdXf5+BpgHgB9YafCtWGHJgqyfNBG+Z+GrQI496t2isH+u6vIv3/kfMFFzhb6Fr/BA9zEevkD5OFieq0DoIYok0Pi0JDVCWtUVXo7StpimJ8SYVYR58yWGMexB/MA0k7HULiTbKLR6ln2BDLNksPe37r401dSPPoiUCpuLySMFdBZswldEFPt43dgaBqG6q7Bpns7kQYzjgigEjluD5Mef9KuDW2IseF/uVIQI4who2M+1L1n36Up8vq84L3m3Oy+jMgmNoWqAaJGN2bNjIXA54fK4s7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2h4Tybcpi6/ovSxB98ddvnw2bnR15ZvTvp5BJYZslg=;
 b=ZTTz8Un25oH0fzvIpUKkZEFcsEeoTMxV8CxyExbu2QqRDU9IQik3zlLF6YWxl2NjPscOXJo2PB1bUr6o1MRwVFcj3ZMkBVsoEhVEu+K1iP2xPgTJhu7bzfPVz5imZXHKmthLo6aANURkGjW4RtJQBpHBcK+8Y3MQkbk+DGt28aBQezu7Xhu1I4ly4j4Dv5Ic6Xu8nRvp8yONPfjQA/DUnnd+1EF8Wh9Em22PseIH9il1h0NWBzCYz4hLTOpUT/pgUXxGCFyiij7FLV+LVCGFZ3hb9Lsx/JSHim/ASgff9FM8ZaD5wy5lhwYd3P8Sj82CEyp0EVcHR2pRPxFhRwwHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9086.namprd11.prod.outlook.com (2603:10b6:208:57b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 8 Aug
 2025 09:33:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 09:33:23 +0000
Date: Fri, 8 Aug 2025 10:33:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Yijun Geng <1204565380@qq.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/i40e: support GTP in tunnel parameters parsing
Message-ID: <aJXEX8vr6YNrB6Cm@bricha3-mobl1.ger.corp.intel.com>
References: <tencent_51BB4368612AB46A24214A53B97AD8A3CE09@qq.com>
 <aJXClxDQiVORnCcj@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJXClxDQiVORnCcj@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0163.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5944cf72-7aaa-466c-e7de-08ddd65e9e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eyFK5zEj5onlz2Z/BhrdZsoWGtRebQfC+5PXx4bX6SN53mDUxUQTsexTn7qu?=
 =?us-ascii?Q?aUVcu+GUfElap0t29KPdnOp+hY+n/OIThOf6G4JnUkui59uzBfH2jPBquvkg?=
 =?us-ascii?Q?eM9AWZ6Un5SIB4nRtGvs2YASFH/i/W7qtv17bAh/xAsbP+Skjv9wXuW9V604?=
 =?us-ascii?Q?tuIAxtvNnekYmnT44c7jff8KgCgdrLD8Q7mUZ+XuswWYxZg4tj9MRdfAy3Rm?=
 =?us-ascii?Q?FLxG1q7OSZ+TYRWydVKz2fIlhWOU5BetK2L1lbRt+0K5ZTkLUyNCGp+0qQ7X?=
 =?us-ascii?Q?VEfeY2XIcgJFJlZdhiP2cEuALAOjbrcXoA7aL92X1Ws4iV6K4ABOFeZi5h+q?=
 =?us-ascii?Q?sH2US2djKv6pySXNipYWylfUp6xI1bfBjvmx+n0RNb18koSupHb/GItYoWI5?=
 =?us-ascii?Q?CfFD5Wf5YiJqhH2f9DH5qICtiDp471sh36yqnIDzRBD2M59eP9LuSPWWkhfI?=
 =?us-ascii?Q?jyA6oTdgo29FePMsO1ciTmBkNnd1iEAWwUPU+2x4ZNchK152QBVeb6IAJdop?=
 =?us-ascii?Q?7BSy9pIdAYGYby1i7Bi8QvrnPgn+sVw2TNf7E9Mh9lJe1+tZ7PUIbNO5loBX?=
 =?us-ascii?Q?d9Q/vuOCRXI8nbkmVV/SrvIqR3h8xsAzFZMCU38juIod3+qPvcyw94GNDpR2?=
 =?us-ascii?Q?VxFMyXLFKp4HXGwwJkXI1QZkl0Qbr701atDmkvG+R29Yt4LurYrfkyaEMPuM?=
 =?us-ascii?Q?7NPMH9AV6Gek8LLL3bUtURxtvMnneQ9XJZDKEjdtbpTUwzp131+OFX6T6Sjs?=
 =?us-ascii?Q?JzF+RL30MlzcQj+uACqsoA0wuTcCnu/Gm6PhP95v/1ZtYP6aQX7C0/D/j62v?=
 =?us-ascii?Q?b5/F6NuE45p7SinA3bCAPIDALS6TP7gzG5AVl4W6/+T8zrQ1Swzr9qVvLKwJ?=
 =?us-ascii?Q?Rm5WiFRvLaQ/6o7EAdhZ1TI/D0aJ1ecnRzyDLd065ttzilRxMlzKrmz1YVSl?=
 =?us-ascii?Q?60SC3nHDVBc6V3FzM3XkfwJd5VVjmrMK6YYcWftO21LZVGhxM41Dlq8oLqx5?=
 =?us-ascii?Q?c7brUtUT4Y569Pu8wIYTUcW3Iy4nEDcoiieKSYhHH6rA1DtiAem6NfVZjmFD?=
 =?us-ascii?Q?/pkIrv5rwUK/DQ+SfjuJH7ykKgJN5vCB1hdPFT236e3QAaKO2xjs7amXxvo2?=
 =?us-ascii?Q?cc8F+27BxgEZN6rBJCeyjp9GUeCVPEeLln/nKl0CqGPXpTjcE3NDtlS42lLD?=
 =?us-ascii?Q?eQ/ZCM1GArsGRdDiYErutYk8WMf7p+Sj3W2P/oZJndzhdjGZjuOlsXiT6Z4O?=
 =?us-ascii?Q?hUOecRezJ11HuW77D+zIDqqOszLIYqvvSqJd1Fm1fdXIhXp07aB82uSnspgH?=
 =?us-ascii?Q?ShiRkjREB799GBZHPazd6u6w0ERNt1+ocwWqzJLIwl5QAG+pBAXPFEfZeRXB?=
 =?us-ascii?Q?g6h7vfoA0nsTf5uoej6dMa+/tJHXHAwUXkNriFRouCnjn1yRCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qrpelUFBtu/LM/gozuKqE4o0QXvH6dZ8W1eyBGecQvqGKhUiIRnaypmKArT/?=
 =?us-ascii?Q?wvAHMQqiMFdIbZjtUzjbAuGhXuW0T6wGPQGiBwy3YDc9x2ProCll4xssA1RS?=
 =?us-ascii?Q?8jmwcfAxtpsycMTTWgkVvmp2W6+nziOs4nFJUyLRsHUzkPxz1imHmGKfROGh?=
 =?us-ascii?Q?5SYuUWFhpUk2RlCJjLQUFGpj+PA+p59vBwHnL/kSt2esG2PhRf4snWVedl55?=
 =?us-ascii?Q?jjze/aj8ANTmF7wcTzyR7FhxtCBd/K2k7Qr29YbrUj93hSBem8mtybNRtp5C?=
 =?us-ascii?Q?csyVHPyUitO9qAHNzK8Z+g2rGRTnYVIOhmT2UhM8vOylm46AOkZCB551fnur?=
 =?us-ascii?Q?XDDoy+3Wb6z6TEnuHEItQB6cmsp/virZ5iYx1puJA0Hcj7aMeEdiwPOtFQUj?=
 =?us-ascii?Q?f/ZJuNCs9NgiePNNw/IFnFuqouS8GumvTsMzNMQCMdJ4c9TooktR/QGX6PTd?=
 =?us-ascii?Q?blVc1udhYxZo+F8TW7jYBj1cHbHk4d1VDfCLTVU/0qwuYzYNWe+4m9mfPmpP?=
 =?us-ascii?Q?CrD9YSu+f1Fi7UPKicvdu+I6vx9XlCNut5Q3iVnZ5HNUOPklzLRhobQKj0l8?=
 =?us-ascii?Q?inQJPAG+eGhaBZzJH94ecfNgy1q4scle80rrAnV7KeUpLXaKxJp2kP01/GLW?=
 =?us-ascii?Q?XGOLr/3AIU1uDsrksa9baP3IweiIILACeAP1IhUFNyK3+xrGpvnjeTHMm6n+?=
 =?us-ascii?Q?Pr0OmXx7zaHvPwKRq9qhVONRaYrTgWW4zGAYV7L+icg680r1Sx3s4bXGIgeC?=
 =?us-ascii?Q?CoQfpktvhjEsyPCO3449eOokeoluk5yygVRrN1AlHVMzKdQPdFvh6ecYGz0B?=
 =?us-ascii?Q?4hxYjCoCDh0BKZc04QiriIPMSaTwKKlR+B23hcPi6GKYSUGPh1M9OGHO1tla?=
 =?us-ascii?Q?Cldqpzr7yyAf9CJu0P9i76K3iLRqCJ9Ks6CUSMIWW16RU4lhgHNVcVwRTRzZ?=
 =?us-ascii?Q?UkoWFaqPiG3MQEtxxQlHoaK71YR14h6QNoZLFeuZLnanihrGb4BDc0qCZh2c?=
 =?us-ascii?Q?ck3z+cG9nebLQtMQe6GNkbvSl7XBkuc7uIPkTy3fZRnI+DH4GxzfQqnZkKDx?=
 =?us-ascii?Q?O5IFXFaiaFpqNWehnhQdd9U4F9NpF6JzGUO7fFaKUaanavjm4cFX4bgELvWi?=
 =?us-ascii?Q?kWSV3P+RkXE6i5HZz+Dbxp31PTVLpR2aVaAxk2CPJCAAhBF4f2Fto59d9FNr?=
 =?us-ascii?Q?vj4Q8Q31TF6O2muJjwsBjysLhocqP5gpQwAxsOcYYsPBNhaFkJgXKANRP7CW?=
 =?us-ascii?Q?U0AKOcnazWtyUsHofFzZ3tB1XVMNQZoNL4UGhflTNiDh3vOPR87yVvssGQwy?=
 =?us-ascii?Q?upiLP8DmpzmjQbaDenWXciF03uilSGivkChbK93LTKjte960QlO2dhKeakQ5?=
 =?us-ascii?Q?bdmtWBs5E9Pg+uNsqk1qrvKVg88cB/Zy5ZUHIqf1K4nyg4iQkZ3Kd5Q/ujxf?=
 =?us-ascii?Q?AD/m0ydfs5poCydsw1EzAC4Jvc4vkU9xUovhBalwdLtKN/mzsgeMv7GAeD8r?=
 =?us-ascii?Q?phueuBHqYuKkIZfV3hqpo1JbkShO69xS9LHlztZ+J3SrvMJkm8cNih1r7NlF?=
 =?us-ascii?Q?f50AEcpEeR3STNo/weGJyown+nP9j+2aX6AlBg9CvCuUmEbyJzQRrYRiI17w?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5944cf72-7aaa-466c-e7de-08ddd65e9e96
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:33:23.4620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldv01xZcdCnbqbK3Y7bN+9YIvV78M3+0fQgAAcyikIaNzvA1WxGr08C/ZQXiqRAM3S6iciKKwvN79oHOTnZIjua7fh2fdQngZAQJVQo2MQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9086
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

On Fri, Aug 08, 2025 at 10:25:43AM +0100, Bruce Richardson wrote:
> On Wed, Jul 09, 2025 at 04:32:14PM +0800, Yijun Geng wrote:
> > i40e I40E_TX_OFFLOAD_MASK indicates that all tunnel types are supported,
> > but gtp type is not considered in i40e_parse_tunneling_params(),
> > tunneling parameter: L4TUNLEN is not set. During TX checksum offloading,
> > the incorrect L3 header offset was used when calculating the inner IP
> > checksum,  resulting in modifying the length field of the GTP header.
> > 
> > Signed-off-by: Yijun Geng <1204565380@qq.com>
> > ---
> >  drivers/net/intel/i40e/i40e_rxtx.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
> > index aba3c11ee5..d59d81474e 100644
> > --- a/drivers/net/intel/i40e/i40e_rxtx.c
> > +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> > @@ -274,6 +274,7 @@ i40e_parse_tunneling_params(uint64_t ol_flags,
> >  		break;
> >  	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
> >  	case RTE_MBUF_F_TX_TUNNEL_GENEVE:
> > +	case RTE_MBUF_F_TX_TUNNEL_GTP:
> >  		*cd_tunneling |= I40E_TXD_CTX_UDP_TUNNELING;
> >  		break;
> >  	case RTE_MBUF_F_TX_TUNNEL_GRE:
> > -- 
> 
> Seems ok to me.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
