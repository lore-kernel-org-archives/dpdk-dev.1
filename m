Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925B9C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 11:06:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 866C8402CC;
	Wed, 23 Jul 2025 13:06:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1BDDE40264
 for <dev@dpdk.org>; Wed, 23 Jul 2025 13:06:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753268798; x=1784804798;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=LmB/Ma52IhweEef3/Sw0zAu0m54uoesWHmt8WU0CNkw=;
 b=GoaYyNwvHr7H/p1aJ6zAzQn6nfop7DClUu9v7kcM0BHXUnQizDEmFWpj
 bOSrw9OwDebJfDktpa+o7ZvXhl5ZQPRV5z7l5f7srK0LMWGjXOYg02oYN
 lQvQl0HyhL0rwqygu14orqjsE1nLHbnrlrskHBABy1eHSJOzDzzH6qT2W
 NKPrig8WL+6WW2ZqhcEylZJe8bPA4u3nKSr6dcSI1R9GMRe6GDQUzsH3U
 2KFF9YFR5sImGCxKkJINxP3+lxaHjkOWUlMPIIxG5LLfzPP/VYDSZ2rtd
 RKc1Oc4VQllsDq3tr8h9W+Z/qqUpvGLQQ+HVJbyHriT5sD4yL0Nj6hvPu A==;
X-CSE-ConnectionGUID: 3TuqwYTJQheefirIVf533A==
X-CSE-MsgGUID: EIlR/MuaT5WFY/hY2fKncA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55251781"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="55251781"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 04:06:37 -0700
X-CSE-ConnectionGUID: EBPc3q5sQTi11WE+eE8hpA==
X-CSE-MsgGUID: 5R5c13eaR16PW8Er7cDmYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="190430188"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 04:06:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 04:06:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 04:06:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 04:06:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnMtBaaEVuDmv5q4FpK/AstV8a9qq+1/KW6T3lsI9eF2NgCE64uLz6TsGfb2+KlPyEPj2V7ZVJkTQSKw4hRw3GE+J1RepugDtN7qg6T1UVgn/bi7mBh9Zl3C4K/UwT/FxBnKBKYB43ctzu/ejKz8A2ZBmpUDfuxVV7ilRhGs0n1cFpUTt7OPwiGe+to6ldcGMMycqP7o56p0fuC8RKecRLr/ptGIyuLS/UJbVV2UYJwmqiOoL/Q/brXbcMoO6QODgWTT/e1ET6xb0wjYCOcqmJMtpABCYpvS5EN45n6XkNlg3mniIFQ5xrK68Gt6qhKU9Vx6L2bttlN8925qnWaNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+3qlgJQB1euKxta23yEXS1Hk77OObCiEXo/a3ypGng=;
 b=CrC/BzHa3Vb+d1i8oJov01Jab+J+GfD2hSaDaMrdhOsmpUWpdKk1JUMrn6RwtbdIb9FHnFOprv/OFNrD1gyil08B09iKuQZlob4ulH1eR0tN3V2PxS+tvBDEkvrW8h+2/eYJ9nuwOEArHBqkmnPD6rweCag/I90FNHnurcR79dX4tbZ95VKjSk/jHXIUu8cWYbIGOAdrik15kBJPbdgRjnQYmdeRD4ogFK7uvxNOpJ5IcTLQV4yLCVCIshcmFPTBsu0L63/eamWdv8xxYOVweqAubopyqy0CtH/1mf+xZ3kcAdAQknHIUJorTNGoyd6kK+1rURgqy0lRF16SzNENYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7575.namprd11.prod.outlook.com (2603:10b6:a03:4ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 11:06:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 11:06:33 +0000
Date: Wed, 23 Jul 2025 12:06:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Paul Szczepanek <paul.szczepanek@arm.com>
CC: Patrick Robb <probb@iol.unh.edu>, Luca Vizzarro <luca.vizzarro@arm.com>,
 <nd@arm.com>, <dev@dpdk.org>
Subject: Re: [PATCH] maintainers: update for DTS
Message-ID: <aIDCNPy1ZoYyC0F9@bricha3-mobl1.ger.corp.intel.com>
References: <20250722160529.2659392-1-luca.vizzarro@arm.com>
 <CAJvnSUDetAq7uRJaCwVf9+QrYn=rTAjxra3zPev_ieRVds33Sw@mail.gmail.com>
 <71bdc991-62a8-4d13-bfb0-c23f868af2c7@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71bdc991-62a8-4d13-bfb0-c23f868af2c7@arm.com>
X-ClientProxiedBy: LO4P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1178c057-05f9-48ba-1de1-08ddc9d8fb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aW81SzNnS1RTTU9XZ2E3eGtSbHRldlM5Z1BtNVpySjhFVDVKTkJMWmQwM3hy?=
 =?utf-8?B?UWNwZ3VSeitqSEQ0cGdWVVhoZjVLT3ZxUGZXQXVKYjFWeEM4Vm5ySkNVWVdJ?=
 =?utf-8?B?bEp0S2hWUENiY0lBSndISytvQ3JHb3dXS1YxZXN5U2twMktkbmFaYlJHRjNR?=
 =?utf-8?B?NnU5K3BSckI5SzdLd2U5czJNRDhWUHZGWm5NR1FsMWdRd1RNTVpjcCtsSGow?=
 =?utf-8?B?b2NYVGU2dDVmb2FBV053YWpubm5rUFlYTHlrK0h4YmYwUkRseTF0ZmJid2Fl?=
 =?utf-8?B?cW1kWmx3aEFxb0JRQ1FBYXAwVkpYNXJIaktUbFMzY0w1bndDYUNsS25ES0pi?=
 =?utf-8?B?SnZiTEZaekdhQ1BCcS9kSmNKWGRyRkd3YjlWRHhERmZZTk8yOFZFOFZsbklz?=
 =?utf-8?B?aEFrWFpibXBXMFJmQk1ETndXd1Q5NW1Pdm1SckVJZmNvQVNHcndCMm11VG1O?=
 =?utf-8?B?SG4yWmp1S0VEUnI3UjAycHFQYXJncGZQVkhSdTlDeDNObjBpdDZPdTJxak1q?=
 =?utf-8?B?cmtrRSs1bVpXMFpaemVKYTNJWDd1ZFlyd21BaC9PSHRveVhCMFVrL1lwRlV5?=
 =?utf-8?B?cFpKVzc2K0QweGczeXRqakpRYXhaajlFT3Z3MnhvSmJScnJ3TXhMekExWG9P?=
 =?utf-8?B?QTNDWFB6dCtJTC9zVUttWGcvbXJrQnlUbkdXcHkvUXI2bFprOW42ejhkWWUy?=
 =?utf-8?B?OFdmQmRHSnBhZVB5Wk5GN1hmMlVNYWlBNHlSN2FZaXd6Z01sSTEzUDlNcUtU?=
 =?utf-8?B?SlJRTWV0K3NSclRUSkloRnNDdjBJZWw0aGx4OXNkdzlvSm8wS2RJdEQ5cllo?=
 =?utf-8?B?Tk92WHlxZXhhazU4bWljWXNNelZKSG82a1o4TjZFL3dxUHR4eW1STlQ4WFdU?=
 =?utf-8?B?SXpOa09TZFRmTnB0d2YxTFBjYXAyT2JVcVJqVTErOU5XNHEzV2g0dFczZjZE?=
 =?utf-8?B?dzE4NzdzZEtVcFVrVTh3NmhOSjA3UG9zcVFHZ2VhbHhra1JvZEpDUS84Mmtp?=
 =?utf-8?B?d3JMZ1k4bzJZZFlBdk9RNDFrV0ViVUR5TWNwdkJaekhSaEJZMi82bVVFZ2dj?=
 =?utf-8?B?S2xnTkFJNmJQMjZRclRTQ1JnQW5vYkZVekFKMzhaRnVXSVJrMHF5Uzh3VFVx?=
 =?utf-8?B?M1RlRlBobEV5VFNvWlhWeldSN2Exa0hLQWtiZ1VUV2ZWTzhQelFkeUNzQnV0?=
 =?utf-8?B?QUxPaUlGbzE0MEVnR0psVE1pM1pmKy8ydnY5a2dXQUpYQVROWTB2cU5YYXZH?=
 =?utf-8?B?V2dBc3AwT1RNUzdpUGhGWkc1NGdubUdRbzQ4VU83M2k3YmQrQ2JHazN4b2Mz?=
 =?utf-8?B?S3FneWJKNW12M2pManAwRzE1WUhkWVRWZEkzKy85UytGaG5iT1hGRUt5bTRF?=
 =?utf-8?B?a0lwNjF1MW1tWksrSEFtTWxleERpRDliWE51S21CSndiZ2dtOTY1OTB1UVo2?=
 =?utf-8?B?cDM5TE9sWkdzSGFJaFFVTFVQOFZCMTVoMVUwZm5tZWJKRFFMQTNXMXJ6VXM4?=
 =?utf-8?B?NUFxNW0vY0pVOFVHcGJXVXp4YmFjMFZYUENyRVY4SGNqY2sxVDJaOWYvbGNW?=
 =?utf-8?B?L3N1TjJqNzRBU2hJS2xPQTM5cnhtZHZvcmNTVmhCbnZZSjA1b3lRekduNkJn?=
 =?utf-8?B?QlZEUGxGb2NKWEtrc0t2a0plQ0UxblB0bWVZYXhqanROYi92dm1qRG5tWEpw?=
 =?utf-8?B?b3FJZUpIZldtUkd6R0xBWHF5aEJ4Z2dobWovbVRnZE93OWlsaVBPK2x3OEk1?=
 =?utf-8?B?MHdFS1E0Ty9GL3Q1NmpnVDF4aUxKNUV3NXpmNmh0K2l4dEc0N3Q4MXo2N3pW?=
 =?utf-8?B?eFJ1S1Yydm14Z2RSekZ1U2EwbGxZaFY2SGU0ZGVXcmlWd0F0VDA0QmxoZHhv?=
 =?utf-8?Q?XMcb9Kz+9L73y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXY3TjFnSG9BOGc4bE1ud3JUeDRSM3VTcDQzbXNKbkNBRFNIbFJCM2ptUnhY?=
 =?utf-8?B?K1F1TUYrSk1YUE50Z3lYOTZXSm1LT01lK3V1NUg4VFpQMGo3UmYyeXVZcUEx?=
 =?utf-8?B?KzNmelhTTW9BclVMUW04WDc1VGtDT0hNVWNLSG1XVXpYWXo2T2NrenpvS0Nt?=
 =?utf-8?B?bFMyVTdXZjVPeW1rVzF0YTdnUlRUMTVpbkYwMng4NWN0OHFUVHR3K2NuRzJx?=
 =?utf-8?B?TlhMN2RveGswYnMxYnhhYTF2Z3ZoamdlYVVUNGlDNHV5YTloWDBrY1duWXBX?=
 =?utf-8?B?aTYxUFlERlRieXV0Smc0blpCZUVpUEN5YWt0Tk1WQTNVSjE2V3NFbEd3MkNF?=
 =?utf-8?B?d0lHeUN2dGpiZ1RVUWVORVZXNll2M3o4WmUwVEJ1dzY0RUxrVzZRTTlBb0xU?=
 =?utf-8?B?dW5EWUh6U0JndlFDVTJ0T0ZVbi9yT0tWK3ZETXhqaFdqQ2k2bTQ2SVZ0MFJZ?=
 =?utf-8?B?RTZrZWRWVXRSaWZFK1IvTnEyUEdXZEwzWTFsQytUM2lOanRiVlIzU3lkc0kr?=
 =?utf-8?B?elI4VlE3Unk3YnIrKzlmVVE4SmdDNG5NY1RqTGg3N1VoSm5NLzVGZTZPWE0x?=
 =?utf-8?B?OWRGQnUxT1Q4ZGRSZWZpKzdTQkFQMGk3MThXM0tIYkR3cExwSW1QQ0VjOTNk?=
 =?utf-8?B?M2w0N1ZDOEZEZjV2UUFLUW5LUm01Yy9tazNCd0ZMdzROU1V2Z3pzVmtGZVA4?=
 =?utf-8?B?MDd4K0dKcmNhaTA5Mnk3czNJWGdwTkRMRElSNDJJa2xJN0J3TnB3SjlrWndY?=
 =?utf-8?B?cTBmNUtkYXZ5MjdjR0hrWTFuSmVZSUFza3NEQXM4MHNYZ3hYeEV6dkJodUR2?=
 =?utf-8?B?MC8zWTcwVmU3dW9OSEc0ampIZHBqT2gxVzdTLyt6Vy82UWdJUy9aRlpmMWpO?=
 =?utf-8?B?SCt1aGJhZHUyVkVkMm1Qd2J5T3FYa1VIbnhRekZMdEUzeVh1ckpDUkdUNkVQ?=
 =?utf-8?B?eldFOHJSVW96Q1VTZVB6WnF4K2R0bElncUhsRS9BVXhxVGJoTktMbVpHNEdt?=
 =?utf-8?B?WDNueEVWUUZac2UrcU11V242cmFpa21XbEthU3RtdkJBVHJlRXYrVzZ5RG9T?=
 =?utf-8?B?RTRZdUNaWWFIbEFaWENlN3BtdEoveHZLd2lqM1lzTzZJMHE5V0lmajlmOHh6?=
 =?utf-8?B?azVKU3ZrZlVTR3JYODdTUTg2QWl5Rnl1N0dzdjAxR1VtUEc4VVJYV05KQXg4?=
 =?utf-8?B?WGswOFo1d3daZ29XZFZ3RFBHUDNxeUlMTjRWeCtsZytnaTJqOEpuSElXNFhP?=
 =?utf-8?B?eW5MN0pjajF6a3E0ZFFFVXRXU0xvOWw3K3pqa2NLZ0RZZDNodVpKT0tybmQ4?=
 =?utf-8?B?RHd2Mm1qMVd1NklheFdNWnJ1Vi9kTFVGeFNpcXUrb29DRnVOY1ZtaGZDckNl?=
 =?utf-8?B?TzJMcUJkVWNwbEhKSmhBdVcvaThKbENlSE41Tjh4eC9yanB4NDBpNGFWeHl1?=
 =?utf-8?B?eER0UFBGMVlKc29ZeG9XV0luNjljc0dkTkx3cEZHcmZQWExWVzMzQysrRXFv?=
 =?utf-8?B?UXRnR2lwaWN1VGtSWlpSNTFrMGxUbmUvVzRxVWdhWUtBZmdYbEg3UmNXZk04?=
 =?utf-8?B?a3d5TG9Bd2hRWVZtMFFxV1JLeitNTTNGMERJY1ZDTGZjQW1Nc1hGUkZZL2oz?=
 =?utf-8?B?Tmc5bXhYUVNyY1QzZjBXL2kzbWRGeSs2TDYySS9neGpRdWpYUUJMYWNuSHlp?=
 =?utf-8?B?V09IaTBBT2lKY3VxY1ErQkhJY2FwU1dsSnhNWG9pSS95SlRuTzNTNDc5Z3JV?=
 =?utf-8?B?L3h3aU1WU0Y5YlNwN3hOeWJXQVcycUpuSDFHejcwcU44bjdZN2JpTFovbXdJ?=
 =?utf-8?B?d0lVMnl2MGxMV2drQkd3ekdGbWtvbDdTVCtXcUx1U0lYSGRVMkVYRUlkUXQ3?=
 =?utf-8?B?eFl1TmlhRkNkSzVDYk1DTWpIK2VtajJmbUdTV2owYmo3eCtwaWdPd1ZTOVVE?=
 =?utf-8?B?aVc2ZGYwaDBCK3ZCQkh4Q1llR29rTzdxLzBvazluNXFScmlDWjFmTS8wY3Zk?=
 =?utf-8?B?NEpCb29ieGxwelg5T1pWbXBEcWJKNmdwSzZ3M2VRSEJtSXFZNVBBdHpvdGdp?=
 =?utf-8?B?NWNkaWVTT0lVRHhOcU5nQmdJS3NzUS85eEdUQmNIY3QwM3JEY3RSTXY3VHZj?=
 =?utf-8?B?S2RvbVBCam4vb2MrUDBGUDFLTFl0TFlCbXQ0R0lXQXdvM0FGZkp1NUx2OHJQ?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1178c057-05f9-48ba-1de1-08ddc9d8fb9c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 11:06:32.9919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8UaTXEsXYF/TyJjAXZx5EiOUNuq4E19qooUDi0sfI2n16CNGeEcpopHmvuXLrFMMjgeIVkKXwVyi5dtKlrQCmEOi1T1QydhrAs9eEa+Xd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7575
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

On Wed, Jul 23, 2025 at 11:58:15AM +0100, Paul Szczepanek wrote:
> Don't think I can "elect" anyone but we did discuss it with other
> maintainers during the recent release meeting and motion was seconded by
> Bruce (I think) and run unopposed.
> 

Don't think it was me, but I have no objections in any case :-)

> Acked-by: Paul Szczepanek <paul.szczepanek@arm.com>
> 
> On 22/07/2025 17:04, Patrick Robb wrote:
> > Acked-by: Patrick Robb <probb@iol.unh.edu <mailto:probb@iol.unh.edu>>
> > 
> > I'm not sure whether my approval is needed or not, but for the record
> > Luca has been making contributions to DTS for more than a year now and
> > is very capable of acting as maintainer.
> > 
> > On Tue, Jul 22, 2025 at 12:07 PM Luca Vizzarro <luca.vizzarro@arm.com
> > <mailto:luca.vizzarro@arm.com>> wrote:
> > 
> >     Paul is giving up his role of co-maintainer of DTS, electing Luca
> >     Vizzarro in his place.
> > 
> >     Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com
> >     <mailto:luca.vizzarro@arm.com>>
> >     ---
> >      MAINTAINERS | 2 +-
> >      1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> >     diff --git a/MAINTAINERS b/MAINTAINERS
> >     index 0e9357f3a3..2098a68b1e 100644
> >     --- a/MAINTAINERS
> >     +++ b/MAINTAINERS
> >     @@ -65,7 +65,7 @@ M: Maxime Coquelin <maxime.coquelin@redhat.com
> >     <mailto:maxime.coquelin@redhat.com>>
> >      T: git://dpdk.org/next/dpdk-next-baseband <http://dpdk.org/next/
> >     dpdk-next-baseband>
> > 
> >      Next-dts Tree
> >     -M: Paul Szczepanek <paul.szczepanek@arm.com
> >     <mailto:paul.szczepanek@arm.com>>
> >     +M: Luca Vizzarro <luca.vizzarro@arm.com <mailto:luca.vizzarro@arm.com>>
> >      M: Patrick Robb <probb@iol.unh.edu <mailto:probb@iol.unh.edu>>
> >      T: git://dpdk.org/next/dpdk-next-dts <http://dpdk.org/next/dpdk-
> >     next-dts>
> > 
> >     -- 
> >     2.43.0
> > 
> 
