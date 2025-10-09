Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B271CCCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 14:51:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93424402A0;
	Thu,  9 Oct 2025 16:51:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 449FA40267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 16:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760021487; x=1791557487;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=H3MaRUYBH0K3udHFvqjDpwmfkB1KYDogJiXBr9BvC/E=;
 b=CO7CRVMamoQYkvl335l+3OzR6VUsHUvKOQdzqh+N2C3FoWKn0uW7WB9B
 lxMnpzJ/Fg74Vv7VGmomTH+lsXUnll9nssYMnc+3tkyEQ/9EPJUMGZWua
 xIUk4Gh249j8QLBqNM0TQHS3O65Q6dRNXgDQ7Z+5X7gfbsHm6PQJsNk84
 37qxj1a48B3KOagi4dHEk2cerg71g+x1BIO7DrCAVFsxlm2p1kmCImXsA
 GTzNH8hxNaeDdGntQbezUXLCRFizsYLYzgO2Or/eqeDHAgqisgpoi+0h8
 n1IZNg9IGf5bHYr8yQ66tIKuZSU6oO4VKKx8Ln2rwtfWCiKDvL3gupxue w==;
X-CSE-ConnectionGUID: jhJssEiZTfif1Vb5Jr8fNA==
X-CSE-MsgGUID: XG4Fo/YMQmWt3/BrvHQ0mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="66086105"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="66086105"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 07:51:26 -0700
X-CSE-ConnectionGUID: 39o5P8u/QgK8kCumzpvSwA==
X-CSE-MsgGUID: XZczxkqTQDO6rLJ3iqeUNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="181144689"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 07:51:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:51:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 07:51:25 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGvI41HrjZJTV2xVbMTIjnGl4Vs7DAHI+J7hxLzM+WHC0zfdZKueloQ8CZG0B92SmTc+wmIK22+kK27SYFvSzasJmBNrOpGvFBwOE99KFyDGZh8P0aDRY29XBs89ohNc1c7LcmNt+qJss4MhGuCVhnKBmbtscLwWw8xBgOoltH5qLFxm3o6Sd6WvfT3hM1Pw9Jz4uB5nVP9KoDgTN5hj8uhYC46tZTHEXgwAzrqAJDFeq0dN5EDkUBg7WXnmGBwO0/ICaekRBse5QNmkATQ0XhfMnJ/bjx/g/a4xxJjpvmM5f5R2/nuM0Hs4sgscR5JF50Vwu3+ihXapWAmF4vhfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+2KfphfwMWwUS6kLT5+nax4g1vg6glzGASImhomS0Q=;
 b=hSflWS89ovBWym5T0qrqmM8LXQwe1dVgqudo2hW8uHQm9x0E6p+O9AlrX2AmU6em2xHbULkSTsvHfe4z/LIvOHAHwQ36sjKkFMTfN4ZnTqHGTf0LQmEcg+XVcveXUBbODJpoiXCpFAYBZjzC/0zwYdl/gQHyVHBPizDzRD5zR+cvjLNdpofyhLRaI/hB6P18gSBmnHR+TKKHIxunGAUnesLFyN4pc9wE7JalW+hK471WDXw8/HW6bn7pGsNhIPcjxvEpznZIXyDo78IoFo+8/Ov77KKAc79NhaKwwBXFax/5+veweUbsuqWHXDimwBICYl9RYO3X5mA4/hvNkLhYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9443.namprd11.prod.outlook.com (2603:10b6:208:55e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 9 Oct
 2025 14:51:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 14:51:22 +0000
Date: Thu, 9 Oct 2025 15:51:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v6 1/2] net/idpf: enable AVX2 for split queue Rx
Message-ID: <aOfL5lm2kWoHekAo@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20251003094950.2818019-1-shaiq.wani@intel.com>
 <20251003094950.2818019-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251003094950.2818019-2-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0273.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: ff496de7-7a39-4d57-556d-08de0743503d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1GIbhkFnJBDM9jE8VEXoAt01UUP9UB7DET9vZqlZY1tLWyLNOJscN/+u7bTK?=
 =?us-ascii?Q?ddNniQQSzVcC+5k/JgtkIrrar54PALBIsCs+NgetaAEftEfzG3I8IANw91UQ?=
 =?us-ascii?Q?sgr+3IuexjFz/Cycxy/tWc+UufCYIJiDPy7NBBKqa1h16bfgbNvuY1d14KQT?=
 =?us-ascii?Q?B+crSlH7AetUlJgUkFnr7g3spcaAhEMFnJ9WbDOIAC4ghiJtK/KvKtywExuG?=
 =?us-ascii?Q?wDyktIVh0VSmkahfnK++RtmjpUcLSWiOmHCpspmsWhDhym1qf00gy5anvYsF?=
 =?us-ascii?Q?/RtU//BkXSLwjB5hDSwdn9+dUg8pRRqweBMHA9FNp+Ek4jnOU1grw9aGm+wg?=
 =?us-ascii?Q?NoOgDcaUpRIDCopZdVYXnPpfFb/BOFKmK6c6AQZ/gxVQMwkn3INkv3uZY6GR?=
 =?us-ascii?Q?fzZBXuntrkL72AtxGHe8/hia8uii4TEMTOxdDQdzJBnH7z2Dooxc4ACraMfh?=
 =?us-ascii?Q?i5S+4tpHzMuWcHm8LaKAgbVyIPZ0oAqto/EOZGep0A9og76BKd1dCxtHhs2d?=
 =?us-ascii?Q?5SzwLncmCpU+6Zl9B5yG7Jdh09vzRVQ11HHagf7IPu374NIU/meY9zYG5UiK?=
 =?us-ascii?Q?SqSsEzIf0jipQl0L7m7v5A/+sR7tm+Ahu0HPE2pnY8XmLMzXH3aOaSBekYTg?=
 =?us-ascii?Q?+nz0c5wRFAA0wZ9XlbL4UtxnJ3cOw/KiHYlGMOuNDGvQy6FM4lNe4T//9SOG?=
 =?us-ascii?Q?RvR4cIcYUHrLHGMFEX3rHeKPiM/8o8Op4ABSAcIZbhv/8KyFvNxAw51IilGj?=
 =?us-ascii?Q?Pa1qc/mpMHfrJFnVQ0U1L1cgNp0f20J0pUzcynZ8utUTgzhR4VIT6h858lvI?=
 =?us-ascii?Q?y1dNtyvAoB5Q613bc1NnWp3zzfccobkW3sevX8C8PahxkHFjv+GR58ZvRtgr?=
 =?us-ascii?Q?5/h/I8NPwSNTFVZ2WCbncbhFJLJDTgoZLQgOLpiQaIwIlTXoEs3tTm7qB/Vs?=
 =?us-ascii?Q?OugwZiM2kD2gr/8uJPCLK6Z6qLhJn6Ill4woIZUQhb1hkwriyxnB6xgm+Asq?=
 =?us-ascii?Q?qru9oUFbVRss9Hr5/I+46xKCzZwK7O7VPm2eWdC0zIe0fR9khuOP7GpuxqT0?=
 =?us-ascii?Q?J27ESh2OzJHGpkO9ey8rqzTnovviOO4OYLoptPbLGy2r3/YVLLaSpPU7GAX+?=
 =?us-ascii?Q?zrPnK3ALzGqezZGEaxaHy4jTc67sY0HtB5aJ/AQeB06U1NCwV8wwZ05RmsgE?=
 =?us-ascii?Q?VmNbj2SQPCVSW54r1jDsvbdnYwRor4Kcp9RjbAhG6silbv7N621gqVJZxPNk?=
 =?us-ascii?Q?jpvmGZuSN+o8NjIORCOxKsH4JLSrKNo0C37wX5OmnEHFlWNhtLAuMBQgbHz3?=
 =?us-ascii?Q?MvT9fhTHCFBNipdCbwbe13c01G1ZA7dajd5NDE/gt6GYEQJBcJBd6WErCEyE?=
 =?us-ascii?Q?VbOyvKVnoeemdYuC557Z/XtlaCZm23A8GBNrT/mmgnHPaWa7AAW/jdrakYr9?=
 =?us-ascii?Q?QFOPGYE5fpNAGOezdTeUDjq4S4dQO2HH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FGeedRAabRInn0aelgukI4FuUeWEeKxc93mesoJd1Za0tcsrhc44vdsU7BVv?=
 =?us-ascii?Q?uUY2GO/7X8nO8kOU4lWk4wjTVkh3Jm36b+HcvZnMhymFjlhk5OBK4eVktMK5?=
 =?us-ascii?Q?SCh2ux1BP0Zyx8hG4vLqTqsqRT8aLgaCDFd4XvJxdY9TlJrlP/FmkDG90Z0h?=
 =?us-ascii?Q?KEigEtuue9FSr5nrJlTSji+ogBd7anSiflmij/SUU/GFMzmHNSlQuIn6Hmwj?=
 =?us-ascii?Q?1yFP8bfTTLj6isBFpnu8cnfFnTiwFR2rsTdg4sJfo3bX/VoqRvpN2HRO1RIf?=
 =?us-ascii?Q?oz8h6hLiqfndLEEwUzqMnInBO/j8r86IcI0QC4QO7uMa6D//JkTaS/T02HlG?=
 =?us-ascii?Q?1WnWM/FY0tQj1tRkn1jCJYoQt+ht3c83KsLKov0uQ5IROYxZ5F7SyiCPABB4?=
 =?us-ascii?Q?tQVRf8oOBWsckZh8DO/MYiKB167GBPoXC+hLitsF9/uXClOtrzpEW4H5MXiX?=
 =?us-ascii?Q?Dq6TVxhK21sV1PHWlfYv2XcVEv9y19d/F+MPrzRxOPoKtP6ieEdO54sh5mqy?=
 =?us-ascii?Q?abCXZSscEQ4WOdU43Z97vX8OxBRLoWLLXXlMwZXbJgHu7QVzSjm2KmZ9UeHy?=
 =?us-ascii?Q?jXvyaMLy/qe2tczrr2QT81RXHtfBkYZe0BMNL+cBFEfbRThvSo1qaovkpMvQ?=
 =?us-ascii?Q?WaVpuQGN78erJFcCPBMDxtCWajCqqb/yBH1w9KkUWs1Y0LPFybpj7h7Je+QI?=
 =?us-ascii?Q?dNGOEzQG1bexnS2vLS8B6sj3F6ztfgYOWYnpmuIlo72IE+ejlgUYxgT5jboG?=
 =?us-ascii?Q?wFe1PfpnFU51nB+CbvVT9duQgpfmDS1tuhIBYHGGwAO2MNT4KDrmrisYnw2R?=
 =?us-ascii?Q?3sNxgIvdvKnCUKq/SRowA9H00ftqIsPccfY/Jv0pcsJqTGVLz5hnCJldi7zK?=
 =?us-ascii?Q?zLX4SUv4+PMy3LTQ+ADGkwsgpy1sr9nfKZ4M7y4e9WwJ6pf3jaCDUM9ZAdt6?=
 =?us-ascii?Q?TAvTcnBY3yOXhQDpMOdd6ZD7Hz/hDf9gMyxBGzcZVQonfWJK6+iE43e3nGNI?=
 =?us-ascii?Q?Xhs79jSc/IJQbJlcb+xoBAs2IMFl6WoecgecjQurmWKEeVW+h1zm1PAERHzH?=
 =?us-ascii?Q?v/TKMpX5UI0zL7KQBedcPzBt6nC8J/YmR2dAWAo7XOHgMdT9wO3E4grJdDX8?=
 =?us-ascii?Q?6qqaGAPCVJzHBE/7wNzW9kC4UepfayLyx4/27tk4RkUQVcIqhqtpa5H1vpEd?=
 =?us-ascii?Q?ghqzqkjPrFP1hkHhzgd4Q3DTvTjZpWQzqA52RVpBBX9vcqpHnlG/2Ik2X4cK?=
 =?us-ascii?Q?K1SNNCvZU6RV35PAdTwqzYjybNEPx6SPhX+e9AafQubvMog+IyGpqox1INmk?=
 =?us-ascii?Q?Mkkl/vKWo0lFHl+yv026Ik1smV+FuUrzzVhiuzx/apvjBNjgAGdWLD8FHfLI?=
 =?us-ascii?Q?pFU3m4WbeS6DsydkPntGR3ZgXqdZJr0cxfPOEpoapn8NVm0hsqFhTHYk1PGy?=
 =?us-ascii?Q?LP1qab32XvFmzYTYgJjrHWZmUXZBqwfbrq/xE1GwfTBh24ufDg7/qxxKc+CM?=
 =?us-ascii?Q?C10rV71FHVojNFVhHDBBqeggGcHZWEMF5zf9ruHy1rpZFiDW7Ff2f+pJFRCW?=
 =?us-ascii?Q?mnoYVkcZIXN6NZTTBHmpTd6eLFIcrJmdvlfjjC7QJdSLvZAPk9N1By2TZE4W?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff496de7-7a39-4d57-556d-08de0743503d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:51:22.6924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBbi2PHiAtkcUtwi5UhjAnvTvgnHT/ODbgJGFS+wJnTOOUA8uVZfcG1Ox0DceX80ry+DGKVpO7KkdunxUZQuT8KC67TBwrTEmleuZxy6TDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9443
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

On Fri, Oct 03, 2025 at 03:19:49PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Review comments inline below.

/Bruce

>  drivers/net/intel/idpf/idpf_common_device.h   |   1 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 +++++++
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |   5 +
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 160 ++++++++++++++++++
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ------
>  5 files changed, 225 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index 3b95d519c6..ed459e6f54 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -49,6 +49,7 @@ enum idpf_rx_func_type {
>  	IDPF_RX_SINGLEQ,
>  	IDPF_RX_SINGLEQ_SCATTERED,
>  	IDPF_RX_SINGLEQ_AVX2,
> +	IDPF_RX_AVX2,
>  	IDPF_RX_AVX512,
>  	IDPF_RX_SINGLQ_AVX512,
>  	IDPF_RX_MAX
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index a2b8c372d6..0d386b7db0 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -250,6 +250,58 @@ idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
>  	cq->expected_gen_id = 1;
>  }
>  
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_splitq_rearm_common)
> +void
> +idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
> +{
> +	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
> +	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
> +	uint16_t rx_id;
> +	int i;
> +
> +	rxdp += rx_bufq->rxrearm_start;
> +
> +	/* Pull 'n' more MBUFs into the software ring */
> +	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
> +			(void *)rxp, IDPF_RXQ_REARM_THRESH) < 0) {
> +		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
> +				rx_bufq->nb_rx_desc) {
> +			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
> +				rxp[i] = &rx_bufq->fake_mbuf;
> +				rxdp[i] = (union virtchnl2_rx_buf_desc){0};
> +			}
> +		}
> +		rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
> +			IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
> +		return;
> +	}
> +
> +	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
> +	for (i = 0; i < IDPF_RXQ_REARM_THRESH;
> +			i += 8, rxp += 8, rxdp += 8) {
> +		rxdp[0].split_rd.pkt_addr = rxp[0]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[1].split_rd.pkt_addr = rxp[1]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[2].split_rd.pkt_addr = rxp[2]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[3].split_rd.pkt_addr = rxp[3]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[4].split_rd.pkt_addr = rxp[4]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[5].split_rd.pkt_addr = rxp[5]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[6].split_rd.pkt_addr = rxp[6]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[7].split_rd.pkt_addr = rxp[7]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +	}
> +
> +	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
> +	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
> +		rx_bufq->rxrearm_start = 0;
> +
> +	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
> +
> +	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
> +			     (rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
> +
> +	/* Update the tail pointer on the NIC */
> +	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
> +}
> +
>  RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_tx_queue_reset)
>  void
>  idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
> @@ -1656,6 +1708,13 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
>  			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_256,
>  			.extra.single_queue = true}},
> +	[IDPF_RX_AVX2] = {
> +	    .pkt_burst = idpf_dp_splitq_recv_pkts_avx2,
> +	    .info = "Split AVX2 Vector",
> +	    .features = {
> +			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_256,
> +	       }},
>  #ifdef CC_AVX512_SUPPORT
>  	[IDPF_RX_AVX512] = {
>  		.pkt_burst = idpf_dp_splitq_recv_pkts_avx512,
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index 3bc3323af4..87f6895c4c 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -203,6 +203,8 @@ void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
>  __rte_internal
>  void idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq);
>  __rte_internal
> +void idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq);
> +__rte_internal
>  void idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq);
>  __rte_internal
>  void idpf_qc_rx_queue_release(void *rxq);
> @@ -252,6 +254,9 @@ __rte_internal
>  uint16_t idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
>  					 uint16_t nb_pkts);
>  __rte_internal
> +uint16_t idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts,
> +				     uint16_t nb_pkts);
> +__rte_internal
>  uint16_t idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  			  uint16_t nb_pkts);
>  __rte_internal
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index 21c8f79254..ae10ca981f 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -482,6 +482,166 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
>  	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
>  }
>  
> +uint16_t
> +idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
> +{
> +	struct idpf_rx_queue *queue = (struct idpf_rx_queue *)rxq;
> +	const uint32_t *ptype_tbl = queue->adapter->ptype_tbl;
> +	struct rte_mbuf **sw_ring = &queue->bufq2->sw_ring[queue->rx_tail];
> +	volatile union virtchnl2_rx_desc *rxdp =
> +		(volatile union virtchnl2_rx_desc *)queue->rx_ring + queue->rx_tail;
> +	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0, queue->mbuf_initializer);
> +
> +	rte_prefetch0(rxdp);
> +	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, 4); /* 4 desc per AVX2 iteration */
> +
> +	if (queue->bufq2->rxrearm_nb > IDPF_RXQ_REARM_THRESH)
> +		idpf_splitq_rearm_common(queue->bufq2);
> +
> +	/* head gen check */
> +	uint64_t head_gen = rxdp->flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +	if (((head_gen >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) != queue->expected_gen_id)
> +		return 0;
> +
> +	uint16_t received = 0;
> +
> +	/* Shuffle mask: picks fields from each 16-byte descriptor pair into the
> +	 * layout that will be merged into mbuf->rearm_data candidates.
> +	 */
> +	const __m256i shuf = _mm256_set_epi8(
> +		/* high 128 bits (desc 3 then desc 2 lanes) */
> +		(char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF, 11, 10, 5, 4,
> +		(char)0xFF, (char)0xFF, 5, 4, (char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF,
> +		/* low 128 bits (desc 1 then desc 0 lanes) */
> +		(char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF, 11, 10, 5, 4,
> +		(char)0xFF, (char)0xFF, 5, 4, (char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF

Do we really need all the (char) casts? Other drivers seem to build fine
without them.

> +	);
> +
> +	/* mask that clears the high 16 bits of packet length word */
> +	const __m256i len_mask = _mm256_set_epi32(
> +		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff,
> +		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff
> +	);

The comment doesn't seem right here anyway, not sure about the logic where
it is used. This mask when "anded" below will only clear the high 2 bits of
the 16-bit values stored at bit positions 32 through 47 of each 128-bit
value.

> +
> +	const __m256i ptype_mask = _mm256_set1_epi16(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M);
> +
> +	for (uint16_t i = 0; i < nb_pkts;
> +		 i += IDPF_VPMD_DESCS_PER_LOOP,
> +		 rxdp += IDPF_VPMD_DESCS_PER_LOOP) {
> +		/* Step 1: copy 4 mbuf pointers into rx_pkts[] */
> +#ifdef RTE_ARCH_X86_64
> +		__m256i ptrs = _mm256_loadu_si256((const __m256i *)&sw_ring[i]);
> +		_mm256_storeu_si256((__m256i *)&rx_pkts[i], ptrs);
> +#else
> +		for (int j = 0; j < IDPF_VPMD_DESCS_PER_LOOP; ++j)
> +			rx_pkts[i + j] = sw_ring[i + j];
> +#endif

Rather than having an #ifdef block, I suggest trying to just use a memcpy.
With a compile-time constant length, it should be converted by the compiler
into the most efficient AVX or SSE code possible.
	memcpy(&rx_pkts[i], &sw_ring[i], sizeof(rx_pkts[i]) * IDPF_VPMD_DESCS_PER_LOOP);

> +		/* Step 2: load four 128-bit descriptors */
> +		__m128i d0 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[0]));
> +		rte_compiler_barrier();
> +		__m128i d1 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[1]));
> +		rte_compiler_barrier();
> +		__m128i d2 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[2]));
> +		rte_compiler_barrier();
> +		__m128i d3 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[3]));
> +
> +		/* Build 256-bit descriptor-pairs */
> +		__m256i d01 = _mm256_set_m128i(d1, d0); /* low lane: d0, d1 */
> +		__m256i d23 = _mm256_set_m128i(d3, d2); /* high lane: d2, d3 */
> +
> +		/* mask off high pkt_len bits  */
> +		__m256i desc01 = _mm256_and_si256(d01, len_mask);
> +		__m256i desc23 = _mm256_and_si256(d23, len_mask);
> +
> +		/* Step 3: shuffle relevant bytes into mbuf rearm candidates */
> +		__m256i mb01 = _mm256_shuffle_epi8(desc01, shuf);
> +		__m256i mb23 = _mm256_shuffle_epi8(desc23, shuf);
> +
> +		/* Step 4: extract ptypes from descriptors and translate via table */
> +		__m256i pt01 = _mm256_and_si256(d01, ptype_mask);
> +		__m256i pt23 = _mm256_and_si256(d23, ptype_mask);
> +
> +		uint16_t ptype0 = (uint16_t)_mm256_extract_epi16(pt01, 1);
> +		uint16_t ptype1 = (uint16_t)_mm256_extract_epi16(pt01, 9);
> +		uint16_t ptype2 = (uint16_t)_mm256_extract_epi16(pt23, 1);
> +		uint16_t ptype3 = (uint16_t)_mm256_extract_epi16(pt23, 9);
> +
> +		mb01 = _mm256_insert_epi32(mb01, (int)ptype_tbl[ptype1], 2);
> +		mb01 = _mm256_insert_epi32(mb01, (int)ptype_tbl[ptype0], 0);
> +		mb23 = _mm256_insert_epi32(mb23, (int)ptype_tbl[ptype3], 2);
> +		mb23 = _mm256_insert_epi32(mb23, (int)ptype_tbl[ptype2], 0);
> +
> +		/* Step 5: build rearm vectors */
> +		__m128i mb01_lo = _mm256_castsi256_si128(mb01);
> +		__m128i mb01_hi = _mm256_extracti128_si256(mb01, 1);
> +		__m128i mb23_lo = _mm256_castsi256_si128(mb23);
> +		__m128i mb23_hi = _mm256_extracti128_si256(mb23, 1);
> +
> +		__m256i rearm0 = _mm256_permute2f128_si256(mbuf_init, _mm256_set_m128i(mb01_hi, mb01_lo), 0x20);
> +		__m256i rearm1 = _mm256_blend_epi32(mbuf_init, _mm256_set_m128i(mb01_hi, mb01_lo), 0xF0);
> +		__m256i rearm2 = _mm256_permute2f128_si256(mbuf_init, _mm256_set_m128i(mb23_hi, mb23_lo), 0x20);
> +		__m256i rearm3 = _mm256_blend_epi32(mbuf_init, _mm256_set_m128i(mb23_hi, mb23_lo), 0xF0);
> +

mm256_set_m128i(*_hi, *_lo) is doing the inverse operation of the cast and
extract you did above. Can you not therefore skip the extracts and sets,
and just use the mb01 and mb23 registers without further modification?

> +		/* Step 6: per-descriptor scalar validity checks */
> +		bool valid0 = false, valid1 = false, valid2 = false, valid3 = false;
> +		{
> +			uint64_t g0 = rxdp[0].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +			uint64_t g1 = rxdp[1].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +			uint64_t g2 = rxdp[2].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +			uint64_t g3 = rxdp[3].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +
> +			bool dd0 = (g0 & 1ULL) != 0ULL;
> +			bool dd1 = (g1 & 1ULL) != 0ULL;
> +			bool dd2 = (g2 & 1ULL) != 0ULL;
> +			bool dd3 = (g3 & 1ULL) != 0ULL;
> +
> +			uint64_t gen0 = (g0 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +			uint64_t gen1 = (g1 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +			uint64_t gen2 = (g2 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +			uint64_t gen3 = (g3 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +
> +			valid0 = dd0 && (gen0 == queue->expected_gen_id);
> +			valid1 = dd1 && (gen1 == queue->expected_gen_id);
> +			valid2 = dd2 && (gen2 == queue->expected_gen_id);
> +			valid3 = dd3 && (gen3 == queue->expected_gen_id);
> +		}
> +
> +		unsigned int mask = (valid0 ? 1U : 0U) | (valid1 ? 2U : 0U)
> +					| (valid2 ? 4U : 0U) | (valid3 ? 8U : 0U);
> +		uint16_t burst = (uint16_t)__builtin_popcount(mask);
> +
> +		/* Step 7: store rearm_data only for validated descriptors */
> +		if (valid0)
> +			_mm256_storeu_si256((__m256i *)&rx_pkts[i + 0]->rearm_data, rearm0);
> +		if (valid1)
> +			_mm256_storeu_si256((__m256i *)&rx_pkts[i + 1]->rearm_data, rearm1);
> +		if (valid2)
> +			_mm256_storeu_si256((__m256i *)&rx_pkts[i + 2]->rearm_data, rearm2);
> +		if (valid3)
> +			_mm256_storeu_si256((__m256i *)&rx_pkts[i + 3]->rearm_data, rearm3);
> +

For most of our other drivers we do a blind write of the data to avoid
branching. Is this approach here proven faster?

Also, since the descriptors are read in a forward, rather than reverse
manner, is the code subject to the race-condition issues we work around in
other drivers, where the software can see the descriptors written back
out-of-order in some cases?

> +		received += burst;
> +		if (burst != 4)
> +			break;
> +	}
> +	queue->rx_tail += received;
> +	queue->expected_gen_id ^= ((queue->rx_tail & queue->nb_rx_desc) != 0);
> +	queue->rx_tail &= (queue->nb_rx_desc - 1);
> +	if ((queue->rx_tail & 1) == 1 && received > 1) {
> +		queue->rx_tail--;
> +		received--;
> +	}
> +	queue->bufq2->rxrearm_nb += received;
> +	return received;
> +}
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx2)
> +
>  static inline void
>  idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
>  		  struct rte_mbuf *pkt, uint64_t flags)
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> index bc2cadd738..d3a161c763 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> @@ -540,62 +540,6 @@ idpf_dp_singleq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
>  	return _idpf_singleq_recv_raw_pkts_avx512(rx_queue, rx_pkts, nb_pkts);
>  }
>  
> -static __rte_always_inline void
> -idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
> -{
> -	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
> -	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
> -	uint16_t rx_id;
> -	int i;
> -
> -	rxdp += rx_bufq->rxrearm_start;
> -
> -	/* Pull 'n' more MBUFs into the software ring */
> -	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
> -				 (void *)rxp,
> -				 IDPF_RXQ_REARM_THRESH) < 0) {
> -		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
> -		    rx_bufq->nb_rx_desc) {
> -			__m128i dma_addr0;
> -
> -			dma_addr0 = _mm_setzero_si128();
> -			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
> -				rxp[i] = &rx_bufq->fake_mbuf;
> -				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]),
> -						dma_addr0);
> -			}
> -		}
> -	rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
> -			   IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
> -		return;
> -	}
> -
> -	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
> -	for (i = 0; i < IDPF_RXQ_REARM_THRESH;
> -			i += 8, rxp += 8, rxdp += 8) {
> -		rxdp[0].split_rd.pkt_addr = rxp[0]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[1].split_rd.pkt_addr = rxp[1]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[2].split_rd.pkt_addr = rxp[2]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[3].split_rd.pkt_addr = rxp[3]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[4].split_rd.pkt_addr = rxp[4]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[5].split_rd.pkt_addr = rxp[5]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[6].split_rd.pkt_addr = rxp[6]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[7].split_rd.pkt_addr = rxp[7]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -	}
> -
> -	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
> -	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
> -		rx_bufq->rxrearm_start = 0;
> -
> -	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
> -
> -	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
> -			     (rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
> -
> -	/* Update the tail pointer on the NIC */
> -	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
> -}
> -
>  static __rte_always_inline void
>  idpf_splitq_rearm(struct idpf_rx_queue *rx_bufq)
>  {
> -- 
> 2.34.1
> 
