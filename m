Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DDEE909DF
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:09:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AA3E4064C;
	Tue, 17 Feb 2026 18:09:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id E3C144064C
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:09:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771348186; x=1802884186;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=rEDwtSqeHZatqqxcEY6QAncC9Qnu6T8DL4pw/hxYGhU=;
 b=Q+YKcGLRsn7uygpSeA9kFYz57iJ+SR9gGg/ybJKfn2sTLdWvqmnuzVDg
 /MZCiTzK0Rdgwb4C/MHPHN8MzwE+Yb9HAcv/GXc/JaKRG1h//+cAAH3YJ
 YaunMs1KzA6Ha6Johj8hh4JY6WBpsjknA+We9jB9rFym6pd9I25lCi5oZ
 AVJLL/d+E/dfvMoeQL/GPCL+2c+9e4Td9xT5pjsqGlv0CZTkQxD0BpkpM
 /pnbCbNbS+z0N4jEI6cUZPZJadoBHmQItInPDE7xY7l7Wsxuxf/sPkg4E
 OXqtQhRljP4O5ck6KmyT7HZ6qAnu3rKL0yQf/pC4/Gscu8WlGaNgcbj2h w==;
X-CSE-ConnectionGUID: BI4GceBCS8OaOBMKsbvbZg==
X-CSE-MsgGUID: qyiIiI1ZQGm5duV3N/LhvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="75020516"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="75020516"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:09:45 -0800
X-CSE-ConnectionGUID: RMI3x7YmTMOJ6b2OT75c4w==
X-CSE-MsgGUID: GXqPJgMQSlKR8uAzSrBVDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="213022700"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:09:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:09:44 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 09:09:44 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:09:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCVORgYJyodn39M4chbWuNhOU3csuX4TqpZzZeGvQM7iFRScIZ72yWpEWuacttikEzeuLJtb6ufUohbH8Jy1JsN4dy8kOsZB70BrBsv3kAfiy/NJbLHgLlE/Y492GeBF4dF/xt0dlMarcOD7laHPSRS2BT2HOcphyLqIvHPOunl44QgfLP8rHjr0NnOlXtmd0qj1ZsZ3vkKc2n0830l2k5dypkz5MNiii8mM/hBOnp5X+G/18hYOiKlWCna0TrzrP6cOi3/lHBsAWbh7695I6KcAGwidv74VzkT/1wYpZb4mtrcvS7Rhh7/QtaBC5ok1PtSe6EynEWxdYoiiRE6klw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+TGQpixrpabn+7bRKI524Qez5TH8p0QQceaIEXSL6M=;
 b=sIj39rUzWF/IJ52xl3hebpDTnnBwmDbtDGEzNnS3saiHRCNvJXsrTDh+k8lJtNN4GQpycPdGaIPasTX81dZWUsJTiSBuyN9rGS+vrpC0EgCsx75Y2xSpR976W78JMNSEVK20JOHJ7+IHJv4BSlIDHYX9mmn9PFRq8Z7MYpwl//VIqZpe7a6HLN8YlIyVmc/uVxxhfUzaZtrMMNk6jKiWXuNosyttgkqbZpyg8FjNXD/V8mrXOrSpsajXb8XNpQDpglsMkjID8qjScPs19aTiWLc5GQ9ji3SL/xm50UpkayUrN2ixM+JE+A4oKYZHjx+9DWnqT3HCAl6Hfgx/46Eirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH7PR11MB6607.namprd11.prod.outlook.com (2603:10b6:510:1b2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:09:35 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Tue, 17 Feb 2026
 17:09:35 +0000
Message-ID: <010caf15-6fbd-4499-acf7-5b3bff24a453@intel.com>
Date: Tue, 17 Feb 2026 17:09:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/27] net/i40e: use unsigned types for queue
 comparisons
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <f91731080720fa5d4b89587b6355fe3579bfab98.1771330391.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <f91731080720fa5d4b89587b6355fe3579bfab98.1771330391.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0278.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::13) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH7PR11MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 406d028c-b087-417e-2112-08de6e475335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjJrMjFwS2xMdTNtT01MeFh0QlN4VEpuK0o2ZGdWb0MveWpoV204NUVzWkxQ?=
 =?utf-8?B?U09CbFBIS043dCtIVk5RVUF0WW9ha1hab01pSTFLL29wYzhSZGFXOGtIMlhV?=
 =?utf-8?B?bUwvS2RyQkJDdWVVcVFhLzZMS2x5KzNJWnJVVkpEYlF0NFlLWU42R2VHNzg3?=
 =?utf-8?B?MWtHL3c4WC9sU1JRUGg0TUl2Q0JiMnk3c0R3Q29wWTFhbmU3NUx3b1hURXpm?=
 =?utf-8?B?UnVTY1VZLzV1aFJqbE5MeHA5M1cxb29wN2Fpbm5VU0t2M1M3Ym5TWWNPRE1z?=
 =?utf-8?B?elFVR1FXTUZDWUY2czZKRDdZUEh1TktyMzdEamtoS2haVmZGS2Z6aHM2cWNS?=
 =?utf-8?B?bnpWSTJQQlBDYkRVbTEwVWQya01wU3M5UmNzOVRzS0YwMTVrKzU2bDZmeUJ0?=
 =?utf-8?B?VFN0ZXR4WXpjUGxNYU8xdXZHSlpoU3JXM01uRXZKVldYMmI4bkVpbFl3aWRM?=
 =?utf-8?B?TVZJVGVqUzRBZktCQ3ErdU8xWFVlUVlJY0F2MXQ3aHNKYVRKNWtDa0dlaFJP?=
 =?utf-8?B?di9haGducWw4bkx4a2prSitVUG9KWXNXWFFaUGU4TndIdmJ3NUc4c0hnbDlQ?=
 =?utf-8?B?aG5oalZXWXBWVVo4OVJhd2VPUStMaVpQTk9QdTNUb0tYSnQrVXVackV6VTh2?=
 =?utf-8?B?K1hTMGZuUjdabWZRNGs0OWNQYlRuK0ZZTTY3RGovTG1zWExIc2ZabkFWMHVx?=
 =?utf-8?B?VlJ6OGk2K2lXYzcwRlJ4aDNhOE5aZkdPcHYra1MrNlF6ZkZCV3d0NS9pOGcx?=
 =?utf-8?B?bXl0eDBFZUZmRy8zQ2RkbC94allnUDVsaHBxRVF1bWxZZFJ6eVQzQWgvRklQ?=
 =?utf-8?B?U0JtdDlNVU5kK21ieVhiTEorTGppTEE5MkRmMm9ROUFka0sxSTgvMTMrSk1I?=
 =?utf-8?B?dnRPV0w0bmlOK2NJdXNLcHNTV3ZUbHdXZ3lqSEpqdU1MamlNNFc1Mnk1bWJZ?=
 =?utf-8?B?UkxrUDRBMFk4QTJnVm4vNGVIc21Ld2wvYzZlbHhFWDJNaE9aZEVXZ0t3NTFP?=
 =?utf-8?B?MFJWU2xjUTFxRThHOE9tT1hLa2FoMUU5SE5DVG5jN0I5SHEzcEVNOHdiYm5K?=
 =?utf-8?B?OVdvMHUxWlNUdDJRK2VvZXBabUhMVUhzRnIvUGxScG5keE92S2pRaEpjT3hq?=
 =?utf-8?B?MnRNYW53Yk9uVEoxRjdEQnFaT0VleWZPbmx6R2VQclV0NkxlUWdaZ1Z3UFJP?=
 =?utf-8?B?cE9wZXhHOWNsOUhveGs5cHROb05qS1JQMTRscDlzVlZ6cnQ0ZCtubnF6Ykd6?=
 =?utf-8?B?K2NzUzdUMTZ3S1NXQkdVbTYxUzBaS2tLYVFkUEYzRk92cDd6ZFlKeDkyeEx5?=
 =?utf-8?B?U0xqMmF5S3FZUDIyS1dGME5QRVNxUVpHQUhUWkZUVHg2a3kwY3luTmxMczI2?=
 =?utf-8?B?MlBrT3VaSndMVXl1ZlBmdXJyNUwrdFVwSi90UUxtdTcrbi9OeFlTZW42T0pB?=
 =?utf-8?B?VVZFSUF3ZU9DeDlxcXljTlVFVXZSclgxc0VhdEkycmx4cTlLdXdjMC9ZT2l3?=
 =?utf-8?B?VzNWcmdlNk9uUm9HejZRMEg0WlMvdk9YMktpZENEYm9sN1krM2xYZk1pVkZi?=
 =?utf-8?B?cDNtMDBRYTFWZ0I2a2lNYnBuTzFhWnlRdm96N01DM1ZvK011K0tBd1p2cmJa?=
 =?utf-8?B?cmhFZWYrYnk3VVhxRzc0eG9ocC9NdHVIVkxTMy9PeGhqK2x4RFQ2MjlYOVc4?=
 =?utf-8?B?enZYTHVKKzE4b1hRYWIvd0oxTjFYdnBaTXJHc3ZkTVM3Z2FNTktJNTNtS2dj?=
 =?utf-8?B?WjJaWFhLWWFGVzJaMzMrY3daQzR0c2RDcEVuSU5CZGhZS1NPc004dUIvN21R?=
 =?utf-8?B?bGprVmNldUc4YXZudkcvcU1WS05POHlwYkg0K21SSEZ6em9tR2NuT3RKS3Mz?=
 =?utf-8?B?K2YzTDZVcnV5M2ZCeUY3YW5XdHJsc3BHY3U5TTdTSFIvSXliNFlySTVvTkhK?=
 =?utf-8?B?QWkxZTZMbEJWQ3k2SWpKWnNwTlh2cEh3WEZtUG5majdiVDRxN092MHh1RUxy?=
 =?utf-8?B?V0FxYTZJbU1vTVI3dkVqTjZPamxES1N2bE1lcTlTaHBSNmxjTDc3QjNIbWQ2?=
 =?utf-8?B?K2NPbjdYcU1PYUhXNkprY0RXMlBMZENKeDM5N3FJQko5ZWhaTSs5WjIvZVFw?=
 =?utf-8?Q?LzeY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG1ZK0tIY2dnQkRBVWtTdGxTeEYyUHVVbmFVT1RId0I1YlRHZFF2VVVteUZJ?=
 =?utf-8?B?c2NVc0dvM09tT0tTRmxBK2wwM2R4aUZYazYyN2Z4VENadGVrZTlaSkRnOC8x?=
 =?utf-8?B?Yzh4aDdFLzRKcVhVZjlIcDhLeUhQMzMvbWx3Ulhva2s2SEVkdkZheW1sV2t5?=
 =?utf-8?B?V1ZDVHFGaTI3czZPWE1LV2w1WG5xVGRmYjd6RmcySGxxZ1BXMkh2dEt6ZERt?=
 =?utf-8?B?cGsvbXlhTUJGUERZZVpKQ2xjUUZsMENoODRzWmtxWXByQndNVlVpSk5heUdq?=
 =?utf-8?B?Vk05MHM5TGRtT2hDZDRzbUNXRFloSXRlQ1NiSjNpUHRZaEhod0lHQkpSZ3k3?=
 =?utf-8?B?YjBKM1JnNXRGMWErMXlzM1hYZndndU14K1BBd1Yyb1psc1JPQWVaZ1B3SXgv?=
 =?utf-8?B?Q08yOHpMUWd2aVk4TEZDbkxtVW51TWpwZUJuN0hyZG54dnBsSy94YXV5akJK?=
 =?utf-8?B?aW1mQy9sVjdXM09scWE0Z3FadkFxc2V2QnNMMDhRdVRZN3RyZFo0Q2wxbTQ3?=
 =?utf-8?B?bzRoSnExeFZIT2NYZjJJUlBLMERyRTM1TEVyK2tRc3lISEYraVJXS1MzYTlY?=
 =?utf-8?B?NzN6Y3BIbnBGUkRDVzhtQURiU3VtRXNMWExNMkF5Vkx4RU9tM3hRWTJnaVlo?=
 =?utf-8?B?b0M0SEZIVnpFRHVrbkRPL05zcTFSQVAvRy9zSEo3T0tlekE0YlFEV0gySDlD?=
 =?utf-8?B?U2ZMNVNVQnJER0tBaHZFaXgvMkNuc2ZPWlZRUTR4Uk12S3QyQWpvblk4dXNU?=
 =?utf-8?B?bFlySnZBUzNpTU1GaUFyOTJYYzhWV1IrVHZrdHZVSEZ0dkNxcjQxQnR6c0s0?=
 =?utf-8?B?QzZiWDQzNHBUaHF3NElPY212bENwZFF5SDBLZlpFaXk2cHNtZmVhTEJoZDkr?=
 =?utf-8?B?RjJoblRiVUh0TFZveEcrRy9xYUpHam5ta2IydDMzeVR1N3RpUGVsZlhEaHVx?=
 =?utf-8?B?TmpLWGRXQ2FIU2FPYzJKcmNPaGwrWS9DOWdLdVB0bGNMM3FIN042MTNaTGJn?=
 =?utf-8?B?RU1QcVZMYll0aTMvcHRIUEVmM1J5UFlxTWtRdStPb2dvT0NGSWRxOXFHQXBj?=
 =?utf-8?B?cUtvU1h0TFFGSGJqL0NPbEpPSnNEbVlIcXhxM28ya2VUTVNxRy8xNC9sZXE3?=
 =?utf-8?B?OU5VY3dEczI3eEFPNnlRdUttcTNqL1IvS0RlcGZRT2VLdThsTFB3WnBDbjg2?=
 =?utf-8?B?TkV6YXB6bVpPQjdmUlRVWnZkc0JoQ1hrUnJyQ0xKQ21xMHFCV2ZRajk4cG5m?=
 =?utf-8?B?cFZyRUlBN0hrVWE3QTZrV2JVSU42RzhHekFHeTNONDN2V0hxemhpdk5sTVp3?=
 =?utf-8?B?QWk3aytwU2p2bWllMDdybDFEdU5tRUYwanFaQVpYU2dmU1RmTWt3eGN0c3Bt?=
 =?utf-8?B?RG43bXExQXhiSDRjMVRNZGJjWityMWl3OFBXK3JkMDhqSHBJOHNPWW94VmJn?=
 =?utf-8?B?NVVnYWJYZlJVQVBQZGI4Z0VwL3ZHb1M4Uzk0aURXZExyS0ZFeHdPUDlqbXQ0?=
 =?utf-8?B?djdraW1Bem9zNEZCelkzQnBTajBxQlVmL2MySmFFejU5Z0pDOUxLWkFybGxE?=
 =?utf-8?B?aEZzVkdEbFZqdnp3eGFoMk5ZdEF5NE9sVHk3NHAyWUlqY1VzaTFwVHZPMkJZ?=
 =?utf-8?B?dGxyR2lyd0pEbHE3QTRRaFFWQTBCWEtsUVNkM0xHUDVUVlRnaldkUTNROTI1?=
 =?utf-8?B?RCtrKysvaWRuNG96SXZVMU9pUnJxcDNzck40NGU0dGFDSm5lSHh5cm1MSi9M?=
 =?utf-8?B?TDV4NjlSdWVhSWR5R1JVQUNjUjZ2VTlSS1pXdE8raHR4NlZtZnJ1R0ZSUTVi?=
 =?utf-8?B?NEpkWDFkdS9VbHpQSXZrUjVmMzdRazVZcWdyVDIwOHJaU2laa29RYUJraWtZ?=
 =?utf-8?B?Q3BCQ1N0Qk5rNlBNRGFqbkNYbjFBZEppYlBlU1VSdVlyRHMrZnBJMnM4NWtT?=
 =?utf-8?B?UHFFMWpVQlluNjBOOElLRzV2U2lYWTlwSnhOczMrTTdZKzA4cWpyc2Z0YkNR?=
 =?utf-8?B?RGlHUTNISGNhalJyVDZjWUZCclRpR2YwWmZ5dFVJV3Rrd2s0Q2FTMTFHdFVC?=
 =?utf-8?B?SzV0VytBTnR2WURSOUF3NXB6WjZDRCs4NXBsTzBpd1dYY2E2dnZ4d3lOSU1j?=
 =?utf-8?B?dVZjK1VUNEJkWWVvVFJ6ZW56YUp0SWtPUld3NDBvMDMvb05uanpsRnNWUEpm?=
 =?utf-8?B?Mjl6ek0zSGVxSFBDN2YrQmdWVWFSZnBaYnRONGtSMERNTU1iSm9kcGFnVXlr?=
 =?utf-8?B?ay9lQ1h3MHUrMUQ5Qzk1SFJCVkdtR0xVeFhuNXh4alJRSlNTUmU3TTJsRWtV?=
 =?utf-8?B?eDBTR0ZYNkxQT2dwQ0liS3hDS3RIRVJteEhsZmVxK0wyT3kwQnQ3clNERTNT?=
 =?utf-8?Q?bbn+ejwm7MR3ToIc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 406d028c-b087-417e-2112-08de6e475335
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:09:35.2822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LC9jO+F0apiGAS7vtT5QwmNZtbL1sCiMqv/km6tutqxFSpDNxhrRaQoq0VtO1GYYCpk6lMxvabdF3JvGU3SEx4ASzHk8ApP7N/VMXDtOyco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6607
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/17/2026 12:13 PM, Anatoly Burakov wrote:
> Currently, when we compare queue numbers against maximum traffic class
> value of 64, we do not use unsigned values, which results in compiler
> warning when attempting to compare `I40E_MAX_Q_PER_TC` to an unsigned
> value. Make it unsigned 16-bit, and adjust callers to use correct types.
> As a consequence, `i40e_align_floor` now returns unsigned value as well -
> this is correct, because nothing about that function implies signed usage
> being a valid use case.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_ethdev.c | 11 ++++++-----
>   drivers/net/intel/i40e/i40e_ethdev.h |  8 ++++----
>   drivers/net/intel/i40e/i40e_hash.c   |  4 ++--
>   3 files changed, 12 insertions(+), 11 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

