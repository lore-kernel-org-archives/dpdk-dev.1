Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2157C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:11:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8943340DD3;
	Fri, 25 Sep 2026 12:11:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3939340BA6
 for <dev@dpdk.org>; Fri, 25 Sep 2026 12:11:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790331088; x=1821867088;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ZhPRd5LrsaoHuXmLv8URz+TpeprT+fZOBaePKfDgx/w=;
 b=bRgK7Mkn20z8BoqJg+p48er0MuSPT1th84c8DGgez474QJ497nMb0tvt
 DVONyu9OglCQ3cKdZwyKqsrFAdqN7sALYHGw7960PR/uKb54lHKzIViFI
 8n9BGoU/Tp42iFe+KWRlnaR4D1FYEdXkYN/m7UbMFd6Upy3Lu6GfAZuf0
 gCULxAv4Jl3IJqFL72TlPptggZafxi1RcA5KE/RMNJY+83DSPqR8UPuFw
 HuAmZF1Pu8MUZ4ay/W2zxVppXfAH5tXPJQSdtI2mS+OjvUHynocI9XtdU
 gqNY6vcAau3CvSHcg6f9s9FE6A455UmTlGi875MzOSBFH3Iq3/0yBx/+B g==;
X-CSE-ConnectionGUID: SYq5aXLASyiLfNeMSw/0Kw==
X-CSE-MsgGUID: tSip2VfORU+ro0yFz8m2EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89882839"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="89882839"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:11:27 -0700
X-CSE-ConnectionGUID: ekFP1QR7R2+hNMtUrY8F2Q==
X-CSE-MsgGUID: QqZvlT3nT4C268/IaQPYcw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:11:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:11:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 03:11:25 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:11:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLUlVNIB/JZsm7Qja9rl1ZotACkLu1pXqxHw+jqntNRXknUrdretMuHEzfMm8aXzN2pyLgjfS6qOLgS40lty+Uiz30Ut3ey5WfoIR7f0fZk9tSU/VfoFZHv/4ZnljPkRkzDM/Cb/zsUvSltNpCSnBjuw+jVPEzpOmWr2dZcnCD6WbcHs3ZAYwgvTyHqqHJxdVWaAU0T45XFzfRhAoEF4q+ZQG75a1J8QwP2kahc3WqCcOTWTmPLyde7nAseF7ZkWTd/KykIINahLDd8Emh72/4i7d9P0vcapeUm56oHpkYMxLk9awOPRArqXFHT3nSTZ+KfAL12yeELzkMmNY2SvFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flMxGzitCFTwnQ2sdFBdJKs676n6zsePaTFToL0SkqE=;
 b=y4tb0Rrin2D9tMK8+tedmpPhiCCiTLmRtM4S8s4uqMeKhwZDOU96WzGacdbFLJHPqre9eXd1x+xlKKhuspRwJ/XkdqXAI1v+7mTjaS4Lv0wa3yAatKvEbMmm2IO5jXiEzM6GxJqUT4JIz223WlH0xRPCWW37+mCY/JTs9Z92cJnp2vNLf5T3eF8b7ni12Ks0d5F7pDYdlwrdkXN5jO7gpSS/B5ONaJfTmGDreRUppC7YJqp/wNln2jlAWamyxuN8NiPikcHRl6H4yAhBc7vcaC3/wb5jg9/haQPAqj8CeTOoCxeJSI3oWwuTDPFvCRbR6Hikw4u7PhMurXWyqCc0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA3PR11MB610523.namprd11.prod.outlook.com (2603:10b6:806:589::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 25 Sep
 2026 10:11:24 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 10:11:24 +0000
Message-ID: <63c4f57d-d560-4a7d-8eea-753e7b823a6a@intel.com>
Date: Fri, 25 Sep 2026 12:11:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net/i40e: use common AVX-512 Tx function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260923135146.3527913-1-bruce.richardson@intel.com>
 <20260923135146.3527913-3-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260923135146.3527913-3-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::32) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA3PR11MB610523:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbe33a5-1bbe-4a9e-ac67-08df1aed5a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|22082099003|11063799006|4143699003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: UPvH/naRfVaJ6LAqYuheJPIST4X16iaR53jDsFjpWg2CXCqUfEIdJmbL8viOaJeSmwYNQSTAHigxfdoRHQ6kYSyKWCGXbSblPN/LpAh/+2VDUQxePvcfc32Nr3cCUOLDH7TbW2aj0UhzCD8OLeB7De7W3lzxyqckWl32+TANvNYiDhi/b0404KJw8MIrY73DxZbACsBzKJt6HphzoOhLcLzQYZgtkz+GkKeCi6rRK7F7+sye9lmLQ5ybubaH9ozlrWheV5z9SwZPLS8SDudbbUE6jiYzKgEJDE4k7B9m+RQOHShZy1p+4KO1fDBfGzMvFBVJTgqolbewMUExJ1MLFuntj1xXHmakGcGwXp2YJbsGXyJl375116By9hXhcH64dIC3C8ePzk+mY1LH+ssKeTvAKOd70UI2tmYTzNDLsFtXI+NG5QoThWEIIB77aKZTXAbcz0Dlu61PC72eTENkthkXW/3u+u9QGvz/IIL7tM8VlkzlRb0Yl2MbAzwcPp34+NXEIywbwiv8Muo7BnSXLAX70DAIJP/eHK7ZyxzG/rOsfLxTj+Irm+myM20nB9kWWFMUPy3OgCkKrAFUfgH7KMj8+tFLRAgA6v/wurZnIgZgHPTn7d8aGe7HIYEoq7oyAiYIwDPGPFsIlfy6L8j3/eud1tMkzDdmO1Gfr4dkQi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVcxOGZEUnNpVEkvQVpHZHlRckNsZklpeVkrKzhlTlJSeUdzM2tuTTdEc3NH?=
 =?utf-8?B?R0pUeCtBajc2Uk1URHZwa21vQUgwOXFMcnQ0UUJMSXBkSVZkSTVaRTJ5Rith?=
 =?utf-8?B?bEViZnJUOUdZYlQ1ZGRReXlFakNRbVJ3ZzlwVXRzQXg3V1JLdUdnUjA5My9L?=
 =?utf-8?B?c1RZR01lVGFpL2M3RFNuYkFZdVlzZTB0VXB1aFJ0WmhtOTB4UTAwK0s3VmVt?=
 =?utf-8?B?elFvMGcwMGw4VTVuSFBSMlBtRTBCV0k1RU9maWM4UWRmSGhJUGEzeHlSQU9t?=
 =?utf-8?B?QmIwOHBHQ0U1ZzZiMXhKc0NqNVR5WG5RSnRJbHN6OWE3ODMzeXFDV0dOMDBm?=
 =?utf-8?B?bXl2VG01T01Scm9CNTBPUzZVb296M29RMzhLOFl3eE5tTUZUSGhKL0xqSk8w?=
 =?utf-8?B?RkEvYkN0QXY2eUp6MzhraysyazNQNVYwQWh2VzM0Zzcvc05sMlpHUy81Z1ZB?=
 =?utf-8?B?UXFnUEdkUzh1VXFheGlsNERteU1CcExCRnBWci9oMHZFa081aWhOd1lYYk5w?=
 =?utf-8?B?UWZnUTk5NnluOXo4S0VSMWVIQXhrWEFXVmQvcysydWVyTzVSK1pGMnVaNXNG?=
 =?utf-8?B?U09JWG96ZUZmN2hyZjZJTUxSU1QzS3NXUDFLMzkrVlZ1Vms3RmpoaU9WRmsw?=
 =?utf-8?B?cTVnN0JmWExsYkNMQldKMnRIRG5xS1BPNms4bGY1RTR6MTJTREJ4YUMwbVN5?=
 =?utf-8?B?NlRhbXd4Z3dJa2QyNWNBbzlDV2wwL09HRk5QZ0ZJaTcyMFp3ZVVPK29EY1hL?=
 =?utf-8?B?ZnNPbHlNc3hKUTQ5S1RJdkYrRXMrcjFISlIvQXg4S0tJZ2VQL2MzVmpZV3Rn?=
 =?utf-8?B?cTVaN3dMQjZ0NGp2SDhFSXRYbWVBanl5OEZqWUxlZ3NlVTFrdUJhb2FiaHZB?=
 =?utf-8?B?WllzNFRCa2Z6ZUhkNDE3ODFjOEYyb1NpMFpqaFI5eUVrRytFV3pYQktxNmM5?=
 =?utf-8?B?SGZraTc2WUJWMWNmaVFGZkhtM0RNZGR2UHEybGRML0t2M2dLMzNCcjhZaER1?=
 =?utf-8?B?d05HdG84N3VKUXI1QlI3b1NYNE52VTF3d281NEFlcU9wQ2Q2VzBxR3VIMkE3?=
 =?utf-8?B?KzF4aEU5MlJUZTNvWG52RVR1YldMaUxmSEhYUUlCelpFSVJybGdKWXpoZk4v?=
 =?utf-8?B?djcyMzBhK3ZCK0R3U0g5dWgybm8zL1hyMzkwVDF1YmdlQjlmWDUyTmZKSWxS?=
 =?utf-8?B?bGQ3RlBNd2lpOU5QVmlPSEdGUkVaRktTdFY2SXJQcXNjMlZlTlRXbHpVNUUw?=
 =?utf-8?B?RDAyUE5vUTV3UllRaG9kVGJxMWZQWGlpMDdIMllJY2haUDB4YUV6OElLUDNT?=
 =?utf-8?B?NWJWMyttTHpnTGZmWHRhTDgzeGZWdE1xZTRIUjQzeEJIS3A0UHJIRzRhL1Jt?=
 =?utf-8?B?VkViSURob0ZaUFZVUWxYNzlUNWtwRVBOcVRuRVg5VU85VXpia2VjV3BwR0p6?=
 =?utf-8?B?UnBBc3ZkU1hyRy9kd0JmcU51bmRzR2FTVGVXRVFJZmhjOVRGc2RuNEpOampu?=
 =?utf-8?B?aXRTMDlMWldEd3NyeUpGVERZYXl3RThLZEhLd25RdFBiRlgxSkx6d3RmbUlq?=
 =?utf-8?B?ZnRpb2Vzdm9yek1BREdTNXZTQjN4YXJLaUR4V3k3Nk5oUUdiN1RmTkowVmwr?=
 =?utf-8?B?V0tXSTFGREk0SVNEVy84N0ViZG83T2NLaHBRQ2FwUVpDK3A1Yjk3MXVDcG15?=
 =?utf-8?B?bVlZSCtUUlNXKytrUmtmNk5pbVhlVVJRNnV6cm93clVyampVZ2hpUXFucWNC?=
 =?utf-8?B?UFlYZUdhMUVLSVZkc0YwREhQRkxPM0tKbVpxQ0pma0pBRDU2d3F3ejZBRVBm?=
 =?utf-8?B?VVNidXVzc0dka0tEVkhOL1dwMlFoKytDcUJGWFlndlFKRENlZ1ZFQmJ6WkMv?=
 =?utf-8?B?c29LVExjUVJOWEx2N01tOFA2ZWMveUJETk9CWE54ejVDbVlpYUZycXYrajN6?=
 =?utf-8?B?YWNvRHJJYUxEMy85SmxDbVpkYUtpZHJHWHA4L1dnZEptTGszVld4ciszM3VW?=
 =?utf-8?B?SFpvS1NOVzZ1a2prOTZERE1FVXpyUnR1NWRBVEw3a1Q1Rm9JbDlaSFpqMlZT?=
 =?utf-8?B?UFlvT3VXYzNIckdHdHMveThLT1lMWlUxME9RaU51cldJUDlLOUFpdVlJOFR0?=
 =?utf-8?B?WFBzcmpCUS84QTRkZFBEcUR6RVFDa21kejk4elMxVVVick9WTzJiS3lhM0U0?=
 =?utf-8?B?QXZBM1BuTkp2cjYyeWxQSlJXbGdHVEt2ZGcvVDFoZDVHdUZJT2NZaTZOT2sv?=
 =?utf-8?B?MFBkTHoyKysrNW92a3RKcUl2VmhuNXRhNGFHeTA0M3RpU3B3ZG5kODc4QWd2?=
 =?utf-8?B?VXBVbEZMem5Oa2dMaWU4MVMwQ0VKaitLZlJ6NUlFZmpZSkFkQzhpV3o3aDFP?=
 =?utf-8?Q?wNDOf1jSJsCQMaDE=3D?=
X-Exchange-RoutingPolicyChecked: HNJ/R8kzD71G8TVxOXoTEzbfsNJO3z3cQua5alU1hclUbVd4v1sJtWQCQtEiA2uFroE9X3cqM9TobdrbxObetQe/5mYAN5dD6BAhEEOCs11ClioJ4TSk1zvSQ4fugyy39ZQ8JTzxzZIFp/5gLsm0wBd8v1QXRkDc1oWyhsK5W7E7ZVwq/WFUAY6sqqnbrfNlcIOT46bTkgD5OLX+b+9jLGGM3lXNv+4v+pntShsU0y70sXW1vX6EG4NBs4AHui31Di0GX0L/XYkzL/1y8Xz9yknJVDWSo57HYUOdJOlfqMA89GYY2LZsCGM3hrdTtQN6BjZTLl1BCAOD0t0UaaxM8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbe33a5-1bbe-4a9e-ac67-08df1aed5a97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:11:24.1144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAhjH0JddYsqo+S0opVWFEFVlfWe9fzQlnaWPh2tJlKscmUVtD/hSHnsmEKsTBsj1uIpRXfDAoNkymFJ1a203o9DevmyR8xJA9SnvilgnyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB610523
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

On 9/23/2026 3:51 PM, Bruce Richardson wrote:
> Replace the standard (non-offloading) AVX-512 Tx function with the one
> from the intel/common folder. Both old and new code paths have identical
> behaviour.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
