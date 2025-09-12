Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC6FCAC582
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 15:14:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E24A340676;
	Fri, 12 Sep 2025 17:14:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5E6C14065E
 for <dev@dpdk.org>; Fri, 12 Sep 2025 17:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757690077; x=1789226077;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=j1mbuROyvrG8M4u2pRMHNAayPIZ7e0EpmO3eyKDhD5U=;
 b=LtT2PJO2M/Oug/cZCwwLq7L8j8vJx/MVTvkC6tiOIJdWYlNQEXp5FS+n
 GcBGBfYqig1Hib9H2OKehsUddBQ4yEa+esnlG0aPO8Cg3PyAyOLsGDatQ
 9kDEU426zmILXmEnwg5CDlvFVp0IodpNTVY7QTizazSmMLjmVmVQ2o6Xk
 MHK5RT2/CiU8J+80+9/l5GeVTGJ19+Or2iOZuI4FLQEvrcutgbvBtLPlw
 KjC6qv9/GmqwcuaIeYrDAEQTUbQd7S+RZnQgUyV44Dc+eFpfCwW8X8BCX
 XGAOIm18e3pSr0sgiUih9MLwZRLmFYiFE8K91B1Tsia0Q6KTZ1HnWNayt Q==;
X-CSE-ConnectionGUID: JeeTozZ0RnW7zpTzq67YpA==
X-CSE-MsgGUID: /B6KV/cNRiGrd3xw3WWpsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="63668776"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="63668776"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 08:14:36 -0700
X-CSE-ConnectionGUID: 0eVXKp7pRj2JnN/Ap161hQ==
X-CSE-MsgGUID: 4KXrFepTS4upkWtN3MHGwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="178332557"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 08:14:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 08:14:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 08:14:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 08:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTbymzMegGT/te1ZqkH4YzUf/T6oZTBNAuKKQveKBHl9NwVN9j+FQldTYUUhGjzj/XC6i2c9j1WIb99bCGhQ26NdE0AYJAUvA/ZSU2VpBg9p5LPJbYgLkucqQCLdRbvryZB47ZXIS6RjkPBfdS2C91oOUDmjGCgtmO3ZlnHDPBOe7PlvSWlajCH2FAvl+jM7bjAFXchfzNfTHYt61nK5i92ZAaOU15xSR5is091tmcBVbi3uf/ThsmFcIA6+zoSLVP5lr+NmaBINwvzKnt9s/lomFpWwER4gLhbbc8w1LEAVbZFK4UA4AdETa+QWb6xarVElBptrdjdg8s7Cvy2IZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNN/+pBUizdi9ze6pLx5feMgFTPXhVlAd7fBb5p04iI=;
 b=jsqiruI5qpjFGlzlO8CBMTWnpZOalaqBGor9XJXcK5/wZ2SKOAkYT2pXuPBRW1r+/aSYbYG35/b1fw117EOg2U5IHfOWuK33pjg0EOvIQ8y2QZQACo9qOsp/vB4eyYJBypHNAlZJULEbBgCJ/kH2uAFXypRWTfZO7ScpntzRiPfH5g8ivLT48yVMspE3lh87iJjj4kHvszkIJuiD1X+8n2OOiXuBj9/cxGn79KxY3aszIK5xuagParCw7r4vEMROgo/3n4+6K07fa1nNGiUEVZunBHvhfjA2fsn0Bhe0gOFp3BDJ4eBgAoW7LI8d2azaIKSiXQxfHoYFSGMxD7VEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 15:14:31 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3%7]) with mapi id 15.20.9115.017; Fri, 12 Sep 2025
 15:14:31 +0000
Message-ID: <6157cf0d-4a9e-4f4d-9278-24dd0507ed77@intel.com>
Date: Fri, 12 Sep 2025 16:14:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [RFC] lib/cryptodev: update API documentation for
 aux_flags
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
References: <20250827094338.767062-1-radu.nicolau@intel.com>
 <CO6PR18MB4484F38CE9989A01F49C8CF7D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <114c4b2b-f619-4a12-ac0c-adca09fe6033@intel.com>
 <CO6PR18MB4484C9F7FBBCC5AA04405899D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <CO6PR18MB4484C9F7FBBCC5AA04405899D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:10:232::16) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|BL1PR11MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 6818eb41-e67a-4466-5e28-08ddf20f12bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTlvSTdxdWcxVFlTaWFNUFYzY1NZWTRKeTM1NFJ6TEx5S0lhdHV2Sm0zVzd3?=
 =?utf-8?B?cElwcjFaR3JHZGZaSHVCOXhJU0ZBWjdmS1liUXYzMnpSUVh3SkJCK3pZQU5Q?=
 =?utf-8?B?akNXQmErdFFtR2JFazBuaVdzRGRDd0I4b0ZkeWNlTmZ0MDBBcXpYbTdLREZZ?=
 =?utf-8?B?TCtXcitXSVFmK011WEc1c090RGxDSWE2M3lMb0RZWCs4UUdTUXVPYUdXR3cw?=
 =?utf-8?B?UEUvMkVlbEpwRVhjVXlwRmFlcWVnRUFmeHh2M0hnRHhFbzZ5ZlVTV0dveE1D?=
 =?utf-8?B?azNIbCtZcTdFb3dETENFM2M1NXNVUVUxamo1c3E0RGdqVWZxQ1pJOE45c1V5?=
 =?utf-8?B?VDdqZGVZd1dRSHBaQnpiQ0FxeUVndFEzUUdHbmg3TFBjTFVKT2ZqeEVacWdy?=
 =?utf-8?B?aXdGcGNSTHJsUFJSVGlna1FnaTVyUjdRWmMzdis5bUg0RzhEYzlZKzB1MzBw?=
 =?utf-8?B?amZuQXhRQkNaMDBrQUltalRWamdOK3Z1UFc2N3dmcXJRNjU2ZkZ4R01oZmo1?=
 =?utf-8?B?ZUhjK3lEdFdOdHBCMVZvUUFKS091LzViL0VIb2FPd1VFYytpV2tQSDM0UjZF?=
 =?utf-8?B?SzdrVTZoV1FIWGUrZmlOenJIekhHNnRlMzVvdnA4ZzVmOVAxSEJ3MEpHcFZx?=
 =?utf-8?B?ZHEzaXY2R09DNkhhQmkxS0UwVnlHQ0pjbHhMYnNnNHQ5Qmc3RXVkdkx6VmFM?=
 =?utf-8?B?Z0JDbURYZGlEa0pRM21zRnFJOGsybU15SHhLL0ZLbnVwbTVKT3lTSEtmcUxu?=
 =?utf-8?B?ZnFQRDEzYVJOem9iM1Yrb0hjcTV3MnBBN1h2bERTaVRaK0J1NHAxYi9UTGVo?=
 =?utf-8?B?U3dWaE5SRHpBR0preEp3dkk4bHpoaFRKMnBWRXA1cEJnV21xV25McUE1SDAx?=
 =?utf-8?B?K3VRQUMxQXhTWGRkNmJvR3lCeU1hSnBEVFV0Znp4cWxmOGN2VWp5MXVEY2hE?=
 =?utf-8?B?cllEbWZsOWVyZHJwZmN1bmg0NnlRVnc5cVZWUHlkV010TDdWZGUxbFc4ajQ5?=
 =?utf-8?B?V1ArNWRpb3ZqVU9mRU5FbEVzQVRWNHJ0Mm5VOVhVbk12b20zVkRJaTcrZ1NT?=
 =?utf-8?B?NUZ6dkpqNWxpMUlCVXNRRWFWRGVMeUV1dEMyK0grbklPbTVjTlBWMlZZbXgy?=
 =?utf-8?B?YlZoM2FZellDMXlGL1JiNmlManErL2Q0SmZZMmZnUXZZZzVqVnZCd2pmZy9K?=
 =?utf-8?B?MkMxMmZEeEFXY1lNZzdtSzZvV251alZEclk0b0tzN2RSTkZaUEphRFI4NEEx?=
 =?utf-8?B?UXVqN2F3U2RlTHlLYW1SN1RTc0dWSjRmeGtTbksyZlY3RGVTaDl6V3BSNzls?=
 =?utf-8?B?dWx5eHVuN29Ta0NyZ1d3L3Eyd1laVXlRN2xYcmJ1UWh3VnNCeTlPRmlFMTdR?=
 =?utf-8?B?blpoNXZMVkZIQmxqVHY4dTVIK0tYU2pBZzV0RnBHTjRUOUUzL0ptNDMrSFBr?=
 =?utf-8?B?T2tSNzlFNjBDSlk3VlJ4Yy85cWNJN0NXeW02V1dwOHhKRHkwVnVlNVJLWDRt?=
 =?utf-8?B?T05ZeVoxRW9JTU4ydHh5dm5maXczMXltR3FRMWFpQjk5YW5sd0k2YS9tQS9Q?=
 =?utf-8?B?dW92eEIwa3BZRmFxRzRLK3JWQnhzUk5MVzBHOVlEckpmR1lidlZRSktteGJR?=
 =?utf-8?B?Y2NMVnZDZklXbFNQWFVSY2ludVVveWptMkRLSnpIR2tnWmh6T1BxQlJTNTRs?=
 =?utf-8?B?cmMwMEp3cHN4ZU9heVB3dUNyNGdhd2s3em1xSGVKeTNPVkQrUzdzWS9veEh6?=
 =?utf-8?B?dmRDOVNJOXhGTHhzRnVteUdqRmVvaE5KdFJ1QzBNbndLUXdVSTdmOEZSQ3h5?=
 =?utf-8?B?SkF1RkwrbCtWOVVYWm9iNzBqdU0vODdFcjZ4M2tjdk93Sm9mVUFRdC9JVHpX?=
 =?utf-8?Q?n9YSpBF6OMb5T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay9oUHVlN3hzUVNHbXdPYVNxWVNDcXpUbXNlM3hVTDMyb2pyNE1RNW5rcE5i?=
 =?utf-8?B?Z0RkQTFlWm5wTHRaaG5LNjR3OXU4MVlBSHB5ZHZsQ1V1My9RbWFueGsxUUpr?=
 =?utf-8?B?N0pCNE1CYjJySVpNV1RvT0l2L3ZYNHI1MEwxOGppcWJnWWJubGdDODJCeGcw?=
 =?utf-8?B?L2ZxWXgzVHUrSGN5Qyt3WFp1QWcyMlFoWFNObUtLa0ZWb3lnbDRGYy9QZ2M3?=
 =?utf-8?B?RnVMWndKd1N0akk3YkRlMitXdUF3aDNSUGJsaXhxOGIraXdVa3JLcldEQVUx?=
 =?utf-8?B?cU1pRDlpdEFkaTFOSWh1MURGczdGdXA4K0g5QURRVUFxaWNYVHdnbkkwRUhW?=
 =?utf-8?B?ekhrdmZDeTROSm1SSVYrM3VJUXlUL0hiV0pRNDBWOTl3ZnM1WjJDM3VCK2da?=
 =?utf-8?B?bmtKa0krU3Y3UksvNWh4NEowNWJFZlllVm13NWdSY2RWeWRwK1FXOTF2Y2Q3?=
 =?utf-8?B?SzRaOEtDaDIrS3hnQjFPV3dxKzVGOWxoajVTV3MxaTMxSjd4bDNhRE85eE5n?=
 =?utf-8?B?bzlrQ2hZT0YwMmZBMUh2M0ZTam5JdFAwOFVSVjA1bnd3VTFHZDFsOEx5NTh0?=
 =?utf-8?B?cUY1TzFHMHg2SEorUG5YT29hYXJlazNJMStYbXRKN0NaemFzNVErYm0yWFJP?=
 =?utf-8?B?Nlg5R2hyUkNZZFhDc3ZWUXZCNEhMcHl1UUVaUXBCdnFwRWJFUEFBMUtzeHdo?=
 =?utf-8?B?Uit0YVpIb2YyVE8xbkZwSnh3OW42amVqV2dlWlBibHVyYjNJeUNjZnQvekNj?=
 =?utf-8?B?R1NpMEtCUTFWVEgweTJWN3FRK1pCRnhRdWdzYTNzekwyZjZDdElpZE83NmxD?=
 =?utf-8?B?VWZiMmF0QWFzRkFXQWdrYUJCYWl5ZE5OaGtITWl2bUdZNkFmWitGK3ZGNG1x?=
 =?utf-8?B?QWlucWloRlpHT0JSNWVabTFYN3dJWWRZeUpqczZjb09tUHNsRGtQU0hMcXZt?=
 =?utf-8?B?TWpDS0dpM3V3RTZvS214L2djWmdPNnN6WUFBUjB6cldKVVZ2cDQyV0Y1NFcy?=
 =?utf-8?B?Yk5kWGxabC9rb2ZWbllLTlJmSjFmdXdHL2xDbWhiY2pIS1FTdHVuNGlYZXRp?=
 =?utf-8?B?SHZSRHR5SDVaL0VnajFiN1AvK1F5Z1pmOE12NkVLVmxIUzFrcnE3T2Q2dkdv?=
 =?utf-8?B?NGZZVktFQVY4YjBaK1VUVlE2bWV4c0o4d1BWNy9hbGVRZHpSNnF2R2VaMTJC?=
 =?utf-8?B?Zk0xM0wwREU4TzZabGtQaDVReHM1STZyMVpxZFlncElZS2Z3NG80Q3ZVNEY5?=
 =?utf-8?B?Ykc1L21iR3YwQjJ5QjBJYXUrLzVLcGtkdXpHNjZMQXBGVmx2TVFiR0REVWcv?=
 =?utf-8?B?QXlvN0gwaDZOTUJDQi9qbW40Z2htUHl0QXUzWDNiSUs1NTR6U0g5NFpLbEhr?=
 =?utf-8?B?TERBaEp4cVVWalM5TlM0b0FqaUdCSVl0WHAzUDF4NTM2N0FocWl2ekdyMDhh?=
 =?utf-8?B?MzVGMDFaWU8xRG9vUmlaOEd2b2tzMVpUZzNCdkFKUk9SUURTdnhQREJaZ2JD?=
 =?utf-8?B?bnBKbFRrcFVGdjhIN2ZmNmlRb1V2VkpPbCtRb3Z2Wld4M01MZlFwbUhDc0Zt?=
 =?utf-8?B?L2xQRUk2WG45disxVXF3djFlTUxhNFUzNnFCRDFHWHY2L3RYZDVxNU9CUnhZ?=
 =?utf-8?B?RUVBMk9UM3pMeUlSQisvczIySDgwQm5YTXVuSGpmODVlUncrcm1tK2NMUWlN?=
 =?utf-8?B?SGJlcEw2NkEzSm1HckFUbnBtYUY0dnJWM1dwdmxOci9MNDgrNHNvUWRFVGtH?=
 =?utf-8?B?SVRBQUZtWThpTGZ5c0t0M3lFOVJsa1JicFlIK1FWYUxUUUVCVy9vQmdQUkdP?=
 =?utf-8?B?ZWNjWnBST1hoNlVSczB2cm9pWFJQNWZZWjV0SGsvNFhGRDREeE9wWExoaWtz?=
 =?utf-8?B?RkpPMEp5aGN2LzdOOVlBZGJmOHFxWGtHVHhBRHRrNGpqTEw0ZzF2d2lJUnBL?=
 =?utf-8?B?MkRiYVYzeFhQMjJRbFJwSEZFVWh5eUFrOTVQZ2RpVFBnMXJNbXo1T0FtbVRz?=
 =?utf-8?B?SkIyWXNZWnRtYnZXSzdRVSsyZGgwZW5PaER0SEFxNklOM2xzWGRkbTJDOXhq?=
 =?utf-8?B?NU0yd2Y5Qkp2a20xTmlNSnBPc1JUeG5iOUU5dk5CQjh2US9MSWV0SEFBQ0Fp?=
 =?utf-8?B?UmhVam4wOGRucGFiQ0UvdzFER292Vk1ZYmlITzNqSS9QOVczMStndTdrZGJt?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6818eb41-e67a-4466-5e28-08ddf20f12bc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:14:31.1414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlZnfFObRJ1syAvIC3EkQoikhCvZjeCYcEU2wSOWy1ql6tfBaM5Tk7TjWdTVEkKUT2KPx4f8pHRYSQCreaCOmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5978
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


On 12-Sep-25 3:56 PM, Akhil Goyal wrote:
>> On 12-Sep-25 2:05 PM, Akhil Goyal wrote:
>>> Hi Radu,
>>>
>>>> Update the API documentation description of rte_crypto_op field
>>>> aux_flags as to allow PMDs to define driver-specific flags.
>>> Can you give examples of the flags that you want to add for driver specific
>> work?
>>> I believe adding driver specific things here may not be good.
>>> May be we can discuss the specific flags and define them as common for all
>> PMDs.
>>
>> The flags we have in mind are very PMD specific i.e. controlling
>> specific hardware behavior so they will not be suitable to be added to
>> the common flags.
>>
>> Seeing that aux_flags are not that strongly defined and seeing that they
>> are already potentially used for PMD specific values my reasoning was to
>> formalize this possibility of usage
>>
>> aux_flags are used here to potentially carry a value that is not covered
>> in the common API aux_flags definitions:
>>
>> https://git.dpdk.org/dpdk/tree/drivers/crypto/cnxk/cn20k_cryptodev_ops.c#n857
>>
> The aux flags that are currently defined are for soft expiry(out param) and TLS padding(in param).
> These are not PMD specific and are defined as generic flags passed by application
>   Or getting more info about the crypto operation such as soft expiry which is not an error
> but will be useful for application to trigger rekeying in advance.
>
> In your case, these flags need to be exposed if application is required to set.
The application is not required to set these flags, the RFC change 
specifically states "optional auxiliary flags".
> And we cannot define pmd specific flags in rte_crypto.h.
> Please specify use case if it can be useful for other PMDs also and we can add another flag.
>
> For PMD specific flags, is it not possible for you to use mbuf dynamic fields if it is an IPsec case?
> Or we can also explore to introduce dynfields in crypto_op.
Yes, we can use dynfields and we can explore adding them to the crypto 
op, but since we already have these flags we can make use of them.
>
> In above link, cop->aux_flags = res->uc_compcode;
> is set to give debug information to application, as warning codes are not exposed in crypto_op status.
> Application is not required to take any action based on the values other than the ones defined in rte_crypto.h.
My proposal is very similar to this use case, just in the other 
direction. The PMD is not required to take any action on the value of 
aux_flags, and the application is not required to set anything.
>
> -Akhil
