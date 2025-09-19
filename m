Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AE0CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 13:14:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D672402CE;
	Fri, 19 Sep 2025 15:14:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id D48DA402C5
 for <dev@dpdk.org>; Fri, 19 Sep 2025 15:14:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758287660; x=1789823660;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Hl+1RV8b7z3e4TpKcb1427vwg8Z5GqidRScvgMw6BPo=;
 b=K+fN3gwg+mFXAriU/hvm14jMxw5FBz/rte29WOpm2plAibeJbmI4cm85
 7YE35aoex+MPvsvJVMc4sQ6QbnstoliD0KuHbAybpdIRhbCG5ZQL+gPiM
 ptk4BhofCkYoNwGWQvfbuyLwe1r6YcYo0Hz6Nwd37Sq37RWudP7ilMskA
 jMUQQNZ07r7PtRibbbNx+gP3UqDcsL5o9+GT5X8EC+z43E4tcHI48maGC
 0j5zE+5lWjf0cb0ovm+prT8G0+z68s8OB8WzocXXPssflIV2DuYI8AYat
 saDzGn3WAgjfN9YB+TdaDBOwxMXgdmDtEp3WzePzOQ8VBfKRILf0K2OI+ Q==;
X-CSE-ConnectionGUID: BqQScH4HSiyZpezVMTUghQ==
X-CSE-MsgGUID: xgG3+k13R/2ghZYFGJfNhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60580023"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60580023"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 06:14:19 -0700
X-CSE-ConnectionGUID: pgXtCkArQUK49X81rYrjEg==
X-CSE-MsgGUID: UQiPZkEXTcCJL6wm6985oQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 06:14:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 06:14:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 06:14:18 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 06:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQD5s1lal4aPLN+zBh7R6IADLVDev959ae69N+pMQ3eK9nxPPuF+UOIcP9lN2u8YLQIufr8YKbEkV09Fz+nAT/sZbf/uInQHy46EAiNgOnnm4PqNIXWLmKSs5Q56cRhiIT4p2B+5bKIqobjcW6aT5scEbV+2CcZJAu8LUZ5d8gduK7WxQcPONv5NbdSYqypt5CrKRFJAmQZLFso3iJOC0qwFSXGSAhpAh6Gm1nuIYr3bsYNmOS26vVXJfF2inVUiwEUBvoiqWTlNb7VMDrky9stJoPpPOWlCyhhRrqFiQhRgf+fbTwjg/UVhJ2nijpi746U7FxSLOcFLxtpT74WInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGPZITRMOmF50OLpXKYa2y6JaOU6DG+SvM4a3SmkZx4=;
 b=jMFnlUZE5FeuwkMij4ed8/R3yFIkSUmlCu4Qb9A6l0/EFmZjAKWcx8Vpm9ywowTKfaztGP9iQkFRD4haNJDbJ3oq6jIQVU2vGmrhWXcA0Bom1qkPlprCNs8ymxERz7/bcv9HcEwL4Lk1gMoiFv0R0I29LvZabjhx3RekjUXr6saVQe4NN6QT7oz2tSrUP3DphqOq3cnTkot5nBAkDRWtotYPQrlBzWhrYuWjpUygPTbyb2jcU6ccEEp/TW1QICY+Uo/5sB6zdXyRNTgRjucnBCgVt0wQsNhYduGiL6re2D5eR63K5YICv1OH3S8/u5XRBVIMMBHnYHUGL/pc91leXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.14; Fri, 19 Sep 2025 13:14:15 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 13:14:13 +0000
Message-ID: <0b459c44-a262-43b8-950c-dae90c0f6f2d@intel.com>
Date: Fri, 19 Sep 2025 15:14:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/9] vfio: remove confusing check on VFIO presence
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <maxime.coquelin@redhat.com>, Rosen Xu
 <rosen.xu@altera.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, "Vikas
 Gupta" <vikas.gupta@broadcom.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 "Nipun Gupta" <nipun.gupta@amd.com>, Tomasz Duszynski
 <tduszynski@marvell.com>, "Tyler Retzlaff" <roretzla@linux.microsoft.com>,
 Harman Kalra <hkalra@marvell.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
 <20250903151800.1965006-3-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250903151800.1965006-3-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CYYPR11MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: d51be657-274c-4fc6-43a7-08ddf77e6d6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXhYbG8yK1ZHTFpPS0FsaDV6eDZyR1FGM1Zrdjd2L0RSa1p3bXVBU3hTemdR?=
 =?utf-8?B?Rmo3TGEzU0tRdWRJUTBLSmx4VkZVV202QVU4dHFhV3Zzc2hZTUdydjNrYWl2?=
 =?utf-8?B?Q2FncDNXZXpIRE56YUJaUERDaUl2d3hZb3ZZcXJ4OWhVL2NMVXFqOWJKUUhH?=
 =?utf-8?B?d2JmZUtRY2ViejE2YWhCQzVRRUluejdzZnJSK21lSTFZR1pFZ3NzZW83cllK?=
 =?utf-8?B?N2VyUUhLWGJiaURRaDc1b25sMFJCeU9VMVhDTEI4azV4OWRPRUZmcnNVVEFE?=
 =?utf-8?B?a0FBRWJySHFhZnoveFcyd2RibGF4TkxPN3U1RDg2cWIwMlRsNStXdGVvR3hG?=
 =?utf-8?B?aFExRGIzWmdzV29QU3hWZit6c0t6ZHc0bWtGVEIxMXhhZEtXK2h3d0NnREMz?=
 =?utf-8?B?dWlramVVYUg1ZWxzTkErRFlXeHFFYmZIMkZNVkNiVjVVZW91MGtlNjNTc1lG?=
 =?utf-8?B?OEtzNk9sTGEyaGdQMmlnbEhzdEwrZUhMc0RWT0RFNXd3a3NadGNzcW9YWDlj?=
 =?utf-8?B?WER3Q3JiRWlCZlVyZVEwK1ZqZEFzQ0JINjdxUzNTU0psMmc0UWoySlRIREhE?=
 =?utf-8?B?WFVnTVh4TkJmcWJlWGFmNlFGUzNYOGJxQlZ5QkVIWndCSWh1anByN0I0bU42?=
 =?utf-8?B?WHo4S1ZWY25MSE9qeUc1dEJjbHhPVkF4Y0JlckdsUnZtNzM2YVoyMnZTRGlQ?=
 =?utf-8?B?ekczVm5XQ3dJdnhwWFZpeURmYlJncW9pM2hINVdDTzFWeGRjamZuVkw5dStV?=
 =?utf-8?B?L3g4NTBySjIzRDNUY3prV0g5VnFyWjMyYXlOTXZ6MjhWbmNaVk1UL1pWd3g2?=
 =?utf-8?B?MzR5QnlVcEFxSE5Ibmw5QWlSQjlEZW1qTDlKSmVmVHB0cUVOa3NhMlEzaUZp?=
 =?utf-8?B?K01UOGVBN2hsYWlHQldkN2VrVzR6SGVUYnRQTGROSUREcEtabzBpSGZGZHhw?=
 =?utf-8?B?dXl0YU93RjZaZHRnSnhRQkIrSVJaTktub2d3dUgvQXhyT2tOSzB6WTF6MzlW?=
 =?utf-8?B?eU1zL3dRMml2VWNnNERhZU1QamdGbUNXQkdzT1F0U1F6ajdxemhpS0g4eFNY?=
 =?utf-8?B?eVIrbWxwamVxSW1iYzlxS2Z4ZUo1M1RrTm5GVWZrLzVuLzdkKzJ0SzQ0MnZY?=
 =?utf-8?B?TGo3YkNiRWtjdHZVR0VVQjI0OGlNNUhpTC9jUGw1WFRKQisyakFGWXJOQWZu?=
 =?utf-8?B?TklXb1lJaEhXK1d4ckFvRzJ0dHNVTDArM2NPRDhoTTlhZWtvOTlCeSs4MGpR?=
 =?utf-8?B?ZU0zWG5CbGhtRHF5WEhQTDFoOWwxYjBGSFVlQUxvR0k3OGorV1ZaVlJKclQr?=
 =?utf-8?B?aGRCOEpEckxRV243aFE1NlJkazhielM4Z2FET2ZyWjdPZ3FvYXg4a3VVWU81?=
 =?utf-8?B?WmpEZDF6ODcreXFWUkx4UHFBKzJDMHBKVWJjMFBSRFBHdWJESVV5ZEg2Q01T?=
 =?utf-8?B?YXlJRkNrS2dEL2RJVzVUb3lvbXdRWmdtTHlHSkZNbHNuNWRrMC9reVlPVGoy?=
 =?utf-8?B?ZktEY0QzNE5aNUdQSS9lZ3pGeFJXWTBJZFB5M21OYWNFbU5Ub050MlZrMUs2?=
 =?utf-8?B?WVdBVTYrMjhSb1dUUU1FQWV2VEtqTWRiTVBaLzllbW16dHc3M2I3b2EvcDJt?=
 =?utf-8?B?SmZCYWxWTGRTYk9OY3g1YTIzZ1ZOWnZsd2RHWVBPZWZFVVFEbVZZdlFicTBL?=
 =?utf-8?B?YlJaMlo1cVFKZVdpaThKTmtvRXREZmUveXBhVk9ncjBNMThiS1l3M3lhbkc1?=
 =?utf-8?B?cHFmS3ZXWjllY1NyWjQ4dFVjL2E0aHV0YmZTeHBhRE9sSU9jS2FBRVN6RVpY?=
 =?utf-8?B?SXp6NU96QTFidVJZV1Z2QWZMOHJVS2tYTGF0Q1RsNk9yVXI1bFlZZDg1M1gr?=
 =?utf-8?B?OURZdnhpUm91MXIzLzgvVlZwZThHVGcxaXhjeDZaVU51WEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFZBdUVYckdEZjh4S0gxN043N1RCckJ6WWVXdVlDaGp1WG12ajBlZDlJSWM4?=
 =?utf-8?B?QmR3dEphY054OElHbjFxOXNaSndqUElYN05lQVd6VG4xVkxqVml4NHFWOGZM?=
 =?utf-8?B?QkZYelBsNWtBakN4TjAxbEhhcmEvT2NUZkN6RGV5bjk4OHFhQ05YSXVpWUgr?=
 =?utf-8?B?UlNFSUNKSkpqQjVqc1hPN09yV1JSUGRUa0hYd2lKeDUyQ1luenJzVDM3T056?=
 =?utf-8?B?R1RzWDBjT0tadFlhZGVrNkJoT1FpSnpLTXR0MnRWc2lUdFpRczdOdGQwYWxx?=
 =?utf-8?B?bFVuVUZOcUZlRmllY0c3c3FYdWZuZjVRZkNJY1JyMVk2cm1yZHYyZng5emsw?=
 =?utf-8?B?RzhCVGQzUkg2UFRucFlIRG5pRTd6amZJa2RLY29pMnRDTkkyN1Awa0JtSTha?=
 =?utf-8?B?eUNMVFZsWE5XT3h2VHJhQXpWcVdiZWJMODdsb0paOGVCTE96MVFmVFhCMG81?=
 =?utf-8?B?cmYxT1JCNnBuNmFVWWxkTFo2OU8rakhQcVZvb2NLNEZvVEd4QzlSc0RxMWpp?=
 =?utf-8?B?bE1ZOEtoNWcrM1dHeVp5QUo3WFBHY3RvWlRGSFE4OHF0eTg4Q2xORUlnVWRR?=
 =?utf-8?B?aVZQZGZSWnJvNDhJa0wxYlg0Z0dMdGhWUFVReUlGQ0x4Qm9FUlZSUU1wUnJz?=
 =?utf-8?B?S3k2Mm4wMUM0MnNCbjA1d003dmZSQmk4RGhWb05xUDVETGl5R3pDbHdzdWpN?=
 =?utf-8?B?MDVCZmpwcUY5ZVQ5aC9SRjNEdUtUZ2Z2ZjZ1OHcvcnhhMTRQM0ZYV3VUb3R0?=
 =?utf-8?B?WmhpaWpDR2s1aG13TzBXdmg3Qlc2dy94OHF0clZrT3lyT3hWZHoyUU9FZHBz?=
 =?utf-8?B?Mk5wTWlHM3B6dGt3LzRKK0ZLbVFEbXMvVmdmWUEyS0tGOGUrSkdydGhNQTEx?=
 =?utf-8?B?R01ZaC9xSzkzcE56d1Nrem1BRmJWT040dExlS0orWWRsZnhzQkV0NU5MNXdq?=
 =?utf-8?B?WndTWUx5UFJkWmpRSEdKQW5aU0tWemIwTXdPTHdOZVhNckcyeUFSeU5tMjIy?=
 =?utf-8?B?QmRsV21vb0dwNVpkbXk3elVTU1Z4c0poVVNWejhoQWkzWkc3a1RpdWN6T3ha?=
 =?utf-8?B?YkpzaVNwc2p0THplbndmZ3R6T0F2TzBaTGZuMWlLVk44N1JKTUZ1MjhpcU9t?=
 =?utf-8?B?M0VvRU9qT0x6RFI5eFFPT0RCb24xeDJ5WElkTklMWnViRnFkQWc1OFBtUHZT?=
 =?utf-8?B?SS9tamRROFlFanFtZHQ0UDJiRXhsMVQrWjkzRUJjcnMxQlVlL1piNGhaSExk?=
 =?utf-8?B?U2VCcnhNa3dtd1lwenhjb1dZSlgyY05kM2xmQmdlenpBR0FHTVdKbWtuZkE2?=
 =?utf-8?B?dGFqY28wSzU3eEtnQ25VRFk1clZxbVJVdmZSRStWaGxaZThHVlZjS2tQZXky?=
 =?utf-8?B?dlg4d2tmOEN5N2I4dVpsRit3aS81YUZEb2pBZkFUYnJtcFJKYm43T1JkU2dW?=
 =?utf-8?B?N2p6TVhFVWxub0o2ZHRNQkVvcmVLMDJsZDhRQmJvUGlwZXBMTkhVcFBMclZV?=
 =?utf-8?B?ZVlLVTJqZk9pQVRwRUpEbEZkS0FnNXVpSkV3WlVyWDh1MFZ5UjFNWGZJNno1?=
 =?utf-8?B?Wk5hWGlsL2xyTGczdWN5dXRsNVJFNFhVSk43d1ZDNm10SnZGVHpaOS9FanRI?=
 =?utf-8?B?Mzg4QXNHaXdwS3dJUGVLSHNzSW16RnduK2NtbGY3SG9GaFdLeDVrUzd3alFu?=
 =?utf-8?B?bUpyV2lNMWRFNGJESnNuZitpa0NoanlEdE9TdER5OFdGK3hjQm9xdzlvczVL?=
 =?utf-8?B?M1dWUWtyejEvQXg3enR2WFhURVNPbEE0RTBiWGNlbmZsaWhqeG5DTkk0S3hP?=
 =?utf-8?B?WUtUenhpeEhmSnpEdDkvRGFRSU1manliWkpKNlFYZHZySFRteWVDTFpod1Bs?=
 =?utf-8?B?Nkk2YkFUQWFvS1Y0YVVBTER1a3RQaWNCZzlndTlOQmlXOEVIeEI2NjdrVUsw?=
 =?utf-8?B?akpxUUhVWXFMeGJ4NFRJL2p4VitqL0RDQmE5M0ZBbDl4a2JPalNkeG51UFNF?=
 =?utf-8?B?eFBVTTF6MTFwbDBTdEtvN1FHclZJVlE2em5PZEJaWXcyWHdhWXFQbXhyK3FY?=
 =?utf-8?B?b0lNSlR1VlJ6eW5VUWxMVXZicG1pQ1I2bmd6WkhtMlNMeUJDeHB1WjBzR3dF?=
 =?utf-8?B?UmdUb1JtNFUxSGJVbDl1NjJJcGh0S2RnQ2VvWUQvVXF4WE45UFdYamRrckZP?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d51be657-274c-4fc6-43a7-08ddf77e6d6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:14:13.7478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EV5hUaOGxo14s3gOPSYsvc2/cOsDn7dIJME8P+fBL0Zqg8hXt/kdTRl7F07zovsfqRXaEH7ZrtnnhzGz1TcyObgmBEQjWoKHdBjBaR34ITs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
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

On 9/3/2025 5:17 PM, David Marchand wrote:
> Contrary to what the VFIO_PRESENT macro may suggest, there is no check on
> whether VFIO is enabled in the (build system) Linux kernel configuration.
> 
> Replace check on VFIO_PRESENT with RTE_EAL_VFIO (for components built on
> FreeBSD or Windows), or simply remove it otherwise.
> 
> Then remove inclusion of rte_vfio.h when the only purpose was checking
> VFIO_PRESENT.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Reviewed-by: Rosen Xu <rosen.xu@altera.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
