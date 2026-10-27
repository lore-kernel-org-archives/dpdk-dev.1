Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C92606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kDcY7YmN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36A13400D7;
	Tue, 27 Oct 2026 14:54:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 14488400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 14:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793109287; x=1824645287;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OQ6OR6itXaX6aMM6QcPe6CYjwnPE7ybV+8D6T2VSJIc=;
 b=kDcY7YmNm2dFJvA0oOW7Qz8YMv7O8rT/D5p3fxb1KLRZ+gVSBW8PsyFB
 WDW2SfW/OfRjjGVV4Ka0d49tAW8LGIqRJ0mxdZxVJ5zEAxiaEkGyfmDer
 4VCkXrLITIDx+UxwC8pduhq4AE7T8CeOp1HCWcIlQtrvFsIwf4YHMMtQZ
 HeVjb+6m2CrhyZwqZb1rclcNptjEQjJFBoDUZ/Tl0Bel2vMD++YmskJdK
 V8yFqyVEJjLmox0PJKiZqysnLm87pt8FbSDopt1DinwOQfoHEt7da4vTj
 HwmeR7OM+Nz3KN8S8WhaFPTRoNPPu3klv9ZAcCDV0rlzwShpSkgJQ7++x g==;
X-CSE-ConnectionGUID: 39cMeHKZRq2hU1z15pfB/g==
X-CSE-MsgGUID: UUi8QcOoTDSkAn3yAY66yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1698697"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1698697"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 06:54:45 -0700
X-CSE-ConnectionGUID: +Nq6TbIKS+ONGrAHfHFgvw==
X-CSE-MsgGUID: IJue0pITTpa2BWtgpS4Zzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4649219"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 06:52:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 06:52:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 06:52:44 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 06:52:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5NuxyuVVyT61uTEP3FrQFR4i/ygnzJC/600dOIonHO0lFlpp6eh7JZE3RFhT5SzYE9gJoK9qy1wNQLg3vddPpAE63iPs04tIdEqs8CZN1ZL0TxPSgLDSGUKGuJq2cIniSVPeYucrWkBnj57K8MvG18t1AWvYWG80MXJfI3iNPPQcb0WOzL7W3MPiKol8RwaggqocqRkcbu0gJWobPSRLKjYUGh489fy1lj6f/XVyezvPneDuWUKFc67PE15ud/ezwBk02Mke0/6VFKfVMgr/PPZ2c4iTdJsV01Xw7ypluyNOCX9O/8zRv2sCbR6XMWolNJu90vYQOWdabkuOGpLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkmP70zsj/jIOwKP9zczziesexIFBeI4KzWqv6D48SU=;
 b=hfKywJgl9rFCBOic2P7wEeiYG2lBECIstQIf1paWiyAaIhRid67WTaOff1L1yGmg21w7++heyk0Iueg/awCkQA56D20BGxWJPTDECfhRyYslDkkJCVPs94PPzBPfTxyOHDG0Bl80udGeTBw0ZKm4oKrPkI7YKnOHpmfGvMnZr9hbo2ceeuEk5heogKeemkXjGou9HaPAd289sPv0cMh455htrEAXYhBlu5m3csMc67qmoG20EqrldI4HIxBYUtOGn0/kh69d9CUHA0YkIFAY2oDJCf3lGF8r4jFc/4vq04onR+HxNxtXszcmGUD1303gxACl5HZ5Mx8TqcrCmaL8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DSVPR11MB483333.namprd11.prod.outlook.com (2603:10b6:8:3e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:52:43 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 13:52:43 +0000
Date: Tue, 27 Oct 2026 13:52:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 3/7] net/ice: fix DDP filename leak
Message-ID: <auCspZRzmnqU8kLE@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
 <85b3df3751d1e6b319c1af2cb21e01cf7db4e229.1793097896.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <85b3df3751d1e6b319c1af2cb21e01cf7db4e229.1793097896.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DSVPR11MB483333:EE_
X-MS-Office365-Filtering-Correlation-Id: 755ef0e3-a64e-4707-ce48-08df3431929b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261026140227099003|11063799006|4143699003|56012099006|261026121527099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261022113327099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: GudvFNbbxJa3qag4VSsVniBuKWXsLAIBvXwUwIbFrOu8WeM4Ot0NxgfQO2oqsLNH8tGfNdSe2yK+7wVoJb8gbhpHIwuSNwSqha/ZhaAY7whe8FBToO7DRfazNqT1k1yNJ7/OwXfZ7l5DXJ0UKC7/3h6hk6Zph33QaXNBohqtYze/9sleQjEKZ9t6ZpPocjRQCOFMr1pBe6HBWlJ/n+aHtgh4yQZCVyrf2Jlh9w2gS3/YZDjwi2hgnQ0sB/RtBWY5uMVvPISzSmkngtwe3VDBpgFw4uluvQnNbMBzD2+CVGRHfnFKPLfRh/YLLzop6bqARZFyvhweA10bkNxchwBMKPF3X25R7Ls/HmaJPFzABmtSJDsggeZizrw7f4G2ETWilzQ2Lsqf+cA/M7EdsrcXiuaOOyyJ5Fzx00DupbmBRfVdQDmxKZRESieamyvdyXmUcxIkdscMx645TV8uMkUnKq6TZynlsfl4vXa//K0XRdJ6bSvKXQ4UKL5BCiYKDnb+7YVUnffLGpfCrWvLE+QbjsRUyxYDFItVX698M88PBYKbotgCxz5PDQHsJoWq3JFaIs+Nd4meiy0ZCtzfh8PtS9WtNIe9jKyN3bmyeOFAv1cqjwj8CRpcphFIsJ4LH9S4uu7KxY9mcgfgiEmqBfvkMnKysx2tIzIQTfBeQuxJTQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261026140227099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261022113327099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6iBsCkU6TWJuvOztE/6GZmS73lu6oC84bAylVCnxxEqQ9LaDmURgueGW0X/V?=
 =?us-ascii?Q?//527p9EuhbnLbrj6rDRij2J+nO1lEblHWS0j52XObZBFOuRQWufX1EkzCBF?=
 =?us-ascii?Q?UPO2EdeEUe4BZlA/kVIxqj4OM22igoPsnTyGyeELnH4BcIcj5nAZcD2MCymk?=
 =?us-ascii?Q?/Aw/RXx7S/MJ4VT96IQ6hs9XXzdLs//owAUlhlbToUr5BCAWNVrbg3dR0q1/?=
 =?us-ascii?Q?Hq64VIZvyqEltU6W08mYcqfppXBaDix9m0DI0/M+DBf4iCQ4SsPuHsKnVOh3?=
 =?us-ascii?Q?PZLsKffgSBS1Pju28TP1AIjmJpu5GY9rnnQFQbpIsZ7gPcR9wCzXWYqiEg/L?=
 =?us-ascii?Q?oDiQC4Pae13P6oabuZHbbXVcJIo0PJrGjzScmdBn60ris0n7LZ/QCKIMpHTa?=
 =?us-ascii?Q?xNKNot4iXUl9NOgJiDmtQ78Qhbh8lvRtbyRAPGWphy+7PlR7UKB48vxQ26hB?=
 =?us-ascii?Q?ty7Gqck41f+ET88N3aTV3aVb6QoeKYuQCHyBcjiJ/6un/olq0ZARV0wzDKjt?=
 =?us-ascii?Q?R6lSitJ9Db8Rxi5DSjx0386n45QKIuvi+ISllXKqZewnRPs2cFX9yCllQVpK?=
 =?us-ascii?Q?UU2gPyEf1NZn0knkpDDDBrPfGcWjVB1yJ/YgAuMRNVbzsMKYFNS2PC9p3FL/?=
 =?us-ascii?Q?lQm0oEauCmaZNsnzXMUyfwiI1tCxocX5nwRktraregQGyApY3Zhwkc8+EOp2?=
 =?us-ascii?Q?RclzizoAw2KXoGHAkrwBXdS29gMhQyWYAack25kPfCFVhWOL1VBZFkHn7f3y?=
 =?us-ascii?Q?4rF8qHc5CTCWa3tzzodaHyiO90uSghGUty1AbDCmAtAlOaGcES5Dootv9UhH?=
 =?us-ascii?Q?bsokUrOnh8nhxvsx8DoJRqY+RcuGAeqEMIvVJpqCyCubFSPcK/F7PfAAjyUa?=
 =?us-ascii?Q?bxRsC2d9i2aAf5wH7GRSeJevZUDaA7GUf/NR29UMC3vQ78+LZnSy0rNojexH?=
 =?us-ascii?Q?Kdi+zR5B/rlQ3PVWDmBRo02gWnCwDA2DaE+UuVSI84oZvWzhQPMjse4wgHoA?=
 =?us-ascii?Q?jf3AasU6uwEZeGxupxwlbmhSVGiR3M8letksj2DhNGmLi2O9FSI+5p1PWPn3?=
 =?us-ascii?Q?ywSiQFX3KAZgm0MQdCiRbjp9gO0SGsYLmtRHnIL/PU6nLozbt0X4Y5Xu9HS3?=
 =?us-ascii?Q?wD2Ozsb2tpN7Yxoajy381S6p42oFq9wHKFJa+VIoF3bQqhEdvRnxPh3c0h9v?=
 =?us-ascii?Q?W+7p9R9SPbU8POOiauJb1x/f43VxVjpd6AJfQC312+pSmhj4mAaJcnjgHdb1?=
 =?us-ascii?Q?Q9camLYW2vHYTy4ew8yPURDe4WcxsI1XKuYGFpR/tpYhcZRb3HYVx1NsZvVT?=
 =?us-ascii?Q?iBdnSzsYGmC3olL6kVo8i5AYVkW1Bpbt7fg8WKnh++25WfGaMpnhhvLRHXeZ?=
 =?us-ascii?Q?nSJTDECG+gvrxqctcXf8Z1eCKGsj20TlWF81TCY+AswncZrfcCRk9GfxuRwO?=
 =?us-ascii?Q?Lj2tGYAAdYfR17dxeoRMJK8wfSHcMEnMdNlCF2VVOUtiKLAuXqYc/81vvEfi?=
 =?us-ascii?Q?sfr3ZcLKbsBYw+INGWVgo6+6Ez0CJvgBP+J+Dm7sM8KWSIAtQO8gL/yMA7oM?=
 =?us-ascii?Q?KXpAvq/RKE47HbuJvR1pHsHLDMJHSWohc+pYRrngsov8HPKAGAnMPWGkWG4H?=
 =?us-ascii?Q?83GZuC4QT7G/6fFnUFimKVctOTk4/dNasoD/Nr2uWwZy+YgvBkBYTFLKqLYc?=
 =?us-ascii?Q?GaLQFnaGCstbGC95BR2HnYdHFh99mBSmvVraycwCb3nOz5RI7w3TxjFUpXkg?=
 =?us-ascii?Q?y+9NPaXTTN9yvkqg6860TJ2dSHbtWWA=3D?=
X-Exchange-RoutingPolicyChecked: 3pgCqE68pstgMVHHOxKrBdwXfGVro19KkidrtTHWop6fe39gfOfFG8oQsq7v7q924cm6rRgqMRxFwI0jIwl9yl85nUtqevJswUXb/Zby1Q2V23p+5wl0FH+ZjrTWNvtAUlztVIgFp3WblQvkz0/VuOXZP+J14Vyy9uZ4FR3LsX75pZVxSDe5SwE5ihmStoWsnD9bSSeR8qoZmQOxw+ISEYo9FZNaiLtFte2pxYHc8poIiQ9RkMiAgOwWbFMspiS3eKEh5rDKZ4bMuIyntgGs0HQ4pdXSvxsZUhwpuNCPKGbo5B1Bh4xhZR2+Smput0DJDJurpQIFofDMrx0pUJ/TMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 755ef0e3-a64e-4707-ce48-08df3431929b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:52:43.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlSrbuKxGOgEmVdXAgsScwLEJEaSHb8pa08aRohEbaNjSFJFACQfwT3/ghp09djZcZONmf7h8BO3K56gOuNM0CY9XKcnYaxcLcckPAAkWos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB483333
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:51:33AM +0000, Anurag Mandal wrote:
> The DDP package filename given with the ddp_pkg_file devarg is
> duplicated with strdup() during devargs parsing, but only freed on
> close. It leaks when ice_dev_init() fails at or after devargs
> parsing, and when the devarg is given more than once.
> 
> Free the previous string before storing a new one, and free it on all
> init error paths.
> 
> Fixes: 9dd6dd1db834 ("net/ice: add option to choose DDP package file")
> Fixes: 603beeb970b5 ("net/ice: add safe mode devarg")
> Fixes: f9cf4f864150 ("net/ice: support device initialization")

Cc: stable@dpdk.org

> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 27f992aefa..ec4d021ec6 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -805,6 +805,7 @@ handle_ddp_filename_arg(__rte_unused const char *key, const char *value, void *n
>  		PMD_DRV_LOG(ERR, "The DDP package filename is too long : '%s'", value);
>  		return -1;
>  	}
> +	free((void *)(uintptr_t)*filename);

You can avoid the casting by changing the type of filename to char * in
this function only.

>  	*filename = strdup(value);
>  	return 0;
>  }
> @@ -2738,7 +2739,8 @@ ice_dev_init(struct rte_eth_dev *dev)
>  	ret = ice_parse_devargs(dev);
>  	if (ret) {
>  		PMD_INIT_LOG(ERR, "Failed to parse devargs");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_free_devargs;
>  	}
>  
>  	ice_init_controlq_parameter(hw);
> @@ -2746,7 +2748,8 @@ ice_dev_init(struct rte_eth_dev *dev)
>  	ret = ice_init_hw(hw);
>  	if (ret) {
>  		PMD_INIT_LOG(ERR, "Failed to initialize HW");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_free_devargs;
>  	}
>  
>  	/*
> @@ -2761,7 +2764,8 @@ ice_dev_init(struct rte_eth_dev *dev)
>  		PMD_INIT_LOG(ERR, "Invalid rl_burst_size %u bytes",
>  			     ad->devargs.rl_burst_size);
>  		ice_deinit_hw(hw);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_free_devargs;
>  	}
>  
>  #ifndef RTE_EXEC_ENV_WINDOWS
> @@ -2912,6 +2916,9 @@ ice_dev_init(struct rte_eth_dev *dev)
>  err_init_fw:
>  #endif
>  	ice_deinit_hw(hw);
> +err_free_devargs:
> +	free((void *)(uintptr_t)ad->devargs.ddp_filename);

I think this would be better using RTE_CAST_PTR, rather than using explicit
casts.

> +	ad->devargs.ddp_filename = NULL;
>  
>  	return ret;
>  }
> -- 
> 2.25.1
> 
