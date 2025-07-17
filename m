Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A81C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 10:55:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 174324013F;
	Thu, 17 Jul 2025 12:55:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id DEB8A400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 12:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752749727; x=1784285727;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=h/kgjl1KEbrewltbOESpXHA9sDG27mIIxOLF4fhMV40=;
 b=LZRGUmEYCelVAD96yqJQzggMa1gb9tQdFV7FQBjHql/HUcPag2D8K2Yq
 wYRSQivADx0KXqBzEh1pUihgNO5+1epGbMOb4dUCrc3fVfq1EHIGO/j5R
 IEdT7HWRVZ/1I+CBvs183Myry82jPPfRf8z8zmewDU10JbrsnwIPywLiU
 vWHGmsMdvKDouo8m0WMaUkvjMTCHpJdwx7b1YlrUeDNB7dGXoDk3/i2eS
 vfrFnAzkRETmroaXQO1wHBE4imBSfoE8Kldx1ebD6uua8uvg9ueBLHJp+
 i+HQxaXCcO8uxum6jojYZCBDD9wRREGrnOanZu/c92GMgJ6nUHj10M4ZQ g==;
X-CSE-ConnectionGUID: eM0CenaLRhaDER0W9h3T1A==
X-CSE-MsgGUID: ELnkMq+zR5uESAMPV1BjTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54894547"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="54894547"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 03:55:26 -0700
X-CSE-ConnectionGUID: EF9Xn0rPQb2F5zS4BwWy3A==
X-CSE-MsgGUID: +2OVR0x4RcqQLdhlmIY+WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="158121913"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 03:55:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 03:55:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 03:55:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 03:55:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCdYNM/plYZXP4VN/zZKxth2oDKKinBvtw974pnX9uoCnKCsG4+8Ch8j307rj2ySGNYn2ar7VjA19jWPRouiTgGpjZB17dOWDxDf/VWtrSvjhG4ZXJZ/Nbo6MRQfDxCYFFnhvyt4zCRMMGsbiL0RdXuD71hxj5HbLFnMShP3jhCSz6tfsIJsW2y3XGaOzi7UXWO//Ws1uPqPSSceER/qZFxl2/Rov+MP7cU01FGCf8W0Qt7WPTsV7SELJE7LPseJEpzbWUTXnWq57/YgXhtv3Z+uoHxTB4wsSp34ONueEuzxwGbfNh5bqkZkda53wWgFA6s3/KJlM5iaMVE/6GMoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v/9K4URAKWAgEKWVrd/FP+yztSREbSy4Vqo/h2drkI=;
 b=e3vQsxUyVTaVkYXJf4z0dVRS1KUPdUHR3KUpY5LLFmWt/Ov1c+9htLoXJv56I390G35bARa8XtXdlniwhtyEtQni59LZ/qz7+92oWLG7R7roIfGX8gdH2uS4jtwMOefVVQL223vHVTpLgCisVXtE25bRbCA2pj0f2NpDPFQ0ASr5lcZ7C9Gx3KVxrrghZzN+guOmo+vXVoz4lyv/txmqJtOsAuTFw0bHcTERm0TmXILqNxwINc8EjOALamHK7tdcr9/Eiw9uwQ/7o6twEuAiekNKV+EkrDWVPWP0o6g659SKJIOSt/eCarM05PIjtAr9myb30R7pfpUnRJXM+S2PSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7602.namprd11.prod.outlook.com (2603:10b6:806:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 10:54:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 10:54:54 +0000
Date: Thu, 17 Jul 2025 11:54:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [RFC PATCH v2 0/5] rework EAL argument parsing in DPDK
Message-ID: <aHjWeVMUGCjTL9VM@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250708172039.183989-1-bruce.richardson@intel.com>
 <CAJFAV8yCJ85zN4cTtpnFngC96jzL49722mLawBh8ZjpUTWNsiw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8yCJ85zN4cTtpnFngC96jzL49722mLawBh8ZjpUTWNsiw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0092.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 867bd179-c82b-4d6c-745c-08ddc5205c8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akhWcVVmR0txekNrbExtT0Nyem9WenJITWlNSFRzUE50bUFTU3RUeVFkakJW?=
 =?utf-8?B?alJHaGxLcmJCcG1DQ2dGMjhCNjdLamZoczVaN3ZXVnFCajFpY2FYMFp4OURW?=
 =?utf-8?B?ajViVC91aGNqekR3U0pUcUtrc05nM0lNYUNMQ0d4b2NBWkhDcWRnMzBRdHUr?=
 =?utf-8?B?QVVpRXYzNzVETWRreEVwaDdzZml5UE9iRU9kakdKcHZiMHVrRXhsdVhMeWRm?=
 =?utf-8?B?Ulovam00TGlRYUFwYUh4S1VOR1E3UWoyZ3hGNk5hckpSdk43anoxbWE2RzN5?=
 =?utf-8?B?TlBzcy8rb3dxSkhvTnU5SFR0RklKN2Q3dk05ZUNVcGlUU3RSdDZUbDd6MjVu?=
 =?utf-8?B?Q0taRWYxQ3BhOGdCalFNcGtweGF4dEFyYTJjVVpzcXFKVVA2b0ZiSGJBY2NX?=
 =?utf-8?B?OU90U1orUjVLNXVVbU9iamYrdDhpelRLbEhoRGlTM2UyMDJLVkdIcUowNm9O?=
 =?utf-8?B?M3hHK1NyYks0Wm1NY3BjMWY0SkthYmlBRmJRY2krVmlKd2pqdkl1dG9MejlL?=
 =?utf-8?B?WHY2eVJlOGptRzB6OW1NNExxSUkrWDFaZWs1Rjk1RE1oVlFNOGc1NEhMd0hh?=
 =?utf-8?B?R0pUaFp6cE5sU3hmSUhrc2ZCcklHVWo5cTdZVmJ3Zll3ZXZxeXE4SElUc2tN?=
 =?utf-8?B?RndTSi9qbkpRTWc0cXAxZ0U1eXhpMFhwcHAvTnlGZEd4SU5zTFlQTlFMekty?=
 =?utf-8?B?RnR4cmV4SmhjczUxMnBhYnJkaGFZU1B6aFdkSWN1amcwaVBqcmh3Uk5FRmdk?=
 =?utf-8?B?ZllvL1JGbnJpejZTZmVzMDN0NklTNU9sR0Q1RWpXRmM0dDc4Ym0yanhueFh1?=
 =?utf-8?B?Yko5bDdPaTZCT1k0YnRDdzFOWUlvYXNEVGxhOTBrQ25ocEdSbm5hUmhEdjlo?=
 =?utf-8?B?b1V4Zm9hMDcvdmJmam9FTFdtZzQ4Q0t2OGVLMEE3NEdCbUJpdW93aDJhZFRq?=
 =?utf-8?B?aktXcUdjL0ZpanBNSi9sS3h3V3ZvNk5NVGJMVDNEMXBVZWlPNjB0SUhZT0F2?=
 =?utf-8?B?andKbTdFVEp0ZU95cmROQktEYUJJRklNVkEzWWpTeGV6dy8rdE5QYmFORURH?=
 =?utf-8?B?cHVkeXgwOVkrQkRKQkdpWHV4d3lyemVNbVNPSTc5TXdnVVA1OUZCYzVYSjJW?=
 =?utf-8?B?YWcxeS93WXdhNEJOOWF4QXVvWmFLbGFxR3BnNHNVd2pra2lIR3plaUxnR1Fq?=
 =?utf-8?B?SGpOVVkrZm9RM3MxekF3d2pHRjMxdndvOTlOcHlnV3VFSGtJcitJQ2xzS2pY?=
 =?utf-8?B?QllqYkErSEpuNHROb1dDVlpxSStjaUY2T3ZwYkZpK0w0L0p0TUw5bmVhUVhT?=
 =?utf-8?B?cFBOMlFQUzJiNjhXajJ3SXozUURET2lldUFkbVRPdEVxQXlPdUdaZmw4b3gw?=
 =?utf-8?B?QzdLKzN6V0ZUbkNCVkJwbFQ4UkhKcVpKc2NyK2pIdlFTbFAvRG1lUkVBUVdV?=
 =?utf-8?B?WStJREtzRlUrZU1ranEzb3pPMFRmNUtuUDlyeEF6NGhROUVhVFJQa2JMM0RL?=
 =?utf-8?B?Z1RsUGQ1RGwvamxmditDbWtGbjlUVitKREk4SFZhR0hvdXVFNXY2ZHRrQWVO?=
 =?utf-8?B?a2JiOGpsUXVybTJ5clZCNTFTR2trYjJNeXUxYmFySGUzWVRNaXpsbWJvZFNC?=
 =?utf-8?B?Q3liVWxUK0JoazFIK3ZUTkpVT3Y0S0hQdmNZVXRyblRTZlF2TitaR1JxblRO?=
 =?utf-8?B?YkcyTUNHdkNUNkhxWXk2NnoyRUpMQm94bCtKNUdqYm8rVkE4UFlBUFBZYVY4?=
 =?utf-8?B?ZVFjd29NdUQ0dmttdUlLL2JESGsxNTBUZFQ0UTkzaW5MTEZLR1pVV1drY0Fq?=
 =?utf-8?B?azZpQVFmMzcyZkZkU2tZYVRsS3NqUGZsUStqVitmbTBzVDJXWTZSRmo3a2FS?=
 =?utf-8?B?T2dtS3RnZHFFMGQwWXFnak1CZkJJU1I4U1cyanB3TnpWTFYxWHRWc1RYR3hR?=
 =?utf-8?Q?2VYwp+f3y0U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0FmbzVEQVUybitPZ2IzRjU5dVhMTkg1TFpjVllIUkpWM3V6VXloR2VhdjVY?=
 =?utf-8?B?MGdKVWZ6aDY3YURFcHloa3NNM0JLZTdYK1VvMUFSOVN3UUs1YWs4Tm9YNFRz?=
 =?utf-8?B?c2xBbnpPZkY1c2xpYS85MjZyTTZlMVJUblo4WFVmK1l6WDF4NmcwZlowY0dF?=
 =?utf-8?B?alpsR3FaSnQ4Y1NQMlBpbmRHWTEzZFBIbjUwQVBLMy9IbzJpa3hFMnF4NHE3?=
 =?utf-8?B?N3E0aVQ0SmtycGI3ZEpQck5tOGhHV3ZaMUFVODZZbXRubjlVMG5RdFpvYzNx?=
 =?utf-8?B?Y1VPWnlqR2NCd29EeFZSdjhKbEN3elZlSnl0VVlQbEJDTUV4Qy85VnBoSlk0?=
 =?utf-8?B?NEJKZU9FUjl1R2lxYitwYklLOUxiMWg4M2pESDFsL240YXJBTzIyZUkwa1JE?=
 =?utf-8?B?cFZOb2oyMFNHOWlqazdrSlhtOGIrR2ZxV1l5ZCtKMzZ3NGNwbm9SaEw5SXR2?=
 =?utf-8?B?MmpDanNyQU9kS1YwNUN2dXdmV1VzMVZjb3o5K0pERGFreEtUTlJ2VmtaUmxp?=
 =?utf-8?B?NXlTNE41eWpuSnk4Ry9DNlJMT29xdWZtZXhHQm1ndmF6Z3IvejdrOGdkSjlL?=
 =?utf-8?B?Y0J0ZkdjZGhzMXIwY0dSVXM1WVp4VkhOU29YUXRaREhMd1RrUUVvb2I0TVNR?=
 =?utf-8?B?emZLNVFxK3lRZGIraFMvOGJseHZmcnlWc3FXeVNYVzF2NDZlRzhMTTFQQm9s?=
 =?utf-8?B?aXZZQmRxakxrNXQ0TkNGVERYZDVoRml5RGFMRTJnREhvUW5jSDZ4bndrcGJ5?=
 =?utf-8?B?ak5TZnVFcndYRDcxYlB5V2RadlU5QnJCUlVuZjl2cmpIcnR1MVhKU1FrT3Ar?=
 =?utf-8?B?ZFhDZk9JUTc3MkVYMXA3eEY3OHhBNGhWcVk5OVNZRys3d3NwUkFzYkRHTmFI?=
 =?utf-8?B?VEJBamZncEVWaURpUHJPVWptQVIxc3ZLREIvUnVxTVJ4ZE9rV25UQVRCdW5N?=
 =?utf-8?B?Wm50b0l2UEc2cXk5cDRReEhNRTZlTWdhZCtPakJkcW9jOWtXZXdGZTZNU1BU?=
 =?utf-8?B?SjVjNUNxVkppQklVNEFiVkVaSzYvN1NSalU5cm0yQ3h4YTNJSjhUcTVJcTdi?=
 =?utf-8?B?dlUyMGx1ZUNBUmtucGV2dEM0bDhMZEhZMk1IQmhBLytkQkxobEFId09UeFEr?=
 =?utf-8?B?UXJZSzF5WkRuL2JMZlFFMkVVeElPbUE4Tk9maVlicm8vUlk2OGZvWGZOVzVB?=
 =?utf-8?B?UnNrUmd3Q3pMRDNIVU5td0Z2RW5QcEJUaFhINGJTQWRyUlY2OFBlL3VOUG54?=
 =?utf-8?B?RkNTRUxKTEE5YVFwaEYrOTAzT2N3c0JKRDltK2ZZVjc3eUVYQlNmdE9SbDhu?=
 =?utf-8?B?Y2xkTGNkSVE4NUQ4ZEdmSk5ZSkdTMVpBWUhEY2xwOVZ5N1ZGWHIxc2NzbmpV?=
 =?utf-8?B?OTBNZ1pJbzd0ZHlpUDJDVVlPdkNDMWw3R3A2cmdUdDVOMms0NE54d09hWGwy?=
 =?utf-8?B?ZWUzMGIvT1ZjYjR6RlZERXQ3OWwzMW0xVGJScjFiU21mL2w5UWJnZWFiVWF2?=
 =?utf-8?B?cE5MQUtFWk9PQ1NvUkdkS2ltSEcvOTRSK2JEUFBjRXU5RUpXM3MyUUVzek5a?=
 =?utf-8?B?c3c4VHlRMTZ3YTFqZlIvcHpPYzEzMFUyS1BpQ2JxWWwxWDlOeUFQb1NsYTRH?=
 =?utf-8?B?UDdTaUxxeEhDL3pmV2E1RFFDZjh0LytjRE5jbUgyODFnZjRYZjhyN2NyRlJK?=
 =?utf-8?B?eWtaSHkxNy9mSGp4bzJnc0tlNEhVUmRaQlFWdWo4eUpQNzFGUUdEVFcwZHlq?=
 =?utf-8?B?Z2hNYjFoSTdUYmtDa3ZaWkhjNU1Cb0xkV1o4bUU2eFdWS0tleTErNWJzZ0Y4?=
 =?utf-8?B?ZlB4SjVscU5hNldtbXV2SGFSb0ZETGxsK1kxMzFJN3M2MTNWaWN2ekNPMnZp?=
 =?utf-8?B?aXduUTFhV1dJOVN0Vm91NEJxNUtVOFY4YjM5bnliV3NVRWtMU3NjVGthYmVS?=
 =?utf-8?B?eUo2RGplSDk4T21NVVJkR1RMVldjVXk0RWd5VzI3bFhtZW0wb1NCT0JpZ09T?=
 =?utf-8?B?ZEtmbzV6MUdZdDBNeWg5aFRHZ1cyT2hDSkcvS0dGaVlDSEJaUFFCQmRRVDRZ?=
 =?utf-8?B?KzFLSi9ocFZRSmNiNzF5MXJ4KzlRQVI1YzM5emVTT0xGUHhpUEN2MXRPS3Nx?=
 =?utf-8?B?RERydkF0VTRGMUFuV01CNnJpU1E0d1NXdkwrZEZONXB0UC9hZk1LOUZ3UHJ0?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 867bd179-c82b-4d6c-745c-08ddc5205c8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 10:54:54.0833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw6LiMNgIqN1850dE2vdnNzzW0PHKYa18rfgw9EFFw+eEoK/DGr4ULSh8I5mA3oAI2qGkinMOocAJGGuXA+42EcnCtpruihaB0JcHpGKDpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7602
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

On Thu, Jul 17, 2025 at 12:41:46PM +0200, David Marchand wrote:
> On Tue, Jul 8, 2025 at 7:21 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > This RFC is a second, more complete, prototype of one approach we may
> > want to take to help improve management of EAL cmdline arguments.
> >
> > BACKGROUND:
> > - The first problem that led to this work was that of providing a
> >   way for users to easily provide a set of CPU cores to DPDK where the
> >   CPU ids are >= RTE_MAX_LCORE
> > - There are a number of solutions which were discussed for this, most
> >   of which involved automatically remapping CPU ids to lcore ids
> >   starting at zero.
> > - However, in discussion with David M. at the last DPDK Summit in
> >   Prague, he pointed out the main difficulty with all these approaches
> >   in that they don't work with multi-process, since we can't reuse lcore
> >   id numbers in secondary process.
> > - This in turn lead to a realisation that when processing cmdline
> >   arguments in DPDK, we always do so with very little context. So, for
> >   example, when processing the "-l" flag, we have no idea whether there
> >   will be later a --proc-type=secondary flag. We have all sorts of
> >   post-arg-processing checks in place to try and catch these scenarios.
> >
> > This patchset therefore tries to simplify the handling of argument
> > processing, by explicitly doing an initial pass to collate all arguments
> > into a structure. Thereafter, the actual arg parsing is done in a fixed
> > order, meaning that e.g. when processing the --main-lcore flag, we have
> > already processed the service core flags. We also can far quicker and
> > easier check for conflicting options, since they can all be checked for
> > NULL/non-NULL in the arg structure immediately after the struct has been
> > populated.
> >
> > To do the initial argument gathering, this RFC uses the existing argparse
> > library in DPDK. With recent changes, this now meets our needs for EAL
> > argument parsing and allows us to not need to do direct getopt argument
> > processing inside EAL at all.
> >
> > An additional benefit of this work, is that the argument parsing for EAL
> > is much more centralised into common options. This reduces code a bit.
> > However, what is missing here is proper handling for unsupported options
> > across BSD and Windows. We can either take two approaches:
> > 1. just ifdef them out so they don't appear in the argparse list on
> >    unsupported platforms, giving errors when used.
> > 2. keep them in the list of arguments, and ignore them (with warning) when
> >    used on unsupported platforms.
> > The advantage of #1 is that it is simple and correct, but the advantage
> > of #2 is that is makes it easier to move scripts and commandline args
> > between platforms - but at the cost of the arg list shown by help to be
> > less accurate.
> 
> #2 makes sense if we intend to implement those Linux options in other
> OS, but I don't see this coming (I would rather remove options in
> general).
> So I prefer something like #1.
> 
Agreed.

> 
> About patch 1, please update doc/guides/linux_gsg/eal_args.include.rst
> (this file needs some fixes as well, like the --log* options are not
> documented, this is a separate topic).
> 
Will take a look

> About patch 2 where the options are declared, --socket-* options got
> renamed as --numa-* recently.
> 
Missed that. Hazard of just constantly rebasing an old series. Will add new
flags.

> In this same patch, I see little differences in option descriptions.
> Those tweaks are easier to read, but some details are lost and not
> covered in doc/guides/linux_gsg/eal_args.include.rst (resp.
> linux_eal_parameters.rst for Linux only options).
> For example, our doc does not describe --log-level=help.
> 
I'll take a look.

> Patch 3 removed the rte_usage_hook_t stuff, this must be restored for
> applications that rely on this.
> 
Yes, I was aware of this, but forgot to note it down. Sadly, I think it
will require changes to the argparse library itself, not just EAL work. The
"obvious" solution is to add user-callback support to argparse, but right
now I'm thinking a better solution is to have a flag to argparse which
makes argparse pass the "-h" option back to the user. We then can add a new
argparse function which returns the help string to the caller. That gives
flexibility to apps to create their own help functions with their own
behaviour, if that is what they want.

> I also see a difference in the cpu discovery logs that disappeared
> after the series, I did not investigate why.
> EAL: Detected CPU lcores: 16
> EAL: Detected NUMA nodes: 1
> 
I probably used to know why - I just forget now :-)
I'll check this out, and make it compatible if possible.

> 
> The rest of the series looks like a good refactoring.
> Thanks for the cleanup.
> 
Thanks for the feedback. 

Once this series is done, I hope it will make it easier to add in some EAL
arg capability to make it simple to run apps on cores > RTE_MAX_LCORE. I
sometimes run tests on a machine with 144 cores per numa node, and with the
NICs connected to node 1. Specifying the core list there is annoying...

/Bruce
