Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA56EC5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 10:10:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9945B4026F;
	Wed, 26 Aug 2026 12:10:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id B5079400EF
 for <dev@dpdk.org>; Wed, 26 Aug 2026 12:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787739010; x=1819275010;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pt3YLPLPNpUE43KiIFw3juX7VXHbhzWEq0rtdd7b/jI=;
 b=RCZY2UmBiwODckLag3j2RA/KLjhhYZLIRote3rkFP75YeXvOGqiJiA5j
 ZKRYrupcCsnoNhkIp3p3bRLpPpx3PCw7RjF7FswKyuLkAHUOy41kuy1HR
 8caYWORIVEQKRLxQt58+prolzPxFeiTX/VKUkINf4y9VHIOuTj6TKXInJ
 M8dkTKTktaq0kHyU31JmNcl1skfV6pUGXtxcOWoJc/3lLhsZCgX+yWwIx
 PfXOhl19zqzGduqIItkq9H/0du509xWlo6X2hRsaZRpCcGPEZXLBeiZQ6
 Hx7PGuMhgJF76bZKtfb55qWitUxc0n7dXAunkqjubvwTVzX7K0zT7D7lV A==;
X-CSE-ConnectionGUID: Yn8X62KCQt6lv6EB84P5aw==
X-CSE-MsgGUID: xjGf4MNBRyWceaVAiha93A==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="92079292"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="92079292"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 03:10:09 -0700
X-CSE-ConnectionGUID: aLz5xNxSQDeutyBlakniRQ==
X-CSE-MsgGUID: 5RH4kBGzRfWZ4kNJtJWc5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="291062874"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 03:10:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 03:10:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 03:10:09 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 03:10:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vL83vuBGQfdg8lX/1g7imD3zKafpt6g6TuNBX53ttZtjs5aq6SvtE/IA1/CYQLht6MmEvUuXDPjWJIYEl9eZvdYnKERIUZQB/JffTrLs9dcbK9iD/FTc8kqNWS+K4E+NGlc9VbNhumdmvaYIjHKX76LdxOSw9ww9nOaa2z2ubyDT18JV8LfM3y3zBLrACezNQueNqeppXdPFsPB3ePWQUeAsp5Y3RmH5fnEYyckq/vd/8yYGJ/NO1yw4UP+i0J2QljxZe5/3WOjjFwIxXfj0vAPnaxP3rIeNJgFHAEUY9x7+HiSAn3+wc2oLUXDODguzA5iMB3frLD04p5YEW902uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6GPSj/9GXaS8l/OjevrtykQg6bxfWkKMQeVwLZ/2mQ=;
 b=La1aEbn0YY5kWmby/+GBj8UqvCz7MOjbMiv2KeYN9h2YSHAKofHyrQcV2mjVLG2Rua/onn20H/OkdYqw8c97sPcoRZCKaK1wt9Zyew/wz3ow0os7XfP1bPYu7rDRZclvWcGUhAaFgN+lCNEEgQp8P+blli7qUW/U5XCoEF8FzJXLK5AUy7Koo6ISQmWH6D6bNmW3uMryHWnE1mZQN9YKXB3ajOWGuHsImTY2y4fnvbXRQNRp2WLzZzjzsC1NYg/uyX213LVOAW9ONrVkhsA5Gwafx5ecltOciYomfkZB2OUPO+2vU4D7/WemQ23nEm0DlOZZFGfwUlVhDOzj7ydAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS4PPF409BB8CE8.namprd11.prod.outlook.com (2603:10b6:f:fc02::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 10:10:01 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 10:10:01 +0000
Message-ID: <54c83772-a87f-48cd-b90c-b79df701cba3@intel.com>
Date: Wed, 26 Aug 2026 12:09:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/20] Support VFIO cdev API in DPDK
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <cover.1787663786.git.anatoly.burakov@intel.com>
 <20260825071754.0aeead6c@phoenix.local>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260825071754.0aeead6c@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS4PPF409BB8CE8:EE_
X-MS-Office365-Filtering-Correlation-Id: d78ce5db-615a-4417-75d1-08df035a3101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +xDkqoaKBp0Bzyipp/0bh5OelJ2+BCeB+jrGK9P7GIOS+gEHz+TW7Eh5c+DIa/ia2YvACLhYwDZlnfNR8g4CoLJp8zZ/eTswrgaERc4pBgpKZxna8rqw+2PsJ6+TSnnJIsI0kaEALNNf4VKzPPXCc7yQgnJ5q6pRce6ECgLHKPohK++vuW7K6RHb3jcy1aKTStqATnOTc//xgC+h+KwCzaYBEkJl4GzY0pVMXY9aGMgETu1jcq7emaKFU3+ckXr1Zq9kN+DlitpNvBVmbW1hdzT/cbQa9jt7m7V08SCecc8SyKB7R/LFX2jOk7ZCrYpcb7cDOXkFCDZe+InSGrXkZ90UK3fmedLb9Z39kdFdb0UQKTOCVzU0HuYr5ozOcF6GsB0U7ZOrCBYlhxFpfzZpBlwaW5Iga/0y7HO7Itx6+qvaNUu7Pnj5SMN9iNaafAKFq9UZIZkEunjXRq52W1YzgAyKgjIjlkE+nj4aiuSoRBwcCQs9sf9U/5vW8YY9kuDqIXmMAeEK8UQg3yoTU4bMV+kwZctwWTZltOBT6ckYLgPdjzNsuGY4gdez7ZJA5Ls4ZTHhY7c4VIkBRA6BqnZM6gB/7vxYBCxN8CQGTNFdb7MwH2Eq1hnq55SPR5OOCQdtHYKTZsDRuIG6O1dqBAc76oBlyrlhs6fvsbmAk+VOPMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2o1WlBzMFU1ZUdIckN4RUJGSkNjTUdxVkZDeFdvbVlhbTdqS00vOEozVEdp?=
 =?utf-8?B?M0VpbFFRVWUzTUQvT1J3djBJZmpCa25iWldjUkpTUjZVaXNDU1ZIVkFlNXJz?=
 =?utf-8?B?OEpleHVtdFdxN015TTN0MGp5Ly8rZ2RoNXJ6WG8zV21yVEdMT1dLYW5hRUln?=
 =?utf-8?B?NDRWREE2b0YvTjZCYjBqM3V5d0doeHlXc1kwRWlRU09PUDdyc20wdmFtcUpo?=
 =?utf-8?B?cXZKTDd3Z0tzaDEvdGRROG9TSjFRV3BNOUtEL2Y4bXNTZmJ1c09TQ3d3NzAy?=
 =?utf-8?B?ZWhNVGVzc0FNUll1ZENGL002N3J4M3VPa0hmOGxhY3hSaDVDNHhralJoNUVR?=
 =?utf-8?B?Nk9nTi9QdklWeXdBODNUbEhvUzQ3UjEzOXdueXFQM3ZncGJWZkE5M2RrajVM?=
 =?utf-8?B?MDk0dGFrZTB6S1A0WUFhQjFRWlU0dEZlbDN6Nk5OUGZXMlBxVCtmUDRBME1y?=
 =?utf-8?B?c2ZnZTJ0UmhCLyt1QjZmbHNzL2FLTFBzUmQ1SmxiU2NUaG1sU3E0MEFla3Nv?=
 =?utf-8?B?bFFWNXBoUjRLajg0cmRVMDk3SGhycnBvK25mNFQ2NXplckpBeVVFRmlRY0FM?=
 =?utf-8?B?T29Oa2ZibXRYaHloa1lwYzF4NzcvRWJaM1czTnFDc3lXVnBuNGs4bnJLQURi?=
 =?utf-8?B?OWZwSkhraUNUckZRTU92cU1HQ04xR01FQjA3WStQWmMwV2xDZ0s2ZGl6ejVU?=
 =?utf-8?B?MFY3RThWc3hYL3ROZWNVbW96SU5DN0RnZFcxWjhlSFNzbG92NlZ6T21OcWFB?=
 =?utf-8?B?dHVyN2hJS2VNdU53ekh4TG9HanZoUjQ3R0MySy8xNnBHRENkRWFEYjFtMEdx?=
 =?utf-8?B?Rzl4cFdDem9ISmM4WUhtcGNzZlgvNWdDa1ZxWE50RE85U0NuVG5OYXdIZHlX?=
 =?utf-8?B?YjlOS3dLYjdrNmFiZmYxSUJ3dnVMZmpWN0VZb2IzeUtINjdZcHVOajdpWGtR?=
 =?utf-8?B?Q2N6MnhBNUZTcmJSZWdhNXpsdCt4VnZDUjhSblh2anlGREFQd3gydVV5ckdy?=
 =?utf-8?B?L044QTJEeE8xa29SS1VkSzA3TEZkME04Q1hNQ0EySGZERDQySUw4dURnenpp?=
 =?utf-8?B?dHM3MTVMWWtkdU1qQWRDUTVZMU42NjUrTVQrMVJ0MmF1TlBibmFkQWQ2aStp?=
 =?utf-8?B?cGE2RDkvN1BGWmdiTXpPdUxjZzJuQ01oUzM4cW93MElFeURDSm1iV1RoNUZ2?=
 =?utf-8?B?VUFDS1Y3NmJVNWNuTG80QzJkcG9NQ1ZSdWUzTkF2MVVXVndYRzErZUNxUlZR?=
 =?utf-8?B?blZ1RkhKVEEwSk1VekZGSEVmWkpRRDBRTldOOVhxbEtoWXhNL0hvNnlvVjdv?=
 =?utf-8?B?L25YcnRJd0JySjgxOUZXamJEUDdjOWdXdFQ1S0tXYjY0dTM3L1dVWTdUZThC?=
 =?utf-8?B?NWdQMWFuZ3p0K3RMUlNSaHlUK3RwWmVrT1hCTDBnK1lHZVNyancxNXNWaE9q?=
 =?utf-8?B?OTRYY0hkZldpUnJuMm9VZlRqMHZWZDJZWkoraGJpOFVvMktVNk14eXU4QVNq?=
 =?utf-8?B?eXRETlZVVlN1cU9EUmxtWFZxOGJKSG5Yc2VyNEJEa1BRbXBzT1ZoTnFhdHFB?=
 =?utf-8?B?K1FsRnZwUkhSeVV4Tkt4QjJENjcreThXV3o2WC9ZOHN6amRteEdLODUwUEND?=
 =?utf-8?B?WGRCS1FMbGk3MmhGSzRCNGloMm5ZcFRzdkJCQmVNZ3pMMFdOaFJzUlFpRFFU?=
 =?utf-8?B?SU1FODRITlRQcloxV0pCUU90aVEyUUY0dWdVbXF4aVVFK1dpU20rempRdlNi?=
 =?utf-8?B?MkNkbkVyOHVRb0dLMG9hdnlJMEdHQkI5K1UzM00xOXREMEVqUzNYQkt5Y0ZN?=
 =?utf-8?B?cUY5Kys0RnVXSEZkbDZJUEJRUlFCZ0R0NkJLeVVqa2ZoNWEyNFV4TVJnRytq?=
 =?utf-8?B?cmNzN2NFRnk0Q2dOTjRNd3VwYW9HeUYyRk1XOUV6UEQ1SHdjeTVMUjExdDJ2?=
 =?utf-8?B?OUtyWEtWVUlmRWJVZmZyWWtnM0FVRDVJTExLWlg5aWNzc1pLaUZUUnhkYVI0?=
 =?utf-8?B?aFMvYTFoc2UvOGZmUTFBUStpU3dUa2Zub05qZ1NNY2VHQlBYdVl5eVg3VmVG?=
 =?utf-8?B?MWt6MVNFcGUrRFBQZ2ZZZXEvaEp2cmU5OE5yR1c5Vi9MRDZVTXltZGlVTmtq?=
 =?utf-8?B?WDZYd1k3Vm5BL29aazNPUVVROHg5ditVTEpmUnNQU25iSmxEMUtRUnozcW9w?=
 =?utf-8?B?bE9SbDlpdWJ4cCtrYjhtWnJXVkNGTVAxVzgzMTdsSURXMWpCSlZuTkZsTlZ3?=
 =?utf-8?B?M3lWaTJBWms5Z2tUbXVMVW1DeUhtQ0lPYnVEMXRqUU0zeVZ6RlNjYnRVWHZu?=
 =?utf-8?B?eXNCNXczSS94TGk0dE5LZE1KRk05amNvQUNtSWRFa1hFN0dmQ0hYSEJqRjhr?=
 =?utf-8?Q?Ujhq4J6wM8EceG5I=3D?=
X-Exchange-RoutingPolicyChecked: teKCBtnRdX9dFevwgB6MbgLd8dS4WAQBAhR58hLCnJhTfeQsT3KrF67kfVerzlde8vF6eYFVOzl4lCKZV70Q9XnwOhoX4SVKsp8VqN2wXTBvAe3TAaE8vnRJES436B1mfposRs0kk/NeYq7QbxWFIToGuvA/oz994wNHW2H5DkG43MT05q4emgrvu6EHZS41BcaONHF07lhRpN6JVkayf5yMRKQtCNy1yA3phSxtD13uvkr9U4J05nYf+KbdsfvWqodtVdtIXxDYyWhjUbyzu4DLmcmwmlmlT6PVzTHVcQRTDEpY7OSxTAPwfvS0TLqDXcIXZt1TfuIkOQIqHGPgGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d78ce5db-615a-4417-75d1-08df035a3101
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 10:10:01.6103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZCabsU2lVhocUdpSKBGXIsavsU839bVIASQiBnrP0Z/1yHQ/l4R31J85AXLqaixE3o2ThvVnUCaTSDWiXWdsfeY0AGrFuL9BzY49zA/1+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF409BB8CE8
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

On 8/25/2026 4:17 PM, Stephen Hemminger wrote:
> On Tue, 25 Aug 2026 14:20:57 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
> 
> The patch series in pretty good shape. AI still has feedback but
> not sure how important the details are now.

there's still a bunch of reasonable feedback, so I'll address it. Thanks 
for the review!

-- 
Thanks,
Anatoly
