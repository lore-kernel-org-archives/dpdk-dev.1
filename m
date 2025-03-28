Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FABC28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 09:02:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 892CC40273;
	Fri, 28 Mar 2025 10:02:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A9E0440261
 for <dev@dpdk.org>; Fri, 28 Mar 2025 10:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743152526; x=1774688526;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=u9DSphU3onv4SNzU06a/Cn8h3Vm/s5rmCIz04zsRdvw=;
 b=InwEMul397SYXe2bHqUgeaa9nENI9pj30EmnzSQ6LH1FvDzO7pfwsQ+Z
 Jcbt1tuW/zfZjWeiX8PdfG6kjaCvqEsesgRRM6S1/8UGUwI2Ac+SqwSSr
 9un06CJH2frr9WM5Gha5LlUsQqp8vxo89Nz5W1AT259PaJCwrpiq383GJ
 XpYmJ67ir6W2ar8u0Me1eDJaeNHMq1rhKLB2F5nAnuXudYod5L+KDK9hP
 FAzj3mnEtXf8WhvQEZhS9MtpuHzjLU0EOyIu78+aYMPv+cO3Ev0nti1rW
 mlOorglO4O1Vlt4uWegtdLDAQV78PmjWA0IYphKENN3NqGX3hcOdnhqBo A==;
X-CSE-ConnectionGUID: uHSd/1EdRq6H3fHjVwccrw==
X-CSE-MsgGUID: kBqyHZ0iT4mR77GXBoUTRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48166765"
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; d="scan'208";a="48166765"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 02:02:03 -0700
X-CSE-ConnectionGUID: 5sQRBNwGQ1+Rjz0oYguHYw==
X-CSE-MsgGUID: oOEvGkYNT+mpXoIgFUMYJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; d="scan'208";a="130109325"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2025 02:02:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Mar 2025 02:02:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 02:02:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 02:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLLUzA5n0nNwlBwngF/9VgFg7cySYGUtxdvDir8+c7PjSZXzNtIFUq5jqCfC+UVCMi7ANWcnR+KorVfdxG3FE4/VMTTe0oiPc6IybMQAhJ+RAfPsViFpOfYoYojFqo+V123HF8bZ9qSWfQ62pJTatLeAVHenuY0ognvh57QbsHLn2fWCjsNHHVN+hEUikhK0zF/v7mk6Jz/mX0/klo2fqaGrwk8iLAayDQWjduYdg7r4U1JIhHnDiH2v943K1WlqG0pbNwe/X3hHn9ThY6B9f3d0HgEbiTibxPX9L3KZt21aQ5bXbrO1T2jE2AGTbL66b8LrKYVyAv7lvBSSbQqNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HruSbt75j+OHHIG5rrXh3kFsQp6sHAnOiUg740egMaE=;
 b=wBXTYXxJK0Pi9vKH5leTViawY+0YQXOL3K5kdP1LaCqWbAgXPH73SAAE87xpa1GkEnuxRhDaxKlImpxqpzpszToDoczvfalJJWf7isd2wrrUQtvtsfABS4B+pa+iWofQ+Bz2bM/gFfqFnVFUpeqeEyq2UEB7nzJiCCEMH63clP3RqoLD15ctncOjwkegJpkFNCvWZbNTZNxo/JnVHmq5oFTl2rNxebQS+YpIvxB/tZCaiHehQH50PaPMJmh0plrJP7Um1CcCH4DVb0cheM8/sHZpAM3bppFTDBi7SIfYXSbdg1U1QsvSJWGSKhenXoyoq4649X3/nKXMOq2f4FZV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7249.namprd11.prod.outlook.com (2603:10b6:610:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 09:01:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 09:01:57 +0000
Date: Fri, 28 Mar 2025 09:01:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 0/9] net/intel: clean up base code build
Message-ID: <Z-ZlgQHcTo0tOI63@bricha3-mobl1.ger.corp.intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
 <CAJFAV8y8eqnTDmsku8=HrF1fQdDuBNYyaKfzWCg9J1Z5P8iYVw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8y8eqnTDmsku8=HrF1fQdDuBNYyaKfzWCg9J1Z5P8iYVw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0228.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: f40ebe89-a46d-450a-530f-08dd6dd7315c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3pPR1Y5ZFl5MHZwY1FYdUxWRWZ4aXZWdUhiTGZuemZQbkFFdmVWVHFYYm5n?=
 =?utf-8?B?MlR4RngwYVUyM2c5enlEaWxaTHBFTG0zL0RtNFZGSWtoempDWm9WamlWd21x?=
 =?utf-8?B?a2kxY0lHNXFIRzQzVWE4T3VUOXFzZzdOTk55U1piUUFnL3JPblpiaXFCMHJm?=
 =?utf-8?B?RVdrdXFKckFIdnhabm5QaHhlWllKYmJkdzJFTXpHL3RoS3ZhZjRqUng1OUsx?=
 =?utf-8?B?NmZsa25GTVpLc1ZFTXVpcmJmcXhIZk9JU3F4dmo2SHVPMVBtVjVqTTRoK0Zt?=
 =?utf-8?B?b0I1U2FZWUtvejVHMEFOWlNhNnFnZnpDQmVhc3FNKzRrL1RGSGRiaFpBS2kz?=
 =?utf-8?B?K0lYL25OOE5ULzQ4YnFsTGdEbzhMbzRBdzdrTWhZU3VOMUMxam1uRy9jcU5K?=
 =?utf-8?B?YkxkMnRBREJzK2FRUm1yR2x2bzAyVTM4czBHSFBNUVgwNnBUcXBWTlJDOTdC?=
 =?utf-8?B?Tlpid01aUm4wMThXZUo5Y0txemZxbEZZM2FhMEc5Q1NucDFld211WmNhNXgv?=
 =?utf-8?B?Rzc2ckgvOEZEMlIrdkRyaFNwT0p0Zm5GVFdGbVBGNE1kTjRGTlp1VmRRV3V6?=
 =?utf-8?B?RDhOZy9WTUNqZ1JOQTFpKzJ6YU4ra2hTTVhobVBHMjZsTVg5Y0RLbVNsdDBp?=
 =?utf-8?B?WkRDd0VVMXJ1VkY0Z0hxeWVLZkNrL2hSL2VJQ09zNldBUHhQejZCRXNMSjBk?=
 =?utf-8?B?REhUZGVhSVQ1aEJsUGNIT0wvQlJYVCtLT1B3eVlvYnBuSVd2K09xc2RoU2pF?=
 =?utf-8?B?R2gwbGw5MCt2eGJTK0FHWXp0M005YVRkOEczOGVMaGVnZGxTaXdGWEk3UGdo?=
 =?utf-8?B?MVl0c05zUXMwaWo3RFdmQ093USt5Zmd3ZmJSWGVkTHU1Z1pwR2xRakEraXA2?=
 =?utf-8?B?Z0hzK3duSm1kM2paa1VUVktoOXZMbThzMTJHNktrUmo0blFSWjF3Sk5rSVQz?=
 =?utf-8?B?UWJDdkMzRktCMEZTN2FCbk5wc1BhRXJ5WHhvSUNKQ3habVYvV05hUk50SE4x?=
 =?utf-8?B?cmg5Z1JvVUFubXYrSS85c1FQNTRGSWdJTzBGdm9OZlBlaEJVMmo4SEJUU0xN?=
 =?utf-8?B?L0RRNVNLQ1I0N25oRnBEbnhTL3d3Q041Y1Vidm5Ub1VianNYSWgxWU5rOHNY?=
 =?utf-8?B?Y1lQbzRpeVorTy95dmZRRUNvbjFnOFBBekNwOGVTaGRhVittdU8rcGs0VFVq?=
 =?utf-8?B?eEFyS3hmZjE3L0ZyVldaM1RCdUJjbzFXeDlsN0JKa1FjZklCQlV0MXRQU3Fn?=
 =?utf-8?B?dHRrRE5xVWZ1WWdjVHB5VTMvaVB5VVdCbkgvOSt3VHp5b2hkdHBoWTh1RzBJ?=
 =?utf-8?B?ZXB4M3dsYzJSeHhVU3lWM28xa0xrdXp2M3hKSFUwdkR3ZXFPVEJpNUdyTDNn?=
 =?utf-8?B?RGdod3V5TUVuU3lLaExJYm9XbXdUUThsbjh5MzQwcWJSVlMxVVMxZjBQN252?=
 =?utf-8?B?eWxWTXFsWjJJSHZqMEFEZDFQM3ZFV29RenNqMmxod0JxVmRtaUpENXM4aGpp?=
 =?utf-8?B?YjNEa0ZycStYVUZWNW8rczdJY09hREExVEVrd2hnVmFHclZCN2xYV1Y4K04z?=
 =?utf-8?B?RUkvNXRtOTQ5VWtGZVVHelcwYzF0alMyZExGUEFUUTlyN2ErcVN2U3lNRDdp?=
 =?utf-8?B?UFdhUmlqaDdKbmJvSGgyRXhKUGZXY3RqN0t4MWdlVmhuTVAxTEg1ZTFLclBB?=
 =?utf-8?B?WU9XaWl4ekJVMm0zVncyL3ZILzBkbVpPTzJpY05UV0JhWmVXK1ExWjJmRnhJ?=
 =?utf-8?B?RlZWd0RmZ1Z2RmlmTDAwa01DdUR3M0xRczBLWmU1OUl3STZ5Skt4bHZISzJK?=
 =?utf-8?B?WDlpNktlYVBtc2M3MThPT3hyVDRJclRrZ3hjQWliZzRZbzlsZjRVYnIxbFNq?=
 =?utf-8?Q?JnuPG/k/XAhr6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eno0eC9ldkhwZVYwL0hReXg5TXVtTnI0U1FmWmcxc1dpeVFueFBhbEpNVE8y?=
 =?utf-8?B?a1FCUFVKR0liWWZyTHM4K1FzLzBDUit6RmQ2NmVpMEEyUkdXTUlPLzU4YXdo?=
 =?utf-8?B?OGJkSEdWbDR6d1IvazJoSlAxWit3Sk04T0VSVFFsYmdJRUlidHFPbUJLT3k3?=
 =?utf-8?B?TjczaGFYSEl1eGFRQW01R3RLcUI0ZWtMVTQzYlV0VU0rTmRtclhodjUvSGJO?=
 =?utf-8?B?K204Y2Q1cFRSVWdnOFgxU0VQbng1UU1vVU9CbTBLRHBSTWEvYUZ3dHdOaEN1?=
 =?utf-8?B?RGJ1ZGxRcFNmaU1mYW9EcjQvOVBHVzJoWTN3Mm1yay9IQ0ZQSW9xMUY3bW9L?=
 =?utf-8?B?UktrdlhybDlEYk1LV0xxN0hieXNWU2NYdWdIUXllcy8vNEx3QWtyTXYrb1Vp?=
 =?utf-8?B?OGw2d1VkSmNrMlh1eGpzNGNRQU1oMDRjL21RZXJ6cEp2M3dTeEIrcG95cHdG?=
 =?utf-8?B?b1NYN1lRdlFxMlNnOXlQVDhVU055Y2krcm05RHRGdElpY01nbGVFYVZEU3BW?=
 =?utf-8?B?bldGNGdmd0c3Y1BMQUJLNVgvK3h5VXRFc0MrWW9zeXRFR1FuRXpSVVZBQTFz?=
 =?utf-8?B?aVYwY0Q3UVp3L2JDNWdnRUJUcEJKdjN1UU9TZHBSZWFhVlZicFNmQjVFZ1FZ?=
 =?utf-8?B?M211NFFxbWNGS1RCMmhNT2xwOGY1OFZVakk0ejMySGpZMG4zak5zMXlsOHB6?=
 =?utf-8?B?bzBsdnRHSStENXdWNXdJMUxRMFM4dkprLzRxTXVvN1JyT2FVQ3ZtdkVuZTJQ?=
 =?utf-8?B?eDFnWTIwQjN4UWlITjY2SVp2RVlkQzFHZmUzY3FCWEVidTBsMCtZelNKUlZG?=
 =?utf-8?B?SWFXNjA1ZGVXOUhnQXhySFVRd2pnQ3NIY2l2N1FvZFdpTkpNTlNPV2FHVldG?=
 =?utf-8?B?VDRXNzlNUlU4cVNwVUVWVU4wMXVrMUpPVlh1bEdNamd6QmFRVWxpWmxuRnpU?=
 =?utf-8?B?c3drUkgvMURxcUVWZ3IzaGd2azUvQ3BuU0NxRXF3Ykhnbm0rc1dIa0tHT1Fi?=
 =?utf-8?B?R3JmUlo0RnQ1WXE5RThwNm5tdjdLVFB4bTlkOW9meXhVRGE5bEFheGM1ejBB?=
 =?utf-8?B?MnVCMEJkemk4ckhjOVdzL0Y0cTdDZWRPSFBmV1g1a3lGT0J5UHhBZ1Mrd2l2?=
 =?utf-8?B?NExzNUxFNFVJbk0wZDQ5bm9NTlovUFRrNUxqMU9XeDc4aWFvRGNpYmV6WXFm?=
 =?utf-8?B?RGYwVkovdWsxREFRZURZTkFERWJGR2xlNUNlOEY5OG5tVTU4eUx2SEdtelhD?=
 =?utf-8?B?VFhmTXp4MWNtV3p4WUw4UkJsUm5vNEVFWFp3dDVkbUNnMUsxbFlnSVk1cmph?=
 =?utf-8?B?M2tDWDRra0hZTFFqY1laUWU2dzZqUUp3MWRpamZTRXlwOUtlTVVWbzh1eEtJ?=
 =?utf-8?B?cWQwbUNjcVI1SXdrTkVUQUhVeWY1ZSsyMFdMeE5MUzAzUzllRFhtNSthMFJl?=
 =?utf-8?B?cFA4UWp0cUtHUER1TTNNeTdSMk80NGIyMC9hUlZDMmo2YmN6RFhZVWJ6WFF1?=
 =?utf-8?B?MU02SUhIWDl4cVI5MWNBRnFMb2RobWxiK01ZeVNLdmQ1eS85a2QvLytsZWMy?=
 =?utf-8?B?SmVZLzRuRWZoNW9hVE1VU0t2QXh5K1hWZEdaWHB1T0NXdWF4TlVDdGRodkJD?=
 =?utf-8?B?ekJnWWpxUmVjbnhaUEtzcE1RSmsrc0NUajk1UGc3ZCs3WDhEN1hnSW5PRE1M?=
 =?utf-8?B?eEdvSU1BSFh5L2tRQkxNdkZLOU9OcWNkQ01WenNITXdEZ2docXE2VytGMVJW?=
 =?utf-8?B?WFhnS1JJbVBHa1dzU09KR2JLazhDUHVPcVcxZGRpbGlhUFBQcVNMRzZ1WnBQ?=
 =?utf-8?B?d0dvZmFRQ0lxYXJVTDNFbU8vaTR5OWFVa3oxWTNFNllHUHVLTmxrTFVxb0xu?=
 =?utf-8?B?L0NLWlJkQWtWT2NwWVIxTnp5K1Z3V3hxdllNaDcxK1N3WjE1TUZMTitHbkxQ?=
 =?utf-8?B?NVBUVE5rb3JYYkVtWG1XTXEramw5Z0NTdW9kT2RtSVdDUGxBUzBXYTdQckg5?=
 =?utf-8?B?ZFNSRFNCYTRtZXZuT3ltVnRoZklqWGxpaUd2QjRGbmdlOEY5OUU1bDBPc1dL?=
 =?utf-8?B?RDNLMG53UmhsTDhYeUplQXlQQzM4eFQ4UHNFaG02ZjJHRTBIK21jbWUzazhV?=
 =?utf-8?B?TE55R3ZqRm5PR1FJaHRESHNiT3NoTnZ4dUhKWUJuZHVaN2RPS21uZWZ2OWpm?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f40ebe89-a46d-450a-530f-08dd6dd7315c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 09:01:57.1285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WS3VBz8QqKyqn9Ks9SbrrDdG6Z2OHLjB/dYwX2iRP8SR4TReMPvXRU2I/aH94ZHKGDRJeNNMeTREq9lGFJDZ7LQaLNQcZ8cp0IKE8qI2cnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7249
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

On Fri, Mar 28, 2025 at 09:21:03AM +0100, David Marchand wrote:
> On Thu, Mar 27, 2025 at 3:52 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Simplify the build of the various intel base code directories, by
> > clearing compiler warnings so the files can be compiled directly along
> > with the regular driver files.
> >
> > v3: add fix for lock checker issues on FreeBSD v2: added missing patch
> > for fm10k
> >
> > Bruce Richardson (9): net/fm10k/base: fix compilation warnings
> > net/iavf/base: remove unused meson.build file net/ixgbe/base: correct
> > definition of macro net/ixgbe/base: fix compilation warnings
> > net/ixgbe/base: fix lock checker errors net/i40e/base: fix unused value
> > warnings net/i40e/base: fix compiler warnings net/ice/base: reduce
> > warnings for unused variables net/intel: simplify base code builds
> >
> >  drivers/net/intel/e1000/base/meson.build    |  9 ++-----
> >  drivers/net/intel/e1000/meson.build         |  4 +--
> >  drivers/net/intel/fm10k/base/fm10k_mbx.c    |  2 +-
> >  drivers/net/intel/fm10k/base/fm10k_osdep.h  |  2 +-
> >  drivers/net/intel/fm10k/base/fm10k_pf.c     |  8 +++---
> >  drivers/net/intel/fm10k/base/fm10k_type.h   |  6 ++---
> >  drivers/net/intel/fm10k/base/meson.build    | 21 ++-------------
> >  drivers/net/intel/fm10k/meson.build         |  4 +--
> >  drivers/net/intel/i40e/base/i40e_diag.c     |  2 +-
> >  drivers/net/intel/i40e/base/i40e_nvm.c      |  2 +-
> >  drivers/net/intel/i40e/base/i40e_osdep.h    |  4 +--
> >  drivers/net/intel/i40e/base/i40e_type.h     | 14 ++++++----
> >  drivers/net/intel/i40e/base/meson.build     | 23 ++--------------
> >  drivers/net/intel/i40e/i40e_ethdev.c        |  1 +
> >  drivers/net/intel/i40e/meson.build          |  4 +--
> >  drivers/net/intel/iavf/base/meson.build     | 10 -------
> >  drivers/net/intel/ice/base/ice_osdep.h      |  6 ++---
> >  drivers/net/intel/ice/base/ice_switch.c     |  2 --
> >  drivers/net/intel/ice/base/ice_type.h       |  2 +-
> >  drivers/net/intel/ice/base/meson.build      |  1 -
> >  drivers/net/intel/ice/ice_fdir_filter.c     |  2 +-
> >  drivers/net/intel/idpf/base/meson.build     |  2 +-
> >  drivers/net/intel/idpf/meson.build          |  7 ++---
> >  drivers/net/intel/ixgbe/base/ixgbe_common.c |  4 +--
> >  drivers/net/intel/ixgbe/base/ixgbe_e610.c   |  2 ++
> >  drivers/net/intel/ixgbe/base/ixgbe_osdep.c  | 20 --------------
> >  drivers/net/intel/ixgbe/base/ixgbe_osdep.h  | 29 ++++++++++++---------
> >  drivers/net/intel/ixgbe/base/meson.build    | 20 ++------------
> >  drivers/net/intel/ixgbe/meson.build         |  4 +-- 29 files changed,
> >  69 insertions(+), 148 deletions(-) delete mode 100644
> >  drivers/net/intel/iavf/base/meson.build
> 
> I see that you kept the base/meson.build in most drivers, though those
> only provides a list of base sources.  Is this because you expect having
> to restore this special handling in the future?
> 
Not especially, no. I would hope we wouldn't need additional warning
handling in future, though one never knows. I did consider removing them in
this set, but have decided against it (for now anyway).

I am planning on doing a follow-up set to move the handling of the base
code builds to the "drivers/meson.build" file. At that point, I'll maybe
decide to remove the files - though again I'm in two-minds about it, still.

/Bruce
