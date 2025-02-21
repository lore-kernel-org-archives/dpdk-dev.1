Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508F7C021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 14:33:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2812F402CC;
	Fri, 21 Feb 2025 15:33:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4A7B3402BB;
 Fri, 21 Feb 2025 15:33:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740148429; x=1771684429;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HHg6xz75i6M8zT1WEuRiliHP9yxNdmQ+lQtZHhlNxyM=;
 b=lSRbYjSoueGkgWMWnt75PRxdPFKVib2S+t/gbBXEODjh8fxOq9mHjvRh
 DFGc1zT7GgnGaXC0wSosS1284JXfno+s6vyoI3zETHKf5t35u4AN2CtPQ
 fiVfB2swEgkLPlEhmpvQHTTnm9ttUrEeNl46qbB56BjFS6i1wSwTUIvw8
 FXXoSJkfCCjreNpX0EcTjY/41PN6DisWS2y1iQ+jEzaxzTx5jFbMsI1og
 7yuBw6dPtrz8+Pijprg+SzZvhRCXz4BN0m9y024DgR1KHkKwK29CJK6Fy
 vanItWJchcaX+zAyKnxxNyfLwZ/rQBEEouZloVo2i4YcJONlCuBhGcWqI g==;
X-CSE-ConnectionGUID: UVUBhKc/RLOUvePnQmaQ0Q==
X-CSE-MsgGUID: Qy6lydIcRKm12yiOfMYM/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="63441103"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="63441103"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 06:33:48 -0800
X-CSE-ConnectionGUID: 5wtckeS3TEGshUnbIL2RLw==
X-CSE-MsgGUID: GC++m4ZPQqytoJ7/fzYOZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115887232"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Feb 2025 06:33:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 06:33:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 06:33:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 06:33:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM5aMOTomEkW5XQcMEyQAFn823zOw6Xyev7W0VKgdGpKtBnI2fOyUKt6IqhZCREdCNoL1wfL7ZR46zqnpMSw0t9GjMptux5UX5pCB7fK8jzCS2hvL2FXttWykDk5gIi9+ps3Y4ZZ+qeyk37jPrsFbIEMwnuYLSO3Q/znUYeGVdc7aDNeyWJpEhk/91HMRJDx1e7W5++qYnHvPnbHkhRf+TBuzx6X7eKHZ8k+xf/V7t734NbpKZuIlCaV9gNE/QgZZSBLuP3Pr3k9j6iSFpR9iFKOnO0ZhYEWZHbGe47Q2nw/8yrTk/p0xarHVi5I7M7IK9YNPEE1BTijCE31VF+sxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxDOthaiUZuhN/vYkppuRIza6ta8VRz6htACxeCS7TA=;
 b=xvFuPWEDtTTC394g+0njPNiGokDIab5L/76iE1kkyKyZ4vNI0/PQcI0ALa6bw4RLHg6PUvfRKe/fklMD/bX/75XPmzzSto5yjVsRch3jUzvv8f+EEDC9Hy7gfFKt2vPAxKbafGPDCvfjoSWQEVEalEDps51+aav8nt3ozregR//hjA+nyeAA1TmwcDKk2NIwppYdbtS7Rn5LNMUFmKuZOHogI+IIFB0Qd0NOlWkz4vKC+daRRJS1pnNIsaSIYP3rmGyTAFBdMuhtaaWaDyTDnmr0HLj1bJhdMp3aFIj3j8A5jjqgvdqhefweOSHYAJZ8n19AI6islqkqYN5pLcEwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4727.namprd11.prod.outlook.com (2603:10b6:208:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 14:33:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 14:33:18 +0000
Date: Fri, 21 Feb 2025 14:33:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/ixgbe: fix min Rx/Tx descriptors
Message-ID: <Z7iOqJgPuuFwjERg@bricha3-mobl1.ger.corp.intel.com>
References: <20250221082318.331815-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250221082318.331815-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: DB7PR05CA0037.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: 75fc0897-334d-496f-7d7f-08dd5284aec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PLus+EBbPeNRgy107unSgD/F5FwGVgv0utyUH3qALXRhq8jCCrB+n0Cq/be3?=
 =?us-ascii?Q?ru81HMCHiQQXwW5qIKsNLKgJ08EnuVUi+UuwzfdlhBm42FbPcD8B1QHnojFl?=
 =?us-ascii?Q?goh9qBjmMuHX/54HSOmq9R/0fw0sErsb2k9ZGQjW0/wDx/DCyomyLewIJ2RI?=
 =?us-ascii?Q?Z2/D8tGRvd90pcpB2W9Zm02yqoftw7smhTO0eL/AGzd9ZUabPJanU67WnTJI?=
 =?us-ascii?Q?k5e/lYdJKfNUjcIHxwooRJ+9jthj5RTjtkg5wk5P25z5FeJceUy0EW1ajJw6?=
 =?us-ascii?Q?vmfIQJBq+pMqUs6+mCCXqNcvXfhzPyiCHtth9CxmRqkzpg2yGKZ9MMOmF7IL?=
 =?us-ascii?Q?t9HV6ocnMJ1oSPHphwPl6cQd//uoFK2ELaREJk5H0ijH1RFu8qsI9HxTqe6h?=
 =?us-ascii?Q?tPC88ulws+8uJcFK9imTYu8wGKNYMAzYaXfyOnLeWuZ2mmE2qufVwGgtU5uP?=
 =?us-ascii?Q?JISxWCy4uSoBDINaHL0l+5tf77P91VyvYDyFEU8rCkUJWMSmdH9zWtmXQIZP?=
 =?us-ascii?Q?DScnMfPl1m5QXb6soy+HcN0qomAzVXDuFOnBrf+ahgZAf3jvZ/ENOQFSrMqo?=
 =?us-ascii?Q?icTE28A8UEMWOIX4jVQT7Y2lfavsGZB4EynCDwJAWDSAkwB8x26FSV2KYOmL?=
 =?us-ascii?Q?Gdn1i4i/AJYOb/podrgaJxNK/R4TVJI/mlTRIWV44Ts5ZC/2Eqd8d2jWvnwp?=
 =?us-ascii?Q?R+pYjGe9tax5GBrUnwjNE9yapX9eFhD4694mJKfTSD8LPqGep7+G2BiYVG3K?=
 =?us-ascii?Q?dwbqyDaVzCR6DG7QA5HgdqhAmc9SfqIsSqRgqoTbBAUsx/QQCDtB0Kx7rw9h?=
 =?us-ascii?Q?M4W2yBbcI1TUV1ejvp7PgxwMgvv39n/lEmLaHTsVL2V+DiK2JpZCtqHSrcuf?=
 =?us-ascii?Q?lM5zpWsbIQczVDbbB3ztaO1LgGWt7UG+GRG2r9XJvPwsWj+i2KmBlguHFFm5?=
 =?us-ascii?Q?a1Pu/q2x2FtTCd6xz/BchqQkSbaKu20aHsdpwFrv68ShYUscvFXWtKMKFT62?=
 =?us-ascii?Q?0E5YIhat7TwbEvC9MFiLFYFhnJNW/UGCj1LH12IYa/kbrH7B7h054uRHlfXj?=
 =?us-ascii?Q?7vQxTd0BsGeSeuD69DvetRHJz12lWDyhnYXkbS1g74cslcqbw/NMsi/+27vx?=
 =?us-ascii?Q?XjBFDnPCPL7GIoSVdkWec53e7dfS3Lb4LfradtTgPP0u00q3EPSp3qW5M+S2?=
 =?us-ascii?Q?thuFkCKAFnWSQZdNTk4BwazIIUfm7n+1j0rR3w3+jI5QJVGlJnARjVNmCr67?=
 =?us-ascii?Q?+LgQamFHdtjqGr1gLnDJluCN3/dQTolxFiXOB8n/s/VPPR8/hvk7LoLuNH3G?=
 =?us-ascii?Q?WATdFeROy0Hc3XSo5B2bYzjZXHwQSEK2Ygq8g7W4bQAKzgsaT2kyiX19cXIc?=
 =?us-ascii?Q?aFDP0xm9HhWg5g5xppx5qBUC4A21?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sZaYep4K6K9F8LiwIx/5f53tIpFV/4p+Wy/+ikMbwcHCPcoO8AR12AQG5ORB?=
 =?us-ascii?Q?2WckZs6bi5Y84FjCW8b7AXpakhAt02Luit//LSy2F4yl5H91g+f/EWH9EPcj?=
 =?us-ascii?Q?CAYokYmqLkZBF6bVnXNPQAKNAx4MfLf174t83Qgf7WQGQVBYc5Bc2BtY8Amd?=
 =?us-ascii?Q?NyVNYYJQ4AkrGM9mHzwnVSx7I0nAoWSWM0646YobAPSh2EpL416CEk2dAu1S?=
 =?us-ascii?Q?2SDK/0VZZyON9ecOzDxv+ZXV/+RDhZ5USFf+O4haBkt/7KyOn2Zee+DUJVRU?=
 =?us-ascii?Q?/XgUWeCDdaFRN+mYUT64rWlv1T5d/m7pyVd1uS4Ve51/PGdca1MRqyS8K4U1?=
 =?us-ascii?Q?SjvPMbnSh/jY/rRYBu3MlmwHQrFkl+4EmvBMWfnm0TTrpQPaBN4UtFQ9ucqs?=
 =?us-ascii?Q?Ic2v9a9f40Cj47/CWqGkLp1WdnOT/2iu8NvNFH93w3kvhCzu5bZr8yUa1Tn2?=
 =?us-ascii?Q?1tS5QyDDZSEWZX/Z3tMgzx8QxbYRdI/Sj0wRF0LoWkTbIqBeK/faK9B9kgE9?=
 =?us-ascii?Q?xb9/mUQlkt+rMRlcRScT4GC6Dww3ZZNvpAQYRi2qaBRJBXNqvMctPmK72DEM?=
 =?us-ascii?Q?eojOm6/SMNB5RbB8FyGW/1TPNoVNAljmUIyNi2ACZyAZtusZLVU6km9u2LmU?=
 =?us-ascii?Q?J2o9+Mb1xcXYPkCikyUfRALqMY8ZFLpj/qBwy2D5wIEVcJOEWTlx8PIl2CDF?=
 =?us-ascii?Q?f+HarH4bPrWRVxC2EWbbZTQhJ4HFeHaIKGhwMbfRhlZ+ksWC1HgZyBYRg+vA?=
 =?us-ascii?Q?3qOfE6jf3yhctWE95yNBSVKnyM7Gx9QFcPxuLDyjNQRv29jCTBVGZEhn16+K?=
 =?us-ascii?Q?f+AG6MgBQy2l3tjV2vKzjlCWFFBsJvdPFR1PJK+Z4b0/0spqiD4n4yGoCevC?=
 =?us-ascii?Q?NaR6LbmjoHGDCkPdty1f8iB5FV8Xpd3Ymhy6HPa70Jk0jupoX16zmCVC1jO3?=
 =?us-ascii?Q?FMzXyRyIGQ+MWOYznIQbq89S/3OkGv432fFYYgw6QI5peRL0qtgAzh+ijiRA?=
 =?us-ascii?Q?tfVSMZumyWBz2IuS0yudsxN4OyylZ195m34721ZYYjfEOWEALbMHrXeLm1UY?=
 =?us-ascii?Q?V5ymI+1OMFF769+PiSvwkXjBLD8TdXxF9j2VqQvoFGZJevwJeiNHoElBA95I?=
 =?us-ascii?Q?eLi+Kw07oGWfiSTbLTT4EbGNAB6DMW1hHpXhUBsayyDCSnjYnSKqUHiHSyqA?=
 =?us-ascii?Q?wtq4shhoYpsLerxpKvpnNChsMC6ZuRvczr0aZXSVepWtErLTc6n0S8bZ7y8N?=
 =?us-ascii?Q?+nAGQKuCcqWPaFKJ+aDdW19k8sHxrdrA7a5ZaUsXbxMFfKs/9qqk37GMqzcM?=
 =?us-ascii?Q?oeU1bDa/+ArTTxAK9wRv2ziZLSXG0dO8f0uGcpzoZjPVkr2hUXlFtpzaT+N2?=
 =?us-ascii?Q?BZUf+L5rfvCQatamIYiDBq3ssZhiQnHJccMmBNzeaRL7K8IZLdHhDpYQ1iGD?=
 =?us-ascii?Q?RJuMy/SDlPmKNgddvfb/eD+erm3cLw+taLo4ltgjKcBgdBC0G1xgvqMOvJ2K?=
 =?us-ascii?Q?DJdecCD9wAw8nNlmX5AdD+EHelshAp16HMFYKheu2URYVrrBk8FOeq+SwN10?=
 =?us-ascii?Q?3UAkDzCoDjYG8pg6CHZoJaXeaMczP/s8ghTBhj7r7BedQQ6iHw78hQKw4yWl?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fc0897-334d-496f-7d7f-08dd5284aec3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:33:18.2920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFa3I4sR95MxVn9x47YQEIkbAMQHieiPXk64K0r9WPD4QNu1YTuRs+fHQyH4FpfL4BO8MDw72MwUF3FNdZVl3DCjDBWiEVeZDPFT0jukAx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4727
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

On Fri, Feb 21, 2025 at 08:23:18AM +0000, Mingjin Ye wrote:
> The minimum free packet threshold (tx_free_thresh) and the minimum RS bit
> threshold (tx_rs_thresh) both have a default value of 32. Therefore, the
> default minimum number of ring descriptors value is 64.
> 
> Fixes: dee5f1fd5fc7 ("ixgbe: get queue info and descriptor limits")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
>  doc/guides/nics/ixgbe.rst            | 2 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> index c5c6a6c34b..10a0cdd270 100644
> --- a/doc/guides/nics/ixgbe.rst
> +++ b/doc/guides/nics/ixgbe.rst
> @@ -76,7 +76,7 @@ Scattered packets are not supported in this mode.
>  If an incoming packet is greater than the maximum acceptable length of one "mbuf" data size (by default, the size is 2 KB),
>  vPMD for RX would be disabled.
>  
> -By default, IXGBE_MAX_RING_DESC is set to 8192 and RTE_PMD_IXGBE_RX_MAX_BURST is set to 32.
> +By default, IXGBE_MAX_RING_DESC is set to 8192 and RTE_PMD_IXGBE_RX_MAX_BURST is set to 64.
>  

Was this part of the patch included by mistake? The RX_MAX_BURST value is
still set to 32 in the code.

However, in terms of doc updates, I believe the text above this point is
incorrect. It states that scattered packets are not supported in vector
drivers, which is no longer correct, as we support them for vector Rx.
Similarly, I think the pre-conditions for use of burst/vector mode are
incorrect compared to what is checked in the code.

>  Windows Prerequisites and Pre-conditions
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> index 278f665108..54569c7ade 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> @@ -26,7 +26,7 @@
>   * descriptors should meet the following condition:
>   *      (num_ring_desc * sizeof(rx/tx descriptor)) % 128 == 0
>   */
> -#define	IXGBE_MIN_RING_DESC	32
> +#define	IXGBE_MIN_RING_DESC	64
>  #define	IXGBE_MAX_RING_DESC	8192
>  
>  #define RTE_PMD_IXGBE_TX_MAX_BURST 32
> -- 
> 2.25.1
> 
