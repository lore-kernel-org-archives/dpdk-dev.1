Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48EBC021AA
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 11:22:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9862C402DC;
	Fri, 21 Feb 2025 12:22:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 106DA402CC
 for <dev@dpdk.org>; Fri, 21 Feb 2025 12:22:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740136936; x=1771672936;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=caTsJWm7Qf/eBf+ocUpbZ0WZ2ru8gT1l4/MQgWGm+Qs=;
 b=LQc/jDNiR0+IXJJXvyGY7xEdyOTerNyHQtQVN7/rfPhPZbrUk1PR/gP4
 OondAnM1BHL2rhrFJiVlbZmAXz6R+9/ogOLp8yEr0zkGHfwPt6LJifytF
 ZACw7AfJUy3Xer483N0ebntQKBjxxkos7GFqm9ftVneXA34jkT1LUAzgi
 tTc3PSCSp3GzsY1E2MbnWoRW2LaSFX1EGS/MrbbbyTyyp5oGuYBxnM8Wd
 MEQlr9ZxBkoY9l2gCTty5Z4n2/wWmVqKr3lERkVVmz5rbPR7e0Us6gMKu
 OU6szVOJ9RQVHn8LTUDO6sHQnuwHrlrOkkRRlaEOkx1Iij5d9cSGGCcKP Q==;
X-CSE-ConnectionGUID: u+RwGC2bRpmQyyuhqBg+ow==
X-CSE-MsgGUID: XImve3KQSiSMKOlm2BOUUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="52357092"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="52357092"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 03:22:15 -0800
X-CSE-ConnectionGUID: /nQ8zcCDTG+6lG+ByqGEoA==
X-CSE-MsgGUID: nYV4BOhZRqOfHy8h57/qlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119466537"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Feb 2025 03:22:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 03:22:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 03:22:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 03:22:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCGAmnZgLhAN0IL3SoUOgVrgb+jX4hcHhiYeffGRHjDVH0ZDtrnZvdUF02/jFvnpI1F9ohhTRIOCaZ3b1LG+YJMX58QRdU2jgAR9utQjzusT48Bp9g6m4dLJ56FeRyEupGKBrKUX+zhDa0FwgFnPdXB/Gm2M8Iba/dgCbgvc9AKuhXwlzSZBxEw5x8xFb0EfoXaPECQUJZ3RAf6T7MKy9F5aqIIZ6TxTbPNiy9xcELWDrxRgLHOsJT7WqD8CnR1H+UkbGps0AAdjk7ZAc1eKGNeAfRxbJWWXiaoHV5KY1s4F7BByhojDpyYgzRzv6M+yYwk7+0gX0Slb5zdxyfCSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecwEkuSZImX/RTK7Nb7ovJOBBOsNnob6tX6c7MakjTs=;
 b=OxGzId94k5Q054WHwtU5vGZiplbxXpD+tp1MdEwWWZkZDdxg3K8FRNIXX3mUyhmFJeGRGG7jMjAHzPCg4c44L35WS6b/AfkU6NRvK7K1e3nSRUhRkyISgEG8CBGEPmFr0KL+DhiX7DRBa/b3PzmYl8hMVYIll4V2NUIY3AdeicDXLMb9WXR875HnXifpL64de3CoyTicE45sEBuIq/sIBJo7LjMQBIR41anKPDVpBIRoWCg6a3sNdhFs1hgVF8TifPi1f4eieF36yLEUE/rHon487V18mK/aScJauteVJ4ta8HxhBHQJptbYSxlF3qu26VrRpsA1pT9igXxkp0eccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB4940.namprd11.prod.outlook.com (2603:10b6:806:fa::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Fri, 21 Feb 2025 11:22:06 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8445.019; Fri, 21 Feb 2025
 11:22:06 +0000
Message-ID: <989913f6-4a73-4db9-bd1b-6ee06b8f5321@intel.com>
Date: Fri, 21 Feb 2025 12:21:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: use hugepage memory for queue list entry structure
To: Stephen Hemminger <stephen@networkplumber.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
CC: "lihuisong (C)" <lihuisong@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "david.hunt@intel.com"
 <david.hunt@intel.com>, "sivaprasad.tummala@amd.com"
 <sivaprasad.tummala@amd.com>, liuyonglong <liuyonglong@huawei.com>
References: <20241219075319.8874-1-lihuisong@huawei.com>
 <01d163c6-6d18-03e8-ac67-e7907d27bd08@huawei.com>
 <20250220081158.345f09b0@hermes.local>
 <295b2b64b39c4a61b76158e4ff474e40@huawei.com>
 <20250220084522.16c5930a@hermes.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250220084522.16c5930a@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0062.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::39) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: a8eb0edb-c7d5-4d7c-bb29-08dd5269f8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N055Zmd4bzRoMHN6eHhrTlhMS0h3OXp3aXdYYzFIa2hnZnFKRDRwSkVWTWRF?=
 =?utf-8?B?R1g0WTNEOFczelFyRFpSanlsN1I4RVNxLzJTVXJjd2x1QmNqOERqeHM3Z1JP?=
 =?utf-8?B?bVpsaW9Yd3lIN2hZcGhTd0oyT0M2MXZpTXJaVEVpSlRyajVlSVhnUGI1eUtB?=
 =?utf-8?B?YXdERW03d2FwWjRJN1lvZmhZS3laOSt3eTNNMlcwbHZEMHI1NEN3bFh2dmdu?=
 =?utf-8?B?NGlRRmx5WDJ4MXhqcnhjY01XdjREbW9pZVB1bWJqNURCaEkzUWVuczJhc2xm?=
 =?utf-8?B?SG1kVVpiaS9yallGZ1l1cWEvbHdlZnVVUWtuT3JVdDNYdkhWYTNoZHczbm9R?=
 =?utf-8?B?dnNERkF1RVIrY1NKeDBjVHpYODE5bkVkSUVTaUpLM2tXVTZNVS9sK3A0eGRt?=
 =?utf-8?B?QUZFSWVlRk5wRU1PUlhrYlJBQ0VPSFhheHZGQzNja2M1S2lOMWpVL1IrZzhX?=
 =?utf-8?B?NTdIL1JHWDBGWmRTR1lDaXFJT1ZsdmxwVTVTRVhpVEp6T2FScHRPbVZxb0l3?=
 =?utf-8?B?eWl0NXRaMDkrM0djRXlCU2wzcWs0OFZvcHlJZFlUL29VM2xPY0lCUlJFY25o?=
 =?utf-8?B?SnRQQmd0RE1mS29yMk1STFNHWkVqVHN5ZDJBc3JBY1NuRXpZYUxoTDNqbU1O?=
 =?utf-8?B?ekR5Y21OL1lHQUJTMlJrQUo0ZnZoSEl4RDBaaTd5MDFKT0ladlJ0aG5ibHJ2?=
 =?utf-8?B?QzZRWDBvbDhCcCtHSVRvTngvenhyL3E1ak5jSmxZRTNvWEs3UVJURWZyRHAw?=
 =?utf-8?B?Nko1REJwcE1IQWI2UzVXanI1aElQQUFRcE51NFE0QUp1S1dQdERLMzkwWFZz?=
 =?utf-8?B?UlQrVExIUmtGbG81a1FkblJOcjV3RjRjZDlUVGtsUG5POXgyYWhTVDE3Q0Jl?=
 =?utf-8?B?bEY5enNJL0JjZHdRYUcweWFtL3o1bnl4QTVtMThUdkRheFFnbVdtK1ovMUZt?=
 =?utf-8?B?d2o0Rk1ZMWRqRWtPUGw2dDRqamg4L3l6K2hFWHlRNGVDSjB3TkV5a1Zvak5p?=
 =?utf-8?B?S0NOOUVxOUxIZGJyU2Nqb1VkYkdUOEdGTEpCdWExQkk0alBXblc3MUpZOVdN?=
 =?utf-8?B?MUtBQ1liYXFVdFhNNDRKMXMvTzJrSzYwaVZDWDlEYjRVUmJGeDZZNlBTTzJt?=
 =?utf-8?B?a2Nva2ltVjhLNU1nbUllSGc5dFl6UGdnUWUyakozTmE5OEN4YWNPN0hhUWln?=
 =?utf-8?B?US9DUk1sZHpaTnZLVThDWEJSUHJTVnBWTnhKUldqYTFIZmdBY2ZjVXA2ZVgz?=
 =?utf-8?B?cWVZOHFzZm16TksrN3BmZTJiSWZhMDlPZEdFZEFQa0xGUDZMUys5YmtCVzQx?=
 =?utf-8?B?aXVxNnY5SmVXL05JUXpMS0xkNHJ0dXVaYW5sa3pscHVYT0dBb1NOeDM5UmNw?=
 =?utf-8?B?bHlMaUtiSm5tUWFWR0JzZVN0YjRSWmNxMnkzT2hZcnZqNTR1VHRQZ3JMUXJE?=
 =?utf-8?B?Y2VSeUplUjMwVkFRNnc5bGVFdjUwb1RzNFRsdlJSQ2ZsTm5Qd081QkRGUWdJ?=
 =?utf-8?B?UGhVNG4yNllLVGV3R1N3SUJxUXdwdkIzMGhqQ0pxWSs2STEyb2YzSkplV21y?=
 =?utf-8?B?YkZLMkQyNGRkSHVrNkRQa0hqL2g1ZEFzQ1pHdzZVR0FGNFNlOWdIM0dDc25Z?=
 =?utf-8?B?K2tRdUZDd214TGtIUUJjWnpDMzFPOUlOdXZyWVMvREx0VVFQMzF3WVNlemdJ?=
 =?utf-8?B?alJsRXYycDEwTDNQNHRsRlhuR211Q0JvYWY5ZERCQmthY3MrSm95OXdSQ29k?=
 =?utf-8?B?dHo1Y0pPVVk5dmU5akpCN0ZybDMvYWE0Wk9OZnNaQ1V6aE1ob2lTbGZyWDN4?=
 =?utf-8?B?TDVTbHZ1NXFjbzZlQnMvSlk0N21vdndYOHVWWURBcHk1cFJpNmVBR2xqeTR4?=
 =?utf-8?Q?zFSx8Nfe7w1nK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NExmWE5YQ2RRSkZsY0dmL2Q5RExPUkM5TCsySEg0MnRmT25adUN0emdTSFhR?=
 =?utf-8?B?aG1tWnl3WHNGMkRRWDRCaUxSUXkzM1R3R29TdXFnWEVRT3hVbjVpbXpOcVB4?=
 =?utf-8?B?NGRCMXQ4SmJ0VzVPZWlwSFZ1S2x1eXdrcVdJMzZoQ0NiMVFUYzBxWHJGWm5h?=
 =?utf-8?B?aUlRY3dWZldkUUkwenBnYjd4Wmt0UHJuOTlMMG1TMURiVERneDRBTnhQdU1V?=
 =?utf-8?B?VVRTR0ovOEpXaHhEMEpaR0M0NEtTdlIvbzNIVjBVSVFWWmx3L25rRUZHUFlI?=
 =?utf-8?B?NmZ3aWdCMlljVk5qSGdPNjRhOGlBODEwR1hUSXVqMU01VmVkdzdtOEFPeXFB?=
 =?utf-8?B?QVRZd1l1NVpxT0IvYUEzbWRFbVVwa3hKVWRlY2VFSTJ3emF3TVVDazkrTWln?=
 =?utf-8?B?bStPTTV1TFJ1SWt4WXBHRk9uNm9HYlk0QWdJdEhXY1g2TlY0eTFrQi9uTWZi?=
 =?utf-8?B?WUxkNktiZFZ0dXNsSXVJVVNrbitHYjRVR05HRHBwanpud0VITHBGY21SS2Ez?=
 =?utf-8?B?NnllaVY1R0VDMkR0bVZrOWZ5UlphVGdPZFlCQXNvS1JheHZ5UUM3anNPR0Yv?=
 =?utf-8?B?MXpwenFneVpueXdRZXd5V3g4RjEzZXhCMzE2Kzh6Y3BKbCtKM0hRTk95N2x3?=
 =?utf-8?B?VUprUEtTamt2aHcyYkZ6aXN5OEV2Umx5RU1HYWN5VWNmWmpZVlAxL3hiSDhz?=
 =?utf-8?B?UUJRMituVVFxdVdyTm1lb0VJdEQ1dFB4TGhwaHlBS092NlU5QjVsWkJ0ZGZL?=
 =?utf-8?B?ZUFsSG82bk1hRm9kYjBOa2FLVzRLejVweTg1MnZnQzlTWnZBcU5CSHV3NHJB?=
 =?utf-8?B?cWJTbHdYVGd1dnNRZTdMcEZNc1gxK1lkN2xhckUxWUJGeWVhRzlhOGdnYit5?=
 =?utf-8?B?QlBacUtFbTBEOENlUXRhcDFGYVZ0ZjhHYVI5Uis5WFhSQnpSdlY0ODdnSmt6?=
 =?utf-8?B?VXBXZklBVXByM2VyVVlna1YzV1JObXNpbFZ0VXg1dUZ6UFNiMkpSL1BWK3ZL?=
 =?utf-8?B?cUdzd1FFOWZxWGFXNUJTQWlhNzhrdmM3NTdLQ2luc2tyMjlOWVRqRGpZT0V3?=
 =?utf-8?B?TURDaGxLT0x2MWpCNUYwc3I2UUVhcUdnOEYzdXdRZkdWOFBCNHhtMzdseUxN?=
 =?utf-8?B?VDcyWnRUR0ZYUGM5VDNDSWJ5cWIxWkJGWUM1cjhYMzBqUElmNXpzMjJ6a0pz?=
 =?utf-8?B?cHFUc0QweTd0R0R4YXI1OHhna0NLVEt0WHE4WHJId1F2U3dKQ3kxcVRoRVR4?=
 =?utf-8?B?cktCd2E5eVFqaUJsRVlKRmNleDFoaUxSMkcwV2h3dXRHZ3MzU05INFJuU3JV?=
 =?utf-8?B?eDdHaEtoaHkraU9sdW80NVBTMUpNNDgzVGNzenVoSmY2ZThCT0JTbUpTaklx?=
 =?utf-8?B?cUNnaVNhS2dTT3d1clVaUzhiZ3dBR3lsYmVGUmtYdEVlVG00a2JESVFjdGln?=
 =?utf-8?B?U0c3M3libW11OVA1WTRjazlkK1hFaW9qem5sWGlKaFh1SVQ1Nk5hd1ZmSEJw?=
 =?utf-8?B?d0MwYUpZMzltZVppSVJCMGN5VUlNc0I3U2x2QUVQYSsvcTBoOUdtWmZ5K2xn?=
 =?utf-8?B?cmNNOVZBaENPdEFTWnU0bUE4S0lHdkZoeW9YanBJeWQxOEwrSWR2ZlQrNkVR?=
 =?utf-8?B?U25CQUZBQzlIR0ZTVDFPNU1LZTBnemdUUWFCcTFCVlFCb2licHo3eU13N3VO?=
 =?utf-8?B?L29SWmxHck9nRzdzRGYrMHNWeWw5dlNCUTRUcVMwUFVKeVRJRWNpYVl0OFBK?=
 =?utf-8?B?SnNoUXN1TUZSd1k1MlZjVnowVGx0M2x5dzNHZndOK3g2NXFSVnEwQnRsSEln?=
 =?utf-8?B?OGtQc3Fnb0N1ZUlDeXZZZ044UHNkbUQvU3BzelU5U1pVdEVyNDFIZDE3Y3Fz?=
 =?utf-8?B?dTdUdjRWZVd1UHRIZDR4SExXbzhZSko1NzFEdjVIZmV4Y3ZSTkRmelVXczcz?=
 =?utf-8?B?V2RzQ0NDbGZVT2kwWERVWVBTSVRHZ3hUTElScUpCSkNGdWRKM1lVcTV2SHV4?=
 =?utf-8?B?TGlzYnZSbHU1UlFNaHUwNFJ0MkxqcVIrYlZHbXREbVVHRkhadlBjYWt6cDAv?=
 =?utf-8?B?MUIrWE1qaGFGeGt1MVk5OTZ1YkI4djdMcnplUnlCWEFtNTB4b2FoZm5tT0xz?=
 =?utf-8?B?cklXSzdCbkQwK200bnlMQXo5dzBrNEhlaEtBdDdoUWV1QUlCWjhpbkFUdGFB?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8eb0edb-c7d5-4d7c-bb29-08dd5269f8e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 11:22:05.9097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27EYHUPNUgQDx3FiVaKWKxWfWVScvwC7YSkUYVz1xwER3KYlP4nJgIlnddMDcFoTp0UKV20bsVDpNOE6JHnYsZZCVe5aYNg9Ff4OQPXyuLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4940
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

On 20/02/2025 17:45, Stephen Hemminger wrote:
> On Thu, 20 Feb 2025 16:39:52 +0000
> Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:
> 
>>> -----Original Message-----
>>> From: Stephen Hemminger <stephen@networkplumber.org>
>>> Sent: Thursday, February 20, 2025 4:12 PM
>>> To: lihuisong (C) <lihuisong@huawei.com>
>>> Cc: dev@dpdk.org; thomas@monjalon.net; david.hunt@intel.com; anatoly.burakov@intel.com; sivaprasad.tummala@amd.com;
>>> liuyonglong <liuyonglong@huawei.com>
>>> Subject: Re: [PATCH] power: use hugepage memory for queue list entry structure
>>>
>>> On Thu, 20 Feb 2025 17:01:53 +0800
>>> "lihuisong (C)" <lihuisong@huawei.com> wrote:
>>>    
>>>>> The queue_list_entry structure data is used in rx_callback of io path
>>>>> when enable PMD Power Management. However its memory is currently from
>>>>> normal heap memory. For better performance, use hugepage memory to
>>>>> replace it.
>>>>>
>>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>
>>> How is that in a hot path where this could matter?
>>
>> AFAIU - it is used in RX/TX callbacks that power library installs,
>> so I presume will get hit on every eth_rx_burst/tx_burst calls.
>>
>>> The safety rails in rte_malloc() are much less than regular malloc().
>>> I prefer some degree of safety from checkers and malloc library internals.
>>
>> Didn't get your point - what's suddenly wrong with rte_malloc()?
> 
> Coverity and Gcc analyzer treat malloc as special case.
> With attributes rte_malloc gets similar treatment but not quite as much.
> Also internally, malloc and free have more heap pool sanity checks.
> In name of performance, those don't exist in rte_malloc().
> Lastly hugepages are limited resource, so they should only be used when needed.

The last thing I would associate with rte_malloc is performance. I'm not 
sure I follow - which "sanity checks" were omitted from rte_malloc "in 
the name of performance" that are present in regular malloc?

-- 
Thanks,
Anatoly
