Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3267C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 12:55:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC304402DA;
	Wed,  9 Jul 2025 14:55:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2686E402A9
 for <dev@dpdk.org>; Wed,  9 Jul 2025 14:55:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752065717; x=1783601717;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8Y0HtPWihek5/89K8mmW0EkjlbQwMmV7dhe6O6LwzEs=;
 b=Bn9hFMRoKiBl9NMF+h/W6eJrIFxYEAEB4m9D44k+SzspzRpCrKL5CpVB
 HrxRt3903ADSzNztVn38HCcOedcdSryvVjyQQX38go/0c16Bd1jSziq9e
 1yML1QlntHi3f0pnQcNeamNd/Riw4WSnplbU4+BjEUoe4lIsKLRlR833q
 vSghL9PCm2GR/aNUTwl9dA8t9mzaXSAMh1r86y0AUsy+QiIVp33+8/EW5
 YHNKJ0/5/iZUIvsz+ZDQSaYyblwSqKqWpvQ5n2iYjvo34gtLdD4Vq32LZ
 J5ZMjLPjQJJtVBH3nX7waefvqrLQEZ0MtlPsn1+dLydqntVTGNBlGNag6 g==;
X-CSE-ConnectionGUID: JqoXJttCSwGlgu+tjUM7rQ==
X-CSE-MsgGUID: exJmyWrQQTiR+mfHbGNmTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="57990877"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="57990877"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 05:55:16 -0700
X-CSE-ConnectionGUID: o5MiUpmMS/C23ZNVMErXQw==
X-CSE-MsgGUID: VKBV0tKWSqO+I+QzbsNVUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="155190076"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 05:55:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 05:55:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 05:55:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 05:55:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4+/eohtC6OS6fPzuFtZm9iVyGHgwDJ80ZvEw67k2lFkdRfNaFxg8MD57ez+jAP/3P/nXjEdidiQ2YO4P0KP8mT0CstDTYiSpI4g4p1S/aHXZfvsDE1Rr5q+ZUQKZdAuDq9Sk8GI0xqvcC9kDW6uyrIiIFBHqnp5QLclkjl7vrH6mwlZpjTD0BG3q1yR5o1Yc4BS+RglY9+okRy5w9PWRaRW2ro34CooqIWmMurD3VCyRQqF0CL8VCxX6GLCol8sZyBA7dSLcVQlhB93r8SkbUMOb8AfydW0gBxHiPmlCwNgG2EvbrmkMrvFfLZdRUQLFnpbjI7roD0jjUB74DWIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seaw4VDv+xVBGU+4J0KB7/JpyrG1pOTALSVidwktBr8=;
 b=vFo7xwsZ0Ex1285ngAi+gHjw8qyKpphzGyHjEon6tTnVCf25YiS0rzF9DUqCewv13R4DvSoNIO6IBX3JR5qfX49/yDmxHtK/SnZH6P2ScsVReZ/XfbCwJLbgHGO8xTmhkrz7QAVGNBb1JBZJyO5LzjeLXBNJqrBPUrOuDXQqddDO5lg3NlZjRPaIzz8lC2qgf8EX3sk19OKug79anyivPPon/adhTBBgYWsEH6q4/AHz+gnPtuX0OOYOeXNuf4TkAvaD1Ou7tx98ZQ2D12aaEMt/8wP6Savux7CjhCinJbFQfbs7k0jVgjZS/MmF4QO9utxHA+j6fWnevtm8d/Coag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9134.namprd11.prod.outlook.com (2603:10b6:208:573::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 12:54:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 12:54:25 +0000
Date: Wed, 9 Jul 2025 13:54:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH v2 0/5] rework EAL argument parsing in DPDK
Message-ID: <aG5mfIw1hs4z9DdX@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250708172039.183989-1-bruce.richardson@intel.com>
 <CAJFAV8wD3BRGYvNdZmnaNauw8qwOpqKn5GmMNEVcb4pema-vEg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8wD3BRGYvNdZmnaNauw8qwOpqKn5GmMNEVcb4pema-vEg@mail.gmail.com>
X-ClientProxiedBy: DUZP191CA0065.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 16da4882-7494-42cf-2849-08ddbee7bbcd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vkt5c0Rvc0FtVi9GaHVaMmIvVlcyM0s0Q0tyazRiUDZzZVF0WmVYQy9KV3BN?=
 =?utf-8?B?L1h3TWZ6eFRKeHZvcEt2Nm5wNXBDUXE4MTZuZEw3QVl3SU1qeHFWbkNDRXFy?=
 =?utf-8?B?M251TStJdkNlaDhiL045WTFRWGRERlpCQVZBcWhVSVgzWGMyRzhCZ0NmRE0z?=
 =?utf-8?B?YklCRlMyMmhkY0llSHQvczFIWFBhVzBqMFVOREVlY2ROcDIxZWhXT01TR0p3?=
 =?utf-8?B?SndaVjA1a3l2Q3FpalNMaW5tRzlXdDVUNTM0SUN6SG54TjBnVFBVblByK3FB?=
 =?utf-8?B?WGtMOVF1MnVLMmNzZnBiR0w0aWlaWUFoaVNtSzlhS1FzNVMwY3ROc1JMR2VC?=
 =?utf-8?B?Sjg4NFZTVXFRZVJOZmVMa21TVlIyUTdweWl5QWxVdHhCdVpjZGVyMVRHejFW?=
 =?utf-8?B?U2gyS0dNMnZWbWk1bWIycThCL1FyRU5XcC9PcXk0WnNDYWVmUmxtUG5mUldv?=
 =?utf-8?B?SzVMbnI4cXJFVjJSZmE5MlVGUkRiZTJ3bWYyWEdzS1phQjRaR3E2RStyTTZC?=
 =?utf-8?B?MzBuQURBVitmaDhMc3RKTmhYVjg4LzM5M0ozSmpIY2oraldpMVdkS0taSXVY?=
 =?utf-8?B?WjJxOXpCZERYQ1hCQzRJd3V3VklxN1UvSHd6dEQ1NVV2aVJYYVVMRDA2cXlq?=
 =?utf-8?B?Q2RqSTlGT1ZPUHpNbmxNbFcxb1B1VDNjK0xBeWNicWdhYUtRS1FpNXlpQ2dW?=
 =?utf-8?B?SEtmc29KMExKdDkzQ3FjME94MXRlUHN6T0dXZEVVU29EdjZmL21lajhtdFBI?=
 =?utf-8?B?MXBxWG5UTzJJd2JyQTJ5Wm9VYWJ2Vk8yUDRnVWM3dE96a0prOGpPZUNDaHNT?=
 =?utf-8?B?TFQxSTQxMlJaK2xIaW5LVGJFbkxkNVQyZmJQeGd4U3RpSFFDZEtaNVpGWVVB?=
 =?utf-8?B?WXIwZjYwV3pobldldHcxUXZ6NEZmd1BnS3VXa2ozOWxkU1BkTVJwb2tSRENk?=
 =?utf-8?B?NEhLRUJGQ1d1T09sVVNyNkIrY3QzRGNrMEhFQm5qVWhYcnlrYW5oUVBxTHU5?=
 =?utf-8?B?YURWcjBhVGJmZkJhS1dQSXdpSTBwMmpSejFyd0RmbWdycGNJVzdzMDFMVnJW?=
 =?utf-8?B?anp4N1JrQkpVUk1DZ2ZnU2lUWi9Bd0NQSnJpS0dZdkxjN2U0SEtrd2JIcmpE?=
 =?utf-8?B?dGY2bmhtTGtQKytmbEd0dHBHSDFNNENycjVlSjFnR2hVNWg5RXZGbjdTZVFO?=
 =?utf-8?B?aXYvdm9TeUoxamtnSkVOV29Iak5zQzY3WGlJZnpXMW9YYU9TM3dxQXZOOFZO?=
 =?utf-8?B?NXJpd01GOUd1SHdPbk04QWdvaU41SVFHWTcvYXp3VHpGYTJEb2E4VldadGVv?=
 =?utf-8?B?eHY5a3MvbGlhY0xNN1dBRmZKODdBeEhjK0V0UWEwa0lMRk5XVThxS09HZWlm?=
 =?utf-8?B?UkgrQ2s2dm0xbDZGN3RQN1ZqTHNiejYyRFF6MXI5VkxFUGVPSyt3ZXQ1SGpO?=
 =?utf-8?B?RkY4eTNhQjFhbEliMDJkMlBSSWVlR1YrbmxDYzZqb1ZHRUxsTVBWSG9RV3JT?=
 =?utf-8?B?bjBWcjdXNmh2Z0oyQ0Jac3VqMHQ2aTVuZFc4bk5qbUdLc3ozT2ZXVnRCRGlZ?=
 =?utf-8?B?NmJ1T3J3NnBvQjF1bHBPd1pBSWlNNDBhWnJRV2JIS0dZdGdNbGdHMHVRVndW?=
 =?utf-8?B?aXRCNGhJc2cyNnpBZmFDdWFiY1pycmpwOEtwM0gyd2ltWXluR3lHYnRtZUdF?=
 =?utf-8?B?WGVhTjNyaXVJSE53WWVBbmJYQkNpVUp1aGM1THJKYStUWjZ2UTBsNmpPUUVY?=
 =?utf-8?B?bkFzWFp2YjkxQysvdDV5RmZ4eDlINGJ2YUZTT1k3TWU5N3RNcnU0M09HUERR?=
 =?utf-8?B?Y2huOTZEOEl6eXlmSFdYeFlraGJLeVdUa2YycDV0QXUvczdBbWczZHltZC95?=
 =?utf-8?B?S1d1dm9LeGRJcWNiSkhRRXVSbllkUmgzajlMV2l3LzlIWG5LYnljaW1HRFpu?=
 =?utf-8?Q?tCvJ8LOXQjg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFdzUlRMY3d2Y2N0WGpqNzN5S05ZTGZSRE9XWXpldXJJS21halBaKzBoK2xl?=
 =?utf-8?B?aFlUazlYTnE4cFNYVnhnSnY1NUtvMDNjSEx5NTk4MjZ0TnIyRlFzSGRJeGs5?=
 =?utf-8?B?OS9oT2ZqYnpHMkZ3N3pvQVcwWnVDTFZONVp0ZEt0OXlKUHBEWmU4c3VMK0lI?=
 =?utf-8?B?cStNRENESHRmbjByZzlLdHVTRkhlTGx5MGlRZ3RHMUUrcFBUR25wa2lZa3Bu?=
 =?utf-8?B?MTMxenRxTjRtY0xvUVBPNHJQUHJGSFJyYnVPci95dk4vVWpRV0ZVRkd3VHZO?=
 =?utf-8?B?S29vRmZubGVjRlQrMXdoNXR3MHhuNTduSEhvMmVKOEdhMlV6bDhueDV6T1dD?=
 =?utf-8?B?NmdNN2ZqK0hyVWV3MHBUVEptSXFZWGh3c0ZOTHQyanpMR0VicjJmczdyR05n?=
 =?utf-8?B?WEdkc01tUnlMZERJVHNXUVRVRW1lUEhJc0tFOFBHZm8rWkhPbmRrWVpZb09F?=
 =?utf-8?B?a0tCdkZpdjdrSnVsUFRzU2JBcXhMVUh4Mnh3cEhOZ3FTTzF3VjhlOFVFMkpB?=
 =?utf-8?B?Y2dHK0lXWnF1YlBTRWFQUUhqbnpsYmQxSzFnUnhaVjg3cE05b0l5ZXREU1VR?=
 =?utf-8?B?RGxxdFF6c2JRaUlFM1hDQkFmMGNPRmRVYUFaQVRKeVA4Q0YrQmlrU2tBSTUw?=
 =?utf-8?B?UWxlSDB3N1poRXJaQjZFeGJTU21YY0pMcERzdnliczRhOVhDY3U3TjlHaUw0?=
 =?utf-8?B?cEdoUHFPWmE0TlljaFkyYk1HdVROTHM5d2JrNHlPVEFkTFpZWDM2eEJIbHpE?=
 =?utf-8?B?NlJLa1VIaWwrbFFZblVid2Rsc2gxQjJUVUd2c0w5UG1kUFRJbllSZ0hUeVBU?=
 =?utf-8?B?R0pYdXFnM1I5RGo3T3Y2cWRrZkJtUDlRd3JETzhBMGRwNm94aFU5M0tyaEQv?=
 =?utf-8?B?alQrVE1kUUY4RUt6ZzlZWjNSTDdSWHRoWEtIbE5DY0dacnB1dkJjU1ZnWjVv?=
 =?utf-8?B?cU80VStuL3psT1c2WXpaUXNyOHBrQzgwWXdNQjlaNUltNlRVWVRLRWYyc2hi?=
 =?utf-8?B?a2VuWGtrcXdpbWt1b1RJdjlxOVE0UmJlQTVFZmJubEN2RkhXeGp2U3RKRnVp?=
 =?utf-8?B?cTlPd0FaSlo2MzNjdnB4anlrV0U0OGtUcE82a3hhcTBQZVJVcUpyVTdTQU4r?=
 =?utf-8?B?UG9vcDJQemtDR0crV2hzQ1BEQjBQSmFjeGxtbHVRUDZlQ1FQZFBsTkZrK1Ji?=
 =?utf-8?B?WkMzMjJmcjlXQlE3amFPS1dRTE5mREhqRFJrZDdVN2k4ODFwdnNVNVVOV0Rj?=
 =?utf-8?B?a2pMR1VhbHBwUExnSjJpeXd4dnJ4V3liTEN0ZDFZOEVsME1TZmFnTzFnaFB1?=
 =?utf-8?B?NGlEWUh5R3BzUW0xb3ZHcDQwanYyZnhiUzdoTmp0L2E3ZzM1OEgvNXhpdURB?=
 =?utf-8?B?Y01MTGdlZm9zWGhuZDZFV0dzZDRidGtmS2tJTzVqTXJ1a2ZYV1RpaFNVWnZI?=
 =?utf-8?B?S1NyeWJ0djFEWnhvWldMQTNaUkpWUm1tbjRJNCtIeXpMZWd2VWVGNVYrQzBP?=
 =?utf-8?B?NkRMK3Jpb0JmSkJaUzRHOUp6Wjh4aHdmYUFrSnpLekJwUFh0RjFLNVVkS3E3?=
 =?utf-8?B?a1JzZS9HbU5pQ0F0WE1QQm1LTFA5d29ObG1iSFcxRUhZcGxzWkNZaUZnNCtU?=
 =?utf-8?B?WXlzSTdNcXpIWFFqTTliSXB2czNQd2pnaXBialZYcEFMRWc2SjU5QTFSZTRD?=
 =?utf-8?B?THZjYlQzdGFFcXBlQVk1UDR2U1hyZkJLNDBWbmVNQW5ZcDl0WTdzQm9haXI0?=
 =?utf-8?B?akk3WmIzNFlFOTVQZkJaNW5tR2NRWGFSSXdpaG5hajM0Yk9xMmlwOEJDSFpL?=
 =?utf-8?B?QW1WUEVJZUpORTlNR2JUQUlWV0FwUEx0MG5kRUZLUFp3dE4xazRCZXZQMFIr?=
 =?utf-8?B?emJxMWNCK2x2NDRoZVM5T2ZuaTRxUFNWU3BMUTY4VU05dEFlTWd0S3RZY3Ur?=
 =?utf-8?B?RW9CS0sxanhOOGRST1FEaHR6Wk8yck1PVnI0SUpxcWxrTXNOZzliUituZTZa?=
 =?utf-8?B?QnplcmR6djEvZElWVjIzbXNQSjJLTERPcThld1BJdlJ3V0VEc2lnRmtwSDhw?=
 =?utf-8?B?Y1VaVUxnQkFiVzIvTjdxc2Jha1lNV2dtUjY5THN3MDVSQ2tvQzVzWXZud3Fi?=
 =?utf-8?B?LzdZZVdJbm9CNHA1S3Q0dmQvOUNXeUNBZ0pGRGp1YXQ3WFo4Tk9RT0xvN3VI?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16da4882-7494-42cf-2849-08ddbee7bbcd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:54:25.5220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p37L5BhBG48e2obbeAa655xBTfvc90zBnI6LKytP7q9gk+2bAryfJmq4vf6O5gHqDseWeSVHaRIH0UxZhvwf+lJ7bOaHLymgQRHqmFY9vqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9134
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

On Wed, Jul 09, 2025 at 02:30:42PM +0200, David Marchand wrote:
> Hi Bruce,
> 
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
> >
> > Bruce Richardson (5):
> >   eal: add long options for each short option
> >   eal: define the EAL parameters in argparse format
> >   eal: gather EAL args before processing
> >   eal: combine parameter validation checks
> >   eal: simplify handling of conflicting cmdline options
> >
> >  lib/eal/common/eal_common_memory.c  |    3 +-
> >  lib/eal/common/eal_common_options.c | 1236 ++++++++++++++-------------
> >  lib/eal/common/eal_options.h        |  101 +--
> >  lib/eal/common/eal_private.h        |   11 +
> >  lib/eal/freebsd/eal.c               |  164 +---
> >  lib/eal/linux/eal.c                 |  384 +--------
> >  lib/eal/linux/eal_memory.c          |    2 +-
> >  lib/eal/meson.build                 |    2 +-
> >  lib/eal/windows/eal.c               |  113 +--
> >  lib/meson.build                     |    1 +
> >  10 files changed, 726 insertions(+), 1291 deletions(-)
> 
> Thanks for working on this topic.
> I will review it soon, after v25.07.
> 
> ASan complains about this series, as some memory gets leaked, could
> you have a look?
> 
Sure, I'll take a look before I do a non-RFC version.

However, I'll wait feedback on whether this is a direction we want to take
or not, before I do any more revisions of it.
