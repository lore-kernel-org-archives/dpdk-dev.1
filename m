Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F7CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 13:01:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA33B40664;
	Fri, 26 Sep 2025 15:01:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 364554028F;
 Fri, 26 Sep 2025 15:01:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758891696; x=1790427696;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=R3MPLPL50xdk2YHRxFvTUxlavDzpB9hSEW68R7CepvQ=;
 b=PQA/2PJ4bgXOEYeMtUNhdbCcU4KWwQ3bNw8kDK8PW9pT9xMEflseEkCG
 9/zfXRnfNn1H/PZBL2+jDfMZKax63ovX69bjG2uKbrT2PoGnAYxzkuXhX
 xFbpFMNdyVEBCW0dTZzlDU7hUc89qg6dEaYbOnduS1ueREl3tnepIBF8I
 N6LsdK0ku4Ty3PlABvE8zy3WyzMwi7BINhM4m8zps3+37IrtbFqG+TvMa
 bCj6cQHoRo7p1dQNtLZQhGRfpdVHEvxqVNqzKjiLhiuA7dSntpUD1G8VY
 0kKriJHbjto2wku+CwhCsb64rj+aLWSLQqKUyqvIiEUvRKaT/tFSEKkUD g==;
X-CSE-ConnectionGUID: 4xvQEQQ1TD6HXku8bxHPtw==
X-CSE-MsgGUID: gzRVdPr4T0KVhv5G3ZU4rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="60261205"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="60261205"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 06:01:35 -0700
X-CSE-ConnectionGUID: fYDW1FUNSKSpZ0aq3CMZVA==
X-CSE-MsgGUID: 5bJHjfROQtG2c/FfaqPWWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="181614834"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 06:01:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 06:01:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 06:01:34 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 06:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hw6dQrWqwslfOur3F+soogT/iSM0iBR3w56tcvVbaEtWtF3Jv01H0xjaK0MrXC8ErX2zANN5OaHTXlCqHRLvXMuRMPEUFl5A4AgQdufpDBOQnTvfrhbV/N9Qxvj89ovKidNigkKsuy7HWmRQOc2qJh2eXV6FPDM/07GErmEEbsM01IaiKL2Bp4ziRiKkzXRjji0c+hmbPh3itwCFe5Mlulb53CjtKmEThEmYJG8pbvTUT626jA2fO9u5g/BRdo+zPumjQfg1UJQX1z6JiG6Y/xycDkKhctL0GYxMO67TpQaZ5S6oRpJDLBGzdvOtJPnv3O7Ioi8pndQJpYwm9GvTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+97snu9ktr1qi8VTSOYzP4cpVDB+4rPesw1/aMKTQ8=;
 b=onlDH0SvP0Qbv6HHDt72teIM3j17ykPhLRb7IHarEvQ5TyRkDsn/IlDSwn50du7B819zttSYVH1GqyEfS6P8f+aOZDKjW8xj4yWkG7/bHnaHpQYk2QG1Ark9JemotxU0rKN1ozZ+aw2JLDYVRYl0U4tc0OMR9VCHi0AeB+Pn/+NXh2hqtoN8Qtjj0Y582VxTwxB199tZI4a+hHn1Pfr/Ax95739fGeocv8e9FAtwDRHN/xhPRg2rO6ZkcGeYblPCvwu7tqmXk+MEMMKclgaoADP4E/24HjdodG1A9Xd2u+1Y/Jj0+C6pm+LzcZvbYFkTS4DRKhtel2J6fWbv8cRKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 13:01:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 13:01:28 +0000
Date: Fri, 26 Sep 2025 14:01:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Mattias =?iso-8859-1?Q?R=F6nnblom?=
 <mattias.ronnblom@ericsson.com>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v5 6/9] eal/arm: fix C++ build for 32-bit memcpy
Message-ID: <aNaOolTLU48lbmzI@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
 <20250926124103.750844-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926124103.750844-7-david.marchand@redhat.com>
X-ClientProxiedBy: DB3PR08CA0036.eurprd08.prod.outlook.com (2603:10a6:8::49)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 862aaa02-a3b7-49fc-6069-08ddfcfcce37
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEJQMEcvZ3BlNUE4aDJZeG1XZTdxVjRoaWJ3dHFJRWpxdFMweitHWFBtVUhW?=
 =?utf-8?B?TFB6Zm5ZVjkzanl6SG5sMHppckNqWGxxWTR3ekJQMUhsVWhlSytGTmtCb1VP?=
 =?utf-8?B?cTB1UWI2QXF1TjlRbjkxdFl5Y3NQSzAyVFd4U2V0MTZnSHlYTWR0MWpYcDFW?=
 =?utf-8?B?U2tiQzJPNzRSRFJUcE1xaVBueUFpQkdCaTYwSlBRVEdTOCtYcGh3YjVEYW81?=
 =?utf-8?B?TTNlVTlRNndPQW9UUVV4Y3B4elhsOVN5VG1PRjhrWHVCajVQeXkzK1o3OWdC?=
 =?utf-8?B?cDhqQk8yUHNLdjNUWDhRZVdTMmROTk1RMW1rREtkNGNiSThubTRNYzhEUnhh?=
 =?utf-8?B?QlV3cE43QmFPV3A5cnNzTDdqNWkxbktKV2VNYzQ3ZDFCQlBSRzRydzRWZHY2?=
 =?utf-8?B?L2RTeTBxU2tNMmFxemUxRGJaYTBJTkxNNnE0UVNtTmVicXRSWmJVM0p3dmNu?=
 =?utf-8?B?RlZ6UXQzOEZTZlZ0Z3QrTnY0QTVBV3Q4eS9lUkRaZTNFUXA5NUZOcEl4c2xz?=
 =?utf-8?B?c0dWeHJOc2tHYmk2azdDWCtyOWQ0d2ViTXd1Y29VZzU4VXRFRG9CbmUyR3lo?=
 =?utf-8?B?MWtXRDloNXN6MFVHZVE1S2M1S21LTk4vRGcxeFFKd3hFZWRzZGtHU0RRblJk?=
 =?utf-8?B?NWpuUGhpdmJLeUJsYVNZT3hZdEw0d0N4R1ZZNzdyZFJNMkpoUFZGVlJXbFAz?=
 =?utf-8?B?c3BKWFp0R0ZWcFVPNDZJbThQVmtuby9FR2xXTms4d0ZrMEUzeWdUSG9qTkk2?=
 =?utf-8?B?aVJLVXNLa1hEamJxbmJvMXZPN2RKcnVaZjZzMHFHZncwbi8yOGlER3lNZFJw?=
 =?utf-8?B?TDNKWkVOSk1aVVFIWmlLUzcwSVkreklNbnV3TS94M1Y5TTVQVjVKR0hLeUdy?=
 =?utf-8?B?TjRqZjRnN0R4ZG9FM1VRRUIzaklHRGNJVEVRZmV1azVreVJVN3d1VXp2RnBP?=
 =?utf-8?B?a05lNkF6aERyUFJOdFRUNlkwQXlSaWt6RnNOV0VqUU5mQXNERnA5ZHFDbVF3?=
 =?utf-8?B?VUNnOHZQNUVlZ3REYWh0SVljVnJYZGp3K0x5MmYwcHh4SDVBQS9sTWw1VzRk?=
 =?utf-8?B?clliQ2xFTjcrZmVLNmYvOGF5cE5RY1FVQnRld3NoM2JITjN2cVJCUUdkYUp1?=
 =?utf-8?B?VU5KNDBQckVzY2ZsMUgvRnNrRitJdUJvWmZFaFd4MmV6VE0wY0NsVHRTN1o3?=
 =?utf-8?B?ck51ZWtDZjE1ZFdTWUYrSzUvMGNrYmRsYyszTnZMZHJZdVpiUnNQWS9KQkRp?=
 =?utf-8?B?eEZ1WDF4emZneDkyaW5ob1RCYkN0clBJZFFEWGlVUDFoTFREU2IrRjdvaGxQ?=
 =?utf-8?B?NlpiNEFrbHg1ZEozN09UOGx4am5uaHd6aWxNNHFXaGpYTWVoNnozdEs3Nzlm?=
 =?utf-8?B?OHk1UHg4SUxwejVDL21DL1Jyeld3UVA0ODI1bjhCUjgxcHM5Uk1tOFh4QzF1?=
 =?utf-8?B?UE1xa3l4QkcxZHJsRGtONE52RXE5NFJBQjhEeWUvY2VOOTV3cFYxYnBpVTBL?=
 =?utf-8?B?aTFHd3FrckVtcDVJVndxd1ZlVjZBdnlqOEJTVEF5WGNoS2FGYmZUVGxJa0NB?=
 =?utf-8?B?WkUzMzVPbi9BRHZtTndpdnhpeis0S2pJM1grdFJVeVBUcWwxTzRreTFQOTFP?=
 =?utf-8?B?ZndiR2V1emFQeDhMQVhaR0FNTXVXUEJLUmxHWlNPSk04ZlNzTlNQQW9WZ3hr?=
 =?utf-8?B?REZhakd6cGFnK2tPVWVoZlpQbGhOSkNHT2UrYmQxYTljUFJiWkc4clNFRitE?=
 =?utf-8?B?WFJDdVBUdDkxdUt3Z3lqSjkwODFoaXgrSEFINE5EWDJxdUlBVVhEMWdWcFpK?=
 =?utf-8?B?eDRickRJZXh0MGk5dzZsWGJLaE1LaVdsc2Q3SFFwOU82OUZxaWsxbmdGdGlQ?=
 =?utf-8?B?VGFMbCsrR0x6RWc0bklibVFmQ2xDNG1nbWw0d3M0NzRpUDhKSFNyZ01aWnE0?=
 =?utf-8?Q?peb6GmFrur9HtycqToYW4M8i09dQIM2h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJ4U1JTN3FKQys1ZjFGVXdGUTlSNUdWR3hqZXFhM0podHRvYWpPelo3eWNG?=
 =?utf-8?B?RDdnS0c1NXhtanRJYlpYT1ROak5VMHU3R3haekczdkFFaXdmNkRUQjA2OFpj?=
 =?utf-8?B?K1Y0R2hWNTdia1dsZmtWbzBkMXhrYlk3SDJuV0lIZVdWRHBUc09adFNTUm9K?=
 =?utf-8?B?RVBnSExmY1ptQlF0TnhFVVJQcERwT2Z5K1ptczk1OEZuQzZHdGJQVFZ1UzJN?=
 =?utf-8?B?bWUyWEQzcXYzb0ZaUUpTakJPSmhmaEx3K28zcWNobUYxVm9yc1JNWDBIaWhE?=
 =?utf-8?B?eU9JaVgrSDliRkNlclJBR01GaWFDWStiZW5WdWJFM0tCWC9rTHlibWRTcVJM?=
 =?utf-8?B?RXRFVFcrY2M0WkZNbTJvMmtRc28rWW1udU83YlZlb2RRV1JacE01VXRrcXZz?=
 =?utf-8?B?ajNYS2VtTnlXK3UxSFJwc0tIZ2lvN1YzU2daZzI2b2Q2MnJ6Q3VBR3phODlM?=
 =?utf-8?B?QklDZWY2N2NuNzhWUy93OUwwenN3N1JQWHQzM0M4bkFvR0Q5S0dGeEJrc0N0?=
 =?utf-8?B?dEttTDFDV1V3SFBqNEtuRGQvODdYazlqaXVsTlc4a2ZhZHFhTkNLenprYTFL?=
 =?utf-8?B?ajF0UGw0K0tyL2d6ak4zZWxZVEdoRUM3R3lXVyt1R1FYbzZFQ0lTS0R0TXI3?=
 =?utf-8?B?OEFSa1pDVzdVWDZhckdycXh0eDZ2TTZpa3hvNWZ3ci9aakE4ZGZ5QUpjZHVr?=
 =?utf-8?B?eTlkRlFyLzhpV0cyVlovY3Rqa2l5L1VwUW1Ubkt1eEFOcGFteHE3N00zRFdK?=
 =?utf-8?B?ekZ5TDZWOUk5L25MZEFwdXk1WUR6Z2Q5TDV1a0g0RE1WMC9icnJXYVBBcHVQ?=
 =?utf-8?B?d1BRYytBSTA2RXNPUmV3TGROWkVPVDY3VUk4MkdKTjRpOVhvUklrb04yR3lu?=
 =?utf-8?B?cWk2UlFCUkNIL3JGQ2xEVjNyNlJyTUFWRG5pOWdGa0hsZWlQVHRHWjEvYncv?=
 =?utf-8?B?OW9QK21WSkRsZGUza3lMYThPb0pFQXNacWVJYzVXQkJ3VENsbG5PNzNmenJa?=
 =?utf-8?B?YytOU2VnSUx3bUtibEZMRnEzNkNiM2pQOUpBRFlRTStFMGhKd0pJbXRHaHg0?=
 =?utf-8?B?ZTRJdjBkTnI3R0VCL2t6OTNkbWVVUWMvVUV3UmRGWHJlcUZWYzhKenduVG94?=
 =?utf-8?B?cFBqVXZCUjBheE1TNjVQWGxSUGtyalRNczdrbTRLWHFWNlpIR0pSS3p5Z1BL?=
 =?utf-8?B?b25HMTAyQThwSmJCeXVRdWdjaTJqUHBOYjlEZ2xYMFRTdXN3ZGxsT1k2RTJ3?=
 =?utf-8?B?QTNidXFEcmI3R21Tb2tpK1l4Ynk4Tk00dkNTcnJEclpMTUpjYzRSY04xVisw?=
 =?utf-8?B?K1ZNTXk4VTBENVNYQzlHTmVDYkJtd2FxVTZsbkJ1M1o3UkNqOEV4RjBOcWx0?=
 =?utf-8?B?WVF1VzFvY2Fxa1BXSGFjVWxLUksrR1c0aEtzdHg0NWw2M2c4bUU2TWZibHpn?=
 =?utf-8?B?bk5kbHZ5OUZQUEFhMVQxL2FnVStvZXFpeHJlTEwvc2taS3FCaFdFOUZ4TS9v?=
 =?utf-8?B?ZXJhR2hlNVFqVk5ieHZ6WUY3WDJyS2FobE9XYnIyOTVaMUpBaWIrMGZYbzR0?=
 =?utf-8?B?Rm52MEJkQ2ZabjZ5dWczNnNTclAwL1hzMGtId2VpNjFNTVNKbXYyZE5jeVBT?=
 =?utf-8?B?S0hGd0FGTG8rVk9BYkZQempHb1orK2hCbW9HQmZNSTBTZ2NyRTQ3Z05HZXZr?=
 =?utf-8?B?UFFpYU1MeGgxUHlURS82SFJIdktrUUpJZyt2aGJHSnlWMVowVi9zTEoxN1cx?=
 =?utf-8?B?aGQ3d000bjVOeEtsTm5QUkI5K1J6VkNzM0FRRXJYRGZ1MUZLK2lxT2MvdDh1?=
 =?utf-8?B?RTlmVUtMbDh6WVk0UUFvT0RKOE9sT3RlUGdFVld1YmhMUzgra1diQzgwYlpa?=
 =?utf-8?B?U0VJOVFXb0Y0Z0xoNmRIWGFIVXNQbDErZDFmRHFLcjhieFhTVFhMYXJhZVk0?=
 =?utf-8?B?Qmk2cVU1WXlxTWN6eFVWaGd4RlZhRVRld3piQXZkazRlZ3RYazJWTnF3V2JZ?=
 =?utf-8?B?QUpQL0VpT0VlcW9LRGxDeTRyZThzTjRrRkt1SHE4Yk9pV3Q1QmRZNXdjQWZs?=
 =?utf-8?B?eithQVhXRitvYnhZanRrOHF6MmF5RHhRdVAxK1ZQZmFoSENPeDRlNUZEM2k5?=
 =?utf-8?B?RnIxcnk2eFBXS1lKdlp1d2dDWGxRVC9OMlZja1QzOXNmRXJUV3pKWHdPY0tl?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 862aaa02-a3b7-49fc-6069-08ddfcfcce37
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:01:28.0778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/EurZhCwmpyazVtIdh6+aN6RM8RCbqqJ2Z6ktNwq0xCbnpJdQXEZdOmZtB9IuX2EnEsczhAHCfGZtljpDjrJ/jvpIkq0abWnRdG/zI8n6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
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

On Fri, Sep 26, 2025 at 02:40:59PM +0200, David Marchand wrote:
> This was caught while checking ARM arch headers.
> 
> In file included from buildtools/chkincs/chkincs-cpp.p/rte_memcpy_32.cpp:1:
> /home/runner/work/dpdk/dpdk/lib/eal/arm/include/rte_memcpy_32.h:302:1:
> 	error: expected declaration before ‘}’ token
>   302 | }
>       | ^
> 
> Fixes: 719834a6849e ("use C linkage where appropriate in headers")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/eal/arm/include/rte_memcpy_32.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> diff --git a/lib/eal/arm/include/rte_memcpy_32.h b/lib/eal/arm/include/rte_memcpy_32.h
> index 99fd5757ca..861be06f5e 100644
> --- a/lib/eal/arm/include/rte_memcpy_32.h
> +++ b/lib/eal/arm/include/rte_memcpy_32.h
> @@ -19,10 +19,14 @@
>  /* ARM NEON Intrinsics are used to copy data */
>  #include <arm_neon.h>
>  
> +#endif /* RTE_ARCH_ARM_NEON_MEMCPY */
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
>  
> +#ifdef RTE_ARCH_ARM_NEON_MEMCPY
> +
>  static inline void
>  rte_mov16(uint8_t *dst, const uint8_t *src)
>  {
> @@ -252,7 +256,7 @@ rte_memcpy_func(void *dst, const void *src, size_t n)
>  	return ret;
>  }
>  
> -#else
> +#else /* ! RTE_ARCH_ARM_NEON_MEMCPY */
>  
>  static inline void
>  rte_mov16(uint8_t *dst, const uint8_t *src)
> -- 
> 2.51.0
> 
