Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3185E9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:26:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0FC14065A;
	Thu, 19 Feb 2026 17:26:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5EFC14064C
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:26:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518364; x=1803054364;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=zduTZHXmq4HUMKOog46Kq3APmT6k/L5TJKUtPHfQsjI=;
 b=TxN7psDocbqv2F5rZ1hpY2jjsXcihoc7A3w+RoM3DSTj4N+gL5E/4F0z
 9Ytl3wzsovDwA5uo+NJiR5t5/+kqJbUXqJ+IUNCI0NAs9YmUv+q46psJK
 a4vbfJHSw90rBO3nQLRq53nv5CRqPEzq7p7vhfCSini/cEzbbevWkRGoT
 +1j4TyJdYpCXsbbubS0Mo0n8QPr6MLpJyhCAuYRfTbkwZYyHIsuZ3SXPi
 l5THVW0urlojUiQ6p3X5hImPZUpiMElp5/3CaLikEvmIajps7VfUmXHYd
 /38lIwHsFCdQzevWdHxBP0tdWsEDo+Qi8JIq1aot7jKx+srh2ZA5QYFGg g==;
X-CSE-ConnectionGUID: p+12pvxaTM2dt/Vlc6jW/w==
X-CSE-MsgGUID: 36PFbCHdQJOiWefDrBEKGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83326678"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83326678"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:26:03 -0800
X-CSE-ConnectionGUID: ZZjXo6Y9QR2ggZgKUXjYRw==
X-CSE-MsgGUID: Jk7EC83hSZy1XDj2z9mDdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="214420905"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:26:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 08:26:02 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 08:26:02 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 08:26:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k00+5BD6JBY2DzJKuz+cRv0e24/VZyD6RD3mvt4/H5TvG+Ny3q3z/8gTFxCg55bHmdHlh0NibI5y/Bg5Nde1hCxGUq4871ECalXW0+p2qkWto5IgH1U9GdR1OeHZK4PU/+uHoThzNR8H245YvguKLYe2/ZcqNPP/+MmlIW0/5IukG74Ja9QGtBSHVIK/bg+zZaexBNFBOOq3ZK3cVjvDuYEMZlsEzny+i6OK3zV4aFLbR7Ew4P5KCoLjnKs5qC55A9cusLXb5Rqa5tv9FolpGTMf2rjNCjMOw4vY/rg0pJ+biJpjd8cIqhrBBSpQBldbQxkIYOiiumOavnhfijNHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75L7NkEO6jrxwgc7zkn9fObcqNMN7In1am9aEdX99Xk=;
 b=by/NNv9WJF9HX2f5H2VcUgqhbclYorT6sCpI0P/bdWwncfzuTqao689pB7hFGUg4hp0b3Jn2ECAPUjKS/AgzNGwHwJ83IBffMQ33RYfDnJmboS+dD6sJdpzw6T5nsfmoIaolCh83od68rD63/vZ+5t2Aqh12sTwKAv9TuSFmIZqDXNUhl8SWB06hxkOFMHc3Ekbs4hP9kcyQ7usvRk6gT3W4b0HEXIMduCVxOfe/zzQKPDkEXyUhxV8k7L4HvtGOhOoXsTcONRWWMbGM70ido5CZGmzPg6XoiZcoKqBhwrIPKz4sB5cF+4WBxY44rmWeTPgvL9tjUIEEjtwVhpfLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH7PR11MB7452.namprd11.prod.outlook.com (2603:10b6:510:27d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 16:25:55 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Thu, 19 Feb 2026
 16:25:55 +0000
Message-ID: <f7968228-7e26-46cf-8c91-01d8a007bb41@intel.com>
Date: Thu, 19 Feb 2026 16:25:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: explicitly pass flags param to Tx context fns
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260219160726.2117208-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260219160726.2117208-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:10:232::35) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH7PR11MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5e6bec-058a-4cf6-df2d-08de6fd38e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm1hR21HY0ExTmN3NUpmKzA3T1d2R0ZyR0Q5MWpZZGtmKzVMNzRGaUZybzlC?=
 =?utf-8?B?YWxSemwvUXk4cE1ZdWc2L20veFM0czl2azVTd3p5a3JTVm1KVTR4cnhoaG41?=
 =?utf-8?B?TGJYVGJTSTR2VzFMMDdjL1dJaWtWbmhob1VmWElJN3FlSGI3ZWlqY2lqR2J6?=
 =?utf-8?B?d1N5N3JocUh1bmcxaWdrMHZyQ2VSSCt2eXNvSmVraWpiQk5oTFR5Tno4czU5?=
 =?utf-8?B?cU1raFcwNmN0emtYRHZRL0praHdiSU5ab1FidDVjdnVnazBkRGllZlYwc1k1?=
 =?utf-8?B?T04wMTAxSFNzeGRCMVJrNzJReVhwZmd2Q2VPNjhXeDQvckRJVHdWRWJOcGVN?=
 =?utf-8?B?bWFuYWNaSlYyYlBrR3d5Zm1ic2ZxL01OQXgwWCtkd3VKYWlGc0hOU21MTitu?=
 =?utf-8?B?c1RsM2Z0UmdJTDhkWW1FMzVVZE5lODNBTkZNVTVUQmRHc1M3bnFLVkRJVVZG?=
 =?utf-8?B?bTVNOFNuQ242ZW5ISEtDNEhKMU1LM0hYNXBKSWowRWtEa1RSU2cvTFlJRHdo?=
 =?utf-8?B?NlBuS1MwdmdZMkprTDBlc05YWVJYR252cGI0VEp4TmNRaHkrYmNDNVMwaUlv?=
 =?utf-8?B?eTFMQmZhNGlZT1pIMFZIVVFrbmxlWDZWRWYxYnE3SDJaaWJKVXZpQXczRjRw?=
 =?utf-8?B?VzNQUDZZRy9CU0RoQWEyakxYNUNMQXJIQ3VoRGFuS1RpbThjRlNDcVVFdzIr?=
 =?utf-8?B?R2s5ZElBRHYzNVI2SDZVSEczMEFkL1diZStoWG1KUThVZkErRkhQK25EMDdq?=
 =?utf-8?B?SEZRSDQ2WkM5d0FYZXJ0VHp5alU2STlZNXAvelNPUEpRYmYzYVUvQ3gxb0tG?=
 =?utf-8?B?WkxrZThYSlJ4VXQ1QzhDcjk5dFFXU3lnU1BXVDNVMXl0RmhobmtoV2dmZ3E5?=
 =?utf-8?B?UG8wWFR1QWZMSncvNDRmNjRLK21QWE92dEx1OTFlSHJUT3FmcGtOK3AwNElm?=
 =?utf-8?B?THRiWVBzYlM2b2tQclBqUm9pcUpMZWcrMnhiKzN0VkRwTlZ6a3J0L2ZJbmRN?=
 =?utf-8?B?ajNlT0RFZ2d4SjR1NkpVUDlaQzJ2TDhVTDdsWUhlb3h1czZzaHB6aEIybi9z?=
 =?utf-8?B?UU9keUplbjBaWkQwMklxWUE2eDY5YldMR0tDdmpEb3YydWJZb3ZHMksvaHVt?=
 =?utf-8?B?R0doM3NNc2IwNVFZLzVHZXQwcERrMDF2L2VZenBESndzNDR2aW5Md1dybEtD?=
 =?utf-8?B?cGZKdlZTWjNnVzgvQjQyN1J2VkdWVGpodlNHYm1mL1YyZzhmK2R5bnpJU3pV?=
 =?utf-8?B?dTlzZWl0dVh6eC9PR29xRWllV3pJRXNJS2wyT2J3bkZUbUUwYmowbnd3V29K?=
 =?utf-8?B?dE5vU2o0dWN0S1ZYdDZES1poOHRKMk05cU5xY3V2MXBXSCt5SXV0M2pGYnNl?=
 =?utf-8?B?dTBnSmE4RFBEOFFTWXRFbnZWNDVic1ZSaVNWNEVicnpBdzVPTHNhTXVVa1dP?=
 =?utf-8?B?aFhpUUZvaGRJcDd5dmJzQzRRdHFTUkJFVjV3M3lyQmhXUW8vcjdDTEwrWVlw?=
 =?utf-8?B?MmVZK2tRS0VpcW0vZVl5aW9aSGdIckZqK3QrKzZuNDBwZ2pDU0lRL01tQklk?=
 =?utf-8?B?RUQ3OVp1U2hXZm9XaVByZDFuNG1ZZnY0VzlnZnAyWlphdkx3d0NFRlROVXVJ?=
 =?utf-8?B?V2ZxMEhhMGlWd29wamVIcSt5bnpzbGlWRnYzUW9CcEFUcEd1WjZ3Nm52ZkZU?=
 =?utf-8?B?K3FrTFBoNnJKQzcwRkZsOVo5MWhGWks0V3FCL2pOYlFEMHBHMU1qdlNzdFlR?=
 =?utf-8?B?NGwzMnNic0NlTDZsYVVxc2RHRi92bmJKNmVqVXNjcmpEUVdEbGN3VWVTQzdj?=
 =?utf-8?B?SHUrQlZ4cXJOY1M4enU1aVNSV3djMlNIaVlKMnh6RXhLeFJJZGx1WUQ0NlB6?=
 =?utf-8?B?M1dteUZXWTdPRi9Tby9oY3VsRU1XckdBTmtvNXNmbnV1QXpwOGNMcldUaTlD?=
 =?utf-8?B?QTVyM1JtaE5hQkR6RHJQYW55V3hUNFQ5djBZWXFCY1QydVY4Sk1GcGJYTHgv?=
 =?utf-8?B?WVZpK05wUDBXN3VueGRrMkx5ZzVmZ1N3bWgvZGRwbzVveGJKa0EzeTFvNU5K?=
 =?utf-8?B?Zk1FU0dkU3RiQVJ6NWRyVUY3YzI5QkgyRDZSN0VWTTlMYm1rV0txa3JGeUlD?=
 =?utf-8?Q?14cI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3F1L1lxdXMwemZKVDlXKzFCTnlkbUV2MVlHOGdvQnJoRW53Vk8wQTFYM0xK?=
 =?utf-8?B?UEhLRGQrNUdEWGM3ektibGxnQ1lIMlpINjIvNExwaHNuOUROSC8rbHJMYkJu?=
 =?utf-8?B?cWkwb3FCSTR2RTNlWDdCZnhVa1ZraWlmMU9YQTdWVkhKNGRjUFRYUkFjNEMy?=
 =?utf-8?B?RGJXbmdBeVZ4R0hvbVhGQ0JVUnBtcFlRZUVzTXNkTjg2OVJCWGJ6OUVxV1RG?=
 =?utf-8?B?bFBTMEw5RmR3dmxsalNqLytSblpJSDRnZ05aYkJmaU94c2N0M0FNNHZpZjFr?=
 =?utf-8?B?MFA2ZFJhNWNwbzVzQmJaT01WanVFdjdEcHNkWDJSRVRsWFV6N2RiQVFkNmY1?=
 =?utf-8?B?eVNvUTFuYW02OGFYOVhoRE5VaTRjamVHbWZwK1hQRXE3ZFNSVXduWXdZY09L?=
 =?utf-8?B?QUV6dXJXOGxEV0RMZFRtNzRLS212NGZvSVpGMERreG8vQjlUL3o3cGh5WDMr?=
 =?utf-8?B?Qy9CWDAxa2lJTWZhKzNJam11TVZYbitmZHhCck5aeVhhVFVoYkFpMU4xVmtX?=
 =?utf-8?B?Vk8xQWVnTDFNSFVRaTlJM2wyWmRTUXdveHdHb0pkREozSEpLVndHaUdwWktR?=
 =?utf-8?B?UGR0MGRCWHVNNDRVNGZRb3orR1plVW5MMC9oL0lsLzEvSG8vSVpQZHFTODJQ?=
 =?utf-8?B?alB0SU5oVlNwYWpDYVQwdGhGbjRWTU5KWE9OY1lzVHVMZnRpRk05OVdRYzd5?=
 =?utf-8?B?MGM2VTFQekVQcW8rZ0thcnhVMmMxSnFIQXowc2Y5Ni8wQWNERWltakxXRlpG?=
 =?utf-8?B?d1BXWnhkdlRhY2pKanNLUXVzRHQ0UUFoZmlNNGdXbXl1a0lBa1RGcTVWWVdN?=
 =?utf-8?B?WU5nS1Q5YkZlc0x1Q1RTVUE5Tm9DMGltNFRrUEZXN3lSTzBISFRGbm5rcGRh?=
 =?utf-8?B?V1N0UENyUGk5bUhra2RkeHRzalNEQ0pqRXRONE9LQ0ZDblJXNzVpN2JoYWVt?=
 =?utf-8?B?Y1JKcmZkR1dhUG8yV3VJMVJ3NmJMRnJXaE1OOG1nWkwrWXJXbmxvWGR1enNG?=
 =?utf-8?B?dzZCeXZjM3U3Nmh5T0dxUXM4N3I0N296eDlRM1NVOWQ2b1RMcHhBcXFrRXpn?=
 =?utf-8?B?MFFHdy9LL3pKbU5TOHFoV3RVSGYyclZJcDdXY1FuRmRIQVo3dUVGNDc1cHFo?=
 =?utf-8?B?NjJOQnR3UGk2L2I2U1ppWmxqNm9qbG9GVUI1aEdwUTk3ZXFmRHE5ZmFnYWNN?=
 =?utf-8?B?TmlvSEFZVlZGVFZ5THkxcGVSWDFaU1B1ZUVpZGxuRDQzTUtzNGpMeWFLbGpM?=
 =?utf-8?B?Vm1XV1oyQWsrcUxaNEFNNXROZlNUVWN5Tm5ZV0dJbnNES255STVqWDNmSmVr?=
 =?utf-8?B?MVNIM1F2cy9mcWRzSWhwWXMvdWtSOTNaNWJESzdaTXVNdUUweFo0ZUd0SUVp?=
 =?utf-8?B?U09HaGxIb2VrbmE2UFRJTDNNUGFpY1NPQVhRMTgvQzFWME4zRGdaTnNmR2Ny?=
 =?utf-8?B?bzdEdjZkQnp3ZjBBMUVuRkYxcGk5N24xd1A2NlJTUkYrdkxseCtGelU2VlFp?=
 =?utf-8?B?K1BXdDBKOU10Yk9hR3hnVnNpYjR1TzAwRWMwNTYwaGN2M0VSNkVqMmx2blRs?=
 =?utf-8?B?VEZqcXlOalRkeXhkU0xmaFkvOGRMNU5sSlh4aWgwaENOSis1MjQ3dWFWVFg4?=
 =?utf-8?B?UjhkUmM1TThjVXdJQ2p4UEE0d2I3YStwSVM5QytZMEJNQ2FpMUxkZ2hsQVMy?=
 =?utf-8?B?N3B0UmVGTk5XbGV6ZFpuSTJHWTVCcXJkWE1tSWZwM3FmVlpKa0RTeVdFRXhj?=
 =?utf-8?B?OHhvK3kyOG53ZkUrUGVzRUt0T3cvRzRUaCtzZ2lRUVp0ckp3QlQzaFlWTlRs?=
 =?utf-8?B?aXFHZXZaT2paVHRvMERHUXkvZ1Y1QmtRRmw2ODFIVDE0czZrVGRrZjhaejF6?=
 =?utf-8?B?M2VOVHJrNHB0SGIxcldaQjBWay9GMFFnZURrRnJ0VGVWMHNwSWswV2R4VERj?=
 =?utf-8?B?ZWFNUFZBNGt3K1VROG1XazVsbys1V2t5QlprM1Y4QzBpM0U4b0xNbXRKeGpY?=
 =?utf-8?B?WGxIOUR3V0dMNHNwaVZYdVJKZmNxN2dDM1NXTEVBSWN6c0ZSU2h5QmFDUHZL?=
 =?utf-8?B?RnVqL2twWld4YWE5M3lGbWY4RG9HeS9PSGVFdG9xdUFzMVAxL0dPWnFQZXRm?=
 =?utf-8?B?NmRJRFFPdkk0OFRDdkxIOW5LTit0eDZpM3V2MmdWWkdnamFQV1lWZ2xTUmtI?=
 =?utf-8?B?MGlCMUpVbkt3NWlzVzMxd1hHOVh5V2FVQm40ZUdYWitza3lSSXlYekh3aEIy?=
 =?utf-8?B?MWV3dFJmZ2daNU1abUVERElGb2RjWFBOVE1MZTlsUUszMldyT3Q4TjYvbGpV?=
 =?utf-8?B?WGhRVXJLb1pZSWcrMUtHWkswSmhwOHFJQ3MycTNHZWlpd1ZXVE5kdXpTUjJ2?=
 =?utf-8?Q?jdglcSCOr7gJ7LuI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5e6bec-058a-4cf6-df2d-08de6fd38e22
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:25:55.0367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxFSHGdvdTX71XN+J1bU0g490adyy+ZcO5pz9j+Qu4LLCk/cpgX4ihn6uJpTnOnR3vXruNg29ejyiEtn+53U+Mw/b0K9ZELRJviv7WYODQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7452
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/19/2026 4:07 PM, Bruce Richardson wrote:
> The get_context_desc() function takes as an explicit parameter the
> ol_flags from the packet, which saves re-reading them from the mbuf. The
> subfunctions for creating the segmentation part of the descriptor or the
> ipsec handling do not take this parameter though, and then re-read the
> ol_flags from the mbuf. While essentially harmless, this does confuse
> static analysis tools like converity which does not realise that
> ol_flags and m->ol_flags are the same, leading to false positives
> like [1].
>
> Fix this and avoid coverity false positives by just passing the local
> ol_flags variable so all code uses the same flags source and avoid
> unnecessary mbuf reads.
>
> [1] Coverity Issue: 501497
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> NOTE: Not flagging this as a bugfix since there is no actual bug here,
> just a code improvement to try and prevent false positives.
> ---
>   drivers/net/intel/iavf/iavf_rxtx.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index e621d4bf47..2464a988eb 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -2361,14 +2361,14 @@ iavf_calc_context_desc(const struct rte_mbuf *mb, uint8_t vlan_flag)
>   }
>   
>   static inline void
> -iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, const struct rte_mbuf *m)
> +iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, uint64_t ol_flags, const struct rte_mbuf *m)
>   {
>   	uint64_t eip_typ = IAVF_TX_CTX_DESC_EIPT_NONE;
>   	uint64_t eip_len = 0;
>   	uint64_t eip_noinc = 0;
>   	/* Default - IP_ID is increment in each segment of LSO */
>   
> -	switch (m->ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
> +	switch (ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
>   			RTE_MBUF_F_TX_OUTER_IPV6 |
>   			RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
>   	case RTE_MBUF_F_TX_OUTER_IPV4:
> @@ -2385,9 +2385,9 @@ iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, const struct rte_mbuf *m)
>   	break;
>   	}
>   
> -	if (!(m->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD)) {
> +	if (!(ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD)) {
>   		/* L4TUNT: L4 Tunneling Type */
> -		switch (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
> +		switch (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
>   		case RTE_MBUF_F_TX_TUNNEL_IPIP:
>   			/* for non UDP / GRE tunneling, set to 00b */
>   			break;
> @@ -2425,7 +2425,7 @@ iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, const struct rte_mbuf *m)
>   					IAVF_TX_CTX_EXT_IP_IPV4 |
>   					IAVF_TX_CTX_EXT_IP_IPV4_NO_CSUM)) &&
>   				(eip_typ & IAVF_TXD_CTX_UDP_TUNNELING) &&
> -				(m->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
> +				(ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
>   			eip_typ |= IAVF_TXD_CTX_QW0_L4T_CS_MASK;
>   	}
>   
> @@ -2435,18 +2435,18 @@ iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, const struct rte_mbuf *m)
>   }
>   
>   static inline uint16_t
> -iavf_fill_ctx_desc_segmentation_field(volatile uint64_t *field,
> +iavf_fill_ctx_desc_segmentation_field(volatile uint64_t *field, uint64_t ol_flags,
>   	const struct rte_mbuf *m, struct iavf_ipsec_crypto_pkt_metadata *ipsec_md)
>   {
>   	uint64_t segmentation_field = 0;
>   	uint64_t total_length = 0;
>   
> -	if (m->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD) {
> +	if (ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD) {
>   		total_length = ipsec_md->l4_payload_len;
>   	} else {
>   		total_length = m->pkt_len - (m->l2_len + m->l3_len + m->l4_len);
>   
> -		if (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> +		if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
>   			total_length -= m->outer_l3_len + m->outer_l2_len;
>   	}
>   
> @@ -2573,7 +2573,7 @@ iavf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
>   		}
>   
>   		/* TSO segmentation field */
> -		iavf_fill_ctx_desc_segmentation_field(&cd_type_cmd, mbuf, ipsec_md);
> +		iavf_fill_ctx_desc_segmentation_field(&cd_type_cmd, ol_flags, mbuf, ipsec_md);
>   	}
>   
>   	/* VLAN field for L2TAG2 */
> @@ -2589,7 +2589,7 @@ iavf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
>   
>   	/* Tunneling field */
>   	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> -		iavf_fill_ctx_desc_tunnelling_field((uint64_t *)&cd_tunneling_params, mbuf);
> +		iavf_fill_ctx_desc_tunnelling_field(&cd_tunneling_params, ol_flags, mbuf);
>   
>   	/* L2TAG2 field (VLAN) */
>   	if (ol_flags & RTE_MBUF_F_TX_QINQ) {

-- 
Regards,
Vladimir

