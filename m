Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87B3C5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD1B84025E;
	Fri, 30 May 2025 15:14:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 49E324021E
 for <dev@dpdk.org>; Fri, 30 May 2025 15:14:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748610850; x=1780146850;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=twxeGBBX1O9A+L4eGJPwkwLTa+tf/qbfKi31jIpYMQI=;
 b=RdBEZsrGZucop9WejnDh7JRfzPDz2aY1p0HkZEiyuk4rp0Qz1ZRrRxJD
 26AvM83aZlZmhXK79wMqiZDfcjOOe0lUWAm7w+3XaHzdJbvRtsT/LpCp2
 DCXDciQPG3z9f4hqcD7aXBabRRCgySViGlRlufGzjgpNV8v5VI+/aHvTt
 a+d2s6HYdBUsDNCeEo5Hd7E40aeJ7Ohd9iTyy028MHKQN38sR1w2GsSdI
 qSiMMDydkYm6dk5cXa8C4kBL1BDUJBX3V7WCtxffiO2I1iyKGmCcATsPi
 rEeaniMjMrl7yd/fpvwCZVmtYCwu/Z3afJnNtJXrLz3KWtrmhghdemQi8 g==;
X-CSE-ConnectionGUID: t4Y5/JUnTPaHUVJDQO4YTA==
X-CSE-MsgGUID: KnWnV9l+TTmbFN5waUCgKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="54366511"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208,217";a="54366511"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:14:09 -0700
X-CSE-ConnectionGUID: fAGBWr0yT1SSQhDj20IwSg==
X-CSE-MsgGUID: evxeWYHBROq34z1WIcW/iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
 d="scan'208,217";a="144853054"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:14:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 06:14:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 06:14:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.89)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 06:14:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqOFXT+0FFu+Pt8yWJ6LF3AObj5HEO29RJTnO2nBVN6e8WYGmuGrwOEwby3HP16m6G0XcWEybCqTPzCK45kJoos2yNatCASxmJ7ryMQY39qa6NZqEaZIRO12QOqOc49zfaDdXmjBbdmi82LBfd9xhk8pKYoEW69NiWGcJ8d1CGaI1AhdKzMsnlyhrZmxuAv5gIsxGt8vx3w/lGSFONqR+yr/azzccDD7XgHToUuXOZdocG22EDw29OxlbSVn/QEGEz78ZNsdz6qaK28TvxGFG6q/wY2t7atzXYLkVHvQCifS2wMOaP9k9uIMdnShsfk+uS+mw1dvO7qpYEsFUJcr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8edLB4uOyanIbV/64YzYQS3L0BtL2Q5vRqFERyIExww=;
 b=PP2lCVO5k7c441kVpDZ7LhCIDv6ECsoRVeC1xHZpFs3DTaLKh8Yx4cmRjuxqKU4j5DRpsmFZ+B2XBIus1eY9PHvCG0ZziLoc2+ggjh86SGTnIgV9RhfQY75xxXVMVQj7OaMbLQsfPByiIvt5wMuTVjfEkQKKN1Ib8bJk2udjEu4qeboNef7DA5nnuLnsiF0Cf8evqug++VH5FZGgAWAR5bfUhzh7yzniEbeJvHc4esrNGc+5JW8OU2zk42Ee9ZcPFUe3pFBtrAq+JLS55HqZomNcWowe5daaW405kBGpX/YnjhA9zje9gHdmhpIvqoe4mEBtmM2FIyTH1WdoTS90Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CY8PR11MB7745.namprd11.prod.outlook.com (2603:10b6:930:90::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 30 May
 2025 13:14:03 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%6]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 13:14:03 +0000
Content-Type: multipart/alternative;
 boundary="------------8mI0GMku0BOaAtHtz0De2v1w"
Message-ID: <6aa7f332-c9fa-43e4-95f4-66c34f2c63bc@intel.com>
Date: Fri, 30 May 2025 14:13:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lib/lpm: R-V V rte_lpm_lookupx4
To: <uk7b@foxmail.com>, <dev@dpdk.org>
CC: sunyuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>, Stanislaw Kardach
 <stanislaw.kardach@gmail.com>
References: <tencent_A2BD85C9F3B0AA4658640DA91443CDF5630A@qq.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <tencent_A2BD85C9F3B0AA4658640DA91443CDF5630A@qq.com>
X-ClientProxiedBy: DU7P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::33) To PH3PPFD9B78DE02.namprd11.prod.outlook.com
 (2603:10b6:518:1::d53)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CY8PR11MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: df686544-ba3f-400a-582b-08dd9f7bd861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWlaSEY2ejR2RERhVEZjaUhUT2liTjVVOWpIdHMxbUJ5R280K2J1dTR2bWdr?=
 =?utf-8?B?MjVtQjJ5OEU5cmZIWFBlVys2c0dtNUpYeFdZRHUwY05XZHhYTnlBT2JjMG9D?=
 =?utf-8?B?eDA2aWpJZjFodVZhVlZKWTZYOGw0TW9JaGpIdk8ycUNvakJvR2VSbGVralla?=
 =?utf-8?B?MXRDTU5oRnBoV2EvcnV3U0tHOTNaZTFUTkVJV2wwZjdGcDZqYUJMN1NzVmxS?=
 =?utf-8?B?blVZMVg5akU1aTJhS2tkbnpkM2NpMGU0a2tVazM3dWozaEt1dXNZTVRFNjZD?=
 =?utf-8?B?SExFWjNUYjFUNVgvclVMUVU5cjh4QUZZZEpkZGlWaFhYVFNpMGRFR1dmNi9J?=
 =?utf-8?B?aGJseHdYamR5NkJyVVIzS25DYldZOStWSmhDakdkbW85Ung4cm9CZm1aSjZ1?=
 =?utf-8?B?VEZBS2VUTWZDWEFOVzFBU1RRMUprYndpMGN0NFNNaFMzWkZWczFCaWdIbzd6?=
 =?utf-8?B?MTJiT21Gd2cxeEFJUXdLT25NTVB3blNpT1RKb3JpczVpU3hnOERLZ2paZ2Zi?=
 =?utf-8?B?SWdNV016Rlp5NW94b1lEL2R1a1AvWWd6ME5ta2pwTC92OHRaaS9WSkRqc29N?=
 =?utf-8?B?UnhSOE4zY010c2F6OENPcTJIOWE0c205TUhFWEZtTExTLzBiVlRSM1loSGFj?=
 =?utf-8?B?NmtxaHF4MlJzRHlKNWxYWjNtbmhoOVhLWHVPVi96LzNCRjd2NHNNTXVka3kz?=
 =?utf-8?B?bi9DcEdtVkQ4ZlY4aldmM0FXZm5va1RwUVFhRWRBOGhPbkJhMkpvU3VUVnpk?=
 =?utf-8?B?RjFFUkRrbmF5eG1seTlHVGtoWjdEUFJ3RlVmbnh5VWJISTZXcHVDdlBvQ2tD?=
 =?utf-8?B?YzRKQmpYNkdhNW4zQmY2eDNkNDBwWU1Xa1dGdm1iUFFjelNqbENENDhaZUw2?=
 =?utf-8?B?L1JnYU83V0VzdHRXdDZIWkZHeXRUTHpkUEZMTHE0Ly9Ub3VVS053WUUwdHk1?=
 =?utf-8?B?VlVqcGtYYXc4MXgwcmJsS3hOcGJyK3BqcU1ScVU2VytWSzhvangvOWYwUzcy?=
 =?utf-8?B?RHk1cEpXWDBsWHd2UFkzL2VZUHJLTFhNSWZuY1NIR1ZZaGwyTWxCTzRiK1ZZ?=
 =?utf-8?B?b2pFR1QrWEpMY3BVRXBtWlYxbUN4SzdJa0YwcXdEYkNpVUQyMStWTWdpT2Jo?=
 =?utf-8?B?MHh1RWFWYmI2NjZzZTlpVDM1S0VnMTNZMnoyUDkrYWxVTCs3WDZnczU1MndR?=
 =?utf-8?B?Q2RZTmNVbHVwdVlxWTlXTENBbzlJNkNCV1RIZnRpbkhOcGYwWDY1Q2Yvd3h6?=
 =?utf-8?B?SWZBNzBYU2p4aGpEc1Nuc2FYOTYvUjJqNW5qR0RWK1VuOUJkVk1FbDJHdmpw?=
 =?utf-8?B?bXRyK3BibHBTYU5OeCsyUCtkck5NU203Q1JLcWF6RUxxelk1ZUJxWDJLV0g5?=
 =?utf-8?B?cVBVbG1iQzROcWNhQXVQNTNFZDQ1TEtEL1k1RnFkcG5xRkh3SXJCM29VcHpq?=
 =?utf-8?B?TTNhN3NrNExpUGk2VWhGL3R3Ulo5aUw4TDg2NEExdWc3OUhCZHNTaDZwcHVI?=
 =?utf-8?B?Nk1BaFVodENNOXNPYUpvbEZtTW5ISU14c1RzWUlOL1ViMlIzUEJ3NGdxVHIv?=
 =?utf-8?B?K0FZaGZXMVM5Z0c3aHRvSjdWbWp4RC8yZGdWN1RucmJmSEgyVXJtUFBFaXhU?=
 =?utf-8?B?dEMwR290cTdsUjIxaVVtdGJmck1uNDFiMW4wWm10SVZNYkZGck9tY3hxaEEv?=
 =?utf-8?B?THpuWm83cUtkNE92L3o2YUd0UTByNkVCVTFSZC9zS1QwdERVK0hkQ3B0VGJE?=
 =?utf-8?B?WllLODJEOVprSHVWTldnMDdnYlFZNUJCa0dyTkNRa3hMNklLeEx4bFR6TXhW?=
 =?utf-8?B?QmUwMFlDYXhvU1VkUmwxRTQrL1FTMVpBMW0vMTBtUWo4KytUbGtWTzlNTU9U?=
 =?utf-8?B?TVhWM0luM1lKaDAzc09Lc3ltRlRjM1lDem5obTdJOE5ua0ZtMmZhdVJvcnJ4?=
 =?utf-8?Q?TE6BRLLSEFo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkJzaURheXdXZ3NxYzRTVjlNQ01WOUJ5aW1LMHRERVZJOENxcjUveWMwczFK?=
 =?utf-8?B?OXgxY0JEUStOWjhFUGRHZTRDbzU5S1RmQmM4NzhTOGlFZmtwK2hMU2RZcUxw?=
 =?utf-8?B?blQvNmZGMFlPQTFpMVZBQ1VlZFMvN3NTR2kzQ1pXNldqeTd0VWZKellzUFVI?=
 =?utf-8?B?S2lPSE13VUl6MW1weFBFSG5NUy9sZTNUYm9pYjhVa0ovejFBRWxxTmlLTFA3?=
 =?utf-8?B?T1oySmI0WXRUenRlS2NyTkI5Rkt4MElsaVB2MlVtd0FFak1LRjFxNkxJL3Mw?=
 =?utf-8?B?SExidXZDazdBU1Q1K3RGcHgrbCtzL2x3VVlsQ3lDdlFDS0RLSWNkTUlNNCtV?=
 =?utf-8?B?dUhZQWlwNHFuakp0aHU1YkJBektySVh0THRjRjRQc3lMb3hJYmdNdU5Cemlx?=
 =?utf-8?B?VVozNk9sbGhtaWEwLzhwZXJUTllodjhZTjlHdDE1T1dTOUhHMzFqdXE5c3Ru?=
 =?utf-8?B?VyttTVAzRzRNZExJc3lRcU5sUU85L3VSVEljNXNNT0Vwc3BBMXQwbHhOWUFj?=
 =?utf-8?B?QUJXVm5XV080dkVPb29JQ2E4WVNQalFHeHc0NG83WkZWNmVLZ21pdVlaSnA3?=
 =?utf-8?B?N29MYmR0VDJXVDBsTDNuY1A4dmgxaTJqZWtIMzh2YXArUis5UGQ3QkI3eitz?=
 =?utf-8?B?d240d1JCTnZqZmJjMnhkU0NIeUtnMmZrTnZhbVB6cVQ5QjRBcmhBbWpiSjN6?=
 =?utf-8?B?UGU0QTBXUmF4Q3hENGpVOGFaRXJUWE5MMndaUDVDdFRpTGkvUCtlWE1NL3RZ?=
 =?utf-8?B?QWxQYWFQYmxWb25mZE5BTUJCaGhjQXpTYWVJUFJjcXJmVDM5bUNzVGhPTGFT?=
 =?utf-8?B?c2Y1Z2M5VlRwcG1ERG1hUk9pajdPNGFHUTQxU1dUNUJPa1cyYThqK3N4N2Vx?=
 =?utf-8?B?NXlqUjZBbXdmdkZOSG1OWWVBdlYzdm84enBxVE94Zk9rSVhoUUVaaTFRTFE3?=
 =?utf-8?B?eWQvYU5FdmJkTDk2eWI5RmhLMzNJTndRaXNabmE3QWFNekZkbExpQXllNTJ1?=
 =?utf-8?B?SGttRkVaUVc1c3p6azF6Umk0SDI1eGVJY2xlZFQweERSc1Zpc3lISnAvbTFO?=
 =?utf-8?B?RkJGY3NIcEx6L0wyOTM5d0h1OWVwSlZhVURKQTlMTjg1TzVrQ0NSVWJTNjJD?=
 =?utf-8?B?d1FmM2NkMlRxemNRREIrQ09tUXNzd1FIQ1owNFlCWXNJNWI2eTcwN1ViQk5a?=
 =?utf-8?B?NzkzeURsZlphcm1GeUY5ZVZ6WGI1S3BIZEoraGFTTGJHb2haNVMxUWQ2Mmsr?=
 =?utf-8?B?TjJhakdGbmhnT0t6SWI3MkpnQzhUTE9lVzA3QmpSUnhMMFhEOG9WM2FYbzh4?=
 =?utf-8?B?YUNSQk5pUUQ2ZzU4M29WNWVvMWdJRlpKS3prQ0ZsbnlnRFg2NGpRVWN2VmJO?=
 =?utf-8?B?RnVSdG5ld2tuWWp4cmFYZm5aSGlIbGVrbVUxV3k5cDczNGdzZGtVUGdVZ1lu?=
 =?utf-8?B?MWg3cDFTcCtJSTg4NW96TzMxdVVZUzdTTTNuMHpDR0QvWVpDMkIyTmJZRUdL?=
 =?utf-8?B?SmlUM1Y0d3p0eVFTR2lOdlFjbzhnbHpXcE1ZNEZhKzFBYUU4bDJSQkpFLzZo?=
 =?utf-8?B?RkttRlFKenV5VjhEclU4UEVGclFCSXFhaUFpdDEwdUpUd2NsRVZMUVJISTd0?=
 =?utf-8?B?cG9rZUY2U08xMzJYejd5cW9NVTdVYVZGcWlSb01SMDZZa2FUSFhCMG9zdi9v?=
 =?utf-8?B?SldOdG9Cc200Y1VXTi9yV09mY2JtR1dMdVJrQjBmWHNwUnpmSUlGYWFRYTlL?=
 =?utf-8?B?ckVHRFNIYTZ5REg2b2c4Q3ZyZWthc0F0V2xwUVA3ZFJ4NEh4aDIyZXVFK2My?=
 =?utf-8?B?c24xWlFRb2ZRQU1ONXB3c2ZUT3ltYmZ0Rkp5aTRYKzZsbWczR3NGakprUEYy?=
 =?utf-8?B?emVGdUxMNVBwK3VhZ21oYjVaaktRR1E2Tjl1TUJ1V1JjQ004eTdoM01xeFY3?=
 =?utf-8?B?VGZBQzI1UlhvQWVHNSt4ZnJlQ0hkVTVLaG44UFVNb0pVQVJRV3lEbHprT0to?=
 =?utf-8?B?WEZWdDg3NnJZaWxmSkowSFkzWk5objE3eEtuVlZiWDVtK0h5UFQ3ZktJYXV1?=
 =?utf-8?B?dVNFam52SThyMzBuZDJFbk9mSnpnRnR3ZDZuU1o4eGFtNWJIL2RNZFFqdmk1?=
 =?utf-8?B?ZkMzbGZuWlduc0NVYlZscm9zQkxGTWRSWTRWajY1K25UaGNMRTg0YmNxVmhs?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df686544-ba3f-400a-582b-08dd9f7bd861
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFD9B78DE02.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 13:14:03.0801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZy+oNLymbRSQbpPGfYMFc2udgn1vWuqsXeHhNNlVBsg8+HSf2TykBqx7S+Xj0csZFFzcicHrSny5kaxJRoLqV+T9MR5IGg83ZwyziViNnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7745
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

--------------8mI0GMku0BOaAtHtz0De2v1w
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sunyuechi,


On 28/05/2025 18:00, uk7b@foxmail.com wrote:
> From: sunyuechi<sunyuechi@iscas.ac.cn>
>
> bpi-f3:
>      scalar: 5.7 cycles
>      rvv:    2.4 cycles
>
> Maybe runtime detection in LPM should be added for all architectures,
> but this commit is only about the RVV part.

Iwouldadviseyouto lookintothe FIBlibrary,ithasexactlywhatyouare lookingfor.

Also,pleaseconsiderwritinga slightlymoreinformativeandexplanatorycommit 
message.

> Signed-off-by: sunyuechi<sunyuechi@iscas.ac.cn>
> ---
>   MAINTAINERS           |  2 +
>   lib/lpm/meson.build   |  1 +
>   lib/lpm/rte_lpm.h     |  2 +
>   lib/lpm/rte_lpm_rvv.h | 91 +++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 96 insertions(+)
>   create mode 100644 lib/lpm/rte_lpm_rvv.h
>
<snip>
> +static inline void rte_lpm_lookupx4_rvv(
> +	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
> +{
> +	size_t vl = 4;
> +
> +	const uint32_t *tbl24_p = (const uint32_t *)lpm->tbl24;
> +	uint32_t tbl_entries[4] = {
> +		tbl24_p[((uint32_t)ip[0]) >> 8],
> +		tbl24_p[((uint32_t)ip[1]) >> 8],
> +		tbl24_p[((uint32_t)ip[2]) >> 8],
> +		tbl24_p[((uint32_t)ip[3]) >> 8],
> +	};

I'm notan expertinRISC-V,butwhyis itdonein a 
scalarwayinsteadofusing__riscv_vsrl_vx_u32m1()? Iassumeyou're 
relyingonthe compilerhere?

Also,have youredefinedthe xmm_t typeforproperindexaddressing?

> +	vuint32m1_t vtbl_entry = __riscv_vle32_v_u32m1(tbl_entries, vl);
> +
> +	vbool32_t mask = __riscv_vmseq_vx_u32m1_b32(
> +	    __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl),
> +	    RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl);
<snip>
> +
> +static inline void rte_lpm_lookupx4(
> +	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
> +{
> +	lpm_lookupx4_impl(lpm, ip, hop, defv);
> +}
> +
> +RTE_INIT(rte_lpm_init_alg)
> +{
> +	lpm_lookupx4_impl = rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_ISA_V)
> +	    ? rte_lpm_lookupx4_rvv
> +	    : rte_lpm_lookupx4_scalar;
> +}
AsImentionedearlier,I'd recommendthat youuseFIBtoselectan 
implementationatruntime. All the rest LPM vector x4 implementations are 
done this way, and their code is inlined.
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _RTE_LPM_RVV_H_ */

-- 
Regards,
Vladimir

--------------8mI0GMku0BOaAtHtz0De2v1w
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p>Hi Sunyuechi,</p>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 28/05/2025 18:00, <a class=3D"moz-txt=
-link-abbreviated" href=3D"mailto:uk7b@foxmail.com">uk7b@foxmail.com</a>
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640DA91=
443CDF5630A@qq.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">From: sunyuechi <a class=3D"mo=
z-txt-link-rfc2396E" href=3D"mailto:sunyuechi@iscas.ac.cn">&lt;sunyuechi@is=
cas.ac.cn&gt;</a>

bpi-f3:
    scalar: 5.7 cycles
    rvv:    2.4 cycles

Maybe runtime detection in LPM should be added for all architectures,
but this commit is only about the RVV part.
</pre>
    </blockquote>
    <p><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:1" style=3D=
"white-space: pre-wrap;">I</span><span style=3D"white-space: pre-wrap;"> </=
span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"2:2" style=3D"w=
hite-space: pre-wrap;">would</span><span style=3D"white-space: pre-wrap;"> =
</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"5:11" style=
=3D"white-space: pre-wrap;">advise</span><span style=3D"white-space: pre-wr=
ap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"17:3" s=
tyle=3D"white-space: pre-wrap;">you</span><span style=3D"white-space: pre-w=
rap;"> to </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"21:=
9" style=3D"white-space: pre-wrap;">look</span><span style=3D"white-space: =
pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"3=
1:1" style=3D"white-space: pre-wrap;">into</span><span style=3D"white-space=
: pre-wrap;"> the </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-alig=
n=3D"44:3" style=3D"white-space: pre-wrap;">FIB</span><span style=3D"white-=
space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-ali=
gn=3D"33:10" style=3D"white-space: pre-wrap;">library</span><span class=3D"=
aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"47:1" style=3D"white-space: pre-wra=
p;">,</span><span style=3D"white-space: pre-wrap;"> </span><span class=3D"a=
NeGP0gI0B9AV8JaHPyH" data-src-align=3D"49:3" style=3D"white-space: pre-wrap=
;">it</span><span style=3D"white-space: pre-wrap;"> </span><span class=3D"a=
NeGP0gI0B9AV8JaHPyH" data-src-align=3D"53:4" style=3D"white-space: pre-wrap=
;">has</span><span style=3D"white-space: pre-wrap;"> </span><span class=3D"=
aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"58:6" style=3D"white-space: pre-wra=
p;">exactly</span><span style=3D"white-space: pre-wrap;"> </span><span clas=
s=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"69:3" style=3D"white-space: pr=
e-wrap;">what</span><span style=3D"white-space: pre-wrap;"> </span><span cl=
ass=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"73:2" style=3D"white-space: =
pre-wrap;">you</span><span style=3D"white-space: pre-wrap;"> are </span><sp=
an class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"76:5" style=3D"white-sp=
ace: pre-wrap;">looking</span><span style=3D"white-space: pre-wrap;"> for</=
span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"81:1" style=3D"=
white-space: pre-wrap;">.</span></p>
    <p><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:5" style=3D=
"white-space: pre-wrap;">Also</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" da=
ta-src-align=3D"5:1" style=3D"white-space: pre-wrap;">,</span><span style=
=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" da=
ta-src-align=3D"7:10" style=3D"white-space: pre-wrap;">please</span><span s=
tyle=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH=
" data-src-align=3D"19:9" style=3D"white-space: pre-wrap;">consider</span><=
span style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8=
JaHPyH" data-src-align=3D"42:8" style=3D"white-space: pre-wrap;">writing</s=
pan><span style=3D"white-space: pre-wrap;"> a </span><span class=3D"aNeGP0g=
I0B9AV8JaHPyH" data-src-align=3D"51:7" style=3D"white-space: pre-wrap;">sli=
ghtly</span><span style=3D"white-space: pre-wrap;"> </span><span class=3D"a=
NeGP0gI0B9AV8JaHPyH" data-src-align=3D"59:5" style=3D"white-space: pre-wrap=
;">more</span><span style=3D"white-space: pre-wrap;"> </span><span class=3D=
"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"65:14" style=3D"white-space: pre-w=
rap;">informative</span><span style=3D"white-space: pre-wrap;"> </span><spa=
n class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"80:1" style=3D"white-spa=
ce: pre-wrap;">and</span><span style=3D"white-space: pre-wrap;"> </span><sp=
an class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"82:10" style=3D"white-s=
pace: pre-wrap;">explanatory</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" dat=
a-src-align=3D"81:1" style=3D"white-space: pre-wrap;"> commit message.</spa=
n></p>
    <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640DA91=
443CDF5630A@qq.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">
Signed-off-by: sunyuechi <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:=
sunyuechi@iscas.ac.cn">&lt;sunyuechi@iscas.ac.cn&gt;</a>
---
 MAINTAINERS           |  2 +
 lib/lpm/meson.build   |  1 +
 lib/lpm/rte_lpm.h     |  2 +
 lib/lpm/rte_lpm_rvv.h | 91 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 lib/lpm/rte_lpm_rvv.h

</pre>
    </blockquote>
    &lt;snip&gt;
    <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640DA91=
443CDF5630A@qq.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">
+static inline void rte_lpm_lookupx4_rvv(
+	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
+{
+	size_t vl =3D 4;
+
+	const uint32_t *tbl24_p =3D (const uint32_t *)lpm-&gt;tbl24;
+	uint32_t tbl_entries[4] =3D {
+		tbl24_p[((uint32_t)ip[0]) &gt;&gt; 8],
+		tbl24_p[((uint32_t)ip[1]) &gt;&gt; 8],
+		tbl24_p[((uint32_t)ip[2]) &gt;&gt; 8],
+		tbl24_p[((uint32_t)ip[3]) &gt;&gt; 8],
+	};</pre>
    </blockquote>
    <p><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:1" style=3D=
"white-space: pre-wrap;">I</span><span style=3D"white-space: pre-wrap;">'m =
</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"2:2" style=3D=
"white-space: pre-wrap;">not</span><span style=3D"white-space: pre-wrap;"> =
an </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"5:7" style=
=3D"white-space: pre-wrap;">expert</span><span style=3D"white-space: pre-wr=
ap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"13:1" s=
tyle=3D"white-space: pre-wrap;">in</span><span style=3D"white-space: pre-wr=
ap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"15:4" s=
tyle=3D"white-space: pre-wrap;">RISC</span><span class=3D"aNeGP0gI0B9AV8JaH=
PyH" data-src-align=3D"19:1" style=3D"white-space: pre-wrap;">-</span><span=
 class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"20:1" style=3D"white-spac=
e: pre-wrap;">V</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=
=3D"21:1" style=3D"white-space: pre-wrap;">,</span><span style=3D"white-spa=
ce: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=
=3D"23:2" style=3D"white-space: pre-wrap;">but</span><span style=3D"white-s=
pace: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-alig=
n=3D"26:6" style=3D"white-space: pre-wrap;">why</span><span style=3D"white-=
space: pre-wrap;"> is </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-=
align=3D"33:3" style=3D"white-space: pre-wrap;">it</span><span style=3D"whi=
te-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-=
align=3D"37:8" style=3D"white-space: pre-wrap;">done</span><span style=3D"w=
hite-space: pre-wrap;"> in a </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" da=
ta-src-align=3D"46:9" style=3D"white-space: pre-wrap;">scalar</span><span s=
tyle=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH=
" data-src-align=3D"56:8" style=3D"white-space: pre-wrap;">way</span><span =
style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPy=
H" data-src-align=3D"66:1" style=3D"white-space: pre-wrap;">instead</span><=
span style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8=
JaHPyH" data-src-align=3D"71:1" style=3D"white-space: pre-wrap;">of</span><=
span style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8=
JaHPyH" data-src-align=3D"73:7" style=3D"white-space: pre-wrap;">using</spa=
n><span style=3D"white-space: pre-wrap;"> __riscv_vsrl_vx_u32m1</span><span=
 class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"102:1" style=3D"white-spa=
ce: pre-wrap;">(</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=
=3D"103:1" style=3D"white-space: pre-wrap;">)</span><span class=3D"aNeGP0gI=
0B9AV8JaHPyH" data-src-align=3D"104:1" style=3D"white-space: pre-wrap;">? <=
/span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:1" style=3D"=
white-space: pre-wrap;">I</span><span style=3D"white-space: pre-wrap;"> </s=
pan><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"2:7" style=3D"wh=
ite-space: pre-wrap;">assume</span><span style=3D"white-space: pre-wrap;"> =
</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"11:2" style=
=3D"white-space: pre-wrap;">you</span><span style=3D"white-space: pre-wrap;=
">'re </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"14:11" =
style=3D"white-space: pre-wrap;">relying</span><span style=3D"white-space: =
pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"3=
2:2" style=3D"white-space: pre-wrap;">on</span><span style=3D"white-space: =
pre-wrap;"> the </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=
=3D"35:10" style=3D"white-space: pre-wrap;">compiler</span><span style=3D"w=
hite-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-sr=
c-align=3D"26:5" style=3D"white-space: pre-wrap;">here</span><span class=3D=
"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"45:1" style=3D"white-space: pre-wr=
ap;">?</span></p>
    <p><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:5" style=3D=
"white-space: pre-wrap;">Also</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" da=
ta-src-align=3D"10:1" style=3D"white-space: pre-wrap;">,</span><span style=
=3D"white-space: pre-wrap;"> have </span><span class=3D"aNeGP0gI0B9AV8JaHPy=
H" data-src-align=3D"12:2" style=3D"white-space: pre-wrap;">you</span><span=
 style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHP=
yH" data-src-align=3D"15:14" style=3D"white-space: pre-wrap;">redefined</sp=
an><span style=3D"white-space: pre-wrap;"> the xmm_t </span><span class=3D"=
aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"30:3" style=3D"white-space: pre-wra=
p;">type</span><span style=3D"white-space: pre-wrap;"> </span><span class=
=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"40:3" style=3D"white-space: pre=
-wrap;">for</span><span style=3D"white-space: pre-wrap;"> </span><span clas=
s=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"44:10" style=3D"white-space: p=
re-wrap;">proper</span><span style=3D"white-space: pre-wrap;"> </span><span=
 class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"55:9" style=3D"white-spac=
e: pre-wrap;">index</span><span style=3D"white-space: pre-wrap;"> </span><s=
pan class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"65:9" style=3D"white-s=
pace: pre-wrap;">addressing</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data=
-src-align=3D"74:1" style=3D"white-space: pre-wrap;">?</span></p>
    <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640DA91=
443CDF5630A@qq.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">
+	vuint32m1_t vtbl_entry =3D __riscv_vle32_v_u32m1(tbl_entries, vl);
+
+	vbool32_t mask =3D __riscv_vmseq_vx_u32m1_b32(
+	    __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl=
),
+	    RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl);
</pre>
    </blockquote>
    &lt;snip&gt;
    <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640DA91=
443CDF5630A@qq.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">
+
+static inline void rte_lpm_lookupx4(
+	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
+{
+	lpm_lookupx4_impl(lpm, ip, hop, defv);
+}
+
+RTE_INIT(rte_lpm_init_alg)
+{
+	lpm_lookupx4_impl =3D rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_ISA_V)
+	    ? rte_lpm_lookupx4_rvv
+	    : rte_lpm_lookupx4_scalar;
+}</pre>
    </blockquote>
    <span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:3" style=3D"wh=
ite-space: pre-wrap;">As</span><span style=3D"white-space: pre-wrap;"> </sp=
an><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"4:1" style=3D"whi=
te-space: pre-wrap;">I</span><span style=3D"white-space: pre-wrap;"> </span=
><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"6:8" style=3D"white=
-space: pre-wrap;">mentioned</span><span style=3D"white-space: pre-wrap;"> =
</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"15:5" style=
=3D"white-space: pre-wrap;">earlier</span><span class=3D"aNeGP0gI0B9AV8JaHP=
yH" data-src-align=3D"20:1" style=3D"white-space: pre-wrap;">,</span><span =
style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPy=
H" data-src-align=3D"22:1" style=3D"white-space: pre-wrap;">I</span><span s=
tyle=3D"white-space: pre-wrap;">'d </span><span class=3D"aNeGP0gI0B9AV8JaHP=
yH" data-src-align=3D"24:10" style=3D"white-space: pre-wrap;">recommend</sp=
an><span style=3D"white-space: pre-wrap;"> that </span><span class=3D"aNeGP=
0gI0B9AV8JaHPyH" data-src-align=3D"35:3" style=3D"white-space: pre-wrap;">y=
ou</span><span style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeG=
P0gI0B9AV8JaHPyH" data-src-align=3D"39:12" style=3D"white-space: pre-wrap;"=
>use</span><span style=3D"white-space: pre-wrap;"> </span><span class=3D"aN=
eGP0gI0B9AV8JaHPyH" data-src-align=3D"52:3" style=3D"white-space: pre-wrap;=
">FIB</span><span style=3D"white-space: pre-wrap;"> </span><span class=3D"a=
NeGP0gI0B9AV8JaHPyH" data-src-align=3D"56:3" style=3D"white-space: pre-wrap=
;">to</span><span style=3D"white-space: pre-wrap;"> </span><span class=3D"a=
NeGP0gI0B9AV8JaHPyH" data-src-align=3D"60:6" style=3D"white-space: pre-wrap=
;">select</span><span style=3D"white-space: pre-wrap;"> an </span><span cla=
ss=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"67:10" style=3D"white-space: =
pre-wrap;">implementation</span><span style=3D"white-space: pre-wrap;"> </s=
pan><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"78:2" style=3D"w=
hite-space: pre-wrap;">at</span><span style=3D"white-space: pre-wrap;"> </s=
pan><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"81:16" style=3D"=
white-space: pre-wrap;">runtime</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" =
data-src-align=3D"97:1" style=3D"white-space: pre-wrap;">. All the rest LPM=
 vector x4 implementations are done this way, and their code is inlined.</s=
pan>
    <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640DA91=
443CDF5630A@qq.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_LPM_RVV_H_ */
</pre>
    </blockquote>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Regards,
Vladimir</pre>
  </body>
</html>

--------------8mI0GMku0BOaAtHtz0De2v1w--
