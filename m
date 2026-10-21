Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA3606A323
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J4jwl6nY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C799440663;
	Wed, 21 Oct 2026 12:08:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 12CE540041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:08:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577290; x=1824113290;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GZgMmz5RYQMzjb4jOcqFWwAmtfv1KUjLsOy4jyYIjDk=;
 b=J4jwl6nYPw8uI6/IwGSdofCRskIjBcWxHFYM+nPc6IR023xbWM72P7Z5
 7oUdaS0tC0O/p1ojo1MGZpLrU4l/m3NyMdpxlCYvcusQO/pRFb5gx+efn
 X2SzFJW1GyNxfiFF0w5nlYqZ2A8fn7uPfxtGjKw4xji4QgtunTwFXvKlp
 WmmDHwt2z/uE8NYiEpvJy6ecwzrOS3fVvPxDYCGsF7VLjcg/F7Ja5K3h0
 zXZAghrSxB3RW7f5NWy3ZAj0N9xcvUVQahXxGvDPYJfQsMzqc8jagj6FF
 MYBFPBjoedhdoWl1opwPGPd3jF2GeAkckEEZzKWtzQQP2EGkiZ9f6N9xz A==;
X-CSE-ConnectionGUID: JdAtn69lSUa/Hq3pPFYn9Q==
X-CSE-MsgGUID: 7AljT7FzRoS+Lt5DUjKnlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1314007"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1314007"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:08:09 -0700
X-CSE-ConnectionGUID: aPW3+ghvSEqm/gZuTBeGiw==
X-CSE-MsgGUID: uggg2nz9SG2CciIVcNnZHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4889064"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:08:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:08:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:08:04 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6WwetKK/svsESA4TMgnqiihEhesGvhluSw8AsuJH/U+y0Kn4tmUUC6NnmzgoRq7wPFjwD2vPqN8GyrFzVxs7yhDOOeihppnpVxW729GABWoenQqB1jyhSHY/1ecT7b7kvHl+faKWO0SElqlvrue002GIGkbEoDVqFHh2uZ2V57hzKfSi14FlsMvzQ33wWG2xk+UQWeSBLyZxI1ZVkVBOSJ5EbnzKgHZJyd9KqNsSJVh2AqnlV8O0qokH+NfOZejPlAuoyaLI22PKZXREolD3XnrgMY7MwM/1dCp1fV761mpe4827Ci0Xa/QI8vDn5zaRc7IdMf3+f7ogkaLDhNS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5n92JWwRzlO2Qz2odlN0ldp+aauvXluUDbqWJu+q0k=;
 b=FOZhPokMHbKIUCAcd4vpiQrQJ7diTMeJDUoh2xOEOMYCsomiXig6LuEkVFnO+5iQBPHBpzhcrlgWDX8OBoCYjxRQKn7b3HBEJ+diFazYgswmW1vumEg4QBe7iKc66z5rQg/OqdFfLSJa2MpXLeznCaO7VslmCvfdt9MPUBHy9W9S8c/EeSy/6VvYh2MAGx6vmY2OdCkdNsJhFEHFUp8VQ7qdLgOKMPEiXFGx90zgmrxKntGNd20BEwt7pLdlIbOL8CIQ812mC/U25gn6eIshrXPmPZ77yQLo+mZQ6zHf7KwZEXGig2dyxC4x8FoXOeYbRa5Jb+kI4yTB5en4Vr2Eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA3PR11MB9399.namprd11.prod.outlook.com (2603:10b6:208:577::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Wed, 21 Oct 2026 10:08:01 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 10:08:01 +0000
Message-ID: <99fdb74e-501b-429b-9ab2-57222df2b232@intel.com>
Date: Wed, 21 Oct 2026 12:07:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] net/ice: centralize flow rule memory management
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1792498154.git.anatoly.burakov@intel.com>
 <eaf28172b00a9599520cd3c8dd6ed29ca5a0e7cf.1792498154.git.anatoly.burakov@intel.com>
 <atiNHzWR1DQZ6Dl8@bricha3-mobl1.ger.corp.intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <atiNHzWR1DQZ6Dl8@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA3PR11MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 535f7ea8-9823-4f67-2779-08df2f5b3069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|5023799004|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ieLaTmAzHdO0a998Uc9oe4SVKWC74xAXonp0/r1CF0smeIDM6WyWnrNN2BwGUmDJzg+K4snRh6Hs1udHIWSz90hx4kuLMtrAzHwmKsHBY/+ltxqn1U+wwoPm4ZTaFVSPURz0SOI3uzSl7ryA81PmQ8wRvEq9CR7RB6f/CXFFY5ZQeKG5Up+DXg7u+QUhtLur7gk7sIci+67lmOjYnmLGSv1j71LdpOB84dSCGwZyDSm7t36PURFvIub692nANz2Th2SaYvHc+Kl20nJgZeXOvHhnKFevizoT/sdGe1olL+qO/491UDittVwa5ikOAazuJoIj2Tckpp2tMF+X6v7iT1wVcLaVuiGonnHqEwhWuyfv78Z8J1UNV19ucWHKBoBXPHX6KO+ngMAvuKOnC3r0BGMA/f8Dvb9E7zbU2+Zp9wotpNyoPPNTcLzsrZY26Ah+isvMFXVcjUqScDuJY5J7UNsb+YyOv499YmQWjtiE8yZXohNFOcOsCSMGLZhfY9fnhmYP7kTXPBfQKUNqhGJw4kgNpWgc61bqtaiRSvv0Rj2WGkVr5UEgQQf1YO7vYayfI2HVAQ9324YFPAJJ8xG8umWQXl6xMesPAqGGpViqeE0wzBjxq2UwhIu6srSjszgsavsrh06KG/91k5BVdR7DB4M+4q3iJe+h6UHZWKcgD/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVEyU2g4SHhhTkxucHB2Nm9ZaEc4RTkzSm5EOFBVVlZoc0Y2V3B5TTJDZGJB?=
 =?utf-8?B?N3FtV1NhSnJoSXRjaStGUkR4M0RLNGlYblVrN3hCVmZjakV6dG5zVFZVTHBs?=
 =?utf-8?B?QVdyaW55LzdFTjkzOEY4MWNWL3VacjZ2K2pRZTdNVVdJWlZPQlB5STkvaS8x?=
 =?utf-8?B?UGlkRTVTcjl6cE9uTnRaZERHRzFjdHVVc3QvT0M2eXo2T094OW5UNEIwSllx?=
 =?utf-8?B?dUd2QVVIcER4WW1lazJjblZwS2ZhN0pTbm1CTjNoa25lUEt0ZEcwZWk0Y1c2?=
 =?utf-8?B?M0lEaDVBYlFId0ZtampZV0NFZmNRM3RVOFIxdmY1MDBodFQyMFNZV2RCcHE1?=
 =?utf-8?B?bTRxZ1czYkRxZVdBb24yMGV0aWxzU016NjhYQ3had0hMK0ZZdXpxOVlYNW1Z?=
 =?utf-8?B?bUZmam9UWTREYVJPR05KSTM3eU9BZkhTUUZuZjFMTDBRcVpiU3c5NkxIMENB?=
 =?utf-8?B?WStvSnpjWkFSam1ULzNCcCtoaVBZUkYzT0dRc1hFYXJzUmFOL3QxT3FKVE5u?=
 =?utf-8?B?b0swOUQwU2Yyb2pQdHk2RzE2ME9XT1FhNVNkbHJWK3BlMmRpS0Y3OGE1Tkw2?=
 =?utf-8?B?ZkhpRE44c2NZRGdQU21JeE5SMGlDdjhJK0Nkd2F4Sm9NSkFuN2IrTzk3ZTR4?=
 =?utf-8?B?U2FLTFM5bDkxbksxNWppaERVRElDNThkZmRxSXEwUURJc3NXV2FYVTljcG84?=
 =?utf-8?B?QjNkWmszNitnUHRNcTZjdGFYLzVKOS8xL3ZtblBYUUJwUkxJeDJRQnhMNGFS?=
 =?utf-8?B?VU5LQWg0V3FUMFhGNmxnQWZJeFNLZTJXcDNhOWF3WDlIbTdERjkrSURscWFT?=
 =?utf-8?B?bmtNYnFEQnk3VTZRVVhpTUpCVXB2WXpvNXU4LzZ3R0V5M2htdmxNSFJkT3Rr?=
 =?utf-8?B?K1lwa1haQ3BGQVczbVBMQkY0NGNvSlBFYnJFUlFPeEoyMVZZMjJrK3lpSmEz?=
 =?utf-8?B?aEoyeVI3Rks0WkZ3dmJpTUpQV0tSVG9wckplWWxKSDNKb053ZEhFNDRzb0Zt?=
 =?utf-8?B?dEVsckZlb3RHakRyZlIwN1lyTUZlbzdDQzZBQUpGdmNMcUE5dWVCL01kOWp0?=
 =?utf-8?B?c1VxTE9nSHZheWt6S3M2ZGczTzY1bEVRbTFPUXVVM0lUVWQ4bnNwUTZRYi9R?=
 =?utf-8?B?Yyt2emJib0VpaFBnSEdScmcwNUlpOXVUYUFzQTd6WFEzZ2N1WTNveXpnY2pp?=
 =?utf-8?B?c3M1UDRqMG1Xb010NXZRN0pnTWlpNVVZTVo4bkNXc3ZnUXAydk8zdy9FeThT?=
 =?utf-8?B?eTZiWjVhcGtGMVczbk1DUnhIWWZkUFkvVlc5Tk1qRVUvUFROdmRJYnJxYnZq?=
 =?utf-8?B?M2NTQXdLYW9FY3E4Vk54VHpnM3Q0dURDRUJFREx4bnZDZWIvQjFFYTd2aEx0?=
 =?utf-8?B?SDdQcnNlRThSYWJ5STJqSXVJVGN0ZWFOdzg0dVZuZGJnY3JzYXRjR2lwUVAw?=
 =?utf-8?B?ZllmU3BxeVNkTm1vRktldjFLV2ZtaU04MXNxTi9Xb1hkY0J6a2NXUDZIYmZ4?=
 =?utf-8?B?K0NtaDBpYTNDT1ZTNERhYnVwZDAwZ0hKM1RtYkY2UGpxRVZmWjhkeGFDN2o4?=
 =?utf-8?B?eWtlNk1tRzVxNmRlaHN5QUJDYjRIdW1LVk5jdTZLVldTdHB4L1dHU2FSd2pO?=
 =?utf-8?B?aFJuR2YzeFFUNFhYNU0xZGhSVEo4Qy95RE1Ba2cwYisyZTNnN1k1UUJ1TU93?=
 =?utf-8?B?bHFPb0xvQUNRRlE2M3hob0RVNS9Kd0Fta28zaDJoOFZIU2t4Ti96a2t4bkIy?=
 =?utf-8?B?M2poTndmYnA5d1M4Smh6WUxTK2hXeWNxRGE0T2g1ck9FN2pOMVFhaUdFOXBC?=
 =?utf-8?B?L2FsbVJsVXd5UkRSOWYxWERwaVBBM1d6WU41Q3BycytGWmpoMHp2Y0lYQUgz?=
 =?utf-8?B?bHhVdHZKL0F5SnY1VUZsa0h6WWhtdmgwZ2hISGExNEllT3M1d1krckJ1V1pp?=
 =?utf-8?B?NHFHREFMVkZoV21DNzRjTHNoWVZqUDZBYVJwQk9ldkk2NEF5QWZ2aERNRkxv?=
 =?utf-8?B?a28weWduZGc0WUNyc29kR1dDa1Z6cUt3eG9tZTZzM2lBZWp4YXo3cHVLTkZX?=
 =?utf-8?B?RG1mV1I2UzNXd0kzVzdIRWlFdy9XNWpXNG12ZzNvWU1iNkw4Z0hCbWZkZ0tL?=
 =?utf-8?B?WFphRlRLYkh5ZWd3RHcwTVFucTd3OVpBY2VhMHFOVGJyNDFGYldzQ1dMRGN5?=
 =?utf-8?B?alFSbitFTkhzOGgwNnQyMnVvTFZEcHQ5eGVyQ2E5U2tpVDRNQm9QaXBVME1I?=
 =?utf-8?B?N3ludjVNSkpIWnd4eEFFZWVTUzBBb1lYaTZSZ2c3NXUvTVR3T0I2RHhOZ0xa?=
 =?utf-8?B?UVlCTDNHcXJKN3kvV1ArSWRhbTFEdk1hY2NpbUdSb1dWam5iNnc4R3FRM01z?=
 =?utf-8?Q?KmMx2XlvDLjVd4aM=3D?=
X-Exchange-RoutingPolicyChecked: oyDxk2h4zQ4cqks8YET8BS4zSrP4V8Cuh3BGKMe+tB32H5OB3KPbb0FYVrUjhzNjAHJQ5zuL1ZINv+SuEW9LTExJz6naMQA31iFutkZ/3zB+ydzzFbyl2YzNrALCH9cHTvrPHv2vfrL+TeHiX5M5kUigWpgLyInxGDOQNexip2hSO1iFaruBONls3P4iyj++A6yrCKsZI9CL6US4Mi/Yfh43ATPF89gXtYBBr1e9kxVfLobSh8ZIlUtXBZ/KhC203HH6FZxTq/7LyLyxmJndc968DPT4wbd3tzXaFeg7jeulSPbnyFYggHBeaitLekEdbD+RBdEJS3/zesjpNd+2mQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 535f7ea8-9823-4f67-2779-08df2f5b3069
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:08:01.1992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5dIBs48lBH07wAIO1u9oXe+4rnCy5CNye6WwbV+vDtudtnvNU3tyA5ndivEEzQ96XbHfKX1Oni5D5SG8KIYntj4aoD+rAoYO0b+9k52wVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9399
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/2026 11:59 AM, Bruce Richardson wrote:
> On Tue, Oct 20, 2026 at 01:11:09PM +0100, Anatoly Burakov wrote:
>> Flow engines manage rule memory independently, with parsers returning
>> either temporary metadata or shared scratch storage. This spreads
>> ownership and cleanup across parsing, creation, destruction and
>> uninitialization across the flow infrastructure, which is difficult to
>> verify, reason about, and may have hidden bugs.
>>
>> Make parsers allocate the final rule and transfer ownership to the
>> generic flow layer on success. Free rules centrally after validation,
>> failed creation, successful destruction and uninitialization, retaining
>> them when destruction fails. Parsers clean up their own allocations on
>> failure.
>>
>> Some engines, in addition to the rule itself, will also allocate additional
>> data for the flow (e.g. RAW pattern buffer in FDIR engine). We can make the
>> flow memory management centralized in generic flow, but this additional
>> data is engine-specific, so use the `free` callbacks to release only said
>> additional flow data. Remove the RSS and ACL callbacks, the FDIR and ACL
>> scratch storage, and the redundant allocations and copies during rule
>> creation, and use stack storage where appropriate.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> After this cleanup, it looks like the flow parameter to each engine can be
> removed completely, since all four engines mark it as __rte_unused now.
> 
Yes, true. In ice, flows are basically two (or more) allocations - the 
flow header itself, and the actual rule it encodes (with whatever nested 
allocations the rule has - switch and FDIR RAW do that), but all of the 
latter happens inside the `flow->rule` pointer, so the `flow` itself is 
not needed. Arguably, `meta` also needs renaming into `rule`, because 
that's what it does now: it is meant to be a pointer to `flow->rule`.
-- 
Thanks,
Anatoly
