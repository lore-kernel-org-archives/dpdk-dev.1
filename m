Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C87C79F87
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:35:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12B3642ECC;
	Fri,  4 Sep 2026 12:35:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B5F6B42EB7
 for <dev@dpdk.org>; Fri,  4 Sep 2026 12:35:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788518156; x=1820054156;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WtiV8yvmKUdty0CLRRYMWiZhzobeywFyr7Cwfm/yO+Y=;
 b=DRz19Bj/G0fHcZ1m73v5rwYOfhjF6QVMmSa3Se8z8v79E6bknKRJAJqU
 e1lftBrW99EVStaFXBYY/JyWSGR7skWdLzf32xEUEdtSWq9sLYjZZWRqA
 0GrQEym3Hc0jF03YuphFaywbV2B3Sg86HGAs1h0EMvwS+rGL/lzlQ8CwL
 ig66C6ursLxnbRYvhfAuFx40fS4b/fB3e9DDgAsohn2PGcGqeeLuBLuy/
 d0dZELHWf0oo1pfZYZqAFxJgelcdW7M59aKyWXS74JqGE8KN9ZqzopY3o
 q/1p9ms8Upe7iKxhbe3YN5cwVh84fRlfikmPWom4nFTryR+K44MV2QwPW Q==;
X-CSE-ConnectionGUID: pTjHHRSxTnGKfg0WeTvRfA==
X-CSE-MsgGUID: u2MuVorQTNOdSnMlQmDVbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="114558834"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="114558834"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 03:35:55 -0700
X-CSE-ConnectionGUID: XJzmthM+Tg2x8JHL8AbptA==
X-CSE-MsgGUID: 9EPuvtaaTfeb/U3nOtFT4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="267428991"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 03:35:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 03:35:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 03:35:54 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 03:35:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTukB9RR7k0PR1uvx1ASAV4p2Xwol7S7at05g+bJikMFzr1awYUkmae8d/Nono6B7XdfCnmsEoUm4MjtbnCcVe0vilBRVgUjotINe3bEgRFvRc663A9vwfQAitm4ram71JSZFnbTPtYFP5zCwxYb5xM1EUWNdfiku6V7T3/kI0mTc8xBi5AGnhEnfJSktK5Zl3Mm9JszGT8ItnWekaXm9vqUfCmF7EwCuILz6/+kmW/YuJEeuDS2dFk5xOjMSbbiQkAsylSWeOxH+vPipqL4T8yJvRFIlcxnt9HBhmAqk6RCp07+nnz4RF7L8Bp/DGBYYCgHhM5MVvXPoFtXrr2XtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trUPrhtlywEJFz4vCvk2MuYCqcSueHmSi/ousVRTbB8=;
 b=oTwmSlPuNeS0rQSTl6RzVxN6aOU8cX+q/Sz2rEffX0giS866mC47pAvGjE+p7byTEzirxDWVsJUcZDjJz5EyoWlpKSWqRP1fSZiscqR8KosyVkQfT0RS72bGl/UlZNNcf+54kbb2bYFs4tDLO/8M0Wf2G6mQlIajKvJ/D+YO8+ize5xOHROZKSJc1KKWxuzy/lTrti8MbUn2kpKt35jzcJMsMNSeCU+b9DwX7dXZy/ueCJgETi6ctXgC8sojD3u8vInD0eqBAfzGSkG0dhR01S9SZ6+lYmzkjH5uIRJ176aEyxWmn269G2dTNQKQ6RTgDd4KognCrrcenkV6YNQF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB8232.namprd11.prod.outlook.com (2603:10b6:8:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:35:51 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 10:35:51 +0000
Date: Fri, 4 Sep 2026 11:35:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Atul Patel <atul.patel@intel.com>
CC: <aman.deep.singh@intel.com>, <dev@dpdk.org>, <praveen.shetty@intel.com>,
 <dhananjay.shukla@intel.com>
Subject: Re: [PATCH] net/cpfl: fix VF ID calculation for vCPF
Message-ID: <apqfA2kvaIIW11qQ@bricha3-mobl1.ger.corp.intel.com>
References: <20260827212216.765057-1-atul.patel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260827212216.765057-1-atul.patel@intel.com>
X-ClientProxiedBy: DUZPR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e68f77-b62f-4a4e-4131-08df0a704a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Dtb95f6qHG+NFEl+mREEGAh3nRZE5zo8m/paw7I0/jFdOLj7sjII2GaFUUZUGvuq72Xmeq+gFsogRoFPtgxBSESELl9t43DYiZY5fGJ2YrHg0WvuM64GmxslMq6Xe2BQ7c0CV0juL+RKSF5zwC5LOes+6JfXRw58tYQSvF8cjl671cjjMkNp4K04zm4Wva1SrWSPU/axUBPl4JVIiDrd4GzdEalKAALrpMiNB1zon1jQXyhw2ecG+bLEFm4X2tUu0aYAs3MVis/PjzAYZWM9Qiw87Yl8vkY9v4onYWrnLMhhQR4D5F6Da4DGWhrO4KcydGNYMXew4LOnXeHlj5VXbvln81NGa956Te5HmPd+MZYjJ0IzqMPeNhWXQ2ORQB1cfoFYJPjM9Jy8JEg8qDxdKADIiHqLN8BcyKkmBXBPFeZ8YYkoPj8hzCs6jZLfEgHa577GKU8qlA/vYKnlRDrh9ctRzgwMSkk79F8CTcO0Ti3BDjOSVZDl+atpqLH8pia8DDG26QcttgRc6BBrZIsuNw1qoAUdUD1r6hyMs+Ba9LdxB3xl5oqr4SoZuZfAeOqUBJ7iWEMej0D9/Oya1KuKyO2Fowusl3QFyvsugV2m7kMnxqM3g9nA5rH1iVSMKxdfFtXud6ps7NPZ9L5YzOeOOb9kGeYf80s2jwCbtpHzlJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qjIVGVazUzK72wuuZUGtpI3fkhGOOsxq52jhyY6znsVog5xwLDD/6Kt3XvW0?=
 =?us-ascii?Q?quYy8auTv0HlqfQrFAYoiTLYa9pmBayh5UTvV69Q4/oEYsN46vQH8FVCmiL4?=
 =?us-ascii?Q?G3YkvlE30isJMaXN9fSnNkF8hFqcOkUNoHXGzOMHqI7FS5E90kZLu4wpVm/l?=
 =?us-ascii?Q?11CGtSOU6L2SCnoDFTkQHVpBuMCnJuleAAKg+46yEv4ebHRTaHiiU9k20lRZ?=
 =?us-ascii?Q?iUGSaW0rgzvK+D+5jpgEAQIMqTf7x/GsosTKCdaxl72YSx1ScOvmZXI56tBD?=
 =?us-ascii?Q?53jRD4hiCLDLfL+EaVfMUiOUPuABwt9khA8Ek1OuzD9JmQEtsvP1ab62+Q76?=
 =?us-ascii?Q?AsbIBLGVvxhBfaL9Nx83x9g6+I7t3G4MRdhpsK8MD9+xFgJX6F1CvkJZz/jY?=
 =?us-ascii?Q?xZt2hSHwCSPzYRtwEKoU38ONPCdatVs+TFbAP2APPh2X1hx6zDcTgv+5M+xE?=
 =?us-ascii?Q?wt9C1sy4oYWLm9tPTJShmJ1xGy1brqod35v8AW9iNLcW7lSMDK15zH8hZ7BC?=
 =?us-ascii?Q?JwGP4KjgJl3lsi+80BVrxBBNrNHEMqzeAFiYSAG69Yd/trBchZjVi9sfQQsv?=
 =?us-ascii?Q?HArlt+M5G7ANUJnJz9c2EEi5Sy+l5z+9F4qy6ZcdY3+tGJRxXm94XdnEMY5F?=
 =?us-ascii?Q?hFee13m+INqaygna+OBbENsSjXXaPCzGFJtq3/dzzcegBOhPaTAiaHjPsH2M?=
 =?us-ascii?Q?ow5554AwM5Hh9OIQutyPhMj3ap+yVdQfPe9EwLEF1yFMmQPsxbko2ic4ZKCU?=
 =?us-ascii?Q?LX+VR5kjN9qyajPZLu4kAmWUjy1fhoXqTYPlGBhrBxmoNOLa1VNq8FmxIM00?=
 =?us-ascii?Q?n0vugiPxItKxxaHaYqwbcL/+pyKYhwXAKUbYpgkKUubQ+PV04Knc8wSBfjcn?=
 =?us-ascii?Q?aRTbY5hnTewt4ABJWcVavvZXBOqeyma5JUikDxLnGjE43vFrKgRdjRPxspTo?=
 =?us-ascii?Q?4TgMdmD0LfaphgFlVZG36gPy7b1AurDeNjbvO2FRkoNQSO5eV408Q2gj/e4K?=
 =?us-ascii?Q?HftTBwu10TWvOY+Oh0InK7BFK+2u6Qf2et1sTZpxVlT/cFYbhLLQrMiFOrEs?=
 =?us-ascii?Q?r9oZs7RXQk58yxuSnwN6LBXeqgIlbKiRxpozZECDfy28zWHxuImZuxYxy51u?=
 =?us-ascii?Q?f0/8FJ+973SH4bBbFGheP3IV+wQHEDtuDeqS6VluaETJiKQ1HdlcH1dPe50z?=
 =?us-ascii?Q?AKd2FyAvsVL1vp8mVnT0Q92TF9bGmVHvlihts7NBXMzS+Q4GuRuNd4g6NBvG?=
 =?us-ascii?Q?aBzHm58TtQG+az4MD5kzo29bgt8O5JU96a7A2ypVxrPY2+9/sF2ns89F8Qe0?=
 =?us-ascii?Q?ruBUISwHyKpBCjjNyAYO9RvLXbQ6TO8Ah+5+1LGOZG00AIIaUVnQRjeqQ1bf?=
 =?us-ascii?Q?DRT2LP2F/cnJ9m1uGLqpvIyuBomID6xNjnIVh39k7G65Y7TRpI+5YYW6Itkq?=
 =?us-ascii?Q?lCV7h42f7OG8+QsW0sBh4dTlZglzmD6AVRT7cjiLkEyw2T8OsKCiGNixNHRg?=
 =?us-ascii?Q?Q2Im9PAmhqBKyPRI8NIJZBRLZfUseaUW+kE7YOpK56lsBfIyOTeCkqkgMZl0?=
 =?us-ascii?Q?k8Qd/x6nuI/wv9sKsTr9Kv5NbR674yGRbQvNRzdqGng+YXwGuRARTn2FHaMP?=
 =?us-ascii?Q?kp7ZOcfwknMcW1HtdQWLICrqWhxVMpz1FZllgAh7VsEGT5kvYXsqaNyrd4UW?=
 =?us-ascii?Q?nqMox4HJhAMYI/eDv1ANqSD38MfCjOY+sQgsSZBj5oBR3mTevUK49qpzAROD?=
 =?us-ascii?Q?pb+801HMBdoi4XDj7Kghlj7lEe1zrSw=3D?=
X-Exchange-RoutingPolicyChecked: j10QdbbXq2ZfxOabh4CCU8V6OXNZTCPj1wVbKxnG0tZle+m4/HBW+14F8TC27tD96Er2Kw9byPK8BnUBwpxpiPNW3kPaorWNUb9tuIGgl/J+FjmzodcHJZLqquogisigzpfdbTzAL4Gb/rSbgZ86xhrG8GpqP0AbTH3YLOLu/3PGls+/eMEtxYlV77W4LkinJzums0cBhrZmjr9zS5b+IejBoviShRIMdVy1F/eNwHVVGoAEJqNmQ4QMnUvaTw+6LRW1zS2NaPnWFK7I70y4i8N6PYHXCKUxdKIkMD5IQ+T8OMimme4fm47j3/jQ4/1KY8THapsDBe1ZkzoIKCvd4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e68f77-b62f-4a4e-4131-08df0a704a75
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:35:51.5014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhlCubmml+B1IbSa6C7RmeLjmMbQRkiR5lmoF5PBI/JWkFPhRgXLfUH138tkzLVrbd9FSz1NUTg91gdj885IKXYNP5suT+beR2W4miZLCXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8232
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

On Fri, Aug 28, 2026 at 02:52:16AM +0530, Atul Patel wrote:
> The VF ID was incorrectly set to only the PCI function number,
> which fails when VFs span multiple PCI devices (device IDs > 0).
> Calculate the VF ID as (device_id * 8) + function to correctly
> map VFs across devices.
> 

Is this saying that the vf_id's need to be globally unique across the whole
system, or is there some other subtlety that I'm missing here? Just trying
to understand the context of this patch, thanks. Most other devices the vf
id is local only to the relevant PF, i.e. each device has its own vf 0 etc.
Is that not the case here?

/Bruce

> Fixes: f1ab44fb0ebf ("net/cpfl: add vCPF port info")
> 
> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> Signed-off-by: Atul Patel <atul.patel@intel.com>
> Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> ---
>  drivers/net/intel/cpfl/cpfl_ethdev.c |  3 ++-
>  drivers/net/intel/cpfl/cpfl_ethdev.h | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index 4315adb68c..01e1b57cc8 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -2839,7 +2839,8 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
>  		pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
>  		vi.func_type = VCPF_CPCHNL2_FTYPE_LAN_VF;
>  		vi.pf_id = CPFL_HOST0_CPF_ID;
> -		vi.vf_id = pci_dev->addr.function;
> +		vi.vf_id = VCPF_VF_ID_FROM_PCI(pci_dev->addr.devid,
> +						pci_dev->addr.function);
>  
>  		v_id.vport_id = cpfl_vport->base.vport_info.info.vport_id;
>  		v_id.vport_type = cpfl_vport->base.vport_info.info.vport_type;
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
> index d41aa93191..97ec128128 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.h
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
> @@ -103,6 +103,16 @@
>  	((((type) & 0x3) << 14) + (((host_id) & 0x1) << 13) +	\
>  	 (((pf_id) & 0x1) << 12) + ((vf_id) & 0xfff))
>  
> +/* Max VFs per PCI device (functions 0-7) */
> +#define VCPF_VFS_PER_PCI_DEV	8
> +
> +/* Calculate VF ID from PCI device and function IDs.
> + * VFs span multiple PCI devices, e.g.:
> + *   device 0: VF 0-7, device 1: VF 8-15, etc.
> + */
> +#define VCPF_VF_ID_FROM_PCI(device_id, function) \
> +	(((device_id) * VCPF_VFS_PER_PCI_DEV) + (function))
> +
>  struct cpfl_vport_param {
>  	struct cpfl_adapter_ext *adapter;
>  	uint16_t devarg_id; /* arg id from user */
> -- 
> 2.34.1
> 
