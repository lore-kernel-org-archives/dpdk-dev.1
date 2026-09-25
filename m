Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F16C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:05:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A94B4326C;
	Fri, 25 Sep 2026 12:05:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7CD5340B9F;
 Fri, 25 Sep 2026 12:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790330732; x=1821866732;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rFFaSL/4QD3TbjjTisRrw6CIWRJBAI2KI8K2FcMcqv0=;
 b=kSszh13js2AUaR0PksdrIQteSAhhDxuv4srEIkX4rZc9V3kEiE6TU050
 T8IQbBoOQTufJ1SEE01v+MqOWyjczZCZCu9cm0OT9I5KuH3BUZnvcR5se
 Z4/9qPNf2i6EFHkAEptx7plMq6ZKLjiGj1tKXsfk960Uxa/iZdbY/W2Db
 9EG8o+RBN2xKpKG9ihsOSDh/I2QO/FxcQRPI8ArBXaZ5Wfws5vFx7dkhT
 999YnbavuFXA1WDOZUHcDFiAJUS7cnaC6dVmXwG+bth2usB3SjJP5piWE
 8rBDA3uhpqtJX6fAX8+XOxpPcNV1PDRvEtKwvQqKCTviJ76vF5rCCGCEg A==;
X-CSE-ConnectionGUID: jLnpYx6aS2+2orEg+0MAFw==
X-CSE-MsgGUID: OLl4KPzKRieA5GDhatbwHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="100447084"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="100447084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:05:31 -0700
X-CSE-ConnectionGUID: hOR9w/E8TZGPFkN6JPjOfw==
X-CSE-MsgGUID: zMkzsgBHThSme0K7yTFZAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="272426203"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:05:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:05:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 03:05:30 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+JEoWwGsZeT1UDmu6HDEBMXBJIlEY0x/gk0kPQFjXSF2e+3hYd9yeDJvLLwJ5yyi7A7qaWFJyPVtovRvSZlPCGGM2qa0TC425eaQz+gSZWcZFWDXDpkA9FCo9PNfVWzPGMIlStnWoYoz4e9u+VbzkfXE/QuIYE6NdD3NsZwSe8sBjg/4T40/wWqNlhDZVC4XRh16JQhkuSUNS0IR5jVmeZjIOXXM9crB6RL1vc3c526WjeroyasZH8ccxvY6OHDOegg37RFSYKLxV5KOZhwxxPLlUWvxNM6WZfAx7mrjGkE6ZEdaqGzPQ2Ye5gRxV/PWr2i8cU9mgX943lVrt9+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EIZK3LE/IkYlIIpcYHkwb8FCGrHpcIpnUeZEa+xnDA=;
 b=lhZ2Vnix1X9KLmuaahR1f4vRG2go9hqkolYPEQUfPRqF4UKFdIVj9jcjvMBfqSr2bdkwtnTryyAnLkRiGvzHPbCPCHuP5JkwhwqTKPlzHATDVgHs3+NLB1EZK2hMELqpII3+fnWZ5cJtJGzsEA7MyJynxLbdUE121teayzc79V+yXvwneKXx9gdySYZmHRAOf8vcSv0lwvmTJ5mfeEujthhdNvYGI1MqPdbk+hLZ5vlJcfgg4oskOq655o1b3HkIuj0pGODw5nTgVcFl+RUJH4sOw6SMTBmg9axY+mcKgQ1hCNqZxIX2cu4MRry2Lq+196c0kEU7XggqoXmgol8qGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA3PR11MB610523.namprd11.prod.outlook.com (2603:10b6:806:589::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 25 Sep
 2026 10:05:28 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 10:05:28 +0000
Message-ID: <b653e89e-d67d-40c6-afea-61d3fc5b1c3e@intel.com>
Date: Fri, 25 Sep 2026 12:05:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: fix repeated Rx packet buffer shrink for FDIR
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: Zhang Tengfei <zhtfdev@gmail.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
References: <20260916135827.116145-1-zhtfdev@gmail.com>
 <a46db9e8-1513-4e19-b029-2d55e28d42b4@intel.com>
Content-Language: en-US
In-Reply-To: <a46db9e8-1513-4e19-b029-2d55e28d42b4@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0346.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA3PR11MB610523:EE_
X-MS-Office365-Filtering-Correlation-Id: 27890dd0-428d-4cd6-74cf-08df1aec8697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|22082099003|11063799006|4143699003|56012099006|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info: nolkg18/PpN41lf5uPbqSwyov6ZP7N6NIu9UyBT23dIBMPSQ3Vg88xX0y8q9udj0lStMX3Dx5jdbH1QT5P6gVD8HqfXqXcIFXdpT7Y34V3qEyyBA0U62iMgs7pQLxQer7NloxfL4/HGLkzL1eIknLcEOQun+1QbP45kaAnEUQZzOusb4xjsk3dVnoik8AcDzPmLgE5VGZRqJWqA0aVuiy8FQUKTTPP3NHEjGRXmUt9qokGHxdvGp0pZpEgV2LtSiV1ehXHBKMreptrZ2cy/77I2c6wdgTSrH/LnfbZf8aL2rXAA3Eb11vr6iCxcAEgOqG8f5B6uWSXHODprbXZ7D1QPxQk+GznLsoy/pb4JlptfixdA7aNRP8k4PqJbW+acHhX0naa3Co/4lhRbxdH31L1tZ9qcoBAM/lqRFBT0khzfZAqVv+4Km1f0RJWhlR7W85ety+s6ooExTp0TU2ORXnBtDSjLb3Ylc0cgsS809c4G2dgu/wX0UsV+SoKEbG+65YE73OqalM4ybsxCairNTTgUbYeRC2vdBP4I/IAeimiXZw/gGlI/YGZgfe+Fb+/j76x3KfNfNOIs5kR69CxbpApb112qMuWM6c+V0vD87b1K5K4cpSHKhI8r+BzA2ryZr1RaPPoM+SnXqnbas5Jj7B9S67XLXipXK+O34WvK9hQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006)(18002099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHFCckl0eU1PaHlXSVM1a3ZFL3RqbWhZTlFoT3VsZDIvZDh5VEQvR3Ixczlv?=
 =?utf-8?B?aGZycXJsR1ZEcUhkWEdIWVNKLzJraUlpZExLNXdxWURmZmdoWnppTGplOU96?=
 =?utf-8?B?NXQvTEhxVEgwam5laGlMY25rY3lEL0R6cmF1ZkI1cjNCZDJNZm1WaGdsVTRa?=
 =?utf-8?B?a2UwbkR5ZjlCWlJqbzdsaGUyRi82OWFhV2ZUbjFiT0g3bGZxZ1hKcWtYcDJO?=
 =?utf-8?B?QWZ5eWhkYngveGNNbGZDb0xiVjR3cEgyWCt1SnRac3FmYUFFalMrZnZFazlT?=
 =?utf-8?B?VXI0c3lmVFJmOXVNOHd3bVVHSFllazQ3RlB0NG5oM2ZlRzdrVXZhYTdPOEda?=
 =?utf-8?B?ZnpwcktBZ2Q0Yy9EWHRpWHRHdFZoYWZoclZnVHVTekNIU050T0wvck9LRFd0?=
 =?utf-8?B?Sko1dkJWVUp0TDhneFI5bFNRQWVKSnppRjg5Z1NYMnk4dHlGQ3dKcDVtODNB?=
 =?utf-8?B?STdHQ2xvRXYwbXJQdVNrMXh5VGpGMnJ0WGtjeWJNWTNnOFBVODlDTmk5R1NS?=
 =?utf-8?B?UXZibjJ2R0EzQnU1ZDlKQjl0QXoxRzFBbWRLVVRZT2dNcHJXYUNMYVJVR25S?=
 =?utf-8?B?RXU1R3VEY1dxYVBhRWNmd3lDemduOXdjQTFianBueGExbmFiMHhveGNxeE05?=
 =?utf-8?B?a2hhNldOanNOVkY0ZlN5TjNCSHV2R0VqUENwelQ4cDNhSU84THF4Mk4yR214?=
 =?utf-8?B?MDN1bkpZZC9CSTREalkyZEQrekl1NFNHNnkybTVEeEJVRHRiNGphWldFVVFk?=
 =?utf-8?B?LzEyODVBSFFtUXBSb2FkQWxYTFN4MGZINlg1MWhNZ0hsV0F1YkdsZy9FZVVx?=
 =?utf-8?B?a3MwOGFNM0M3bjVvVjlWcG5Halc0TTM3VkNOVlVUdmJLempiVWZUY1JzWll1?=
 =?utf-8?B?N0t1OWM0VmNmRldkcU1Ld2s0UTlSK29Wd1RuUXNHZXErb2F1cGJUaVE1Mk9Z?=
 =?utf-8?B?Yzh6aUZYSDB6bG5oU2FVTWdralBzeHJTMUNnMStTZHVXdFRNOEZCVEhsL0w0?=
 =?utf-8?B?cjdSUDJtMlpxZnYzQ1BteC90bXhUMFBCWlZNNWNpeWI4WFN4WDVjYmhzUHBW?=
 =?utf-8?B?N29vR3BvMERRSS9wS2k3eGZpOHFWQzViejVXa3lPVVpiOG5Ub1p1NlZkdk52?=
 =?utf-8?B?eVIwR09kR3FwbFd1VCtGcllSQ0FKWUpVN09ab0ZCWFJzSEg1Y2VqeWllcUZy?=
 =?utf-8?B?L0I0WUc1Nk9PZXcyQVNXbDNsN093ZWJSL1M5dDBWSHNnVm5VYWJPOFk5TS9i?=
 =?utf-8?B?dGZubDR3Mk9aZU51S21wSEt6NjA4UDhIMVQzS0tPRDM2c0pZOFhES1FLNjNO?=
 =?utf-8?B?Sllxa3lheURzY2RMUWorcElyS0R0THdoeEVHOURNSnJMRURyVnZucm5rVURk?=
 =?utf-8?B?b2NwdVUrR3JTVnNLOWtBbVpKT1pqendoMDNTcXVWVTNEV0NDcDdoandTRlBQ?=
 =?utf-8?B?U1pBOWwyaHJlY2R3bWFMdkNJakVjUjJDcEpUUi92WU9SREJSU1k1NmNCVlpt?=
 =?utf-8?B?Q2VGY1RVY0E1cHpzUXY3bFJDZHFxc1ZUVy9heUlzRkc3OGttOUk1MU5GdHVI?=
 =?utf-8?B?Ni93bVJRTHgydjhKYmVGQ1AyaHBRUEluTGE2dU9qaWZXTTFZMU9XcFd4MG92?=
 =?utf-8?B?UENtVXJFZGMwTDJvc2h0ZituZ245VEFLQ0pTOWVYZDBXaFUxcU1UeXEvckp2?=
 =?utf-8?B?QzZBeG1EL0hpWFMwNEx2aVR3VUhnZklKbHZoTkpQaUJRTlJhZ0s1UjJYWUVZ?=
 =?utf-8?B?SFI0NUs3cVlQdm1wT3ZjV25JTnlyWFB6WktqekZHK3JkSFlCRUk3cEpDcWFP?=
 =?utf-8?B?WVFleE5KQi9YOGlrVkNGdVR1RVBUQmhET1h5SURpVWRaclRyMm94Q3lVeGNY?=
 =?utf-8?B?b2FPRXVFamZLYldVNkk0a213SWFMSUVRQkpHMkRUTk5wY2I5aUhCS2FNU3pG?=
 =?utf-8?B?dW9TS0o1QU1MSkl1TUJrTGp2Y25Lc1NnRG5KWFhqRUNYZDlOLy9QS0EwWVM2?=
 =?utf-8?B?Zk5aN2JIWXFEeVFqVElnQ3pIaEtvSDZDQUZaajZ6Z3lvTFcwdXdta1JPL3JY?=
 =?utf-8?B?Q0xDcHR0RmM1VXAxUFRWTjN0N2t1WllETWZpT2drSE1JQjRXVS96WmhkeXgv?=
 =?utf-8?B?T0xWcThZN0FwdzIzODVWT3o1MG5DOWNoSWZZNFgvS3FsVTR6YjkxS1hqd3pY?=
 =?utf-8?B?KzJjMHZtYmFMcXVsUFl0Mnl6aDNwS1VGOWgzdzFYRlBnM3pERkVkcy9oc1FJ?=
 =?utf-8?B?ZXhKcGozUjVpOHQ4WjRHV2RJT0tIc05wTmg3eEkwRG1NOXgrSk9SOG9rYkla?=
 =?utf-8?B?ek5vNEU4a0ZIeFlXbWJEUXgwSkNDREdZR0VBM2lXRWEzWnlZdmJWM3FjNklp?=
 =?utf-8?Q?Wp7RdD4elaTLp1hc=3D?=
X-Exchange-RoutingPolicyChecked: vbmEl3aQSUFquuDG3o9Ld9S8j70/xxWrjYJdjNyrf+bBDMSYdFVHh55tGvR40cB1Ncm2WCZC5gCILHXYjf6jnOZr68FCYUXLhdLKhxqUH2iM521wydTADKmGzQBqDzq1TCLp3fjz3Wifa3yLs+Fw1IkQV89MrYhwPe8f3E9flLWUKAlSIHfZ8QriU6yhiYRAGx/g3kcUaptxQVLXiRLUXmHFy5a5IP4kHVeHVtlW3SME+5Dxte42m73hBBlhM0injkmR2KXmupHqHYvNwQuBdM+l8UdOwdXPrGf09X+77F9Zyfyz9jUfMMWGYWdlL+noLtlsLI/v2F++77kHJoDX/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27890dd0-428d-4cd6-74cf-08df1aec8697
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:05:28.3992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hh2RaUTWpi7qGr6S17vwgnW0tM2/7xMws3wbt1MQeQtQTA7M1nLT2EXT9S4gP/huy1n2WukZz4TmqQIquq92QjO+f2Dz9PHMdBWbhK8Nm28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB610523
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

On 9/25/2026 11:47 AM, Burakov, Anatoly wrote:
> A general comment: instead of reducing/bringing things back and storing 
> a flag noting whether we did, I would rather do the following:
> 
> 0) store default rx pb size at init
> 1) on enabling FDIR, recalculate using that value minus FDIR table size
> 2) on disabling FDIR[*], restore the default
> 3) similarly, on enable/disable VMDq, recalculate and/or reset
> 
> [*] there is no "disable FDIR" call, only fdir flush which just flushes 
> the FDIR tables but does not actually disable FDIR. arguably, we should 
> convert it to "disable FDIR" by flushing FDIR *and* writing 0 to 
> FDIRCTRL *and* restoring rx pb size to defaults. naturally, after 
> running fdir disable function, FDIR will need to be reconfigured for 
> next FDIR flow and get rx pb size recalculated again.
> 
> So, a bit of a refactor, but I think that would make way more sense.

I asked an AI to implement a fix based on this, and here's what it came 
up with, it is roughly what I would like to see instead (obviously, 
please review/rework as appropriate e.g. to properly support VMDq as well):

diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c 
b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index b32dc542874..9f48a27cb3a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -101,7 +101,6 @@ static int fdir_write_perfect_filter_82599(struct 
ixgbe_hw *hw,
  static int fdir_add_signature_filter_82599(struct ixgbe_hw *hw,
                 union ixgbe_atr_input *input, u8 queue, uint32_t fdircmd,
                 uint32_t fdirhash);
-static int ixgbe_fdir_flush(struct rte_eth_dev *dev);

  /**
   * This function is based on ixgbe_fdir_enable_82599() in 
base/ixgbe_82599.c.
@@ -554,6 +553,20 @@ ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
         return 0;
  }

+static void
+ixgbe_fdir_disable(struct ixgbe_hw *hw)
+{
+       uint32_t rx_pb_size;
+       int i;
+
+       IXGBE_WRITE_REG(hw, IXGBE_FDIRCTRL, 0);
+       rx_pb_size = (uint32_t)hw->mac.rx_pb_size << IXGBE_RXPBSIZE_SHIFT;
+       IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0), rx_pb_size);
+       for (i = 1; i < 8; i++)
+               IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(i), 0);
+       IXGBE_WRITE_FLUSH(hw);
+}
+
  int
  ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
                 const struct rte_eth_fdir_conf *fdir_conf,
@@ -561,7 +574,7 @@ ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
  {
         struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
         int err;
-       uint32_t fdirctrl, pbsize;
+       uint32_t fdirctrl, pbsize, rx_pb_size;
         int i;
         enum rte_fdir_mode mode = fdir_conf->mode;

@@ -589,13 +602,14 @@ ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
                 return err;

         /*
-        * Before enabling Flow Director, the Rx Packet Buffer size
-        * must be reduced.  The new value is the current size minus
-        * flow director memory usage size.
+        * Before enabling Flow Director, the Rx Packet Buffer size must be
+        * reduced. The new value is the default size minus flow director
+        * memory usage size.
          */
-       pbsize = (1 << (PBALLOC_SIZE_SHIFT + (fdirctrl & 
FDIRCTRL_PBALLOC_MASK)));
-       IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0),
-           (IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(0)) - pbsize));
+       pbsize = 1 << (PBALLOC_SIZE_SHIFT +
+                       (fdirctrl & FDIRCTRL_PBALLOC_MASK));
+       rx_pb_size = (uint32_t)hw->mac.rx_pb_size << IXGBE_RXPBSIZE_SHIFT;
+       IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0), rx_pb_size - pbsize);

         /*
          * The defaults in the HW for RX PB 1-7 are not zero and so 
should be
@@ -609,21 +623,25 @@ ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
         err = ixgbe_fdir_set_input_mask(adapter, fdir_mask, mode);
         if (err < 0) {
                 PMD_INIT_LOG(ERR, " Error on setting FD mask");
-               return err;
+               goto error;
         }
         err = ixgbe_set_fdir_flex_conf(adapter, &fdir_conf->flex_conf,
                                        &fdirctrl);
         if (err < 0) {
                 PMD_INIT_LOG(ERR, " Error on setting FD flexible 
arguments.");
-               return err;
+               goto error;
         }

         err = fdir_enable_82599(hw, fdirctrl);
         if (err < 0) {
                 PMD_INIT_LOG(ERR, " Error on enabling FD.");
-               return err;
+               goto error;
         }
         return 0;
+
+error:
+       ixgbe_fdir_disable(hw);
+       return err;
  }

  /*
@@ -1180,28 +1198,6 @@ ixgbe_fdir_filter_program(struct ixgbe_adapter 
*adapter,
         return err;
  }

-static int
-ixgbe_fdir_flush(struct rte_eth_dev *dev)
-{
-       struct ixgbe_hw *hw = 
IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-       struct ixgbe_hw_fdir_info *info =
- 
IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-       int ret;
-
-       ret = ixgbe_reinit_fdir_tables_82599(hw);
-       if (ret < 0) {
-               PMD_INIT_LOG(ERR, "Failed to re-initialize FD table.");
-               return ret;
-       }
-
-       info->f_add = 0;
-       info->f_remove = 0;
-       info->add = 0;
-       info->remove = 0;
-
-       return ret;
-}
-
  #define FDIRENTRIES_NUM_SHIFT 10
  void
  ixgbe_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info 
*fdir_info)
@@ -1360,13 +1356,26 @@ int
  ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
  {
         struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+       struct ixgbe_hw *hw = 
IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
         struct ixgbe_hw_fdir_info *fdir_info =
                 IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
         struct ixgbe_fdir_filter *fdir_filter;
-       bool had_flows;
-       int ret = 0;
+       int ret;

-       had_flows = (fdir_info->n_flows != 0);
+       if (fdir_conf->mode != RTE_FDIR_MODE_NONE) {
+               ret = ixgbe_reinit_fdir_tables_82599(hw);
+               if (ret < 0) {
+                       PMD_INIT_LOG(ERR, "Failed to re-initialize FD 
table.");
+                       return ret;
+               }
+
+               fdir_info->f_add = 0;
+               fdir_info->f_remove = 0;
+               fdir_info->add = 0;
+               fdir_info->remove = 0;
+
+               ixgbe_fdir_disable(hw);
+       }

         /* flush flow director */
         rte_hash_reset(fdir_info->hash_handle);
@@ -1386,8 +1395,5 @@ ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
         fdir_info->mask_added = FALSE;
         fdir_conf->mode = RTE_FDIR_MODE_NONE;

-       if (had_flows)
-               ret = ixgbe_fdir_flush(dev);
-
-       return ret;
+       return 0;
  }
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c 
b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6868893d46a..da05e61e8b4 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -3157,15 +3157,15 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
                 memcpy(&fdir_rule,
                         &fdir_rule_ptr->filter_info,
                         sizeof(struct ixgbe_fdir_rule));
-               ret = ixgbe_fdir_filter_program(adapter, fdir_conf, 
&fdir_rule, TRUE, FALSE);
+               if (fdir_info->n_flows == 1)
+                       ret = ixgbe_clear_all_fdir_filter(dev);
+               else
+                       ret = ixgbe_fdir_filter_program(adapter, fdir_conf,
+                                       &fdir_rule, TRUE, FALSE);
                 if (!ret) {
                         rte_free(fdir_rule_ptr);
-                       if (fdir_info->n_flows > 0 && 
--(fdir_info->n_flows) == 0) {
-                               fdir_info->mask_added = false;
-                               fdir_info->mask = (struct 
ixgbe_hw_fdir_mask){0};
-                               fdir_info->flex_bytes_offset = 0;
-                               fdir_conf->mode = RTE_FDIR_MODE_NONE;
-                       }
+                       if (fdir_info->n_flows > 1)
+                               fdir_info->n_flows--;
                 }
                 break;
         case RTE_ETH_FILTER_L2_TUNNEL:

-- 
Thanks,
Anatoly
