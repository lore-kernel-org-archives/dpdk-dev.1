Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64695C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:54:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A989240E34;
	Mon,  9 Jun 2025 17:54:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id E92F44064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749484450; x=1781020450;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OiHmGg9C3PMV00yDGcAU0s9VKb1zwf3Z5zNZhjDF/nk=;
 b=V76MSYOu/MMjci4mZfiv0Z8wWbBInEd+5TLkOCJ/5R9FyQGixE/HqZ6m
 RYtazED6osp2GANiXXnh93mJNm4DaLNF3BpvJQ/ctEl2JzN0D3No1E7CW
 GbFhoCSgZCe/78tLvKJdb8NAKgiqLx/sghxzByhBP8HEmx83JXAA19iCD
 Q0gCDpZuw7o7c6mpD7SOz9Ko5PH4oGe09DMacCxiVxzlQZis7PR8P5tDs
 usgLGYYwBrVwb4rzBQCyk6vFHFpZ0F7w/FNjZdDao2EIy6FdamBGEgc4V
 ywX4kQkOhkqg1S/Tki+QMsvznDR05yhOjM6eXIlCLRbEjUC2T+jAjoGvW w==;
X-CSE-ConnectionGUID: zGZz82C2Ruuc30srl45f7A==
X-CSE-MsgGUID: ErYizA9EQoamQ5x9Pn6YVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="50793226"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="50793226"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:54:05 -0700
X-CSE-ConnectionGUID: x27B/3IyR/6ex0Z+WQxJ6Q==
X-CSE-MsgGUID: 4jqX4PX6Q/KDwgulbEUKSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146903464"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:53:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 08:53:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 08:53:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.61)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 08:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMAwDTisT3cypLu+yyM2fpiRXWyUUoLwJlGpHSbgc3X6uELx3xoJThnocT72PsPAP9CSADoV6Te01z2rl00/WerJtWZ5NC5tfRFmyJYBvVqdhVRLdHqKLHIUX2QP+7vyUGVQ2woml3jfqEodXGH+MXvMkV6829ZdL4ljEeuFaBA/v5tU+hefrK85Cbg3V+aSvzD+0aKfoI4EqKIfgqBfMXDmgWJY4gIESVyKXOM+fvH5IvZpxaYEvoI1c0WU2NSWrVz7bIVIFCHQLpWkX+nvDdTt6JH1VaspZUxUmJb2gofuPFlYsDJJ4PRUFME8mibiimBcJGbRsNI/kIUFhGNhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nmgBAQrxNCvsoN9WTH+Sf7CpY+XYg4vrjUPMHKSpy8=;
 b=uSNxC14QX49XDx456RETMk+Ov1wPZCQ5EQEdRwh9osQ6MJbq955ZMLnOXuGZHEs/b4L0AFZEVtVCkd68ofF2/VvycBIxv2BB+bBz47U2WQtf2w9q041OLyFpuSSNFP0k2gkHZKlWWilx5D+R3nzVUtSR6G0zbX2tc//45NX4x0fThZtvIihZyGCbgVOBsHdV0qp5kNNbCzFe1TrHOsVWypaKCSb/gt2XfAROVLODO6/nMWcu/akHmEMwZ5xcaWTV/ek3W0EpsMdJAA6Rrd2Zx+DkMAC9ML/Gj6+cGUOcJMM754yUIU3YjqH90VLmCUtaOqTt/+Xsc0sDrazZj8rMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:53:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 15:53:28 +0000
Date: Mon, 9 Jun 2025 16:53:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 0/2] e1000 base code update
Message-ID: <aEcDc8zMyfHrkAqM@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749464159.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1749464159.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 561ed32a-235e-4467-ecb6-08dda76dc693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QWWeExE+d34PuC53Z4flveogUQI+kEWRaXh5AHHd8Z1IDXdn8ZczMnUMtmEp?=
 =?us-ascii?Q?hbwvrhUfb2xjCgX7jgOP19LSYZgcJtCJLQjtDAWE05XR3lluf3fBD17n99Ng?=
 =?us-ascii?Q?GIBEtjAQkMBn1CMJHBEz5ltuMGiphT1Kflzaw9c3wgHxpMcoQ0+ioqrMwlPH?=
 =?us-ascii?Q?DZKRpHhWYSYhZ4GX+37wkSMXo8hL3v1l6vCb5Ax4t3ZzuD1T1HmTivjH5cjh?=
 =?us-ascii?Q?41f9NyH8zdow5dRJta9B9+sQfGiO1tlbULNf5qL886BbZDGr6CpGQHfzNHbZ?=
 =?us-ascii?Q?rtGKPc29zXMtV2+nkz6Ty5mcoUmyXV26kdfZt8QRK2hCEzaZM7i0gc//URJc?=
 =?us-ascii?Q?g0nY8TvgBcPOHVXLBWMhTI/tDlJl0mlLLQ1uxsBxDnOogoBsKxlYK14UJawW?=
 =?us-ascii?Q?/jixnmqYSpR5z6NaF9HP1RLZyOvJtTNwV6VcorE9EVmQ/JHFWrDS/epNFb04?=
 =?us-ascii?Q?6gVrQBVaDlJbUJxW4xiAg8Pmyoghy9Z49L/dtB0XimcibbwnDhQGKBbgSW92?=
 =?us-ascii?Q?Gmc+4QMB3SFrN0o6FYZWlSMcpTuqWkBMsQgcPnxDPa/qXdWk1kTEZ3blMzgr?=
 =?us-ascii?Q?9C1N9K0GeThGBUYDvqV3bA08I9sM5JlIGXd4QU4aB98EPW4hnbMX/u2iEdSh?=
 =?us-ascii?Q?J3fsR4wo5GELB9lJl0adURH7k8bXqqWIYv7fqJPRihHdiqcD/UKmDQDsk0Kb?=
 =?us-ascii?Q?xFDGPxVuoDe3gRAFvDgYE6s6hyLwHCCaIqmju+MROFTkO3WOIDDXD8V9fH/t?=
 =?us-ascii?Q?redlEncmcdESi+Wz7214OsSnwhtK38oKj3Y7DLQPQpl6gGXqv/mpPFs0X/AK?=
 =?us-ascii?Q?S8TdlSsd2aovl3/+7l2XqLlsoObg7VgJ18xrPUVwJd+w7jXP54wqMTg/uGvN?=
 =?us-ascii?Q?CBBIshVHmGMM+39Xn6Eg8ckBYR/jwO903Y3ARPWrdSwg/ztryLPjfQjjtkZN?=
 =?us-ascii?Q?zacgTu6GivlCqVcyKwFhVsnf7xmTjjspgEeZTjH869vNm8tMLcsk1pRoWbIX?=
 =?us-ascii?Q?UgArIBuuoAcbzpOQyfHkzIfMsXVoSvTJXLM506lI3YxFaiB1+6oJieAi8aik?=
 =?us-ascii?Q?MUuNkx81vr7NBVEYUIGpX41GEWAg+pzrrMy2Xzyv/fEKnbfNSFt3fX6Tel4l?=
 =?us-ascii?Q?F5WdtMA8YwqdDW5o71xyXRmHADHQbfwk9I58bmgGBMxxAQxwYomyzENAsz+A?=
 =?us-ascii?Q?wzt9xB7trLou1Nzo45SnJ9jAjkRJX6icyjHNO8DDA09lF+yFK/Nl7McxukEi?=
 =?us-ascii?Q?tRLDWlnJIY/7Cn1ebZ/fVaiq1Lv4LzYB1GWwLAhlrQ4qchjlGtsvyfS+xMW3?=
 =?us-ascii?Q?xNGfwfuwadQZhffWta0vPEMVtKCPikCLGUWjakfhT330ISipqpYFn36RdwmU?=
 =?us-ascii?Q?tE3kpQu91+Ed6X/GCvjBZzXNzXaZOvCPJZolB+k+ieWeeuqybbNWbaZ36spU?=
 =?us-ascii?Q?6pkI6NQZEfc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tigsLUUr6Q6swd7ZMOqd0WLAe5QDdnO/+eX/dKbwhMF2OLGkN7I0WQP2mg8M?=
 =?us-ascii?Q?STt+NX9TvJzkGzM52KnQzYpo6eexbtPIpClfyNrYFcJ2e3BOrHbEMFA02tZ/?=
 =?us-ascii?Q?R46rt6Fpl4alYrkuIlAF7XeuQwXJS2qQQry89NwjnDpbazPJ958GnW9sS39+?=
 =?us-ascii?Q?yrWCqy1/+2HvrRRjmSkNF4vT7UDE2fyfXpbAMHY1WpTWKtu6ssnVic9nYDTD?=
 =?us-ascii?Q?FaDzcGpw2WjKRvc6ggsnQaHMggqrWkFK/8bgdsSVzbM/qOQTGN1z1WJjMkZi?=
 =?us-ascii?Q?JKD8DWdEHimdLZPQ9g0QoIn0RAr05HzKEZjfyA6VOlpLLRyIf9PXw3nk+Xng?=
 =?us-ascii?Q?qcluS+nKj+nNRDnj7dtvXSHoYNHuRO8YMfmBFS0Uu6+efFbxR6TWQA7tFwnu?=
 =?us-ascii?Q?K7JzTYT9Zbq5F1UjaSwgA0CAT2Bq2eSbYe4MsrhdZLN31ZkVEfvbh+/860nc?=
 =?us-ascii?Q?YZ2DiqovqvPZnfYAKzuJAOnlr7+0O3WWbnQ5ucWSPDuiDMM4IsydhyXB6aCh?=
 =?us-ascii?Q?guZ0p4pik0+2N94z830mpgiRzV3NYvYAa6FvEyRfBcGl61jrRoh3WPhMCXFA?=
 =?us-ascii?Q?B7V7Mq+7f5/ivt+9GAA+UEXW3nTPwnAzsf7p7Hx/LRD/mm/Qq9FWv2JkY+33?=
 =?us-ascii?Q?8ofj748vFT/S3CLJVjr8hFsNIsW2Fp75vCrVKBXwlgy9fLIpu3GkydL9dvXu?=
 =?us-ascii?Q?snwsw7PkaUlnT3eVhbEzBf9yVL1Gq7TSN5SkYAqy0ojzAEFiiWkRrxjFy4CP?=
 =?us-ascii?Q?yv8Zado0GMVI7W1IVuGXa9ELQPaeQpWvssErCddc4dFQaUV84uvt63O4jeCe?=
 =?us-ascii?Q?j8jLpTIUqAWBs8jVI0ipYKFfMYpETpLTHIdZjAdszNOPwUHk8HvavlyKpgIe?=
 =?us-ascii?Q?4Cd7+8d5iCNHnrQj5sTHKPX0uF5vf/7cYb3fuOvGardTgCL1MypjW1JC3nlX?=
 =?us-ascii?Q?ghP3aYpd/NV0L7sm04o+/+SC4awV0Aj8Z5D9IIGyC8r66K6ctahe78YPiObw?=
 =?us-ascii?Q?g1FiwplxFCxwxrNK2dSxQ2f8vCpG5lvULLeZvm0hyYM4wh2GvRTjya/CuUfy?=
 =?us-ascii?Q?9AjsWqpyLAbGfURA+7yYtd1cLPVuZn45OPOcBht06AaXHy++C3NnDVBgeugk?=
 =?us-ascii?Q?7anqF7SueaOeeTXm5LY5d49rehI/k2Vy+I5zViVBx0gGPhIPDqnybJD6LORa?=
 =?us-ascii?Q?fBSjuKFDNXb9aMonvHQFk1SCGelip6AqjbIxT3BdR2g/ogvdlUhOdz/34Com?=
 =?us-ascii?Q?GPK1oSZUmvs+wSYj5utPEqcBrUo401ZrW9lH8+RUCq6t4NelTdPeYX+tkPJz?=
 =?us-ascii?Q?DT4lnkf2OSQnJx/yEqwPB9McFtKK+Nua8ubYDTIdH8iR2D0fw30UieAxVmxV?=
 =?us-ascii?Q?/sphMzPECCeASEG9TdNLkdaDVzfwrz3uJgea3THwi2NOp8axOoaer3IY81F7?=
 =?us-ascii?Q?pIGm0Ie110GSsH8fIQvlrVAjibzJtQFP9G0wlFyU0C1Gnj1vdYx8iFfUgTj5?=
 =?us-ascii?Q?lCXrscuOEhiXL0lGriDpjR+20EXQR1CA5P4Kz+UNQY0c7CaPq9XE0FeaBv2K?=
 =?us-ascii?Q?Wl8aLHsTdsuY/dna7v6zmMTsm4kRmRjyrRjxs0eHHsRRoMAYaY0Wrrv26XjQ?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 561ed32a-235e-4467-ecb6-08dda76dc693
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:53:28.2360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DvWi5zVbsz/bv/dhTK7vT3G93NUgIxrkAHn+axMNgvul5CO1nZ300N07hupPjXiEbY5WLIuTd1XqbSDiR9TTjoMjpEMPLrqg3YYLr59Rbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7752
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

On Mon, Jun 09, 2025 at 11:16:40AM +0100, Anatoly Burakov wrote:
> Update e1000 base code version to 2025-06-04-14.40
> 
> Anatoly Burakov (1):
>   net/e1000: update README
> 
> Vitaly Lifshits (1):
>   net/e1000: better clock synchronization workaround
> 
>  drivers/net/intel/e1000/base/README          |  4 +-
>  drivers/net/intel/e1000/base/e1000_ich8lan.c | 82 +++++++++++++++++---
>  drivers/net/intel/e1000/base/e1000_ich8lan.h |  4 +
>  3 files changed, 76 insertions(+), 14 deletions(-)
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied  to dpdk-next-net-intel.
Thanks,
/Bruce
