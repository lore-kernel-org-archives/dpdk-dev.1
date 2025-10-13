Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20433CCD183
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 12:36:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FAA2402A8;
	Mon, 13 Oct 2025 14:36:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2F19E4028C
 for <dev@dpdk.org>; Mon, 13 Oct 2025 14:36:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760358971; x=1791894971;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bDpWzS0a9bok0g49ZO/+y+cbkgdXXQlpDL5fYUYjicQ=;
 b=VBH9yqRiRmVYX5hCQbcHni0vsTTGXRQEXiAkL2QWcACUw74MWxydZhpM
 g4IWYYWCU38blgi31V4oVGDdpcxWDuW/la/79irjlY+5Oxz9M6syIXXkI
 9EXrEcKVC7OeSbOrpF1o7Cm2W1eYAjdYpg+K6S04ySjyVhsWC8CaviqAn
 OqCNN48/DXHF2sau5X+2CEKynlmltozQ4TxJqGnNNrqDlaJCos1pmjxgn
 wftv9w+r58EXx3P02dhMJHkGRDyVToCBssQWgTZG7M/cm32msPgBTjJh4
 MI3ObB+kajm4sxst0EkyEZiKhaH1xHV3OUW9gozPPbBb08JFOCOKnm7gF A==;
X-CSE-ConnectionGUID: NdpPqWa7R/y6J5VInbaNjA==
X-CSE-MsgGUID: racfiLKnS8msLMrtHVsR+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62384790"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="62384790"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:36:10 -0700
X-CSE-ConnectionGUID: R6bW8xXXSGGPtjiB7o0c3w==
X-CSE-MsgGUID: pZVvnhr0S6uFmHljOhnDrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="185851924"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:36:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:36:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 05:36:09 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNhIrralIX1Q7xX8oyUjBkOifN7tY0nqmRypdDOSAmFqIBAjz/P0cu7dUxW41LV07Rr0SHZHgd+eUylAV77gMMdvn4V3AfoR1mDFb+0lk9DwqPu1wFhywwTAF8RmMBcVA8+ffHATn9A70wNaU+frnySfW+6UmGzdbLgRAOTLYkTTghzqxDY/y1ppY8Ny5dE6wTYNytA5QcGDOmERggn+gBnN/mvnbg0+EiykDZkE0Yi4hdlN28Z3kcLJwi7UZGpHcnmI945K7DAVQOnNFYPNGCvkbsZmbsQuNwjj/nF3ZcUPjq2yHHXG3rk5HaD6ZQi/WxSXnlX4VcDLnQhfGoFvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4SAa6LKj344+cXAZRE7DzCmDPhCttxPv/ge6vjs+IA=;
 b=JbYGUA898A5iW/0W1oKTHmUMt/AGIjgqrpmRq8eFxwsy6ET+ireiD2hUpEhYZ8us9jiIzpRNsI40V2C2fmKaW6tL6Lz5271svgDyaRWGm7O4UB0ay9hlICFuoC3nM19hSU5bviTgN2k73RWy1DfScxmrlgZk//BS+g7J4bvzIihASNzIE5LOzF9w1Zs/V/Ry1q+M1pnqFEJmBfdmOvfeFDWliJ2kN1Dn6jWQUR0MMBuDeziEsXvgyV0UX0TbNK7ZVrEROq2Ek+lga37GNFHb+7RgTeMrvjRaJQYBQ7KEDsR9khJm24O0VYfaE3r8CS7xH52gdahGxXGX5h5rBqtnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB7285.namprd11.prod.outlook.com (2603:10b6:8:13d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 12:36:06 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:36:06 +0000
Message-ID: <644b3439-8fe5-47dc-918c-f3af1da7e70b@intel.com>
Date: Mon, 13 Oct 2025 14:36:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] eal/freebsd: Avoid claiming memseg holes
To: Jake Freeland <jfree@FreeBSD.org>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20250814213246.4141803-3-jfree@FreeBSD.org>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250814213246.4141803-3-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::21) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dc5b26-c0ad-49dc-650e-08de0a551485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THFtcVUvT3UwS2hOa1pYMDdnSmxUTkFBVnVEWjNpRXlPVy93TDR2c3UwMmk3?=
 =?utf-8?B?WmhNYnNSMkNITHR2bllRZ3daQ3YxNXgyUnZDYjNETnEvai9GYkxBeUh1ZURV?=
 =?utf-8?B?Y3BoQk5HMkwyU3NRRXhCRWJydzhDaGMybHFHTnMvS09LeHRhZys1cFZ1NU9Q?=
 =?utf-8?B?Z2V3cVVVTEhpTlJCZVk5MjlzVHBVbzhDdVo3MjJxQmdMaDNJTE5oNXRyMEhh?=
 =?utf-8?B?WnBTa1ZEaEk3cU9CNDlrMUhZZ1RCdlYxYnROSEttbUFmMERKOVBXNCsxUDdZ?=
 =?utf-8?B?b0l0d0lwbmJIUnAzQlp3TXlnT3I5VURBUFJKMzM3SGxFUi9PcjB4L0E2V1hX?=
 =?utf-8?B?d0NYTFRDeEk4THZ0MUZZdzlGd3k3R0ZVeG5abVFIRG1zMVdkMG9IZWhGZkRl?=
 =?utf-8?B?Ry96bEhURzhXR2F1dHJHWDVObjQ2dmNQbEkxMkZzM3NXZWtCT1U4bC9VYnVO?=
 =?utf-8?B?d2JnSXVlU0pmdVVBb0RLQ1F5Y3ZzVzV5T1BXNnNtRVpwKzA3aEdFZ1Vzb05z?=
 =?utf-8?B?b2JoUStNQjRqckNCZUJ1Vkt4V0FHZEJ0U3o0RnRKanh4QUdjQ1ZNN2FRYi9m?=
 =?utf-8?B?VEtvcEN4N1YrclBoSnJZdEdQNjVuSWE4QjJ2U0Zxd3NKYUx5RnozOXJBQk5E?=
 =?utf-8?B?a1AwSlZYbHE5clJKOGpGWWxSK3Azczl0bHM2OWwvYnJMRkdTWWpFUVBPWVEx?=
 =?utf-8?B?T284S0d5VVFvL1NkUlEvMWhRTlhKYmdCMlU5MlpXR250cTZkQldLZmlEaGJi?=
 =?utf-8?B?bHpsdkRkK29zVWQrQ3RBZStVMDd1RzFURlpBVlV3YjU5d1p3K2VHcUxuUVA1?=
 =?utf-8?B?ZHY0VkdmVVNMTzQ3ZStPUkNFaU9Rei9zbDl5S1ducU54Vms2MStBbFJNR1Va?=
 =?utf-8?B?NmFrdWJQMU1pa1RNNzlEcDFWamxhYW96M3BTd01oWnpFUEVidXROTTJsWDFz?=
 =?utf-8?B?QmxGdXFmQUQyRkRVcmczc1RqaDN1cVdhUUs1OFBNN1lVdStKVnZNdmpoUldq?=
 =?utf-8?B?LzZSeEdvSlVUc1NHQWdzMXJIamtReGtjRXVhQ1dCK0hJZEdBczVRZWVEWHF6?=
 =?utf-8?B?dkcrZXlGVnlENzg2Z0xaNFpEU1FOWFA0RGdudlFLcUwwYmN3K1A2MklJNk1x?=
 =?utf-8?B?TWN1b0tiWlJvTWJyQWpNOUhINEQ2WWl5cWUvK1R2S1pzTTU0anlDQ2VFSU1y?=
 =?utf-8?B?OVMvVEgydkhDbUhDUDE4amIzdFIySG5kdE5acFBML2EvdkU5WHUyVytocmFn?=
 =?utf-8?B?emhlZ21sQ0JiN3FYSmU2VjFtdzlrNFBNMUc5Rm5sa25QWUVhbndxQ1p0bG9F?=
 =?utf-8?B?TmhKVDA3S3JyeWxwUmYzQUJHcElPblNxajhTVmErUUtCZXBhTTR0MVdJd0ZP?=
 =?utf-8?B?MXN6ZEYyVUtKSitwZGlLdDkrR3YvQWdMZm1xK01ZKzRwR2JyYVVzK280U1JL?=
 =?utf-8?B?dCtrRWtWOE9YVHZNN1EzWnFXVUkvV214Q3pGT1BaRUIxbCtzd3RkaWFHV1lB?=
 =?utf-8?B?OEpUejdzdWJ5SXA4RmNvMmVKdjErRlBMNXl4MnFrRmlSNXBJT0xrSkdEZTl5?=
 =?utf-8?B?RmRxZWxRWDk3alVOa3dnaVJXMXVRc1VSMXVMaWpMNlR6WVNpa3JDQzFLZnBS?=
 =?utf-8?B?SDJFZDhSZldzanVGL1cvZEVwbGdidkozVG1KSGJhZ1E2RW9iUHB2b01sTkpi?=
 =?utf-8?B?bWJxS1BYbUtVQ052Z2dabWZZTGVZMVIrRktaU1pTVUFpMElQYVQyK3FPa01D?=
 =?utf-8?B?NTE5bHdPZFN2OHJSQUxqSWNadnl5ZHMyaDhlekh6L1VCVU4vVEtoa2cvMnU0?=
 =?utf-8?B?bFEwOW5hdWtzRnNmMGV5UEFueC9LLzQyNm1BU0RDc29YdUhtUnVyWk5odit4?=
 =?utf-8?B?RWJ6TzdXUHdGaVdFUHJYQnJTRFNIY2JCM3JDaUNXTjhSek9Lb05Ka2o3ampi?=
 =?utf-8?Q?WZCQTX91CVHkm937jV4wJdg34OIKIEvj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZTMTNSckVJZEhSc3NFcDliUlpnODF0TjFTdnI0NVlkUmJaSElXelFyeEVw?=
 =?utf-8?B?NUxwN0IxeE54YUxaMmRtTzJMUU9oaGdTSjdPbGhxTXB5UUltamF0WEdKQ1p4?=
 =?utf-8?B?UWtSWEluS295azI5MDBBNFJ5TzBYbGd6MnU3U0xic2VleDNpMWp4MDUzSEhP?=
 =?utf-8?B?aDZ1R0ZkU054OFNtTWNOdmxLREFpWnZJb0UvWXROd3hsaTdnbVN1MmNZbHZO?=
 =?utf-8?B?dCt5QWNMb2JYN1dTQUpwVnpwSW9ydkM5S3gwZmR1TVN1c3RndEM2NUUzaGgx?=
 =?utf-8?B?ZzY4a3FneXVqeGM1eEorSUwrcUt6eTViZXExVExZY1VGTmNjckYxMHpQS2Zl?=
 =?utf-8?B?YkY3UHJlOTd4R0FuSWtiWTRzb08rQkNoemQzSkIwanlrY0w1TzNmZXZic3FP?=
 =?utf-8?B?a0tvWnNyNUNHd2NzQjQ2Z2NWSDZqWVJUM3l5b1YyY1d4T29uNU1pSTRXM3kz?=
 =?utf-8?B?aHFDQ0VWczkyK2lseXFRU1VtaUd1WVNUK1pHWlFHbEVsSnZBWTlKSVB3Slkw?=
 =?utf-8?B?SUkzRlVDMWtYRndzTzBQY2JvMkk5QmZSdHJDeUs2UnFMa2JCSTJHWG1JbWVx?=
 =?utf-8?B?Q3R5L1RJaVNlTlFYaWFJRjRFN2xzSDc3dGpqWFljeFg0WTZsdVZoL0J5SVV3?=
 =?utf-8?B?TXdmNUxyRzZFdUJUN2dHaHQ0YjBqN3ZUQVU2UGUrbkhBQ0JsQ3dCRUFlTWNU?=
 =?utf-8?B?QVdtcDVsNzh0a3dVdWRSQU5CeGNCTmJLUXRRNUQrRWV3N2ErUnlmb3hBQytF?=
 =?utf-8?B?bCsvekZ5SXNzTm9XcklncFZXNUZsMnorOGJvcHplTGgveldVK1BZdHMvUUFq?=
 =?utf-8?B?L3grVTJMMVRsamlNTW00cWdaajF1Zmo0MDJ5Qk1ERlNTK0Z2MVVxckhRajFr?=
 =?utf-8?B?a1ZSajJ4RVMweEprcVNpc2V4M1phSTAvZUlvNmtXYUxMWjlDMG9ZRkt2QXZL?=
 =?utf-8?B?K2hqd3R6Qnp6U21iWXNpcjhPMGpQelMzbHFqVlo3V1ZUdjJ4REdSRVFiZEg1?=
 =?utf-8?B?c0xhdTRGcmZ6aUZlVG9VZHRXVFRkSjlTWDZBUjlUYzB1c2prN2MrSXhvNDU5?=
 =?utf-8?B?TUlVMVpXK0RXUExWaXY5TWtHb2w0d1lWTExBaTQxZTdUOWlMOXRMRk9JbUpj?=
 =?utf-8?B?N1g4MFc2MnVMYTViYkp3eWFia3pacTlwNWlRZVIyZzRjU0Izd1VNa1JlOEx3?=
 =?utf-8?B?QzhFa3grYVZLTUcwVm5RbVdISkpaVlFWMFJZYi9CbjlUOHZGOVdwVFhzb0tj?=
 =?utf-8?B?ejJlcTIydmlBVTdDSmVxTjhMck4zdVdzRGh0SjNJaUlDMU9uckFPU081b3VI?=
 =?utf-8?B?N2pXN0N3empGRHVNVWZDMk0vWWgzU0xubDFtdzNCbk9kSzFVZjEzMHR6dXpy?=
 =?utf-8?B?c2ZiV2hSdmFQaFlyUTJvQXhPb1ppRjluRFhKTDBjZGFoZTI0Y0V4cEFkQm1a?=
 =?utf-8?B?NkhuY0VPdHU1NDY2YTVJRkF0dWFxZWJyazMvUmxramR6RUx3OVFlQW5zOXg3?=
 =?utf-8?B?dlhYbVRFa2ZkcVI1OGVmS0RJUWxVUkxnYjZYWEljSlVBOEJZdHpMZU4rN2pQ?=
 =?utf-8?B?azBqdHcyQmI0Rmo2clM3alIyajhnaXZ0Kyt5eTlKN0syTWZvT3VLcGNCNVJW?=
 =?utf-8?B?VS9sK1FYMU1LYXpjbDV5MEg2UGR5TWs2dEl0L0RwRTlsMHlZNzZyMVo1RnRr?=
 =?utf-8?B?Nmx4TC9yVUN4ZVgyandnTlFCS3pVbXh0dVhJVzhFUXNlQU9PWXhWQ0dwN1lQ?=
 =?utf-8?B?eVp4cWFiR0ZYQkhRdnVxSVlkUGZNRVJXVVhReHQ3cUxpRWg0N29HdTgxVEdu?=
 =?utf-8?B?NjVIR3Z2RFdHdks4NGpLRHQ5djV4TjVTM0hudVJaeGFhZ2o0dmV3YU1OZGc1?=
 =?utf-8?B?MUZMYUNxTEJWeEgvUUZyOEdXcnlqekJsaTlIVHJlVlhmZUE2Tlpwd0xuQmxQ?=
 =?utf-8?B?V0FNaTZhQXE5aE5aTWhLYTBCRENNbXNFd2pOb09hNEpoNFZSM3grZ09iQWU2?=
 =?utf-8?B?dnNvWnlGN0RjdElwTGRTN1I3Qm9ER09oVWJTSTFTZS85TUQ4QTFqdjBwQkVJ?=
 =?utf-8?B?RERJb2Q2SFRsNjlDbXo1VUJBMUUrdGM5VHN1Tmt5V3lCYjBNN3RlZnVFN1Nv?=
 =?utf-8?B?UTlhMEU3WmVkblVEWnRTUElFLzJmZis5YmttU1E5cnZXZkpHN0xYREh0ZzQ4?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dc5b26-c0ad-49dc-650e-08de0a551485
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 12:36:06.7452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70ae6qWP123pfL0wIr5lcRSXce5lPCcswzSBUMHIqStDUKEXabm5lJfan+bwB5PeyiALWB26TEj3KBlCGxj8ZkWsdlWhSezef2dm4BUXeJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7285
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

On 8/14/2025 11:32 PM, Jake Freeland wrote:
> When need_hole is false, memseg searches will only be done for a single
> element. If the search starts at beginning of the list, an element that
> was previously reserved as a hole may be wrongly claimed.
> 
> To avoid this, begin the search following the last used entry. This way,
> we ignore all pre-existing holes.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---
>   lib/eal/freebsd/eal_memory.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
> index be3bde2cb9..b159e9ef4e 100644
> --- a/lib/eal/freebsd/eal_memory.c
> +++ b/lib/eal/freebsd/eal_memory.c
> @@ -143,6 +143,7 @@ rte_eal_hugepage_init(void)
>   
>   			for (msl_idx = 0; msl_idx < RTE_MAX_MEMSEG_LISTS;
>   					msl_idx++) {
> +				int start_idx, num_elems;
>   				bool empty, need_hole;
>   				msl = &mcfg->memsegs[msl_idx];
>   				arr = &msl->memseg_arr;
> @@ -157,10 +158,24 @@ rte_eal_hugepage_init(void)
>   				 * adjacent to current one.
>   				 */
>   				need_hole = !empty && !is_adjacent;
> +				if (need_hole) {
> +					start_idx = 0;
> +					/* we need 1, plus hole */
> +					num_elems = 2;
> +				} else {
> +					/* begin our search after the last used
> +					 * element in the list, skipping over
> +					 * any previously placed holes
> +					 */
> +					start_idx = rte_fbarray_find_prev_n_used(
> +							arr, arr->len - 1, 1) + 1;
> +					if (start_idx < 0)
> +						start_idx = 0;
> +					num_elems = 1;
> +				}
>   
> -				/* we need 1, plus hole if not adjacent */
>   				ms_idx = rte_fbarray_find_next_n_free(arr,
> -						0, 1 + (need_hole ? 1 : 0));
> +						start_idx, num_elems);
>   
>   				/* memseg list is full? */
>   				if (ms_idx < 0)

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
