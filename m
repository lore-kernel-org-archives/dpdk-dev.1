Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0350AC9830B
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 13:04:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAB0E42EE6;
	Wed, 23 Sep 2026 15:04:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 82B9A40262;
 Wed, 23 Sep 2026 15:04:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790168693; x=1821704693;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dZEtlD0NVZyriT8/DbUxA1wT8LU0llwr/de0Vn7dpUk=;
 b=SCUpNSm07f8NJAl2yASNIsTl7Fn1YkktG8ZsNcZ9MQUHSNtp6WPmcop0
 NNHwMMzW3pUyTF6gQXGjQmBqfR3Ul3Q98qObsp7qFsW48+wT74ely4ocv
 OeTmlQtKqBoGGT/L3G9wRE6YzFta51IHY0fZMlkRibDSV6ThSpLlHjIMk
 RiLK3cy7xOa4Swa+LY+RpbKgl/cUg8PJ2T8pTgLUv4vp0odSS/GoRE8uv
 h1KnQt3io/lOLIpWXxF1b9Gp8YbsQEwHiBMO9lQmQejcKY2MUbK6Q4nTn
 FaBPbi4xw+BCPkE1GBKts7u6LFFeMgdLUAbnztza6/R6DeptYTag2Q3HW g==;
X-CSE-ConnectionGUID: 19dYHqPwS8GeZo3noeqSzQ==
X-CSE-MsgGUID: QyiiDxvXTMuBsvJhi48e/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90977554"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="90977554"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 06:04:51 -0700
X-CSE-ConnectionGUID: rEha9EZyQ4Czb/kUyont9Q==
X-CSE-MsgGUID: Pi2OrpVOSDSbWgMBk01oog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="272780537"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 06:04:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 06:04:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 06:04:51 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 06:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBOtRuwuwgZ/a9aNkttjjcgoR3CLT/NDw2Mj72u9ybEQB/s0TdyKkWB2huofzag2Ls3GLn+VocY+ToxrPzZsvoaMOmuFJH6LDwU55Q0uOsfy8NbJ0sJ3woXZwGxfY4aau6+W4RQ0x37SkqKdmKxl4lGRAR/6cuqBUmtehRSvCz77rK7pyZnVVQnQrpoGn9lsbF0rRdoHztj3JL1wUu0KXDEC5ZCFocc5fvnq+3W4nhbfm7NYrKC+FyxUxbn0Tu+1aV7kI8ygiOb0K/vAKP9gtSNSSo21GW/j0lTJcwc3Mwkovgbentco/XpIGT2mbYlMeeDHIaxZup7I3FTQho8hNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owU6bx7j3CI5AY/+Fz6RsBMLpNNjf5jpiTQQNmxlDoQ=;
 b=Y8EyiNJ5xtefgq7G2IwwztkHjS8odlucrc09dd+390XlU68DhhCwWJXGKly6JUQqzVTG4Mz0gsZyt/x9mcXhSmEXwWgVqulaFjvB5GlfLwuYruCvbSAoS5bIyO4TnJ/f75kTUr11nVNuGR/I0ipDDNajusPtJZ+lHqTGEEexXel8phMmf6S9nkaM06Aa64I06gqFuIWcd1zC4mPg9gvrADR5ef0SrIsfwDp31LKbcTsPNdqohmV3UZegGHPeX2BXPuo0K0trNf94tX+alWDbgcHxcvS2fNhGUlLDyVR9gcbTrksFkzy5EC6THFruQ8gF+jDBNmpthKQ2LyXxP++FkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 13:04:47 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 13:04:47 +0000
Message-ID: <99a1f01d-ec36-4399-a82b-6e477819416d@intel.com>
Date: Wed, 23 Sep 2026 15:04:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] eal: notify secondary on primary exit
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Qi Zhang <qi.z.zhang@intel.com>
References: <20260507210152.410419-1-stephen@networkplumber.org>
 <20260507210152.410419-3-stephen@networkplumber.org>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260507210152.410419-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0119.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH8PR11MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 758aa900-85a1-4f9f-3a79-08df19733e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 3Y0yAy4OE8rMVnT5K5PPcQye/aSuVPCthNGkf6grGkF3n+ToAl8VM0soTXwFTsmtnZ7gWz/DG14rgnqxB60pI7zehXx0VhelZ0Qchn8gSJXfjqiEVTf0MgxFXFZ3WICyb9Il4elBs7ldEdXoJKhal7d1bwXWjfextpeaTvCNGYb5oVld8Z7CpEwF63qDWAuqnaYqzXNJ9LbWccq5+kuIt961+7CYez4bf9Ty82Gfg/C3Lvks6a0b5lwVoq9G5oOqkifpYSQXWk0Cw7+nMMDkIB3pf4io8TenN5pTHYsS1utjm5v1a1IrFRGJKrKeu+hMNw/YQQ/5PVgRpDdn0AxNqptXSmoZxurzwXbJBYPWijHrBUt6KVNUfSLB6ukDfm0k6QIgwutH1o01WU7NHYtKtenizpMVchFaNPg/hQc522QMRoch8sFlyOURAnyz44yJjrGhsFPZFrCP2Iz6M8Q8y6xQoXivxU6lEI2BUmWO01+BlyhUQsWNYjwQMEGdVEu3ZQNMqRCbOVG00pphDMhqYs8QQgjw1GAHnDMNlAxIy0LrjWK975mlw0Bu+gNBRvA0W4OheFnMvU6UQcsWi3rD+ra/+jmnCGVuvU++MTS2lLNS5lFa3A+9uMPvtJQ9BH7q6woZMXUOWrSBFjY2mP2VUEa4IMK9SH67tD74lqdwpEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay9BYzU3Y0xHWnVGVi9OcnNocUpLa2FsakxvNDB0RHFYbWpTby9wTDlUeUZC?=
 =?utf-8?B?UnVHbFlQcTZ0TjM4WDF4bTJ5SWRYUGRnRU9xTjhKWG1IYmtSN1lzd210WjRP?=
 =?utf-8?B?YTZRdVJpTGVpVk5vUkpWb1Jra01mblN2MHVQZlREUklmeDA5ODA2MEY3SGFl?=
 =?utf-8?B?eWtmS0Y5THJ2R0pqU1dFSnFiN3k5VXU3WVc3UjFyZ2ZOZW56dUhqSTRxMG9Z?=
 =?utf-8?B?RlpLcmFQaDJ5ZmZNRWZtK2RlWVByTzFSMkliV1J2YkkrdTd3NGtJYzlFSHBT?=
 =?utf-8?B?L3BoSThNL21lSzBiOTI3b2tjUE92S1VyaW9ia0R6elhidENrOWdHTDMycFQ1?=
 =?utf-8?B?dVVSSUF6S2VjZU9WYW1zR09hRHRnWWI3OG12TWVrYUxGOUJ4MDV2eGluK3RG?=
 =?utf-8?B?UE1HaXJqdUlDRWhVdWVIOUhVTVBpejNSeXVhYUhtZ3JDN3ZXdFFsWndkSlR4?=
 =?utf-8?B?cEpWMStxRWxlaWNHMzBJSXNLcmExNVdHY2s3THNtUXM3MFh1bE92czZNYytR?=
 =?utf-8?B?VVJrcENwWUNsRGxlT2cwVFF5NjlDdmNSTFlJazdkOTltWlZNVW5QalZEeVFo?=
 =?utf-8?B?cE9aOE5jakdPdjZ4dVpHbnFGdFJ5d1RCa2FKK3pPMzFXYnkwM1RWYUxJTDBG?=
 =?utf-8?B?Nkp4NjB1S001MVpLWXA3c0JWN3MxaTFBMDMzdEFGYWloQ3FGL2pINk54aWF5?=
 =?utf-8?B?T0p5MTFWdHdHVFZyaHRhbUNaUVg3OW1JZkpISmJMLzdaQSt6NDdia3kwYkJZ?=
 =?utf-8?B?RVRiOXRmK2E3d09tRUptbjJHZWVOM3VNK1BwajZtRUVSY1dMWWhicmNjRE5p?=
 =?utf-8?B?NDNRVEFWUVRObGZYQnB1M2d3SHJCZGpkb3o0Q0VnbGNJY2I2UzZzNldFUXZp?=
 =?utf-8?B?ZjN3eitmUWNwZDFGMVdIUEVNMXdpUW9kaGNvOUgyK3VhQ1BObnZaZ3Frb0Ni?=
 =?utf-8?B?MUJlLzdvczNKek9rUjBxcnhzTkxKOTNxejRhdjV2ZUNaUFY3WGxXWlZTVjRu?=
 =?utf-8?B?Tll2RTB1RXU1bFNYRWQ1dnBrMFhsKzdmT3hpbllhcnUveXA1cTk3d2xyYTRk?=
 =?utf-8?B?VDdldU5ZQklZOUI2MDc3K0ppN0h5NGVaME50aFRoelh4c1BuYUw2emtIUG51?=
 =?utf-8?B?Ykk5VDFtamxzamorZDJHWFRSZFVQZW1yNG1TeEFrRXdaaTlkVy8yQmMveXZo?=
 =?utf-8?B?dzVKWWNSUFErVnJqT0hMaFVxbnhSNXV4NVl0cHVNV0pYc2VYcGZOSFpEVFFW?=
 =?utf-8?B?YVdKN2ZFd0Q1QTcyazlLbmhJM1lobXYyUW5GNTV5NW9DYTlhZmtweUM4dVBK?=
 =?utf-8?B?dVUwaTFKenZ1WVZxVmxTb0NYTXR5OWpIeHI3U1Zwei9KZzVXdk9nR0xpSGZs?=
 =?utf-8?B?eWkrSHkwd0thSExXa25xTVNENXRPS2dPWkI0SEVWRHRQdFhIRVJCbjhTWHRk?=
 =?utf-8?B?ZnFISnk0OUpZYWVLRC9zUGEwcVgwUHQ5enNLc1piMjNDcHYycnVuUHFzSjZp?=
 =?utf-8?B?S21OYXFEWVM0THZqWDBISGROZ2RVMkgxRGtGaGNNZkJmbWo4cG1UTkI3MVFT?=
 =?utf-8?B?STZudWpSbm1xelRjcG0wZmVDMmZ5alpqRmIvZnFaL0NOVERFU1ZhM09ZTGk4?=
 =?utf-8?B?cGVac3JvZUhwUG82Y1dLUmZveUdXOXF4YVpzaG95MkpIRWRITTBpRzR2ellQ?=
 =?utf-8?B?R2NSWWJWdVc3anByRktabXpGOW5Cc3ZBVFFBUDFYbFRkQm51cUswOStmeVFH?=
 =?utf-8?B?TTlIcXZHTlFiQkNBaW1wSHdwcFJ0STNXNW1WNG8zc0Q2S3FSYjBzMzBKMUtj?=
 =?utf-8?B?aUVUQitKNTh0OGFjbEsyVHN0YXIyNGJvM2U0YXdhV0VpMERLVlFxcjFlbUFl?=
 =?utf-8?B?VUhCSmNWcExWd21FVEhseFoxSFUwamZXNlRTWEN2NEdaY01RZ1NGbXExd0hk?=
 =?utf-8?B?L3FpaW56cUJObjJ6TEc1bmpWVWRuOWYxOCt3bmpqSUQwSVJxU2tXV2w0YWRI?=
 =?utf-8?B?WlptQlE0UVBYY3BISTR0SnU1L1dlTWJ5azVkQnAxWkRManF6YVc0aHNzOWdP?=
 =?utf-8?B?Z2V4L3o3R0RKRUVlRTdHdG8rVFRPWEZBSnFRaW5acDU1cGVxcWpEKzJkdENX?=
 =?utf-8?B?dkc2NUpSY1p5dWV4eXEzMnh1azdXcFJjTktOcngwaTZ5ak1ZZ3BVYUdDc1pP?=
 =?utf-8?B?bWpEU3lGZUQydWlOUytTVkx5QjZEUHVIa0o2MFR0dUZBamY2OGxhMW1ReHpI?=
 =?utf-8?B?TzRHT0FHT2JNMVdEYnJqK0lIRUYxSzd1WnVBZUJudGk3R0cxTnVoSVVCYllH?=
 =?utf-8?B?SVNoR1pKQ2Nxd2cxZWRmS1I3bG1CTFBVaGNmK2V4NHpCZk9jL3pQcnNvaHBt?=
 =?utf-8?Q?JH/MT5PH0+bOzutA=3D?=
X-Exchange-RoutingPolicyChecked: QzdWR5/xQg9JcOWU1aElMl6lrYQXoxPAhTGW8j6fQIvyU6lXk3S6tPgVYorJ1ppFvLqpdpaYwzgF3yFJk9guJSgQ3fPgwGBQ3wpbuWj7vgEDmi1b/rY1Ms1qBJxXvRAhLlGvDS9xbWdSzo8b117CWTA9nLLBZGZgY19nRgRHuiMBvfvT8pw2QRBTB/gqJAe4V0MyS6thKi3YZYo4cuD/Rd9XoWL1SGBePcCkph8fXxlSCLc+pjeIoYmktpsP9SV47CWp2J9Z0Sfp1NlrFvAc2pqu6vM98QZ80fqhNTG5K1/UEaFSHoHMTSWkOgMyvFp5jA45qqd1+xtSdhsMd5uTRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 758aa900-85a1-4f9f-3a79-08df19733e6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 13:04:47.1357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cfc6I4bbMA76fkFS0WqFtauVq7CVbAkRnlwdelx+/cT8ce2gLcCKJfJSJHhUfMud18/AiUmAWQ23jFQrz/HscpJ3ixhGnlaOcvPiv+si+WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8040
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

On 5/7/2026 10:58 PM, Stephen Hemminger wrote:
> When primary process exits, it should notify the secondary
> processes. This allows for clean shutdown and eliminates need
> for MP handling in applications (such as test-pmd).
> 
> Bugzilla ID: 1942
> Fixes: 85d6815fa6d0 ("eal: close multi-process socket during cleanup")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

It would be cool to have some kind of event for this so that processes 
could react to primary/secondary going up/down, but this is 1) way 
beyond scope of this patch, and 2) of dubious usefulness given that the 
only thing testpmd did with the information was to stop forwarding.

-- 
Thanks,
Anatoly
