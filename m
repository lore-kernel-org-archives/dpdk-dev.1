Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F7C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 12:54:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4355240E12;
	Wed, 16 Apr 2025 14:54:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2D40C40E09
 for <dev@dpdk.org>; Wed, 16 Apr 2025 14:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744808086; x=1776344086;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=10DZwM5nVy93Sm0sgbty1PSHpJD352aC803bHMwJA8w=;
 b=UIq6wZX20UlCXTry+YMwH/TtW8xUpWCI7FVukWFean3pasJY7rieTFCQ
 vJvfUx++/BzL7AwocKK6/EMIEfEzngW1HL+286A0bwGfS1sbiES4OWGyG
 s1hekNtmBXyWA5YxTMr4yYkLZVxD1wRfB4HuRAjlxt+n4IoPwnK3cU/hu
 GriqWI1Yko58mi+Bh8yx3K1HrajPo3GwYTAU5F0+5t4+E7c2o5tlPZNuR
 bMedi0YUbQrxn8c1XTQPNTwBMNlNMD3ji5sos1ERZ/Dg4ATQ0YmTgTLRp
 y+5PW6BjfbQk2ths0s/+StGAgs4wfEEOUGtX5vyFU2r9xvrgcGMItAMIU Q==;
X-CSE-ConnectionGUID: +EmF0oZFSMec10hBnDBgrQ==
X-CSE-MsgGUID: +7obumJNR/eaqAOHjzGYvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46485298"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; d="scan'208";a="46485298"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 05:54:45 -0700
X-CSE-ConnectionGUID: vLEj9YrwT2GLqwCY9uHgxA==
X-CSE-MsgGUID: DKwRVJDESJisd6yGsC4pvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; d="scan'208";a="135646348"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 05:54:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 05:54:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 05:54:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 05:54:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rzw3UrG59PLzUStqsfKeX/pNDwhbBnSHPcdZzhSf/7+3kS36fFO+HLqK7MYccIkdgO5RcF4aD51Ct6XUj2JPB6nHR5i166Os9Ks7X+vN/6ioa44Hq+5UXagmv4e8wsZCsvph2o3SGvG9VoUakKUDmsuz0JHt/bueQbqiSsu667M1f782rtZl2DL2cRdkdLwqeaOjdAQCaxsKlTZ2U2NtRzNUJ9ptNRpAIsp+T93zG0DxzzQ4DYbMhfJgT3TMlp0EgkJYkwl8VkXh3kBm6rBRJXSHAc7b1YDZiH8FN5/d5BvtmUiyeA8kn82yChNa3+NZV9CEuGb3r2eqpcX73PWP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5WbfX9XwqlGRiPRTPnVgViZXjYLBBpXGHunQf9Uiig=;
 b=zIvsCBAsaTGrSmNTCC5qN2z5eAtzp5zR46qJVjmunkwlrkFTmrW2tgAEO3xpp3/2x6YLnAwZ0D2Ls4Idb7ZWBPLUShKVLQzGK6/wCCIH+h9qPRVkYGyg7K8UiuaSnRGikSsFxvs8cJaansVDywOLe9mXCU8TfjbP6n+RqRmgOrJg+LeknpqHyvopUB5VBbpfEGV6hClCYhNkpFUoghznx87+q6x8m8yT8RRm0DBn/GJfwu8yABSh6qsdKRHfcgJc3oyPudq+oYi9vHwwRNpX9dzHjRW7rNr6TrcLuKmFmbu1UXwsf5vyRpn9XkF/a2JZTc7YcqMOSA2S0RqWwPtiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 12:54:40 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8655.022; Wed, 16 Apr 2025
 12:54:40 +0000
Message-ID: <380238cf-085c-48ff-800c-a876edc96dea@intel.com>
Date: Wed, 16 Apr 2025 13:54:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/12] node: add process callback for IP4 FIB
To: Ankur Dwivedi <adwivedi@marvell.com>, <dev@dpdk.org>
CC: <jerinj@marvell.com>, <ndabilpuram@marvell.com>,
 <pbhagavatula@marvell.com>, <skori@marvell.com>, <rkudurumalla@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250415121052.1497155-5-adwivedi@marvell.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250415121052.1497155-5-adwivedi@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::28) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a63247b-fa92-4761-8e9d-08dd7ce5d9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SW85ZHdNWFdLb05BUFpheldxL0JaczEyNkVrMERHbWw0NFBZUHFrVmR3MVJP?=
 =?utf-8?B?R0UzazFaK1R3Zm91NTZremhDK1pHdUk0Qk01M1ZaVEs3SWNOQks4dmh4aGhu?=
 =?utf-8?B?ZkVETlhrUGwva2xVVjR6THB4UkVJTlBETDNBRVU0VTUrUFlYOExTRmtwblh5?=
 =?utf-8?B?Z1FPV2g4NTM0RTk4WlgrR1pFMmllM3JSRWFxalN4akg0RzRPeFNqUUxmdGNY?=
 =?utf-8?B?b3lIMk1kNUdVbGJiSWIrMUlVRXU4bkFsSVpiM2lTTDQ0Z3h1aFF2RUM1WWtY?=
 =?utf-8?B?cExxeTNVUGdBc3ozV3JiREtIekdPRmNpanlNM2lRcEhQNkk0VTFSZlRWYjNE?=
 =?utf-8?B?Q3NEVHYrTjQ2dURwVHhhbWdxWHJ0QzNVQm15YzlrZHFEcnVqVlBkU0t0cW16?=
 =?utf-8?B?MjVkcncrdCtOZnorQlY3TWFpaU1hLzZ0ekJwTVd5azhvbGVzaXRVZTg1bzhK?=
 =?utf-8?B?MThyRGlzVTVBeVY5V2ptR2poU2pRTElhSVJ6dnZMa1VzZFVPcExsZ3pNVVdr?=
 =?utf-8?B?L1FtTDlialBpSTJMR25oeHBXVlEzSlRCSGxOWFlxQzFGWVlJdGxab0d4OUxn?=
 =?utf-8?B?cmlva0tlTTRpbDltQ08rbE51c0l6N3hOOEFWQThsY2s4SnJZbEttcjAxa1BS?=
 =?utf-8?B?RHBaeXhxZHFwQUpxMXJaTkdMWlhaWWRRZ3dFVHJEY2RKMlNFa3FwVWpTZEkz?=
 =?utf-8?B?eEJoOVJiSTVFZjdyNE40OUU2S3lBNXJ2RmhHZTAxb0ZBVStFV0I1LzZZQ3BS?=
 =?utf-8?B?SS9SWkR0Rllrbks3K3UvOW53cy9ZakRGbGtoeGtVRldhcWNtSURJK1d0VStU?=
 =?utf-8?B?ZmgvZkdVREZEajE3UHZuUWpIUUNrSjJ4aHd2UVlid3Q5VUQ2dStVdUNTRkhV?=
 =?utf-8?B?aitrUTFzU3JDN0RLc29WbHp5ZUdSN21uTFRFT1ZRTlM4WFl5eG5PbFg3V2I3?=
 =?utf-8?B?VHNEYVBkL1NROUc1MWI5NHRsSGZmSzNPVGJKWkVPdFcrd1hoalZMWHZqTS9I?=
 =?utf-8?B?M0dETjRoRStQbnRaY1Y4MEVNM1dPMnFKTWwyNjh4L1UySGpMR0xXelRKcFhq?=
 =?utf-8?B?QW05cHZzNEp6aWl4U3ZQSlFUZ1FLL29xOW9IRWVRbmVjNTVSdThNTEJWSDVx?=
 =?utf-8?B?clNZVXJoTGw1ekN1NEU2TWt6NFNqNm5ONGtUWDZsSEI0TTN2Y2N6Y3Y3Lys4?=
 =?utf-8?B?ZU1ZaS9odmNDNjIvTlkwWXc0cWwxSjRJb29oY1ZjWTEvamlkUk5BSzZTblRS?=
 =?utf-8?B?VUxKaXN3L1MzZ1c0bWh4K0d1cVpOTVpqODluOVRSbXdqQXlMMUtHcW9NK1Yz?=
 =?utf-8?B?QVNNbmlhWEV1RzQwQlc3UWx6eTVjeGdPcWViYUVVR2crUkcvR2JjcTVuVFBN?=
 =?utf-8?B?bHMvTTJWNGltM0dYRW5IVVBpVXN0MXR3OG1kaFdrY1Z3RzZFcTdoZlNIM0lH?=
 =?utf-8?B?SmY5dFpSR1ozYWFSS2pYN2ZHZWNhaFlRTlJLSDduTGVlNDFNWEdoRlVLYkth?=
 =?utf-8?B?bHJzNThGNHJtZ0pLdlJiNWxSTGVjSXZldWREdm1mOGlYY28zNkhjWUE0NUFR?=
 =?utf-8?B?eG43Uk5kMFllSjAranltbzY1Y1h2dDNPZEprMGRha2I1Y1VJZllhQnRUK3VZ?=
 =?utf-8?B?K2ovcnhMSTJudWRIU3dtbjh0NVdrYjRzdXBBRTJHL29XUk5JUG5QQk84NnFB?=
 =?utf-8?B?SDcrZ1JlK1ZtZ0x0RXFCdjY5OXRONlA0d2RJNlJXQTUzVGFHQ3ppSVh2UDhS?=
 =?utf-8?B?aVNuS0hWM1ZkUis2QTdkZ0FMaUFUdCtoa2p6MHRzT0JwOVNMbnpDTFpBeE9w?=
 =?utf-8?B?cWVaazZCN2w5Q2hWem95RmVzM3VtTVNDdTBLb1dGdHNJaGpPUTU0cUcrNmVV?=
 =?utf-8?B?Y04wU2FkWjdvZFlFQVdjRkgvblFHNmlmM3RERXZtY080VjNib002ZGUvM09w?=
 =?utf-8?Q?5896WzIY0QQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU0rK1Zhb2pzZXhMZVNIOTFJMzFQNFgxVGVZL1lCUTJYQ2pTTEZaUDVLenYy?=
 =?utf-8?B?Q2pjeU9GTzRmL3crT01MZ2krMkxlWnFiLzBzRDQ5bVFwbmJJaFFuL1RXcFFa?=
 =?utf-8?B?ZkJDYXZyRCttVUxiemp1T1FiZ0RnRENHMnBTUnF6WkxFeGYydUtUMWptUVlh?=
 =?utf-8?B?V1M0bFQ3ZU9oSTVuZ0tWRktvSDAzSDRjRTN4SU4vdVk3TWwyNzNZTDJHeFU3?=
 =?utf-8?B?QnV4T3RnK0svNUpXK0xlS1FIMU9UUmd6VHU1RkVWRWhrM0x2RUc2UnJISHJ2?=
 =?utf-8?B?L3d5QUc4aTAvT2Frb29VYnp3bUZTMW5xM21tL0dFZW1KZXVOTEZ2aUJPL2NG?=
 =?utf-8?B?N3ZIcXhBSzBJVGxSVHZqdDNTbVIrdlhzamlGT2FLQkVXUUpmOWkvNVg1V0Rm?=
 =?utf-8?B?bkxoVFRzZnVOUVNMRVJnYkd2M0R4bmE5bUpPVTJ4T01wNFJlc2Q5SkJiNER5?=
 =?utf-8?B?Mmg3QlIxTG10M3dVZ0p3T3plVkNJdjRFcGpzdlJXNHdOa2FZN3RBUVlRc2Er?=
 =?utf-8?B?YkVpUzJFdklCd2c0TUxwWW1mcTBuc2lhSEIxUTg5N1UrRTJveXczVkMzc1Ey?=
 =?utf-8?B?dVQxNWNEbE5PRXFZaTRiNGU3aGlMcHJJcjhHcFo2NXJsTzMvWmpvMjJ1QVRM?=
 =?utf-8?B?R21zR24xUURtQTk5bzF6V3d4U20xTEhncUZVMUxvd2dCZ1A2ZjJjTTZ4VmFB?=
 =?utf-8?B?VHBPV20vcmhhb0ZvZnY1WUU2Rnl3LzdiM3ZRRjJESWNOakMvbUxPSHdvQTBK?=
 =?utf-8?B?QU5tYjFvdHh1enZqYmU3WXhVQlZiaXcyK0UvQzZZYWpsZnFYdldoMVMyRmNv?=
 =?utf-8?B?T2hJai9Ecm5jT2dkWWlYZEsxQVdnbVhOeDNnS3VueUtOZHdKK3pPL1Vkc3VT?=
 =?utf-8?B?cGIwTjhiSytpZ0F6TEl5MERKV05HOGxMc3duM1JqS1hseEIybTJXSmlWbFI0?=
 =?utf-8?B?aVlBRk9RWXNGRlVSeFMyQnJTenc0V1FEaktyZHpxNndLeWN3aGxIWmdPdHlt?=
 =?utf-8?B?TGJpbEdCWHR4WGVXaWYzakJPUndXanR5K3ZLa3J3N0x5ZzJ3NXozSlJpYjZr?=
 =?utf-8?B?eWZEQkx3TGxja21HZHR1eU8vS1R0bU9BMmNmNElyZVZPc2dPQ3A0bTlyMERG?=
 =?utf-8?B?aXFTQlZMcTQ3cUJXajN4ZzQ1aVEwSDRHUmtIbXVjRkFkYitWVDhpY0tGOEZN?=
 =?utf-8?B?S3A3a0VaZXJYWW9XRjZNSGdmcmpTVUtBQzVhZkRoK1pGeng5MDdvTXBTUFAz?=
 =?utf-8?B?ZGczcWdZVVVhdVZoYU1MeXA3OGlLb2RqY2xJdVJBY0FOOGlKVDVCTnRHVVhi?=
 =?utf-8?B?WThDLzdiRTU0YXhqbUoyV1NQNkU5b2cwLytwZGNLclNEd3FNU2RHZW1mYWxy?=
 =?utf-8?B?NGNRRGJqeTJlR0NOd09sRFpPdjFoMmZnRnVmWEt0Zjg5UG4rdjRJVWdMdlgx?=
 =?utf-8?B?Qml0L1JyQmJaSE5kUTBKLzM0OUdQVnRzTUorSVF2RFpRQ0s5QXZJZU9GUUZo?=
 =?utf-8?B?a2FuRUgzSTE5R3EzNS96TFdQdDBvV1pMWXhUd3V6UXVlNWR2Q2NDczNJMmxp?=
 =?utf-8?B?UTNtNjlZTmxjTmF5UkE5ZzN6bFlVSjNSQVNzejdPYTdDV3JHaCs4TC9xdWpo?=
 =?utf-8?B?bGlTTmg1UWZaRjNtSEdJS3IwNjVlTFd5VWZtOHRMY0pmcmFHQUs5allsckNN?=
 =?utf-8?B?VSt5Vjg4V0JVWURLWTFJem1XZlA0RURXYm5zdU0yZjFvcXF6Tmk0ZlhpZzlM?=
 =?utf-8?B?VTNGT0tPdk1MbGFJVnBJc0VLNytvbDQzV24vK2o4VDRWY0lOZkoweUFZYlUy?=
 =?utf-8?B?VDdNZDEzNDRSZFFYV3BTa01Eam9IWWJOR1JxN0hTZjF1WHVJbFRMbTg3YXVY?=
 =?utf-8?B?ay9DeVJUL2dxNmxiM1dnWXptVVRvdHFQZEpFUks1TFh1YWJaYWJxWWo3VjZF?=
 =?utf-8?B?T2FnbnAySHYxeGV2S3hQbUo0eVBlSHlEWVB6ejBXS0x1cVp4S0NwNGtWQ2Iv?=
 =?utf-8?B?c3VzNFhJRVk0VXJ1OUR2YTR6d1oxQU5Wb0o0QVNFUkhNMDY5QWJJL2NJUC9k?=
 =?utf-8?B?c0MyVkNoT1FVY3hzb3JBa1BINXFkU1A2NWM0R0l2T0ttY2pleFhIakVDNTZs?=
 =?utf-8?B?dEY3ekMwdnkzaVVEQ05vVVRjMHI0SG42cVFYOWJSbE5DYmU0V0pRVDE0c3A4?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a63247b-fa92-4761-8e9d-08dd7ce5d9d7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 12:54:40.3700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMwLCuKml7Zqpqh0Vv85H5vjhgz4+91pZa3a7WbHZYy9AFpuELB7IIQ08l9Dyu/kvx0VCT2+vfZpnvdPyVpqHkergU3dcOlUPaqrQa4eQSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
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

Hi Ankur,

On 15/04/2025 13:10, Ankur Dwivedi wrote:
> Adds the process callback function for ip4_lookup_fib node.
>
> Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
> ---
>   lib/node/ip4_lookup_fib.c | 164 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 164 insertions(+)
>
> diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
> index e87864e672..c535b191f8 100644
> --- a/lib/node/ip4_lookup_fib.c
> +++ b/lib/node/ip4_lookup_fib.c
> @@ -40,6 +40,169 @@ static struct ip4_lookup_fib_node_main ip4_lookup_fib_nm;
>   #define IP4_LOOKUP_NODE_PRIV1_OFF(ctx) \
>   	(((struct ip4_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
>   
> +static uint16_t
> +ip4_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void **objs,
> +			    uint16_t nb_objs)
> +{
> +	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
> +	struct rte_fib *fib = IP4_LOOKUP_NODE_FIB(node->ctx);
> +	const int dyn = IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx);
> +	struct rte_ipv4_hdr *ipv4_hdr;
> +	uint64_t next_hop[nb_objs];
> +	uint16_t lookup_err = 0;
> +	void **to_next, **from;
> +	uint16_t last_spec = 0;
> +	rte_edge_t next_index;
> +	uint16_t n_left_from;
> +	uint32_t ip[nb_objs];
> +	uint16_t held = 0;
> +	uint32_t drop_nh;
> +	uint16_t next;
> +	int i, rc;
> +
> +	/* Speculative next */
> +	next_index = RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;
> +	/* Drop node */
> +	drop_nh = ((uint32_t)RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP) << 16;
> +
> +	pkts = (struct rte_mbuf **)objs;
> +	from = objs;
> +	n_left_from = nb_objs;
> +
> +	/* Get stream for the speculated next node */
> +	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
> +
> +	for (i = OBJS_PER_CLINE; i < RTE_GRAPH_BURST_SIZE; i += OBJS_PER_CLINE)
> +		rte_prefetch0(&objs[i]);

Does this prefetching loop make any sense? Unless objs are not passed 
across threads this array likely to be in the cache already.

And if objs are passed across threads, then why do you start prefetching 
from the next cache line instead of the first, and why don't you stop at 
nb_objs?

> +
> +#if RTE_GRAPH_BURST_SIZE > 64
> +	for (i = 0; i < 4 && i < n_left_from; i++) {
> +		rte_prefetch0(pkts[i]);
> +		rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[i], void *,
> +					sizeof(struct rte_ether_hdr)));

This construction does not make sense to me. Same as similar 
constructions below

The second prefetch has memory dependency of the data, that will be 
prefetched by the first one. Does removing this prefetch affects 
performance?

> +	}
> +#endif
> +
> +	i = 0;
> +	while (n_left_from >= 4) {
> +#if RTE_GRAPH_BURST_SIZE > 64
> +		if (likely(n_left_from > 7)) {
> +			rte_prefetch0(pkts[4]);
> +			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[4], void *,
> +					sizeof(struct rte_ether_hdr)));
> +			rte_prefetch0(pkts[5]);
> +			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[5], void *,
> +					sizeof(struct rte_ether_hdr)));
> +			rte_prefetch0(pkts[6]);
> +			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[6], void *,
> +					sizeof(struct rte_ether_hdr)));
> +			rte_prefetch0(pkts[7]);
> +			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[7], void *,
> +					sizeof(struct rte_ether_hdr)));
> +		}
> +#endif
> +
> +		mbuf0 = pkts[0];
> +		mbuf1 = pkts[1];
> +		mbuf2 = pkts[2];
> +		mbuf3 = pkts[3];
> +		pkts += 4;
> +		n_left_from -= 4;
> +		/* Extract DIP of mbuf0 */
> +		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf0, struct rte_ipv4_hdr *,
> +				sizeof(struct rte_ether_hdr));
> +		/* Extract cksum, ttl as ipv4 hdr is in cache */
> +		node_mbuf_priv1(mbuf0, dyn)->cksum = ipv4_hdr->hdr_checksum;
> +		node_mbuf_priv1(mbuf0, dyn)->ttl = ipv4_hdr->time_to_live;
> +
> +		ip[i++] = rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> +
> +		/* Extract DIP of mbuf1 */
> +		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf1, struct rte_ipv4_hdr *,
> +				sizeof(struct rte_ether_hdr));
> +		/* Extract cksum, ttl as ipv4 hdr is in cache */
> +		node_mbuf_priv1(mbuf1, dyn)->cksum = ipv4_hdr->hdr_checksum;
> +		node_mbuf_priv1(mbuf1, dyn)->ttl = ipv4_hdr->time_to_live;
> +
> +		ip[i++] = rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> +
> +		/* Extract DIP of mbuf2 */
> +		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf2, struct rte_ipv4_hdr *,
> +				sizeof(struct rte_ether_hdr));
> +		/* Extract cksum, ttl as ipv4 hdr is in cache */
> +		node_mbuf_priv1(mbuf2, dyn)->cksum = ipv4_hdr->hdr_checksum;
> +		node_mbuf_priv1(mbuf2, dyn)->ttl = ipv4_hdr->time_to_live;
> +
> +		ip[i++] = rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> +
> +		/* Extract DIP of mbuf3 */
> +		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf3, struct rte_ipv4_hdr *,
> +				sizeof(struct rte_ether_hdr));
> +
> +		/* Extract cksum, ttl as ipv4 hdr is in cache */
> +		node_mbuf_priv1(mbuf3, dyn)->cksum = ipv4_hdr->hdr_checksum;
> +		node_mbuf_priv1(mbuf3, dyn)->ttl = ipv4_hdr->time_to_live;
> +
> +		ip[i++] = rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> +	}
> +	while (n_left_from > 0) {
> +		mbuf0 = pkts[0];
> +		pkts += 1;
> +		n_left_from -= 1;
> +
> +		/* Extract DIP of mbuf0 */
> +		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf0, struct rte_ipv4_hdr *,
> +				sizeof(struct rte_ether_hdr));
> +		/* Extract cksum, ttl as ipv4 hdr is in cache */
> +		node_mbuf_priv1(mbuf0, dyn)->cksum = ipv4_hdr->hdr_checksum;
> +		node_mbuf_priv1(mbuf0, dyn)->ttl = ipv4_hdr->time_to_live;
> +
> +		ip[i++] = rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> +	}
> +
> +	rc = rte_fib_lookup_bulk(fib, ip, next_hop, nb_objs);
> +	if (unlikely(rc != 0))
> +		return 0;
> +
> +	for (i = 0; i < nb_objs; i++) {
> +		if (unlikely(next_hop[i] == FIB_DEFAULT_NH)) {
> +			next_hop[i] = drop_nh;
maybe it is worth just do define FIB_DEFAULT_NH as a drop_nh vaue to 
omit these next_hop reassignments?
> +			lookup_err += 1;
> +		}
> +
> +		mbuf0 = (struct rte_mbuf *)objs[i];
> +		node_mbuf_priv1(mbuf0, dyn)->nh = (uint16_t)next_hop[i];
> +		next = (uint16_t)(next_hop[i] >> 16);
> +
> +		if (unlikely(next_index ^ next)) {
> +			/* Copy things successfully speculated till now */
> +			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
> +			from += last_spec;
> +			to_next += last_spec;
> +			held += last_spec;
> +			last_spec = 0;
> +
> +			rte_node_enqueue_x1(graph, node, next, from[0]);
> +			from += 1;
> +		} else {
> +			last_spec += 1;
> +		}
> +	}
> +
> +	/* !!! Home run !!! */
> +	if (likely(last_spec == nb_objs)) {
> +		rte_node_next_stream_move(graph, node, next_index);
> +		return nb_objs;
> +	}
> +
> +	NODE_INCREMENT_XSTAT_ID(node, 0, lookup_err != 0, lookup_err);
> +	held += last_spec;
> +	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
> +	rte_node_next_stream_put(graph, node, next_index, held);
> +
> +	return nb_objs;
> +}
> +
>   RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_route_add, 25.07)
>   int
>   rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
> @@ -147,6 +310,7 @@ static struct rte_node_xstats ip4_lookup_fib_xstats = {
>   };
>   
>   static struct rte_node_register ip4_lookup_fib_node = {
> +	.process = ip4_lookup_fib_node_process,
>   	.name = "ip4_lookup_fib",
>   
>   	.init = ip4_lookup_fib_node_init,

-- 
Regards,
Vladimir

