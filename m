Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A32CCA476
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 13:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 620B6402A8;
	Mon, 13 Oct 2025 15:12:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id DB2314028C
 for <dev@dpdk.org>; Mon, 13 Oct 2025 15:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760361174; x=1791897174;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=a+hHGjJsaTvQgb0o5FM8bFC2X7E3WI98uF3virsQXNI=;
 b=Vm0E1Sitj+Z/m45USaDyfisGhLwnOu/FyuI7Pxe8RwmheYn9QUo/UqOT
 IuA34G/roc5WEJnkchzzhUHsxL2YPp8qaaKIL0u06kckyw9Gfj/Wh9Ugw
 +rpzpkdOhPOenWTDBaRWUyVFOeA0Qom8wA6WmVf/PF29bf6Iv3crV18Fo
 O2+ucM4tyFVDaNbBKg5U9QRNd3HkdF0a/kg2EM54NTaGY2ZJZu7cgZ5z8
 WEAvjt4/r5f7Kt0ASFC7al1cZCCDrjZfOPSgDMMia0NRUCFRY4gcxbCtD
 xueE4lTjXwUDs1xlC2pCLfJznzzaoSWY9mzznt8s4HiL4aE59KfA9dpba A==;
X-CSE-ConnectionGUID: TIwpNLTLQJOG8IZN182wcw==
X-CSE-MsgGUID: AYNnGE2ET62YgzVBfh6gJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="50056394"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="50056394"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 06:12:52 -0700
X-CSE-ConnectionGUID: QuHZi8/0TiO3SXc9052kqQ==
X-CSE-MsgGUID: V/BBwXmZTFSb72PLmp8+HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="181169324"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 06:12:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 06:12:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 06:12:52 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 06:12:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soaL0OLAEhhXRUI7GGDgD9nUsTqXzA2gwc7jyVpdXrHnQO+JwbLbMQnc+7DlmDJ3xvUjlR+6qpszUpLX2Iy+Po6yfDaEzyjik1ryT486CCO4phQOqimUA5W2OLG8+lfOIZJnHgkILRCPp1oG+aFitMiNUzL4im6p72Xema010YBLUUek6o7CnMAH7sViBq3aM4Ta/2AIT0ShjuoOnU0X552jVc6P5llwlfXuO8VQC7V7mCKhzQUfQBXzZy+LGNsXpYxOCGJwjzflo8f+dMDqznNTlVc6xI81PVCyUDwfhog5xCKMjS3j+TLofYkoM5wcLKBBDHccpE8ueioBQCYTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQNyPXaBrkCgaWiserEI+o6lyWnRZ3rhqbfMhLBjkwE=;
 b=v8M4bVah5AGBAFrbdr9vSh2L1Ct51N4qqUVm3ObNaKSTH/9JxSX34aRAbEHBB/PIaB1fBSnIgB+sVpdORwMX45xi/blUQbIO2QotnakHDfVo8Cd0oKl/4G8PuYTdOb5KjqaKt4Qb5WUOxU41nK/KYcYuXJmsBI2tZR5jIegc18nS5tunlCkzWMkhlu3VCGgOT1aauq/Naoq9uj8ZnFAA3zRbqig5MChvGcSJaOjVm4KrDGfmAimQzyJDUCXaF+m0ZsmJXjuPjxDRZFiKtPcA9MCst9vhJdq83JCyriVDtSnawvS+cfbZHBxezccBrOBO9yYJpR7CDpIP1G3Lb1zo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB8361.namprd11.prod.outlook.com (2603:10b6:610:172::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 13:12:48 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 13:12:48 +0000
Message-ID: <ee355946-16f7-4876-bc05-65b4de5b8185@intel.com>
Date: Mon, 13 Oct 2025 15:12:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] eal/freebsd: Avoid claiming memseg holes
To: Jake Freeland <jfree@FreeBSD.org>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20250814213246.4141803-3-jfree@FreeBSD.org>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250814213246.4141803-3-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:10:232::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a814f89-7b87-4476-f1f0-08de0a5a34d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkd5bEh6dVBOVUhwc3RjL1BETVhkSmdrYkhsZ0dLdVNPSlpwSUNNUUFFSjEz?=
 =?utf-8?B?TVBnaXcrVDZKZmFkWmtzbUMyQzVWR1N4b1pMWFJLNzUvOUw3UWFIZXVOZGNt?=
 =?utf-8?B?enZjNVpCS1FVTzdneVcvdzF6alpoR3BXKzN1VUZGMm9CNnY3N2FXNkFHb2ww?=
 =?utf-8?B?bEFyRUNxV1VDWDErVzRUU2k4dStyTWc2dkxSdTArRzRjNFBLN0svSzZRQ25n?=
 =?utf-8?B?SGFzT3ZSTTlBeDZFdEpQNncyRW5FZUxlQ2o5OHdHdTJnUmc0ZUJTbDh4N1hn?=
 =?utf-8?B?dlMwNzJBeUs1K09RckYxZkMvdmhxT094QTNUYktrZFo0cklOM3Exc1RJZmhh?=
 =?utf-8?B?dTQ3MytNdjZpZUJqRmpHUVMvcUFWaloxaDdkbjhyZEhxdnNlcVZWeVNGZjlh?=
 =?utf-8?B?blYxSmRMWnQ1d3QzL0gzd21iMkpaTEJUcGFwRzFyaERhOHMzT3QvM1JzSHBE?=
 =?utf-8?B?UDB0VkM0RmxzVFoyWHVTVi9Ta081RUZPMFErcXlWbDJhUWVnT0V4NXZPcXNl?=
 =?utf-8?B?dUI5amVPTFh5dEpwRlhTNytVT2plei9EZDdXYTJ1U3dLNm42L1NsdSt6SG5o?=
 =?utf-8?B?UEFhU1FzVXRFRVRkMnVBS0pvKzFYdzJRdk1TeExMeE5Sd2ZDcnhtWDd6cVNN?=
 =?utf-8?B?bWFENWlYOUl0VGRob1hPQWVpSGZhTVdIYWlveTBQVEZ2VVMvaTdOYTNjWDJi?=
 =?utf-8?B?dTIvZ1Fnb3VBVGJJMkFrZXlYM2cxYWJqaXlFV2h0cUphalBlVURCYi9NSFJD?=
 =?utf-8?B?RDZ5bmxMdW5qbmxldHR1SHJ0Q1JQK2pXSzJuV2c0b2JWUllYRkVBSmhaczNi?=
 =?utf-8?B?cjRuYk15NDRDOWtFV0JtM1RYZjZZNXJmUmVuZlVjYXhKN0doOU9iUTlzYlFh?=
 =?utf-8?B?L1lwdlZTaUYwWXhKelkweEZhVnhOZjJiRmFwVTF3MlVpemJKbU9WbDIzN3V1?=
 =?utf-8?B?N3ZlazZnbGRRdVY1WHpnU0h5ZnhKQmRTWXVWbDJnclRZbjlWQmpaWU5tbHdt?=
 =?utf-8?B?TXVNbUFoWkE1VS9neGM1RW1iSmpBL0hhL2FaUm9YN3AvQ1cwV21tZnNNdGJG?=
 =?utf-8?B?RDdZdCtXcGdBN3pLOE12aDkxcTRpV2gvTEh6QWF2WmpOYlhMK0dISmpIZkNa?=
 =?utf-8?B?SVFNZWJLeGU3Rk9MZ2h5eUpuSnZ2WlpNZlF4cnB0Q2t3Q21KTWQzb1NJWXMw?=
 =?utf-8?B?K2QxZ3JpSm9rUzNCYnprVlVaTERMMHFvWnQ1LzVoM2JzTXNzbDJ2UXdPNzJO?=
 =?utf-8?B?VUd1WUlLY1pPdEdMOFB2UkZLY3F0Z0xMbTk3QTJBSVZ4cEVQK2UzLzM1QjZu?=
 =?utf-8?B?U0I3RXVjbkFscEE1a3drY3p6aExuaVlIdDZkY2F0a3J6LytsU2YzWmNFVzVy?=
 =?utf-8?B?eEFNdWVyUy85V3IvYlFtZVg2MThxaWRCb2dqbjN2Vi9nK0d3RlB0ZjU4Y0ZD?=
 =?utf-8?B?aXdnRENId1ZNVHkvN0tnMFc5bkQ3VDJXL1IrV2xZLzJvdnFqNjl6ZStiMU90?=
 =?utf-8?B?MkRJM1dtZis0NVU2dGxDTVRMekt4NHdNZWZ2WWVWanZIZ0N3V1FFUW1EeXI3?=
 =?utf-8?B?bW9uSC9rVUhyWS9hamVSNkZzQjlDaUNIVjdjZTJGL2ZhYmxaMzh6M0p2cWd0?=
 =?utf-8?B?VEtQb1JhdEcyMk1iRTJpWWtQUjc2ME5IcStLcUdoTWplZUR2eS9nNEtzMXA4?=
 =?utf-8?B?K2ZwblNDQ3hsSi92aHdQT0ttbzY5MDNYNGVra3lHMkNNbHc1M1A1MVdTaUhh?=
 =?utf-8?B?VmpTZjNXRnBXMXNDQm5xNmwrYnQ1UXRZaTJzL2dVYVFSa2VIOEszSGdpU09v?=
 =?utf-8?B?d3gyYW9vVVZSd0pTTk4rWTRUZUxQSHUzaVlGODUxQ0hBRHUzdTBRdnBMNDZS?=
 =?utf-8?B?RVZzM1RmSngydXpWY2JLQVN0TUNsYmVNQUpBd1B5ZXEwVTJkUXR5M3RSRzNI?=
 =?utf-8?Q?1FTbpz9Fih40EAFSO5RiGOM3nlzP2Pso?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS94aDU3UHUvYllYeGo2RGFpSmo2V1llOU9INWpnQ1YzUll2SWRFTFI2bXk5?=
 =?utf-8?B?K0ord05rbzVsMVdjKzJpVDlMTklhZUlUSEE1cVJyalFUaDRvYSttTVMrNkRU?=
 =?utf-8?B?YWl2aVkyUmx1VXc0QkQzMDhmaFN3TkhNM0hHMG1TWldGSG5iR0s4ZlBXcGtp?=
 =?utf-8?B?VENwbVlsZDZZaWIzWHBiNDhrS0x0Wkt5cS9zeW5VdDFtc2tSSnB1YUR5SUR1?=
 =?utf-8?B?ZitRRzJhMWZ0UXBNRkFmeHViYkxCVTh5bE5iL0l3STMxb3JWa1FpUFcvQjU5?=
 =?utf-8?B?akZEcFA0cHBFZm9aV1dVR2NQUjJoUUwzaDlwODE5eXkvVVNVbHUxcVB3Wm5k?=
 =?utf-8?B?ODV6UmJieU14SEhaM2pRVkp1Y0ovMkViSy83SXlCbm9qOTZabnZhYnRsOTJ5?=
 =?utf-8?B?WElNRnpBcER0VlF6M1FzYUpWQWJLbnR5cG9zcFpld3dTSWI3K2ZPMC9aR1dO?=
 =?utf-8?B?NjZXQXFOWStzelZTOHZNWDFVR0JxcXp5RHlXNGd0eVhiU2dHaHNpUjNvTHk1?=
 =?utf-8?B?eUNqVjJDYjJ4MTA1TXNGNmNBT1RhTkh2THpIU2FGTmM5SlJxZk9FNDlYbGVD?=
 =?utf-8?B?eTJWVHpKcmkvK3J6NXI4T29WSHJnQU11Ym9ZOW1mS3FESDYyckNDWXZlQXJP?=
 =?utf-8?B?OHRZelU4czF5NDdPcXVObERNa056dWk0QStSQXpiSVhSVzZVMmZQZFpDdTR6?=
 =?utf-8?B?SCtwdGNXaHhHZXdLUE9nSjlnWEVVR25lbmxuRGhZMC95MEprKzZNZ09PWmxS?=
 =?utf-8?B?RUpXSjErbFVvelNoNFdRUitQaTd6cWU3QTZHMlFQekxuSVdsRzFkTDZuek1P?=
 =?utf-8?B?SWhuVWdEYW95YXZPK0cwd2ZyL3FzaUYzYVJjTjQ5UDZUVDR1TDFha2lXaGVz?=
 =?utf-8?B?TGd6M2E2UGV1Yndrd29XMEltMzVsWDJaUWpWMHhMY0NVZ3lRMjJ0d2hrNEx2?=
 =?utf-8?B?V2Y1dkFvUG12eGExTTFNb0M4TWh4SUZFdUFqc3VKaVJ2L0RqQnBpcFRROGpJ?=
 =?utf-8?B?c1JXMkxNc0hUNHB1Y29BcUtnOTkwM25YT2Y5RmhHL0RRU1M4TXA0VjRMK3Jn?=
 =?utf-8?B?U0FUWW1zL2o4clZEMWNLNkxRaERveUxOTVhlWUoySGJFVHNVUXU0WVhLc3JE?=
 =?utf-8?B?TjUzL1czVENOeXM2blFDQWlnNXNPNkJtRklQdUZDRHcxbVJQeHNFZTVXTktq?=
 =?utf-8?B?S0YzSjV0cnJodWNwZkVsM05qTzczYWtKTndZTm5rWHY2WTg5N3E5aWhXNmNw?=
 =?utf-8?B?QnY5azZiQ08rTEppWVVtK3ltWVR1bThHanVOMXR4dXVvSnRERVNMZTU1dnUr?=
 =?utf-8?B?RGdEZ2N3ajRKNlpKUXovRnlCYWlucGdXK1RIdERITTM0WDJuUEU0S1VjdFRi?=
 =?utf-8?B?Wlp4M0NSK3lwVTY1SkszWFdIZEZ4cC85eU9BOEZ3c2JMNFgrb3l2ays5SWJi?=
 =?utf-8?B?UkEvU1U5bktXM3Q0RVE2ZGRmUWJOUkhpMGE4LzNUNWJWQmRQb0ppbkowOTZT?=
 =?utf-8?B?Z2hHZUJTWkhwSng5WGswTkowSEl5SGlaTGhqZEVEbkVZWjRLaWhXVzA5UjU5?=
 =?utf-8?B?RXpyQzZ5czN1WDVGNTREdGNxUnZKNEhQL1BwS29ZdjVFZmJPNjBpWXQ5TCs2?=
 =?utf-8?B?L2xDT0ZWalg2TE5NUjF4UC9majFvRU1HRW1ma3A5YU9uVzl0RzVVWHYxRHdZ?=
 =?utf-8?B?N3ZNa3puNkJua3RLdW16QlFMLytoaFZRTzdvTlhVUzhaR1NFWUsvYTFMSTh4?=
 =?utf-8?B?d0xHOU05RFFuempIUG11cEZTb1pTUWozOXN5ZUpHVmtsSzFIYzZkZy8vd05K?=
 =?utf-8?B?VG5OYnUzWTdRYXJKamovZHd0b3VEclBhMkZpUS9XREduSXRQa1lmYlhqNnY0?=
 =?utf-8?B?V3E0R0tORGUzM2x5RDFEVkV3ampiSXI1T293NGpHc2RyT0hpdUFobVpkS0ww?=
 =?utf-8?B?cS92clJrRWdYMmFGZ08wSzMzdGs5UUNhWGRBY0F4LzZZMUovaGJvZjZXMUUr?=
 =?utf-8?B?cTQzNHp2UVJBVEsrNGIwYlNXQ01FNS83WFRuWnZiTUlXSkQ1ak9tNSt0NnhL?=
 =?utf-8?B?cUpOVklYV0lqNndrOVdpMkpvdVkyRmJ1U1N1aUJIVkFHWHBXdDBpN3Rob3dz?=
 =?utf-8?B?K1l3NGdGZmhsc3JjQXBpTER1blg5WTdPODNRNlYvMWs2ZksrM1g5VFN6VUpQ?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a814f89-7b87-4476-f1f0-08de0a5a34d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 13:12:48.4917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nyX4ruw8/64yjD1rZafFsv9qC7c91IIfVGQ+xbMBFxW4p1UTUrT9QYlvSfaH50bS5+gJRNc3YOfAHWsZf6iFeOmVf6Er43ehBxBF7AkvOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8361
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

On 8/14/2025 11:32 PM, Jake Freeland wrote:
> When need_hole is false, memseg searches will only be done for a single
> element. If the search starts at beginning of the list, an element that
> was previously reserved as a hole may be wrongly claimed.
> 
> To avoid this, begin the search following the last used entry. This way,
> we ignore all pre-existing holes.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---
>   lib/eal/freebsd/eal_memory.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
> index be3bde2cb9..b159e9ef4e 100644
> --- a/lib/eal/freebsd/eal_memory.c
> +++ b/lib/eal/freebsd/eal_memory.c
> @@ -143,6 +143,7 @@ rte_eal_hugepage_init(void)
>   
>   			for (msl_idx = 0; msl_idx < RTE_MAX_MEMSEG_LISTS;
>   					msl_idx++) {
> +				int start_idx, num_elems;
>   				bool empty, need_hole;
>   				msl = &mcfg->memsegs[msl_idx];
>   				arr = &msl->memseg_arr;
> @@ -157,10 +158,24 @@ rte_eal_hugepage_init(void)
>   				 * adjacent to current one.
>   				 */
>   				need_hole = !empty && !is_adjacent;
> +				if (need_hole) {
> +					start_idx = 0;
> +					/* we need 1, plus hole */
> +					num_elems = 2;
> +				} else {
> +					/* begin our search after the last used
> +					 * element in the list, skipping over
> +					 * any previously placed holes
> +					 */
> +					start_idx = rte_fbarray_find_prev_n_used(
> +							arr, arr->len - 1, 1) + 1;
> +					if (start_idx < 0)
> +						start_idx = 0;

Actually, I think this check is largely redundant, because even if 
find_prev_n_used returns -1 (empty array case), we immediately +1 the 
result, so it's always 0 at a minimum.

> +					num_elems = 1;
> +				}
>   
> -				/* we need 1, plus hole if not adjacent */
>   				ms_idx = rte_fbarray_find_next_n_free(arr,
> -						0, 1 + (need_hole ? 1 : 0));
> +						start_idx, num_elems);
>   
>   				/* memseg list is full? */
>   				if (ms_idx < 0)


-- 
Thanks,
Anatoly
