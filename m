Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0673AC982D7
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:13:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E6C740647;
	Sat, 19 Sep 2026 18:13:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id ED9B540272
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834388; x=1821370388;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=VXWevDVeVyIjUPxENNSMnsWwaS9twpnMMrIqUPEHkxM=;
 b=nhDWjTojF86scm3OkWmyhAs/Z9PZUN2ZJoehrTpKz+NdToXKO8mBJ2bP
 mqXRxUBMv3LS5b8/WL/wF5e12n8I/xltQqmtsfbb/hUPnv4UZEljHl4h8
 tLdSDbvDTEFjzFqNlDH62/f+5QRcEc3nDav8qvElKoBFAnV81vOnpVb+2
 fRVXYzk/iTg8YujbP2KdGQ/gdN9pznEz8RGPb4c2GGwIkZqeZXvEI59Sx
 zgWMYiH9qDX/a5p/421ncmjw/pef1NJM84TnX5Ep2Pw0pw7JXzSzJJ6jC
 ZDk8qVgTcP4+A674yGkVqjOtjNE4H4CXX3pmgrlxq7ggKwAxurScyKDcz w==;
X-CSE-ConnectionGUID: 3ck1aTvOTjKjpASg8MCjiw==
X-CSE-MsgGUID: UslLQjJaRHumVDBFCg/krA==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="89490939"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="89490939"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:13:06 -0700
X-CSE-ConnectionGUID: ZrQrtduLSty/c1cFqz098Q==
X-CSE-MsgGUID: v0m9zE1NSJKZcgmuH2mpdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="268545663"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:13:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:13:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:13:05 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Msj2ZpdmSNBd6nUxnxmpv+fy4S8t+VzAGFS9PYh3Cb5UVKWlD8TvyshwqSiyFchMqfAJLYAPDqw81dMLHOTobYbrwW0BT4PPNYQWAL/jP2Hgq+QgGTWsKDzVCUX2lQPkf/tThKCYzqESHiB3i0Swdi2J/7SAXXc+3zuX7nHO+ClH+yHisLqQLqOOB9Gm/MadK9P/vA+xRcN0R6s7OconAUEJFH0iJysDGfV56xycrF/565RgAqC2prbTNabgg6/98R2sba3BCOkhggqBhrr3iuYf3KukAU1oAqCIkF2KlgZ5CuKSBBZW9AJzhNYUbCB8dsgyVWGr3Dtyb73hEc0Fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j+7WFDHYSGfsaXA1qlrgEgSKnDGnVhthqrJqd4LFQ4=;
 b=JLUc7ZaRELX27+tef3rdb9b90iyDQBd+OJBE/A/EZtti78NKUmc4y+xNKpfcOOfPmiXcePWAgyEyeCZ6jlQwOD+V21eCWk7EXC7A2pyiK+iYccPxsgIIrey8ytxRSe9rn6v+4R39ky+TgF9ZyHrqTPOGNZoIlZ/ixkDQe+D2gFjPNGbm/T0KEC9Sb4Hvh5yaEghdOL7KU9OVifexwqnGL+1Z3iXVcAWJ/Mhw0CKURKU51Eedk552kMx2/2dMdx46ED3SDnerETLwikqzxKFZ7iPCUYVksvodIb2Gta3orvBJDhz1SSLWAujcR2tDjsyxfvTEPK2R7gP1xbbWgpnVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:13:02 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:13:02 +0000
Message-ID: <f6aa207c-9d03-41de-91bc-af2c8e05bd74@intel.com>
Date: Sat, 19 Sep 2026 17:13:00 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 13/19] net/i40e: add support for common flow parsing
To: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <15e95397fecce4dd21813635cf82b52c829d44fe.1789560946.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <15e95397fecce4dd21813635cf82b52c829d44fe.1789560946.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::7) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: f1218bb2-08d8-4963-00d2-08df1668e15c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Jrzm0/ZzV2Yym9UUgRjWPbO+GahqaWCzWvBXsVEiYf/2qYZxf+b+WQODTps1qy+kT+xO5Fih4getPobpQUtxiHw7ASanZt3fjk9HAojaEwxRa3yQJ3aMZkSWFcFHnzsOObwSaSC39nhct0ErPnf3GMdSwx38kwrT9E/g/mHCfVvazsJNec3Wv4pjSjeFph0G8WHnxlOL6DUX42zo/yVmm3bp3EhcFSVDZz+V37gdsvwi2KToMlwHSpvfpNDzr9Chu42usY5oSIUgyeaJ/KjxXIpI4UdBnBRrL2o2DLXHHSOCeNNMlVjNKXJ8XlE9mE4qgxmq5Pf5OzHp3IICKfvUDTVthOfDXnUmtT/nBUpgUCquvrj3lz46XLp75gTV8INkdJ4vplEfU7mRLH54jS7VHkgFaKlSbCmWoN/joD16cCld/Sd2r1iO6a16hijzkzkEExZ4ub1L0JEeFuN02OgUyobbSzf/j8Se8CvbWl7r9rIm0Yisxka9SWlCjr3Kd+L73lem0H6BqlEhyetp8Iwncb99acx+50oCvHwrN8u0Q+a/Vby64bagYuSN6sn3z0Kr87i4LNHa7geWi3f7xwVBHryQuZT1cKGdd8hxvDgDXx4umNJ05XklicsLi0vAuPFNYl/iInhoR82sof9Vy+pYlU+sFI3ajqliaA2BxFV9Ja4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTlRRG8vajYxdFZjdzNEZjVDa0Z0d2gzYnJzMHUvaHVEZ2VJN3daQUhGdkJa?=
 =?utf-8?B?K3BTcFM5SU5UdmIzNk54TTl5UE5ZdWdadDVFc2M2SnIvZFpHSFZ5L3ZLWS9M?=
 =?utf-8?B?cUFpR3o2N1R0U2hocEkrdVN2bmQrYkc2NlhUU0RUTGlERFUxaEV0SmluZjRZ?=
 =?utf-8?B?amtadVNMeXRocnl5eHowSzM0K3VzV2ZWdWwvcVVUL1I5c0NpWjlXT01pOFFQ?=
 =?utf-8?B?UnJNczllWFdkSFJqQlFQZEVtTHJXWkkwSUpUcVR3bjE2elZiaHpTdE9qWFZy?=
 =?utf-8?B?NEVjNnUwclgzV1dhck5jUVFLWnVyc2dOWlVRMW5SeVRUbkxLSktOUXRXbkNS?=
 =?utf-8?B?Z0E0bUV0S21GL0UwOXRjYms3STl1U3N4R2poUUZ5VC9kS0dwcEt4VXZocnBz?=
 =?utf-8?B?OE9vOFpIVlc4QVNtUXAzbWRUOVliV1dsRFNCVDR3Zld0R0c5MHg2T1g1KzJV?=
 =?utf-8?B?bXBJVkJXUlVjZXFVb2FkNXJGYjdtUWFCckNPWFdNN0piMlUxTW5yaWZIVTQ2?=
 =?utf-8?B?WVBSOWVNU0poR1JRdjU0eEI5TW14UXJIdGVzWGJjcGJoYkFaeHU1NVBVdmtq?=
 =?utf-8?B?dC9WMWJUMzY5cXZIY3FqelBWd2N3UW5rK1FGUTUyY3l5WEJrZVVOaWhlZklG?=
 =?utf-8?B?anlRNUV4b3NPZDdIbHpIYVFaK012VHMySFFxU3VzeUhBZWIwMmhPWUZhQVFO?=
 =?utf-8?B?NklER3QwL2NQcW1VN3lSTlYrSWI5UEFPMTc2NGJCQi80TnVjSkxyNXl4Z2FP?=
 =?utf-8?B?anJ6R2pUZGJwSit0QTVPRDNHVVVWUHcrcGFob0swSUFrd2hNaFpUZktxbXAx?=
 =?utf-8?B?aEsyL0RsTDQxcW9CZUh3UjZWRnM3cmFXOGgwMTM3RDZZOU5reENrZmhDR0ZV?=
 =?utf-8?B?aFA4NzRWWDQ1eG1hTnYxY2JXUjVtNVVUQWthcUxuWk1MS1NiazJVdDd4amJO?=
 =?utf-8?B?cURuVHkxV1RjUmhSdUU0K01xem5JRnFzbWpHTG85UGMxN0ZzSFBwT24rRzFr?=
 =?utf-8?B?WkJTZW9XemI2VEZ1NHl5SmVDQ0V2WU9vV2FOeHlYV1BJZDBhMlkvNktYM2JV?=
 =?utf-8?B?WVJnaHZ6ZkpjTnlZUHU4ZnNpVG4veU1ORVFXc2doRFJqU2NMeE1GcmQxaCt2?=
 =?utf-8?B?UTZXeEw0V2E1ekdId1ZkWC9uMTV4WTR2NEtQb3krYXhReDEwWEU1bEx5Mlk4?=
 =?utf-8?B?TFU3REppOGpwWjdlY3JPeTVoYzdYVHFoTG9odnBsNldvbmxROEpHTUV0ekdD?=
 =?utf-8?B?NUlkZXF2c1dneU55N0daUUZpMUNBcDh5RmEzOFJKQjdjVUVlaVdZSHdWblBq?=
 =?utf-8?B?WXkvcGJPa1NOdllGYWlPRmZYVkdBWkxEYk1wWmcwb2tDbTN1M05XcjBXQis5?=
 =?utf-8?B?L1pLMkVuRjEzVnJKUFMrOGsyMmpaTnFrNFBuWDJsR0ErNm1Ic1dTbExYOUo4?=
 =?utf-8?B?TnVGTnAySE1mbHBsTk9nTmxkdks3WVd6MGQzNUtnaFRmdno5ZVNFT1FmeGtN?=
 =?utf-8?B?d2pQUzNlSUhOZjJKUkxaNVV0KytPdXZ4d05WRXkvMWh4T0RWUTBNMUJxOXJm?=
 =?utf-8?B?QVdpMFR3QVZaeTRzeVJ1WHRtWHJ5algwMVVDNDZNcGNYVXRGU3phVHNpWkFP?=
 =?utf-8?B?OXFFV3FXekVxalowcDlXTlNMdGxmM0treVBmVit4dWJVUEc0b2lPRWRqUjFP?=
 =?utf-8?B?akpuQ2htSjJaaE1xaVU4b0lVL0NyZE1KNkxCd21VVzB1WFVlVTV1RGx6Qjdn?=
 =?utf-8?B?dWxkajdDb1lzSFJMalJLUFh2aTFObSsra2swbFJuQzJnN0pQQjJzZ3NXdFJz?=
 =?utf-8?B?SFpDa1RkdHZPUHNVUUtDYlFDdkluL2FIMmo0NjRIVmhUTXpjWmg0djUvb3Va?=
 =?utf-8?B?cm52V1BBTmNkSEhIVzZDQ1NuUmc0ZnFHUm9FT3kvS2FVQU1VR2FVdjd2T055?=
 =?utf-8?B?Q092OFFQTUkyWkxtUTBKaXphTkplMU1EcTcxR2NBNE1IaHNJcTFJTGtqVHhl?=
 =?utf-8?B?MTRTa2l2L0JOWGVndmZZMFVOMU1GcWZrMGVWaVhucTFVb3dUUk5kSnQ4Tjhy?=
 =?utf-8?B?K3N2eXdqOXY5QTBSUUNXeEFpSHE3OElxNHFtWW55N0tnanpXbHFBQkZwSGNk?=
 =?utf-8?B?YmVkSkVXbi81bW8xUlNHZ2d1NndtN3hGc0tJMnc5TE5LWWtmZHhzcXc0RDBz?=
 =?utf-8?B?enowS3pDNy8vbzVtamV3MFdpeHI1c1E0QmpuQ0liQ2xHcGROV0NJVVhrZGt4?=
 =?utf-8?B?aGV2TWVIVGR5SXNIeXhlQlhXcHhyK1dqOGNsN2c1a3doY3lkdmhzaXdQYXlL?=
 =?utf-8?B?b0hvMmU1bksxK29wNDQ3a1N0dFgrVjdaUEJJWXZsckpTOUptRzNZVE54Q0R1?=
 =?utf-8?Q?tyBoVqqbiV/f24dM=3D?=
X-Exchange-RoutingPolicyChecked: YOrlvrwlp/yeFn+61l0zComFKpqJEJZJ+8DwnJ/+rECBSDdYd7xfVwl1J9lwZebSN7YTowC/Vm1/r8SseEs9IvXabrGNv6GF5LRWyLbu7CVIYOI/qlo+VbxmPXnAhzpPdqL9kGbD1nyi2DtPrBYvE3Luba9SOtqEb8gznrJoN9KbN1WJcnhIzsxlZIHjrTE2K/DpP+Gh16aOhwY+9fMgyyI7BgisASm16iHIUohoMu70JNe8ZPAqaXPYVon6hKRW4Of14MnqzqCaEY7AOK77PAO9Hz4xizT0NpgwMWiehsbtv6BbpdyRmllK01qdEBDlTON8CWuilTuYutcmTNQZdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f1218bb2-08d8-4963-00d2-08df1668e15c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:13:02.4102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQOqMIN3ZaKU6xMI9o0JmOyo4lRWKJmShymM8Rmh3gvoZblgpcwPrB70N1qYK8cEs/Rff8D7k7WCOKPq6kzevf9uxmbSfdnjZ+3BnWxGiJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Implement support for common flow parsing infrastructure in preparation for
> migration of flow engines.
>
> Currently, i40e explicitly clears KEEP_FLOW capability flag, meaning that
> it advertises that all flows are flushed on dev stop. However, in
> practice i40e actually restores all flows on dev start, so while we will
> not (yet) advertise the KEEP_FLOW capability flag, we will also not flush
> the flows on dev stop with the new engines, and instead replay them.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_ethdev.c | 21 +++++++++++
>   drivers/net/intel/i40e/i40e_ethdev.h |  5 +++
>   drivers/net/intel/i40e/i40e_flow.c   | 53 +++++++++++++++++++++++++++-
>   drivers/net/intel/i40e/i40e_flow.h   | 12 +++++++
>   4 files changed, 90 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/intel/i40e/i40e_flow.h
>
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index d64d8dd7b56..a7fc82f67d6 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -42,6 +42,9 @@
>   #include "i40e_regs.h"
>   #include "rte_pmd_i40e.h"
>   #include "i40e_hash.h"
> +#include "i40e_flow.h"
> +
> +#include "../common/flow_engine.h"
>   
>   #define ETH_I40E_FLOATING_VEB_ARG	"enable_floating_veb"
>   #define ETH_I40E_FLOATING_VEB_LIST_ARG	"floating_veb_list"
> @@ -1838,6 +1841,12 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
>   	if (ret < 0)
>   		goto err_init_fdir_filter_list;
>   
> +	/* initialize flow engine configuration */
> +	ret = ci_flow_engine_conf_init(&pf->flow_engine_conf,
> +			&i40e_flow_engine_list, dev->data);
> +	if (ret < 0)
> +		goto err_flow_engine_conf_init;
> +
>   	/* initialize queue region configuration */
>   	i40e_init_queue_region_conf(dev);
>   
> @@ -1846,6 +1855,12 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
>   
>   	return 0;
>   
> +err_flow_engine_conf_init:
> +	rte_free(pf->fdir.fdir_flow_pool.bitmap);
> +	rte_free(pf->fdir.fdir_flow_pool.pool);
> +	rte_free(pf->fdir.fdir_filter_array);
> +	rte_free(pf->fdir.hash_map);
> +	rte_hash_free(pf->fdir.hash_table);
>   err_init_fdir_filter_list:
>   	rte_hash_free(pf->tunnel.hash_table);
>   	rte_free(pf->tunnel.hash_map);
> @@ -2613,6 +2628,8 @@ i40e_dev_start(struct rte_eth_dev *dev)
>   	/* Set the max frame size to HW*/
>   	i40e_aq_set_mac_config(hw, max_frame_size, TRUE, false, 0, NULL);
>   
> +	ci_flow_replay(&pf->flow_engine_conf);
> +
>   	return I40E_SUCCESS;
>   
>   tx_err:
> @@ -2715,6 +2732,10 @@ i40e_dev_close(struct rte_eth_dev *dev)
>   
>   	ret = i40e_dev_stop(dev);
>   
> +	/* free the flows and reset flow config */
> +	ci_flow_cleanup(&pf->flow_engine_conf);
> +	ci_flow_engine_conf_reset(&pf->flow_engine_conf);
> +
>   	i40e_dev_free_queues(dev);
>   
>   	/* Disable interrupt */
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
> index 1e64a2d2800..16b67268f7f 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.h
> +++ b/drivers/net/intel/i40e/i40e_ethdev.h
> @@ -21,6 +21,8 @@
>   #include "base/i40e_type.h"
>   #include "base/virtchnl.h"
>   
> +#include "../common/flow_engine.h" + #define I40E_AQ_LEN 32 #define I40E_AQ_BUF_SZ 4096 /* Number of 
> queues per TC should be one of 1, 2, 4, 8, 16, 32, 64 */ @@ -278,6 
> +280,7 @@ enum i40e_flxpld_layer_idx { * Struct to store flow created. 
> */ struct rte_flow { + struct ci_flow base; TAILQ_ENTRY(rte_flow) 
> node; enum rte_filter_type filter_type; void *rule; @@ -1182,6 +1185,8 
> @@ struct i40e_pf { /* The floating enable flag for the specific VF */ 
> bool floating_veb_list[I40E_MAX_VF]; struct i40e_flow_list flow_list; 
> + /* flow engine configuration */ + struct ci_flow_engine_conf 
> flow_engine_conf; bool mpls_replace_flag; /* 1 - MPLS filter replace 
> is done */ bool gtp_replace_flag; /* 1 - GTP-C/U filter replace is 
> done */ bool qinq_replace_flag; /* QINQ filter replace is done */ diff 
> --git a/drivers/net/intel/i40e/i40e_flow.c 
> b/drivers/net/intel/i40e/i40e_flow.c index a017d3cd448..7d410b6c33b 
> 100644 --- a/drivers/net/intel/i40e/i40e_flow.c +++ 
> b/drivers/net/intel/i40e/i40e_flow.c @@ -26,9 +26,12 @@ #include "base/i40e_prototype.h"
>   #include "i40e_ethdev.h"
>   #include "i40e_hash.h"
> +#include "i40e_flow.h"
>   
>   #include "../common/flow_check.h"
>   
> +const struct ci_flow_engine_list i40e_flow_engine_list = {0};
> +
>   #define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
>   #define I40E_IPV6_FRAG_HEADER	44
>   #define I40E_TENANT_ARRAY_NUM	3
> @@ -1268,6 +1271,25 @@ i40e_flow_dev_dump(struct rte_eth_dev *dev,
>   	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
>   	struct rte_flow *p_flow;
>   	bool found = false;
> +	int ret;
> +
> +	/* try the new flow engine first */
> +	ret = ci_flow_dump(&pf->flow_engine_conf, flow, file, error);
> +
> +	/*
> +	 * There are multiple possible situations here:
> +	 *
> +	 * - User requested to dump all flows
> +	 * - User requested to dump a specific flow
> +	 *
> +	 * For the first case, we keep going because legacy engines might still
> +	 * have flows we want to dump.
> +	 *
> +	 * For the second case, we only keep going if the flow we were asked to
> +	 * dump was not found in the new engines.
> +	 */
> +	if (flow != NULL && ret == 0)
> +		return 0;
>   
>   	TAILQ_FOREACH(p_flow, &pf->flow_list, node) {
>   		size_t rule_size = 0;
> @@ -3892,8 +3914,15 @@ i40e_flow_validate(struct rte_eth_dev *dev,
>   		   const struct rte_flow_action actions[],
>   		   struct rte_flow_error *error)
>   {
> +	struct i40e_pf *pf = dev->data->dev_private;
>   	/* creates dummy context */
>   	struct i40e_filter_ctx filter_ctx = {0};
> +	int ret;
> +
> +	/* try the new engine first */
> +	ret = ci_flow_validate(&pf->flow_engine_conf, attr, pattern, actions, error);
> +	if (ret == 0)
> +		return 0;
>   
>   	return i40e_flow_check(dev, attr, pattern, actions, &filter_ctx, error);
>   }
> @@ -3911,6 +3940,11 @@ i40e_flow_create(struct rte_eth_dev *dev,
>   	struct i40e_fdir_info *fdir_info = &pf->fdir;
>   	int ret;
>   
> +	/* try the new engine first */
> +	flow = ci_flow_create(&pf->flow_engine_conf, attr, pattern, actions, error);
> +	if (flow != NULL)
> +		return flow;
> +
>   	ret = i40e_flow_check(dev, attr, pattern, actions, &filter_ctx, error);
>   	if (ret < 0)
>   		return NULL;
> @@ -4017,6 +4051,11 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
>   	struct i40e_fdir_info *fdir_info = &pf->fdir;
>   	int ret = 0;
>   
> +	/* try the new engine first */
> +	ret = ci_flow_destroy(&pf->flow_engine_conf, flow, error);
> +	if (ret == 0)
> +		return 0;
> +
>   	switch (filter_type) {
>   	case RTE_ETH_FILTER_ETHERTYPE:
>   		ret = i40e_flow_destroy_ethertype_filter(pf,
> @@ -4161,6 +4200,11 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
>   	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
>   	int ret;
>   
> +	/* flush the new engine first */
> +	ret = ci_flow_flush(&pf->flow_engine_conf, error);
> +	if (ret != 0)
> +		return ret;
> +
>   	ret = i40e_flow_flush_fdir_filter(pf);
>   	if (ret) {
>   		rte_flow_error_set(error, -ret,
> @@ -4310,14 +4354,21 @@ i40e_flow_flush_tunnel_filter(struct i40e_pf *pf)
>   }
>   
>   static int
> -i40e_flow_query(struct rte_eth_dev *dev __rte_unused,
> +i40e_flow_query(struct rte_eth_dev *dev,
>   		struct rte_flow *flow,
>   		const struct rte_flow_action *actions,
>   		void *data, struct rte_flow_error *error)
>   {
> +	struct i40e_pf *pf = dev->data->dev_private;
>   	struct i40e_rss_filter *rss_rule = (struct i40e_rss_filter *)flow->rule;
>   	enum rte_filter_type filter_type = flow->filter_type;
>   	struct rte_flow_action_rss *rss_conf = data;
> +	int ret;
> +
> +	/* try the new engine first */
> +	ret = ci_flow_query(&pf->flow_engine_conf, flow, actions, data, error);
> +	if (ret == 0)
> +		return 0;
>   
>   	if (!rss_rule) {
>   		rte_flow_error_set(error, EINVAL,
> diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
> new file mode 100644
> index 00000000000..c9588686619
> --- /dev/null
> +++ b/drivers/net/intel/i40e/i40e_flow.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Intel Corporation
> + */
> +
> +#ifndef _I40E_FLOW_H_
> +#define _I40E_FLOW_H_
> +
> +#include "../common/flow_engine.h"
> +
> +extern const struct ci_flow_engine_list i40e_flow_engine_list;
> +
> +#endif /* _I40E_FLOW_H_ */

-- 
Regards,
Vladimir

