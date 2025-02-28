Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24540C19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 14:33:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AD3B40609;
	Fri, 28 Feb 2025 15:33:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id C78A3402DD
 for <dev@dpdk.org>; Fri, 28 Feb 2025 15:33:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740753193; x=1772289193;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=hpaiwGlyNyeJ72XXhY9v0GA1zP306h25pvb9s9JtwoQ=;
 b=gYkuXbD9WA1HAT/i0GTyVUo5Vp1O2MwmXcfpR3M07k5hz6o41WaPXJVO
 GZ98eXA1zvRrSsEoQlPdCKnjNkQ++pv66nlHMkjCFt4LJbTkXAd+tNxl1
 0uBmGpqkq4AjpaixGtv9qV+dqeHDShOBRv59iuUwpmoME/isHthczAFQb
 YXr4q2g5AUlXb4sjKW+QuPTVLmPVg3jogWrabv5FWAyY48tEjyP4eR7E+
 fabYULifi8UEJGfLcXGfrd+Ew+AeUU8QHTX7YXNX1vhQFWJ4LXwM/MGgv
 7i+fA4R/Iy3uf6qiCd8WOcYnq9uIcdvWIAoWBeQ+883FYS2p0nAZNKsKC Q==;
X-CSE-ConnectionGUID: xk01IEYxRw2LjOlT4ERWCQ==
X-CSE-MsgGUID: KusD754GR2SZw4fR0XdXVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45334063"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="45334063"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 06:33:12 -0800
X-CSE-ConnectionGUID: 8FvEGRW6TfSR2klTwQBuTA==
X-CSE-MsgGUID: S6fAz1X4TA+xZuXfOocB9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="122588653"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Feb 2025 06:33:12 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 06:33:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 06:33:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 06:33:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EocrGD1Bon9l0rwa1oyfU1l3dRC4oy/eFmvFkm1c57iJK0Aq6C8OOAuWW3QEXBy46kE7gcJzY3wLk6IKjbAXSfu0efNvNUuIgjTWVbCA4AOfVhEYeE8sLgAb8QOgt9who/zPWNDmUilI/o3snZx0lU63vvhJMN0lpVn8SYAcEhPpq59fovdA8kno4SYq/SMg9xOgpEn1d4VfUyZKUqWnWrJL8XwCYhKMqovN5HSU74KfIHnair9PruwfFwSEZwXpEcyeHwjVSIwD5vtYImdZaspguFFLozgc0RMPnmS1EVD1h44YqYIayCPOzuV+MyiSBNsIa9fLdia+NB517TsrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MQoUS6P/a/5kRtdLJNtQogctaybJG1xsrMmSxDCbUY=;
 b=DYXVIlIGzOc1JXrMhYyPOdbvK0/H+zf+c0mQf/az7Cab9q/yn8dUxaN0pSnyyqypRTQTVIzyvrjE4LvWfVK3K/yxedsoM3hw7ht620hF5HCKhyBhaM8Q4HAeDkFhW5dsPRylhcLQvNU/p+sUHEpAmCeqTjbtG+vbq6Y2QALvyFKASHO0S7wL0yP7SuyVI0WOzpC7q4Z4u4uZ6enaMtiZncP7oRPP8nGdWnaTU2Kc1wgtPyTgLueKOIYI82T6sQdOADMqTxXYlUamWUriYd+a/Wu+la/h3qxwNftMvRhKSK+aDA/4YG6+caKMnlgO2bCy7ovMuAe4J3DTI2A9IP6lzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH2PR11MB8833.namprd11.prod.outlook.com (2603:10b6:610:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.24; Fri, 28 Feb
 2025 14:33:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 14:33:09 +0000
Date: Fri, 28 Feb 2025 14:33:04 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 2/2] devtools/dump-cpu-flags: add tool to update CPU
 flags table
Message-ID: <Z8HJIBSXK8Um_YYa@bricha3-mobl1.ger.corp.intel.com>
References: <1740707537-10517-1-git-send-email-andremue@linux.microsoft.com>
 <1740707537-10517-3-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1740707537-10517-3-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB6PR0301CA0073.eurprd03.prod.outlook.com
 (2603:10a6:6:30::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH2PR11MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd45099-3b57-4bf0-239b-08dd5804d280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjgyamhKRVlpaDdQTzJIZ3pXZUYrRUFFYk13TnJudy9xd1l0emcwcVhObnJh?=
 =?utf-8?B?dzZRdTBPMU10WmRKMitoaUJwTlZCV2k3V2pWNmNVUktSL3BuSnhXRzJCUk5w?=
 =?utf-8?B?eENody9hZ2E2aEtMTVNrUjAxMkVOZkdpR3hUcGxHQXMySGIwTnU2N04zdW93?=
 =?utf-8?B?Znc0ckdLd1lOdi8yS2JqRjN4R3RmNkFrTW9jRUdVMlYvMjl4cHBGWm85cVB2?=
 =?utf-8?B?Q2JGbFgwK3d3WncrMnZrdFl3SUdxa2xvY3BhbUJpQlkyMUgxQmxiOXhSdllR?=
 =?utf-8?B?VmhaTDhybFJXV1Q4bGJ2dllqZjJ4bVJKS2poT1dVS1JWV09LWHlwTmEwRVdU?=
 =?utf-8?B?T1N5eW5VWGhuUDV5S0VaKzFmRkFkTFY5VzhaUUZiVmErVXZwVTBIZXQ1WVJj?=
 =?utf-8?B?UTNCUlBoVFpwcHZ0Rm9lWEJudHczRVVJTGNrS0V1T00wWU1ad1VIenc1NWRV?=
 =?utf-8?B?VW0wVzdONklTeFhHQlpjWkY1L1IzU3VnWEFCZEZBUE1TQk9jUHVodGEybjFL?=
 =?utf-8?B?N3dEVGxJT3RoUDBTS3Q1YTVsWGpGM3lSUFBSUlk3LzdlSDhnNDc4REZmZXBZ?=
 =?utf-8?B?Q2tnMHBQWWhLbDFqSG1MUTdZTklRbWlURUFBWHZ0ZkZTT3RxQi95WkZyV2lE?=
 =?utf-8?B?QnUzUnZYV0k4TThhZGYwVHBwWElpV1VCVFh4a0pDblBvMzdwQjlDVXc4WXFm?=
 =?utf-8?B?VFEvUlhKUEtIU01jQWhCemFCMXBnZjZvMGNhUy96LzAwY0ErV08xSHhVWlV5?=
 =?utf-8?B?UFJMSEE2NDNDc1FNVUFRYWJHMnZxV1dTRTZzUUd1TjNHdkJJVGVrMmU4MWpo?=
 =?utf-8?B?TWY3a0dTVUxCNkVDMFlWcmtMakNRQ3RDZVNxUU9pMFRSRUN0b1hXcDUwZnVq?=
 =?utf-8?B?akovYmJ5VzRXdXUrT0oyTU5xdXNnaWh4aDNjT1g4a1N6YlBQcnBqeTlGMWtG?=
 =?utf-8?B?NGZIMnQ1V2QxSHRpTmxqUnZJOU9xVk9uUDBOVDdRcHF3dFJNNXhSVWtNM3d2?=
 =?utf-8?B?ZitUWVR2eEdTY08velZ4NkJ6K3RhTlVEYiszUkNpNUg1M0tsdUk2OWJSV2x1?=
 =?utf-8?B?cVZYVzV6UG5WbXlCOUV2WTV0M0tnb0xlZnZ2SXR0dXRiRWhOUXFBS0JyS295?=
 =?utf-8?B?Wm5vYnFHOE1VaHNnYXBKWTZoRDRWTExZVFFwRnZZUmtrNVhKMXg4MFVieVcx?=
 =?utf-8?B?dkNpaHdtQXlxZ3FQTE9HODFzSllzaGRLeHlrVHFZTWxEaVZDN05rVjlFc0NX?=
 =?utf-8?B?Rmk0NEhBcGcxcHE1NC9sSDFJd1h5eXEzeVZFUEs5T0ZDSkV2UU1obGY1bWxG?=
 =?utf-8?B?RVFNWkttUExCZEZ0TkZud0JCR3EwR2FUYXJsdXdjZFVjNUx5MFUvK1hRNHlj?=
 =?utf-8?B?VCtSWGxUWGVUNU4rQ3RUZTZGdlJ0VEowTDc1M2pZb2JsYy9URVluZjQ5dE5z?=
 =?utf-8?B?Y2M1SVZPRWZsMUtmT1lreTM4eE03TWJxc1htQWNTcml5dWhVUndraEtuVDNp?=
 =?utf-8?B?NExrY1lmajVoelhmb1lmaWFINFZVSDJLeXBILzgrb2F2MEkzOWl0U2hLL28w?=
 =?utf-8?B?SFVPL2JQY1BBVWdzS3BhNjdWYjZGYm9XOWNubHpiZzFHNmpnRHRWa3I2bnZh?=
 =?utf-8?B?WnlwNXdodjltQkN2a0d3Vm9oZ3F5aE1sQjBELzcyQWY4dk1XS3V2UnVVTnNV?=
 =?utf-8?B?UDRDaXEzK0xTSkF6S3lGQ1k2ZVB1VDQ1UTdkMjJIT1lHZ1ZXblFpaHlsd2p0?=
 =?utf-8?B?UjdlMzRJT0Zpb3dpSTNLWXFUS1doTEdOZDU3ZFNhVFUvemJjTUQzZHpjWkwz?=
 =?utf-8?B?Z2ZFVlNuMnhXZGZZU3VkQS80aWxubVdjZkl1a01kK0UvVzNQOVo4Yk9lZzJV?=
 =?utf-8?Q?FWLW5pzyJp34j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXBiL2owVm1xYThuN1lFYzBWdHU4V1FQMTdDU0lHMTZLUDdCa2g0L3ZNaDNP?=
 =?utf-8?B?M05tWnorYzJzK0JkV3pObFpVanJDNVFrTkN5WEM3S0R0Sm9ETzA3OUhtMWhP?=
 =?utf-8?B?eHpBbVJyeEpCL1hSQjBqYlpUZmVoVXU1ajVCNmFNbGdWUEViVnc4QWFPTjhp?=
 =?utf-8?B?STQwcGRnUnNxTENDSk9tNkVzcUtNd242TzFsdmRmN1dhdW8vYlVjL2RyR2E1?=
 =?utf-8?B?OXZrU3A1azFUVWJzYUtqUFVWVEhRVDVBeHg0NVZvQTM5RC9SWXo0SnlZL0ty?=
 =?utf-8?B?K0dsckNMd0ZnNmNNYnF3aWpKdzBvVHZtcXMyNXYxc3dtYno3R0pVZy9VamMr?=
 =?utf-8?B?eWt4cWRxdGdUWHJvVHQwaVhjZThOcU5TcEd0eGlKMkdGRFpKM0c3NXU1R0pY?=
 =?utf-8?B?QkVnOVFTeDZLU3BpSktKMWVoaVRkZ0p0OVZjQTQyOGpnVW5Ea1E1dTkzbG5u?=
 =?utf-8?B?VW1NUUtqNGZNejlzU3VuSjMyMHdoOU0yWURaRTBGVUZIc0RMcWtEUFU5R0Q2?=
 =?utf-8?B?VjVUVW9lZktoR1p3V0VDcklZcHhKaU9nK1U2ck5ld2t0WHUwenUraXRJSWtp?=
 =?utf-8?B?WXFTMnQ3VzM4anJkckdhcHROdk9Fckh6R0s4a1pNSDdxVGd2QngyWHlsb3NM?=
 =?utf-8?B?VzA3NTVxL0pjTHJqNjdFM0JxZHZQdEFRRFplc3pXUW5yZHIxUFBRUXNST0hU?=
 =?utf-8?B?Y3BqZENWdTNkTWk3VzhnMXJnakV2ekgyR0hEQXBDSWd1Tmh2aWNaeXlFa3FX?=
 =?utf-8?B?bGttUll6aDBrK3NIMU8rc3U1RzNwZU5mS0R2Y3F6ZGlmemxaZDduaERKNXVC?=
 =?utf-8?B?ZzFUdXhZSW1ZNUdkL21Qd1VkZlhZZnN5dDlxK0lyanViQStBVXpwMUxZU283?=
 =?utf-8?B?aEU3T3lIc24yUFhkOVFrYUp5OHBVcm1aV0ttdEdWcnd4U0Z2Q0tpT1JXa0RF?=
 =?utf-8?B?eStreUt0TkxhU1ZyeHdlSDZ5Z25tcldFYXZZQ3N1dGZoK1NGWXlUUTJwU0p2?=
 =?utf-8?B?Z0l3VnA5dTZmSHFhOFdlZk5yTUtGTDNiUE9XMW1TT1VmWkhKS0F5T0lmeHd5?=
 =?utf-8?B?SDdxeTNUQjI1c091RC9Kd3IxUjRFanYyMkx3Z3BueWpoVDZUNHVDdzNjWEJZ?=
 =?utf-8?B?dWpkOUxFdisxRU1JWm9EbTRsUmVUbG96Y3NwRlNWMzk4RWJTKzJqc0JXWEdz?=
 =?utf-8?B?WXpETGk0ZEk0QmZ1Nmh0QjhBbUtoSnFRWllvRkpvZUlOYWdzSFhlWTZvejgz?=
 =?utf-8?B?dFRzNWxTWmhLcFhkbjh1L2dwRWhpc1liNHREREYyWWZHZ093NTlNdk83c3VJ?=
 =?utf-8?B?UVo5UFNqU29aVWtGWjV5V3Nha1NXY2xVVVA4YTdtd04rUWZvQW5lVWw5aU5C?=
 =?utf-8?B?RThBR0E3bmVQbVBTd1FNU043d3U2YWpyZ0NtM1VEZDAxMEkvQWJnZTMvamVu?=
 =?utf-8?B?azZla1hJOWtMaVorNlkweWhhZGdmdExpUTNBMS83c0prQWVuMzJwWENJQU1T?=
 =?utf-8?B?ZVM5NE81eWVYbEhhSTdxNUR5SmI4MDdycWFheWs4dk4vSEhJa3BZYXFZbTR4?=
 =?utf-8?B?UVV3RDhnWUZlVEcrR2NEMWorWWJoUEFoM0wxb25lVHBubmFOK1NXS0dpdFN3?=
 =?utf-8?B?Y21MUXZ6eDNTbFU2Q2hlK3EyNnMxYTljUkZ6WDZwMjltZW5NVTY5WncyaTRr?=
 =?utf-8?B?OEVvYlNJSDcxS3JpZDNZNXBkUE5TNXk3cGtjWVRyaGNqV3VVb1ZYd2V2Z05E?=
 =?utf-8?B?dmFGZFQ1WWhzSWtLM0phNmJqVjl4N21LL01DdTZpZ2k4WTIyQW5uaFNOYjZa?=
 =?utf-8?B?TytpM2RyRHJsZ09BNjkzUnFpOWp3eUlRSEF5enpRMzRVVFpxVEM4MytMZVVs?=
 =?utf-8?B?MnB5T2hUeVFQMVRjR0JndHZBRWxYMjdmUjd0REdMVkpGNGg5Y1ozb1hXd1Vu?=
 =?utf-8?B?ZHlUS25QZEJGR0llY0pJa2d2ZFdQV3NzdUpBQUMwZ2U2NnQ0c1Z6SnJtNFhN?=
 =?utf-8?B?QXU0clRlcktMbWNGTk4xWDI0Y3VSa2hPZXZaMmVUSG56YnYzYzVaQ1UwSWx3?=
 =?utf-8?B?VDZFTzlyMGVQUysvZXpwTUdRL0t1S2FVYUI1NnFFY1NkQW51cTVSL2RxeEJ3?=
 =?utf-8?B?QWR4akFxSzVTUFdxNk9rQmZCVzlGN2dkNFVweWpMVXl6Y2RRZ2U0OUFWcFAv?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd45099-3b57-4bf0-239b-08dd5804d280
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:33:09.3564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9QLLIv62wNwHwnaVtyAGOco8BHstHWPqzbeOlyfttxQVCWuqI05dgtd3yZv9e6WLGXTUUQlSFAxrymp0nLr3AU3wMSP+qxG6oWguCftrNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8833
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

On Thu, Feb 27, 2025 at 05:52:17PM -0800, Andre Muezerie wrote:
> This patchset allows users to specify the CPU for which the generated
> code should be optimized for by passing the CPU name.
> 
> MSVC does not provide this functionality natively, so logic was
> added. This additional logic relies on a table which stores instruction
> set availability (like AXV512F) for different CPUs.
> To make it easier to update this table a new devtool is introduced
> with this patch. The new tool generates the table entries for all CPUs
> listed in an input file using a recent version of the compiler, which
> has all the information needed. This reduces enormously the amount
> of work needed to update the table in msvc/meson.build and makes the
> process much less error prone.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  devtools/dump-cpu-flags/README.md          |  25 +++++
>  devtools/dump-cpu-flags/cpu-names.txt      | 120 +++++++++++++++++++++
>  devtools/dump-cpu-flags/dump-cpu-flags.cpp | 119 ++++++++++++++++++++
>  devtools/dump-cpu-flags/dump-cpu-flags.py  |  41 +++++++
>  4 files changed, 305 insertions(+)
>  create mode 100644 devtools/dump-cpu-flags/README.md
>  create mode 100644 devtools/dump-cpu-flags/cpu-names.txt
>  create mode 100644 devtools/dump-cpu-flags/dump-cpu-flags.cpp
>  create mode 100644 devtools/dump-cpu-flags/dump-cpu-flags.py
> 
> diff --git a/devtools/dump-cpu-flags/README.md b/devtools/dump-cpu-flags/README.md
> new file mode 100644
> index 0000000000..3db69f9f8f
> --- /dev/null
> +++ b/devtools/dump-cpu-flags/README.md
> @@ -0,0 +1,25 @@
> +# Generating updated CPU flags
> +
> +File `config\x86\msvc\meson.build` has a table with flags indicating instruction set support for a variety of CPU types.
> +
> +Script `dump-cpu-flags.py` can be used to generate updated entries for this table.
> +
> +The CPU names are stored in file `cpu-names.txt`, which is consumed by `dump-cpu-flags.py`. The formatting used in that file is described at the top of the file itself.
> +
> +The script relies on the information embedded in the g++ compiler. This means that an updated table can automatically be generated by switching to a newer version of the compiler. This avoids the need to manually edit the entries, which is error prone. With the script the table entries can just copied and pasted into `meson.build`. The only thing that might need to be done is adding new CPU names to cpu-names.txt, when new CPUs are released.
> +
> +**NOTE**: CPUs not known to the compiler will result in errors, which can be ignored (`dump-cpu-flags.py` will ignore these errors and continue). For best results use the latest g++ compiler available.
> +
> +Below is a sample output, where an error was logged because the compiler did not know about a CPU named ‘raptorlake’.
> +
> +```sh
> +$ ./dump-cpu-flags.py
> +       'x86-64-v2': [],
> +       'x86-64-v3': ['AVX', 'AVX2'],
> +       'x86-64-v4': ['AVX', 'AVX2', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> +       'alderlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +cc1plus: error: bad value (‘raptorlake’) for ‘-march=’ switch
> +cc1plus: note: valid arguments to ‘-march=’ switch are: nocona core2 nehalem corei7 westmere sandybridge...
> +      'silvermont': ['PCLMUL', 'RDRND'],
> +             'slm': ['PCLMUL', 'RDRND'],
> +```
> \ No newline at end of file

How about having the tool output a valid meson.build file, that can then be
used directly without copy-paste. While I know such a thing would end up
with us having deep subdir structures, it could be just loaded from e.g.
config/x86/msvc/cpu-flags/meson.build, for example.

/Bruce
