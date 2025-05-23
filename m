Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5356AC3DA6D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 10:20:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19CAE4060F;
	Fri, 23 May 2025 12:20:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7D38D400D7
 for <dev@dpdk.org>; Fri, 23 May 2025 12:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747995611; x=1779531611;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DK6sLZGFwqmXJiFHCQCbQfH/N4xS/H3GY1csmZQhlxA=;
 b=gZXZGNhTNwuBaCe2AvYFPoH/lzVrxQJxWtVr+ns9VKISJMLPnkbWOmhG
 vS+rJ9mkeDOfMY2jDZZmw0DlzmgsG2Zg9C3ByFXvMZ8DTORWLObk+io5v
 +SuBlM55vKKpaSBBFNWOeKhrPg/aCzXHUQLCxhIU4AmgCFhlqIwy/QJoi
 z/s9Qihplth8UAYsvLShCYU0msCJUp49L1TrzNvQmd38NZhLUFlfOBbzg
 x4avN4RzVdxHVuaQJxLweeiCCkoMVPh4uRDEOFBnwngkQniVLGaEc9Ccy
 OBWEadZ7CdbLmhinuS/okwNbhdyM8SUkloy9wL7N3vHDZHGPAU5ZFfGOI g==;
X-CSE-ConnectionGUID: NDmJPbmqSI6LiTpSWBpH3g==
X-CSE-MsgGUID: zfEF8puCT8Cm51Ux53Qpdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49931381"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="49931381"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 03:20:10 -0700
X-CSE-ConnectionGUID: YICEY/GgQfO9u/R7uPeg1w==
X-CSE-MsgGUID: 55WkXIeeT3iNz+VvFttkrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="141582494"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 03:20:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 03:20:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 03:20:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.85)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 03:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bieicmLa9M6TyDgErqqxlRfJrUFOVGMW0+M6zgdH/ZowXUHypn0xoDRSq1wWhqx0fWRjl+Udiq6T1V2OAa7RNW95LL4j2C398K+GwVtU53qmg48SZWctoyiYruADJPI177YGueXzpP34dYOTBw25pbc+go+JHG7jLDcF5NXzHraBHaXXEiLDyPwJ5IbFPUlY7IwGJUAeC3bZc/c40IBNLQlTuSGhPHdIbLlSJ2e/TG0qxu2WsJd3FPw/VcjgK71zIXkH8/NxulUHJ4pohC9UacnItmy6AGJ9lHJLSOdty+ywuZJLu3ie6wHq8FHl5jNalgWCJowIHUQOiXsD+1atMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zWeFcxPIJ5mHly1N2k+cNh6BUL5App8QxN8PfzsjN0=;
 b=x6XpiQ2FjYUz27grV/CuTyDpXa4iEPiv3SAV7ZN4CVmwNZWOeUtRDrxannRsXbR5y9UR2z1HDPV2SOm9AZkkW2FY2jwLZDbc3TOXbeKxlmdp98n91Th/969Cv/m6zoyroF2Wzo6Q5dKSsBOQJFZXK0d0elUY1n0Va7B2+Pe2F6OWyzxy8+LBEQ3vwe1IUeNw5PgMwDeQSGBnoBfPXjXqxGrwtg1sfEKC6SnzZda8aQf83DmqSxO9+Cnbgrkwr24iT5VDDSLz13DHfKZ9dyFb/V014STVSJn+41ZpiyOP6u9C1XaNyxMcVMq+penQF30Op+iDj4j05ecF8os+iilNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CY5PR11MB6488.namprd11.prod.outlook.com (2603:10b6:930:30::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Fri, 23 May 2025 10:19:32 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8722.031; Fri, 23 May 2025
 10:19:32 +0000
Message-ID: <672d8dee-b3fc-4866-aaa7-ef444e2ec90e@intel.com>
Date: Fri, 23 May 2025 12:19:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] app/testpmd: sort commands by help string
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
References: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
 <608636ba99de43497d42f41787fec7005cc2e52b.1747227723.git.anatoly.burakov@intel.com>
 <20250521152409.37302820@hermes.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250521152409.37302820@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0066.eurprd06.prod.outlook.com
 (2603:10a6:10:120::40) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CY5PR11MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 4676bbad-9814-4032-b081-08dd99e34f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTMzTUhCNDcrNmxaKzlaR2gxOW1XOEpPRWJ4cDRTUDFYSEdLd1hIVjRCYmpv?=
 =?utf-8?B?b3RQbUhORTFPNUxKRXoyeWt4eTNhOENwNWRNTkpxOVE0dGhUY1poVlZweXNC?=
 =?utf-8?B?YkhBWmtMbGNBQWl5Y3BMcmYzYWdnaGV2eUROcjdhWGVQVVVUYzFwREZOQmtH?=
 =?utf-8?B?djViVmcvVVNMaEFXdXdwQmF3Mi9rZCtlb1JDdGVMMlh6Mm0xd2QrN0gybklr?=
 =?utf-8?B?bmwycVFCOEdKQ04yRklxZis5dVBxNzdZNjRDT2RhZFFYWEYxOUYrcWJrYUdr?=
 =?utf-8?B?TmVaSnZZZzdmL0dZeGFXUXR0NC9iMEtqS3VsbUdtT0pEZ0wwVHFXWmtmajRS?=
 =?utf-8?B?NEkwejk2eVAwU1dERkdteTZMRytub2diakR2ckxnbWxmU3hzK3FOVkdGdTVZ?=
 =?utf-8?B?SDRQUm9tbHBkeXYxMmg5aWJmUTlROFhTaldIY3A5T1BURG1JQUpSN2ZVcnhv?=
 =?utf-8?B?Mys1TWJrNUsrWU5kd0JNc01yZzBMWHN1dzdGbzV4ZTE1ZDJNWDNJUnpTQmYz?=
 =?utf-8?B?SXErMGQyWUNEWEl2bmdoZFdtSVFQOEpIMStzcGV3d29tZmlraHozVVlyMENW?=
 =?utf-8?B?eEc2WWlLOXRQb2Y2YSsyMFZEY2RST28xQlA3QW5rMHhNd2lPVVZKb3dzUFhW?=
 =?utf-8?B?cFlMUHZVaFpBbG1heWJzU2E2SW8rZHoxUFN5ZHowRzBWYmJqRWkrNWlVUS9x?=
 =?utf-8?B?eUJuamVrZm01Rkk3SGYzQUlJYWdaUE4zeHN4bDhXRFFMWWtuVnJxcEtrR1U2?=
 =?utf-8?B?WFQyTkFqMERpV3JlVXRBa2VBY3MwNTRObWEzQi9LNVAvU0svSU95a1QyenJ1?=
 =?utf-8?B?UEZ4VU9tWm5UQkpBVnpQbDJOWE5GbG8rNGMrenB4VGlWREZaRjNsaFBUalR5?=
 =?utf-8?B?SldtOXlOait2NS9ONmFZZWhLUGU5OXZOTnkwTUFCNkhXWndJRlNVK0lxNjR5?=
 =?utf-8?B?TWV3Y3NrdTJlazkycVBncDk2V2JaanozSTl3MncvRTNBRzk0dCtoZnFtV05o?=
 =?utf-8?B?RFNlOXFzRU0yWmc4T251TTA1Ny9CUC9SRVlpc2t6dnBobTAydC95WEtoWUhy?=
 =?utf-8?B?T3pNU1p1TDQ5OW9iVE4zaEd4R0JpbTRSUXByemNOemJLRTQ3YUp1ZmNxa1pM?=
 =?utf-8?B?dmphYzN5bXBJYkhCeWJUOGNhQ2JxcU9EaVEzLzVNZ2NyU1RVcG13cVp2amNJ?=
 =?utf-8?B?T0kzRTJ1dFlMZUszcHowa0tKaDkyWnhEZmEwWGd2cTJ5Y1ZQRE95cEpOQU9M?=
 =?utf-8?B?NDh4NWhPVkZqN2t6c2RkYUJ1ZmVBSTE5QnpyMllXZTRBN1JIeUthOW9YNXNP?=
 =?utf-8?B?a3NFNm10eW9iUGRZaGRuaXBPVXk5MHd3YWhjYlp4OGVObHZVSXdyTzdWL21l?=
 =?utf-8?B?OXRhMlVnZzEwUlc3WDc0TmRiT2RKNDUwTWczbXNYSENjck9ORXU2NnhrOG50?=
 =?utf-8?B?dEVad24wOWh0bHRhcDBNWnFxSkJWNVpQenE3MXZ6bm9sVWlGOVlxeW5QTldq?=
 =?utf-8?B?VGxWWkFEZi9rejk4eCtpMVlZa2R3L2pZNlJaWWQ4aVRxUTk4UnpyZDYzdXpX?=
 =?utf-8?B?QTBPbUcraU1PdlVnNjVvY3lhRXpaa2VxbnVvbkR5cUVMYURIWTZoWXNNZFNr?=
 =?utf-8?B?V3VxMzZsRE0zaER3VGxqT2lCSWpsTVZ3Nk81RElkN09rS1ByWWZhTGovc25X?=
 =?utf-8?B?OVo2SnhxM2lpaWx5d1RQYTNiaDVHa1AzZkFlWWM1Ulh5ZTFRQVZwNG0xdkVG?=
 =?utf-8?B?cUhBRTJjanYvWFNzYXdoWmNLdm9VSUxDNldpK3VLcnNnWlFqVm9DZngvOC8w?=
 =?utf-8?B?ZlVzY09abnY5ZTZnWExSRTBrS2JieTRlejhNa3BVdUxoTnhrT0h1UytGRWUz?=
 =?utf-8?B?VDJ2ajVjdW1lRmxBVlBsSFY2T1dqL2pTazlDTGpXcXJOUWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXN6QkVZeW5BYWk1VHpEaWFlZVovMWVQK25vdmpnY2NKdU9ONTR0Mi9UeVdv?=
 =?utf-8?B?akNTNWxWc0o5NXljTjVTYjJ2YVBxc0YrRjMwVTRYaUxnd25pOXlSVUptN0lL?=
 =?utf-8?B?aDJCcUpTODNrQmJhek1sTTBucjdTL0w2c0ZMWWZkK2cvMzh1WTJaSEg0NGlO?=
 =?utf-8?B?Vzd0NGFvRWhUOHgwVnhlRHRic24rK25sT0RSMSs0RGNkS3I5YWMvK3p0TkZG?=
 =?utf-8?B?SE5BeWxsaVNZSzgwUlppYzhuQXhIc2lUS2xkK08yaHRwL3VseC9WeEQ5VjNP?=
 =?utf-8?B?emRRenF5MWV2S0s2ZG5TQmhTTm04dzlvVjU2bDdPY0hQMmJaYnRLKzFqQ0NV?=
 =?utf-8?B?TFV6TWlkMExBdnZ1SVo2Zyt5dGlIUEM5ZmN0bkF0ZTk2M1lqN1V4ZTFTV2t4?=
 =?utf-8?B?UmhxWW1BZC9Dbk42b0k0Z2kwLzkxalhISStBVlJxL0s5akZ6bWYzUXUvQWNS?=
 =?utf-8?B?cW43Y0VoeVQveGpxQmRIeWZiSDVES1RqM2VBR2o1Qm1jZXg3VTZ4OFZ1Q3ZO?=
 =?utf-8?B?SXFybkRzZHQ2L2VsdVBvSmduR2tXY1NYQjNuWUx5ZDZ3QmJmL0NsWEdxd0d6?=
 =?utf-8?B?T2pVbllhVUJyTFdJd08rYWpvbXVESmZ1Ry9kVHZwUTdzbnlCNXlSNFdRSzRM?=
 =?utf-8?B?VDl2MUpFWGdTdjR3akxFVStkMzl5VjNaT3lQMi85S0g1Y1p1TDFvUXlGSGNL?=
 =?utf-8?B?MG55bzNtbWRHZ2ZMUkJia2FBazZBMzM3ei8yWi80U1ZCWURPTlN1a3pMeUZX?=
 =?utf-8?B?dVRoZDBjMUVkZ2JVZEwxSDZPb2JWWHhLN3c2NTRQamdITnAwSHIvY2JzSDVH?=
 =?utf-8?B?bEQ3d1o0U2JhMTFXeXhlbElQYnRVODkvTXRaOUtLZ3diRm5ZUlQ2SEtvU1pU?=
 =?utf-8?B?U0NxMnlMWEJna0lLM2J2cmpTcmUvVHliL2dEQWhydzg0aFNGQyszNGNpRXZm?=
 =?utf-8?B?ZUVwRHg3ekhkUzBKb1hrUTI2ZjRYSWpyKzhoMW9YU0xaUENTZ2RaYzNvSE5n?=
 =?utf-8?B?Qm1FUXZXSmVKbFhxZWRYU010R1JGdHRLYjgrdVFKaWpQdHh4Y010Z1ZwZXlm?=
 =?utf-8?B?NVdNaWVHazhTYjloVTFOK0p0OEtWc29oeEQxUnlHUEJNU1dFRVI4THJVVEF4?=
 =?utf-8?B?NFY3eVI0bTVRZ0xNK240MWdRNVJKQkFVZ3FHOEZWam1HYWpZWEJLOTV2TTBL?=
 =?utf-8?B?SE1tSmYxTGE1LzJSWCtiUXVjbkxUeXFuZmh5bzRjenN1UlpBVFJYRktTckM0?=
 =?utf-8?B?UGt3b3gvVHIxNFJQSXZLU1lZR1lmeTJyVFQ2MzBoWmhPeXpZSElzMDBYaHp1?=
 =?utf-8?B?T0ZnNTIyY3E1cjJyNDYxU2h1YUZ2ZFROb2U1RXk0U2dLTXdPOFBZbjZQM2Rw?=
 =?utf-8?B?M1lMUU5YWnFwUUlsdTJZdEtraCtZYitOU3FDanpyVkJ5RUx2UG5zNURNSUtV?=
 =?utf-8?B?YWhlMjFBd0Q1dkU1TWljRzhMTmxTTFBQNmxrVFQ0VFZhT2FRSVd5RVM4SW9X?=
 =?utf-8?B?Q1NwUEFNQkpXaWt2NE9JbWkxSmJxczJoUjJtWU1xMmlPUE9YSmhaQ1V2WWxQ?=
 =?utf-8?B?dXRsOFRZcFNKLy9OWUFnaTBJV0lJaFVuMmJaWkI3aDRFQU9udmNZVnhQeFo0?=
 =?utf-8?B?b09NUGVyQjVCYXZmUEF4L1dkcUVoQUgvcys1aU9mOTBKbHhiOTMzMjZzb3Z1?=
 =?utf-8?B?NEsyT0hDZFRQb2JPQzFybEExK3JqTG9lMmJqMjFURUVCT1A0TmVlUitiUG96?=
 =?utf-8?B?U0pUL040WTVKa0RZUGVzV3ozcUd3bVVldXZZSmVmV3lLWjUvRForMG9DV2dl?=
 =?utf-8?B?YWQ4SEZUZmRHclc1YW9vZVVoZDZHb0ZuR3dKc0NHajJBUWc2U2hiaW5JRnRn?=
 =?utf-8?B?OCt3MFdKRlpiK3RmNFRNeUhYUEIyclNHeFNudHg5RGxuZmwxS2VrVEdFbm04?=
 =?utf-8?B?cEpoM1E5bDlIT1FWRktNK3dMSWVhUUxuVFZrQU5yYjBON3ZGanZEbjJxTzlv?=
 =?utf-8?B?OGhPbjhvT1hPUC9jeG9xRUtVemtyelllbldMYWM5OUY0d1hqNDNubXJ6bnQ1?=
 =?utf-8?B?cVZPOXBVNkFMNGYrOGJWNVkyRWY5R2JnR3JNdnN4b0lsdVNYdFVrUE9zWDM0?=
 =?utf-8?B?c1Rnc0tXL2thQTIxTzlwelR4anNrTHVxMkNIUGdXbjMvd0Y1a2kveUVnS1Zp?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4676bbad-9814-4032-b081-08dd99e34f20
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 10:19:32.2579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRwln+82pq5ADHZRsrpOAP/v6GGdScbm4nvyfYOlE6pxLujPdnWuBdvoeqHcpOSSClutDT825DQqaCq7QbhPnRbKdtxu4I654XN8PoQn7xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6488
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

On 5/22/2025 12:24 AM, Stephen Hemminger wrote:
> On Wed, 14 May 2025 14:02:12 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> When using '?' to find commands, it occasionally is difficult to find the
>> needed commands because all commands are not in alphabetical order, but
>> rather can be ordered rather arbitrarily.
>>
>> To address this, use help string to order commands. This sacrifices some
>> amount of grouping (i.e. when tm commands go one after another), but may
>> improve discoverability (and most similar commands tend to have similar
>> help strings and will be located closer together anyway).
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
> 
> Sorting is good, but why not pre-sort builtin_ctx and make it const?
> 

It's difficult and error-prone to sort these messages statically because 
there's no obvious to know where to insert the new value without reading 
lots of help strings from other commands. You could argue that we could 
sort by variable name but it feels like an unnecessary burden on the 
developer to maintain this sorting order when we can just automate it at 
runtime without giving up anything.

-- 
Thanks,
Anatoly
