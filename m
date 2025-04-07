Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C4BC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 09:48:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17AA940156;
	Mon,  7 Apr 2025 11:48:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9BF6C40150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 11:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744019333; x=1775555333;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=dDfNKOHp30/G6W4tIXGTk+NKaxflNMTsr8gfhPXt+EU=;
 b=gTqPHUQZrl+mgMPMY0D2PtNZ0/KgVa8+QOO6pK4WMJmoA/Kyf7h6zxU0
 o19vNo3KVhEP4pvxaxRkWIPLz+mEDqgelFXImHg1Z3g4R5PWpTGvRq67g
 R1n8/dL7oN8EEcl2H4tuOcD1d6VgfLcRW/SfnwgkM6dR3lUUXn8GFH4VN
 lhDmdYiGBrsdlNiQU1BmaR6AUmChXT/FiQYpoWlZGrQhzJyqM/Ogno2GW
 g412Mi335YECuM8MTz1t41GCHIg7Gzh9WIgia+Tw+g6XMKCWaPKdxFu7n
 yU3DRW+dCtnfeJ2HFb09cSG1BBCgxycF2fwZTPwjtDDU4LO7GeRh5Gi/B g==;
X-CSE-ConnectionGUID: YxQs2m1kR4mJPIjpSZTjeg==
X-CSE-MsgGUID: 8FjNGPZVSaGEdroxVaQi8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45109603"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="45109603"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 02:48:41 -0700
X-CSE-ConnectionGUID: rRSpYwZ9S6+H/JDz6hyshA==
X-CSE-MsgGUID: Gpsw83/GS4eswQUkyVAdKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="133058894"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Apr 2025 02:48:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 02:48:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 02:48:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 02:48:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Id1CILBn6O426ePa1PoNUA02xGZ6QElT61akrkeI0UBnXtTTKD1zlEpAZvTW16ObALEHN4fsMv9NjxqguBwKnIs4NUrpV1Y4bnrP5kqSrZVvhrt2BPxXFwusNtQLkIF/xHPAZeaaxqEJ/OOCy0MAO2vQF5/t1CJW62TiRxItk+8TkBmZ9KEH8Pdzr0wPbAex1XU1dv0/BU6T2nnY1WkogVtXvrryxrfeltAEHYIYqUBrtpux6WPuT4Ak50ehHkNelAweIVyv/QBjFNYiLZYTalbCfnSTY3+WZwVWFyrzjsd21ioBPiErnPqT1zD88Z1GQnJBW3mYeRwwgXpEuYSmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ntxMVALMlWDI1ogr3Z7kshj+UFGvQHezwVRkXYWb6A=;
 b=ncQSPHqNvP8YVayn/PrfXNPm4IKTQmHi5exJWQkrrZRQGCM4KpGx9U2xc7uYzZotACSEjDwwKBTiMW9NrrZMRDQwMciD1GVJYcTuMkmCWeC/5D+4QJiXddGHw6BGrTU3fR/UoxKkqVnGILeOsTjfI+QbokPTYhsGqKTsNqW2MPNi4azOEACbi01C+lUiQQZITaZB9bsG8GNACaHHYhFNkwxkf99VvprzDjom58pXjPb+OoBqtdPoxu7JGd6w2wSDLn/9xF3VGUiuRTVP/bvUxnQ2q3OZoElmfYEhEm3n3QTSwYm8VMDMDpETd3f9/6SBj9e7y6pPEemVdBp9UhNeoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8832.namprd11.prod.outlook.com (2603:10b6:208:59a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 09:48:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 09:48:37 +0000
Date: Mon, 7 Apr 2025 10:48:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] allow easier use of high lcore-ids
Message-ID: <Z_Ofcb4ktAmn2RqJ@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
 <Z-vzAS8TXWn9WSV0@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zcFU_K0feJMK=YEouyxYxwURUPQq7EGcacJ++RxoTuEw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zcFU_K0feJMK=YEouyxYxwURUPQq7EGcacJ++RxoTuEw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d22ab3f-e00f-41a5-2e5d-08dd75b95ec8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXVaanRSNkFhQzhLU2VHZkJIeUdVeGdJeXV6dGljaC9HU0FYR2ZZY1ozTkUy?=
 =?utf-8?B?LzBXTVNXOVJUakN2VzBQREd2Vm9uU1BLcTFHd0RHQmVrMUh6QmF4VXU2eUx3?=
 =?utf-8?B?R2k1Nm1NeFhiQ2N2ck5EcUU3aTU5MllhY0UwVndJRFlSWE9UbjhXcHI4RG9n?=
 =?utf-8?B?TU5hdWR6b2RFNTVpN3dWdlRjbVhoemx5ZGk3T3N5NFdVRmRQblhlbjE3M3Uz?=
 =?utf-8?B?Z0JhSG13U0dXelNJa1k5VUp5d2hqRHRsNGxOcHF2dG1VVTZ3TENyZlVWK2ht?=
 =?utf-8?B?anVMNTVmaGZZK09QOGZveS9icVdxRkZwSGFuVS9TTUNkcVdDNy9HZzNwU1pO?=
 =?utf-8?B?ZjJRRWZLcGpUbEVzWDJNajFTM3N5UDMwamg1THgzTStaMWNUV3E2N0pzVVdL?=
 =?utf-8?B?QTJlWkhySDJHZmVzcUJIT2NIa0hKWjdCL3ZuOFF2MG5JYnFqR29saW9EMFFq?=
 =?utf-8?B?VTZMQzZGRmh1SlhKeWtYNnVJVXM2emh6WjRGZWV3Y2ZUbGxMZWRyc0lPK0RB?=
 =?utf-8?B?NGtjMVFMY2t1VFp2eEVjZU5FaitISzhjSTlBcnZKOFgwdWNxc0NqQzZDbk9n?=
 =?utf-8?B?QkhLdzhJSDRNSzJMWW5Ed3p1d0xtYUU4eWg2UTFrK3VFNEVBTFpVV3k0VGJX?=
 =?utf-8?B?Q3F0QTV2c3lPVE9TVEZHdjVZbTROZ1g5UE9COEJkQ1VGaEtnNnJqdmx0cFE2?=
 =?utf-8?B?dWdUYklSRGRyck9pUGRoYzdMWUJsbHByYThkbitqZ1V0WlhKQ3hYSkxkMm9W?=
 =?utf-8?B?NzN6T1E0UHlOWUtXbGUzN0Z5NnRGdmcxOU5QaVVtNDdWS2YxNDJ0VHpFYzlR?=
 =?utf-8?B?blRSQUNyTGROV3Z2UGFVK1BOMUxyblNWUzJuNHFZVVJEUmhoOGxGakpDdjIx?=
 =?utf-8?B?UmVia0lya1dYenpkNzBpNWIrak92WlJOemVpVGg0aURMK2hMZEkrSGlyU2NF?=
 =?utf-8?B?Q3ZTcXRHQ2lKZUZmQlArNHgzNU1Ga1ZMT0Y2Zys1VWhHaVhZeDZua2c3THlF?=
 =?utf-8?B?QmF0d1RyM0ZLUGhGd1NLODlNRDlSZkpWUkNvV0sweVB5QWhxQkFHV25ycGJR?=
 =?utf-8?B?N2xQVmp3cHJNdHh0ZklBL1FoVFhDa3Y1U3d1T1pMNWc1bmhzZ0pWRHVUOWpt?=
 =?utf-8?B?NmY1RjlWaUMrTzhDOGpqMWV5S0ZSc3E2VERJNW9LY1RsS0sxRGFzazh4T2hS?=
 =?utf-8?B?dUpsQlJ4Uk5Pc1Bsd3UwNlZlVEozSE80T1B6UjNwcFBVSGI3NFRJWE9uUGpm?=
 =?utf-8?B?Tnl5bHBBbXBPTjNteDhaQXl5Um9zcTM3bFBLdDBDdGNZREFqL3p6QmIvOUJ2?=
 =?utf-8?B?MEVlUjkzdDdFcTBFbk1ZUWRlN1BwNjhsamREZE1VMUVJZWgrMHo1R1dIZ09J?=
 =?utf-8?B?RDNnbGdZSm52WG1xb3pxT3A0UVZLY3M4dmp3MW50bWtwQStPSzZCNU4zQXB0?=
 =?utf-8?B?eFoyU3Z4YmpENEs0anJZZlRJQ3duZUloZVRrU0ZENmJPZ0I0dDZsclBKM3Er?=
 =?utf-8?B?U1hpVWhJV1VIdHMrVktqend2OUNzcUl0VTIvRm5nS0hrbVFEdCtWeFRDUCs5?=
 =?utf-8?B?cThDTmtYdHp2dXU1TDd4Q2szR3pvZnV3WDhPOWVnbGYwQ1Q5R2ltWTNja1JB?=
 =?utf-8?B?YzRBTVBFQzEwS0xPSEdLYVpybzVCcHYwSlJrU1dCQkR5V1puOFoxbmF5UWlC?=
 =?utf-8?B?TTZLYmRFbUFTbGdDb3Q5ZUMxd1hwN0lGNjhDK2J3akFpNjUzU0VjdFM5cU8z?=
 =?utf-8?B?dVR1ci9HUHBiVXVrME9VcC9YMGdRdjJyUm9vQldwTnZRdE81eVFlS0lraFpi?=
 =?utf-8?B?eEY0M2Nsbm4wSldYbzNYaS9BSFg0bjEweHVZMmVCUHRzTVVkaDlNZWljVU1G?=
 =?utf-8?B?a0tZYWhUNFBkd2RxeWhzajdPck1YZU9ZTS9ISllUZEdKRnAxbEh3OC9uVklC?=
 =?utf-8?Q?1ZOsaj3eJpE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzEvWTQyMEZhTnpnUFZXdW1rS0Nqd3pldXBiZ29CNndraGVrbTVXNkhadzhF?=
 =?utf-8?B?bTluSHFHaHhWWWI4akdiZDRlV2JaNGJBSDdIZ0FVcHk2Visra2dGZ0xtNkRG?=
 =?utf-8?B?ZXZXZ2Z4K1RSOWtNS1dxbGtmN091L3krQ0R0YWlNd1F0b3JUenJjbUtZeWJV?=
 =?utf-8?B?amxGNCtKZ2hUNkV4M3RYT3hyY0tCQ3N4aFdTSFVKRW81UDB3QTA1elBkYko3?=
 =?utf-8?B?ekVBT1ZNalZETmdWMkxyVkJrUHZSUnU2QTE4VDdYV0xpL2RBSVVHYU5rZ3ho?=
 =?utf-8?B?MzJmb2ludU9JaU9DaUs0WmNjYWpJNmFrN1g5clJaODlTcGZOam9BdnRRTVFJ?=
 =?utf-8?B?em4yZDduZTBBZ1dwa20wVS8yZHIrS29xYmRGbkZGL3cyUVMyMmUrUGRIcitx?=
 =?utf-8?B?MXZtK1BkVFBPU1JMMkpKZGJUQk5HUDBqV3p1Vzg4ME11cFZXTGJjdm9kbkNZ?=
 =?utf-8?B?MTlQelZlNXpucExUb09DdDlRbkE1R0E4NFEwdUJVYlRtUHFkU2JXSmFxVDAz?=
 =?utf-8?B?dmFuMzh4a2oxQU5pbmgxMjVWK3BFRkd0T0RyQnZNVEJyT3dDUWVQeFFqY2Qz?=
 =?utf-8?B?NHRoTVVKMElYWmRoVjJ2YjdJRmxXc2EvaUNZbHlvUUdJSEZEbGl5TStyS3Vn?=
 =?utf-8?B?UlRlU3JxRmRBWmZkTTNvVm4zYk9IcGJ6MHBmeEdDdTN2ekpGckhBZHM5L3Qr?=
 =?utf-8?B?UmthY2VSMitqcWFwNEZodjMwK1QrQjJ5cnUzWGVJZUZNVkRPenVINlVDVEln?=
 =?utf-8?B?WEVzL1pvRklncUJURURua3ZIY1p5WEU3OW4xMmpUOGRpdzNNZDFLNGNzU20y?=
 =?utf-8?B?Z2Q1NS9hNnhQNEV3dlZXNWtHNmNrR0MyZS91Uy9GRjBxd0lPeXZTUnZKcVB1?=
 =?utf-8?B?YzFlY1o1QTJsNHRreHlVZnRKTkpBNVZ2T1JadjlrOWZIOC9DRFlUSkQ5cDkx?=
 =?utf-8?B?eDhxblFvMXhaQmlSZ0pxRFJjVStTMlMzWW5Zb0ZXK1o5c3dYRmw0bzhqbnAz?=
 =?utf-8?B?ZnA4R1JiS1FaQlI3QTlXNGlRQlZFUGVvVzlNSXNVN0FBYS9NWFl4M2xYWUJN?=
 =?utf-8?B?bmtZYjNNMkFiQXdWRXVxcnhlaDgvN3pXUGVzaTM2MlhacHd6WHlEMmp2cUFI?=
 =?utf-8?B?R1d3V2MvNGpsWEdsNmlBTmQzaGtTU3RkYVh0RU5hZ3lJa1BVRi84N0huSWlS?=
 =?utf-8?B?djg3a0V2NVd0dEdITzhpSHpwWWxQSTN6M2lrZ05QUkZMbzlXWm0zQzZNakd5?=
 =?utf-8?B?TTVyRDU4K2F3UnljT2dVZUYrMEE3U3h3UUNXc0hGUUp6QU10cUxQSHJ1ejRW?=
 =?utf-8?B?bjRLbzlxTk1lMGxyQ0t3Q0wxSUN5N2NFN1ZkM1ZWSGIzRnlRVFVrNk0zMDYz?=
 =?utf-8?B?QlBlY29UMm1iTGhzQTM2NlF3RzNzK3AvWVh2aGl0V0d5YkxPd3hWVEEzNlBm?=
 =?utf-8?B?NFpwdEFVTU9hSUhoMlFRTVNIQWZralFpb1Y2SEpUS3h3bExFcVVPTEN2a1Zp?=
 =?utf-8?B?NUJyMU1DQlVkMUIrY0RsYjZ4V01XRFA0Mm50QUY2REhMcVNNaFViVzdBTE5G?=
 =?utf-8?B?YS9PY2dhV25PdUYveGlEZTdsRTh0aXp4UzJ1YWk5bVpDYzRUUGo2cURrWVN6?=
 =?utf-8?B?R242L0szcThGSWIzaW5lNWdXbnJoVENmZFVldjBaK1RQRlFxSHMwTUV0YVVu?=
 =?utf-8?B?bEtqcG9sT3VIbUNTWWxLMFpKTnlvWU4xdDg2clF2d0VWOVQyWGRJeUcvRVp0?=
 =?utf-8?B?N0FqU0hvVjU3N2Qrc1I2R3dKdEdmVDR6L1pNNUpUSFI4b2x2aDN3TVEzeHBv?=
 =?utf-8?B?ZlBEV2ZTMVJ0NmN2NTdIbjZTL2orb1dDbGxKK3lWTllXcmJLS1Q0Tyt0RFFV?=
 =?utf-8?B?U0J5UmFxZE9KOGxjdFJ3Mld3NVluQm92ekhqTzhCNDJQLys4TThpTHNrRVhl?=
 =?utf-8?B?eDVldi9sWkxUa2NJUnoxeHRrN3gxdDFuUVdERDBKYnVMMHRubWFFaVR4VVpj?=
 =?utf-8?B?aHRReGUzWHR6OXlYVE13b0RGTThCeEtCSG9uY2dsM3N1cXNWc1NjUVJCM3hp?=
 =?utf-8?B?b0dwTE5mZWV4c2FUR1VlZlZuQS9Nbnh3RkFYN2ptU3FldzFVTnV2ak9rVWRG?=
 =?utf-8?B?eW43M3RIL0MwL2hWajFoSkIveVkrQ0tLTGM4RVJwSmVOeHZaUEg0RFhheXE4?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d22ab3f-e00f-41a5-2e5d-08dd75b95ec8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 09:48:37.8441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsrsj+mV8xju65+hod6P7hrS66iaRQ8nmDgoU6GM1+JOWCTswAqSK5bDw7infxquuqkDv4mK/jhXEe/od/WDf8oZcO3R86QuWdBPGLjIsFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8832
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

On Mon, Apr 07, 2025 at 09:04:05AM +0200, David Marchand wrote:
> Hello Bruce,
> 
> On Tue, Apr 1, 2025 at 4:08 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Mon, Mar 24, 2025 at 05:30:26PM +0000, Bruce Richardson wrote:
> > > Traditionally, DPDK has had a direct mapping of internal lcore-ids, to
> > > the actual core numbers in use. With higher core count servers becoming
> > > more prevalent the issue becomes one of increasing memory footprint when
> > > using such a scheme, due to the need to have all arrays dimensioned for
> > > all cores on the system, whether or not those cores are in use by the
> > > app.
> > >
> > > Therefore, the decision was made in the past to not expand the
> > > build-time RTE_MAX_LCORE value beyond 128. Instead, it was recommended
> > > that users use the "--lcores" EAL parameter to take the high-numbered
> > > cores they wish to use and map them to lcore-ids within the 0 - 128
> > > range. While this works, this is a little clunky as it means that
> > > instead of just passing, for example, "-l 130-139", the user must
> > > instead pass "--lcores 0@130,1@131,2@132,3@133,...."
> > >
> > > This patchset attempts to simplify the situation by adding a new flag to
> > > do this mapping automatically. To use cores 130-139 and map them to ids
> > > 0-9 internally, the EAL args now become: "-l 130-139 --map-lcore-ids",
> > > or using the shorter "-M" version of the flag: "-Ml 130-139".
> > >
> > > Adding this new parameter required some rework of the existing arg
> > > parsing code, because in current DPDK the args are parsed and checked in
> > > the order they appear on the commandline. This means that using the
> > > example above, the core parameter 130-139 will be rejected immediately
> > > before the "map-lcore-ids" parameter is seen. To work around this, the
> > > core (and service core) parameters are not parsed when seen, instead
> > > they are only saved off and parsed after all arguments are parsed. The
> > > "-l" and "-c" parameters are converted into "--lcores" arguments, so all
> > > assigning of lcore ids is done there in all cases.
> > >
> > > RFC->v2:
> > > * converted printf to DEBUG log
> > > * added "-M" as shorter version of flag
> > > * added documentation
> > > * renamed internal API that was changed to avoid any potential hidden
> > >   runtime issues.
> > >
> > > Bruce Richardson (3):
> > >   eal: centralize core parameter parsing
> > >   eal: convert core masks and lists to core sets
> > >   eal: allow automatic mapping of high lcore ids
> > >
> > Ping for review.
> >
> > At a high level, does this feature seem useful to users?
> 
> This seems useful, though I am not I would touch the existing options.
> I would have gone with a simple -L option (taking the same kind of
> input than -l but with new behavior), and not combine a flag with
> existing options.
> 

That would be an easier patchset to do up. However, it would then mean that
we have no less than 4 different ways to specify the cores to use: "-c",
"-l", "-L", "--lcores" - and therefore need 4 different sets of parsing
options for them, and more checks to ensure we have only one of the 4
specified in any run. That's why I chose the modifier option, and to try
and consolidate the core setup a bit.

However, if having a completely new option is preferred, I am happy enough
to do up a different patchset for that.

> I scanned through the series, not much to say.
> Maybe add a unit test for new cmdline option.
> 
Sure. Once it's decided what approach (if any) to take, I'll do up a new
patchset, taking into account any relevant feedback on this set.

/Bruce
