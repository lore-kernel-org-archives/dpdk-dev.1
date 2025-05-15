Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A657C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 12:54:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46DA340E3E;
	Thu, 15 May 2025 14:54:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 79CBE402DC
 for <dev@dpdk.org>; Thu, 15 May 2025 14:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747313694; x=1778849694;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+Q6y/Cy5oR3lDHeY5I5/EF+T+Bo348H98JNPYontvAo=;
 b=TJQ2iD7DpjXXoUFPb3si2XcWZNrBCF0FZR9oUthnaQslxedGcdAtOl4+
 WSilxD/IlqchDRpqWic2kG04c4gcPmRPvJIeK1q3mppVPmcpsle8AyY3Y
 xj5oAlJY3WJd5JkBtyGVFN/+SE8S4G+JBHIo1bmfF4eU+8AHElUdyk7sS
 VplqUfBp0Q2PAoQbmn2EKTAgArp883ykM/p/aNBriZiaAeig6pdpJhMnt
 i/ix0kodRf/8YXQn2IxdOuO7JLmnAQVuf5GPNgXKaOmhzVGkZZZn7RAWw
 WND6lG0Qs+BHRuZS8oXXjyHfeCB8otyjUMqJrsHguBQeoKsI+H/1WBoVp g==;
X-CSE-ConnectionGUID: HaFzeTzjT4uVT1ZOLmTYZw==
X-CSE-MsgGUID: z5/8+BhGSAqRVdMOUHMPNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36863810"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="36863810"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 05:54:52 -0700
X-CSE-ConnectionGUID: qjKbgJu3TUKfdlVAK+siqw==
X-CSE-MsgGUID: sCdf3osWRvqPPBdVodiI/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="139354240"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 05:54:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 05:54:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 05:54:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 05:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT6CgiTiwzQgcU1bX8o/aQ79ymyepqIO0eRTz6Fix29a+0TKJ/XuJkownqwjvgH0K9S5L+f/A9BZhkiA5vAhuuNh6uSsQ+kLh+B6defJCv7XSOtOlvzxjIdA/VFm6CuuUbM9uR3vKs0IJq1eziYR0Pa0CddGZBGB32QbyrXRU2k5ptUgSlznK8drfGghduFm5XOakgz5gRURUL5EiY6i0zwpd8Th9Sa6gJZoOURp6OexFWP4Tu0Sl5eDACIcPTbx60QPY8nWOznR6pYxS3gpeZOBghrhlLVDxWVQWJPEx20QmM+BbebIhn9ZRnK/1ExK+Xr4/faTwbBDShyp649fpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+hJNH6/6t8evWLgUY5vWMTS/BczurdC1pW13ge856M=;
 b=LDzfAdileLSi1Clm+wtW2fD1kMbQVfeWcvJqAvzlXLoxupF2VVhGMi6wTx49vOz2CBlJNZCJN7NUkc5mgZ3dvWEkr9asgcQqlqvGReoji/WcUyN0f0YLoDRMwGKbyeqSZkYFFb1LRb5sfDCyZ6dmSO5puNyi5UQJ0Ee0rh0vpzW9UBbpwrKUQOHWEhR4jHEp9s4fl2QlYHhwFv9IUgPIII0+NFM+YybYBGAzmIzro2QCaUoNbHrZ5ISZypPOGmSRXUZ0SodvcELJZ6WlL1D1bRMF1yPuRMpg0ZJzMDC9a9V18SJP/LlzyhJaYW6Ddlh5x8ViXLeSL8nSmzyopco5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 12:54:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 12:54:33 +0000
Date: Thu, 15 May 2025 13:54:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>, "Patrick
 Robb" <probb@iol.unh.edu>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v2] build: automatically report minimum meson version
Message-ID: <aCXkBNE30KbzhMYc@bricha3-mobl1.ger.corp.intel.com>
References: <20241009152417.4028297-1-bruce.richardson@intel.com>
 <20250513085956.1670288-1-bruce.richardson@intel.com>
 <CAJFAV8xccPZAvQrFX_dqhQ49ZQUEtTO3GoDPKLZpz05pyBL1nw@mail.gmail.com>
 <aCW1qG-VVALr_o0n@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8z842+xoRs2P8YCrG9EvFD_S-aC-0oaiV_7Dz41qiVZnQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8z842+xoRs2P8YCrG9EvFD_S-aC-0oaiV_7Dz41qiVZnQ@mail.gmail.com>
X-ClientProxiedBy: DU7PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b125ba-60c4-4aab-ef3f-08dd93afa395
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zy9BNlRBSFFTMjU4MVhESitxMEthbXlxS3l1V1RHSitoaFk1VWxwU1dEOVd4?=
 =?utf-8?B?T0UxV05xWlk4dWp3K2U3ditXT2J6d3hlemNqY0hVNGpHZUJuM2plM3dZRHJj?=
 =?utf-8?B?SnNVTE9jWUI3cXdza2F1YURaYXAyTW9ZSUFuaWE3ckhlcTF4SDVGRE9RUytS?=
 =?utf-8?B?dGdmb0c3Q1JhQWc1ei82WlZhR3BFKzA3SDJNNkc3N0RtZVZqTkZHTnk0SFY0?=
 =?utf-8?B?bGtaNXBnMzg5RHk5OHptTk5NN2czSUZuR1hLTzdDamE4aDZwYzhlRjFGNzBJ?=
 =?utf-8?B?bG1DNThjbDQ4WlZraGhEUW9RRHpmNU9NWmZLT0RQblZIRUNlT0NXckoycjdp?=
 =?utf-8?B?WVczdm0vN2hLVTNyd1VKYUNPbW9XWkNZK3h3cFErRG9ON1lqTmtzaDlNNFdL?=
 =?utf-8?B?U29ZSlFnNnJFQ05KaUV4ZjhqMytrdTlJblNyTTFQTEdNekt4eTh5anZMOHpi?=
 =?utf-8?B?NGE2L1M4d21DMFJoZkpEajRkQUVmbHFjUnpBSW9LcXVkWXY4SVNsZ2VsWlFX?=
 =?utf-8?B?cDBER0lmdC9ZdklhdXRPOWdBWU1FZFFVaFl6VEhnQitKR0Q0bC9qeXhiaUVp?=
 =?utf-8?B?M2NuYmVJaXJtU0p1VUlnSkxPL0l4S3VSZlViQzM0TUtybitUN0tvVC9CTm5a?=
 =?utf-8?B?dFliZDJTMDMrN002VDIwTGhZNXNWMHpoU3pEcTdmTlkvWFF5R3N5TDBvNjhU?=
 =?utf-8?B?V1JzOEdQWmVtY3ZKRlVCeXJSa1d0anhVY2dRZHV1TllRSU9tMTBNbkNPTWtv?=
 =?utf-8?B?QzliK1gyOHhUTHdpZ2dwK09YeTY2SUNPVk5Ja0tOWXhiUUhNNW52OGx6V25n?=
 =?utf-8?B?NHQraURSaW0vUE4yb3M3UUpjdHoxVVI1WlBWYkNGWFJMTDlKMUVyOUpzY29x?=
 =?utf-8?B?M3R6a3hYU2RBd1crNFdvSEpsQ29VNVBQWkRTQTB6TXpxNWswY0M2Qis3Q2dD?=
 =?utf-8?B?dzhHang1Z1FDaUl5K0NPdFF1ZTRsNnNUZzlIcERZVmxIMEI2UEUvWjk2RjE1?=
 =?utf-8?B?SnhJY0JTc25PNjBNOEdDZ2UrWHB1ZUd2OEhKVUc3MGdQbXQybUhCNGR5VFpS?=
 =?utf-8?B?VjVtck1lYWxBeXhEVTRDTXlONFJGWkljVHdFZFo2VWpFWmdIc2EwY3RrZmlH?=
 =?utf-8?B?dHZnbTVvQnJkOFpoSzhxMXE5algwaWFEZndFM1BHTFBNM1NlWEdwaDBYMVF5?=
 =?utf-8?B?VkV1eW9Ydy90OVVLOXJaeEUvQ2I0RnRBSkk2K05aZmdyN1BPYmM0YXhJa24z?=
 =?utf-8?B?N09LSlhST05BQTlZZGJ0Z1ZvNXZnNFR0NS9DTkdYVzRpcVQ1ZWFlMnZyZklh?=
 =?utf-8?B?YW5BeDZJc1lHMzQ0b3FtTC81VFE2RDRNbWFSMVJ6OEhDUkFhZWpvall2b3Zx?=
 =?utf-8?B?TUYra0V1ak9qOEV5Z3lXVmU4Skp1VTNwT0xObW4xWDNJeWlYSjlpRFBtL1Ni?=
 =?utf-8?B?cFFjaHVwZEJjSVBBSlV0cXc0WTdWZFdiTXBOOEZGTUQxOWlTZkhJQ0VBZGxX?=
 =?utf-8?B?d0ZsanJ1NFhobzd3aTQxZGdjSEt3MENmRXlEMzdEUUdHTDJMKzZOeUV3Qll0?=
 =?utf-8?B?UmRvTFM1aDJPNzEyZjhhMytrUzg1blMvMXhMTXY2ZGRYMVZmT3l1Y3VrS0R0?=
 =?utf-8?B?T2prZmVKaEFBVXJOTThTOGI2ditYRE1uNldrV09mTElCZVYwaUJsQWErVnRp?=
 =?utf-8?B?WUhTbVo5dis3L1Y3Z3dZQVN3UzFIb2Z2MmZHNHVucEFqazVpczc3VkkzOUFY?=
 =?utf-8?B?QnEvRldtZUZEQXppYW1SV1ErR1VlZm95UXVJNXpWUWZZbUhuTzVGUnNZMHRC?=
 =?utf-8?B?ZmFEVWo5SExIVVp5RkRlTUVLR1Q5RGN6TUVpSEQxUVpnVHFLMHFsNW1Qd1c1?=
 =?utf-8?B?aTN1S0VVMnRhWjNMUGtmS0pwS2xxdlhpczB1Y2xrUHhFLzlVMFMybFJlRTlV?=
 =?utf-8?Q?8zbNTi/8EbY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDFRdjhobXlqejJ3eER5TWlPSVVXL0M5Qk1vSmhTTUFna0FrbmxMRFJteklN?=
 =?utf-8?B?MnJod2RkV1BueTFNWmc1eGlIQjJMRnhWMk5HMlc3RjVxRTZuRjl4dCt1M1M5?=
 =?utf-8?B?WS9uSzRZZXZSS21rRzR4bE8xTXoyYzJqcW1SL3VCQ2tLOEhEMms5d0xFSTUv?=
 =?utf-8?B?cnpzTUpXK0psRXpCdHpFbXhRQStLNVNXdEcxeEo2RllKbnRUMXlwTHRrZ21O?=
 =?utf-8?B?MjNiM0xTMCtTSWp6UGcxa2tvbCtRTUZkZkNTN3NrbHYyc0Fub1o3M1l0YVRD?=
 =?utf-8?B?S2V0ZWpCNlZMN0xKU1NQV2FJZmZrdzNyS0U3QXAxa1dycytZOHNMNE02T2Jj?=
 =?utf-8?B?TnZoaUtTZWx4b2FMWWYrNVVLTU1FQjZWS3JpbHI1eENmQmZSQk9Jd3ZZU2d0?=
 =?utf-8?B?NmNNejlpTkZKNmdKK3Z4NnVnVkFFbEh6YlVOU0xvdGJsd21SU3RyaXJCZEFj?=
 =?utf-8?B?Q21SQ09Jb3cvNGE0MXVVT01mSjlrTm5UY0EwMVNVa2l1VGt3djdxeFpidTlC?=
 =?utf-8?B?a0xFaGpCb002NmxBbkgyalBEYXlUV2FaekFMWlNjQUpCVkJsVlFBb1o4MGRK?=
 =?utf-8?B?NGZ4Tmw5NDhyZ3pUVm9VRHo1eCtrbzhEVElsK1pzM1p6SDNkc1YvV0tVV2t2?=
 =?utf-8?B?dW80Q2RHU0hVZlFKUlBubko2YTVlTmQrTkdVZFRhK1MzSDQ0WXlYRzZqNERk?=
 =?utf-8?B?Z3Nqd2ZaejFTWGsrYktYTmRsdHhEMDBxWXJVbVF1QitrMnJmckhaVkF1aXI2?=
 =?utf-8?B?K0ZEc0ZLU3MybkFoNkJVUW8wUFFxSnlackVRajdiM0VhQUFGMnI0d2RMZWFq?=
 =?utf-8?B?TU80OUdZQjEzK0VWT2x6aHJMVFR1cmlkZWVuV1NVdE9lMlNRTUZxNUl3Ung2?=
 =?utf-8?B?VmJZK1ZSaC84QjkyV2N4OWl4em1TU1dzdWFCOUxSdVJ4VGtjRGZLZUMvYXRk?=
 =?utf-8?B?OGVxcUx3Y25SdTMxcEtBRHd2K1hjZ1Ywc1UwSitFTTN1R3ZtUzVIR1NnM1d0?=
 =?utf-8?B?dGRrQVU4RjkrNjdXVHlJMmlKTDNkRWZsL1RJOEZaS1ZMZjJENklXckhzdUkw?=
 =?utf-8?B?RExRbW05NThpdStuYmlocFgybnkxdW1tamZwcUQybTBGWm43RzBtYVVjd3RW?=
 =?utf-8?B?V3R1eXVIZzUySTRMMkFTTGQvT1UybHRaOG93ZzY1RDVKZ1BBQVlDQWpxSWtt?=
 =?utf-8?B?d2dxSjcvL0taaTNEY1dTSlhBK2dBb25ZYS9WaHpZUkdzbjJiMjJqNDZIdzU3?=
 =?utf-8?B?QS9haW1MWlVBSGJqenhNckVkT00yaEhQbDJJckRubU9LTG5XZkRqaGFHY0Fo?=
 =?utf-8?B?VVp3ZVhERG5JdFpPN1AzQ3dCbFdXakhrTC80Smp3VzVMYWZPcFQ4OTMzTjhP?=
 =?utf-8?B?UU9GYTZZMG95M1Y2L29kWFoxMlZoV1FkbUxTVDRVOGhtWFBwOUlLbXNlYk4z?=
 =?utf-8?B?eGkrTFdvQ09OV0VacUMreDVXOHN6ZUVkbG1iRFpxUm1TYkZKMzhQTDBYZkFJ?=
 =?utf-8?B?S1I4U3BzYzVmVUV1NVp0elNLTzl0T0lETmlIbkxTVW1KZGNheWx6VFlZSWhI?=
 =?utf-8?B?bThCRTZFYnRCMGJOWko1WHdZSVFOaDBKODZTZHZpM00yeGdmVkFyMktJOGJa?=
 =?utf-8?B?SEVYV0ZlL0Z1L1BoYmZwbXViUDZpc0JVc1J1czJjRHFCUHNoQnEzMGo5WHhW?=
 =?utf-8?B?WHd3VElNdUpZZHdGTm9WdDF2a2ZjMXV1YnNtU1pHZ0dpem1lU2NTNjk1WmZp?=
 =?utf-8?B?MW8yVDB5SW5nVW1tbTFqSTlyVHMzazJubkVBbnNVVXBEYVRFWm5LTFBQY1o5?=
 =?utf-8?B?ZFljRUVlRDQyTzBoSDhCNEtnRERmaFBzQVNQWHExdmJnd04rWFNQQ2U0UUt2?=
 =?utf-8?B?dDhyNVQxeHhqMUVwLzZyd1RueFVBYnBEeUVGMFVSYUhyd3gzdllUcTI4bWs1?=
 =?utf-8?B?MjhRM0k0YWlTZjIzalJOVVY4OTIrbWNOMWU5cnZnUERFM3dobVcrbTNDbUNx?=
 =?utf-8?B?QWVoLzlKc2w4OXpHZ1NQZmtrVm1TV1REU2VxUUFkeWowMjFhZ3dsZGsrUDV6?=
 =?utf-8?B?ejRLR1BTaDFZbE53TjhETEc4SDBKUnNDSVF0dkMyRVh5VjFzblU3Sng0N1hU?=
 =?utf-8?B?UDRKVjB3eHVJeFdhMHNPTHgwaEhIYkFKNjVUU0U0TGo4MytOa2V0UVpMcXF2?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b125ba-60c4-4aab-ef3f-08dd93afa395
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:54:33.3418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DECLNutLzQ6/GfPmB4HmyHfLyiXtwb/01ZV6M2+WVj4rAjuNZ5g6cp7D2I0k5/8zvhZAo9rSGfg+IZ+IEQXHOwOvaF40jkZtbivGgsNjP9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
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

On Thu, May 15, 2025 at 01:39:47PM +0200, David Marchand wrote:
> On Thu, May 15, 2025 at 11:37 AM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Thu, May 15, 2025 at 09:09:22AM +0200, David Marchand wrote:
> > > On Tue, May 13, 2025 at 11:00 AM Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > Add a script to buildtools to report the minimum meson version given in
> > > > our meson.build file. Then use this script in two ways:
> > > >
> > > > 1. in the .ci/linux-setup.sh script, use the auto-determined minimum
> > > >    version to set up the CI, rather than hard-coding it.
> > > > 2. in meson.build call the script to report the version. This serves as
> > > >    a sanity check to ensure that any changes to meson.build file do not
> > > >    break the script.
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> > > > Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> > > > ---
> > > > v2: rebased to latest main
> > >
> > > This patch is reverting dbcd72f3fba0 ("ci: fix unit tests with Fedora 37").
> > >
> > > There were some strange errors raised by UNH, though I don't see the
> > > same python backtrace.
> > > Let's try again:
> > > Recheck-request: iol-unit-arm64-testing, iol-unit-amd64-testing
> > >
> > If we have issues using 0.57, I don't see there being issues with us
> > marking the min meson version to 0.57.2 rather than 0.57 alone. I can do
> > that in a v3, or else we can abandon this patch, if you prefer.
> 
> Retests show the same error, so I think we are hitting the issue fixed
> with dbcd72f3fba0.
> 
> Bumping the minimal version to 0.57.2 seems fine.
> I looked and can't find a distrib that ships meson 0.57.
> So either a user relies on the distrib version (with a version >=
> 0.58, from my quick search) or the distrib provided version is too old
> and then the user relies on pip.
> 
Ok, will do a new revision with the version bump.

/Bruce
