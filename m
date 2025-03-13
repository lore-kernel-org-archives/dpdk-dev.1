Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72CEC35FF3
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:31:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 096664114B;
	Thu, 13 Mar 2025 18:31:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2068D41141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:31:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741887113; x=1773423113;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Gkrp0x6eEYjEJm7ceig+QXvQHofqRwm6XcCmynQFvAM=;
 b=Kzj1l356/rnoIBmR1loBqCjzzYb7w2TEAYXiALG7J7AS+ZJ8/1sOpLeH
 59WyTlTq4vEJ4EHEAhKk4hoKCd5/g1VzQ1Uw+1s1kE63AZa7KbUi2rFeD
 iPbzg4KG1MwNvPoj3iuKhQ5PtqJhMvc8HIdFo2JIjN1dvKhwyU3oww8j/
 AVjEnpmVW5kTc9RRI/hbyCQfqtT6zfoclbDPzU8QVSAtbB3/sgqYfGHHF
 oNmGQuyyR9TY/YsLnwH73kc9ctK849kRkeoifPEl4SQEYk61/UB+TVxS5
 EruIKlsNvn+EJFMnk1XnBKwhQwCVN86gV1bUacWZboHhobgsA8kvT6Vdb g==;
X-CSE-ConnectionGUID: k74WygR3SrmPLLzZb5F9mQ==
X-CSE-MsgGUID: 8vvXzdOmTsqrQuTKEtJDqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42883634"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="42883634"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 10:31:51 -0700
X-CSE-ConnectionGUID: UeL8ic6XQiy+6O+XBj/WMg==
X-CSE-MsgGUID: Fg+neYbKQpaI1BrNnv8DMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="151887770"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 10:31:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Mar 2025 10:31:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 10:31:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 10:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8FDs0Ybr7WOPTkyDW2Tb0kN6WFP+VSDpsFXoo4ZFBrK0K8LwE8JxtCtzvYNYTrH3kXZuJcbkk020n1u9o01Cn9hXhh4sUiyxuhvXqpng8ZEwkjDptW97mJUGZg/hLAzfl0fQnjr6EUqGuqiDNyX0M8HgnB/Is62QGpihH5j5I/sbOOsf9Emlj8QxhYS/dgMhc6+Qz2zISFnNMwm6l/gl9kK6B6Q+DGttux+CnbL91Cqh48ePgDBn/RYBMZ5wRIxsrCcCQZIySMXBvo6dCorFf8bcyofjhnPqNo2MLHbvNqHVJt5eI2Frn7f7Ecr2SMvNcJ/oERXwq07UDdZJZ8gkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG4MnTW9E83cGRcry4EGONt2yi6kQZ4SzzDeMu89G10=;
 b=pN3/E4djqS9mzPSqIIl0aiEWxFaYmn0aU48mwIbYPLwN33ahFYuygtzP4IJN9SQ6lj5kffWX7DMhxOXP75ZhjL8gQT/uM3GnXrNyGGWCu7n4zs+JL6uh/+nsTX6OgA6hZ4WKK5LgmQvEBcM8IJ2oObTmuypzMBCaJkKLF73m1K61cWc1xVUzDGFvoh30dLOu5o5Iwu7em87mqK370gZSHQmO3caavM6KnH0LLYWObbD0XdpjpOmaOl2c2J8Ipkcbl7dM5IZ4gA37te0/lt0Ic3VZi6OMcHWQlNlFCIiShrtFkHoyF2jPZhCcFWZ0x+S8/7xQdeEc2annS8Kq+8StHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6681.namprd11.prod.outlook.com (2603:10b6:510:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:30:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 17:30:57 +0000
Date: Thu, 13 Mar 2025 17:30:41 +0000
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
Message-ID: <Z9MWQR_o3m4T_rFt@bricha3-mobl1.ger.corp.intel.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311095609.194523-7-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0046.eurprd04.prod.outlook.com
 (2603:10a6:10:234::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 1177c092-bc0c-4f54-94a3-08dd6254d031
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3HFeEvjozaQhS1ArGtR7rd/nY6BTeywFdhq9AMtKTAmtjPjrzcuwRo1ZToFI?=
 =?us-ascii?Q?qXzR+9ymosQpAI1Pb1vLRUb2r4t3gQX0z126+3uyE9nLm+T6psS7oS3e/88l?=
 =?us-ascii?Q?vZpPHog7nQR+KTgSUL5VCDeWl1KPG12MdzFNQFsG31sYppIkpxrCY2zMOWFF?=
 =?us-ascii?Q?C3bFj3T8G1D3zMIEOE+zFI9ku2GFznaqrUL5MQLmxY05BEn8tIQKYjnZ2CS2?=
 =?us-ascii?Q?a0+PwrH0/yJ22gudxabR6os3hHXDmLNrj7uAdDLbsjJx8pFc5TSu1SDw8dI5?=
 =?us-ascii?Q?E46NXRh52uIjwSBuuDLh1jSrGVBgTnMUj180ZAI9IBtm60J1oVp26tE4eVtA?=
 =?us-ascii?Q?W/XljmrfjsXz/MSykpnFpI7T4TabQU+DVcpfJ3anvUMV58tm+WKp1MMl4qpd?=
 =?us-ascii?Q?aEzeVDzKgVQMK4SaRqGsrr6P+1iukT4DgqWgdSo71dRIa1UPlzvuf50M3N8O?=
 =?us-ascii?Q?aKltICHsXAwsT4oIaovYw0JWW80u45snIBF7V8RR14MWgXf1UI73bZ5z8bVT?=
 =?us-ascii?Q?PYHSCEAt88NlBDfeYcGV0F23Ap29OG5H62cKwvQ8DkmbGq0OiMunneuo9XS4?=
 =?us-ascii?Q?xC4Lbq9P/GAU9WXYXysfLXbJVXGvrE6nF6T572KWI3HCluesi2uu7MygNc7A?=
 =?us-ascii?Q?WQ4MSWTu0cOEEvFeQtmq2UTN1CAYtwQAcDO/thfqgCM6hKB7DbNzyRlp0RVC?=
 =?us-ascii?Q?0otRk67xPQQXJVPjFKbOlizVjVBb2UzXhK4IWDwNHCeiG+2gLvw5yqmRkk6l?=
 =?us-ascii?Q?eNrukqXnWU6weGD5lFG6XXLMZqpW2PNZbUzG86a43LenxmYgGFRax+AqxiAP?=
 =?us-ascii?Q?Naw5QiZ4pvjzldxmXbKJS/LN1LhtYpw3bjIgft8qkPRxujECjCrBdFRZtYgw?=
 =?us-ascii?Q?NtYdXJAdwXT/3by4x9KMU07BzVcORKNy/5aG95U/WCeCFLMs1y6D6vVF4faY?=
 =?us-ascii?Q?AiI1Kzrd1lJOO5lUmnAYgiCbq38mhj9EWxkO0ynfWsND8Q7jKlR0/uW9nQ9Z?=
 =?us-ascii?Q?6BxfHyjYrddkzbQeVOyc8h4FCYLK2cixkE8opmFpwDO+3A3H2JmBCod2WMXG?=
 =?us-ascii?Q?Nlicd7xw5MSW92kMwT5tLMoo9czaMdSBEkgSPYDTGCOWOMKjfLcWg3mG6Uyr?=
 =?us-ascii?Q?ChBb3ACD6A4SxLwDEdyINx4YKYjE4knBmu8YuwiKerRXTM6rJ9P0JuPudglu?=
 =?us-ascii?Q?0/Mbm0/9Ud15DIPBzCwcVDlFRJ3GYJOmVoJGZXIxciLesHF8zMKmIPXf9eCM?=
 =?us-ascii?Q?wk2nJQs9yQAJ+QHFNwdx8Icv7pzlE3v7vD8p1tA2uekNp04u5gjNWiVfQnxN?=
 =?us-ascii?Q?ybRCqypk7Xz8rNgDdWA2+SKEfxHZH75rkqnYNVJ+APURYW5yqcp0pNoAhyT5?=
 =?us-ascii?Q?S5yV6RpLLUUFSdBHaZid7yhzbllh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7odaEISVH5RRiF5iS/cwRR5rrnuQhTWU+F3Sls9AdxKWNlDjFyrEtaHWOHZ?=
 =?us-ascii?Q?7Crerf2DCvzUnxbAn3mw4YPMADMHU92P8Ti/KlRwcBKsPRwDtzyAP0utlGne?=
 =?us-ascii?Q?IWWO4229WD+WaqDmUz4VEpEBt/1uZUswAAL0g/N+3Ee+5v6d+opAaSIzvVf8?=
 =?us-ascii?Q?dIhFpKYfY8TjnZjvvW59oZtxwVMPaoeGREvziJmmTh/0aCu49ALgFLNppVQI?=
 =?us-ascii?Q?i31o8Tn/GJERNCRPo+o/IeDVJG2zuCwxEzarEFwihYcdFeNwshZKRdi1rsjh?=
 =?us-ascii?Q?mbDdKhm/WNKSvnwj4iocuqSvqN56w8RV0DMSt3kPj+obTheIS56DWMZeGG7x?=
 =?us-ascii?Q?pA6zLovR0CH/Lgd/B6fZa1dpRBY3f/4BH8MCerKUW4JdRMPhAF2AzozNjKXX?=
 =?us-ascii?Q?g7/f/5hNloUuhb91GoyZYUlPqp0NxlGv3n9WzvT9lfkSdMXEGKEWevXh+pXk?=
 =?us-ascii?Q?g7XRhb4vWL0zD0IylDHtk+sTUjCr6t7HZWxHYcetBG2u06eur1dpYY90lSns?=
 =?us-ascii?Q?1pQuROqE5wWFWf8+7lZuMFm66qk4+RD41IuCKiOZyyLT201ajwgYbCt466qo?=
 =?us-ascii?Q?7m9pBmtl+GBd58U1bleww5Y43c3NV5ZPJmhiN51KZlr3NLN2Ml+LNu6DosNh?=
 =?us-ascii?Q?2h/VlUvmZRyoUvUiTMWFkIzIJasRr7gNoe69ck8kMnFAD2qyuiZ9pBspAxZ7?=
 =?us-ascii?Q?FM5tf5oiKsrEpr2dBPC1MTi8WC5rUtbklQZ4HMqG2JZG9DBZ8xqFbeJZlDl9?=
 =?us-ascii?Q?KL6zzCnKB8TDmpRF7hJ2QzbWWDiY9xRuRYXA7PxZIvptxWnDbzrUSj7bZ7WA?=
 =?us-ascii?Q?0AwkggPNVVczJmAxPt42H8KBHZz1L7yg2mH60KBl04qoV5RLKbaPqRgKVXtc?=
 =?us-ascii?Q?u9GTYoyWxBGTcMqTXUm8M5AkBhhUSi9a0lD0fFHae6ywoQfnHyVHVjVh6oee?=
 =?us-ascii?Q?h1c5vys4MiMf2/6GS0wsntLpjGwHNc+xQVAitY37sdLb5I2BwiwrVracC8G8?=
 =?us-ascii?Q?Z/9/mprfngSfXZ8TyqwSUEjDcW4UQC6nvNRPf2DW5Dk/q3iheeoHv+NXQ+2r?=
 =?us-ascii?Q?rnAsv36ndsBzPbUbigatgazroM3ncoFS7Zpd9cVZtyBdX+vF2mdnI88K7BXn?=
 =?us-ascii?Q?OXrTK4G2GMdyPyrqtBm35caCAylFIDWrTs4P7aHXxbiePMxNDjxnpCubO/rx?=
 =?us-ascii?Q?e2JfbAQnuRghzoT2Ul7wxSHykPHhcl8lduaQNGKQgcZ0iwArLn0qX8zduppJ?=
 =?us-ascii?Q?CJDeynfET6psfpmGjcBxzr/K96bN/ocEN5V8hHqBpOQeg8v0v/IkfqSOiS5U?=
 =?us-ascii?Q?MbkCJCmAm/GoBuQJcEdvdnjj+uGR9l4NX3k8sPVPbbJsdUcf1UefxIeTaDRb?=
 =?us-ascii?Q?e+/8MmYHaW3aqZqfskm5LEFQ4Nyctp13B20wwdM3qnj7rNNniDiIfQ9oHRgt?=
 =?us-ascii?Q?KA4ggmrH205w0f6G6OQxUN4qVq1lP2w8PFGo45VaNhmn+7d6bZoyu9sv6UeR?=
 =?us-ascii?Q?qrrMc105W9Fk8bRqODA1RwvXkzRxzPLd/qmN575yoTAD1B0x/zZbNEvfjxcs?=
 =?us-ascii?Q?Q6NUaOVnRjJSvPCQLVOCcMcbudundU9q5gR66NPya9IgZLOJUCC4Xm8N+yVa?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1177c092-bc0c-4f54-94a3-08dd6254d031
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:30:56.9417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubTLj7+kDXC0qlmOanmDPpKqqCyEkB0L+DV/G164Ii7k8+b3ssMj6QiDoGXELubUlmoTmO3wvVM++161fCcayVJ4zkRI5IsPo5iC9O2K6jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6681
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

On Tue, Mar 11, 2025 at 10:56:04AM +0100, David Marchand wrote:
> Annotate symbols with newly introduced export macros.
> 
> For code not compiled by lib/meson.build or drivers/meson.build (like AVX
> separate libraries, or sources in /base/ drivers), the exported symbols
> are added in some file listed in the sources so they get caught by
> lib/meson.build or drivers/meson.build.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Just checking: for the AVX2 and similar instruction-set-specific functions,
we don't get errors if those are not present in the actual link phase, e.g.
when building on non-x86 platforms? We don't need to put an #ifdef around
the exports?

/Bruce

