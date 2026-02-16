Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5422DE81A5D
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:33:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E32E40296;
	Mon, 16 Feb 2026 18:33:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 02BBA40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:33:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771263222; x=1802799222;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=O0SGCS7BS20qSeB9u8TZjerfJnCuEGau//3mTnl4JtA=;
 b=BZ/CDlKT41RPm5dLDRyCaoOmzJCYPfWUui6Wi8ZkHdBvbxT5z1Ul9irP
 WMp6c+cltHDMfNAgTj0zp08EFWTAMEgWArfFxjh3T8Vly9SPLoV1LJWgf
 XbCVGRk+vved6zxo1vriN28UzCJAHKEJ3bu+1fnGJzc6wkWrpy9jsS25R
 0TYXaZRAaFp2ORv/7sZf0d3w0N1ypI0Zo2fzbfA5SGFNbh3+nDjAMGWEo
 MBO/HMy7HGYqF6Xlt6sT3R8uk170ixsCgDds1B2a02NmcwBwidoFMyv1G
 uZDXqlHVS1lFz7dIJlsfJC8iHvL0qbApQc1m08B9UByeoaWp1DeRh2pVJ w==;
X-CSE-ConnectionGUID: i30ZsU05TmSryI+PjxtKAA==
X-CSE-MsgGUID: KLIJNzmJQRqLmtj7UKXiVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83783473"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="83783473"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:33:41 -0800
X-CSE-ConnectionGUID: tQaYyGUCR4Of1d5Lju+5/Q==
X-CSE-MsgGUID: De4WsCroSWmqtYpRTSKmLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="213504231"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:32:58 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:32:57 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:32:57 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:32:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+nmsAcGY2S9RunAJsU5ky+asriFIeKunE8EYp8/lGaCynrDBw9Y1EvagsChs7A7QzKr5CxlaWzf3gLinwKAC9HEm2u7zmlWBM1iVwHDouH5GKuAfF697Q0Rgsgod4O+4FO4M+iDD8LG30oBwkt1UE1m+5CwUpnpiEyWNOiT/uzJ72bU/Kn3Q1vjQ18oRWqdY08AhWmLNvVA28J7ESvNx3NLb+IHdof8lBuG1PIXuLNLxQggmGhTHa3V3/ncFHwvzUvFOAbMJ4eLiXzhaE5BvRGeO7KwEb5Rs1hzJzPuC8R8XsZZThAU6Mi/gPRBewpghNv8NZBLiirkjQCPk6QARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q740K6BWzAWtiEkI0DSKfpwGLEVf+qZa6ZWLRJol+RA=;
 b=Dy1+8IkNYdrz8TsZXDMBSNuLcqK/km1fhbXpugJKWZ09aMO4BwIRJhgl0gKi8EOzaVi4lTQ+cXAc6DjsilOW+ls4iOM7RgtnONsPi/WYn0y35zJae1BzHsuzi+5h3nj84AwslUe9pTZHSg6WoEoAANBnl04zC4avLP3qfwIMZolbN1nA+gPIBTnAApS3G7q7Ssgb11j/Bp9JMfOwCbsdt6a0cYtr9dwM7Yldgc2SVX42jqmlva6xwf7OJw4EKwMGW2+beNPzaxax36GsmZcH0xeBQwmSa3q2cVkmQdUdMT6eU8MCzpezK+EHdatr9ll4bNTfoOzTZ1CNtNtEbWZ1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB9452.namprd11.prod.outlook.com (2603:10b6:8:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:32:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:32:54 +0000
Date: Mon, 16 Feb 2026 17:32:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 24/27] net/ice: avoid rte malloc in RSS RETA operations
Message-ID: <aZNUwqrjaOnd9mc-@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <0bc9d1c85bce4d3fcff1d95251d1756b6ba605b3.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0bc9d1c85bce4d3fcff1d95251d1756b6ba605b3.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0199.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3002fe-4012-451d-0169-08de6d816af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?acGnTP8pV8mzhEZPhLHsHJA/ISJvjK6K/NaLIuBs8bwVGSjHyQeMKOODesi4?=
 =?us-ascii?Q?dey5EnFHfMVBckgOU1FcavW4j30Qgc1CVxXcSfiUJk6rEMCFkno7xNsaS2o4?=
 =?us-ascii?Q?wnEWkXKi9V6PbvzBBTwjmHyFDelI5AeZDRjWgnGFh/PrBZs9iXbysC7l7frD?=
 =?us-ascii?Q?fTnbllZ4HI1uhATROIL8FfKtE+UIBA5WYQ8fOlB1f0jIMwmDcaXN+12kKZmZ?=
 =?us-ascii?Q?mI/q+MEB0xXEQQziu2BYIPfTDOWu9wFwJaA8C9g1GVEC7xA6FXAVru3haXG+?=
 =?us-ascii?Q?H6HkXN2DO0ZzOa60bEMeOK4xr769gHRAN4Yqc/ehRmpJl9eHfjc8OzS5Ko8r?=
 =?us-ascii?Q?/7rETyFEAQejMSc1T4soVrvuXIzpBw0BPoGI0zTYwroGSkR5JpbQmAuQci4s?=
 =?us-ascii?Q?oV4YAe/oR0WjTIjSVai1sHVIjccQNEoDuVyvHrU6ESRGE9ri7S16JOsAejf6?=
 =?us-ascii?Q?RDMYVwoSd55mSNP/lsbhA1Ys+1IXm3HS+dZOFW4Z1LVgesENnyw47h8YDXJ4?=
 =?us-ascii?Q?2XQNZBsF9ZVHOSP/FBDvHLCx0+1yLYFaPnPKrJu15zrgpfaJwmwQ1BEypbvN?=
 =?us-ascii?Q?Bb3Myfv/JFjr+yuYWNR1G/+wfbEQU1N4WmXlPSn1Hm94el3+Sx1jhx9ZVC2c?=
 =?us-ascii?Q?x4co8E4bRdSezGSwRzchJwCxlAAE1HmTxv3JGQ6rHEKakSi0KN0y0SUFNfZH?=
 =?us-ascii?Q?qujFOcM1vFVisKcdWOFBbrDPb/zdWFPY1oA+hFwJSGimGm8wx6I8frSEggE1?=
 =?us-ascii?Q?V3iR8EqhCBqBRX2FjTMpxjG87RssT8tIXtdGgJRoZ96weUEBlIha7wMYpm9C?=
 =?us-ascii?Q?6s8OqdKEF7kfFwoKhIvvNU7ogpj1PYdd8ByWDTcmXse8PBmci9Tm2z4pIFxf?=
 =?us-ascii?Q?VQzE/lxy8E7z6Un/tju/4GgYgZ7yqcC9wjw9Aj7kpi2PGkKp0RYsge0A9V1q?=
 =?us-ascii?Q?AVMF0cr7obbbcnFDXOd/BIUnkMKuNoEbiGYl001GiIyKmSb4JfW/yeaiCfzn?=
 =?us-ascii?Q?a1a2qYopp0N+NRBG+4jG7Efx1mCxMKYPON6JOlzxlSMNYpvfMHWQUi34EHC8?=
 =?us-ascii?Q?QxwGbe8AUbOCAOYV4VOKJhoFq8ajEoDrVXdLm6MZhfPbRPyDZ+jQRTgsRprZ?=
 =?us-ascii?Q?fcdK/UlDc007BgkTbgi5JH1ZqXu9pmq1nV+tH329WfxiTF+ak0EfE+dvvngL?=
 =?us-ascii?Q?kktWL4CVHgPtilx0UnIsqZfB/yEDgjD2Wv7OeZqcRBqIA2B/K+WnPOmZztEj?=
 =?us-ascii?Q?ti9ZGp89g7XMLCGn16668wDC46LmVGwmlVy/IL/csZ9yJYLnry7kUI9XSPIW?=
 =?us-ascii?Q?/47azcSFQybt47gAyho+pRDc31QixQDGDMGRYPeecWR2wmjqthG4YxJAsSrQ?=
 =?us-ascii?Q?ahjZT7zrDYXaN4pIc81JeXZIEjbDFZk8dpGFErsAf/gKiKC+PYzqOJT0fDKK?=
 =?us-ascii?Q?C5ERWSi0SqAuINyIw/ZXmTjyFvVo+6Ice8Whgb5Pyr1SKXkZ25Nh8yVquvgc?=
 =?us-ascii?Q?2QjnrwguWJBHV65SEbkPY2eXRDCwPb6sLJ66rXYftAZ/l+uUsmn1wuaxc+NN?=
 =?us-ascii?Q?NxOjkwgraMuo2Xc8YDI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ACxXVgxtbEzHYfa/VkXenJxnwWPIg1+QxPP//+bgskLZWoSSBVOVSP84RryV?=
 =?us-ascii?Q?3y46qkK6QQjpk2SvT4jAx1ztDwqmm7z3iCf+OjEmhG7EeffXNEIxOEmfAkBC?=
 =?us-ascii?Q?CURtbR+oNHcpvUd3MwfAXuwAedMO0EG3Tjp61YBVuv31JQHb5tmN5pKVtHbS?=
 =?us-ascii?Q?8UXTsaZ0e5GAurlbL9HIQMXSRBKUR2Ota+FFbVUJD5m5Io8aYUuaWAgUSSrC?=
 =?us-ascii?Q?iyQPZtCJ3LipXs6VZ8u5UWWyiNH+PEaqN0CEIhw6oevxgc1q3gZ5oUXbxOHr?=
 =?us-ascii?Q?+HZB3y1iFR7qiyp62jR7Yrxbmk7AsJJGgAWreeMr8TqlCEUwl45BDRT56cTl?=
 =?us-ascii?Q?R4tUjFgvdWzfybWvrNteJG5m6yvMLgNTHlk3FBe2vbS74oMg0y1QSUjIn7XU?=
 =?us-ascii?Q?SnZ3XGgPBp8PHArXrE3Vq+/FLXiGrvF8qkD5eUrhY4x8VET9e41pApq+dAac?=
 =?us-ascii?Q?I61/5+XawpCuIb9f1IejsU3x8GYJYKo670X3c9+FKVAzt+Ayc5SeN+5Jmw75?=
 =?us-ascii?Q?yY53g54JI27wRbJj4FUMQhAhh2ThrXRwv8pMHuMxzwC9eJ5ZXyKRLVBSAL9V?=
 =?us-ascii?Q?QEivKcEvziioxeF90cpK8UUy2nPN5rD147SfYgChXQW6ypvm0fGlySNApQ+e?=
 =?us-ascii?Q?xAZiajifgJJoUeGkkzRqpQ12iJdBpY8vyIH2uSZ8mi+h5/nM0HbkLmf6tJ/I?=
 =?us-ascii?Q?FoneOUMfYrIfGQRwzVdIoVFGGijMIsH2OZ3f2evcNc6dMlnbiL8A1PEhM2cQ?=
 =?us-ascii?Q?6NmDAYNh1WcD6lgJLCLvBuCY5rhQA2ywreUZC9a1mKBJbSvguk4GA6aJdhOn?=
 =?us-ascii?Q?gUPCcScsxoySe3ZxwEmtkG+S98Jpd4K4NvEYkCNN4nGIkvdZe6EQrEKsyiva?=
 =?us-ascii?Q?mDM3vLm/toAXj3QpHqLOKygQ5HYohuHX+ga8GEiUvu3nTTOUxW82KovsuKrg?=
 =?us-ascii?Q?C0h4D3W+JVT8d63Y6kbOa6WQ74biXX7Ua0/pkWneNcbC/AuNif24aTUpwPkb?=
 =?us-ascii?Q?/JDqGh4JOo9CHGlUtHxJ+4KVypK3QdpQRV3PLmTJRX9Q1md53iPIuXBxL48Y?=
 =?us-ascii?Q?XjMYa0/yWX4YMU42P7uAMQMsehulxjQy9LpvBGfJsIa4+cLKoCJL5tB6dVdr?=
 =?us-ascii?Q?Ng3f+IbBbNdo7YYAfcdqUOc+F8I0giy3mjF+BaGiosaOuKi5u61CLOkWirSR?=
 =?us-ascii?Q?IK/OzCmK3MzBlgtSZK+QOdOo6FPrdvH/o8mK/OiyojJU8lW6L8RiVdjdTswR?=
 =?us-ascii?Q?vC/Tq5KINCLqi2bxXMd/1QwvoC6fpLh0w9Gb6cW5Q3SIVBiRACyBGZRRuY6s?=
 =?us-ascii?Q?jCKhYsQoCcbFy2IM+zeDOAhu0+xknqExyRQoSgXTaH/ik+K/LibpmvABP/uX?=
 =?us-ascii?Q?8wYkjfQ3y1xSTdv/Nj22/4npl5kvd1ECt4Ub9h5m/hJQLMKGMI/s8fGp1Lxh?=
 =?us-ascii?Q?zyOP48nGqCkBbP6FkS/mWsw7GlH3YZSp57FanRt8OeH5gSL05L9Yv4Q6v26e?=
 =?us-ascii?Q?+/gWWwaPefD9qPMO51cUO2kXjknmQA4wWQnpUoV/3Jhrf9Hbtd8Sce6s87qA?=
 =?us-ascii?Q?gobVAEMXAfCfF8XtAvXTcPoXc1vykwBkZH0pGlCcJ3H5S0FZcs9UnaBSdjmO?=
 =?us-ascii?Q?FY5BkWZ57ViyvxVuUJmOqOv0YVgLvnrfEQbKl0kmpgn8TAZiu6RHX5MXUxqI?=
 =?us-ascii?Q?ua9/zG5kz3VkcnyNDMq4iRA/yMavRWkPB35v5VBS/q/wTMtmy13WCaxXoSMf?=
 =?us-ascii?Q?g3ZmYbllUgbaAgtOXTlqhGt7hVM+7vg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3002fe-4012-451d-0169-08de6d816af3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:32:54.6975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tAifYKKNr/YvadPv6JAF/3UYED5DRBlWykeMt+8YqjYWhiN8hfHRISTqN0VcAMR9HQx3fJgOeLFtdCeH0c5ZO865MC+1DCzH1Pn5vBFcbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9452
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

On Fri, Feb 13, 2026 at 10:26:35AM +0000, Anatoly Burakov wrote:
> Currently, when updating or querying RSS redirection table (RETA), we
> are using rte_zmalloc followed by an immediate rte_free. This is not
> needed as this memory is not being stored anywhere, so replace it with
> regular malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf_ethdev.c | 4 ++--
>  drivers/net/intel/ice/ice_ethdev.c     | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
Same comment as with the other reta changes. With or without that taken
into account:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

