Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA57CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:25:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89CAC40285;
	Wed, 27 May 2026 15:25:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 738B64026C
 for <dev@dpdk.org>; Wed, 27 May 2026 15:25:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779888317; x=1811424317;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HYpsvBQwOfw2k5PxzBwBchzFHh1+H9flGLdW6tRxLdo=;
 b=VT+dfMDppMpNtMbJYDRvnsBNLcpZTBmnmhqjUg38T6GPK1fHlaY6uOA7
 aryDLp3upqA1+8HFTUVC/wiUdl1yAo4+QAUe2u4kqZ+R9ZLCVN9iYnrXw
 x/CWc0MtlGG+NV5A7co2xAkHCk1+YJbuT+Ohg0wd9SHPUiKa6OZuoU1EB
 AVQc8adYvGniUY6sv+P2kB5wWGjWcDf1jXpddohUYNCiAjUmxCkmugLMu
 iF8/WQZLsP8Vfhtvzb1y3cWlgShAbtWYph4j4YbZqyXsotJ6Jcwj6F2fU
 0aDpfGibEY5SiyM8G/irT43zba8uEz684PIGn3RqP27JppFywuJRjGaxq A==;
X-CSE-ConnectionGUID: 6LKZPQ6nRt2RUdjaxoKT1g==
X-CSE-MsgGUID: aZZgMitiTUWVf7tYOKeY8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="68241385"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="68241385"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 06:25:16 -0700
X-CSE-ConnectionGUID: Ms54JSyqRLqMsD7fkrLvjg==
X-CSE-MsgGUID: Ck1PMxBmQtqnlvDOpKY96w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="235861357"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 06:25:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 06:25:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 06:25:16 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 06:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTl3x+NcX4q4Oh5XoBHfK/xrbOIgKjcfijV9hm74XsNrUxgL+CeUVuvraEQMJzKrj8mhvWc666GY5Vow9Wm633sM9gs8jHmRjla8ChbOt7xQTZ0IYt/dGidR1px4f5mPVVhd3hsDxWGnc1835yjBBNpNWwZiU93oIRJkA+OwypH9Fli8tDJuBjirUv2jl+qTLwSKk1ala5f29mwkoxjUQRCjwh3kZe2ufhCgkZhYg+el7EY+7I+fYlcmby56hQRWSXKypD1zX3KqV5M6gCQV0tuhkOO2eIE0O3JshE7ESInraRc5pQwkPVbmntf8LlV6HycLeZfmfmfyzVQ7ESNyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ozzSNjvM9gfuw5D0Oo0r4IQ5GJBO/gshNt5/Hb8f0U=;
 b=n/R3E/3IThDmRa2179bG9278oIJZE113O4WXnt1r61yKpEIXv2dC8YCPvtTcax95J6vJSDjdFS6BgkfPVly9ouVC9llaTAGP8MEb4TqvL9NYIj4an5PUCJVx2/WVgFnbZ0Q7yLj7/lTHvd8/JMHfmUCeb9+eLa+omRvAqOeAR+z0QdMLr1uUPBWPcwZj6S+8tNaIxFXTPteXWuZCvLSIBdpz1wyuEd3HfQ0WAW4nGXqWqighqFBwl0hu4y/nHxArzk3dZ67rJSmfhEPrvExqs5+ai2mIT7HTg4pz8ezvLlq/tr9g8eNEsGzwPAItA/HUx95DhLPpkVdxf53WXtWyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 13:25:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 13:25:13 +0000
Date: Wed, 27 May 2026 14:25:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 03/27] net/intel/common: add common flow action parsing
Message-ID: <ahbwtDTZDcztR9zl@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
 <00d686796ef0440ca63220d468ed3d15ccf4894a.1779717943.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00d686796ef0440ca63220d468ed3d15ccf4894a.1779717943.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0358.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef0e2e4-84ab-4a3c-bcda-08debbf361e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: rIUGHNbgIOKK3I0milCFGqgX0VePRacZcDzRRleDk3KHMDY2fWQxlkofS7EOxqyxy0I2MPF6alfDZTVoMXVKjmRCOlj4ixFSw8zaSfeGISjwNvGnXOlkU6PjDgEKOa+3oj4faVLymWsdKkIQmT9gXTsXh8WrUm6lSowuUVh649Q/a48bs4eVY3WPR1hrbfe6C1oD3ULr2Hta6nTwMUBSQ1Nvl98pt2oq9tUol109eKIw6ckr2GgWR2tgQTnOnRROBplECJVa/lQIMfhZSUZe3/QcNp4l1LKQekwd6Za5s8KD//gnpJbXv9FFUZp++y33jXBhGr74tGyDwlq2G46KP7G0WE2e+b+3sHNNT27iQZopiysuQTYEN94YvNc3xo/VHp/hqr5qCdnNemHcc81x3eY9kiIO8PWYsZ8xQPygiPCefiu+9F1ILiKMaQjL6C0V3ol4uib/QhZn8GedyXq0i2J4uAMnIij/7UI+LnoXHutMf+17jhgXzKiPAmjwR6B5BQQbK3XeA5yIJc4D8wVZgM1ZymH/wTTu85iLFELk24EpPijgDkO7g1sL8fRuV5R444e5hWbGACcLDGirhT4SAEEv0zP7nFa5kmiR5MZGxicKXKLWwqxRon936L3u+yzFBHg3HmffYP3FbouBq8VdOX+ZLQ9L7wtffqUkvjOxtz75pTr+qzZoPLkN3gTQoUGn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IJQCei8QF/fsHP6b3/Kt9I3rJuwn8mHJzW549PnuJTIzDk9klRfphM0iYSZd?=
 =?us-ascii?Q?plHDWTeJF7t7P7+eqKj2WokzkypxmXDceLQngsEMTmXGMkeIv+s5v4jhFV90?=
 =?us-ascii?Q?hcJxCDA08N17K8pYPNHVgLFpTPR3AXMVZ+dIN6Eu30wnriy2BQNLuhPKcImT?=
 =?us-ascii?Q?SVNbbilz381rHvAqwtF7xbRUVfyHUaZguI3w5XZ1NidgZjwXyKE9t7S+orGN?=
 =?us-ascii?Q?lyjgljl0toReseRvg2rNRItVNs4MhllvZrbiPAL5ryho4rKGSUgwVhp6V6rl?=
 =?us-ascii?Q?VZZ5Lz+YLAsKO8QWNnhYXdvBFYEzwhfLlplTKTdy3CByXe8EijsnQ4hc65Ky?=
 =?us-ascii?Q?bNVyTbPJagg2u5yD66xfcsJMrWCIPCFUau+NLzcD/6FmMqaQxE83wpmY8Urs?=
 =?us-ascii?Q?QbQw+aZXyKu7F0AgGOez4S3iRvtNVJxb0BSii9A09qmOmeaaQzgJx9kpFM3j?=
 =?us-ascii?Q?zy9U1hONXmraR8im51T4qEDGLbwpipz9Y5PZvHu5fG1yG03HD1fZFfDZQpbt?=
 =?us-ascii?Q?5CuVxHf1vs29Zn2ks16AFCgnWlyVcxaM0xm/cuerFrXJnu2AC87I6UuWDWpU?=
 =?us-ascii?Q?yV+bGsohgLDRScpkYTcQENcw/qA3uY1IGZavAL/P2qjuY3epaEaskJqAE4mO?=
 =?us-ascii?Q?aeZb7cgONZ21w2Oesov0m6eNjxKO8utCa3qG+/fHEMgW56DUPW+mv1fewdJD?=
 =?us-ascii?Q?6tQQ4xNoU7QPaQ3Dka65Y/O29ijXcsgnInKBuVSKS4JQpB+jo2D5CIEIJbmo?=
 =?us-ascii?Q?B2BCPlnea7s2ouq/7pzNN0LMjerAzpzWHX+ee+VxWIHQKY4nhVzVc/Bt4/YN?=
 =?us-ascii?Q?zGnyUqi5ZyOKkKvCUHgi9WMaUKfj15hpF1nursZkVzKki6cOyCf6d/DU5rZr?=
 =?us-ascii?Q?gAN+gcSkO+6OXk2GYnULzn8hg6RFcEQCShu0zDRGpINBqZbj1AnCiGdGdG71?=
 =?us-ascii?Q?z8WgBE27gTHDStAmCnjQe2f0vjRsNwul+6iCbdfvxNji+v+O/TW3VkeI8FJP?=
 =?us-ascii?Q?Qwv2JROMfoLbUVlZFlRsjB8dSK3wHiXmDO+KY1i5bTkq5NyJcd69NhY883cp?=
 =?us-ascii?Q?Hqcp6E2Rc6GP322zZljqSaqbMbV7GHl1z9nK/nUoQT+EUq6CX0faZMDjRdgn?=
 =?us-ascii?Q?gPs8Niholin+ZV8q6H7VJQI1elom7E23E6e6SDZdqzIjhZFTtes41VOwVXmv?=
 =?us-ascii?Q?me72l8bUWBoWQ2M1NpMp6fgSbZ0xTiLex4kuAF+0NF6roQB4ESe7C/JopTYc?=
 =?us-ascii?Q?KT0VQTnHVe3xfVdZymHnh1Ay902b9B0G38n03f8dp+R1X5HYKqTnDYoReinq?=
 =?us-ascii?Q?AaYQRuD5kML6adqABkwR4UygUxQBmooPycb6+XhbxniWxDCVsqFf59M66wzV?=
 =?us-ascii?Q?ab8vUVtMpflvBEwimQOFKot1xXFh46i4OrDxzcElP99HbWo+OqIRTlRmG15c?=
 =?us-ascii?Q?dx9RlZPuu9B2unVmJViKxFAc8VpT/bCxfCKc4hnO+0hKebkvyx+wMXhMHNCo?=
 =?us-ascii?Q?TqsP3ib8EyTQHmfCexCJZYbiz/Y+d5NuucJNFx/aHWCk2B56KFad4DsOZe7m?=
 =?us-ascii?Q?s+rHuQYIyTpZZr339RLrYuGqnw/C1iuJew6QFcHuuF1ROWCQh581iuYzWKFg?=
 =?us-ascii?Q?9II6GJKk88FgwylTI8aqWIv2RG1/FH7+ZyYhuc8Fxs/mZTXFoD5Pk2VUfv1x?=
 =?us-ascii?Q?jF8pLbA1pxBT8h1KmaY/l+VAmdrNbXdou2SIIsQYs6acc6niD6YmAudElGiV?=
 =?us-ascii?Q?FMaM99qfELEtBWZ7A687Oi6VuakjWeE=3D?=
X-Exchange-RoutingPolicyChecked: VUeOghsclablIzW4uP2qMyQoJFQXKGWoP1KJV+HJMTyaEzexAdSzcm0LruySWZGDTRDrpLqGZoyYbscYxqMdT6/fDRyP3zTw+cCiWANAjSkfV1VcYgKJo6l5di4Grlxjm+Ve6+4xeM3eGudIKmBMxw8DZzwycUADmrtsh0b6j/oNxFH2GQv0z6tTbv4Fq/B84fNH154AcEWoB8zDFWLWHADRTIpUv7oFeLJeKXTedS3x9R9N0h2viOaGPHxDsl0FMtGuqv8a+50rH3ocmSHPjLFPQfxo+Ue0TlqfZAVF3XfcaKJWamr37enMuIcsnPOS/Qd5Ygb0izAk+uHLRlMFJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef0e2e4-84ab-4a3c-bcda-08debbf361e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:25:13.0612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoc9jOOYmSFNWXmdNFDZdDwb1Uaq1CaqItWN2awjovJTUzu/1PD56mb0rSPTLNn1jQI4juqqHpwXBJzd03durK9dp+c43DfenmAx9X4pg14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8379
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

On Mon, May 25, 2026 at 03:06:22PM +0100, Anatoly Burakov wrote:
> Currently, each driver has their own code for action parsing, which results
> in a lot of duplication and subtle mismatches in behavior between drivers.
> 
> Add common infrastructure, based on the following assumptions:
> 
> - All drivers support at most 4 actions at once, but usually less
> - Not every action is supported by all drivers
> - We can check a few common things to filter out obviously wrong actions
> - Driver performs semantic checks on all valid actions
> 
> So, the intention is to reject everything we can reasonably reject at the
> outset without knowing anything about the drivers, parametrize what is
> trivial to parametrize, and leave the rest for the driver to implement.
> 
> While we're at it, also add logging infrastructure for Intel common code,
> using the new component name defines that are automatically passed to each
> DPDK driver as it is being built.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
<snip>

> +
> +static inline int
> +__flow_action_check_rss(const struct rte_flow_action_rss *rss,
> +		const struct ci_flow_actions_check_param *param,
> +		struct rte_flow_error *error)
> +{
> +	uint32_t qnum, q;
> +
> +	qnum = rss->queue_num;
> +
> +	/* either we have both queues and queue number, or we have neither */
> +	if ((qnum == 0) != (rss->queue == NULL)) {
> +		return rte_flow_error_set(error, EINVAL,
> +			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
> +			"If queue number is specified, queue array must also be specified");
> +	}
> +	/* check if queues are monotonic */
> +	for (q = 1; q < qnum; q++) {
> +		if (rss->queue[q] < rss->queue[q - 1]) {
> +			return rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
> +				"RSS queues must be in ascending order");
> +		}
> +		/* if user has requested contiguousness, check that as well */
> +		if (param == NULL || !param->rss_queues_contig)
> +			continue;
> +		if (rss->queue[q] != rss->queue[0] + q) {
> +			return rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
> +				"RSS queues must be contiguous");
> +		}
> +	}
> +	/* if user has requested to check for queue contiguousness, do it */
> +	if (param != NULL && param->rss_queues_contig) {
> +	}
> +

Empty block, and I don't see it filled in later patches. Is this for future
use, or just an oversight? I see the check for contiguity done in the loop
above.

