Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A5DCAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A7F0402CB;
	Tue, 23 Sep 2025 16:04:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id DCB23402B3
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:04:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758636254; x=1790172254;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1c8pRTYNkAjPMCID6ofbdM6/LV4Yv9tLdzs9WocfydM=;
 b=BhbcL47PxUAFNi5V3aYKArrIVp/ZM31nSCwns2RAMDx/6qnamhWMaZzU
 AydqjeYLol0fPqCC/QtJqZSrATIvdq0lvI+K76zyPOAGlyOYIZOKcFdoQ
 An76zkqNUqbkJ3/QX4DPy9AMpHaLikY2EtJXJCT/wGdcW0cSV+k9UAYYs
 6vYNkUCOVFRYAWX2XPb+TPFqzQFJhAShnH1Wl072xc+u5MH3+giI2ANMr
 /W8AmqXz2/wD7IOroagurCohEjdnJRc9FK7/JTFLzkKzXKmQhvecbCDrF
 y3dVALpT6N43cklRlsDncpQ02JJvmIZs2lHjLs+0STMIOc0Q3eUmuVZw9 g==;
X-CSE-ConnectionGUID: AXBBpIWmRlmicuAmbO3lGA==
X-CSE-MsgGUID: 0hPPts7KT0GjH05P/+i42A==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72021972"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="72021972"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:04:11 -0700
X-CSE-ConnectionGUID: /9sT0+vXSFOiRTscyt0Hhg==
X-CSE-MsgGUID: t5tZUmS+QAqZbDFNZfgDIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="177148423"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:04:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 07:04:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 07:04:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 07:04:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ge9/r0pfFvNmSgP0Wt0jWP1VdBzbIar4iaE0gupmvRbiSFX1pRd8NhPHgrO1DjAqInXnwVH6tYIZWnVxFCUZmrOd0nCVgipjtgIEa+v+1gK93RnX8sf70GZ3sdOevdFYwrXymiiEbBVDucPVGoWeq7GJQ1cQ/IPV3CCjZJJVidQpD6yIYWxqE2cPkLK/WyPFm7nd09sO1kNhqXfquErQk7qi3nY15t+SHEVBrpRNZ3h1AZGohfrpnMS3ig25rpaDqShp35vgSlBXgeum3WsxodYmAfbq6fR6MSPkAjIMhfj3MXoAXzOtDOOFNR73/5fRs8kaqKa9Mv+ujc+DMxtWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBbHkHiSuxOBXSVAXp3nxufsS+ad6vgCXSVFlLz2hOc=;
 b=sJaiiVw0cTg54odjKshWOR8YxO9VbvihuLG6yJGWaJtxmFuONtOCNZ4Oz2jnWqvKB6see6DZ7hqn9d9kPHGzigzvIzT3od8F27pHLnvXrPXIRSeZK1NP1164FkS9y2732SNade30IW0SgCebkXG+qGQZl92oO3W/NkwTJbiSsIdALDMcNEEXkx/46RbfoLlCCQ99xR8fglAwicvt342ST0fqLr6M+XTGLfUgs5n11pprpBxSZ3MjbMtkVuQfTaPmjotgnuK3SZ11JC8CDRRu/m4W+k+TOa4ivZDuSru+iPcHTxRbrfTt6ZKG6of6MO2a3fGC04IzQhT1EBbfkb44aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Tue, 23 Sep 2025 14:04:08 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 14:04:08 +0000
Message-ID: <905bfd08-821d-49ea-bd66-e4ddd0969dde@intel.com>
Date: Tue, 23 Sep 2025 15:04:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [RFC] lib/cryptodev: update API documentation for
 aux_flags
From: Radu Nicolau <radu.nicolau@intel.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
References: <20250827094338.767062-1-radu.nicolau@intel.com>
 <CO6PR18MB4484F38CE9989A01F49C8CF7D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <114c4b2b-f619-4a12-ac0c-adca09fe6033@intel.com>
 <CO6PR18MB4484C9F7FBBCC5AA04405899D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <6157cf0d-4a9e-4f4d-9278-24dd0507ed77@intel.com>
Content-Language: en-US
In-Reply-To: <6157cf0d-4a9e-4f4d-9278-24dd0507ed77@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR02CA0018.eurprd02.prod.outlook.com
 (2603:10a6:10:52::31) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|PH0PR11MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b83b72-2880-48ee-731c-08ddfaaa0ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MU44dzV1WHBwRkFFZGs2KzVuc3R5KzJIRTJZRmhGVjArRk9CNFhuWnpQbjFY?=
 =?utf-8?B?bGYvUnVKYVVCVEpVdU0xRmZSR09zUWlWZWtldXY1aURmYnBLY2xGMGtCVEM0?=
 =?utf-8?B?eS9HbSthZFhaWVg5SVFXTk5EVVRaV1J1WWYzajZlSXpIM1pTYjBzS3dzQXJq?=
 =?utf-8?B?MDlEaEJnRHVsOXNuVTNQQXZUWTBRK3JkeVVYcS9STW9rZytVODVWdXl6aVJP?=
 =?utf-8?B?L092ZFNZSGY1QXBjTUIwNWQzRktFUzNuWW51NnJWZEdobTVGUEhzem5mdVdZ?=
 =?utf-8?B?bHdXSWs0dVhMMnJNbXo2ZkdIV3NMd0VYZm01WEZCZmtNS1k0Y1U4NHpZdVBx?=
 =?utf-8?B?M1hScVdCWE9rRUhBMU4vTjNpSlhXbkNkQVdjSTRUcFJTQmkzUFJXckpkWE1p?=
 =?utf-8?B?ZTE3Y0w0bWJhTTh5VHloc0lmakpWQ3dWU0VsWms1OTN2RVdvTW82OCt2SllV?=
 =?utf-8?B?V1Z1NTNiUGx1T1JiQ2l3OHJzekJHN1FhZko0Zlcxb1ZHbDR1Q0I5TG13ZVpt?=
 =?utf-8?B?V0ZuTW52c3hOc1lZaTRIRXg4U3JUaXdueVRRUlk0SVhNbVdBM1QyWHBHcjFX?=
 =?utf-8?B?ckRQanVYYmZDcFowR0VieDBFVkxBSEg4RFJUNEFWZGE0dExodDJCdjdFOWhu?=
 =?utf-8?B?Nys0ZnpoLzc2MnUzMmtOWmZIZEVBZWtFOHY2OW53UTNsK083dnVjd2laUVY4?=
 =?utf-8?B?M2NBTkZlcnd0V2RjaEdKTXovbUp0R1doL1RIbWFZUFVEdjlkRlViVEZVQlhX?=
 =?utf-8?B?cGUzQ1BQU3dUdlVJQ0sxMjFEK0RFcHhxcVJhV0J0TC8zYjN6L29MSzVXblJV?=
 =?utf-8?B?bVdqR1NmWGI0R0pnbnNoSTJmNGEzNUZ5aEdielZyTXdqeTVXTWx4VzRVU0tt?=
 =?utf-8?B?N2lOUjA5dnNzSkxBbWxKTXRIUnUzcFcrcVFkMHhvekdwVXBoUlk5aDJTV29y?=
 =?utf-8?B?RU40UGtkS1lldW10N3IyckNWMDNMVFRwY3lmZUsvVGEydGVzZHc0UkU2TXBt?=
 =?utf-8?B?L2JLNDI1ZnJzT0dzNmtHUHNqV0Z3OGkzSnphM0lieE40aDlPdTUvYk5oRE5z?=
 =?utf-8?B?NEhmOXI3eG5tUkpjZ3JoU1k1djZlNmxjUU5tcC9CcVJRZzVLR251RDl0blRz?=
 =?utf-8?B?NHZLY2FsOXFmZFdXMXdUL3hUeVZDOUY4bWZjdGVEZHdmNi8ycDdHTDNKQms4?=
 =?utf-8?B?RzhaZ1hYYy9QUG8zMVNDUHo5VG9sUC9JeXdJOHZzeWRhM25pVm03QnZsMjJh?=
 =?utf-8?B?QWFaS0d2cWJ3QXV0UG55QjFXditUR0hGZno2bW5jZlM4VzBUaXFENFhaRWd0?=
 =?utf-8?B?WTFVWjVKc2l2aHRWcmtsTE1QM3QwZmhXZEhSbmNDVFlORlJQWnhFQlBUa3Uy?=
 =?utf-8?B?ekdRN0toUUQrbTBHandpSVpkQjlycjVheUsxUUtlazUvczc4MmFDenlmNUJO?=
 =?utf-8?B?ajBlREhRNVBXZUxkUWNVRURwY3RreU5lOXhiUWRKNS9URXdWSUNYUHlpQVYr?=
 =?utf-8?B?TUg3ZjRZY0RhK09VZXRtN2JyeVFTR3NJTlZyaHVhWG1yODdnT3l5R0ZvMXZD?=
 =?utf-8?B?aDd5YldvM25uMkNkMmxNZ1dXT3F6ZmNTS0VsVXZ5TUx0d1JKWndlQVVzQzRm?=
 =?utf-8?B?TDRWc0hMdW9HNWVpVTlsUWlJeUk1Z0pzczFLVmwxaTFFSDNWM24weElESWQz?=
 =?utf-8?B?TmpjdUt6ZThwdzNxR0RwSFo0WGhDVzc1VExqdENhVU5QUXBjbnNMZmZnK1ZU?=
 =?utf-8?B?YUtTQjRjQWVuMndRNnFodzZYd0VRcWwrSGdSMFRnTVJkRWtQUk5NbEdnM1pG?=
 =?utf-8?B?M3JoV2tZWWIvVUNhdzRweHJZdkpLZFNJbVYrOXZXK0pEL3h3eVRZM3p2WUtl?=
 =?utf-8?Q?p02P51+VEbn48?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDdTZE11RytuNWo2Z1hLNWxSaTBSS2JsSWtYQVh6TGtoZXdBdE84SGpYWmht?=
 =?utf-8?B?Rk1laXZQWlVoZ1VtdjhVREdzVzk5Ly9JSVVEcHNKYTIxSkl2SVFoWkRJWU5p?=
 =?utf-8?B?a2hWM0VnTFEzYlV5VXkyK2JNdk1LVWVRNmh1a0lmd0o3QzQ0dW5zQmFDMVNs?=
 =?utf-8?B?aTB1ZUNMZlNidnJFbC9rMUhBbGNOaStlZzNUUDBUbHNSdHVha01QNlpLU3Vn?=
 =?utf-8?B?K1E1bmc0YWF1Wi9GcHpROThlaVlJSWlDMkg0Nk8rWUw5TFBPWXBLNk5nTmps?=
 =?utf-8?B?Qk9KL1dsUWZlcnZzK3gvdDVOajJkNXAzTDJkNnRKSVNsRHJLaE16dEJmSzUv?=
 =?utf-8?B?dTd6MWF0UDZWS1B5a2c2VWQ1S3BNR3owejB4cVN4SGkrV0xCMURrVE9mU2Js?=
 =?utf-8?B?cTVUdHNYdHIwQy91Y1l4Q2R0RkJsaVI0eVRaQnNyN09kQkRrOVJZcE1nV3Nj?=
 =?utf-8?B?WkRDSWYyS2k0R1pyd2QzVitHSGJtL3Q0SWVmcURTc3VtSE1kMVRDWEZTekFN?=
 =?utf-8?B?OC82R21xenZVb2k5VXJzTHJOS2ludnQyMzVoVHFvYVBLUU5KK25JNDFLTEZH?=
 =?utf-8?B?Sy8yYUl6eTZ5aTNMb2tLUXhKMFRMamtqVUVSMGtLNjN6SlF5RC9qa1A2Nm1r?=
 =?utf-8?B?RmdYS1JCeGNBQTIvVitLYlB6VkwxUjJJb00xbVEyZ1J4aEJNU3Z4Z21FZG0w?=
 =?utf-8?B?eWdZN2lGSzNvQm5DemNFbCswYnBDaEtPdDV2emtoM0xPUnF2WkNDSTloK1Z1?=
 =?utf-8?B?bjhvc1BXL3g0UDRGSldoSUNMQkQ5SlZOZjEwc3MvNEdOdjNyK0kraU1Xd3Ar?=
 =?utf-8?B?TUw5MG5MWEpqYURjZXBqclpWcGZ6VGdDc2FGaDEzZVdRQVo0SkswT1lNRnQ5?=
 =?utf-8?B?c0l6QjBWc2lBblZCaytlc3doaFg4L3lNUXpHaXQyT2dFQ05RL05WSmZCUWxD?=
 =?utf-8?B?ZWo2SUhlc3ZOdndHQW94eFhJOFkwSExQbHN6NW5QdjNMeU9ZK3Jtd2swc1BI?=
 =?utf-8?B?UmJLQ2JXQkNjNmhsRTBSc2VYTWZjZTk2QU5ud2hNMFJEVVhlbCtlQm1HWXJl?=
 =?utf-8?B?M0VybkJ6RmVIMWMrUDByUUlnNm5wSnVxUmhyYVAyc2FmQ0tVblRvMFMzZFVD?=
 =?utf-8?B?RTBnakdha2UzNVBMeDZkOXQxcUpIdnAwZFlOMmJuL1lrZG5NZ3c4L1RML0Zy?=
 =?utf-8?B?NkRQQzlrVC9Bc2QrY3ZOUmhhWEJ4Nm9MbW91Zmt0ZGFSMXlBekhYenBxdHlY?=
 =?utf-8?B?b2ZHRkxLYzlGanJreEdJMG5iWDkzdW1tcFN0bENhQ2dDOHdsckFDWUhUMVJZ?=
 =?utf-8?B?YnN2RXlHdndYYVFsV09YRFN0RlVuQlRrdzBOSDczZUpoUTd1dDdrdTVqNU9v?=
 =?utf-8?B?OCt3TVZzU0VhbWRqMGkwbzB3OFZZWTE0ZHNVeVpNbWN0T01QMStQL1JqL09y?=
 =?utf-8?B?TFRSb0tmczFGN3pYMXI3SmJOMEdIdjVEOVhndS9TL2ltbjJpVHk5b0dnQmYr?=
 =?utf-8?B?OWFBOC9KSDcrSURGUVNxTGFTd2pqL2hwZkc3THo4YkUwR1pPRGpDMm9mTHc2?=
 =?utf-8?B?dm9hUzJlNkxnWmEwMUVtTXRyWGpVRTZGcHEyZTFiSzkvWDdwWTVTQkx5dlBW?=
 =?utf-8?B?alg5VGpGL2o0bnNsVFJOZUYzemRNWmlIakRuWFAxcERyZitDV0I4TmFObmUw?=
 =?utf-8?B?THI4UjEyOWprb0JpbEE3V2t3RENOOUhvRmhGTytNWnlOWTliTFM1bkxmZzZp?=
 =?utf-8?B?UjhnZ2xzTy83bDJmZWQ1LzFpRDFINFFCSnQwRlVBSmdFRFc4Y2d0VHNUd0JB?=
 =?utf-8?B?NWgwUjIrTkFESlRCZDRhQUNsNlZqUWZWNXduMnNHOGpVUzg1VmtwM0I2N1VB?=
 =?utf-8?B?VkFldmpxTGp4aE1Vb0FBSnFqRG84bnZvbEt1VWNWSGlzZ0ZEUXU4M01CTVQx?=
 =?utf-8?B?bC9ZRDIyM2RrOEh3ZVAwSEVCbXVscTM1ZkxXQTN2SERJUURnVDRBMmVSYlJK?=
 =?utf-8?B?OFZwMkhuUHdpdkV3OENpa0tWN2RjQk9iU3NVakkrV1dqc3RBYXpocmM4SXpm?=
 =?utf-8?B?enF4bG5DaEE2cjFFMkdBbUR6OWtqOU1DdDVzR0xTVkJWa2xWUUZDVjJ3Ymly?=
 =?utf-8?B?aldld2VkU25aeXBlc2VRdHJBVUZUMGRZVFNpR2FEd3pNRExnd1VVSUVyeWQ0?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b83b72-2880-48ee-731c-08ddfaaa0ff0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:04:08.1923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StCljwN/tRIfTvjYNnVEZkXo61JCfbnXZ+5KrD00BhiLj64DP26FEPnnfVzm11/SHq2w0B+UX7Q1l+bjhoo9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
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

Hi Akhil, I will take this RFC down, thanks for the feedback.


On 12-Sep-25 4:14 PM, Radu Nicolau wrote:
>
> On 12-Sep-25 3:56 PM, Akhil Goyal wrote:
>>> On 12-Sep-25 2:05 PM, Akhil Goyal wrote:
>>>> Hi Radu,
>>>>
>>>>> Update the API documentation description of rte_crypto_op field
>>>>> aux_flags as to allow PMDs to define driver-specific flags.
>>>> Can you give examples of the flags that you want to add for driver 
>>>> specific
>>> work?
>>>> I believe adding driver specific things here may not be good.
>>>> May be we can discuss the specific flags and define them as common 
>>>> for all
>>> PMDs.
>>>
>>> The flags we have in mind are very PMD specific i.e. controlling
>>> specific hardware behavior so they will not be suitable to be added to
>>> the common flags.
>>>
>>> Seeing that aux_flags are not that strongly defined and seeing that 
>>> they
>>> are already potentially used for PMD specific values my reasoning 
>>> was to
>>> formalize this possibility of usage
>>>
>>> aux_flags are used here to potentially carry a value that is not 
>>> covered
>>> in the common API aux_flags definitions:
>>>
>>> https://git.dpdk.org/dpdk/tree/drivers/crypto/cnxk/cn20k_cryptodev_ops.c#n857 
>>>
>>>
>> The aux flags that are currently defined are for soft expiry(out 
>> param) and TLS padding(in param).
>> These are not PMD specific and are defined as generic flags passed by 
>> application
>>   Or getting more info about the crypto operation such as soft expiry 
>> which is not an error
>> but will be useful for application to trigger rekeying in advance.
>>
>> In your case, these flags need to be exposed if application is 
>> required to set.
> The application is not required to set these flags, the RFC change 
> specifically states "optional auxiliary flags".
>> And we cannot define pmd specific flags in rte_crypto.h.
>> Please specify use case if it can be useful for other PMDs also and 
>> we can add another flag.
>>
>> For PMD specific flags, is it not possible for you to use mbuf 
>> dynamic fields if it is an IPsec case?
>> Or we can also explore to introduce dynfields in crypto_op.
> Yes, we can use dynfields and we can explore adding them to the crypto 
> op, but since we already have these flags we can make use of them.
>>
>> In above link, cop->aux_flags = res->uc_compcode;
>> is set to give debug information to application, as warning codes are 
>> not exposed in crypto_op status.
>> Application is not required to take any action based on the values 
>> other than the ones defined in rte_crypto.h.
> My proposal is very similar to this use case, just in the other 
> direction. The PMD is not required to take any action on the value of 
> aux_flags, and the application is not required to set anything.
>>
>> -Akhil
