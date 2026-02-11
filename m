Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BCCE9E31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B381D402D3;
	Wed, 11 Feb 2026 15:45:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4C90E40297
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770821153; x=1802357153;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=hjUzsofMAGCCYGU6aHkACzHLG/X6i0ieJqTk4mT43zI=;
 b=aEoTc8BLj42yEWRck/wxZxrDTvibM0kwOPSogwxMWFFyx0y8FADoYQv9
 DDnlC+PpG79J0UFLSjT/6wh/4+m3MkNT13EzL7cLDpyKx6iXeJIgi763X
 EDHgQH4ynn97Fff9tMInhkK7TFvU+MfnT1faFN/NJYNj70/jKYfMquTSV
 IcYnsLZ5JteFNjAQC3mAOt2BzkSpCtZbT+8At70Q9wKxUMF2GQXn2UgDH
 nRhBuA7f2UgjVu5urX305V432RLmXAGNs7A3hVpQaRcUym0waBdYyQhPO
 glKpZ5n4KhHg8SIEtNhBcmPdGDxu6CoHR9dEyLJGy2SSp3/UGpS83afcH A==;
X-CSE-ConnectionGUID: EqeBFyPHRrOuZqjeK1rt4A==
X-CSE-MsgGUID: VhldfjMESFCFQ4jbwZOXAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75593969"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75593969"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:45:45 -0800
X-CSE-ConnectionGUID: omABf6B4QpWcGcpYN+DyRg==
X-CSE-MsgGUID: Eq+xyoHaR6qewXo9XCu13g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216771342"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:45:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 06:45:42 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 06:45:42 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 06:45:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rd/yc96OyfjaQz1KcE5I4V2hZ7TB0l80DHCK3fMAPrfCJ8EGzZ03+NQbCq8HHw0R6qPAqGEVBLoZcuxQCi8n8U2Giw5FVSaeFnIktnitFVFxAgS4ce+zrIP1f+ds4AGCLAJsb49kwfQdzjsfXGy4xItWnQWuhSTIlcaRj7ZieiokYHxjkh0TjtEry47cbLjO531Rt4QTbfsZ2tdqzQQOK0r+DAHXKDDXHayOqrF79/1K5Nc1iS1m6GBNMJQfhJ6iPCjdK+Avl2Nbamy6WcIX1o9ZEcwf0ZZumf/VYtRblam05nevWGTZGmJHTqu2z2QO8qNmMVF9IVJgZTAYfoTe9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=230CLyUy9knc7ZcMZkLWbTNwd4vqNOB2QfFjQQZm3n0=;
 b=Q/wF70RtCYfgwbQ3tWptk5FSOzoZVlb3b8PhI5xEXYtOKsyqF+qAAi+EuUjRwR6f/3kFWsaqaaZO+Fn+QJggH8EovHprM9Swe+9Jkw42AdnVTSLldjQCU04+d/Fv0G1tkh+DCYKvij2VTPe9nhPG4P5hQ99hPtuGnS/cwHpxxFCo5W+ZTgcq1HkSAPxjUB6d3wYELmC7QW8OzcYDhkQM4gR5cRwfvJJANWguMrqgnct3IWovi0WRV6dxU2bMAAtYg4EYoBngZyh6SLIuaTG5PzxiuQJwW/zDCsQFFjY7/cwl7ldCknRh2h40IcZ8mkSNw7HgTXhWCdWDrYFOxUPLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB8826.namprd11.prod.outlook.com (2603:10b6:8:256::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 14:45:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 14:45:39 +0000
Date: Wed, 11 Feb 2026 14:45:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 19/35] eal: add macro for marking assumed alignment
Message-ID: <aYyWDSo2UAm9Clab@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-20-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656F5@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656F5@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0a701b-d0e1-4df2-1ca5-08de697c3970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?3QkBaxNmbuEkfm+6YZ1J5QqVNNDTJeS4UKqsxJ/oHEycNtc0WVBTy4/pE9?=
 =?iso-8859-1?Q?A4n+P55ZH1SuxIMbJ0/bS5vsI48tzI0IX88ZdL6vUMoviuk5/Eq6PJOgrv?=
 =?iso-8859-1?Q?PRjr573hV91/LVLN4g7Dx/f1YO7ZjqZdv/WdLNpxAMr6LrRyaVjzdpYofM?=
 =?iso-8859-1?Q?woq+Mad8B1EZxN9qhsiP6uNLGNdC2wHVaU/u3W9rRG8CFiNqBT3A+v3qvB?=
 =?iso-8859-1?Q?em5loyZ7aTm7hDnmeyvCI0RSRYDb2Obms8TZ2T1h73CVoftBmOgYYSuhLk?=
 =?iso-8859-1?Q?mwyFrYIf+NnSjwh/hA2dwq85hrvnXpbe0Ib8HUi02LKX2qpUOdZ0dETZkp?=
 =?iso-8859-1?Q?pjX5upvIYKXQ5i86P3FQOmF58CNtvKPNn/uWYPfQjQ7V8G+tfWuC/+uFuC?=
 =?iso-8859-1?Q?89d/kfkffo/BckIphjKPQAnjA1KW9kHZBhSp3mkulmQLRpC1ooz10ImcvI?=
 =?iso-8859-1?Q?Ib0kjSAwjePH7j0GOms7YS7XOBtGOaMDUzOz7U9/4YWNQx/s/wvs61o53x?=
 =?iso-8859-1?Q?zPbT3uvCF0Xb8nZBCBBgdRpr32waonS3WKB6gbIKVp3dYKleIHHaktW9mV?=
 =?iso-8859-1?Q?VbDZL+0k87lfAQzINIc6iyW+qow6SbkNz/i98PcGCUrjRvjni4wraoe/c3?=
 =?iso-8859-1?Q?UjnkUCHtqr25epH+fHtCfqAybzgqxCvsVxYKD6ceCCjCzvnUSkzbICK6FV?=
 =?iso-8859-1?Q?j+XwFp8V8RmscJC2ViDc1hhex3NOK0OSLDqJCW5/jkwjZGxsOs03HDq8PN?=
 =?iso-8859-1?Q?nqecKicGFiroOAsqUVaSRe9akiY8spJsfDtvzaiOImgE2dalNO1/u69rOs?=
 =?iso-8859-1?Q?RZ+708Tfb219o3F0gY7TLZ4vSeTg3QsPs1a1fOB01Uttge0behWEvYMuSj?=
 =?iso-8859-1?Q?s5nQ+bBeWJuowhnwBrn6ABk+4WanSJrzg1/YHZAtSpXZ+poIWu4YBdjBX0?=
 =?iso-8859-1?Q?FYRm8lNI9TuvrM/OHzCe+AOSWmOAB9BY5CZmuSN24hg2FSxR9/XSnLA27o?=
 =?iso-8859-1?Q?hKgtv9qRHggnV9ilOiBPTd3Ld3FkMVj8E/bU3nxFd72cspX1Z44BkWKcqj?=
 =?iso-8859-1?Q?EtKd5e30Go/+VgJOk47LY+ctcFHojm+5VyCxLQNlQsuybzOz6ryVd8HMT3?=
 =?iso-8859-1?Q?1SdLj+7u4ygWV1xjGwXS0a25K13DOFRcpxS/tkzS9+pyQqmISUmKZX/opI?=
 =?iso-8859-1?Q?NlykEs1n3SyI4n5H7sMQqXFxUUCFdTMlqn5LbvVGWvTmZDXqgpiv1/wuYS?=
 =?iso-8859-1?Q?qHKlqKVF3/ah0lPWG6nwV2QA3btvKu3JBAG2vvbn4CcSFApWXT2sY5XqsC?=
 =?iso-8859-1?Q?Zuup1huM2rD9r6E1BF2l8OsT3O7BA+DsCPpotYBqBO+YyRkE3WKAwP0iFQ?=
 =?iso-8859-1?Q?pf9eBsl+7RyC4tJWBh0n2U9LfAtID4sbLL8QOwUhXh2b1gH72V3a/zG2i0?=
 =?iso-8859-1?Q?UgKmEBEPTcr9U+Y5QzF/MX7HTP5QMtvz8031gd6SUiTNiHnEmfH/Z45gvV?=
 =?iso-8859-1?Q?1WxXm1su0ko0YTA6PUJkWQjtCYPhsctWTlRszpIGRlzVWOO/e7MyhAwTWb?=
 =?iso-8859-1?Q?qPr2W+C9lLYCymE0hfeVb+IqcFF3CVs09JzU4uFE4qmMaoYGhXXqNnj4pR?=
 =?iso-8859-1?Q?yaBhAbhcvIMAc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qGB6nRhP0E5Og6xPkghmiHLEUNIuJcDBxMgy/IExGejLT+EMnt+vOhwyxL?=
 =?iso-8859-1?Q?TwDOdyuD01rhHQe9q9SqFfsVnkX9CvE8bnstOgHPn70eIl7RCaycmKEgWx?=
 =?iso-8859-1?Q?45LBc7Pf4YK6GBRxeBMcUb3OI28gbsoP8DisgiiEZfKj7eDtd3n3HtZFiZ?=
 =?iso-8859-1?Q?tDguiC2Z6CjE6yzBv7Hb7lw9/XTRTjPNEw4426rcpl01fot+FBLdyI+olg?=
 =?iso-8859-1?Q?2IOe9YE9t7f7YDx0r4Sh7IjinweFLao9p0E/7kkDzh6fd98RHQL/W+8eFt?=
 =?iso-8859-1?Q?bsrKOTF5S8qGpErZT0dev20m5lqRZZNlHL0vIUyGrMXz3oed4EW9BBkvqu?=
 =?iso-8859-1?Q?RJwWwK50v8nAzO8sUbpM5TY4TplKuONFxP6UpZKIK4jtH4ON1TyX5Lhphc?=
 =?iso-8859-1?Q?D6DCybCNNo5UbRHQ/aJRhytyfa3GgGB4tTFrv4WKfStd3+Y4ZAl9Vkefvl?=
 =?iso-8859-1?Q?L2dnGHKDEBRKHxvAjDiKmw59wlzRE3EiNt77eKyRtxFVImlcPaH2y5b/VF?=
 =?iso-8859-1?Q?yDgIkHPMLLTgxp5x4xAbxB8Vk4j3i1xaop5UJyh9/vTUGczc3SnpnTD9qv?=
 =?iso-8859-1?Q?iTio4N4Lx8rXYdOzghqmDm0E1VUj6g029FdRDxh9tC26yYeqQsy+voiQAK?=
 =?iso-8859-1?Q?2EVhrMBlf+gcECIhGqxZT5v3zRp83wQ4dOYlDm7fbJv2d5sdI8vbRLwAmv?=
 =?iso-8859-1?Q?he9VHDvaE1HF6ftUR1UXILQc3OtY2qES2LrA6xLU9c0RlKxEWrgnCg2kx4?=
 =?iso-8859-1?Q?RSqaGZDIe2R/BBaPsluBXVSB7ydkKfCO4gHb+2SJ6BtiDrJ8WeXL32UWc2?=
 =?iso-8859-1?Q?HRm/GUDTg0/rsla+83/naHpZ9zwtFck/d+VSM7WT86NB+q7kmrT6gGU5+j?=
 =?iso-8859-1?Q?8iSO6gsqenTpEk0VvtXb7v2MG/W7mOFRGlVzCrUe84vMW7m1pG7Drv+kEC?=
 =?iso-8859-1?Q?L4y9j7RYLg59p9Lg5Fsn8aRSiToXS8pFpD7APDPlmW2XfmFkdvb/aUC/q3?=
 =?iso-8859-1?Q?QrX0YfTWT6vLd7u7XYe1bIVRLqLLxc0yLMCvP7je8EtQX7m47e+MEGFeNn?=
 =?iso-8859-1?Q?zAIToT226KF4Zz8oUa97JeVPjJjsds0mLQ1kqUCqywDFS2IznCcuDIfX4m?=
 =?iso-8859-1?Q?maWHlMfWk6mZmuIsMYubRAsenQMZzH6/sVcuq3FhuKfuwjsfaNkClx40vG?=
 =?iso-8859-1?Q?YddYTga3oQDTdipTi+6Agme+ventYgOr7MA1LcoUTtmkjWd/xf+WWkSMJi?=
 =?iso-8859-1?Q?CbxvL331XwH77+iub0rAOfX3cppdX0IGpqiu4CVEz7mRz63TotqHV6/VNb?=
 =?iso-8859-1?Q?z3wVpIGZJ7TNQumgmUPZerUe06RUzTUOUTlaB9u82YuR5rpygtCMqJ1hXY?=
 =?iso-8859-1?Q?kgEa3XiDJmKy7PyjyhFw/RAWcRB5CsWmdY2RXAFjpTcjay4Z7ds0yY9EE1?=
 =?iso-8859-1?Q?QwKK3V8T/sCA0eIFwgAQ6/hmnNf7sH99JNmxe/9M0//EFkDw+f8+wbX70P?=
 =?iso-8859-1?Q?3kIoK7OQMLnvxZg130HjaRcjGQpGRyc72nm7dXN/33P4vteNdxDhmvtM8U?=
 =?iso-8859-1?Q?ZJwzq7kVOw29yuKtoAtJDXyLHRnbq+RnjOHXrpRNP9e2rn7BjgY0QpD+z0?=
 =?iso-8859-1?Q?TzsC+eSSwiHMG6/8ZxPYFkvyuRULcx/iiYjN74n7guKWGQP2l+/vbs/Epd?=
 =?iso-8859-1?Q?qfQmCM2q34MB9Dxf0EASn+37O87wDfpAeJOYXs2q1AC1J6t8Nfbar/W3DF?=
 =?iso-8859-1?Q?KIf3teJPYBbSzU8qdiuG1v+0VpYtW/+MhQxBYn6ZAutI/h3Lk75uG7JpMA?=
 =?iso-8859-1?Q?7Xt/eQagLnBh+VwoxW14EX6t7857BkM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0a701b-d0e1-4df2-1ca5-08de697c3970
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 14:45:39.5754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8h3CIR3kTQ2FSfnzySKS1aSDlnemoUozaBvKvrNMJPmzHPx2J3o5oIhlVwYqVlL6M5Zs33ovIuRsjbX7NjQN3tJ7ww6JM4xXTyvgM23Qnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8826
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

On Mon, Feb 09, 2026 at 11:35:26PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 9 February 2026 17.45
> > 
> > Provide a common DPDK macro for the gcc/clang builtin
> > __rte_assume_aligned to mark pointers as pointing to something with
> > known minimum alignment.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  lib/eal/include/rte_common.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/lib/eal/include/rte_common.h
> > b/lib/eal/include/rte_common.h
> > index 573bf4f2ce..51a2eaf8b4 100644
> > --- a/lib/eal/include/rte_common.h
> > +++ b/lib/eal/include/rte_common.h
> > @@ -121,6 +121,12 @@ extern "C" {
> >  #define __rte_aligned(a) __attribute__((__aligned__(a)))
> >  #endif
> > 
> > +#ifdef RTE_TOOLCHAIN_MSVC
> > +#define __rte_assume_aligned(ptr, align) (ptr)
> > +#else
> > +#define __rte_assume_aligned __builtin_assume_aligned
> > +#endif
> 
> The GCC/Clang macro supports the optional 3rd parameter (offset), but the MSVC doesn't.
> Maybe it's better to pass (ptr, align) to the GCC/Clang variant, so the API consistently only supports two parameters.
> 
> If the 3rd parameter ever becomes needed, it can be implemented as a new macro.
> 
> Also, a short description of the macro would be nice.
> 
> 
> Did you look into using e.g. __rte_assume((ptr % 16) == 0) instead?
> It's relevant if it has the desired effect for MSVC, which the macro in this patch doesn't.
>
Dropping this patch from the series, making the discussion moot, based on
your feedback on the next patch. Thanks. 
