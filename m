Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8BFC021AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 14:56:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7723400D6;
	Mon, 17 Feb 2025 15:56:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 223CE400D5
 for <dev@dpdk.org>; Mon, 17 Feb 2025 15:56:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739804211; x=1771340211;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=giyLQ0k8qCHLJNGtPr1yGM3P2wub0Ty8FMUWyobNr0Y=;
 b=akSsahBgxu68rTWdjbAouRq1vSA2TUD6NJlPjG/5kFRahGSprmbGGn/4
 FnK4NbSus9ffqsPyWRWkL9YulgLn2Usz4ELJ9C48QCPt6v93WS1dBRJVw
 p2aZnEN3iUVVxwTPhrq1XEQ2bSYpLTK3h75lVQF1rPQ4q4Y9oT/ryKgLD
 9kuvczoCZk3bmyIgEKmLlpONyZxoWDlJ1yjBHH38Q04B26++1YRCdHf8U
 GSXLtn+CsbSyqlx3HxNrx9Wpn/ZI37Qc42joCdisTD+qORkbAFHyqSPH9
 Ci2pk/MfUFEQKEfp2L8Kz9pBaC1hfPOs7iIzpVnqoUNGSoE74WX2+ZOew A==;
X-CSE-ConnectionGUID: oSke3lSnTf+lWEdEQd2BiA==
X-CSE-MsgGUID: HybsGfDgSE+XGtwF+OK2dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58016880"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="58016880"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 06:56:50 -0800
X-CSE-ConnectionGUID: 7OoJEMb7QdyU+J9qooPv7Q==
X-CSE-MsgGUID: XCPPBtSYRv6oTGeC6+92Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="151323297"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Feb 2025 06:56:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 06:56:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 06:56:48 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 06:56:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozlOgG1076gzRxCEJUykZVpOfE4/quxr+i/KRKTRxLzu7SG1BKaYj4vYQQSwjqp9prZWixekqPOLOyUe2vCv59VOV9fG3fn3Y3jZEAlLbSfN6kPjAWxUeY9uLDvDrNnnXSLlQ9JAgKw+NegWCXVFyFL3eUpvVJpB11foNT5e1LvFEZ4RZ6dZfGsyhptWQoN6ld68vgVWyAEhzQA2mDaGVsNleI1ZDiNyCGNDvD5zPnAzNX12UFpsnQ2uoBAaIvIeGyDJP+5VFOH7SwNbJrsxXESohATNKv0LgzY/KXI73N0IwEy1Kgqffj5sKVAu0qc0UHHxtKnR52VY7cBN1Uo6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gmXNyxEfgVfK4gz7ikJG9KdoRD6GD7m26Q2HKXCAgk=;
 b=s5ZI2JZoaIKQ16NN6De5c1dvNDytB0az/PdvfEALswBdIJLp9rumZzyqpW4PGQ9CoqV7c/OuO5lJ9fJ84jwrkKrJTX51KhBZzo8262gbAZddGU8VmuOioV7yCCKUjMy6tljFUolLpYl5yioAfdIlDQpVnESbchR16aEEsrAnTzPrCBrI6/aBj0iSHzcXYldGnAcUgxLSi4ZnDE5RXixIj6TWtQlAOpLUUPl1Vb7NabL3Y+tNaZapisXft094qqI1He0Xrz3ZZ9lukJ/ySBHIdJtZ5bvNuleLg8NFsI3WuoMTz93THiyh7fFN3CdN4CSzLBwC/ev7Cr5hVBx4xMb5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 14:56:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 14:56:45 +0000
Date: Mon, 17 Feb 2025 14:56:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] net/i40e: reduce log level of global register update msg
Message-ID: <Z7NOKKsKQPAMc9Ag@bricha3-mobl1.ger.corp.intel.com>
References: <20250121163539.2308702-1-bruce.richardson@intel.com>
 <CAJFAV8yXqN=nmnqc5T7Eyt6KeVJOisk+MCadLxzjoLkjS3n48w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8yXqN=nmnqc5T7Eyt6KeVJOisk+MCadLxzjoLkjS3n48w@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0280.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 859320c6-528d-42f5-3347-08dd4f634bed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFBELzgrOEtIOGNVTjRDcStqNEtiOEpRQ3F5UkxZWVZnYnVURkpnNTVIcXY1?=
 =?utf-8?B?U2piK0xTQzF6ejkvYVBqbG5JWlVTMnhVSkplT254bU9ORVJFK1ZZcUNDSVhx?=
 =?utf-8?B?NXRzZlFIbFFtS3JBbHZCaDQzQ0ZRYkc1dGcrbXJXbnFsN3d3U2RTZmM5QmdV?=
 =?utf-8?B?M3Qva1VhdEZSOWJVWHNaL1JNU21zZXRudVhyUmV2TW5iRytaNFBScmttMllp?=
 =?utf-8?B?QldBa0tLS1BzbG5LNkdwL3Y2WmJqWjZuWUhxUGhwZytXVUx4Vm5ySFowaTQx?=
 =?utf-8?B?Z1MxT3pQcjczWVVIWmIzUGhkekVHaGRXbjJqNnEwQkpZUFFIdVBBYUM1MHpM?=
 =?utf-8?B?Q2wzdWJ0alFDT1FoV3dUeUdLRVczK2Q1QituNGk0eEg4TFRoa0VsTitWQnJJ?=
 =?utf-8?B?ZlBiOXJWVUNDZklFOWJ1Zi83TW42NTFpcnowVEFZa1cxcDh6aFRCWXYvUkdL?=
 =?utf-8?B?SWI2YUMrUWdPOEVOeGRrZUU2Yy9pN3BOS3M2YzZUUEliay9OQ3Blc2hmUlBD?=
 =?utf-8?B?YnlpZ3IvTFo5ZVpBakRkdTZJMEo5VlhTWDFYKzhlZ09WMk5aTnFpbFpwNXFo?=
 =?utf-8?B?WXNzSVpiZ21hMnVkK0ZnL2pGUGFSakprcDI2WkhWVGxjenVlb1IybWY2U2hL?=
 =?utf-8?B?dE5HMWMvdGRPTHMrdlBiYzByaVVmcSswbXhvVC9ENHIxOGJubG9ld3VoR2RJ?=
 =?utf-8?B?M3lqMkRsb1g2UVpPRnhJaVM0OFdSdXJmc1NWS3JGR0JTYzAzeHVoYk5wd2dB?=
 =?utf-8?B?U1FXQ2hEZVFsZnMzcTgvdVR1TkFLRDBTamNZSGM3SEFkNlU3NGFqaTJpTTF6?=
 =?utf-8?B?dmlRQTllK1dNZnlGSkNQL0l6d3JJK3k3NjZnWGtLUy9nalNSUXc4bjUyNjdp?=
 =?utf-8?B?cSs4MkdqVU9FT2tYM1ZtNUpZSjl6Z3M5UG5XUGpEZ2xhY0Y1djJua3MvbmtF?=
 =?utf-8?B?SGVqQkxpZXVBS3dzTnYwbmlrbVJuRlA5bzZ0RkVZM09Jb3ZQNTh6Z2lUbEt6?=
 =?utf-8?B?UW10Y3ZpUm0zUWlFSkpmRkJSQyt6cHNyMmY0QUoxMFlPc2VUNGJ4ZGs0S1lX?=
 =?utf-8?B?RlVJMUh6L0FqNkVmUklOaU9Oa013bXhiVjg1ZjJPTlpNMHpVSGw1Tk9WYW56?=
 =?utf-8?B?VDdSVndQMXZiUUtZdVRBZ0kzS2ZlZGRabWZSVTRBbXFvV0lEMlIvWVZQTHdP?=
 =?utf-8?B?L284Y3dXZlVieW1ZY1cydnEzeXBxVGhpU09VS0ZOUmZReDU2YVhqUldQa2k2?=
 =?utf-8?B?Z0hDS0N4L0VqbysrSWNwL01DU2hxdEd5R1Z0dHkzU1E0QW1mWnBFZUdZWXFV?=
 =?utf-8?B?d1VrblNFYmJGR2xWYTZNaEhpNW5oQ3NEemkvblNoeThyU09WaW9RNTZLUU1P?=
 =?utf-8?B?RTVBWHZYNTRxVE9jeDNSeFp4dVVSNGJ5NzhaZmh5MllYTHZ2R1ZUdS8vMjdy?=
 =?utf-8?B?MDlmdlZlWUIxQXpwTGEvTlJ6dkdidE1sZVc0Y09wWUc2eFU5dVFnRk9HdFNi?=
 =?utf-8?B?bGJSL1FKeTNNRmlpMStQNkQ4MldLbE85NUNPV1ZsQ2VvTWsrZTU4OEJSQWN5?=
 =?utf-8?B?WjlUb3ZhMDYvUVQ1bEJ5RUJsUkw0UVlldFNxd0RJNGtmYmhvVHVXb2F1SjZI?=
 =?utf-8?B?aEIvNHF6OWhuUFYzajRQNlBldTVrK3h0OVNpL0twZ1pESnpLZEthUGNyMzNW?=
 =?utf-8?B?cGpiYStkK1pqM2N2am9obUpEZi93cEF0c1BLNFQyaGZoTDQ5RTJBUHdwbjg5?=
 =?utf-8?B?UllOc3RLRFZ5UkRoWmxUNjUvN3FnK0grS2JGRFV0UWpUVTN0RGlOMFd2Zkhy?=
 =?utf-8?B?LytPaWlrMU9vZkNHbm1pSWdoTWFuREttVE93YXpmRFNGN0I5a2JvZ0o2N0hi?=
 =?utf-8?Q?t6TNlDx/QkSZ1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmJoanliMWpuaStyMEwwY1ZxZnZmMEJPRzV4SGw3OHVmQzhmRkx5R0JnUmpZ?=
 =?utf-8?B?YjFrMWtNODhOZlRuaDYxdmhBNzkwWEthY3pWZFhRSER1aTJSbFFTVDhJUkxY?=
 =?utf-8?B?cStEZHpTd205QVJwS0p1SnVhZDl4SkVUMGVzaSthSDhhd2xvZTNsZExLUGRW?=
 =?utf-8?B?aWxyeWt3Q2dtWmhHQ0tuTzFrUWZGWjY1QUJGcXBlQVdrQ1ZDTUZGSTZoYUxn?=
 =?utf-8?B?OHUvb1N4Tm1mUWtIWEdzdlkwQjRwVjFTQXp3WnpjYWw4RFBMMFhWNUZrd1Fm?=
 =?utf-8?B?MzFDZVhOVUllTzNiSnZmOVp5RXM3WjdpNkpqTTgyOHdSY3RKTHJ1b054ZXVQ?=
 =?utf-8?B?YVVqdk83aXpkYmVvTHprNzVuQmI4RmQvaHpzUWg4MnViVUpvbUJBK0xjSURp?=
 =?utf-8?B?UW8xam9oSmxQNWVlY1g4SmFIWVJCQkxXRW9mUnVjbFp3QjhYRml1U2NzZ29j?=
 =?utf-8?B?Z1Y0TmZyZ3ltd0pHTlRMcUQ1TTI5Y2lkWjIrZ0tONGp2dzRIWHNBTE5PZEtn?=
 =?utf-8?B?czRtdnBsaW1WY0o5TXpMY1R3SS90Y0JIbW8yU0ZhM1ErMXpRQlhGYWpEeUtZ?=
 =?utf-8?B?ZlFWN2RFWk5Ya2FvVFRBbllLVW91dGNwSUNFdTRySVRDcVVhbEVKZmRsekZW?=
 =?utf-8?B?Q28rTitYTk1CWFVGUHZmcUo2ZTJhMFFSdEFHODAvVk41UHZCQ3JlY2NTc0R6?=
 =?utf-8?B?cGQ3WlBSVDlVSG10WFNEQW5vL0VOekVWSG51UlF1cXBaZFVlVXlFVGp1aU5a?=
 =?utf-8?B?UEQ1RkxxQkREU1RuMU9JMzlXRTAySVA5SDM3clNGaVpJUW4xRjZuTjJqZ1Zu?=
 =?utf-8?B?dzFRWkVpRE5LeXBXWlpmdjJyNlJFUlQ3ZklRUkRrY3UrdTJVTE1Wam5teWxS?=
 =?utf-8?B?MnB6K1dyTGgrQTZHTktWbW5Yc3o3KzFxaXpQeVluTmZ1MjkwTVR4MzArSlJN?=
 =?utf-8?B?djU3TjVzdmJhMFdmblV3WVVHQTZKT3gwUWhwa1NRY282dExFa2pyenhvcXFq?=
 =?utf-8?B?emVYVTFtcnVVMEsreU94ZFpIWGZSVFhnQTJteVM3bHV0dGhDK1g2YVp0MXlU?=
 =?utf-8?B?MTNndXpJN21MamR0ci9VS1FzRUxOUHRwR2JnNUgzSW5kRktrV1czczdPL2dF?=
 =?utf-8?B?N0VNWWdSaHBoUXFFSnRZR2tJbm1XRE9CeENuVXFvSTBKZVNZeFJJMk9DVTRP?=
 =?utf-8?B?SXNlRktXUDNPN2VLZmxNVXVFWXM1eEowYjFzZ0ZxQUFCWk10UkI3Y3lnalZH?=
 =?utf-8?B?Q3pnbW44TFBlbm1icS9XajVESXhST3RQcnFVRWN6U2t5dGgvMExBb291d2k1?=
 =?utf-8?B?K2xISG5Wa2tnQWtuNE5wZ0FDOEFxcGFaZU83SjU3c1RRbldvbnJFUU13dytM?=
 =?utf-8?B?SVplQkpSSXRGUDlSRUcvc0FaOUQxR3BMQ0Z5aGdPRzNXb09rdDJTQjdjd21q?=
 =?utf-8?B?SmhsWFd4K1lwUllQOHdTM0t1ZUw4SllBTko2cmV6WW1JMkFuYmVqK0c5aUsw?=
 =?utf-8?B?OXZieGoxdzdxbE5tSUovdkYzNHNFSGY5cU5zYVFYMzVvUUIwTlpETk9Ieldt?=
 =?utf-8?B?Y0JXLzhlWnQrU0txenlkRVhKMTBQbit4SnI0cDQ4d1dHejVPempyb1phNDE5?=
 =?utf-8?B?bU1RSVNkNkhoZzluQXhUK2N4cGpBRDBlQklDUmJ6dXFKd3R4Y29HTlVIbkxy?=
 =?utf-8?B?RFRXai9oRzBwdjQrSU9BbnJPWVdnNEd2VHlWaThBQ3BuM3NUbEwxU3QyQ25y?=
 =?utf-8?B?OWpIbDF2aWlpVGg3V2hvbTNXTWN6MjIzRGwvQmpTRzY5TGErM01Ja0JoZ0tS?=
 =?utf-8?B?VTZVOXNkdVd1Y0xxZHQ2Y1RJczVjTHpidGl2MmtGdW10VUsxSHJ3bWNKTlp1?=
 =?utf-8?B?S3Q1Q29xTzh5a1dXTkJXZGdCMUs0UGxaSndOQUNWWmpDUk1CV2lxTVhSYWpv?=
 =?utf-8?B?cEZlbG5DbDRqR2UrVzdQeG9rSENkN2tNc2EzMUxiRVAwdDN5dVJLeSszSEl6?=
 =?utf-8?B?QWtXRFZRajY0MEZZc2k4L2V0Q1E5ZE12NnNjZjJRTktjTU5CRDVVM01CUUJn?=
 =?utf-8?B?NEk3K1Y1ZllocGM2dUZxOE9oQ25abzFaQ0liY3ppdFZhSEs5YTQxVlg2alJK?=
 =?utf-8?B?emY2ZUNBZkREdC9Ia1dqdjU5OWNuTVgyTDlIVzYxWFlOR2UvdFVxNVo2N3Ft?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 859320c6-528d-42f5-3347-08dd4f634bed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:56:45.2135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TDZpsp9kr0mrjMXEQ/KRjmDbZeku4CXnFNqnaAYgfBQdz2m1SJJmPdnvLE4DMmACIwHNeS3ePgPeUD/RRtggfmelewjR22FwXYMUQi1U1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
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

On Tue, Feb 11, 2025 at 02:57:21PM +0100, David Marchand wrote:
> On Tue, Jan 21, 2025 at 5:36 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The modifying of a global register value, which has an affect on multiple
> > ports is an important change to HW. However, the actual details of that
> > change is only relevant to developers and not general users. Therefore
> > reduce the log level from "warning" - which implies something is wrong -
> > to "info".
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: David Marchand <david.marchand@redhat.com>
> 

Applied to dpdk-next-net-intel

/Bruce
