Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A6C83F27
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 10:18:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E8024021F;
	Mon, 14 Jul 2025 12:18:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id D2661400D5
 for <dev@dpdk.org>; Mon, 14 Jul 2025 12:18:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752488288; x=1784024288;
 h=message-id:date:subject:to:references:cc:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0qP5Y+YBbJw/Gt5xoyeV61J9TGfKz0oiC5eHA+E66l8=;
 b=TKjhQwJyhTJGBMpIhtu1RPT3KsGrx8Prxs+As1OT8awkmlkFfpSSHvmx
 n+6soIi0sdwfOIoii2u1XnYpy5vk+ZEmoLKuuPsXKuwguDbHMJ+2Fk0Sv
 5pk6tTmwUR3ofOJdVqkVBv1L+JJFYrgJn7V49FDy/CgJes8Tfy6Kcq9hc
 o0Rz4PPePCPIW/CmrNpzya+W3JyJoqQfvHp0+F30f9myXbzboRqbuCAgP
 GTmcPp7ox+gFRQp7La/VzuhvsEMO+fqMpaOiypqSSuVVgLenHIyJ49K50
 O0e8oTCjsFXFLpWvYdIJUnJARolfY1zJx1NA0OkT1TUmbLaZZBupMbqcO A==;
X-CSE-ConnectionGUID: ehSHr6TFTPSFo4Mi1t9V7w==
X-CSE-MsgGUID: rSjcv3OySfigVQRIv0fkTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="42310546"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="42310546"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 03:18:07 -0700
X-CSE-ConnectionGUID: vpr7ZgV3SkywEoslAFmDlg==
X-CSE-MsgGUID: KjkbZdJZQpO0NxEyOmfESw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="156996515"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 03:18:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 03:18:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 03:18:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 03:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyMCjzXJ0N1gKwGbhQXRERkJPmqumnTs3Xx0jSHS10oSbSVHKufAntnW1VTRrirzj+GliyR4UvScaGsEkYGCKgVspt613KEV2Fioi/Elj0+ZoQUkmhIxHsrwO/xN9QCUPhJLQypXJklo5wwSErCUXmSbeP9yndktbLVUAB84USwdYFi10aZ5OnduJeNFFHQOmcgmeFaB9i3XCGhGMTVLQg64fS4yX9CYX0vbWJlvKrsJfRFSB2K+sBc7Movum2UA8gjbftS3PB4TWZpwByeWLLqCGd2KiMxmjEbKTmkbWMpbLWGfkXUe5mkHWElEuUhTD90nM8NmoD+7UlUcRIIzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5XbH/17rsuE2/DWfBQFVpM96k1YCD/MlL0dT6Gdo0g=;
 b=P+fqH/7h6kQpLEO31ldUSkBrphYEmlXw88LB46zBU2wzjsRjbPV6ITqmjLMhSpdD1YAJtZN4g2Kz40fF2A2l5isC07Km92ngd9CyAhAyxYFG3nDWCjvMo1x44eZ2GfB7VuKmlj+ycuNezOjHyaYdlbsD17jUyKqAWgqhL9pJiJjW/nfrHzEnJJMXx25Pkl+uKcvK1/BflDGUvBQtQFKW2tfn77lfHqyLiPFZp96BeDr8YJEdUTx5Y9XWzRhrnpOqhzxdMfFjWGxLgqad3YbGx0F/RMC7zoNd980QB6UHWm2+enovRen+sJzwaqp0xFbGGSNRAVvo/7zK+9ncK4IGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by LV4PR11MB9514.namprd11.prod.outlook.com (2603:10b6:408:2e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 10:17:23 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%4]) with mapi id 15.20.8880.026; Mon, 14 Jul 2025
 10:17:23 +0000
Message-ID: <8d868117-56e0-4acd-991c-504a5dc451d5@intel.com>
Date: Mon, 14 Jul 2025 11:17:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 1/1] doc: announce inter-device DMA capability support
 in dmadev
To: <dev@dpdk.org>
References: <20250710085101.1678775-1-vattunuru@marvell.com>
Content-Language: en-US
CC: Bruce Richardson <bruce.richardson@intel.com>
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250710085101.1678775-1-vattunuru@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0350.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::22) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|LV4PR11MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 539442d1-2b38-40bd-00d3-08ddc2bfa017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmpwclVJc1VEako0SkRVL24rTnQrd05uT29vemFKcEVKQlRXNkZ0bUc1d2k3?=
 =?utf-8?B?cnpoVFVzWU5HbVV6dHQxakFqWi90eklxZCs5S3VDVGlCbW9pWUdDZTZIWlFD?=
 =?utf-8?B?Nnp5ZnByRTYyTUhiaVl6NllvRm1mbkpDUmdEZ3BBQ2g0NktzOTczdXY2cFh6?=
 =?utf-8?B?eTJhbDJ2UmdiM2pKVm5hckVYREw2N1BRUFVEb3AybERGRXNrWlRxRXU5MmJ3?=
 =?utf-8?B?a2o4S0xMOGxrd3E4amtGdG9RaU1BTmg0aFhoSFNSRnhmMGo1TnBoUXYrUkVO?=
 =?utf-8?B?c1BuWWU0VzBJOFd1dTErS3ZMZE1JVlFkNjhiV1FUSk5YQklzdjQ0YWUydHFV?=
 =?utf-8?B?OFFrQVhTazRmYjdOSnFWTUlTOVNNNi9VN0JjMTB6NkhJdkFna2R4QnZFWEdQ?=
 =?utf-8?B?b2RtdTZNRXcxR2tMM1o5VythOWNadlNERkl6TTYzK3NkOGR3L045b1JrU0No?=
 =?utf-8?B?Zmg4L1g2RDFLcE5ZWGJMYzZpNGRSTWU3R29XeHc0eTRWTStMNkJObmpabTY1?=
 =?utf-8?B?MWhRdkZodDdlVnUwUGpPalVjb2hvY1FJUmtpbTR2dTcvdnJaZit0RHlEa2Ez?=
 =?utf-8?B?SmMvMlcxU0VOTUUwamtaZnQ3Tjk5TXo4MlZucTlWTFBKcWpsT1ltbjVScVdi?=
 =?utf-8?B?VG04UUhXeWVQOHcrNmc5aTVOVmpMaVZudUE2WVRwT3NKMXZBSXRJaWlWNmU4?=
 =?utf-8?B?QnVxOVR2V3lYd3Z1SlJVcWJtVWt1M2tqM1RxMSs3SmFYdmNuVkdKL2dqNlNk?=
 =?utf-8?B?WWlPdjhaMXhHaFdUVjJsMzNqaThaYWpsaXd0RXdyMlpVNDJXU3l4VS9Oc0ov?=
 =?utf-8?B?UWNFRE5MMWE4bU90bS93eERVd3kzbEJvVVFpbnZHTXR6N2toVUw3VkI4OGNa?=
 =?utf-8?B?eldJYkp6ZkE3TE44citubFpwK01jRDVudGJ6dHNwZGYwdmY2S2U0YXFRaUc4?=
 =?utf-8?B?YkpBK3ZYZWZ4NWZSYzIreW5la2RmaXU0Y1drREJGR2lNSDRiSFNmd3J5K3dH?=
 =?utf-8?B?MVR6M1VOM201REpiOVY4ckwzMFFaNkhCME1iSjV4UTdJOGJyZFpmUy8xNjhJ?=
 =?utf-8?B?cnBPZ0gvUU9ZSWlLU2dRemQ3aHV6ZzFJQkFkZCtJWUNJN002T2xxamxxdXRZ?=
 =?utf-8?B?TlNIcTcxL2VKYTJ1dkR3SEhTazMvOEo0a2Y0dGYrckk2bnlndktOeXdxcGw0?=
 =?utf-8?B?NlBNL0RUK3RLNFdDRjNTckdUc1ZDWVp3RUlKemt4amtTNmN0NW95enhHaGZO?=
 =?utf-8?B?N0s0emRYYlVtMCtYSVNnSmdMTDNRZlRqSjdDN2x4bTNQYUlENDkwVkJVQmJI?=
 =?utf-8?B?cTdNK2JCd0NsWkRLaDlZaDBaL0F5U09uMFFNNzE2ZkIzc1hMd2lzN3JYREdF?=
 =?utf-8?B?WjJ0T3NjNEtxdThncW5IU09KVHplbFIwaGFjVCt5bTVqZHRMQ3hqTXZNWFV0?=
 =?utf-8?B?ZDZLMDk2T0cwcU9Fa01kQjhRZERGOFREZnNyUWU1dExxT1NJYi9sUlpZeEl2?=
 =?utf-8?B?WTk5RnpiekpqRmxOL2RmSVFXTjRUT1M0Y1NkZmFOenplWFZPOHJWWW81ZUxy?=
 =?utf-8?B?T3lOcVRwa1dlelN6WkdCU3V5c3RtVzlLa1M3bXJ6VjRSUjlMVXFCS3RVeUNP?=
 =?utf-8?B?Ny84Z0c2S2xTMkFVT3ZVVW9UU09kdXgwVHdVc0p5dkNqaUNPSEk1RzRESXl5?=
 =?utf-8?B?Mk91Y2owTmZNZ1Bycnc3VVlLZTRhdGZEbGluNzFJK1NzTGdFY3RjSzNDWGhw?=
 =?utf-8?B?UFh3VmhpQkFpWjFJUWUwYXlJV2sxVFdzRWhjZUpKRUJvNStvS08yWk1SQk9T?=
 =?utf-8?B?ckRFdFNoeEtZZnBUTW5BZ0llc2w4RXZ0WWJOVlRXbnNVMzR0OUpjMDhiT1Fk?=
 =?utf-8?B?NzRSOG1ObUF2MmhjSm1VY0VnNVlYQTdJNzZodENCTjJSSkMzTjc1NTgyQ3l5?=
 =?utf-8?Q?STQAA8uC/ZA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y09YR2xGZWZGMlcxMHdjTTZmUjZseEpUMy93RGlUSmtIMVE1aFJvc1dOUVdx?=
 =?utf-8?B?L2RJcXpUckVNdDY3VCtnaEo2QVJ1b1gxeHdpZ2hNMkdyZ1p5eGE4ajlLbUpR?=
 =?utf-8?B?eHdMcE9reE1NaUtoREJuS3VzbVR0KzFqOFZVUDI2Yk9TU1RONHpzd2xnbVBC?=
 =?utf-8?B?clkyNWN4SXVMK09yOUZIT1Zpd2cyRVFlRW14dGhONmJUaE00ZEpIY0g4aHEx?=
 =?utf-8?B?L3pCRDFOR0hUSFFoRllYODRocTNTd3FUbHkreFowT3NYRUt3MFNXem5IK0h3?=
 =?utf-8?B?b1h0SjFSMUhXNjhhQmQ1VVUzblNUZGk5cTdjcDNySXdIT3orNkI3cU0zeDlT?=
 =?utf-8?B?RS9CeTVibHRBM1dYcnYySWdNN2xBMHM1eitUNmJnbFlWYXE3S3ZibXJYYWZJ?=
 =?utf-8?B?eTJOaEJqcW4wU0x6MitaWGNIc2pTaG1vSFBRd2Z4R21jUWNXRWRTRVFUcDJs?=
 =?utf-8?B?cm0xTFpTaWdZY0lFaXRJWHg0UTNLREhMdXJLS1hiUWRPOVYxU0todXdHWEZR?=
 =?utf-8?B?QmVpZjh0VG95U29EVXJIQ3ZJa0MwNUFXc09jdUV5RFhkN29iWjliek9nTUdV?=
 =?utf-8?B?NUxtSEJLQng5ZFVWU0ZTMVpLVlFIcUVDTFVtSjBNUUF1VnJhblR6WnNIM3Az?=
 =?utf-8?B?VHkxU3krdm9hcWVzUFlsMjMyZldnbndRa0ErbHc4UnErYVZnM1VUT3RGR3Uy?=
 =?utf-8?B?a0VlVkNzVTNxYTFVZTFLb2w2aEY1R2k2YVlPTklyMjdzb0R0c05iSDlaaitm?=
 =?utf-8?B?ZnJJM1JEV2V3ei9FTFJnUHUrYllseGVxaGh3NmFJelNPK3ZaN3g3cFcrM3Jr?=
 =?utf-8?B?eHJEY1pHRi93c1ZQaW1GNXpQY1hydmQ5SlJRTVRyWEphRHNQS0tRWUdhRDE5?=
 =?utf-8?B?TGVkUmQrWTNoREF3SDhSdzJGT1hzWGtJT0FYbEw4NG1xSTNXbTN2ckJqV3du?=
 =?utf-8?B?NXFXMGxOMFg5Sm9UWUY2VVdWRk52VTV2OXl6amE1MFNCY0o1NitnSFk1aVJD?=
 =?utf-8?B?Zk95U1NMOGJsWlhralg0Mm1CVUVsK0xmZkltR2V2Wm5MWVlyTmRGODFUaHIr?=
 =?utf-8?B?S0RyV1VTNWR2bTNWQmRSclg5bHRxWWdKVzgxZmhuSGE4blg3OXB6enF4ZDVI?=
 =?utf-8?B?OU9NTjB1TWJmUWR6MktwTnRVTkdNbFB3Uk8xT1M2V0FNMlFPaWJ2YjVIMzE0?=
 =?utf-8?B?Rm5kK0ZwbmxUMVpIMUl5dGdiYjZseW42TGNXNmkyMGk0ZWdkZHp5ODYxN3Iz?=
 =?utf-8?B?MHJRTjhyMWtmMG9KODB0RHgyaE12N1VZaklZRTFBK3lzZHhGSmVDcDVaME52?=
 =?utf-8?B?RnNHajJZaW1FV3Nvc1lIZXlZWXNFYWJQT0R4VmVQSDFQNUpKZGU1bXZGTG1W?=
 =?utf-8?B?QW56VVNtKzlGdDFOaHRGSXBLSW5YUEo0bk02OUVITzl1cXlFczBSSUJKZktU?=
 =?utf-8?B?SnhHejJkVmpnRTBkZHd3WG45NWdETUlHL3dYL0RYZWtXdXpsMklNclZWbHdZ?=
 =?utf-8?B?UE1mTUtxajFBSVJvYy9QTzJ2dG8xdW9KZmg1d1IwcE14SURaR3pvbTlxc2c1?=
 =?utf-8?B?MGJRM1M2NjBqYkdJSmR6VFNSTG56NVdrTGxIdlVTYVpPZ2tzL0owUkcrTG9q?=
 =?utf-8?B?Nmx3TDY1dnFWbVAvZHNZU21OUjR3bitoSjVpbUlad2R0bitzd2JqWTVUdWIy?=
 =?utf-8?B?OXNVY1A4RzhBUERTdHdMTE9FYzgyeC9rbTdDV3BOa0VBbk9rSXdEMTMwUzIz?=
 =?utf-8?B?M2tXbW0weC9MbkdqMmVhcGpua1pjYVBpeitWcGs4eHBGc0N6ckkwdjAxbS9q?=
 =?utf-8?B?T0IrRE9BUVQ0dmgyRkd2QWJWTDNCU3U4Ymx6QklXZkFFZThQWmRGNWZhT1BH?=
 =?utf-8?B?TklaQ0RxNnFKOW00VzVHcXVMR2RGKzJHcmFpL0hOZE9jQ3U0ZDdRb2hZTUhV?=
 =?utf-8?B?SDByOTJqRTFNQnR2dDM1Y1Y0YUttTUlqRGxnNC9hZTFDQ1ozSTUwcDdnb2Nh?=
 =?utf-8?B?aEhGdVJOaHFOTFRKK0tXTytQOExPY1hZTUl5dUFrQ2ptNmtkdEVoRDZOVjRI?=
 =?utf-8?B?NjZVYmlrV0YwU1FwLzVCNkdkZEtGMzhCMjFqSGNMSWszcHpFaWo0bWovc1k3?=
 =?utf-8?B?WURaUEgybXBFWDNRTE56V3Npam1iN3pZVnBGN01LaHhlNXpVUkV1T3M3b0xj?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 539442d1-2b38-40bd-00d3-08ddc2bfa017
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 10:17:23.8746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DPQQjnHdVM3pqbj5jP93+vPVFlbObNUepnY1Sw/6yRHQB8aJVgNyuKhOSZXKM2j5Aj9cSFDkBMTPVGMDZF4JjzRZ5mmURZAqzXJAVs+cP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9514
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

Hi Vamsi,

Could you please tell us more about usecases for this feature?

Thanks!

On 7/10/2025 9:51 AM, Vamsi Krishna wrote:
> From: Vamsi Attunuru <vattunuru@marvell.com>
>
> Modern DMA hardware supports data transfer between multiple
> DMA devices, enabling data communication across isolated domains or
> containers. To facilitate this, the ``dmadev`` library requires changes
> to allow devices to register with or unregisters from DMA groups for
> inter-device communication. This feature is planned for inclusion
> in DPDK 25.11.
>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>   doc/guides/rel_notes/deprecation.rst | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> index e2d4125308..46836244dd 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -152,3 +152,10 @@ Deprecation Notices
>   * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
>     ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
>     Those API functions are used internally by DPDK core and netvsc PMD.
> +
> +* dmadev: a new capability flag ``RTE_DMA_CAPA_INTER_DEV`` will be added
> +  to advertise DMA device's inter-device DMA copy capability. To enable
> +  this functionality, a few dmadev APIs will be added to configure the DMA
> +  access groups, facilitating coordinated data communication between devices.
> +  A new ``dev_idx`` field will be added to the ``struct rte_dma_vchan_conf``
> +  structure to configure a vchan for data transfers between any two DMA devices.

-- 
Regards,
Vladimir

