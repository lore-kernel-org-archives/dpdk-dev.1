Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B11EB26F7
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 18:04:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C564F4042C;
	Tue, 10 Feb 2026 19:04:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id E4DC0402B0
 for <dev@dpdk.org>; Tue, 10 Feb 2026 19:04:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770746647; x=1802282647;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=baItHQIX88v1EPQClEViVKQY3M2RjwcEB/KPceKXpeU=;
 b=gANL219FqR15K0XlvUP6dYiPyNL00H+El6hc6JG0CxE/AlhDClffYJyH
 h+V925+UXQdMCWWL09VntfUnutxm4CaXT85UiC6ovnbTpV58L184vAKgU
 9TYw86rSY9ynCz9oTv8NWNwthDI2lGd7cAwyRsdxsez2rGMY9NfROmn8O
 F5swKeLnKdDv+Z9JI6cV0tYrbBsOhsZEQ4iH/XJJfqMWyyifJIjwgrDSY
 KBe4e3vdj3FGMi06ahSqoJ8kOKkMg6NIrGtgqyHsIRFjMkZdqF8qRLrkD
 2zgD4SVNcC/tyLrBaJsmPveALSjSJBGK48mGFL72+Uzintt/Ng30v/xbA A==;
X-CSE-ConnectionGUID: HLU8X4OORPCrfZIu66P1FA==
X-CSE-MsgGUID: CXL+0UPPTWycMehytU9ucQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75510054"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75510054"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 10:04:06 -0800
X-CSE-ConnectionGUID: wiG9gc1WQ/msKm/KjM8eVw==
X-CSE-MsgGUID: lODLEZKHRA+FnVWx7Hegqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="242615889"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 10:04:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 10:04:05 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 10:04:05 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 10:04:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiHAXiy1MRsKUCVpgqLPBc+/N3BfkbwehRgXxRjKRmCmUpaKpih/gWVLhT/LIYIkJBLeN0uK1YWio/bz1za3RptpEpU3SOeCKHj7crQO5ibOOy3mi+oUFXeYbwsr/Z2GLCT78fuXZdL3WP4aHm9tMpf2SZE2EoYfDABb3HOYn/hYUKztA/Qg1HcvBE9f8bV39d8xEntdSu5SP38+F9KPDvffQGtL4X/4rq0+/ZNyEOWFGRyWBREkZuoWgyTF7qZbJL1MCbeifzZ+TgU6EFbBUt6RHQJ12g/y8+vQRZboCVCk/NmQ0BOmAv910KdE1r3h269uPF3VwTI+4YKtrtF5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RVwGbH4khRGZ78fUSOEwqRbxCT8rXqz5eItHtAKRQE=;
 b=vMq5xmnf1VgMWRmPYKXF9l/uQZ1Lx+ZPUDor5ixENYIcNXKqU40C1x6HhSaB2ueOxwi0cOM/g9GMPyTj+TYXDqGNvUfwmcgjA6YSSvnXcktP/vVnffyK7f6KXi0ShhAYet/n6tdGBZRY0S/RjTKUikv98XP66YkjCjcOLze0W8MqlgLLCZttvnceTjQFcRXXYctkSc0BNMP+yZnEFxNs8xrbTpcckk8W1IugOg5PZDtgmiqpBfGYTUq9ZMCB44R/AX3IGgke0iLwQN6DTGu18nWfYcBoVgYc+goIDPSeEQR/nJKVTlM2GRSZ5sD7SNiGRO1e78K2RES9x6+W7ygBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6487.namprd11.prod.outlook.com (2603:10b6:930:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 18:04:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 18:04:00 +0000
Date: Tue, 10 Feb 2026 18:03:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 11/35] net/intel: create a common scalar Tx function
Message-ID: <aYtzDKUZC8fmKMTP@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-12-bruce.richardson@intel.com>
 <7dc889e3-f8b4-415f-a911-d3e14acd4cbb@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7dc889e3-f8b4-415f-a911-d3e14acd4cbb@intel.com>
X-ClientProxiedBy: DUZPR01CA0117.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dad5a94-5090-4961-c99b-08de68cec4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h2U4qrb5u3FKSgJoZkrHoYFXGgPD++GMNjM06uDusfOkIfVf0PElJ0aH64Jh?=
 =?us-ascii?Q?Us0wBBN2kAewiK64J5df48xQT+eofvxzvIaG+0Bl0IUcqUoc3HMcRSuZFYtU?=
 =?us-ascii?Q?Ftv2ErJO+oVsXxBEJm0Xl4nT2V2Mx7v0+ZlaTR+ld0DWnD+hG1O2Vz/wrARX?=
 =?us-ascii?Q?76DM3Ireg/PaHaI/sJ9sPqxivrsRbmEFPZGNLDYXnj25wEaXZXwpEaqBOWSv?=
 =?us-ascii?Q?empJF0kmvqWg+aw4jRem8ymLpJKnhsymcrCWv+FeattVm4ZMzNvM7MhYnbCI?=
 =?us-ascii?Q?Iv8eydvBqz0eBcBvR8rnCXiF9NkbTt1XgmKhQ7SoPqOLm+jx3d8HT9flyI1l?=
 =?us-ascii?Q?OeF6lks75ZBWibsJE3pqNGzbia7tf6ldqwZ4SJE342V8yM62B9yna7wXNejt?=
 =?us-ascii?Q?zEi7cIzOseGsPTtNgaKDTWd2BoFOCXkc6mVTbtniYpuknf47hTzSEYyGE/ML?=
 =?us-ascii?Q?5+wmLXnyDCfEMnwxnDWAmhkLpjwRIruC1sX/c3EkHCZBTUH7KGnUCHJyvdVA?=
 =?us-ascii?Q?caITUwWjnGh+p0ZvL5ArAzEH7X98+uLRPAiRtrZnPACLFkowbLVNHpz2+VfR?=
 =?us-ascii?Q?y8hocjWyuzhZX3XtuQC3U1e2MyukzvYdP81go+OH9iRCmnEK9Xz3LeJL5BOH?=
 =?us-ascii?Q?HWPLfSP/CJaeDT05u1Qaqw5/hnS25WJT/fhHlCETbZz6+ZuNW4BvHgdRFa96?=
 =?us-ascii?Q?T4WvW5e2iI7NEgl/QjiJ1+SF2FkRH6tdaHfaxYlqvbN3HK/PbTFU/roTn9/I?=
 =?us-ascii?Q?gaBHYaHqUkuukHJC3748Rutgs/8QRXImxztskUHvbXdnByMmZ5UUFzkel7ty?=
 =?us-ascii?Q?bYUl1bLQjjOx3etN0GsU1/FTbHPdkpKmMpKfp8cWetG35a8Vp8SF4W1YKQs5?=
 =?us-ascii?Q?j0+xyGN6etgdYigQo6kTZk7p6uGnni2S2ffi58ms2y08IyzF68fgZY8tsLUK?=
 =?us-ascii?Q?3nFWvwk9eOb8Av8zdxBRAy2TM0IbO1Qxad2jSN43N6LAF6vJxTPcv61iZlY/?=
 =?us-ascii?Q?IADBwXGMUD+xIuLJCWHENdbp709akr35S4xFObQTGlmCn5hDFcWbz3VeEvNO?=
 =?us-ascii?Q?McdapydE/T3orkap92qN6KZyRtKLCEN9pULuIVgVBDyMuTu9u/9aBTz9/Uee?=
 =?us-ascii?Q?uMBBdyJSDTr+GirjW5eFkcVuRVeuVaosmEmKXrfmCSyelUoRtgj3nrkLeIll?=
 =?us-ascii?Q?Su8OOfuwYWteXrSq5aIQ3lZ80U5DKlR13f781T4lShVK+JddNF5A7qYnZXFD?=
 =?us-ascii?Q?Sa1BiIv48p0zSPsf1SfJHqkbF0XQyzNpAepJrTm62rI9YCHlRAIdu7IUFFdh?=
 =?us-ascii?Q?+Z/34adT/Q00cjMNwEuGE2whHxRTT8u6w8aYB/7c19sElWH+9Ac82uvbIs1k?=
 =?us-ascii?Q?9zBTnkC1ooi7GKtW3GXKRYOYo7ElYwJSaHduPJZKHVqWfPFkryvRECb9NwwX?=
 =?us-ascii?Q?2+LCTVA4cVF+uqpxpZLvN1tQRRV2X6FhlZS41weGelEdvkLQsraTh8NR0PZV?=
 =?us-ascii?Q?AsKgpnWewtYzKy8PftJBGo6TOWYxLX21LbmWXU2PPtnAG3FZDyT/45anrJW+?=
 =?us-ascii?Q?HPxHrXbdkK3EKytdITc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yHHdM5263Sr0jVWJn4qG/GYgvXuhkgJ9yPAV3M6cfBA2iyWXBHJa8LJKeL6Y?=
 =?us-ascii?Q?lrUQSEjGEdkEV9qlVb2/6Fr4/vh3+5Jcv18ywCo7peSl0ErB1/WFXDGvwz44?=
 =?us-ascii?Q?e17BFZKNATJq/uI7X/oKGDMv+5ZbhV6OHuyDA1n07oHCEAl5bt1NkgM1BWBK?=
 =?us-ascii?Q?v2I3aYyjgB9SADUDObgzk3T3EpXt2NDrUvPZS8ec8a5GNJbwfKQcotmXJBsC?=
 =?us-ascii?Q?At2c7br/d5cYH1CamC1n2KAFebwRLH9uapFRmX5h5bjqhHXUFsXmX00AG7Dc?=
 =?us-ascii?Q?FCoK3HM6Cnu7eezzFwB2O9xRxbLsAspSMSXzuPS0D7iAZxGdy/ra3iHzjaSA?=
 =?us-ascii?Q?S14JfnVAZSK8udm31058DJz6hReuof9Omj5BdF8cHNdsVP8BaSHSpQGhJERy?=
 =?us-ascii?Q?w70k9rJuXxEMfRIpHPBEJkq9y4PL24J6idZcfVTOT/okGxMMmgXEaI44VYY/?=
 =?us-ascii?Q?gHpkR5aICKI9cPs/kooiUDyc+7TPN+hzxHIDLzwZLS6qnHDuOhfnogkd2UrA?=
 =?us-ascii?Q?6K5TFg0H+Mrq625f8Cp+eXHeGnwQja7/qPWbjILJ0hHesYPxzuo+V1H5jp4r?=
 =?us-ascii?Q?xnWdWylJ5anbKz79viNGbXfeGAkBYunZ7+TPWcJ3jH4/SFMUlSEgl6clgzc4?=
 =?us-ascii?Q?1f736G6jqFZ4CeZVZnmUqty0wi0gCsetcVaaYMFmahIWz+jZMNsITX1LqOxP?=
 =?us-ascii?Q?M+3SVESzfq6ps85uu4GT/f4UWqBaLIObLQZYWtvYhDsNccIag/rp+WMkZlOw?=
 =?us-ascii?Q?7HLpVIBEOUxwfoJnQf62ohnZNNMeh4+z5b6eED/tasJ93tGs1CUeJmmhgKxx?=
 =?us-ascii?Q?MZ4C5RnK54TRrYpjsB9VJIU9zEJbeD+DNUUgyawC0pPtlYFJ4Z7X5e7bdyhY?=
 =?us-ascii?Q?VFJ1h3LPa97N6nrOsRFsdSy6e/jzTYnysp+5Tfj5obgWk8qAFb96dODmNryV?=
 =?us-ascii?Q?WYzYWeaYnwZLg9NUtnm7yYQlE/CN+kv8rLbeFfqc9h5KapS7PrUgAAadzABF?=
 =?us-ascii?Q?DKEyhvn2Bfjsdss8hPr0Ocd4zCZur6EavUy4olw76MTSCWkxrgKV5HaKjyED?=
 =?us-ascii?Q?rtpvuT0BXNNpxL+AYeyR8SAwYU1jTpbmwFRfbJsOhmmyEW+V+1ZLE+4vxIhS?=
 =?us-ascii?Q?WrtBjSbGd/Pgmucwt28ggTMsPKTyElZ5dSfDV0l3xpMeowZtM7FHoQbld901?=
 =?us-ascii?Q?4oRqx72B1dIqR9epA3Kp9BkwkhgutkiSrcqNZ27Y577pkJAJK8SknyAgDe7q?=
 =?us-ascii?Q?bevnZtf6jKKAhmGrp4byYiuzPYJcMZ3ZfJ73jGMNRwFQ3GYo+tALZYBBRVk7?=
 =?us-ascii?Q?J76H7ZMdxM5D35Nr/iuuDQcmE0XtRnX1eSYUtfOH2u+SxvmRLUQdW2nQ00pN?=
 =?us-ascii?Q?Yt0ukASAezpeE10KSoKdLmtH7C40O4VMoMhRS/zxiVLrKblEgIY+VX/jpcQ+?=
 =?us-ascii?Q?rFvJ0JnmuAU51UVN3tOmX0DU9p2rasnAIqR8ItCRQL+J924zRCSvcj12hozr?=
 =?us-ascii?Q?8ctnsW1jQlYzkMV0aQiZvkJBq1It4uKlXW378lMFDt/9zoAGbLbJcoInMaUU?=
 =?us-ascii?Q?yMiSOgBkDXTmJb0GWWA1ttHIpKciScQt1+HcHt6pVaVVWZ3VV9LVoCsozYzp?=
 =?us-ascii?Q?oy9nu+v3aBpljrmvBRx+w6mlyb/K6/gEA0Q3k/PDsO7HSrNX0gTI4iyAxXJh?=
 =?us-ascii?Q?lfS+DrMo2XUeprMOHuFb2KQLP5cqCgy6p04zxZ26o1A3bYLAm/hu/bziSfWH?=
 =?us-ascii?Q?bkgDY3hgHqngqNWV6uQvOgNtQ4NVvsA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dad5a94-5090-4961-c99b-08de68cec4b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 18:04:00.8673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qk/I3gY9YRCWSN6Z4VQtfxurpHOyrlfaEA16tPAyMJiquaYP/ZkUv8kN72DzAVqVnyfhev5n1lel1BwzM5L1NLlalvHZj1va6z4WIj5MdSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6487
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

On Tue, Feb 10, 2026 at 02:14:04PM +0100, Burakov, Anatoly wrote:
> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > Given the similarities between the transmit functions across various
> > Intel drivers, make a start on consolidating them by moving the ice Tx
> > function into common, for reuse by other drivers.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> > +	if (ts_fns != NULL)
> > +		ts_id = ts_fns->get_ts_tail(txq);
> > +
> > +	/* Check if the descriptor ring needs to be cleaned. */
> > +	if (txq->nb_tx_free < txq->tx_free_thresh)
> > +		(void)ci_tx_xmit_cleanup(txq);
> 
> Why (void) ?
>

Not sure, it seems superfluous, but I think it may help with some static
analysis perhaps? I've seen some tools warn you if you generally check a
return value from a function but fail to do so in one place. The other
places where the xmit_cleanup function is called here the return value is
checked each time, making this the outlier and so an explicit "void"
doesn't hurt.

If you feel it should be removed, I can do so though....
 
> 
> > +		if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> > +			nb_used = (uint16_t)(ci_calc_pkt_desc(tx_pkt) + nb_ctx);
> > +		else
> > +			nb_used = (uint16_t)(tx_pkt->nb_segs + nb_ctx);
> > +		tx_last = (uint16_t)(tx_id + nb_used - 1);
> > +
> > +		/* Circular ring */
> 
> nicholas_cage_you_dont_say.jpg
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> -- 
> Thanks,
> Anatoly
