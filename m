Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBC1CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 13:47:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABEBC40DFB;
	Thu,  2 Oct 2025 15:47:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8A51540DD5
 for <dev@dpdk.org>; Thu,  2 Oct 2025 15:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759412873; x=1790948873;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Axdd0cAFX82Yo5BfxTbooOylt0gY+RrVIjbN4IMECGA=;
 b=n5dfRX5sfDEjPlWAsGQnlPuuQPFX0MYxKjO3nVm6MZh87oZM8icuEt81
 p9LDGbCDc0D5ERcE8nh0Xf5qbJOj7rO2glP4ra4FIFF/+GWJWJi2ouChW
 zFlUIb5sHHRjtsTY0WAkcMRlLkVvxv+tqaWg9ency5cVEPKEyTJ7kcc8y
 65BXSt2YcobkhM6ps3zmmlFAEH/w6B0AOkCIvY9vmB95KZ4W6W8x3U4RY
 nXxpivhyGFTpQ5Bdka35vopUYr+xRNDNjEklwzgNp/03vZ62icJkISq3L
 LVptFcqMj39COYP1yB6mzjMLM6QDGhdhRjgD+txFSS4Urx3M8Gnl6g/V7 g==;
X-CSE-ConnectionGUID: pqDfk3TMTsGJI3VsMgDsZw==
X-CSE-MsgGUID: 0JIWc5jQR6mKQaICa8m59w==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49250179"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="49250179"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 06:47:52 -0700
X-CSE-ConnectionGUID: wj7uXFXzSL2ldaSCIjxqMQ==
X-CSE-MsgGUID: jcj8RZe7Sv2/b3XZUn0Efg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="179459202"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 06:47:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 06:47:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 06:47:50 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 06:47:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xamSehDhpwMS7afV8iy4bL4V3WTPr2YxHSoSf7G3XOJ0xhzJGWcuV2rnmNiji7+4p7jvtOxYzz0OeKHkxnRlQdFEKUzEY+YnJsK2YAvRwWHevjQ02o44uFNXCDZeKMylf5216slqOld0BpCaFYayiTZi7OmTzd0Ec3CwKrFGjVvIb3JEPLJA2E+dsk1pcw4mslx3i0Ulhkh69kpDT6AwXiOYlHfUe82kcqkrjTDEl/xBpcuelOHhI6Uxsk/1cou/0QV6WhPU/ZQc5G3fpaWbG+YNrYNymcuHI07LxuJYNeF0Y+zfTsgTTJ9tXnPBjsX5Ug8vU7rK6/y61vSWUa1R+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFfzUUKYcsItfu2e74HROEkj8+JT8xyXGSic4oTOyZw=;
 b=GvCUwSZP1PI0NYggbxjfj9RMM62UgMNLMhaUzyDf3qpq/6NoBYMvYz8UZZEeeCsHsz3XBQOYzvNDKzHKTzG1LBCiOjVTFHJ2KERCIM+vIrn/JO0PnzRtGLRJlqNLlD++fkNK6omWOFXQWt22ptlirI6GX8DUa6yo/EwbTxEQz6HmThdYwOAYtgTDZ10MqY21uIMwz3BeCxEFysfSvoPA8wMXPVjFzzAcw7A7sAsmS1bEmLM18pl76Mf9EsEp3Ge9nFo8KbbHpevDTJfOkstK267m8hUVofpmQrvO0nL0+uA5hkrUtidttKJkwSu+LAO4bjNVqkouzZVwm74DMV7Jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB7703.namprd11.prod.outlook.com (2603:10b6:a03:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 13:47:42 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9160.018; Thu, 2 Oct 2025
 13:47:42 +0000
Message-ID: <ecfea079-2ba2-43b5-90f1-d20a99fb556a@intel.com>
Date: Thu, 2 Oct 2025 15:47:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] net/idpf: enable AVX2 for split queue Rx
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20251001075609.2608021-1-shaiq.wani@intel.com>
 <20251001075609.2608021-2-shaiq.wani@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20251001075609.2608021-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0034.eurprd08.prod.outlook.com (2603:10a6:8::47)
 To DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: b5027652-1a8a-4bb2-b274-08de01ba4215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVJnWXJPQktXTVBCOHo3UUxGRitHWFhLSEQ4VCtaWks0UE5kajdSOFdjN2J5?=
 =?utf-8?B?VHpyUmY3SG4wOFEwTDhVZ0JJL2piRERURXk4TnFDU0dIcFlMUUlHdEk5R2Nt?=
 =?utf-8?B?QkordEtZcU1wSXJZbXFmTUFEbzN2WFQzWDJRSHcrdWtlWGZIczhza3hlRVVL?=
 =?utf-8?B?OHIrOEtlRHUyRXNBTUFZcmNyd3RzNmNtZ25VeUJJaUZOUEE4YUxyZkNWUWFT?=
 =?utf-8?B?VzBGUk5vODNPaS9JTkQyaSs0UldVOWtHaHN6cE82MWs1ckM2a2t1U1liN1h6?=
 =?utf-8?B?VFBzd1NxWHlKZTJvQ1BySHl4NEFyRmlIQ2VmeEdQb2VYREVTalJnWGlzZlVo?=
 =?utf-8?B?MmRDdTk5a2Z4R1VrS25mT01pdEEzQkdvVU9EbVZJS1d4Q0c3NGdtamZiSzdR?=
 =?utf-8?B?VTUxckdDdUw2OVZrVC9wUWFVaFR6T3pITjlneDNmTzhHUUdoZmxnWG81QkVn?=
 =?utf-8?B?dDRQS2ZDYjkraVAxQmxGRThrZUpja0dFeGNFNndiNG5mV0xwaE9uVFd6bm93?=
 =?utf-8?B?eTRyUnpIVGlvZFVSRXFPMTJINE1TVTU4RW9HUmhSUmt2Q3ZRaGM1RzRGTlhT?=
 =?utf-8?B?QlZDRkluNngzOG5ueFppaW8ySTIwM0pXRCtZU3dDM2FhTVBadDlrUXlYUEtI?=
 =?utf-8?B?WXJ1N3dhcUZYZWJDQ2RoYTU5NjBHMzNwbVJLVnVQN016Z1BMTEJtVzloTHFy?=
 =?utf-8?B?eUptZFlpcHRxSjFlQnhyUVlNUThWa211S2oxOWJ4UHpSUFZuWmFIejZhWnNh?=
 =?utf-8?B?VndGRDlwa283aU1xOVh6RWVtY0ZubkU5VWlMQkgwN2h1NU5XcXVsMkhmU3cy?=
 =?utf-8?B?dTk2RmsyUTdhZUMyeDhSelpUMC9zNE5neHBVbEtWZjZNemc1Nm9WaDJ3UkRz?=
 =?utf-8?B?SmMrcyt5OWMzaitjL0hNaTdEZ2psdWMyMmFVR3ZHb0todHBZVWVUOEZ2WGJk?=
 =?utf-8?B?ODdIdUJaSU8ySkM2bkNXYVpRQ2d0YlNyN1liT3ZIdUVsMlE3WGJ0UnFZeGhu?=
 =?utf-8?B?WkJtY3lMZGhwRHVERTdyNjFwLzJ3MHpEZlRud29TMysvbjZNaFd0WEpCb3ln?=
 =?utf-8?B?c0V2Sm11YTdSVG9IZVBCamhBbXZhZS9TVFA2TENpYUhJWXIvMTcrQUFicHhJ?=
 =?utf-8?B?WGpkT3AxWEZBd0lteHNYZk1WaWFycGNzMlhQb28rSXJ0Wkh1U0xTYVRXaEtK?=
 =?utf-8?B?V2dKNVNrRVpUN05oMXA0NFNnV2VFY3JPTHlwSU14TzZJbWVCY1pDME91ZlFT?=
 =?utf-8?B?NzNWOFJnY2k3Y3VUOUxYRThVbXhzcWcyUEtYQ1RKaXJjSnpJZmN6MlExdHov?=
 =?utf-8?B?MFhrcWpDUkN1aGIwRXVtQUZ2bGVtWUI4VGd6MkhKZkNtTHhZN1QvUVBPOHlm?=
 =?utf-8?B?QkpJVVYvdDd4eEdweDRDRUUvV1ZNdFJ3aTdvU3o5YWNmQWM1U2IwcmVlZG5M?=
 =?utf-8?B?WEkwVWx2SnArUzdlU0FHVWd4cXRlYy9vVFhXTC9Qd2tJVzMyTkUrMEpEQnox?=
 =?utf-8?B?WityQXAvazdSb3I0VHMxY3VzUTNLQTJFN04wczcwRjU0citxeUdYN29abzJO?=
 =?utf-8?B?MUo3R1hPL25kQTFTYmViV2VESkNIRDB4eFIrSHRTeUNCYUdlQndjcStlQWZG?=
 =?utf-8?B?d1BZbUYxYW1Obk05OFAvaHRsc2JCdnhuYmlpcDlxSEptYmdUTnFERnYrcXV2?=
 =?utf-8?B?UXRvVHBxQ1F4SVhZM1ZOdWhpZnVmVHNaSVp1ZFpQcm5udFgvaWwzckE5TXpQ?=
 =?utf-8?B?ZXpSWWIyRzhIbmNFUmRNUWZaRjZxazEzQ0ZPclEveVdxUlJzSzZNbjJsd0VV?=
 =?utf-8?B?azNJa3Fhek5lamtwbUtEUHZodWc1SlNrSWZOMDFNQWx4MHlQMHA1YnNVTy9y?=
 =?utf-8?B?ZXhLZm50UkgzVzIrTTA5Q0ZqVnNZYjJhNmJHemdYQnhNSzQ0VDBUaDJvTjRX?=
 =?utf-8?Q?NNe0HMex/AFBMXhYtbP7DvDtA5/jhASP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU13VW1MSHB4aFpraHN3UXlZTzZWdkFuenUxQSsreXowYUNsZ0p0Y0I3aGtR?=
 =?utf-8?B?b1lRK2RWV1VGVkZhaE5yNUs0Y2gvSXlRYlp3R2pYNXk1ajNRT0lDcG9yUkYx?=
 =?utf-8?B?b1cwVEFHMG5WTXVHZjV0U09EMXQ3UUdPTlc0S1pTY0pFc2ZnN0VQN3FpNHRn?=
 =?utf-8?B?WjJIT0UyblYycm9YQkk5S3JhblZJRnVWNlFzWURxajVTSzBpUzI1c0NXS0Nz?=
 =?utf-8?B?L0FHNlVHa0lodXNpT1V5Q3laY1BYOEpIaTE1UUVCMllPVSswdTBkNnBQS2Mr?=
 =?utf-8?B?VitHbE1GL0V2cnhCbzBXTUZ4MjhsUUh2MDE5Nnl4TkJ3R0JnaGg3NmV3Ny82?=
 =?utf-8?B?Q2JOOVNCMzhucXFjTVhGNmtQZGM5Rm44akY4VmV2RkZocnZScy9tbTI4dHQx?=
 =?utf-8?B?eTY3RjlZS2psUVRCeSt2cWttOEdNemRRTFQ2NjJCTTFWUCttYm9WRDhCdkIy?=
 =?utf-8?B?VER6WnVKMVVUdHVaV081WEhjSDFSL0dqNzluRmd2cnVZaFZZWmJRYXhkNWw4?=
 =?utf-8?B?K2dGcTkyTmRtaksvdk1DYXUySlRXQzgwTm5hL1RoSzdpc2F4bURoLzhFNFdN?=
 =?utf-8?B?dHlBaURob2ZzRktmdlZObWJLc0JLMlB2QVd4Z2VjV1JiQlQwYi9pYVl2R1Bq?=
 =?utf-8?B?bkxBZEZKTjBQenVjeVh6d3pBOHRpZDhSZDBkRytIQkFMdEFuVnRFYjRtdkRj?=
 =?utf-8?B?NUhrcmlDbmVUN1pHY3MrZjFhVHhNZkgyaVd3bGExdVAzWHNvSG9TK3FVMXJU?=
 =?utf-8?B?TkhOc3RkNC9oM3NNODJrTDlUSytnZUFDb1pDQ0toUUZreklMMDdwc09IOVVB?=
 =?utf-8?B?VHJ3VWtNS3lIOFVUMGxIRzV6UTBHdkdBdmpNZVBhQndRekhvMWlyM20xRUlj?=
 =?utf-8?B?ZTN5bXBOSFVETUZHSU1Xbld0TVJZRENpUHhNeVFCcW5VV2FNUS81bTloNmRJ?=
 =?utf-8?B?bmZZVWQvNjdta0xkRUdGTWZYcHRIMDRMZzYwOW5SZE91dzhYMCtwakNZaThX?=
 =?utf-8?B?U01jT0l0SEZrNUE3aFVOV0p2YzQ1aWR1eDJraU1EWVNqSHRCR0ZVQjVBV2tZ?=
 =?utf-8?B?cGNpeTNPd3RQRFBWMW9UeHRYU0tLdWdSSkJTRmhjZXlIL094UDc0NHE3NGNp?=
 =?utf-8?B?V0xGZGdYTDJQNm9iKzJiUktrbFV5SW55MFdCSXMwS0xKc1hIUnl2azFZeXJF?=
 =?utf-8?B?WWJSSFo4bkI3a3h4ZHlhanFNU1U4VmxjYjF0eGNWL09CK0lwTTEyQWFjUytQ?=
 =?utf-8?B?aFIzTThrR2toTldMckhuZEdaZ0lVQ3pjSkVuOTYrUHZNWmIvSUthczRIWWtn?=
 =?utf-8?B?ZVlEaDQ3VTBaaGh4WWdGR1hTWXA1bHprUHNuOWFhRHlMVWNFcjFpdWdxM016?=
 =?utf-8?B?SEdiYkdSWWZiUXlmK2Q1MngzRXlnR2RCb1U5c1VCYnZTbEs5a29sWDZiWjBH?=
 =?utf-8?B?T1VEdjgvckp6ckFFajVlMGlUZE4xSTB2N091UlFvUU9WNGQ2VGlWSjg4NWdW?=
 =?utf-8?B?SVVEU3JjbGdKR3EwbFlNUXo1YmMvQUFzTGRrZWE4MzFXUzBVL24wZ3NIeFEr?=
 =?utf-8?B?SlBUMlZYMXZ0SXFISWhDdlczVi9iR3lwbWRxaW9MZzFVd25RUElycGliM2dx?=
 =?utf-8?B?QnZUVDFzVll4SlVLK1BJczZHUHNsQWI1Rmt2cEdiSDNsZHJ4cmhJM2VlRGNm?=
 =?utf-8?B?ZERzaEQ2NDhmYVUrempac21BYkYvSmttMm1abmc3UjRvYmFCdWVXWWZSMHJ3?=
 =?utf-8?B?SnE0MkNnWFc5ZDFVWnBmN0Y0OGxmRUN0MlNKZExWVitiWmQxVlFPNEM2ZzlD?=
 =?utf-8?B?eDQzUFN5ZlNza3NjYmR3eGs3UHJCbnVkUWRyemFObHNmei9jOE1wZzBiaElF?=
 =?utf-8?B?TnVOQTJOa0ZZcTJRTzE1enFqYWtyYzZ3QXByNXFNS0tXcDh1Vnl5ZUVoMk91?=
 =?utf-8?B?elFBQzJSd3RqZ1hCOFRHT0cwVnlzMVBuc1R4ZGdoT3QzT1hSbW5qKy9jSkk1?=
 =?utf-8?B?K0dieEplTWIxQ3NoZFhlcERYYW4razhuTktNQUdZaDJQRmFEN2JockJicG5W?=
 =?utf-8?B?c1JqVXRpTG5DaDNIcDNRVXlLUlNBdHRnSnNtZ1l2NkMvT3BPdmZ3VGovdHFa?=
 =?utf-8?B?R3FFUTFtcE5sU2twOVkvSnI5U2N3ZUFNRHBmUkRndmZYSEc5Z3oxVys2TU9C?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5027652-1a8a-4bb2-b274-08de01ba4215
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:47:41.9802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdP2FkwVC7OFWRTA7SYXixECMqPPYYynIsn/4SOc/dusAkDp6op7lJ57su+9BXy5bWPgO+d44bVN5f0h2QeKCUV7x38bzb/yTajVtfqIZIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7703
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

On 10/1/2025 9:56 AM, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Hi Shaiq,

<snip>

 > +RTE_EXPORT_INTERNAL_SYMBOL(idpf_splitq_rearm_common)
 > +void
 > +idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
 > +{
 > +	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
 > +	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
 > +	uint16_t rx_id;
 > +	int i;
 > +
 > +	rxdp += rx_bufq->rxrearm_start;
 > +
 > +	/* Pull 'n' more MBUFs into the software ring */
 > +	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
 > +				 (void *)rxp,
 > +				 IDPF_RXQ_REARM_THRESH) < 0) {
 > +		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
 > +		    rx_bufq->nb_rx_desc) {
 > +			__m128i dma_addr0;
 > +
 > +			dma_addr0 = _mm_setzero_si128();
 > +			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
 > +				rxp[i] = &rx_bufq->fake_mbuf;
 > +				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]),
 > +						dma_addr0);

This is common code (including non-x86 platforms), you can't use 
x86-specific intrinsics here.

> +	for (uint16_t i = 0; i < nb_pkts;
> +		 i += IDPF_VPMD_DESCS_PER_LOOP,
> +		 rxdp += IDPF_VPMD_DESCS_PER_LOOP) {
> +		/* Step 1: copy 4 mbuf pointers (64-bit each) into rx_pkts[] */
> +#ifdef RTE_ARCH_X86_64
> +		__m128i ptrs_lo = _mm_loadu_si128((const __m128i *)&sw_ring[i]);
> +		__m128i ptrs_hi = _mm_loadu_si128((const __m128i *)&sw_ring[i + 2]);
> +		_mm_storeu_si128((__m128i *)&rx_pkts[i], ptrs_lo);
> +		_mm_storeu_si128((__m128i *)&rx_pkts[i + 2], ptrs_hi);
> +#else
> +		for (int j = 0; j < IDPF_VPMD_DESCS_PER_LOOP; ++j)
> +			rx_pkts[i + j] = sw_ring[i + j];
> +#endif

Why not just a single load/store? I guess compiler should optimize this 
anyway, it just looks odd. Also, I think the comment only applies to 
64-bit path, so probably should be made more generic (e.g. "copy 4 mbuf 
pointers into rx_pkts[]" without mentioning how long they are).

-- 
Thanks,
Anatoly
