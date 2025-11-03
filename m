Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B53CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 19:57:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D64E540285;
	Mon,  3 Nov 2025 20:57:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id D093840270
 for <dev@dpdk.org>; Mon,  3 Nov 2025 20:57:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762199866; x=1793735866;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vaAv6zx2HPAiL+MQo6WkONaSF5Fmngd6tdaxtnj/53I=;
 b=bZj2DWsdOXymwDFqeReEybZ+lL1+WmksRXaio0GJFLuDFGW+1qpd9gZ2
 vqmmfGgymm9LwTcg3OlYuuerWQ5HI9lop1xqRiyQbMR5EPbe6I7K54/OO
 2V9CGFklMB++Y+rehYL5l2Gc4cd8EoOFG8mjd1LmaevFH6S2Kb9ga0DLS
 vtesabEa/nFVxA6sOtxbA/6fbIykhALPHzegbMMrFDWsXjqmQl0VpqHq1
 5mA5te5xNcgV9AX2T/ycl4IjqhZkjtJEWmhA3wKNZPrPGd+lDfUGPMhoA
 frX66pL9tLYINFQVV3kcs9oYSNVPW/MMAv5/RMDkbn/2eJiPH019cUF3P A==;
X-CSE-ConnectionGUID: rzaw3ihLQVaIIK2QbvH6tA==
X-CSE-MsgGUID: chukGP/dS6uUsoxVCsFShA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64204482"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; d="scan'208";a="64204482"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 11:57:45 -0800
X-CSE-ConnectionGUID: iM7xzFYFRmmtlkd5Eqyfww==
X-CSE-MsgGUID: uRmpX8qzRdSQUOpM3onyiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; d="scan'208";a="187679312"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 11:57:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 11:57:44 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 11:57:44 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 11:57:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2HHi9k06GTmBKMj58CxUAd6C/PefD3A+xpSl/hm7qdtZeVG25JscLqSaW3GJ/e0BpFwRQTdgohpdR/pD/UHbk0MZBzp0AOajkfJX3NI+1mKt1xo+NQXce5DbOXOcLlBga/u0kC3T3JlTVd+bVtIYESxSE5DbW0pEuG/tWRiDJF/q+kILKCJWyQ4I+ohUjxNHi17MRm4MeNUwvR+SBN25imKmRIQQ87B82rTl5200Je8mFix7PlcgPLMtRCIru0fRTRXIMnWeKy38Ohry5QR6oxObzrlOHSHDliysTR8UVfa8Mnj67VLV0XfNpqpVElDfSRD8AiiOnNAcLwPYVKalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKw4aDz2Y5zVoMKeLpfZmQggW4h4GsfUD5VN9fnPbwg=;
 b=kIIzhXFhpAinF8q7zXxIqV4+g2bOrzask5HWB7USJIL0nVK41PcRsnwZNoQ4WfLZtr1UyPOsV7zw4R3vVyQNdTIujvKBrHxSLmhtbd3cXdAM1tIA1bA2rPkhpI1xHAlplVDykwoNNQlVlHyNmy/LZqus6Frr8d1Fk5fczF5xLHQ9/KQoIRV1HKZHJIozf4k+GKFMrXHl6KaYsZKx1T5eP7Y08RKwbg3pT6qj4sEsZymSJFQw1bh+Z+cv9Mbzdfts+xhBW3zkv/OGRmSZf7qCbOPOC13XK/QNSo7xdqTfYjhNZNSGQvIe5xpAKGwQwvddC45OrNaFO7nxEVgH0ay/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Mon, 3 Nov
 2025 19:57:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 19:57:42 +0000
Date: Mon, 3 Nov 2025 19:57:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: update FreeBSD python version
Message-ID: <aQkJMHX6NWmZcJEd@bricha3-mobl1.ger.corp.intel.com>
References: <20251103193038.135022-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103193038.135022-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0302.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: c894d5bb-ff47-4c54-56c1-08de1b133f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PL9t3C1bfWM9imtdN744Pd05kHDlqck3gwHUpvOfgVBu/TFze3soKebYoIBs?=
 =?us-ascii?Q?8ROhTlSTdygA6/+mLm0v8blypU2jyxHoam+VGn08KelACwr9OucSlZsqTpC/?=
 =?us-ascii?Q?IWKla+3rUZ5nzr0rgHAnPaRDlyMZQB3fFsTeLS0zzlklo2ujrEjzHo/zdR/q?=
 =?us-ascii?Q?cN5GvvXL9x3ILrWTTuw/r0d08edn318f3/d9j6RLGINRL49eJ2+w3taCPg8K?=
 =?us-ascii?Q?CB2nT6ZQzWxArNl+hg5jA659z9oIV9TAJmYII2P9+udMNngwYKl/6GW8+q+F?=
 =?us-ascii?Q?/i71kjZKINF6mZnGOr9mlhbkU6F6+ScOMs4FC3jGPor5ih4rqZLiCP1zCQzq?=
 =?us-ascii?Q?c3LE6yCsdVFFnqiOeAlhoh3ipTVlFkGQV/9AVbTbGRckum9LmYEyhbuosFZ5?=
 =?us-ascii?Q?yKF+0aa440k2HAdy6AzN+3SlC7yYCKwd0BfM8ITm2Bp+FgDVCly1gJWWH5Uy?=
 =?us-ascii?Q?DPkfDcjy+SKbMgy6LIXrVg6XLxBRfYwPujmzrhUjY/8WROGlB5bmYH3RFRVW?=
 =?us-ascii?Q?kcVfMORia3MKTTTQfu6XiQhmcfMnb55TL1EUORByYgpG4MnsWwH7liBMKxv2?=
 =?us-ascii?Q?xSCswnTgylhRC/K30hA5PLo6PKpOnNUu/X8vV5qmbMze4KW+UK+0rrqklcP7?=
 =?us-ascii?Q?4RA8cgz4CPbyvALVizpZKkPK1JX3kM6cnHwHxHDLzMAZf3UbQFlcZ/P79U0m?=
 =?us-ascii?Q?JLQ0zSyFx06jK3qom/l1F7VVRN1WFh0ukVMZy42GDNR7MavNBhxy8CA1scPg?=
 =?us-ascii?Q?TH1GEUsXfmrvhOF2kgFwVsmFqfLjzupkx06KSiSEXvALTAwY/337KsGzYNqD?=
 =?us-ascii?Q?Iu2zWtFQffnsAM46uJeajVb5D97CJUcpMo+FdsotZezIwTzVqE9tD05FAa0T?=
 =?us-ascii?Q?SH1LrR2jyxKWx2DRcbSp/4JI9ckgXN1zv9rdtxv+M1xV463UL+rmYi1kN8G1?=
 =?us-ascii?Q?n4skhL7SSPNlFV+4dWZM4slt3JL+XXJ9YNEzMm67BbZjxD0BA60bNde8m0LM?=
 =?us-ascii?Q?Mv0p7BzVGupscuOUbq+C/oknRFKa5kJaGeHJ//8iEF34TdOYiAtMfIi72Ixz?=
 =?us-ascii?Q?fmmZta9PEp3+X6wZmACKYsN7VjIyw5iUiy3a8Zw2x/eiyobxFPUf107VsYhE?=
 =?us-ascii?Q?AEg6hMpeyCFbMdQCpB+5n6GYAdloST9Sfh8zoat/tEIYmDqSsVhGY9H6HpIX?=
 =?us-ascii?Q?16uMYeQmGO+zbgL+QLBSQlvCR5KfDlCu5fGZzmgmvTa1VqRacXeCDM0LfUb+?=
 =?us-ascii?Q?hrMvp//XZNBQx6mSqNPoCQ8c6QqpqVdDh/JvpzOtRW642brrMHZZOgPGGpgY?=
 =?us-ascii?Q?owYwRlCLYfqMpLVz9IF3lE3TXphl6ATcYA2S6CZFSvun0Vs1475CA8ucXWOF?=
 =?us-ascii?Q?fV/PXF/d9bsgqFrnx5phzlJxi75vYJwO63yVL7Df4RZ5OXeUmJSxlMrmLfzK?=
 =?us-ascii?Q?oGqASm/R7Mbp4p299tY95mIss73o2tz/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V+hn2iyspF4H3pD3kMt8mCLTTT7dqFRwDn5cMgIsS/ijsAPGlqxv5Eav28qC?=
 =?us-ascii?Q?KAsqtReP0J0XDXyUWXls8DxU8C5XA6ylL+lFugDmLo5x4sbMHjOaVUBt9EmK?=
 =?us-ascii?Q?hGb7wSX/gksRpiRD1OV1wh7qC4vgcs4lvkjDFRwQlbXUaIWFLh1kIp/4Ab1Q?=
 =?us-ascii?Q?FEdhnP0SGUO6gR3GCl42i6Wo0DB7bxdBRvAQyTi1UapMmrM0bnRUBP7Mf7vw?=
 =?us-ascii?Q?S+kkLhh5mUE+iuscs7Wib0hdVYANXfLhb8YJrduYcTbxO5jHM5u3W5JsDiro?=
 =?us-ascii?Q?qF8lpV6dsE4nKm9gQq9xC2BiU1SN9yTQw0I40cBF0hJREXLzAyrSfkrEb1KA?=
 =?us-ascii?Q?e69MvBiXBZSwDMSe2WSoxkYMO6WL5MwGD8A0JI3vJvdvC4fXxbMcaBJ+Uifh?=
 =?us-ascii?Q?FXMtc0qHyVLVZhrf+kp84Xj196CIIs5k0KpNgFGcfLz5/2SeVwQ3ocW75rxp?=
 =?us-ascii?Q?myXbC16vUJXNPAiT4vwEFFMbKQ5ybv+yllBds1qGAOgwXDb6urkGg+vvQ4kC?=
 =?us-ascii?Q?/s9AClveCxLzepwd0MBX2BFKJJXPQB8y2+kZqB/t7cqW6D8ucAQrl97I6SgO?=
 =?us-ascii?Q?dPZgEf/mSn6ZKo4sfaqsFNSnO/nGwPiUrTPSfr2iJN+fZHCJI2AlanGRd2fg?=
 =?us-ascii?Q?IQnwbq8wlOKL/+y7DADJC7Wk4tHY4TJqVhdBpI2DQXKq6kJIqs17btH6ZEO6?=
 =?us-ascii?Q?l6cDXat42Q36OoMuSOQ/Se3iUkEZk1NWBFm8yZrx88tgMbGhuusrFl7h5nzC?=
 =?us-ascii?Q?qCTnTBRbO4p5lqXwYJhxobwkCwPABD7a3p9XqeHSQ0HkJSN7XSn71ycdZ33x?=
 =?us-ascii?Q?kA8SeIPEhhGtyuHhxONQs8N4Z57CEetVQ7SVaP1ni4Vvf8/e4O5tmF1Oq/xS?=
 =?us-ascii?Q?bcynRV5yygTw3DfBc6JXbVRL0DcTNbwrWkPKJDXpbYwpIHC5nwAjk9Fg83oz?=
 =?us-ascii?Q?J6WXrI5sDxIByW4QjqczvQ7uvCGsPpNY+kyzT+Ec7iUtFn0X5DIv8h9Yyxx3?=
 =?us-ascii?Q?siM0FEJQ7Weneel/RjHlIZyos1IofByZYj0hTQZlNyi1qvtv2DXQ2ysNk7qe?=
 =?us-ascii?Q?l8YBK1qoFggZcO/D+YtCqq26VgjXnqcQW8FQowBwunGNJUApWODJxEI6yg6J?=
 =?us-ascii?Q?nE6RMITVK/haOI/V0O1xa8G+UfuMoix3GIQe+Q9dfoEebuccxz92LsrSG0Ho?=
 =?us-ascii?Q?itsnZ6OaVkQNW8AL+K8gPqx47AAY1aaYT746gTnpU+uRm8KrFA8QkPb1YTeM?=
 =?us-ascii?Q?xZA0/td11sqScDCj45S7roBtSpuF3L63Yq/Eqr/IDxdJEWIx/ywOJZj1/Xsa?=
 =?us-ascii?Q?wAt9enyn6yPW7P/ie/fGTCYPbnZiW4jCX5RvH1oVWnUdNB90Pv5hyioU4i+H?=
 =?us-ascii?Q?uL4B5tf/sa8JAet5dhTGGl3ZCm1rjBhddW7O0u0GexsYIqDGTnuAh1T/F0Mu?=
 =?us-ascii?Q?u9jwoG45ZlsJJ5V8t9i2zmySO7IbNO2YtFiSydJsA6/l6CdRum0oC5yvc85x?=
 =?us-ascii?Q?DMjHAGSgXogHy6eu1UklRobzO10xIbmrJ3ZGrr9sTyYCxGNhziXAUg9LWKOH?=
 =?us-ascii?Q?RZZqA6vOSCzBT16wOUC5qczY87f8dm6YuaIYyHrlJZhLDHOULEj1+WueOeM9?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c894d5bb-ff47-4c54-56c1-08de1b133f8d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 19:57:42.2089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXp5ZDQwkjFePt+rHWYwh3D79BBafWR5cdcKRJFXpTCJRC+nq+memnDUvHD/Orw731OeXEDAPEEdwgvr1sKx2IYdG1pxUjx10ONbAuZTKSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
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

On Mon, Nov 03, 2025 at 11:30:38AM -0800, Stephen Hemminger wrote:
> The version python used in current FreeBSD stable release 14.3
> is now 3.11. Update documentation accordingly.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/freebsd_gsg/build_dpdk.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
> index f98292bf41..c8b2964a4b 100644
> --- a/doc/guides/freebsd_gsg/build_dpdk.rst
> +++ b/doc/guides/freebsd_gsg/build_dpdk.rst
> @@ -16,16 +16,16 @@ The following FreeBSD packages are required to build DPDK:
>  * meson
>  * ninja
>  * pkgconf
> -* py38-pyelftools
> +* py311-pyelftools
>  
>  .. note:
>  
>    The specific package for pyelftools is dependent on the version of python in use,
> -  Python 3.8 being the version at type of writing, hence the ``py38`` prefix.
> +  Python 3.11 being the version at type of writing, hence the ``py311`` prefix.
>  
>  These can be installed using (as root)::
>  
> -  pkg install meson pkgconf py38-pyelftools
> +  pkg install meson pkgconf py311-pyelftools
>  
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I always find the python version included in the packages annoying, but I
don't think there is anything we can do about this. Thanks for the update.

