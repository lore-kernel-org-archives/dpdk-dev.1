Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDABE7E36E
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 10:52:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A02540296;
	Fri,  3 Apr 2026 12:52:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 84A064028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 12:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775213576; x=1806749576;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qGYTqa+ffS/K3lrIbizi1znKH8BfbbwYjOrw8dume0U=;
 b=dazt+SbGwdM3nZWp5ytHZ5ubOi6u/0bEWPVYVwucHlmSNHtpiuNPc9gc
 /GzQdOomcjU4ojKr5BahOKeNb78EqDfprCiYX1VwRgujB2kjzyRZeyI3a
 pQCtKOuGlnnZkdA6Fr1yFEAMof+LU8OgkkfmAvtGNl7j/TsxaaDXBsnoV
 VdBLS9geXa0HWGOJiQy0p4VKMehf3jI8Rro7WVBaEpK9DPivQ0N1/YzWT
 Mq55eh/1wcrYhVP1u5SRWIRCQkDELzulVmbhZnnAnHWnfDVzUFRr6Nc/a
 vff9Uopathmcooy5+LlyPNfhQR7HwL7SZ3/Ky9CblHFuIpiNHZj/hNKXj A==;
X-CSE-ConnectionGUID: 9pO7pZNsS1ayJ5zTNCWTWQ==
X-CSE-MsgGUID: Yjc+5dAQTV2Bgzj1gLmmEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76161035"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76161035"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 03:52:55 -0700
X-CSE-ConnectionGUID: 9D4VEouWTI2rciJ0nT0CTw==
X-CSE-MsgGUID: 9mi3Pl6RTSK182J5e3/tfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="228855966"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 03:52:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:52:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 03:52:54 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:52:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8TgaVHSqn4FD1siDZiGyxWAoLfZ8+3gSahbs9WL3S7iJ8olpD/PZe/RaESSrynKMWtB57JPvg1YKdOJdGyifF8boUAPpbSSayaA+O1b7j2XGd+w9xQpveThzAARf4Tm4qqx0tAG/kZ2CgxpLGRlTm2g3bpB1YiA+CLdMW8kRfEE23ia8/KxwKPARf+te3RakhUUZEjGPQbl9oXv9cTXGVcBpHSldouB/tzM9ljmuEsZx0OR0PxZhk+mwx27BFVou5udfR4yenYjGBx/+/sSeL4xZ8atM5RJKoKqId5reW+Vs3f6DaI+3zGSraESUvsVVFTE941x5CYRCz9YXM5f2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQkylVO7T/hx/6W53a7FWRJLUUbLtD8eoOniEqGycpU=;
 b=JrdovX6jB44ZaVuBiXzRH4JEawFKceaYVkfVrTb+jZx6KzJ1FIojXMofF5riOHGHTNbaZYN6sHaO4TQDfPpDz9YaqtziJi+uHZSWkSVAChk7RPEBeE7YKGnykDOzHwEjnJSsevHIrd6SLD0EAwxUEeXMun1ZmkprElTeF0a8StxcFaluSHjaJTZnxCvSg3y5tbHC67l4IgID1iNUIx4iqPGdtkuJOW779KTOrxE83XWy+HAxr1mUg1Y0LneA0rCTMfRU/Mv+cVNt8sjqtnpcvm9HYcJ1ogaXzre7sHBr5jW9SmDcBK0FjBL3RfuUoZGhZlHhRoK7TIjSjmnUa3SV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 10:52:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 10:52:50 +0000
Date: Fri, 3 Apr 2026 11:52:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 4/8] net/iavf: rework "async" virtchnl requests
Message-ID: <ac-b_eXBoaHNMqyl@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
 <d5193c7e8c1cf6ba351409943a59a546f4dcaa7c.1772794442.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d5193c7e8c1cf6ba351409943a59a546f4dcaa7c.1772794442.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2a9449-c1bd-43bb-8cd3-08de916f2612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: rCqalB5xnkP/medJasyaPDYi8KqTkOuCPWctt9USCcggrabGHtDLCusy6k1z9YOGVKzRAFfnvAl9Mdg8wvbirx5TSJCYvRYsT9ZnuF1pLpZwSKb387w9xqdMdslGys8KkEcinGiBgDAAMe7C84HWoqiEj75nuNG3YMNNd1gi8FdwxBchqPnX0fbN7SC35eVaV7O1TLWbxZL+XZNeYeGiRVIinDc0SRGGTTZfanJaMxU1ETJJXc/bvtfUYb0nlCmwdRqb84B0X2hbla6YAoOOaxq7/64jm3ChcrGyXtoNP2C5E0LHsgjJJ8re0Qk7Yn06osZR1crzCxToBTL/IqQD7du5PMBb7yqd4eC3GEk3FphBOYe4kucdy6+/MldlDaEAWwLUqjLyvfiIz6UdTB3GlytN0GhSmIyArb+BtsMObYuHu08eF2X6QAH23Y5VdTntopV6SpljecyQ6M/YVTPWmsHw5JTkFjq5n0ueYoosa5W6RdvU5Q1sCpevH34+kYUL2MwJ54dgr1fQXGB9rDIZP3I6C4eXUgw8CRE/zLM8WW407LoBN+rK94a0oX6PjEz9tKpdBdHfnzWGGrsXg+9E1u6eFqoTCyGkG6kjCffkeW3PukWjLoyhasjmEO/GnsjZ5njU0HLNMM0hJ5QgDckFLqxxfTTuz6g3+t35T252P0wLlrfWyjiMLVdipDXmN5nOZj+TgcyD/t/ZBjBRvyNFcHMy2E3PmcWz4Z4dwfYNcvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YPjo4EE9w5sx9RnP67Mw4ehSG3SHRiIwI0B/sthdeaeFyC9ZRU7Xjz7sFjrQ?=
 =?us-ascii?Q?J0vVZGoTpFQCmIyAd8svXw8ExcW0GX09WP0EKDQw4H3QMFuoasGL+VJ+KoeY?=
 =?us-ascii?Q?UuJK+DnpJIOL0LbBrefmWFbuuUcpAXDfzmZwAv+cq0Mo1ZJuI//UfsAjaMPw?=
 =?us-ascii?Q?iFCFo8mLblb0H3TlSEJeAltFAkJrQSiKMcugwv/kkVvoX8KWhJkAjwbiYMhz?=
 =?us-ascii?Q?3auYWNiWC7Kifq1yZc5BBAoW/Ti2cvkNmNJM9s7gJvFSNjE8cbgovRCHfmtq?=
 =?us-ascii?Q?iz3a0czwkSqIKRnjpCj+rFfFKCXHGLUksCaWCWWvwKo+3mxhAoGV2w+WPByj?=
 =?us-ascii?Q?8fCBoNJ/joKqqTttNFC1xilSg2clTBM4zeCKMVz/bYHEkY4BjYN7Y2NnXRvr?=
 =?us-ascii?Q?iIjG8f+X78khuNelXvoGxCzu0CzADDyQgw3mPDlb1lAOrWzCE9TGBOdo2IXk?=
 =?us-ascii?Q?hwtAwSmD1t8znxvECeYIm+9kwU7xoXPlGOn9bqMQDc0i6/8eui6jr11+b+KI?=
 =?us-ascii?Q?spmkI8Yd+s+OBCYDq6tUDiVYxeNqyDVoxSFWq4bTnNvGz7x3gTM3ijEl1pfo?=
 =?us-ascii?Q?ZDQA6nMoAdc+Dgh3GsrUaX2mTQQ5avhDHFYRpSozmb/01jUMMwv6xEzgbUcJ?=
 =?us-ascii?Q?8EmnBzUcNDGMfq5ff5NTJnAtGkSZtid0nxXVP63z0h0LnLVluQvOs0DUdkTg?=
 =?us-ascii?Q?9J/uplCJbK/DegjX6q7NkuesgwVHededf40KqG0mq9frYrOGw4SVxOk+L0l8?=
 =?us-ascii?Q?lMBcBcGUtiWbTQWUn/2jHpEImXxdhjudTFsAS7avydRfZWTdzrdH6tONufBr?=
 =?us-ascii?Q?52zLf9RW0dagXsPKjeZ0MYeA/kYHqMy35AgcrBMTPkSAyPanegOxztyrcggw?=
 =?us-ascii?Q?213MIL5oGhpHsq8AqRWsDhQINMQA/0E4b8wTJzwf+0QS7YUTxfhNZbX3H9Do?=
 =?us-ascii?Q?M56Vw85LMcXq/I+ZNA5vO03VLcmaR03RsXv/c08964j0EIoF3iDiELW630cE?=
 =?us-ascii?Q?flcrzXyksy6m+VYPJvbb9v+y2GhkCLUGNQYBdPd2CmD5I69W4R5Q92NZWVpk?=
 =?us-ascii?Q?rjkMQEmzV+xtKW3EZCxbbrR+G+I3e6GwE3EvVpGwmOYu3032MZZ5SSEfnOR+?=
 =?us-ascii?Q?/O1hUpgQeiC3b6T5b0vDYwhGRa6SYV58Bzqhp/5XC7LmSPBq4qOd5epDucFg?=
 =?us-ascii?Q?BpoZ7AGIaYt/gB4MsA70f+Hmg8nDOjVL7yB5iDZ2UBtZbFpOsa0nmC9tGgkD?=
 =?us-ascii?Q?Qjlp7ck2CMH0RJEVZXfJ9Idv3RWM5XoXhwlNVTZIou0HNh7Ws0whPCBYdjfU?=
 =?us-ascii?Q?Rfaa9KPmMiwKqreBjIKNa/HYYK6HEgXi/hrymCK30cDOECKyVZugfZSPKN89?=
 =?us-ascii?Q?w0IeC6iQuQY88PFvOaYfEtUghAj8GEh35PMMtp9s659adTTGnJlATKryqehm?=
 =?us-ascii?Q?M1PgCHyZZ28+hDVlRdold6mmjQi503LkDaD0E3iaoB9M9sKPbsAtTbeHv2PN?=
 =?us-ascii?Q?PKFWVkv34q2oahvhjnyG8DsATcood6s2xZ2ObtY0UBKWwNIIOhEF3dvRW0wy?=
 =?us-ascii?Q?xQG/gq0dBAE0qPfmvmCGe2RA8V1U/4g0r0feJJKpOPdfjzgJB0HrxIUNIuIf?=
 =?us-ascii?Q?j5hMjj7pqKcVC4GuCKn9bfjYXBsmmwQgzIkc/RjjkU4txqJydFjxGT46Ejqu?=
 =?us-ascii?Q?EiRgbCm3EBSP4z22pJqYOxzixbBrEB+C3O5eKl7R7yFxKLhWSAt5BUHfXz12?=
 =?us-ascii?Q?xk2mH68k12KiS76liBVCpFKcG6IVPGs=3D?=
X-Exchange-RoutingPolicyChecked: ACU66QJ4yXuh0OR/rrZfvsN0taQ+PIefnJOpModywuQQJ6rGc+e4Sx8YfeIyiL6yPMjcfJJL4Ndadbyqkc1u/SVFcz1NsksqAY6KABhTZaQZvT8b3vF7r8+SUdInLn8+JxgKrtoxjS9OqmEEjRcInCXCRa8+t7LYbR5uRdH5XwcBt96ZYcBAYMczlhzoCZdnCMzq5pWYN8m9ABi92eOCxOs0Kr5VRbAEiLQf+hA2qwbpWlnzw2H1SPkT3El2Wxw0ZyH3Xn/NHemPc2um5R6A2DmJxHKjL8VxReeOh3kCpXdNqH60gzMvsUS7Me/OvJGVefBJgP+wHgJcExzcKnTgqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2a9449-c1bd-43bb-8cd3-08de916f2612
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 10:52:50.2137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zR8aXMZL8Ku832yzXhh/is/YY1cztfOILSSst2SoI2jR+gVYghzxabU/ynlE68PRHf3rRYPMwWwGjLZ8h+dgnWzfPxmnv1duaF6YCi0LH2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
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

On Fri, Mar 06, 2026 at 10:58:20AM +0000, Anatoly Burakov wrote:
> Currently, IPsec crypto requests are called with `async` parameter set to 1
> on account of these requests generating two virtchnl responses instead of
> having just one, like all other requests.
> 
> However, this terminology is misleading, because in actuality *almost all*
> virtchnl requests are asynchronously implemented; that is, almost all of
> them will send a request into virtchnl command queue, and then expect to
> receive a virtchnl response in an interrupt thread, which will update the
> global "pending command" status and write into the global response buffer,
> while the pending request will simply check pending command status on a
> timer. So, for almost all requests, the command status is updated
> asynchronously. The only times this *doesn't* happen is 1) when the
> request is sent from an interrupt thread context, or 2) when the requests
> are sent at init time and the interrupt thread isn't active yet. In both
> of those cases we directly poll the virtchnl queue for responses.
> 
> To make things a little less confusing, remove the usage of "asynchronous"
> terminology across all callsites, and instead make it explicit that what
> we're actually interested in is the number of responses we are waiting for,
> and whether the thread is meant to directly poll the message queue or wait
> for interrupt thread to update command status, not whether the requests
> are "asynchronous". We also make it an implementation detail, not part of
> the API for executing VF commands.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

One minor nit inline below.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/intel/iavf/iavf.h       |  53 --------
>  drivers/net/intel/iavf/iavf_vchnl.c | 187 ++++++++++++++++++----------
>  2 files changed, 121 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
> index cf98d12247..440376c4ca 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -432,59 +432,6 @@ struct iavf_cmd_info {
>  	uint32_t out_size;      /* buffer size for response */
>  };
>  
> -/* notify current command done. Only call in case execute
> - * _atomic_set_cmd successfully.
> - */
> -static inline void
> -_notify_cmd(struct iavf_info *vf, int msg_ret)
> -{
> -	vf->cmd_retval = msg_ret;
> -	rte_wmb();
> -	vf->pend_cmd = VIRTCHNL_OP_UNKNOWN;
> -}
> -
> -/* clear current command. Only call in case execute
> - * _atomic_set_cmd successfully.
> - */
> -static inline void
> -_clear_cmd(struct iavf_info *vf)
> -{
> -	rte_wmb();
> -	vf->pend_cmd = VIRTCHNL_OP_UNKNOWN;
> -	vf->cmd_retval = VIRTCHNL_STATUS_SUCCESS;
> -}
> -
> -/* Check there is pending cmd in execution. If none, set new command. */
> -static inline int
> -_atomic_set_cmd(struct iavf_info *vf, enum virtchnl_ops ops)
> -{
> -	enum virtchnl_ops op_unk = VIRTCHNL_OP_UNKNOWN;
> -	int ret = rte_atomic_compare_exchange_strong_explicit(&vf->pend_cmd, &op_unk, ops,
> -			rte_memory_order_acquire, rte_memory_order_acquire);
> -
> -	if (!ret)
> -		PMD_DRV_LOG(ERR, "There is incomplete cmd %d", vf->pend_cmd);
> -
> -	rte_atomic_store_explicit(&vf->pend_cmd_count, 1, rte_memory_order_relaxed);
> -
> -	return !ret;
> -}
> -
> -/* Check there is pending cmd in execution. If none, set new command. */
> -static inline int
> -_atomic_set_async_response_cmd(struct iavf_info *vf, enum virtchnl_ops ops)
> -{
> -	enum virtchnl_ops op_unk = VIRTCHNL_OP_UNKNOWN;
> -	int ret = rte_atomic_compare_exchange_strong_explicit(&vf->pend_cmd, &op_unk, ops,
> -			rte_memory_order_acquire, rte_memory_order_acquire);
> -
> -	if (!ret)
> -		PMD_DRV_LOG(ERR, "There is incomplete cmd %d", vf->pend_cmd);
> -
> -	rte_atomic_store_explicit(&vf->pend_cmd_count, 2, rte_memory_order_relaxed);
> -
> -	return !ret;
> -}
>  int iavf_check_api_version(struct iavf_adapter *adapter);
>  int iavf_get_vf_resource(struct iavf_adapter *adapter);
>  void iavf_dev_event_post(struct rte_eth_dev *dev,
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index d97bdf0dc1..d240745f5c 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -309,42 +309,97 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
>  }
>  
>  static int
> -iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args,
> -	int async)
> +iavf_set_pending_cmd(struct iavf_info *vf, enum virtchnl_ops ops,
> +		    uint32_t resp_count)
> +{
> +	enum virtchnl_ops op_unk = VIRTCHNL_OP_UNKNOWN;
> +	int ret = rte_atomic_compare_exchange_strong_explicit(&vf->pend_cmd,
> +			&op_unk, ops, rte_memory_order_acquire,
> +			rte_memory_order_acquire);
> +
> +	if (ret == 0) {
> +		PMD_DRV_LOG(ERR, "There is incomplete cmd %d", vf->pend_cmd);
> +		return -1;
> +	}
> +
> +	rte_atomic_store_explicit(&vf->pend_cmd_count, resp_count,
> +			rte_memory_order_relaxed);
> +
> +	return 0;
> +}
> +
> +static inline void
> +iavf_clear_pending_cmd(struct iavf_info *vf)
> +{
> +	rte_wmb();
> +	vf->pend_cmd = VIRTCHNL_OP_UNKNOWN;
> +	vf->cmd_retval = VIRTCHNL_STATUS_SUCCESS;
> +}
> +
> +static inline void
> +iavf_notify_pending_cmd(struct iavf_info *vf, int msg_ret)
> +{
> +	vf->cmd_retval = msg_ret;
> +	rte_wmb();
> +	vf->pend_cmd = VIRTCHNL_OP_UNKNOWN;
> +}
> +
> +static int
> +iavf_get_cmd_resp_count(enum virtchnl_ops op)
> +{
> +	switch (op) {
> +	case VIRTCHNL_OP_RESET_VF:
> +	case VIRTCHNL_OP_REQUEST_QUEUES:
> +		/* These commands trigger reset and are not waited for */
> +		return 0;
> +	case VIRTCHNL_OP_INLINE_IPSEC_CRYPTO:
> +		/* IPsec crypto commands generate two responses */
> +		return 2;
> +	default:
> +		/* All other commands generate one response */
> +		return 1;
> +	}
> +}
> +
> +static int
> +iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args)
>  {
>  	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(adapter);
>  	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
>  	enum iavf_aq_result result;
>  	enum iavf_status ret;
> +	uint32_t resp_count;
>  	int err = 0;
>  	int i = 0;
>  
>  	if (vf->vf_reset)
>  		return -EIO;
>  
> +	resp_count = iavf_get_cmd_resp_count(args->ops);
>  
> -	if (async) {
> -		if (_atomic_set_async_response_cmd(vf, args->ops))
> -			return -1;
> -	} else {
> -		if (_atomic_set_cmd(vf, args->ops))
> -			return -1;
> -	}
> +	/*
> +	 * For some commands, we are not waiting for responses because they
> +	 * produce a reset event. However, we still need to set pending command
> +	 * to avoid sending commands while another one is already in progress.
> +	 */
> +	if (iavf_set_pending_cmd(vf, args->ops, RTE_MAX(1U, resp_count)))

Nit: according to coding style this should be explicitly "!= 0" 

> +		return -1;
>  
<snip>
