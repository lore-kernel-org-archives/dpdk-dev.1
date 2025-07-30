Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC358C83F26
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 17:28:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ECE0402E6;
	Wed, 30 Jul 2025 19:28:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 21E65402C3;
 Wed, 30 Jul 2025 19:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753896528; x=1785432528;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=gFkTFO1o3tSA2AyMvDNZaO8yrY0Ab9du/HusHErMCEQ=;
 b=NcaVo+fQoPCDXwfTI2BXokfF1lJ/vvmP04Jt9FFUgs2LtBXxf4A3zCd8
 a3G8+9b5Ewj7FdzmFMThqIN78ShyhaB4p+qizYwplgTG0P29dFxDHBQaL
 qmnEUGqMC728m1HG8g82TZxm+wFDWPDqCTi3TdY+z941GvzQuufpSYzBZ
 MoVrjtzD9AUE9H856vyI1zbvH/EQUCjlY5eZJ089K6lJV8RQzjuXDue0q
 7qZhRzZqN44ZBnG9Rt77TCkt3FPulMfO19ZTC+YiUgXLbAdIwT3asUCt+
 d9JZYfEDDYzzIpGMSKZyw92gGI+e9NN+x8oDKnOjhhiGZshq/qCE9YkIR A==;
X-CSE-ConnectionGUID: Rb2rxDy1RSyF8C6NdfQx7g==
X-CSE-MsgGUID: y1B4bzosT82J+Hiu4MTWCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55906580"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="55906580"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 10:28:46 -0700
X-CSE-ConnectionGUID: OgKzIwHGSsOqCTkRASAY/w==
X-CSE-MsgGUID: 1ap29gp6RemqZxeXRZ8ucA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="162633420"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 10:28:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 10:28:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 10:28:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 10:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQ2NZdHM5JvHWDERVGmQ10ua8wBH6gdK5fz70XINzij2pP0ynG8RjUdnFXSKhwBgeU3xrfJ7A7MfEt30lWbcUTNFr06AQbp16jSuoeQcV85hxCA5nRyqqRSu7bXmjkETtwaW5J/mdyyN1yHcdB01I6hv8hqn1OWZvDKaup2S8CgngWdthXmhvfth3msSRQpSpUXO0tYO1XtRId2oR2pROfjleHbqdgXhi6y6IrHWSmoPZZ5IS4bxut2PmvSvR40shBQPpETZ8ioHuheCSj36uDzo3iXCGxWcjfVWW/IlqVj8d/2Gvkc6o1dyP7bY8ihfyP68XQOnU9dA2Rq5XXDwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGPFf+v1GQt+v4MAoNhUtTC7grDEXoh1O5KZzEpReAI=;
 b=sq86XncfaoDh9Kr3/lpWxL8q8GEG/pmk3sLgrJnXtzdO0xo/glelde0F/X+eaXTrr4NDVSv5Dqyx7/hXiCpf1H46Y8iPzFG9S63y3LvfVXhCVFSFvOP94oR2XrV3lcta0VG22i2pyAM0Xc/3qF92NIA6n8JQ8DRiAuSAxu9iM1+20qOiMxIOFHZs2misYsXIktJT1IRNKgEE9xYoBtIxc7W4D8g7+Gb0P1OrSMjtp1Gkjf+y2ACnA6AVlqlE8ZdGBQp/KCNPpp44HQ5V3GNkl5z4F1li+VQwPPbObZBNUjo+JGwWa/s8v2fL9mvbdFsXPg1F+NDGQ2iX/N6f1XolWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 17:28:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 17:28:38 +0000
Date: Wed, 30 Jul 2025 18:28:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Dengdui Huang <huangdengdui@huawei.com>, "Vladimir
 Medvedkin" <medvedkinv@gmail.com>, <techboard@dpdk.org>, Patrick Robb
 <probb@iol.unh.edu>, fengchengwen <fengchengwen@huawei.com>,
 <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, Dean Marx <dmarx@iol.unh.edu>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aIpWP6FCcMXktUvq@bricha3-mobl1.ger.corp.intel.com>
References: <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXPtChUUOdz3gfiyKqY4Rn2_0F8Ck4O6ypq9woATD7hfCw@mail.gmail.com>
 <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB8@smartserver.smartshare.dk>
 <CABD7UXPccao=o1O=SessoAdEKUyA-dXP6HG5mnkpFSVNL_3dxw@mail.gmail.com>
 <aHoEUmesrg9Y8qtM@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXOqkROef0_BreD1GHC_R+7EwxRTL8LF-fXQJBECp7J9SA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDCD@smartserver.smartshare.dk>
 <aIeTCX3KbnxIvDJP@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDCF@smartserver.smartshare.dk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDCF@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ1PR11MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 844c93fc-2552-449e-d9ae-08ddcf8e84e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yy9jTjZVeXpUODl0dUloZmkzdThLWm5SSXBPWG9lZFV0dGZHSEYyY0pLNUEx?=
 =?utf-8?B?ZFBTa2lmYVNFSHJwcEo4ZDBTRk1IVlc2NmhualdpRTJzV1R2QkNGVTBPdENE?=
 =?utf-8?B?dmxZMzBtYVFQNjJFRE91UVdtK1BKS2NxbG9hVGNQblcyZEtsK1RHR2g1cVpC?=
 =?utf-8?B?YUh4SWwvdVV5dVdoUU9GS1BIRHUvRkYyZmRaWUs5V2h4cjVzN3E4SGc2QzZ5?=
 =?utf-8?B?TGd3bXp5ZjlwQWp0VXQ4bWRyRmszL1RIMnk3WkJBS2hZNE1YV1l2VjRwRGZE?=
 =?utf-8?B?OHpwTWw1bk0vWEh3WDB5dWFoRExQRURTeXdDTmxabFF1QnpGOWZLVTBXSVhU?=
 =?utf-8?B?UDhzc1krOVVBQ3Y1Ritzb2gwTjhDRE40OHlqbWx6dUlMUGx6SGl0T1hSN0Y3?=
 =?utf-8?B?d0tLbUtzazZCREhVb0RLZGFsMVQ0OTJzVm8yYjlTVk8xUjllSzM4U0grbmhZ?=
 =?utf-8?B?Y3Z6V29QQWgrb0p4a2tSQ1NtdEcxbTJsWldUbTdZWk1uWE8yYVoweDh4UHlP?=
 =?utf-8?B?YUVoNGdPei8xZUxsdDJicGxGcFZyaEdUSG9TTHBBYUNjVU5BWWI5Qkh2VTZ3?=
 =?utf-8?B?YWdkamhOOVdzdGw4VTVCeWtoQUZUdzJWQWU5aCs5VWIwczROV0lTZHdMWE94?=
 =?utf-8?B?MGIrQXZqbXBoOGxqOGlSTklRMWpRK3krWlRRMTAySWdSMVZZbU1BenFldzBm?=
 =?utf-8?B?aUh3SlltYUkwcDRzUlR6SXZISUwwZml0VmFTWVpOS3JQaEtVYSthblZESWRt?=
 =?utf-8?B?Q1h5QitUaHNYeVAwdXFhaHlEK1Z0LzV6UWQ5eTlhdVZZVUNoTzlJMVIrZXRU?=
 =?utf-8?B?aGI1RzFsMUNHa1R5QVZQNTlKc3hTUy9XTnQxbnpOZzQyWG96TVNIUXVGalhk?=
 =?utf-8?B?aVhSU2dKaGg3ZnVDQ0FGMytuTmxRODZKUXpzdi9HQjhLd2doM1BiK2tMZjdx?=
 =?utf-8?B?SVdsYTZ5MSsvck5UeXpwNnpnd0NHVWp6RHhFVDBtTXVRdWRRRnphamd4R0cz?=
 =?utf-8?B?bkp0ZTZDZVo2WTg2OUZ0LzI4dldVOXpUMHM5bzZ3Y2NyZjZrZlBlRnMzeFNa?=
 =?utf-8?B?ZkdRR0pWSVd3cXhyYjhJQ3dOemFFQ1ZpelhNUnhuQjhoNzl0ODNYdlcwSUg0?=
 =?utf-8?B?cHFaVUZGWStCSUs0Z3NrbHM5UjZlM3ltNnBXSkZDTkFuRExlMkVoREpLY0Vj?=
 =?utf-8?B?anY3eE5CeWNFb09iUVUyY1Rwbm1CU1A5MmFTenMzYkZGSC9GUnE4Y2MyVjJa?=
 =?utf-8?B?SWpXSTFTOFdmTmZQRFNWcHRwY2ZFc0I4UG9JSmQyTG9hTjdTZ2xrbG9NUCtY?=
 =?utf-8?B?UDJBL0l1a1FRZWRjUnY5MXh0L0krVmtaYmhaUmRzOU5UanAzVDJNUWJNZWFv?=
 =?utf-8?B?cHhEbjUvbXpzUysyMWhVQW5Sa3FkSjhzMHVyejlEUzlkUHlRVFJtTFh2Vm1v?=
 =?utf-8?B?cUZZTkx6NHM3V2g2bDY2eGhxMXRETmFkNTFVdUFIOU1tSFg3TEFaZ201WUV5?=
 =?utf-8?B?WXBtbitMVEp3MW92alRVRzF3azlOWlFYSSt6T0FJT09MbTU3czRuM1J2elYr?=
 =?utf-8?B?UTY4ankySkFZVmVRWnAxaGxhNnpWbjJPdUFXNGtWblZCVFRqKzVNR1JBVGZK?=
 =?utf-8?B?L05wMWZuNGxpMGNZeGlVZUdTWXA2TnE4Z3RCTUJWN0hiZDlCaEZzWHhoTHBu?=
 =?utf-8?B?eWUzZmZOVWZ3TVUyWThDZk95NDdCekFnSm9XTnc3azJZbHVHdHZYMjRvenNn?=
 =?utf-8?B?UnpTSC9rQVhtclV2SW9SM2kyeExEeElHU0xMM3gzZ0xsWmhZa1VYc0V3WUFV?=
 =?utf-8?B?NllGcFBmZUxwcGsvV21xSWMxZ1ByS3JTV0dDS2R4Umg1UmdqVXJ6RTd4MEIr?=
 =?utf-8?Q?9wqLWs8o/cazF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NwUUFlSU9zODBRek9RVXp3YnE0ejZabTJBalk5czVqK1lRU3ZFWEJVRU9F?=
 =?utf-8?B?MFN6UWV3cjV2ZkF4NENBQ2Ivam05NkVWOWVYa0hicHZpaHlZTjJPcFhnbEJw?=
 =?utf-8?B?NTM4R0E3QUtUY1gxZHlBQ1EydDFmeFoyUFA3aG0wdTFSbmQyUW9vY2VrZVlo?=
 =?utf-8?B?bXpyRWlEUjdIVFlmMFMyd3JHclNOY0xaR3pJckQ5elJJUVJ3QmRXRkJ5MnNJ?=
 =?utf-8?B?akcwRGQzWVY0R0dVZWk5Z0NlL1J1ak4zaUE0UFJmeGlWNmRPbkJ2OTd4K2I3?=
 =?utf-8?B?K0ZFcUdPRXBaQy9YZmpaVFFjYktlZlR2UWhLQVc5ZVU0MEM5eUc2cHY0aE1N?=
 =?utf-8?B?UDNlQXBqYkxCNUFMMkJXZXNycjUrV1dEbjVpcDdRa1NmTTA5L2dxMXVia3da?=
 =?utf-8?B?alNJTkllQXZ1VWF6RG1URS8xeHZDRktPcFQwRWV5QXJ1MlNuc3QrWE5nalNV?=
 =?utf-8?B?NWNwSGl1cDhRa0o1Z3I2cGRBcmo4SDNyemVqWVhOaXJsaEhUOWczSExZRzE3?=
 =?utf-8?B?bHYzQ3JtSEJtZmZtQ0trVXhkd1RoRkhFYitNZ3J1dGVJdW5uVWd1K2xaMHU5?=
 =?utf-8?B?WUxWbU92eEJuK08ySVhRVUxOeFZoVERBY2UyWm5keXJWa3FiendKVFRKaEFi?=
 =?utf-8?B?VjVwNHQ3RjUwcFFFZW5RRmRweUV3UVJtR25lRVpwaTJlcHdVT0pvcitoSGRa?=
 =?utf-8?B?ZlVNUndWRy91cXVFTmJRblZXekZETWd4OFlXUnVuc0c0Mnpza1dEUWQ1aTFE?=
 =?utf-8?B?STd2NnB2R3c3cmpiUnZIRGRNVXhmTzBQOVN3RWlQVGtsSG4wRVM3a2NSTGov?=
 =?utf-8?B?U3FtMEZmblQzZVBTZ1ZZMnQ3S0ZhT05reUhiWUl4em9VL0tyVy9RWlNmaXFD?=
 =?utf-8?B?QXRBK0cwY3N6SXVFOUJpZENUSElLTktNTFJyenBwYy9ZQ2MwT2YyeXFCQjlC?=
 =?utf-8?B?V1huakJ0QWNQNnNlTFJLRXNYOTUrSmx0N0dIZ2xIUmVzR3g5SjIwaWliWXlF?=
 =?utf-8?B?bDBRZHdaZ0wzUE0zVzdiLzJwUWpsSW9laEhNekxTaXJHNHRaek9UajdRVENS?=
 =?utf-8?B?amxtK3dvMzREazVzNnh3Z3Bjc1d0UXVYbmJnUitXam1XbW9ySk9CbURLaWdC?=
 =?utf-8?B?NGIxckRoOXJ5S3lBR1FkQzhza0EwcldoTWY5bGxKMGFwMzBweEpzTFo2d0xI?=
 =?utf-8?B?VThJUzFJYU14by95NHNBdlBlTE15N2JTSGtvYXJkRW84LzBkZEk1dVhMQlhL?=
 =?utf-8?B?M1crZ0JJVG4vQTJ0Mm0wSWpmRGliR3pGaTBIWW4xVVp4NnpJSDRJeWN4clpW?=
 =?utf-8?B?L0dqQ1gvWlFOUE9LWjFhWTJ4SnArVDJLbTJNbDVSSndrYXQ3OVFoTjhUeUN0?=
 =?utf-8?B?dDVJMEszTWlxUUY0cjdqR2JodmtUNjdZbUxibHJmWVFvMnkrdWI5YzNEeFp2?=
 =?utf-8?B?YldNbmRrdmdNOEo3ZSs2bVpubFRwc0kvelFUQlA2S0ozcDhBSEwyMENlOFhZ?=
 =?utf-8?B?bFpyTmhvWDNXRTRDT2YzM2h0RzhYdUR0cTNBVUVkKzgrRWZQVmFneDQyR2tD?=
 =?utf-8?B?cXk1Wng2K0J1WjNLVlRtd05rcDUrVHpHWTlMdndDdnI4VnEyTE1QeWJnOFlH?=
 =?utf-8?B?M0E1YmgrUE9QMCttM05RSHRlSEtMSlUvTHY2OVVGWE1Nb2ZOWEdpRHRzSEZs?=
 =?utf-8?B?UUFRNlEySHU5ZjNsWEw5S05KYXZxdFIrVDdseWRWYXhGNGE5RnAxS1BHNEpN?=
 =?utf-8?B?M0VKT2tTRElOMmp5UnFHTm9WcmJqK1RZM20wVFdlSTFkVkoyT2t4SktWRi82?=
 =?utf-8?B?OUxZZjRxWFNGMDdEbzJPRWl6NTJnZzRoZ1prQU15U2xiZ2RNRmhVT0htRWVo?=
 =?utf-8?B?aHMrdHhGZEROTkM1RHlDNUtsdVN5WkhUQnF4OWhxSVI5SDVQcG9Vd29jR1BK?=
 =?utf-8?B?VFgzdENYT3g5R09hejgxRVhqcXF5MlpSQ2psOXBkRkRIUVh3ZVUrakVwMTA4?=
 =?utf-8?B?MHNSS0VnUzBib0tVSDZMWGtNODFUd3Z3YUJpdTI3NHRYcjdiTFJ0anBZelgw?=
 =?utf-8?B?MWt2R0dJYVlCNndiMnlMbXpBdjBJZk9kbC9XbVZKbnFNcG9rVVJKY0VsdG1L?=
 =?utf-8?B?dmI0blV5Sm5uWnhzNlpURUFkdVRVWlFzaCs4bDQvMjlOVG5kSHpqSERUbjFO?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 844c93fc-2552-449e-d9ae-08ddcf8e84e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 17:28:38.2054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2b6eaA1vW0poU++JspAopzMJs9t8/3djN36v9epfU97sqvKy3YIBE5lHPMgN+VVTVS2VXekbyz9+u9XoebbB/uBSwdLbIMQcLliFPCfLNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6179
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

On Mon, Jul 28, 2025 at 07:48:53PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 28 July 2025 17.11
> > 
> > On Mon, Jul 28, 2025 at 04:51:30PM +0200, Morten Brørup wrote:
> > > > From: Dean Marx [mailto:dmarx@iol.unh.edu]
> > > > Sent: Friday, 18 July 2025 15.18
> > > >
> > > > On Fri, Jul 18, 2025 at 4:23 AM Bruce Richardson
> > > > <bruce.richardson@intel.com> wrote:
> > > > >
> > > > > On Thu, Jul 17, 2025 at 05:03:13PM -0400, Dean Marx wrote:
> > > > > > I've created a v1 of a QinQ test suite around the set of test cases
> > > > > > discussed earlier (which is not set in stone, and I expect it to
> > > > > > change significantly across many future versions.) The PASS/FAIL
> > > > > > values can be mostly disregarded in the context of this conversation,
> > > > > > but I've added logging to explain which packets are sent, and what
> > > > > > happened upon reception, which I hope will be more informative. After
> > > > > > running on mlx5/i40e drivers, I got the following results:
> > > > > >
> > > > > > test_vlan_strip: QinQ strip OFF and VLAN strip ON
> > > > > > test_qinq_strip: QinQ strip ON and VLAN strip ON
> > > > > >
> > > > > > i40e:
> > > > > >     test_qinq_strip (sent packet: Single VLAN): FAIL
> > > > > >       reason: VLAN tags found in packet when should have been
> > > > > > stripped: Ether / Dot1Q / 802.1q (0x1c) vlan 1280 / LLC / Raw /
> > > > > > Padding
> > > > > >     test_qinq_strip (sent packet: Stacked VLAN): FAIL
> > > > > >       reason: Expected one VLAN tag but found 2: Ether / Dot1Q / Dot1Q
> > > > > > / 802.1q (0x1c) vlan 1280 / LLC / Raw / Padding
> > > > > >     test_qinq_strip (sent packet: Single S-VLAN): FAIL
> > > > > >       reason: VLAN tags found in packet when should have been
> > > > > > stripped: Ether / Dot1Q / 802.1q (??) vlan ?? / LLC / Raw / Padding
> > > > > >     test_qinq_strip (sent packet: QinQ): FAIL
> > > > > >       reason: VLAN tags found in packet when should have been
> > > > > > stripped: Ether / Dot1Q / Dot1AD / 802.1q (0x1c) vlan 1280 / LLC / Raw
> > > > > > / Padding
> > > > > >     test_vlan_strip (sent packet: Single VLAN): PASS
> > > > > >       reason: VLAN tag stripped from packet
> > > > > >     test_vlan_strip (sent packet: Stacked VLAN): PASS
> > > > > >       reason: Received packet had outer VLAN stripped, with inner VLAN
> > > > intact
> > > > > >     test_vlan_strip (sent packet: Single S-VLAN): PASS
> > > > > >       reason: S-VLAN tag stripped from packet
> > > > > >     test_vlan_strip (sent packet: QinQ): FAIL
> > > > > >       reason: Neither tag stripped
> > > > > >
> > > > >
> > > > > Can you confirm exactly what is being sent in each case for the
> > ethertype
> > > > > of the VLAN tag? When you say single and stacked VLANs, that is VLANs
> > with
> > > > > 0x8100 type, correct? Is single S-VLAN a tag with ethertype 0x88a8, and
> > > > > QinQ packet a packet with one 0x88a8 and one 0x8100? No other type
> > options,
> > > > > e.g. 0x9100 were checked, right?
> > > > >
> > > > > /Bruce
> > > >
> > > > That's correct, single VLAN is one 0x8100 tag, stacked is two, single
> > > > S-VLAN is one 0x88a8, and QinQ is 0x88a8 and 0x8100. No other types
> > > > were tested in the stripping case
> > >
> > >
> > > Bruce,
> > >
> > > It seems the drivers have the ability to set the EtherType of the Outer (and
> > sometimes Inner) tag:
> > > https://elixir.bootlin.com/dpdk/v25.07/source/lib/ethdev/rte_ethdev.h#L3752
> > >
> > https://elixir.bootlin.com/dpdk/v25.07/source/drivers/net/intel/e1000/igb_ethd
> > ev.c#L2739
> > >
> > https://elixir.bootlin.com/dpdk/v25.07/source/drivers/net/intel/i40e/i40e_ethd
> > ev.c#L4038
> > >
> > > -Morten
> > >
> > Thanks. Question is, does this help us to clarify the behaviour for these
> > tags? Based on the fact that the comment for the tag_type says that the
> > outer is the same as single for vlan types, then should the behaviour be:
> > 
> > * VLAN strip - strip at most one tag as defined by the "outer/single" VLAN
> >   type.
> > * QinQ strip:
> >   - if outer/single VLAN tag matches the outer tag type, strip it
> >   - if outer tag has been stripped, and inner tag matches the tag type,
> >     strip that also.
> >   - if a single VLAN tag is present, it gets stripped only if it's tag type
> >     matches outer type - it is left alone if it matches the inner type
> >   - if two VLAN tags are present, and the inner tag matches, it is not
> >     stripped if the outer tag does not match/has not been stripped.
> > 
> > Also, should we specify for DPDK what the default tags should be for the
> > two cases. It seems for the Intel NICs that I tried, that both inner and
> > outer tags always start with 0x8100. That's probably a good default for
> > VLAN strip, but for QinQ strip, we probably want hardware to default to
> > 0x88a8 and 0x8100. Alternatively, we could/should mandate that drivers
> > explicitly set the required tags before starting the port.
> > 
> > /Bruce
> 
> My train of thought is:
> 
> 1. When not configured for QinQ, maximum one tag is considered. I think we all agree on this.
> VLAN is EtherType 0x8100, and (if present) is associated with the first (outermost) tag in the packet, and kept in mbuf->vlan_tci, regardless if any more (inner) tags are present or not.
> This defines placement of the VLAN tag ID in the mbuf and the default EtherType used in the packet headers when parsing/stripping/inserting the tag.
> It also defines the purpose of VLAN capability/present/strip/insert flags in the ethdev and mbuf offload flags.
> Feature creep: The EtherType of this (outermost) tag might be configurable, if the hardware and driver supports it. I would consider such a feature very exotic.

And just to be explicit, "associated with the first tag" means that we
never have a situation with VLAN strip or QinQ strip setting where we would
strip a non-first tag, but leave the first tag in place. Tags are always
stripped from the outer tag inwards, and tag stripping stops as soon as the
first non-strippable tag is encountered.

> 
> 2. For more tags, start by strictly conforming to the IEEE 802.3 standard.
> QinQ is EtherType 0x88a8 and is associated with the outer tag (S-TAG), mbuf->vlan_tci_outer, regardless if an inner tag (C-TAG) is present or not.
> VLAN is EtherType 0x8100 and is associated with the inner tag (C-TAG) or simple tag (VLAN tag), mbuf->vlan_tci, regardless if an outer tag is present or not. (Note: When disregarding the outer tag here, this is exactly the same behavior as for VLAN in bullet 1 above.)
> This defines placements of the tag IDs in the mbuf and the default EtherTypes used in the packet headers when parsing/stripping/inserting tags.
> It also defines the purpose of VLAN and QINQ capability/present/strip/insert flags in the ethdev and mbuf offload flags.
> 

So based on what you say above, having a VLAN strip setting separate from
the QinQ strip enabled setting doesn't make any sense, right? So we should
decide and document that when QinQ strip is enabled, VLAN strip must be:

a) always on - which makes sense if single tagged 0x8100 packets are still
               stripped as you describe above 
b) always off - which makes sense in the case below where singly tagged
                packets are treated as outer tags
c) ignored - which is a bit of a cop-out, but avoids any issues with backward
             compatibility for apps.

> 3. Then add support for VLAN Stacking, i.e. using EtherType 0x8100 for the outer tag.
> This mode of operation is only relevant when configured for QinQ. It does not support "super hybrid links" (mixing QinQ tagged packets with simple VLAN tagged packets), because a packet with one VLAN tag is considered an S-tagged packet with no C-TAG, and such a packet would normally be considered a simple VLAN tagged packet.
> Now, QinQ means EtherType 0x8100. It requires that the hardware and driver supports changing the EtherType of the outer tag.
> QinQ is EtherType 0x8100 and is associated with the outer tag (S-TAG), mbuf->vlan_tci_outer, regardless if an inner tag (C-TAG) is present or not.
> VLAN is EtherType 0x8100 and is associated with the inner tag (C-TAG), mbuf->vlan_tci, and can only exist when an outer tag is present.
> Note: rte_net_get_ptype() cannot support this mode of operation without adding a parameter containing information about the EtherType of the outer tag!
> 
> This describes the behavior I have now come to expect, after getting wiser through this discussion.
> Drivers might do something else, and applications might have adopted what drivers actually do.
>

One followup question/thought then: the rte_eth_dev_set_vlan_ether_type()
function only applies for QinQ traffic, since it specifies inner/outer?

/Bruce
