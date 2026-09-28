Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC474C9833F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66C4840B9F;
	Mon, 28 Sep 2026 15:14:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id E27B040275;
 Mon, 28 Sep 2026 15:14:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790601274; x=1822137274;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gwdunIrJvDoB/vW+AM9yZVJzu9kJ2mSD2xnzcqkhuU0=;
 b=Dasmot80bOBNTXpcTPUea5F91u96soIlHtFo/f7Lx7jb+YSjcSZ68H32
 OXf6hSvFvqKaLvKBwOrs9+lr595wqMulAKldnYoFJ6L2fZvYBif9m4Vm2
 2V1QpmCIzOru99xQK9uzfXHENZ4tXnp9cLiC+EjBSbSIPyO2d10d4q9tP
 gyBvq4zVlx/72HJCEikDDN2MatYB4v3J1Al+n+Rr392d8me6st2AxB6Mq
 ESJDGdhPDfiwvisPjjTPAD35sJ1JvOhF+PfItTT2VCDZl+i8CxGFMd9RO
 TEECkwIpFQhZfNOYHPT/PzA02Avw8blEZK/bN6Uw8E/SG2YTuDbYUP4MU Q==;
X-CSE-ConnectionGUID: pvNhziGCTo+q1qaZsc29hg==
X-CSE-MsgGUID: VAx3HR1hTi6dPZKf9HlCAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="78864748"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="78864748"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:14:33 -0700
X-CSE-ConnectionGUID: jotqFURoQBSe7rrURZgN8Q==
X-CSE-MsgGUID: lLywnCoTSsil6s66DlM9lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="278245671"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:14:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 06:14:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 06:14:32 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 06:14:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCQ240Q0wFsMU8+h0nbMA8L2kycgcfEA3yWK7YzuaOrjF3b2EP7vpcDpubziwnjXlFpdQlQ3IkKHX3LeRvvcMUVVU+/4MfnUSF4wlR6FjBh8sJ4PMAhL+IU7cyeIyv0uifwmXT5bS9AcYvTDWITyZjM4HZfCZ77JGOZvjbFcz2mm/YUXTS+qMKYo+ie8XtK3nHy18CelFv8qnaAMAvhCKVDEJhjgcon79w32lBQRryjJye8F7wB5aaDLUkJE9XP2ip4z8Ls8sHD87zUrf/2GiQyZDWGRQADT7J2ak9bKqGdUmc/5OoRvPb9mjKx5bTCnKplFhNXqoCy7I0BzVaw7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEPQsMHphMdMNI6TqyqcYJO3UjjIuwJZYu3c2ongJUE=;
 b=gDJe75LJojGgb2bSGMGRjxWOfpgutoA4DaXoCWwGSQuJtIVhh7A55bpwwV6ftsIrNrin8U/bPog6Awb8hmzeoekqbnYMtElnAtpI9Cfug/bWn4Q1QQJmQ3voqaAGCt2sIBCIzmqGvwudaRL0JODOdlhtkNLWd9iqjWIlax7OEJM4oOJmIcx5obDUkmwZtaUbuz417AS1NVQbJbUqS9J5DsB/L2QXRlFPwCK7jS3B2QGPemCmwUnIaIBarvw0jUfmD6uBbeNh5UoNvge5pR9LCGe/OMpY+ddcF8RHOOaR7A7oFWDc6bAVvhw8AN5eJXQswXnySjJuVjFHXydmrsCgXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA4PR11MB9417.namprd11.prod.outlook.com (2603:10b6:208:569::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 13:14:17 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 13:14:17 +0000
Date: Mon, 28 Sep 2026 14:14:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Piotr Kwapulinski
 <piotr.kwapulinski@intel.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/ixgbe: fix null dereference on EEPROM write for
 E610
Message-ID: <arpoI5ltCdcblnwI@bricha3-mobl1.ger.corp.intel.com>
References: <20260928165054.20913-1-sandeep.penigalapati@intel.com>
 <20260928201253.45484-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260928201253.45484-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DU7P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::13) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA4PR11MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: eb211abd-b634-430f-c9b1-08df1d626627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: YXCPJTk/0VCpLemVbDe6+3ClVowkUsxG5zoqDumQpt6vH7/HmDwTUUoV69pNPpUHc2uJ5YXfxn+L5usbDXnM/bjWtDKCgfODcDsZKsvJNuKh9I/PopdITQHboGOJ9eJcfBb+F3k/Q7mt1ImTSPQJqfu5b9rbAMVyN2jujdZ00kks1EDE+xyMqJdipiTAOOB9+GVIGmGBDugIKdmCNWUo1D05/3+rrWHU4R9HSqWuQEPLzwz+C8kAd5eKScQ59j/fR+J43V7pDB+Am3suLj+7GMuqcW+fsdiVQt5Sw/cpoguJuT6lbsAMP98i3apWLJN9H6bN8qQyIylcPrTIen9Xv7vnQ+kCbz4N/+MSfXIhn/YkUPXJOmtq57cJfrlg9n+UrM9cyij356gWFxVDvDCXvb5PNjS6RV0MPAPCYdY5Feu7SZ6bdc+7hiqkAcqx7JWV4uzRJopkYYo5IELAbEslS6+qaevz4EnonissTZaTLb/Ow4AVQDs9RfLt79I9edYefW6OF1rSazXEOtQ6EyVw4hPDeX9EzHepsYO5q0g7M1QVZ0IlEruGVQWh8HJfooI5wV172bTYiVfbsuQK0pklZZoCZJAn638Hb2L4yawJv6FHH+5EJjVoJvPXlDxHc+Va39PemHsDjZdayxBuRfrfuhd9Iz8KVKV1aVq4zoaPIAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z6gjTXOv+LJc1Mqzz5lwWMMt5wydFp7aAzvn8yC4bQUvUsJLbHCctyq7ELQ6?=
 =?us-ascii?Q?M2r1mAqwDkl1bWYDcUyLTlTfpuE9xKOApy0V89CNGG+gLvryREQYPFq//YVP?=
 =?us-ascii?Q?GBl46LcgSPd5YJIgCCC2ZhhpvyktD/NAJDNURBV8OY5UuHTewRsst+UMndS+?=
 =?us-ascii?Q?gX90eGoUpKBYNh7xc+EpWiHqdZ3SDkTzuNthx20r6g/Eqpmm34HBMEGysv5u?=
 =?us-ascii?Q?YXgknNBpLQxHkoZWLFrhDwz8sh62aIcUu1GXrNG/eu0sjRmuSbgo2BDkCSDr?=
 =?us-ascii?Q?WfEC6VlA9VbbrKiUwYEJ4gmm0/uM1Q7KvyBxc7dN5g0RcOLQAfveg/MRjjCs?=
 =?us-ascii?Q?yOazzltuBqn2pvlC8RUqz5DTdDdopws2GDb++gXIazFtx3eAmyMQylF+3H4z?=
 =?us-ascii?Q?D8hFE+e0ND/65NayR2IAGsH29GhBl+KSgXlPRjuYhRQjQ3ucr5Z+E7JosHXf?=
 =?us-ascii?Q?jlBeCwJpptAXgE3wcQCtxdorzpd/Im6HMW2i8MkzLlU3ZhsQWsDUh8QsOJVv?=
 =?us-ascii?Q?k8EwDuy0Be2BSMXFX1s37GAzUj8lPExCZImNlaTB6lGkr5Q9Dej6K0TwVIN1?=
 =?us-ascii?Q?5utKr6Y3XCDUpUPIKD2O4S/7QKfQDpy78mvMquOGdD87iS6QLSBYDJDFDxlg?=
 =?us-ascii?Q?KS/HCsi4VInJJ2CEuINaXycPoT62urkVj1DPloeTNrBAsrXlu5HUSKtAoKV4?=
 =?us-ascii?Q?hG8sWR/zYHDofRDWqvxP2oRz/8cAgJGjkqcwngce3YY9eOw/zqqslUcWpiVT?=
 =?us-ascii?Q?bBRqBs0RD2TvnN3tAz5c4EgUllbUQEZl/FfyOo1XPuWEA9w2Q14WvsKeZB+h?=
 =?us-ascii?Q?MSY7RI9QTzQ1BcBNoSirlqtmy5WoOZaBf/4ezvDjSyg/QvY+6a8Spsdbz13N?=
 =?us-ascii?Q?QGWjgoFP/0prS4B33fiTv1W757gc21Ies+68NobVG4QBK7D3/LqxMm0vb99A?=
 =?us-ascii?Q?yDMhv8GRctac6H6dSKJGkok9s5vEAnHpGVRFshn1QxryQJGW/8SD6Nk8mwtq?=
 =?us-ascii?Q?NmZ3KCw+6VKkgBPMwDbtgaj+1gKDuQ2aOjqC411ZOvg+aPEYX54CPmJ9ES+9?=
 =?us-ascii?Q?dQBlyk5ANMvUp/PtUTluyJKPT/ekLYtoscH9QOTRgdGEzzlJs1LuMgXofXhE?=
 =?us-ascii?Q?7CKDhOTllQxzcrdXkxrMJQzPu1doEsgSzhT8P7iKlHj7Zk1wrqngVKnUjoJG?=
 =?us-ascii?Q?xVZaN3CoQ1Dkps/oW7qY+0Bd087D2VBix0RS1vbkLu3qyKiUGBPHbZ9D7E8P?=
 =?us-ascii?Q?mTwJaFRQZ1wU7fUDbFU9Bx3I/fnVhnIISy8fP9e7k0oG3cG5mnL83VVgJnFI?=
 =?us-ascii?Q?ysVo+nhPBPYITObi07DhumylTpHYlp4EOfoHfr7o5ounuKKEvHk4l0wRUrcV?=
 =?us-ascii?Q?ACnFxYcAQ8EneTHt4VmqDzXF3PX/EOwJIKwSICzey5Z3Q3061/XM8wHVuqH6?=
 =?us-ascii?Q?V7XxchrAoms8NrSBsMbG/va82yK7eGh5EQt9EDvMXGWAjd1EnCOsNrcQYiXu?=
 =?us-ascii?Q?UBBFahc0fcpQA409+foP1XrIjHKKPG7sOKoHxy1Moc0WQtK8/y5sf+eMuxsG?=
 =?us-ascii?Q?WE/3RSjVQ2MIhCqedBuGGFF9K3rMrkEeyeJdkP/UrPe30ihNbCgZQxYWPt0A?=
 =?us-ascii?Q?L5fcEXLxhtxIqaD27HwP3L/Y6w0RCd7R9BT/kW/ppstc/EB8svAtpILlhxqE?=
 =?us-ascii?Q?hRhXcEt9gbwWf5PIC+EZUWl65+HlgSWp/u2sz14HcyA1Cej3cFi0APCgM05L?=
 =?us-ascii?Q?wTvzbjx67GjUgUWcJyqFq09/MjraqQM=3D?=
X-Exchange-RoutingPolicyChecked: rvAodVawSxxt95q+XOpwoLI4u8hWxqLkcju6H3Jag8ocNsDG39S7F2drJyyluy16m4uLok/7sq/EicUFtqQKQU7USrNztJLyenlEnc4Cg6Coy8hnFOo+lERM9luOtwRaFEHOlFUU5H3bn3ysq44blOP+fHN3Eymy5qWGxD3acWhFNZ4jEocMqTmIkyRy1t8QTjr4lswDfKMbM+apyo73LP5W+dl9FYRNNm8MqVPoJxXcjnYbd+y4WKjrisnR+fITNojdtXjlpb9jXwhhkx0d0Z0hHAnhZSTCO1hHnhnCOT+Z8jEmzCTCRdvlzOIJZt1dny4QyDOr2Od6FAUjDrEygQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb211abd-b634-430f-c9b1-08df1d626627
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 13:14:17.2708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjoOct7nXePMWalxj5N21pPNeCSFgH2eawIafawdITMPjxFQt7Q7bLId0SJrLydIMb6eILVOeCPQXRpAwxv2EyT5vO3Fk6R9EXlLwtbGu7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9417
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

On Mon, Sep 28, 2026 at 04:12:53PM -0400, Sandeep Penigalapati wrote:
> E610 does not support EEPROM writes and leaves eeprom.ops.write_buffer
> as NULL. ixgbe_set_eeprom() calls this pointer without checking it,
> causing a NULL pointer dereference when a set-eeprom request is issued
> on an E610 port.
> 
> Check the op for NULL and return -ENOTSUP instead.
> 
> Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2:
>  - Moved the NULL check before the argument validation so an
>    unsupported request returns -ENOTSUP instead of -EINVAL.
> 
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 78e19f94c0..b7b2b92e3c 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -7362,6 +7362,9 @@ ixgbe_set_eeprom(struct rte_eth_dev *dev,
>  	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
>  		return -E_RTE_SECONDARY;
>  
> +	if (eeprom->ops.write_buffer == NULL)
> +		return -ENOTSUP;
> +
>  	first = in_eeprom->offset >> 1;
>  	length = in_eeprom->length >> 1;
>  	if ((first > hw->eeprom.word_size) ||
> -- 
> 2.27.0
> 
