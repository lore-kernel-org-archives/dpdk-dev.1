Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D09C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 09:37:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF27D40B97;
	Thu, 15 May 2025 11:37:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 771F0402C2
 for <dev@dpdk.org>; Thu, 15 May 2025 11:37:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747301828; x=1778837828;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ukiIh3IzLQS2sH3EgrDpmlpIysAy3JaWxwgtWjLWOOQ=;
 b=njZqxgglFYdOV+lCBWHa1OCfX9WbQs0r/N0QZkFD2FX0QrPa0s9aQxIY
 2sJ6aOoewCKo50E8fEoafrWy/e/NmrwR6RMWHLUO7ms8HGLOKcH4+Jfq4
 l40grDTN+B5yKcOxb9p5v/9mkPJIl3d+pvaCWtSyKzpjc/C5OuoP0X3eQ
 rWT+X5P9F+H+MwVvJ94W05YX5K8M66FOZCQD+EgnCRzjvt8hG2SDb/Ar3
 rCNOZEvjNUTMLlC0ClTpC1pnaYBAr4kI/35LS4OrT7WpQiLYE7400oos1
 qrYUpbSEnUXyd137k+CMbyzC+MpnnZj5nFuMB7WdRbGR4mzwrv1F8dqbt Q==;
X-CSE-ConnectionGUID: YPL10YzIQGeGx8z/9eTteg==
X-CSE-MsgGUID: Pkmz/6lOQaq5/cbLgYganQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="51866476"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="51866476"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 02:37:03 -0700
X-CSE-ConnectionGUID: JzKXU4xST+yTDaCOO1qeoQ==
X-CSE-MsgGUID: bsnRE3ZdRF+TD5EEsc6CVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="169389368"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 02:37:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 02:37:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 02:37:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 02:37:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmb+uhh1o1JvuFjpVafxQhwfk9RC5Uq40HIIsbgdE953ndhCd3SJmGIB/etEMeS9FwjNE1Ez7FhABPLsAZyS1qJTA0Dbb8g2QX1obwFH4lfznHhKacuhVt2FUlFOJGV8REX5lCAa9UooqMDA+9FSQhi1ml4Z+598HlXGbND5Hd16YVPvz/+/pPZv21YkDEH+prmGq72UGqDC3+mpo9OkbtCXpbaXyc8t8Q66gMIesPZQ0TRS7TjUS/Y7NNg18vetW1AH7CnDwvDr4yqojm1O00owe7wbmSFAiHI9Wwd4R7fz9u2EL/zNLLX/BKryGKP/6joE08z/t3WLKBXLGqqcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ6zFRCQrUW1IXcjHwYbn1pECn+g7WMwwcQ0Vz8M+rU=;
 b=CbR7HanBfqbeN23anTkrrunxpDIgclzHLR4z/UzFRPN/A5pTvtCwly8R5GU7+Eet98Md1LMclbSWxzAAW7lqSFkU+8zzEYF4KannWUJvlhPbzzgQ6QU3MTzxzlMHynWXiv5hpT8v/RNOgjhox9LR6GMBN1IMLGB620DR09GGQ/jJnGj0ps9OLpUP/XSxO/Yj7Xw7HUpkXRdxJFxyXfDKa/Z1+nocGqncn1dROGNYfK2RzTvxYKsJeEWKcuDtchcdi9qSFmgYbpQAMFSSFVYcqv1B6zHnB+CbBMkKdhivoB9qj8KTsCd6GJHEX77LNI5t7tkF+sFlouxBHo9ca7NhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 09:36:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 09:36:46 +0000
Date: Thu, 15 May 2025 10:36:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>, "Patrick
 Robb" <probb@iol.unh.edu>
Subject: Re: [PATCH v2] build: automatically report minimum meson version
Message-ID: <aCW1qG-VVALr_o0n@bricha3-mobl1.ger.corp.intel.com>
References: <20241009152417.4028297-1-bruce.richardson@intel.com>
 <20250513085956.1670288-1-bruce.richardson@intel.com>
 <CAJFAV8xccPZAvQrFX_dqhQ49ZQUEtTO3GoDPKLZpz05pyBL1nw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xccPZAvQrFX_dqhQ49ZQUEtTO3GoDPKLZpz05pyBL1nw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0269.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV2PR11MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 26dabb2d-2a56-4a20-d5cc-08dd9394022f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkIwelFWNExUOEdLZEtFckZTWlFuWmo3bU9DSHZkVk9oTUJJL0JhNmQ5am9J?=
 =?utf-8?B?R3NrQ2l5S1pSLzJQelNIYjJFaW80dFdCamN6Tm1DSy9FNXU2c1llU1N2UVFp?=
 =?utf-8?B?K0R5UUJabVN6aDZiQ2hNeml1NTYrdFNOb1hVT3N2RS9tT2NwMjVRcCtteHA3?=
 =?utf-8?B?TlkyVGU5SUVJK2EzbHdMb0VEZkFMZmtIM3RCR3FscUV6WEszdHRNb1h1Z1Ba?=
 =?utf-8?B?MUhEa0kzNUZIdEo5Q0s3dWY5UjZwTXZRL3hKNmVXQjhrZmFnTjVuSmkwejd2?=
 =?utf-8?B?Z1lEMW1oWUxPcncxQnJOczAwMUVGcHZIa3NBWlZRY3ZYWFJaRDZ0cld2R3VO?=
 =?utf-8?B?cXh5aGFLdzRXQzBINTdXVkRVZWptZzNJMmdNNjM1eFNGZDFMR0dFUG5DR3pz?=
 =?utf-8?B?MmI5SmhUTHpUYmNua3l5NlAvT1oyczcvQ25PMERBNi9mRlBvYTlLNDl6NTJY?=
 =?utf-8?B?SDZYc1huY0hQTkFhZFdHTkF6RWdGTC9SSlZNUHJLUG5MdGxaSlR5ditoNG15?=
 =?utf-8?B?RFVwcWJhdnBUeUt5bGhtdW1XN2lmSVNzWEorV1R6YWVUSjhvRXo1N2ZUZmw4?=
 =?utf-8?B?eUwya2JQUnNVMC8rWlhqNHJOSmdWOGgvS0VhSlJpK2twcUVuVWIyL2l2SGln?=
 =?utf-8?B?MnJmU0hsOE5qVEVBVkxtWmltdGVjTVI5ZXduaDYxS25DTGRYVHRSRldRT0V4?=
 =?utf-8?B?RUJGa3pQbnNBTVBGdWRRTE9pKy8xcEVuM211dnFHMFlzaHpEbW8yOVNqdGhM?=
 =?utf-8?B?YTltN0ZlWkljQnlrbHJPODBqbE92N25UT3U3cGZQemQwQUI0MEo5SzRZOEg0?=
 =?utf-8?B?N1ZPT3JzcnlnekJHUm52YU10RmMvQy8vV0NBNTIycmNVZ2FlL3lUbFB1UXFS?=
 =?utf-8?B?QkJSNGxmQk1TQW1RcnNiVDcrTWdFTjZNM3hWOUd5d2hHZmM0Zk1nWWFGY3V6?=
 =?utf-8?B?L0ZEMkRFK1dZOWU0RlRydUxxWjFqR1JpUGZFL1dMcUY0MkFpaFo3bnB0dll6?=
 =?utf-8?B?ZzgvYnBJOHlEVDBuK25aTXZhNCsxYVJ1aDdadWZqbXRBaVFaOGlVaDBPS09F?=
 =?utf-8?B?amZhM1BVT2lEcHQ4WXZtMHJEaG5Vak1jK0lKdlBvUkc3aUlCVEZCdjUzeXY2?=
 =?utf-8?B?akN6RXhtTmcyb25oS3FkYUFZZjRhMVhralk1NmxMNmRjNGFRamdSdm1HbUho?=
 =?utf-8?B?anV0SlJLcVhKRUJob3ZCdTk1UlorOGc3T24xMncrRkRWNUtLZ2FIYjFrRU93?=
 =?utf-8?B?VTFnVjJIV0t0ZXZWdE1LeUxuYlE1SDA1c2s3SzBnemhyckFwQUJoMDdja2hw?=
 =?utf-8?B?RG1RcUlyZGVXT2hmVlJscFVWVXVmNytYUnVsQWd1Mmh3MXZEbC8vWHo5dE1v?=
 =?utf-8?B?Z2JmMUVYM3M0Tmx1dTFlNjVZamVuZit2QTNTc09RT0FtU2U1VzRxWTE4YjVZ?=
 =?utf-8?B?Z1pSNDRRd3ZMTUQxTDdUdXRXdXpsMFRNd3hVVkRoWE5oL1dSTkc0emZBekxm?=
 =?utf-8?B?UGhQbTlhZVhCeERIWnZ5QTBGNHBGOGNxOHhzQkkweVZNY2JhbTBNT1NYVXhW?=
 =?utf-8?B?UXRFMExIOUFPLzNlUjl2SmdSSFVuMjlvOFBIM3R3ak9CYm9IbkFiU2g5emRx?=
 =?utf-8?B?K3VVL3lrWmhhVEdSdE5CMS9MZklqVW5CVnRMYnpTMXJ3QmhHcUVHWmZKZGNO?=
 =?utf-8?B?YTJoSVlVRE93WWY1KzVNQkdWa3NXS1JtREZuazliOXQ1bWhEL1dSTWI1WW5Q?=
 =?utf-8?B?TU1JWW1NWUU5WEdtbDZKS0JoU2JQL21TYmtjeEI0T3ZUSWpXQ2NRMVJQemV1?=
 =?utf-8?B?WUN6aXN4Q29LYlhnUVl4ZDFGTEZJVDhDdTJrblNnS1VOUjVKSm5vMzhud2ky?=
 =?utf-8?B?R1hucFRsT1piRnF4RDA0TTZnN3dTdzdHRmZkdFNFTmZVK2tGRm9uZEpra1k5?=
 =?utf-8?Q?uxRy+PP1iNQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ZPbFpQMERCd2xxaityRGIvL2VoY2FDamp1RXV1NnFndkx4RkFTYzlqZ0Fz?=
 =?utf-8?B?VGYvajdGdFE5T29aMnlndE41TjFBN1lzQmdmaTB3WCtlTkEwTndsclFtSXdH?=
 =?utf-8?B?bTk0K24reWg0L0dDRXdwRlhmdEhNQmM4YWdDSFVIU0hldjBNZEs4cWcxTVUx?=
 =?utf-8?B?NWY3VmRWcVJvR1Qwb25HR3dlcDNFMHNLNDJlZ1ptTE1XRlpGcW5BWHI2amtP?=
 =?utf-8?B?N2RacXc2ZEZEWGpKZnh5ZmZ1SEhRSDIzSmxNOEsrNzlna1orTWFuMForTCtO?=
 =?utf-8?B?M0drVG1EY3UvazFBemJHN0RhdHBuQnVWZ2ZLUGRKWXpGdjFZVlBzQ2plelJz?=
 =?utf-8?B?SDk2NFk4TTlVNlZqbkVkS25COVFzN3VvOFREeXk0UDkzNksxUGhVMWhTbWxI?=
 =?utf-8?B?bEw5NzZCb0Y4ZENFVW5ETm5oQk5Td1hxN1RYZ0NKUnp4bEFab3k2WEZXR3NU?=
 =?utf-8?B?a2lVKzNKZGhlbmtvL01oOWg2ajlXSng0RWsyVFEzTGdnV2RCTHFOYTEyYzZq?=
 =?utf-8?B?dURXZUxtTld1S2NVNWpYdG83NWNKMmlsdFY1STNwa3U3TkZBLy9WTFpOd3hY?=
 =?utf-8?B?OVEvejB3bjhubUVhZXVFVFVGaXVkMGlxc1RVMDFDS29jSmQ1T2xQVm5UZFVN?=
 =?utf-8?B?d0NmMVFFNDlhS2VUVSsrT0VXSFFRM0NUVVBzSFgwVkFZS244RWZrbk5FODA5?=
 =?utf-8?B?elh0WUNJRUdpOXFVaWh5NGpRdUxncU1rVFl3bWRRMk90THNyQkNZR0tDMHFm?=
 =?utf-8?B?b3I1T1U3MHJBS2NieWowRW1lM0NMUEh2eTlDdEtYMDlzM1Rqb0dkT0Z5cjlG?=
 =?utf-8?B?SUNSczBEOFpXcHZPdU9JWUdaNHdsUHZRb0FDbnBMSFhDOTZKcnFXZmRYWVdK?=
 =?utf-8?B?cmZsWXBrL1FrcFpHdkt3cW83RVhXLzJwMWhJRlFCbHNmQ3EvVnRENjhOTnc4?=
 =?utf-8?B?bXIvWW9HVU5rMHJpdXR0NGxCdEwvc240TENjQ2FKOG1zOTg5bUdERmNRZEdr?=
 =?utf-8?B?ZGtkcjYxc2Q0ZFFhT2U5S0FMOUcxbTZEUjlFT0hHaDRlZ0pESk5NLzJMOWlQ?=
 =?utf-8?B?WlNCdjI0Lzh3eGk1YmloYmZrcG1rVzdibWkwcCtzc2Q1eldjdGhVZlEyeHIr?=
 =?utf-8?B?bG54bVAwRDcrR0Qyc01RLzJwaTFLOFRYcVhWMXFIVlAvcmtHN0tEZTNSM3JV?=
 =?utf-8?B?dklabGRCdDVCT1ozc3J4YytVNkI5L1dCN1A0aUpvcGRUL2lWTklROHZVdUxv?=
 =?utf-8?B?UUFPNlFsRnFtTDZYdFhjRzUxOUdiRm0xR1VVNnpyd2I0QVJHUkJiaXM0OERh?=
 =?utf-8?B?YUxBTFgrb0grY0wyVFRWa2VUbGNPV0UwMEVKb1hMdVpXYzNYanFXWnAwcXFM?=
 =?utf-8?B?RkpsNyt1ajQyczVGUUVQNUdJTU1sWEx3akR1M0taYVVyWXRaZy90UXk0SzVI?=
 =?utf-8?B?dm1kWlNMZUx4d3UzNGkrL3F3WFF3T3hKNHNldzMwUGtFR1craE1xR1hGdUxI?=
 =?utf-8?B?VHZkdm5HNUliT1prVEtOOXNtVm1GckpVQWs4UFJLekl1bmRIMU51c1c3ejds?=
 =?utf-8?B?OUZIZDFrUXFhaGU0a3p4dUFDaGdyZVlKS0JpQVp5QUU2ZlkrdE9mN1NaWWhY?=
 =?utf-8?B?L3EyWDFYenNaeGF2WldzNDd5N0xrNHlIWjI2RmUyYzNQNWZ1NEFKWUxnaWZa?=
 =?utf-8?B?ME93ZVV4K0NOK2FQdmRMRHg4WTVkbm1nOUlPYUZFQTF3NTlhR0F5WExUVVdC?=
 =?utf-8?B?Z0ZobDNNYi9VQ3BzbzVVVmNpcm42blhHYlBCd0pFbW54cVhGR05yZjNwREVP?=
 =?utf-8?B?YkxaYWc4bTkvRXRoYWl0NW5FdzB3OXgyS0VLSU11cXlzZGRiSDRSZFdKTFY4?=
 =?utf-8?B?VFFaelIyZXRFdkN5eVJZOTZkbkdXTXdUY1lqT1k3d3hra0NWQ2NYUG9DRnBI?=
 =?utf-8?B?bjFwZjVYc2tyYSttVlEvQzVyNEdlNGFXYzVWZFpxVldDcEk5aWtmeFNXL1l4?=
 =?utf-8?B?Z1c0ZEhlcEowbkY5S0krNGhxWUxBTCtaSTd4R0VaM0N6c3NGWlhUR1dwYy9H?=
 =?utf-8?B?ZGlWbmJvdXRQbERGdzNldjg2eEttU3Q3TXUrUVNkbmRoZDhDc3poRFhVOGx6?=
 =?utf-8?B?OEJpSWk0RU5haWxPNktnNVZQSHFYZlRBV2NSQkU5ZEkrL2N4REhlMXJrY1lz?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dabb2d-2a56-4a20-d5cc-08dd9394022f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 09:36:45.9942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsRqhYmNVlS1Q/j+2WwIH022N3M/fVYmfd1l9aTWjLrsq54bjvyEXm9S6TLCxJPs8pNiEfllsKXTharOj3bliuMMmS1xWktQwjkkOS5eTnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
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

On Thu, May 15, 2025 at 09:09:22AM +0200, David Marchand wrote:
> On Tue, May 13, 2025 at 11:00 AM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Add a script to buildtools to report the minimum meson version given in
> > our meson.build file. Then use this script in two ways:
> >
> > 1. in the .ci/linux-setup.sh script, use the auto-determined minimum
> >    version to set up the CI, rather than hard-coding it.
> > 2. in meson.build call the script to report the version. This serves as
> >    a sanity check to ensure that any changes to meson.build file do not
> >    break the script.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> > Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> > ---
> > v2: rebased to latest main
> 
> This patch is reverting dbcd72f3fba0 ("ci: fix unit tests with Fedora 37").
> 
> There were some strange errors raised by UNH, though I don't see the
> same python backtrace.
> Let's try again:
> Recheck-request: iol-unit-arm64-testing, iol-unit-amd64-testing
> 
If we have issues using 0.57, I don't see there being issues with us
marking the min meson version to 0.57.2 rather than 0.57 alone. I can do
that in a v3, or else we can abandon this patch, if you prefer.

/Bruce
