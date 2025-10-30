Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC9BCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 11:51:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FBC24064C;
	Thu, 30 Oct 2025 12:51:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 861914026F;
 Thu, 30 Oct 2025 12:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761825069; x=1793361069;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ejQzeGfBfdmO9Xsti7e2LCWKX5SygIXrg3nsgQsSTXg=;
 b=SlMFUm22xVmS9wXqPDNi7fxsnQexOYVuWoH797PgbEiehXzWYLDD/i+P
 5avhscYAMZwShZvttBZsLg5+eccISgsxH6KDTTGFEZL2fqDfk5ZbdxqGE
 c3wn/JNu41hPAcVAkScKLAGskbnfhDVzV4vBPylbQ+P6j1HX9aagIcbNl
 hiALwrKMmMIdi10ym2gkcXo+5pI2FZ/cYCac54U4/5pPiusn4UZBN+PQs
 SrVIs8ebLOCUDFBiEy2hS0kYLcUMJnJ/tqX8RqZUa2ynvjzG2Ttxqf3q3
 rZ908xP/QlYA1UmsJHrsrXwOrdUC/Az+OiJLReAetkHy+VzE25wtAravn w==;
X-CSE-ConnectionGUID: WI0l1cWnRLGHcnOKyVxieQ==
X-CSE-MsgGUID: iZbhKrQkScWALJROf9lBKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75083044"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="75083044"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 04:51:07 -0700
X-CSE-ConnectionGUID: qU1056zCTEORa9EqgddKVw==
X-CSE-MsgGUID: ghW26NlWRoy6diSJMJiZuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="185193873"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 04:51:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 04:51:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 04:51:06 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 04:51:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlRaKnVi55izf7j+gkfXO2qw6EjMZruzuVKxxoAMaSHfOzQ9MirMS9FCG2sT7FfIlMVfF6rEIgkwNaa5WC42tpYqVD/6Q2FgdXiKdQliE0Q727Al6u1pYoz1DD1fPrGfAEyxBeoFRxyZGXPTbb+LivzsAu3vXmcK4DO9x4B/lPU8SD5+X0CKLhza9qZvYFGCMZVZp9zwOxRO7DfoHbwXAi2sGfAEt1fzT8piRQNjKw4UhzYBnz3J7yh4wnXkZNjCFr7Vm6LUbHnco336SsogpZ3HOZz1PPzsipOx5r1o8rZAKPbFKjy34ZuRL5VhkW0xfG8vbmVjrYnsCabj2gL/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYEzVSqbi2s6ThkOK+INAI4+pm+GzK9mVdPl9Bqm/mA=;
 b=pWGHbZNiXHQgdBP1Bq8csBeg6NTh+dRUFzKCFCOrE7MJpIlzAVJknjemg/aOxVcxygy2/5+iaVQ6s5wBKGT0+2tSs6RM+YIyjHmMqR83ksI4Y3/UUCkMcftGfmsjq8BohWl1dnXBd+gWei9hFKnPO5DPFSUzJyDO20y2L32qnbutjU3q6gqbDcWjjK018932SHXeMxVgehc/AdmFz4Lbas8jb0qiFiEKwFaMrX+sT46kvM9juigmKl36txV1hWxkk0PRs/q+GDTkpn/aDIyF279YPO8oKK8PR3vGeMYXQ8dtPs2yOxGwMmh4MJzhGgS7yjV82bh6faG2nC9NsUJH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8678.namprd11.prod.outlook.com (2603:10b6:408:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 11:50:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 11:50:58 +0000
Date: Thu, 30 Oct 2025 11:50:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
CC: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/e1000: fix crash when built with GCC 13
Message-ID: <aQNRHQ9an_Tpvrhp@bricha3-mobl1.ger.corp.intel.com>
References: <20251010125848.965340-1-ciara.loftus@intel.com>
 <f2050e39-4fb2-44cb-bbf6-e0fca99ab9cd@6wind.com>
 <aPEFya9U-aGhR2tb@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPEFya9U-aGhR2tb@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0133.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b3bfe4-8e11-4058-fa47-08de17aa96df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?txVuuJU7K8k8h5aeIAXSmif+yD2a/t+qr+Sebw/w7hrcsrOVLnoEZoDMCc2z?=
 =?us-ascii?Q?u2HlJ+mO0lNbqZD+kN4a1uh3rWcWS8Efu/aXz9y/0pVS4LT1zVrSSg3wBkrZ?=
 =?us-ascii?Q?0oIj3gBBLwntZyYC46fTUfqgyAOHx+40GsOTKJGPrXnzXAvImLGh7q0RjMgl?=
 =?us-ascii?Q?zA39DHbP+cefvGTCZD0B7LJt01nIHbekJnnFlvfJUb3DYWI7So3JXKSx3HVw?=
 =?us-ascii?Q?q1zp9AixCCW6aGqAnN+Zmb/6jw7wc43S/cVuZ12EKW0cJEyu+0J3j+RbDyEN?=
 =?us-ascii?Q?pprvxe0eONcg+hbIfI3mY3ETjdDhNfXVjijJ+Ji9+Gqj44yV0ffpQo/7llNv?=
 =?us-ascii?Q?UpR51C65Rk+PViMmxOpevgsNrpNISfynj8wconHedPp4TVUVunZD33LBiHs3?=
 =?us-ascii?Q?HAShasDM4dw54RBiPEXXi4Tt75Ow/07sUawyp58SAKvvhANvfZkrgEwnq5+D?=
 =?us-ascii?Q?OI6s54yMAzjErSriWi5KNNadQcJ4oJYQmA9P+yX0nY7sxGPZzMNPW3+XiGBh?=
 =?us-ascii?Q?cTjxI1clp/uXyQxeZ/xcbxyD1LEe9vtyG+ckXACbY0tdBe/SQ3vF3UOuk0bE?=
 =?us-ascii?Q?YEZ90HKUFKtGuDtVc4Z14YcxYSK3RJcJo0WvFdGMapacRBWobE89vaGtSg6O?=
 =?us-ascii?Q?Z/F1Wu2etco9V71wtaH1t6WG+wzsdPZDFtDNvckNbrgnzDP/qys7E6g0pWJb?=
 =?us-ascii?Q?G5oBfAPRj3SjmD8+goV1z6aGDQPgVBhB6cjGS7sG2ihCEop0gUe72ckX7uwg?=
 =?us-ascii?Q?I2yPnXmhOI0gE3wIKKqPfckxiXNluPfSXJJ9rxem+wYFdssS7rozmZlZVU/O?=
 =?us-ascii?Q?ncQOiT2S7AGDNy3HPXOOq62WH6wmPM2fCdj9EedXMWw5Fl/ET9U1bBgYLZ9O?=
 =?us-ascii?Q?rbpbbhZkRrFR9ugrfuk/BUumNVm1o66MFU9Hndt4mICImc5cRWUPQ8keUDoU?=
 =?us-ascii?Q?uHUcYsMFDbcxqROfL4M10jyhm9SJA7UzOS708FRf7AkkqNfcJS/KEQ10a4Re?=
 =?us-ascii?Q?nkSRNqfEEwMFT4GKNADFVmHP7ZTZO1g8q2Ws+YKSLrICnBg5S94BBDCOQQ5H?=
 =?us-ascii?Q?hLCoKupa+Yiq8j6NWNxzSwucxgGIWBfMpFYNX/ZCj/whCDM0ehINnrvI33H0?=
 =?us-ascii?Q?aOpzfYxXYbMJb1UG6z3XqPcJ9rC7RMc79zinyK9pkMZATvWp8+mdJS0fDpJj?=
 =?us-ascii?Q?ajpXz8cvOWVY/WDUTeiQJFpGF/TNYsan19b6J/7pPMtHnw8VAOAQqBNPqrCH?=
 =?us-ascii?Q?5n0IwU2qcxCEqPSajMIJQfnQ0DI1OBxC6ccuKFpf9ep3OcYgKp6VFHnLRIhI?=
 =?us-ascii?Q?2vPC2Pfu91/faT6AU6ZhR+JyGC75teoYzXGnup6rAldIIwMgDwbl2IF5vm1m?=
 =?us-ascii?Q?yOxospSxu4WLE6ikqF4JOhMPgy1d+k3oLn18HFHfGViqfaAO/XWZ1oDSisje?=
 =?us-ascii?Q?MaDzUumjXtxQD1ZdCS5nFoYhBQwQj6y2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMqzQQbU5/av0HEG/y8bFnq4nszL06T4Uxn/tSrQeTlITL94FP+cW2RVdi3v?=
 =?us-ascii?Q?WX4NAJZhJwjICFLCX/0cXrMQiaTRiiuKY0/Zxy0UVecBiz7Ozi6CO1q2TTfZ?=
 =?us-ascii?Q?YHOG5FteOAyDgWXMRFGkefNeZUvEDouN78/UF6D3n6YWxh1dpTZOwjIhG/G/?=
 =?us-ascii?Q?31ZGfBy56/MvFEKFCRnChndokPYb2p/9BOPpLHNtL1cEjuazb76X475bHcTS?=
 =?us-ascii?Q?lFisdZ67+2k9IX+eUNGh/9y7lE2g6nzHX/CmWcdasJ1mZJyi2aXJYyftyE43?=
 =?us-ascii?Q?j+NOUpXAH+ewp76pFCMuiYS1HeKP9iW0xP6MS5kdPW1QB1fUDQSqpOM/B4Lt?=
 =?us-ascii?Q?B6U6bb+a0ga9OUtqYOJRNXr+3jKbrDFSJ58ePQFS9bv14yqgdv766vFqAWhE?=
 =?us-ascii?Q?oNgISqJIDz2NU9rxp4+6wTETGsr7F5PxZsIbPM9NkAJJ9Iqcg76BW/ajpvbO?=
 =?us-ascii?Q?TJft0xiIwl0Wneobt4KZJGxoDBJt7+i3nfd7XtFsPS8L4DaeeQrWOWVJIuCS?=
 =?us-ascii?Q?BxmiphskpuLJAmL4m6Ed+Y/MMptyuo9ej3dWZRroN9FR1C9JUaLdCQi1q505?=
 =?us-ascii?Q?omQzbR+GQkZ5ECefzN67/KIjfzu/7gTIc7LQVBQ5Sqt5uZqY7yvpxSPj4HB5?=
 =?us-ascii?Q?Clo3UxyyHHlvzY5q/xTUJ1uRUXHxgRMcMXN/lBDa2adur/GaNt/r2ucHfvNh?=
 =?us-ascii?Q?4qDdab4fUNMHi6FAMT1kgz4Wi2QPQn1tL+0T1qKced8ACg7YUkbQqoCpWBHm?=
 =?us-ascii?Q?JA3np9GU290V4r0ItKJgqst4GbWt87fAB62CkyRrQDjrf7qtuSrJyUU0/pUq?=
 =?us-ascii?Q?ivpT0t66yuRsPqLJP1R/7YfkwYqpYuNe0+WP5odwC2SpjK9d/Z3eM2vIHKmn?=
 =?us-ascii?Q?/qiayOIygYYCG4mnA0UpVXxVp0Xlj3bZHToWjdYR8vLFlS4ybD+J+hK2OLf1?=
 =?us-ascii?Q?E6xOdLpuZYtKx8yKCl5WuLv0QfsyfVJE7X98e6K7dTmhlhzddp+tfVChkf7w?=
 =?us-ascii?Q?8zxFWl6mDLTwJQVBnaxubdm95zd1YNUdN1rIdyY+Hy52gnnjTI3KhYl2TX3n?=
 =?us-ascii?Q?sxplVptWmMXY7o99bDBgQVPIlPOD+co4LOX/Y0K13Z4m4VdqAuLTIJ13SFUb?=
 =?us-ascii?Q?Hpph/qes+RXWVG53SH++ITANUNtays9hyArHoRk8+ZpK5NkGQPh2TRe7aDv6?=
 =?us-ascii?Q?vwR4D/4+lMl/g2SHxhKrKYtk843OMEbsmgrM8GnC+T30/zyhwH+8S8PWVGr/?=
 =?us-ascii?Q?38JXvZTXhihxhlCB8vzxEWFqBouEMQTF0YMucKCOcnCsCo8Uo3jc7MDV5a9t?=
 =?us-ascii?Q?f122csqSw6hf83oGJDSI/V1P1EQyKHT7kQu63hQFcaB0dG1qeKgxDiJP2C1O?=
 =?us-ascii?Q?8X1Pu0ZhuEZsLeaci4EqAPdt2dQx+bHWuTyj73x43Vj6mtxQ5fa+C9erC+bH?=
 =?us-ascii?Q?vfgN8I1dSH0k5GW4pLOqvQq9yVUcrNCxgCcfX5rTTfwLmfgvoDTSVb+cMnNM?=
 =?us-ascii?Q?MKKsBq+Bfas2IssyQ9/it/Zjpz2srLfTtOg+4C0dEcMIG4lp78Go6jucpd0F?=
 =?us-ascii?Q?4yX9L1N1VKbYn7jYZT1+LMiUcoztpDSZv//MNdozXWsIVCgWoNVlTK7DZ7p1?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b3bfe4-8e11-4058-fa47-08de17aa96df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 11:50:58.0122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9WZRLsfBKHrFOZJwOTl8GPeDnS4Cz02XjVqsj2ZdpYkQhgwJKIWqS6INsorj3tKDNTfOTeWFHLt0bjHGXA/rlHgAXiwwazd/663Ls8e/+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8678
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

On Thu, Oct 16, 2025 at 03:48:41PM +0100, Bruce Richardson wrote:
> On Fri, Oct 10, 2025 at 03:31:51PM +0200, Thierry Herbelot wrote:
> > On 10/10/25 14:58, Ciara Loftus wrote:
> > > The e1000 PMD crashes during initialisation in a Ubuntu 24.04 VM when
> > > compiled with gcc-13 with -O3 optimisations. This patch introduces a
> > > compiler barrier after the register read that was causing the issue.
> > > 
> > > Bugzilla ID: 1691
> > > Fixes: af75078fece3 ("first public release")
> > > Cc: stable@dpdk.org
> > > 
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > 
> > Tested-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> > 
> > The patch fixes the crash at startup.
> > 
> > 	Thanks
> > 
> > 	Thierry
> > 
> > > ---
> > >   drivers/net/intel/e1000/base/e1000_mac.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
> > > index 2fa97d12a9..41aae86ffe 100644
> > > --- a/drivers/net/intel/e1000/base/e1000_mac.c
> > > +++ b/drivers/net/intel/e1000/base/e1000_mac.c
> > > @@ -1842,6 +1842,7 @@ s32 e1000_id_led_init_generic(struct e1000_hw *hw)
> > >   		return ret_val;
> > >   	mac->ledctl_default = E1000_READ_REG(hw, E1000_LEDCTL);
> > > +	rte_compiler_barrier();
> > >   	mac->ledctl_mode1 = mac->ledctl_default;
> > >   	mac->ledctl_mode2 = mac->ledctl_default;
> > 
> Since adding a compiler barrier is still a workaround (all-be-it a fairly
> unintrusive one), I'm going to hold off this patch until rc2 or rc3 in the
> hopes we get more details as to the exact root cause and why gcc-13 is
> producing code that crashes.
> 
Given no further progress on this, taking this patch into RC2 so at least
we don't experience the issue.

Applied to next-net-intel.

Thanks,
/Bruce
