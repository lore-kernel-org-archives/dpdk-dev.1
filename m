Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E3CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 18:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC95F402A8;
	Tue, 14 Oct 2025 20:16:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9777140288
 for <dev@dpdk.org>; Tue, 14 Oct 2025 20:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760465797; x=1792001797;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Pjqnvbhz8M06gJ3ur2BBfKV8IcjWsnpDCEkip23v9B0=;
 b=fkpAbWv3hAF+ErCl5ia6+hFcnqK/HTScwPtoDR8Kjer8Iu058Ixjhclc
 IHSH2sRcHlMJ8CFlMhIQxTW6C0V6y3W9nrkrCifB+yB0RdGO0a1GV3voi
 PQlxhO9GzRwR7x9s2PCzgG/zfUXJbOq7oS/56zPaEh1AhGR5Iw/P6KC6v
 abklDwtlfpYZ4bUY1XzpBk+q6b2rfZjSCQg2DOmP5+iri44f3LIUyiG2/
 5xX+xJLCFOo8Pnq9z4c7iv7oHCGTUcDaQ7cPREg9jNSpU31Yj1aV+dCoG
 83Ue8PE2sEYmGw5DAyL+Rd9uljv6BMf04Q8N5/7ZVUPP4WjaIdQC40h8A w==;
X-CSE-ConnectionGUID: k+M1EcKGQIqoqrZBZ60AyQ==
X-CSE-MsgGUID: CDntHhaPS+aQxmgJht6ZJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="74082494"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="74082494"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 11:16:36 -0700
X-CSE-ConnectionGUID: 7EPtMJyOT7uaLr/pzVnHng==
X-CSE-MsgGUID: L5VW6P18TLyt+hX//TTIAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="181633909"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 11:16:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 11:16:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 11:16:34 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 11:16:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQYql67iIudEmn2oBMugHVlOUg99DEYFFtWAh/UlqIyrbT0Uf2OqnbmUVEd+yGsWCpw3nh9BbGHpyGmytU2VFXC9j24fHyuIP3kZSeyACnCzQjokeWqvj2ea0u/PKYlia528qeev3nOCLs+RRi0suuXJKBJFvhNx2goZmnuN1x5P8xa+0IEwNju7YW25MkE2IsH8twQtfCV52Qq7mry3AUAct1nXRk4KaAKxJHFt/+FTR6uNJt17mYVA0ndkrUqPzdzlP6WqoG8ggyTg5PKpztl1pWysHlLC2hrOGeFinPrniiJkerpyDo0f0KgDEqinoT8zZC5yBNaF3ujvPqtjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoLynVJ8wM2b3eBLN8g3hoOeX+KAF0WJ4H+N4Xx+Hds=;
 b=Am/7JY5oPIbLL+9EnS42gXr7DIj9TrhGxTof7oSBc2+d3XbZFraOh4AylI8/UpEfTVnU/qKKG857hpMSpjyoj9Xr/c2bhqoHWquEpH373dTMbO8iKGzHlxxZP6gNvbzE8ON+1Ly679g6GlQ2QLQwxejhWAoHlig0yfZ7Oh66kR2fqJDPN835l5bVS0OFd5ObNQGTk0Xd71SeoBfdiIzoO1AHQEdSGuisColI5AQO2HyJddYAv6j/MSlttTcp5E7fwogYB2GnRDhOXwJYnKmLX4Dh1S+hG5bDeLTrt5TFDsKLKO36vnvtSFSwKsGjIMvEKYnrKNzdrJjjUYMPPn55JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SJ0PR11MB5938.namprd11.prod.outlook.com (2603:10b6:a03:42d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 18:16:32 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 18:16:32 +0000
Message-ID: <a06b6bf4-ea23-47f9-9d97-dc72eb90b0e9@intel.com>
Date: Tue, 14 Oct 2025 19:16:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH dpdk] fib6: implement RCU rule reclamation
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <20250610145341.38271-2-rjarry@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250610145341.38271-2-rjarry@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::11) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SJ0PR11MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: a9782719-31b9-4c4a-1e3f-08de0b4dcd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UytkM1BDZlR0V1FGdmhFWWlWZEkvTXp2elRoZ0YyQzZrTTYyWTZYbWpDNUV4?=
 =?utf-8?B?b1grNmdYZmhTdGQ4RUtOdUR4eTl0LzJ0bUdrSXRjbTNCY0FyWGdtRnR2Q1Fo?=
 =?utf-8?B?KzE0ekNHRGh0MWtHWENpVC82dDZ6UklmVzFDa0wranlsUUU0UVQ0TzdtZXdD?=
 =?utf-8?B?MTZkV3E2TVVqbFRrTkZ1czBscExMSzRiTFdoMG1vZUJiUDhSK2d3NEVpT3NP?=
 =?utf-8?B?eTlLZDNwc1ZHTnRiY21VUk45ZjBxbzZuK2RMeTk1NEZLOFhJaVljeWh5VU1u?=
 =?utf-8?B?QjZsbC9ldis3Wmd1VW1Xak9ndWs0K0w4SWZmV3dnTC9UemQ0TlpsRHdJd25F?=
 =?utf-8?B?UU1vOFY3S0lGaXh6Nk5Xd0Y3c0IvdTZ2Y2ozRExEMXFJQzJidGJGYitEUDZC?=
 =?utf-8?B?amdIMnJQMU9aSDIvRHMvNEs2eENEbTcyQno4SVlXUkduOUxqWGtwZ0RtTVY1?=
 =?utf-8?B?OVU4VENZTHd6bVA0OHFWSnZJd3VCNGk5YVFiV0xCR29haklERGZBNWdxdjFY?=
 =?utf-8?B?M0szR2NDVm5pVTJiVTFSOE5SRTJhY09MN3F0MFlqQXQzMzgvZWJEc1V0bW54?=
 =?utf-8?B?QWNIYmVrWkJwS3dma0VvMGowZUIzalhCckdwaHorQlhnOEIxaGNNSkgyVzds?=
 =?utf-8?B?enozYmVHWlkrV014a2UzWkdjZjhJMDFzYnFTaFhOZHRkVklUbHorcGk1Zll1?=
 =?utf-8?B?Zk1pcFFWemJjOGdZWDN5djlGN3pzbWRhM2pIemYvenZkN0F3cUFESnVLd1oy?=
 =?utf-8?B?NmNvOXJlOWorbTU5QUtFTlVRNE9lNWtlQk9ZK0dXRmJUWFREYVE2SzhWTCtv?=
 =?utf-8?B?N3FMbm1HMmxxMHF0cUlndnlwOXR6cUFtNEoxU1ZhQVJwWVM0Q3RYSm4yeVFm?=
 =?utf-8?B?Q202WTJHdnhxMHQ5c09UUzcreXlSaHQ0UG92dFgvTWtvZTZva3ZxMzY1RXk2?=
 =?utf-8?B?dVN5ZDVscW94TFpuMG1NOHRuNFEybG5xQmxmVGxiRWhFSCtqSGpKTnRDZzY2?=
 =?utf-8?B?MDQ1TC9aZTNKUkNtckpndEliOERMSWNrTE5VbFhGd21BR0NTTTExL1l5NjhT?=
 =?utf-8?B?b3lJd1oxbUdTN0lnVERUaW9zcTR3aEZ3RlZIOGlWVkhEaHRYUTNaNFNqcGZS?=
 =?utf-8?B?TGl6UkZoV0cwNHlhejl1WnIvVVhUNm5SNjBKcjk2a3lXYW5oYndwVTMxVUVD?=
 =?utf-8?B?R2xNSE9TVHdQajlzU0ZDeXRkRk9XMVFnSStPT1NLRm8xT29ROHRjUTlNOUk5?=
 =?utf-8?B?QzZCQk91cElTZzJLajd2WTdHN1JBcEFQT3YvWEx1STNHVElmVVg1K0dBbHVp?=
 =?utf-8?B?RkMxYy9hSkZleU5wZUFGTG1SWGkrTm5JMXd1Ti9KVmFGWndObTV5Yko4ckZY?=
 =?utf-8?B?MG5FRUFSN2ZhTHpDcHluVlV1OVFSemo5QkNZU1lvWDRWc0JicjFpcGdZWGJ0?=
 =?utf-8?B?cG4wbkg5bUtSS2tVZTZrVmhMWStkL1BZK0RTc3JzRjBkTVV0NjQ4OEduTnJx?=
 =?utf-8?B?cTdSRllBeXJjOWUrVXVJYStuM3hvdjdSanBjRkgzU212bmkxdkVCVDlubkUz?=
 =?utf-8?B?YlExa2dZODgrem9sTEJGaEtsQUh2UFNLRFl5MEdaZDlVQksweXhEN1lmbXls?=
 =?utf-8?B?eGVCS2xINTR6ZzFZdnAwd1Y5RURIWmxRWG10NTVKVHZqWDJwTGkrRXBJSXhZ?=
 =?utf-8?B?WTJIdVFJWXhlN21PRlVOMzNpSktod2JHYVBkbndhUTFwOTdSVWkvSXVzR3ll?=
 =?utf-8?B?N1RURWRtNEZMdi95ZTJrb3JsUkZKYm5hZGcwamQreklJVWxKMXRURWRrYnB2?=
 =?utf-8?B?aEJNT2xsN0JQemZFaCs5SlpEck85N2V4aXk5MUozQlA1QWVGNFQzcksvTUV2?=
 =?utf-8?B?aWl0Q0pRVVFRcTJjb1VrT3FhUzYzLzJOeGVCQ1hQSitzR3dCcU9nZWFOTVpC?=
 =?utf-8?Q?9BmuMwL9h+U6Llrx84KrURBXxoy0NKqw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NktSY2hEeW90czJTWGVwdk8zVmJEaWxHZDBnK1UyTTFxcUlaRmlKVDVLMU03?=
 =?utf-8?B?WGZzZVdwbzVVYXNkVHJBWGVXVG00SWN6emFWZlprRDFYSkFMUFI0L0xvV3NP?=
 =?utf-8?B?NWo4MEU2aVc5S0l5RW0vSkdGcUo3ZmpwSjB6QlVYNEdId0JoRHN5UkNLUlgx?=
 =?utf-8?B?clRkVGVDZDQreEVXdEFYSldLUWVLUW1HRHJYYnV6dG5pd0VjNkU3am9mWWY0?=
 =?utf-8?B?ZDM4bndOdjM0VVJHaTNWUnpNZmxLdFlpVVRKQWdIdUIvUHFyRnN5Z0tnTWVI?=
 =?utf-8?B?c1NxQUpjR0tmV0JiWjVTSnA2VmRGY1QxSmtPRE9BMUZsakdnaVMxdkh3V0Z6?=
 =?utf-8?B?akJFM0tSWFdjMDA1VzVDNU1RWU5CWDhwRFhNZGlCQnRBMW5ObzVPTCtvd1Q0?=
 =?utf-8?B?bFZOemY1KzNjVnQvSFpiTWxQTlRvVUtoVWQxVjNySXpHUUtEbGlOek9FSWw0?=
 =?utf-8?B?cTk4azBuRmFKelFMMkQvZ1dyNnNTWlNXTnhLU0xEbWNnOTVJSEpYRUdiNytV?=
 =?utf-8?B?bU82aWxHSmh0b2tqZVBwRmhPUWJ2VlVPdC9iV3pZRUlObnNHYkY2ck1tSEdJ?=
 =?utf-8?B?Q3FkWURvY0VmazFXZHB2TzNYQjJibnBxQWR6cWFiNkNsSU1wY2RhbUxMdGdF?=
 =?utf-8?B?WWlrU3JCS0tsSGd0SCtYL2I4SHFsQUVaNXlGdFJhQkdpL0x3L0JFK01PcVh6?=
 =?utf-8?B?U21Oei9kS3A0M0V1QTBzbEovMS9LY2ZtL0hwTVBXMUVveFFreHY5T2s5bG4v?=
 =?utf-8?B?Y0I2K0RUWVBCSFlUalJlSEpqaDZYTXRXNlY1Z1MyZEFON2tjQnJHb2dXMWlD?=
 =?utf-8?B?Sy9DdTBIbTN2ZzMwNVlWaGVFR3N0YkxMV09BRmlwOFZuN2VxbDVZd0JJcXRW?=
 =?utf-8?B?NlFqR3hYUHpkelcxNXFJbFVyQStlclRsWWVUSEFNOHRrRlF3aEgvSVNUK3lS?=
 =?utf-8?B?NGVVSDRNV3NJR2ZOcjlGUG1QU1lHelBkd2dBVFFSaU5kYjFCYVI0Tkx1eERK?=
 =?utf-8?B?K0NiVXk2anFiajN3RStObkJvd2hDWDQ3ME1kV2E1Tk5KRVlGa0NyTTNqSXNE?=
 =?utf-8?B?RSt2TDVvY3lKbW5WcTJuYm1CWWw3cUc4TjdONGVaSGt1NkU0b3dDT1VETGdR?=
 =?utf-8?B?bStVWEtkL2xKbGFUajdXTVcreHY1UGpuVDdlUEJTLzVoUjR6RkYyT0FUN2hV?=
 =?utf-8?B?M25sSG9ZZFBTUzJjVWIyS1lpMVI1bktzemFNU0gya2psaFc5SHFNZy9mMnli?=
 =?utf-8?B?WC9BcmJ5Kzhua0ExdWN0ZzZkd2hyeUVPMjltdENrV2xuUVlhRlp3dEpLbGo4?=
 =?utf-8?B?MjlaRS9palU3Q3FMWnZTZWRPazJDSHB1UUJnc0JHNnByK2F2LytGbDR6QXov?=
 =?utf-8?B?bTAzSkoxRmxvNnZIYjllYnpmbFYwQkNZQ251RmNvbU5xTWUyYk5DSC96WnAr?=
 =?utf-8?B?K1pISk5WU1NCVFFJTHBsNEhhWXNRNFhOYW1GZGRiSWRPY1FJMXpwUUZyajA1?=
 =?utf-8?B?QlRBc1BwbllRdEhNUmI5VC9YVTR5dWhZdm03WndUM1ZFV1JVc1lXSEcxa0R5?=
 =?utf-8?B?S0owWmMzUDB3ZzZJd1BRWm1TZWNOQ0JxdSszWWZRTGVHeTlzU2RvbHhBd3Iv?=
 =?utf-8?B?ZEpCdkVJOEFKaXRsc2xDc25WTzdCVW9HTTFjR0xsTkExT2JrV3JCMENSdk1P?=
 =?utf-8?B?eWJ0K2ZHektpR3BPcHRVRE5GZE5vNEdjSndMaEs1TnlhbGxCRmt0WDRYNmR1?=
 =?utf-8?B?SHM3ak85Z0JxOE1tQ3pGdG9kUjFLRmQzSURPa284ZHU3L1Izck50UVRpb05p?=
 =?utf-8?B?QWdUaWZ2VEpjdWhiUGRvZXUrczVoNlJVQlUxQkh4QlJ5TkovOXBadENSVnVS?=
 =?utf-8?B?emRBSXp2WnVLREU4TnErakxVclZLL25wSmI1TWNObnFiTm5SdlVPdEVQWDVY?=
 =?utf-8?B?cUN5aDR0Zk9Od3hHdCtSNEZTakFjTkc0YVdINUd4KzRPN2pBUU1pWkJUdC9Q?=
 =?utf-8?B?K2FGRnY1TlF2cEdnWkw0MnNIU3hwZk9KQkwrVFdIQ1dOTU5TaGg5MjEzZmU2?=
 =?utf-8?B?UlRvMnZTNlZ0TGphU2RJSzdKYmY4MUtwN2xGTjNhQkF6WDdHbHVua3hJS0pX?=
 =?utf-8?B?UENuMm5vUmN6bTFpRHIwVVFNYVhWRHVEbUF1Q2RibnIvNmtpWlo0UThHS3lS?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9782719-31b9-4c4a-1e3f-08de0b4dcd95
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:16:32.3917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aT8I5G6dnKfSW8gwxSrrXioh/kH06HU3eQcga2k1e2BwhwmXZ0vxYGwsJWqaGGueKo6RwytK9XyYATJba55p14KuZdAm5GndrwsDGRIVnqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5938
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

Hi Robin,

Thanks for the patch, see comments inline

On 6/10/2025 3:53 PM, Robin Jarry wrote:
> Currently, for the TRIE algorithm (actually, it should be called
> DIR-24-8-8-8-8-8-8-8-8-8-8-8-8),

Technically yes, but we can look at this structure as an n-ary tree 
(tree with associativity equal to n), where the first layer of the tree 
has associativity of 2^24 and subsequent layers (up to max 13) have 
associativity of 2^8. It has properties to keep prefixes, so it can also 
be considered a Trie.

>   the tbl8 group is freed even though the
> readers might be using the tbl8 group entries. The freed tbl8 group can
> be reallocated quickly. As a result, lookup may be performed
> incorrectly.
>
> To address that, RCU QSBR is integrated for safe tbl8 group reclamation.
>
> Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>
> Notes:
>      This is a semi-copy-paste of the FIB4 implementation.
>      
>      I couldn't understand the implementation of trie_modify with regard to
>      depth_diff handling.
>      
>      The unit tests fail because depth_diff is always 0 when deleting a route
>      which causes any subsequent add to fail with a -ENOSPC error.
>      
>      Vladimir, could you give some more insights on the matter?

I'll be happy to explain.

depth_diff represents a number of layers(tbl8 entries) that should be 
built towards the target new prefix(prefix we add) from existing least 
significant prefix that covers prefix we are going to add, or number of 
destroyed layers from the prefix we are going to delete to the 
next least significant prefix that covers prefix we are going to delete.

Here, we determine whether a prebuilt path already exists for the 
prefix’s location or if it needs to be created (by allocating depth_diff 
tbl8 entries). Or find the number of tbl8 we can free.

There is a bug in the current implementation, where the number of tbl8 
entries to be freed is always zero when a prefix is deleted. I’ll send a 
fix for this issue, please refer to it for details.

>
>   app/test/test_fib6.c | 214 +++++++++++++++++++++++++++++++++++++++++++
>   lib/fib/rte_fib6.c   |  15 +++
>   lib/fib/rte_fib6.h   |  54 +++++++++++
>   lib/fib/trie.c       |  89 ++++++++++++++++--
>   lib/fib/trie.h       |   8 ++
>   5 files changed, 373 insertions(+), 7 deletions(-)
>
<snip>
> diff --git a/lib/fib/rte_fib6.h b/lib/fib/rte_fib6.h
> index 42e613870886..a4e1d34fb1c4 100644
> --- a/lib/fib/rte_fib6.h
> +++ b/lib/fib/rte_fib6.h
> @@ -19,6 +19,7 @@
>   
>   #include <rte_common.h>
>   #include <rte_ip6.h>
> +#include <rte_rcu_qsbr.h>
>   
>   #ifdef __cplusplus
>   extern "C" {
> @@ -31,6 +32,19 @@ extern "C" {
>   struct rte_fib6;
>   struct rte_rib6;
>   
> +/** @internal Default RCU defer queue entries to reclaim in one go. */
> +#define RTE_FIB6_RCU_DQ_RECLAIM_MAX     16
> +/** @internal Default RCU defer queue size. */
> +#define RTE_FIB6_RCU_DQ_RECLAIM_SZ      128
> +
> +/** RCU reclamation modes */
> +enum rte_fib6_qsbr_mode {
> +	/** Create defer queue for reclaim. */
> +	RTE_FIB6_QSBR_MODE_DQ = 0,
> +	/** Use blocking mode reclaim. No defer queue created. */
> +	RTE_FIB6_QSBR_MODE_SYNC
> +};
> +
>   /** Type of FIB struct */
>   enum rte_fib6_type {
>   	RTE_FIB6_DUMMY,		/**< RIB6 tree based FIB */
> @@ -82,6 +96,26 @@ struct rte_fib6_conf {
>   	};
>   };
>   
> +/** FIB RCU QSBR configuration structure. */
> +struct rte_fib6_rcu_config {
> +	/** RCU QSBR variable. */
> +	struct rte_rcu_qsbr *v;
> +	/** Mode of RCU QSBR. See RTE_FIB_QSBR_MODE_xxx.
typo, did you mean RTE_FIB6_QSBR_MODE_xxx ?
> +	 * Default: RTE_FIB6_QSBR_MODE_DQ, create defer queue for reclaim.
> +	 */
> +	enum rte_fib6_qsbr_mode mode;
> +	/** RCU defer queue size.
> +	 * Default: RTE_FIB6_RCU_DQ_RECLAIM_SZ.
> +	 */
> +	uint32_t dq_size;
> +	/** Threshold to trigger auto reclaim. */
> +	uint32_t reclaim_thd;
> +	/** Max entries to reclaim in one go.
> +	 * Default: RTE_FIB6_RCU_DQ_RECLAIM_MAX.
> +	 */
> +	uint32_t reclaim_max;
> +};
> +
>   /**
>    * Free an FIB object.
>    *
> @@ -217,6 +251,26 @@ rte_fib6_get_rib(struct rte_fib6 *fib);
>   int
>   rte_fib6_select_lookup(struct rte_fib6 *fib, enum rte_fib6_lookup_type type);
>   
> +/**
> + * Associate RCU QSBR variable with a FIB object.
> + *
> + * @param fib
> + *   FIB object handle
> + * @param cfg
> + *   RCU QSBR configuration
> + * @return
> + *   On success - 0
> + *   On error - 1 with error code set in rte_errno.
Please fix this doxygen documentation to reflect actual behavior of the 
function with respect to return value
> + *   Possible rte_errno codes are:
> + *   - EINVAL - invalid pointer
> + *   - EEXIST - already added QSBR
> + *   - ENOMEM - memory allocation failure
> + *   - ENOTSUP - not supported by configured dataplane algorithm
> + */
> +__rte_experimental
> +int
> +rte_fib6_rcu_qsbr_add(struct rte_fib6 *fib, struct rte_fib6_rcu_config *cfg);
> +
<snip>

-- 
Regards,
Vladimir

