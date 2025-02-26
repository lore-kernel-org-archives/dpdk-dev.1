Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A412CC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 16:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89A714029F;
	Wed, 26 Feb 2025 17:53:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id BD9C14026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 17:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740588799; x=1772124799;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=FNYkV5oxSDmbaH9M1vHus/KiLMU0UffTos56pFVYxwE=;
 b=Qw/lAXuouuwcuX+pmgKshkz+oSfZanLReRdX+hSLzo5aIMnMHW1lDneO
 BEqBHLoo2oS1Z9UXTGLqTS6BohkBgt1+1ft8eizM8mzetU+Z+pmVlftId
 2qXMihzT6xQKHNkstkSWFKteHVU7KeeRz8nAkBWDsLFE8xiQDEL/CyKOW
 J9dNJKKujBfoOZSj7d52mSvR5riN+uPVNaoVdHCK5OO1IjS8/VBsGEGK9
 NHS44KnwJODvI63Aes8h03eRVax+erk2iRpIaYjrRFSOnKQIOhLAp22m5
 xfX3o5QWV4F+hPmhHy5xFH5XgM2cLPF8tSeR7Ma+mp1Z4W9PdoYykaw3O w==;
X-CSE-ConnectionGUID: v5Is+REjQ4mB6HSszq3HBg==
X-CSE-MsgGUID: o//4Va+cQkysoYyhRrt1QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="58985606"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="58985606"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:53:17 -0800
X-CSE-ConnectionGUID: EDe8HeQFRM2//5soWhJIZw==
X-CSE-MsgGUID: W2tEZUNzTFi1o9tH574bBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="116545622"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2025 08:53:18 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 08:53:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 08:53:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 08:53:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1U+BIjQr65/XgdcuYH34u4FmOBJkcFAmvOgXAEXcEYIL06j5vvyh8SNUr6vwVl//lIx4o0Er4PCzjzn+6K4Azj4QCIX1x+/dC70urPWPUtP+r/Wk0GmSihkTEjiSMHnROCigCAI25mLz6O5673CZe1JVgRGKPflVKb4z0p6GzNgyhDyl8CdqjgqJIPi9V4PRZoEu4Q7L5JSQQZaybNhOBHA7Y+DKMe5zvg8DXDlsvFGajbiaxfyU36tO15r1hmF7mh80PPeyfLFtjOMeB183kjgAF06NM4R8EV1vR51+KOi0mizOWpWgNzWXEG8bIFXdaqeN7JH2yja8zCc7T1VlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFxQIGktt3/DlKgOO/y+ru1/le76ioG8rp8Zt8O4YjQ=;
 b=yx9UFE8Zz7I7AeorfRYiadMy+IuNaL4kMur1ygGM9hFxj09d7emUc3G1TAmBVkVn6sOYbQD+xtgQe0lzZk45FLvwi9D/vPa4vXNqU7PXuCMii4ZkEA9P7FQSi47Kej6fHuKgtq7FCjle+XnTs/pCzVOOXTtAK0LruvKC0cqjJF9nTuuXfXR+OM2zdQQJkuudmv9THMuhh7LDZlD4okK1lylnD0KhcXB2MmCxXW+7Z9RzwEQt6FTAY0ft1UusugR6dLD+cW1A3OvPhGrLJzN4S4m9xghnWovVLrJeAmwOpqM/WMDf2Nl5VkZ6Ifp6y/xE3HooveiwQZCfUSBj5bwt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 16:53:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 16:53:11 +0000
Date: Wed, 26 Feb 2025 16:53:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
Subject: Re: [PATCH] mempool: micro optimizations
Message-ID: <Z79G8hI3Yc6kcT2O@bricha3-mobl1.ger.corp.intel.com>
References: <20250226155923.128859-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226155923.128859-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DU2PR04CA0210.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d21d57-33bf-4bd8-25b2-08dd56860d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?3yMH6UStswzlf/d3oxYmb2t9c+LCxtuiFX6E99HIdS9wJtrrjht8ECLZ5D?=
 =?iso-8859-1?Q?uC1XBfXEu5UoruPq3Qn9Ylz+isBs7FRZ9W50kSTAef81bJgAhglaO94y0q?=
 =?iso-8859-1?Q?5AyysyNL10V9mAHFGI4mnWSNgQb1tIBmVH2G/qv+Ue87eZMNkg9FiJ+XmP?=
 =?iso-8859-1?Q?vpq4rIpEs8FHyZ+8Vz+ZDdy1Q1IqqfznC0wRcMP7qU8xq+OIjLrlMYNC8x?=
 =?iso-8859-1?Q?eXr456CrOZTSnjaTc5sszVPdgEWamVRiM7tKOBeQK2yi/kApogjldv5T+F?=
 =?iso-8859-1?Q?bsuNWq8BAXyR4ZDwr8LTKao1GUfkuSk2pnUZeXPNKbAaGW/zQqgs1Z5Sbq?=
 =?iso-8859-1?Q?gISzEn0uIDXlM5Qhe7tagV7GLOQ+W9FTIi/V21viJJh4uCRp7TeTT6CvhK?=
 =?iso-8859-1?Q?bjn1MgaydIUTVz4z8th9QZqR1m72vMHDvC/z4qVCFCcI5VBtRBCEF37rTv?=
 =?iso-8859-1?Q?ZhEdSqq9yevx/bb7ew8gJf9i0meCVl1Z9X7P0BqRwzINdanrYKaEsxGfRO?=
 =?iso-8859-1?Q?Y7q/aQuhrUR77MsWuQ/j1/cwTZM6UPjjDOROiSYbZMVTbv53c4nc5kf4hv?=
 =?iso-8859-1?Q?lNh8eH/lUu1hcqfblZZflZa1frcEmuKRqn7/RXG6S1h7cwZUd9k61YGzIw?=
 =?iso-8859-1?Q?oXhQ17D8z/np7tW+u7iS6s9mQl2tL2YKxwOMALah9hnChIuTP2BE4BPxoN?=
 =?iso-8859-1?Q?1t2ElgJL3nvV1Xhq3HNOWsHrz8Ud8yVDKV9ObW/738oOEEgqtfx+mUP2u1?=
 =?iso-8859-1?Q?p5j/CZ5itsRA7rJ/dexnwV8WfRDMKNwC6H/a0EcXxNUDnXTqo5T1EDSLUa?=
 =?iso-8859-1?Q?0gv2HvSFJWXGdgPNMMeScv2nVoubeTlGvJDh4lHu2kCkBTtJ1jqlIhrj2g?=
 =?iso-8859-1?Q?iWx8sRf0GT6vaMi5RPijSfO//PNu+yki+sj8AINuZXm5SzwKNTy7/QcBZU?=
 =?iso-8859-1?Q?eqSNZ+1mBiyNZ2cL/lTyXhHxivE0nDrGRbkueCxBtUmXS+dTzjjZiUvboa?=
 =?iso-8859-1?Q?4NL7XgfLOqJwforacb71pOEpPJAeTXCcG4jcwWXneCMeDuAgpfHFuw67x3?=
 =?iso-8859-1?Q?zQzYc0crH4kmvDE0jaYvSNHBn0Atp2VaqqdIKOEPD5XmvTN1EwheLDEB3p?=
 =?iso-8859-1?Q?WbjGp5cCm5FXtJg6s3GBMZ6xSTEtLVnaMJx9g6Ngm/oyYeZHt90hsXKxqY?=
 =?iso-8859-1?Q?byq22cd+1rK2NXgo2oqzgKU7I8NXdSkBVQKYOOtPlMS2rqVlqLBulS0Pq/?=
 =?iso-8859-1?Q?XRY+DqtI6Jt/N7Odt5w1W3/FU5UFnAAhJnVLk2dECF7TY1CF9VXl+F9RhK?=
 =?iso-8859-1?Q?s8EPGKCyg9q9DXjkHGC7+k+QZmIbZN3U100whx8lZ8SXDckYnzn1+UgHo3?=
 =?iso-8859-1?Q?jC3pq9EAdYjzmuq/fMly3lELcLYsc5JgW+SUfp1nohv+WGrP3/BPlheJA3?=
 =?iso-8859-1?Q?4bK7tozXPtcX8KEz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?znKnmrK89Iv7wYPAqkd0GdSq10J1TRGW9TG2hpP06+jkRdOInR+T6VLc90?=
 =?iso-8859-1?Q?Q2ZO/nfm6Wly5U08/s3kJ8zSml7aMHQdhl5ABZDWIApnQqXIhZHAGAidqA?=
 =?iso-8859-1?Q?aqvDWT6/YuQEnW6GxhKkwFYqMSC8GchTtNBS9mtlJKak2x3L49jMyaxp6z?=
 =?iso-8859-1?Q?Fso87eUs/uOuqimnUm19ynxhy3sexx157wPcYAX4njUb1Yq1/3tHkmewRT?=
 =?iso-8859-1?Q?Q/8riDAc8oI7QUkTb9gOE0/UahxixhUBKptEqLZ1S/u9qRrR3jQzhe8whq?=
 =?iso-8859-1?Q?9MoO3MEXchN4lxvSAv/hT+1GSS1tfLvFIYG3Lk2EQuN6fTbX1E0qAyH0ZN?=
 =?iso-8859-1?Q?kN01Erc+hd7yZdhRed4keS3wmuS4fbKRHXY0BZ+Bk/Kvweloo8+KZv/QKK?=
 =?iso-8859-1?Q?S8A5uvKr0L1YBYwPjj2sWVHZJ35HzilcXuCP1P+ujdBRql6ew6M6fwXYHB?=
 =?iso-8859-1?Q?DDg+PWOCHtAnC13ht9EYWS5WeXx2HIJJjST1/+5BfJCWWXUL1hYE4WbrUq?=
 =?iso-8859-1?Q?HjAny6kHJyocHNFXy+gpUIXjgNQGZ75oTj42r8mdkZQfUnhLbHXnnys69q?=
 =?iso-8859-1?Q?ihff35VL4gd/o8Yss0jZl0ybDLuzhuTV6ZUPXAHSnx9b+UrOlg6bIK5xQR?=
 =?iso-8859-1?Q?5WeaCXySQAuSZ+mpspLd4xzVNKV3rJ/XvCPaf4Sn5mFG6DkryHVKQ03b4n?=
 =?iso-8859-1?Q?PXdGtz80WsVts1mlR2QlCsmoLDkvU5ghfGbhW4hS0UVQIKPTxZXTStJLnG?=
 =?iso-8859-1?Q?ng7BPKT921pgq0mKD6ovc5MWHuMdHhSSaEoJBSNN/A6DDOmjN47wtv73FO?=
 =?iso-8859-1?Q?iWHCMNRnyL+1hCA2tGuWlGH17ZZHPWRVkB/B1bJtRq8SeZgVEIfvxU66Qe?=
 =?iso-8859-1?Q?94Q5SfHqh0HqIDnVSBp+CwJ+mk29J2PKTA54awUCUzT0V1OLj3MKKnC4od?=
 =?iso-8859-1?Q?DW54EnPiDLlthK+6VyDUX94GgYxDEi1+D+k43+YotBCpVaNvvFyAkj8SmY?=
 =?iso-8859-1?Q?l5R7oe4f3OiNYsahkVyZqcVmx9QdH2SnMqGD7BH9eYkM8ubCjUcwEwM6ds?=
 =?iso-8859-1?Q?Ivdg/HS0e35vsy4dOc7pZMtWS39Sw5epAUW78c5LQ4H6ucFrug2BF7g54y?=
 =?iso-8859-1?Q?nM6uDp4vH4WlzkpsAp+D6rhJv5OpZ7FE4mdYhcj0x9UrbXsObvHlnVLMBX?=
 =?iso-8859-1?Q?gHNam8cKoG3d55PlagtEhWtIwdDwpVGJBFtLqUFk6i6Kwim2AEsGICDvG1?=
 =?iso-8859-1?Q?OfPnHhAj8rnO/+SuRsDRl1qzo21p3MucAUjAgJLdaFrM6XS4OM8uxk6TAC?=
 =?iso-8859-1?Q?aIrcxTtZqfyL0zQwQ98ndLtQ3IteA/AltPddS/4akM+utIhJuyRkzHhDqy?=
 =?iso-8859-1?Q?A2ac/xYfRNDWKUwf90Mh+jmFKJOil9Zeb/BvVUD2yPkiVYLmaXrX2C/NeD?=
 =?iso-8859-1?Q?p6s4kx68DwPsJpAipAYKZvgfcn+swDb45PGvE1sDaMDorVb71okALM9Rxb?=
 =?iso-8859-1?Q?6LHTJsXL5VaGouQ17+T1vYZNJ/qKzM2IEul1cyLh9j9r9uAylhriL8bDnn?=
 =?iso-8859-1?Q?sJ8N5YrvncuXkCtQ4VRLvHnwWDkp2RXAngHj87OViPxbWRSuR9rbNNbZkk?=
 =?iso-8859-1?Q?7nDhGsvunztWXPdckRFU47Jp7UgVhm6WoEceCcz/gVmvBzS5A8NPjfDQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d21d57-33bf-4bd8-25b2-08dd56860d7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:53:11.1087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grR5184+clde4r3eWazjCaEVPYwola8cLGhe12Tmu8yE4h4428jnK3L+um7dcpkjjJOXJ3yMfbctMrts/Wsmr5PjoVrhgPm9WYuF9hBnSjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
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

On Wed, Feb 26, 2025 at 03:59:22PM +0000, Morten Brørup wrote:
> The comparisons lcore_id < RTE_MAX_LCORE and lcore_id != LCORE_ID_ANY are
> equivalent, but the latter compiles to fewer bytes of code space.
> Similarly for lcore_id >= RTE_MAX_LCORE and lcore_id == LCORE_ID_ANY.
> 
> The rte_mempool_get_ops() function is also used in the fast path, so
> RTE_VERIFY() was replaced by RTE_ASSERT().
> 
> Compilers implicitly consider comparisons of variable == 0 likely, so
> unlikely() was added to the check for no mempool cache (mp->cache_size ==
> 0) in the rte_mempool_default_cache() function.
> 
> The rte_mempool_do_generic_put() function for adding objects to a mempool
> was refactored as follows:
> - The comparison for the request itself being too big, which is considered
>   unlikely, was moved down and out of the code path where the cache has
>   sufficient room for the added objects, which is considered the most
>   likely code path.
> - Added __rte_assume() about the cache length, size and threshold, for
>   compiler optimization when "n" is compile time constant.
> - Added __rte_assume() about "ret" being zero, so other functions using
>   the value returned by this function can be potentially optimized by the
>   compiler; especially when it merges multiple sequential code paths of
>   inlined code depending on the return value being either zero or
>   negative.
> - The refactored source code (with comments) made the separate comment
>   describing the cache flush/add algorithm superfluous, so it was removed.
> 
> A few more likely()/unlikely() were added.
> 
> A few comments were improved for readability.
> 
> Some assertions, RTE_ASSERT(), were added. Most importantly to assert that
> the return values of the mempool drivers' enqueue and dequeue operations
> are API compliant, i.e. 0 (for success) or negative (for failure), and
> never positive.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  lib/mempool/rte_mempool.h | 67 ++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 29 deletions(-)
> 
Is there any measurable performance change with these modifications?

/Bruce
