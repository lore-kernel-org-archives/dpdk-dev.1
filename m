Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBBBCCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 08:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29B40402E5;
	Mon, 20 Oct 2025 10:57:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1004A400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 10:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760950661; x=1792486661;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=pVu2ONlvliCseeE140qXB3BJ4W7Pqqc/h2dMUaIsurw=;
 b=UY29BhL4Sij3KAb6fu5i5AZoY+inSR0ADRyBhuTC6DLbUj+rJ0iaVheZ
 4xQlnIM3kq0PTCBWPqmmEzj0KOKE5xUwAI7r+g/OmrxhKfv6+OFIefAfC
 Fx+JOwhLL2rDABFVjrPy5R+wF+dyfXNn0TAxuilTHpnXU94MGDq6ZZ8tM
 +ewVRUcRjdlkfUpGAsFiCvguAVs65qQKs4bYCJn7DtK/0yxsLC0c7SY9q
 hPWrn2bILahIm8U65nnLE4R9wnykkKoH5vnrJHqC/4105gfhhiqHOtYmG
 I+VPr+mscrp4i9G5TCrzByt6hOFwnx+mW2FArRqZnq8HuHfoDTTMQnUyL g==;
X-CSE-ConnectionGUID: KumnZgKdSkS56TIkQ9bOkw==
X-CSE-MsgGUID: 6uPVnZGBSjGsaTRs7VdU5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="66702530"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="66702530"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 01:57:40 -0700
X-CSE-ConnectionGUID: YOqTJgCmSKG/0tUYWmscXA==
X-CSE-MsgGUID: irDGLoeXQwy+oLL/8zaBSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="182421463"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 01:57:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:57:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 01:57:32 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iItC8yGHs7ixuits6dkUk3ED+UHP91+RurT0VttTTSdp03u184fjFu2yghDl5sPSxIyfNGpJ8ADlW260xmnszavVnEOPabA3C4QyyueZvtLyiJ5oeq2HeexVlzUCv1lDErp4oskmy24ySEFY7ehqz1fjcvGFmryonphebcAzlAsKc0Q84v50cPO5qKY40vmoM2TaI/UO45h+7lREvnBsiLw73BQLl6gLuMkNxf9cZ4HXcxou57cahddnJYDIXSAZavuIDfXypQA4uL90I4u2lGd2k6cQTehsJJT8Vc9tMPs2yPvMaFakRIm/3hUlXxPKEi9iJjGaSMEF8E+4Wgyftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/JlMJLHkkTPmSbeAzaabRsEenWV1gKTPUnxwuJt34E=;
 b=Cf2K8TC9hkc4als1ipV1eSkQc0jQQ/eIkI+yvu6psZtla7jGrd90F68aEMQ+oevJBT8YT/buCKmlWAxra276DM4NXMTrfZEjmHBcxVuQrR5OeK44blo9fm/d36WWcfmjsa1c4Lc/XRjWIjA57loNfO979MECsoLGQwngBqWjJzgDq/+6fTWsfhNVDuN6+MXy9jy72gNwPXHXkdKAhpWM9QIa3fhwZHHkeH1dIbUioKchzmb6LkIFl+Ecqn51Iuv3t5qZ3Sxf1CrY3iDBj2YTf+V+S/e/0I/nXiMnyUyGR9duI1oTmORD5koWqnznTl1WJwrMMzvWnFFqBcU8uXqmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5802.namprd11.prod.outlook.com (2603:10b6:806:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Mon, 20 Oct
 2025 08:57:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:57:23 +0000
Date: Mon, 20 Oct 2025 09:57:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
CC: <honnappa.nagarahalli@arm.com>, <anatoly.burakov@intel.com>,
 <jerinj@marvell.com>, <radu.nicolau@intel.com>, <gakhil@marvell.com>,
 <cristian.dumitrescu@intel.com>, <ferruh.yigit@amd.com>,
 <konstantin.ananyev@huawei.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2] test/ring_perf: add optional cross L3 core selection
Message-ID: <aPX5bkbE-V43O_Tq@bricha3-mobl1.ger.corp.intel.com>
References: <https://patches.dpdk.org/project/dpdk/patch/20251017163407.845502-1-sivaprasad.tummala@amd.com>
 <20251018064831.1153059-1-sivaprasad.tummala@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251018064831.1153059-1-sivaprasad.tummala@amd.com>
X-ClientProxiedBy: DU6P191CA0065.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cb34f4-41dd-4bc2-4c4d-08de0fb6af65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1FrdUlTajFtMVNSL2tkUG01d2t3b21MczRzVUE0YW1HUDNCZ295TDJyUW1Z?=
 =?utf-8?B?MHBOaWZxQ2t1d2NiSURJYzl5VXVLT3NHZDN5Uml1NFVNcm0rUUg4THlnOGUy?=
 =?utf-8?B?WHp5Z3Npb0RSSDh3U2Z6eUV5bkVnWmFJUWxEOHdzVW8rc2U0bFpxWFNYSEtF?=
 =?utf-8?B?b2F2bHBoZEI0MXZoV3M0TGFLamEyLzYxV3l0bTVnUVdYTGNqVE0rNXgvMG56?=
 =?utf-8?B?Rk04c3JMSDVocnU4NCtXcit6Q2RMSnNBaDREem9xN0lFRUhheTRwL0JTZGRB?=
 =?utf-8?B?SEFRdjBlS3pjMGlHOUlyTy9RTTJXTmhwUlVyTFY0SDI3Z3Q0NGVTUG9XSjNZ?=
 =?utf-8?B?U0wxK2RnS1orZmZoNHZCZlN6cmVqekpzTUlkSEx1TUJ1MHZoUlFNWGVBWWE3?=
 =?utf-8?B?RTFVaXJhQk5WV0pnVDJQYktucFA5K3RBeTltYmk3dWl3QnlpcEJPaEtCVjR3?=
 =?utf-8?B?NzV5OWVJWnJIWGc4S21pZFhvR1BHazcyL2k2RWtkUHVvaytCTGNzb1JBK1E1?=
 =?utf-8?B?bjN6SE9RVHhsWi93RlF4cE9hZzhFZldFTnZ5TVplZjkycVBnaEhob3ByYmRG?=
 =?utf-8?B?NDA1NzB6RmNEOGI1aEhPTUk2dWpKc3UyVnArUmVaYlhrNEVQYW5qcjVZU3Ny?=
 =?utf-8?B?aTF3ZlQ2VmREbVdqcmhVYTFRUzlzWVpHN1FFc0RLSTczSjdNNlR0QVc3VUVj?=
 =?utf-8?B?SDdBYkxFYVB5WTlWMnFyanhlNFhzdEZmOUtzNkNaUytpKzllZE9SenZPREl0?=
 =?utf-8?B?VFlpeHJaR1VLdzQyc04rTWxSRlloSXhlaGptZWZKSmk4cXNKTlJRcFF4M21R?=
 =?utf-8?B?dHlsZ0lqM1dVRjlnMnNYL2VDSWNDVmF2RmVlU0VYRWQ3bVEybEgwYTlPYmZi?=
 =?utf-8?B?SjRrZmNLRzkramtUMll5dzdHeFJBdWR0UWtLOFI2UGcwRTQrellPN3Q3c1ds?=
 =?utf-8?B?MUJRYkFXandRNFUwQk1oM0FwNFlkNDg0WFd2UmlGMGd0RmtpbFpHTmRXa2lW?=
 =?utf-8?B?RThiWlhyaUtiWk9GcUlYakJoN0NIaXkwc1F3ckNFclZHcklpOWlmMk1oc1kx?=
 =?utf-8?B?aXFBc0FEWk9yRGVsVVdMSld1N3d2b0U2Rk5nWkFsZmdJaDlRVEM4TU9mdzBF?=
 =?utf-8?B?ZEtzbTFPN29TMU1ITzMvUDIzQWJSZ2dhbXFqZUJ0bnRuZjNrbHlyMERBTjV2?=
 =?utf-8?B?SUVXcU83TU1IeUI1ZG91dUtJQitjQU8yTG5yWGdqK0F5M1JJTVdpV1FOQ0w2?=
 =?utf-8?B?Ym5iVWdWMTRuK1RHWmdsQ3J0WkMrNDl0MGMySytIbzVsbjNaYVVMZVdYVUhD?=
 =?utf-8?B?VzVia3BVb0RkUmN4am9walZYQ1p5YTA1Rm9zTzQrWUhSUkVrWXlmWEx6cUJy?=
 =?utf-8?B?U0NoRG5zOTZxQlhIZm44NmFvZ05KMVVSbTQ2VnBtZ3QwQngvaXQvWmhUVFJh?=
 =?utf-8?B?N0JzMnEzOTU1VEw5QmpBMVcxWXUrMStDSWxrMmVtK1R4bXV6UVlvZnpDNzky?=
 =?utf-8?B?cHF1aWJ2VzkwVHQ2RHExTWptbEU0R2w1UmdGU2NjcjluMzFaV0kxZFV4VktB?=
 =?utf-8?B?RU9CSFQ2WnJKODhlMG1ybHNHY2ExcVFQak9wRWFNTGoxSWR6a3ZYM0pWSzZy?=
 =?utf-8?B?YytjaS9uS0ZPYWJ3RDVqOXZVWmszc2lJMXBId0xXSlpMVWZvakZUWURrc1Bi?=
 =?utf-8?B?MjlTM1c2Y0JySStFblYvNCsyTnNWTDBSY3hJVW9SdzVPQURiN2d6M1ZLb2sx?=
 =?utf-8?B?eUFFMDVwVEdvdnl4SlBXTFdaNGxjOWtBTHFsUmxzUVhvSXJhWVRKRzVTQnZi?=
 =?utf-8?B?eWU2VC91V0ZhWVhuZnd6b3lBM2pLQ1RPRWFLNXdRVnVEcjNOb0RLUnBGeHgy?=
 =?utf-8?B?YktmQ2xOM0ppS2huU0pYQVh3MXpneGlHd2xHMHNVWW5KS05JZ2dRK3ZjK2M1?=
 =?utf-8?Q?9PhB1HCVv/a+Xd7aXM3BDaKAr7LxJc9O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNEaENpSncwWjRIVXA2OXZLSnRTUG93M1NGZWNoT3VSQ0hEM250WmZMYXRU?=
 =?utf-8?B?TEE2NFk3ek9NL1dkYU5MQU94R294WGNEVXRtSFBSa29QNmE4NEFyZzVaaDVr?=
 =?utf-8?B?ckFCNGtzVitFV0MwZ25XbThEOWFvM0tKbUdaWkRSNWU5TzNKRXpDMlNBbTdS?=
 =?utf-8?B?SkFjeEZyaWNCMTBwSy92R1dHa1o1V0Z3WEtNblYzeTBqc25wc3lZSGhQNXNB?=
 =?utf-8?B?TllKRk5ySzBFNnhsd1JuMEM4WnhTazlONnp0TWRZQVBxZFRPbE9UVGM0cEJD?=
 =?utf-8?B?TGIvakl4SGhocW9manRKYWxJSnVMdFpnUEhyZTU2UUJyOWpDWEgxbklzR1Rz?=
 =?utf-8?B?c01odHVrL2ZmV3dQMis0bVV0alFCMlRHL0NKeU5yVWdrL2tjS3BQdU1iTlVC?=
 =?utf-8?B?K29sM1N6R0JQUUpIcmoxa2hiVkZHaytaWjVtank3S2dOeGtWVjRjeWdoOE84?=
 =?utf-8?B?R1RiWkd6Nk1lU0VMakh1akVJc2lMd0JoMnFSbERLWUNtVkdnMVhUV3hKYnpT?=
 =?utf-8?B?c0tPWWhFWTZzaUJlRzlwK3l2UWlCMkE2NjJMOU4wTm01b1JvdGhISkZISnYx?=
 =?utf-8?B?SXM0L1NXRFh2TEd1dWsvUVpHTlN2aXZsUTRQTldGd2MyVEN4RUJxd1hBN0RQ?=
 =?utf-8?B?RmZoQ3VQUmFhbGswamZEdWVuZUFDclRWbG5sVVhVUWN5VW1ERXdBdzkzTmd0?=
 =?utf-8?B?UjhtSGxBSE9idnRuMmh3WCt4empwSUh1bzRmMlV4TzdKcVNzdm9FWmExUXNs?=
 =?utf-8?B?dngyblNlR09BVmdLekZhQmx6djRxcmR2Z3lJUEoreFJaejBDNDU2LzhIT3Vn?=
 =?utf-8?B?WGJDZVd1OWpidWNHYlp2TTlKMGI5Um03MVRxeHowcnJ3WlUvNE8wTFZJOFpn?=
 =?utf-8?B?a0lRajcrWGhhSFVMVkVtNWlCOWdMNjRsVCtkMVMrT1VnYXRwZ0dXS1FvR3FZ?=
 =?utf-8?B?akcvOTkvRzlWNDhIZlN1RHlmQVJ6SlBwdTJJaUV0Q1NEaGV5WmxMZjRwMGxL?=
 =?utf-8?B?QVlqQ0VNWDVDWWJvT3cvM3ozaTMzNDRUV0ZDRmZPa1ZNUGtIUUlRYnJPd1lx?=
 =?utf-8?B?NnFTZjJOOS93cFVZV0YzS3NGK2tOVm1PTzM5VVRRRzJOT0tyL1VRRmNtZm1C?=
 =?utf-8?B?VEV2R2VXbzdncVpCYlpnRXpnSzVoSXpCNStDMjFRVmMrSjkvOEJ6MUpybnZX?=
 =?utf-8?B?Y2tuOWx3UHFEbldNS0NBOXhtNDRJNzR3MS83NFd3NldLYkFnNjZyNEJ2K0Fr?=
 =?utf-8?B?NjVJRXBtcEd2QjJxZ3ExZWUzTElJRERKZHI5RGhFTnVveHJ4K2l4amhOaENw?=
 =?utf-8?B?cFNmM01SSTFkdVdQUjNRdTRsL1JQQ0pMWm9KcVFMNVFSUFlMVEJsS1puNHRS?=
 =?utf-8?B?b0tVRTNrMWozS3UrRlJmOUkzem91dzJKYk91eXc2MEdvL2h3bzIrZVhna1Va?=
 =?utf-8?B?aWlUV0ZzakZURkU5R0Y5eUhqbXMzenRBUDRzbVd3VTd1cXRzUU9jMHlMaGxt?=
 =?utf-8?B?OWVVeEFtaloyQXIyQjRZTU10enlHcCs4S0VSQWhseVFNcnZ5M2REREwvV3hi?=
 =?utf-8?B?NlFjNE5DZUdhdEJIQ1RYbTdoSWhJQWdzaW9lUFR5RmU5dGgrc0MwdE02R1pz?=
 =?utf-8?B?T2c5Wjl5OUNDZ3FmZldkZXFrZ1BrdUZIaHVMbFloaU9zTHgxQkxhWXBrYnMx?=
 =?utf-8?B?REpOdkhxWkw2UlFVZXRmMnU5a04vV1ZpN01lRjRJYUJ0bEk0OUZBc1pvV0My?=
 =?utf-8?B?MFgxSjVabm9LRkRtbElCUDZwbHV1TTU1R0UrcFFEVnJjWGJkUkZNYWYyd0dN?=
 =?utf-8?B?WUd2NmtOMy92Znc3NzloVm4rcXNiS2l2UTFCVzVMUlhYS2d0WFNqS3NrQlJp?=
 =?utf-8?B?UVhla2lDRFhMYkFoZVFueFNvT25lVmw5UXIreDVHRjc0eVYrL3MvQ2VhcWpk?=
 =?utf-8?B?T0NnOUMvdVdxdE1naEpvazMrVUNid1gyNVcxU2xiNysyTEtpNlNnWWR3Z2N1?=
 =?utf-8?B?K2lwOUVjNGZsNjd1VVI0d3FCZWdhSVI0SW95djRid1pBRHQrcGZ0RXd5VGJ4?=
 =?utf-8?B?ck5pZUpPUXNPWXNhRHhrVkx1elcrdEFPWFBtMVF6RlJrZU8zQ3NmNUxhU1FU?=
 =?utf-8?B?NEMyaFQwSG1aUllkbEV5cDhQYWJRazBXdEFnbkd2bHFrUkpIMDJzRld1amRW?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cb34f4-41dd-4bc2-4c4d-08de0fb6af65
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:57:23.6514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es1eElcJ4fK2szALm6ETZowF71cjV+KAWebVMGqplA8EO+JTtGp8LI75Wz5ROesaxNsUhUcBEnp8K0CxabYXHAVm1/JTqoruKYvWM/7m3Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5802
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

On Sat, Oct 18, 2025 at 06:48:27AM +0000, Sivaprasad Tummala wrote:
> Enhances test_ring_perf to optionally select two cores on
> the same socket but on different L3 caches using hwloc.
> 
> This allows performance characterization of ring library
> on processors with split L3 cache architectures, providing
> more realistic measurements of inter-core communication
> and cache effects.
> 
> The feature is conditional on hwloc being present, ensuring
> builds succeed on systems without hwloc.
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> 
> v2:
> * Localized hwloc dependency to test app only.
> * Optimized get_two_l3caches() by moving socket and L3 cache ID
>   retrieval to the outer loop.
> ---
>  app/meson.build           |  8 ++++-
>  app/test/test_ring_perf.c | 76 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/app/meson.build b/app/meson.build
> index 1798db3ae4..5443043f0c 100644
> --- a/app/meson.build
> +++ b/app/meson.build
> @@ -46,6 +46,12 @@ if get_option('default_library') == 'static' and not is_windows
>      default_ldflags += ['-Wl,--export-dynamic']
>  endif
>  
> +hwloc_dep = dependency('hwloc', required : false)
> +if hwloc_dep.found()
> +  default_cflags += ['-DHAVE_HWLOC=1']
> +  message('hwloc found — enabling L3 cache–aware topology support')
> +endif
> +
>  foreach app:apps
>      name = app
>      build = true
> @@ -60,7 +66,7 @@ foreach app:apps
>  
>      # use "deps" for internal DPDK dependencies, and "ext_deps" for
>      # external package/library requirements
> -    ext_deps = []
> +    ext_deps = [hwloc_dep]
>      deps = []
>  
>      if not enable_apps.contains(app)

I still think we can limit this more. No need, for example, for test-pmd or
test-cmdline, for that matter, to depend on hwloc. Therefore, I'd suggest
moving the dependency code to app/test/meson.build and adding it there.

/Bruce

