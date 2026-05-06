Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1321DCD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 14:39:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E22F24027E;
	Wed,  6 May 2026 16:39:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 49D5840278
 for <dev@dpdk.org>; Wed,  6 May 2026 16:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778078352; x=1809614352;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4PMj1k36mtBCKWKoLgR6Zfj+WJ294podJ33Pn13bmLw=;
 b=EXhkiwnJszjjc5GJhPlqPlZ6mwQNs88OknCD4XJKe0JMwYIuxDGbtT1i
 KqDgq3xAkxnP4qrpSWCz9Pbzym7q0+gJuFKQi01coAZvEy96zdUhpj20q
 JbW5Ysh4U1vt1PyBf9tU2HMBs0isad6vmDV30txN3zLfQgJ1YT5utLQuR
 gX67WRA936TZDER4w6Xvd9qbomWRrVHswkV0kuk0PoRITv6NUSJfZVlWN
 7AztINXy6Lgf3u96NGeKlKADtSMTxFzsInb7hjU59CFykxnviE9jjoB8u
 XPY37LXIk56rRn78mh38V2rIWiQRbQv99hZejBc7Xj1a9mh+Z5m2cSL4S g==;
X-CSE-ConnectionGUID: UsT6Dh4QSRqrKBKBJV+9Xg==
X-CSE-MsgGUID: nAXlam1WQcmc1dLLJQ1P/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78729627"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="78729627"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 07:39:11 -0700
X-CSE-ConnectionGUID: QSrg68tWRNaAUjexFKYIHQ==
X-CSE-MsgGUID: jKYIQDPeTJGibXE02Kr9BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="274294591"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 07:39:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 07:39:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 07:39:10 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 07:39:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByeAWLt2O3oKt3X/oSHAcz10tkPhkWmcVSJdc8YQeiV5TlkIznLfU+otmnTQd4sHXwJraAS+3BLO3RAr5F+C0t2zr0KO6GNmMERuoQvcGcfj2Mqjit6nGBvgmsWVWf+JRa8g4KOLMhEk8/nnULtiE2q8qV99FMGevAVRMys1ii0pAiNICAcn7byQxjjhm/00RMw9A+Ctvixww34sRlY6gW38YDbLWOMBCnkOg0ytrFCwqjP/m+pMNEfjoiaa0M6t7wo0KtbRtlyZCU3VlRXnQOpmCeLls+3BLt9eV2c0pBewuza3wuLEfI4+rR8IiBQTN7P4ZlIt8ZlY6vsmNCYdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fReHKAHOoaFP84wiHpqJYuXqyVBDk3zVIxo9GSWIpaw=;
 b=giSy00ubSOqsZqArR+pIt0CCAEuY3J4LQirgMidpTlgQ27divwBio7aKpizR3jxCKZuGdt1GQZFVPwdp2LRLKXoPHqdQF0LruQN6BNjcIcAFnN47nIyyAOu1M0xlWM9/KIf5sM/QigJVS+ojPT0i7cr9V38IZ2b5eCOKAwFmCxA5KyehoDb97J7q+FyHZoNW5E2qnJveqbhWCaNBKTmfFPHPE+cnvzzKOXoHimDQRXvJuD+AMNScRBwWF4aiv7OLmMXRaqbbvo0ES+GWlJ8hy86FmRAJsfV1p/s4Ij7QW93dkDGLM3EGthHCOl/pUyd+dl2JZRhGECpV/v/DPy/4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8326.namprd11.prod.outlook.com (2603:10b6:806:379::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:39:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 14:39:01 +0000
Date: Wed, 6 May 2026 15:38:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/iavf: add support for QinQ insertion
Message-ID: <aftSgP5bvXSfsHw7@bricha3-mobl1.ger.corp.intel.com>
References: <20260430085813.230798-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260430085813.230798-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU2PR04CA0315.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6914d0-203a-4877-14bc-08deab7d3715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 5Mg3wmCYw+J4cIWUG6kGCK+tbD2bS8CPGJXPpHmtF889r0plVzPdL4M7xEBRH9xo72Z/E6Igiflzoqqpy3RNBpD+ymDoaYdU1BeB2deJyLp02Bm9YVeX5aNT37TuMFDAyC6tfGwkHzTgM92Sf4dNHQbNO/NnUIBpvT7iT75mrwohYrpi+3xPFDiVNr6gcYsBSH29NBIMX6yMGLX/ES2LzgNa/h3ZA2V2fqDcTWZFZf44yMen4o5Qgs9Qh8HjelH9Qk6Q62OY8xzdLcSilsHkJaXDJx53hHOCybGryt2QNs3ivn8uGVb/YW/YczoLNksh9FWq15nsM9mSU3wBtSw5bSY/Y4FwtaPk2jznfoH4hqRl7Gb/gcu401sspfTZBCi67Pz/15bUPQY7vXqZP93kqltU2KiirebAAL1/aGSQCB96YSv7P56cG6SUnOdKHLEXkjwpZBdR62YyeekyLS5cdx+QtyMsC1K7kZBCJP7XKcTJ3F8EEipuLVrvx3pUsqB3qEbPTIVpYOjqqGNqX+7xyB7ba76gQj5k4GJV0syttJC5B/Smk38ntnu0TxBVwM6x8GsS/10CdsP4pY9IqGEuiDomY8j26IZ7P7S8e2r3PTmS8A5/uduGx8L93Zgkq/0W0B9nQVctt/wFpPfnbhw649c8xPaKjODcPo4KjFl3caKXCH2rIEnbbhnFo1SCAsDt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dpQrLy9oml+7IhMTcBPKXQHCzAL0aFTHzKg/WNEA4mODKF5DJBsT98g1E1Eo?=
 =?us-ascii?Q?QMjVc0rXPyPagqWos2FHyJtGFXtyK8E3bMm5MfHoa/3g9Ek+jRvpDHbfFcpo?=
 =?us-ascii?Q?kHB3zZgyZzZpOe5z5BZOF2BuC4WvLTiJPV49Iu1u33bOnLAzhmHESZCY6Lm/?=
 =?us-ascii?Q?xHVLaKmoj9aJbPTHux/Oqjk58ctZ80Pk3TEHO6jaGl6l4wnagIsp0l7iUefF?=
 =?us-ascii?Q?MzgVJaqdYgpbZfdoNXNuQ+MAs4H5jkRL9oOIYh3spZ8FGWJsiG2Fr9cJoW6I?=
 =?us-ascii?Q?663GktFKTL5f+ugs6+6dV+sIY1bQOfwnhPBZSaXzMff71w5S/CMX8k7pKwTs?=
 =?us-ascii?Q?JhemqrC9pPcrv6cOiShETX8LdREaWdFVfJr7dLbiNOz/9a6aQEc+CI4LNpH5?=
 =?us-ascii?Q?wMjgydstApYU8TP0GT5tKAAR9KdLrUyiGhaJ3VeRVhKRAnIypk8h2KSJlyHV?=
 =?us-ascii?Q?8o9rq3BzfUtd65S8Ce/tDQ2gWtuv5Q9abHIiAbk82ejudUXNqNcbFSIpCkDp?=
 =?us-ascii?Q?DMYpB1yy26Vv6s2SxNaAuE92I5JF0xOiyzh936pcSEPHsE5AKcjJI1rqfjYD?=
 =?us-ascii?Q?EKeM/BsSZpGEsB2r4Bdsqogeu8ofyUGgGFpHXjBAGEj52N4wHsRi4uy6MBzb?=
 =?us-ascii?Q?cVwn7LS3LeJR4THDYmRzsQTbNknyVDTA1kW5YizYd6SCjJZ1/bWBYY7e5LWI?=
 =?us-ascii?Q?EQquLNDKP0mD8bfX1khtEWgLvFYMiDE5rjgChC268vdcg3Ht/cnSoXqinvr/?=
 =?us-ascii?Q?ZPY8mtiEnLrCBHsIHmY2toTKWMlT5KNdQ/YWDt5Xtzw++rFFXdk9GrC2vM+y?=
 =?us-ascii?Q?czNlEmgZzextJKJDS4Nh8dL9CO99iXvX+EDb7z6Fs+5QtpTCHIL44LUhiL2D?=
 =?us-ascii?Q?xest+wPNbLwbjH90EqqKXYfpO4LM3EWM3wV2DHmTNlEBwExDfIkBF0oZZhPZ?=
 =?us-ascii?Q?r16HsvVu8Ti/NB7oAibRAmIzruh0JgAPrYBL6LbUqGfrKP6MqYinubGQKvTp?=
 =?us-ascii?Q?hidAeNPvS5wB4jcU5a4Jl4IcFxJSx7FQnHKOJqjE+vXsTuZq5V0MLmzgXmaK?=
 =?us-ascii?Q?cwCu1neCprnvHvpPh0DW4+2Vrrq/TS/JRQDD7VPt3CWXImfmdunHPgkwgtaX?=
 =?us-ascii?Q?aPUB0vAhayK4yACcoxnm5Dt2NB0srHJ+56O3TnRhpICyPQKO4EvftewaSYtj?=
 =?us-ascii?Q?xNUUW6x+UvUDOR3QkA4Ho9fc6tz3d+4rsFnkmWWzUN5R+8dnq2aIPt6qqD8k?=
 =?us-ascii?Q?MXZr7sthVSd+WynT5frJ9cNpJOjhdoAC+NtSxxA02xTREPQvgcD5p5x6DcB2?=
 =?us-ascii?Q?vhpCKt+o5jBbV2DyJLoBWoIS+Rc4MNwEC/DWvBTNKTZ3S05QtSWnrym9xsvS?=
 =?us-ascii?Q?G9sU2sIWzS+UfSAtZVXraruahPqE0fYpPPBZp9Ek72Dwa5apY/1IVB2Wel80?=
 =?us-ascii?Q?0X9ace5h3cCDoUeK2E6G1LdqWuGR03TLDjavRfS9UtwsfjtGX7SvFI3TXvMi?=
 =?us-ascii?Q?hICvuMW+O3ZpJBqgKjpInPzYx/PeIIODMy67E/bDJAJoEHkThxH4lG6/INrN?=
 =?us-ascii?Q?QOjd1rbae/CnfWjUjzIFnZvZ5/hco6+5UQwMI7wbmZ7AdliwRMoIpt0xLrIy?=
 =?us-ascii?Q?zy4TV0rDmqZFtDBT53iRLy0cQf9N6bsI+u+Jv9xSPizPIoA1pcBaX01V/gbI?=
 =?us-ascii?Q?/R9F4CpPhpvqhytj7NtzcJ9XXKj2Sn59PlOI1bmUXc3HOx3On7N9N6Vb7za8?=
 =?us-ascii?Q?rQDrprfVrL3ekoO7i08HpUJGdNcHYvw=3D?=
X-Exchange-RoutingPolicyChecked: ko7N8SArxyjiZ3vpFjlcCXcjr0ohhsFFJZxrJyEhXU/L9Cut4vLTjs45sOYwuzsodta8+9Hrwr/ZnLTKP5vRVfeYqXq2+MejHPi5V0cCvJjL9RVQnuUYP2o6Er0Iz7FWTHk6cmsXbdUy9Gbf3E3aqAnzm3ZW/t42QEtpPyLBOmv5HDFhddVYJ47IrW41TMUqt6s8MScVKXEHpQNY3mnY1uAIviMqMrS6rWDjip3xetI5Ydcn3cpcvmU5XPiLLoOUmBascSfFAgKX/507jDQNZbgIyxi5wgVzKH7dHNMKibnbEHfba5ASOmAMor7zQomQ5g/P9ZYwBv0JN7QMz+XPKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6914d0-203a-4877-14bc-08deab7d3715
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:39:01.7768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fin+0sNcSRpGVu1a2Nrlv8u8s+VdHc6i7hkOdvBAA32bVwbONsrghfEhHpWdOJ/oo7HzsdW0kzQ2K5jgDsk2Ktzo96iL5FkJUOm9UDdpRLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8326
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

On Thu, Apr 30, 2026 at 08:58:13AM +0000, Anurag Mandal wrote:
> QinQ insertion with VLAN TPID 0x88a8 support is absent.
> 
> This patch adds support for QinQ insertion for both
> Outer VLAN TPIDs 0x88a8 (802.1ad) & 0x8100 (802.1Q).
> VLAN Extend should be enabled for the same and Outer
> VLAN TPID should be set properly for TPID 0x88a8.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  doc/guides/nics/intel_vf.rst        | 19 ++++++++++
>  drivers/net/intel/iavf/iavf.h       |  1 +
>  drivers/net/intel/iavf/iavf_vchnl.c | 56 +++++++++++++++++++++++++++--
>  3 files changed, 74 insertions(+), 2 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
