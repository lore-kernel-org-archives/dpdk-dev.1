Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0818E909DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:00:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11B5640613;
	Tue, 17 Feb 2026 18:00:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B9D0A40261
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771347604; x=1802883604;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=7+HJ5wDbgDZOVXUKirTCPZTVHdtbG6kV/b0o30eTaoE=;
 b=G3APjO9R1vd+eVfbEBGU/Vm/FYiNmIFLXFboY4jFQQOv7xRevcG6orNq
 Ucc2s1Bk+cGUe/TYuFlv8y0ULDRiEb+9EIDAGAgmBiL1HMYn/akybhR6o
 r9HHjoXnuIAtASm0TLJ5N5yg5Itq+r+Q2uKOh75m/fZ0k4k7E5WAyUcD8
 qaM0m2YvuLipS0f3c/l5W5aGwOkqTT3bc/k+k5bCk0Nc3dbmUZm2I7AM6
 lRuHVYvW5aWG8YBjqVgPr96tM3lDnRIWxTBnwpKRQZ5sM4JWz51F4vZbW
 R1NrBtDTICv4EmLL9a3ed+n4tSnLZ8881CWG+V1OyRlmY+1rvuD+PXXFk Q==;
X-CSE-ConnectionGUID: Yb7SE0ZrQO+xFLp0IkJhbA==
X-CSE-MsgGUID: mXUjT9YER6O1mSCC1j6N/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="97881338"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="97881338"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:00:03 -0800
X-CSE-ConnectionGUID: 2iep7VvoR1eOk4RhtorY8Q==
X-CSE-MsgGUID: VuODOYExSWmXwVnTP1QxMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="213181400"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:00:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:00:04 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 09:00:04 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:00:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umOQwEujusnYCHH8ylDXPFM2g0IZ/7o4682pqi89u4PCxfHfKWaOW1ayI/lGqlk8YS8yfdjqZxYWfuzCm8knKYScCl9yd+5CVTvKpmnBv/+oGFBLrFmMg0whggfkMcPlqFG5Q7LhM2x5tcMx60XnzR8q2tcg8UJ7aegShpYL5c9AdQLMfvsOStAUBbw5JHWKWPjZK8eWK5y1trS7FypdsonZiyhXiAry+fm2vmkfrx1wBbbf/E4m0+hsdSrfi5Yxdtdry5O5UDzom4QEMiTrWaLiIoaK3z17zf+Fs9xHdq9+8A1Z56q+LqO3BUiOiyvR4Ouf065J/Y97uUfq2anA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehkSDQrELzd9xqAz9igZwfTSYQ6QcRjInpluVLTGQK0=;
 b=nv8Udni+EyxRVFF/1+LJSvwOTRz+ycRuE2VFCnP9ZW0U8VskYFf6y/9HVyIqrpfSAG8LQcKnTtMZj3hwncpKiPJkYaq/YNhtxp9G4jFAOhy7n3XgTSqbMrr9Hqju2oA2gAt+8Muw+EINt4IO1Xx95D/2uKBKP8FkEG8k2a8cL+JiHAdPt7lnWYQ2IPKU/IXuFy6BnJKa3Yzwr0lpO4xE9K20+8eeYo3Hxpy8vCMyiwOwVBZ09SuM0IJqmKLWjKe38vbvaMWPBU8bpilcEnF9OCUOIekGeaYHKxQOhBmfuZc2SlZ6pT0KpsltNvvwNGIuk5rkNO6NbMVyKm/EFP14xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SJ5PPF867D7FF5E.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::83d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 16:59:58 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Tue, 17 Feb 2026
 16:59:58 +0000
Message-ID: <4d3cc8c4-89e7-46e1-897b-aa6f282f034d@intel.com>
Date: Tue, 17 Feb 2026 16:59:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/27] net/i40e: get rid of global filter variables
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <2a5d484fd32010a5277c2f3f5c46c2406610041b.1771330391.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <2a5d484fd32010a5277c2f3f5c46c2406610041b.1771330391.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0257.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::29) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SJ5PPF867D7FF5E:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4ba4dd-4996-435a-6b4e-08de6e45fb51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dURGQnhjVXFTRUUrTWRaUDJ4bnNhR0NyVUlTRnRwQ3prQ1NmWllNK0s2L2E0?=
 =?utf-8?B?QzNWZWszZTBnZzl3dlJEU2xuNnZrc3UwUGtGMTdDRkc2RE5JL29HSVIyaTQ3?=
 =?utf-8?B?TXJQSXkwYnpzbDl1K3oxOUZJSGhDT2hUR1N6WGYzM0RNNDRYbjlkYkxzNExx?=
 =?utf-8?B?SGF3WEJkZlZ5NkRkSktGOEMxeWEzb0JWZ2dzMnFnWDVFVXBDamIydzdhYjNF?=
 =?utf-8?B?UnZzbSs0b0phclVtSFJYUCtRNk1iS3dVZks0UmdMWndWSXJYQ3hvSVFYbUF6?=
 =?utf-8?B?anlDR1p3MDd6SDIyVmV1QVJwRFlCZTg2VktuMERyWDBWYjZTQXc1WlNqY1o2?=
 =?utf-8?B?d2k1UHNNU29EWENyUzVhcUpXMStwOHRkblpkeUFOdjh2cHprNWJvNFFQcEx5?=
 =?utf-8?B?OFgzZVN0VSs4Tk44aUZzVXRCRTA3dWRXRnBSbGRaNlc5QmVoVDdwTTF3VWVs?=
 =?utf-8?B?ZDlwKzZKY1RzUFYrYmo2bUlyVFg5aC9pL3ZIa3Z5NDlMS2loNXlDaGtQQVQ0?=
 =?utf-8?B?NDduYkt1c0hxZ2FPL3JHS3NGeDBPUVE0TGx0UGdIK3pEQzJNMmRZd2l3emlY?=
 =?utf-8?B?RkNTN1NDc2E2RzIwNGdMRzFEU3NGSWFJYWgvaTh2b1FlWDFReXkyazdDL1RP?=
 =?utf-8?B?R3JsUFFHb0xhdm9xejZKUkMwdVhqMmMwWGRVNUQwR1U4eGhlcVM2bU02czdH?=
 =?utf-8?B?L3NtTWoxTW9rYzBvNjlxVEs3VFRRbDR5c1paL1lBNFZoRVhqcGd1Mk1HQWNV?=
 =?utf-8?B?NDRuSnhCbTFXSmk5ZVpjdHBpd0plOFlzc294Y1hQb1dReFJsU0RSWWV2a25x?=
 =?utf-8?B?UVdzWllZdTRJdTNFWlNvaTdYUUZ0cVVCT3R2KzZmKzRUNGRib3NIVUE4WVdv?=
 =?utf-8?B?NktVd2ZmelRzY0s4MlVTRnVEUHNLbS9YNFdQN3VCV2gwb2t0TG85WXpxTUNQ?=
 =?utf-8?B?SW9tcnVrV1lMeDdCWkNUUlR3MUxBVkRSVFNycGFDOEprWG1XRzVlVDNhMUUr?=
 =?utf-8?B?Q3BhWWMzclJHYWIxb2lNQkwvYWVIakk5d3U2WFNqaUJacndSUHB2anNNeXBl?=
 =?utf-8?B?MWR5ZW1VN3ZRTVZRUXBFc1JtSWVEZmFWWUJUWmRrWlZRaHN3SWdFankrSW4y?=
 =?utf-8?B?dC9OaVFyb054VmoydlNhRk5hTnc0VjVFMTZhNHIzV1lwZHlMZkF2TlhuQzhr?=
 =?utf-8?B?U0wxSEduK2grSkZCMDlIOE91SW1QV1dJbDZBZng1Z0QwTUJXTzlqVVlVTWty?=
 =?utf-8?B?MlFXNHNkS2xsVjJWMyt3SUpkOE1CZktVejNLVGlEYnQwbVI3bUVnOTZXc3Uz?=
 =?utf-8?B?dm0wRGtFU1VyZ1k3NzQ0MnUwUUtPV285cmpRQW9TWUl0Y0t0c2lVMEFwcm54?=
 =?utf-8?B?cVltRnhaYjZaY1lUMm1ZSjJMK0ROV0plTFBwY3pKWERDNitvQ3JnOE8zOG9t?=
 =?utf-8?B?bkxEL1FaM0M0bzJVK3dVQU5SaUR5dWdlOVY4dGxFNnVPUG9aWmJ4Zm80d1Q1?=
 =?utf-8?B?YkwxOEU5ZlFadTdSKzB4c3laTVJEY244QkhxZHdSRk9udnJDRnFhNXRxUmhq?=
 =?utf-8?B?Q01TSmRBb3psc2xYQkhWaXBEcDNEdFhUSCtQNTIrSEtLdzNxaWVxbCtlcVhP?=
 =?utf-8?B?UHlmaythbEQ4WDZ2NG03SEZpdmFZQzJWUUwyWjdNQTRXbVMxVkJ0blZ2aE5n?=
 =?utf-8?B?cUhUVnM4YU5JbUxlZi9MNlR2bWxoNmlBY2tmOVpPeFBPeTRUVTdzMUFpbDhI?=
 =?utf-8?B?a0M3dkJIK0kxOWZ3bHc4K00xYTVaZzNoanB1SjhlNHdGOXlncDAzdU5qU3p2?=
 =?utf-8?B?eDc2aHc4TlRxb1VUQ1RscEFBOGlWbFhLRDVJZG5VRElmQmRFeXVycEV6NGkx?=
 =?utf-8?B?Y29pYmMvdTR0MUdXZVF3MUJUcDBNTitVNGxnMTl3TWRQTzZyY295ODZFM3FE?=
 =?utf-8?B?RVNIRW52T2s4d1NsejBKVS9jWnV0ZlV5SThBT0JVTHhKanhvbnI1SXZOWS9G?=
 =?utf-8?B?N3g5a1VQNVA1dXpKSXJMTHEyeGk3RzI5WDhXSjNucHhVUjZSRlpaOER1QWJY?=
 =?utf-8?B?ci91VzJBcCs2dkQ0RjduSWNGTGU5eVg0WGtuZ0NJTkN0SGNzNVFIalM4b1g5?=
 =?utf-8?Q?XWs8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTdzRGd4YjFjQmlubTFNdnZVQit4L1dnVzdHWG5zS3BXZTJOdlBPaWZzelA0?=
 =?utf-8?B?TnVMSjBrdm53dkpPSUE1bzBadDBic1NoUWpEcm1renM0VTdhZXdYN0VtT21u?=
 =?utf-8?B?S3BJY2QwWUJPU0tBeUJacUlaV0lNRkc5VUVqU1FBaGM4Zk1sRTU3OFE5WmtH?=
 =?utf-8?B?c1VIOTBiOGprYU1xa3o1MFdEaHBsOVZ2dlVOa3Q4akVmbFFtaVVWRHFXbHN0?=
 =?utf-8?B?QUdZZmloNWtNNC9Ua0JHK1pMQ2FyTUp6TDNYRmk1cEhNQ2s2OFh3T3QvZndu?=
 =?utf-8?B?Znp2N0xOU2VaUnhPWnVCcXlZdmo1RmFuVktLTnpHRWJXNkdIQlZJeU9JZ29R?=
 =?utf-8?B?SjVYK2oxWmU1MGJIMEVCTktoZUVqOTNHREowVzBHcGwwdmlFVndlR3FJMXRm?=
 =?utf-8?B?T0V1aWk4M0IybU5pdng3QmU3VXB6a3ZHNm1aSEMrdHZlS3BoQTI5RTRydzFL?=
 =?utf-8?B?UE9GQ2JpMFJHZUVYWWVrZ3FwMExWYUNYUnBNZU1FWEdkcEdvb2ZqN0xZK2s2?=
 =?utf-8?B?QkxxQ29EVi9CQnJ1WVk0aDZiWGtlN0NsTWNWUGlFYWFNWi9uVGFwSlRBdkdI?=
 =?utf-8?B?dUMvSHZpMlNqd1dWcmduUnFyL1l0bzZVYmRIeEpNVmxuLzE1QnQ2WGQrM0pJ?=
 =?utf-8?B?WjdCa0Fad2pndlBCOHJXVTVkOW42d1hLdmsxeE1rcjZ6K2ZJL0RubmhHSHZx?=
 =?utf-8?B?MXNOSEZqOGs0M2h0bVlHK003YVdpRWgvcWJyMDRzSnhkVWJtKy9mVkY2cE9L?=
 =?utf-8?B?MlBON2NHNm9nb2J4Y1V3MUFUdEVCOElIWXBWdE9tUDhTWmhFQ2tXazB5UnV5?=
 =?utf-8?B?c3EvZHJ6NzdhNlQ0NzFKMWNLbzJVaEl0OFhFWm1FcUkyR3VxdG9yZDZFcVNh?=
 =?utf-8?B?WDJkSTNQOUN6bm1lWUFURjdrS2tYTFV5R2xFOEE5aE1Va2hiVGJsUWUySVd2?=
 =?utf-8?B?czRDdTJ3cmQ5S0JFbVFFanR0V2tFOG1DZXBkMXpmRFQva0hRR3lhNExwQmV5?=
 =?utf-8?B?cGwybHlabTRpZUhXUU9DTGJsMEVERGQ3YXo5QXZTaFFzYnUvOXFKSTJTcDhW?=
 =?utf-8?B?ZTdwODZicXRneExPR2Z3SHJGWlhpUG9mV3lJZEpuT1VGM1V3SHhyOFhrRjNE?=
 =?utf-8?B?Mm9hamVBclNNOGdZdVlWMUkycnRlbnR2REFIWXhiM2ZKNkZDUmdNV0Z2cnR4?=
 =?utf-8?B?eFRvMXJNYlRWc1k1SVE5ZDZ4Q0tKRk5hTTd2cjVZS1VkcVVmY0ZtdTlYcDdP?=
 =?utf-8?B?dkZIeXpYNnY0ZkxEUFdDeit4NEx6OWIrZzYwM0pTWTdPS2RtWStkR2tRejd6?=
 =?utf-8?B?ckU2aE4zYjJ5dCtUWXFQbUJOelBzcnZkSlhpQXBWQW5WQ2M3KzExb1E3M1Jw?=
 =?utf-8?B?Z3c1czU5NFdBQ09HSCtwMmZkR3UwUFNPM2VjRmNFdUk1bTRWVnljZ3Vidld6?=
 =?utf-8?B?QklOdTZVU2p4TjVSdWZjZnJCWE1GblFsd0VWeWNPVWx1bzJoRWo3YjFXSm96?=
 =?utf-8?B?c2tMVlgzWTFmQkVaakRWRk5xQ2RFUjZEZloxNUNmeWl5SlU0bnNkNDJYK2Vo?=
 =?utf-8?B?aHhJeU1RdVA3amRydDJnajhRdi9Ibm5lTS9Cd1QwdWRVU1hha1ZGVTFUMlBT?=
 =?utf-8?B?S1UzaVJiS2hYSmx4ck9YSUxwRmJOc2d6dVJ1ME5yL3FVTkJnUENJNmw2eDVB?=
 =?utf-8?B?V0RPb2tvWSsxb09BdGEvM3FNVTBWTTc4Q285SkFRdXprMGlWKzN4K0ljY3NO?=
 =?utf-8?B?RkJPbVVpQk9pNkNES1FCUEl3OHg5czhZazAwTDBiZFV6Vkw3aEdEYSt6KzN0?=
 =?utf-8?B?LzZzZVIyNE42WUxnYmhwVzQ1alowSm5jenNQUk1hMCtWOHh3ZVJYSTZ0WUky?=
 =?utf-8?B?a0tRTWs1dVZuS3hmVERZNDNGMDRSV3REU0dPeVczVk5uTDRKZE9wMWFsUjVs?=
 =?utf-8?B?cUVqQm1IRTFkcFNaYmgxMXJETFRTdGZGRzlaRU1FTUlyK2FmU3E5STJ2eDdF?=
 =?utf-8?B?aDNqeUo0cUlqREFEY1d5UHBFSXgyeFBTblB4RzZiUktiZXdGdXNCTzlGeGdy?=
 =?utf-8?B?NTBUT2ZjK3RHdmxGUzhXdTQxUG9sWCtZR1ZKNW96MTQ4K3p2NmVvRWhiVXU1?=
 =?utf-8?B?endkVlZzSW01c282eHprTFcyRThaZThxZnQ1eWNodUFKMjBia2YxM3ZBeExX?=
 =?utf-8?B?U2hmejN3Z0IzZkVtbHM4Ti80ZzJJNUxaODRudERBWW14SFVSWE85UWRFdEtv?=
 =?utf-8?B?dktBRHNqb29pZlNLRnpycEIxV05JcjBUckFvWjhjUkovTjI2R2VIb1QybTUx?=
 =?utf-8?B?dEZSWmRZaVIxOUJNUmJkeWdHbERqeGc4TGl1ajNMM2FRUGRpRW5HZmJsODg5?=
 =?utf-8?Q?8xIUYSXY2zPw5G0Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4ba4dd-4996-435a-6b4e-08de6e45fb51
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 16:59:58.3191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeKbsgSjOoYzSBkNA0OV4MoRz5h9D47tH5vwIeQqf6gnpwRZZYDSnwhIR4Gw4IJffL6+oofks9k2+zmnRpLJNAtefFklyokPyoR5xMP/bcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF867D7FF5E
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/17/2026 12:13 PM, Anatoly Burakov wrote:
> Currently, i40e driver relies on global state to work around the fact that
> `rte_flow_validate()` is being called directly from `rte_flow_create()`,
> and it not being possible to pass state between two functions. Fix that by
> making a small wrapper around validation that will create a dummy context.
>
> Additionally, tunnel filter doesn't appear to be used by anything and so is
> omitted from the structure.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_ethdev.h |  16 ++--
>   drivers/net/intel/i40e/i40e_flow.c   | 117 ++++++++++++++-------------
>   2 files changed, 68 insertions(+), 65 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

