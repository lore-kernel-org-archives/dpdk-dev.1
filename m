Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBF3CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 10:11:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 736F240262;
	Tue, 28 Oct 2025 11:11:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 981384021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 11:11:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761646306; x=1793182306;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VD1OckGgvwb2HuQ0UVhaR/oYuRkAD7PGyoUlCKGCk8k=;
 b=m459JUG2C3TyO4c97LhRl4xb2GTn0OYS8s3qO8O0g00w37+QYxA2WsGk
 zSUEUBy6mOBiJX/zVuMlXla3fYr/GK5MIxLabnfT2PTE+z/j+2uum6dZp
 0/2HkCZrk1xT67ZbjQJL1mAetcLpT78f/n3ym+APS7jNc97iDlx0oJ0GI
 0WV5mVPinKgK31UGRZn+9FS4CdXTD4nWz2OJ4tRz0csosfmzc5BUWi594
 UYAuKjj7qS0EYcpy3lNbph5lsMpgr/2SJP1Z0AHbGZAIfn56/SUFH315Y
 TpfNvIgY95VITp+Nz+BQlG7PIBJ7zf7tEE31rLPGWxE2vf5HuiStFrCgc w==;
X-CSE-ConnectionGUID: l65JzCttTT2ruK7/j4S4FQ==
X-CSE-MsgGUID: pKjf5B00QfafjCK3JRTcHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67606841"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="67606841"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 03:11:45 -0700
X-CSE-ConnectionGUID: AjT61FAlQFeGyhSEKJgo9w==
X-CSE-MsgGUID: qQIuh3nSQsK/6CZPTnbpQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="222513646"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 03:11:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 03:11:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 03:11:38 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 03:11:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaVg8ItYiHA9+eNkaqPW14e46ugTGhHr3fwkeyr91eA1caI1Fi8fKu5cI+cJeUkiDtS+mvfMI9S4CB93i8rEWyih470QaeCN1W1C/oPFbK4Qxjs6+GzRPXmd0jQgRtdy7jngoxN7sg42mzyEFh+oqbozQ33E6p7A9q0X/paC61I6DwgvkZ5iWybcOpcyOfpIBkzZXavyHQ/yVIK4jD6qxuzQ46Su08r7vIqSYx+UE05/qpQwJMM1Eqr6faS/L1eZGVrZ4xML5BzOjqzK6eFZoidS9skn2nEXP6PmNO1OuQXehp7RKsFx+sdisjqWDww0leq83mb1UgiSaOQdz53V0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZo0pvQujUD2gCNbRcfOS8ix8ZJzDe+ZQT4fVL1Jah8=;
 b=xcCiJcJ8lWcYNO88o+tCKrVLogcrb7ZkCi7hWQNRWHSOrT3q1vyXxKjhKto/V6HwahtM3yWqCtsoF9KmUL/mk94+am2n0xgCN+Eyi8VC/D1OykEleCvWoLfctRxAtOl909QSjmB/HYFIXKFHUDjcy5gVIs5F1DGzU+2YpM7++kwojWM1d2gmdqJdpA0rzsU9/91Lre3UdV2XF4ygdrdCTAmKM9Dz0th9Ef3s9yquSiqhjwtbujU+d7XHNMWwZU6Vg3xYhjftsG3wouOPA+4ZmRojMi1DCkg2Sxz7T356fHCj/VK7TH6jcsTN+jPt10aaAQ4q5WxTQnKKzpUGNBwmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 10:11:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 10:11:36 +0000
Date: Tue, 28 Oct 2025 10:11:31 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Chengwen Feng <fengchengwen@huawei.com>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>, <dev@dpdk.org>,
 <reshma.pattan@intel.com>
Subject: Re: [PATCH] app/procinfo: fix warning of deprecated coremask
Message-ID: <aQCW06IyKKZRKeR2@bricha3-mobl1.ger.corp.intel.com>
References: <20251028081733.38583-1-fengchengwen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028081733.38583-1-fengchengwen@huawei.com>
X-ClientProxiedBy: DB7PR05CA0005.eurprd05.prod.outlook.com
 (2603:10a6:10:36::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e554fad-9c30-474e-cbd3-08de160a60de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r/5aJK7ljx4XnjZJ/Ow05cPfI/cKe17F0MnnhbW9N5MQRJQn+AOT5pjG4hTt?=
 =?us-ascii?Q?xEz8LFWXlfdfHzwRWFUWYfcV+A4AKK6RQ4X6bo0bL86tYSMPsl9BmFpAUKS6?=
 =?us-ascii?Q?9edjh0eHCyZfE9waD4a3TSSw4UgaWgbEm85QRwE1EvT7Z1uX7yB4y6Dgm7Qx?=
 =?us-ascii?Q?atxGem36iCCyH93g04N+To6zSpqwo5Mk1lxtdl3FnKf3rFFmavR2qhuY3Tem?=
 =?us-ascii?Q?EtWQK9vvTlWzHt7HA4DTGLn1uU8OkMEeZd7HWeUg1C8O94aY+jcvMFQ6zoaJ?=
 =?us-ascii?Q?khVlgqeAE3dAoPT8GhO1aFr0JPyOvBgHOYcKCz7WM2MK5E/cm7Cp1p/q1AdJ?=
 =?us-ascii?Q?ykqBCuvL2wV80vR30lVh6E7gzxMW8JnVE7b81GPVIx4kxKDV43F9PrHzZNVA?=
 =?us-ascii?Q?MtMVcXHVxtGpqaTW2PgCtyDI1SvS6sY3QhLc8vV9EuVsJHdCdQaAFNfUP6Dr?=
 =?us-ascii?Q?Rzehuki4pNidUUtd8nTqGCZtKS2JLDeIhrpxF/1Ew0wjnfTZjuQXEDbypqhd?=
 =?us-ascii?Q?+X4Rh4MIJU3xv2051WDW/1HCHfofzR0EaAPEU7GMOLy8ZaOTZ4ntjxJOOEes?=
 =?us-ascii?Q?e8dZNHn5ByBfL41XwS3JSIn5KdNS9IL/5xENCUVm58QZ+4wlW0/z3JeJ0+qa?=
 =?us-ascii?Q?L5s0nGIn1eCTDvFmBJNFs3eoU7Yf+wj4C3yu2HDCoySI7SpyWBeJnK3QQdhp?=
 =?us-ascii?Q?/JddDUg3aiKjYr2IarR8ygNemgPyK7cZINoGk3ymWEqIa7mHbQAz7jj+UmOo?=
 =?us-ascii?Q?4A9lPX4PB/B40o2v24WgU6mifFLQSTEwdIAznfhoeYleA9b+fRkXv8FP8Mvk?=
 =?us-ascii?Q?XlTxPl/VsnCgM6QoL7/9hnJ2VDqW+iNYUYHlVTn37OlzEAlfoNkNTFIum1LV?=
 =?us-ascii?Q?EshhWVx8Zr6C1r7eoL0wdLuu+fMDlkxC9ghjzRS+JHhxjGxHHQBwTs0cgR2e?=
 =?us-ascii?Q?O8yAX+1KezUTA7B2yEHxEMMPFkBy/EwTq2VDvhnnyAojCUMrarJwNRca/BDD?=
 =?us-ascii?Q?x2r/syLq4QWodVbaPY9ngG1UqaplS9NdZBukDAsCOjJggmXBB9KKWisIJYJi?=
 =?us-ascii?Q?Hh0AXH8qEeMXjxRc6vazdAloVdy8iRCKv4CPz2R4NNus6XdfJ5P8T5/F+Xz1?=
 =?us-ascii?Q?QRWvofSsHxPP0WLU1zOEW815MuXJ7Wn3mXrtfojtfXfvj2nMipKhNVc+/bh7?=
 =?us-ascii?Q?HmwHJRviF5UMKchwuXYV/IYxel/WCokw2PKSS4h90h+KAEcTtDZiKPaxZh/y?=
 =?us-ascii?Q?0WcHWnfAoTRl4iuM6iUBDacx+Xhu9NFn2d5qehMRgoHzZrCHz8eK00vlwZHE?=
 =?us-ascii?Q?2dr1AEazpr0DwfqRdMAa/SKfFoC/o7WPBlpnKHQKR+Z5K6Dcq9/AwHel36a+?=
 =?us-ascii?Q?2fS3tKOoTIyU8vJqZKR/n97DRKw/+a/VFGQVKdA3CBNMMakRPzlmQ32ZWPQY?=
 =?us-ascii?Q?rZd0XBhTlx/R7bocXP8k0yXUmu3+XW1p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8iN6PSN5aV5xm6mVfa3cCKOs2SKtCmPG3KApPliYF3y5erJC/yQKvMezxWFF?=
 =?us-ascii?Q?p6tTy/YTh1tspMxNf//763hLjbzGktxOlIpq1O1uS5oxaqUobn7p5sW3PEbG?=
 =?us-ascii?Q?agw4WJ3yHBcXGw5rYDG2wly9kbwuHbyKFI/Tjwa+0PRAtra4LqEhY8AA5g2o?=
 =?us-ascii?Q?k+mlOC1casEZx6h5kDq4Q3wwtdsi2HSj2UsjMDmH9t1LffeTyPG7TckjX0Ph?=
 =?us-ascii?Q?E5EPjQuGfv9qmo1vMuNImYTSBXrl5l7bM07rjV4d4+wjMMv1qa3V0MWvRpJJ?=
 =?us-ascii?Q?49cUCnqJBBoNYxXuO2bE7G70iGRmaDkuTByInGactehxgmwGS8onzb5USEC8?=
 =?us-ascii?Q?HS1FPpGtNvmd8qauz4/x1ShsyC1fqKDRqrYM9R1LfDo7gO8RoZI9d3Oegwi+?=
 =?us-ascii?Q?jkpgDnpeOUYyEWlojvkq5b4UM7of6khY/GWJYwqL1aI91rN0GjvKfQpFEqzr?=
 =?us-ascii?Q?LoKamH135EEtGznB0e81vRhlE3X4RYkGBMtEn2xJ3q14kw2Cu0pDNreyWDMM?=
 =?us-ascii?Q?KTnx8Y3WMe77pQi7qfK3TMCbIhBe+4hMKZRdMlltsjXZ0Wo1Gf2Ev+Z1wBU0?=
 =?us-ascii?Q?SaEwL9I+QX7VpG8sIBYhXmuxV3MnR01A6YZGFMOlIxG1QcgAjeOVc5Bl6+X3?=
 =?us-ascii?Q?apVmwASwG0FHK7kLNTZXmLAsSivFbERBB24pvby/nf4i1NsFZ7KhIUK9iq/5?=
 =?us-ascii?Q?7y7UDE/MEWGpLGd9IDBNZDjDQmcXUo6DiugQClmoboUMmVrqXukzbe4EXW2v?=
 =?us-ascii?Q?5QvgeD/OISgAxhSNiS9Vy2cIhEjA4/filzTb9MA01E7osGZIllYDIiPIVaSQ?=
 =?us-ascii?Q?5WnocQYHJWsjgtJrLiQZpS3dbTpnAEXY9vLVDGVf4AiNOXmZ+h5oqQDwLdoQ?=
 =?us-ascii?Q?AF0Qq4GfCDnkRpS6+s6HQ/6DEnLxahmnhTB4YAxPVMLhM7mz+mO+gz7zqydQ?=
 =?us-ascii?Q?XxIsqLDQylnYYwzLPZDq2AYdi+zJE7Bqd7S5IrP91jhDUlYktah4JlINQozE?=
 =?us-ascii?Q?48RqZ6iM8nACQnqM+il2Gu//HNeJhe6lVBaWtVYwfI2CnYMT4038JB+KZo9Y?=
 =?us-ascii?Q?SpysPcx05kfVQacJv7YKS20TozKXUKS3lxZxhFXJdmncqLlenUPMpPS/JJhc?=
 =?us-ascii?Q?WLGn5DT9ZkdML2bfWbbO3A2d2BRZwtPIFMHKq6LHXATXNOGfyDDJW0HhxIGd?=
 =?us-ascii?Q?3vOvmMrGONcW6jy2n8VqviUgqBgS6E8eINfQtsxWprVokzGggSuIYbRC9C5M?=
 =?us-ascii?Q?AjO0b/yrfWpn1IGas+yJMtMI8wRigEhKfclLp0VhJGzd4hnXbsV3tZN9DB+B?=
 =?us-ascii?Q?MMRRabm00lByNXuoJDZvFDe1o0pmB03GopaQ6rrIzsvmLkQ++Jz1E5wK1bG1?=
 =?us-ascii?Q?CGuPItncWmJFolDje/y2oUNMbaKQY7AygYhJE9Px6IKHKYXKHnTSbVbkiHPT?=
 =?us-ascii?Q?8rtgjxUXGQZS3cSubEOIWJdWH7UD0OFf8Sf45bkRQPYV0TK63aM/zNEcnw/w?=
 =?us-ascii?Q?0XtHCwFXxZK4F20LF62ZRTLgSVCeBiZNh93fqFgsVYMnpoPSJcY6c0wsg8Ld?=
 =?us-ascii?Q?Nx1aHHm68weOqSOFeJh0NwJfOdN39cyPngIFmNdmQIjWoOSQuugPTCqa8/0D?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e554fad-9c30-474e-cbd3-08de160a60de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:11:36.5988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+b++6H4zeLmAarDpPuYplWOb6U9iFFPsTOusnp9Nm9DNJpqRAQbFDvJ8lKVEJz/7JhK2ApuVrYmPbFdqoJrmRDw+rnbROsbX+3DXPTXIss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8436
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

On Tue, Oct 28, 2025 at 04:17:33PM +0800, Chengwen Feng wrote:
> When launch proc-info:
>   EAL: '-c <coremask>' option is deprecated, and will be removed in a future release
>   EAL: 	Use '-l <corelist>' or '--lcores=<corelist>' option instead
> 
> This commit fix it by use -l0 other than -c1.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  app/proc-info/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/app/proc-info/main.c b/app/proc-info/main.c
> index 1b9979b7c8..b09c03ab35 100644
> --- a/app/proc-info/main.c
> +++ b/app/proc-info/main.c
> @@ -2121,7 +2121,7 @@ main(int argc, char **argv)
>  {
>  	int ret;
>  	int i;
> -	char c_flag[] = "-c1";
> +	char c_flag[] = "-l0";
>  	char n_flag[] = "-n4";
>  	char mp_flag[] = "--proc-type=secondary";
>  	char log_flag[] = "--log-level=6";

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

