Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D9CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 14:51:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA06A402C8;
	Tue, 19 May 2026 16:51:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D029B4025E;
 Tue, 19 May 2026 16:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779202299; x=1810738299;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bYbTjJ5Y7JQrEeOeX23d4ysuW201DobW45fHzT7SX2c=;
 b=A6j96oQSIRW/sCYE6cpTaHwlPHzFAdOzjH3Vj6X4x5y6UgW4IDZdeJt0
 A4fd9m/tzidhnQQ1/DYqEG5uPSr5E5YV+UFHP+u7ig9FEp/9w6nvQ1+Ly
 EONFQ7CCiiJBlSTePmasIbVq+w8rP8ZGZlfBP+ywAppquTAU7KtyiSrll
 +iqoR2cuInPP9h0Rni1/meO88q9E54fea3Znq3xEV3fInxUaKHUxb2pBj
 uWqDkYE1Djpw7IUCvOyilEcJLI2/VpqKrBGhZdsZTeC8R6tVjp2LbmwUN
 btCmTIhzB5Z9DPfpesOJlOz0d8L2+QDkUNlzik8bE4nvbJvuUPbZDdryw A==;
X-CSE-ConnectionGUID: lIwcPjUiQMiJ5Vs2r4nfVw==
X-CSE-MsgGUID: zJ4GMSR/Slu2LgB3LKk1Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83696569"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="83696569"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 07:51:35 -0700
X-CSE-ConnectionGUID: gt77SOthQLuLgVW14hj63A==
X-CSE-MsgGUID: Jz97H5vfR/OeTQ7apGbEQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="235528715"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 07:51:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 07:50:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 07:50:46 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 07:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTRPnqPesSGumyDsUWLXciwJEdMz+tWkWoqFqi4Pg4aqFZ9WEaA3R9G1tBeuy6m23fUcFfyKvoQQ51iBoOkoAwKgvo1bIj4gzGXQxMBxp4nEFROmRSzhCdKxVX+oXkzbGNtmJ9afO4dA23Kb5SfKeelX8wZ+eWDM/q2IwDQrRkJR61VzTMXSSUSkc3Dp5sMsxlYoEauudLEsofEkS2Z1RW3MTnDQRD67S+nvRzMGZQGQCa/Kb+GjjHrAStNBCS4h4NrzJd8L/kHVcD+mrd6R7C2T3VPCnQyPRMeig/YW7S2URUBgND8aH6G1S5ghebiyen6vMYAm/ytBma1hO0ppDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdqCUOtyy36EyGfcSY2PC3M9WWiCUPgldcJajU+90QE=;
 b=ngMpC/099PMOLMcWcIduEw5Shw7EY+QToeXyYH/Ng7fmM0I3kDnFSTY4wk0gJG6SO57BNDk9R8zOkItdZtCaDlAvX4UIsHWGl88hZOaT5tRDxfcdo4Rum4uxRwYKl+Dq4umk/7Tu1aHl8JRNhPUS9tQQMY5zkVuBgcLEp6VVwbZ5nw6upRB8st/p/XrjflyhAg9TrKS5OFOPD2EeuVaDGTr2d5aCd7cDTGxfcQjr4WXHQf7eAGSDOQTy20Blvp0GOthZTr6RkCm+SJJ1md/T/965h70BEfyKP3SC4OWeDmvIflu9sJZA21ycgb1oCFH1mWHOTINdti3wNywH7YUN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DSWPR11MB9953.namprd11.prod.outlook.com (2603:10b6:8:39e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 14:50:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:50:17 +0000
Date: Tue, 19 May 2026 15:50:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Daniil Iskhakov <dish@amicon.ru>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: Re: [PATCH] net/ixgbe: fix flow control frame byte adjustment
Message-ID: <agx4pDIeuCIcZ0Lu@bricha3-mobl1.ger.corp.intel.com>
References: <20260504145502.160806-1-dish@amicon.ru>
 <agx3WX8nLoJT6JbS@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <agx3WX8nLoJT6JbS@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DSWPR11MB9953:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f8e014-6198-48b8-1986-08deb5b5f0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: LdXRdKMb6hM0fiayfZ4nEFddVIxIgAQbKsi3oDaKb99dW/8Kke+RxYyF9XBPUui04Kwx0uueLaKWXRFgEtSADxWZOnXheCjhq9QycCC49g+MsmmrRPd00dJW8w4sovKQghJAXG/9CqNGmBKBHVeuoCFtZENGWkmZEEX836YMthwl5Dy8ylxWqDY2FOUw99YXBu03aEE8154Fr1/XpXcUajF7cEYCAtY217UGzZy967oy+g8au476F39l4qm0NBQJZ3hyFeejdPU+3SrzRM8mVSxJxYlqja8tPdjHbstKz4opM+4JABZBsK5gujP2hq7jwEltjEYKsZ9kSPJwWSWUItQDjg4stHOK7UnNwDh0Fx55aKdv2COK/iXeV05hyaNVGjGJ0Azgs6dICfloFCYxhGvwiYw8fUp52+7BkBKsCax/jwX4qBDEEFssZWifvvIlGh9CVdYgIibNURrrfvGDixBD5TCuI0GV0uOY7SjXkIuTu1BXCC0wyJlUPDEQMMuxsciviDJgR8Y0CBOHvcqtQf32lsqPa15bUzrQL/NLcw5Gj8GkYZsqJVR7824FpM8JUUx2jecGnjMOMPdLDhKsVUrNf0KduGr9LT00ZNy4+Ft+YWavJ4GhK/32o1BulC8iQUgsiwKm0DLL/KN9FX36kefQpl9tRuscKuLHbPfeY17XdFzE8XqPCYMXT3V8bPJJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yzbHKBjC+gmO4LQRLSOBVI5IBJGaKRBUOvyk1bkNa1bPBblhciifBjm/uV1r?=
 =?us-ascii?Q?Hb8sKjf3k64PGDJYCodRbPVwh5u8rARgajuE4XD3j5cPuJwi0LozwQIHJgtg?=
 =?us-ascii?Q?v4UN31bd46CpGXnWw6XJz0L2+9zREod6VvfQcATsiheoP4Ev7fY2689MUihX?=
 =?us-ascii?Q?9K1vwLuNWBqQ1pTkgBdYlTYmmIIF2DB/k5hexgr5bW8hymWLJOokPa0vy4+B?=
 =?us-ascii?Q?CG1vHy8dEx98fxXF9qgyAqePCJVhhJBStJ2zsX/RpMON2jL7Royow0EdHwDT?=
 =?us-ascii?Q?9wZGJP3rW2wmP3QgtIiME05toYLpqZwqGnqtKq8oJuLCG5uWRon/7AItqMCb?=
 =?us-ascii?Q?EPuBuAEEvrWiKBCYFxh/W/rA9vHQhFF0ElpwLpJxN4Bxg1WCaRpDtrzkq6ck?=
 =?us-ascii?Q?hM4JO9MFF1Ngcez8HvXju/8UTXr0kgFGYHaJJHpnedI6yr/juqnXl8+fYTvo?=
 =?us-ascii?Q?fTSbPNQ5s6L9JfYA/Xw4TtJ9SNPazlCAtrHkNqPIZoARWWfvmcB85EObyp/v?=
 =?us-ascii?Q?jQ7RN4bLYVQmIRxxcRt0A+AhFsuynZvDioRU3HVE5n4kK2qEBKlYS5/fqGCk?=
 =?us-ascii?Q?SDJkohXJRLiPJvgo7dRmCmueIL8UJb0LhpRiRsmHmo1NOSx0RxtwSdlYDqYT?=
 =?us-ascii?Q?zc8tEgSKBZzA9Ii/LG3SCDqf8Fja8EKZBzohOUJrvPBEDP63x1Nw+z7D6ib4?=
 =?us-ascii?Q?pm/f3AVrQyKOZe4TC9OyXgTBQ7YD/lFx6DZjW90T4hsJJn9LFuJp47Cjq9x4?=
 =?us-ascii?Q?TD/RBWeeCzLw39GplyufXlmLq80hvOgLm6dSdnApQoXuOI0wRP1hvu4EfNRA?=
 =?us-ascii?Q?5yJWyapAA4aoArDGUxlPm3ygrpRkgRADkTF6iAflF34bN0mnKyUTFmbMP9xN?=
 =?us-ascii?Q?OGfXVzl0/JGnqOmXDvHg/cSiOISqRhk8K1jdg6t0NuAHaS6hJ/KigLWOWCGS?=
 =?us-ascii?Q?7DJzAWElXqIl1D0gnvCHu8NBvG2IhLg+3PcIFuvXYiqA6BEiZzS4dxvMLLJI?=
 =?us-ascii?Q?zfGELWnQ4CnuJLpSNtQkewoe1cXQVtgUwGyKuCay6kAVDz0RJQtQBNIoCCQH?=
 =?us-ascii?Q?CD/hCaLu54JMFp9ntA25djiaCp9KCuuk+QM2CX7eI+sUBGeBATI+b7c2F4zd?=
 =?us-ascii?Q?SBPaQdMn6lRIgm14kzZfW9D9JWu1gPCqJYa7ZmhxhiZgpR1sOALNxAuWSBhY?=
 =?us-ascii?Q?8hN2Ru2jRmGNqnIRu5f0Z84q+IZRmE62pCE6LjkFCIJq2zkxLVgLV3uAbh9X?=
 =?us-ascii?Q?KrhuMt98PD+Sz1PYSQZcfMvhhmZDUJ0RVFz2qwzDKh9ipA3WN3HpXT6MpPsg?=
 =?us-ascii?Q?tQHPOFs84/dVq5bf1VVB77bPIPHGalg184l3VKMZ+wvuGEeogy2SyG0w6zeC?=
 =?us-ascii?Q?bmIqwaOdKIIm7+3KGcrTntsOqsyal93Fqr6UqpJ/PprCwMa6n1jgKNAC68dn?=
 =?us-ascii?Q?Mcv0bH+p+etCJC+g97zgIvLscfzWJ8p66pmMEItCHF7QLLB8GiX3+fIH627P?=
 =?us-ascii?Q?EypLzcz87TEetSTNRzFVN8Wqth8nzLCFeEcbNfYNFfl6+rxhYSKCQE6RKcmR?=
 =?us-ascii?Q?Sm8r00FwU6qGNaJZmAszMRDsF1NENEPTTNFstHAnInKmJcjwul4FYHwZ+9bP?=
 =?us-ascii?Q?OC02Feto1yxV98asGMPOxq7qstw+JAQRJfRtLrP5bO2AEUeEpdxQdjJxs0d9?=
 =?us-ascii?Q?ciB+1z1zSZEG16goshq3BEvlnf442RzzCNrMW+WCt7gg72WRrGIfl6J/Naj4?=
 =?us-ascii?Q?JR3tvTptVyGh2Zax7W0AqHRcM4iC9Zk=3D?=
X-Exchange-RoutingPolicyChecked: Qv0CVqHnKD5ANL8Ypuj6hqEyasjyPcKiIQBXukkUrCWbOGJ1sFgCKOgRfzg1II4ankrvqlQNzumg/Ymd6tqo7rIlmIC9s0vQnpOdyYPmXlqJnklxiQqnwoChYLd6P1BgRgx4mQL2WU0Nx8UdfCrYanztwSnlYt2sQX2NsnpJCejfp6ZrH9/XoC2LMWzSvYu6WXxah+2B7PsUPxZpxuwZJrh/wBb98QyXJFqch4O2JOgNYXH44AKvyUEFmXwvnGIwy8L91mA7tRHmhzS8NkwKb+oBGKkL2n5QGwFj49MqCp++uFHUygOG70RgCm5GYQM7stnzpJSxh9jKGpfPt5dTrg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f8e014-6198-48b8-1986-08deb5b5f0fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:50:17.1780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96wZ2Y1xzI5WL8LJMoNGOGNT6oyNQ8vd1UOF6p9EudR5VxepqUARODD1Jenp8cz4zgb8/D++vwfwj6nTkPzZ9SyPVCOUYg6w2FQ4Bxa+wJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9953
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

On Tue, May 19, 2026 at 03:44:41PM +0100, Bruce Richardson wrote:
> On Mon, May 04, 2026 at 05:55:02PM +0300, Daniil Iskhakov wrote:
> > LXONTXC and LXOFFTXC are 32-bit counters for transmitted XON and
> > XOFF packets. ixgbe_read_stats_registers() sums their deltas and uses
> > the result to adjust the transmitted byte counters by the minimum
> > Ethernet frame length.
> > 
> > The sum is currently computed as:
> > 
> > 	total = lxon + lxoff
> > 
> > Since both operands are 32-bit, the addition is performed in 32 bits
> > and may wrap before the result is stored in total. The wrapped value is
> > then used in the byte adjustment, which may make the software byte
> > counters incorrect.
> > 
> > Make total 64-bit and cast lxon before the addition so the XON/XOFF
> > packet sum and the following byte adjustment are computed without
> > 32-bit overflow.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: af75078fece3 ("first public release")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
