Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36113CAC5B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 15:12:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C7834065E;
	Thu, 25 Sep 2025 17:12:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id AFA3040657
 for <dev@dpdk.org>; Thu, 25 Sep 2025 17:12:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758813131; x=1790349131;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3LlCii8QXFHhtwN0FXJLVJynfViv7m63xIRNsmMCKKA=;
 b=FdVdpNTOxGjL6KginOq7VxPuSSsmfZkDn9GDvopkcFcD+183MomhIWUp
 xbbuFB88KJgK8ZSiptqDTtFmO+731l1Xd4zyNBXMR80OVcjTOLD31ON18
 WbKgojGWpTP5KbNNiXQEW0616ecGhQWy7tF/OqbLomXb1gqzP4Tam5LHz
 qS4t/GXG+hCGfiyhFPd0YUUY4oKJmUQ+kN5nztiOJMYxPtvyjKv1772XO
 AHx2/FxKVObf5ukEDvGGR10Jj1ZtGQbAPkS7QM2zpbsBTLsHPudlZ04Jq
 aBlkDcevSBdSuOc2+w3cP5kcvtiMut0oPg+uehHkMAKDFwu01rWFjQ1X+ w==;
X-CSE-ConnectionGUID: 9N9iKdKAQ+6k2xIFZ/p3SA==
X-CSE-MsgGUID: sqBh7a6rTROm4p3ygMDArA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="60346716"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="60346716"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 08:12:07 -0700
X-CSE-ConnectionGUID: rURwPLs0SeqkA7YG9FQ1Wg==
X-CSE-MsgGUID: WljTcQLrSemvSeZoidK4FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="182516547"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 08:12:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 08:12:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 08:12:03 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 08:12:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBvWw4d0UGK46DtiVYqo4SYj5dKzgF3Vpiiwmdnqtqsgn8CuL0vNCIHDXzr0vblK/tzZK8WLrPHotEiVzf4v1QDrUqYsX/ZgkBLSli05IKc1LxcMlLfrUo3Qklb42aPMtNaPTn5gLvJVGGOZNwrEs+We5U9wnpszOijwpAnug8WdzVhNqvEWnh29WWiJWe0bqCNCSqDHzFaQllnaipC+2gAcoMrsWr2Zxr1wji/kSH9T52wDpEkobBMQKX7eIhl6TJ1vB+Z1pP4OgJFc9OMBp6o9tKoiY0iyFVMR1FcYdy4j+JTTD3DaJ+MVfhev+iEZBpLjCp19IPlROO749P05fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZtLNYZlhk9nmFcDTq2ypswXS4SVYgJBNjRTlIwIf14=;
 b=S8yeNMluKN6/dJQnWeYOKsunBVoTyhdH7Z9uqhHFgQFPm769VN3Bf8RhH900H2E38/WM/JhTH0UltjjtbkTPwdyhnzGauNmErtqF2007yFgd8ihJ7i7m+2B/1q8XsJh+nHqTAO/o797klyAoalM6DwWGTdR2Nse+RuOJ+5scQZ+8GFeexTBj1/l7UN19VNxJ1FUM6f8Vq6CNEcDZK9zGn3QRcjEtidZiEGQ5t4winNzpANHBPCnEEJrGw1tQDGibkWlpvqXq+i38PSE4dODoTRFWi2fNU0k73LVixZKv0Sy/9QttPIQJ1bYm5O5m+Ti1tfYfEMZgx8tyCXMvvzhKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 15:11:58 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 15:11:58 +0000
Date: Thu, 25 Sep 2025 16:11:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [RFC 6/6] intel/iavf: remove use of pthread_cancel
Message-ID: <aNVbuWzpak_gG5kP@bricha3-mobl1.ger.corp.intel.com>
References: <20250924165527.268645-1-stephen@networkplumber.org>
 <20250924165527.268645-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924165527.268645-7-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:10:234::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: e364866b-7bde-44e5-cc4b-08ddfc45de47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?esvOWVNkzDqVBf+oCc93qwMW1fJZTUsEszEpwjdfHUBozZLDvz5om2BA5Goi?=
 =?us-ascii?Q?qCckBIpK9aspJePM+lxw2B/rIDFqvquKOWrKE4Qh4gJuq2RmQU0mYqgVkkn3?=
 =?us-ascii?Q?F0t4Mc9HI+yXOHDY19FarVJueReVe8LhqC/aFA/Rq9yyfs34ufnwSqyEueYS?=
 =?us-ascii?Q?5SPbYyMb9VEVO9+PozwFTuNyEcVvY9hK8MH2y285yaAMQks5hKnvfUN0XhcF?=
 =?us-ascii?Q?v2PvSTc9QnSQlAt9p8EogzYNBkgranfBtufGGcxSTqIKgL9CjIKJ/rsJ7ak0?=
 =?us-ascii?Q?ykjDPP38cenBgof8Gg3zLseXotSOl+I8qGZFL/yqDzxEAjNH5zKk7qfWif5U?=
 =?us-ascii?Q?qEfOsNVOy2BPFvullyjKOdex83jisePgXEX14ekProWCYuAbkbzN3mD1tMv1?=
 =?us-ascii?Q?DKA7Z0yx0DxxqYo1BGSRW/v/ZyJuIMv5UVVCSEGhZuWISJ6KoxJCQFGI4ZEh?=
 =?us-ascii?Q?qFa6zFMcPpNIiMVOFBcYg8YFqM7cwjrnAHRED8lUT1l5FuzOi/urRRwCuQMm?=
 =?us-ascii?Q?a9LF2+9FrJjHetPVZ8y4w+XlrdVue/IftFPtg6aA0TP6NqpRxkvuF+bTo/rb?=
 =?us-ascii?Q?7rxTrCOgldEus4UZ0DWjDO9WXnPKQaCBkrtAvjEHD43FlcC6MbXhfmWj1D20?=
 =?us-ascii?Q?II8x5lDZjIIenfXzQhZGXe6KU77wLI6QpAp3TzMyw0ORWt0+yYZ/qh8P23QZ?=
 =?us-ascii?Q?x/ogNo/XJzs1qPCxB8YzBSaM+RGvwGHyIdjB55B+K8NbddxAWd0sDMgxpVOg?=
 =?us-ascii?Q?VzbN60ReZ+rBvPs7bECuRajQtCQaqbg5Ust/1Y1RJFDeR0NXWZO6SXm/hM+c?=
 =?us-ascii?Q?o5zSahtCfNH/kZzZJdOUyvBhk5xY6gpZvuMxNufyebbZckwB1mBxvnrG6M49?=
 =?us-ascii?Q?gtdCOsqIsuozP/z40fxM39HhoCE3iutIKa99wapH9UpS5Ms9BEmUzSxE7cEV?=
 =?us-ascii?Q?ayiv8mr/EkarScADZXEAvTCtv+54xyOqdZKruUZdk6UetVuVxkwcdN/1XRku?=
 =?us-ascii?Q?jlLJRioV6s8Y8exZyh5FjCRJkHmQmMFIcOV2FOSSggD1cu5lTXiYLrfDeVti?=
 =?us-ascii?Q?pCsX76xRjK6WpMxzlPIzV+VR2xy9YEjYEhI66dIb8n+hS5Ahr5suxAtNw7js?=
 =?us-ascii?Q?D+sDPBBprUO6Q+AtM6xAk0jgWxA1iJ9m5q81kNKTTe/TQx8ehRLO3W+69trj?=
 =?us-ascii?Q?LNo2e3GrOxXy/ar6EKDZtQfUMIuTz7qnQ3ThZfNKTnbyRLye9ueuyI3TgtUW?=
 =?us-ascii?Q?uLZO3MNNfSL2UQyKD2lWWBY0BzN4jNHLzvYYRKFjpF8fj8jEdNiq5Kolldh4?=
 =?us-ascii?Q?d1+sDo0NB6tFv4VMqiY1SaUh4r3+lrZZF0agj+dDwO0OrrlaHcoPRJIYGh5J?=
 =?us-ascii?Q?j5RjSyAAPqoxE1zlMRkOvWFIgurnr4dSPm2hs+e+KvoadXvb106ss3a7XiXj?=
 =?us-ascii?Q?32ISesmYbZeUpoTptsxvrbe877TmFygzFAdIMcFm+1oOEMcf2tTxNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8KNAxzys5zz+tc54GhoopK73Rq8jixtOm8ZYHAfAl7f3Bc7j7WxQN2+nIJH?=
 =?us-ascii?Q?Ckj5TCKiD6hoVkM7oOLh8Q13+/x6V1EmrEGIC3bMlSd2+TLARrPT65AIJI/B?=
 =?us-ascii?Q?43MaNouXDjOqJKyx8eY3EofpWGcxeCGYU64CrLHZIw+rki7UqhEjtY9lNlsW?=
 =?us-ascii?Q?uPVDphkL9gvB57+eJnTfXYm7HBXyXFWkxsUiy/ToeMXRjZYDRlmgTPH2CdfI?=
 =?us-ascii?Q?i1TadnQ5/s4ensw3OSpuKo3D4eLafBI9ytUHRuybf96RA48ZYVupxmt68Y6G?=
 =?us-ascii?Q?SaxBpKg9piUmWcgIMcU6WM2ocUmMNJLaw2fa9DG/r3r58mfd9LsAvqT0Jga3?=
 =?us-ascii?Q?AP4D6s+8ZbL+cAwlj49a8TnUWBdMX2J9IbIlOH7PrzBU2JD8Dvk1gajF2znG?=
 =?us-ascii?Q?DlVxJtQZQZ/5NN/g/9W6EiOWw4+eQmMFmuVfXQnhqvJ7t7nOIYCFJSsZzZwg?=
 =?us-ascii?Q?rBUJDmCvwVQa0C4fwRWDP5WKVZpeohSruOy8bRVenmqTDymt42d3Jn2itgfD?=
 =?us-ascii?Q?tMTHw+fA5KaAb9XgR+fnxAnzLpYX++Hvwixl3op64YlP5EGyf/f23KKPdSkt?=
 =?us-ascii?Q?fWRRmG/FzyzEBfhShwQhn780/h3Lr5UYotezozax/LQm18YnWknnTk0eeDwF?=
 =?us-ascii?Q?qYxzPfVaLk/wiOX42+AB1DlhFTqUz1KjTWjyvqfiQ/ebjN0LXsbor6mGs13Q?=
 =?us-ascii?Q?OEH7DTCp0fHdpWhHxIIsP+fJ9UmZK+MWX3jaQYg43uTlZDWz4qlzER7dhXxG?=
 =?us-ascii?Q?jiZD/D46OE4DoMgs9L1CnakFmSurEThlKd58sP9Zzm/qqTVj+TAUY5nhU/db?=
 =?us-ascii?Q?37P20VP28tRrX1QLBik0MvcEpOUplZZeH2IbLIUH6j1ffQM5Cs4YeW+UDSYz?=
 =?us-ascii?Q?iOGP9ldgqcqmXMCr1eT0SIxUVicsy9OfUl4gk/5UX0TAnwMm2YjMDYssIdi/?=
 =?us-ascii?Q?McZ6DkW4XO38xe3AtW2xQVRA8mBFpvL9cxWhCKk1kp9DXtmT8QaaHuzQ/jL0?=
 =?us-ascii?Q?xHjjKYB1woHArADkIHdA65KO0SlXDRM/NjQi781B+IUrqwO+EkniBw1TbtFT?=
 =?us-ascii?Q?UU36SpFrqxoBbQ/FzIaeCD2/xZjrwYNAFv3/7Sh/s1HvcHhF0H1FfrT29bdF?=
 =?us-ascii?Q?vII8rDf/rWbo8to5MWqxlqmGbKB937mDOfuJ0SS4PUKCrbL9Gilrvy3KiVsn?=
 =?us-ascii?Q?kaEDk7ZT4lY1us7Shn8NydfVKV8lfdFQGJtM3XG+mVjCDAZI8HDmxm0CWeF0?=
 =?us-ascii?Q?OW+mIGrwTQWJT8hfo9c4JrCCi8uVmgzn9ZW0NYe3SASZnLVCqz63Eytmxph8?=
 =?us-ascii?Q?0Zo+RkE1oplOBXTGvfuxXNyF+w9uflbwTE0GCAvNkus54HN1HVdUYIDMJiHb?=
 =?us-ascii?Q?V2jE6kiDfKSgTlxcEsMZyvT5ieHM7LLYIuchGuy5EqiOy6LoXGvPMgHn1O7c?=
 =?us-ascii?Q?zk88/uxErUvAbqrioBvK6pu72V1TpgPe0E/FsIVK045axoXHb2Sq+I2SlQa6?=
 =?us-ascii?Q?uWtFuGMdL7Iu1u0za55p0TEEtNGOY9uT9cnpD2cawplzOtcMXwLO8AmiT5/a?=
 =?us-ascii?Q?OqcMIpg15XZGC+ItvG+c8jfCQmNaqScYEHVWxPEWLYYpA1mPPUbP7/xeUIgk?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e364866b-7bde-44e5-cc4b-08ddfc45de47
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 15:11:58.1328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVxI9pA/qa5e0JngwZuSA/wFosrEaALxy2U12O74K0dY4QFGaIhoKfPH9aH3WuS+4KCjSCyZkUNQcNi+0hJPqG7+yI24zN2dMzSIncT5qU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
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

On Wed, Sep 24, 2025 at 09:51:13AM -0700, Stephen Hemminger wrote:
> The iavf driver uses a pipe to communicate with control thread.
> By closing the write side of the pipe, the main thread can
> tell the control thread to exit without use of pthread_cancel.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  drivers/net/intel/iavf/iavf_vchnl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index b1b7a5bf94..781bae11be 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -161,14 +161,14 @@ iavf_dev_event_handler_fini(void)
>  	if (rte_atomic_fetch_sub_explicit(&handler->ndev, 1, rte_memory_order_relaxed) - 1 != 0)
>  		return;
>  
> -	int unused = pthread_cancel((pthread_t)handler->tid.opaque_id);
> -	RTE_SET_USED(unused);
> -	close(handler->fd[0]);
> +	/* closing the write side of the pipe will cause read() to return 0 in thread */
>  	close(handler->fd[1]);
> -	handler->fd[0] = -1;
>  	handler->fd[1] = -1;
>  
>  	rte_thread_join(handler->tid, NULL);
> +	close(handler->fd[0]);
> +	handler->fd[0] = -1;
> +
>  	pthread_mutex_destroy(&handler->lock);
>  
>  	struct iavf_event_element *pos, *save_next;
> -- 
> 2.47.3
> 
