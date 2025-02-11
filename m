Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1B7C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 11:57:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A482C40156;
	Tue, 11 Feb 2025 12:57:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 32CD840150;
 Tue, 11 Feb 2025 12:57:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739275073; x=1770811073;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=vgSepD4FUW9jBdaJgSGSbVmWnaSIF+Uo4a7uTt0qcCY=;
 b=XTrVAdB8BV5BoA9zF7JWFVUMpYuS911PzwtJFLEne9LmyM0l0Mnr8mZW
 au0zBXt704VOGLZ+enNYlh6ovqmkC9bSO5Aal8bxKWFHf2I+ZrDOw5GXw
 hZ0uDaeBmfPrA94cDWKJsXgo11P3kAA4lbdRVMsm8l2XtOCRTQBYXrS/q
 TYHfJHyCEWoNV5SzekDG/EYn+vYw+p7O+1BF+B3vyhnmIXk7QVaSqKzW2
 u3FTTRs9Fz6Yjo+laDnisdT+L+2eESImpCOMZpbEt2G2siElfAlp+OqZJ
 kd69g92Y7UPUruWwRjhfbvDgE992Z8VGptxCp4yYqg94GpL40RB/X5ext w==;
X-CSE-ConnectionGUID: r4Nf5Mn+QAGY0wG0M/OgYQ==
X-CSE-MsgGUID: BenVLFBtTSKjmKckZMgA6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40007671"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208,217";a="40007671"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 03:57:49 -0800
X-CSE-ConnectionGUID: uYnX0AzjRTGQ36r3SkIKLg==
X-CSE-MsgGUID: FhgFosTUQ86DdPDGMZwEPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
 d="scan'208,217";a="112346018"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 03:57:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 03:57:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 03:57:47 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 03:57:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N19LZVxJFnYoTSQB3bDX48V2Q7agH4GEQ20bg9rFsFWiq0/0cCwLRmepoAag7FLmoeUQCXOfmGsujcQJcKYwnSxeuw3bHGasWLevPrT1zlc2hT8ohcONeh+WMV87HYPWxVpkGMnqtcwy3aUQ3jXB5+abe0+ss9HGA9shljt8+uaz3PC5ZPcBCstg5Y9L6MS0cOUPMjAO+/Mi/cx+nKvdlZ7UsY/UNWVM+K06rg7mE5B131HihZ9QndgacuGGWPTisSCRSyCm2/gPBJCCz+jXiiFM7BH+jfoH80fIICyW0u9sp6xP+cW+e+1wZziXHdmO7EPr/7Q+34eXbixM51lDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lORxf7XhHlGqky4TA3AxK0tNPTAcYJ0Hq7q52/BPfJo=;
 b=WbgoIAIaki/MZXz45e4gxnkJxoDCpsnVXbKUnX7KFd32yFe5h2FRm1Kt3l2JiPNMX2XLeYmZCOdE6zyPpdZns0GMZHJx5ChBFonC7TFKUM7QfL6NSnbPGWzqmp3iLyHwFDgZ16v0shGRZMuRSf8HeavskeVfQT81r6CpdSGCHL+IfoQrif/vP3w2WTFKGs0x+WQf1rAOQ+RIypVX6kS32Au+Vo1Pg07jyKM/u0/c52YARtRWQo4T2EKNsndbT2NnN8YFUt2gzgpYz/AP7mjEd2WW7SfuS0xc5aHEOKbdNhgkhigiE6fVeDlxZH/fdvfeCzTD36+EVa4IPcbJh/kmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by CY5PR11MB6236.namprd11.prod.outlook.com (2603:10b6:930:23::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 11:57:45 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 11:57:45 +0000
Content-Type: multipart/alternative;
 boundary="------------u0SuIfglrXC1ZbASrL3pYzV5"
Message-ID: <732623c7-829b-406e-9653-7511f33003af@intel.com>
Date: Tue, 11 Feb 2025 11:57:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma/idxd: add device ids for new HW versions
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Robin Jarry <rjarry@redhat.com>
References: <20250130172624.1450975-2-bruce.richardson@intel.com>
Content-Language: en-US
From: Kevin Laatz <kevin.laatz@intel.com>
In-Reply-To: <20250130172624.1450975-2-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0337.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::10) To MW4PR11MB5872.namprd11.prod.outlook.com
 (2603:10b6:303:169::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5872:EE_|CY5PR11MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2bf7ca-307d-4a00-f9c6-08dd4a934c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZysrK0kwcFU1dlJhb216VzVSbHhwc0hGUWZ3d1NjMW5ORUNuQ2NiTmFwU210?=
 =?utf-8?B?ZlRSZUtKVzdHcEJrTW1DbVltRlZ0dHlwb2p4TGdYN2s4SC9kTkRpMjAzMllz?=
 =?utf-8?B?WWtSTUhNdURVU1RhSUJWMGdnNk05QldPWGZjS1ordjMrUEZzVkJWeVJLYitX?=
 =?utf-8?B?emx0YmdQdEpXVzlYSjFLNnhTb2d6WFA3NTJ5MjFZN0lscFMrN3k0RnRqYVBl?=
 =?utf-8?B?TjRBeVdsOTRWay9jNXpFRDNOcjl5c2hSaVd5NWowZktGMW5BQ2ROM09sakNW?=
 =?utf-8?B?ZEQ3WG8wNFYrWmc2dzFDSkZTN2prQllIWVhIS0JOempnRlNMQnVSaDZmVkFB?=
 =?utf-8?B?ajZtNG04cFA1RjVxNWVwdW8ya3RJbEtKbE1MSmtDYWVRT0VyY2J4ek1ZaHNE?=
 =?utf-8?B?ZlQ2VlhlZk1UaCtIZDBXRW1mcGxOdXNERWFSNTFxRmsvVzVxWnVKYXBYY1hR?=
 =?utf-8?B?R1ZhYVdZZTIxeWVUZDdxVTByNUNTSkpveFlOZHRWK0NKYlNZcENGQXo4dzBE?=
 =?utf-8?B?YkE3THp3NmVXdWxoZjJIUHphMkM1ekFucVJJL1JjR2ZlTnBBbmsxTTJDV0tm?=
 =?utf-8?B?VTZEVVp5b1FkY3h6NGhkeStiTmI5WThLTGF0cWJlZFJqeHhXMUJkeDNXMWhh?=
 =?utf-8?B?eDRaN1hCb2FsSUZnK0ZaVllsZVE0UCsyRkgvTEw3am81b2hjdlN4M0xRVEI2?=
 =?utf-8?B?ZzBjQ1NPU2pBV1NVWlB0cnV4R2ZXdUw2Y3JXSDVsYm5WYmZmRGxlYlVZTEYy?=
 =?utf-8?B?Sk1ZaVVtSit5QjRoVU4vWUMwSDlrRWg0elFXbHVBZlFGSVp3MHVMWklwV0Zm?=
 =?utf-8?B?RlMwVDh1aVFrNW5Jeno4bWtIRGtkcCtGNGEzUGNoVFIyWlRuNUtFTlZ3Y2VK?=
 =?utf-8?B?VzU4Z0tTYXlBVkVYS3BrVGZUNHJ2Nm95dEtCKzU2S2VLbXN6OVJpcmxlRWdE?=
 =?utf-8?B?b1FHWHRkOEFDR1c0V1NFaFNGMjF4c1RYM1ZHUVhNL01Kb21BMWg4eE1Oa1gx?=
 =?utf-8?B?a3dsbnVtZEtUcG11a2N0TS8xYVZqa0hrQWpINEFKd1J3MzMzVlBjMWh1N3Bn?=
 =?utf-8?B?M1NJWHRNZnp4Y3JjU0xnVTQ3ZGRPM2U1MWJuWUFwQnFvNVVCYXdDQkxadUZQ?=
 =?utf-8?B?eXdTczlycVM4SmdRWTgyZndaUENmRS9UYTQ5VUo3UzdWY2ZTajhvTkJqM2xp?=
 =?utf-8?B?em91b0FVb1JlcTFvK2lSRXljb0UrZ1RVcVl6WDg2TVJyU1ExdG9VaUsybE1i?=
 =?utf-8?B?V2pxcnhnMVVtcS95b0VLNkxiclJiRi9IbERuOHh6aTU5NUtlVHdVU0s1c3V3?=
 =?utf-8?B?U1VkbUg2LzRCQUlzZEMyc3NNYSs0TlMxRStpY3VPa29CcEFOWHQ4eG5LamJm?=
 =?utf-8?B?Yk43cVhYaUtGYWtGT0dkeThRS1k0cnFNdkFneWUvR3pMYUxrYnhpUHF4c1Ja?=
 =?utf-8?B?QnEzLzlwRHA2Z1Y3UkhTMVYyc0ZyS21pajVIQ2NrMFMwQXJOVFA2NklOY0dQ?=
 =?utf-8?B?emwyMy9vcDdJcDB3cng4MVdBaHltam5UMTUrVkxCZithNjh3ejFEZWRjY1I0?=
 =?utf-8?B?TFFDb2RmQVRkOXF4TEhwR0F3WU9IazAzQ29JMU9CVk1aQjBaZ3M5Y0pBanFS?=
 =?utf-8?B?T1IwTlEyM1J6bUpzOWpNa2hlNG5aVGJ3WGJ6eWFJZi8zeVdYdTVtY1NkSjZv?=
 =?utf-8?B?UTlUNHRHYlhWQXdVZzRYQ0FkcTEyQm5SWlVkbmVkNmRZNXZsNjhXRlJqRlAx?=
 =?utf-8?Q?PddCIyPJY2MxdQTKDJ2quXma3vvZT9eGHpFgZpf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5872.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNFQ3p6dDRvZmNHQlVXVWtSSk1FNHk1eHZFU3hTLzd5Uk92OFJ5TWptWEFn?=
 =?utf-8?B?TXFsVTJ5eGZVS2FXOWcyVTZ0dTZGRkxDZ2lXMHVxRTF4ODk4cWdGcnV1OU54?=
 =?utf-8?B?OVUrTUd3S2VKYmp5L3FSTk1FYXRHR04rczA3SWRUQ1VmSkhZS20wMy9wSVY1?=
 =?utf-8?B?SndoWUR0ZEtsU21tQU1ManRoNjJHUEVKRUtVOVpnWkFnSTlBN1VLQWkyVWJl?=
 =?utf-8?B?cktITFdjUko3SGdxSG9GM202UUxpZG1WNW90ZnZVR3JVQVpPOW5EL3pIeklx?=
 =?utf-8?B?UU40aGk1WlMwSjFsT0I1NW9IU2VjREwzdWFldCsybFQxRFZlMDJGeG40bXUv?=
 =?utf-8?B?ckdOMHlZRlZoeVE1M0JLL1VObzJFZjFIamsxMjBZMTFFSTlDUkFxNlpXUDUz?=
 =?utf-8?B?aXJ1U3FJWXpvQUdySlJmb1NTdXVCYjNYQ1NxZWk0Nk15eHNvZFBTQU53dGky?=
 =?utf-8?B?THJCejZtSlAyREdKenMvYzNNUTJGMy9ESEdQL0lLWW9kRDRzOGsxNVk3TjRB?=
 =?utf-8?B?b29BQUFSbm1CbHRPcHZwcUd6dkhMQXBQUmNtVTJoNVJCUkloa05RWXdUWGRl?=
 =?utf-8?B?TVQvbENzYjMvL1lSbHFOQ1N3anZJQndWdkNWTnRVVWJ5V2lpS3Z6TVMwRThQ?=
 =?utf-8?B?V2lBNSsva3lyai9DbmE5SVlyd2NXeTAyS2U4WkNKVzdTdnVaelVETkFtR2Zj?=
 =?utf-8?B?Ti9BUmVOKzNyOU5panJoMDhQd2YrbUpOaXVvZVJ1cFQxWUFmcDRYcHF2amtp?=
 =?utf-8?B?MGQ2VmRETXMyemxEcjBpUXFjbm1GSkZ0WFl5WDh0YnVJTmFTY1ZsaVBtZWJ1?=
 =?utf-8?B?R1VqKzlkU3NNR3RmVW9qN2Q2ZjQ3bGx4dDVKSzc3bFNZYlhxR2pNc2xnLytp?=
 =?utf-8?B?OERSQnpGWHgyMDh5bVlmZTBJbDdhTEIxNVZpbncvWXNxWHlLME9QbnVxdjV4?=
 =?utf-8?B?aDFTY29ra1pDRHRmS1lrTU9rRk5ZQ0N4L2pBeGNsWHZlQko5bzVZNlZ1K1Zp?=
 =?utf-8?B?MlBvc2oxVkUzZjRiTDFkcmFoZE84WW5QSmdiTjVZOEYwbG52MlBLM0VkVUJS?=
 =?utf-8?B?RWlocUg1V3lRNFo1eDlsVVBxOFVJaTFOdWlQWVBWQnhOd1l5b0swdFl6R2Jm?=
 =?utf-8?B?U2FtYjBibFdQUVEzR3BSMFJMR0dwdlBUZDQ1ejFsR2JPZTZXcGVLbExvK3RX?=
 =?utf-8?B?aDFTSDBWaGszSEM4aUx5OVd1TGsxbXZFc2g3ekl0T0JJdFpmelI3U1VVN2pT?=
 =?utf-8?B?TEt3VmxHb2JycENSL3EzaXpGWHd4RWNNR2hjZER1ekYyTmk3Z1NKQlBZSk5K?=
 =?utf-8?B?c3JOc1JmMmxUckJEK3Y1NlZ1TGR1R2cwY0wyZEpoMlArc0RpQ1hVYWlNUk5H?=
 =?utf-8?B?eGRGaTdvUTQzckpBZHFwazdndnpIb2RnaS9VcXh0ekMvVmpLTVVZSG5xbUQz?=
 =?utf-8?B?dmFkc2VIVSs5MEdQMWovY3BxUkJLbXZTK05LMnFaNnUyaFFLK3hqQXN3RGRJ?=
 =?utf-8?B?MnQvbEJkRFJoYmtoRERLQmx3WEFsY1dqR1RtdXZXL3JNek1pTmpaQUhGSmVP?=
 =?utf-8?B?VEpVQlQ3Mm1YK0Y3aGlLTCsrZnJ6d3Z1QWVpOWM1cklkWWU1akR6WXI4clRx?=
 =?utf-8?B?TVRNcGU4Rkxub3BUSlAvMDFLZGVzZEsrMHZlTC83bFlibmtXN2RHaDJ0TlpR?=
 =?utf-8?B?aHNuMVFLTE9rWXA1ekFDY2tpM0pGK2VNZytza1VZR2hYU00zR3QrZVVxU2FD?=
 =?utf-8?B?OENWdzYwNjArTnhWZDJjUHJ5UWdWVzlSMHlNTnJ0VE0yUDh5anNSV0hRQ003?=
 =?utf-8?B?NkxQTDNJZmE2RStmMkpPN1BwVWpxenUyRUgyMHMwdVZhTFBoOXN4LzdibnBy?=
 =?utf-8?B?SWk5MUhiaTJRcHFFakt5MnlMVDZzY2lkNjZNd0VlWUR5TnN5SUFUSkZZVTgz?=
 =?utf-8?B?RGZYcmNGY3lOeXU3aUVxSDF6QUU4ZW5mVlQyb2p0eXVDTzJSVU9wbHNlOVcw?=
 =?utf-8?B?V1pyYytpeW5oN0wwRE12ekN2TmV0M1NjZVZ2K3RGYTJHdWd1N25YLzJHS1E4?=
 =?utf-8?B?TDJVYXhUSTU2Y0FmajRjZTBzV24yaGdhK3NYSFdhK3RJZ2lIRTJUakgyMkxL?=
 =?utf-8?Q?SjcjO06fsV9a/f9VEZ2sjgFui?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2bf7ca-307d-4a00-f9c6-08dd4a934c33
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 11:57:45.8123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaOI0vzdkouATklpxSEORgpmTi6lJcehT2WwCgxNhAcJQmfbSrkGnaZMpb6GSTSgM/zneA2I1oxPDEcB6NAWHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6236
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

--------------u0SuIfglrXC1ZbASrL3pYzV5
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 30/01/2025 17:26, Bruce Richardson wrote:
> Add in two extra PCI device id's for future HW versions to be
> supported by idxd driver. This aligns with the definitions present
> in kernel idxd driver [1].
>
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/idxd/registers.h#n9
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
> ---
> Cc:stable@dpdk.org
>
> Since this only adds a couple of device IDs, and there are no other
> changes to the dma/idxd driver in 25.03, perhaps this could be
> considered for backport for 24.11?
> ---
>   drivers/dma/idxd/idxd_pci.c | 4 ++++
>   usertools/dpdk-devbind.py   | 7 ++++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
>
Acked-by: Kevin Laatz <kevin.laatz@intel.com>

--------------u0SuIfglrXC1ZbASrL3pYzV5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 30/01/2025 17:26, Bruce Richardson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250130172624.1450975-2-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">Add in two extra PCI device id's for future HW versions to be
supported by idxd driver. This aligns with the definitions present
in kernel idxd driver [1].

[1] <a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/idxd/registers.h#n9">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/idxd/registers.h#n9</a>

Signed-off-by: Bruce Richardson <a class="moz-txt-link-rfc2396E" href="mailto:bruce.richardson@intel.com">&lt;bruce.richardson@intel.com&gt;</a>
---
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@dpdk.org">stable@dpdk.org</a>

Since this only adds a couple of device IDs, and there are no other
changes to the dma/idxd driver in 25.03, perhaps this could be
considered for backport for 24.11?
---
 drivers/dma/idxd/idxd_pci.c | 4 ++++
 usertools/dpdk-devbind.py   | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

</pre>
    </blockquote>
    <p>Acked-by: Kevin Laatz <a class="moz-txt-link-rfc2396E" href="mailto:kevin.laatz@intel.com">&lt;kevin.laatz@intel.com&gt;</a><br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------u0SuIfglrXC1ZbASrL3pYzV5--
