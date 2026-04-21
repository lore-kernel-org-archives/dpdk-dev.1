Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39E1F8925B
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 11:00:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE5B74029D;
	Tue, 21 Apr 2026 13:00:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6502B4027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 13:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776769257; x=1808305257;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=lv7aKApAsGwqd3MEW1+XmOgZWVZItKGvfSLv32wbcbE=;
 b=FOo2bM25RCPFagFtI7XKqWhQS2qJXOoJuzvk/7jvgT8D9fTyp2NaDeb6
 9YLGHDlNMDdggS+h/Rdut9e6cR3PGVHf0aU2ljMvhxaLnDHsuKZ96BPdr
 fsNPl5UHGAHvZk4DkCCdW6KBQiShldcAsNxlZTi9qmN96DSPPa1P05CG+
 Fu4X7hLbtabqb4xCQl/QG5Wr2VajK+0sbDYPuC9Gs9hDBp7JRnclc20/i
 W++cQdIft4y+JqihewnKA3hML00309bIenh2uEoeQmXq0I9g1RWreJsB9
 DK69zHUkRTycZ1uFf3aouqwvsLRj/lDp3C6XKwHmh9hZReorMbg04qidW Q==;
X-CSE-ConnectionGUID: zNugDzitSxWUA3AK2DrVVw==
X-CSE-MsgGUID: IDhexf70QwuOrJ36rpiz/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="80286087"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="80286087"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 04:00:56 -0700
X-CSE-ConnectionGUID: GTN2GafMRCiNJBTKHM5mig==
X-CSE-MsgGUID: Aw4kswf9Q1u4SsJCMRetdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="270094583"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 04:00:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 04:00:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 04:00:55 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 04:00:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdRHtjL7kDzLP0EsjHuY91aV6R97pPdsMVnO9xPsF6TqaR/MKPcLo/NyYDNHRNpinzzN4qIbsfFxOLoz3I0ZYKiILguUSYB8hksjcLp1PcN/Lwd7ZOIVdmvMhpPs0wn/Xa2CRMqbWvQUlcwdapukPgugKnJle/tGIm2vRTI3okSym/h2u8lC1322n4PJbXxT1sbIAYrStBLZchSQ1hSCsK0bdM0KcNplJYz+bvA1gZY3DtOM7QKdoTZkQdVtLoCb4PS0mz27TCqGuwRPAq57bnHdn1Y6/BHkze/5zQUAYGukrFqBhK8nIZcCv/AKnSZ9ElrPJBXL5EYw1ttt67HvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVREK7GezoKmYz5RQYlbYc96Pj8TwdBFC3M+YEdwTTg=;
 b=X8AgAN9ZcAqThAnz19xtp0pIqoq8xcUeei+YON/HyM0iecnVlOMOqTmvm+ToSXo/BaAVQiJ1rUL5nzwA0Vpt7yKedu19hpdXzTGyZyAfk9ePyS10a6ufUjOjF9KXOaoF6lZeEaemaU4Ju4WfTMg7KkfuO/gbomwnkIFJ3oECdVGt0bw+aLbMco5R6DpIGqteufqBhCQQ8uUotqk0LIuAFOPMpLYzfWcvvQTZxQ7UYe+7iJ8jI4paiFABh3Xp9I1PjAhvgaaEBxQ+qB51cAnaTdNqMYxoKGmZIKBNj4g9G2r1RCB1o809jBiQJrnkbW2ysxibZ9WlNdkIyyVdVlZw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPFEEDD586DA.namprd11.prod.outlook.com (2603:10b6:518:1::d5e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 11:00:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 11:00:52 +0000
Date: Tue, 21 Apr 2026 12:00:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: do not bypass mbuf lib for mbuf fast-free
Message-ID: <aedY35lVWU3EZmye@bricha3-mobl1.ger.corp.intel.com>
References: <20260418095639.10003-1-mb@smartsharesystems.com>
 <aedSxmC4gskM6mHM@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aedSxmC4gskM6mHM@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0114.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPFEEDD586DA:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b8ba41-2f1a-4473-78d1-08de9f9540e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: dB7DxLeWBeL7hTfMt651Myl1B+JHaZp3AJxbwyICJniCbOLxxBhjvVoGOUmA0C04X4DgaJLLlRmspcYPLobcSY+YgZ/M17+AfjrUzGHpOU2nNh5sPElgAxBh5gI6ZWkQaXSddAtiOCuUBw3WQtz+Iv6J9GBPux6HqLiIx522ABBeJT/FJm8YA57XywL7qtcxZPCglJ6Gq3o2PARaPOCy08XGcDKUvT8JiZrvLsIfRfw22jzTT1bUYJyHnHFUZVrXqcQn2xDWhuMawA90O27lXRHH7+A2qzbofk1OtcqlljCa0pRfRmzKRBIPybK8RwOZVCU76dDuLK4Pi4dn9SyF2EA4QTXN545hrocZq6UeXW+Hi1IeXBXHAPEDrOKoV4KCqd+q9LdD5bLHGh/hyaveI7tTnbXQmIAz38CNDEnxcM7itmzoogT9092OPoO9pKWVD59DePg2zAGf+L9dw9KBt/0CTKQ9jepHoNDKXe8iW0PgrDBi1iEDD8z4tZSmAGPeZaLUFb2fN9dx/1cU5VSu15aH2b48c1YQk+rv12H6ehkf7H5EIwvXxFA1vQO3xlYXDWbctlSP4wQuNcYYfisMcJPKRqwn/UJPSrKLTkpIUkKj9CA1ILBNKOEE3tdwfZau/1Tdbe55ezmEv82NRymjtYdh6Rk5GdJrCvL6gXvPgyH+LPYLwzRcWEoPUykWwmehkdsH3qXRGYYmWJVinojt2HRm7Bp3Fr8nDkta8SzFMW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2jLF4dFfA8hJgq3EaBWclNrIUxz9GhYIz9KIPDH6GTSRDd9WoS/JRZuLKa?=
 =?iso-8859-1?Q?jEA+R5mpZ6PBioGX9pJDJtADVFPS1mEjsX6NQ3xymOMrAFMMJV7Fdf9jkR?=
 =?iso-8859-1?Q?vhmIy/QDcs02Dxnpg5g83gWDkRhxHLGuQRYQdBAclBclM6rCl70s4hIewD?=
 =?iso-8859-1?Q?eBz7dru4DRXkmvrpYlof9msc4RYf6b2XrSdl5x8ckAfpKGm3/I5nmv6G+5?=
 =?iso-8859-1?Q?YdJNxL3Bs45BvOlLswtt5fglqP1NyPU1Kx3QQlV7yJPprOYbOoyGpKLiad?=
 =?iso-8859-1?Q?nixqv7Bdey4CqA1EXi11jfZXE6MgKG2vj4h3NOkptKRGVYu4v/TZZUA44n?=
 =?iso-8859-1?Q?ZncKtjQ7d9CSpSIuBDr4NRQmbwyUZEm0PrCCHMxe1BcHTkFXDp/69D5ech?=
 =?iso-8859-1?Q?TRB4qjmJwvPYGoynn5cHp9u/sTvNRTOeDPmhbVBjs0hMprqnByJ/HIh6D+?=
 =?iso-8859-1?Q?92ht2Et5djXeyWSx9e8HTDks7MIvSl0wwtvKHC6Ld1hPY3g2cfIQpPW9ab?=
 =?iso-8859-1?Q?O7sd/BBjJ7Wk7ewsNWErQ40wlkjSsBnpGiKZ4MiD10NmHX0wbwBFaRljvc?=
 =?iso-8859-1?Q?TCUY6U5UW3I1AQoNnEloHNOgd8cmVHtCdEH68AO41ahuXmoeVPxISYX3uU?=
 =?iso-8859-1?Q?vg+uKZV19Zt9hOTyIkFOI5FLiipkyxTG8ArHRnO48QXhGSTRSozq3LslsL?=
 =?iso-8859-1?Q?Cl6rEAUC0EPxukIB+fSkOBwyONK390fBom+p0rmlgtC2ELjRcAWMPYwQd9?=
 =?iso-8859-1?Q?dvFo+xcjH1OSsUSbXlyz+5NTuY7CsJiuHGIDzutm/taWT7/S7Pnudf5ULC?=
 =?iso-8859-1?Q?j7fxqAX+opb1m38LmMRMrTroywhX8+GwcuBLtnWiCSQw+1FyOdbsdOwT13?=
 =?iso-8859-1?Q?HmnN4OV47em8kIWPIsJiONVVRv9bPr8LHuiJGwWkiYIL6Uo4OTgXLeePny?=
 =?iso-8859-1?Q?hJDb6sncjk9slnaVJ6G7LyDhpQ9qs7+gSHr73+ycWmoXZFX6eVYndpFupM?=
 =?iso-8859-1?Q?uLKh0wYWA2rHMSgSXaiFDij/lUkZ0qc4AshmFcdwLckWiX7MgfItVxERvw?=
 =?iso-8859-1?Q?Lt3CU9wnN/Ski2agYbEPfDVqqNSGKjqbQSNOj9mXVCP1ver5bchtm/FQle?=
 =?iso-8859-1?Q?DhsLL3T/ynOj1TYQ9MGVZpuCZh90ixls7uBzaxzTHfwaCchYfgnJ3qYV9B?=
 =?iso-8859-1?Q?/LHem6OOrWP+8m15GPmNA/FA9Gi/QxS+hoIlSknbzkxHNVdif2wEKIrA7F?=
 =?iso-8859-1?Q?q2oHxZiG6ZQ4uZeg5nIzaK7JusZQxXjLLivPdCf15OlHkvvSpqpkGh7kjw?=
 =?iso-8859-1?Q?8sOj67A6og8ACUz2oc4QjJrbXboHqPIaznOicnxTttAF+aDY7ULXIG6Avn?=
 =?iso-8859-1?Q?9sifVfo/+KrwpgWwpd8zUTDntH1AMcYpOWiVhRCkA9Ea8nu9UB7kTquWDm?=
 =?iso-8859-1?Q?UN9zXjiUl60LVfqzbllmjZd22zvpth62iPH7QjQfCQIDTMc5nrH+ONLmQl?=
 =?iso-8859-1?Q?1/fIRRJtRT20dbyLZLfWBTrlSEWGa/50Bu08g5ilcSjBE1zPULkQoS8Eng?=
 =?iso-8859-1?Q?Nr6cj0MVX+tbIiIc8bNy3krjD3GDXRlV7DdHBONuUYmjXfuvyNuS0l19KX?=
 =?iso-8859-1?Q?+dF///lI+m2MXqIPfQ4ECDG60Mb/0AgYTCNjVkgnu147T5UfmYEO9JMWuX?=
 =?iso-8859-1?Q?uaIvGoN3tiDEWnJ1a3gXXG82QPomisWsP1d3HG2vVrH3y1zoXI9HwdGxAn?=
 =?iso-8859-1?Q?iovv5qYHwtmvfUenZgcYAPROhnBVpcTBI9MChM/iRBD6kg8UneMftqn0Up?=
 =?iso-8859-1?Q?HyVq6AmdYqF0CrprOyyo4aE2r9Ns388=3D?=
X-Exchange-RoutingPolicyChecked: HfDHBWeVs2hWIpTlQ+Mpame6itzxC/HN8NAKCZ4Bo1I1u4kBnHWAD0r0oTKpGvGqSgjJjuHMWXcCNtACj4rVMBzWq/87Q+6Dow7vPqj/3YAznSYSdXiZWPD/gQwYviNjmxXo+NKhUW5QlUmUAdJ00ycHog/ZmyQushoORvXYDcfvtyjJesPYlDx5vlTu86IQeL3/yPDQOmd19O0GpEI/j6F1NEOJXQQR7iDLsxPlSwavgI3N22eW2hTr2I5ynOWmDZr+ZbflTJD4UYQ9iGVVzBdJ4c2prh1MkWXOBgwEfHgR5xn0fha2lufHa6R4dFwiVlGdQiFKpCohhu13jjZM+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b8ba41-2f1a-4473-78d1-08de9f9540e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 11:00:52.2686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVimywntIL1HywXEcuxRKSewlJEu26l8tzwPBa7+23zFxZi3zZmxp/yc7w8mJrmqy3T7MqJLDBe0nlwrpxVOTKKiO4g6nnNiAD/3zQ2uijc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFEEDD586DA
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

On Tue, Apr 21, 2026 at 11:34:46AM +0100, Bruce Richardson wrote:
> On Sat, Apr 18, 2026 at 09:56:38AM +0000, Morten Brørup wrote:
> > Freeing mbufs directly into the mempool meant that mbuf instrumentation,
> > including mbuf history marking, was omitted.
> > The mbufs are now freed via the rte_mbuf_raw_free_bulk() function instead.
> > 
> > Added a static_assert to ensure that type casting the array of struct
> > ci_tx_entry_vec to an array of rte_mbuf pointers remains sound.
> > 
> > Performance note:
> > The (n & 31) condition was not removed.
> > For the default tx_rs_thresh value (32), the condition will be true.
> > And due to inlining, the rte_mbuf_raw_free_bulk() ends up in an
> > rte_memcpy(), where the optimizer takes advantage of knowing that the
> > lower bits are not set.
> > This should compensate somewhat for removing the handcoded optimization of
> > copying in chunks of 32 mbufs.
> > 
> > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > ---
> 
> Ran a very quick perf test using a couple of 100G ports, no regression
> seen with this patch, maybe even a slight perf bump. Therefore:
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Tested-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
