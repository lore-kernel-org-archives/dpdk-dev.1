Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63DCC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 13:03:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 798804025D;
	Fri,  9 May 2025 15:03:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id C8C8C4025A
 for <dev@dpdk.org>; Fri,  9 May 2025 15:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746795807; x=1778331807;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=0OGs8iDCbVnIpc+Lx7gOYxQZW0fwkgIc2t9k+VrKq+k=;
 b=T3Grxzcp+OKlu9MBcrG7/+3ThpWGpXMhsZRykxvswE1+xBW8Q4l3Vsj4
 v8V8bBiL0+pR9vrAyFUWs0i7dlo6O+dTHMlJhY+jzVPcsxQcBZw8V4SyQ
 2UC5aoungm++qZTnbBgNnpggCos+Q4Wz4xvfdZWp+4DbNAKlyjb2aenOF
 wKx1haewRm8DLTviKibfm2006nij5WL8xRL9rQxl8FhuY5n9ZnsnFAgwq
 6GHLSGKSiGNN5vVhnyF+ySb8EDNI3z3aA9yflZJXyRDt/TxVNmtDf0zz6
 pisbVpTyQ4gT66NcXyRQt9j06QHiIzS9Womt54v6ImVg8PClv/2vw+nGi w==;
X-CSE-ConnectionGUID: TGWrSDg5SQCBVZchlrvQcQ==
X-CSE-MsgGUID: 205uEtCkQvifMmX+7/u8Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48781528"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="48781528"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 06:03:25 -0700
X-CSE-ConnectionGUID: RuJMxaklRWqpJImpxUfG8A==
X-CSE-MsgGUID: j8m1GACUTIifRjWwKPkjXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="141832401"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 06:03:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 06:03:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 06:03:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 06:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb5MZ7HWSIUDouQnpwNpF2UtqnODU61zko9Dy7hYi1VdqXBIRrO5WE9vqIy5dzPumIvSaclEr8bc53c559FkMSXKvJLMX09BDaml3KN2PPUIbY4f1vYdJSQIJj6MOLpwMWnJ+CeS6UNfWQOlMzP6iqZmwNFQSerY3bZXiFBwr7cIL62Sq31/VBofFlutPAbTzJcoixZDMxlByRlXEWXyp21vNlBvzOcSAFYAUnGW/i2zoZJrGI+p5nQpl3Qu1ZXWHYiYWLZ0x85stE6YWnzkkvsWaBBi+AU6hG+SkbP1E5sdcoR/fTlLkNkOds3SU/tO7NjTDZhDGU9qiE3kKTgIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9gFYUi/b/BcUjSGngRxqzDcdsOo4FnTNsLXc9Cv3Qw=;
 b=ZdB7yBt3/+DehLesL3cxmaYxrstoOurnC1q+7bVWsWSqseTzM+WDJZsCXErtZAccnSv2WpPpVCcyP5HCEdS1NmgAVfBuWzTIpPcxmGUJocTnabZixOjq/l1Az7Yau8RE8ObnhSyrAHx/t9bRTLFcFvoHspXomkUfQJ3qDIXvJ+IanpUHNGk+s3mE6ddCZhA2YPoCFXrJjTZTwezYRYZ/q8LLfjG6SZjAclk58ZdzKnUnp760JNWOaoSPfUogePtJEMd9ck5VCUTZ0wQDOtaC1led/tGipKft+w+WE0gtuhoRO5S+17RITmMazRKWWqN7r4muxcLFZ13DycsEfBG7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 13:03:02 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Fri, 9 May 2025
 13:03:01 +0000
Message-ID: <ebb1b821-0138-4f64-bdb0-d86b7eab48a8@intel.com>
Date: Fri, 9 May 2025 15:02:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] cmdline: use C standard library as number parser
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <7bebd92be36f945c175382bb1e0482e55844c1d2.1746710154.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <7bebd92be36f945c175382bb1e0482e55844c1d2.1746710154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LV8PR11MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a37f54e-6c1c-43a2-bb8d-08dd8ef9d43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2VWditVOFJPQVV2K2RBS3hNV0hQKzYycmdIM0VJbkx3UXVRa3dVNXFISVdL?=
 =?utf-8?B?S01hYmVKT3BzaUhVV0l4TURmcEJyZjVPaDhIV0Y0Z2FFeFo2TDNWTEpYdHF2?=
 =?utf-8?B?WEtVcTV5MkxpOTBsdnNqOW1OTFNUZmt3S0RZRm1LMHdBL2YrbzQxSHg3VjJO?=
 =?utf-8?B?UVBweE5xWlFQa3NzUWg5R3lwNG51T29kOWZiOFE1cGRYSEFIbmdocXlUdnNP?=
 =?utf-8?B?N2hDN1Zob2c2c2xSRHZvaDYybE5PRjR1clBoeDF1ZUdjTXZ1dFBkU1Q0UU9M?=
 =?utf-8?B?ZGRxa3orVzJxVHVKZTRKbXNJY1NCcitaU2FTS0dyQnduR1lXcGpPdnRnb0xI?=
 =?utf-8?B?cXl2b1lkeG9ZenBMa3dpcm0yUTdMWmZYZDIveUFGdkhzZk5wNmtVMHVkTDVt?=
 =?utf-8?B?WksvVlVvc2daMFBTUkVXUmZ3VjR4aXUzSVhzSnBOQlJrWklvWS9TMm9mR3Ex?=
 =?utf-8?B?NDZmL0Y4eVc1SEw2elFuSHJlVng2S3dPeDFYOU9jVlZoYnZ6eVh5c2FFRWZk?=
 =?utf-8?B?Qk4waWFxNUh5WExERVlkM2tlV0NORXVrL1dielVOSWNTMWtlQitYaWU1UEhU?=
 =?utf-8?B?MHpmdXNoamYwVi82RStPdmx1QmlhdDh5YVUwQnhCakpQc3RUT2x6S3lOZzlv?=
 =?utf-8?B?K0pVb0s2ZjJPM1FQdkN6REozTGF2dkdzeXRIeXFjUFN4SXA3MEhINXlqTjZO?=
 =?utf-8?B?MDc4TDh2cHhnenBMZlpWaDdVMGNXRlN6MGlSQ0p0bXRMVFA0T2lCaWNId1dq?=
 =?utf-8?B?WGhuTE14ODJBcVJmQWw1SURYVmJ1OHcrMFgrVnhpVzA2TjJtcW1UdmpHbGpa?=
 =?utf-8?B?OWU3dXRTbm5VTC9RYlNwT1VHUlZLTDQ5YUE0NFNIL05oeUlwdGJTWVFpRENh?=
 =?utf-8?B?cTFMOXFtdmU1dDFHQ3c4QkNZUkNLbkdwSklwSSs0Vk5rd2VHV2M5dklaYVp6?=
 =?utf-8?B?VGhjZDBkT0VwcHdRWXJDOVdYRVRRcTVZa2loYnhyYSsrM2VEb1pGRlQvNWRW?=
 =?utf-8?B?OCtVWEhVT1VBSjlrS21tQXljOFJ1bjQyYitnbmREQno5M0p2WEphUEZYa05h?=
 =?utf-8?B?bVdEWkdCNHdLaGxodHJnK1dkM0tjSHR3Tkk3T3FxZFJMT2VVZUo0bHlyTEVW?=
 =?utf-8?B?dEN0MUEybXNPVmZ5MnduUndiMDNIVUpvdFRScndTY1U0ZXJqOWVlYjU2U2lN?=
 =?utf-8?B?Q0dTNmhIbjc1UFUzTVdkZ1RMTERRVzN4UFBSbHdRK0IrUnBhWTJBUVVoM1JK?=
 =?utf-8?B?NWNYK2xydno2NUJNRzRULzY4S2pHblBFazlENUxZakRwaUVIUlBBQ2E0NVBD?=
 =?utf-8?B?aFZIODZOeTFSNFZEdTM1aFRXa3BHUVhkb3dCZDF1VTd6T0paQTRXZUdXQlJK?=
 =?utf-8?B?cVBPM1h4bDZkNDRSZ25GanBPdFZ0Vy84R2R6T1VENzFYZ3VmR0RNT1J6N1FN?=
 =?utf-8?B?Y1p1RVVQcHhuZjl4UnFmeFowSFZmNGxrNDllcGRvV0o4NTA2NWRYREF6R2px?=
 =?utf-8?B?SFRjODFvdUliY3dmd3B2NjBPbkc3UWZmVnE1eWVKeUxKcHhtTUEzU0tRTFVP?=
 =?utf-8?B?OVR3U25pNzFVTFpEdTkyejFRSFZQR1JKZkg3N1VXSnRlZlZ3Rm5KdDdaN1Rv?=
 =?utf-8?B?TnBqOFJBNjR3bHpLU2lkUnArZzdaNDYxVXlyY1ZNUjZCRFZ4YU1FN1ZGTXlS?=
 =?utf-8?B?b1VYN1pNQkdkdlV6Z0JzcjhLUzI3c1BDcUkyS05mYWJOdzlrc00xVDdCZDZh?=
 =?utf-8?B?d3luazFkTHNoMTBYUjBQUHZkbmJkYnBkRUFXV1JobzJKSjlucE1FYSs0ejl5?=
 =?utf-8?B?RExBbjVVVmxVR2xBZEdRL2EwdmNFVS9LdGJWSkNLUS9aZEo5RDVsVkpYYXVF?=
 =?utf-8?B?azk2L3RkTnB2UDMyM2ZvSVV1SVN1bWhaSVU5Y0lBUG9iQ1A5dGFWbkRrMmdm?=
 =?utf-8?Q?YbFrU4Rm+S8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VktJbnVJMWxFaFRCRkZYWU90NHJsbUp3d0psbVRaTGgyY2RiNm1mTmExODh4?=
 =?utf-8?B?R3E5aUJPWExBSlp4cDlLRTJOejlNOUxJa1RLdEVpblNRWFZKZVNLRVNJSTdx?=
 =?utf-8?B?ZWQ1QUZQbXgrQlF0RUNGMTdaM1Q3WURmSmF3ZG1mTGRkN3V0ckF5K0YyTnUw?=
 =?utf-8?B?TklBYzB5MHROcWNpYTdzQ3p6Nm9jY0x0aElKT3lPTjU5SmpmWnJNbXRQOHlm?=
 =?utf-8?B?SkRkbkgwNGsvYkx6RU1wMytlZW1hTER3NlhKTVdQMkw1akc3QmNvOUN4czRG?=
 =?utf-8?B?bHBkNGpJOWsyaGhNajdrQzZ1WlZuL0g5cnU5T2lscXMxb2NUcXQ0L0ZzSjZi?=
 =?utf-8?B?dHpPN0gvU3Vadzh4TDM2T1lkWjZudUdxZjBQSE9nWHlYeTlzbDhnWFNLS3ZB?=
 =?utf-8?B?NWlFRE5nOXJiZk0zUUJmUHErUDM1ODNWVVRURFJzNTJTZEtZUTQ1c2ZGUUx2?=
 =?utf-8?B?eW95ZGN0dVhDYjNrR1VvZzBpbEZXcDhqY1gzNm4rYlllOVA3ZU5CSzZyN1lr?=
 =?utf-8?B?eWlKR091NWVQcFFBdlRGM3BRK1VSa0laN3RDS0tLTmJRbGFwdDBWaG9iU1VS?=
 =?utf-8?B?UlIwSkdLQkZ1OERXck0rRlFjKy9ucGJsa2VFNkd4WVg0b2dybU9IZHZmcGM3?=
 =?utf-8?B?RUpSTzVFa1JrTVFJNE9haEFYNDlPN2R2M25sT2FueVJaeEYxNFlnK1VrSlZp?=
 =?utf-8?B?YlY4WEc3bGswaVo2UFNra1hHYkhyWnhZNGRCMU9YeWxWVXpYeGxJcjhJZmJ1?=
 =?utf-8?B?TDNpRDNjQXRyNDVJLzJzY1dMRGw1N1h0TFA5K25KVXc3alROVkhxd0UyZUQ3?=
 =?utf-8?B?dE81dk93SlMwVlFxWXpFK3NDN0FlYnp2aXp0Um9xRGNsUUxxSGxOZnduK0Yr?=
 =?utf-8?B?NDR4YnBtdmVJM3FrSHBWUXFTRCtZQTdwZXE3UDYxV2dvTzFpeEhLUGV2NEg5?=
 =?utf-8?B?K3FjWTdwbENtN0orYnBTQm80Z2duOE9VRDhRSGVXb3dUQmNRTzY5R0U3ZzlW?=
 =?utf-8?B?T3JvYStmRlNDakhPRS9MNG5sa1pYa1hqT05KdzUvVTUrQk5HOUZkbU5iOU9C?=
 =?utf-8?B?NVZiZkJjanMwTmJwZVdja3dRRW5qWlVOTnR1U0w3amFLQTh0d3ZXOW1TZEgx?=
 =?utf-8?B?Q29GRjcwU3l1RGFnZW01YnE2eE5SK3ZiM0xWVXZma3FmS2owanRFQWpwN0I4?=
 =?utf-8?B?ek9xN0Q0aG9lelhXQmlPQk1POVZJUFg0dDJuQlphNGRtTjM2WVcvZ1YzQlBa?=
 =?utf-8?B?YjArNFBYRTJNRlZCOXg1MFNqRUdXdXJlNWg5ejVEaUQ3Y0RYVGFsRjZDdzlp?=
 =?utf-8?B?dFB5aXIwZzNFOHU4aU1YcXhkSW8zWnc0U3BkQ3FEWDVyQjhzeWJoZmVJMExO?=
 =?utf-8?B?a2pWWkxYZTZ5RGxxNHd4WmNtWWtYWmFpeS9NdzJmRCs1QUdYRnJIVXQ3U1c2?=
 =?utf-8?B?ZG15dXhCRjFtVHN1QVRSYnBHemZJakhaS01ucUZUWnM3ZFJCdVg3K2RqSWR4?=
 =?utf-8?B?SldpT090c2ttUC8zbmF1T3QxeXhrWW1NdnIrZlhpaU1zY1E2dUpxMVBPV3Rs?=
 =?utf-8?B?YnpKYzRVeW1OdlVNdmNvUFErb2xYZTVIVXNFb1VMN2xNS09VMDBjNFNzOHU2?=
 =?utf-8?B?RlJMZmdoWmxYcXk0bXBXOGhFbnJhbzFyd21DcEpXaGpBOTRHd29waHUzVjd1?=
 =?utf-8?B?ZkZwZWlsZWplWHZ3TVRaR2ZSRHo0WmRNTmtZVHdMQ2QveEJkV0hmSWw5SVFt?=
 =?utf-8?B?bVE1MDFXTjd2RjBlaENnZVR0NmN2aSthUUJBaUhhSmNDdUhucjJ6RU45bm9Q?=
 =?utf-8?B?cG8raTNEQU1vNExSQjJOOXE5TVhqTUlZNDNwQmJhWHhxRms3L2VjaCtybFU0?=
 =?utf-8?B?MnkrNVJ0NmZGbWE4V091SWJPS0R5cUUrb2RmZlBYYTZ0dkZSUkxhbGpCYjZq?=
 =?utf-8?B?RldIZisxQnNzMklQMnJpc1YwcllUSXhVSk85Q3I0Y0pObGFwaGsxVUs2MmhS?=
 =?utf-8?B?MTlEanFldUt2ZTYyN1ZYTUxER1gxMDJJZVdUc09mOGhYckJRQkNKWWw0RnRS?=
 =?utf-8?B?dG44d2ZzbmZCSE9kWlV0YjF3SmRFNFpEVkFzeDRhcG16Ukt5QXBuSDY2ZDMv?=
 =?utf-8?B?YXVsMnR4aFNjQ3QwRFpYQ1Q1WDVBc00wcHFTSEFBWXVNY1Z2MTZGcExGVWI1?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a37f54e-6c1c-43a2-bb8d-08dd8ef9d43b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 13:03:01.7754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kO33l8G+0mddY0lU1Ghz0m8ndo/kHLdFztt6dEBI0jUOEO7R3CmSct+geaKwTxIi92nM4aQevMEVKBxINlExaggUBDiqO5C6XPSNe2ZfCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
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

On 5/8/2025 3:16 PM, Anatoly Burakov wrote:
> Remove custom number parser and use C standard library instead. In order to
> keep compatibility with earlier versions of the parser, we have to take
> into account a couple of quirks:
> 
> - We did not consider "negative" numbers to be valid for anything other
>    than base-10 numbers, whereas C standard library does. Adjust the tests
>    to match the new behavior.
> - We did not consider numbers such as "+4" to be valid, whereas C
>    standard library does. Adjust the tests to match the new behavior.
> - C standard library's strtoull does not do range checks on negative
>    numbers, so we have to parse knowingly-negative numbers as signed.
> - C standard library does not support binary numbers, so we keep around the
>    relevant parts of the custom parser in place to support binary numbers.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:
>      v7 -> v8:
>      - Added the commented-out out-of-bounds check back
>      - Replaced debug print messages to ensure they don't attempt to
>        index the num_help[] array (should fix compile errors)
>      
>      v5 -> v6:
>      - Allowed more negative numbers (such as negative octals or hex)
>      - Updated unit tests to check new cases
>      - Small refactoring of code to reduce amount of noise
>      - More verbose debug output
>      
>      v4 -> v5:
>      - Added this commit

There is a unit test failure coming specifically from this commit, that 
only happens on ARM. Log:

Error: parsing -0b0111010101 as INT16 succeeded!

That is, when confronted with a negative binary string, it seems that 
strtoll will report success, whereas other platforms report failure. I'm 
confused, is libc strtoll different on ARM? I don't have an ARM platform 
available to test this so I don't know why this is happening.

-- 
Thanks,
Anatoly
