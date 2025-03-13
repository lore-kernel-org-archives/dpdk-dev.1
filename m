Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C814C282EC
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 16:08:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 774F941141;
	Thu, 13 Mar 2025 17:08:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5F74A40ED3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 17:08:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741882101; x=1773418101;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=KAvYTtptjViHotA2+IReesujuwFlNeEHpJBQpFzdkd0=;
 b=mC7dJ7airPCW3TbDn2dKrWGWvIvciFpx/L2QvMOgcTyUEFysdtDdaNDY
 XDQ2ytC+kxBouSYCm/CxzTes+3XQ+Wpw2R4WQhNfs+E3isq/8L9Q7XQUc
 SXWqv3zzNmNyioDjMKDQ6zklarOMUOB3yWdoSiwb+X/gK1Xp8LSyHmzLD
 esE2Wbf/FOlj81px4O4HVcqUtS7Rl1u1+1bgfF44e7kujAI5YMNKGLASG
 PRhKIJooJp6LQhmigUtBlI73rEq4I69M/GTlgct2MK8KtKEwFc9rn5TLl
 SkMrLXx1xk7xmF5nAh5OFqSA+cWJMW6aw6oHoY7ZMdK6D1sUCYUHVDbXK w==;
X-CSE-ConnectionGUID: mDm7nboyQUyU39nYVgDkSg==
X-CSE-MsgGUID: EbosbfYJQny5yJXF85yTDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42260062"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="42260062"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 09:08:20 -0700
X-CSE-ConnectionGUID: 2hRwX5pBTim0yMjtQfX3jg==
X-CSE-MsgGUID: 59rUTVXzSlO21Dz8etLkzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="121935725"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Mar 2025 09:08:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 09:08:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 09:08:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 09:08:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vzj05VfyYLuH/7ruJKerHQxlUOlKAvLN0zTzVnmWfw5ZCjA8Fb2kt0UtgXVaaxOXbmsyyst+wnT5LKuGKumfFMxevM8S4fFYRoQIdcllFOsL5n4ywuYQYRPkt02ESUbJAIJmfIKGzwUL5wu5w5G+f1HUtYV9QvUhABjJEbF6isRr0dCAplgY8P2G0A9Pm9k1QUNOV42rjeMV4xgbu3C7dwQYwlHGdjhTUClD9pIfRFVoLFfLQk+7Mdj67awqb4UV/KSP7JB9fo43m6EhMFhJSdEITN0JmELVBC5wXMbCdikIWjtHW26wbHOYSO0Fa38GgK4tsfvNiP6ldzCkeWgqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFiINdJ8aIZcgjIHB9201rNJ3TczlDrprid4rToWTFU=;
 b=nfze4vlaHpxlXAXs28A2ygQio27uINXgdYcKaCAoRKY20erFwCucTpBaoejDoNVT3DbKXiAbkHOsJ9wcTl2zx/0ZOf2zrbhezI9qChHvJmbXYON9AtdNkWUog5oEztyIWhQSuhGkxe5f2U3eMYZLcvnOh6PsyHYbKpBfh3ZDddIAuoXnL6+IYBNEVN1W+vmnaB5YQCalnmCZoPo7wHt9fnrvbetyUHeswqXjgaKks1ej1qCpd4MB3tfTipPEfoi24U9Tu6V50P2DLTArPnkcudiLcqrUjva4W/0Vv4QnCCkXz3gTULiO0MKx++b7gqTNZn2uBTqDgiqSv1AA8yN6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6747.namprd11.prod.outlook.com (2603:10b6:510:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 16:08:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 16:08:11 +0000
Date: Thu, 13 Mar 2025 16:08:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: David Marchand <david.marchand@redhat.com>, William Tu
 <u9012063@gmail.com>, <dev@dpdk.org>, <andremue@linux.microsoft.com>
Subject: Re: [PATCH] net/intel: remove unnecessary compiler flag for mingw
Message-ID: <Z9MC5rVDwDx0ICjO@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155458.1395709-1-bruce.richardson@intel.com>
 <CAJFAV8zAhG3U9h1A=UEu_eUjLBEV+FjuZffZg8+SwEcSuwN9ww@mail.gmail.com>
 <20250312091110.64b77903@hermes.local>
 <Z9LflQ-mQiuwC9ze@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9LflQ-mQiuwC9ze@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0324.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c24c7c-c816-414c-3d28-08dd6249409a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlFCbUdZSExaT1BUOWdqb2c1cUFPcTVCSXVrVVR1MW5pQnBZZ3l5aWtYUjVR?=
 =?utf-8?B?ei9Xc21vVzFmMS9zRHUybWtoajV3WG1IL21YN3poUDhDRkFzSkR3aTRoRTNH?=
 =?utf-8?B?d1R2NXZHdm5CV1pvVUtlb1pNWjFjZzZXc1RjUEg5RDNrT0Y0NmxuS1pSbmIv?=
 =?utf-8?B?QzdDbHRRNGFyc1VGQzdlMURlVm1nMk53OW5MeGJxd0pUalZWd2pHVDQxZ3pI?=
 =?utf-8?B?OWRzcDhTQTY4bXF4cmJpK1JnVGhRa1A3bktQeHFiUnNMZjV5VGphcDJSL2Fn?=
 =?utf-8?B?cXVXVzF3Z2UxalJTSDk3SHRvSldXTFdPWU1yTEFySGxCVHZRK3hBZnovMzVO?=
 =?utf-8?B?bzdmclRod3VSVUM4RzdSNzY5Ykl2K0dMaUhSWXh1b2JDRVlGSEJpakRvck5j?=
 =?utf-8?B?TW5TY3ZHTVFYd2IvZEhSTFhpZTFmajc5TS9idGttZXhvemczci9jWU8xb3N6?=
 =?utf-8?B?T0pNZmhVeURXcHl4UUpaYmllNTh6K01iMFNOWU9IQm80clByRk12ZmJSL3po?=
 =?utf-8?B?Qyt4eEdFUjdwaGpvcW5DMEJTWWpDL1hxTE5jRDlHMXlnZnRpMU1ob1d6L1Rx?=
 =?utf-8?B?RFNQa0JRcG41eGIyVFk5cSt2ejF5L2Nzb0xZMzNuWlNvdnZDWUdTRnhxT3Ro?=
 =?utf-8?B?L2RWcHJNYnJTUHUrRzZIaWJKZEthRXVMWGFzWVo4enBuZ1hVWFlKeld4U2s1?=
 =?utf-8?B?N3ZBbXpTVEgrVjJSTFlFa3lBVzRoVlYvcUlYc1JnYSszWFFhaEozZStpMUl4?=
 =?utf-8?B?TjY3RjNqbVhrTDdnR3VoMFZBS21EVGdnRC9CeVNTQzNvUmhLZXJPemVZUFJP?=
 =?utf-8?B?M0srczNQUlFxbVNJS00wdnpoQ0dkbWphWXhjbWNLeUQxd1RGSE5INVZrb1c0?=
 =?utf-8?B?NkFsN0tYYWE5dmIyQTU2NkZ1OTJPMVRqR1FrUHFSd241Sk0vczBoU1lNVW5r?=
 =?utf-8?B?VWJ2RG0rVnBFNENTM0VwNmExTERZUGxNVGluZTJHUi8ybGRnSTlCSzlRZ05a?=
 =?utf-8?B?SzRNUmdFWVBjMkNoMVU2NFNkRW5oSUdhREhpcVpZbm9yQmNzbXZhbTFOWHJh?=
 =?utf-8?B?K3FTU3krdldQWlFhVE9nQVB4TU5DZVRmbC9uZUNIbXU3SWc4LzdWOXZqNmVn?=
 =?utf-8?B?STdFTjhMeWpPNzA3aUNROWNlUC92ZlIyL2pHUWhqOG0xOUlZemNxOTVvaW5Z?=
 =?utf-8?B?S0hSQVJvMnhYbUlNN1VwbXJZcUpHbVg4Z2U5SzZWZm50bjE4WE5hWFhCczhR?=
 =?utf-8?B?UGk3d3lwMGw4dW9KK1BCOU9qVzVySjlLUVk1T2JYd2lLaW1Mbzlud1NqQS9x?=
 =?utf-8?B?b016WVIwMHRCbkRkT2NEYitReElyRXQ3ZlFlVkVXUTRna2l1OVh4eEcyMDFi?=
 =?utf-8?B?Qkpia1dhWE5mTXhIZ2dmM2NhZFJZencyd3JiWEdNYWR0eFAxS1VoRERPQzUw?=
 =?utf-8?B?d1JnNXlRaDBtMEw1bFlZdllCU1pzeVFmakNwbUpob0tVNzRHOFR6ZHlkU3VP?=
 =?utf-8?B?MGptSzkrYjhoMFJIUlJ5bGdHZ2J4NUNTWC9pVFdTSGFsT01sV2FsV3QxK29l?=
 =?utf-8?B?L09WN01pMFZXV1QrU0dsQzBzTXFFYjJIYkxVSG12WFpDTmhDTC9veHU4SmJ1?=
 =?utf-8?B?aVVPenNLaWU2T1IrWnk5OXYrTVlXWENIOGhZL29JNURjUStXMGpVL0c5cml3?=
 =?utf-8?B?Rm5DaExTeFFtQXRpOHBBdFBkekczaTV0UTg5NjBzVGRsTWpRaTJtb0NBd0Mw?=
 =?utf-8?B?ZWlEVkRGLzFPemNjVFpuNXhabjJrZ05sTFlDTmVPUm1kT1FTZytCcVpwWThH?=
 =?utf-8?B?TVozemxRMDZHdzVuWGpQZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVpVVkrVEVkNEJIQ25ZNmFiUFhiR1dGdWZVN3gxNk16NEZqcCt1MnA4TWNz?=
 =?utf-8?B?VW5jWVNyRUk0NG5TMmVVQXc2K0diRG5sd20wWkx4YzlxQnZMeUg5OTVxb2I1?=
 =?utf-8?B?Nis4eTNEUU5GbXpXN1FKQzN5K3AxSzBoMEhPWCs3eHhjakZSOVl2ZGFTcE85?=
 =?utf-8?B?SXo0NDA3R2gwOWVWbG5RQzZldVJhSkh6N0phMnYwaEowRjVCQk14YVYxUjJD?=
 =?utf-8?B?MEJpZGxSTS8xeEZxZ09WVmZ4RWNxMmtUT2FJQVVxUHN5VjBVWWdJbjZKSURw?=
 =?utf-8?B?K1JoOXozalc1YUJiRjZDVnc4Ynp0SG1pS3hha01pUWFVbHBYZXFpYzNia2Rl?=
 =?utf-8?B?dTRvMDNNUkdkMFZSdzZwRk1ScTVJKzZ5S1JVRlNOMW9lbFUxeUpMUU5PckhG?=
 =?utf-8?B?NFZ3d041NU1lM2lvS3oyb1o3bk5vNGNyVGNWcHhHMklqL2s2aElER0xRRmdq?=
 =?utf-8?B?R2dyWmpKWnZXb082S3ZzT082Y2NPaU1HNHdPVEVLcnFUM21UelRqc205bnlT?=
 =?utf-8?B?VzQwOS9FSUkwNTVOamp1WFBzNXdGS04rNFVVaGx4NU9sRGo1Sk5WVi9RZnFT?=
 =?utf-8?B?aGc3Z01wOGt6dFBVbm8zcFRRbmhvUDJMV3psMit0Z1VEZ0dMR0l4dU5SZllq?=
 =?utf-8?B?SzVJcmdXSC8wMmJWNEw4a1FlTGZ6VHZqQnNCRlhkQVdiWnVlNFF0SGVwbXpD?=
 =?utf-8?B?UkVVUkJIZ052V1JMVnhmcEt2Mm1iRlB4ek9WRXc3MVV3ckxZcG5hVTgyUzZ2?=
 =?utf-8?B?ekc0RUlJZzJiQU1YU1d6NGppZjZJeFY3YjBPb1htbng2WjlmYUFNQmhnKytZ?=
 =?utf-8?B?M0xBLy9PNVN2eGxaaWhTYm1ORUpwWE95VGZZeXkvNTRyQmkzYkVlVFB3VkND?=
 =?utf-8?B?enNYTkZhcWxQWGN4WjhqeWpHYzBCWXhNVDlRL01BdXd2WUcxZmVBeFdXV3lZ?=
 =?utf-8?B?dU5CRUYzM0NsbmZ4Y0s0Mk0xLy9LckVUOEl0d3RORUFpRUIyQ3FOelRHVS9q?=
 =?utf-8?B?MENuSmxsaElhdGhMaWJqZmdpVkdpK1d4MFdLZDBjSFB3ck9GVUJ1QTV3OVZp?=
 =?utf-8?B?NUdTVU1QdzBFRUNoQUpWZVVsWUVoWUZ4NnBaaEUrVXJhd1hoZGhteVVTb0Zj?=
 =?utf-8?B?Q3E4OWZoaXN2NWdmR1FIazRaNFdYelkvS0xLY0s0a1ZrQm94VXZJUmdGbTU2?=
 =?utf-8?B?c2JWaTRZNlpleHZWRDFyM1pTajJBdmlmMjdDcFRUVGhrbzFVQ25leC9qMU5K?=
 =?utf-8?B?NkhKSm9tNThjQVdTbERzcE9BYWpSc28wV1NOTjdmM2NxdlJTYUVSZFRhNXAr?=
 =?utf-8?B?MmNXenY2c09mUHdGT1BtQjZjSzU5N2xHY2pQeXVaa2d1am9Qb25xYWU1ek54?=
 =?utf-8?B?Qm0zYXU0eG52a2w4V0Noamk1MDZDeVZna2N5S0E2UGVQK09HcVNuN25NK2pO?=
 =?utf-8?B?UlRGVjlCeFIyMUVkUlM1QVJscDdURDVBVVh6U1JvdkNSenhSRTJHVXhSTU16?=
 =?utf-8?B?cE8xWHFaYmU2SGpEOU9MR1IzcVYyekRKTlZHNlNNbVB4K00wUlU2Um1JUGdM?=
 =?utf-8?B?cVBBMTdOcVBvaEg1VS85TXp3MkFhSmdCZzI2dzd1bkQrZzRsd0tKcFhkTGJ0?=
 =?utf-8?B?YnRMcnlpaWc2Snk5Q3poR3I0Wlo5NDRZeXlSNWMrRzZRc1FxV0lKYlZLekh3?=
 =?utf-8?B?WnM4aTRKbDczZklERmYrcURobS9SZG1GRlp0T0M4OXNCRVVPdUlRb2xnelFy?=
 =?utf-8?B?VUVsVm1RYXBVRTNLOUtLTUFnVXBqWGRiZm84dTM3UDkwWHh6Unp5YTMxSDYw?=
 =?utf-8?B?Z1JWVUVZMUFXbDBkejVYa3lidXhOZFFBM0gvREs0ZDlHUHVhZjloRDBCTzVY?=
 =?utf-8?B?cTNpaTg5eXJHM3cvUSt2QkdkT1FjOUJyQlVmZ25sZkkyZDMrdVU1dFk5Qml5?=
 =?utf-8?B?UTFXSFdDdUlpWHNSMXNIOENLdVQrNzJmZ2hZbGIydGxZa0h4bWFsVEtobXdY?=
 =?utf-8?B?STVuYzFLYXpOcXBlRGhXVGdZZ0hkZVhOb3RlUkdqREU1WFB4UDJNek9KRDhH?=
 =?utf-8?B?TjlJeFRtMTgxSWhkRTdvTTVYMnlPTTNKK1lBN1MxOXpRWVdIKzM2M3R3QTBB?=
 =?utf-8?B?SVV3bG1obE5SYzJNQ0FHcnNLaGlHK0F6bFRISG9QRU9jd01lWVpwU0Y5aFBu?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c24c7c-c816-414c-3d28-08dd6249409a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:08:11.5944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmKQ7AAnbOr5xsyaVl3NcEWqa5zrHU32B1tVrfIblN3wAAK1i8lAVBWEGW9dRtiMQonJRRTxd/Yzcr5ENK5Gs+BAsiHetHkRvi/HhDU4VuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6747
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

On Thu, Mar 13, 2025 at 01:37:25PM +0000, Bruce Richardson wrote:
> On Wed, Mar 12, 2025 at 09:11:10AM -0700, Stephen Hemminger wrote:
> > On Wed, 12 Mar 2025 16:58:49 +0100
> > David Marchand <david.marchand@redhat.com> wrote:
> > 
> > > On Wed, Mar 12, 2025 at 4:55 PM Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > There was an issue with building DPDK using mingw v8.1[1], which
> > > > required using the "-fno-asynchronous-unwind-tables" compiler flag when
> > > > building using the mingw compiler. However, recent versions of the
> > > > compiler no longer seem to need this flag, so remove it.
> > > >
> > > > [1] https://inbox.dpdk.org/dev/CAJFAV8z3qFhT9Vv5xOpLhi74BYAht2YCfL2ffLrmei4hfSG5jg@mail.gmail.com
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>  
> > > 
> > > Adding William in the loop.
> > 
> > Should add documentation and check for required version of mingw?
> 
> Docs, yes, but don't think we should add a required version check in code.
> 

Actually, nevermind a v2. Windows GSG already lists MinGW v10 as
requirement.

/Bruce
