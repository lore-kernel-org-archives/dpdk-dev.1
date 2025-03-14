Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787ECC35FF1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 17:29:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F91040263;
	Fri, 14 Mar 2025 18:29:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 674A5400D6
 for <dev@dpdk.org>; Fri, 14 Mar 2025 18:28:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741973340; x=1773509340;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=r+CVguoLzvioG+RJvLY5KKJ1Zm3kqHxg5PoaJZ32jrg=;
 b=lUsMzxzdezYYZ/R0TI4C17dPJLwSWWeXxAPBHFhpHdvAEP2a0v+BGWW+
 pIiDwTyBA3P0HJnu+CT1KTLvrR+LSuYICYS39UDC7DRuh5um5GKVHEM10
 2Nrinb5n8Zx2gr/draeDmghw7XdVL6D+6R9aalgBDYdebp3jxYC3wSPlR
 9QDNfFdn2Bj7G79s8z3q4dxd/Zhh0ZvKL2Nsa78rvBBLbjd7N1i5Msph1
 gJDl18U51gZDBoqWboV9gzLQIB7GqEn22gvp9Fiw3O/+0owj8H4VJ4Wff
 ZY8lp3+pLbt16z+5+55PKJJ4zmmgCLJ0v3GBLhLawo1rjJGfH4DwHW8Xd g==;
X-CSE-ConnectionGUID: 8g5WIueWTFWmd89zHaKSag==
X-CSE-MsgGUID: 64lsCchFSRaKHq/17/YPRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="53341965"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="53341965"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 10:28:59 -0700
X-CSE-ConnectionGUID: TrJ1rOO5TKWNMiyExtwCpw==
X-CSE-MsgGUID: fk8J7aWYQ1atxt6T431T9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="121062476"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Mar 2025 10:28:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 10:28:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 10:28:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 10:28:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrUGK/2ntQ7eZXUrZ+gET1aNUnr5Wun+HCuqzF/gXQe+0gsQnzFhPrdy+PPcPpMFh70rYlyDXYsrsrN4dJaO2xNfd/7RNt5MEf2frwEEIuC6noEQD64iR+o4MBmprVDFuXcYm8X7slJ85hFiqDpPMzD6/H3XueW/5ek3NlNoVbrO3ksiepgdzhYl1/M3epl7X+lKvLv0jMQyT3ZdYkFp2Y+Kb326l0OA6ywRSVkHXDPUp+Fvld1o/D0RUh5KtI2+gmfbkgEFh6TA2Gn08h3+FD8fUxFwQvT6Mp1WOEU09DEE6v4wLkw4Ra1Nc4RCRibTQWLHR+LGxphMCw8JSCGTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZurDFnmPgwEBUrKcDkWv/rdyH+IWRzdUF6CUSAaf70=;
 b=ylqqM0ubZK8skZKtw/Us7XWNNpiURCTkJ01tK0IYVI4VALm/HdpbzvU6P+iZW4L+oZKM4rNXS0TAKOtWNMx8zI5TrvI2nh6vrgbmp/kZnVhGsqW/1IbCpfB3nDNOd484aaa4/nqkb/vUlAzMOzRjZ5i4swXuEhEUJBrRhB0ju8DNhX7clN+lpYlHF0q4PnW7JGFyUVP+WH6a8Vhr3/vPq3e5a+UxvTXnNhFaQLWDChS1HURdNJ6hhPX4w9w0VcAJlE+pz6xoa8FxzUxcwS4YZNPYvztwqpOLDiRSQZPhW/1VcVwR81OmONCPcE+bxQFfCzlfadsAUHnoXfJW0xljjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7518.namprd11.prod.outlook.com (2603:10b6:a03:4c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 17:28:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 17:28:37 +0000
Date: Fri, 14 Mar 2025 17:28:20 +0000
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
Message-ID: <Z9RnNPIKpBD5Oz0Y@bricha3-mobl1.ger.corp.intel.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-7-david.marchand@redhat.com>
 <Z9MWQR_o3m4T_rFt@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8w0MPV7XQpMyiGTsSVDGuW1LctGyrXZ6n52O7AYzij7Zw@mail.gmail.com>
 <Z9RYCXF6Ag23k8Uy@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zsgxW7goppOjNariu_oA+ET5HeNTOeepDSHsE31KmkNA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zsgxW7goppOjNariu_oA+ET5HeNTOeepDSHsE31KmkNA@mail.gmail.com>
X-ClientProxiedBy: DB9PR06CA0004.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ef8a1a-0ff0-4480-b4e7-08dd631da782
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmM5ZklEQWNXR1k1Mmc3QnZFWmFFV0d0YjJGN3lKOWVLL2ZmUnViRi9GM2Y4?=
 =?utf-8?B?VzlMTXd3eVZtNHVyRGpSdzE5R0ZQUXNLQTNxaEF5SUpwcWl1a0k4LzNTN0cv?=
 =?utf-8?B?alc1aStJR3VYM0NqZzZ2MFVWaEkvWlQ1TzJnbDhZYnZDaUZzSDVzeHF0Y1dp?=
 =?utf-8?B?Z1Q2OTRBTUFyb2VkQVY2eVRqT2ZGdjl0dlpneWZERG1lNlFqVXREWVZIUkE5?=
 =?utf-8?B?c2R0Z3pPTXdNMTd0cFpuWEhCMDVVN0grSzNsTldHT2xETTBFTW54VUF6WGhF?=
 =?utf-8?B?Zm5LMjBpeWxnNTlScXFpb0YrUGludUZPMG0rYjViQUdlRXlMUUVWSnNQSE1E?=
 =?utf-8?B?T0RwN0ZTRHJxbi9vNnovNlhOMExTZG9sL3RHWlFka1lySVdtWGZEODQxeDZm?=
 =?utf-8?B?c1FiTVJmVTRZbkJiSU5CeVZKMkFiODJ4YmkxaTVqR2JjVmtPQVdVMVpNMjFm?=
 =?utf-8?B?Rm1wL0puRU55OWs3QTFBblp6enNjdndVM3NhM2hQZW5hMG16bUJPYUVMSGIv?=
 =?utf-8?B?VFRET1RndUtmSkxGR0dPVTBmSWNWejd5VTVwdG5ueW5SVGJsOS9MajhSWmpY?=
 =?utf-8?B?bWxpS2VvS3BPaU1Zcjh0YXRTb2pqM2JnUU5NdUhoajRPZDBKb29QR0M1SHIv?=
 =?utf-8?B?cm0wY1JMaHV6QW5ucTNGSVZKMlpySXBtaG5NRCtuMm4wL0RzanBGaEhKaVMx?=
 =?utf-8?B?Q1FUeW8zODFRaldFNnpVTnZUdTdZeDlXRS9vNkRyaHJyRlVoOEg2VUNwa093?=
 =?utf-8?B?N0NwWFo4cEhKMUtFQ3FFUG5udzkreFJMV09DcXcvY2FUZWh0VGFna2pRTStM?=
 =?utf-8?B?c3IxbWJDcnZIcjl1YTEzcjBkdno4MCt1L200WDgvVlZXN2RJWnJuY2VJQjZq?=
 =?utf-8?B?MkZoaWR4Mzh3TFdUUHlQYUx2TnZldFNsWGtDdC9XN2lUYTlVTkhscDJiYmtr?=
 =?utf-8?B?bzRoNmdUWHRLSC9ZUnpuMWFFaWpCNzVWU2ZDQ3g5VjBKOHM1bmh4amN5VjZK?=
 =?utf-8?B?YVZGcHV4SEdZejl3NDRMbHlSNGg0U05WQnNPbklmMlArOW9TVE9wQ1BXcDNL?=
 =?utf-8?B?K0lpYWwxV2ljM21wVDl4VEdURnRZdFl6c01tRnN6Z0pVdlQvcG5EdTRiaGdW?=
 =?utf-8?B?RUlGN0JMV0l4VS9JZE05dlpWNGVadjVXQlRENGd0NEtjL1libXY5Q1JYNjhr?=
 =?utf-8?B?ZDQ4aWZuNU1oYVdRWE0yaThWdTBYdVM5T3R6bUNocStob3BGSE8yYWZOOHZ4?=
 =?utf-8?B?WU16bGR4eUhBOVJYMDI5czVveVYwaG1tM29zN0pVcm5lMjVzYzV5azR6aDFG?=
 =?utf-8?B?bmtwM2ozT01NUFRZVHBCUmJGejU5UHpNRUF0WEdWMWFHN3M4b2s2blpyNE8w?=
 =?utf-8?B?WWwzaEF3dTUwRVhkRk80Q241V3M4WUI4bHBiZzlOdHpKdzhQQktLMENEcHpI?=
 =?utf-8?B?NDh2YmJjdXdkd1VLdGlSRVRIN2tveENsakN4M3M2Tmw4VTZ4VkdmYlZhbmpo?=
 =?utf-8?B?cUFnMEJqN2x1ZUppTHZjSkZsNUV1WTNORGUvUlFVVmphM2VYRXNMeXJ3c2Z3?=
 =?utf-8?B?SDRmZThuYWtQOWhyWENYSG81bkQxenZWMXlkbkZiTkhxWjZaM1NLVDNBNnEw?=
 =?utf-8?B?a2tMNktmMzlxZGVXc3BMOGFXWkgyQSswK2JtQzJEdEVhbEhXVmhuZUYxcjJG?=
 =?utf-8?B?aHJRN2wzeUhaT01EeEdaZHVwcWgwTEpjeitKdjB5VWFqVVNXcmg5MVZKR3hk?=
 =?utf-8?B?dU03enl5a3VVbDJPZVJ4dktoSE5vQjRyWmwzbnVYeVNNY00waUhCMHYxcDNm?=
 =?utf-8?B?aERLK0FqbVlRMHNKRUV4dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUpQYzRPakQ5TUFpTTNsSFBRYlJBRUpRdm5LeTVwNFRmR0xuVlhSTzNETmVr?=
 =?utf-8?B?RklIMDVZWG1aMUJpUnZIT0tjR2NiS1h6c3ZUakJXamV5aDFLbDQyc0Q0dEE1?=
 =?utf-8?B?SzVDTTllU3RmNHQ2WGZJTWRFL2hWUmlhczFjWkRxTHVnYVhMNDJJcVNlNk5p?=
 =?utf-8?B?dlpwMlRjQ0Y4UDdwd2h0WkFPZkZ2QlpXUnNpekQ4eWdYc1RCOVlhMkJaQTRV?=
 =?utf-8?B?OU1rYlhPQ09WQzlxTGhpOEpzWHkrWHloenNvTlB2ZHRqSk5BKzAzVEZKbU41?=
 =?utf-8?B?M0prOGpzdUlOU1hmWG1KK1FDazYyeVQweWxpSXBNMW80a3R3MXdUcHhmaWts?=
 =?utf-8?B?NSswUVpUUVBDVDl2REg3YytTY2dCUjVsSFdYOFEydGtlQ01KOXBQU252cTh5?=
 =?utf-8?B?aVlGVlI5Q0VubWVORldyd3BpaVYxOGZmZWVQd0x1UC9PRmNVMEdWanE2emdy?=
 =?utf-8?B?ZnJDem9QVjd5VTBicnhhQWdTQmJWcExKWVgzTU91b3ExYmJrU0V5VDhuTnhl?=
 =?utf-8?B?QW9IRmJNaElPSkJNLzRZbnUrY0w2cmh2N3VXdHZpcFFxNGxnSE5rVWI1MENj?=
 =?utf-8?B?UzNFYUtRSkw4cDM0NWNxSVN0TVNsVFo4S3FhKzF0NE5jSXQydE8rNTJrbUR2?=
 =?utf-8?B?c2NPWk9kOFV1aDltMkZBRXgxT29QdCtuNnNHRDdEWEcrL1RkbmlLZ3ptcjFV?=
 =?utf-8?B?dURyOEl0LzBOT1c2TkVHTFRSZmFoVktEVFVtVjhXT0dRQzZuMXU4RWQ1T203?=
 =?utf-8?B?dXFHUmd6eVhaUFdhUU5XK1VsQnErb2dOWDFKdldKTnZwaEZKMjBaR2Q1WGll?=
 =?utf-8?B?N3dpWitzcFBFL3pvZ2d6YW9aQVF1SU1sU0NmSnNrejhWTFdSVURXMTlNTlBJ?=
 =?utf-8?B?RjlyR1JrR2VOQURTT1VWQmNSWWNIUXlramhqZlhrdE9BYUx1SXN1bWdMNTF3?=
 =?utf-8?B?MlNSNHRyOHdsZ25zZmdlVkxVQUFadWJibmJCc3hmSWFIUThoZmlna1dpVWhz?=
 =?utf-8?B?TERQY0tsK1NoS2NvVE0yK0hQREZSMXVsenJiUDlIZTRTbC9VaWhobDBDU2Jt?=
 =?utf-8?B?cmVwc0xscnV1d0Z1WnZIZXFZQVZhRm0xU0RVRW5pQ1N6UHJVZ05sTWsvK0hN?=
 =?utf-8?B?L0lFYmUraC8yWnNQaHBTRVZyYkVveVJTSEkyNTJkb243SzJQdmpuL1QzZnUv?=
 =?utf-8?B?aVd0ZXg5NnJRKzdmZDg1TTBUUGw3TFFJd1NoTS8rVGlNQ3hZMTFKYlhPSmM4?=
 =?utf-8?B?RTUzMXZvMS90WGtxczlSTmpHQnBJQnJZZXhxY1hNTEV1a2ZuSTVGdWlybFc4?=
 =?utf-8?B?VnExbk85VUplOE80RU9xV2g5cndoWUxxbWhrajcvWHZhK0ZkMmxjYndjWXlS?=
 =?utf-8?B?K3B6OHF0RkUzQ2NTdDYvL0x4SFk2Wjg2Z0NWZDU2bEZGcUMxK2ZHd1VVTTdP?=
 =?utf-8?B?UnU4NFJ0SDBYYTdYU3ErTmhJRHpzZGtVa2R4MHhab1QrcndKNFhrcHpjZWRL?=
 =?utf-8?B?cTQwcnRhYVllcnlJa3k3ZElMTW1ZU0p3ZmNSRENzSlRoYUt5eVhtTW4vNi9y?=
 =?utf-8?B?R3I2TlRlVHVwRFg3ZzlBTy96bTRyMVdRNzhSUmVsSmd4UWdsYk8zSXN5eTdh?=
 =?utf-8?B?QjVoQjBjQzhqVGRZWFAralM4bmN5SnNKV1U4TFRYSGlHNE5VWmZOOTAzcFJ1?=
 =?utf-8?B?UEtxWDdacC9iQkFzVGpuTGlvQW1ZYUtnQmlOcEZLRG1tYWFaYkgvS1h6Q1Iy?=
 =?utf-8?B?NjFvOVgrSmxSWiswRXZBM2YyZHZjamZTMTNqckZrRGZ6dEo3clVjS3IwaWRK?=
 =?utf-8?B?Z2srS1ZqZE5ob0h2ZHg0dDI4a2dybUtCMjJiQ3A1bWQrNGEvQXRvUDRvd2s3?=
 =?utf-8?B?RkE1TEdYUElKbytXa0R5b1MreERVVm9jV3NZbU9hZTdRdytxdDJNcGF5dHl1?=
 =?utf-8?B?dDM4ZXVUZWgwRUh1aGFGRWhsWXdSWDl4WW5POGZEcFlsMlBuUXA0UEZna1F2?=
 =?utf-8?B?a0NiQk5sWGVSU3dQTG9HWHBLY3VYSnRDeEF1YkxVVGJJalkyVmNlNHJ5NFpi?=
 =?utf-8?B?RlBEVW9zMWxkWjFaUWpaTnBVcHRBTFZwM003Mnc3SVJSU3owWkNLVmRpV3h5?=
 =?utf-8?B?MUxkUnUwWU51N2dXNVpwZGNMR2dNWEFpNzJPbm9VQURHbk9laHpDVVVyMHFp?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ef8a1a-0ff0-4480-b4e7-08dd631da782
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 17:28:37.5205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFyyK70Wusxu6/F7n3k9JwK3vvF5OQxlHQdVLpjRVcE2aZgwFu+xEFpVKsa79uA4Vg5FYdISnR1wBe4sYRLDHU/gjyItIM5AtMgz8HjXgxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7518
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

On Fri, Mar 14, 2025 at 05:53:59PM +0100, David Marchand wrote:
> On Fri, Mar 14, 2025 at 5:24 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Fri, Mar 14, 2025 at 05:14:34PM +0100, David Marchand wrote:
> > > On Thu, Mar 13, 2025 at 6:31 PM Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > On Tue, Mar 11, 2025 at 10:56:04AM +0100, David Marchand wrote:
> > > > > Annotate symbols with newly introduced export macros.
> > > > >
> > > > > For code not compiled by lib/meson.build or drivers/meson.build (like AVX
> > > > > separate libraries, or sources in /base/ drivers), the exported symbols
> > > > > are added in some file listed in the sources so they get caught by
> > > > > lib/meson.build or drivers/meson.build.
> > > > >
> > > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > > > ---
> > > >
> > > > Just checking: for the AVX2 and similar instruction-set-specific functions,
> > > > we don't get errors if those are not present in the actual link phase, e.g.
> > > > when building on non-x86 platforms? We don't need to put an #ifdef around
> > > > the exports?
> > >
> > > We are not there yet, but it is likely MSVC linker will complain, indeed.
> > >
> > > #ifdef around the exports won't work, we would need a precompiler pass
> > > (and exclude rte_exports.h inclusion).
> > >
> > > Another option would be to provide stubs for those symbols when the
> > > additional AVX512 (for example) libraries are not compiled.
> > >
> > > But I think the simpler is to let a driver/library provide a set of
> > > sources to parse for exports... maybe via an extra variable?
> > > WDYT?
> > >
> > Yes, something like that could work.
> >
> > What I'd actually like more, but never have had time to actually try out is
> > to generalise the instruction-set-specific build stuff into the higher level
> > drivers/meson.build code. After all, much of the code for doing so is just
> > duplicated - check for AVX512 or AVX2 and if present build these files with
> > the extra flags for that instruction set.
> >
> > Something similar with the base code. Most base code builds follow pretty
> > much the exact same routine.
> 
> Having those separate libraries require special cases every time, so
> yes, it would be great if those could be factored in some shared
> mechanism in drivers/meson.build.
> 
> Putting the AVX stuff aside, and back to why we need those separate
> libraries for base drivers... I think the main use is to waive some
> build warnings, is there something else?
> If so.. I think some drivers could already be cleaned (like net/e1000,
> net/ngbe, net/octeontx, net/thunderx, net/txgbe, raw/ifpga at a first
> glance).
> 
> The AVX stuff seems a bit more complex, as there are multiple combinations...
>

First attempt seems to go surprisingly smoothly[1]. It still builds, which is
a start, though obviously some testing will be needed to check nothing else
is broken.
It really helped that most code just seemed to have been copy-pasted around
the place.

/Bruce

[1] https://patches.dpdk.org/project/dpdk/list/?series=34868&state=*
