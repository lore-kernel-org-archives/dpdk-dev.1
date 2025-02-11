Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90546C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 13:47:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A12440156;
	Tue, 11 Feb 2025 14:47:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2832540150;
 Tue, 11 Feb 2025 14:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739281672; x=1770817672;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=1aCZDQN6PQ8OzVxP1RmDix0vO+a0sdUSmBHqQ2GRKEU=;
 b=mpL7Y91v6PhAPIv80LpEGPv9HAIqreRM+OSGnXbt1gjUWzeX0GO/ZK3s
 g6rC+wSN/PrpL91bJGPlA0mstEh7OnfLVUuNCEwxXu9a/2DL0DcPfPuZ6
 JHyMhoAgMjo0NenOUGLzjdCDSAtQvN5goerGCMvVhXU2zWN1mPD4nsHA5
 DaUHKIBFA64tldfEoxjjKb417eCGNVsGhMlsKGFWtltSWMX5mkIDF0tOe
 UkMNS2JTSsxnTfLcWYpxd/w6tC6SZysuL60o+6uI9ZASJtpmCMzJaNqrL
 3HHXToKEj1VtWTSQhqFho9HDqzmiIjXZZ250vzLexHe4ASbABqeI9WfrO g==;
X-CSE-ConnectionGUID: Rcl+jAbhRTurM0/QhwIGWw==
X-CSE-MsgGUID: hx31KwQuQEm1LQ6qTKBBNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="62368682"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="62368682"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 05:47:51 -0800
X-CSE-ConnectionGUID: k+cmXkb1QAetV1ikGEgd7w==
X-CSE-MsgGUID: iFL5u4UXSPCNG6cCeCXR8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="112283257"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 05:47:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 05:47:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 05:47:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 05:47:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4o6tjulrNIciqP0lW/+hupKJ429hbKHTjzljRJQQnwGd28aJx0zyE4lrwj7pO4BBIcfUaQOUx5KaZjUSKWRxgqdhSgx2EY7t4CbkJozZG+P11RSWXyR37z+mryjU2fnCptC3ex6bUsUlecvpTvJDnU7lLgYu6ppmJqhHxzO3wcMQa7xyvzkoqwc6ldF5U44hWAjzhiSjM/pe7wKTAggSnvNIlIWo5F6eKg4VUfRHywvRx5cMuZC45h+nylzh756APxQL2VAbzlY0pPb7v4ToY45M+ozSkv6rvBbPhCSF5DK/lnxqU7kzMDxy00mkjzwtsP1TUBfCQ91+UFCoIBVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4qbKnNSXF39Hdzr9oRxcLBNHJRPZ7jwvlyNmmreoNo=;
 b=rUeEf2dQIDrnXSCuaykrYb2vDPjur76CQf4sUf4wChGCFHLmwxrx5BeG1JkADH8HAAwMrx08S0AatSKFv1+HCwOi6UDZ7hPH1uQuN5vNdjUXOpnSIqV+9B9YicjwDbpEsSTW8jTZABly+3MlOZ0MwwWnR64DNAAt9ODuwm0ZM7LpuHh3qEJD5Ut1jb1J8KsZIA5OrBexuB0LC4uqIQhd9G/uzu8u1aPSN82OOnS6sk+0SDzkw0Bev38xJeP2g6NXYG2GVzcRG2ZtzOoBvp06fl3CVHeQQGK9xdwwzmRGerko+sPlqys+MHWHg2FjdOYMd7jkA0scNJ3DSoqQZzkreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7426.namprd11.prod.outlook.com (2603:10b6:a03:4c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 13:47:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 13:47:20 +0000
Date: Tue, 11 Feb 2025 13:47:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Kevin Laatz <kevin.laatz@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Kevin Traynor <ktraynor@redhat.com>
Subject: Re: [PATCH] dma/idxd: add device ids for new HW versions
Message-ID: <Z6tU4__d7z7Nsxoo@bricha3-mobl1.ger.corp.intel.com>
References: <20250130172624.1450975-2-bruce.richardson@intel.com>
 <CAJFAV8zTpB3EzZJeb2mpW0UqAfaMVjBYat7L+pLaYYpYwcEnwA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zTpB3EzZJeb2mpW0UqAfaMVjBYat7L+pLaYYpYwcEnwA@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0175.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ffce07-9930-49e2-1f7a-08dd4aa29ad2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0FFR1VvNGNXV1dmWklPUTgzZEdzYUpFZys0RVVmRC9zSTQ4aEpja1VURzI4?=
 =?utf-8?B?ZWVCSkJSZk5TQmI0c3FDNk1IUWorY2NMNGhxK3JtV2wxRkVDVVdiMC9ua2N1?=
 =?utf-8?B?N1NiclRPVEJmQ09BOFhsT2xiV09VR0RHZWVrZ0xQcEtva05ibENueit2a2Nk?=
 =?utf-8?B?aFFyQ3NOaCtZSkdLVmorMy8rQlFYejNXYVlHdC9mdmd0RlAvM2ZXdXp6UEly?=
 =?utf-8?B?ZkdiUW9SRDF3Zm50bmxlUDJXZ0o4Kzg0UkVJY2JBTU5FRmQrY3o3cUNINGtB?=
 =?utf-8?B?VXdTSlN4MUt6cFZ5R3crZ2NQc2gxTCtuRW1ZQ0duTGFxQWptMEZUdzFoVmRT?=
 =?utf-8?B?ZjRSeDNKb0lydjd1VjhQbDFuN0xHUnUrQ2h5N2VkdFpMcnZPREFHSVpqNW9N?=
 =?utf-8?B?ZW9Fb3NSdTEzMUpaSEtkdEo4aGVqRFRLeUFUTENDQ1FsYUdneTlVb0hYK0pJ?=
 =?utf-8?B?YkZQZ2J2V28yWlhrMXB0V1JLTDRVcUtRRk5HRkNabGZ0cW1jTXlydWZ2Q1dB?=
 =?utf-8?B?aVVwdmtja2hxUmdVWVhlbTdwbi9iNWVOTWF3Z1hkRjdKQW5ndVErRXhnWkhU?=
 =?utf-8?B?YjE5SWkrK0NRUUV6VThFUkJPdytoNEg3alluYjVhY2pmYUZjSXdTS09TVXVx?=
 =?utf-8?B?djBmLy9MdVZnNUN1UmhScE10STlLcWMzY2pSdStLOFVQQU1BOGtkU3hSVEtF?=
 =?utf-8?B?bmhHQXh1NURzU2ViQ3IrYzBuOTdiaVBJVSthZ2VpUHBIQlBESlhFTm9OYjRL?=
 =?utf-8?B?OUw2Y1BzS2ZNTzF4elhDcTdWSkZ4YVJrWFBKYVM2M2lndkloOERtb09IY09h?=
 =?utf-8?B?TkpIZlZEOUJaZlBQMU0xMzhZdzNRRmxkRjBqdU1FUHNLczdrRWpmVEZGY1l3?=
 =?utf-8?B?TlFyOHJSeGVwUDFnUTRDek96WTVocTFwc2xJcEpsNkVPSFBRVHdDazBWNGJ0?=
 =?utf-8?B?S1VkQ041d2plOFdFMDYwbDFwSXE0QkpITzVKUjJvNjBlYWVmSHpwcjk2RzMr?=
 =?utf-8?B?b1lmOXYrV1dVeWRoMGRDeldLUjQxb2d6ZTNoM2s5K1pxZTJDWS9LdStaSkow?=
 =?utf-8?B?K0dMVERveVdTRzJvTnlreHNFQ21zV3FRR0NlaUNTZ0ExZWVlZTRlSW0zcTl5?=
 =?utf-8?B?eHpYb2hib2QwL3IxcDNlN1pQWFlsemxHNFFuRG9EcWRlVzdlU1JrbmpoRGpM?=
 =?utf-8?B?dEpKNnRNeVFYdWdha1dYcU9QbHBkTElETnF2UTdyL1RGUDM5cXBBMTZUVzZl?=
 =?utf-8?B?VDV0dzB0QXc0dE1DeDhhK0JEV1Y2RlVUL3BHa00rK0pKRjdkS1NoNXhEVEpz?=
 =?utf-8?B?SThBNENPbTc0YnFmNm40L2hXZ1VtN1BkV2xDTVVlOGZsS1lHQnB3MmVQaFBh?=
 =?utf-8?B?ZmRvWnR0SVhPcGIzZjVzS0QxUG96UHpFNmxHZVcvQ0RzVG44TU85aHhVZDIv?=
 =?utf-8?B?SDdjN01tb3JOQXZhYWFaRWpXblF2M0ZIVGhkQytZT05oaDdvWmpyaGhuakMz?=
 =?utf-8?B?RWpYL0lxdDJJb1kvUmVobHJmRmk5NXNacnFGYVBSY2srSTVJeGNDQnpHRkE1?=
 =?utf-8?B?VTlLeC9mVElyWnVYUGRkR3lhWnRhc1kvMnZLZ0NjSk9KY1M5blVQa2kzaXI0?=
 =?utf-8?B?MTd0N01ia0Q3Zm1PYW1tdW04NjBNanpWd013NGNWMkkrcmh3ZDVqYkZrY28z?=
 =?utf-8?B?ekl6eGFPUEZObnhpdUpDODc2Um1nTkJHUCtsMitOMWF4L05xamZMc0IrVG1w?=
 =?utf-8?B?WmJSdDZYNVVhaEM2L0xqUVkycFptNXRROFMxcHlyMTIxM2U0WE4rS2JneUZK?=
 =?utf-8?B?OXNIaVJPWFJKMmgzOWcyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anF2WGs1SXBkWEpUbHdSRlg4NkZPZXcrZ2FuL3h3Ym94WTZudnc1ekMxeHFa?=
 =?utf-8?B?VzBRaDhEN0s3S3dzNzdaK2luamIva0ttSlJMUXNHd2dKREh1K3FNdzY3Y0lu?=
 =?utf-8?B?SVFVWlJXWHNidjZ4RWNRc2FUMVJ1cU55YndxcVBSMStLK3UvMTh5bnJNTS8r?=
 =?utf-8?B?SFZ4WmVsU2libHZHQ0hVZXNWOElIY2dQUS91WlZMSnlEanFJbzJGcEQ3dFBl?=
 =?utf-8?B?RWJkMkQ3ZzFJOWcvN0tTelhpM1JDdDNjbm5ScWdEMjVxLzZ4T1NWam92U0Fu?=
 =?utf-8?B?RkdHQ041WWowQlpxb2V4TEI5RDZHbHBlbVNvZkFVaE5GZUk0V1RkeUU4Vndz?=
 =?utf-8?B?bWdzR0F4dnNBVGZJKzNHeDV3d0xrY1dtTDdYUHc2UnU0RGpGY1BxcmlESm1s?=
 =?utf-8?B?UmdrL2pBZE1aeFNDdGxLeEFiamVoQk1EUUNkeXBYSU5BYmVnL2NIZlNnS05C?=
 =?utf-8?B?UGVnT0MrRmtJUkhsSzlSQTUxZElJemROTGxLamRRbVhvTDhQdXdyRStvRkRt?=
 =?utf-8?B?OEw1Rndqb0VlVXJaZHM3K3c2aWFrWWpKMUl4SUpHdVVkTG9CbGR1SWVTbVdU?=
 =?utf-8?B?VWcwdFQzSTJWMzVlZW9nc2RMOTZSWFZDd3NhZThKMmkxaERtek5XRW9uclBs?=
 =?utf-8?B?dGdBeEt0TmVYOUVTQU5OdXVtcjg4L0hSM0YvRzNxLzJNM3J3aVFuT3N6SUNw?=
 =?utf-8?B?SGNYUFBjeVQ1R2dEVVdRR3dqc3NMN1l6ZXd1T3JFbW5UY2orN2FoTURGMEZZ?=
 =?utf-8?B?VHVKRHBGdTZneVIyY2Nydlh1WHRpaG9WTUgwU0ZORUVVSjFrN1dxR3d6OXI1?=
 =?utf-8?B?QUo4cVNQcEw3WktuRHZsM0E0TGNRYVdYVUlJMm9YMnUwbDd5cjFhQ3pTNHp4?=
 =?utf-8?B?MWJGZkRzN0o0QjRFSWVmR2tyTUZKajNKd0NvOHdnc2xielB5VDFQY1QrYXFY?=
 =?utf-8?B?ZGNLMXdWQmJLVXJSd2ZzVVJYcVJUcUhoaldVaVRQWExyd0RlZnJWYXkxeU4r?=
 =?utf-8?B?WjlRU2R1YUVaTzZIaXRLSU1mcU13ZHRBd2JCbE9JczZpTnVNUFlEQzQ2Nmpv?=
 =?utf-8?B?SUJXTnkwNGZzUVNHNDZ2YmFQaEtaNFloRGVWS3htdU5VS3BkRjB1YzBkUTZt?=
 =?utf-8?B?MUxQZW5ZaEtOM2ZxM0RQL0w1cmtkbjdyNEJoMFJPYU1rWTdFaGI5eWJvMVZO?=
 =?utf-8?B?MTNYcnhHK1ZIUVhLMDlTcXdrZjlPejIzR0VqWXpwM09USGhyaFdjbG5KYVFq?=
 =?utf-8?B?ZlY2Zm85T0xuay8vRlk5TUFaRHVpNVdocm9zWnBCNDI4RWhEdUNUTHJpQkRL?=
 =?utf-8?B?SGRMREkxMzZwclJiUkVIMFJnOFBZczd4N3J5VGZCN0ltaUVQZEN4bGw0RFlp?=
 =?utf-8?B?TlowWDZYQ1pCSUtieHk5RldWTk4ySHoycVdYZ0pxVE5iRHBmNFpOc3BkSkg1?=
 =?utf-8?B?L3Q3eXFiRkdXUmErYnIydnRoWjBZSzVraXRrNEE3YjZLWE5qbWc1RldxZDcw?=
 =?utf-8?B?NGg5eGc0U2pHSFZtNVpXRUlqbGc0bnp3QVhJeXV4azB0bWlqY3VlL2wvSlhK?=
 =?utf-8?B?OFozWHU2TExtV1dEelgrVldQOEpaazJmZWQzS0UxNENzV3ZYVWJUcUVJYXBP?=
 =?utf-8?B?SllSZFA4NEh1S09Kb2gwbTRVY0xnbGhrQmhXa091aGFCbllLWWlTYjhjWTJF?=
 =?utf-8?B?MlNSaE1NT2M3WXFpS2lkeisyTzBxTFlka2ovTk45SitMRU5oR1RuK3R5Z2pN?=
 =?utf-8?B?SnlFaVQwYWlEMlB3cGswaEEwNDA1RGpTUmkrSTVLeVlSOUUxZ3hQWTJJekR4?=
 =?utf-8?B?L2hKWlpkMlJERUs5Z1RtTWhOK3d6TWFRSUQxRGJqSGJIOWhWcHQxRXhPbkRR?=
 =?utf-8?B?NzNmVkIwUkdqZ1JxeFllTDdIdXU4QitPM3RCOGd5QUxuSlZ2SFNqd3FUUWNq?=
 =?utf-8?B?bytuUi83NGxpUkx5ckVyeExDR1czaEZxZUFJZlJaQ3BzUVhsY3lyM0Vvd3Vv?=
 =?utf-8?B?VGx4eUdlckQvNHE3YUlaalV1NEp4VGQ4Q2VJTGZDZlZ1R1cxam5ON2dad1pt?=
 =?utf-8?B?RFNOYllaMVhYb2VXSmE4NU5MOUFsNnIzZDkvUnQvTDBzb1Q0blFCcEoxdXg4?=
 =?utf-8?B?MkVkcVYwMzBpaGgrSEZXMXVmcGt1bW95ZkhOZ3NmTWNwMmQ1OUduQ2RvMXBt?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ffce07-9930-49e2-1f7a-08dd4aa29ad2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 13:47:20.1750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3DWuCLs2HCUB7u1eMWWRe198W+O3UjSo1GvXZc7bVxENDQnP2PfnyfCuAp/MGzIz44poSUHZaswmfR+27i7Aaqdn8WwYUsijgtsoqA0s10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7426
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

On Tue, Feb 11, 2025 at 02:20:51PM +0100, David Marchand wrote:
> On Thu, Jan 30, 2025 at 6:27 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Add in two extra PCI device id's for future HW versions to be
> > supported by idxd driver. This aligns with the definitions present
> > in kernel idxd driver [1].
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/idxd/registers.h#n9
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> > Cc: stable@dpdk.org
> >
> > Since this only adds a couple of device IDs, and there are no other
> > changes to the dma/idxd driver in 25.03, perhaps this could be
> > considered for backport for 24.11?
> 
> I prefer not to mark with Cc: stable@dpdk.org, because this is too
> vague and LTS maintainers may apply this for 22.11 or 23.11.
> For this special request against 24.11, the simpler is to send an
> explicit backport request to stable@dpdk.org with a 24.11 prefix in
> the title (and copy Kevin, who handles 24.11).
> 
> Patch applied, thanks.
> 

Ok, will do.
In practice, I think it would be harmless and work fine in all the
older releases, but I'll just target 24.11 for safety.

/Bruce
