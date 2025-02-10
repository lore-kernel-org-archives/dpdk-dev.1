Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE5C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 14:34:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C40CE4278D;
	Mon, 10 Feb 2025 15:34:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 15CCC42670
 for <dev@dpdk.org>; Mon, 10 Feb 2025 15:34:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739198083; x=1770734083;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AUQLMKLividJspZDaukVDAQrN3bimPmAGmGbDM2qBg4=;
 b=OL62tPZfCqYGRExHzZezrxC81qa4bEt6vv4fO2DaedY6plNiofudbL9m
 19YxJfQbkrXjeHYeyp9u8dp1jqC+dZBaMxfs9O7lOTjewGswmGmu/Mh6T
 OJTAcoC/BRZjsUxGr3z2PPQ4D6XYNM8gY5LAVaj0r2DPMQvhdjMEoJGYr
 W6+tH1VEhwj/AN3xyoxrWIJNNfp7ijJghHgj9r7TpGAwJlBV4rdtAQr4H
 ocA7Y1tkHiFaB7KP/4S12+oIWuXmcihMGETsmSAwJYHo9WjYa3QGmuQKg
 Ti0gtQI6h4LIaH8lrxJnP/6kjwP1m5ypfyGmnZdVc+Qgjcheav1DNQyIC g==;
X-CSE-ConnectionGUID: N2MKtoZhS1SFV89tygUYvA==
X-CSE-MsgGUID: q9Jgn3vTRPiUo24fApcsQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="51172103"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="51172103"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 06:34:40 -0800
X-CSE-ConnectionGUID: pLpfuiytRAK0h2oA2aL/sg==
X-CSE-MsgGUID: BAmF9+7URmy4Em/csjJ0KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116272663"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Feb 2025 06:34:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 06:34:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 06:34:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 06:34:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv5D+LJm0+PnMe5ylGg+5mSqPwOS/mhD5b6S5bCcHww7t4/XDZcsduS1JQP5ANRgHsSchHGoG7pwFOK1UGo+sGhcexnkjb3mg/1O4XPYQF0WtXt3cmgjrbZpWW4xK+PPIbeFziL+OQNRPxHv15cdQoRU3sxpuI+xUxLVRalWlRpPHfZz3596GbKDJ/SeuTHIIWt5E1RA3o+T9CUJaiPse+/pA/MdKRaTNWccWitmLJA1PMFqlJWWz3OkAMRZ4VB/wydAjSBRUONB/MkB645yg1icRH8OK0PEhjuZdL2bhsWPoOIuzxIRNeqxYgh6uKRmdE9pVUPrH5ui+bPZ4IN5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47Njl2lgJwDOm2mj8q+Rb6Up+Fwg9WvMMAw3UpUdJwo=;
 b=SRe+SD19iAE3mV5Dh3c26rhpahrHOQo4M1f0I7C59j2UN2a0k574Kez0NozMf5pl7EnbYhSsIoJhBERluZaZF8IO7bz7+AUXDtPNO8y4xl+/qdkSpgQZLDrjTG3TeMkZ4usS4Wy0d5mYsVrQ+9izQDtwEJL4vxOsC4lNWqiV8u4eUFvkRt/sMUTj9Lw478RubusHqTAIy/8e06JZjF8kNJM82qxxaFjyOL/xFiRZU+QTSJQbG7oXqkxQd1jW7OtbOMSFjGRv2SSrnypNII6xqIhH0ZzMHALjoro05nKOegXJPbyGm+LzfGsCiXh7VRvRPsLd7lXj/TjeSVUSX4NT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7147.namprd11.prod.outlook.com (2603:10b6:510:1ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 14:34:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:34:33 +0000
Date: Mon, 10 Feb 2025 14:34:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] flexible IPv4 fragment action
Message-ID: <Z6oOdGx02myDi3-6@bricha3-mobl1.ger.corp.intel.com>
References: <20250122082310.380054-0-mingjinx.ye@intel.com>
 <20250124091324.403435-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250124091324.403435-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: DB8P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e13f3d-80d4-4273-86dd-08dd49e00975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mJsJZy2aG09qK9qyIRtfBinztGyokXNXb2vck6IzKpDmlTDXqWHfyjEQ3n5L?=
 =?us-ascii?Q?WBLHtL31xLul7xU9figN+6nC+JQlPw1kT7lJw3VisWuFU5T1GgMwzlgodAsj?=
 =?us-ascii?Q?4W5BPk7RJHOTXkuC9s5McxVopeFrjjBON61ZtcVb4low6sOU1RZ6p3xtOVZ8?=
 =?us-ascii?Q?0r+NbmOWLFJRr3x/7tjxC6rWtv/+NK+97lS6z4gJas/88AI2gYWdwhdfqGb2?=
 =?us-ascii?Q?ZiHGqR0kRY4pJBA3SLGSfNchbo0hHb/SkEEmukdvdYi6pgq8iUrgOHASC9Pj?=
 =?us-ascii?Q?3+WCWT2PL5No7FABcwuXliLE29bfnFWYSSz5+xs+vlbn6oGlkT7kaDfXYTkU?=
 =?us-ascii?Q?pmKpygmIIcd2R6rh28iwi4LPNCFnlt1GfeBShaJv20WFttDksJrh0OpVJmyO?=
 =?us-ascii?Q?18m3rv8cGdBGTEqg2V2ndyi3J/ZOGqRgeOR/MdNC2nzA1NGD9sTOSB6rS7Tq?=
 =?us-ascii?Q?SaMyXWLu1MMqioZYwXfR6LChueSALp25PV+UO7EPd8moAcy5kj7zfwHb0Ymi?=
 =?us-ascii?Q?SrBbAnHuZQ/dcVblb6flhYP20OoYnIOwCVck2kU4lbu6HSsOf0EIzyBtuSpf?=
 =?us-ascii?Q?iU/5iKfMiCen4waMXIcgI1AvuyXwlKeZbrxBCZgbZ2WL6yd9Il4nfUUe4PLm?=
 =?us-ascii?Q?P34SLDS3T2304ip3FY6z7eIngMAAUoWdbagPI+eTAYNhzHwpb1ejKeIhrwOf?=
 =?us-ascii?Q?AUc6TbK3m2i0QIOqUS2MpWmVNDHG9sUTXzxe88UMMoXJz/+wwrC5e61FW1aK?=
 =?us-ascii?Q?hHEffgGyQldTLEBwKAhT5if7KB5vLq4ArkjiZORP/oMAkuBn9/ehBVjwyGKG?=
 =?us-ascii?Q?oVEfdZoPRS5htcgYa1dhNzAmQkdX2MpaK1foQ8p24YwmPB7NkpXNAfLTO9SE?=
 =?us-ascii?Q?No86sbeu8iHQwbfeq2b95TsYK7r0d8AnB6GLh77A8CDGFAL+4FZruSkTIzgC?=
 =?us-ascii?Q?KAJjts/+cxna5MV1RF7k9XKp2XImsSf0uEEo/L5+NBGiEhE01IBguiUzHW2q?=
 =?us-ascii?Q?mfXj/pIvbNaiGFYfjbfiVp7LG01Las+KaKG3xqeWrM7BTI11NIgkG9HUNFSj?=
 =?us-ascii?Q?hUrFxhUsCges5HRqOjx+QdAW5P5E4fZqVRPhH5iXnlh/0H8TNsCoGhwb71AE?=
 =?us-ascii?Q?nWiD2UgokGhMBR20OUX7NnE9h89/QWoXyrfk7bXi1gicaO9o8rKsTTextiSB?=
 =?us-ascii?Q?S9/43MixW0LIj9kJBcp6ib4JzzGp/w1DzT+LLKu74CxaRyxhYV1fpOapF0d9?=
 =?us-ascii?Q?Lr9YmMX4dsNNNdQ0397YV1WVFovi+7f7DBwBecoi7OhPy4rCxL7OWDulkO9u?=
 =?us-ascii?Q?OXoz+QCvsF8mQ1Ra1UgbOJnxVMywW9buVgmg1j383EMFhR85L97rmFSLHiM+?=
 =?us-ascii?Q?3ZDU9ogC13/3P2rFawhPQa4LkGED?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3kx7hqRTlXWqKVhzhID91sLBVh+5EfxQeN0aLff+nLv/ADgl0NhXeQVYt2kz?=
 =?us-ascii?Q?pEMjPQkQbo2oRuNKMrQpHn1Xqe5XvCDwXnSBnh3OKxV5MdIG8gUHPJju6STk?=
 =?us-ascii?Q?O16qM6NRJ11YqcbZel1uXGWuVDp5Xxu5u6Q49ynUShQRxgQw1007Td/6RvME?=
 =?us-ascii?Q?S9dQqjNZQqfPqFWvWhT3n/wpgxI6UCiQtdTJVM3RhkKGwx9BjTg7Fxe5wI7j?=
 =?us-ascii?Q?LlTs3CQbto1zWV50rllYG4UIpoxMYNnOo0SOsgwjjjMe5La/sNrCKBPien5I?=
 =?us-ascii?Q?s7C5Af6eWH5SckBSd/EmFreuLimFsplYrT+pqaRpandodqXsTvvkBbIVsFD4?=
 =?us-ascii?Q?tzUZKjMe9s855X8rGa9KMsRD1qx7nYo8hlewIuekwBFN/ilztwN/Mn9l0Uln?=
 =?us-ascii?Q?3wxmHQyMRTKRYKGL/Ly++szoau8HwF7JnGD4KvMMd3Ziihu4A58iPJrXrdMK?=
 =?us-ascii?Q?qYuUn9Bz7JmMoSeywEx1Na4GzJwJ3fF0d6DwSDO0igdPAIyQkFm117KUg4hG?=
 =?us-ascii?Q?9OK1gG/qVIfKeWQfn1yvColliBtkqBfv7Jfup4JSjH9CEU0h9aYdGJZ+XWLh?=
 =?us-ascii?Q?PwxxAzoP9wn4IGZSBuAEzy4oPvy+Wmt8GFGKQdLArwTnKC9Ma393RTNd4h0O?=
 =?us-ascii?Q?4qCiJBmmYksu/4HQeH1D8EKG7rEp4Df320ihP6/+J0Hko56nDFoZxoCtH6M3?=
 =?us-ascii?Q?4l7lFJPIauKDdHclbDele+ypHVV8OqbBiZrBYSaFHzTaSlzxvKepZQ8HelFs?=
 =?us-ascii?Q?TgjYsyg/ixpR196oIfCzwa90VuxFFdTPfk/tULBtZB59tRjc5NiTy3by3ZhZ?=
 =?us-ascii?Q?jm0QSzwts5psPFOtv0+hXqK+V7c9j1AJyeoH4K8rpMiwu3x47tj1sHaXzAd1?=
 =?us-ascii?Q?kh9xC0ZxO9Lj/kpZWvybB8KaqFb4cQ5Ea1UcJTokg1HeA7btg16oM/idPdh+?=
 =?us-ascii?Q?NM/4P+4Bi3aiOMKFNFxZfPrGs2hiX5/jy0LnBLkSd/6iWexkcS118vgfyCKG?=
 =?us-ascii?Q?dM9jRq9IClWE5rhino1O5AZWqXbMZfGJ+/dnU3L6y0S8Y5x0D9C4Qft9FPNe?=
 =?us-ascii?Q?m54b/yG+qUXhQAtnTDeqmTAQaRB+3Wyr+Uq+JZlC9vHvYV3jTnJ9AywRkveA?=
 =?us-ascii?Q?UIwRO8yJ2F4gG1BGRt6AWot69Ej5Vgv0nlBlj5WPBY7cmdmO9pkCjbxTD4K4?=
 =?us-ascii?Q?njdcn9t3RMC2z6losWh+AgWhDeIs0PTxtsGXwaGnxdeniXon58OZ+PPeXJnl?=
 =?us-ascii?Q?n6cTI/hW9xCsDbW2c/4MSRslt7bqrlNxkwi1z8ReTGd7c4DFH/SS3OEZgkxU?=
 =?us-ascii?Q?WAO6BR8h2NR0Q5zEUwGw4E+H1JETihPnlyEs9SntJFffwA6DTNKJXrBHjp5Y?=
 =?us-ascii?Q?8RybiXxVjBohTKXyT0eHqVCJ96+5s7rpYSpBnmeT8QT98VN19wwbLmpM64Z/?=
 =?us-ascii?Q?eC9Hj4vfQif0DjrBU8RH+Bl24sRwo0GUdLTj7TBuaJ8Zgzs54+yoq+lM+Wnl?=
 =?us-ascii?Q?HyMOLCRrqJ+uFtAyBnzvum78iNYmBMwoLJAeBFVER32th1Yd4eimHEqZVcR/?=
 =?us-ascii?Q?qIoiYhyuqwADQR6z38OAMjQPtYu8weibjfKRj3uNF/l0VR2excXsrVMx4osv?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e13f3d-80d4-4273-86dd-08dd49e00975
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:34:33.8671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9UXSvguuEjVu+CEDCFpKptvLFf0508In8I7Gsx7xDy22mrBmNOLf6IBlw2kCGIzY4fmzsO28eOAVkMVCNujID9HwOssYglzYzRzhF5zBDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7147
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

On Fri, Jan 24, 2025 at 09:13:20AM +0000, Mingjin Ye wrote:
> Support for distributing the first and other segments of an IPv4
> segmented packet to different RX queues.
> ---
> V2: All names standardised to *_IPV4_FRAG_OFS.
> 
> Mingjin Ye (3):
>   net/ice/base: add ipv4 fragment related field
>   net/ice: FDIR support IPv4 fragment masks
>   net/ice: ACL filter support for IPv4 fragment
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
