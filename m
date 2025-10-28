Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACD0CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 15:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3098E4028D;
	Tue, 28 Oct 2025 16:02:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 23D334021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 16:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761663757; x=1793199757;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=NrBOZMa73JlHBe8KOpz5vOrfDkm5GObin4cP1yY6sYU=;
 b=lKXzMiSZgoQX49v3pRUIXUV6I84Bdrt9lXFJbIDfLk7b6xhJWb0xjYHm
 /795wpTn8b9tDK6XAlNJGuyG5RxzaKIfNhWbxd1G+P/KLpJnnJVev/G6d
 tGJYCeoZekKraN73DaBjRlQcN7xzElOF1sOCjgSpIU8eHstx5uslyqqXO
 f4FbNyQMXJhBlyE9oUFfrBj2QKfdBzdVMhTf0YkZRG/ma7cprJIiBeyni
 qsCL1c3heyjufrN9RlIsqMIncNIuw/nxLy4z+1VMEW4W9dutLlOvYJAX6
 ke+EuxKmYHxF3DR8adpEI1Fa9klyURVizK1DUQVIfZHIQ+57gz5udp54z g==;
X-CSE-ConnectionGUID: 5Jv+iLJgSKeBbx6gUVRZNA==
X-CSE-MsgGUID: 2aGHXAnbSRuvznHqIgqitw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74052600"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="74052600"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 08:02:36 -0700
X-CSE-ConnectionGUID: 7lC/2B2jRsuyYz05ejS8+w==
X-CSE-MsgGUID: HS6FdUxYSWmPaAFZx9KmUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="216242720"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 08:02:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 08:02:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 08:02:34 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 08:02:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOOgGRBYeGT90F16TdCPI0TilmebV+zAJpxW2UdLDLNFmlRBNooLT50Yw2UKCYYzaI3mqYZAPta3VoQuoFjlDH+thACgqB4CcaLQfd1Yqz3FIsmZhLjLuwoPNkgkD4dBnKzFUZO99kN8m0kuaTOY11r+8s0MdK0B8FYPYktaiSW86Ke/D1eCSLlQDuWUtQBVP636aIPFPFnh7zo6Q+iP0EoIMugXzzLHanJx05KgbsM+bmniC6ZY3y8HXjR+GmsBHrxTyAF2xdpanWVG2egg8KgFMHKtAlIUPbm2SqPztRWGtRverV4bFHaDhQ4WH48WzGYdxPSVbB5XHze4086Gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iteYIV4QRqoS4qeC0Nik/YGtWeOz1h9viSjycjzRASQ=;
 b=KyrMGAp5eotgmv8zSBv8RLFQU5ygVHDJaUyPCv7hQbJPet2dUM2LCj0WaS1xQ3fcFk9IIP7Ld2I2VzgVjbRO+wb4IpFDBERcUh1iMCYYJBQq8SYJ5j1HSlYEXnbudfvmgiizLXUmFlsMWyg8TH/E9dmKa7AKGLG7HMi+/JEul8mT2BVNsLk4nFuD8jjYEtqLbh+hQn1odGFM63kKIu/qXnPYhxYZM2gG/+B6FetJL34Hcb2guJpjjACQVQ7VtABy9LV2HGbAcxjv2QXdhh1J30lPUVyaUn9hjeUH3gY+pftPdoBJ0S2yY5yKZiDBPsIiRBpxb8Ey98F4R8U3IJvAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH7PR11MB6404.namprd11.prod.outlook.com (2603:10b6:510:1f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 15:02:32 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9253.013; Tue, 28 Oct 2025
 15:02:32 +0000
Message-ID: <4c743c23-217a-4aa0-9144-6735737f5ca2@intel.com>
Date: Tue, 28 Oct 2025 15:02:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk v2] fib6: implement RCU rule reclamation
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <20251015095347.333685-2-rjarry@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20251015095347.333685-2-rjarry@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:10:234::7) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH7PR11MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 97267c52-391a-4c1b-d0c1-08de16330520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTVMU1hjVGFQWnU2VjVMMXQ2WlBHVWZQem9rYmF4OHAvcTAyNmRpTEwxYVhR?=
 =?utf-8?B?aXAwaFljV3AxQkpKbEhNbGNudFRtS0w2TXhRblRWcnBjYkdWb0RRVDRFVndz?=
 =?utf-8?B?bHpUYmZBMEh5dlRBWHRaY0VyL0tFS2d1VzNZQUd6ZXAyWUJlZjErRFZkZXlB?=
 =?utf-8?B?ZlVrQkpKb3hWSWl6Q2pnNzNjYWEwelNJTnVEeG5ld1J4NEFKQ0llbGhsVk5P?=
 =?utf-8?B?OGp1OEZKeEpHQ3pia3FVaTBiUVdnUG9tbDFZUWpUUnFVU0VPRmxlYmVOZXlM?=
 =?utf-8?B?OHdNeUNXcm5EN3pkT1RmOHJxVWpYVGtrME5zbW96MjJLWlNKUWIyWGJ5QUJ4?=
 =?utf-8?B?dmZpWHorVFNLUnFheVZoUGJWRFVtRXZIZU12OG9uZ3NJMU80TXVsMlhQeFpV?=
 =?utf-8?B?eEFqdjNvSHRQWDJoUUtCTlIwQU8wdkhOWWFpTE9XSEtObHNPTHhMK0phQjM0?=
 =?utf-8?B?c2kvblRLdXU3VFFFNTdOYkE4WTFpSXN0dnMybXB6SkdxTFVleHptTDVvb0k0?=
 =?utf-8?B?b2JEMG9FRFNoRzFpTUNRMXFER0JkYXN0NmROSUh2UG5GRG5QQk05VzFuWU40?=
 =?utf-8?B?TTJRTjlycWZDTWxPTHltRWdzazBEdXArNXFxSEZjZ0Q1TTFUZTQwUG9lRlEw?=
 =?utf-8?B?WFJwODhuUjliUkFnbi91elViK1lHYUVabERjMUxBV0pubE94blV1YnJhN2Fs?=
 =?utf-8?B?aDIzTWQ0UXFUcXZSZ0docmwwdUU3NDZueHJsb210SENFKzNqNHZ6bzJkY2hr?=
 =?utf-8?B?NDJoZzFxaWxsc2d6aDNRUkhMbjQybW5Ic3p6bEMyWm93VEh4SytvNjVtTzRH?=
 =?utf-8?B?dmNMYlBqUXQ1YzFsT1lHRVFHZ0p0alpKdHU2MkVjU1YwaHRSQjZSbHdpcDRu?=
 =?utf-8?B?aENLOEs1Z0dWQnU5RmxaQ283TXJZLysvT0xERHloSmh1VDArZk1oQm4rMHZk?=
 =?utf-8?B?eThTYXM2c2ZURENZeUtOZml5R1ZhUktkc3dwUGFjLzB4V0JSdmEra2F6Wmxt?=
 =?utf-8?B?UmRHdldPMEpzZ09rNW50ZWhZVExqWTZkMGg3WDU3MWZhc2ZsalY4Z3J0VDVj?=
 =?utf-8?B?KzFZT3VGZmJhSVNVdVUvWFg5N2R6S0JRRElMZThRVTRyR3NIUTk5VUtGaTFz?=
 =?utf-8?B?d3ZUeVBXeFBFNXpnbUhic3F0TGRCc29PM1B2S2gwRkluVW1qS3B2QXVZSzVu?=
 =?utf-8?B?T2RYaDFaUUIyR2FLZFNvb3c3VkZTK053bUR4eWpDMm1iL0Q0MzVBTFVGdS9n?=
 =?utf-8?B?OVcyREVvRXBjRDNDVVhCZGNic0VwTldoMEhzSmwyZk9Zby9IYWlDNlQ4eHV4?=
 =?utf-8?B?QjV1TGdrTCtWZHAvVzEyMlNNc1NKclNKdGZxUVhNWVZEZXZ5YWNtYThvanRm?=
 =?utf-8?B?Z05EZm1Gc2NpZTZrODF4OUc3eCtaSFdOSVVUZ0xhczYrL2l4OE1HQzh2YzVS?=
 =?utf-8?B?Q3c1ekNhR1hFcXBHVUE3MjV6K0NpMGpwUnNIT2JiaGZ3Yk51Sk9HTXNIU2pi?=
 =?utf-8?B?cHFRSVl3bnErMmt1c1U2VFRMeklCYThaMTRZK3RWdEwreDU1Y2NKcUZQTjBJ?=
 =?utf-8?B?U2lPSlpuTjIwNThPY2RWODgxbHRtbHcwRG40WjVVTmFqOXVvS3Vob2VkSWZQ?=
 =?utf-8?B?ZTVxVDJLM2lhQnFodUNnWHRiekphYUczSTV6TnI1M1FQelJDbkp2a2ZWcm1S?=
 =?utf-8?B?ZTFpWXZaS0RFQVA3bkxNYXJ1T3N6QW1kbVN5WU5rNHZsNG53NmdjQXNraXJt?=
 =?utf-8?B?ZWRMK2ZxR2Z2VXFBbUMzR0ZiWGlGc1MzVkhSM0RmQlkvTjhUU2hGMHF3S2VC?=
 =?utf-8?B?T0xzeWFjV2xaOGQxR3BOcVZEcWgvL29lOVcra3g4VVZ4S3BDOTN0Y20zQ2pa?=
 =?utf-8?B?RHFpa1ppelNRYzZDYm5INjZFblNLQ1VCU1dvSXdLSGtmQmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxuVkw3cEpnSldPRzFwRFpUWVhUWlpWc3RweDR1R1FFWmc0VVBUWHhqKzNs?=
 =?utf-8?B?QjFwQVM4TmxDdnhEMFdXOE5ya2pzWmk3Skt4Q1VxTTBXeWZHMU5PRlVIdjI2?=
 =?utf-8?B?dTVkWlNXcG43ZU5HMGY5RFJPeG9wNkxadExOajNYOExNT3FqSFQxaWRoa1hN?=
 =?utf-8?B?Ni9kcUpnYUxLY1FvK0Znalc2TmF1eXRNOWNFYmxKQTBENU1obWVsY0FkUW1D?=
 =?utf-8?B?WU9IbGVxeUZPMWpIdldxWWpnaXRacFI2YkpDL3hTcHZnT1l5RVZDNWtTVk5D?=
 =?utf-8?B?QnFCTkw5Q1B4TzFiY0pzTUxyMHM0L1hXSVFsK1N2elo2UVlLYzE1K3oxLzY3?=
 =?utf-8?B?dzZVcFFESEVpSUhRaUNEV2xuS0hFUjBGYmg2ZHpNVWlsZm5SVnBuTTUxcWVv?=
 =?utf-8?B?b0E4MEx2a2IvRXRONWY1RlZpYVU3SHBQVlMvdlVjNm43MXU3YnprT3lGWVBR?=
 =?utf-8?B?dHROUHNtTWVVZEo0MDVuR3dKaFpYWHRRdE9WRFBqbVduWTVmVXRYZ2ZkVXhN?=
 =?utf-8?B?cGpGQk1mVit4SkpMazRoL1M4bkxkbU5aZktTYmR5UVBVMjNLanRHKzBhRkRn?=
 =?utf-8?B?blloRzBGSEFxSmJVTnYrSEFQTlFHUEFuZ1F1VUtDQ2xvZU9WczZGM3FsOXFQ?=
 =?utf-8?B?bSsrZEpDZFRIZk9RUllUZWgzUzF6aERXOWh0bjgydEJVc3Z0QzZpSUlPU3RE?=
 =?utf-8?B?cktSdHlDL0FDV0tFTXd2Y2xnQkRXK2VOVG04eTUwdVpsNFdDV05zcnJIcmdD?=
 =?utf-8?B?YjVZeWJRS3g5NUtWYjNiMlFFUnZtaExQR2FlVmcwd1lhd3Raa09oQ3p3OVpv?=
 =?utf-8?B?eHdtdVdXTDNaOHdNTXJXNkdTTHlvbFZhVFJTeFRDT0hFWkVPeGE2WCt1UUJx?=
 =?utf-8?B?RmdwemtvaDh4MjJKZkQ2aXRuenpMR2ExOXY5Y2dNeTJuS2U2OGgxZFBmczE2?=
 =?utf-8?B?aENtRVQrL3lGWVdBazhEeUdNaFA0dklsWFFNWjlIUDdrcldiZWdST0pVYXFi?=
 =?utf-8?B?SUhoV2N5QzcwZGNNT2NGQnE5WnpDU1NEM3h6M2srejdyaHY4Z3UwVWhJdTNo?=
 =?utf-8?B?c01uWXR1L3U3aHRUZXEzUTM5VHZoQTlzTUpJcXNaODhjd2xJeUpBMndPdkw5?=
 =?utf-8?B?SkhMUjdEL2VNN0g2Zk4vY3NTTzhGZyt4Tlk1WE9kS2JUbUVwd2JyL2FJRFlh?=
 =?utf-8?B?cy9JWk1TT3c1bnZVZ0NoZGNndHdsbUlRN2RIa0dwTVRRUlN1aEh0M1JiR2dN?=
 =?utf-8?B?bUFnc1AycjZlQ3NWM084amVGeGVmVDdtSFk3U3d0Yy8wNmJqTmFXaTM3YUZ5?=
 =?utf-8?B?ZVQyZDh6YjUrMEx0ZHNCc01hTjN1M1hvZktMdWZDeXdKRFVEOVU2UDBVbXU1?=
 =?utf-8?B?SEZQRk83TTRMc2djMXk1anJqblp4c283eEhzZW1aakRGVDF6eG9oaVc5UG5D?=
 =?utf-8?B?TEU0VnEySWFWMUo3TnJzb2lyMUdWNVZEaFR6TnFOYXM0ZjUrcGlUQ2RFelVq?=
 =?utf-8?B?ZzcyT1VZTXhFaCt1WGZwUFFIZkNVOGJmWHlPbFFmN3pXT3oxaStQUDhNamwz?=
 =?utf-8?B?OVZqSW5Hemk1SFlSbzc1Tk5XZkx1OTVMc0JxczJtZXEvUWd3aEJ5QUNFbFZm?=
 =?utf-8?B?azVLZDZ4TGdPbFdzSHNZdEg5WHNxbzA2aXNwbUlET1dmV28rbXo3Ky8wVnVO?=
 =?utf-8?B?NmhDK3pDOXdJYWtWRDBaazd4aHV2MGJCNVl1RndMcm55bGI2a0hXWVBKWmtm?=
 =?utf-8?B?ZWE0WGtYSWZXSXAzeGs2U2pIV1kwb2NPRStvQWJobm9SbThPYU5DaHFWZks1?=
 =?utf-8?B?NEdPYndUaEFyOGloL3R6MlIvQWNTVldzcmlZOEFRdkh3VjF6SFVhS1FRalBa?=
 =?utf-8?B?Sk1kemZVa2YwU1RrQUxpOC9ueFBZWTNlZ0RWMTlvUFYvR1Y3TUx3c0R5VitZ?=
 =?utf-8?B?M3AxaDNTMVRUN05PQ1JHeHFnZzFCTTBBUDllRHo3SmNkblVSQzlYeDkxWG9i?=
 =?utf-8?B?Y1M0NWlvSmhHdVJrdHJjWHIvY2EvdE96R1R0ZWdrNjJXMzJaejFuMTZwS3Fs?=
 =?utf-8?B?ckU1L3FPU3EyK1BrSWxvS3ZncFkzZFk1RU5WWmY3YlgreEdFYnpCMEFYNjVP?=
 =?utf-8?B?TWRRM2ltL0grMnVqa1BQWjNtcTk3MW55V3dnOFRZOHVFRlhZc0d2V1dHUXd5?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97267c52-391a-4c1b-d0c1-08de16330520
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:02:32.0238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7KFkx/4AFAn+4xsDmOVlKhFoNPm/XsVACnV4OK5k8KmSaxxwgvQwTQRqEPn0mmxcSssuYeoPnCMp74NcxpoAhxLE2oAX5GSUYNegspTIbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6404
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

Hi Robin,

LGTM, with a few minor notes:

- could you please update release notes?

- see the rest inline

On 10/15/2025 10:53 AM, Robin Jarry wrote:
> Currently, for the TRIE algorithm, the tbl8 group is freed even though
> the readers might be using the tbl8 group entries. The freed tbl8 group
> can be reallocated quickly. As a result, lookup may be performed
> incorrectly.
>
> To address that, RCU QSBR is integrated for safe tbl8 group reclamation.
>
> Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>
> Notes:
>      v2:
>      
>      - Fixed typos in docstrings.
>      - Tests depend on: http://patches.dpdk.org/project/dpdk/list/?series=36356
>
>   app/test/test_fib6.c | 214 +++++++++++++++++++++++++++++++++++++++++++
>   lib/fib/rte_fib6.c   |  15 +++
>   lib/fib/rte_fib6.h   |  52 +++++++++++
>   lib/fib/trie.c       |  89 ++++++++++++++++--
>   lib/fib/trie.h       |   8 ++
>   5 files changed, 371 insertions(+), 7 deletions(-)
<snip>
> diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
> index 93a1c7197b26..dffcbdf657e8 100644
> --- a/lib/fib/rte_fib6.c
> +++ b/lib/fib/rte_fib6.c
> @@ -346,3 +346,18 @@ rte_fib6_select_lookup(struct rte_fib6 *fib,
>   		return -EINVAL;
>   	}
>   }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib6_rcu_qsbr_add, 25.07)
25.11?
> +int
> +rte_fib6_rcu_qsbr_add(struct rte_fib6 *fib, struct rte_fib6_rcu_config *cfg)
> +{
> +	if (fib == NULL || cfg == NULL)
> +		return -EINVAL;
> +
> +	switch (fib->type) {
> +	case RTE_FIB6_TRIE:
> +		return trie_rcu_qsbr_add(fib->dp, cfg, fib->name);
> +	default:
> +		return -ENOTSUP;
> +	}
> +}
<snip>
> +int
> +trie_rcu_qsbr_add(struct rte_trie_tbl *dp, struct rte_fib6_rcu_config *cfg,
> +	const char *name)
> +{
> +	struct rte_rcu_qsbr_dq_parameters params = {0};
> +	char rcu_dq_name[RTE_RCU_QSBR_DQ_NAMESIZE];
> +
> +	if (dp == NULL || cfg == NULL)
> +		return -EINVAL;
> +
> +	if (dp->v != NULL)
> +		return -EEXIST;
> +
> +	switch (cfg->mode) {
> +	case RTE_FIB6_QSBR_MODE_DQ:
> +		/* Init QSBR defer queue. */
> +		snprintf(rcu_dq_name, sizeof(rcu_dq_name),
> +			"FIB_RCU_%s", name);
> +		params.name = rcu_dq_name;
> +		params.size = cfg->dq_size;
> +		if (params.size == 0)
> +			params.size = RTE_FIB6_RCU_DQ_RECLAIM_SZ;
> +		params.trigger_reclaim_limit = cfg->reclaim_thd;
> +		params.max_reclaim_size = cfg->reclaim_max;
> +		if (params.max_reclaim_size == 0)
> +			params.max_reclaim_size = RTE_FIB6_RCU_DQ_RECLAIM_MAX;
> +		params.esize = sizeof(uint64_t);
> +		params.free_fn = __rcu_qsbr_free_resource;
> +		params.p = dp;
> +		params.v = cfg->v;
> +		dp->dq = rte_rcu_qsbr_dq_create(&params);
> +		if (dp->dq == NULL) {
> +			FIB_LOG(ERR, "FIB6 defer queue creation failed");
> +			return -ENOMEM;
> +		}
I think it would be better to add here an explicit break instead of 
falling through
> +	case RTE_FIB6_QSBR_MODE_SYNC:
> +		/* No other things to do. */
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	dp->rcu_mode = cfg->mode;
> +	dp->v = cfg->v;
> +
> +	return 0;
> +}
> diff --git a/lib/fib/trie.h b/lib/fib/trie.h
> index bcb161702b49..c34cc2c05731 100644
> --- a/lib/fib/trie.h
> +++ b/lib/fib/trie.h
> @@ -38,6 +38,10 @@ struct rte_trie_tbl {
>   	uint64_t	*tbl8;		/**< tbl8 table. */
>   	uint32_t	*tbl8_pool;	/**< bitmap containing free tbl8 idxes*/
>   	uint32_t	tbl8_pool_pos;
> +	/* RCU config. */
> +	enum rte_fib6_qsbr_mode rcu_mode; /**< Blocking, defer queue. */
> +	struct rte_rcu_qsbr *v; /**< RCU QSBR variable. */
> +	struct rte_rcu_qsbr_dq *dq; /**< RCU QSBR defer queue. */
>   	/* tbl24 table. */
>   	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl24[];
>   };
> @@ -143,4 +147,8 @@ int
>   trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
>   	uint8_t depth, uint64_t next_hop, int op);
>   
> +int
> +trie_rcu_qsbr_add(struct rte_trie_tbl *dp, struct rte_fib6_rcu_config *cfg,
> +	const char *name);
> +
>   #endif /* _TRIE_H_ */

-- 
Regards,
Vladimir

