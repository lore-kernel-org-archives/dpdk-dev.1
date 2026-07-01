Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FE0C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 11:26:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5372440647;
	Wed,  1 Jul 2026 13:26:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id BC749402E0;
 Wed,  1 Jul 2026 13:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782905194; x=1814441194;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6T7lMxRMfgJ5u2/lYHqWghSMYPrmwOmTPS6rLnDTGFU=;
 b=BkqUKlswpfgeOSV5BnmyOU8o8jIcAyLgdvlRY42CFOdfG/Fs7wTCy5MA
 rDjBCcxaxW3R5p8/smlqOoHdqegN/D/n8shGjiqF3lB175if1vl9NxpLS
 Wr0y4vHVfrf+D0iroAZ+E7yrfLAIV1mBrgN5Zwei5m3RRsmJD01U+xzih
 UivKjPzgo3BykXKC37LJaq8auBxxmBAMnJud5mE/3OF0mnOZA0AYklHvP
 Kn2GbA2/lg3s/mMzvoAu2s8oB4TDTdDJMfRK8N0VJdSebSjKjIevdeiE3
 1x9pYgS9TuPtR/akiPTmbtt2ZzqGl9iH0xEyGo0fVDaEn+2j04ZIDb8yL w==;
X-CSE-ConnectionGUID: yPEBCi8fSKqZUpNNTMPA9g==
X-CSE-MsgGUID: SWVY8avRSZqjeYncmSSsyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83833599"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="83833599"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 04:26:33 -0700
X-CSE-ConnectionGUID: I3EBfI/hQciN5W/etjYIsw==
X-CSE-MsgGUID: 2f3WdhctQCis0AlrPLz2iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="256125021"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 04:26:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 04:26:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 04:26:32 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 04:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkkvvqZMuj1oh1V92TsTw0/I3ADQgm8ByKGVwPObQBj/Em9qRSVOoPvv8n6WMSrGDs3PTURHP7O29pQBWXT26KybP/NSeaSMgcNK1swB0K/UEKi5MsYgEr/vXYUkmKkjbzVBN8swDZY3eyN9//vdWaVmUdj6kcLAYfyBBjPpvqVIDUZw5F8aAswdgohjkVAdbD+gycSN/oOClopWfLWs/quTdgk3u0XzwssZ0SBBVZab1ppwOZFwu4a42vVL1S1XRPIn4PLEkL5itiAjFBn0DlqueS1bCD72rOAxf7fNUrqaBJUxKbG8i8W1wJMhy/Al0MEkEVzQCcXXQXbYMXxQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBtMXcNXgQJH6iep6/5QJeeBFOUDbR5GKVd80IVD+Ss=;
 b=W2X2zcsOIahbVsLkQObN+CvmiQQTuiLZ6Wrcc2rtgGQ7kBMfFIkGYK0TOvj5oRQFs1SWfrtqpwHZYEpj1spv8wHSLjN0mgZwqepD4sl/x18N408oZRem8WGFTPcRnVTc08wg8xei3p/tZSVm7xLTMTsHfbNwEftY0iapCbkFvFzlmmDRgG8cn+OTqiTGYKgC8W5T809GxOXxjl8SfW9unwCDMXpU/ia3bD9hUm6uSUI92spgbdKtVVObUb0Hvu0E+vWYZQWzZlCeVgEOqQ+9ZOgBWFi3nxK/mQ6Uu/gTKJ+6nYlKAnhC9XD75NuZm/PADjpR0nMWlGmSCSzHEFQarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 11:26:30 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 11:26:30 +0000
Date: Wed, 1 Jul 2026 12:26:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/2] net/ice: poll AdminQ if interrupt delivery unavailable
Message-ID: <akT5YUCBeqqcDxie@bricha3-mobl1.ger.corp.intel.com>
References: <20260630141627.1035420-1-ciara.loftus@intel.com>
 <20260630141627.1035420-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630141627.1035420-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU6P191CA0070.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::18) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM6PR11MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd91022-00a9-4ca7-07a2-08ded7639906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|5023799004|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: Nwx3K8xBJ67ibhH2HZr/OZ8ECoBIQLQ83vvyBNX0lmxJrYbfAc+LYNxdFyYLg3E7SPWbrY8aZ5Wss2Fmx/8DaFyeaK9UdrMhZTUIduBz8SLYM/a4Osr8tRK8i1Vm8Gq7autqCOiK+Dv7VJRdM5cQI1ZVDlZLYP7827EZKeEdS7RsQdfWPWgrzVWj55w7u2fLgb+auBCSuGo7cFoE0VxI5LvYZIA80vS79XmDYKxU/yUUWUu9GCDar/GtPH1XO+3W7UFpLy0jk7jftn+XhSuJwUOEGIgfw7yd6v1oUXlgbf3w0OmfNjGT4I1SfJCz46XA0uEXL1AzS+5y6hzU4ohJYLN1mGnBA75LybZaAYrRGXOR3qFQ4vwJbLHwctsXc45nt3PWSUpc/PW1yjc+cy61ghvu+RFDyCjMNS68JDSHkIhuOmEXyR0jhKPBLi9AZYM/7xI4SBZhWVGWPSuPR7+szMGyMDnL+iE9F9VxScbi/DPimh1BzFmUU/3e1BAYf4OLBgrGOEppWuKHgw5e8bYXDsRiTnBL0e+eB+oaSjCOW/37Pc/r2CJGuMZqdTFLZaSWYKVDTVQXogjFC89wUnWeXcRnjF4rLuFvwmYA3e1Nugafseevyjkpraq+IbQJ2PzYSU7e3H5LeOQ5QdFYT2Mk2u0DzZYM/K1J7pZsGJOTN3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JeeATMG0qyAQOfOIlHv/5bvTQKpdaltagEV0fkS/xb4NkjQUxiNLZmkiRsHp?=
 =?us-ascii?Q?ZlA9RqU1uV+6AHMVV9S1xnlAWunYta6+E+tYIV+tVQhq3CI7kprct93oxYoe?=
 =?us-ascii?Q?YGGioIONzDlCG8hqOOn9jFBgzldEzp8dJobKc98K2Q752VmvaPs2k0gqvW1A?=
 =?us-ascii?Q?0ooPdtciN/ZL8EuK/vcH019Q8FnXMUgkK91zm/WeWr2KTYYTgk5oxO8nu9FT?=
 =?us-ascii?Q?YEyg2Or7CB/ihyWcwjAFgax9sucHjrY89fdwgdpUsyzRjlkrOlBqfH6Kbwus?=
 =?us-ascii?Q?FXS4J657lu0qPUkQsiT2kSDk9JZI3tSPhP+7qnYFDvvF2mbCPioC5Ry4Chb9?=
 =?us-ascii?Q?GZmI5Nuok+urygC4gdFvnVY1myL+Ab/zGnEDwiZPNhKbKnHgRJljY0/ocLDD?=
 =?us-ascii?Q?TlDAA2X7bbXUR7iYLlHoJp3Xx+0+P8OdB/WVK9F+pmTeI5GSYUJ0UJ1hxZVF?=
 =?us-ascii?Q?v9pRe5+cqrBiED9dKtMz/9r99mHu82SCj3qmuCaZnr7W3Tsz6uYxTLctRk+9?=
 =?us-ascii?Q?twyAdT/FMgMO6bsAMIIuFnue++Tl6Wm0G8EhZYqtzkoR8o3jqpBhoJDgA8Bb?=
 =?us-ascii?Q?AS43ThPNmBWEu4Wfv/oDSj2zotZsAlgKRAQOzhRN7fIfYirw/xkVybo6W+7l?=
 =?us-ascii?Q?6JRIYFPKIcuqiNZr1imRAz50B2MvUtFnPcocGdoUXlR8bGB6iSLmbPVrbj+z?=
 =?us-ascii?Q?LP/ifukFZ36u0i2SpzvPPYG2ARCi9cf39CDuuASyG5D8xea6P/ZSVeV0TZgz?=
 =?us-ascii?Q?POxgc0B/xX+AIEYrSXmVcKHu2oDLSYsiYhHX/RRb6Zl1Hp0Pgt7X3QlvPj1o?=
 =?us-ascii?Q?Yue4ogRTOT5ZzAN6bPyKaEuDCNektFEV/ntGgoaxTwjkG7kVzoAL8NAgQG9n?=
 =?us-ascii?Q?kROiI5xz1XQHPd5pCrIYNU6uVKSYEA7D/HQRNDe1/vVpGGQ4JzO5UtWbUULe?=
 =?us-ascii?Q?tXULXiV2h538xSl7bMvCgx0Ojg2t32cdcxkoVEQiae9qmGVOiehegTmfxo/t?=
 =?us-ascii?Q?HAGoHzPMLMsTGQdWlCgy1Pc7yTTG9a7qwngBd3mvV/EqnmIR8xjvUhHHavYJ?=
 =?us-ascii?Q?6wbv3jkbabVrixmQKjHWjb5npXmeMbwccSOFvNQbIvnXy+qYrfWsmftpRFL2?=
 =?us-ascii?Q?7hNMqtOuFTPeykVXZltesBUP4unrg6mfjigPG0w1c3JNlB6x1EPQbT3/juv9?=
 =?us-ascii?Q?xdloXVe0CH4m0HBLn8zwhzkvprNn77ZdqA1f8150MOGF7G6NV7W5PkFjP3pn?=
 =?us-ascii?Q?qr+d4CeASz3E32JafrECj/bHOLNC7dDtN+u6OOR6QuyNbS0j4SRSDtOfAS/z?=
 =?us-ascii?Q?22l+sRrzwm3q4TvF/eIkjtGH+L85rnUXbstGcHaQenK35Wec1FUS8KO82GFL?=
 =?us-ascii?Q?v2Yuv6yh+RtvtZj6txjKRqPy5fBIY+QssJDlz8F4ID98+vMKgpbsC7jnbgBy?=
 =?us-ascii?Q?/Af2Zg/yuQgTPQLYELrDOwoSVMTE/6aTbBRHkVGgvg2oj/A40+L0DBAPdVgQ?=
 =?us-ascii?Q?XBSOlhd1r4We0rJAw6O/Aovw8WIVeIccUNHX71CP+ABaPZU0RLsHIlQsEIiD?=
 =?us-ascii?Q?Lc1qFzsmpqPth+6p9k8EXfJlUWqzL+NZVRXUI7rXtdlGLT3G4p+RlZltMvJj?=
 =?us-ascii?Q?zCz/7RTnA91GN9qs1kp7w39jSGwI9kH9FS3uv1JWBI6bPFAnJ51aRRSP0Mkr?=
 =?us-ascii?Q?HSjBAkQQebbqzxX8Dje7bcFwSKRZT+mhjdDg3QYnj3XcRwHkE/fmpX7ztKW0?=
 =?us-ascii?Q?4G9y7vpLTeR24EHePket3qXAYYHHsn8=3D?=
X-Exchange-RoutingPolicyChecked: sem1YPg5pYzZ+I+Jb7Ta2wslY1TS0QJmv431UvJF/2YUKU4OYK2Ez6oNiMMp/SuFg/BkKsxDDGZABHTwwpwX6EVdZ9S8WXCAilj/hRvCxsdK8lL4L0odrVDyPmXAHT0AWJ9i79SesI441KrC6tg8ufItqTgsTl9C4qBYJukxLcQ2ccmFTIqFmV9ebC6Gpq1sjQnfMOWuxOZd5JF+moJMar5G/joJNG2jaNEpCs/Jjn7f7FU141r6YyxIl5kI8q0mnGrBofrRQ8x6RPl9HF/psx6BDHceCvJ9kX/RIiL5KyokrQUfl53gU1uZeUt2miefHZGWzwm3YDegb6ylh8zhTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd91022-00a9-4ca7-07a2-08ded7639906
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 11:26:30.4015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgWKGDJ0NmDhPiWGHJA+prSaNu1KdVEdR0j+1bEAwba+NPSV1KPMSQa1cJvdxNQmPjUY3sPeQ0ck2vWRZQCejxRXL/ExwhZQrTvT2o01c0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
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

On Tue, Jun 30, 2026 at 02:16:26PM +0000, Ciara Loftus wrote:
> If interrupt registration fails eg. on FreeBSD with nic_uio, the ice
> interrupt handler is never called and AdminQ messages, including
> unsolicited link state notifications, are never processed.
> 
> This gap has always existed but was partially masked by the blocking link
> status poll in the ice dev_start function, which would delay some time
> until the link was up before returning. In this case, the link status was
> typically correct after dev_start. However after that delay was removed in
> 2dd7e99855 ("net/ice: revert fix link up when starting device"), the link
> status was often wrong after dev_start, and there was no mechanism to
> self-correct.
> 
> Rather than restoring the blocking wait removed by that commit which
> would re-impose a startup delay on every platform, instead activate a
> periodic alarm that drains the AdminQ on a 50ms interval, replicating the
> role of the interrupt handler on platforms where interrupt delivery is not
> supported.
> 
> Fixes: 2dd7e99855 ("net/ice: revert fix link up when starting device")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

This solution seems reasonable. Some thoughts and comments inline below.

/Bruce

>  drivers/net/intel/ice/ice_ethdev.c | 45 +++++++++++++++++++++++++++++-
>  drivers/net/intel/ice/ice_ethdev.h |  1 +
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 022d92a2f6..447742ff8d 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -3,6 +3,7 @@
>   */
>  
>  #include <rte_string_fns.h>
> +#include <rte_alarm.h>
>  #include <ethdev_pci.h>
>  
>  #include <ctype.h>
> @@ -108,7 +109,11 @@ enum ice_link_state_on_close {
>  
>  #define ICE_RSS_LUT_GLOBAL_QUEUE_NB	64
>  
> +/* Polling interval used when the interrupt path is unavailable */
> +#define ICE_AQ_ALARM_INTERVAL 50000 /* us */
> +
>  static int ice_dev_configure(struct rte_eth_dev *dev);
> +static void ice_aq_alarm_handler(void *param);
>  static int ice_dev_start(struct rte_eth_dev *dev);
>  static int ice_dev_stop(struct rte_eth_dev *dev);
>  static int ice_dev_close(struct rte_eth_dev *dev);
> @@ -1473,6 +1478,28 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
>  	}
>  }
>  
> +/*
> + * Alarm-based AdminQ polling handler that drains the AdminQ to process
> + * async events, then re-arms itself.
> + *
> + * @param param
> + *  The address of parameter (struct rte_eth_dev *) registered before.
> + *
> + * @return
> + *  void
> + */
> +static void
> +ice_aq_alarm_handler(void *param)
> +{
> +	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
> +	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +
> +	if (!pf->adapter_stopped) {
> +		ice_handle_aq_msg(dev);
> +		rte_eal_alarm_set(ICE_AQ_ALARM_INTERVAL, ice_aq_alarm_handler, dev);
> +	}
> +}
> +
>  /**
>   * Interrupt handler triggered by NIC for handling
>   * specific interrupt.
> @@ -2913,6 +2940,11 @@ ice_dev_stop(struct rte_eth_dev *dev)
>  	rte_intr_efd_disable(intr_handle);
>  	rte_intr_vec_list_free(intr_handle);
>  
> +	if (pf->use_aq_polling) {
> +		rte_eal_alarm_cancel(ice_aq_alarm_handler, dev);
> +		pf->use_aq_polling = false;
> +	}
> +

Do we actually need to cancel the timer here? Since the callback itself
only rearms on started devices, we can let the timer expire and become a
no-op, rather than needing to explicitly cancel it here.

If so, and based on other suggestions I have below, we may be able to
remove this block from stop function entirely.

>  	pf->adapter_stopped = true;
>  	dev->data->dev_started = 0;
>  
> @@ -4434,7 +4466,13 @@ ice_dev_start(struct rte_eth_dev *dev)
>  	if (ice_rxq_intr_setup(dev))
>  		return -EIO;
>  
> -	rte_intr_enable(pci_dev->intr_handle);
> +	/* Fall back to polling the AdminQ via an alarm on platforms where
> +	 * interrupt delivery is unavailable.
> +	 */
> +	if (rte_intr_enable(pci_dev->intr_handle) != 0) {
> +		pf->use_aq_polling = true;
> +		rte_eal_alarm_set(ICE_AQ_ALARM_INTERVAL, ice_aq_alarm_handler, dev);
> +	}

If alarm set fails, we should at least emit a warning, even if there is
nothing we can really do about it.

Also, I don't think we need to track use_aq_polling at all. Its only use is
to cancel the timer, but all places where we cancel the timer are places
where we mark the port as stopped (with one exception, which I believe is a
separate error in the code), so the timer will self-cancel at next timeout
expiry.

>  
>  	/* Enable receiving broadcast packets and transmitting packets */
>  	ice_set_bit(ICE_PROMISC_BCAST_RX, pmask);
> @@ -4497,6 +4535,11 @@ ice_dev_start(struct rte_eth_dev *dev)
>  	for (i = 0; i < nb_txq; i++)
>  		ice_tx_queue_stop(dev, i);
>  
> +	if (pf->use_aq_polling) {
> +		rte_eal_alarm_cancel(ice_aq_alarm_handler, dev);
> +		pf->use_aq_polling = false;
> +	}
> +

As explained above, I don't think we need this block either. If we have an
error on start, then the port should be marked as stopped and the timer
won't rearm itself after it expires.

NOTE: there is an unrelated bug in the code here - at line 4550 in start,
we set "adapter_stopped = false", but there is still error handling at line
4564 which causes us to jump to rx_err and stop all the rx and tx queues
again, but neglecting to reset adapter_stopped back to true. I think we
need to either reset it immediately after the rx_err label, or move the
assignment down till after all potential rollback points are passed.

>  	return -EIO;
>  }
>  
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 20e8a13fe9..86b256fc3f 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -599,6 +599,7 @@ struct ice_pf {
>  	struct ice_eth_stats internal_stats;
>  	bool offset_loaded;
>  	bool adapter_stopped;
> +	bool use_aq_polling; /* true when interrupt path unavailable */
>  	struct ice_flow_list flow_list;
>  	rte_spinlock_t flow_ops_lock;
>  	bool init_link_up;
> -- 
> 2.43.0
> 
