Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC632CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 13:16:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1054E40664;
	Fri, 26 Sep 2025 15:16:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9B1284028F
 for <dev@dpdk.org>; Fri, 26 Sep 2025 15:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758892598; x=1790428598;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=N9DLmI9uxq5L54aLyi9YLyg4ROvq4CRSlLYfNY5/IAM=;
 b=BFW8BTqkl8TRI6BzKYU6QKP9Zf0fUoyCqiebSho0Niq41F49jlquCqqG
 V4UWJDffP65i82ax1gMWTK4Fwke0TBrllYsz40xcYzu614jhFbNABZzOM
 BXzisFibRexl36vrTs2s8Wi9oBWKtBI4fyqPhqRCA9/o79Dz8g1XAqZvX
 gZ0nUO/wiXw+zdOCPkhVbMKMgXYboR4taDaqBsEasrRXlo10VtUiiMHhj
 DLxh3jvXRFYb0KPPW8uC/Z72+seRVJJl3siw+FsgK2tnpN475a0v7nrfv
 Y0zsKGnkRcNcDWVEXg7GVh5RJTzB98I4YQxdWaZAlTZvyIWW9TREJi2lk Q==;
X-CSE-ConnectionGUID: guoE8r+XTiCz4jlBpmZbjw==
X-CSE-MsgGUID: dBUI8RtjQ5aFtWmAFCt4zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="60262820"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="60262820"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 06:16:37 -0700
X-CSE-ConnectionGUID: HGDdyRvwQiSj20DPhrMsGg==
X-CSE-MsgGUID: jcWSktImTuW1UpHBp6x9cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="177998729"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 06:16:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 06:16:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 06:16:36 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 06:16:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+aDS+Vzq8Y2ccprpsk2Cwo7My/PLRMe1SZOZ6Pj037KQZKko890t0EjM7D3NxwjVESlDKP5oOE2ejWwTFdtfmGqLTkvRJCn6eVc5dSC90+jDpPWi/4PA5TqQLv0L4sgnDYdNku6F/6wLoZgdDtiUcGaE7WpzrcKOXOWEQQABlP5yR726mMSyJSQBQVOuRkISQQtcmnIbRR5BIS8GqCTHk1FIw7paQzwbCNyVr28rLzZpqtcANqnvtWujTkNxJQpl/9Zj/pK1oo//UaAvThRjvXpj8xMcfkbixBAkM11JcgEKYnSQHXcdyypUBfkMYR/6kgG/SFpE8Rmx9h9US/EMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ1O1J/FjdymsFdE/NamG/qfPRkr3nGWJaocMIg9knw=;
 b=pbqbOE0HFUFn+0ufA/kv7+8Hwrgx3jA+YqWhp0XBiGcpKfKU4HvKMHfIu71VKJOpCWsAc05jRmpbSF3vODvUe4IYAXmTIGN7FUzd6ocLwmSXdNHFUr04zg9QkObO9KFeFy/D+Adu3ru2jdlmOevi+KBcudGmzPJCBqv2pReVJYFyPq/6Bh8JrfhZG2Eg5XbaHtMPP2StkNoujFFJbTtT6ftMn3X6TmAObLdHY0ejpyJcCLCxR7C/NzCXeSfvit0PCmC2cksf5jL1uWXCr8L7jRVUwvX8wSVa8Zmd7ddQt4HbyLPlt9+hc7AFJsRjxEXtvLt8fiZecHuLFLCM4GOYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 13:09:20 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 13:09:19 +0000
Message-ID: <d60f98f6-accf-4fd4-8e2f-01e9152f658b@intel.com>
Date: Fri, 26 Sep 2025 15:09:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] net/idpf: enable AVX2 for split queue Rx
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20250926085404.2074382-1-shaiq.wani@intel.com>
 <20250926085404.2074382-2-shaiq.wani@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250926085404.2074382-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cb6085-3b89-4d45-3f83-08ddfcfde734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFVUSFVXVTViZStmMUdmaHl0ZnVJSUlkWFdFWmhvdFN6cGQ0R2lLd3F5Y1Vm?=
 =?utf-8?B?VkYyemNtbkJxZDFpazJra3lRWGpMdUE4Y09iVEFaa1NlK1RVcmdteXZWWG9l?=
 =?utf-8?B?b05Ea0VST0ZiaTh1N0dETW5XOW8wUmVpZzU5Rk5VU1p5cHJuR256NUhIdUxv?=
 =?utf-8?B?VU5UeWpxbkJqdVBUUEh0b2NpL00xQlRMZUlrM2FxVHczM1lLbEVVaUlEWkhs?=
 =?utf-8?B?c1RMWDVZSlRCK0lWQWg2Umh1a0RiZnJ3VEVSM2EyUkM4K3gwV1gxTzhFcnJ3?=
 =?utf-8?B?Y3B4N0pTS3BuN2dPbWNGK1dWMGxFWkJDaEUxSTJHeW8wSElpdlNpYW5pNEJl?=
 =?utf-8?B?NHY2RmplcndOSXZrWlNJUUZva2FqSUVOejZ1dGJGaEw5ZlU3cFFzd1dCSVBu?=
 =?utf-8?B?aHd0OFo4NWxFRlljSnRXRGVsQjZiWFNzQVdRYnMzcGlwb0lsNGlNbk4rd1Rr?=
 =?utf-8?B?NnRJQ0dTUWJ4RWtoUnNmcjJPWFZ2NEFXN05mNjBoclA1dHlWZmJFMXhnUGM4?=
 =?utf-8?B?M3VRSTk0a1ZvbXdYQ3Z5OGhseXR1cnFDNmdmajI1cnJEZ0xkNkg4UlRSeWRJ?=
 =?utf-8?B?ZjFoTjlsdzZjOEFyQmw1NHdBZDkzMVU5UnF1M2RlbUxxU3JvaEQyL2syOW1q?=
 =?utf-8?B?UDlVTm9DZlovUlVndEtRYXhOdnhXRVhON2dlM2NqakxSbW5ITklwcW5ydE9v?=
 =?utf-8?B?OSt3ZnpGYmFLcUh4cFVrRStRNk9EcVZHTWp1U2JickJaYkkvRjhtRC9Sa1JN?=
 =?utf-8?B?cVZQck40KzBjY3A1MzRBWGkzRzlaUnU3STJFaTUyZGM0V3ZYOEkrVkxvWGQ3?=
 =?utf-8?B?QVhXOHNyTnJPZmR2YXRMZEZFVHJUWW5ZOENYUlIrNXJ1dVJ0SlF6dFhPZkw2?=
 =?utf-8?B?ME9WZEliZVVRZzNpU2hjK1gzVWNvYzhJMmE2dVovQkNVWkcySW1ndFp2Undj?=
 =?utf-8?B?T2c3N0ZYZ1UrWGhNV0kwdHhoWmRQL3QrZmY5ajB4Tmlzb1FDbWRKL2l0L2xx?=
 =?utf-8?B?SWFCVUpoV2VIYkNMMGZ6T05IMy84eU1XQmUrK2xiSGpuV0VDeVRqbDg2dFVj?=
 =?utf-8?B?bVhTWFRMb1ViR2M1akRkbUZZUlZvWkJxRk9XZk9WNnJFcGMwRG43RHBxU084?=
 =?utf-8?B?N1VLZmRzWWl2cTAvaGs3Y0FkZ25CRU15dXZtNXpZKzdBNVNwMGx2cWRXOERn?=
 =?utf-8?B?S1NDVlZPZHMvUytMWWxjVmVPTG44amRrUlpCZEx0dHVnRjhxSk90SmxmTkZP?=
 =?utf-8?B?WUtVMytubHh6NFI4Ukp5bmhjeGpleTN4bWNJd2NrcmduWkxiRXFvUjhwMWxZ?=
 =?utf-8?B?cFROKzdSYkJjVkN1bTJnRFhaa2wxQVJzU3hGamF3UG1xMDNlbllMZWY3MWo5?=
 =?utf-8?B?b3JnV0hnUittQnhvZUhmMFVWUUQ1QmdZcWpxV1BDUzlLZ3pZTkpkcXMzTkVQ?=
 =?utf-8?B?L3hNT3JvN2Nrd0ordjBrbmVXRVBqWnhsQnFPaFU3cVNCa1h1bjQ0U1pvYUVL?=
 =?utf-8?B?UitTUndib1h5QS9yWDBiSnU0SGNkM3RUSE5XZDl5VGF2K2RBWUxqb0tmaXN0?=
 =?utf-8?B?Z0JycmJOM1M5Q2JPR0FIRS9HL0IxYUhUcWUxMW9hb3NaVmtIbUhPL21FRGdp?=
 =?utf-8?B?SEs1R3pVQUM1bkpDUzFYb29pWkZpYWtzRVp0MWdqZm93WFA2dVMzUkVYYmlr?=
 =?utf-8?B?VDVkdHQrQzdFMHNOZmFJcms5am40cVdrRmlkWHEyOExiTWZZYy9oa2RMQVBW?=
 =?utf-8?B?UjArNEo4cEJtWEJXK3B4L01pcTM1WlNseVlpYkEvM2NjL0pzWi95blR0ZDVV?=
 =?utf-8?B?OU5JeEx0eEkyblVHYzc0dm5DMk51Slo3ZmFnaGJuL1cwTDRHRmxQZ2xhYXJM?=
 =?utf-8?B?bnlFTVpCVDB2UjZieEFWanE0d2I2Tm9lQlhWTnFESGNjZkRSVTZ1MVp2YkNi?=
 =?utf-8?Q?/1x3AhR5NUe6AOcdFU3R6SmgxKP0QzlW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytOUnZ5T3prM2pjbVNVNk5JVDhRTitsbm8zcmdmVG1yTnhRTzRLNXI4YmQv?=
 =?utf-8?B?OUxyNVA0b1daSFVkMldqRkd6dmpCcnRNRDBZWnpJeUJxSzk1OEMzK2hFMkx0?=
 =?utf-8?B?OWlGOG5kamdSYzhvUXlYMGRXWGdkRDB1ZjFoWUN4M3FlTmFXNWtqOEt4Z21t?=
 =?utf-8?B?N3U5SE0ya0NJZlNldWFYVk5xVWJYY2ZCVk5yQXVZYTAzSGFZOGNxTnJaSnRU?=
 =?utf-8?B?T2tpR09vaVRjV2FRaU9NZmM5RkpldmUwK0dVNWxVWms3N3FaWThCcW8zbXRy?=
 =?utf-8?B?NnpHeXB0NWtvQXhhMExHUzFoU0dCdnRwRlNleWJvOFBVS1JVdlMzdnI0ZFRz?=
 =?utf-8?B?bVBEOWc3SWFJODhlczFMN3E3KzdJMWMvZk9DeDN3TWRoSmZ3TVpsYXQyTFVy?=
 =?utf-8?B?R09Sa1dGL1hEU3hXVGhqWEtQRWFPQWluMHE2NjAwdGJHRmY3TXFhMWdpYmlk?=
 =?utf-8?B?K2FRQnJBU3R3WFFNd1RMNkY0YlRFWWl6c3ZoOWpicFdtNXhWL2krNXFHeE9j?=
 =?utf-8?B?WlhCR0FPZzllNFpFa2ZuL3FkdXl3RkQ1VzUwSC9kRzhuc2ZFOWhUeGpLamlt?=
 =?utf-8?B?dTBRR1BqaFdqSEs3NndQWnpJSGJMZFJadEVjS3BBalZlaVJibTNOSEFyQ3BJ?=
 =?utf-8?B?VjdnTmUwSE5pMFFBZTlrdENMZUhRcy81OXNlMDdtSm1aeHQwVW91MTZmRnJ3?=
 =?utf-8?B?UUJoRjArSWJQNnozWnVjRTZ4eFptQ0EraUl3RWFZVkNmcjRkVHpJSnFBa2cr?=
 =?utf-8?B?L1FLT2hOdFRKdHdiSXptNVBaYUltMCtWYS9vRTFES1Vna0ZOSmNSN3RieHBW?=
 =?utf-8?B?aEhHUitwSTJNNzFpL0xBZUVSQUxJbXZrNmoyY0E4Q3pvRkROM1FkZ1RCVWdh?=
 =?utf-8?B?U3dLbWw1MllVRGV0UnVxcTl6eTR4aDRFZ0w3c3YrcVA0S1o3Z1JENzE0Qkxs?=
 =?utf-8?B?emZGR2ZUbndTNCs1Wm91SGdueFc4eDRQcmZuUWtzWE9MNzlGcTl6emxJcjlQ?=
 =?utf-8?B?bGNIM09EUUlRSTB3N2JGeUhnUlNTWWpIM2Y4KzRMemtZTWhHU3I4Ymp2ZzNj?=
 =?utf-8?B?bkVkaDF5QlhWa05MUm44SUNzQWZyY0dTQlJGTnpMdW9QN1F0b0piWWRRZTRM?=
 =?utf-8?B?NFRETWNHYVkrcUtCVWYrN04zQWNhZ040VHlobnlPUEdYNmxvNVRnaGw4dFhC?=
 =?utf-8?B?ZWlOd3NHazQ2ZXZIVXhrWE9JTVhoRE9PdXhFZVY4TGZGNEtJOWtuVTFqWmNN?=
 =?utf-8?B?OTVSMWlFL1dpUEswSEdJREtqcVc0RUJyOU41Tk0rUnBZbHpKdk1QeWZQSnha?=
 =?utf-8?B?S3RTNmE1ZnZ6MVdiMFFnZ3QxQUpOa2dYTTRucGRhVjBpaXRHM2VON3UyeXlH?=
 =?utf-8?B?UVdLU3dnTFNINGhZeXdkcVlMenR0TDFDdjd4SjFDbTRvVVhaV1lFcm5GN0Z4?=
 =?utf-8?B?ZDgxR0dZWmh2eWpBdkdEVjVocjVkdXdrRG1YSHVJYzZTbmM0azJ1TnlON1Rp?=
 =?utf-8?B?d2hBZVhyUzY3Nys1ZTZYNDFJNDRPcklqUjdTaGx3REtERzhIYVRYWC81Q0dm?=
 =?utf-8?B?R3B4eGJ6SDlDTVZQb0lTaVRlM2FBelJaY1BicXJ0NEFqS1kzdmpXVmQ2Wjlo?=
 =?utf-8?B?RlNLNmR6bkF0aURHTFNRdS9KWnBwaTNYTVpBUWFlUlFRREVWNHQzUk9EbjQv?=
 =?utf-8?B?ZnpNc1hta093aEtDRldPSU4zTGdGNW1hOEFZckNzbllpbVlpZlVHMmcrMmJ0?=
 =?utf-8?B?K0QrT1dHTzl2Rm1Zb01JTXNjM1NwWXBQbWJlZ1d1RFJIb3R4RXNqT0JFa2F5?=
 =?utf-8?B?S2ZMd3loSkMxb0pxNmIzb3VYL0ZhQUN4anFGZG53M0s4MlZtRXlTWDdOMHJl?=
 =?utf-8?B?SjF2OS9qV1RCaHJnOGdzWFlRRm9HMmJKd3NzejlhVnJGNmd1bFhIWVlFdTRM?=
 =?utf-8?B?d2VIT3V3MERNRGFsWUtYakxxTUtHZTA4aHQ2T2pXbHZQbVk1aWI5UzQ1djND?=
 =?utf-8?B?YkN6UFUzSEQxZUpRNUl2TEthY0JPamxiTm9EMmRTc0NjR2JrMTliVVhYMURQ?=
 =?utf-8?B?V2lnaGoySnpMa2M3NTUyaG1VTmVZSVlJTEkvbWdTWlN6Z1U5UEYxR3ZyTGFJ?=
 =?utf-8?B?bUgvUnZJQzBIeEptUjhaSjVib3NkbGZHTmxxak5jYldDT3Y1RHhEYXNrakNP?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cb6085-3b89-4d45-3f83-08ddfcfde734
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:09:19.4179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDdYrqC1AQep+pRI3hYVGRLmtvsOXNQzwnfhiJS23S+fV7FowxcowOzmmxzDlIe0MY2jld24yUMdYt8zp5HBGgZjOoO2/TErciujPavesGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
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

On 9/26/2025 10:54 AM, Shaiq Wani wrote:
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

Bruce has already provided some feedback, so I'm only going to touch on 
thigns that weren't yet touched on.

<snip>

> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index a2b8c372d6..57753180a2 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -1656,6 +1656,13 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
>   			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
>   			.simd_width = RTE_VECT_SIMD_256,
>   			.extra.single_queue = true}},
> +	[IDPF_RX_AVX2] = {
> +	       .pkt_burst = idpf_dp_splitq_recv_pkts_avx2,
> +	       .info = "Split AVX2 Vector",
> +	       .features = {
> +		       .rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
> +		       .simd_width = RTE_VECT_SIMD_256,
> +	       }},

The indentation is different from surrounding code.

>   #ifdef CC_AVX512_SUPPORT
>   	[IDPF_RX_AVX512] = {
>   		.pkt_burst = idpf_dp_splitq_recv_pkts_avx512,
> @@ -1663,7 +1670,7 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
>   		.features = {
>   			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
>   			.simd_width = RTE_VECT_SIMD_512}},
> -	[IDPF_RX_SINGLQ_AVX512] = {
> +	[IDPF_RX_SINGLEQ_AVX512] = {
>   		.pkt_burst = idpf_dp_singleq_recv_pkts_avx512,
>   		.info = "Single AVX512 Vector",
>   		.features = {

<snip>

> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index 3bc3323af4..3a9af06c86 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -252,6 +252,9 @@ __rte_internal
>   uint16_t idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
>   					 uint16_t nb_pkts);
>   __rte_internal
> +uint16_t idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts,
> +				     uint16_t nb_pkts);
> +__rte_internal
>   uint16_t idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>   			  uint16_t nb_pkts);
>   __rte_internal
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index 21c8f79254..b00f85ce78 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -482,6 +482,248 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
>   	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
>   }
>   
> +static __rte_always_inline void
> +idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
> +{
> +	int i;
> +	uint16_t rx_id;
> +	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
> +	struct rte_mbuf **rxep = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
> +
> +	rxdp += rx_bufq->rxrearm_start;
> +
> +	/* Try to bulk allocate mbufs from mempool */
> +	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
> +				rxep,
> +				IDPF_RXQ_REARM_THRESH) < 0) {
> +		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >= rx_bufq->nb_rx_desc) {
> +			__m128i zero_dma = _mm_setzero_si128();
> +
> +			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
> +				rxep[i] = &rx_bufq->fake_mbuf;
> +				_mm_storeu_si128((__m128i *)(uintptr_t)&rxdp[i], zero_dma);
> +			}
> +		}
> +			rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
> +							IDPF_RXQ_REARM_THRESH,
> +							rte_memory_order_relaxed);
> +		return;
> +	}
> +
> +	__m128i headroom = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM, RTE_PKTMBUF_HEADROOM);
> +
> +	for (i = 0; i < IDPF_RXQ_REARM_THRESH; i += 2, rxep += 2, rxdp += 2) {
> +		struct rte_mbuf *mb0 = rxep[0];
> +		struct rte_mbuf *mb1 = rxep[1];
> +
> +		__m128i buf_addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> +		__m128i buf_addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> +
> +		__m128i dma_addr0 = _mm_unpackhi_epi64(buf_addr0, buf_addr0);
> +		__m128i dma_addr1 = _mm_unpackhi_epi64(buf_addr1, buf_addr1);
> +
> +		dma_addr0 = _mm_add_epi64(dma_addr0, headroom);
> +		dma_addr1 = _mm_add_epi64(dma_addr1, headroom);
> +
> +		rxdp[0].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr0);
> +		rxdp[1].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr1);
> +	}
> +
> +	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
> +	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
> +		rx_bufq->rxrearm_start = 0;
> +
> +	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
> +
> +	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
> +			(rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
> +
> +	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);

All of this code looks really familiar. Perhaps porting IDPF to use 
'common' infrastructure should have been a prerequisite for this work, 
because I believe we have pretty much identical Rx rearm code there 
already (see net/intel/common/rx_vec_x86.h - there's already a scalar as 
well as SSE/AVX2/AVX512 implementations for rearm that are 32- and 
64-bit compatible). Perhaps the only problem might be that they use a 
"common descriptor format" rather than the virtchnl2 format used by the 
IDPF but as far as I can tell they're pretty much identical?

I realize it's a lot more work than this patch, but I really don't think 
adding things we know we will eventually deduplicate is a good practice.

-- 
Thanks,
Anatoly
