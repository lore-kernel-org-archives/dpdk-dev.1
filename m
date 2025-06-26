Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0537C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 13:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 286FF4025D;
	Thu, 26 Jun 2025 15:36:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id E29B840156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 15:36:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750944993; x=1782480993;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=u4jcDqGs7PgQ6el/wNOaE8X8jQzGmPYeW3BZdWQuPbQ=;
 b=ick1mULFP7N+NsrG3YOD0fgf1UusGHOvMpAykNscJ9pWIV+5YyV8wx8g
 DmdiQ+NvYB8/Mr2IrzNdEoVe4GOB3g9l/cW1gtYuk95Qi+BmRCqBH9eok
 AGLV+iq8qgDpHYwrf34/xoBySWga8SaBagVAIoLDNXzKb+cOyxBUbEQmU
 PzaBbd8i4nOJ1TcxXTJktc29rZ34o7oKIDoluMlX20xNLci3stmB3T+wn
 M/SQJ+2SWQmCExtzzlD44YIlW+J8ECvmzOMF7LPmlNradpwIJdkGHJSyO
 AgZ5VupPr1hEO0dUrdDheEbrWzAuu9DsgkPz5h5ySZGkNmjI9s0XGGHey g==;
X-CSE-ConnectionGUID: azVAKUC6TUmPIPSB91guhQ==
X-CSE-MsgGUID: HlxXjlmAQNWQ/uB2d9jutA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="40856524"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="40856524"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 06:36:32 -0700
X-CSE-ConnectionGUID: NpYnbOkcScaDBkGVaIc1Sg==
X-CSE-MsgGUID: gWHJnmo/SHWjpDCvpXAo4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="152631364"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 06:36:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 06:36:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 06:36:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.45)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 06:36:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbXkbqrONNNmdyvp/EMUdA611dOFjKxkfofs+bLt9nMoeDLo3WgIqW7ubqEz76cZ93itbK/gOli59Qo5fjrVGykd5Noqu3M+PyZZ8iW31cdjys1AxZB156wFunplXF0GAhs8/Fx7Y+eVlE8IFBGFGtjHS1xIBbqvsndYn/rgcLkapEftE7xEaIrTO1VXmbsAoFYxp+wkSMay31q9TH9YhIQfAoYsrl/GyRCRDkLVFiCButvwUUQThZ4FUojs/xkl14JgdJI4icmFjKzvRy2GaB53dEq/85lEu1qEXV1CraQPx+JAai2/EsgI8+M5NPN3mahbyb+TdPz0YmBUO1idUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwqY3z8RnRDmBliXLHJVCndjZc11uuAS+gcRuCxgjKA=;
 b=eC3udeoc6ygcw05bv1Lc3v5q/ghceDlaui1sCbMjqUDLB0jceGIFGpvddaMBRxYilj2efBiEZYDbZmbcHLS63pGRIPAemTuwK5S9WPsahJ9k1BttCWsG+XtJUUgXS5Y7mGpyheWzkxxCu6xXhThqMyKqndDR8MHoiIIjp2VRSOMnZGaNlBJgjeM5a3oxdOZSwXiwl/Ess0liqzUZsEl3vOIXmKVFuICBbwAggdppHQQBOezOV787Za08DVENlHGJVnUBhzIC09Hldzz0nx0Jfa0oTHBIkUrUKLbvaLrn6P7SpFgAZpUCZ+BIgUGG0udFMS16k7ACzel3PcdeyamKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA0PR11MB8301.namprd11.prod.outlook.com (2603:10b6:208:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 13:36:15 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 13:36:15 +0000
Message-ID: <14688ff6-54c8-480b-bb3e-22e6f30f011c@intel.com>
Date: Thu, 26 Jun 2025 15:36:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc/eal: add doc entry for service core list flag
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20250624133409.550372-1-bruce.richardson@intel.com>
 <20250624133409.550372-2-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250624133409.550372-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0234.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::25) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA0PR11MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 410b6f4c-fdf5-4c8e-b65b-08ddb4b66c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlFOaFJMTXJHYXVNWit1YjZBa0luOThEblJFSnY0NEJjT3I1TDV3bmJwdnBM?=
 =?utf-8?B?anpxeTMxdFdnVVdiVXYvWithQWZ4dmRwdzdOQmtkVytPNVZEQWI4emZIYkRQ?=
 =?utf-8?B?MXhGMU8vdnVBQjFiMDRlK2V3VWJpU3BvSVRxb01oRGtsS0tGcDB2RDF5ME1w?=
 =?utf-8?B?azRjUTd2dGQ2WnlweXZDajg4aWF1dFNrbm1tKzIvRGI5SEZ5OU5WTmV1T0N5?=
 =?utf-8?B?bjR1NVRPdlhzMDIzK1RPQUpUZmFhb25qWXdHK24rY1F0Y1djcTFTQjk3T2lx?=
 =?utf-8?B?b1ZXanBlNGl1NFdEN0thUXlXcGIzQnJhRk82clhkU2dURTB4U1NUUmI2cHpu?=
 =?utf-8?B?RTBKSVJ1dEJLKzJKb2NvVkdKcjQ4d1lEbzFTMjkrb0llQ3lJNHlwOEx6eTd2?=
 =?utf-8?B?Q0lSS2RNcmQ3WDYwS2hBUGpwZjVuMlhxMi9ablpuY1Vub011OHVxbjZsYnY3?=
 =?utf-8?B?Z0ppaHhlT2RYZTUvKzYxT2dnR2JrZzZQcVdQQmE3dXFkbUIxTi9lL1hVL0I1?=
 =?utf-8?B?L0JveGt1cllyUVBDMnRXdDFXNXB3VU1nczBGVkF0WUFKeTJYNCtIVXdhTll0?=
 =?utf-8?B?eFhRRGpmZnJ6NWNGRXcwOXhjN1RuNmNUNWluS0NabUdydFpqZXhSc1orQUpa?=
 =?utf-8?B?MHBwUEdudzAwR1M2QjdFdlZ1UmY1ZCtib0Z1eElyK010YTNDMVpSajZYVExt?=
 =?utf-8?B?NmJuNG0zSDVIZkU4RTNYVjl4L3NISE5rUi9OSnJWeDVXbzdkQUxDM2dlSURZ?=
 =?utf-8?B?K1N3NzZBdjNjYjBqa2FDNlJ1OFQrcHdIeFRvNVRqNy9abStmRHpWYW5XOGRk?=
 =?utf-8?B?RDZ3aGJqUmltcTlrQy9UTjQrTXRad2tjaGVzQWx0SGx5ZkdWTEVuU2RxbFN3?=
 =?utf-8?B?a1JxRlV6Z1JhUE1ZRTRKN2MzeVNnL1k2eHF0MFdhVUwzZGFodXlIbE1Gb1JT?=
 =?utf-8?B?SkJXbExQSm8rN2ZmSFc3cTF0RWNRRmVaOHhEOUxMQUJpQjR0NmhRekJBR2Rk?=
 =?utf-8?B?UmE5VDFZV013MkhBNUx0WW5pNHpIZ3pGVVZIK1JyaTJEc29rb0JsRndFQW9B?=
 =?utf-8?B?SzNSdWt2YXJvOHJpRTBoZGRBM1dFYkRDZm1mSTM4U3p6Zm1YOXo3ZVBza2Fq?=
 =?utf-8?B?aFZUYkFsTEUxd21XMzhNS2hKVWxvWUc2TExOZ0RZS3J6R2tQQXU5QjRZVjJn?=
 =?utf-8?B?UHZiWUtoWCtUd3l5ZTF1V1Z1Vk5uanNyaWllVG03Q3h1N0UrQW9Gc3ZZNXJj?=
 =?utf-8?B?UzhyU2pzeXVaRXdCV2x4Yy9jVXk2cHhPdExsWjJScVl5dlJqMHlmR2dId0NH?=
 =?utf-8?B?VHpadmRMZzdLUm1EQlpKZFd0RVhXV2Nka3M1SUp4RXNPQVVDbnhWSXFXRS82?=
 =?utf-8?B?SWQydGs0eUtjelZLSnRnWVVoaWMyTk93VXh6bFc5dVo3Z3I0TXkwNlNxOHY5?=
 =?utf-8?B?YitSVEhmeTY2WHpVV2VlanFwU1VLOVRQd3BoRFduemtUS2ptdng1VHFtL1Rr?=
 =?utf-8?B?ZVJEcUl3c3YwdXhFc1Bla1lMK3hLR2NPSWFFd0FqZXNQYXhmODgzQ1Z2K0NI?=
 =?utf-8?B?bEgzakZ6VFJFZzNqVHg0T2duWWFaZ2NsdU9QdHpCS2wrb3hLZFZpYnAxVG10?=
 =?utf-8?B?SGR6Qm1xbzdRMjJmSjZ3L3huaXJreHV1L25pa24zUkE1ek1JaVFtQk5lQ3Zp?=
 =?utf-8?B?cHI1cjk1ZndRZXl1Vk0wQjB0MFNBTHlVenE4R2loZklldkpvS21qUXl2VVdP?=
 =?utf-8?B?c0liYUIyTllCaUpYdDNTZFdOSlBHejdXSERSUnR2RHJiclhRS1phMk9POXhn?=
 =?utf-8?B?VWVlVFAvWmtqN0ZQdjV5NDE4WlNkZExqVnBqMnhIYzdJN3B1ZHV2dnhuQXo5?=
 =?utf-8?B?K0J4VG85eGNDQmNwVXBhRkw4RVpnSWorSE9IQUpTdEVqVm5YYi8yUmxhdDRk?=
 =?utf-8?Q?icIaxkj/ah0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mnpybzh1dy9rREp3dlYwdzZiUGFZTWNUSmpUT2piTXpuSXg1cUhnb25PWkNU?=
 =?utf-8?B?RWpIbEI5NDFpemtzRjRxN0hub1JBSTdCRjJ3ejlzQk5yV2o1UWFidlU2SDll?=
 =?utf-8?B?QllnNk9mbm5kMGNwRDVYWVhVQ2xNQ3hxU1RBQ0w2RnVBaXJubW95UTdkcGpj?=
 =?utf-8?B?VmF6bzAveElyd0xyMXdyVUFEY2lWR1hvbU5aRnJ4TmNzK2VrQnBDYVhuYXZY?=
 =?utf-8?B?NklmdEtTU3BTSldPem5nTEZxOWNGRWlLZEc1NFNxTzN1ODJDUVBlQnVoZkhL?=
 =?utf-8?B?cFMwWnp3U2E3SDYyY3o4QjlSckRJL21NWG1tZ3FNSTlHY0ZWYjVWQnozR1NL?=
 =?utf-8?B?L2VTSk5yWnBaODVCRjFKL3pQUCtxZkx2QWxEcURnenNEZndUaWdXZ1laZkxm?=
 =?utf-8?B?RFVYN1lZNDQxNi9mSE0xWUtUeGZZeVRZSDFWZmljU0g4T3VNZjZzVzZsdDds?=
 =?utf-8?B?a29VbExscTRWUjhQZXk0Z2pVUWtkSFp3WllzMjFrTGw4V3gvcDFpbUtnUFg3?=
 =?utf-8?B?Z2xNdmozVFVLTi96dWl6NUtQUnVLcE5iOWZNR0dJQ2Z4QjM0dnA1WEU4SWN6?=
 =?utf-8?B?Znk2THdRQWMzY2U5YjIyRFlXTVRZZHlVbnA5Wm9obXJYbWtNU3dtK2ZWdU5S?=
 =?utf-8?B?QnBLV0hkTHBOdFdaQ1ZMTTYzTWh4RlBQb1Mrd1pDczA5S2pQdCtpUXRMUEwz?=
 =?utf-8?B?amRUaFdnb0NnYjdINE95a2FJczVFZHNENHRkUGE4QTU0OUhEMU9LcU9CeDNu?=
 =?utf-8?B?NlhiZ0ZTTVRaSjVnYXQ1N1gvb3dPRmlNWHRqSWNUcDV5SXJIVHZDcFptQm95?=
 =?utf-8?B?NzVnUEJ0NERLTG5wUm85enpBTkM1VmhkNDVYMXVBWFR4V0hVMlRoNExhZ0Uz?=
 =?utf-8?B?TGRIV1FLcWVOZHFFbUJqWGJSdnhsV01FNXpjbVNBUTI1NXJHejArOW9VYUJw?=
 =?utf-8?B?ZkpZbGJNQjZUYlh2RWhCSEo5Z3EzclZFM2ZCbkJFWjRRV0ZMYmF3bUVqOXEw?=
 =?utf-8?B?OWkzQ2JqMlVzWVdsV1F4SG05NVBZM3BHWm9veDU5L3ByM0ZqVk9odEZ6Q3dm?=
 =?utf-8?B?dWw5NUhhVVBmc0JWTGM5SlJjWFFyMmgrQWZ4ZzcyRUorVkZ0Z0RqTmtPbzQr?=
 =?utf-8?B?dHgwNlpScTBSWjBlNGRsRHJoU1JadWFLcGh2b2ovMmR2RTBZMkJZUngrQkk2?=
 =?utf-8?B?SUl6NXJzU2FKeWp5OFVVUElYZ05TbFQzL05xNWxFSmp4WnFSNlpjS1JiUSti?=
 =?utf-8?B?OXhIWGtEdmxoc0VRelBjWENRbTFrOE96aW1oTVhOZUY5cWNFc1l6VkMxSXNV?=
 =?utf-8?B?Qno3SzllYTNldmpIQlltNWVBYnFLRWd2WHVRWlUxMjJKODF0clc3T3F1WmVG?=
 =?utf-8?B?aW16Yi9jV0l6YmExZzRyblJpUGpMZ0l0QUlyWnluSUROLzR6eHd2ZTJ2cTBD?=
 =?utf-8?B?cUdXTzNEdHpaUEs3ZDBjWW5rSy9NcEt6STBLQmhXdG1hQmpKczZhdWxiMUZz?=
 =?utf-8?B?OXdQUEJpTVY0YkluNjdqTEdmamZlK2ZUNDFRekhWdXh1bVFzUDVmSkNtVXZw?=
 =?utf-8?B?SkZTTVA1d0Z6bUxUOHJ1NEdqRFlCYzJVK242MDcxZktNY0RlTFEzUWlmMEx2?=
 =?utf-8?B?OWpXT1ZOSFdpWStCdzg3aVpqYlc2MElvM0hqSFh4eXlmc21PeUR4RHVISE1N?=
 =?utf-8?B?NXJsdHVyc3hSbnJmK1pyUFhhQThUUUdvNVp6L0pJUnE2b2x6RVdTTEtLNkU1?=
 =?utf-8?B?dVk4ZzBmWHBBL2paMTNBRnUxdDg3V2NDc2FZcjJDVks0ZzBxWmtpcmlIaWNz?=
 =?utf-8?B?M0tWc01YWnJrL3llSFo2N0Vac2xCV2lEMlJrZW8yVXZUUWM5Tnk0L0ozdXhy?=
 =?utf-8?B?UGhta2lxcFZXT0FPYit0WlRER1M1UGViTGN4UVpUZWN0bkpJWEpTUjQwTXhV?=
 =?utf-8?B?eVB4RDZnNmNRcndBSjVnTS9MbGVETnUzcWZmeldNQkdsbXZsbk9kQXpYbitU?=
 =?utf-8?B?V3E5akUyV2ZjbXRvL1pHckJBa1BLVFR3cWpxMU9PS3c4SDdmWTk1YU9yL2VE?=
 =?utf-8?B?ZGtjSFlGYkV4MU13c3ZxazFnZGpXR0ovRjBQbXVkTzZlMDc4TFpIVEpPeDlM?=
 =?utf-8?B?ZXFKRnlGdHYyUDNma1NMT3Bzc1hPWlFDaC8yU2dlSHkyK3VHU1FFOW1CV2tq?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 410b6f4c-fdf5-4c8e-b65b-08ddb4b66c47
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 13:36:15.6273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGqDrMnE1EaT/yav0Gn/vKTOCbKppvxXyjugOUmQx9lXYlVYF5J3/V3G/I+kEcWuViNCznOc3qT0ojApLAaA2QLB8Ls7myav6miAm00olws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8301
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

On 6/24/2025 3:34 PM, Bruce Richardson wrote:
> In the list of EAL arguments, only the "-s" flag for service cores was
> documented. Add an entry for the "-S" one too, which takes a core list
> instead of a core mask.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   doc/guides/linux_gsg/eal_args.include.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
> index 359721eb6a..6ee79877c1 100644
> --- a/doc/guides/linux_gsg/eal_args.include.rst
> +++ b/doc/guides/linux_gsg/eal_args.include.rst
> @@ -79,6 +79,11 @@ Lcore-related options
>   
>       Hexadecimal bitmask of cores to be used as service cores.
>   
> +*   ``-S <service core list>``
> +
> +    List of cores to be used as service cores.
> +
> +
>   Device-related options
>   ~~~~~~~~~~~~~~~~~~~~~~
>   

Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
