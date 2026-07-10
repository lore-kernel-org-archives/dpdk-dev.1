Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91308C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 09:22:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66B8C4026A;
	Fri, 10 Jul 2026 11:22:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 79540400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 11:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783675357; x=1815211357;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=j9+gsUPc67og3bhHQIodlyqiOKhgzhniPnHDsinGU4s=;
 b=NnQda3QYkhvrSFs0pA8GoeAFns09JBcXIrf2CWvIGscdtzeup0xxPS0l
 e6bb7c2BNopZNY4G1edivXhz6N3fbUoq+y7gV0au+2XTp7yZ3jNFPa3Jq
 T1e0A8gxtSqEuQZho8lcAznKX4fz+AHUUxhSCTPwzPPo0Yi94Erm1be+S
 qR3OqQh4D8pRPhEt9YhcowOcq5SypRaObY8fU0rcO98NtrbwHcvQBf2QS
 RtWh0B23pDXFuKvzTWmFWoO3214xPmdBQcr3rqMT0r1USRln/mFxLSvJj
 Mrccz2JF2McnLU1Qbr/DR3ayTHmVMCE/u+I9k0zS4bjSWX8i3UZNr7J7H g==;
X-CSE-ConnectionGUID: 47H3ecixQDefWAZKTkV7KA==
X-CSE-MsgGUID: 6W9uBvAaQYK/x6o6lP8GBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101798108"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101798108"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 02:22:36 -0700
X-CSE-ConnectionGUID: wDTJfVSsSX6uRb6HbxSw3A==
X-CSE-MsgGUID: KfvJJVL3QzaopS0fBS9jFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="254337047"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 02:22:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:22:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 02:22:35 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlNei8Elu7PzKX52qoOkXfyYKOJKsHeuzWJvkvLFnB3RI6HOF+48H3quThKoDL3sJcEM6mWxANfX5vThhTp3axyo3EKTQLZcLOf8O9PVengE+pVpfxApYidkY+uTUkfJaq2dg3mWdHqhKDuyPR5GxwSgu4Qw0ipvcopdSCcltxH5C8dM3+cFfKs0LSzvq7zlT7qd+7NOBKDd7fYSpUJ4chKUCC/8RgiNHx9I8sDj23c/yVEwWF8LSY6KcVjucxKJBTt/VsTmSchCwaaOXlP1EMYF83kwq1F4HPZf7L6ZYgESwJkI1sSZAdVf+oE7iKzx18vZx21ELP63ATEWZRjg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7pEqU/cxPLUlW72mpEZksxfSbU/ajpfdxn2CyU2NDA=;
 b=tExXWHptdUuIEM2N6w5fRUKgd/0elXBzMlHed+1JYzzDUn+2n6jgJZbD2YGanJtf+L/MBdyNjikfPmU9ArCy1KSqMcFyu5yfmCiqO/WjJTHBSKDikH7QKEVTb8saunb4iJbtOFcoBpTHv0FFIv8OZu1ZkYuIzAd87YgnzGFcYRqRAcCqRwVyY7TaaoWdu5OSrznUysaagfi7jghYhS2A669Sj3zYZbN/z+UNU2R1YnPFncrBzip+PNNpI/8JjrR6sUy0S8ZojUGj36L028ccuVoLgZokWNGTpkLn8Tz/BNYFNpMDwzKIxLwJZozNwoEaNk5rTKuuGdD4d0VZzvr67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA3PR11MB7977.namprd11.prod.outlook.com (2603:10b6:806:2f3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 09:22:33 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 09:22:32 +0000
Date: Fri, 10 Jul 2026 10:22:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] net/intel: fix link status when interrupt
 delivery unavailable
Message-ID: <alC51J26VzyF0YEu@bricha3-mobl1.ger.corp.intel.com>
References: <20260630141627.1035420-1-ciara.loftus@intel.com>
 <20260709112556.1765262-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709112556.1765262-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU6P191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::12) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA3PR11MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: eb43ca7c-4fed-41a2-e8c8-08dede64c58e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|5023799004|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tjkKEYq6qqCkWyrKMvmw9tRiypZm7rMix7dZuSaiBR+7jVFegEky17vS1PkJbj1DmNiYvxe1P3V+B5IqXj0kFWiLMnz22EHA+VHpVEMxyfvJrUywvKBM5a0EljGgrYJtwE1ol6yDNhZlvx/O7oPIEVNrvnAM3YrVo5VTTGJGxIo07K9P1gEaqPlxV+IvNcyYVB5ugzNMq0JoEvBrFpDu+eat86eODTy2xNtrjG9sjYvZ8wUfeNiCT8ze2OUTzyeDQ7IvfFLngImBrnvd+FRCWLYd19VQgpOcqF799NWw0F/tEfNty0zz92UEO/5oarHThBz8UtmmNTX0fPG3YJqV77Rcz5zcpVXsAxP+flNJswDvX2NXD7ponEq03EVzdfSM9nNX7UJnXF1IQfTZP+tQk5zWzhzuuHaGtZa9oEg2ho3UxY7E65xdxExFt+o2ngQz6oPnxD5qeZr5PRvi5k4FFlCK+0MOsVy3JO9H2G3SqFj9f1IJ0JuQ61F5au31snC5dMYyyon/PV2g7ssAl0h5mPKDdn9l+EyC/XTbKxGjVilUtbx39+ShOiwmMENuM6OaUPRFi4AwI0aYG92MpyDBgWehlHNmATSPMGDqGf+O1egNsYojlLivKa001Xa08vseC2mqpNjvJQne4F3ScAMAdytGES8PMNEpLBOgWGqRp1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JoJfcX3BgzqDRHqtvPJnLfOQbUb8a0lrTQ5zfaQOGmI3+IuZSDh+zfjOGzZ4?=
 =?us-ascii?Q?Mbtb9o1sFZkC387HVNWWfhzLYSpQglBWQuc/1opmSdqEapWbWbF2fRxwgnIM?=
 =?us-ascii?Q?J+K/OWUTdoAQRB8C8ONlQ4bC2M20KMmTo9fheUA2zhltCfskEgZeH0wjL2JZ?=
 =?us-ascii?Q?UfMfkzKvK7krq1dLVmO54dJeC4syrEH0iu5lLLRr8yIzcYI+7jEp0cLLSa/9?=
 =?us-ascii?Q?wEYKs7wc6kVq/NpFLUZCSYUfpT0qf2Zz2fdABLScyx/ecxMB3Un6QZgo28jN?=
 =?us-ascii?Q?sycCSu+Jmk2PR8LO6+eYw26Ge8zMVRNQVw8tJals9hueYarv0kYuwKmmesQT?=
 =?us-ascii?Q?/u90Gv9/22dBDNWqrvAcgJyc0fe5uSIQ9pmkWW9wvV35/feSzVjSHrEfgES0?=
 =?us-ascii?Q?PVT9l38vtRtiWfP0+rLwUVTjZZtKW+cnK7s0IAqOMSDm65IbHr7D3BgZ65UC?=
 =?us-ascii?Q?9EpqHSy1GJBOP5RkbZNaPv5h+HpWa/aLDUALs2cw8M1GVPrkHKmQ8b9cGvNO?=
 =?us-ascii?Q?9MZjq6kRgzh3kDauHn4oomBuiSq911fBNg2UEtJXDyBssGz7qZTae6ZA8kEe?=
 =?us-ascii?Q?c03CLu5WQksqYww/WdJl7OXYEXzuf3jLf4G22cU8BqzFA/Z/88Wu4LA9b66H?=
 =?us-ascii?Q?pOZm0cosFtLwGvIfBznz/aaWB9mz7AlVYQwWgNy7KY/jHJG0ICXEHtOtB6fb?=
 =?us-ascii?Q?QptUXbnqPxOqA9IxZUbldbHu5mvMXMaKj1G3495x7ULi8Kkd6b8hY91aHLgf?=
 =?us-ascii?Q?0+JBja35RaXl4nvQrEKcVxHarbP02JK6dyXDHTshtR1yRLO97QcFZbxwXS8d?=
 =?us-ascii?Q?Kc5PqMcrXcsbABx6UuPh8n+LF48PdU5pb6cd8eKH6ubQ+RfMk+0P0soruFXx?=
 =?us-ascii?Q?h7s4Q87t9JOU/kB1hal450MHIV4swxKH+CmNhelBAGD4M5nhWepc7Vwuf3+J?=
 =?us-ascii?Q?TAu0wVvOkUCsOYlPMXjLwX16434/hEA4yhERJn6KbVMmw4EkvOr/ho3iwDEz?=
 =?us-ascii?Q?lmHQv0G7D230i7FQKixFUAP8JzBuIN5FU2HzmlRJ6DTO0hJMFgA9ISTBtsCZ?=
 =?us-ascii?Q?TsKiFEZ3CHNEDznA03/uvUY1l2B/XPuR+KB+mUCLM3TqVTRbeLfuu+e/tqIY?=
 =?us-ascii?Q?6XhyxtZxX4RR/0iEDcXKeAhAB2OArHROVdSNSkyDdFaF0YUPwJHItoTAemHj?=
 =?us-ascii?Q?0RpNVa+uuQzLXm375XqVVBgtqQJKNC8j9G5L0sK9sCJuSNz2qrrqyKM6oqBZ?=
 =?us-ascii?Q?PMaqtT8qPhL7CEMJEhj4Gv9n08KonyR/fe26woUXUI0LZcdfkmWFXpSY7zrn?=
 =?us-ascii?Q?tX4QDNOkZ+ll2T8mCDaWm5PaHHy/VdPQBcB8h4i3m2wMel49xmsQ2MTCmmCR?=
 =?us-ascii?Q?Uq24WGbO0Q6fOZgBzgC0ZozgOI7Q6fDnIb2OQ581PkfadQxFGMnDMWdv3Nw4?=
 =?us-ascii?Q?7r7wwfiKcJ7KhH3Z1vbVzm7redtgmLGHo9f/4V/4wh6CyCSHR5USmhclQsV3?=
 =?us-ascii?Q?eaBb47DcYyb7eFmlgeJVMRToV2klvtNUEiBVJmBPlawZA3Ab+q3jUpglz1rz?=
 =?us-ascii?Q?m9WZShgQkc0Jc2LmjL1dzGOBMquu7sn0sTVScI6bONTsNEOM84IFxnc5xjV9?=
 =?us-ascii?Q?kONq1CatFS7Fnc0n2dy6pb7Y1LSEaVhENcy58liDQtMDMiimg9WFQoczwJ4D?=
 =?us-ascii?Q?8plVE2cNhwYCd6AeOhc+7jyND6cRQxDSPq+a34EfzzQM/MzvvpJDnUjeV34b?=
 =?us-ascii?Q?JIYBSErrY4FXpib+KLpLuMqqKb+/niI=3D?=
X-Exchange-RoutingPolicyChecked: HOnLEKPjCbQxQINzRNcwAKSid2ncABVuOIxSUo539Vn24IdmAVCL2DMtajbWkQSLaj9W9Zlgpts1MaJig5DKWMpKunNVmnwpvrGsPlw9+XK1Oi3rIZ5G32ehcDPKJAIRiwb5S6Sf0dulm1vY/BFzlDuO7cN/Hnn9gmFWqXKIm1Xin6Gx6Fn2PifTuV+mG9vykI5eMc6bZT7kd3BVW79TNde5eAR4BxHrz1COR7hzQijc/GH30P50wa+CoHrRnAbjn6zc5jCSia1nQ234oP1sMmKXK3iLvO3YsvweQHMZPeGM1PWTPipXIn+PQlPXtKrKGJ+ZGGwk5ZFIszG2OgZ8kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb43ca7c-4fed-41a2-e8c8-08dede64c58e
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 09:22:32.7781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGTOVfJ6ZQwiacYgS9LOEzaSeGwHiF0N4Fi24Rdpxx2KEEPgmD5iYl26EZbS+Z1cC7Bm5P8bbIJH7ftPiA5zABzxvdat9bI8fememT49aPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7977
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

On Thu, Jul 09, 2026 at 11:25:53AM +0000, Ciara Loftus wrote:
> On FreeBSD with nic_uio, interrupt registration fails silently and
> hardware events, including link state notifications, are never processed
> via the interrupt path.
> 
> For ice, this affects the typical polling-mode configuration: the
> interrupt handler is never invoked, AdminQ messages go unprocessed,
> and link status is not reliable. A periodic alarm is added to drain
> the AdminQ when interrupt delivery is unavailable. For i40e, an
> alarm already runs unconditionally in polling mode, so that
> configuration is unaffected. The gap is the interrupt-mode
> configuration, where the existing alarm was not activated as a
> fallback when interrupt enable fails; this patch extends it to do so.
> 
> v2:
>  * Added warning on rte_eal_alarm_set failure (i40e & ice)
>  * Only set use_aq_polling if rte_eal_alarm_set succeeds (i40e & ice)
>  * Move alarm cancel in ice_dev_stop to prevent a race (ice)
>  * Remove unnecessary alarm cancel from ice_dev_start error path (ice)
>  * Added general fix for ice dev_start error path
> 
> Ciara Loftus (3):
>   net/ice: poll AdminQ if interrupt delivery unavailable
>   net/i40e: activate alarm if interrupt delivery unavailable
>   net/ice: fix adapter stopped on device start error
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to next-net-intel.

Thanks,
/Bruce
>  drivers/net/intel/i40e/i40e_ethdev.c | 11 ++++++-
>  drivers/net/intel/i40e/i40e_ethdev.h |  2 ++
>  drivers/net/intel/ice/ice_ethdev.c   | 44 +++++++++++++++++++++++++++-
>  drivers/net/intel/ice/ice_ethdev.h   |  1 +
>  4 files changed, 56 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0
> 
