Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E1FC88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:47:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3CF540269;
	Fri, 11 Sep 2026 11:47:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by mails.dpdk.org (Postfix) with ESMTP id 9B9EC40264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120043; x=1820656043;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vJHQ7sSt5LoXSCGBV8AmTBVaDjeCXog+W79O2iQX0CY=;
 b=CTDVMN1Vay6TwlOuTrXfdaLaobaDFqcdEEjsaSJzmSytDRwHjVZrVlci
 SDBq5EvNvfGMznD13tysdJYdorJnsvXutqGyopAwoxMVX/UO+BgpuLqXc
 s5mPTbjwxu/VGgC5Twa9Q2VDQX9gEYYJVURX+r+dP2OUVfaJzzquzbtTt
 yItYKL6T+3XELjk/zlwh8V+Bkog68YlvHDEjeD54l0S6GYvVcHtcGm19q
 rp99QSvMOfRxZXUaYwers0MBpxQMWMTcWyYJDj0cTvsmiyGE7PCSAEQZG
 r2uAEtZxLUj7XOWpszhO/IkFRhzmOnjtnczPoBXppprkzNd3GLBCIr6zf A==;
X-CSE-ConnectionGUID: 4tZ4iCV/RcKBxcYmu7jnVw==
X-CSE-MsgGUID: g8jZLrmqSUWfMYodQS+aLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="91941"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="91941"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:47:21 -0700
X-CSE-ConnectionGUID: YBcgCbaaS0eAK/ncxncoNQ==
X-CSE-MsgGUID: aJGDohAhTlK5cqgA/4T/3Q==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:47:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:47:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:47:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJtV6syGb4Zt2h9aBvcUbXFYGjqT66Kk4wsCZWQykLm9RrSU7xN6l0U2qkIhXvnVEx+bnpziAX8lYBvGTASCWKN9SYukz+4WMtmDvh72M90dGB9v9J79Vpo8YLuotUXmCLkr5byGEyZOjEYIy/W1agMtrIz2dzSgLnBax2GI/t+1/RYt64a/ZPhS9TPj+azLd82PfXOQ9eE3RKDRBw65qcmT1uPqeu5IKXzGxkAQY/CL7aAKfAMP7INFdNRgqLbmQKlDaIj2PyOB4L+znEXaWXXg4MabH+zLZ2pePSOCYpeglistiCodnWn6NxBDNBn0MhIyl7VS4yifG4WpIA6o2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2p9DkQ+0+Lg6mCzDjYdeJTuCrcy2qI78MHWnIWX1r4=;
 b=AIRvwfvqWk/5bUTtyu2DNRt5VJyzakUpz+Lwj0Q0n1fx1/WlnlsbfWDmY1e8YpK5A2/1r81MURuP5ZmtX1XMz4yM7hqRxVIemRO5/3cIuGAdQtQuvKHEzgas5hMC37OyJxXUiQSFeZEirBzH1zl4fm8XdcPzmdEUOdrLz5Y/5QORLxei9iMgMURzwSdrwOB4SmUZ4vZPLnaicfOsxP4J1EX/y5G4veR10zyrMojzKwiBwuwMt/1z3SK2fU9dtOmIa2ljK2mA2c3knRbY3b7f3d8x9/ZtKRctUZovqSkoXscLFRKVV0re8QZDZmoprVrIZSIlmsdezEYpCZ7ZRk3NKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV2PR11MB261624.namprd11.prod.outlook.com (2603:10b6:408:413::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:47:13 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:47:13 +0000
Date: Fri, 11 Sep 2026 10:47:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 54/68] net/ice: use memcpy for fixed size data
Message-ID: <aqPOHN4hxALo_PfZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-55-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-55-stephen@networkplumber.org>
X-ClientProxiedBy: DUZP191CA0068.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::29) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV2PR11MB261624:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f89e2e-46e1-40ac-680d-08df0fe9a80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8GZP08ruarEmXqXwr4Xh2UdzeHSMHjTbE2IkNJfhposQ2irLdqSzu1CiQdXb9wdiRYf7rMkioSAIEoHiYZ0cjTFTZEqFtrYLH1BL/lsG1O/8mBT1VT4+3gqDSxk+miA0tl2negZPTtggLTvAF9cwyq50fMQQIsopJD7eSn2b7oSDaXJSyaMeeNty+FB1V1MFknCsUYQry6KC4yxUk8LlpyvQLPAQ9dAEy8HyKYo400Eu30NOOc3U67UTDTAMWbAIBZCQpIv7uWa0sgPFNikSoiNkt/1DVCVsi9+up2bpPBkw6S+wa2xJUyqrP10SvghExQcbFZKJlnMaHIM7joj1w72dY8zkWO/OczOsDuGoqos0M6RkzljjKYt8n8SMuPPiLB60Uzgdgoxbs7XS+DSU+w97Xnrfl5QVCsCSqNtNUQcQE2SAh6KF07tPT1TSR5xIbSwoP0nu9xudL0WerwKPcO3PPoJW/nEG+N8I9J/m6IRIcgzLjHiuPYV38QdKuUo0R6CWvXDtGxa3PNRJcgla385Hf4f9faN5pwr1emD53c72R/dnvqkYoJaORteRihjQmrrz6yLuhZ7LUk2iw/m23DMnk4MzWbnVJUhY7DxqCULdpqP9Axgdtz4R9h2lzUe0A0Lu9KdFUEPElLegHTRxBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ECC4ZGB9u7yilxkoM/aQ1a3L8s3z57AU5SrfK+28DQV0G6eJfiU9J5iSvwCN?=
 =?us-ascii?Q?XWhnBqCw2SfpYIlt8iDU3z3gyqfQqnD9btBbdfDg7dMqgUx0L1Bw4dRpaWKa?=
 =?us-ascii?Q?n030uDSCdsa+itO039K5bdv0FuB3Jb+YN42ENOHYn/40o+33jm6HR1AUIXCW?=
 =?us-ascii?Q?MLMvBI+70WTQYOYJD/srrFNid0p6V0FTEx3V3owqjegLvJB3p+yPlUiq30tJ?=
 =?us-ascii?Q?UG1T/+mjc8S1Zp98SKIuxcS0DeE+K9kmOnEEWaXxNXjfMkOMJsRgR4APm0Hz?=
 =?us-ascii?Q?i3Z6PqaYEK4FV5hnX3Ib6BWos74D9DrHzalwjSkB+QmhcOtTC5oao7uVed6F?=
 =?us-ascii?Q?nGSi7cqRCKp6AjXfUM2L55ab4U9jghYSDTYYU1tYumzzK/OXF8kgT/prpcjn?=
 =?us-ascii?Q?47TsFUB0GGATeUI2CP6ZyCjWiqhVkHjJf35wIgZopvRgC075az+71Hq4at4m?=
 =?us-ascii?Q?bKhZ778UIeTmkakSmfGGtjk7ZQ/I+7dcqNEzGuzNmEKcyLP28BHZNHGquDND?=
 =?us-ascii?Q?2rTrfESc/7K0wXH1N5aCZwRTUrJEh3UCdMFfqrkAphcOQ88ka5bchN9L475X?=
 =?us-ascii?Q?8g6GslKoHI5yFqxY/8PdDzKV/2h/sVCmeSpm6CBqYdpvrIpw1DtxixL4V4xI?=
 =?us-ascii?Q?qFbtqOjZ+g+6VJOtNgC3vMltyfW6pmtuwtELcfQ5Q890tFF8eVJWhwqH9kMQ?=
 =?us-ascii?Q?vPlNIMMXgBXX26ua1b6X7pM+SORxQrpgB2SR9REuUc96BfadM09Fw1xCFhl0?=
 =?us-ascii?Q?364Cc8IUVoAwh057ycDnFWCTgrZTWvN/Gq5/uqyAFmeFjQjSbf5clmf2HmDE?=
 =?us-ascii?Q?zhKYJi69FF2E2vHUui3SpJPZo9R6vZa/TDHuyjHCCZQ8d+eo/2Mei2+OrSEo?=
 =?us-ascii?Q?DdNZj+Bp1jw2dt9CbueVQFDXSLabjPWKEM/WUuUhdfz8eSmjf7WVFeu5hJxP?=
 =?us-ascii?Q?jhGZSWMKR6bOVjz5hGF6Y+nHgf7QTXX9EWsbeI7i+Iz4M32OaT1mftZWpOVS?=
 =?us-ascii?Q?XS4tbIEo+d8zzv3ji7D9BkZ9401Cf2igdD+1vncL3L5lqNfQGwW1UUPrUUl/?=
 =?us-ascii?Q?l/qzRtfBPliva9fjvPg/D+0QFy0J94gVxoHRAqY+Rveo5HNidGZocZ5YLPQR?=
 =?us-ascii?Q?r2IiwHW0FdlTG6VabeKVtr8UXcHaqg3CYo/trVUDgA+kI45uHvcUHqm8eEzi?=
 =?us-ascii?Q?aluH+7xRkdnYygi86CqPIic3FQ1BfUwkTp2F2ai/XiuCvZAFAQATOBi8LW4K?=
 =?us-ascii?Q?JPRYW4wy0doCbKgv4g+ibRlo/Rj67I3BPoKZin4RHiLFGFu5jFfdpnn6j2wS?=
 =?us-ascii?Q?mEKjeL0/n2jVMn/B0pyvN4FyGnZsomlyad6MxT7DN403vQh0lbswBoZKdae0?=
 =?us-ascii?Q?9blZ00LibauiPnY4vL3nmIKW6tRUxLHV72uZdBNRH2EZIMFCmslmc8e+vBPy?=
 =?us-ascii?Q?yJJrn6c6inzwQoZl8MVMa0TePPH3Msm6mem/cYljPU/Rg02lex80hMc20kMl?=
 =?us-ascii?Q?lvl+kdvk1EgTV1Hbu5gxaY9rP+WfuXOn3Pw5JH9J3k+KvoTT2sfSo+hzRqxU?=
 =?us-ascii?Q?RhL6IqfiZOManVox2Cw6xm9LdCDtq1CkAKrSX+EwzhHK6aK46Ugyuo9AovBh?=
 =?us-ascii?Q?Eb5JsAxUF54z6/dnEeK6Pzkswj/hNH4Cnmlj2mqSv0t9bOXif9inmpH/e2Em?=
 =?us-ascii?Q?aagxnqM6lyorjy/C/DSRkC1nuVu98Dtfosw09vW6E4UpFGQcvoQBg5VaY5ei?=
 =?us-ascii?Q?MMF88DHYY0ofGzLOplCrZXozn7CKObo=3D?=
X-Exchange-RoutingPolicyChecked: Z+t61OxvcGa0kvXayLVA5lzr6f/9PzRCkMSGKJjv2FAIiYDdyECS05nF8rNU6gp49OFnCgMxtWnYc3rJtcnPc/wzypOjy+heni+lvbirSWP2Jg8ILte8ehQSFRMeqpFA8pv+89e66v3dfDINIF651K+CBgcAJ3jjuIsxZiXXJ6IG8dg2BMh3W4moZ94RrmXKcnEdYjMED9K9RtM953d5RbCxHxscHyllaV5ksFP1iSGwUzbwXPHrEDw4QiREY5uuwZpBOiMmq2PQZWsbNXDFoXDetuuvZdnfof2+msniAesiGaWsXMbrzNtjXBwZ4dor5sTNdY9fgPWDD7KxDutoww==
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f89e2e-46e1-40ac-680d-08df0fe9a80a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:47:13.3355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+2IVtUZgWr2v91K0f/6aEABiom4tTizxarJotxR0TL4qxxP/GnnURNQO1Ma/m/aUfiYkGzmgrs7i9fqa2UE8wDrDgwzjwV1JAJykcUIjtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB261624
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

On Fri, Aug 21, 2026 at 12:24:49PM -0700, Stephen Hemminger wrote:
> The regular libc memcpy is inline for fix sizes and has
> better analysis coverage.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  drivers/net/intel/ice/ice_fdir_filter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
> index d7ddd32f90..6d6fa04e72 100644
> --- a/drivers/net/intel/ice/ice_fdir_filter.c
> +++ b/drivers/net/intel/ice/ice_fdir_filter.c
> @@ -2873,8 +2873,8 @@ ice_fdir_parse_action(struct ice_adapter *ad,
>  			const struct rte_flow_action_count *act_count = act->conf;
>  
>  			filter->input.cnt_ena = ICE_FXD_FLTR_QW0_STAT_ENA_PKTS;
> -			rte_memcpy(&filter->act_count, act_count,
> -						sizeof(filter->act_count));
> +			memcpy(&filter->act_count, act_count,
> +			       sizeof(filter->act_count));

Since you are editing this line already, can you remove the line break and
indentation. This should all fit on a single line now.

>  			break;
>  		}
>  		default:
> -- 
> 2.53.0
> 
