Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA49CCD185
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 13:48:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFD0E40285;
	Fri, 10 Oct 2025 15:48:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 838544027A;
 Fri, 10 Oct 2025 15:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760104129; x=1791640129;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8B8kLzPZBgdQrPHU2tmWrerZicyaXFR0laAgjN3rgPM=;
 b=HUF9ZMMFm/jrtX11LG0AQNJizlgpSidzbZ6zB1twsdVU8SvpL18NuCPI
 edueVQ0pky1n0UCMxuBiVcmtGba1nK4eR3jOvyM+7991p1tVY7JTifnx9
 FQWxjzWQGu78jG+3+/JdNHG+LRLNzBqVOm5vU6FxUYjj3+jW7V5Z3wx9q
 dEFERWW7qLsDMMecEZRSnEAlz0B5ZMzAvSceRcX7zFHJig62rTMDCDUsc
 LzdSXAmNrU/4ZkQHRmiANBArKQvYwiNuUvw4D0J72Yz3ZvQwQVOFLscGn
 r0NSEn8jWczfz5vo1XWaOChRqC57hQ1y6WvShVHBh/IgO0TFSOY0OmWeX w==;
X-CSE-ConnectionGUID: 0DNIgti7ScqUFFIHQZxfvQ==
X-CSE-MsgGUID: xJ0kvZHcRZiwUjhd5F8EHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="61355492"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="61355492"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 06:48:48 -0700
X-CSE-ConnectionGUID: J0AI9BUCR+eibHeA/a98Aw==
X-CSE-MsgGUID: /oKVYQceRC+7+ytLDwl77Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="180933006"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 06:48:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 06:48:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 06:48:46 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 06:48:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL9wxH2rz1kj1lbdItHTqv2CKqO1EiPFIxoerNWZINlmXtFtBOhdmb7EfFuHGzLOviT6Z0olbErOUi+GPuRGGSNhxvYk7+Y3sC/ugJgHBncK56inOz1kJIsQOEEU24Q4CtbM1QFhnMmCVsEPKKb94g/mRzO0GAXcfskGBHxArG007jphciLfzqKIPPOr1axJPVl7YElyicAUzsjVxHeRkfeOpz+LGdIZYXauKr3gFDNCE2Xv+3bEsbwRnw4bXxjQOZOpwsko36Q9d6x7WKw+5MjSVxSuhib6/piiWKLAnHetrOEl3heXePpKaCwkn7U16EJlIv5Fl3jZoiVnfGzeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B8kLzPZBgdQrPHU2tmWrerZicyaXFR0laAgjN3rgPM=;
 b=FxOGam9yrS7N2TSuhpj6Uqhsoy5sghoqoFnZhidhX/M6ISnm/c0jq9eIF68//Hjw178+p+fXmnnjoBR5j2G8eJL+VGNGVyZrFh39tyMR30Srje/ESsPiNOn+cCUeegn6juy9Kx9HqWdfSKgYLhZQb222pHWEi+HavuQs8pxUlc5GA4W5W9ZSVb6j74IzYO9Wq8P0kkSsAIKgsp3uNEjbHn9b4v05nrVeLOUQbvfJPxBuvlDMR/SFnKutOQCOVCk9BjwohXpzevz+uv8xHIsMdCneLtBcFqFCEEyPxFcxt7K197NDxLOcvFSaLeM++DE+rZPd0LgKpRu24CWOK3u+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA0PR11MB8417.namprd11.prod.outlook.com (2603:10b6:208:48d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:48:44 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9137.018; Fri, 10 Oct 2025
 13:48:44 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
CC: "techboard@dpdk.org" <techboard@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Miskell, Timothy" <timothy.miskell@intel.com>
Subject: RE: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Topic: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Index: AQHcMU3AqHIGIyG6mU6GyIhfLzcII7SrcJsAgAGJkoCAA0L78IAH2KkAgAGWzBCAAEs9AIABffxQ
Date: Fri, 10 Oct 2025 13:48:44 +0000
Message-ID: <IA3PR11MB8986D47057F5DE567C811B548EEFA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <3977268.0vhOF50zNu@thomas>
 <PH3PPF7DB70F9CE21D69B81237AB58593BD8EEEA@PH3PPF7DB70F9CE.namprd11.prod.outlook.com>
 <2774555.irdbgypaU6@thomas>
In-Reply-To: <2774555.irdbgypaU6@thomas>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA0PR11MB8417:EE_
x-ms-office365-filtering-correlation-id: 9e133831-b81e-473e-4515-08de0803bae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OUJUOFgxbnlnMjEwWlF3SDJkdEliTEpvMEROSmZZNW5MMGc4WVBsMW8vUmJo?=
 =?utf-8?B?NWx6WkhveGMwQkttY3RtUlVLTzA3alRuYjkxOG9EWE01b0cyUWNMRnFqMlZM?=
 =?utf-8?B?R2RiTXZyK2pkaFZZa0N2Z0Rhbmd0dFk0Q0RZRmpFZEFuamIzdFJvQW8zMU9x?=
 =?utf-8?B?dmdTMmNQYzdLSkJuWXhhNTJsQzNXTWUxK1pVeEYvNi83K214OUt1ZUFvVGM4?=
 =?utf-8?B?SEZPLzNBMHZWZjZWM25KMTRMM3l4bXZhbWJmTnJTaFJheXc4VGhLcWJFdTIv?=
 =?utf-8?B?cWpVYTRyQ2ZPT3IzbGs2blA4N2o3Q01NVWRFREZscFVmV0E5eVd1bFdRcDRG?=
 =?utf-8?B?b3ZHMGpla2VERldmaWZBL3h5UzdNNG9pSHJDSzBxVU1ySDQyUTFXRnV3R1Fa?=
 =?utf-8?B?UEdlRkxVUWtzRVNnU05MVmpyVEt6c2wrNlo5LzN5M1duaDZuV2J2ZkJQZGR0?=
 =?utf-8?B?RkdoWFVZVXR5VWV2dmVKQjBweGlELzY0OHNENXRrNXN6QUhQVzdZQVN4WFRO?=
 =?utf-8?B?ODM0V3NtRUFFZzBWT0M3QTFpdEhMbG5aMG5nREl3Si9weC84SW41MlR3NnRQ?=
 =?utf-8?B?TzV6S2pQeitkd2JLbVZkeVJtSmU2cmtzUkF3VUdxUGJ6N2p6NXZ3SDQxdnU1?=
 =?utf-8?B?aGNyVGJxSFg4REFOaVlrR2I5R1R1a25BYVZTSmNQSHBXbi9IZ1RJVDJ4L0Nn?=
 =?utf-8?B?dXZMSFlmMDhJTEZFMi9kbitweUZPTUxBblRLRkQ4NVdKYU1rWkJVeDFRSlg3?=
 =?utf-8?B?Q2FKQTl3Z2JvNE1iQkc1d1pFZWxjZytQTkRFWXdYTWRoa0VVWjRJdHdzcGJ4?=
 =?utf-8?B?ZGFEVnYrTE82TW9NMlMvWUltMlF6ZTBuKzBmK2pjUTN4RGh2TmRPWlNGeERj?=
 =?utf-8?B?WDAzcmd4V3U2Q1RRNTEwczQ0a055MWM3cmZJeXFuZGRIeVVxY0lwcFVYcUM0?=
 =?utf-8?B?eERCYTFNYUZSTDJabzhJU3NSSEh3UngzcGczV2FCUFcyVDkyWjY5d0xRRElt?=
 =?utf-8?B?UldPRG9zbFphMmpiNWtWSjRYNC91QXpRc3ZkMnUxQ0pUcmJYdWFNMVV6K3Mx?=
 =?utf-8?B?VVQzVW4rbjJKRE80L2tyRk1FQ243UGhwOVZUTHFhMDUwTUZIdVJvci9PMnB3?=
 =?utf-8?B?VEpSeDFsb2FxM2w1YTI4cEkrSmJweFppZG9DREM4cDhFcVJWSzg5UGtjMjBB?=
 =?utf-8?B?QUdFOWFDVnk4WEFwZnBWOTFlbS9CWkhORE1UbVVJWGZTNVVxdVZoT095ZTVs?=
 =?utf-8?B?aWNQVFZVOTVYL21xdU1wcnhlQXBNelZ2Ni9IT3oyVk4vS3dlZDA2d1RnTkEx?=
 =?utf-8?B?YVpSUU1Qa2p3YWNLV3FNMmZMZjZNMHFwbWlSeHpZMy9CTFRuSWFRb21rWjZ1?=
 =?utf-8?B?RDFKMVJ6TEZRT0p5UnE2bEhFTnNPNHhHVjdYaVdZT21FeUl1YjJDMXorTENS?=
 =?utf-8?B?SGRZb0c4RGhpeTRMLzF6bElObDRxK1h1V1NJM3JZMU9GcDhFRzhCZENpeDRn?=
 =?utf-8?B?NDYxMzYzT1QydWMwV1FCN3ViVGJMWktWRXJWdkxsWnlCTVFCL2hVN3BvTXg3?=
 =?utf-8?B?SjZkLzlLVmE2cUVTaGtyMHNmcU9MNDZBb1E0TVJKZ3hVT0UwU0E2cDBaYUU0?=
 =?utf-8?B?TzNZSkNCMGlINmIwUlNyZDNCNE11d2lPRjF2aTZSOFd5bkZ3SDREK29kK0Zl?=
 =?utf-8?B?L21QZ2YyRFE3MUFsZHQ0YVZmaUp6b3JXdmxqMWNScXg3TDNTbXhjSWpqL283?=
 =?utf-8?B?bTN2Znp4dkgxRjZlL2hTUzNlWHpHaG5ST0toZ0lxcTdUK0p2LzhiSkZSbDhw?=
 =?utf-8?B?YjFqMzRSWHcyL2NuMWhBT3NMdkhFOGpzQkpVYW1GR3YxdWlUb2MxOUhlTUNm?=
 =?utf-8?B?a1BVMllBN3U3a2ZYVXpoTyt5YnY3Y2Q1eElSTmRiUS81UUlNeWw3SjlmU1JK?=
 =?utf-8?B?VDMwSEVhYWhrNTV4L0k4OHBEVnZvbUcwQUdqUE41VkRVdDJGR1oxem9zR0E0?=
 =?utf-8?B?bk5BUjhrMm5DZ3ZML3NkMVlkNmY2QWIrTVlGdEVrOW42R21zbDcwOERqcXJQ?=
 =?utf-8?Q?UdVMAU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzRRQitYWStISHlXNU9JT1NtT3ZOZ0NPQldnL2lRUTJhSGhDdEhOS2ZZbzBF?=
 =?utf-8?B?cm5uVVVBaSs0NWhNMTJvYXFTS0xrY0dmOUVBWXRDRU5veThaSXgrMHp6WGFs?=
 =?utf-8?B?YUUremRUZVlBanZVQTFNRXhlaG05cU9VYU5nc3NERDNMd2JMenErT2FoMXVU?=
 =?utf-8?B?Vm4xUFZIRWhSeFgzZ1BneDE2RUZjTUgrZExMa3ppTVIrUXF2bVNCTlFJNTRl?=
 =?utf-8?B?UzBoMDlJN3VHMFRVTWFFWTRDMForMTRySlRpRmQyWkNWNDNvRVoreDcxUHBB?=
 =?utf-8?B?M3hKWExvQVpNK0pUWXBlWUcrVWNwUUZvam9tZmFQTjVnd2ZibzhrYURTNTZW?=
 =?utf-8?B?dVFvblE5emdlNnh4L1h1SS8xbXlnR01TVFBaclQ2RjhvV0UzZGJlYlozejFC?=
 =?utf-8?B?akNzR3k3SXgyWGFWUHk0V2k4eFFlZzQreDc4NlJBWmZJZDlWWmxaVElnb0k5?=
 =?utf-8?B?V2pVWmFvQ0s1WFJzRUFJNmFGc0RYbXUzVEtEdTRHYmU2TDZuOHVrcFhIajZB?=
 =?utf-8?B?cHlUODBpek9UNmNIUmZGbjJEMHZkdnE2NDM1K21yemFvaUR3SnRUWEszTWNE?=
 =?utf-8?B?OGlBbjBzaXhXUVJTd1lrMXVsWTRLRVMvVjZRaC94VjVoOXRGNnQ3N0dOdWRG?=
 =?utf-8?B?NnFVd1c4djZiRVJqUFR5N2ErTDdjOVFFanArd05PbGRJNzVMZzNqZzFsbWl0?=
 =?utf-8?B?eFZmbE93NlZpUklGczlNc0kwZGRhLy91NUdtajEvMkdENEpLTWN1U2NpVkN3?=
 =?utf-8?B?MHBrUWkxU2JMN1ZWTjJPVzc5UjRCYmk5cE1EeGdLRGNPMWpnbGhhNlEyT1dE?=
 =?utf-8?B?bjlaZ25tbEZBUm8ycWFGSkxXZmJjSXJvaUxHYjQ1RXBNQW9YbmxySU44MkRT?=
 =?utf-8?B?R3FkVWNtUVRkUjcybEJkY3lSdWlNMVo3OXFJV0pONHZ1N2J1SW1LNzFvbE91?=
 =?utf-8?B?NzZVOUlHeEV4Y2ZRWUhTRkZOUWd4ZGZRT0dFTVJYWHlYbTQ0dW1aNUY5ZjFB?=
 =?utf-8?B?bGhhZzE0RkhGbWJ2dWhlOW5YbGpCQXJNZVpBWERPSFpzRzBRVE5QM0UvblBr?=
 =?utf-8?B?TThZQW92RWk1dk0xRmNMUngyenBrQUxQVlh6ajdWUmt0WjhWcGpYbEdHK2o5?=
 =?utf-8?B?MGJXWHovU3NmYVBoRXhnalBCTnZXT0ZRaEpXRi84aFhOZjIvcTV6VWJYZFEr?=
 =?utf-8?B?eWllU0ZuVTBGMWVTQmpYUTducS9TeTFhSnViSWVOaWVUN2ZWZWwwV0hMVS8w?=
 =?utf-8?B?Y1JOeVMwUnVhOVg3bGtSeGlQMUJWdXBPeHpjLzU5U2xCZk02OEd4QjNJUlRh?=
 =?utf-8?B?bGJjVjM2L3UxNzJ2MHpCanAwM2hVdkFER2tib3M2SmVGMEQzYUFMNE5NM0N0?=
 =?utf-8?B?ZEJmaFZQZFFMVFVGd0wyTkIwUHpwOUUxSU81RmptcXg4QSt0NkNvSC9XYU9i?=
 =?utf-8?B?cldaSmd3UUt6SkpuakZTYmJGd3U0a3p4blFHN3dqb0Z2bVlEWmNxYzB0ZmZL?=
 =?utf-8?B?Q1hpTDE5YWZ6N0dVV1ZuUldCbUVmQlBLNm00ZlVTVDNmTVk5L3BWWWtYRmYw?=
 =?utf-8?B?Ynh1RldmUkhTVkFNMG9yOHBKTkJKT29pTk5yK2xhaTZKdjhNZDF5M0pIZVVL?=
 =?utf-8?B?ZzhoVzdWbE0rTmpMckFBOGV0YXdzYVFKajBEZStSR2s4VjBMeEp0Vm5VcUYy?=
 =?utf-8?B?QjllNHVST2hDWE85bW40SE1aeW9HQmg1dWgzeSs5WGdyVHFBVDliK2xsb3ly?=
 =?utf-8?B?Y1Q2TTFvUGJIYSs2VTk4dVAvOStaeUdhL1VZZDBNMWNwU1B3K2xBQmVJOXpp?=
 =?utf-8?B?SlBJVGkxQUF4MTRKbzVkYkw1WUl3cEdVWnI0RFN5TVRKMW5GcVYySnN4WnRk?=
 =?utf-8?B?bFk1NjAzdllBdENwUmFJZk9QS1UvdG5iTmxHZDNqbHMrTUx6Z0VsYTVYc1pB?=
 =?utf-8?B?bXgzcVcwTmdRUmJSTnU2dm1RS2pnQXZHempQaHk1VFAzcFNhTVROdm5sNzNu?=
 =?utf-8?B?WmsvZmZKWHN4OGtvei9GMEEyNkZvc0VkbEVQV3cxK3c0cC94cDZFTzFDK1ZW?=
 =?utf-8?B?T3lUZnJMQUo3aEVzalI2aDNmU1psTXV6Um9CeEZDcVV1SmQzUTIwSDhSQXlR?=
 =?utf-8?Q?islEeGhvi9RdJlOHRLuYS0Atm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e133831-b81e-473e-4515-08de0803bae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 13:48:44.6160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ml7rfwVQKpV5ccAgCTWeUs/ix4bKn3zDZe3r/5j70ZjOwmKkOiXxW0gHahlb1EdHDeqa5YnYpsDLCTT+FPxDCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8417
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

PiANCj4gMDkvMTAvMjAyNSAxMjozMCwgTG9mdHVzLCBDaWFyYToNCj4gPiA+DQo+ID4gPiAwMy8x
MC8yMDI1IDEyOjI5LCBMb2Z0dXMsIENpYXJhOg0KPiA+ID4gPiA+ID4gPiBJbnRyb2R1Y2UgYSBm
dW5jdGlvbiB0aGF0IGFsbG93cyBhIFZGIHRvIHJlcXVlc3QgdGhlIFBGIHRvIHJlc2V0DQo+IGl0
c2VsZi4NCj4gPiA+ID4gPiA+ID4gVGhpcyBpcyB1c2VmdWwgZm9yIGV4YW1wbGUgd2hlbiB0aGUg
YXBwbGljYXRpb24gZGV0ZWN0cyB0aGF0IG9uZSBvZg0KPiB0aGUNCj4gPiA+ID4gPiA+ID4gcXVl
dWVzIGhhdmUgaHVuZyBvciBhbnkgZXZlbnQgd2hlcmUgYSByZXNldCBpcyByZXF1aXJlZCBhbmQg
dGhlIFBGDQo+IGlzDQo+ID4gPiA+ID4gPiA+IHVubGlrZWx5IHRvIHRyaWdnZXIgaXQuDQo+ID4g
PiA+ID4gPiA+DQo+ID4gPiBbLi4uXQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEluIGdlbmVy
YWwsIEknbSBub3QgYSBodWdlIGZhbiBvZiBhZGRpbmcgZHJpdmVyLXNwZWNpZmljIGZ1bmN0aW9u
cyBhbmQgSQ0KPiA+ID4gPiA+ID4gZmVlbCBsaWtlIHRoaXMgc2hvdWxkIGZpdCB1bmRlciB0aGUg
ZXhpc3RpbmcgcmVzZXQgQVBJcyBpbiBzb21lIHdheS4gVGhhdA0KPiA+ID4gPiA+ID4gc2hvdWxk
IGF2b2lkIHRoZSBuZWVkIHRvIHVwZGF0ZSAob3Igc3VjaCBhIGJpZyB1cGRhdGUpIHRvIHRlc3Rw
bWQsDQo+IGZvcg0KPiA+ID4gPiA+ID4gZXhhbXBsZS4NCj4gPiA+ID4gPiA+IFNvbWUgdGhvdWdo
dHMgaGVyZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAxLiB3ZSBjb3VsZCBhZGQgYSBkZXZh
cmcgdG8gdGhlIGRyaXZlciB0byBhZGp1c3Qgd2hldGhlciByZXNldCBkb2VzIGENCj4gPiA+ID4g
PiA+ICAgICJzb2Z0ZXIiIHJlc2V0IG9mIHRoZSBWRiBqdXN0IHJlc2V0dGluZyBpdHNlbGYsIG9y
IGEgImhhcmQiIHJlc2V0IHdoZXJlDQo+IHRoZQ0KPiA+ID4gPiA+ID4gICAgUEYgZG9lcyBhIGZ1
bGxlciByZXNldCBvZiB0aGUgVkYuDQo+ID4gPiA+ID4gPiAyLiByYXRoZXIgdGhhbiBhIGRldmFy
Zywgd291bGQgZG8gdXNlIGEgZHJpdmVyLXNwZWNpZmljIGZ1bmN0aW9uIHRvDQo+IGFkanVzdA0K
PiA+ID4gPiA+ID4gICAgdGhpcyBiZWhhdmlvdXIuIFRoZSBkaWZmZXJlbmNlIGhlcmUgd291bGQg
YmUgdGhhdCB0aGUgZHJpdmVyLXNwZWNpZmljDQo+ID4gPiA+ID4gPiAgICBmdW5jdGlvbiB3b3Vs
ZCBiZSBhbiBpbml0LXRpbWUgb25lIHJhdGhlciB0aGFuIHJ1bnRpbWUsIHNvIHRoZQ0KPiBydW50
aW1lDQo+ID4gPiBvZg0KPiA+ID4gPiA+ID4gICAgdGhlIGFwcCwgbGlrZSB0ZXN0cG1kLCB3b3Vs
ZCBiZSBnZW5lcmljLg0KPiA+ID4gPiA+ID4gMy4gdGhlIG1vc3QgZ2VuZXJpYyBzb2x1dGlvbiB3
b3VsZCBiZSB0byBhZGQgYW4gYWRkaXRpb25hbCBwYXJhbWV0ZXINCj4gdG8NCj4gPiA+IHRoZQ0K
PiA+ID4gPiA+ID4gICAgcmVzZXQoKSBmdW5jdGlvbiBpdHNlbGYgdG8gc3BlY2lmeSBhIGhhcmQg
b3Igc29mdCByZXNldC4gVGhpcyB3b3VsZA0KPiBtZWFuDQo+ID4gPiA+ID4gPiAgICB1cGRhdGlu
ZyBhbGwgZHJpdmVycyB0byBoYW5kbGUgdGhlIG5ldyBwYXJhbWV0ZXIgKHNob3VsZG4ndCBiZSBo
YXJkLA0KPiA+ID4gc2luY2UNCj4gPiA+ID4gPiA+ICAgIGl0IHdvdWxkIGJlIF9fcnRlX3VudXNl
ZCBpbiBhbGwgY2FzZXMgYnkgZGVmYXVsdCkuIFRoaXMgYWxzbyBvcGVucyB1cA0KPiA+ID4gPiA+
ID4gICAgdGhlIHBvc3NpYmlsaXR5IG9mIG90aGVyIGRyaXZlcnMgLSBlc3BlY2lhbGx5IFZGcyAt
IHVzaW5nIGl0IGluIHRoZSBzYW1lDQo+ID4gPiA+ID4gPiAgICB3YXkuIFdlIGNvdWxkIGFjdHVh
bGx5IGRvY3VtZW50IHRoYXQgdGhlICJoYXJkIiBvcHRpb24gIm1heSBiZQ0KPiB1c2VkDQo+ID4g
PiBieQ0KPiA+ID4gPiA+IFZGDQo+ID4gPiA+ID4gPiAgICBkcml2ZXJzIHRvIHJlcXVlc3QgYSBm
dWxsIHJlc2V0IG9mIHRoZSBWRiBieSB0aGUgUEYiLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSGkg
QnJ1Y2UsDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIGRpZCBub3QgbWFrZSBpdCBjbGVhciBpbiBt
eSBjb21taXQgbWVzc2FnZXMgdGhlIGZ1bGwgcHVycG9zZSBvZiB0aGlzDQo+IG5ldw0KPiA+ID4g
QVBJLg0KPiA+ID4gPiA+IEFsb25nIHdpdGggcmVzZXR0aW5nIHRoZSBWRiwgdGhlIFZGIGlzIGFs
c28gcmVjb25maWd1cmVkIGFuZCByZXN0YXJ0ZWQNCj4gPiA+ID4gPiB0cmFuc3BhcmVudGx5LCB1
c2luZyB0aGUgZXhpc3RpbmcgaWF2Zl9oYW5kbGVfaHdfcmVzZXQgaW1wbGVtZW50YXRpb24uDQo+
ID4gPiA+ID4gV2hpbGUgdGhlcmUgaXMgcHJvYmFibHkgbWVyaXQgaW4gZXh0ZW5kaW5nIHRoZSBy
ZXNldCBBUEkgdG8gaW5jbHVkZSBhDQo+ID4gPiBzb2Z0L2hhcmQNCj4gPiA+ID4gPiByZXNldCBm
bGFnLCBJIHdvdWxkIHN0aWxsIG5lZWQgdGhpcyBuZXcgQVBJIHRvIGZ1bGZpbCB0aGUgcHVycG9z
ZSBkZXNjcmliZWQNCj4gPiA+IGFib3ZlLg0KPiA+ID4gPiA+IElmIHdlIHdhbnRlZCB0byBtYWtl
IHRoaXMgZ2VuZXJpYyBJIHNlZSB0d28gb3B0aW9uczoNCj4gPiA+ID4gPiAxLiBleHRlbmQgdGhl
IHJlc2V0IEFQSSB0byBvcHRpb25hbGx5IHJlY29uZmlndXJlIGFuZCByZXN0YXJ0DQo+ID4gPiA+
ID4gMi4gaW50cm9kdWNlIGEgbmV3IGdlbmVyaWMgQVBJIHRoYXQgcGVyZm9ybXMgYSByZXNldCBm
b2xsb3dlZCBieSBhDQo+ID4gPiByZWNvbmZpZ3VyZQ0KPiA+ID4gPiA+IGFuZCByZXN0YXJ0Lg0K
PiA+ID4gPg0KPiA+ID4gPiBJJ3ZlIHN1Ym1pdHRlZCBhIHYyIGFuZCByZW5hbWVkIHRoZSBmdW5j
dGlvbiB0byAicmVzdG9yZSIgaW5zdGVhZCBvZg0KPiAicmVzZXQiDQo+ID4gPiB0bw0KPiA+ID4g
PiBiZXR0ZXIgZGVzY3JpYmUgdGhlIGJlaGF2aW91ciBvZiB0aGUgZnVuY3Rpb24gLSBub3QganVz
dCByZXNldHRpbmcsIGJ1dCBhbHNvDQo+ID4gPiA+IHJlc3RvcmluZyBjb25maWd1cmF0aW9uIGFm
dGVyd2FyZHMgYW5kIHJlc3RhcnRpbmcgdGhlIGRldmljZS4NCj4gPiA+ID4NCj4gPiA+ID4gSSBh
Z3JlZSB0aGF0IGl0IHdvdWxkIGJlIGJlc3QgdG8gYXZvaWQgYSBkcml2ZXItc3BlY2lmaWMgZnVu
Y3Rpb24gbGlrZSB0aGlzLg0KPiBBZnRlcg0KPiA+ID4gc29tZQ0KPiA+ID4gPiB0aG91Z2h0IEkg
ZG9uJ3QgdGhpbmsgd2UgY2FuIGV4dGVuZCB0aGUgcmVzZXQgQVBJIHRvIGluY2x1ZGUgdGhpcw0K
PiBiZWhhdmlvdXIsDQo+ID4gPiB0aGUNCj4gPiA+ID4gcmVzZXQgQVBJIHNob3VsZCBwcm9iYWJs
eSBsZWF2ZSB0aGUgZGV2aWNlIGluIGEgcmVzZXQgc3RhdGUuDQo+ID4gPiA+DQo+ID4gPiA+IEkn
bSB3b25kZXJpbmcgaWYgdGhlIGNvbW11bml0eSB3b3VsZCBiZSBpbiBmYXZvdXIgb2YgY3JlYXRp
bmcgYSBuZXcNCj4gZXRoZGV2DQo+ID4gPiBBUEkNCj4gPiA+ID4gZm9yIHJlc3RvcmluZy9yZWlu
aXRpYWxpc2luZyBhIGRldmljZS4gSXQgd291bGQgZXNzZW50aWFsbHkgY29tcHJpc2Ugb2YgcmVz
ZXQsDQo+ID4gPiA+IHJlY29uZmlndXJlIGFuZCBxdWV1ZSBzZXR1cCwgYW5kIG9wdGlvbmFsbHkg
ZGV2aWNlIHN0YXJ0Pw0KPiA+ID4NCj4gPiA+IEl0IGlzIGNvbmZ1c2luZyB0byBhZGQgYW4gQVBJ
IGlmIGl0IGlzIGEgcGVyZmVjdCBvdmVybGFwDQo+ID4gPiBvZiB3aGF0IGV4aXN0cyBhbHJlYWR5
Lg0KPiA+ID4gSWYgeW91IHdhbnQgdG8gYWRkIGEgbmV3IEFQSSwgeW91IG5lZWQgdG8gZXhwbGFp
biBob3cgaXQgaXMgZGlmZmVyZW50DQo+ID4gPiBvZiBhIGNvbWJpbmF0aW9uIG9mIHJlc2V0L2Nv
bmZpZ3VyZS9zdGFydC4NCj4gPg0KPiA+IEFwb2xvZ2llcyBmb3IgYW55IGNvbmZ1c2lvbi4NCj4g
PiBUaGUgbmV3IEFQSSB3b3VsZCBwZXJmb3JtIG9ubHkgdGhlIG5lY2Vzc2FyeSByZWNvbmZpZ3Vy
YXRpb24NCj4gPiBhbmQgc2V0dXAgc3RlcHMgdW5kZXItdGhlLWhvb2QgYW5kIHVzZSB0aGUgZXhp
c3RpbmcgZGV2aWNlDQo+ID4gY29uZmlndXJhdGlvbi4gVGhpcyB3b3VsZCBkaWZmZXIgZnJvbSBh
IGNvbWJpbmF0aW9uIG9mDQo+ID4gcmVzZXQvcmVjb25maWd1cmUvc3RhcnQgaW4gdHdvIHdheXM6
DQo+ID4gMS4gSW4gc29tZSBjYXNlcyAoYXQgbGVhc3QgaW4gdGhlIGNhc2Ugb2YgdGhlIGlhdmYg
ZHJpdmVyKSwgYQ0KPiA+IGZ1bGwgcnRlX2V0aF9kZXZfY29uZmlndXJlIGlzIG5vdCByZXF1aXJl
ZCBhZnRlciBhbiBydGVfZXRoX2Rldl9yZXNldC4NCj4gPiBTbyB0aGUgbmV3IEFQSSBjb3VsZCBq
dXN0IGNhbGwgdGhlIGRldmljZSBjYWxsYmFja3MgZm9yIHRob3NlIGZ1bmN0aW9ucywNCj4gPiBy
YXRoZXIgdGhhbiBmb3JjaW5nIHRoZSB1c2VyIHRvIGNhbGwgdGhlIGV0aGRldiBmdW5jdGlvbnMg
YW5kIHBlcmZvcm0NCj4gPiBzb21lIHVubmVjZXNzYXJ5IHJlY29uZmlndXJhdGlvbiBzdGVwcy4N
Cj4gPiAyLiBJdCB0YWtlcyB0aGUgYnVyZGVuIG9mZiB0aGUgdXNlciB0byBidWlsZCB1cCB0aGUg
ZGV2aWNlIGNvbmZpZ3VyYXRpb24NCj4gPiBhZ2FpbiBhZnRlciB0aGUgcmVzZXQuIEFueSBwZXJ0
aW5lbnQgY29uZmlndXJhdGlvbiBjYW4gYmUgc3RvcmVkIGJlZm9yZQ0KPiA+IHRoZSByZXNldCBh
bmQgdXNlZCB0byByZWNvbmZpZ3VyZSB0aGUgZGV2aWNlIHRyYW5zcGFyZW50bHkuIEFsbCB0aGUg
dXNlcg0KPiA+IG5lZWRzIHRvIHN1cHBseSBpcyB0aGUgcG9ydCBpZC4NCj4gPg0KPiA+IEFueXdh
eSwgSSd2ZSBzdWJtaXR0ZWQgYSB2MyBvZiB0aGUgbm9uLWdlbmVyaWMgdmVyc2lvbiBvZiB0aGlz
IGZvciB0aGUNCj4gPiBpYXZmIGRyaXZlciwgc28gaWYgdGhlcmUgaXMgbm8gYXBwZXRpdGUgZm9y
IHRoZSBnZW5lcmljIGFwcHJvYWNoIEknbGwNCj4gPiBjb250aW51ZSB0byBwdXJzdWUgdGhlIGRy
aXZlci1zcGVjaWZpYyBvbmUuDQo+IA0KPiBBIGdlbmVyaWMgQVBJIGlzIHdheSBiZXR0ZXIuDQo+
IA0KPiBJJ20gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgd2hhdCBpcyBtaXNzaW5nIGluIHRoZSBjdXJy
ZW50IEFQSS4NCj4gDQo+IEkgdGhpbmsgd2hhdCB5b3Ugd2FudCB0byBhY2hpZXZlIGlzDQo+IFJU
RV9FVEhfRVJST1JfSEFORExFX01PREVfUFJPQUNUSVZFLg0KPiBXaGF0IGlzIG1pc3NpbmcgZXhh
Y3RseSB0byBpbXBsZW1lbnQgaXQgd2l0aCB0aGUgZ2VuZXJpYyBBUEk/DQo+IA0KDQpUaGFua3Mg
Zm9yIHRoZSByZWNvbW1lbmRhdGlvbiwgSSB0aGluayB0aGVyZSBpcyBwcm9iYWJseSBhIHBsYWNl
IGluIHRoZQ0KaWF2ZiBkcml2ZXIgZm9yIFJURV9FVEhfRVJST1JfSEFORExFX01PREVfUFJPQUNU
SVZFIHdoZW4gd2UNCmRldGVjdCBhIFBGLXRvLVZGIHJlc2V0LiBIb3dldmVyIEkgZG9uJ3QgdGhp
bmsgaXQgbGVuZHMgaXRzZWxmIHRvIHRoaXMNCnByb2JsZW0uDQoNCldoYXQgaXMgbWlzc2luZyBp
cyB0aGUgdHJpZ2dlciBmb3IgdGhlIHNlcXVlbmNlIHRvIHN0YXJ0Lg0KUlRFX0VUSF9FUlJPUl9I
QU5ETEVfTU9ERV9QUk9BQ1RJVkUgc2VlbXMgdG8gYmUgY29uY2VybmVkDQp3aXRoIHJlY292ZXJp
bmcgZnJvbSBoYXJkd2FyZSBlcnJvcnMgZGV0ZWN0ZWQgYnkgdGhlIFBNRC4gVGhlcmUNCmRvZXNu
J3Qgc2VlbSB0byBiZSBhIHdheSB0byBhc2sgdGhlIFBNRCB0byBlbnRlciB0aGUgcmVjb3Zlcnkg
bW9kZSwNCnlvdSBtdXN0IHdhaXQgZm9yIGEgZGV0ZWN0ZWQgZXJyb3IgLSBwbGVhc2UgY29ycmVj
dCBtZSBpZiBJIGFtIHdyb25nLg0KDQpXaGF0IEkgYW0gbG9va2luZyB0byBpbXBsZW1lbnQgaXMg
YW4gQVBJIHRoYXQgd2lsbCBhbGxvdyB0aGUgdXNlciB0bw0KdHJpZ2dlciB0aGUgUE1EIHRvIHBl
cmZvcm0gYSByZXNldCBmb2xsb3dlZCBieSByZWNvdmVyeSAoY29uZmlndXJlLA0Kc2V0dXAgYW5k
IGRldmljZSBzdGFydCkuIFllcyB0aGlzIGNhbiBiZSBkb25lIHVzaW5nIGV4aXN0aW5nIEFQSXM6
DQpydGVfZXRoX2Rldl9yZXNldA0KcnRlX2V0aF9kZXZfY29uZmlndXJlDQpydGVfZXRoX3J4X3F1
ZXVlX3NldHVwDQpydGVfZXRoX3R4X3F1ZXVlX3NldHVwDQpydGVfZXRoX2Rldl9zdGFydA0KDQpC
dXQgdGhhdCBpbnZvbHZlcyBwb3RlbnRpYWxseSB1bm5lY2Vzc2FyeSByZWNvbmZpZ3VyYXRpb24g
YW5kIG1vcmUNCmJ1cmRlbiBvbiB0aGUgdXNlciBpbiBidWlsZGluZyB1cCB0aGUgZGV2aWNlIGNv
bmYsIHZlcnN1cyBhbiBBUEkgdGhhdA0KanVzdCBhY2NlcHRzIHRoZSBwb3J0X2lkLg0KDQpUaGUg
dXNlciBtYXkgd2FudCB0byB0ZWFyIGRvd24gdGhlIGRldmljZSBhbmQgYnJpbmcgaXQgc3RyYWln
aHQgYmFjaw0KdXAgYWdhaW4gaW4gY2FzZXMgd2hlcmUgc29tZXRoaW5nIGhhcyBnb25lIHdyb25n
IGVnLiBhIHF1ZXVlDQphcHBlYXJzIHRvIGJlIGh1bmcsIGFuZCByZXNldHRpbmcgaXQgbWF5IGhl
bHAgcmVzb2x2ZSB0aGUgaXNzdWUuDQoNCg==
