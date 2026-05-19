Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB89ECD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:30:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD42F402EB;
	Tue, 19 May 2026 18:30:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id EE7DC40296
 for <dev@dpdk.org>; Tue, 19 May 2026 18:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779208215; x=1810744215;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fPh7fzpaxiqPOvrwFiuw4qQJipZg2c4ySjHEJ16P1aA=;
 b=HMQSqKAzK4vZkhYuMKSJrNE1dlQXOnrF2JGV0OzIjbWWCK+K7EVSKe0z
 JwIQy9iiy6HvTSSbKx35L9nzfNyCwVxlTSo2oNrKMudUpQt3x9MTg+CZG
 v/0ZHFRdx9W9CX8yyCj2lnKxpvnGkXRF36oom8FiQ7A6gNmLesGtg3j0u
 ceNDDI3RVElBHf4UjgRm97L91wSu3D66TtKOnMoE/PaXB2XzBmJMbBHZP
 /NG2ckAW2WjOLAaHcK5BMWS5ixlbTcphx9Q7NXKyJVowRls1RZ6MoM8TY
 VSOJBGd/8LVyUO4UFhvTYKmR+T+rXmRVDKP05850rFlLgXdjNWDOzQ8yw w==;
X-CSE-ConnectionGUID: 3Kxuxx9sRme/RWcbF9IFKA==
X-CSE-MsgGUID: sZD61hswRZeP0567iMfj2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79239431"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="79239431"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:30:14 -0700
X-CSE-ConnectionGUID: 03bsRf3kTBuc9H2P27GvSg==
X-CSE-MsgGUID: XqJSM9bRTWS8iXoDsV+ShA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="238827724"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:30:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 09:30:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 09:30:13 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 09:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/OyaRQV+oiTMSZfzI+aArUN4ynGbIIU420w7Mn9bJlniRQHoz5zzMDyuXZyxIhv2bAnO93zqws+tmE59aYh/gJmU1qvaLDuGkuQI+NRWbKTPBpmdEbU7JES+FHPLV3JcsZZ5I6gHO2ZMBsQ5qj9SAm0G42GMb0sEqjHvliNd2yNydid/a8uoVj78N3cCiLo1RLVgadRloLrN2HqRx6i3H1s2BHzxL87Gx7lhrv3t1+rLEShe49fXCY+aO67SdtQcvUMt9L2z/m0ky3cWzpiXSAaUTuW4w22WsNgnSvNhsnZbTR206BRQEQtxVd1j+Gsbqwsg+k1jc4gk9wWC2sGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6tZa9vpfjAHDmHjBX9xP20vZUrWzs695cI4dqA8nLU=;
 b=Vdjrn3mZFf8U9sOIuAiukutAMwtsWtp6hUHxi6Ien6rJmn1Abl/g66Q6Bt5/OV0wFKGyoJMjpQJr7l++TpCc5XwPYwovdVZWlGMoAzHeT7JMpc0iBQaFTXms7OKpcI6g3uobtdp5oGKbT65MClHauftrqPgZ+c88gpULZ0odryDejLdH4OIhT7M2iOGIEKG1lWsUXNNWpFfuVfQyCUvlKI9SMrPEzKDiGG83vYR5TwquJqAJ5b6TVgtbDQr0MPY2YhX75szqh6GQLtEkVeggvqHgsmpgxRveRpgaxbemGtibcq2wk8Umwg4uUrhcg4ysEYfk54iKyzaP6SYZWLEiNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 16:30:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 16:30:10 +0000
Date: Tue, 19 May 2026 17:30:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>, <rajesh3.kumar@intel.com>
Subject: Re: [PATCH v3] net/idpf: harden PTP frequency adjustment
Message-ID: <agyQDS58xbijmWT7@bricha3-mobl1.ger.corp.intel.com>
References: <20260407200405.1568940-1-soumyadeep.hore@intel.com>
 <20260506204134.18634-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260506204134.18634-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB9PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f4eb9d-fa6f-4619-5840-08deb5c3e53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: Inj7+vdLGzo+WeekvYkroluAOXCdrgWF/mmwmcR2HoP8iQF55MWhApD5O9w9pfw+UowWgzYfAzuQEM2EFTwWWsEpHFTIS6E6zDUNul3zrjT5o6xmA+DLM+e32ZyySe5UxrCY3Cc4JVpjGD7VDxfGitoOU4xNv4gafctlOxw6YGysAEdR6CX2F7tfXh2Ya8TI+0i51MZh2Myuah6k3jueHyxMqyKj47hDJ9wt/rSl3o2h/6/PCKHpDrwJpL9vzfRMibH3ow4V7wNJ8fWMUSXMEAsUVPalRRJbbwW1nSkVSs591bXSA1WoLUam/LpcWUSPNAkKQhQUrTuHvBWOozkMefKz1fvG4CyOgKQBvtloWgai4bImOsz1aVwNsS9zWeb3mikKdTAvUq7Ed/u5JAVHmLpFBjp969y+5bZaEs3EiJbRSE8jX9UsKHtt+4I3EUaFfBRztkrwOsSpUm/Gv+Z4iAEVwZXPKQsFmPFVwTkg3D0pNv2PuwiZLzDAFpUpO19j2c7LXm+zPRbmAWz05XNVF008OyZ4v82PnWtpnO0lSz9ag1BjPUupfF7Zp/ZDNLgYHr68UQBPkP5CwEeLksagPrPMQvwcq9NnNlH1ZyGFS52tCJ9qANEgUaPvtTGe23Mi2oxtuYFfZgkz4DR/hFqGysr8dhC6ptkaJjpynsGaSAJS05Ng1WMoBCLVaiWJNsL5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9DQbAtKKUJT7aeay8NUUkn/ZRegWjhsWjzdu/p34aHUJUGADtEVT0yPAbZ4K?=
 =?us-ascii?Q?hxVQvFNbk2f5Dihngy7rdvSHlF8RZBzUbYuU0Hqh2B5x980AwsohvaKalReJ?=
 =?us-ascii?Q?u+hy+f8FxOI4YPiTmXi8Un1o+vwVGffh+i/dNksHPOpxgo7LiRFuRWu7y2uz?=
 =?us-ascii?Q?GHVo9H0hGw/CsMosv7qPtYBiB4OM7BYQm91H2r3+fKTrJZwYExh82QGRuSnb?=
 =?us-ascii?Q?KVFKiHHhd9aH2J1DYy7PfNPePZANgw3juXlxJM32Rgf9NGXSKdSDdNBJRXLc?=
 =?us-ascii?Q?iKDTbOW3L3WzNmcGH72+K2VGw96GF6w2T7iUy4/4mko3phl93+Eujqo7wT6c?=
 =?us-ascii?Q?SVfQQiWz21ul2gaxJt93/XycSsmPvrH+O1KmY+zq7bc9vSpVV90su7505kz7?=
 =?us-ascii?Q?vfjBsKvSIMAOdLclMDuiPGW5w8QlZyKLS8XBQh7s94nmfnL3DYQI006+8C6w?=
 =?us-ascii?Q?WXlKqRfzTB/rhp9YTxipbpW2ZulYXCsc+AledB9ZUsi/bf7VP7mxwQESt5Cs?=
 =?us-ascii?Q?18+jWvfhqancvTaC7NPsbMtfB/Z3swEQdxJS0qo/lVJ/1psg7X2T0pGepRqB?=
 =?us-ascii?Q?UZTE9i9rjA1y6dpWPMws/Xt0/uPwnAQ2iZCzdptSw10JI2OrRd07hUbaqi0m?=
 =?us-ascii?Q?DZSF1XhlZO9tVscnJhIihZHHdMvvU3fJZwxRN5PNHvqOHR/n7W1kkhj/fFnZ?=
 =?us-ascii?Q?f9Vr9qHCBGox8js9ZvotzapOZWD/9e33riU2PXL2KZqbXGnH93g8LSvumMcR?=
 =?us-ascii?Q?PQLseoRYohU5qCbRnuPGi5ZeXpCuDZc12GM/thnuSdQGhgJZIB7z4nBdxq08?=
 =?us-ascii?Q?qpQUL08uSuz+Jh6MeFZgMvPH2x1xeimBhChWgrW4/Uqr0Plq3GoLGjKLv//m?=
 =?us-ascii?Q?neF7l02WNnEumKS31ZqnDe48AQVhDTk6Ceew6DuTDSYis4AIZgLe+3ZarlkX?=
 =?us-ascii?Q?6Zw4mRIhswvtavRjaiTCD3XN41oqsKQb8IHgEpd8SnbVSEstpsTOXjA2kESZ?=
 =?us-ascii?Q?CQrAlXfDVty4jJBirC/cEhNQxPUYoJfGGCYAKfGeCbR8wuz0AS5GiH7aeI3X?=
 =?us-ascii?Q?ZLgUMF4iGN/G9wHjCbUxAbV+Ff28KjFjuXC+a7lSuBejRQOi/lMHcICwJael?=
 =?us-ascii?Q?jNx5qIr0aQSWsV52nZvy/Ckg8xrBN2EVhNqYqacXoDt72KvYp1Y6xFUg8bg5?=
 =?us-ascii?Q?hdYkXEIVnj6TNmbKr1t3gY654eIXW+N1GNCRIUhO3jVf+RcuMUdwjhRECdMW?=
 =?us-ascii?Q?CDYE0cBXr9uORTDFLlgWuJWwbmqyQDosJ6hE3D5kTge53jyUgZZaiRfIEv60?=
 =?us-ascii?Q?/M8/I5cF2H/jzoFvPNXkE8RwkApZ7WkBKaCl01aO0JtFH5Fo6UmVLq/Rtilm?=
 =?us-ascii?Q?M1gPMc5nPBj2sZd3j7fW1BLPzOsKORJkMMlxaf/3ZkSfj9Jl+V6gDD03Lvy8?=
 =?us-ascii?Q?P3UMq+INPrm1ab+kpsgbMNr8onogs+LLra+flCfKw134AvBoBY+/nbwxLiCs?=
 =?us-ascii?Q?+v4NjEJGyZ4hWtxvIx9TjMA6RKCEpgdoKeyaLyOkRRWF8UIRGo//vxFm8Oey?=
 =?us-ascii?Q?8qTR5U+fiWwo8PUAVGlran/O1i6GtmWfPr6Doooty2G06ZWlCp1oA8MEa5s5?=
 =?us-ascii?Q?2EqA3/0nvOUlw2mGH15sDvL0GaUzuEfvOOdZVIAJFjmwLol9B39ie6XsQEWQ?=
 =?us-ascii?Q?LauWwaCF4FEZW1B60G7bqfGNvXbVvSqB+Enib8O8FeuRVrmHIBfHdY+BIAKt?=
 =?us-ascii?Q?tHid4VJRstgPqRT1UFV7j5UawpdOaKM=3D?=
X-Exchange-RoutingPolicyChecked: kMX3peUGRHRjKzYb6vkYoc4Ke019ojjS1ghJIHLG0kD34IDclxDZO/NXO/AfCJ3z6aRvPBYdu74zEpjKqEGoblraiG6xwYpxk5F1eOvWbBsSJnwYTXAUdXt20eTLRYWo/dAfY8KNWSlii4hhT1mrMHrVkuwBuIwO7kaANY3BUDIGrc1f1IfHa2ir2hPM7nzgMOer4WEpjXVmxA8INj2fp23efQY7vnyN59JYUds/roi8Sl7lyfL/6WB6eTHDvkKyctlhk+7C5fvp2VqdL4HPSrKqYBqM5rlB45dOjBAeTX7qpJvbyZCwDBTSGRCowSm2yH0kcuFqE4asz+L0aCKxMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f4eb9d-fa6f-4619-5840-08deb5c3e53c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:30:10.4841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txwjtc8RUrWtH2Er3dykjpw3VpYdfzNV/dN4yc25Hv+IH3HFbv6gec1BYM9L2cUdgx7r/r0dymJduK9tU/5UCaQwzIJHTTkG+RaJku6JqJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
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

On Wed, May 06, 2026 at 04:41:33PM -0400, Soumyadeep Hore wrote:
> Use the direct __int128 calculation on 64-bit builds to keep the
> frequency adjustment path short and readable, while preserving the
> portable split-and-scale calculation on 32-bit builds where __int128
> may be unavailable.
> 
> Both paths avoid the INT64_MIN negation issue in the original code.
> 
> Coverity issue: 501832
> 
Fixes: 1c6e2737fd3e ("net/idpf: support timesync")

> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel,
Thanks,
/Bruce
