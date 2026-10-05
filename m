Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E265ECA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 12:55:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8A714028D;
	Mon,  5 Oct 2026 14:55:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 88DEC4028C
 for <dev@dpdk.org>; Mon,  5 Oct 2026 14:55:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791204907; x=1822740907;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=q+PshjFd1nGdpK6F4mkHAtbMJ8vG/Hn/weer8lwB504=;
 b=NSliP+zkaDtinzDPkAHMcNGpuHJLCmrL0W8yUlclzQJkz/tug9jT8PVL
 GeV07Dr+teCU6RVB6pzgEPVWXc3RpyVJq7KT2UxOGAo1rVzxfnUtMGhUv
 AgIYHkF3XhAcmuMoc+Csx/psYaOE56ELIU/pLpG3NZhBwnSuH2da1ZhYu
 4FFXXJ1iEvC9enqSVfgS4xM0ye+ttvy0NMYvfTgoqo5XjI8RHiSp5GtjV
 2BzpMEdhYPSoEbmHoSNYi+L7IISMjB2MPEnc1XiUe7NI2TsSrQaRPXR+e
 XXOgd7BAcT5Hlm+GUogTB4ImLHUChee5/5qxYT3TVRdKcj0f2W8DMl8Ti Q==;
X-CSE-ConnectionGUID: 76ceYxkkR7CU0kRqni4JIQ==
X-CSE-MsgGUID: sFs57h6UTz+z3EsDJcDi4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="91736137"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="91736137"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 05:55:06 -0700
X-CSE-ConnectionGUID: cGwgT7bCQtmcqtUWxDKuXQ==
X-CSE-MsgGUID: hQCcFDy2RFuBnqqOTnioQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="276940499"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 05:55:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 05:55:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 05:55:06 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 05:55:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCK+LfyjHgrNlynwPb88opu42el4m9XXusuSDC7oyL97y4JB6nYSbXIbDsud0omsg6GbSffqVL50DSQl3Qs16W3rE2Ekr8r0+Xq8a+0/hlAc993/HngY4s2R+CqzO3Fb5lVm5GhxxFDV8uG8By6o0ya+LfKx8fk2hHL9rsNYl3CrS/7UHFKWiZNJEU4hK645F3izSe5iIa0apOTP6zTu7X79iZSmqOlPdssrGEda16t2NYyQyKd7z1dL2Agn42EtTVLwc6i4bOzLdgk2AhDW93VLNHXvsiA0FdN4QjPeBTTpr8K0NuDzzH3diPkWbFMEJa7Dc5SIc/3FtgJaj0e7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuEblExbY3w30JSoLAI7ZOKzlohbyxD8pNXaJTFd7xE=;
 b=gf6vKExEQPG5aY0zThDDCU+pYDjyT5hBfk1rKiwtfWzLmg+wAFvtYgoWMEITC3REm0wwkcWCI1Oy+BNRBoBveeO0O6lCRGm9bNGuZi25UcRDE/qMMqGbs+MTzBlGlLGNzrqrpI37WdKVUQ9AW/xqIxEzYfdcHqNvPuqjyzjldGMDjuEtDrTAzomqvmUiQVir6QtIkuAH2tc+LViHXG7iK6Ap3MVCc7yNuUAR5QT4cAtoTI60sxERf8Jatw2ifXG6DNV3e5+bHK6szSKzTlXTN0tzGFGaYn9zNvkh4ot4F582d14FWD5H0HlmoVL3sehCky34Wuq4YU2HQDYq/+f+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 12:54:56 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 12:54:56 +0000
Message-ID: <e3956442-b50a-4f02-87c9-d4e484409159@intel.com>
Date: Mon, 5 Oct 2026 14:54:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/19] net/ixgbe: advertise flow keep capability
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
References: <2b8b1ef8b636d23db9a9741f38ece4e31bf3997a.1789560946.git.anatoly.burakov@intel.com>
 <69ca2fa2-48c3-4d72-9ac0-36b81b7704cf@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <69ca2fa2-48c3-4d72-9ac0-36b81b7704cf@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0117.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 5527b011-353a-4e79-fe70-08df22dfdb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|5023799004|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ej1Zu7dVuWmb2cfIwlInWuNKH6TUPrIhSSiXSdKKKsEdcOOIj8L2lCt6U0i+GA5Z10q88N2WhuzpotEKl5u7ZG8Dvm6B5Sgm6sullxE8BAkd0pNRhWvlFQiWQxivotFKcXqUeh3WbJD1DUxcpNSiNHQRc2i+qCtRuEoK91ktGuq2qQOiO8JAQe3+MF4u6ipVbIGIQdrhs8WM2bKGWigsESdLAQ77fWou1AFjCqLO04OqOaB+YpdO7WsK6wN8OgR1KnOntbMmBUv1FWZW64HCfd5kDYc9x8BxITghmKty3zBjxWdL2OZZiivYftP5UUYTGP3lsKAMehHeixmMRFP+9lemLsXEgwo4bt48qv703+H5xOgbaZYIsaxreV0eE3IAMAy1QjSqjmIIPhEFBoInuF5zFx2yPWW+ohFhu+bkcDUXVG2hGFNBOS+DYlz05fozrdMQD4vKodUwjnWRCqw6PaDi9xSl8o4vev4J8sqBPX7YHDOVKC9pWbgjPkoi2seXq9+7VRA+EfCFjmkZ371MNm9OziylPkvbOacxsdzMx0L+J+8lYViMPTNaQiytoAk5pNimpgbBcK3xjuuja/vlftGVAGwQyqrFqsokT1xzpXqiKD85IVBVkcDO0Zt5hVrRShZdjgl7l7a/ZBL7QhORQmMe2lltrE+oHI5UUABP26g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC9LK1p6TjM0OFg5SU1YWFRMUUJ4N1dxL1UwYlp3K1pHclpMUGphdkFvNjRN?=
 =?utf-8?B?TkMxYVV4a0lySUxZMHdwQ3g5M2czUVVPYUYwWU4vSFZJazk4TGFxNGhOS3VV?=
 =?utf-8?B?L1hienRsVzByZ3UxNitnMlV2K1dGSkk3eVpzNjZzTmFkUkVna1Q3c0dabE1a?=
 =?utf-8?B?Nktmdm1pbWYwOTQzSCtBK3l5b050Vis3L2lKYjZ5TWxCSFhSV2pFS1kwNUxt?=
 =?utf-8?B?dDlKeWxrRkZjZGlJdFI3OXhHUEJ3dWRBK0tOUVlZOUNTdyt6aEhtYm5ZdVE4?=
 =?utf-8?B?VzhmR05LS3NHelhqMndsbzJxZGlnUldMd2hiZUFJZnpNT3Fzd2laQ0hTd1Y1?=
 =?utf-8?B?azJLN0p5c3ZGUi9QcUY3MmMwa3I5U3N5K2o1THkveVFiRXRpZ3I5Y015a01v?=
 =?utf-8?B?NlFpekdZMTV5dGFVMFBjTnVjLzJ2cmhxMzJIcjBHRkNwNE1zcHQ4NDNxbHQ3?=
 =?utf-8?B?UUFJMWdKaTl1VC80YzgyQkNydyt2TC9oa3ZVc3BkemJqVVUzbmF3OUp3K3kx?=
 =?utf-8?B?bURIbytnMjdlNG9mOGdjaUNYQkhmWnRua1RWZjdzTDVscDhjdStXaHgvZ210?=
 =?utf-8?B?S3V4VXptV01TWSs2NW9KZ1pOQmYzT01OcXRqakZkVmdXMGY0c0FuTm1Vekx0?=
 =?utf-8?B?WWllOXpLYU45bkkwOGxsaitYQTF3SHlsWTlMZGVCK3ZXRkVXU00vRlZmN0la?=
 =?utf-8?B?NDBLb3F2dUNUUklETHI1bFRvMkZGazVtTzJuZEpIbDdsWUI2a0FmWEF6VjZt?=
 =?utf-8?B?SnRtdlZSZVFBQ1NNRkNuMVdCc0J3UUN6c1U1cHB2S0t0L25hSzkxazNHRlFl?=
 =?utf-8?B?WlpVQ2ZDWmc4NGxGSG5iOFJGV0lONjQvbkFITTF0OUNxaWF0ZGJOanFQdEF4?=
 =?utf-8?B?YjlPM0FDZWFwazJMQStnODN0TEtaWmJ0NFFZQXhrN3F2L2lDcFdmMFBwUWhP?=
 =?utf-8?B?VFdaTm5KUEZIQnJSdVdEMjJya1NnUnBPSzVoemQvbHZ6WTFlbVVQbUVYRy9s?=
 =?utf-8?B?enVJWUdWU3BLTXROdlhDVWtWbUtDbjA5ZG9aZi9oRWxuMThISVFkU1hvZ3RY?=
 =?utf-8?B?RlRTWDJFeUZUVjRTRkV0b3VDRE1YaEpZdjFnZHNISVpwVzgzamcyNExzYlR3?=
 =?utf-8?B?b1VpeGxpU1pCRWpyeHZmUjdqVlEvYnVKYUVCM3hlUWRUQUdLZWFmSnVBTE9s?=
 =?utf-8?B?ekNReVhPRFVsVCtmd0pCMmJFRVNUV21QcVFJN1p5bFdSMHlHNHFoeDh4UVkx?=
 =?utf-8?B?ajJBbmN6WUIxUHdRdy9Fb0kyNEc2aDVKRERZVHljMTJoclhad3hRSWh3VWZV?=
 =?utf-8?B?Q0N1THh2TU5QamhTalhPTEtYRFBaSldOQTFzK05vdVZTelkxUTdWenVIU3dZ?=
 =?utf-8?B?ZCtneEdxWU04T1hxMUtIaHdCeVNqNEFCNzlWSWIrVUdHN0Yyekp5aHpVdHJI?=
 =?utf-8?B?d1NSRFRpcVZmTWNUYlZMY0c0dktDNnhUcFhEdHpaOFVjTDE2ajBoTXJOMHdF?=
 =?utf-8?B?bjV0RVczdXkrc2ZMcUtmbVZ6QUlKUE5iTmpkM1E0b093MXhmTFlyMld4UWVt?=
 =?utf-8?B?N1hDSFRLOCtLN1BJNE1zNzQ4eUtQWmNsVUlwRTNLTTlCdWNwMGFkMFVsZzhW?=
 =?utf-8?B?TXJ1TVpQeHdJY1R6YUY4ckNmT2ZNRmRzZFZaOGtXVDhYVUd5S0dYek9wSWMy?=
 =?utf-8?B?a25kbllXZkpuV1N5UDJrc2NRODA1ZnhZNmU1SkJnbXdaTkFTZjdTUWNyaUUw?=
 =?utf-8?B?WGFtQk54NHk3TThYb3ZzcUxaRXRjQ2phTGExNVBJbE05YndCeFNuOEZYeXBm?=
 =?utf-8?B?KzYzQ1NtWmxSakY3aGNwVWVIVU9ISlZ0RWZXQXlFeXFKYzQ1a1FJYmdrZmZp?=
 =?utf-8?B?MmhPV3lQS0E4eW53WnIzbkN3OHJoVU0xOGxzWFFNNWpsQ0Q5YzJzU1FkSXRR?=
 =?utf-8?B?K1dOZjd5aUZvVVU2dFdHYkxScUFUZmx5dlFzU0plWnZuVWorMkdrWWFtRGds?=
 =?utf-8?B?RWI3RjFRRzRQcXVPc1oyZWdET2NpeHBxT1ZWem1rNzhoU3IrOE55KzZYYVpW?=
 =?utf-8?B?ZE9SbmpUazlIU08zQ0tXcGlhaUtwWW9UUlJvWjFlQW5BNVVia1dhMG5JdGp4?=
 =?utf-8?B?SldCbnk3MWdoRCtyUzRCeE1NazhKcFQzSDFBa2NlTDJXYVZhVmYyN1N4VHhk?=
 =?utf-8?B?WGVNbTFaS25uYzduK0txZmYyeFhMM0wvaHZkMzNtb1hqK0R3MlpwUHc0RmJt?=
 =?utf-8?B?VFVJQ2dETmN3aElNekdKbitzaStrYjJKLzBRV0c3Zks1VEUxR3BNeFBVODAv?=
 =?utf-8?B?bmhSd3haNVRLMjFhVjBZMzJsUG1KdHNKQlBobnd3MVVxZTJJWVNQbGlqNTJh?=
 =?utf-8?Q?pPJolb+vzMh6N/AY=3D?=
X-Exchange-RoutingPolicyChecked: T0R2mv/xmRD1/uxFIj64U0U4eKZVoxH4U84qK9XHFWeRSnQHTikrvuVsEZSbs0Lj0wPLhlNX7N6FlKdV7L87o/kRvMAi9FNH06lDGKvmHLAVqDX69fvuee4IKswiWer4CHzcq0cKDbj3CFN6upWm8BHvpga/qU3uBQwW+Mb9YV1v2/flGz/LUChbBfj4lhdoFwVQEEKR3wj/EhihAH/uEXznNvJS2l9eBlB9lnZJGyL13bb/M+BRAsymwO0vPpHx/XZnepPsvN7ESuaWmbf3JmRV6cqAmc7zqhTv0nmgVY9vM6IK2OtwjBcnjkqu+CzUgr3D/c28jmT55fYayqc2ZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5527b011-353a-4e79-fe70-08df22dfdb14
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 12:54:56.1750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXdAHjhnta6W+rgKJ3XZSUrOlTpY0xoceI1AeYpJIMUVhUFZknrURsdorBrQdfhOtVIvU704IXsw2VvI5CAIXYZpzamYsXrpKZ7k7nsPaj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
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

On 9/19/2026 6:11 PM, Medvedkin, Vladimir wrote:
> consider reflecting this in release notes
> 
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
Arguably, there's nothing that actually changes - the driver was 
behaving this way from the get go. It just didn't advertise this flag 
properly. I'll add a note to the release notes in any case. Thanks for 
review!

-- 
Thanks,
Anatoly
