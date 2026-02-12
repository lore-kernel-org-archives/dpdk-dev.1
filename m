Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AAEEB4917
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C37E14027A;
	Thu, 12 Feb 2026 13:14:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 29A6740268;
 Thu, 12 Feb 2026 13:14:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770898495; x=1802434495;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GhU/iIDtjI/m8wPPnNIY3HmYQkBVMYWMQbZqvuhATGk=;
 b=Uc3H7yTU9iEjVosJPzeb0yaC951M9Xz/k1oWVS597bxv4VaeC7ia5p5Q
 W3qjKkkMSBqj+SSq6RXI/2vZTmWzA/6MNx/KjLPPyv3a4t2I6kUn6nYIq
 d9D4EyshIIVcFhHhzX13JnzQNyiZt5DQGmGd3A8C38xHcoYuHD1Vh+B/T
 YN4s/5UusddFJ3dns7XCr4gFs8mkiQRMQX48yuY13oOEpTpHpTek7cCqg
 VKVkQvxFyVpHrIbcaEYHW+iUAAE1KgyZKHWyZZ6ePu4ZeN1vlccX+Cn3W
 859tx728XL0cPe4lKh5a5kaClLGTRzLHK+VlW8uTX0lz74zzlO3UzZ2h7 g==;
X-CSE-ConnectionGUID: 5VERpUuwTh2TFaJEt+GCww==
X-CSE-MsgGUID: uggQdZmdRa64M1kZ2ehYRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75911765"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="75911765"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:14:54 -0800
X-CSE-ConnectionGUID: 6NBlmiDBSyKERzzBsHHbqw==
X-CSE-MsgGUID: gjeA28zLSUKjuzn44KiBeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="212690055"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:14:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:14:53 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 04:14:53 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:14:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3O73W6Yc22auRrNindTvdExW8K7Yy9X5LnbcnZdIqgqoCRr2Kw4WELgP0zfxI5D6NRrtT4/tFcmdAgNcPVIcRwsS6iOyZnqohj89iIcJDZCSkV0UiOwM6ke8XI5DTweo/mzIFJKO2VHzzBPHICzCNvLNaoKAg/qRhtvUMwoemMjgmzJPFBWdLOBCJINwoZvAXx8APsCYNjD4EJbDu8XJXp//VjNrVUAF93deqPnhk84FWLmkFomK18diPEx45QkH0NuoHDjCFePFp9yFvuO9r9UI4LOlsSK5IlEFaa5FyRl5OhS1Pf9heH9QEHweGUaDQkkwI25jHKCZFaTY5jKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1U8GCWvUAj2T6bEntlUL+e6t7LDlrljqzctF4rGMfE=;
 b=Dp3VJqWoEW7CLvAS8f0fvXjNyLIPHzAxweltlZYczEsDInXdEBADXgHfgpmA6TOe2BcERZ/KeWNNWfAv3ttJG6l/RXAnb4DJSlS3PmZIdD/WHeW95w5J0TUuYA47Fhr/IU2QqD4ntGLzT+INIIAjbPkwRpJYbF6Fpszo04f7JCWJiucBkBAdnZWxwP515zWhdWm5km+pQJ8QuXugpiCUkIpAR9Gc3Ze3EpVJkhXPYQf45HMOPLXtCuOu1E3MdwZznQP0IwAewmeNXkzRBUcEy34bSJJuuLfi6t9XLhRLzOMR6jXofTOKZ97lK5XNEGjBYE469UnVNW+MgNEPPHh2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB9496.namprd11.prod.outlook.com (2603:10b6:208:5b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 12:14:51 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 12:14:51 +0000
Message-ID: <ac8695df-566e-4a15-84be-d18094380c9a@intel.com>
Date: Thu, 12 Feb 2026 13:14:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/35] net/intel: fix memory leak on TX queue setup
 failure
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Praveen Shetty <praveen.shetty@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Mingxia Liu <mingxia.liu@intel.com>, Beilei Xing
 <beilei.xing@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-3-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260211181309.2838042-3-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0017.eurprd08.prod.outlook.com (2603:10a6:8::30)
 To DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cb0ed5-51ad-440f-752d-08de6a3052e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z05ja29kTHdoSkUxbE1jajVRc25UTDNOR3lSbGJ3NlJsTkJHbkRuV2hsSEV3?=
 =?utf-8?B?TFR3bmRGa3pmL0djSXZYakRhVVpjY3VFdExzekJwcEFxbDBleEZ5YTlnZUdB?=
 =?utf-8?B?a1FaZjZVQWR4V05YZDkxcXdTZDArKzNTR3AyTkF6dzh4UjRVeDJYd1h3ZUgv?=
 =?utf-8?B?d1VhajhEWG9BVEF0WS9JZUYydVgwanloU1huQ0Erdi9RaDNJaHRGcmdTY1R6?=
 =?utf-8?B?alFRU2cwVk4yTk1qb0hYRmQxV3pidEhIMFY0YTJteEo3VytsQ3VHbVJtOHZB?=
 =?utf-8?B?bDNYdlplbEJ6WGRhNWFKcE5Sa1Zna3RuMDFjbTk1dys0Q1JuSU9ia3dldFVY?=
 =?utf-8?B?ak0ybUpmQ3FyOWd6YmtncDFTUVBMcnJjYXhxNm4raWZvU245a1RqNjBNU1FV?=
 =?utf-8?B?MHczbFh5dEY4dHFtdi90Vmp2bk0vZ1V1MXBWZDc3UnYrZS9rNFRkemdKQzJ2?=
 =?utf-8?B?dU1oZDd1RmtZS0x4c3FscEpkc1IxTEZaMEFRR1FpbnJLNVpUOUFJUG95a0Fm?=
 =?utf-8?B?eHkrMlBOanJsMFpwWk10MzVpS1QrbVgzc2dzeHM4cUI2cjlvRnEzRGY0QUFE?=
 =?utf-8?B?TVpQaE1KSmdSdE5NL1poRitEaWIwY244UDBCM2xhbDBXdTZCSTBaZDQzWXBQ?=
 =?utf-8?B?Sk5sSHJZRi9mWEFjdkRDR0ZvYklwbFhPUFVFRWJFYTE2VFE5YVpIQ1c2ZW9h?=
 =?utf-8?B?aHgyRWlkU2dCVk44OFdhQmw3TGpqb0xrSVRpVWg4cVdSRS9kWGNVVjZZYzlz?=
 =?utf-8?B?b2xPUUR3RmhaUXZSS3NNYVVJK2pTcmJQa1pCemthRGZUSGFzYkREYU1Kbjds?=
 =?utf-8?B?aVdEUVZCays1TEQxYjZEandYZFprU3dhQlErU210eHc2WWlyZ0s4SFdremNV?=
 =?utf-8?B?TVVlZGE0WlhSNUpBZUpLU0NXbjIzeTh2dlVqbW8ybURpVGdEdEE3ajIzV3dH?=
 =?utf-8?B?TUR2Ly8zekM3WTFwRStuUHBrVkg5QTRFdWdQdmx0MDdSOG8wZG0rRGhlVVVw?=
 =?utf-8?B?MEtCd2hZMU5uVk15S2E1dU1Gd3gvUUFvUjU2S2dDbEVQRWpEREZqQWErVklm?=
 =?utf-8?B?VUwwdlQ1Yk12TUNjWHpkcXBRZ2FmNnJiN01ORmx5UHpWRG56MmRHZ2E5T3hv?=
 =?utf-8?B?Ym5UQ3ozWStjdmhoSVBrSVFDaXZQZW1sR1ArVW85NXpjOGt2U1hQM1ZYYmNn?=
 =?utf-8?B?QzhEci91bDBtMXN4ZUJZVXFHUDlJLzBSRzVRb1BhWXF1UHlaK2lBVjdNSUg2?=
 =?utf-8?B?VWROSG1RcHk4ZkFudjdkWVhKR0pONkppZ3BBdXVvdlZDWVM5UUtBQzFzZnZW?=
 =?utf-8?B?YSsyNlZFeDNIYVJndW9DWU9HaloxUFY1NTQra2R5MWFUUHFFQmVuVGVoUEQ5?=
 =?utf-8?B?Tk8xQlkvREVwYm9VTjhmN3h3TWZObEp2THNwWWJIdVVNeVRvWThOekp1VjQw?=
 =?utf-8?B?djU5SmxlT1lwU2dUSXVoMmJTa1lVb1VoSTArME1DVnpwcm91TmNUOUE1Y1NH?=
 =?utf-8?B?RU1hYkYyQ1BQRGtNbVNkaTU4eUNoaTZUZ0tPVWJkU25WNk8vbk0wbUxsRTZz?=
 =?utf-8?B?MDM1am9rOHBUOGtXa3A2cWN2T3Y4U2RKWnhwa203Z3dzcnN6c2hnY0dxZEtM?=
 =?utf-8?B?bktyNVdlVzI1NllFVkdvbCtXTWh3c3lCb1YzSy9ncjNkVGxsTzdiTkgvZW1W?=
 =?utf-8?B?WnlqcndRS21qRTVvVkxtcTE0UHQ5M0JnN0NqU0xTMFh1cDBuZjZYU0pXM1JD?=
 =?utf-8?B?MlltSzhaa2h6ZlFHb3hQUExqOS93WmhuaHNyWkV3RVFYdnJUVWJaYVRKMzNB?=
 =?utf-8?B?T2M4Ukd6bHB1ai9kNDROZVB5V3IwYzFVY1ZWM2FTUmJhTXovUmpMTm1ZQUU0?=
 =?utf-8?B?WE9TdG1IQWxCMW5KUDN4RUt2V2JBRUpQYklDVlMvY0Z5OERCd21EVXpGc0Ix?=
 =?utf-8?B?UTllVHlNMmRpangzdlhwUFNabG1hTC9GM01rTW10R0NNbHlJNlZxaUltYXJG?=
 =?utf-8?B?N0k2M2tIU2orY203b0xwR0tlUHpVZHhRWC9tQ0drOVpRcUhFYVRJY2pHaW4r?=
 =?utf-8?B?dXVnVlgzMXAvUTBBSjFPVEprWjUwWW1kRmM3ZUh0Qk01YXFlVU5DNGR1STA0?=
 =?utf-8?Q?TypI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OURGWjFaZDBGeHpwS1B3YXFsdGN1NWdPRGRHYlBmR1hLSDRsN3JUZlQ1dTZr?=
 =?utf-8?B?U1ZaZTQ2YzlFR0JuVUo5M0FlN1pnL2FIb1dCYjVDbWc2YnAwb2dpYWZvbmNX?=
 =?utf-8?B?c3A3TTIwMFNRVTJyOWtnOWgxdlM2Wm9mL3VEYlNVbVlWdjRFU2sxZU1qem5h?=
 =?utf-8?B?bmJxcUxTZjduRnd6SldCeEdsNklxb1VFak9rYnV1bEZqenlLNCtMUWZ6WWI1?=
 =?utf-8?B?YzcxVUFibmJ4eDE4VXZBajYxZS8rTDA4U0lPWGJha21UTEo0cG9LZm4vY2Fh?=
 =?utf-8?B?OHhmSWhENjMyeWpYTVVSc1BEZ0FONlJUelBhamtRK1gvM1Z6WEl6Rm1FL0lt?=
 =?utf-8?B?RGZXOTcrOHJmYXc2Q2l2ZWZEVzBLemlRWUZkdkJaZm5RTVlXNnpDWnpLRUVj?=
 =?utf-8?B?cnZMNXRQMnFZZlBLd1BvN0xPeXJjMFBXOEJtQWN6SndXVkMvc2RSSzVlSVJr?=
 =?utf-8?B?R2tuMkpRS3ZZait4SlNhNzh0aVVMenVTNjI1TUxZdkJETzViNTluN1hzemhI?=
 =?utf-8?B?SnBlWUFCZWYvT2QvTHRSSkpuWUtMRzBPOHFYcWwzT0xMYVRBR2cxT0xpNkFY?=
 =?utf-8?B?NWJ1Wm5ML1hEWllRMVkrNCtwdWR0TVllVFVSMWU0aUZtbTYyb3hneWp1RGtp?=
 =?utf-8?B?WjF2cDFFa1RZc0dMSG9Zbk9ZRVFiYk0zRkRRN0E2STBDY2o3S2dvQWVBczdZ?=
 =?utf-8?B?WUcvcjlnNEdrSGdJYjVXU0FmTzhHS1NnaXdnK3M1MTFzT3NBRGV2eDVPalNj?=
 =?utf-8?B?bkFkbWlnOUpmYjkvejFRVllLY0E2Sy9iNDR2M0xLT29lWjdVU1p6bkltS2Vm?=
 =?utf-8?B?Y3k3RHJaWFVCT2tHL291b0JzUjZEY2NyME1VdWFackN0dmNxQTJjN2lsZzNs?=
 =?utf-8?B?cENFajZEbkl1K1hreDMvSk0wUklFYkhzSXczbE1ZOFBvckNpR1ZrMkNFdExk?=
 =?utf-8?B?aENUQlFaQXhteSsvb2VVcWY4MmZwMTlmVDhCNEJGbDErUGk5TEZKa2FKSXdV?=
 =?utf-8?B?WGxvS1ZranpmQUhRZGVOZjBIaEFvTEtQK3JvL3E3OGVSbzFpeGtGOVNpTVNx?=
 =?utf-8?B?SmsxZXJycFRXMW9jbHR4RlNMV2tvT2I4eExLS0M2cVFnR1Ribm9kblJvTmR6?=
 =?utf-8?B?eDUvM0JzdGxrcG1UeGsvdDljMTFZQkNVSlM2ZUFpMWl1RXdOL3VqTkF2a1BP?=
 =?utf-8?B?dXlyTmVnS2RCT0FMZzdzNlQxRW5QRWVJRGk5NHNWeW1hTVFuc3FRS0N5Nkgr?=
 =?utf-8?B?UXpadndoZGlsL21CRzlIem1JRUp5TnIrYUNGb3ZrTjMrTVQwVlVSdFhBdXdV?=
 =?utf-8?B?NGZYMVl4K1BwS1Z1ejV4L3drSWZ1TVE2OG11MzJiaDJqTFJJalJZTU52YWhB?=
 =?utf-8?B?YUQzeWtKbDMxcHNjZFBuaCt3a0V2c1piQjYya2FzMXdrQnlLaVNOSGYwT1Ew?=
 =?utf-8?B?WGxXZTRJRC9SZTRqWDNzUTBqclFZZFh4OVhEMEpzMEh3TmRuelB3M1loc0hJ?=
 =?utf-8?B?cGlCYjJ1d2lYNXgzMzNQRDR0ejQxTFRZYzRubUtDWEdEYmV5OG1UZmdlVkQz?=
 =?utf-8?B?TnAxbHc5S1llR0x0UitkaU43MjVTUVYzbHhRZ3J4SjdLUWtWV01IZVpSZ0lP?=
 =?utf-8?B?S2wwVmN3dk1kWkhHdnNwR2NQa2hPc2FlQkFmVDVrNGNpUzZRVkNPUzRyMk5l?=
 =?utf-8?B?ejdpbUxMWmV6VXpKaEdpdHlXaFZiTHlTcmFBQkFaeUIyeStieFRlcVEycGdW?=
 =?utf-8?B?MVJvV3RkekdXUllIMWlGeGV3cklDUzBHUUpjRnB6L1cxWjhqelBPQ3hDbVd6?=
 =?utf-8?B?NnpvSXpMUFFrMjc4N2tZd0M4SEpGKzM2YUd6VFdWYlZVcEZiUElUS3drdzFI?=
 =?utf-8?B?QW8xWmt5bWxldkhXa2dmbVUyOUlWcUtSWVRSM29BWUxvWXZNWHRnUHRUTjlp?=
 =?utf-8?B?U0s2S0x2QjR4N0hwSy9icEttWmdkVERQelowbDFxb003anJaMi9rWjIvc1p1?=
 =?utf-8?B?MkRFekpzenlaR2tnekppMEQwRGlQMFNxQ3pLdEVwdHpsZ1huaHR5MzJLNW5k?=
 =?utf-8?B?b0x0Y0xTMWVSRnprLytLVGxlREZ4VDlKMnlMUDdFcEJSdVZFc2wxM1VMSTFq?=
 =?utf-8?B?elRnanJOdTVSalh2Q2ZjaFY4RWg4Qys1MytCU2Y1K00vTzNDdkN2ekZLTjhx?=
 =?utf-8?B?ekNFalBWY0tzeFllZjdlNmFqcW51U0xWQytYVFQ1SGVuZDhkMmljaU5SWmFu?=
 =?utf-8?B?NHpoMXFETHk3bU5RQ01GNWM3NUZHenJOcEpTVTFwSTBlcDdNSjhmWGsvZUh1?=
 =?utf-8?B?TENRbnBNMHEvcEl3M0EyZThjN1ZPU2VWQ1JzOXBienhDNmh2R29Td0lFSloy?=
 =?utf-8?Q?JvtF1ijRNNz5bsJI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cb0ed5-51ad-440f-752d-08de6a3052e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:14:51.7201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVYs3IWjHsmH3w2l9+HBu8XVVl3noz4u1UiP6zckenHz9tXhxoZGS5JXKagkfl8dneZAXDfUFd4lThI3Vsb2XEuZrq4j26bg3SX8D8tg3T4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9496
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

On 2/11/2026 7:12 PM, Bruce Richardson wrote:
> When TX queue setup fails after sw_ring allocation but during
> completion queue setup, the allocated sw_ring memory is not freed,
> causing a memory leak.
> 
> This patch adds the missing rte_free() call in the error path for
> both cpfl and idpf drivers to properly clean up sw_ring before
> returning from the function.
> 
> Fixes: 6c2d333cd418 ("net/cpfl: support Tx queue setup")
> Fixes: c008a5e740bd ("common/idpf: add queue setup/release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
