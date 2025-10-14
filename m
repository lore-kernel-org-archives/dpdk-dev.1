Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA8CCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 13:24:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8891F40650;
	Tue, 14 Oct 2025 15:24:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id DD98B402CC
 for <dev@dpdk.org>; Tue, 14 Oct 2025 15:24:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760448251; x=1791984251;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=w/P2hOCFlLiNsVEti54b57dUZQGHoBIBgLkQP+wb9Bc=;
 b=AjmCuM5IayzCgUpErIDFmLdYkLDHfe6SjmMr7KEu6RN1nbYl3MKGpETB
 P65zjBAfKBcRKt0tU5pAyephq3RgftOp5fBihhyP3BJreRHj00LbejYDB
 OcnVkYgFKBsQWdP/4rBSPQJMuxqxjq8QX/TWWbdxeLayIN77X43reRhsv
 NRkBqzlF9eyBNrI9y2Qu3X1H2wL7HLefzSgiFG9NjBzS/VreZGBMDaUni
 jAxMctyJMGLpxSUTdTHl5BqLJQzdTP1mSsgo00KOtsE663NXIjSucGZIP
 WpnUSNHds8YTq9JolWxvT4Zj2J8XH3Ymn5kYU0K9/ndnHGWWy3b7J1JBr g==;
X-CSE-ConnectionGUID: RuXg/fcQQPWI0dKHuFgFZw==
X-CSE-MsgGUID: +KsbMLQaQCa7JHpkii+duw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50168286"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="50168286"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 06:24:10 -0700
X-CSE-ConnectionGUID: /eRiKiIXQ4yw0zo14gIC3Q==
X-CSE-MsgGUID: LIKV/uqWRseiEJB6jauo1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="185897033"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 06:24:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 06:24:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 06:24:09 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 06:24:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3q+vrrBAt72qecUGhkwu+3jeoqQ/KmiFCUDiojvml11vmCNen6qhGhVGa+pEgypQoBYf26ryF5pDJU4cM2cJA/fqrGtYID2AVt3VmHaGoL7C0vDU6E5pmmtmbNqNnUdtI0LyDFR8NLbw/J+QcMYu36Z3twjXhkMwfj9M2gKe2/lHZfIpNiY6mYsbJdtFWzqKQmJdPOQCWJVRaAiyzKyFrQmp8OI/G6or0VKNrp7ABcGcav7K4rPYwjd5rcZ4Nwk40bL8IxhisFRpscT5BCsNch214UpppaK7yEcS8KGxKlaUnAnd2UK/Oz8Md+a+0HQKgFvgqe313MIrHAdrWGBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdla9CqQQJMrRd1UrX2jRuqzxwzN1ZAfdMKdYz/JUm4=;
 b=Wv8LKBtliGvIGV8aq/hrncFULCf1G9eey/mig3GOPufqFXzmgrcagbll/VElZnjDNYbkAHBCHQXNr2yoPZ4bLEDV+AtMzdvsRKJr4oaKicdVKv2Gib63+JoVDG5kzYzAjX+i8L3YRorcrbOHH8v7423TmCH/Mbzg5aM3f5haIIHftzsXI4G/TvI4hO7pCjwTm3854ASt82Uc/ukSZ8staDfpbrT7KH0ZTJ6UGyTshrCKN1REmWDiyHtNhYkYge07Af7VmiWr7wK6CC12y4GiTDFAXZZzOfZ+q8TRmLCYS1H2lDGOLAK6GHoirJplTCIrfMT1HR4RXttJ0ENxVmdIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB4939.namprd11.prod.outlook.com (2603:10b6:806:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 13:24:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 13:24:05 +0000
Date: Tue, 14 Oct 2025 14:24:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Venkatesh Vemula <venkatesh.vemula@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <shaiq.wani@intel.com>,
 <david.marchand@redhat.com>
Subject: Re: [PATCH v7 1/2] net/idpf: add IDPF PCI class ID support
Message-ID: <aO5O8fdbqz2C3T-W@bricha3-mobl1.ger.corp.intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <20251014104511.459215-1-venkatesh.vemula@intel.com>
 <20251014104511.459215-2-venkatesh.vemula@intel.com>
 <aO5GTZ-dW72KBIrF@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aO5GTZ-dW72KBIrF@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P194CA0004.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 20223701-8554-4a36-d9bb-08de0b24f2fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vKkStN2mSmpHp8f1Z/RNpB22R1CBUha3nMYNEXdYAJU/0jE5jfAEq+pbnqTy?=
 =?us-ascii?Q?PiDxeOJxp0k9YxzXybci9CgC3trAmsz6wV3JnuO8Es3IrfGBOLZapoZypsb8?=
 =?us-ascii?Q?0KIBbT69t9X24Z4aORefIbxzqXqNVW3rhHLZAIOIG3jUFTDN3JuFpjhhl/Xk?=
 =?us-ascii?Q?j+ZNWyxatB80uidGtcbSSAZpeBZVGhwSnIP8fxKGRzd8QYrQdTRsRHsC9Fgu?=
 =?us-ascii?Q?Qt/TpaUTQHyVLkY6BlDxxhqJpZZGKVx0KHUSSd55tD0rKl68iBi3BQmAJSf7?=
 =?us-ascii?Q?ILL4v+LPiyAh8N59IZ+Bz7XDbVpuXHbXtZvsZxBsqz5d15kakRQ8MRjJMHj0?=
 =?us-ascii?Q?kolaPfXC53yUFRCBjCeGhk3Qcb1MZV31+Qq+em5av/PcQgZstYFCSVojzt0v?=
 =?us-ascii?Q?x8VD85WY4cNQhTVjqoS6g/Rwk0zW8lCy9gOWvU4S++QkVfxNVMq8oTW0/zhW?=
 =?us-ascii?Q?Z/vwHwARQ3pHx4mNwTfCxHhlAj9c4s/O5nvon6EZpPskiqR7/nYTrumyta9c?=
 =?us-ascii?Q?7X+8+OwLkoZA49DXKegrU6PUPKO0n8HdWeu2qKG5JGastP4Xuu6rI3a31pYm?=
 =?us-ascii?Q?m5fuK3PFRSZYx5cXqMwMCKEUeL5gOVC+diJ1HMCckwpAExTGNTRRE6tntJmK?=
 =?us-ascii?Q?M0UhTDLQlIJnpBe9iG8Ter4vQ1LL/NkxXxIwCDNf8sI8C4czIaBEKFveZSdV?=
 =?us-ascii?Q?F+Mk6pIOovzjSdu7TkWWSI8bhB1+siA/HYQhshvhk7QcXMyAFlOG3kbLL/HC?=
 =?us-ascii?Q?ngpeMboHAa+ho4PCxJ+UlPgDQO6Tbpo99xutmq+InF8gINmRVAaqM5KFIQV9?=
 =?us-ascii?Q?fRDIw0IO8PmyWsEnwDUJUvYx9imZ0OD9bO89sQfH3QtO72kZpLXOhVKfmGfd?=
 =?us-ascii?Q?rUBtEu+UpTu+zRhVWcggv00ugaTEL6R27ndnWCH/oyDcDyhkv6pFityr6RT+?=
 =?us-ascii?Q?oGRqoEf7o7FxQ4SuZgTdunY1NT2TZFMlY45JVNdaQ5qodruo+4/vrf5h1vDp?=
 =?us-ascii?Q?l+u/11mjM4QqwzYQkJjsboU77ypT+T08GmJ2rJDs78e09r28/Q761PatprwO?=
 =?us-ascii?Q?hl44w4P+4V0Qng4RIVrBPsveaaLnQumPXDAFym0k5KFJQQ0sW/p05TCBu/qF?=
 =?us-ascii?Q?jci25JbkU9lFMVkomp2ke48d4Zjk6zv9xK+XhQshuOJ2YviVi5WS9zC+lvtw?=
 =?us-ascii?Q?wxbwDdSNrcCSCYQkrCquHAWfttF8q5Red6+rw87rGKRVtOTGnjk27TIxQ6En?=
 =?us-ascii?Q?6kP3xQdibw/kTrcFDBoJEjMxi4Ju9MGic+1+1oolUDh36DTFSkCtOIMJp2hp?=
 =?us-ascii?Q?Tg+pLwyvsZH2OdrHk+bXkyNb79pDiMfgJhXxD+apb1qQvTmPermiO9AmXU0/?=
 =?us-ascii?Q?X7YVxibHbQHDmQAXo+csnibIzmMbUF4S+oQJj6ApQXuH6PthcZBurf5mv22o?=
 =?us-ascii?Q?G7WTFrHblYt4Gh5vMmY9py/B6Yi85Xz5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Zi225qD/3c3M4f+znWV9jHqTE7Cz3COe0SPZTvY9HWNzQ+UpD36bbhny5+K?=
 =?us-ascii?Q?zqCCA3JXAf/RLwILOX/BD9brYRWeRYcdLZkz8BVAG5LwHcY2yBv2l10/rQi1?=
 =?us-ascii?Q?jj6Zb9xwDcZHR3TcKJltwdSScmf/xAY57Icn2YRs8gcgL47bojbEa2JnfbBl?=
 =?us-ascii?Q?z29g0vj29eUwu6/BmAR/gOEjRr1ba7xqNTx2Pzl4yzBCYwmQD5mhP7VOmIlt?=
 =?us-ascii?Q?C/MYvmKUOVu7VYlKoCweRVJyhM1rUFYPhLMOgQrI/wZu7tOK1Q7jkF8ndg89?=
 =?us-ascii?Q?GNtpSQ8giF4di848nq9aI87ZgXfYUe92AhRrDssxQNaIF9IlDD/ZwepXW/SY?=
 =?us-ascii?Q?0ApV+Zl/qsrmPzfNaYGWIzLjVFFsqXSGG6jsIdlBDe3tWqCf7K6FkNZ9GfIL?=
 =?us-ascii?Q?zzy8zeNGVEqXOqwcEvacLKOMAN8HdqtczNuY/l/UpfArb+f/2Oj2kOoLg8mo?=
 =?us-ascii?Q?5ebdYb1wYmecavwOMIP5/FSch7V/qlSSASeuFdt8joQod3HbB3MFpZBPDshs?=
 =?us-ascii?Q?QGuw5pdxGNqBPX3HWwt8iM3oJipCr25OR5Y/mnycjz+DRiykt6Cr01Y6JML1?=
 =?us-ascii?Q?qddpLkx+fI69ebry4sIiS2jrSh+7r74b60dB2OEyZKpW/zY/c6HJb7LhlXoX?=
 =?us-ascii?Q?ytVQP6OZ5NwAkOiKZVINmQkToUoWUO+xbqGPy2LUU02SCs1Wt6ugfgTjsENP?=
 =?us-ascii?Q?d02fbcYO/Fe80ukmxMz4Zy0uOTwbSvLjomtwuwEJsfTtuB2qFLWFm6Mc+PgX?=
 =?us-ascii?Q?+bR7nYkaFDpCuvxgUw1CpaGNchDdUeJEz9RNxejurOjj3ruNJnolyLLiKZJ7?=
 =?us-ascii?Q?g7+15qbfA8D4BvoppQuHnP0otDU7RrDMfDi3p4xBRnxCu4+VZl8D52ilzwAD?=
 =?us-ascii?Q?DZeF+jymEQESfH0yiowQBoPEAI05DSLIFLOUVxdgRpfQzXtX1jlZQMHig4KO?=
 =?us-ascii?Q?bNVPk+pCq045tKcXzj0YcwtbiszBu69puieEC9Zv6tc3aKN7gw3PAOjO2jMD?=
 =?us-ascii?Q?94uHq8TxqchbwHM3NTby5mw1KrWhZOdfOXnqqqslt6/MtTl7CRlB0M3PRBbK?=
 =?us-ascii?Q?x0WodDsR6bizitfH5qJm+7BigwJ+mw5GlDzIY1LCt1KTKWjbPulf9K18SQL0?=
 =?us-ascii?Q?Oww4VwcuaO6ehnsyTPU4QhqD4pqaEiKrQr8/tV87pAlhopcQhXchPh3wQ4JT?=
 =?us-ascii?Q?vSwGFXAcFhs8QCILt7XK3AKSK8ivA1nEroU58HQaKITdbHAAIdp3r37P2koP?=
 =?us-ascii?Q?PvAQd/ZkFIx5kB/WRisD9iVEUrTq6vEoRxIdUcHLLe1/LjhGZnR8XVL4DbMW?=
 =?us-ascii?Q?uVJdfEI7fCEoY3pjO7D3yr447p1B/4QtfFShVBN/GRW3/O1yhylg20q5uihK?=
 =?us-ascii?Q?Rq/YsAsH+oAdunIynY9aey20QbK4W5NkSf9x88WgjqId6GEAxfz2AfF/jR6+?=
 =?us-ascii?Q?lwgFGmlV8gbQ+xqKZJXxN0pg3R8YUAntGywwP0HHto7NN2v5EuHtW44/f5ta?=
 =?us-ascii?Q?tnVwi6lor0CN2dTmkI+KZTRQ5oQm3MLpmzJYIXUudeQvr3aV75jCIE/MiOMp?=
 =?us-ascii?Q?d2lvig1TuM3CDHJg8UFM+TuQakQgb2hK+19MccxzyXb6ci/0Jf0+0+SX/YEx?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20223701-8554-4a36-d9bb-08de0b24f2fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 13:24:05.8750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syrC7bejwJ1XJClpAJHu4AvQe1eKSMDbFhXDYtdmUAx6hMrnSpA/zGnwFYmrUYFJPpT7CLJDqoJZJaHqtZP/MKSz5jN21v1rB9lpBP4VLjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4939
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

On Tue, Oct 14, 2025 at 01:47:09PM +0100, Bruce Richardson wrote:
> On Tue, Oct 14, 2025 at 04:15:10PM +0530, Venkatesh Vemula wrote:
> > Current IDPF supports only the MEV device IDs. MMG has new set of
> > device IDs and same might be the case for the future devices. Instead
> > of adding new device IDs every time, make use of the IDPF PCI class
> > ID(0x20001) to differentiate between PF and VF.
> > 
> > Write and read the VF_ARQBAL register to find if the current device is
> > a PF or a VF.
> > 
> > Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
> > ---
> >  drivers/net/intel/idpf/idpf_common_device.c | 20 ++++++++++++++++++--
> >  drivers/net/intel/idpf/idpf_common_device.h | 18 ++++++++++++++++++
> >  drivers/net/intel/idpf/idpf_ethdev.c        |  1 +
> >  3 files changed, 37 insertions(+), 2 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Series applied to dpdk-next-net-intel, in reverse order and with some log
rewording. Please review to double-check all ok.

Thanks,
/Bruce
