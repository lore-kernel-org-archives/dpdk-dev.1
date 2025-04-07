Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B5CC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 12:41:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 213CC40156;
	Mon,  7 Apr 2025 14:41:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 28D1040041
 for <dev@dpdk.org>; Mon,  7 Apr 2025 14:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744029717; x=1775565717;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=EV5c18viry3YBCrtLaotTqS5vRhU7X5KeQB5kcIpJHk=;
 b=Q4SwCb/9xW3pbRYWTRfZvuH2h0D14sMBQinKUjhoTNhLhbuFEGMk7Gk2
 FOYfUjv2e6nPqVKOOpMhFdIVOERJiMm7gpAKaNyUP8iThZEyiW4AKv66r
 QR0yGhSWL2KQH1hdqkyWl13VxRk5WrggrFilDr2t/rkCIJlEXgk+tiYZ+
 tmYW6FvbqwTiGkGeOy6MRuUv/oj1nW7nNv+NbVOQipENs32fAt3jC+K+H
 ajsSwpcwHeFwTmxxlCTTfU0losNfz8B1X4PrBLYA8MlXFiPwdHYc9OmGD
 rYegoZceO+WAHLOeqZc52iEiY0amvp7HoDljo8IEhWIT1WFr12ZG/xLc5 A==;
X-CSE-ConnectionGUID: U09j8NiCTfm1T+okfRkvzQ==
X-CSE-MsgGUID: JjDp52uBRzCb5gzIqcR7iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56779208"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="56779208"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 05:41:55 -0700
X-CSE-ConnectionGUID: aia3k7/9ShmV50IFiJruIw==
X-CSE-MsgGUID: hShzg59NRF+iKOBT9dcauA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="127807289"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 05:41:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 05:41:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 05:41:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 05:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS++ObrixJzKbu4fhZAhmam+1yBVItMM/NchpsAjf3ipwaCyWCS76EAKE6X3+CJQrikS4VqmJxRnDHr4ESysG0msSynRxieJ2fYEo90RS759PzgzKhVn5n4Xg0LMOuUKdmv6zfz9U2M7owllMoCqw0ublYrlF5sbQypV0wcqwf65/toQcwXVm3DMla1UXDHXhWUIvUMxsNGk6oHv42VxlWAv7tQz0UCaFsXKfg6vSM1nYbuGCvR6lt53eva7LXs11kY2JFux57XNHXPtBHEnezBYTvdNzMc5kgaWkO5hC3jx42MPB1ezxfOmZW295grKMzQyLWfjbw8mPAamcsZJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeznIbOJnJQ2OGSbxLkMmAZbB0ghnWgBKh2rzutxTB8=;
 b=iTMGEaFW1+hnjlTTUNyouq9M2RW8dvUN5dLTmo+kR+r+2cH88+nbllrO4C/zbAOlV9Q8xXCCQjhG5A3QijN4Dg7tnqlH+jo0ccf/bNVvXzvwORgdUtDLFFKRKRSjdbT84PvsS7ZetT+FcXsUAiwNQ1HlIzCH4bblSmC1blxgQ1KQYwHH9xzSjC3Bm/KSYP6ocEu+zNKLNHnD1udTqEHD5Ll/qr31bpkl+JKnOmA7fQPwXpt9mL/RRDnB5CuCWMWrBRQAgPSbLazCCOfptc0xe5tWFutJ8uVzLpkxg60NJvWIKDKUeKLXCNRhKf2NkdeB4x3eodlq/7e9T+AmzQY9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.33; Mon, 7 Apr 2025 12:41:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 12:41:46 +0000
Date: Mon, 7 Apr 2025 13:41:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] allow easier use of high lcore-ids
Message-ID: <Z_PIBLQIT3eu6Ab3@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
 <Z-vzAS8TXWn9WSV0@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zcFU_K0feJMK=YEouyxYxwURUPQq7EGcacJ++RxoTuEw@mail.gmail.com>
 <Z_Ofcb4ktAmn2RqJ@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB99@smartserver.smartshare.dk>
 <Z_OrsVaV64pLREqv@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB9A@smartserver.smartshare.dk>
 <Z_O9Uq_Mg86yjKzi@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB9E@smartserver.smartshare.dk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB9E@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0190.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2db4a2-a0d5-41e1-a5de-08dd75d18eb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWJwSlhkSmFiWWNqc2IwUjIzV2xxaG9neFp0RC9QYkpnQUlTUFpiMHdPQ2NK?=
 =?utf-8?B?TEsraVptTVpqeXFwM21RbDNVa3FMR0xjWlNncjJ4VXJDYzBiQVNXaUhJdlRy?=
 =?utf-8?B?UEtQb2RjM09vaHJvOUJFZklIRDd0NzN4ZGtQMGV5aEVqT0NwbExXVmhIQ2dB?=
 =?utf-8?B?elJuendkOWpKWlJWV2lER2hHakRzQVJTM21ycHluVlc5aVcrbDJUQkpuTFhH?=
 =?utf-8?B?VnVSV0VtNEtFMDRUVTJaQVJkbEIzQkpuL3lrbmgyYmRnaFJyTnJvNDhIMVFw?=
 =?utf-8?B?bUJ4NlZzTFM1a3dFYUw4R1lnV3pacnk4Q2txTHlDQmo1a3hvbklHbkpacTND?=
 =?utf-8?B?QlJ0WXdKb2ZvalN0bmtqL011WTBVT25ORnpMSnBrUkhGWWdueElHNnA5WTRt?=
 =?utf-8?B?WmRmSVRudzJDMHBvL3pQNGd6VVdyS2VqeWVKQzZLa0EzbjFZKzBNWUd1VXJr?=
 =?utf-8?B?ME42UFZQU2NJUDVFdU9MYVJtSG9GZnhrYStEbk1OZit0dnlVWjhsKzVrbzUr?=
 =?utf-8?B?dENnZnNZcTVyV0NkOS9yZnZuMndLZi85YXZ3L3ZmT1p0NDVZOEZ1SkZTUGRq?=
 =?utf-8?B?WTFsRlRlS2d6Q0tPS3lhMDVZU2ROYnlhbDZLMXhoK21TckpNM2ZIZlJtVTlH?=
 =?utf-8?B?UmxIU01xTkZQQlR1S2VpYmxrd04rUTJrOHdycHlWTjVOWmR2Z3o2OGhhVlA2?=
 =?utf-8?B?TmVaRWtRMGtTc2hJRWNHUUV0aVlsTVNENkZYdjNoUFp0NnZOU2MwM1dlU0Z2?=
 =?utf-8?B?YVpvSGhiT2pZZkRpSGI3RXAvRzlwOHZSMGpKSkZlT250Y0FucUFSa0paTFYx?=
 =?utf-8?B?bGNqaXJCcHM5WkpmRHRaN0xqOFNTdW9oUWpCVW1ZL2tjRTJ4SnZGZ0wvWnhy?=
 =?utf-8?B?MmhNMjV0K3JZeXNrUGR4NnJ2REh0MS90NHBhOUw1S1ZXalRoY3h0N241Wk04?=
 =?utf-8?B?SENKNThWSVVGaTRVTjQxZHV5VE40R2huajU5Qm0rcGNZUnBTRUM1TTRsN21Q?=
 =?utf-8?B?bndwcjI3VmJiU09iaWcraVVlOHVHM1RiUDFqNjhMeW1RSVNUS3Q5WnBVSVVK?=
 =?utf-8?B?ejk1R3VHTXluM3VSN2E3RFBpQm9nNkFpODRGZlpxRXRrMEhWSmlsMUYzZ0dP?=
 =?utf-8?B?QnFLdkQzdlFDcTB1YnNLS0NoM05GM3R5ZlBCR2l0QzV6QmU2SGhtcEVYeExP?=
 =?utf-8?B?TGFWbGc3TXFQYkluVHpja1pMMTAzbDY5ako3R0FOMWsvaCtnenUxL1c4U1Zn?=
 =?utf-8?B?WlZmOUY5enFLVjU1a1hkSFIzNlpvYzZoSjhnUkVGWTVTOFhrK0NpVDZmWFZR?=
 =?utf-8?B?Z0dFOHpicExQY0VENzBwa0pZRGlkdXMzLy9WTXBYeWk3Y2tNdkVhWGhWUEUy?=
 =?utf-8?B?KzAzMGZVbFhXWHRhRUhycXFSNzloUndCcVpiQm5hYmdxQnNMTGhEbCtXTjNF?=
 =?utf-8?B?KytTK0hNNWhlQmJ4WDRnVm1nQW85aG5zaGh4aGFKY1k2ZUhubkoraXdCQ1E0?=
 =?utf-8?B?eTgrcXNMMVJmbkh4MjMxc0txMXdpbnY1MFlMWWg3ZXNZVmgrUnltRVhHalIr?=
 =?utf-8?B?cGxrd2kzajI5Zm9rT2xRWms5Zytmb3VEd3hTclp4T3QvU3l6dWhIYlJ3S3E1?=
 =?utf-8?B?aWZ2TW9qVlptSDNBM1I2TXkyZitQaGlUNytveDAxOGU2SVhScWV6ZHdwZnlu?=
 =?utf-8?B?d2RpV2oxK0lqcTNsY0hVVERjdzZGMUZta2FBN1JKUkZKd0hPdlJYdTcxRmgy?=
 =?utf-8?B?d2t3UnZSM2FCUC93VlFBaWpCMEN2MzUwT0dhRnhrTFJScHdkeTN3U2QzT1Ry?=
 =?utf-8?B?SjZCNndJZHNJK0wzOS9jZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJUWVZ4VHg3dkxRUjBtdi9kZDZPVmhTSGpWKzJybW1BWm9mVDBqejBnZTlU?=
 =?utf-8?B?aDJ3bmMrQ2pEenNQZDhIQ05GWUtpMkt2R1ZLeEVOZXNmRkxTZUdmc25YOHhu?=
 =?utf-8?B?UEVXTDZMTzkyR1MyQjdxSmFNZkdGVmczcFJTemtQVWJCdTk1U1dVRWNNN25X?=
 =?utf-8?B?Unk3em5WbnpZd0dzVlZadEFpUHpWZ1hlczFhVmFuZHVIRklGeE9MdURUU2E2?=
 =?utf-8?B?M0dudU1QSm8zOEt4TGNtVWxOUTQwMUZScVd0dFlyNk5GNXhZNTAwa0xTMzI2?=
 =?utf-8?B?dm5qeEVvSGpEeUQ2TEE4YUp4Q3NwT3YrRTFheHdJcExrdHM5ZnpNSy9RMXll?=
 =?utf-8?B?aXc4YzFUK2h0Ri9pM0NWSlZHRlpwSlpJSllYSXNzT3crRWFJSnlLc096RkZp?=
 =?utf-8?B?YUI5akx2bW8rR0xZb1ZIVW9oY0ppb2ZrbDhRam5JZzJralNPMnRsdFNhUHRr?=
 =?utf-8?B?Nm5UTnNEWFcrYjVOZHlKMExvd0hVSDI2ZGJEZk1pMVNxWXQ2eWMzTFZNZ3Yy?=
 =?utf-8?B?RnBYRU1XdzNMQ2ZHcGVXOUt1Q25BNUFMSk1wbWZicmJDRjlFWmhJei9DQy9I?=
 =?utf-8?B?dmhlNm5PUitTcktuNU1EZ0pwZU1ocVd3QzBDN3lZNzcyckhLdXJYNktSbDY2?=
 =?utf-8?B?SlUyUzV0RHE3b2l0MFZQWnNVSDVxdUVia2pyNWMrOWhGRkhZQXp2STQ4Qjlq?=
 =?utf-8?B?WlJvKy9iQk9qTGljaVd6OEwyU2dxWE0xYXhwVFNnRzBUQjVwTlVibG40SXZS?=
 =?utf-8?B?NkR2NWkxa3B5Q1ZtM09MeTJKV1VYK0N0ZTJTU3RKVnJKaXJkYnF1L0hGZ3BQ?=
 =?utf-8?B?Z1BDWWloZGZOcFMzYlY3R3lTOEF3TWp4bkxiRTduc1N3MkJSdjFacE9Ueldw?=
 =?utf-8?B?dG9hUEJwTDZHSkljQzJFREIzVXYzS2pwZFZXVXNzdFZvUkMvdGFKWFVmU0lY?=
 =?utf-8?B?WEk2MzhxVXJyYUFGWG5ld3g3dHk2aTQrVWNsc2tzeTVoVjEydWM1ODY2ZE5m?=
 =?utf-8?B?ZFJCQVo0dUZySEVRV0tmZDViamVWWUh2VU04NEtIRUpYQ3RUejBXZ0VCM203?=
 =?utf-8?B?TFZsaUg3dkFORmp6Z1FzLzZkeDl2eWdHdi9halRBTFdtNGNUU0QzS3FQNDgx?=
 =?utf-8?B?NHh0bEszU1lUdGRkR002b3ZEeS9YcTlmbVYwenErMUI0QTN6WTJ6UjFQNStj?=
 =?utf-8?B?RTMzcWVDMnJxamt2bVh3ckQ3UGZSWVdaalFmZ29mclZGTFlxVE9xai9oK1Rw?=
 =?utf-8?B?WmNXTXlYSmRtNkpaTy9nWjBKVlZSVDc5Y0Vza2lLanluOFl0ajBJTWhUSUJr?=
 =?utf-8?B?YkxhTkNFUWhNTTZqbnp1a0pCM000Y2NmMTRUbGtiN3VJVG9tc2Q3NjhoQ0RY?=
 =?utf-8?B?QWorajM1MlkwQ3J2ZUVnV2M4R0twN0FYWE1qSmJPTUVhM1NEdmlNclJnUUxO?=
 =?utf-8?B?T2lERFdrV2Y5UmFrZDNLNUlIMTNycWlsYk1yRGRwb0NDR01EV2dBZC9ubGVZ?=
 =?utf-8?B?YkNTdGZydFFRWUtlZEJRTTVML3B1YmxxWlNrQ01PRVRtcTJ5K2N1TTZLaEFj?=
 =?utf-8?B?OGtrejhSK3BKbU51SnhoY2I4MFVWKytiTFhyYkIyUGtPbWhsNHJ2dDVlTElu?=
 =?utf-8?B?TG5JMVBHRC9YL0V2S1VZUytjRDdaT0ZYdXFRQTZMb05idkFnc2pydHdzcnR5?=
 =?utf-8?B?TU4zeVFtSHBycjMwci8xc0QxQTdVZ1RhVldSWEJoTWxzamxDeTRHSTE3OFM1?=
 =?utf-8?B?MXF0bkZsWUpCTnhwbHBBT09pMHVLbXExdU1QbWF3cEM5WFBpMldiVzlua1Z1?=
 =?utf-8?B?cHNsMGJSQytpL0FrWlhVQytIUFcwNU80M2cxUEtVc1NObWlTb0dGdFBSdVo2?=
 =?utf-8?B?MVp1SkhQMG5xN1dvS0pqcWFWM0NkM2pyRUdsd1RJdG5WbU5kbUg0RTJIa3FK?=
 =?utf-8?B?Y2JDZVBpSHVLMEFONkY0eEtOV1pyb3N0aEEwWEZDcHVMUFE2b2RWVGxmUmdH?=
 =?utf-8?B?NmNhRTE2US82a0VQT3NEV3VSekNvOS9tdy9kRkpLMHMrYVAyTVIyQjJ2eHdE?=
 =?utf-8?B?eTJsU2lqMnMyOHRuRWF0OHBRRURrSnRzaVUrR092VStnN0phSnVnZmZIS2R6?=
 =?utf-8?B?UzBabnVyQStrVFNWMFhsN2dhbVVnUWwwcFVUL2V2UWxGSWRubkFCVDlGcUdR?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2db4a2-a0d5-41e1-a5de-08dd75d18eb7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 12:41:46.2381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRQWOxkQuWVG5PInDplXxh/n2WSIBtuhBjERqNJoB26nCCJ838+VAMnYin7wPcp/CwB89Y2BsbUNub+yK0E4n7TMY6XcGL8DjzrBD+XSn+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
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

On Mon, Apr 07, 2025 at 02:25:46PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 7 April 2025 13.56
> > 
> > On Mon, Apr 07, 2025 at 01:32:59PM +0200, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Monday, 7 April 2025 12.41
> > > >
> > > > On Mon, Apr 07, 2025 at 12:15:13PM +0200, Morten Brørup wrote:
> > > > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent:
> > > > > > Monday, 7 April 2025 11.49
> > > > > >
> > > > > > On Mon, Apr 07, 2025 at 09:04:05AM +0200, David Marchand wrote:
> > > > > > > Hello Bruce,
> > > > > > >
> > > > > > > On Tue, Apr 1, 2025 at 4:08 PM Bruce Richardson
> > > > > > > <bruce.richardson@intel.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Mar 24, 2025 at 05:30:26PM +0000, Bruce Richardson
> > > > wrote:
> > > > > > > > > Traditionally, DPDK has had a direct mapping of internal
> > > > lcore-
> > > > > > ids, to
> > > > > > > > > the actual core numbers in use. With higher core count
> > > > servers
> > > > > > becoming
> > > > > > > > > more prevalent the issue becomes one of increasing memory
> > > > > > footprint when
> > > > > > > > > using such a scheme, due to the need to have all arrays
> > > > > > dimensioned for
> > > > > > > > > all cores on the system, whether or not those cores are
> > in
> > > > use by
> > > > > > the
> > > > > > > > > app.
> > > > > > > > >
> > > > > > > > > Therefore, the decision was made in the past to not
> > expand
> > > > the
> > > > > > > > > build-time RTE_MAX_LCORE value beyond 128. Instead, it
> > was
> > > > > > recommended
> > > > > > > > > that users use the "--lcores" EAL parameter to take the
> > high-
> > > > > > numbered
> > > > > > > > > cores they wish to use and map them to lcore-ids within
> > the 0
> > > > -
> > > > > > 128
> > > > > > > > > range. While this works, this is a little clunky as it
> > means
> > > > that
> > > > > > > > > instead of just passing, for example, "-l 130-139", the
> > user
> > > > must
> > > > > > > > > instead pass "--lcores 0@130,1@131,2@132,3@133,...."
> > > > > > > > >
> > > > > > > > > This patchset attempts to simplify the situation by
> > adding a
> > > > new
> > > > > > flag to
> > > > > > > > > do this mapping automatically. To use cores 130-139 and
> > map
> > > > them
> > > > > > to ids
> > > > > > > > > 0-9 internally, the EAL args now become: "-l 130-139 --
> > map-
> > > > lcore-
> > > > > > ids",
> > > > > > > > > or using the shorter "-M" version of the flag: "-Ml 130-
> > 139".
> > > > > > > > >
> > > > > > > > > Adding this new parameter required some rework of the
> > > > existing
> > > > > > arg
> > > > > > > > > parsing code, because in current DPDK the args are parsed
> > and
> > > > > > checked in
> > > > > > > > > the order they appear on the commandline. This means that
> > > > using
> > > > > > the
> > > > > > > > > example above, the core parameter 130-139 will be
> > rejected
> > > > > > immediately
> > > > > > > > > before the "map-lcore-ids" parameter is seen. To work
> > around
> > > > > > this, the
> > > > > > > > > core (and service core) parameters are not parsed when
> > seen,
> > > > > > instead
> > > > > > > > > they are only saved off and parsed after all arguments
> > are
> > > > > > parsed. The
> > > > > > > > > "-l" and "-c" parameters are converted into "--lcores"
> > > > arguments,
> > > > > > so all
> > > > > > > > > assigning of lcore ids is done there in all cases.
> > > > > > > > >
> > > > > > > > > RFC->v2: * converted printf to DEBUG log * added "-M" as
> > > > shorter
> > > > > > > > > version of flag * added documentation * renamed internal
> > API
> > > > that
> > > > > > > > > was changed to avoid any potential
> > > > > > hidden
> > > > > > > > >   runtime issues.
> > > > > > > > >
> > > > > > > > > Bruce Richardson (3): eal: centralize core parameter
> > parsing
> > > > eal:
> > > > > > > > > convert core masks and lists to core sets eal: allow
> > > > automatic
> > > > > > > > > mapping of high lcore ids
> > > > > > > > >
> > > > > > > > Ping for review.
> > > > > > > >
> > > > > > > > At a high level, does this feature seem useful to users?
> > > > > > >
> > > > > > > This seems useful, though I am not I would touch the existing
> > > > > > options.
> > > > > > > I would have gone with a simple -L option (taking the same
> > kind
> > > > of
> > > > > > > input than -l but with new behavior), and not combine a flag
> > with
> > > > > > > existing options.
> > > > > > >
> > > > > >
> > > > > > That would be an easier patchset to do up. However, it would
> > then
> > > > mean
> > > > > > that we have no less than 4 different ways to specify the cores
> > to
> > > > use:
> > > > > > "- c", "-l", "-L", "--lcores" - and therefore need 4 different
> > sets
> > > > of
> > > > > > parsing options for them, and more checks to ensure we have
> > only
> > > > one of
> > > > > > the 4 specified in any run. That's why I chose the modifier
> > option,
> > > > and
> > > > > > to try and consolidate the core setup a bit.
> > > > > >
> > > > > > However, if having a completely new option is preferred, I am
> > happy
> > > > > > enough to do up a different patchset for that.
> > > > > >
> > > > > > > I scanned through the series, not much to say.  Maybe add a
> > unit
> > > > test
> > > > > > > for new cmdline option.
> > > > > > >
> > > > > > Sure. Once it's decided what approach (if any) to take, I'll do
> > up
> > > > a
> > > > > > new patchset, taking into account any relevant feedback on this
> > > > set.
> > > > > >
> > > > > > /Bruce
> > > > >
> > > > > Changing the EAL parameter parser to a "two pass parser" makes
> > sense.
> > > > I
> > > > > think checking for existence of more than one lcore specification
> > > > options
> > > > > should suffice; we don't need to accept multiple lcore
> > specification
> > > > > options and check for conflicts.
> > > > >
> > > > > When remapping, do we need to support gaps in the "lcore"
> > (logical
> > > > cores)
> > > > > array, e.g. for secondary processes, or can it be continuous from
> > 0
> > > > to
> > > > > the number of specified lcores?
> > > > >
> > > > > And are new EAL parameters for this really beneficial?  Doesn't
> > e.g.
> > > > "-l
> > > > > 0-9@130-139,100@140" suffice?
> > > > >
> > > > Actually, I believe "0-9@130-139"[1]  is not the same as
> > > > "0@130,1@131,2@132,...". The latter affinities one thread to one
> > core
> > > > ten
> > > > times over, while the former affinitizes 10 threads to 10 cores -
> > > > leaving
> > > > those threads free to move about within the 10 cores specified.
> > >
> > > Interesting. The documentation [GSG] isn't clear to me about this; a
> > example there could help clarify.
> > >
> > > [GSG]:
> > https://doc.dpdk.org/guides/linux_gsg/linux_eal_parameters.html#lcore-
> > related-options
> > >
> > 
> > Yep, agreed.
> > 
> > > If users are manually passing lcore parameters to the EAL, then I see
> > why some sort of remapping shorthand is useful.
> > > IMO, if the mappings are relatively exotic, it should be acceptable
> > requiring an external script to build a long list of mapping parameters
> > and then invoke the application with those script-generated EAL
> > parameters.
> > > This would reduce the scope to support relatively simple, common
> > mappings.
> > >
> > > Could we expand the --lcores syntax to support common mappings?
> > >
> > > E.g. "0-9@130+" to do what I thought.
> > > The lack of "()" treats the entries individually (not as a group),
> > and the "+" indicates auto-increment.
> > >
> > > A more advanced example:
> > > "0-9@(130-131)+", meaning lcore 0 gets cpus 130-131, lcore 1 gets
> > cpus 132-133, etc.
> > >
> > 
> > My issues with the above syntax idea is:
> > * I think it's overly complicating the lcores parameter adding in the
> >   support for the "+" symbol - especially in the advanced case example
> > you
> >   provide. I worry about code maintainability here.
> > * More significantly for me, I think it's also getting things backwards
> > in
> >   that it is focusing more on the lcore ids visible to the app, rather
> > than
> >   the physical cores to be used. For the example above of 0-9@130+,
> > what I
> >   would expect is that the user is mainly thinking about the cores he
> > wants
> >   to use 130-139, which are then to be mapped to lower ids. If we had
> > the
> >   syntax reversed where the physical cores were first, I'd say it would
> >   make more sense, e.g. 130-139@0+
> 
> I 100 % agree on the syntax being backwards.
> A good reason for introducing a new parameter, rather than expanding on "--lcores".
> 

Yes and no.
I agree with not expanding on --lcores, but I also don't think any new
parameter added should attempt to reproduce all of what lcores does. I
would leave --lcores as-is, as the power-tool for lcore config e.g. what
you talk about below for mapping multiple lcores to the same physical cpu.

> We should consider deprecating the old (backwards) syntax, so users don’t get confused about one EAL parameter being "backwards" of the other.
> 

I disagree with this. I would be ok with deprecating the old "-c" coremask
syntax - I think the time is long past when we should be dealing with
masks. However, removing "-l" and "--lcores" flag is, to me anyway, too big
and jarring a change for end users for us to consider.

> > * finally, as I found out last month, there are systems on which the
> > cores
> >   are spread across numa-nodes on odd/even boundaries, so to have an
> > app
> >   running on socket 0, you need to give the core ids as a list i.e.
> >   0,2,4,6, and cannot use ranges. [This also reenforces the point above
> >   too, where again it's the internal ids we need to generalize, not the
> >   physical cpus]
> 
> For this, we could use "/2" (like in subnets), or "+2" as increment parameter.
> 
> > 
> > My thinking on the matter, and I'm happy to be corrected if I'm wrong
> > here,
> > is that end-users are unlikely to significantly care what the actual
> > lcore
> > ids are internally in the program, so long as they work and are unique.
> 
> Generally yes.
> Note that we should allow the same physical CPU core to be assigned to multiple lcores...
> If a CPU core is shared between multiple worker lcores, then it could be problematic, but with a mix of lcore roles, this might be handy for some applications. E.g. a virtual machine with only one CPU core could use that single CPU core as both main and worker lcore, or as main and service lcore.
> Sharing an lcore between threads requires the developer to take special care of e.g. spinlocks, but the EAL parameter parser should not prohibit it. It might log a notice, though.
> 

This is already taken care of via --lcores, so I don't see the need to
reimplement it using a new flag also. Any new flags we add should be kept
deliberately simple.

> > What does matter is the physical cpus on which the code is to run.
> > Therefore, my approach to this is to find the simplest possible
> > solution
> > whereby the user can just provide a list of cores and tell EAL to just
> > map
> > them to reasonable values. For the "reasonable" values, I would imagine
> > that for the vast majority of cases starting "0" is what is wanted. For
> > anything beyond that, we already have the existing --lcores syntax to
> > be
> > used.
> 
> Agree with all of the above. :-)
> 

Great. That still leaves us with the problem of what exactly to do as the
best solution. Here are some alternatives that I see:

1. Add a modifier flag for -l and -c parameters to auto-remap the lcore ids
   to zero, so user is just specifying physical CPU id's.
2. Add a new flag for specifying physical cpu ids, which auto-remaps the
   cores specified to zero.
   2a. To simplify our code and user experience we could at the same time:
       * deprecate "-c" flag for coremasks
       * make "-l" and "--lcores" the same flag just in long and short
         versions. This should not break anything as "-l" parameter is
         just as subset of what "--lcores" provides.
       * that would leave us with effectively two core flag paths:
          - -l/--lcores, behaviour as now, full explicit control
          - -L/--lcores-remapped, takes simplified core list (only "," and
            "-" supported as with "-l" now), and maps them to zero-based.

Third options? Any other feedback?

/Bruce
