Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD99C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 17:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C23AF400D6;
	Fri, 14 Mar 2025 18:52:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2433D400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 18:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741974739; x=1773510739;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=5s4ijKg6DSzI6TYwyedsTHyfUwnlVLN739MVdoOElvs=;
 b=BFwokRcYZ6QdUPECHxU7ejgQZFk5TNsqOZpVRJ57gcHGbKFSNwfb3fYT
 17EnLJLrKiMlkswCVo+W7YDs8zNN9uFvzrCFkFSQghN2GyYzQj/j/I5gQ
 2jGAbV9VaZ3mGT3iHlC4eAbR86ktb0zoaC/lZWf376QGUIIP+YlJG3x84
 vP3NdGY0ZuAOcgvbN50NlwNx2IE1j9tsQqObyhlAqfmRVCK3XDLBdCLSn
 vrMi6cF7SyE5UIV6pSL38eMY6YDwr80mYJtcT5Ded33vRgQQI5M/kF7lG
 ZhvpI0o3J5iNuBWOw3nxsUklnlNgcT3RRIxsJl6zgRoUQK1pGVMhtabJg g==;
X-CSE-ConnectionGUID: w931ywYTRFmIAI0ZUjZOqQ==
X-CSE-MsgGUID: mjvRBpYzS32gKp7GJ2fJ8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="46926627"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="46926627"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 10:52:17 -0700
X-CSE-ConnectionGUID: Lc/p8ofqSiy/zu2ForLIzw==
X-CSE-MsgGUID: n+EdmTHNQheu4OpTocRerw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="125981776"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Mar 2025 10:52:15 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 10:52:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Mar 2025 10:52:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 10:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzYfHY7wn1r4Uycukpn65N9P73ZICAXaifndhVjPFY+STxMm8O+MfSvjnyUMj0nHAvwtRh/yP+BWT7VutgdzmcxSwzk0IxobT8pqzUQhXgJk9aCEiSDMuUvCRPpsW/mijYpHiRmkhaSdBwyKHJJ895X0aJsHiD1LtkZXkgyc0HxxgEW3Vlvn/yeZoomsyWiw4zORxelt6GTn/3AIDyhgeMtDpyPKwaPcPA7FQlLphy4dW6Rb07wBQbjLQXENOFv7chPff5rYKlpeSQ86d1JgSOj0NAn3YRKzXBibV8xLC2oQYj0lKu557jm5D/xcojugVLjJto3TeCWuEsg6njh7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxf165YTAXfTzxg8YJCOX+xb0BLtLKADHVdXI5QN8+M=;
 b=hsRtt6U1I3pStQo6MA6+SY/yOQD0e07TqVmVWsEcyhX0rn7IKnWSee/KRO5/IdMobM5NB7M3/SO+95His8J2eVYdr9/28ZUukXclsxqJ3COQWdog+ga/AWusIyoB/lCDx1q0tL3+ZIsNlzdzS2HfQHeBDPuZjR9Ta906ywWJil11bIutZF8X7WodGaN2tQG26NDsCO2JQ31dd+wagTHKs6zOS0Z8LpH0zym86CuCSzpd5nQBcPBZsWUvouwr/sKNz3wbklY2dgqWxhIDEJLpZv8p8iCupVOxnV2z47Os90TS/QtURAmCxGM/ooeZLg4/WPMQsCgMrQZSuU29fl6x/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 17:51:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 17:51:52 +0000
Date: Fri, 14 Mar 2025 17:51:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <andremue@linux.microsoft.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>, Parav Pandit <parav@nvidia.com>, 
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, "Nikhil
 Agarwal" <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>, "Chenbo
 Xia" <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Anoob Joseph <anoobj@marvell.com>, Andrew Boyer
 <andrew.boyer@amd.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav
 Ovsiienko <viacheslavo@nvidia.com>, "Bing Zhao" <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Liron Himi <lironh@marvell.com>, Chaoyong He
 <chaoyong.he@corigine.com>, "Nagadheeraj Rottela" <rnagadheeraj@marvell.com>, 
 Srikanth Jampala <jsrikanth@marvell.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ankur Dwivedi <adwivedi@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, "Gagandeep Singh" <g.singh@nxp.com>, 
 Kai Ji <kai.ji@intel.com>, Vamsi Attunuru <vattunuru@marvell.com>, Pavan
 Nikhilesh <pbhagavatula@marvell.com>, "Shijith Thotton"
 <sthotton@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>, Ashwin
 Sekhar T K <asekhar@marvell.com>, Igor Russkikh <irusskikh@marvell.com>, Ajit
 Khaparde <ajit.khaparde@broadcom.com>, "Somnath Kotur"
 <somnath.kotur@broadcom.com>, Chas Williams <chas3@att.com>, "Min Hu
 (Connor)" <humin29@huawei.com>, Ian Stokes <ian.stokes@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>, "Praveen
 Shetty" <praveen.shetty@intel.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, David Hunt <david.hunt@intel.com>, "Sivaprasad
 Tummala" <sivaprasad.tummala@amd.com>, Akhil Goyal <gakhil@marvell.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Fan Zhang
 <fanzhang.oss@gmail.com>, Ashish Gupta <ashish.gupta@marvell.com>, Mattias
 =?iso-8859-1?Q?R=F6nnblom?= <mattias.ronnblom@ericsson.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Jerin Jacob
 <jerinj@marvell.com>, Harry van Haaren <harry.van.haaren@intel.com>, Min Zhou
 <zhoumin@loongson.cn>, David Christensen <drc@linux.ibm.com>, "Stanislaw
 Kardach" <stanislaw.kardach@gmail.com>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>, Byron Marohn <byron.marohn@intel.com>, "Yipeng
 Wang" <yipeng1.wang@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>, Amit Prakash Shukla
 <amitprakashs@marvell.com>, Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>, Elena Agostini
 <eagostini@nvidia.com>, Zhirun Yan <yanzhirun_163@163.com>, Jiayu Hu
 <hujiayu.hu@foxmail.com>, Sameh Gobriel <sameh.gobriel@intel.com>, "Reshma
 Pattan" <reshma.pattan@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>, Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, Gaetan Rivet <grive@u256.net>,
 Volodymyr Fialko <vfialko@marvell.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
Subject: Re: [RFC v3 6/8] build: mark exported symbols
Message-ID: <Z9RsqQAIkGHDnoFb@bricha3-mobl1.ger.corp.intel.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-7-david.marchand@redhat.com>
 <Z9MWQR_o3m4T_rFt@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8w0MPV7XQpMyiGTsSVDGuW1LctGyrXZ6n52O7AYzij7Zw@mail.gmail.com>
 <Z9RYCXF6Ag23k8Uy@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zsgxW7goppOjNariu_oA+ET5HeNTOeepDSHsE31KmkNA@mail.gmail.com>
 <Z9RnNPIKpBD5Oz0Y@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wrmuhn-nsiDc+RrCqth13hjyrubhqcZK17mqpDaDVuWw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8wrmuhn-nsiDc+RrCqth13hjyrubhqcZK17mqpDaDVuWw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0202.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9c3b06-0770-45d6-f6b8-08dd6320e709
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVVNMnNCWTVid2RVaHVVM2ZrTjEwTWQ3SWNyQnovL3lLaFJtVXF5OTV0TjQr?=
 =?utf-8?B?eTF6MVFCNk5LN3pDdnhMRVJ3dkFnRjhXaFNJRmRFQVBmZnRWM0dtVzA5MUdq?=
 =?utf-8?B?cHY3eXJPeFNrcGtPc2REOTl2RDRMdkk1ZFRwbWJRSzVsV0FDSEQwWlNlTlhu?=
 =?utf-8?B?S0tpU1VaQ05EekJDSjc3NG1oTDI4azkvSy9HZDZRVGI5MElXaXhXVDlqWkl5?=
 =?utf-8?B?cmQ3dlY2Wi9uZGhLMnlVYmNIY3FmZVAxRVZ2SlpkcEY4ekhRUEVFQWFhRkNy?=
 =?utf-8?B?RVV5Q2NTY1lVQk0rNk5mZXRlWFdncU5ldmtPQWl6Q1BDU0JBS09KM3lGMHk2?=
 =?utf-8?B?NmFHemxLZHdwNkR5bEJpTWpscU5QZzI0dVJ1bTlxM0dJR0kvcmFzaG1xaXZP?=
 =?utf-8?B?dEZQTXY2R3FyUlIvSi80UTQ5NUp0ODcwUE9tOHl3TFdxdThIekFkUUErc3Fo?=
 =?utf-8?B?MTVpeFlmZkZvU1JzZDJZbU1CcjQvMXg3MVR3MGxhUHpveHBSekpxM2UxSkhl?=
 =?utf-8?B?NE1OTGFPQUM5K01oY0dIWklZeXZnZmQ5ekhGL1VxQWpIM05nc0hQOU1pVW1T?=
 =?utf-8?B?NEdKQ3VZRWNIYXhOQ1EzUFlFa2lyUTRUYXhoVGZlVWYzRTRaY2E0elphVzBC?=
 =?utf-8?B?UmdzZG50a0pYa1l2OTZSZWhzRXZaTDMydnVyMFBvdlA4UEF6N2JLVzlqUW41?=
 =?utf-8?B?dE50NzBubjhlMENScGI2dkJFTStWU1c2TE95SnVTdllCbGlaNVpGUGpLUGtL?=
 =?utf-8?B?OHFld0Nyb2R4d05LN3BFdVIxV25BVDlIL3NONy9nUDErQU81MDlwbWNDei92?=
 =?utf-8?B?Y2EwOGgwaEFyRGszaDdLVHg1M3BOWUZ0SWVHN05TR1QvOEFNa2RTRnhQaGw5?=
 =?utf-8?B?RjlENm9vd2RyR05lakdETi9BRFRpV21hbXg0WGFlRFJ3NmFOazNGb1lpNEZR?=
 =?utf-8?B?ekxwNkZBbVhmMmxZSVB4ZDhDTS9rd1RVM2V4V25HSTJRaVBkSTR1aDhmS3RE?=
 =?utf-8?B?UWZWNnkrU0dnRlZQSHdqWVRwdkdxTWF3SWVsYXZ1UVJpRStMSFJwVUhjNTBn?=
 =?utf-8?B?WTRTSUJ1S1B0eHovb0pBOVl2cUZZOGlEU0tUVmJua25GSU8wZ21pcmR4NFp3?=
 =?utf-8?B?Ni9Kb2NKaXhVaHlFTkt1RndrRklOU0I5eHNkZ0hSY0xQaEpLQ25xckZNenhP?=
 =?utf-8?B?emppNXhVZzJKV1hzM2VRcTlrbUl6cTQ3M0dablEzd1lESnRNMDlveWthRSt4?=
 =?utf-8?B?cUJHa0R1R0F5Q0Jta241M1laR3d0eXhrdG1RdWIrTWpFdlJDZ1pyRFo0RVFY?=
 =?utf-8?B?N29FYVZycncydG4yL2dKQ1VObjB2NUV5YVdWUmYwRmpVb0dQbnFxNE1MbVNI?=
 =?utf-8?B?WFBJZUhMQ3R6YjNnQXNPV1F4SEE4YWxLQmRwYVlIcjBLbXUramVtS01mSGtv?=
 =?utf-8?B?RmllUFgxZXdGZlRpWm5SQXREN2c2MGZxeVkxc1l0S0dFd0pBVUlJazN2ZEth?=
 =?utf-8?B?SXNvWVBpNW1lQ3NPd1JPMzJJU1pVSzhKbldtV2dWY1hoWXJpaTZVMjZ5eHZ0?=
 =?utf-8?B?T21ReEw5bngvbVErb3J1cW1QYVFJYVhDNzYrRXdjQWFZQnovT0ViRVZBWnAz?=
 =?utf-8?B?NUwzZFFoeUdvRjZ5Wk1YVmEwMEsreEhBQzVUWEh4VUw1QlBTK0ZDZEthM3NF?=
 =?utf-8?B?M3RPaGR1dmlwVTlnclM2NGppUHRUcHR6ZkVTMHZKM0p0NGxpT3NIaVR1MFR1?=
 =?utf-8?B?RlAzTTdwRnBaQXVhUGlLY2JuVnZqTGJCeGR5WHZtMVhod2lvL1VvNzEvbUdi?=
 =?utf-8?B?eTUrVnhMNm9zSFd3ZlZPSm5YT0x2MTBzaUdnTzJ0Z3ZTMlZQbnlsT2JCeU5F?=
 =?utf-8?Q?XnDigCmRXU8Es?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHFXYzdwamcrY09HRDdMVHRtNUxobnlucmVibzFCU09kc2t4Zy9wb015UndV?=
 =?utf-8?B?SCtOaWJJTmlDUDd6ejVpeWR5ZTRjRjJ2NmVSSTFFRjJNS3g4MENlZENrMGFx?=
 =?utf-8?B?MFg1TWFWQnArTkw3YmlZdC9XdU9UenJybjQxekJjSkg3a0RKUkI0RWU4NzBs?=
 =?utf-8?B?NHRudXZXOE5lUlZjK2hvVkdWMzBySE9DTXlQLysrUW1jeDZ0WmhSN1czMHpS?=
 =?utf-8?B?VDNuS2xZVTZxYmRhcXNBWXpuSDhLc3hscXdSVzMvQUMrMEN1TWJ6TE1wMzZh?=
 =?utf-8?B?ZEVrVEpNaVZRZ2pPclIxMDlldHhnMWlmcTZUYmlhMVBncG5hRUVFeXF1UGw3?=
 =?utf-8?B?OG1VTmV3eDVRWE1uVGdUQzRJcU1wV2JUVmE0NWZnZ1RCVGhHeGVNT3ViQ2N6?=
 =?utf-8?B?TnhDT1J0UkNnTVRsS3VPNVR0OFk0Nm1pRGhjQUZ3VEwrUkZtV1hRbzZUbjIx?=
 =?utf-8?B?amNQQUlIMnlxUThqNUNTRDV4eWRDU2NOTm1zdEMvbXd6Q3lQNzRRUlJ1NVg1?=
 =?utf-8?B?WjlsbUkvZEp6VUdpSVhxSlZUODZKNVV6THZnem95Y2tSMkJocEdIU1ZmVnVr?=
 =?utf-8?B?cEhmRE1rUGdOdXphRU12NWVDZXpDWlI3bTZyWFZ0clpCWmNmRm9YMlYwMVVv?=
 =?utf-8?B?ZHk1ZkhaWWJSREtyWWhlaEVlVUVTTmszb0RjdVA4N0VGUHM3KzEvTDBkZmpr?=
 =?utf-8?B?ZmYxc3ZZV3FuMkdXSWJVTlo1TWttWTBoVG5CdjdpNzFDZE11ODlzV3ZCT2J6?=
 =?utf-8?B?SU5mQyt2U3F2RStiMFhUb3l6dENWVTFhRzFXMS9KcUtRMkZOL1M4SHNpdkZD?=
 =?utf-8?B?cnNsSFdPUU1FYkdBME5ycFdQYTdhUERhVThWTWhrUHNqR3pKSW9LQy9FdzdF?=
 =?utf-8?B?OVFEZFBvdCt5MWswcVlUWWVQV0pmaXlWejIreDdPNEZ4UFdUY0ZYRDIvYS9W?=
 =?utf-8?B?eDdoQVpGbFNEalFVWnFaOE45ZUxRS1dFbHAwNGpNaHNHdnYrN3JRRWhEdkFt?=
 =?utf-8?B?aVN6SXpxQTRnTUtjRjN1NXJrNUV5VXA2TkVkR3VQTFFmMFN0RjZmYUE3dnNO?=
 =?utf-8?B?UWxUN0J2ci8vMEt1ZGJGU2VjUWYzS1J0YjEvV09ZaCtibFhrQ2kzK3Q0YlZ2?=
 =?utf-8?B?R0ZtVEhPWjNIVC9INXZuZGl4dnVvSmhkNCs4bk1NWkFzd3A1Z0kyZkxudjBt?=
 =?utf-8?B?RDV2NjBVSWxLVS9nTUFZcHkxR3RreEo4UmlZRnRzSE4yWi9sdWlLYnEzSXlW?=
 =?utf-8?B?QlJjeWtPZCtxUlNaSlU1dTZzSUxEc2hSRzBrZ3ZPMkhoRzhTRXFpZDZUMTVG?=
 =?utf-8?B?cXB5cWt5ZHJlc0VjdFdIb0lBSHpSNHEyNVNrUEQ1c2RoQ2liYnYzclFaY1hY?=
 =?utf-8?B?UGhjSEEwcUZiSytKMG1QY1ZxVkxBR0xHeVN6NkFrSlhVYkVhazUzZ0VncXB2?=
 =?utf-8?B?NTJiM2lPLy9remU2M2xRUUhQb2VuNm1DbTlMTHluMlZMNDhvRmQySk9zOVJq?=
 =?utf-8?B?d0U1aFd5eXJ5VlNLdXZDbFdaS1NmNE52MWs3TlZLdkN0OTNBN2JsWXdxNThm?=
 =?utf-8?B?ZURJWUk0WnQyNE4wZmFzSHFuanIvZWd4MjByWitwTUxKOVo0SGpieG9QTGZO?=
 =?utf-8?B?cmFwdHR2VkIyYk54S3JZbkllMFZwYW9rVWdQUTMxbEtuU2x4QUs1Nk5QNjRB?=
 =?utf-8?B?K3hKa3RhQlRMR1VFRTJMTXgzd2RUYm04SW96SHVEWWkzRXhQbG9WZXdsa09B?=
 =?utf-8?B?Z3pzYmdxb0RqZ29VNjlFbnYxZkZObHVWUG5zZW5ka1ZCSHVaczB5dHROQ0FS?=
 =?utf-8?B?N0tpdEl2Q0xwUXhUSWsvRmZuWThTcTVnSzNIN3RIbGlSN3NvajBrbnFkRDA5?=
 =?utf-8?B?UElyNHIvOGpUb1pvYlBUM3VLVUswZFZoSmhVNThjSCtYOVlmZUlxNThLenc2?=
 =?utf-8?B?cHVhcWxKakl5a3ZzTmVTR0V0aHBOMTI4TDdWT0xiSjhpdW1PeVhqOXBKWFcx?=
 =?utf-8?B?b3BzTHNIS2QzclZRdzZ6WXZWVm1ETkRpZHdpS3dqT0loTG1ucFFXQTdEMUlU?=
 =?utf-8?B?dmRXSHM0ZmpTVTZieFpmbFp2Q3lDeUtjZDRXR205UWV6K0hmL05MbGp2Y0U1?=
 =?utf-8?B?ZkFveHZvSVNteHE0SXllM3ZKOHpFbHI0NkFmeTZCTy9QWlNNNHNpcFh4S3BD?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9c3b06-0770-45d6-f6b8-08dd6320e709
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 17:51:52.6101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3bJQVi2JQLALlBXim72AQx7fBzgoH2g5ghSRrANdr7zVaebvKvivce5RTSu8rJXvQADj4/DPywAg91QKD7PK2m6444qDOTuzKfItdEYzOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
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

On Fri, Mar 14, 2025 at 06:39:54PM +0100, David Marchand wrote:
> On Fri, Mar 14, 2025 at 6:29 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > > > What I'd actually like more, but never have had time to actually try out is
> > > > to generalise the instruction-set-specific build stuff into the higher level
> > > > drivers/meson.build code. After all, much of the code for doing so is just
> > > > duplicated - check for AVX512 or AVX2 and if present build these files with
> > > > the extra flags for that instruction set.
> > > >
> > > > Something similar with the base code. Most base code builds follow pretty
> > > > much the exact same routine.
> > >
> > > Having those separate libraries require special cases every time, so
> > > yes, it would be great if those could be factored in some shared
> > > mechanism in drivers/meson.build.
> > >
> > > Putting the AVX stuff aside, and back to why we need those separate
> > > libraries for base drivers... I think the main use is to waive some
> > > build warnings, is there something else?
> > > If so.. I think some drivers could already be cleaned (like net/e1000,
> > > net/ngbe, net/octeontx, net/thunderx, net/txgbe, raw/ifpga at a first
> > > glance).

Great. The question is whether that will always be true for those drivers.
Even with those cleaned, we'll still need common base code handling, and
with that done, it might as well be used for all base directories, not just
a few.

> > >
> > > The AVX stuff seems a bit more complex, as there are multiple combinations...
> > >
> >
> > First attempt seems to go surprisingly smoothly[1]. It still builds, which is
> > a start, though obviously some testing will be needed to check nothing else
> > is broken.
> 
> If it builds.. what more to ask for? :-)
> 
> > It really helped that most code just seemed to have been copy-pasted around
> > the place.
> 
> I had a quick look, it lgtm on the principle.
> 
> Could this be applied to lib/ ? (I see some complications with AVX512
> special instructions in lib/net..).
> 
It hopefully can. I suspect there may be more complications in doing so,
though. I notice a few libraries use instruction sets beyond the initial
ones enabled in march=skylake-avx512, so it's not a common baseline we can
easily switch to. I'll try and look at it if I get a chance.

/Bruce
