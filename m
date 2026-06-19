Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D23CD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 09:54:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C958F4067B;
	Fri, 19 Jun 2026 11:54:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id A508540279;
 Fri, 19 Jun 2026 11:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781862870; x=1813398870;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/y2BWwAyJIpZoEYvs7sU1qZ9MLXk/fEqj/W06or+yZ8=;
 b=nnocN6ovOK2HJ1j9Pn4lVlLBauuVK9jgd/PAyXBDPYLvowoCkewJ6GMf
 l2bR7hNIX4bW1o7mi6y1zCDh5UodeQ1Q+9UALQ3a3tCvrnFCcLloCYJ0p
 sJs69wu30pqtnRijUr1SBDsnxYIE4avevlnEZZPmlabJZk8vRf0QRcC+o
 S6XoLQKlPcLiXYsAKNyk5g7iScHMKXyhONEu5oRoRtCRpBw8uvXWK532g
 ljkUG7ue0nYKvXqT+O6Yxwf1HCj1UIVBv4pw0tR2AogfuhxcE2jNJtFvj
 cbxyv2T8qNbcZWLTQTZ7a0P5QaDGhaHVAI0G8sgyXaVi9IpwG3YkzD5WX g==;
X-CSE-ConnectionGUID: AMBvEF2qTMmOX5ayc17BBw==
X-CSE-MsgGUID: vcecPsfZR5669w/XYlrfMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82587329"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="82587329"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 02:54:29 -0700
X-CSE-ConnectionGUID: YvQcV8SBSDy/U9/gOzonAA==
X-CSE-MsgGUID: Tq/5ypWxRIS2HgoKMmlZ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="248667403"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 02:54:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 02:54:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 02:54:28 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 02:54:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVZPWBuJzXV2cVlJ3H1iGCz8OmBsLWlCu+zaWDbRyulxp3dY/ZB9RMW66+qm2EZCUGqvP0hIdJEKLHflBdVstkyT2SxSyhSXag4JTN/da89elX0Oh6PSBzwJ4Dw2PLOhyabt/6SHJ2Jw4YABlEpDat1cK9epvba5ZJ8ftEN4ZDDfEpuGpyKueHTUfseFUKKIW/cuHed+gnjHRXjECIm2H1uwXKg+paWvdeCopv0th06nuzyPXKlv4Bk3G6pnzb4CTfAaq0H0ssd3O5bKKOKg+nUo7B1GoUFgTwIVTKBFlLJZ3dDNWX+eCiKiPAAMFyVsQRmJkRDk3rvA3fwHJvTPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42kdp1gjUy87tqkeyMucFotgP+D/YH26YdMtLrzQS1k=;
 b=UWpOofRwikfazA1qN2oB7N3oSNVkjQ8cFxocz6Fna48zOi2a0dEeLfEpjgdw5wbnbf6BKFzoLnbuy9nA2OYetSSZ1g3Pcb7vpg/Jd6tRxJqmuHNZVkrTzuPiCRr+QRaZ6RIufd7qKgbKuThE80bgyF9wGzlGVxu3/GZ2zasXgfTUWJlkjV0t1uUH34RwEmGKofyiKBvu0oEzKrT9YADEaqmG+gEW6P98GhOV1DJwzBNtzNTCxIR2RZPPaddK84nnuCzBBViFGinIORg8tzNYt4CLiob97dtHBCecHqfYj/DFeVuO/r6UN7v9ydhMS4vKcUdwEo9qv7QcMvpR2D0NcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 09:54:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 09:54:25 +0000
Date: Fri, 19 Jun 2026 10:54:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Chas Williams <3chas3@gmail.com>, "Min
 Hu (Connor)" <humin29@huawei.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: Re: [PATCH v2 3/4] net/bonding: prevent crash on Rx/Tx from
 secondary process
Message-ID: <ajURy3X9GWvpCfxJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260529000157.235931-1-stephen@networkplumber.org>
 <20260529000157.235931-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529000157.235931-4-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0351.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 635d6421-23dd-4dd7-e867-08decde8bec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: KABVeroabnouAc3/ULsoDFI8a2KukozvC0L0nAcPwCU3mI0eQtaxAnzK/wJAkzSWBLK+Piwgp2C0TjtYcbihAOGuUbSBxPJz2Oid/qvyBWbIqxFs8O7apEaNldHtHz90LOawEkIYHAr+51NUTf5PszsrR7x2rAk1HHUv4l94AfLigSa95jdDK/w2LQuP7CIWwHHqEVbx3YQTCkx9ob8K/Ho4HWVmOkEF/BrARZMpgUoKrUkskQon1cZsMMCXtjJ7fsfGADYjh/lyARBiY/SuvEUfLhLZGu5zrfgew4m3GZVJ4E1d+H14XKKBvOiCnQTxbqADh+jc22Kp8joG67HU1LVpCmETZPrRKNWXPN/9RTXWR6SbxntJdhoxnu12vwuCB3LdKxq4rOWDuF/fthUUy3y8I38Bsd4hLKDRs40yKeXJ/ZBxgFrnLWAE/f3g8Ewaaq+ZZNI9ohkNGfN9GrS1btccwE1QiWr86zlIE/Qi3PkabxgJGirz4dYhAPKfODf1wma0sW0bKKr7mhbFEFRwP00kdZB8FI5NGiPZcvhDJ0c2iEg6aG2ffgOuN2LW/Im+fT4ChT+11an//dfpM9H3WYnTZKWKNnKJ0uk5xsd1ZR0e0fe+VoBy5udl3cBk5qNRQ++YUNIW/GCAIaCKIxUYeWxWwCPpJW9XWuMDz+Dx54k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E96C3remE34Yyq3EMu+ODFELyYy7Xfe22FTjykmntLd71dw96eLlslL+d3k3?=
 =?us-ascii?Q?81kf3/OaTuNK4BCdJ7rNXESe8CWPExR8wmpmkzoTiEoJ3uL94knXa1xuMXIw?=
 =?us-ascii?Q?81PPAdLK0SA6xTbZdXesID42xFAwmwbTsX/bU7tjbhCxKv3h/5ZIPIFrBbJa?=
 =?us-ascii?Q?WaUR1oPickSC59bMndl/ltxv4Dld9MqmlH16bu4YxlkTiRmgViZZZRCuhDKZ?=
 =?us-ascii?Q?xM/M7oajHwMnGFwyPQWr9etBAi+bfpPuzyIlfDLaohO5vbtshFQ0X1ZNDCqG?=
 =?us-ascii?Q?W2FXICtbIiuCCH9yNZkZN/uKbzHt023C2rCrzWK0Zx1S145+fnrcWw322WPi?=
 =?us-ascii?Q?sBB24Zukb9iK6/G7vP/SEIy9AR0AyBHD1mtzrn7FNagXkrUlBfzRj9IocSOa?=
 =?us-ascii?Q?4rMFgO4bAZkOXBnbDPdqMstdFac4G3b+ZuUAIolBpQPW55FmW5CU5vGHTz2q?=
 =?us-ascii?Q?V1tTTziUoECeS7lxC6jorXdw67nGF7G0olh8ykH4g4YymDTDamokjj7tQg4Y?=
 =?us-ascii?Q?CbBkcBRxKoIOvqOS+ZLMwv0rkAmhfiNgVkExN6fDTB9rIkeGesYm1mQJWL8V?=
 =?us-ascii?Q?Sr+vlA7EgBGetw4LZoUmR8Gqr2jAgSy2t6xEQZk9n6xl7Rqdbq97PhpjWSAL?=
 =?us-ascii?Q?Z7SH3/uCF3yH1R75FKOeQ8iQjdlj4H3QYW2mSdrCWdFdc2WcJAS8amg64wYT?=
 =?us-ascii?Q?kHPymXxpCKXLbuhBiNqjjWFZqRjJaDjMxAIryPFq7oxSkUvhgqxQRvFUslEX?=
 =?us-ascii?Q?hjhmrviL3BYc4T66J6umDf1qAwg3eev3kE6gAnWy3R4c1h9VbRteCGoH3iHa?=
 =?us-ascii?Q?KP3YDm32U9X728Y2RT3QvXtnyc6/mM5VuLfQrpPEAq/oI53kVrKSfPqQaTbc?=
 =?us-ascii?Q?xirKWS93Xnfk1QF/NWfUkWyL+d22gTcMerE77bUqanNcyYSQY0m4mgfmt/1n?=
 =?us-ascii?Q?V6hHn1gpBlpjyiLl5ThNGmMHXo5QW5Z1p9md9oMxj/urEEcep4tZ+Nc8ME47?=
 =?us-ascii?Q?V8lr27PfliGg7EKkIrhwj13DuiL28Uw4W1aY28Ji6jkT/8EIGZsy/FFzJHz8?=
 =?us-ascii?Q?3ZBPzxJ6nQel3FkzSRKmevQfgFlDiX2BXok3p29vr247Dbl8yTzNyYLoQiyg?=
 =?us-ascii?Q?0F3Y7LX6VIpx9iZt1rwIE1f+6xnaE8+oth+kLOnRAK3eDkO/SXHqiUcNLlyi?=
 =?us-ascii?Q?Eb8MjJKK5F/nGdVzn4U5aGigMCX39ptIBHUTrlHKtrXSbdFmW56//QHImM8j?=
 =?us-ascii?Q?QciPyOy2zugKuWgdj4llu5yeGRnihzp4W2n8J1PdwDQ/o+8dIIo4DTeO0qUp?=
 =?us-ascii?Q?Cdf0YMNDPC/TTJP7jzuPbUcAAkjHRfs0+5Vw+DNroWzP4QVBE0YwmU9NYiIH?=
 =?us-ascii?Q?0knJTs/+QIc8kVR9bQT46R4tpUdNvCu0UodhpL2W3q/86WI+OB4rG9/u7TBl?=
 =?us-ascii?Q?sc1HQ1bKZ3oBfewu/Ga/5QHju6CznSTO0sv/TA1TA/6/cIrR99P8CMIsfXWe?=
 =?us-ascii?Q?uNUGD2Vf9RKWT61b0NlNHOwy+TWjzzKj3oU0AKJt5ZJY494cSQTOyFQgeFd6?=
 =?us-ascii?Q?Z/88klijGHMDl+1jes/CvBMgYU97auSc9vDxD/FRMlJLWEK+sh17yFam0lxf?=
 =?us-ascii?Q?0uvFICej9oTqmajGbczlGTspjAtRNIzbERg+Fo4w/Zai+dGCxduamyVCq2Xo?=
 =?us-ascii?Q?awaa/FpQKWI2Ti1CtKCDSBmu7Ag/n7fr2nbUTI17C2RXk6qVN78W2T5+EcNk?=
 =?us-ascii?Q?U7C0kNhMCuWUKdesO2NRgno81Bu38mM=3D?=
X-Exchange-RoutingPolicyChecked: E8ZCNUrg60upjeTnp8iy7fJyxWZzYC0M6zuicw+MlBM8iESO29qVUu+StnrNpoaCeJovtbn/ZBBD4jyUJ/HdcXxWN92h8lvVFyMz0HfcMmOl4LjUebEvWrbMg2PDHJTP60tNP9RMYjxH0E7yfLikWx3pBxV172Vk8g8p5ju1tvDNIwysFUsrY/2RVXmF5V2+oUK+vDkMbHOhU/6RF4A+kWgaoN/JfUIsDnDBDnZ8liTMvUZjKaHgAOfrUUjzEcUYYuOLBeb2uPAYdBxmLtgl0fe1/RhOAZvcQ0gCCtXLdGLXH0MuYbkdwVVvT1tOM1PExFs4mDoQrwpSis/6bOx9Eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 635d6421-23dd-4dd7-e867-08decde8bec6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 09:54:25.1823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5R17tyjoVTMJNQtjuw/XFn2134WBEFAAbMbIJ4da2hswunFFCc80QUCRc6wqE6ZGgCyZ8yrqMp063W0Vne/Ee3dzXNlIRQuZazaVFoocLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
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

On Thu, May 28, 2026 at 04:59:15PM -0700, Stephen Hemminger wrote:
> The bonding PMD's secondary process attach path registered the
> ethdev but never installed rx_pkt_burst or tx_pkt_burst, leaving
> both as NULL. Any rx_burst or tx_burst call from a secondary
> process therefore crashed with a NULL pointer dereference.
> 
> Fully sharing bonding state across processes would be
> overly complex. Instead, install blackhole burst functions
> in the secondary so the data path is safe by default. Rx returns 0
> and Tx frees the mbufs and reports them as transmitted,
> matching /dev/null semantics so applications do not spin
> retrying. Each stub logs once at NOTICE level on first use.
> 
> Also reject bond mode changes from a secondary process.
> rte_eth_bond_mode_set() is callable from secondary, and
> without this guard it would overwrite the secondary's safe
> burst stubs with real per-mode functions whose internal
> state is not valid outside the primary, reintroducing the
> crash by another path.
> 
> This keeps secondary support available for the more
> common use cases of procinfo and packet capture.
> 
> Bugzilla ID: 1698
> Fixes: 4852aa8f6e21 ("drivers/net: enable hotplug on secondary process")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
