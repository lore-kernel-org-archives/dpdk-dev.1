Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FACCCCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 12:04:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F8114029A;
	Wed, 29 Oct 2025 13:04:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9639340288
 for <dev@dpdk.org>; Wed, 29 Oct 2025 13:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761739449; x=1793275449;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AQaUjxdXMnQnCg//SJR7Q9xiSf32tsxIfNp2dgDyyAM=;
 b=Otyyb7zlBVpjiL21B7qmnOvnloaN45H0hrgK8EY7QpOHIKaUl6/uE5gb
 rGzH0z+rwjHcmpwrRsKrgXBMthgISiQaGuzR+n0gcB8OvgZlU48pJE5+n
 I3zu0QmyREjfGnTJJFJTUouI6s6JsXdQ7kUrE9Kq4um16LTw+qMOYcjuQ
 juksx6OODAoRYECb5HV7tvdfA8st1wRf5hazOmzcgfe5WQjT05a3iimJM
 mgnGrqHOrmVrIg9LyBvjt+t+2/LbXEN/4w37+JoWBi5BiN3CaVAsLqzJ4
 H9VuBdBM4sCDzBoMe3hYj+qAHrv+U0EkTRE2E1189SOgNRc6bFmCzoMB+ A==;
X-CSE-ConnectionGUID: zlSfwrJwTyS+xWgKGxQ8RQ==
X-CSE-MsgGUID: J7H+PWj1SVOSPY8Krd2Cvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63953421"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="63953421"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 05:04:07 -0700
X-CSE-ConnectionGUID: d5DlKBKSR2uaEPi9KFhHxg==
X-CSE-MsgGUID: YouDOLnkSOaIb+ufh/k50g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="216301947"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 05:04:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 05:04:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 05:04:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 05:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OezCunvYhWa1knr4wHturIdsN4WrEZGOFxmA74qK7HeBRjIs7AUPytzcNO/LDE6y7WgEdEqOQZLaQ+g13SRAyqGS0lFzNSiU7BJh3PlARiKOgiDJpQfNGypsISfdOzGWGjp7ubZIZJ1C4G6aLtN9HhPWJcRxnXL007ja1Aywo2jP0awlAZaB/ig6MkAy/IXTLhAO735nR3y7dpW4SVQhza7VJldqsnq4ecd5ibdKbPFtk13dplTOQGbHX+xCo0zMpL/PYvrc2i/20EgPjKHDbWKxgX2B0d/gGhSC+7qy/fVFlKMt3Us7tjs9O9wzvfb1ATwgom9s2EtfRrnKJGDsKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+0NI9kVMyhxvPnf/ZkE5XCdL0VURQAF+ZGGHNujuFE=;
 b=k3aO02NnOSqauuszHpEwKWfSNytcMUrbPCWaBemV9VI9x22GU+ewlnYuZ0HKfCWg/C7TzjmnvhrgCO9TYl2AR4qy3rw39I6PzQJ0J7aBGUplr5yz5WQ5EWYgV/hSQnA8A0Y2ZFsf3L4EKbyStVeH51kwFgeNH215oEbZpZt5MAIribFM4XbBontig2JyFTIudgq1fQKmqUSq0VyR/83mhAt0VYSg2dobWndXteJvzPBBjWGwuC9yzirtj9zV+0qBlzhF/ofW9avs3gZ60i5C+dUviUItfSf++JmAMiftvvLtB2ZMX11EFyjTYKNUZmGDFv7Vw9Z26jnMRWie1HAXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM3PPF1939049CF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f0b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 12:04:02 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 12:04:02 +0000
Message-ID: <58ed8304-fecc-44c2-8926-97d9acfc9df3@intel.com>
Date: Wed, 29 Oct 2025 13:03:57 +0100
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mltQQVRDSCB2MSAwLzhdIFN1cHBvcnQgVkZJTyBj?=
 =?UTF-8?Q?dev_API_in_DPDK?=
To: Dimon <dimon.zhao@nebula-matrix.com>, dev <dev@dpdk.org>
CC: Sam <sam.chen@nebula-matrix.com>, Alvin <alvin.wang@nebula-matrix.com>
References: <cover.1761669438.git.anatoly.burakov@intel.com>
 <8659bfe9-b12c-4263-a130-01fdbb76d7fe.dimon.zhao@nebula-matrix.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <8659bfe9-b12c-4263-a130-01fdbb76d7fe.dimon.zhao@nebula-matrix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0214.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM3PPF1939049CF:EE_
X-MS-Office365-Filtering-Correlation-Id: 203a018a-7374-4552-59fa-08de16e34021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkhMMjNUZkxENjIvZTlCbGs0RGdDU0NWZ3ZKMmJvaFRUSTdQOWFXUWJtaXR2?=
 =?utf-8?B?THpqOWcxeEU4OUtBOHhZOCsrTnlhaVNONkd2WWlNcFFMVmVqR1JGVmczbUc0?=
 =?utf-8?B?YnpJV2dnNFVWaW03VkN5RVM2VWJQOUFwQldMY2p6NWVQcDhhNWZKbmtEeDVR?=
 =?utf-8?B?SUh2SFFKVEdSTWxvK0JpRldrUCt5alh5c2hma2xrMXlnTGdiUDRJWEpheEhq?=
 =?utf-8?B?UkFNcDBueG96bVhDQ09DTnM5SVZ3L1NLY2Nra3l1NDlhVjVQTjNpNE1STEND?=
 =?utf-8?B?RnR5Z2k4eFYxTG5GbUV0Z29uYXdOT2cyb3ZwMm1QakhsdElQcWxEREpkenJ0?=
 =?utf-8?B?WnVZSVRFVUt4YlB6dm1zNEI2T2syVGJQcTBZSWtsSkViVVc4dmRDWjhnVE15?=
 =?utf-8?B?Qk41anIyekdpMnZPS1BCcTFCb0FPZ0hpOVhEOWR4WTMycWJhWUY1TEQ2dmRv?=
 =?utf-8?B?ZUNNR1pDZmZteGJrcGtMN1FaMlBMUXRwQ3hWZmdzRFBIQTVjY1cydVRIaDNY?=
 =?utf-8?B?R1JiN21YaVZUV1lmR0gyYjA0NkVlQ0NVRGN0RHFLN0lIL3p3UWRNelJ3My8y?=
 =?utf-8?B?M0Q0RHFkckxWRjcvQm5tZG9BaGl1UzNQWWhmNXlGQi9uSWp6aTluaGp5c0VD?=
 =?utf-8?B?YU0vZnZuRFU3aHhHRjVXaW1jOHpsMU1sUzl1TndYWXIxTE1oWCtpTVVDS3Zw?=
 =?utf-8?B?aXdvWHl1TjBVOHJ5ZE1QSFpzSVFrYnVKVXNzZFhoTXFoaEQrQTBLZXNLdFhy?=
 =?utf-8?B?b2ZLZFlvUkMrMlBTak1aeTJtR1hlSE5xZHFpSWhMOUJpS2w2ZnRtL1Z5RW55?=
 =?utf-8?B?c2x1S0EyTmNreEZ6NEhTOUVYVEljN2wrdnJzK3dGREw2MU9tRnpwTVozalhU?=
 =?utf-8?B?QkFCcjJvc2Uyb1F6NFAyUE9xZlQwdU8rMVpRbFZ0cUdFd1V0d1NsUWY3QWcy?=
 =?utf-8?B?WkNyWnBXZG0wZjZZMEdwcDM4OWVmc294WlBhbklzME5Ua2paMEcxNTNGK2t1?=
 =?utf-8?B?ZVZWelpBaWtNb3ZJVmtlNWdQby9lMHhjUU1VeTAyRDB2aDFFRHBYQ05MZ0Rh?=
 =?utf-8?B?N3R0c0Jzd0I0SWZVTVp5akFGMWdJdFlFNEMxRklqbHhjL24vWTlkV1NkTXEx?=
 =?utf-8?B?TTl5ZXdhejRRajdyWGJYZDJLeER3dzdFd0prbjhFMUR1aC9SeE5vN2NpSWZE?=
 =?utf-8?B?ekpWaVVQRVU1TGprZ2w1VU1lMU5kN1BEazdDcWJYZ1VJaUV6NUNWdWVhZDVN?=
 =?utf-8?B?MjZrR2NRT1NrTFUwMG9iWWJwN0FTYTlBaEZwODVacXQ0eUtsY1FCN3RyaEFp?=
 =?utf-8?B?UTlkcjFEYkZ2Y2pTeVU5WHFhMHV2SXM4ZlNNZGFhZ1lMZk1IQ0l2Wm9hVkFG?=
 =?utf-8?B?VEt0Q05CTHVpaHBSSXk4THd2eTlPUU1Ba1VNWlVzRnlUZGFvZk1Sb2J4RDlS?=
 =?utf-8?B?U2ZIaDBMU3R6UUZRMFE2K0dxZmdXbmZUN2lrSUZOazZaMWxPa3plYnEvOFJG?=
 =?utf-8?B?UXYxYVkwZFduMFVLR2dqY2NDVG94S2JkZ3lxdm9HTmIxY2dHM2tpcTRrd0ZN?=
 =?utf-8?B?TG8wMUVFMXVCZjVnMWwwRXV6VG5FeHVXMFZ3N3gzUDZIM001Zlh2OExXOUMz?=
 =?utf-8?B?eHJrc3g2YXRERmtGNmdjWnA2YVU1RGZ4NVdEeE0wYllOQThhUHYwaHVjaFBl?=
 =?utf-8?B?RU1IcWs3SzhORUZXaEFyQnRvKzNOWHBiT3RhMS9DWlZSbFp3NnhveFA0VlQw?=
 =?utf-8?B?SWV5UDlGWjB0b0pGdXNMb0J5VkNTZVlwVFdqdkxiNkxLaUdVRXdwL3Zpd3A0?=
 =?utf-8?B?V2Z0SDR3STJXUzF1RE5BaEkySFVLeFVtZVk4Sy9peEhFZGRuaTBBd0NUKy9p?=
 =?utf-8?B?REFxWXQ3SktOeDFmQ3dkeHdyS25mVWx5ajlBT1R0cEJoMFlJV0krVUlVNGlU?=
 =?utf-8?Q?J+2ujoV6ip90virtGEEoXY2ryPrSF5yV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QitWUGw0Z0p1SEYvRTVHU3QwOGZiWlJQeEJhYU9USyt3a3ZIdFZYSWYzcFZR?=
 =?utf-8?B?MnlURnRBRHpBRzhaeUxKQVpwY1JkZStKUTZ0Q1RDd3ppSzc2RVBvVHkxVmR5?=
 =?utf-8?B?U3EzbXRWK004cDNPY0hSbGhOVUV5MDA0ZXZhcXVJd0FSNWswVnc1RWo4aWhF?=
 =?utf-8?B?clJJSmxvNk81emlPd29nVHVta3JibkRRc1o2bnp5UEJuZ2VlRmZ2SVFjdHg1?=
 =?utf-8?B?aHlRZll4MHZHaGMvNW1mQUl1SWMrUVBFU1NlZVg3OFNoM2N1VlFnZW4zZXZD?=
 =?utf-8?B?ZTg4VEVHZzN1Z2pyNmFpUzViblBDeUVISGFLKzRpNzBwck1sSk1FZUxFNW96?=
 =?utf-8?B?S2Y3Zk9mcndmOUMzcGYrV21yQmk1Qmc1STIxUWFNY2hHOEpKL05lODVTNktu?=
 =?utf-8?B?ZTI1eG04R20xU0V6Zk8zMmM4NnVvbHlJYVhwRm1KbS83bXpORm4wdWIzUi92?=
 =?utf-8?B?aHJCUDFocldYMHpjSnBSWUVkOGRTRkp2UVJVNVJ3TXkxL1lud0V3N2VnYnZO?=
 =?utf-8?B?cy9IK3ZFaDJWclhSbmptUGI5QllvUkJOZ1hFTnB4cmpFY0xuZHNKbmsyV3Rk?=
 =?utf-8?B?anBiUmIrZlF3dk54elI2akV3NnlhL0phN2hhQzlZOEtGbTVFVzE4K2xjaHNH?=
 =?utf-8?B?NTY5OWlUejhFdDNKYzQ0ajRjNjd4MXRjNGxKck42YlZVczVXOHpHZVVMcXNH?=
 =?utf-8?B?NjBhOG5ZWXNCamY3UklRV0FzOVNLbmNnQTRwR0dwV3ZZNEhHaC9zdndxWjJJ?=
 =?utf-8?B?UjZEUkxXUVczN3pKRWVpUEFGRzNaWTM5VThpRm1yRHp2K3U3SFNsS0hIaElP?=
 =?utf-8?B?dE0yNldpQ0tKVkpuSy9NdDdxNlA5VzBzaXFNa3ZUV2lFSE9QQzNsaHdTdEdm?=
 =?utf-8?B?ZzBuMUJWN21QQ29zMi9lTEtIWlptYWlkeU9pc1dwRktVZWRVQXorbHY3SWwx?=
 =?utf-8?B?VUYwTTlwbFFUT29xelY0RjM4ZW50N1BCVGFTTGJGbm5Nc2dTZUZrMkNveFAv?=
 =?utf-8?B?TFlUaEptcnM0UXMzZFZ1d0YxcUU2VExpQ011VS9CdDZEZitZWk0zKzRKazRX?=
 =?utf-8?B?WmNlMlFnQnVMd3RXQ3Y2YUEvTjFpc0dNc2NKdnE2QWd0eVZPaXMvZTVqUGlM?=
 =?utf-8?B?MEpvT3k4ek9ZYno4RXZiYzRJU3p1TDkyeTBhQ2NZN3JxQjZCRlRXNW40QnEw?=
 =?utf-8?B?OE5iTzNmUW5RWE9QRW1HSHQ4Z0duNHRXbmZXUUtaeDVjTHJHeFN3SWx3VTB5?=
 =?utf-8?B?a3RuUUV1YUJnLzRRZFBBRTRUSm5hSUVYOUk1RjlGUmI5UHpTS2o4SjVEWUE0?=
 =?utf-8?B?SWNDamdMRVIyTGJlQjdOV0U3ZTNkVGZSaFc2alB3b3pQOTg0aVRQeWpSOVEz?=
 =?utf-8?B?ckZKeUxteU5PWGdqQzJ4TVE3UytlVm8rb3NmNUwzaVVZa1dMemVVOTJJTmc0?=
 =?utf-8?B?SUlqOC80TFRFMWw4TFU1c1BzR0NpVFNNV0xCbVJ5Q0tYSktTcGxvQ2t0WWd6?=
 =?utf-8?B?VzhLQXdrb3dERVlPNXVCckY3WkpEdFJPMHYycXdheDRSNkw3eTJhOFlDa0dD?=
 =?utf-8?B?cnlHRmRsUm1sRWhXVjlzZXhpS2ZvcUphaEtmV0xvNU9EWTloUHBiQUE3ckMy?=
 =?utf-8?B?WER0OGd5Q3NhR2I0NkV6ak9oTXJwcEN3TkNJUzg4Z3U5d2NIL1UxZWNYVjlM?=
 =?utf-8?B?dC9FNzk5VHY0Mk9iSUlhOHBiYm5wcGFzWXhYZWl0K08ydnppQUJuNUoxUGlM?=
 =?utf-8?B?eEUyTGRZbDJIQlJQUmNaZHUvU3BvVVo1UXMweGpFbzBaRGVHWlRXVXJhUHBz?=
 =?utf-8?B?K2tNcXZtdmpJT2N4eENhdkFOUjRGTzNmeUNuclNJOWFKZGhhYjZsdlZtdUti?=
 =?utf-8?B?NGRLOFpyVksxRUZNUHdLWXZIMkpZZWJXOTVCTUhhLzVHQm5hdVFualFEbW9H?=
 =?utf-8?B?Y052Y01NalJCV2lVZ0V2Q0VvR2xiYVhiV1h6cnV4dXY3RkRYOXdYNkVwdUs3?=
 =?utf-8?B?M3lwL2FBcnAraHhDemFhSU1uU0RzMFJucVdnR0JFeW5WRGsxQlUyc1g1ZE84?=
 =?utf-8?B?NU1nUFNlZkhrMy80YkVQcWQwd3FJZnRYNldhTHIwVkMxMkVxdko2ZGZxSlV2?=
 =?utf-8?B?VTJESUVvWGFJdWFUL2lPc00zYkxPVmFJRXlVLy9UQko5a1lKSjZ0bE1RRkdx?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 203a018a-7374-4552-59fa-08de16e34021
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 12:04:02.5640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrTJ0EuiRhjLLt2Cizaa7VVj63071/V5W8Khrf2hvEsbi/UYi46fh/qRCZjYGuNmXHKfTFLWHjbKzeUyriFIx90KAkB4ms0jzKKbn7nfSnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1939049CF
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

On 10/29/2025 10:50 AM, Dimon wrote:
> Hello Anatoly,
> 
> I tested this patch series and encountered the same error on both Intel 
> E810 and Nebulamatrix NICs, as follows:
> 
> I used GDB for tracing and debugging, and found that there might be a 
> slight issue with the code of vfio_group_assign_device function? I won't 
> insist.
> 
> (1) vfio_device_create will alloc a vfio_device dev
> 
> (2) vfio_group_setup_device_fd will set dev->fd
> 
> (3) DEVICE_FOREACH_ACTIVE(cfg, idev) iterates through each idev->fd in 
> cfg to check if it is the same as dev->fd, but at this point idev is 
> actually dev.
> 
>       So it will report the error "Device 0000:08:00.0 already assigned 
> to this container".
> 

Hi Dimon,

Thank you for testing it! You're correct, of course. I shall fix it in 
v2, along with other planned fixes.

-- 
Thanks,
Anatoly
