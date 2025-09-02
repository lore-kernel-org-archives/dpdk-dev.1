Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA8FCA0FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 14:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42CE7402B5;
	Tue,  2 Sep 2025 16:14:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B540B402B3;
 Tue,  2 Sep 2025 16:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756822463; x=1788358463;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KtW9HC1Vw5IdaAPS4YIuEMr11ZiB6vKB8+AuE/AVVhU=;
 b=hhvIce0F5CJqghHSIv48TDPe5aOjD8QgI2lx16Head4F4gmDdy1AERcU
 Jk1fKL1Sj0vdSg738b4Q/qBVG7lgmDC2+SBs6rEGP6M4d3PBmEYDDyZOY
 GqwG4RNUCgWeupxH//gXCeyLb9UgWG7zvQNULNEYYNFQuRKBEM24RXRAB
 2ph3ld/sJ3Zd9zaCvcFhk9bLjoHCQV+VBBI0wA7kSG/shmCfuQNbwI+Eo
 1EcKOtdraltVlsT4Bjv91GXCskX7hfac6R7tUDDjrh5+dIJjZFoOoarie
 uzfOvIUVCitmBBDhfYv/yxB0xWDcSwbuxIl2t5Iur/Mlw9qSMzoiBLFhs g==;
X-CSE-ConnectionGUID: sLTevoIFRGyeWE+KzNYqcA==
X-CSE-MsgGUID: /7Lw7oHqQUS7tHXCQfJ1mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59036442"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="59036442"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 07:14:22 -0700
X-CSE-ConnectionGUID: 1lWv1Ov+Qh6v8RV7oV0lUA==
X-CSE-MsgGUID: i7hGoco0QMKb5IdLyHOhpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="202211990"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 07:14:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 07:14:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 07:14:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.55)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 07:14:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyctdQ1/aPXjXpZoqAMl8Lk2BCLC2b+bJ6gipdNk+8dDsgCjpZ17kjmtXGFaw2RFwHDXBgCsMG67e1HYbt6rLcOOQqy6fKOfIKFhaMFMLu4NYx3jLNLCjT29j7d9pwQYeVSRMfeptp2aZsz04P/03LQpFEXzwtY3Tojjh3UtcMZCnEdc2T0J34HlISUMrrD6viKuvMddEiWtsz84tnD0pX3J1upSfyEKtiRmvz7DHe+7RJ+6Fqd7UxS3SdEGhoEUDGxfy1ShbDIKEASy12c5LU2cLynvVtYcQ2dBefQByYoWgTxxfgp0/WzqeMtR3fD6vXwH+H1yNc47JRaot1MWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0rTtUar4rcPnAycE9Ji71VXfQu4IeR8/kL84Tinx2I=;
 b=uGTNl56ok95HQdaimoxuxhGrhSIG7ejip+EB2RcwczC0iuB4ho9Q0zK7c422dYXbOxwS7bUs+F/yqEF4rnNjPA6WnX3s6eqAs6nOXHvZdylJye9oUDtRBzprS/z/jEMydxrVJKTcsGhIWfeBJG45V9CMwdaIklkA9oyPKzuSiGoWAzzhpD2fZ/cUbjTRw12XhhIYU0GoNGq3dHLUua7j3fGKX47IPSANuDu+Oi3CxRR/6KQXspVDXreUrEe4vLBraCN9tuHN8dMALFMoOb8EDxSbZ5XAJku7LsjQ4SnON6IzppNQ2agFhwP2DxWsM10PWJNeCe/Us6KfuEXBGPfnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH3PPF55C5E51F2.namprd11.prod.outlook.com (2603:10b6:518:1::d20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 14:14:18 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 14:14:18 +0000
Message-ID: <bb7e23db-eba4-4912-b6af-bf51cf25a2b2@intel.com>
Date: Tue, 2 Sep 2025 16:14:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] eal: prevent socket closure before MP sync
To: Yang Ming <mosesyyoung@gmail.com>, <dev@dpdk.org>
CC: <kevin.laatz@intel.com>, <stable@dpdk.org>
References: <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
 <20250719153227.1980-1-mosesyyoung@gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250719153227.1980-1-mosesyyoung@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::26) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH3PPF55C5E51F2:EE_
X-MS-Office365-Filtering-Correlation-Id: 7905e2e0-9c19-4821-2185-08ddea2b00dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDBXMmpUZ0N6RXJhem5qWld4YklMZmtzNnFGeUp4RjJvSWxwY3F0WXhuVFFS?=
 =?utf-8?B?cUVDRnhra1FreFlySkpTYzNCVks5OWliWXpLRFVZMlpwRHlaSE81d0pvQXhx?=
 =?utf-8?B?UkZNSWhRak9qb1JZdERnZFF4dFZFKzFsNW8yUzV3MytFSFM3a013Zk5yQmtB?=
 =?utf-8?B?cGxxdUdSYnhXdk1odll1Z1dPay9FcXdQTitQVVg4OGR5Ykd5UGN2Rk1paHNn?=
 =?utf-8?B?Z1dSV3NYN3M0UG5ieDVXMFJuc0FpbGNBNjUxL0FFWWswN3FFTi84UFNCQ0p3?=
 =?utf-8?B?T0d4S2hpQmlITnNocktzaXg5ajk5WmVHZ3hLSmNkUzB2RjRjZVhCd3FOeUI1?=
 =?utf-8?B?ZFBzMmtBQWQxT0prYTNHS0RqZE9tOHJXdWtjWngrcWhBdjQzRkcwNmJ0a2tn?=
 =?utf-8?B?d1hnN1g5ay94TjVWM1dyYzBZYVREb3NJVzI0WUJIR1RIcko4bVhRTzBUdlM5?=
 =?utf-8?B?SVJMODZLWDczMXpKaldEOWFiclVJR0VZK2F3WVZUS2dldkZoMjVuL1h0VTEr?=
 =?utf-8?B?WnU0MjdRaWdKVWpNaG1reFZ6ZkNKSHEyUkdrdWppQWkzWmhGZDIzTlJKRzFM?=
 =?utf-8?B?RFlZZzIyRWNORU54ZVhYTFJucjhWdUpyUnZUM3dyU3hrVjZMN2VVUjE5MXRF?=
 =?utf-8?B?MHFDY1U3dlB5enV6dGxvUk9oUmlLVnZpUjFMa0xzdHh4UGNDc0o1RkhrUllY?=
 =?utf-8?B?N3ZkVDk2MGZxdld1VG9LSVgrakVzL25MMDZmZVFQZWpGeEJyY1F6ZnRzUjNR?=
 =?utf-8?B?TVNZaUlQYno2YmF6UytnNDBYOFJkeEU0Qi9JL0l0a3lEUHFZM2txZWc1RytT?=
 =?utf-8?B?cGppZEFyMjRRNUU4ZklicEVNYXRwcGt6V2k2ZXNOUk51aVM5VE5kVy9WYXpT?=
 =?utf-8?B?U0l1a0g5ZjJBQ0hoSVg0SHVvbStpai9kdFVsOWJMWDArYjZUcWYzNlZKOHda?=
 =?utf-8?B?cm5jQmJyL2lGMmRFN1RsQWVKdjVlNWkxbUNScE5HdDhnUVBTRTF2WDYzY01K?=
 =?utf-8?B?N0VnWWJ5V0IrVGtoNzZWQkQrcDRxOWdHU1F0MmdmVWlNWVdTWGdISTNVWU9n?=
 =?utf-8?B?TWJXNFBtbkpkMkJlNGhHU0lwcE41Mm01dkNBV29nVmxaZGFMTVNBMno1dWFr?=
 =?utf-8?B?MWtaZ3FoN2Zwaldrd0tpTzhtWUJWTzFpaVRaNGRxVWlSTi9SSjRPSVdUNVY4?=
 =?utf-8?B?K1d4d1kxbkFtNnoyZ2FUb3ZHajVYcDIwZTk4aExwdGVNRkx4RzYxRndkVGtR?=
 =?utf-8?B?VVpaeUNSUm5vVklRUS9LODVBaTdZL0VSaWFGSjBVM0RIWDhHalBMc09ZRHZl?=
 =?utf-8?B?bmxBU0I2SzFOb1FEU2JHZkM0c2FoTEtPcWhaZFNhKzBFdEEzdVlsbkYvS0hv?=
 =?utf-8?B?SkhOSFRwa3NUVHZGeUNhbzhON1pyTVZxR0FjMkM4dS9sQ0laRkdEQzBCODRB?=
 =?utf-8?B?aUg0UjhYMVUxTmFGQjBoR1VxNEZrbGtEbEZOWWI2Sk0rM20xN28zZXlNM3d6?=
 =?utf-8?B?VXZjTERxN1p5Umw4bzZ3elY2akpEbDJ6ejNsRTVaZnZySjlQWGlVVjBSL0NZ?=
 =?utf-8?B?eVNHM0s1OEExdmlCL1lEQTN4ZGlVMTlRemdnQTFFUEN4djc4eHhoeXpLdGFK?=
 =?utf-8?B?WTBGQURqU3Z2aXZaTmtFRGZ2Qm5wd2tHUHZ6UE53ZkpOc3B3UGh3aEh4ajg0?=
 =?utf-8?B?cjF4c0RiKzAwa3NYc21MejZHWXNRcjVXTklCWGlzYWFKT1RGTGRoMWNTb2wv?=
 =?utf-8?B?QkRCZlJ6dkdxQmxzcThRQjhXdUluc0JHY1NZcWNLWjNCdTI5WEVaUWwvS3Zi?=
 =?utf-8?B?SjJFY3ZiWXB2Q3BtZm1KNE02a090UENNMERkeVl3OWZjdTFoK2N0Z2pyMUR6?=
 =?utf-8?B?QmIwOVFVbng0bGEzR3hnSGJHaGtpV0RqUDc3UGV2SzRPcE9leHQyVnJFd1pY?=
 =?utf-8?Q?STkMwFHq0lM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFRXNVJia0lJcDBpS1lpZzRyS01oUnJTODh5YUdFQjlQSzNDVHBhaTBZbFhE?=
 =?utf-8?B?OEVlU1hqVDVQbGRzcTNid0tqcElGcVhrNmQ3UTEzYmRLSm9hWlozNnpHMHd1?=
 =?utf-8?B?VFo0OW5aZDF0YVBpS21uaVNWNlp6R0FVYmxJNEl4ZmRwNFZtNXpnMGMrZEo5?=
 =?utf-8?B?KzFNSllMS0RQaFAvNnRPU2VnMGpvR3JDNDBncVNyWWFqZCtUN3dLd1d4ZThV?=
 =?utf-8?B?dFp0M3I2VGN2QlRWSWNxNk9NdVYvMjNYRlNZNFc4emVlb2hqUG1wakcySWJQ?=
 =?utf-8?B?QU8vQW9sZmhGRlZ0SVY2NnkwVVdXcFd3c3BycWprQUtGOStPamV5SlIzbUcx?=
 =?utf-8?B?R1B6WUFSYlFpc0tqRnV3Q1orNUIrRkoxd0FZdUI3NnRKMTZWbnlPMm9UQVkr?=
 =?utf-8?B?S1NoV0tkbUs4eEVsWUt0Um10VFpRTklRZkRIaWNXQXZENU5zdWVRUTdPK0FI?=
 =?utf-8?B?MDVHRGR0ZElDeHZaaXIzNGVHN2R1SHpmalVHOVpOZFV1NlorNGZEazZOQW5T?=
 =?utf-8?B?QTd1YWdpRk01bE81eHNZanNRWEZsTUdOVUtudmY3MXpFdCs2TkdFT1d3c2NX?=
 =?utf-8?B?bkJiWnZnZ20zaUk1NjNQUzVYVkVjTDgzdW1PdEFZeDVycUk4MXZoeVZIcGxm?=
 =?utf-8?B?TnliWEVsNGVGWXoycStGVmhwbTNYam9kK2pIQU94bThkZUI3VjRkRnMxQzV6?=
 =?utf-8?B?VTdBWWRCelZGNzg5OXdMVFdGak5VRW1BOE5yWkV3UUF6M0JvVWdUVHBwaGpK?=
 =?utf-8?B?RTdubjFybHlscG9qaG9nM2tsUnlMY0QyUGZYRGpSQkxXUHpieVV2TDgrNHY3?=
 =?utf-8?B?QXR5TC9CajUzSjFjUWlCNTRHTUNGOUU3YndwWHQ3YTdBUHNBcmlRejhaNExL?=
 =?utf-8?B?VjVWZ1lEeFgveDRmV1g5dzk4U2Z1RnhMeXlkVEs0dGVaV21GZ1NoVkRmL2cy?=
 =?utf-8?B?MXpZRlBNdXVWRmx6Q0JnR2U0NUlKNlFYVFZnZVJrcVVhN0FLQ2JRdmtNUVB6?=
 =?utf-8?B?dEtFcm5MSGcyL0x5ZktvWjVaME9SYUhkN09HQjJCMFA2azVaS0tIZXgxSjZL?=
 =?utf-8?B?MGlCdlY0QlMvbDY1RTZ4MW9uRitPamFabzhacm5aMjJDM0NwWTRXNTU3SkFX?=
 =?utf-8?B?S1h5WVg0MjgzdWQ3RGZKQ1FGNWVFNjRTODR4M3FVYldaemZ5bkRIcGpnN1JM?=
 =?utf-8?B?VDNJUXpCV05BQ092bzdGY0xxam1ORzRhY2Ird29VclJ4NW5RY1BLSWRLcUw2?=
 =?utf-8?B?dlBoSnhQWUlwbkg5eWh1TFZNMmpCNGhlMnEyZnlaMWhZUDNiaFJXc0dIN1k5?=
 =?utf-8?B?dXUrUW8xYVl2QmFXcDFPbEZnRUFvQk0rc2lZUFM5U0kvbHM0SGsyTVc3OExR?=
 =?utf-8?B?d3kyS3Bqd3o2R1VqbnVTcG00NGtiY0EzYVlMSUh5YjRvYXo1M3FTQ3ExZFRh?=
 =?utf-8?B?TXkxNkU4Y3Y4RUZQc2Nvb1EybWYxTU0ySE1CYk5iZnh0SVFMRmhUVURNeGh5?=
 =?utf-8?B?em53NmRVU1h3NEQ5WHh1K1pZanNlTy9uZkhJcFQzS3V2TzdFK1g5QUNhWi93?=
 =?utf-8?B?K2luRzJJQUxlbEt0Rkk0SEpyMTByKzNiWGxoTkxsYmM0VnVmQVZuenQwVEFr?=
 =?utf-8?B?YU9NT3BpWUdLTWhPWWlQV1BrM3RQcGtKRnZscVhxbXAwWTRDTmlHVUl5T0Ny?=
 =?utf-8?B?aGxkdmhKTFdRanQxaUt3ek9ZMy9QTWs4OFQ2WHJsU0hQUDhMeFJPWFhTQnk0?=
 =?utf-8?B?b083ZWdFaWNMdTA0MXowaWgyTXVrMmJUekJwTEdqQWxwakJoTEZVRFBaWElz?=
 =?utf-8?B?Z3NuRTdTNHN1OHFNdGRqckM0MFpHd2VsN1lHdmxBS2lrbHdzVklwZVNtdnVU?=
 =?utf-8?B?M0FROFZ2b2xlM3RGOTk5K1RtNGtRajNRdE1zeWtTSEIxUVFkTlkxTXhrQkQ1?=
 =?utf-8?B?MFo4TW9KbTVIWnJxMHFnY3lHRGV3TUZCbHJ0ODhycFhtNWpUdzdjQnhJOGJK?=
 =?utf-8?B?Q3JMSDIraDgwL0FGYkxUdEhlR0dIeVRYVVpDL3lqWUdPbTVPZS9oUnhVUGwr?=
 =?utf-8?B?cHZZVEdXVDBSdFNHUHQvcWV4ZTV4Z0RhS1ZaMEMyUlM4VC90bHNPeEhUWXFl?=
 =?utf-8?B?dzdTRVB5ejhEWi9iZjRQbDhiazFCQUhKcXA5T1JtTFhJNE45YndDTWthQ000?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7905e2e0-9c19-4821-2185-08ddea2b00dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:14:18.0289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDMABIkNhVlni5GuPP3e/8qttqfH78P1uMn+e+NHHheUH0p3LIE2wiRFUJQrYA49K+vLulPBWxcCP6KOEoLKHEP5yYSePdO00HIEZ9qCLk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF55C5E51F2
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

On 7/19/2025 5:32 PM, Yang Ming wrote:
> The secordary process should not close socket file for MP
> channel before performing MP request synchronization.
> This prevents error logs when the secondary process exits
> without any operation on the crypto device while the primary
> process starts the device.
> 
> Case situation:
> eal_bus_cleanup has been added in rte_eal_cleanup. But for the
> secondary process, rte_eal_cleanup firstly performs
> rte_mp_channel_cleanup, which closes socket file for the MP
> channel, making mp_fd invalid. Subsequently, eal_bus_cleanup
> triggers vdev_cleanup, which calls mp_request_sync to send a
> message via the MP channel. Since mp_fd is invalid, error logs
> occur.
> 
> Error logs occur as below when the secordary process exit:
> EAL: failed to send to (/tmp/dpdk/l2hicu/mp_socket) due to Bad
> file descriptor
> EAL: Fail to send request /tmp/dpdk/l2hicu/mp_socket:
> ipsec_mb_mp_msg
> USER1: Create MR request to primary process failed.
> 
> Function call trace:
> 1. rte_eal_cleanup->rte_mp_channel_cleanup->close_socket_fd
> 2. rte_eal_cleanup->eal_bus_cleanup->vdev_cleanup->
> rte_vdev_driver->ipsec_mb_remove->ipsec_mb_qp_release->
> ipsec_mb_secondary_qp_op->rte_mp_request_sync->mp_request_sync->
> send_msg->sendmsg(mp_fd, &msgh, 0);
> 
> Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
> Cc: kevin.laatz@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yang Ming <mosesyyoung@gmail.com>

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
