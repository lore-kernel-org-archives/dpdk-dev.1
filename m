Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75552CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:52:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2D8340DF6;
	Thu, 15 Oct 2026 16:52:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E8AF8402F1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792075959; x=1823611959;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IG/fKjZHRDzlRp0QUx99suj9oQhq0UYBsi7b9aYmjwY=;
 b=lDm2NV+ccf4VsCWXG/VWHiZX73dVSnfgnldwNSm2+x8NwSmdecLeOF5g
 vJsSxDHwpnI8vSmq23KKxIUlIDb0YBXt9iHSLxChmIIsdeJosxgmpZmeJ
 wvKB1wTVKD+NpsCMQASmqcLoqvFVH6K1LQfuW4n41uT4ZJxgvk7nFeTni
 3pYnJwD9KMKrnzSuP7eAOslMDHWQVPAnOG/dwCz2GcCjxqBG56WsvLIcz
 gzaeWcVu0FXpDNpAAtcO0zOyownAotQfJQksDwK8v/kDxPbPPHNByIFW9
 O2skuP8izqSR6yGOClNEEiH9FAueC9fFWweoC1t9U6peI/esKTMfSK25u g==;
X-CSE-ConnectionGUID: DzzNw8nfQBeK//JUhlJ1LQ==
X-CSE-MsgGUID: kPBYFhudR+qjcNkkLs7xUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="952646"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="952646"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:52:38 -0700
X-CSE-ConnectionGUID: 4zPjNR2mS5OVcuy6RyIutQ==
X-CSE-MsgGUID: lKfcrCICQm+qkAt0BVzEBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1727135"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:52:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:52:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:52:37 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTbLhW+uMJ5bQLpOtaG69Y1iXhydjIv1Uhge5sSp7UKC5Csb1+pGn4nhpw+X2I4QnbKiNC9IwlJO+qVEo7dOWuCzLr7akt0p9+litArdSLoCIZ2ATE9rGjk0M/F42QZTfwAEOwd32GAUD2NmwAK6r+g0iMOq8Sl/dyhJbgKRXgNLEZHjUhfu0MirdygZ+tFkEIvfYtstLY7dnCQdcM778nmfAV93s6wF5mUKF1JXkPeVZQjBON2yRnEqeZup6txa10oqKVaqlR7QWzEAcMFlneWOiY1/KDCDyPEJqv3VL8VEaGDthEovDBm7shkpWmYnCag1zjkhi0s0fDr0DiaRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=werJBGevfLkgBm9s88XCj7zRFuzyVITu5JmKxB7rZgw=;
 b=keOQjSIrBav6W5662lpE/hwBkxiFIQUn4I02/PbvM48lvx+RXHAguzeQ9ZOZMzmo7H4q4CXMugglhC8tkWO6SwkEYs9ObYGrhISA1FpX0jZrn49zBE7cYvnHNUokEezpcSu+Gt61+TgqAWUXtAG6x6GNgQidhQAn9JZdU/LZpZe3jTADEYhIGQ4uM5jviFjXJAxcE+JknaUYvA+yG7SwFCPPZTUzkWWym2e+XMMvHaCJwXKl3OEi+Rvqws2tkHuRJFQCH7ovebFs1pZndtc4h+vVrhA1a8WdDspJJzftlGzXWTCC6WLMOYrsPhTan6qZ1W+Ze8t76UXTwJRYKK91tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Thu, 15 Oct 2026 14:52:34 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:52:32 +0000
Message-ID: <c61f4b0e-21e8-4552-8d28-fe810e803580@intel.com>
Date: Thu, 15 Oct 2026 16:52:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: set interrupt throttling register
To: Bruce Richardson <bruce.richardson@intel.com>, David Marchand
 <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20261005110613.473007-1-bruce.richardson@intel.com>
 <atDYWtn8lwvGspyT@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8x_-WcbE6i5vh_vaTXPUqYwaNXNY7eFgQpqLjzHWP1CVg@mail.gmail.com>
 <atDc5cZqzHSSF-F6@bricha3-mobl1.ger.corp.intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <atDc5cZqzHSSF-F6@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0353.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfc46b3-d6e1-4b17-c69c-08df2acbf137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|4143699003|261009223027099003|22082099003|18002099003|260925021311599003|260925021911599003|10067099003|260925022911599003;
X-Microsoft-Antispam-Message-Info: V+XeRp1VeO/sATGYsA7KxeQiwKqmdaGRW9IK/mRMu3Q/mgDeWRXGmapWMORi4WmRh4zB7LX5j9myaSHpvTBTUcZ2TxoF7R6yhfH414N6B4w3ak6yQWqdz2FbLvo22sWmN5mlgaQsLG+xk9K9RB7pq7CvLN1UnyZQM5vadYo9TOtpZU2DVEy/9sX5H+oabUr4V8lC68VNxdyziOHyhN6CHzwZkIiTPsqTCj8iCJGmZMTK6ZO9xA6wkYEeYIA24zrVJMcNgohOlXhqPnOYbYSpYysbu/FAhLzSyZnO3fhkKqiKKvfF2XAX3zuyDazNuHaRmfWARisyx7HO2NTgBm04rAnY5EbfaHb+sHz4JZSo/KQhjULQ69d2QjiapAm03kxS9bGh3ejG4bbmm452Psrg3fY0vZNcjQjxsq+JCNCbE7veX+uevbdNasHWz8mtjK7L2xWFLtyCVKrO414QgGuuNk8Gtta4uDbmEJ08BA6T/mb2CXdMXsguzxeRAWV0TlbOYdGmw66mnRj9N1hQPF9rgh9ibnZVlrKOuLKYcazz4Hg+Ci5NziOJH7KfNIwwxBIEUaNk5o2oDMwAeoIJ/w/Nuaqf5Yxqj7kychnq1ScL0gu4jOWk1LyqSqtQ9EP18JFU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(261009223027099003)(22082099003)(18002099003)(260925021311599003)(260925021911599003)(10067099003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzY3RUxFMkYrOGwwbkgwd2VWMWVzczVVT2FiRGl2TEc3MGUwNTNwN3p4VklE?=
 =?utf-8?B?dU1XNTBzcnZtcHRGWGsxeForVytxdGhWeEhVYmF5Ky9lUXNCYWJ6RXVEMW5L?=
 =?utf-8?B?ekZ0L1ZZbEZtWEplUVpwaWVNT0Iza2ZIS2dOM3hXN3k0c2JSdXQ2MjUzc2FE?=
 =?utf-8?B?WEZKQmdTM2F4RFJhYTJndVNVNHk1b3EvaER4d2tCUGQyM1RyK3NaRUpBWGQ2?=
 =?utf-8?B?MXZ0SFdDR08zN0w4VWMzMWF1QTlLUklNc1NaQmM0Vm5hU3FiRytaRW0wQUlH?=
 =?utf-8?B?QmE3TFFCajd6SmJLVGdWUzZaWnFLRmRwNjBYWjZMZmRHcng4amVpRzlpVWJr?=
 =?utf-8?B?WnFFeUZUUVFQTElRUG43MnRTSjBCeW5KQkRtaHBVVk5wRjZyam9jTVV4T1Mw?=
 =?utf-8?B?S0dFQnRMQytGTU1MMzBua2ZROVNudnYyVHc1S0dhVXU1UDBTWGVKYmxtaVZT?=
 =?utf-8?B?YTVnN09Xc0Q1cU9EbEJVZW0wQkE0T3BoME91ZEVoZDh2WDd1MVZWN2RLQzQ0?=
 =?utf-8?B?emYvZnluUUFEa25EUHBsUUVKU3ZvR21pZ0xXV0JpZGxSSTFieVVxcWxJTzZK?=
 =?utf-8?B?bWpJY2lIdVMwY2JhOU15S1MzLyt2S3JoMHg3YldXT1Fwc3JTNTk0M05tS01P?=
 =?utf-8?B?UXVSam5XVlpOKysybDRHZklwaXRQT2YwOFlMSXI1b0ZMVVpWMERodmh4VU1j?=
 =?utf-8?B?cVhMY2EzdTlRTHhNNWJGM016WlVHVWxWMVBpZWhlbFJ1ejJkZ2JFQ1dlV2R6?=
 =?utf-8?B?NHYzSGsvZnZzbi9zQVg5ZDdTNXNxNzRsbFZUNnlZVkVkUG1Hd2w0UmRieU0z?=
 =?utf-8?B?dkIzMjl4MVBPSTIrY2JDUnRtSUlraG0wVUdUbFZwRDU0R2RlNnVWNGIxdEpn?=
 =?utf-8?B?UzU4SFNwZ1R5Ni8vMFpia3JPRHp3UjgxSG0rWTQ2VTh1SDhkcnFNSnJtY0JG?=
 =?utf-8?B?K2dwd3JtU2RhZUxGc1puNnk5dTE1RDgrT3RFaVhudEpnb3F0UWx5SkZHWUN2?=
 =?utf-8?B?YkVJQVNjMDZSMmVxK2hBNWIrMEd5a2FVU2VQeEpFNENib2lTZDZmejFFZTFi?=
 =?utf-8?B?cnhKOVVycCt4cUhEVnkybXd0T2JJbUhZNGNhdkFldmdyUlBWNmhTMnhWZ1gx?=
 =?utf-8?B?NzZEbnRRRjVLUjA2c2ZDWlZ0UkNCWUYzK0hRUk5KWWplVXE2dFhudjRubGRX?=
 =?utf-8?B?cXJ2ekZraVNKYWhTS1lPYWlaNUtmMkZHUE9oamc5UkpJem9oS04yVHU1cFRC?=
 =?utf-8?B?dlVCR2FGRXlFb1o0bHhtR3pDUkpZallKT3JxVFlOVmJtOHBFbHlEVHRaU1Jn?=
 =?utf-8?B?c29xM2dEb1Z5SzNvbm9zeXJjUVByRkcvNk8zYWpJR0VuNGxsQUZYdE42QTAw?=
 =?utf-8?B?MW1GYVptR0NhelI1RGZOMGtlR2M3UERGZy9sQnBuaU1ic3c2dlNrK2trRm5u?=
 =?utf-8?B?YnlTQTI2TFRFbXRuTmEzZWlrajN6bFJLc2VaQVM5WDJLY3Erd3NYVUExOXho?=
 =?utf-8?B?RmdDbFpwQnJybXYvcWdDYk1OMHVwbVQrS0hTRG1XbkpXbExyS0dMUXIzczUv?=
 =?utf-8?B?bWozTkxqdXZOdkhIU3NpbHRaTjU4UW5uK2d4OU1rcFNCcE14V3lwUW1qSW1u?=
 =?utf-8?B?MVlVNmtEd3ZOS09UdUtTNUN5WVM2dlVzd2pBRXpaczNldFhGeDVIMG04cXN6?=
 =?utf-8?B?Q084L2dHOWwvSU9iUU50ek83ODJPQWJSVm42R0RxWHQ4VXIyR0pVN3hyYm9Z?=
 =?utf-8?B?Q0puanRvR3dTbUQ3NXZpNDNaM1ZUY1F6MS91UVFrbHpuTmtDV2l3NlJTQmgr?=
 =?utf-8?B?MlNubmFPM3JIUE1laDhGSVZSMldlakV3anlnM1JqbFJQZklkR284L1ZqZldT?=
 =?utf-8?B?TG5SSCt4RG5BVXl5QWdRSVZsTzlka1czSi9ZN2YvOUpJT21jWlBvVThCamtU?=
 =?utf-8?B?UXRVODdJdVhkMVZzWTZJY2tGdTJlMDRBUlRHUjF5WE1meU9CZTBYUytRSnVR?=
 =?utf-8?B?Vml0TXAyOStTVkRWcVA0TjRZWHlSb0swdnZjWDQzcFZ5TkxobjhpV1RDSDlm?=
 =?utf-8?B?UDNsZFhpb2JwYldsYXdpMHpiQzIrQ0pleDlwRThLa0JnclVLRFEwdmNJSFUz?=
 =?utf-8?B?Nng1U1gvMEppc25vdU5qNGhGdjUxY2UrNWlqN0tLRlBHd09LdFVwVHEzV0NO?=
 =?utf-8?B?bmpEcWhnaGw3RnltSFcrZGtUdlh0dWk1VTVxd1h1Q0RZUUNUTC93Y2ZURWZS?=
 =?utf-8?B?UThIeGZCTlNWZG5ETU90YXpnUkJqak5qR1NtTG1iMm1ycXFnVHdIRjN0Z2N0?=
 =?utf-8?B?QStzMkQ2cGQyK3lSSnk3Tm52U2dmVWN3Wm5BVzIyOVc2WEoyR2o3dk4wZVgr?=
 =?utf-8?Q?qnO9OxNISW+C4L2c=3D?=
X-Exchange-RoutingPolicyChecked: IrUx1Tl9Twx1FRZQaqQNbZu3cW2HGCQ6qgHd0uXhtclS7pfah4zxDdCb/M0b7CT1P94uPWhr9yWvKeEyqK2Ydzr9TAJMaUBWEWjQzFBrEnci/FOckhSPu8Ks7qKPdUgcBAX0v4m9FeY1mUCgIXzr+3SiYwsRiHlyeQyNZSoGe6eT6eCLh6FiUT+CALzDuPzLI4dMPQTFUvAuKNjI+IxUTO1ozSSJ45ozOOxabQdKWdgsRgEsYKgNWoNg9XIhbfLDCilVvyGUp2bYHibQSbE3LF4SCwR/MhUL8sR4ZuZVA+6cRQq6RgoPpEhj3uBUuy1mEQgI3SMK5auM6kGRd6+ZMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfc46b3-d6e1-4b17-c69c-08df2acbf137
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:52:32.4678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pg7i5cfDBLQ+Fwj4utOWr7jgEao2HhlXCf3wPZQbrx68xyLiCNM5bCjUwsgrxZG25Te8lRWbbEAUh14BERjn0n4dbBhQq3F9TKGyFtPfIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
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

On 10/15/2026 4:02 PM, Bruce Richardson wrote:
> On Thu, Oct 15, 2026 at 03:47:41PM +0200, David Marchand wrote:
>> On Thu, 15 Oct 2026 at 15:43, Bruce Richardson
>> <bruce.richardson@intel.com> wrote:
>>>
>>> On Mon, Oct 05, 2026 at 12:06:13PM +0100, Bruce Richardson wrote:
>>>> The interrupt throttling register(ITR) bank 0 value is set to 2, but
>>>> to ensure best performance across all systems also set the bank 1 value
>>>> to match.
>>>>
>>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>>> ---
>>>>   drivers/net/intel/iavf/iavf_ethdev.c | 5 +----
>>>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>>>
>>>
>>> Further testing has indicated that this patch is simply working around a
>>> config issue on kernel driver side[1] and should not be necessary in DPDK.
>>>
>>> Dropping as rejected in patchwork.
>>>
>>> /Bruce
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb096882095e5a8d6b5159e43793d4a38a0c5b1f
>>>
>>>> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
>>>> index a8abe0154c..dc3cea0b95 100644
>>>> --- a/drivers/net/intel/iavf/iavf_ethdev.c
>>>> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
>>>> @@ -899,10 +899,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
>>>>                                       (0 << IAVF_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
>>>>                                       IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
>>>>                                       (2UL << IAVF_VFINT_DYN_CTLN1_INTERVAL_SHIFT));
>>>> -                     /* debug - check for success! the return value
>>>> -                      * should be 2, offset is 0x2800
>>>> -                      */
>>>> -                     /* IAVF_READ_REG(hw, IAVF_VFINT_ITRN1(0, 0)); */
>>>> +                     IAVF_WRITE_REG(hw, IAVF_VFINT_ITRN1(1, vf->msix_base - 1), 2);
>>>>                } else {
>>>>                        /* If no WB_ON_ITR offload flags, need to set
>>>>                         * interrupt for descriptor write back.
>>
>> Why keep this dead code then?
>>
> No reason. Just haven't got the time right now to do up a replacement patch
> to delete the old dead code.
> 
> /Bruce

I submitted the dead code removal.

https://patches.dpdk.org/project/dpdk/patch/000a4926363e5be631db4f8209bed02d11369912.1792075372.git.anatoly.burakov@intel.com/

-- 
Thanks,
Anatoly
