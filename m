Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C1C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 12:53:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C2DB4021E;
	Mon, 21 Jul 2025 14:53:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id E4AAD4014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 14:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753102436; x=1784638436;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=iQtGsMzRtGzp9NfQvZjlWf0xOQ/yXIeigtFR5FZJO/8=;
 b=HMFhSWKDesiwd/0PbSIN620W9img0b2JCp09vPIvsbqyR4FcAqsp5R0T
 uqESxPblQ0NT0aQ6P4SEwRyMCOha3ZVF8REzNn74/29GrXmkvXpjHRqku
 3NRd/wHi+XqEEOd8ThvCLXAOrnw4RhBDqC/8IPIbuzqKGRncvPJ8m/JR0
 S+mrz6niSWOsvaKh4ENRNWhFhsCeOWq32g2qpZdyjVDPriGu1nDnCklSR
 j17dN+lZ++ZDFD0fNUpGmzNHdXNkYOaMkT3qLjrJcCvH+otDWD2ugoPZG
 yJAcg9JRwu2+GBhE7wsyGtoV42qcT85WYyOs3GA9opTNFWlueXC9BGbxb Q==;
X-CSE-ConnectionGUID: Oi+n7Wa2SR6N/u2XYZyk7g==
X-CSE-MsgGUID: kuMLWrLfSpuPSqsqI2LhGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="80759712"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="80759712"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 05:53:55 -0700
X-CSE-ConnectionGUID: h0/iAnHHR8ao0VfrfQXG+Q==
X-CSE-MsgGUID: s2tp4jDaSyCOaWzUvphawQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="163057012"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 05:53:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 05:53:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 05:53:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 05:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAmK92ED5EmYyDpXuZTtA2D8TuTYJLYVPtaaWPdcRBb+FblRhGTyHFOmssMhMy6qrNhzFkVOQAh+joON+AI4+3iu0PR0pz7D2rGOdUroS920o3JYfeMyNcLKiP1nRh0YZN2k46BgMGWjmmKRpeWE5p9xFbKTs9cfMCDseRLKojnswmjsTZbz17UhAqNEr9w2QCBinj8hX1GWZ1i9LFBap77ZXaxL2ZAbUzU7rzSzU8I3hslLjNNgLT1dM0cl0sYoalUjn8JY9J+JubLNbC8hezunmwq2YdMH2llkPF4JUjpNGBBZhz8edV0T5Vbc3gCbMOKs/8NLZGXILlrRS7g3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nSrLIeLUyXNI+bpVnMorojaitYXQAiTPHIVO7YST/s=;
 b=SanuYwaE3VaCE3ROGAH06viUd1whLOuGQ1xEbAlUBj1E86p8TS7u0LTymAgGtBeGXxUvumZvGC4uPd7BPNAAUjvRrD+crPUJiZlPR9gNJdcfQzAZ/ZvDImEGjqnpIUzUbyLURb62ykk/q0IUE5cKAHTWTjZvh94ppIqxy7Z9FVgNJhp6/0T1B0OAot98TStE+O1gQp1xdR7OYofd/cc77RKgqT1jRD1Rf3vENpMtUc0NEE84Ppx7DMEBtZbWHiyjy1e0rvfWzJFSSqjWjZbMzOz6VLikdsrMjG0qPfeP05K38sgl/XX10ivsaJi6shINCPi+hYeTZOVZAGUYbdy3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5004.namprd11.prod.outlook.com (2603:10b6:806:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 12:53:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 12:53:49 +0000
Date: Mon, 21 Jul 2025 13:53:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Tyler Retzlaff <roretzla@linux.microsoft.com>, "Thomas
 Monjalon" <thomas@monjalon.net>
Subject: Re: [PATCH v3 5/9] eal: define the EAL parameters in argparse format
Message-ID: <aH44WFlx1hP9JcWB@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250718143356.1578988-1-bruce.richardson@intel.com>
 <20250718143356.1578988-6-bruce.richardson@intel.com>
 <CAJFAV8y5_O3T6hLbZov0LqhXyAu2s_n0P3C3Y+WSGVUjd8gbtg@mail.gmail.com>
 <aH4C06sBOa7q_tlg@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH4C06sBOa7q_tlg@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB6PR0301CA0092.eurprd03.prod.outlook.com
 (2603:10a6:6:30::39) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab51982-a2dd-4d2b-13f6-08ddc855a344
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFVvRFZnQUlDWG91QU91UlVORWFWKzBoOEhBMSt5RUtFZHFQTTNLY1BKUHR1?=
 =?utf-8?B?a2xXcW1kU3M0QkJEN2JzSHA3SysyUnhxWEJVSnVLenZ3Ty95NHd2Mzg0bFRK?=
 =?utf-8?B?UzZ5VHdBU0pKbTcxaEtVcWFQVnlTcFFZZlA5cmxocXFNQlg0MmRxQnh4VGVv?=
 =?utf-8?B?aVlySmRwWnYrNmoyU0ZqMGwya2RKdVo1VFRDS0FhMkU3dUpyWXFuNDBRcDBN?=
 =?utf-8?B?ZXpENmQxNHdxdTV1aEF1WGMxRGZpQXhpYmFZS1BQakd0MFNZT1JxU2xGM0Jj?=
 =?utf-8?B?OEMzNkZFcnZ5ZGtCZzA4NDgxbUhudGc4aU9jcmdnUzBtcGpCTURoNzZCY0Yr?=
 =?utf-8?B?WkxZYkZUWjBtWFVRNEhnYnh6UVBodzFmZ1ErWS8yU3dvWnZGd29WNTZpbDFQ?=
 =?utf-8?B?eW53OHZISDBnTW5VZFEvUkxZYS9CMytQWVFYa0xMSkRXZnVKcUlvU01Xelh5?=
 =?utf-8?B?VitaK25GRU9qMGFXRDFaNC9vZWxsd3RiZ2o5VlFPdjBBWTNTZVBWQ083RkpS?=
 =?utf-8?B?UXpHTkx2OVcvYWJoaURpdVk1aWdBYzFzeDMrMzZ5M2tYYjY2aDhWUHVLbFVY?=
 =?utf-8?B?bVhWOU9Cb1B6YzRuUmJORUFod3JwNVYzeVFOU2xLZVk1MUZPUmpka0RCcHF2?=
 =?utf-8?B?NlkyRk9JWldwRm1ZbUR4RS9WeDdVZVcvekl0azJoV0xmSjhDMFlyL05jTWFZ?=
 =?utf-8?B?aEF0cXZHWUIvaWZlZjEyNWZYcy93Nmt6QmtVMWVMWDhPS0N6VGU3RlZVV251?=
 =?utf-8?B?aUdqbmdNOEVJSDRRdFZDQjc4cEhmQW5KV09LRWQwVmdleWFYejJBdW1IK0V6?=
 =?utf-8?B?VHBLd3NxWThOUXhDR0I1QXkxTnN6c0lwS2tQcEQ0R1FXRlpPOXh5em5QU1ZY?=
 =?utf-8?B?dTc4VGg5K2IwcmxaY3JyQkNYR3dNUkJncXFHNXl2ejBGZU5Gc3JTZWlVSkdJ?=
 =?utf-8?B?VG1pbkpTamxRc0prTEJGRHd3SlhiVDNJbWgvSEZGZFNNaDJTZEViS3V3RDQw?=
 =?utf-8?B?QVhGU1hJS2lSYVZKSXhPL2ZRMVUyaVI5L3NhUmhaT2dod3k1UVJSWXg5bDlE?=
 =?utf-8?B?QnUwVDlBQ1U3RW1yTTl1VnhTS0FRMER6ZFIyTThJV3FxdDNaMlRQTzJHekFC?=
 =?utf-8?B?azBsbXBPM1I0NVltZXEvUU9FWDhZeW4vN3Y5dVJrSm5SeWJLNEJQNndsSlpy?=
 =?utf-8?B?b3o5NjdGVnRraFF0L1lMZjdCa0JYVFlXZDdsd2poK3kvTXYvOHdHS1R4ZjQ2?=
 =?utf-8?B?TkNldjJEWVJJM1AwdEJURW8vbWt6Um01MlVRUk0wZ1FjZkpTL2NoY1d3V0Ur?=
 =?utf-8?B?NmIvRlY3SENYUll5NzlBZ2NhTTNSdC8vdWNQSHkvNjVPWUtZM044bW1aeHRG?=
 =?utf-8?B?dkpjMXpXWHJOT25kOWdSUm5WTWNkSWREc3QwN2VzdUsvSlVJQ1JsRS9ncnhR?=
 =?utf-8?B?Z1NYRnRxbGtwM3ZNL1N6cmt3ajJLME1UYkNld2lIS1VwYXBOOCsvL0c3WlN2?=
 =?utf-8?B?RHk0SUYxa2pVRmdwYkFpWG5qZWg0TEovUGhDb05mUzgxUXl6Yms0VzNiUFNs?=
 =?utf-8?B?enlwNVNOVkNFZlN2T0RGWW1heVZWUjBHbFJ6ZlFZZW4vSTh2dTRSbTkvcDhK?=
 =?utf-8?B?ellReU4vay80ZFdReVFUUzdURkdCYkE0b3A2NTByRXFWUUFIemNXSDhwbVpX?=
 =?utf-8?B?MHBndnR6d0E3YW5XT25TaS9VV29EYXYzYUpLVHpEMTBZWXEvLzJIalBVNmVB?=
 =?utf-8?B?eWg4UzZiZVRONlhsQnhpTUZWcldGeTN3VjFwWUxjU3BLWmFwaGJvc3B5VlR0?=
 =?utf-8?B?cGRvWHJYQWI5dDFCV1M3c2w5REtUdStGTUlwc3ZIUU1GMmxuSTNTRGQ0QmNE?=
 =?utf-8?B?eXZQRWpzbVFud25TbDl1c3lpTUpGaVdaWTBEdjVra2ZqVmRUbUpaNTNDNjRi?=
 =?utf-8?Q?y/xHRqyEDpg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlRBSjVjSDR3d2dlUDA2YXdQTmwrNHhRWnpOMWNOYTJ4ZzA3NGpsR1pjMGFJ?=
 =?utf-8?B?QXdWNHZHTkRvb1ZtTiswWGFWRmNEVE9kN0t5MEZFcHJCZGNiWEp3R2NRN3hs?=
 =?utf-8?B?K1lBU1F2a2tKYlQrU3pwQ2FDK3JNMXJ3aGF4SXNKV3hUeEVXNEFmVXBaMk9T?=
 =?utf-8?B?RXVUSkxSK0MwcWJ0RS9pdDk1MlNVRnFjQmRsdXlxN3krYUhSSlV4UUJzdmth?=
 =?utf-8?B?ejRoWDdyU0tHUXhFbjMyUE9kTTlkZ2JiZ09tdVJVTDhSUE5DOWRLdzV4SmFy?=
 =?utf-8?B?RXFCSUtPazNDbExYQk1pcmNoOFl2bWtUZzJJMnA4T3pzQ0hIZVh4czI0Y0tE?=
 =?utf-8?B?Qi9jSHZGUEZObEREVnFTVFRVWHUwbytjSTBVUUhMcVJZWmNtT0FobWR4QjVx?=
 =?utf-8?B?WjFuQUZDWS93UFRvVXpZTzhLRnVZVDhlWm5DK2xHWFhlWWk1c2xKRGZId0xn?=
 =?utf-8?B?WDB1RFNEenZkbmxobGI3ZzNadUU5eGdKeG03SjF3Q2xFbi81NFlHYngxSG4x?=
 =?utf-8?B?RStwdzdqQ3FyZXVHc1EzdW10L3p3TnNOby9qOGxWMk1Xb1ZFczR1RnBRc2Yv?=
 =?utf-8?B?c0E1bHdtalYwajV1bWZreFNnZ0pPLzlMWkZQcFJWeHk3S2JiVUtFd1RVMVBJ?=
 =?utf-8?B?VDhQZ29HYzFPZGQ1UW00M3IwUUw4SEFTMVkyRmtURGFrWU1TUk1PS3pFOFEy?=
 =?utf-8?B?MDBCOWlRRjBFVGcvcXZadmJ3bUFZZEswNUtxMXRYZjdCZ3lBZDQ4Q0RaL3RG?=
 =?utf-8?B?Y0pnTERGeFVWRFZ1WVJJUVhGWSs2MUFGUEE4MXJWUlJKUkF1R1haUFMvdDYv?=
 =?utf-8?B?RXlvSnhyTjdvREZsTXhoczNDT2N2UkZsWXhKRU1TdS83ZitIbVBnT2g4TkdK?=
 =?utf-8?B?Mm1WNjZCSENTZ2wzSTZ5THdFaGl1SzRyNTVTTWhBa0FvL3Z1ZXRGcmdhakd2?=
 =?utf-8?B?ZmFlZGl4UklEbzk3alg3VFU0TW1kdXJUTzBrOUJiY1o1N2FZMC92Q25nZU5Y?=
 =?utf-8?B?Wmd1TEdZVHhKWnozcm5XVFJ6Q2dUS0lTRFc2aUJQMEVOS2gyVTdDZEFiejVt?=
 =?utf-8?B?Yms1ZTV0MVVkdUF2aW01cHdRdysxTmFTRTRkT0lqbWZBSzJTWWx4blJlc1ds?=
 =?utf-8?B?bkViNXpiR29OTDd6aFVhTUpDZmI5cjBtYUF4MUttVU5nM01PbkNHMklJT2lr?=
 =?utf-8?B?S2h1OGF3dG5SZDNQUU5UdHdodmNRdy9UOGJTOHYxVmlvYVNiUHdXR1N4NmJt?=
 =?utf-8?B?TmY1Vmg1TWZRNFVzY2JydUlwYjR1c0NNelBXeUFoOGhtVXBEYlVjZ2tEY2Vm?=
 =?utf-8?B?cjE4SjNLckRreUhuV2wxNWRuc0ErcXFoVVRBS3A4cHZrVWZtRUN6Y3V2T25v?=
 =?utf-8?B?TW1uNWxWN3k5c3hMYWYwNkpCN1QyOXZoU0V4Z1kzZzdTQzlOVEtxR0c4T3Fi?=
 =?utf-8?B?L0pOUGlFM1U1S2dWOEVOcEdRdWdOSElDVDd2VmhsN0NsOFpPM044ZmdmZGxR?=
 =?utf-8?B?Tml4eWhENSt2NEdVeUtKaUpmcmN4UC93K2VBRjlOcWJRVXR2bDQ3NDJwUUsz?=
 =?utf-8?B?WmdpOFl3VDRiRkdlb2JDUTlnRDFNNlM2NXdsMUR1M3doNTBRVnAzWUlSdjNW?=
 =?utf-8?B?dUx5emNzQTZrSEpxc1FKS2Nzam45UllqY21yWjZXN3dTWVBJT3MwR1NydXB3?=
 =?utf-8?B?Uk9PZFl5ZnhvWnZReHBvRXJIQ1BHZjd6d1pJZXZOMnprUGJ1c0FwMjkwSEJj?=
 =?utf-8?B?ZkhrWk4vMGZOZzg2cnAzMWFwcHNxUGdFRmlvSWYvRVNScFpmZ2JweHpnc0Z4?=
 =?utf-8?B?dnVCeUs4RXpSUzY4NjB4NzNMRXRMT2hPd1RuMkxNbTU3WlU0eUZVaFU1L21P?=
 =?utf-8?B?NDl0VmF4RFA2WlhWQ0hrLzV6NVJCU2xyYlNrd0dJcjVBTWFCVFJ1em1WQTNO?=
 =?utf-8?B?UEFQQW92QmlGZzBteVp4REdxK0s2bWdVb2FVcU54NDBTOUo5T3hCcUhsWU8w?=
 =?utf-8?B?YnBpQTV5VVBqRU14MGZOZmlkMnF2Nmpnb2wzalNlWElRSWdiRjJhZWxPbXkv?=
 =?utf-8?B?dGFQZ1dIUEo5aE5UMW1ZOUNEdlBLeFVvODM4OHE0YkYvZXUzdHcyZkpQdUhl?=
 =?utf-8?B?ZzdJYi9DMVM3TkJrOXJUT0swSVhiais0TWNtYlFBbGx3SDFiaDUzbnNzd1pB?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab51982-a2dd-4d2b-13f6-08ddc855a344
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 12:53:49.6614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRPPT9PGkh/Nnvv3e1ImhLl3G67G0PWDF2PlsONgEBtYm9kpcCYUhVoEDeyQ/4+0H386SjITeQrHmrM0NK4lzuruGZfJ9w1D4DUkusdbuj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5004
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

On Mon, Jul 21, 2025 at 10:05:23AM +0100, Bruce Richardson wrote:
> On Mon, Jul 21, 2025 at 10:41:33AM +0200, David Marchand wrote:
> > On Fri, Jul 18, 2025 at 4:34 PM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > > +struct eal_init_args {
> > > +       /* define a struct member for each EAL option, member name is the same as option name.
> > > +        * Parameters that take an argument e.g. -l, are char *,
> > > +        * parameters that take no options e.g. --no-huge, are bool.
> > > +        * parameters that can be given multiple times e.g. -a, are arg_lists,
> > > +        * parameters that are optional e.g. --huge-unlink,
> > > +        *   are char * but are set to (void *)1 if the parameter is not given.
> > > +        * NOTE: List is to be kept alphabetically by option name
> > > +        */
> > 
> > We will have to be careful to keep this struct below, in sync with the
> > options list.
> > Could we construct (at build time) this structure via the options list?
> > 
> > The rules above would be enforced at the same time.
> > 
> > (macros + #ifdef for Linux/FreeBSD may be an issue for MSVC though...)
> > 
> 
> I wonder how much an issue keeping them in sync would actually be? When
> adding a new option to the options list, it takes a reference to the struct
> field, meaning that we can't forget to add an entry here when adding the
> option. If we add here but forget to add to the options list, then obvious
> the option just doesn't get parsed so testing quickly would show up the
> issue.
> 
> I suppose the main concern would be around renaming or deleting options -
> though in the latter case having an extra stray element in the struct isn't
> a big deal.
> 
> I might have a shot at auto-generating the struct, but I'm not convinced
> the complexity will be worth the benefit.
> 
Auto-generating the struct seems to work fairly ok. Will include in next
revision.

/Bruce
