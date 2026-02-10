Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC3EEA8109
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 12:19:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01D23400D7;
	Tue, 10 Feb 2026 13:19:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B1D64400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:19:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770725945; x=1802261945;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T+j+Up5lJkPXu3w0Sd9ObrNAQpdIFrf0cx4tEdUrN4g=;
 b=V2YQiuszIlZV/KPZwg0QEI5fW4U5UtvYUD2barwTRPhfNLcQ7RU5UMfd
 jgl4fCStlgDWtSO3piYv+qaqQNhSGlt5oaYe7ylaIQAKm3MR5ykZY74kK
 5dwRmnCEWVBNQxp0+D9weew9iCIYnL38vVgs8L90KXjCdih9a1Lp0iXPc
 UitwXPO06ic+t+MSpJoDk49lIBeVZIMzvh8YaLiiknjodyWz7wvz9P30D
 ZuZi/YTLoZu0sbbM1aa3EI8c5TSUZToo/NM2R0bFNAXSsGz+Baayd+AUX
 LIZDwPIT2I+6FNR+kUd5I1npREKjYCtKzSQYRbdo372esUuVoW9rCjz0C w==;
X-CSE-ConnectionGUID: 97cPkPzZT7+zssTaqy6t4g==
X-CSE-MsgGUID: V4Ra5wiNTpqThiQ6BEPNQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="82175637"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="82175637"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:19:04 -0800
X-CSE-ConnectionGUID: G8fDd/5JTK6Za1J1Bsq3tw==
X-CSE-MsgGUID: iC1x5TdGRH+LstrOjwC17A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211234140"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:19:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:19:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 04:19:03 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:19:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3LFobPykCzACl3QX3CPE7cZkllLjn2rioVloB8OfMSvNjGD3NqZr7VvTpDy1QPWgQ4+1lQDGv8UTX96biJD3sXF/oZ0M49mTmPxLrlzhj+tQsth00m0t2vLMCWXtWZKVU2wLRMO38VUPXKiTYiofpjbgbwQ6zNrmShzkJZC5Bqdmvh3sJ+qLiX6yR6ddHivonpxyvG8o3OLivA4itEmXKNH28NGYCxqctDwPXSaafpk8u2oyqn/WnJbdhysw4NO8dweOOBUHhef7cn2trtezT56DwfqkutDMMtjaDjoPcd5IwCRuAgUuyQQPZsd1YQNy7Fu4GoVw/x6xEhcitQLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4NwvTHkD2iCKySJnVCL9FGURdgRcxZ3G3pEHPSeXzY=;
 b=wSlj9Kg/raXpoGsUpDzImH2Yk3idncNnFnSQ9qcDLwuLmMkpHA3J8ghl+wPcrNddhCDGV0LkLsLAn7/24gdjET5rgGNwfETlyCxmWz6+cjrAfL/x/JOcwadbHx4ZWz5vDbht7TPmQmtzanMaUOrh7TCQUoEQmU/JlaUJgLAkCr1RcFuCUh/4rc3L2U2QJ3dBNOAUwJSwlgC1MqPXVHGbUvan/zG6WWCch64Xq+NcbcmolHfybA5RsD2cYk4j0o7rBeApFlD2PKrU/qsWDnSeC9wr08Nd1VjxZ55DF4cx8JW77ZLdwC2apvfyhpBDKrCq3n1ZH6iHx03mGRUzsKVEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM3PPF90FB92BE6.namprd11.prod.outlook.com (2603:10b6:f:fc00::f38)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 12:18:55 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 12:18:54 +0000
Message-ID: <929374f2-1290-44f4-9242-6938c8493812@intel.com>
Date: Tue, 10 Feb 2026 13:18:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/35] net/intel: create common post-Tx cleanup function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-4-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-4-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM3PPF90FB92BE6:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0dd957-2454-4876-47ac-08de689e8efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGpDamVVcC9RTThYODRyNU5LMGorcURNaHFBTitUaDVoOHh4d1JqN0tqS3hn?=
 =?utf-8?B?ZVFrS05rNlJIRXE2dEhqaWZrYjFTZTNiZm15NHVnNjBQN3g5Yk4xTEZRNlg4?=
 =?utf-8?B?eUQ1VkVZRWpOQ3Z5WmJ6em8zYVJSS3NvV1hLdXdNMUJtR3dic0ZIcE41dHlD?=
 =?utf-8?B?NW5IbkJjUm52TTFscHRydTk2b0RJdHFHYi8xSE0yc1dGc2VKWDNFaDY5c2Vl?=
 =?utf-8?B?dngvM1pvd2dHTWRKUy9SSVNNVFlZZm41NXNEZEdCOG8rWXhYZDhMTjV6WjlM?=
 =?utf-8?B?WXJaclREbEMzRVZrUWlHMjJuOUJ4SWpwZjU1MFhtaDRGaCs1OTd0bGlmQkhC?=
 =?utf-8?B?am9sdXNIeGFOam9oMFhmMGd1RzdkK3dIRGp4UGdkOTZCNnB1b0QwRThEWWJp?=
 =?utf-8?B?cnNSUUttUXFSc0l2c1M5UU1Gb0hrSURrUkVkWTBrMXZGRllaQ2hGNlpHeHF2?=
 =?utf-8?B?cEE3clVXMmNnYlF3Mm9jT2ppQndrNUwvbXk3aFhNZGI2MnJvSFUxc2pqeWFJ?=
 =?utf-8?B?WGtoMXVEVnBzNEJXMHJmcktkeEVkNTlqbWxTdC9uYzFpSng0TnU1NU5SUTVx?=
 =?utf-8?B?aFlxVlFacndEMWo1Wmo1aTVVTlVuQmVPekRPOUlOam9ZUkl6VWcrU3BkWFNN?=
 =?utf-8?B?MEdmbit6dzJqSFJoWmxRc2tOSjBIWURLcEpSRW5lL0pCOGV0MlNCa3hqV1Nu?=
 =?utf-8?B?MWt6U2RaZm1XT3IzMUdQNzBocS82MytJdnpKc0YwTGJaTGwycmo4bkNvNzJK?=
 =?utf-8?B?cVBxM1EwY0VhMk5mV2xubkZkWGQ4YUNER1VtZUpyNFFDd0c4R1M4RWpub2ZU?=
 =?utf-8?B?dzZ2cEwvaWlBTDFEVmpPS2JIT0MzSXYwemtlaXBQQXh0M3ZVdFI0OGJMRC9z?=
 =?utf-8?B?Ujl0U3M4dWJwMXdMeWlRRzFKcUpiZGQ4RTF1QVQxaVdSQVdNL3BXYU1LNVVT?=
 =?utf-8?B?SlIybk1tSlFHc1Q2dlNOdzdycWJBSG1YSnV4TUxMTks1L0xHdUZvWWtuY3VB?=
 =?utf-8?B?Z0ZNSURpYzVaQk9CZHdLZkxrQUZtVHNQNlpGSGFJeHJEN2FIR2YwZDZ6SWkv?=
 =?utf-8?B?TDZUMDVRaktaU3NSUFBQM0VlZTZETzFnZGZEVVpvTFAzNnpHL0liQ3dwR0dR?=
 =?utf-8?B?VEwwait0anB1WDlncCtQMFNseEwvQ1p5dUZjNXVpT0JPdWZ4VWY5WjdVOENj?=
 =?utf-8?B?OXZ6YlFNQjN2dkFSeDVIUHk0RmpwVFhobHVBVCtUT3AwM2FDaTVQOUlZc2wr?=
 =?utf-8?B?ZDlUQmpEYzJQcm1URjJSRktzUmdkUUJhLzBYNGRjYnVjWXdVYmRLOENvVzA5?=
 =?utf-8?B?eTQ0Vmc1UmRTV0FYcE1DT2VlT2pzUWVwUStGeDV3WitZU2VHTFFWQ3FHZmI5?=
 =?utf-8?B?TDBKU0VyZ0UwcWVCUWU4WXZyRGRBWHdpbGJhMGtHd3RZRmMzemdnQ2NkZG54?=
 =?utf-8?B?MU1HSXVUcjdnS3FYT25KUllraEFFNXR3ZDM2WXAvN3dNN1Q4N3VpTDY5bTBW?=
 =?utf-8?B?Tm0vZEhvcHFkUkRzZXNuTVZqY2t4dnljcUZKaEFVKzlFVVFINGhqWjlKeTU3?=
 =?utf-8?B?Rk4yQzRyWEhsZ0hxdlVEVG9rZTd2bXk3UHRxQzRJeVAvL3ZIZUhCOElTWmdM?=
 =?utf-8?B?bGlFdHIyNXRhVWViR0ZXWmVhVWxkVDJYK2c0LzBDNlZVaTh2K1hNd3pJYkdz?=
 =?utf-8?B?aFhJRGZIckJ6QXN1SS9GdTJmc29KelA3VXl4YVI4aFdNbXRqbStnYU9qT09V?=
 =?utf-8?B?bGN5U05EQkNVTFRCcHA2VjZmeW1Pc0x6bnJMaDVGdGRpREJkSWlyNnlxaVZk?=
 =?utf-8?B?SkYzTUZzNW5VcnFzM284YktUU1Nla0hIL2p6UCt1WExCNU4xb1hlcTdNZXdT?=
 =?utf-8?B?VG10aml1TGVPL1VPYmNkWFJ1ZlJIRmNEcFZRR1pUVks5aUx1SmlMRmhqZjdG?=
 =?utf-8?B?QzdPYUZZZ1JCVVVmS2ZIU2hPWTJZUHc0NTBRK25KSUhCRHZFdThaT2MxUFlQ?=
 =?utf-8?B?eTZxSHF2R3hiTC9MazRQMWZybnlqOUoxK1BESENZcHI0NWxlYnNpZGNKMjg1?=
 =?utf-8?B?WDltQU9TekxGRzF4ZTlGK05rWGp2d2lWVGxCWWpwVXI1UU5BK3V1clFSUFVS?=
 =?utf-8?Q?w7qE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRTTkh0K01uNWFudVdjMnJLRTYvdjY2bHMxVUxPWlZBWnRjQmV3b0ZWclgr?=
 =?utf-8?B?bWlmYmkwRnRveVNIakVXeDM4SHluN3NDTG5xRDJaWFhpelc5bHpVbHBKK2Z2?=
 =?utf-8?B?Q0VEMXRreTA5UHVUZ2QyTldaMzhHNTBTM09DNjhBS3VFQXBiYXpEMU53YUxY?=
 =?utf-8?B?S3dpVDZNT0RacGc2T1B5YkNMRkpPNHI1UWVjMkhHSHd5VGxpQUpPQUhXbnZU?=
 =?utf-8?B?TVRoUk5WSHJpS2ppM1dlcGgrQVcyWmVROEQrdDRYQm9LaDZQdHhEdkljdkd6?=
 =?utf-8?B?WXdNRlVEdkQ2bnhMRWlNdFlEaTV6SHBLZ05ONmdxUmFLTkZqSlhqQ1pmUFpM?=
 =?utf-8?B?U24wMU9EOWFsMkhpOS92UlZqQTYwZXk4RDBRRjdvV21zSER5YXRvNGN1RU5s?=
 =?utf-8?B?M0JPVDJpVS8vaWJsR0N4eWZUZ2dvamRMQzQra2g5blhhWGZOdURPTWFtTlVQ?=
 =?utf-8?B?M1YvbFV3Z0VLSXJUbWM0SXJCTHB1YVZ1eFA0MkVJeFdsbVVORHhzaE9tTGow?=
 =?utf-8?B?N1FkMEJtdTJFTklJZjZSUm9JT3A2elNnU1ZoUk1YTEdXZGd1R0pMMGJYdnpX?=
 =?utf-8?B?WmZUejBuWkpzTjVnNVgya1VSZ2lPZHlFTHl4K2ZZd0lhUW9XYU9udWJmTUFm?=
 =?utf-8?B?cENQQXdZU2VWVFVGUlh1cnZMZWpoVHRrVzF4VitxYmNYMndHNlBnWldKM1lx?=
 =?utf-8?B?ZXZoZjhnRkNWRlpsL1pLbWI3QVNSQnpCYW5kd2c4N0MyekR6dDVucnNkZWVu?=
 =?utf-8?B?cEQydG1LQzZhTXFRREIzZ0FlcGJlaVMvOTVuVHNXdVEydVdSd3Q0c1RMNzBw?=
 =?utf-8?B?YlJZNThQOW8xcmVZZmhnLzF0ekxiTHZIdTA1NWg2ZW0wekdJNXZJQzJ2d2J4?=
 =?utf-8?B?bU5maDBWR3R3Uk9kNHhWL25EZG9seUJOOUFaS3FTNnNxRzBVaGNDVG5yQnpa?=
 =?utf-8?B?bC9PaWE1eFp5ZTAyWDlmaU56RXVJMEp4Z01KSlJ0dHdDejN6RVRITVNneFhY?=
 =?utf-8?B?OFhIY253VDRlR0J3cjZrNXkvdGFmOUVNdWJXUFJQQ2xtSHpiVkxNQzYwQnM1?=
 =?utf-8?B?M0NvaXJFWVRkMGw1aVlmbXdpaEs0aUg2bC9aTVpCVWF1RHRibzBvQncyOE45?=
 =?utf-8?B?NG9jVGd1Mm1MaUUzcEtPNGN2bUtCRHgwbkFhL2lzQzhGL3pFbHVCK2hHaU1U?=
 =?utf-8?B?eXRZNWJFT29SNk42dUxadm9tMGlWMjArUnVrQU1SdEdyenkwWXRKM05VZmlh?=
 =?utf-8?B?ZkY3NzQxTGJRQjJVcE1uWW93L29qWU1FMDVGdE9abEVYTU1abmJQRTBlWFlt?=
 =?utf-8?B?b2M0R2diWSsxZlF2bVhCK2hFRU8zMGNveXNUdklUaDNQcVVGUUIrZ2FrZ25W?=
 =?utf-8?B?N1NzeFovUWswWTBCVVpLcXRRV2F1MXpqS1c5eTQvdjZPc3pYSTZ3bHluYTZT?=
 =?utf-8?B?OC9qanR6VFhTOTZHRnk2WW9RTitHTGsyQmE0ZDQrYldCaUlJOFZJeWtiSzNK?=
 =?utf-8?B?OUE5bUk2ZzZYYXVQejRmTllWVUsvNlE2RVpxckx3WHZyVlMvU1hpZzNtUXJq?=
 =?utf-8?B?SmZVcmMxVlRxTHltQmgwdTlnMjJpTGc1Ykx0VjdZVXhpUlhEdXI4VkVxYXhQ?=
 =?utf-8?B?VDJ6dzVsMTBhNmZFUFBKdDV5ckNQeDNjVnNna0VxNVhBWUFLMk5iY0dxaEEw?=
 =?utf-8?B?WjJxOGRpdXltZGNKMHdRb05GV3FabElwZzhYdjlrRThBTDJiUS9QZGx4cjdT?=
 =?utf-8?B?ZFNFcytCV0Rza2hrazJ1SStGZk1VOGc1WGhPOFNuUUIxZitSemxpQ0dpVjVl?=
 =?utf-8?B?clhya2VwWmVsOE01cXg4b2x6bVFvNnZzT1FNSWI4eCtiQVNIREl6T0JCWVQv?=
 =?utf-8?B?eEhDcTZMMnRZSy84NG9oVWRBOHN4ZFlIYXU5dWhBQnNOY1h4VzNUZ1AyWWhz?=
 =?utf-8?B?VWxaWVBZRlV5QlhZaUkvZnpkSDc4SFNqa0FJVFdRUlBVMzdaQVZLb1lMcE00?=
 =?utf-8?B?eTVtdit5NExUOVZPZDhqVUJKdWpKYUllbVZjSi9qWkJGeUpvWEFIWFMvcFo4?=
 =?utf-8?B?WUhDb1JaZnVacHo4Q25ZcVJHRUZlWmdBRVNadFdZUk1IOW0yUm9abTM4bFg3?=
 =?utf-8?B?Uk5DVmtMTnA3TFpsRFp3Kzg1VTdLaGN2bnRCeVBHSTBPSUdlNmpoWHVGMGVJ?=
 =?utf-8?B?c2FvNXRLZVRtWlduODRxUWN5WWlDMGhiMVZKS0NQS2pOSG9vemMyNlg2ZE1H?=
 =?utf-8?B?bTk4Y3BFUWZxU2RBNkVRVFJRaXJuOUhyVTV3L1RxRGIrWWxiSVQ1WmR5WSto?=
 =?utf-8?B?OGdKSE1WOHFMSUs3RmZocS9qYVQwL0pwSVRjS0Z6c1Exc3Y2Vm42Z0NvOUQ5?=
 =?utf-8?Q?XzlYssIX3d6UZfiU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0dd957-2454-4876-47ac-08de689e8efb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 12:18:54.8099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2/MDFGJZshWG2+BZFPVr9vjKtvN6MWExrIc6e2AwCq8aQa1DD6XdIBUX8nZ5aIuzaI3/hQKltyalR/d0osL2xX8+zRocZtLF4eWFleWTd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF90FB92BE6
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> The code used in ice, iavf, idpf and i40e for doing cleanup of mbufs
> after they had been transmitted was identical. Therefore deduplicate it
> by moving to common and remove the driver-specific versions.
> 
> Rather than having all Tx code in the one file, which could start
> getting rather long, create a new header file for scalar datapath
> functions.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

<snip>

> +static __rte_always_inline int
> +ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> +{
> +	struct ci_tx_entry *sw_ring = txq->sw_ring;
> +	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
> +	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
> +	uint16_t nb_tx_desc = txq->nb_tx_desc;
> +	uint16_t desc_to_clean_to;
> +	uint16_t nb_tx_to_clean;
> +
> +	/* Determine the last descriptor needing to be cleaned */
> +	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> +	if (desc_to_clean_to >= nb_tx_desc)
> +		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
> +
> +	/* Check if descriptor is done - all drivers use 0xF as done value in bits 3:0 */
> +	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
> +	if ((txd[desc_to_clean_to].cmd_type_offset_bsz & rte_cpu_to_le_64(0x0FUL)) !=
> +			rte_cpu_to_le_64(0x0FUL))

Kind of a nitpick - we do this kind of "(value & mask) == mask" in a lot 
of places, and occasionally it needs these byteswaps and whatnot, which 
IMO hurts readability as there's too much going on on a single line.

I think it would be good to add a helper function e.g.

uint64_t desc_done_msk = rte_cpu_to_le_64(0x0FUL);
if (mask_is_set(txd[desc_to_clean_to].cmd_type_offset_bsz, 
desc_done_msk)) ....

and use it where we can to make the code a bit more semantically meaningful.

That said, not a biggie, so

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
