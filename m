Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55121CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 09:31:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F73B40274;
	Wed,  7 Oct 2026 11:31:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3BD4240264
 for <dev@dpdk.org>; Wed,  7 Oct 2026 11:31:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791365513; x=1822901513;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=11cyLj/hanYks0ogLL7sH4SUD9eRhSPc9SNJHM2fzAY=;
 b=CM4pebxqU28bCSAW6xwoZbcJ3NXo43+KjwbCk7M1pQLY1ORAdSn262ir
 xsw/aGV8tya2JrTu8umtXXG5TgewP+fXUU7JwCIVGKg2pzvD07ZiMuQXg
 GAATdV5/b4/JdcZFyD8N0+lHoSYvNtDH5ctn2w3BMtAhmHiMeoh7cldpZ
 33OxBYqHq+vP5tG7+je+2fnppAr/UvH0a/pyniQtuWZkoOpbLFjks/5hT
 bCb/012SpMwABOgRgAWLd/F+dBVMqrdG/J442KJB9UO016oBwJ+fMtFRH
 KmhunPopaIXN6JkTFeZ4BogIKoXlvNGD46yJLNb4wqZ2I/7q+1WWJBBoi A==;
X-CSE-ConnectionGUID: LAVeZ74hQsqvbVq4+5R3wA==
X-CSE-MsgGUID: 0KVLzRijTv+VpNT8TiVY/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="129995"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="129995"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 02:31:52 -0700
X-CSE-ConnectionGUID: xXfJXSDZR+q5VbEKWnaMqw==
X-CSE-MsgGUID: umTZRdaESOmbRgPzLIqJgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="16825"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 02:31:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 02:31:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 02:31:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 02:31:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shvCEWgAIb095yPOgnNnRQGugxdG5hPN/55thsDN/yDcDzrZjdMOHk31XvXHBeJl5VJr0hulBfixZiWMtJ58j5B+PJQuL6/gZr2ra17A+aJSZWkq5VY2B6QK1aHPsptLMZLqrbA2RNlDSWEvslh5iLfJmCI1PI5IPfVbERfmR1biAgdKPMjhb+6k5hCqkc2uKwXCuveg38izURRSC0tHXTpALvYiwjpUHADO421knDNnvLZ0USPFudy2C+rL3tWICeEEMxz2U4EY2vuCfFT1QJmjLNTZN/IjHjdGq1JEObu7RxQwPb1Lc8arBbX19P22OXRcEmiWReVsr/iwWz0oEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjXIBw9CWrnF6agJJCTHS/koQ+zzAIFKspfjbE/YX4E=;
 b=Q+iPkZg2wt1QNFK+cQm4Sxd4xcFVKVp8WRQR1W06n0d0mqQwni47R0JXUo8QwRq/OPH05wA7ovtbh5UNLtomrhAA7/r63tzrQz86Ugj9mkAhhaI6xnR9akMX85yAVZipptbCvcCHzCtS7XvU9tAi5qzo/zZWTDRqrtxhI4MyGpVZ2bgP0NioXHZ49VJQMzK5oNWXTNjmzLziuN7QPnwvU8Uo8oC5BIarlJ8HlopiPmOR4ZpqjTfFvBOtkC/J+TwtIrIFcRiKfsWarl43QMU7VQi4YX4O20Zm3UJnZiV3qxmWu3D91p1sFZ6/Tgb0UW2yXDEp+d4PXoQbwTeGKkk6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 09:31:47 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 09:31:47 +0000
Date: Wed, 7 Oct 2026 10:31:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 0/2] net/ice: fix memory handling issues
Message-ID: <asYRf0mgWZu8sUmi@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1791356190.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1791356190.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DU7PR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH0PR11MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 7566f1b2-f4f4-4578-fad7-08df2455cef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ijegxvO0iYkyPFM7N7v5cPChBABtIDy8GFXxRHeHfz6o3Z6vDYgfLGi4uFvf7QVDTdXsUmb1bb5doEKNf/rgVhy24bByV9E63NtWAaG/u/LPT35UBPERXDhfv01cokE0QK+GbdHjdbEdQ41ky7+tqc/UOr76su0TSQO0clSMbWSl5jkVvmQ3qaFwmro31TYEsc8GOPDHKild6lizCHQI7RkKeW/1ly+uGpXmmQotTTEdWOCtIN3J+I++2r02BVLVtxCFu182TAtvv1NGRpnmW8wKsgJiWqF6pskYCH3drsKUZBo/qumppejruI2qR68fp9lYSgSK+ZvRumdwCeLICKJsU2AdsnXAmIhzNJgf9rOyEAoLyO8UHusJQacd21goTfFJOl4u+lUoycgxhfKnE2lLBE8HGgsikGiJoxRz9MD3bn/wFAXd4rJ+xWCy/qIbZfKXcjCDQ5T7hXd/xYpDcK+R+FSF2ZinO6bnL01+LiiC/GHi1wttDCH/Rbdzfle+9htenDX3HoQQIlIWOne7gILWME4G0EsLKknxbsgT+TxcOycckPo0cbreHFaO/rFsVqppsOz4BHnAO32QnXLPlOzf4v9FTtaATd1IYIiHtPiIobR3hPJfCIlP579QJqZeYHse3CXJhszaeB7NMtLEEQG3S9a0w5DgMWwSacy8/y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/nbkcDXexz3eFUukJATBFlrZBmEUmS1JahfqGHqM4aLkyWpk1ovdnWtodOy?=
 =?us-ascii?Q?U2aKrVaCYMnd/8yea9Gzuq+zIwUWczUN6tfabgG0jwLJr/9Q2RJQE3u9K4qW?=
 =?us-ascii?Q?TNE3AKfV81llw3WPkhZ5R/Ngk0jf2nItM2TZ4ST+obktanCkvpmtz7ZKmSju?=
 =?us-ascii?Q?SlB2XfbTXRCdZRnNBl+trLQa0ojp0GBvtkxhenRjxeh/kh+tBMpOe884ymun?=
 =?us-ascii?Q?ZvdjvBPYXZ1UAdbDCY2YN0HaiEVnr72YS4d+YMQtlEZr/PWi0/jb2CxSwE7C?=
 =?us-ascii?Q?3yLwnjjyR10pQVz1jbTN/Lovsh5htx8Hvtno44kzdSXxP7f4pMGLaGa8V7e1?=
 =?us-ascii?Q?7ct+L5LfZzLkVWWpEDP6HCwxIAtoIjM2fFDfGB3i14izm/PjHxvQ1VzJ7k83?=
 =?us-ascii?Q?G81eqB89PBBA9/rtgaGiWdlt8nCPuUSys2CtxbxaxbHXGUOt3ZC7DPxRFYDm?=
 =?us-ascii?Q?bjqUn5VgiXQ6xYPWKUwK8bof9V0aHLA+JA8isyPRTq2UEGYnyZaOswOBJmWz?=
 =?us-ascii?Q?ckDZvgP7mK2ivXW6worYzdHV4JEl25n3scTkyEcx+S2MhhPGBxSmAL2FBO0t?=
 =?us-ascii?Q?3UnUcldSgehzg0jNo3n1gbM8TUtByJVGwr1MWN0j4OYnxEDfZSq5jZlX3Ia7?=
 =?us-ascii?Q?ty4TixjzRDvvGS/8LmoGJNbKv9LcfHpJxX2Gkl/yc54qAJwJ2zsG0drt4v3Z?=
 =?us-ascii?Q?VK1c06w/O/SEHG+mbhc2K+JJypVChcsNLFMcs/rYXfr3KHM1B1Y7dVjtLdWH?=
 =?us-ascii?Q?N7+3GwlgSiG6YulqEiAOyt9XVIxh8EDJ3GI7+Tkxt+ZLLfNPMoOLCvgnyeqq?=
 =?us-ascii?Q?fHsdkyMAIr7mdGth/ddjoNtp4KaFZSWhqjuYYsa2dBAtL+3nRigmjI2oEBbW?=
 =?us-ascii?Q?J3zjYCOQbanLK0elbtgUA1EeKoj0pgCr8NBj/RkqwKgaDF/fkN4fmjxlKntw?=
 =?us-ascii?Q?H7O5ATUuNCYK0dkDAyki0vgc1iNA2gNFB+9lrb+rHrrqRJSQ9tiP19NwRNVD?=
 =?us-ascii?Q?IUh8+lqF21osVgqqKObbdEcILLwgGA0XpUll2oi1ahzcjCUpA9Z7r/eve+d1?=
 =?us-ascii?Q?APAFjI9kAGA9BQTFg182MtW28lCUviV8TeZZtM+7apylkWftT9ir780XHFX2?=
 =?us-ascii?Q?+TyDJCMehZNxlNTAJoMp42mJxvYkhJoycP/Cj1qNnsTufRNYcfpOLmj8LdMH?=
 =?us-ascii?Q?f6WcUhdzyUb33EqpGOeTQl26dSHwjXXS83dFb62vv3NuLam1qvtEKcjE2fQA?=
 =?us-ascii?Q?PDK8607LIcNWa9M2eJFcqIlP/Uriy6xNh1UZViev/erOWyhlo1s3KH+68uPp?=
 =?us-ascii?Q?/JUYO5VXeCoq81Z/GZ6lqqarTIly1ZYab073oEfTcaaXHEOBNOtGTL/tTQUE?=
 =?us-ascii?Q?3xHDiszVpVdoomao4d+5JaEOJ6pKH2uT2p0d3oRsmCGB9OaucshPsaOnnwQX?=
 =?us-ascii?Q?sBxOjubl7Y0HrmPpARHO/f0doQqGNUXVOyZTDjx+43hyZoEa2sjHtWW1TheR?=
 =?us-ascii?Q?+GwwVXMaT7vfwMqKPmswMgTWwU1uGIQNimqdNGrqm3VnJ6CqLNDDn4xlVEyA?=
 =?us-ascii?Q?d5t/z83Dr1a6f/RT9Z7TusuzGJ6Od+nairm3fvqtsuCAnFfkPt2b+Glulz+U?=
 =?us-ascii?Q?McLWs6oCR7155MAJRDGcHcYjjhg3OdbcfGbfDYhcopVEHQgUppYepLPahtbe?=
 =?us-ascii?Q?qNPfFR7FpIAC5dY7aGhPm1rXOmRZ8W0+85in7YE4vV6eBNAPusWdXztIpoCQ?=
 =?us-ascii?Q?EdyiJ21qdcCcxn/vJUlQq97rWxoXOO4=3D?=
X-Exchange-RoutingPolicyChecked: fOfP3yZf8At3IwDiqUMzBPHyoSgKZ31EG+wyz3baDrLhGCiZ37mYTmol3BMY7oqRtI3vRnRCPCQFOMMtBVwT9R5neICSVOqndZkCOEtVT87xxq2X7HBfXYVacUQiJblDWnjbbP30ibJSL18utHArzP1svbGLYjyELiTmOciAd33Zwjlk9JTNLIaSeFkb3RHy6ooNEVKnqhdjbz5tlHn1g4p9cPZ9wCXQhfi/SX7SQuyr0FwaYRvbjOOP2dnqGk5TPhSx/hUIyZM/AiDexrXjqX8jJCUfu4OyyGCMwvjRK5g8T/CSzhiMXeF7/sdMYC1TnC4KbbV3WwENkCIxhqjT/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7566f1b2-f4f4-4578-fad7-08df2455cef5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:31:47.5009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2z6dz0ZV1hXgTr2cTEHj3TnjKDwmTgJ0XjcP8lyi65lak0SF7KrL1NvJIxIEb2DBzigffRql9eukjp+YOxwWWySVBieICuUZgbHOKk0sQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
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

On Wed, Oct 07, 2026 at 07:58:18AM +0000, Anurag Mandal wrote:
> This patch series addresses two memory handling issues in the ice PMD.
> 
> - The first one makes memory allocation and release symmetric. 
>   Several buffers obtained through ice_malloc(), ice_calloc() 
>   or ice_memdup() were released with rte_free() instead of ice_free(). 
>   Both APIs currently map to the same underlying allocator. 
>   However, mixing them is inconsistent and would break if the OS 
>   abstraction layer ever changes.
> 
> - The second one fixes an unchecked allocation in ice_tx_queue_start() 
>   which dereferences the Tx time queue context buffer returned by 
>   ice_malloc() without NULL check.
>   On allocation failure, the E830 send-on-timestamp path therefore crashes
>   instead of reporting "No Memory" error, and also the already allocated
>   txq_elem buffer gets leaked.
> 
> Anurag Mandal (2):
>   net/ice: free memory with matching allocator
>   net/ice: fix unchecked Tx time context allocation
> 
>  drivers/net/intel/ice/ice_acl_filter.c  | 10 +++++-----
>  drivers/net/intel/ice/ice_dcf.c         |  2 +-
>  drivers/net/intel/ice/ice_dcf_parent.c  |  2 +-
>  drivers/net/intel/ice/ice_ethdev.c      | 14 +++++++-------
>  drivers/net/intel/ice/ice_fdir_filter.c | 12 ++++++------
>  drivers/net/intel/ice/ice_rxtx.c        | 22 +++++++++++++---------
>  6 files changed, 33 insertions(+), 29 deletions(-)
>
Patches applied to dpdk-next-net-intel.

Thanks,
/Bruce 
