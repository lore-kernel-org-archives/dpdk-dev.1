Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D551C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 12:32:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59A20402CE;
	Thu, 20 Feb 2025 13:32:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id AFF6E402CE
 for <dev@dpdk.org>; Thu, 20 Feb 2025 13:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740054756; x=1771590756;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=+0DRaC8OBjvai76H9uB1CtGdFLw7oLYFOoPYk4sQeoM=;
 b=KHGtMgLWim+yzW4xSW0BDVqiw5uo4QQqvd3BjamF7DIhZOvGmTGB+54z
 vlGIOq3u+Lxx+XIqZEScJu02gOcItGHg2dOix9hoxMsXN6ofPosyKoEQZ
 kOp3nhRKOX7zaqyF6EyxkG44oluOYPHM37Mf1Cp6N9PJVHPzWPFqyKfrM
 /jQsZQTQ/MRHQCPrm8tPQ1kvfQwVT6Q+3c9o4/lI9eKzzkctSWnx5zKMx
 0Pgei7CIgsiRFe0FhiJMWY6t6DdueIODLmV9JlRhF6YEvQil/u6xFdpuY
 a+tUzzxZDIIKAwiQiSRImhtp7wl01fZn79UAFIMVNiShjRHfbQYDoPUV0 g==;
X-CSE-ConnectionGUID: be1UjRmoSAKGquPf1SJipw==
X-CSE-MsgGUID: 2Id6VaVsSLCTDUzURMLzJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40062958"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="40062958"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 04:32:34 -0800
X-CSE-ConnectionGUID: UgTtozCmTh6x8+DOxtLnFA==
X-CSE-MsgGUID: QKrXInZhQAy2+FfcvGr5NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115924535"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Feb 2025 04:32:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 04:32:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 04:32:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 04:32:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+chdU0Hg6oRowQckV3fLiewm5WgMqr9AODjngA81TK7xFZEirKZXdNh4f83iBXPqdkY0wq/trBq7L/z5/eb2Qcf2lInLfauZ8Qf+/pv0f9SCO3vsN0yfpups6By6NI+it5dHO2WjIA94z8Xao/srQSGzEr4v1yzvVmyG1//Dg+vgs8heeYqGNw1e6K586YfqrTQWuRxCp5J/u4dBvx7/rzkXuLB36vBg+JPr4sOKk3Gf8zIT3G5cIexhoOqBvys56ZG32lH3zentm9LrKo8Z9pq+Dhtir/hVpR8IdKvpt17wK8YFGR7AdO5duRs8s4KPDfL+NEen3FB3e+E93vAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObYY7fP470W4PF3/9lUYXt7N44KHhk8wH+ZwYVRspxo=;
 b=nNQ4ZSkW+ebUWnJhU0TsOyQG94uA6PHj8OzliVNUpMTnmiMYCelwBfkaty+twtzG9fG//FSoB//Jz70xesWWbVU5X4dICU8zII8/ERSRM4FupcnvR2v+gU8W1X/Qn/j5O3458gwG5e2/o1f0CIHumNbduNTooIRd9bEOZ4KR+owjCFK7V1PWUNd0Zon59Voql88fVMZqkm6v0MDhlMz1mFSQuo4BhAtcFTfWFljOM8r+LjlY/nzD5tG1ZP99vrTbORQyDRuLIRHEbsm+GlxZQ6E32QfoeZmoVCXo3N0pCQexPyXksRgSDLEdVY86SwUO2pKJiAI6akdRRFK8rtihXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Thu, 20 Feb 2025 12:32:31 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 12:32:30 +0000
Message-ID: <649e5dcf-b0d5-4a05-a50b-0de2c8e93966@intel.com>
Date: Thu, 20 Feb 2025 13:32:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/17] app/test: use unit test runner for malloc tests
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
 <20250216170110.7230-7-stephen@networkplumber.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250216170110.7230-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0197.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM6PR11MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: e0774462-0247-4a81-5742-08dd51aaa4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkxJNjFkeTN1NlYvYmkxWGVSM1o5Q2xlLzZ6M1B5TFRlYTJNUThvOExaeDVG?=
 =?utf-8?B?TldMOG8wOTd6cUdNL0g5QWhBVlBtYzE1VXNNZG1FcWxOdVUrOXQ2dUhINEhi?=
 =?utf-8?B?QnhYTVdlc0RhdEU3dEthYzJNS01qb2pWVG4xcGYvNXR4MzBucHV5TG9GZ2Fw?=
 =?utf-8?B?QXU5Q2tjY3hnaXBaQS9UcjNWUmdZcWIreUhaUkpWZ1MvVlZwMDJSSVg2akhL?=
 =?utf-8?B?VThoLzQrVGl2TEdIdDMvc3RXbDlsWkFjcHFPK0s5V0d0UjRvNy9URS94UnZs?=
 =?utf-8?B?TlJieFBZMml5a0NoL002eXhiSWF2bGgrSVEvblZvWWJUNzhlbHFSMTZnaDFa?=
 =?utf-8?B?YVdxMXZkNEZpeFlMMWk2MDVMWUtWNEFFcmtFc0V4OERnbmhyUzBCUTlQQjdU?=
 =?utf-8?B?bXRSeFd6VXBzcVptK2cxcmZUcElEdHdUZ1lvaDVpZUdVbk1CYmgyRjI4Q3M1?=
 =?utf-8?B?Y0lQRWllSWhqdktUQzhkRS81dTgrdkN1cG10Tk1UZ0ZlWnV3aGk3cXZVMnFu?=
 =?utf-8?B?b1llT3pkQk9OcDJZeDFHeXIra3BoSWl1SHlsc0ZGY0ZCRTZ3TnFXR0NPN25j?=
 =?utf-8?B?eUdLOUxNelROKy9Na2t6NGY0WnNENjJtMm1FSmxsbjF5cG9ZQmM4TmdKTjZN?=
 =?utf-8?B?cFhCbUdmb3ZWTkFPaFk0TUlKQWFzMmlWSE9HRGQ2L2FNSFhiSE5hc253OURS?=
 =?utf-8?B?RkV0bzRCNm9GZUFCVHN1SzFZdmQ0N1ZBZmp3VVVMUEhaaks4NEIwcDYxdHNk?=
 =?utf-8?B?YXN1SzB6NXMzTzVpRkg5TFVUcWUyZTc1OFRpV1lkQlNmRW4rMFMrSURDMlBB?=
 =?utf-8?B?cUlxOVRheWZSS25YVlBLc3laKzhIUWRYT3VrSXpxWkxEV1dzTzQ2TThCOTU3?=
 =?utf-8?B?OGtuOVRWaVpmWjdybnEwc3k0dyt6dHo2NnBJL3dacjdrbW44eXBta1AxUEZX?=
 =?utf-8?B?RjZ5clZSTUh0NWE2cnp5MHhDZnN4YUdaTENaOTNQbVpPV0ZKRTlnSGs0dFVO?=
 =?utf-8?B?NTRuR0ZqNmVHVVlsSHpqdmFOeEE4bmZweWtadXNta0h5Sk1vT2pIQXVhMW5Q?=
 =?utf-8?B?R0dMMTRVR0NmU1dQbDNEblhGaGhDYm0wRHVxTDBkcFBza0tZSTB3V3F1bENM?=
 =?utf-8?B?NlI3dWhRc0NZcXhNQlNDME9SZUJPWTFob2l1alM5V3NMekRCTklmVXpxdzA1?=
 =?utf-8?B?VVRaK3JlUVMzWlhCdFNBRmRXWUpVd0dNOGhua1FlZERFUy93eU9MbXdlVmZz?=
 =?utf-8?B?SDlEb1NuZ0dodHgrK0VieG56T1U0TWlrdGFoZjZOdysrZ0hUbjZGSGtxbnhU?=
 =?utf-8?B?VXlqaFBBRW1zM0dqYTdNbDkyb0dZU1dpMDhySW1DUXVXc1JneFhrODl2WDFm?=
 =?utf-8?B?L1hleThhRjhxRFJCTkl2N1c3NXdtQVRYNFNUZkdsSjVrWDlxZEFxMzRTWHNN?=
 =?utf-8?B?KzEvUTByMXp1R3F1NWQ3bGtacXpHN3JPeU96b2dwWnNyd2lTd0RKK2VaaTM1?=
 =?utf-8?B?OXpBbmVpdStqYzloN0Y1dWxZMUd1MFFGbkxMaEFCU0JDSWFXVGZXUEJTaDFT?=
 =?utf-8?B?d0FMOEg1bXRYelE2Q2Zsa2ZrRE55T2NsMCtDNGV0Nlg4RWdoQjlGaEpMTW96?=
 =?utf-8?B?ckpmTkRPL3U5NFYrYVFFTmh2M3dLUUJwd1VsTXgwZXowR1lKdU1KeXNlNXcw?=
 =?utf-8?B?anNONEZLVC9VbU9IZ3JDQU9UWXozVk9YVHphQ2lkcEl6b0dRRWtNdjc0bVlL?=
 =?utf-8?B?ODdDT3FsRkZ2eHd5ejI0TzNXeFN0YkVBdzNHblhDMEhsUDgwYXc3RTExVXdn?=
 =?utf-8?B?ajJxREhZd1QrRGp5Mk9RVVg4aFZpelpEN2thckdncTlmMEdkcjgvSXQ3WDNo?=
 =?utf-8?Q?UzTcBtJYOF4T7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlIVFhjNVVCTjhVZEJBeTZFdm14L0NJVTB3c3BuK000bVAvMmpRVkhOOG5P?=
 =?utf-8?B?cEdsbFk2b0NXNGtaTlpadUZhMjUzWEJvbWMwYyt3aXZqdm9HR0kwVkRIZXZX?=
 =?utf-8?B?RWx2dS9LbU9BalU1TnFkcS9lZ3FrenZvYVcwTjkzb0IrSlVOSjE4ejFibkZ5?=
 =?utf-8?B?QUlqT09xNUJ0S1hxdEJXR3FKMnRwOFpNWnNwd1lnZC9HRVVzR21SZFFFbXV5?=
 =?utf-8?B?T3dWQUMxZFR6bVNFNXV5TTc5VHJQWkdrVFNseUtpWDhOK29JZFVQVnRRdTht?=
 =?utf-8?B?aWUxajdJLzdBMUxqbWQ0aFViVmsxQ2F0SjRBQ1hzcGQ4N2JyWmkxd0dJaHRF?=
 =?utf-8?B?S0FJZldYRlYxUjNUS0dxMlh6UFd0aStHYjA4dzhxTlZsVVBXUVhST0Mzd01J?=
 =?utf-8?B?a1BjbEZiTU51enNseWZIWWRzdnVERk8vRG5NbzRtbEdCQWJVNEduM0RTQkZp?=
 =?utf-8?B?VzFHcC8vSEdndTNWSi9iS0Zsa0tVUHNRaFRERWI5VHFDVmh2c2NZSy9VSzd5?=
 =?utf-8?B?NlBQRDRWYlJtUkZhcmVnMDJ2Z1pPUnJzOWs0bGZ0VE5yUzJaNTlpVmErczVK?=
 =?utf-8?B?S0ZXajdDQmd0SHk2RVNmUDFOMXlwZmQ3b29lOS9ud1dKOURKUStwajg4Mk1P?=
 =?utf-8?B?SFh3ZDJqbExrUjVHbDNjUUxoQUVzRUdEQm9uTk8vbHoxaTE3czhhMGVVVy9s?=
 =?utf-8?B?YVNYbFhtMjU3UlZ3MVU4OUlIU2tiMFZvQ0NKaUoxcXlvY3V0MG9ERFFjZzVL?=
 =?utf-8?B?RGs1Q1ovVjJTMWFHTmdKblFIR0lpb2M0NXNmb1pPNDRmMHJvTTB4akVldDdX?=
 =?utf-8?B?b2VvQVZoa3c0aFZER1VPd2dMUUlJYThSSTlDT1pLeDZmSW96MzgrWXcrd1dG?=
 =?utf-8?B?blNDSC96Q2Fjdk0wN3Rqd1VNcVl2Q2ZFVVdmVHBSZENRZ0I0Sit1bnpZK2FR?=
 =?utf-8?B?K1ZjL2lXQWFoWW1tendYUEFnSGk2WktTRWg1NmVtMEVxY0VaVEtPZ1k3aVdP?=
 =?utf-8?B?R2xPd0FnTURyRW1ITkp6dWEzSHFRdEtrQy9sWmRFMVo1WFBhMFQrLzlvVEgy?=
 =?utf-8?B?cGNnY3hHUDA0T0Jrc0YzSFRSSmwxMnp2Z2ZKdll4bnFCTUZ0WityZjRybU1O?=
 =?utf-8?B?TnVQZ2FRZ21FZi80eVBnQldFZGcwWEVSMS82STI3K2JHZ3lMMmRseU91eVln?=
 =?utf-8?B?ZVUwSCsrbjVLVzJSejIwYVE3U0VXd203SERyQ1ZEVGpzVDg4MDNmZXdpU1ZG?=
 =?utf-8?B?OW1haXpoeEd4S3YwWjRPVjF4cHJ1WFRmSndremZYTDA3bUxvSEtUaHo0MFhm?=
 =?utf-8?B?NDlMMnZNT2RJTmwyQXlxdUVhQnZTZXlwTUhwK0ZEZUxqUHFLVFJjWWJ5RTVn?=
 =?utf-8?B?UjRQM3J5ay9Nb0cyOWR3TWRYOVhUOXdIRktrZ3ZFdU01cjBiU0RZUWNyNmg0?=
 =?utf-8?B?cUhWNkNFOUhtdFAyNHUrWUMwT1dMRTlUUGhmUTQwWkhYQ1hMTHAvUTVSc3Q1?=
 =?utf-8?B?bjNwalljL1NaK0IzZm96MTJFenducnAyY3J2eVk2Z2dyMXB4N3U1bEdZdlJU?=
 =?utf-8?B?S3hEdEwwNVBvTjE2MDZSRXlRbVBHTU5EOGpPSGVXaDh5K0dEQkZScVVnRWlE?=
 =?utf-8?B?dTBra0tlZGlSeWp3bUw5dllZSndNaWVnZkJ2b2I5Ylp5aVZwM1R3bHF2b2hZ?=
 =?utf-8?B?WGY3WG9DTkE3OXhPWjF3N0hzQ1YrZFFQQ01UZVlBVGxLVmc5WDg3Znd2S042?=
 =?utf-8?B?QnJkZEEwQUtBZFhjMzdoazVCV2dsaHp4RHRhVXZoeGFIMk15bzQ3aXQ2L0VL?=
 =?utf-8?B?cTdRd0V4emd6dmQwazhDSGt6d0d6WUdDaXFFb2x2NHJlVWZyRWxnc2VGejdv?=
 =?utf-8?B?U0RYL2YzOEU1ciszYUhlSkwrbmhQUlNrSWdMTDVDRERBU1YyUHpEMHowWmpU?=
 =?utf-8?B?QnMvSFltcTR1V2xWSGU2bXBzTFlLNFlKMzV1S2o0ekJUOHMwQTkyeHVzQXFi?=
 =?utf-8?B?d0kvWTdXeGhUQWIyK0Q3aUhQUVE5SWZLOWZGZFdIZ3hQSEdzSWVZRC9hVVZG?=
 =?utf-8?B?MnQvYU44M0pST25DYW1wOE9rMU01b21UQjljWmNEQXJVaTNuWDE4R1lmSnp3?=
 =?utf-8?B?dXV6anhiSkNZSEFYRWl5WlFHd2VQMEluVTdPV0JQKzdjYTFTb3BmL0RvYUFq?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0774462-0247-4a81-5742-08dd51aaa4bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 12:32:30.8234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHDexQcOo2uwzvH044Oyv32tPoBnYvmTtDftclE7n/txZzkrD4WrB7K7dJpUfuAwJJePseZ4WM4U2defoJxA8nbN/toLMXXA2fkobwk8y70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
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

On 16/02/2025 17:53, Stephen Hemminger wrote:
> There are several malloc tests and switching to the table
> driven unit test runner improves readability and makes adding
> new tests easier.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
