Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1FFCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 18:07:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ADD0402A8;
	Tue, 14 Oct 2025 20:07:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6802F402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 20:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760465241; x=1792001241;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=RKHRFSc67wYsTbab2e78pprW3d44FOAwfipY/GF6jFI=;
 b=mAALlTF9dR7biPonLJaNZBpAa8uzr5kfB3mz2veJx9LXzeZeaZ81NprT
 93qXAYZ/QJ4dBYMjnVBtJ5JlylGpROEd1gwd4PtMCi2HcUl+6u/m/BnAX
 erPuxf3CtgWTTdW1IzpqKDYrpp4K3gxsd1uCIIDOP3wnPod3hFUlDfetb
 VwRbaEWkQL+fzHI4D5pHa61K6VIleHJ5kjfGqHz6Jn9i547B1rZUOnocc
 SY+LFIbSA/m+cXg7x8+EjuSrCdXwoYGKV1qBsQw2f4f/I5PoVNhDP0UN8
 jiFCsdSw81VjJKhhUdqP33NSzU8DgzkFznnPJomk47IOQ8tDJv6THLKxW A==;
X-CSE-ConnectionGUID: GlQct52ITu6HRPwk0wUYgw==
X-CSE-MsgGUID: cIcRXcV/Tg+d83XARZq4DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62561423"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62561423"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 11:07:19 -0700
X-CSE-ConnectionGUID: qnXehBwaSUSu11B4rz/tCw==
X-CSE-MsgGUID: OpQFJijJQy6B/0VkgzZf6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="181892007"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 11:07:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 11:07:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 11:07:18 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 11:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mjdo8NSoHY2zaC9UkZ3h/NGZWYuWb6LrszaL8OIpi1KTORyMxQIevf7hnmAB/LnSqy8k2eXbqpswv8N78BmdNDiGLT7eT9OZX6CPjWZ5s4u5d4jvQElwTaPxVsZFXJHtRtLxaa3uFafeDLDb0DX7i+W4jPmHQWUJcOxwx2eRcwYV4aD4rEy422G8dwfvDZVrRwjx0xQhfW09ONi3Hqi7+AFnPPlHitsOJX+b8flvqVc9jb20gNt/qkl97CvhNNOyVFA+srQNa5kiP6174CUNbgqZspp9t7ms6t7JTvxhKq+mlm3+DgmDQdCI0OgQE4bNDxx9oK0szTr6/5puU2mYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwIW7h5wDtN78IUUR8/WAbH36QcyQ0j0kXO10Xv0sp0=;
 b=yzE8O/7nO/GcjrzNztsHClEi7IlM7HMaiAUpVSlHglMvnzStv3Zk+lCb3DDPtQkaMlwM2klY4myOvrLx6q6My8p+3Mcfc6U90XoEKlMhbXRn4GMao0OLbnZgweve+P6UKjgJqID8G4oue+PMSaqnbJHYhSj+gsu6xr1Zdh4FOdx5224IxR1RUdvzs3JdFyBqYZtup3lPSQsOXL+ietvpeXHWPWJoKmwboYdvBHWsZr8+hUCy9sFvu/jO78aCNNjX58sRpq6JCbO1/GpKyw8kNM9EEjEOso6SGx27DASI3u4amOo6F1zgSdO7LlhynThTaFlCPwLRUDGE4Trcol/5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 18:07:16 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 18:07:16 +0000
Message-ID: <789143e0-f4c7-4be5-a090-bbfcd45b3df0@intel.com>
Date: Tue, 14 Oct 2025 19:07:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH dpdk] fib6: implement RCU rule reclamation
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <20250610145341.38271-2-rjarry@redhat.com>
 <DDEILG4ZSB37.Q38N053PLJ4N@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <DDEILG4ZSB37.Q38N053PLJ4N@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0029.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::34) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH0PR11MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: ff209ea9-58f8-453d-3ce4-08de0b4c8207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDVoOGI2ZnZNUWxGNjZ5Z1NaMVJEazg5UUU4YjNGUGZwRDllMGJDRW5NTVFw?=
 =?utf-8?B?RHNuMlNqZjBiTGdlamFhMDEybGJnKzA2ZTgzRVBzdkpZSWZxYjdXcTIyRGtI?=
 =?utf-8?B?MVhqVlUyR1J2ZTNLZ3JtbGY1U0VHSmF1Z2NiNWFrMmFlejBjRFBYSzdSclY3?=
 =?utf-8?B?ZE1xZnJWV0Y2OGI2TkN4eVdlYUtTWXp2ZEZDclROb2U5ZkQ2OVRrQVB6SlRI?=
 =?utf-8?B?dW9KbU0xM3gzYldIOGZMVmNvcjlHa3loN0N0TTQ4WDh5cjdSQk5KR2UwbGND?=
 =?utf-8?B?WmxYdnZVUnBRaTVrT1RFRjFBS2NzMktWK2I0S2k0YTZJSXNOMys4bGExMmR0?=
 =?utf-8?B?R09XOW5KVU9BdlNUMDFid1N6cWRMZWtLUCtIOXpjNFpQVTFUNVljRWNQVEJF?=
 =?utf-8?B?UjdIdy82UzdoMXVkbk1PWVNhVWtxVmZiWE9ZZ0JaMVJJbStMQXQ0SFVMbWlJ?=
 =?utf-8?B?ak5tcVhZeG9ZOGVyY3YvSUw1TDd1TTRkNCtCcENMYlFWYlp4VWVIZ0tXenUr?=
 =?utf-8?B?Nk9xN3VJVjFrYzVtRGhjTFJKT0VEVXlBMVIyd2xDbmxpU0d0Q1gvay81by9Y?=
 =?utf-8?B?SEpybnVTL3BYRzRid0Z3SS9mT0JsLzhLbDh2YzZtUUpETytxNmZBUlUyb0Jp?=
 =?utf-8?B?MnhWSTBrN3A1OEpMYlZRTGRqUFhtTG5ONG11SkZkY0JyL3c1NjYzaTlBUEt6?=
 =?utf-8?B?emFndVMwbFkyWllDbWptMnNZRXJ6RStxYXNaU0FiYlB5aFhqQlBkNlN6Ukxq?=
 =?utf-8?B?VDROdzNBWWxPUnczWTE3TnVxVjEyOHIrL29sRWsxMVFjZ0ZGa1JkMzMrQ3hE?=
 =?utf-8?B?OXdBK1BOdjZTV1FEWTNaQmd6UlE4Q0YrTjZxL1U1SFRrYmJ2VnZCcXg1Q3E3?=
 =?utf-8?B?TXQzaGhIeU5BcmxZZVJzYTVlSnE3OFhhSitVRUJaQXVaQkM3ZWMzYnBmMWIz?=
 =?utf-8?B?OFc3M1g4S3c2MDZqcFdLWm9iUmdJT21PMlgwSi8wVGo2ejlmK2NUMUt5aUM5?=
 =?utf-8?B?WUE1ek5rWTlNRlpxd01ud2JiOC8ra0cwZE9yck5lMS9LUUxhS09Tem9NaVA3?=
 =?utf-8?B?dE5xdjlXNUY0TEZuMGZzeDVsdnFtbWVuTEhCNmJHc1hYRFBEaHpzMzFrY2l5?=
 =?utf-8?B?VzhaRDFVMUQ2VVMva3FzcGZBREhGUDhsbXpLN1pWR2FXaVJnWlIrNFNKeVox?=
 =?utf-8?B?Zi81c0NKZ0poNjkrVHV4bzhrNFBXWEExREUzM2NGQmF1OGxaU1lmSlJaVk93?=
 =?utf-8?B?WXRJdlVSMDk0WkNaTDdDT0VzV1VKNHJlTTdBNVE0emk3YnBPUGp0eXoxdG83?=
 =?utf-8?B?QU5hMTBNSHozcEt1eEs2ZUxhK1Z0YWR6N3IxSllybDhlN0tEVVNXeFltaVZ0?=
 =?utf-8?B?b05xQjNuQVBFMGlnSTlEYXZYMGtWS2FBbVh1N3ZIK1RpMjJOY0F3RlNVaGV2?=
 =?utf-8?B?RGd6SWxJUmJkV2tGMW1OeEQ5NGZnVElCUzJTcjV4YzdLQnhlclZZT1dOMERY?=
 =?utf-8?B?aHcySFVHZFMzK1dycXN5dUtTY0lZSnd4ZjNaNEVrOWFOR1RPb2RHdmdaR1J6?=
 =?utf-8?B?RnVsQkpqbmQ2TXBYcHI3YzBQSmRFUHB3UUV4NWo1NWh0aUZmdTlSSllUOEdF?=
 =?utf-8?B?Qkl6K3hlVGEyVmROU2RnQ0g0YmxOcGJvZlVWTVJlbGZlODJWL1loY0QyQklo?=
 =?utf-8?B?V1JhaUp3QW8rSVRlazBEZGE1N0xKOU0xNGJCZ0hPTmdhdlp3SktDdTZLQnQ4?=
 =?utf-8?B?MXdCSEdzVFhtdFk5NlhXOUgxejlMMlJMc0Vva1F4V1R3eTltUjZUWVVhNjJp?=
 =?utf-8?B?d1VvdVFlbFRQVHVXUE1zU05nczdod0c2RE1nNUk0ZXNld29JaCsyMkxJMy9Y?=
 =?utf-8?B?VUYyUERDZHY5R0RUa2dzcFBmUEpzS3VVUlpMTlk5aExuT3hoTWg4SnlpRVZC?=
 =?utf-8?Q?Qs8FBzSJyK11YO52gYqR4LD6XxChgku7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTBLVlQ2NUpaWHkzQkVQVkFFWGF6bEFOMU56OERBcFlMenNKSGM5SlJudFpl?=
 =?utf-8?B?dlZ6MUlMMWk3OVJ3OWNnY0xvMkNDMVBiVkcvd056cE81WXBVWm4xcjd2aGp2?=
 =?utf-8?B?cWUva1ViVm1pREl0a2ZRRXBOQ1g5V1hJT1p4Z3piVFlhN1JOK0pybTVYTTBX?=
 =?utf-8?B?c1BzS3N6RFVQdEh4WGJubDFhamZqUEltOGZ3aUN4SlZHc0xPMm9ORHBORk1w?=
 =?utf-8?B?YWthbE9UMVc1Y3dJZmxhcVpoVWVnd2VwdXVMQ1hqcVVSQ3hXRzk0TDduUHVj?=
 =?utf-8?B?N2RXdzU1bWFvaUFVK1gxU05pVzFTN2tqMVpVcmd5UEVnQ09JM0tub3habzNX?=
 =?utf-8?B?Y2ZiRkNZR1lSc1NkT0xTNFlWVDMxZ2lNT1hHTVBMY1d2RFl0UUo2OWJvdXh5?=
 =?utf-8?B?QXpSMnYxd2lkYWhyVkdrZzJNTk4ySlNVQ1RXTGx6Q3ovUmd5MzVLcXRld2pZ?=
 =?utf-8?B?WVcyM2Z3bUU1d3J3TjFVdFBhQ0tMZWk1aFBqbE5haEtiM09MRHBpRkNGZHE4?=
 =?utf-8?B?dDl6ckNRN3h3RFh6MVpCQ2ZnNTcwL01ydGpXOXpDZElSYU9mNHdKdms5cHhL?=
 =?utf-8?B?eXFySm8xSEtkN3cza1gvSytnd3BEZk85SzN2NW0xalV5ekNQaktrT1VCbmhD?=
 =?utf-8?B?aCs4SUNBeGhnWWJMcHVPN20vUEFEN0dDbVJjM282RFFwZ0J6TVg1TW1ObVV5?=
 =?utf-8?B?bk1JazlGQ3F0T2xpQ3FySXNRQVo4VFcwd3ZDKzdQK28zVjRQeFBaZWxTY1hX?=
 =?utf-8?B?aUw2TFJVd3RXZmNHSjgyV050UzE4ZHlqZGN0NHk1YitYT09hSVAxZ1FPakMr?=
 =?utf-8?B?SlhqckdSTXE4VjFMQ1ZnRUlUenIxd3gydVpuU1IxN05RWUhqcUhKL0RMZU9Z?=
 =?utf-8?B?Y2psaE9lb1JIYlBlam53cFRXVHAxalNRbEhTSzBPSGFPM0RwM3VodEQrSFZ2?=
 =?utf-8?B?WFEwMnJoOVAxK1gxTEJxNXB5VTR3ZUlrdTBOTjhEcVNMVXBtUjJ3eWxJb1pz?=
 =?utf-8?B?VnNBUFV4c0NrQng3Q0hBZ3VKQmp4RzJKMUdOVzQrYnYrNHd3dW1nYjAvOExu?=
 =?utf-8?B?cmR3eldycG5TVmlPUVVIZWFHSG1GcXFDVXphbnhuby81WVJOSTFRS1laK0RF?=
 =?utf-8?B?Zzl3Vm9LWjBtZk9NaXRMRzJ1SWZIYVQ2OU5BU0c4ejJISEMwb3JjU1dsTEJ6?=
 =?utf-8?B?aUlhOVBseU1MckR2Zyt1MHRBenNsUjEydEpVVy85U3h6ak0yNS9oWk9YOGt5?=
 =?utf-8?B?ckNKa2NGbG03RkdOaXg4R1R6bGZsb0JUay84cEd5NjZmRk9YN3A4NGtzL2Q0?=
 =?utf-8?B?T0RrZW5XUXJtYlp2a1VLSXFCZnJ5WDVLNGs5UlRzSGtoSGxQQklZejNKc3JX?=
 =?utf-8?B?VHBJNC9FZHVSbUZkbjdqdFp4djI2SXNnZS9KSjFKcDRoZmVZU2tqbFJHNmI3?=
 =?utf-8?B?NXhGc2VuTFRNUVdVemE2OFdNRlBTRWlLZDNNNzZWZ1NlcVBnd3YrRWhTZTNE?=
 =?utf-8?B?QlVMbkgwOUxLMW5CT1VwMFZGdXM4Q1FKZWtlNWhtYWFrVXcraFArbmU5WlV6?=
 =?utf-8?B?QndwbDhrQ2pDcmNLTEp3N0tCRkdmc1UvVU8rbUE4VU1UVDYzN2ZHbTY1eEdX?=
 =?utf-8?B?QnpNcGxrZERyUkEyR3FSNllRK3U5YUc0Q1RiL2RyTEFWZmZRdUFuWWx1d3Bv?=
 =?utf-8?B?Q1F5c2twRzluUkpmQ1RZT0lvbjhBR05nREdLVDg3NzkxdzhkYzNkaFVTZEhW?=
 =?utf-8?B?aDY5OHRsckRuMmZQaUs2VGgvUGNVbStnU1J5SGRmVG1LRUt6UzBvKy9MZHF0?=
 =?utf-8?B?ZGhFbjdsVDdvcXRrRFZMSWwzeFA5WjQrbThEeVdCTGNxUmxSa1hhYkdQQXl3?=
 =?utf-8?B?d2RrdEpDaHNKSDBOOFRFODhGTlY1eTN4YzB2RXVHYnVHZzcyTHd5MUNYVm9G?=
 =?utf-8?B?OFkzb1lDMUdzemJwOERIbkdLTWpoUjN0NDVVNjJ5Y0lBOFF4UDJISjRCU3Vs?=
 =?utf-8?B?YXFxK0t0R0hHTkE0c1JCWEdoYmJaK1hxL0Q2VlZ1bGEyYStTcm55QUtIRlZz?=
 =?utf-8?B?UzRIb2FrSElrV3dGbjhPWGthZ3J0WndDekpkdUtPS3Qrc0xKTnVOcXNqMTUz?=
 =?utf-8?B?V01OKzlHY3I5OXlrRDE2RUh2OHNNM0hWU1VFWTI1UVpoT2I5YnFvdWhlM2xS?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff209ea9-58f8-453d-3ce4-08de0b4c8207
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:07:16.2854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNVdnSuCNk2Of7QwRU1M/ogJNNpI+/4N9iRfFPyfxrLoTo1nQ0qLaGH8EwF8NtJ6cPgJ0GIcrH0wJtrEJXa4Em52MTXuoB3zvhXJvF2Z22E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
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

Apologies for late the delay, I'll reply to the original email

On 10/10/2025 9:55 AM, Robin Jarry wrote:
> Robin Jarry, Jun 10, 2025 at 16:53:
>> Currently, for the TRIE algorithm (actually, it should be called
>> DIR-24-8-8-8-8-8-8-8-8-8-8-8-8), the tbl8 group is freed even though the
>> readers might be using the tbl8 group entries. The freed tbl8 group can
>> be reallocated quickly. As a result, lookup may be performed
>> incorrectly.
>>
>> To address that, RCU QSBR is integrated for safe tbl8 group reclamation.
>>
>> Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
>> Signed-off-by: Robin Jarry <rjarry@redhat.com>
>> ---
>>
>> Notes:
>>      This is a semi-copy-paste of the FIB4 implementation.
>>      
>>      I couldn't understand the implementation of trie_modify with regard to
>>      depth_diff handling.
>>      
>>      The unit tests fail because depth_diff is always 0 when deleting a route
>>      which causes any subsequent add to fail with a -ENOSPC error.
>>      
>>      Vladimir, could you give some more insights on the matter?
> Gentle bump. Hi Vladimir, could you have a look? Thanks!
>
-- 
Regards,
Vladimir

