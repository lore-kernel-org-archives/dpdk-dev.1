Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88197C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 10:10:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6287402E7;
	Thu,  8 May 2025 12:09:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 746E34026B
 for <dev@dpdk.org>; Thu,  8 May 2025 12:09:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746698999; x=1778234999;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=BivnFdJfqU+bkG0FiY1y+WAc+aW/TQVEd3UpPxpaebQ=;
 b=nIbRfv2pXCedZY0eYMOBJQVH/Zs1vJIEcBTujOjJ213M7VtMrDovqInq
 SBmWpXjtKR5O9bEMYPWYMnZlHuOV1U3yw7/OfOYJOHdZMsgGGD7MEVtiO
 FZpKBjdiSISTu+obOa4ejvz25LHFL8VL6GS3h8KobvJXbj4h9NbhT7uoQ
 QX4KSlUfMntCqnR4kCTrw+nRY0b2Q8uTp/mYgD6ULxsh8jkKLtddxU08C
 TMvk8fwwMQuNpBascVNh5ciO+81fpovaoy2hgNgC0zUAmCc2L57Bqux8s
 Nz4bREMnE3mu3XP8KZSknBgF5fqXUKaka9IYwbKfMLIS5vkVMpsdx3vbE Q==;
X-CSE-ConnectionGUID: IdMiemWaRrmuaQ7mi4PGdg==
X-CSE-MsgGUID: I3TfTSLZTpSexzI0bdUjgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48621177"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="48621177"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 03:09:57 -0700
X-CSE-ConnectionGUID: eV8dmeaMS5ipaVFSSk4Q5g==
X-CSE-MsgGUID: FnYo9SfhQtml+GObpxYPtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="141204968"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 03:09:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 03:09:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 03:09:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 03:09:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OALRC+G04OQMdZ3WzlB2uFZ7biKLlA6jJxLj6aFdfcnt4wCoNq5anvEivaGfbs+4WKlF4EtVDtifDI/AuQPfu2mP/0/DKwEOCxQ+y4HrQwSqLEo34GXf568HTMzLfoWnunD4PKcpoOAEw7v/oWflhlXnTXyQteELecrSgJLa5r11RT3CwatPCpcTNPfTPa+Vz9Wcc9E9WSEc5oGKheKwRKM097BR2ZugIlT3aUOuTdo6um5jySoPRZD2Odp7JN/HE8515dsJsFBAkTqmWTXncmq5hUXcKlwZqu0vbfltvtQbg+bkvb0/jnPq8nHfi7QvHBfztt4pTIa3leBOIJwhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2XG3i+wHnqMGEFSfQGwwiVXwBn1JfoVcDVcvtN+C2U=;
 b=SauBZC0c24z7fESj2gxxlo3pMcBq5h7TDc8ahclBF+SYLVvKxubby5EsZcuoWD42n0OZPF+Skg9PJKtSvDHsToh9YfiH5Ihqvs7/+64Wo3Ijj/C05MecSg9KoF1jPPK6ED2RdrEgnj49Nm5bBQuF/pjJ8mU3bRZY3oX24IJfBgSk91PwbAtEN4J/nuHACqBNjH6cBE4YwSZrCle1q3xGTOAuRlP+g9t9nSyAtTjlNf/LOprPyhGdwHuiQlvUdyYZyUAuJOnEJu4si48DFQjIBv+u2ii+a887GdmxnHff/q5Z83y5e1XcgL7Ei+yDllEXbxA2e3+aRrpRF8GdCPb5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Thu, 8 May 2025 10:09:09 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 10:09:09 +0000
Message-ID: <dbdebfcc-0ba5-4ca2-8040-0ee347de175c@intel.com>
Date: Thu, 8 May 2025 12:09:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] cmdline: add floating point support
To: <dev@dpdk.org>
References: <e80092cfd3ce9f28a3c720a0f0ffca0c511ec0e2.1746698489.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <e80092cfd3ce9f28a3c720a0f0ffca0c511ec0e2.1746698489.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:10:234::22) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM6PR11MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c22fe2d-2614-4d27-3f68-08dd8e185f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjJlM2ZhWGtwSUFCVzJZU2xkTFNOQWVLSTA4TXBPV1FUM1N6NTg0dXl2Rng4?=
 =?utf-8?B?T3Fpb0wzdXdmN2czNnV1dkh6ZWpVNlJDSHE5SGhzeUxHZlFzTlRzdEprVndw?=
 =?utf-8?B?N1RoRmRMRzNsdnNpUTE0TkdCTVBGMU02UC9oa1lDNU9uMlBNRWFOYThNeTR3?=
 =?utf-8?B?RFA2ZmsrSko1ZjlIRVlydmZFWXZ2U05WamJIMDlrY3VLcjFPWXY4VGVyZzZS?=
 =?utf-8?B?RXg1c1FwUTNCNG5vUms4bUR3Q1NSWmZpTkRQUVRERVB6K3ZZZU9kbHI2TGQz?=
 =?utf-8?B?T2hJQjY0OUQvMDJVaU4vZ1cyTmhaVkJRdEwyVWtjUlpydEFyWlFyZklwYlVk?=
 =?utf-8?B?L01oWDRBVW1qMGpqRUtMdjYrVnllWlhPMXRtYVR4QnB2ZHc4WnA5UVo0QjRv?=
 =?utf-8?B?V3lwdEE0K0NSNGQvUzJKY2Jzb2t1cWF5ZkQyb1FNS0F2aFZZRHBpMndwaFo5?=
 =?utf-8?B?bjVrQUJDenI3ZmZucnZwOUZ1aXBUdXUwdExtYXNPRDBmVTUrN0kySUVaZEtN?=
 =?utf-8?B?Q0R5bExEWStBUThhSjN5aTIzQ0hlL2lIanJRTFFmUjdTVUZpSFFwQmNXY3Rw?=
 =?utf-8?B?OEd5ZU5QUEpSYmhJVm9KQlQ4OXRlc01WMzdPdmpGejV0S1ZJZjMwa2sxVzVl?=
 =?utf-8?B?MldGNHY3UnFkR3Nmd1ZnUVRRTFNXWEdmMFRmaURDKzh5T1J3ZERjWVNTa3lx?=
 =?utf-8?B?ZkxwS1dSRWdPNE9jS1JFWlUxTHJWWTNrNWRkVUJpd3c4aWlqZmRCRWpjNGFW?=
 =?utf-8?B?c3FSTi9lVlNwaFAxd0VuWWZETU9LeEMyOXdOMnRhOFdPM2l5Z3JoYlYzck1C?=
 =?utf-8?B?VzlsNDhYWHZmR2lrSjVObFowT0xUdUd5MEdSb2w2YnUvdEZUaTlIOTdKZHYw?=
 =?utf-8?B?eGlmSkcrNUF2enJ3eDdnOXZmTGF5emszcDlLMDRSLzhadTZWUEIrSlR4VnJo?=
 =?utf-8?B?UzhtRzVqSllRNDZBWkE4MU9kTTFISUgzUU9XdWV3dVNHaGNhMVZBY2VSY29v?=
 =?utf-8?B?MnNyc1Z4cm11VldBbGV1V0k1dXlRZTVveGhWbGJQVmFLeFVhWlN3dGhhckZQ?=
 =?utf-8?B?VW45OVExMVFGYkY4d0twb2hKZmx1cng5RHJZQkp0a3g4aWdUNTN1bHJCZ3ZL?=
 =?utf-8?B?RWdTL0RSblVpMkxsVmtOcCszaFdoT1JqYjZRdGgvYXBYbGpVMzg3STE1K3k4?=
 =?utf-8?B?QlpZU0I0YXdTdEgxOGJvZkM0U29HWVNESkFjenBMU2xrYnc0aGt0WnNyNGdj?=
 =?utf-8?B?cWdBRnFNVTZvaDFnbGFRblYrMER0bVd3emRjR0s5SUUxNkVaUG8vNFp5azM2?=
 =?utf-8?B?aHFsd3htRlRKRmVFam13RTFZY0tQcnJvL0ZxUWsxNWVkdmNBbE5jRFR2bmF4?=
 =?utf-8?B?NUphVk1NaTNHNC91aWRMemVjQWpNT0NMeXo0eXY2a0U3eWlRcTRwbG9ZbmNM?=
 =?utf-8?B?ZjI0cEFpYmRPNVF6VHVzWGZZMWhFL0JlQkVBb3haaXdYOWRMdDQycVJWSjJZ?=
 =?utf-8?B?Q1AzL2p0MXVrZ044dTVUWUtFZXJ1NmhnekhOT3B0M00wMERUVzF1TVBTSjRJ?=
 =?utf-8?B?aDRWdFprdjVqS2w3SkFMUVViZXNoSDV4STVKL1BCcEp4Sk5lYUlVS3ZTQXI2?=
 =?utf-8?B?OVFRRWQvRG9PT2hRWC9LRnMrMU1WOFdhdVlxZjJxL0JJUlRUeTZ1bE0za29W?=
 =?utf-8?B?WTEyaGNBR0dxamtlNzJkcjN0UDFzaElDMDZKK2k5WjN6enJoQ0p6WXFpYWRk?=
 =?utf-8?B?aGJsZnlZdUx0b21JYlBpR21FYkVIcHo5SFQzaElVTkdnaDV1bmdoVDkrMkd1?=
 =?utf-8?B?cjZqN3NUdWxVTlplNjlKcGloeHZJTUcxRytRdGE1UFlLVVZqUmt5T1ZOVXAy?=
 =?utf-8?B?RHhJMWwyS1hkcHpJSGF6M3hjS1pZOFgyQi9OK3g4NU16aUlvdmVBMTdiblpN?=
 =?utf-8?Q?zdNWPYnWZoM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNpbUpUZVFXR0UwS21Db1ZBaGNBRUdaNXpwSUJWdDVJWHJHZmhROVlJdUpa?=
 =?utf-8?B?TjhKTWdoN3FYa2liMCtKWS9KdDRzODhNeXZUcGtXTTJlMFBCaXNaNXhtUlhB?=
 =?utf-8?B?ZHlkOFFnenM0UzYwRWkrYm5STTlKeER3U3IyV3YvTDVUb1kwZlk3dU13eFJ2?=
 =?utf-8?B?MHN5R1Q0S1VKS1lEanhidGV2andNcHRQa0lqSk5ycStBMmV3QS9nMmp0WkR3?=
 =?utf-8?B?UmM0RisyMnZaRWcyVnJXSDNjL0w5WUJKSHloTnpRV3FLcnRXcnhib0IyQ05J?=
 =?utf-8?B?SktXa1JmLzFISXg3WlVIMngvRmlFRWZMVW1ZeFVsemhCcjhLZzZoa1IzRXBi?=
 =?utf-8?B?K05pdXRhbmNnYy96bUZLRVFIdW1yZ0t5MlI4QTBLT1pIU1hCVlRvSDZ3NTdO?=
 =?utf-8?B?dG1pMGx4UzBWV0ZzUWk0MWZYNE0zZkZ2UE5Dang0SG5tUFpMbWhrNGpxamJD?=
 =?utf-8?B?dElxM3pyRlNXek96RmV2UjlsUTFWOXRWQjNVR1JiSXhMTHdOVjRlOHRFbXdJ?=
 =?utf-8?B?SW14RFVGNFVsdi9lbnJjUU1mUWpaQ0pCNXo0a3A5YWI2c0ZYTEZiaytldTVT?=
 =?utf-8?B?MDBIR2xTNVVFNjdRamhkSm9sMXBZcFdSOWxCTGFzTVdqYWJ6MmZsZmxIMitk?=
 =?utf-8?B?TXl3cTF2azZhVktMbzhEYVBMbVJQZTRhVG9PR3FvWG5RdkFqZzljU1ZZVHNU?=
 =?utf-8?B?WGRFSC83K3BGUGJZWHVXbGRtT2ROYTVLZFk5Ty9GbEw3VFYvd0ljUUVpelZ4?=
 =?utf-8?B?QVVCN0VKMFlicWpZK3lia3BrYmxzUlFXb1VmU3hXRGVSVXRkbGdMNzRReWpl?=
 =?utf-8?B?V1BzU2JSMnpxUFJYbkJZR0FLcEx4WVZhTFVNREhaVzhMUVpOT2luRFNqYTd3?=
 =?utf-8?B?NU5zWEdmcDU4YVFIQVJSanpBYW5HNytoRXRnTDRjK2tmRDhHRVdwdUNXSG9U?=
 =?utf-8?B?bWxDWDJ5TTRSb3lndU1td1FLT0JzVnlhUmczaE9TczNjR3E4c05xL01ZVEVZ?=
 =?utf-8?B?M1dUbC9RYVlFUkMyaWZZK0tRUmpYdVAxdnlka25jWjNsYmFpNlUxK1pIaWh2?=
 =?utf-8?B?UG9vTW4xTVI1SUZZR0NQOFZqNEVqdUIxZzhSYTFjWmc2WkFhQjBKMFRPTFN3?=
 =?utf-8?B?QkdLdVVKellveVMwcEpPWDFyY2wwbURvaG5aamhoTEwvOS9LL293N0RpSjZ5?=
 =?utf-8?B?QmZBSEJYTzdlWURJWTBmRXlqM2pqR3pPMEZISjVBVmlJSGJtcDZXOHNERnhI?=
 =?utf-8?B?eXZQSWE1UU0yRC9icUYrcGx2VzBCUGpHalRJVW81R0s3aDU1NEpOczdWR0hF?=
 =?utf-8?B?YVBLM210Sy9vUEhkRnVzazVPQmVnRnJKaTZVcEgxWVRCUFVmZi85ejZKV3Vp?=
 =?utf-8?B?K3M3RW15VGZGUXBpNGFCMDZldE1iY0UzV3RvRUF1N2ZsMHd0aysxTmVJQkEx?=
 =?utf-8?B?ZTVTanN5VHh1WUkxZDhkVCtESWRkU2FkamVlemF5NW8weGFHQlgyWFRtOW1r?=
 =?utf-8?B?dDRGa1owVUhUa2toTnZ3a3llblJJdnhnUFhaMTlZSVZObFVzOExhMmlhZ2RO?=
 =?utf-8?B?bkNEWjRielpLNG5BcWliOGlFcVZXQTNHRzVrdFZmUEVjdVFzT09lajZtUlFI?=
 =?utf-8?B?c3lEWkcva2k4OWtvQ29IYVYxcmhVUGZHTk5menlLdVJ5QWZzUktnMzJreDg3?=
 =?utf-8?B?WHVEUm9JVG9jbTlaQUNqWHhkRmdHS0Q3NjlJV2xIRWhBcWRzOU5DQllxOExk?=
 =?utf-8?B?YWV0bEJBdzY1dElKOHlabjJ6OHptWCtpcFhoRzFxck9JTlQ3cXBIemxSbEwy?=
 =?utf-8?B?cm50ZUNPbVgwSVpra3RWSGY2aVhOR2dFd1IzQkJpeDAybWtHSjUzUnVxWTBr?=
 =?utf-8?B?R3E5eDdOQTVpb3hyYzRMdW9KNzRvdEdNMWtmN0tFY1FHTkZ3WjFzTGhCVi95?=
 =?utf-8?B?V0dhak1UbkwyakRVMm0xeVJiTjRMKzN0eWZ3VUVjdXFvT1ErR2IxeDFaRG84?=
 =?utf-8?B?dUxaN21zaTZ2NW5YQ0ZDSFM0dFppZk9CUktXcXpWeTRiV3oreWRLcjl0Ti9h?=
 =?utf-8?B?YXNOVk9XTnFOb2pvRVhuTzhhdm1WcjBPUnNDR0xUQSt1SHQ4MmpQOS95eFNt?=
 =?utf-8?B?dWVwL1ZneGowRXZwMXZRdWU1Vy9FVDZhLzVwdWlROU81YXN0QXFZU0YzdXk2?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c22fe2d-2614-4d27-3f68-08dd8e185f7f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:09:09.1139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZiP2A7zNQToolqNgpIThDGVEOb8mRMPm7CvHwmdxAO8L6qrWQypSfAP3DNOtkToBoYJyd3BCsmz1vzuvPZkOfO6rCkuStTRfcbIVbbotkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
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

On 5/8/2025 12:01 PM, Anatoly Burakov wrote:
> Add support for parsing floating point numbers in cmdline library, as well
> as unit tests for the new functionality. Use C library for parsing.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:

v6 -> v7:
- Fixed a bug in float compare in unit tests where a bigger epsilon
   value than necessary was "needed" because we were comparing float
   result to a double result

>      v5 -> v6:
>      - Small refactor to reduce amount of noise
>      - Use strtof for parsing single precision floats
>      - More unit tests
>      
>      v4 -> v5:
>      - Reworked to use standard C library functions as much as possible,
>        keeping near-100% compatibility with earlier versions (the only
>        difference is that strings like "+4" are now considered valid)
>      
>      v3 -> v4:
>      - Removed unnecessary check for integer overflow when parsing negative
>        floats (as we convert to double before changing sign)
>      - Make naming of float exponent states more consistent
>      
>      v2 -> v3:
>      - Fixed a bug where a free-standing negative exponent ("1e-") would attempt to be
>        parsed, and added unit tests for this case
>      - Added support for floats in dpdk-cmdline-gen script
>      - Added documentation updates to call out float support
> 
>   app/test/test_cmdline_num.c            | 284 ++++++++++++++++++++++++-
>   buildtools/dpdk-cmdline-gen.py         |  24 ++-
>   doc/guides/prog_guide/cmdline.rst      |   3 +
>   doc/guides/rel_notes/release_25_07.rst |   5 +
>   lib/cmdline/cmdline_parse_num.c        |  67 +++++-
>   lib/cmdline/cmdline_parse_num.h        |   4 +-
>   6 files changed, 368 insertions(+), 19 deletions(-)
> 

...but forgot to remove the comment:

> +static int
> +float_cmp(double expected, void *actual_p, enum cmdline_numtype type)
> +{
> +	double eps;
> +	double actual_d;
> +
> +	if (type == RTE_FLOAT_SINGLE) {
> +		/* read as float, convert to double */
> +		actual_d = (double)*(float *)actual_p;
> +		/* downcast expected to float as well */
> +		expected = (double)(float)expected;
> +		/* FLT_EPSILON is too small for some tests */

Please fix this on apply if there is no v8, thanks :)

> +		eps = FLT_EPSILON;
> +	} else {
> +		/* read as double */
> +		actual_d = *(double *)actual_p;
> +		eps = DBL_EPSILON;
> +	}
> +	/* compare using epsilon value */
> +	if (fabs(expected - actual_d) < eps)
> +		return 0;
> +	/* not equal */
> +	return expected < actual_d ? -1 : 1;
> +}
> +

-- 
Thanks,
Anatoly
