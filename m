Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BACCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24A5E4029D;
	Wed, 20 May 2026 14:36:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3AEBD40649
 for <dev@dpdk.org>; Wed, 20 May 2026 14:36:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779280588; x=1810816588;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=0iqoPM4HHcnCDHjVT+jGvQ2qnJ05rUwpaQSNf/nnulk=;
 b=ZdtpuziU2Yx7nGZ6t0lBuV+FhUrqj4J3AQmtr777TGVLenZAh03gu9oy
 EOYGUumpResRFCtL52yEk/xJo7bMWLc3lRL/6DWPFZ1h+T/099blyiaOS
 lFIGooDC3Hgmynv7+eBTXUplQOQY0oojLzX/2OEZbKeKiEDL7GKCpiXxR
 MqKA8ADIL0/hN7zM/Zo21Fmfn0dE7EJa7KhsxSKsn+4rxckHr4J+FtVsk
 2p12dYNlaxfW6roEaLZFaIoOSbI4Vv+OsGsU6yybO+1l8Q+oiSS0Bh3aa
 QLzfog3tH63Vr3eQIgJBUEj4zYArDyReGvMS18RWAR2S+gWp9+KPQJzi+ g==;
X-CSE-ConnectionGUID: SYXdVh7eT5+Ae/w/Des8WQ==
X-CSE-MsgGUID: zqp4dGj2QzS4Z7CsMgLM/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84058113"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="84058113"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:36:26 -0700
X-CSE-ConnectionGUID: zjf3uIM1ShCfGLgEdYmn9A==
X-CSE-MsgGUID: ab7m4WGsTkCgudjfQB1yOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="239320153"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:36:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:36:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 05:36:25 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcuK8TOyzadfewe4kVybvuL+Rdc4gEBO8lx3EVv00C0Arm6mgBGozjrt9MnNeK8SyizsKVe+d+KTdx+3ofjYNUjqRPDXzs5beyXFa8pIwGKQhHPjIQLXo/fTt/QdUIGWVC/NzbVk1WVo/kqFI5GhSPEV71gstKqd3m4hmtmRvOXcNL7cHPpQPQg8Xnm5GOwgduvS897sRg+NZq1gvx/EcabVHtuTWFerycL1QArtj9wYrxeZcuOK+tWaDJK6Nd2uPKgFD2MClItVTAbq2yZrmRyIql7HbLkV1MP+Z5WtWvYF9HhMxD0Ac81ylqdFQ0a5DgrbJjp1KNngA2HyCFZQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukMv472V0gERj+OuS81zj3TlmYEbyeFkaS9MSHqeSaQ=;
 b=BAQBsxY22VPMpVPzF9fFXSBF08M0lKq2aVG71n+7pzAADW/Q0EfO3XF1l/cj0+8auEM87TpIt0v1hYtBVZ+5uupzTanlvYpCtfARyDfTWxC5VUS1xi61Qu1O4zdvdGzywlGrZ8jSaRZVWChhtIQA1H48TyaQtyt4zu2Nrfczgh/YMj5AJWhSEjsYn2+7ha1uin8SPLk1CcPtWJIgnuasbYimYCaGSr/jRHviWsGqtVuzx+EzF9U+czcat0aZR/+VlVH6iZzi5Oax2VL+p1o/OweRWBjBAOXqx6KF8ATPKzxkQqptNW+9zsRM+8J/JXE5cQKg9egWWo9Qd8qlTeGPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7186.namprd11.prod.outlook.com (2603:10b6:208:442::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 12:36:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:36:22 +0000
Date: Wed, 20 May 2026 13:36:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 0/6] net/idpf: fix split queue AVX2 datapath
Message-ID: <ag2qwXcPxBBDf9nR@bricha3-mobl1.ger.corp.intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511090935.2288837-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DB3PR08CA0031.eurprd08.prod.outlook.com (2603:10a6:8::44)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fca44c6-8b08-4316-8b03-08deb66c666f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2UiPbgNzdELnNOfZdmlQucs+/tP4MX3PJWFia7zFbPSb2ethFjud+PBq2OmghqXUwBJoGFpx5MtNdFNWfqiWAsxn8PnwdH+807U8SACGJTk6Gn345E/FCnoAROIT2rX+XhFf9nx1c8YbNswbC4eE2GqFZfsg9XWCDckWp8ebBXrAZprgd8EUiW8oznqVCxdTW5J2xeqXU7Jl8DlEmQUqyue6Ohk35ESs5Sa8c39uvedOJZH9fufm7DzeWhgMJCDyryQiLmMHiUwx/ha4hcOCEpNTcFeZKXBlgkUUFI45kc0ugg4cs4iBu21EcQ5DdqZwVpCo3DojoB+Urdn4Vffr50H1/AWRQAjc+CZ1ryeHqj99GwnWWwefgajgxa7G7bv+mQTYprw8F67Wt0JpiKVdsm+SrZm3zmLt7eBE2mZHmTSFda21WDjwZKFZ/7kp+aVUxCCRR0IL/gK2NUyvJT6O/LQxSNd126a9BeC69IWepvzJFygPkAGtji4ZvIrguRFUvnWVS6k5uyLzG4TmVMLZ3mPEaE+lktIqXB8dFB7zBPaFBMfLnkt9RHAovMRpdmzns79Re9/WAdlj6keI8PGXdO7IRIbqKKJf7OI2bb/dnELsDpYZ5+aBB7s+ZsDFlbxr3kzw9Y4fwADB5jmVU9XYhhTfISNskaIaBxkblYDrzllmm/d7lvVCdD40z+olf7M4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5talRiczlYQWxmK1hHaHRZU0tlaVhwcXNjMlErL0V6QkoyZ1pPbWRDaThI?=
 =?utf-8?B?ZFNzSjh3UUx0NG9zK1VuSmpFMXV3UEt1YjhuaGN0cE80Ykw5NnEwQ0N3cUhj?=
 =?utf-8?B?RVZCR1JrdUFlVE9wRlNoVlJ0VWt0NkhLU3gyL0MwRXJMeXBSUXd1bXc1cHZZ?=
 =?utf-8?B?d0VRMXNneklvNXNSQUxoOE41RzlncnUrVWNmbjdzTVVSWFpZRzJ5T2ZPMGpF?=
 =?utf-8?B?Q1hnL1NEOUVjMGdRMks2VVZHQlJLRitpQ3lhdVBUR05QaXNweUl4eVdIZzJx?=
 =?utf-8?B?ZzkvUndFL0lBWnFPNHNUc2JIL2tJdHVkNWUzZzM2N3FjVkpnbityQzFZOFQx?=
 =?utf-8?B?bk5HZ1dQY2N6UmVVYm5iV05NWUhISU9ZcHZIcGVjSHFtN0lDbTdSbFFrSHNm?=
 =?utf-8?B?dkRRajlwYTdyS2ZjMFVQeklUQUVSTnpvZVMxejZlRk1oZ0lrQXJrNG15SGli?=
 =?utf-8?B?NERSK2RqbCtWWkNHak91VW9RTGdkSlFqZ0FQdjBsd08xWmZ3RmprZFgyVmZK?=
 =?utf-8?B?TndiK21zWFFsTmNBUjJGNUsxcEo1MFRBMGdUNXVUeXFlb0JMcHkwYnVLWkw4?=
 =?utf-8?B?SVJwOFUvbStvbVJrcXBSZzBVcy93MVl5MjA5NHhLMTZLZ2gybk8xT2tPbVpM?=
 =?utf-8?B?T0FWYWhKZkxIMlZmOXVBNEJOKzVqRDdpZzArU3dkUlRVZEZodUIzdGxiek9h?=
 =?utf-8?B?a3l6Mjkzalo5S2h0OFNST1VHZ2Nsa0tRSHBnSjdybXZhTndlOGY3RUxuV1pt?=
 =?utf-8?B?WE01cHVVejkxRnBHWU5sQzR0NVhpOW4xK3F5Z0EyMWxzU3Y1NUtlL25RV0Ju?=
 =?utf-8?B?VzhwdDlsaGtrbXNSQXlsajQwM0J1cWNSVXpiQUlJS0lLQlNFdmMzZk1Nc0xP?=
 =?utf-8?B?YkVOczBZMEx3VXo1R2tnSmFKN0NSU3lQejQvaWlwZmRxVjdWcERZbGMzS1RC?=
 =?utf-8?B?T0pDYkFBTFdvZzc2ellOWnExL0JyYjBKcGg3QnlwUTVjVlpyV0RGUkFMMGx2?=
 =?utf-8?B?OWg2RmVqcUdGTW5kOHlSSStDUlY3VTVjejE1Q2xvenVEdXNxV1NIeEkwOXBz?=
 =?utf-8?B?RXJPVUNjWDByS203b2F2eDZ1cDFyVFRtd1ZHTVFKUUVLRzd6ZUJiTkJwZGVp?=
 =?utf-8?B?d0dvU3NseVBNcndnbVFnNTFEbGhzY0tNUTlNYi9PMGpwZ3VHWENzOE9vUU9T?=
 =?utf-8?B?VXZ2VnZTSGJPUjVYbGpzL3M5UVNoUEtucEJXMEV2b3B6bDg4R0pYdnEzMjha?=
 =?utf-8?B?ZytMSDBsSG1iTVZsRUtlelJIMU9USUdJNi9MVGRRNk9CeW5DK2d5d1ovcmVF?=
 =?utf-8?B?TTB1V0t5NWtYdG9UWE8yVCtqdnVIZ2FwTi9KeDNJM0lDTE5EaUhDNzBoMzZP?=
 =?utf-8?B?RmR2a2JMYWtIYURuTEhHaHJRMWtxNUE1OFNncDZpVEFxdGVOOTNmUGxaQ3BJ?=
 =?utf-8?B?dURwdkUzY3RYMjUzcTRCdDRaK0dXcGh3dFhCSXk5QXJrZzNpdXhTbStZbjlM?=
 =?utf-8?B?WjNTVWlGQXpYWTlLOHlyUkdxTjkzdU1tcEpVLzU3Z052cnR1eWhvT1ZiblpN?=
 =?utf-8?B?SEdTako3NG4zenZPRTVGYkszWHQyYmg2Y3ljWGIxVEJTWjdLdGhCS2hXU0NB?=
 =?utf-8?B?N1Zma0YwRDdFUFRQTEMwcjdXclp5N042aHg5MGdrajVRYkhHUnlIREkvb3RT?=
 =?utf-8?B?N0Q4L3UvMG1WRHlJTGNzelRvVkxDYmZ2aWNjMGZ6eU52TVpLSTZPVGwvdnB2?=
 =?utf-8?B?b3MxK2tJTnNMUVpYaUUySmszR3htdlNETSt6NFBvczlzM1V5WEdNM0ZoZm9X?=
 =?utf-8?B?aTVMQTdyelZ1T1VIek9xSFVvOTBHL29uN29JTFQ1UjhsSWVDOUVXcnV3SUVE?=
 =?utf-8?B?WlRKckt0aXJwSmNqeHUyWWYrY3ROa3p1TlowZE1CUklxOHZZWjhvOWJ5RW5S?=
 =?utf-8?B?ZFNqZDc3eDIvSTNrRTVjSHNpZ3p4Qno2a1JmN01GYVpxa2IvOHZaZko0UnYv?=
 =?utf-8?B?T3YreEVrZzZrQVk4bUFrMkNyWFFPYzgzTThxTHVna2UyU0E5djdvVmVrMkhh?=
 =?utf-8?B?bnplZHo5RXNXOXNReHlWOWZGc2VYVnlFSzNlakVEeHF1MGxZUDRGUXJRcllr?=
 =?utf-8?B?d0xVcVBEWW9PMWdFdU11OHM1a1h0VU4vRUJ2WDBsNDdYMjJWcWk0VjhtYkRC?=
 =?utf-8?B?Yy9Sbko5bkdDTVdQUHJwZU8wZ0tHNjd6N1hIQ1pib29EeFlKNnRwK1BOakxZ?=
 =?utf-8?B?SHIyVStNS0twS3RLeHArN1BVYk5KK0h3YTVLWEdkaDZXd1MvNG93YTNZZzZi?=
 =?utf-8?B?KzgwWHVva2RGbEZoZldESWRGaUlsbkQ3cWtiS0JKK05TbUdwSGhDZFRRb214?=
 =?utf-8?Q?JK6EPsg7cOJH2aFQ=3D?=
X-Exchange-RoutingPolicyChecked: RaLBPLE18GlLrT236f7qFHsjnKOTxMTGIbLjiS9KvoeYCZSkzjoVC3IqSO/7+YFSxTjJhpq5u+TStK2GuRAjdPM3UmCvStlcUpIF7dqOODMCcdB9QkIctKaDIPG4cm4n2brjC0e7FB1MBo/1FT5avARKivwmPUhSIU+NkaNhAc2DI7OtQISEanMDQ2TznFLi/7Xbb/VOy4PAFsBAnK+7VA9EH5D4namSHoeOszYaAt58KOFOdqp5crfTm7d/rwoUXZKaIL9XXbDizavNE0w6kdUJgkr+NCK3V12oSgMSu8nRr0EMzvjC40VuLEVappTnbQHiV4Nzmm+TLG5pW8q83w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fca44c6-8b08-4316-8b03-08deb66c666f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:36:22.5509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhrdbIro1vE0sN04sqp1ZBv4irYKI4BpNj8d53WUONwsWoULew++Tr4rCBR+RXcVjVJpxfsIZKTPv14nGWVF8W9wk2i2p19ZXBejYyxNA6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7186
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

On Mon, May 11, 2026 at 02:39:29PM +0530, Shaiq Wani wrote:
> Fix the split queue AVX2 vectorized path to correctly handle the
> virtchnl2_rx_flex_desc_adv_nic_3 completion descriptor format and
> the flex scheduled Tx descriptor encoding.
> 
> The split queue completion descriptor layout is significantly
> different from the single queue path — the generation bit, DD bit,
> and packet length occupy different positions than the base Rx
> descriptor, and the buffer queue owns the mbuf pool rather than the
> completion queue.
> 
> On Rx, four issues are fixed:
>   - Generation bit extraction order (mask-before-shift)
>   - DD bit byte offset (byte 8 not byte 1)
>   - mbuf initializer sourced from bufq2 instead of the completion queue
>   - Packet type inserted into the correct AVX2 lane
> 
> On Tx, two issues are fixed:
>   - Buffer size shift corrected from 34 to 48 for flex descriptors
>   - Burst clamped to tx_rs_thresh with proper tx_next_rs tracking
> 
> Shaiq Wani (6):
>   net/idpf: fix gen bit extraction in split queue AVX2 Rx
>   net/idpf: fix DD bit byte offset in split queue AVX2 Rx
>   net/idpf: fix mbuf initializer source in split queue AVX2 Rx
>   net/idpf: fix ptype insert position in split queue AVX2 Rx
>   net/idpf: fix split queue AVX2 Tx buffer size shift
>   net/idpf: fix split queue AVX2 Tx burst and completion
> 
Series applied to dpdk-next-net-intel
Thanks,
/Bruce
