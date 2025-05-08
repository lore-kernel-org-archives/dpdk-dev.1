Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342F9C3ABC0
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 11:21:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E74D4026C;
	Thu,  8 May 2025 13:21:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id A49704026B
 for <dev@dpdk.org>; Thu,  8 May 2025 13:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746703304; x=1778239304;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yUJiqFbIinC4wUQ+dJDMaHP4wqfxl9MGP4cqvIGkbro=;
 b=G2vDrJwt+mryluuTvckTKamd60EWCgBHu817a6IkzyUychKaFpYCCES6
 fM3FxZmL4bOYTO16vTRIRDKYr1N+Jml0nicYo4bjk7LgbY7POpQ4sG1YO
 l25wGmQ7w3VhUybB+J3KtKUdXLYFhsB2oqKWWLYSQMFANLtwsrCzkr549
 FnWSUJh5zbln2xnkcfRlUo5UBgQpCwJqdEMH2ZEDLC59PYIvCj/vjJBIt
 0E9cU6sGik6GOliuvhncb7AcppW7A8KnJQYvr1sDmmfxYEdTh1ZXOzZk2
 zJzIV9UTqX+AIa6kIA/CJYM1mALbTT0Yqdi/5miOxba7oP3Esje38WB9N A==;
X-CSE-ConnectionGUID: QV2QLihBTdG5MRAxXr4Fcw==
X-CSE-MsgGUID: 5qLU8VgWS7e7hRsq/Rox+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48384966"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="48384966"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:21:43 -0700
X-CSE-ConnectionGUID: 99LIdInFTwSt4dfOYgznZA==
X-CSE-MsgGUID: dCNvZyShRm6Xm1w4/GwPuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="136757720"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:21:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 04:21:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 04:21:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 04:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYQrlB8bmYUpuNJ7mN8YIeeXJNdrnFl28MzICJlkoZgd+dkDSb8Ws3824d40bolvmwAM8mT8BQgmsUZcIxkKr/X6qivMIjfqlBsVYRgV0wooTqCBoM+eL/ZsYpQ8BcL3HolpagtUZa90Cl8BaZbOYM58ZQ8cgrGfod+IGVJ5/FnoPGl9Mf/Dyr2tNmKAmvPIXjagcpadu2xRNSoMUPLrFkc5FssszNG1ChVZRdV/aVVEzCsJvkGoDDX6EniP3rUUPFgenN3gTwUWdf4qLHFLcPeEyBr5p0ufzmvpgWYH6T617WOdAqa1z7qOJbdAkRWaByZCYoXIFuuPVeAl9DBcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Gl04h9ptOxnq5J232eLCwHnt6Q/WlDFDyhg32TLvVM=;
 b=AfNJ4gqRCLbnsr537/jDUrLfg9f7KufvtFqydWVvYIavEtqkG6DjIl6HqRpIzAVcnEQTga9z5yIDqDO4OkUEEucPBnBRX6lOeL3tSOU0ee9HFkxaIgo6112QpU0KxE4SPTaUn26kxZYBv5P1LMj32UvFRmdWXsawHmUc7eMTDBwqkrX9gjIHGBRksHNSHskUKvvWPQKnQsWjDH/wpjiiVIBXMTH70VfsOIDzadgQs6icebGJVORkiRsosYaP65psOPvzblzQm8FoG4UDGalMypuU3lITv5DYJzMl1X/7EdFFRhVpx0jPnmXcxjnX94JXU4oMxwl8yUMcCXFQRLzH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB8421.namprd11.prod.outlook.com (2603:10b6:a03:549::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Thu, 8 May 2025 11:20:49 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 11:20:49 +0000
Message-ID: <e0e7d27f-c047-41a1-ac40-912eedd6c431@intel.com>
Date: Thu, 8 May 2025 13:20:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] eal/freebsd: Do not index out of bounds in memseg list
To: Jake Freeland <jfree@FreeBSD.org>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250506175010.1141585-1-jfree@FreeBSD.org>
 <20250506175010.1141585-3-jfree@FreeBSD.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250506175010.1141585-3-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::21) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 53021271-cd85-452d-8524-08dd8e2262bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTRIam52UUZTSVZjNHJUcE05UXNaZWFSK09TN1Y3WThWM2kzUHlxRVZZU3dL?=
 =?utf-8?B?Zis3czhrNENRNU5Pbm5laE54UlVSV1RIZWZESFVnMG02WXRQRFZySUhFNEJT?=
 =?utf-8?B?eFcxemR2QkxLNFlTcWxkbTJFMGY2V3A3ZkJTUHNkN2VjcHhoUU9hQW83VHdI?=
 =?utf-8?B?MFZlOUJrNERCNjBPeXE4MHlvejJCUlBPRytLYlFGK3BnL3F2dzFVSnMrdjYy?=
 =?utf-8?B?N0NiOFBPL0FvUERiaUtkR1EzNHdwMDBqTVJjcUdzcHZSRXNwMzJEaWswa0NG?=
 =?utf-8?B?cm11d2trV2d4S0hiSlFkdk54cGI4MmxiaFRLSyt0V0pxb1V0OTU0b0REM2wz?=
 =?utf-8?B?cUFMaFJVM29QTzJsUmMzRWZkZE5sYm9GenFLNFAvbHpiSGIwQXE5RmliS1JD?=
 =?utf-8?B?SUNBa1BubDRuUng5bEtUSEhnbWVidEFxZm80amY2SEN3aWpjdXpKM0N3QUV3?=
 =?utf-8?B?NHh6d3BsQzNjSENYSTdzNjdaVmNlS1E5aGxCNFhzclhpSXh5RDN4MmRydmli?=
 =?utf-8?B?QkNHd0U2SlFDekVvM2o2Y2lleW9kQ1V3Qmhta0toYzlndEF4UGswemxaUytB?=
 =?utf-8?B?Vnh3Vy9jck5pVmNzT2trWW5nVWtGd1cwL2xYKzIxVUJCcjc5eHNVY29TM3pD?=
 =?utf-8?B?OXd4dldPZERRZjBiVmFINTlMZXBrcjgxTFdzMW95T0FITEZNTzc2MmxJR1Mr?=
 =?utf-8?B?TXN1ZEpYbENCaUpaaXM1SHg5SHdRRXpYbFlNNk9yd1ZSaGhoV2RaY0hvZHhy?=
 =?utf-8?B?ZHpHRXdUcU5peXd2N2R4OFdmQUR6Wi9maHUxTzVhTTBZVHo5WWZMUjV5QWtC?=
 =?utf-8?B?Q0ZjMVVvcmJ4V2pMMFdXUzNYaThxcEtlOU9LUlF0bDlLYVhzT3ZiY3pPbG9x?=
 =?utf-8?B?Y0s0Unh3WkpTaHVkSFpldVVsT21mVmxLNmpRUnFuMlkrQ0lGOGNZb3dnOU4z?=
 =?utf-8?B?RE91b3o2UzJTRTFmT3dpdHpIalFHWDJ2TGhob2NxR1ZYU0Q2MmhxRnRvSjJn?=
 =?utf-8?B?NnFDVWgvUjI5UzJDQXNhcUpTVGROMEVTdXRkNktEYmlEQm4wSUtzZFRaNWNj?=
 =?utf-8?B?M0k2Ykk1aFJUazN0QWNDc1RpMEFjUmlMVlVKZGRHbGlBMUNQRkNlZXJ1ajNv?=
 =?utf-8?B?N3JWMHRLY21KOU1Mb3FaL0prazlMcE9xTnQxemhKOXJHUWl3NWQ0aGJudllR?=
 =?utf-8?B?SGpZSG9sNXZRR0RHc2s5dVI2bk0zSDA0MVBUcXk2dHpjOUNJaFNwM29LamhS?=
 =?utf-8?B?YU92QkRjZUNzbWxIVXlqT01tdEN3TWxPV01tcmRJSms4L3RnVXRGM2dEOE1B?=
 =?utf-8?B?STdwaU1MR3N5RTQwL3NSMVNKNFd4eVJvWWZNVm9Cc2ZqL01DZkNWYzUvUUEw?=
 =?utf-8?B?OXpSaXRVVThjcTNkQ2JReE44d2lWTG5GRGszdndUb0R3b0YxMmdzSmdGU25V?=
 =?utf-8?B?UDBDZEdIYjRoUjlqV2kzcUVaRHhoK0gzcXFtT0dQQnh6cWRCTWUvdkRad0dQ?=
 =?utf-8?B?TWN2bjMwR3I1UC9WMTYvT01MMmZsL21NRXlqRjVWNnJaQnhDN1ZsY0UyQVFJ?=
 =?utf-8?B?NDZOeFhNUVZzdC9VTkxTcFhWWVdzd3UrQjhWS3dTZUxKMEo0UUt1WkRyWDM3?=
 =?utf-8?B?UFlhQ2J4UmFBSm9JaXBCQUxnYzdvU1hNQlVzSkI2T1h4WlgxKzg0eU1sd21V?=
 =?utf-8?B?Vm5rYWxBQ2g3dzl0SXRXMHVhaUhWdnQ2aGgxOWFrbFU1NjJzMm5UQVl0dVcx?=
 =?utf-8?B?NkNEUWxpbkcvc1FDUWRodUF5bmdtUmpBQStZZDBxOU1OakdQR2JWaXZuUitz?=
 =?utf-8?B?c1hIWXBEL0diYUIwTjl2NjdFMXFZUHFEVUVhOTcwSkxMZHVJNzFZcEVMajlY?=
 =?utf-8?B?bGZSK3lrSlV4VGJidll2QzlML1lyR1RZVTd4eFFCbExRNGcxSUhINkVpVkw4?=
 =?utf-8?Q?ihkc4ZY8pzo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2wrUjRVQzFZSG13K2RUVWo3eE1BdUxHbkVlczFUV244OFpuQXppTmd0Tm1X?=
 =?utf-8?B?N2ZQWTNaaHdHN3gxRWlGNCtTRUErMHpDdE5yakY4QUlBSUZnTGJLRHQ1ZTdY?=
 =?utf-8?B?VHE3dUtHLy91VTBQZmltRC9aYURkNGVDZjFGbEp1WlZQK2dIZktZcjRPcExa?=
 =?utf-8?B?aUZBNVNCRE5lQUhZdkx4RmF0ZTA3bXpmTGFKdUxXMWpzQ2UyWkMwQ3B2SGNI?=
 =?utf-8?B?TVM4VWloR0tBUnluWkRnRUJCcmlQc29QcHpmSHJLRjY5MlVnKzVDdWl1UlZ0?=
 =?utf-8?B?aFJDSGFvSVVrSGR4WlF2SVFhRkFzeCtHVGJFdzFxU1gzQ0ExRWlXWEFVVTBy?=
 =?utf-8?B?ZE5IVTNhZGpOZmNYa2M3aGZYc0IzTkhlUVk1WmhwWUF1dmRDSTJUbTZSSkh6?=
 =?utf-8?B?NWRvM0c4QWg2WjBVTUVrbFlyVmFHZzlMUlpibStDbXVIeG5lcXdlWEtPT1ZB?=
 =?utf-8?B?aWo5SXBoTGNCV1I4TkxlVVJsbERKL2hnWEQwbGJQd2ZGWkdnUFNSZGpRKzNm?=
 =?utf-8?B?cXNRVVVOQUZHYXo2OWxUMTVJUDFRaDdhbnV4ZDU2dzRTamdTLy96bm5kd1FH?=
 =?utf-8?B?dFJjd1FNaXlXL1ZvcSsvNTJ1MUNHVUFmV2RmZitWcDNzRG10RGNzYy8rbmsx?=
 =?utf-8?B?SEVJNy9BVENGUkZFMXlYSGNzU3pOK1E2TkQrclVuU3BPOFpsclliTkVienVC?=
 =?utf-8?B?MllqSGZZaXhVUER1cEY1czRvQUFjUHZlUDRqYWRUT3Y5ZWM3RlJxK2R1Lzhz?=
 =?utf-8?B?ejdZenJLU0l3NEFRZjl1cmtZVGE2azNFSGU4WFZraVpGd3o0QmhhdkhPSzRZ?=
 =?utf-8?B?MmIzNS9zc0RrWnpRR0l3L3FOQ3VJdVg2QTQwd1VFTklpL3ZORXJnZUZDUkd2?=
 =?utf-8?B?L1NhbjF1WlNwTStJVG8zRkM4dmh3aytLUzM2OTRYdDVSNDUyaERLNXJSbnZM?=
 =?utf-8?B?dDl0REtNb3l5VTNoWWFwRWNPSnQ3bkh5R28xNXRRTnNJVkJ6S1Zxb0ZlSXJv?=
 =?utf-8?B?MXFXQVVKWEJGUEtRMlJSY3U3Um9vUXF4T2hNMEZ0emxnd2ovSXNtRk1VSFh3?=
 =?utf-8?B?bjN0Y3VoUnFqQWJMS2R3dHNmeUxEVS9hY2FNNGhEeXVmM0ZORFZmb3hYS0pY?=
 =?utf-8?B?Tyt6Y3FhYkpvYndSbkFaV1dwV3FLUHRVWjRsWExmKzVVcUJSakEwOXExRVdN?=
 =?utf-8?B?ZnRyRFFoUURiUkxMMlVkaTQ3SmZ5em42THFkWFJ5cTJmdlRJS2NvMmdWcTV3?=
 =?utf-8?B?cVduY084b0IxdCs1cDhvb2JGY1phQ1V3VTRqdEhvVWxKOTZQNHdYZGM4RExR?=
 =?utf-8?B?UG1YRHJXVlZHN3hLRkxMQXRuR0o3MGdkNjdEbnhzZ3FsUHB1dlB1TGR3ZXZT?=
 =?utf-8?B?b3NMem1lZmpSbHMrdXFjS21KRmVIcUlNNHMydVRWb1htdGZpeVd2RllIa0pp?=
 =?utf-8?B?WVNGSFF6RzhaUTh5K0JxWGxwclRtN29mdW00aHZLNkQyTDVhSXpCS0VlWGtE?=
 =?utf-8?B?VG95dEtGZk1pOXhlV3VhNUdOeGg5VkpycFRIa2MrdEpIbUNzdDc1TExERE04?=
 =?utf-8?B?MEhzdFhtR2cveWU0TW5weWdMQkFMdWR5YVpHOXFpNEFYb2tOUGhvNGpLY1c1?=
 =?utf-8?B?S3JqSFp3NXBiaW8yaGpPS1F5ZzhQWFcwTThrU0tkcnVJK21HR01TRWVaZ0ww?=
 =?utf-8?B?Tm5SVUdZQjh5UFJERUlZN0R6d1NqQVJpd2dlVjY4blhwQkxIbmpoU2ZVWmVP?=
 =?utf-8?B?RVdHeTRqMzRHa0JqOGQyckljUVJ5Y2NwbFR4ZnA3TnQ4dXRwbmJheUwxZlVY?=
 =?utf-8?B?dG9ZSjZodXNlc1VZMWtYenpKYVVhMlhaUEpGMjJxazg0NHNGOXFZeEt6OGdV?=
 =?utf-8?B?V0FNL2hlVk1Xc1NtSGM1dEhtTFV4WTZSYW94NU1PQ2x0cTRBQ1ZqelZTZkJ5?=
 =?utf-8?B?cjlmaGk4aVcvTFBzcHMxN3ltQTM3UlhWd3JVbUtZcG9aOGFhMWxnclFERjUv?=
 =?utf-8?B?TkNCVldOUFRZQVBkOWl6RTlHOStwQmRpais2NkR1Y2JZT00wckVRbGthVTJP?=
 =?utf-8?B?OExzSis1ZGpTN09zWUxCbEdST3dwRVJQUTBUamFuYk01RGU0V2xENUFpbDNM?=
 =?utf-8?B?ZElNbmRyZ0c2TU1sTllqTDA4a2NlL1ZXNVRtR2piOGxkSXo2bEZSWmoxL0JN?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53021271-cd85-452d-8524-08dd8e2262bf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:20:49.5414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59O3XDjm2uuWQzzewIwxMPyJBD0mFW8R8ngBgedsUVxy/aD4EVXPjfyzLGLUji/INqjBqD5ijnNyPmg+6GI6cNAyiIHq7Y+9eDiUVAiwtfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
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

On 5/6/2025 7:50 PM, Jake Freeland wrote:
> It is possible for rte_fbarray_find_next_n_free() to misreport that there
> are n contiguous open spots. If we need two contiguous entries for a
> hole, make sure that we're not indexing out-of-bounds in the fbarray.
> 
> The `arr->len - arr->count < n` condition in fbarray_find_n() is meant to
> safeguard against this, but we are not updating arr->count when inserting
> holes, so an undesired index may be returned.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>

I don't quite get how this happens.

If we "need hole" that means the memseg list isn't empty, and previous 
segment is occupied. When we need hole, we request 2 free spots from the 
memseg. Let's assume there's only 2 free spots left in the memseg list, 
so we get ms_idx equal to (arr->len - 2).

We get ms_idx - that is, the index of where the free spot starts, and 
there's 2 spots guaranteed to be free at that point. We need a hole, so 
we increment ms_idx once to arrive at last free spot (arr->len - 1).

Where would the overflow come from?

(also, now that I think of it, I suspect we should not be starting our 
search from index 0 every time, because if we "don't need a hole" 
because the segment is adjacent to previous one, that means 
find_next_n(1) starting from 0 will find us a hole we left previously 
for some other segment - perhaps we should find first unoccupied spot 
from the end, and start the find_next_n search from there?)

-- 
Thanks,
Anatoly
