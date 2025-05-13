Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1721C3ABCC
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 12:54:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A51834026C;
	Tue, 13 May 2025 14:54:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B562E4025F
 for <dev@dpdk.org>; Tue, 13 May 2025 14:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747140887; x=1778676887;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aLq26jDEKBolyudZcgXfefPiCDGTKZ3ZmlTsVAvrZwY=;
 b=YQ/bNInHaMoP4x8RPkeXDZI7e/Lx2sdcsOEnlGEUqyJgZxFEc6wxE5w1
 jp04zQohZ8YPRjv2mNhH+POryC4lBgd/u3GkgRpNMs5NeXYNI2QgDryER
 ch31MTDaYcsN2cPS4pG6GhvhC7rBLtVOHzsaeqOfddAwse9hxQzssTUIT
 EDIKoa4NcHetwAo2qbucA83zprXnQLMmgAqEDmM5nMlszHe2296WS6dPP
 6dD/2abcC3JA0pFVvVK3ZOGj49kSFVdH0MkfVLgsEkwBtoIPBnJoo+A+T
 fN2GcVHLNUu67NTBJv9cmNMp8XS2ASYJfeZVZhhwjZ13AlQ1FMEOU/Mli Q==;
X-CSE-ConnectionGUID: 6/huBBjxQECyXCt7y2T2ig==
X-CSE-MsgGUID: l70dfhOkQ9Sg5lqJ761tnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49149721"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="49149721"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 05:54:46 -0700
X-CSE-ConnectionGUID: 6zWMq2eDQlGpdMlaYZZkSw==
X-CSE-MsgGUID: UNCrqiqrRiuHd6LUA4uxhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="138185186"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 05:54:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 05:54:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 05:54:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 13 May 2025 05:54:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSwT6ro9AtNuFAbtP9YaPSU4SKiOPOH/UaGBEfhyzXs3p+AjMlM3UomI0fxmzFKimK07u6RrML4sHop/kENbZW5lAMKeYFa5CJTm1PNfXIMjpvD8Dissm3mee+EsubHy7+lXOQq8eK4kdzN/BXpGlf9rgiYR7j/Vs6xeBOuVVFtOjiEi0PeSrbT6dbunKfZSvZnT/Pe4QYQ1Csm1tYVF/yxFdEKy+pUfBir9eqZ29+0lx13ywimdGtwEVAWdGH1pTpT4MXhhI0rmyJxXcEmVRSt4mFtojzm1yai4cu/mrXO5GptYSmnpzw4Yx5F7Fm/cspzoE8/aCM/zn4J1pKnJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PnjPC5ZlPMYmFrkZ9ckqWZtnMKD/cR3Vs9p0MaIRk8=;
 b=wWjIsviVDWay38JurrVTkdzJcKneEtbPpkXK+hwvO9Cwvra+IXtXZCF3JvogB9nWuoo6AEKmI8l+zCLGY1TKPKYW9VhP5RUZLj95Fwc/XjLnZbmE6y+890E3WDgBZzr7dUbIdp55xnZuX2gGoPwKYqY/bz+duwludotscL9R1tNCScR3L5q9HLcaJH5cOItTdQJU89kbIlhvEZ3JNv4fP1skZQ8EZqZu/XB5o4AUMn5Lq/NyQGKtHvuY8UKuZqZN7ojAzCtfgeELLe/qrRiTWNl/nP68bKvdJ35NthizzCbqEIYD2rVs0levpraA3azf8GW7widxs3yQhJWcg5W/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB6979.namprd11.prod.outlook.com (2603:10b6:510:207::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Tue, 13 May 2025 12:54:37 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Tue, 13 May 2025
 12:54:37 +0000
Message-ID: <19a0a878-2d87-457e-adc1-4d69563beb88@intel.com>
Date: Tue, 13 May 2025 14:54:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] bus/pci: Use force-noreplace flag when mapping PCI
 resources
To: Jake Freeland <jfree@FreeBSD.org>, Chenbo Xia <chenbox@nvidia.com>, "Nipun
 Gupta" <nipun.gupta@amd.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
 <20250506174046.1136711-2-jfree@FreeBSD.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250506174046.1136711-2-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0216.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: c90fd70c-b2e4-48ac-2dc5-08dd921d511f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjBtdk92Tk9tNlpUUkdnSS9aWk1Na002NFBCd3A1OCsrWWpIZHhQVVc4LzhV?=
 =?utf-8?B?ZUdlTXZVSnVqNXorZ2VqdnVNZkthNjlFU29lc2FmQ1h6TXBWUERYV3c5ODBP?=
 =?utf-8?B?WjNyTnI2TVZPSnVUT0R6MWszSU12N0htU1hwK2Vob3k5RUUzNW1XT1I2VzJ4?=
 =?utf-8?B?emZTYWJrQkliREpBbnM5L0J2ZFFyZDNUM0ZCcU1SeitMZ2hqekgrTjR0TTJG?=
 =?utf-8?B?bWpxRXVlMEZGOTBLYmpaZ2NqZE9ueUp6ZFh6SlBrcUlZbEVOZjRuSzdBSk00?=
 =?utf-8?B?ZDdUcDlDWElucXNGVUQ5dXc0bitSMkVyeHJ2alVqbzZjZnV4clhyVjR5YW15?=
 =?utf-8?B?dFQvYkdkWUNIQ3dWaHltclA4d2R0aTBtMW1zOW4wWXRza3lsSC91NjFjRlQw?=
 =?utf-8?B?U0U5Rytjc3ZyYi9iUUhOVFRXdHVqWCsrYzJQdGZuQlg0ZXAyMkxUYnM1WlQz?=
 =?utf-8?B?dzBxMGFMYVpWL1Vvb1ZTTkU0eTFpeW45SlNKREw5ZzJwdE14YkovTGQvVTBx?=
 =?utf-8?B?MjVxZHloazE3bkRrSDdjSXpHdzV0NGhmd1dxVklQNXV4M0xKblNZcTRwSldD?=
 =?utf-8?B?d3p6SzFIU3FUSWU2cWp4N0NQWUhWWWlydHpIM2F0bTNIUjQ0c3hYYXFxbDlG?=
 =?utf-8?B?UnIrUjM3b2ZYTUo0VVF6Q3NWVXozM1NjeldzazJlWHY2Ny9JOW1zMG96REpx?=
 =?utf-8?B?WFhaNHVPNUovR2N0VVJJVFo4d2RLekNvWU9yYzhCMExKZzdxN1R4V09IZUEz?=
 =?utf-8?B?TFU1bVZtYnlhcXlNRUJzN0F6cUQ4dzRFbmdPNDRNdVBpblV3QzJUb0N2ZnV1?=
 =?utf-8?B?OWpOL3VCMlNaT3ZFaGtKZGk5MWpxUjFSM1BxNGFIMTFmM0pXM09sM2drVGhI?=
 =?utf-8?B?SGpkUEYrY3ZyR0JqaFc1Mm5SYjl5QmxiUGNrc0hRWDIzb21VTFpzVGQyeVBT?=
 =?utf-8?B?VEx6RUxFSytDaDhIQjV5eWplaXo5QUVFeUNNRTdCKzluNUpoSXJtNy9GNFp2?=
 =?utf-8?B?OFZCVHlJYit3VVhtdEp1a0lmM3pkWjdKZHdPY3lRbk81R3NkZGNzcURDQm9L?=
 =?utf-8?B?Q2wrVk5xUzdVWjN4V3IrS3V5SzRuSkllM1pQakYvQXhtcFVvekgyN2QvblI5?=
 =?utf-8?B?QnJZYjFadDg4OHVld05QRDNHVTM1SGRLbjRvVWs4WVI2dUFJVnNjaUV1RGpE?=
 =?utf-8?B?cXlUUll4L1Y1WTVwdDRFb0NjQWdqSTlTc3hSNUZqMGs5V2R5c1hOcERjY2kx?=
 =?utf-8?B?YkwxVUZzdTU4cndIZWRFRWZQdUc1N0lTZFlnekJ1bXV3b1VWVkVQeGdVV2d2?=
 =?utf-8?B?UUN3VkFiSUptNFAwc1ZuUXBIY04rYkhKbHc2M3hpTTZGQ3B5T3NMdjdtOTBH?=
 =?utf-8?B?VXpyT3ZwSjhBdGhnODkxN2Z3UDBheFJwazNxZ21EaHoxbndhYVF3RFZYT0RO?=
 =?utf-8?B?ZkRncUw0ZmRqWWlpS3NmcURHNjl4Z1dpcDlsVWk5Mmp5K3hvalFVNXFiMjJh?=
 =?utf-8?B?akIzaDErbThibHZadktCMTZTQ3VqWG1qT2lsd1RCaDVtaXVPN3I0SWlva3Rw?=
 =?utf-8?B?RngxZ3dsd1M1MTZlZ2JrWktZZGlOWDZJaFNZcm9rYmcvMHoxckVUK0x2VitF?=
 =?utf-8?B?QlZDellRd3d5bnFYRVVoSEpSZi9nRjBXcVpDbEdqeEdOdHBrZXIzNC9zb3NG?=
 =?utf-8?B?NFpxMm45UzB3dWtkRzllVnQ1NnNzNFFvRjlRYkNEeUZZK2VCZHNnMlpDYUI1?=
 =?utf-8?B?QStmSmN4bjgvUTYyYVlqMGNESTFUSTlCTHpNeXZoZTFzY1hSTlJMN2xVK2l0?=
 =?utf-8?B?Y09VUFhNckJuVGxrNElxSkhEd25xbjlMTzRDSmc3Y055anc4NEtzSVVIOVF1?=
 =?utf-8?B?UTNsUjhibzdiaUltYXRzUXExclJYMGE3SkZNY1dHZ25XL2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG5GcHlTY0VxaUc4ODZJQ0dnWWErNHF4dDhGV0RxU2M0eWljVUEybkhaUDk5?=
 =?utf-8?B?Y2hhT1pzRkJzMWFHc3RJZ2pXU1pzallONktaZVlWZ2pFeDZRUXhJaTZIYWtX?=
 =?utf-8?B?MTdDODMrMDg2R0hGU1IwcjVRcFlFbHU5ZXNjaGM2STRMQU1XK1c5L1pPUkJl?=
 =?utf-8?B?aFkrejU5dHM5UjBvZjhteEo3d0ZseU5LRDhEMTJodzBjRTIyaU9RRTA0ckNm?=
 =?utf-8?B?NDNwcVc2UUhvUm1qTy9IQmsvNmNHNGdFd0JaVTNrQkRUMWhpTEkzZjNkR3NN?=
 =?utf-8?B?eUVoNHVpVUN4ZzdwbWU1Zld6THU2YW14dDJkVU1LSmErVWpZZ3FNa3A5VFRZ?=
 =?utf-8?B?cDhNMmRoWDdVOVVWczZ4UHZkZFZ1c3BKbnFFbVNuRkNiM21VZkEwbXJncXFK?=
 =?utf-8?B?U3JaZTZhcmpzMjdQemd6dFFTaE4zTVFEL2NXU2dlV0IzM3dnakV2aDErOGR5?=
 =?utf-8?B?ZTNMWDNmTlI0T0JQOFdEM3A4M1FibC8wVGgrdVBGU2FIUmZmMjJ2M01aZUdp?=
 =?utf-8?B?UkJSWnMwNVoyWkJuRWZhVkNJT0JhK2s0anJKWGNBVlhMNGVYbGNvUWpxQWZo?=
 =?utf-8?B?SjduOU1scFpKd0pobFJud2dlNE9ZbGFNUnA0b3piV3RHb2ZlcWQrcU4yV2JH?=
 =?utf-8?B?UVNJQ0VKN01mcUNvZERUZDBudzJPM0FhaE04eStFQ1lmdjJCd3ZjclZQdU5G?=
 =?utf-8?B?bXVJdkhJZ0pKRmJzdmRWbnIxODgvL3FhbzNOamFMOTBYR2pPWE9rVzZxaEFn?=
 =?utf-8?B?cU00TzlwTWxWNjNVTjZ4UUxNVDB0aHU0V2NtVUcrMVJEWDdWeU81bkxVampE?=
 =?utf-8?B?SWp5UUU0dEh4RUczaEFDanZKRllmZkZZczE3azVLVDVnSXV3SzhOa29UcStk?=
 =?utf-8?B?QlMzU1RuWi94Qmh0WEtiOXBscVpCRmJrOUNpSmhET2IwTjZkM2dJVWZYemhn?=
 =?utf-8?B?WmJHOFBKekhrVEFzMXc5YktvWmdZbkFlcHJmTjdRWHBzN0o5NVVBVnpmdzFP?=
 =?utf-8?B?T2Vkc2xkRjRDL0s4eVRUTnpIcjJFN1M1V3Jmd2VoRldsMUIvbzF0dzB0SFVZ?=
 =?utf-8?B?MlRUTDAybk83cnAvclZXUE5LUVBseTluWis0Z1h2ZHFZS1BiZGFJaExiVGpG?=
 =?utf-8?B?L2hBT2hQRkRJL0tiRXhSdzRFNzJ3RkhZbFEwbGlya0xqdkZWNElSeFZWV2xw?=
 =?utf-8?B?V1BUcWVaN3ErNUZtbjVHRUUvZVlsM1g5OWMzZUplR01TQWNSMld4czc2RGdR?=
 =?utf-8?B?KzJOdytjbDVCREVMMFhLK25RV2czNDNHNEpyQm9tOTRrY0tTWGhTTTJFR1RF?=
 =?utf-8?B?dUwxYXRGOHZoVy9XTzcwTmhqSXpua3VicWxKWW5sa292eGwxeVhVTE5tbDlJ?=
 =?utf-8?B?bWh2c2lvVVNrSDRKOVlkaXFCcllTY2o0UWdMWTZKVWRFb2w3c21EYWllS1V5?=
 =?utf-8?B?clpta2ducjI3WEhYQTRmQXVTN1ByM0tQSVY2ajdsTWN3ZktQMVRPMDBMSEtv?=
 =?utf-8?B?bkNOdFoxdmtPVFpPTSt4R1BhWFpJZzdzUmtFY3RHblNHWW1DWmFaWUJKbGd3?=
 =?utf-8?B?NEdpbWNWZUNLMit5cjJkUEZmNVAzUTdHV24xNWdLMk1QTWpOWFFnNHV6SlZu?=
 =?utf-8?B?ODdqbks0S3FHZjZnMFZEV29vZGdjUFlIVmpBb3M2aHJCclRmNnE5bVREbW5G?=
 =?utf-8?B?N0R6VUxyTldBdjlsdS92bHNBVjRydkozM25Ma3pFWUptUXlVWFdkbjNGL2pP?=
 =?utf-8?B?RDN1QXlFaUl4ditkcEJBQnpLM0JVS2tXVXQyNjRYd05ZcStHQkF0Y21BR1Js?=
 =?utf-8?B?cWJvSVZOUmoyUDdaeExkR25CYlFZTXVHNDV5QkRMcCtSY21CLzNJb3BXdFZN?=
 =?utf-8?B?MlFSYXpUaWRrVldmdVpScG9xU3UwRGR2QXB5T1ZmeS8xOXZGeG5lb29MTzkw?=
 =?utf-8?B?MTFlOG82SExQUmtiOGc4bThralNZaXlWd0tYR0RqK01BUVM1ZVh3NGlhWmRJ?=
 =?utf-8?B?SllQbWtnUlBYSDA2QXJrOEtxcS9nOFVjM0lUQjdCZUpkMWE5ZnRvaTgyRkx4?=
 =?utf-8?B?OEd1cU92SHh5NWJtb3FQazk0bUd4WktIMy93dlYwdkprdnp4dkpCalErRGZ1?=
 =?utf-8?B?VUdXbkoxd2NRditYM1U2ME16aDJHMmxnL0lvTDhQZ3k5MFBtWkM2R2NGeXN4?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c90fd70c-b2e4-48ac-2dc5-08dd921d511f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 12:54:37.2694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fsRpWdiQHtFd+cU/wjqm5BmtVGUIZlBZhI0E1ngVwaMuBAGGLj15V9mC62qwg7eaL8/2pflPbtziM+IltPE01RCZ6AjDZYPyb1yWuwoaC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6979
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

On 5/6/2025 7:40 PM, Jake Freeland wrote:
> When mapping PCI resources in secondary processes, use the
> RTE_MAP_FORCE_ADDRESS_NOREPLACE flag to indicate that the
> mapping must be made at the provided address.
> 
> Without this flag, the kernel might return a different address for
> the mapping, even if the requested region was available.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
