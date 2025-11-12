Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F0CD3421
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 16:26:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADC4140A84;
	Wed, 12 Nov 2025 17:26:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id F0C1C402AF;
 Wed, 12 Nov 2025 17:26:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762964774; x=1794500774;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XdniEdFRQaZ8wW1ow62T9rBB3OHQzoWP8c0cpSMvnPU=;
 b=Nu22c7CZJzHcoTpZ4Hv+hxMQuO0YvBHw1XXU4MQFDzE3kSVAflCkWVoU
 MTtwRmuEpO+vx3PAygcOMgXICMDaMQzItAx6Dp7Y5/Txk3Tub9+8fdqkw
 SDeEr++ProXeyPwkIKynNO0H2q0hRZiWhvxvJca7eqJUN9NYlbHFO3frg
 k2CkMnOiJq493BLozv6wdRKvcBi41xuMlrAlStQK4qFI+tu9kgvu5CbUt
 1A6HL9mQgVQeygjtSX3tLt+bYrnC3SNBu1sPEMP3yOm1CWDgNj8L7gOCR
 eCjK2dXzm0uJzQdrXf82r0AVcwrZxUyx80IQOaJGDAjHMOukD28LcEjKO Q==;
X-CSE-ConnectionGUID: wHlT9F5LTD6R/nhicAVCRg==
X-CSE-MsgGUID: a74xiM+RQY2kfN8oskia/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76135352"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="76135352"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 08:26:13 -0800
X-CSE-ConnectionGUID: lYPX0AOpT4mUyuLEpq5aTA==
X-CSE-MsgGUID: wmminBumT6qk7F3xjEH1eg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 08:26:12 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 08:26:11 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 08:26:11 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 08:26:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHo5fv2RExBjvJISZUtL3kN4IGgXD7dc6WTubiZ52GEC9b7iVCyRo6rvcaIfJ4EkQp6t9dhJcxWqtmE3QkL3uaV+QYXxnuGmPJ44GaQ8p5ucmzfV6uKc8IihREljroStNgKjCthwb8gT4JRPEYDLkXLF305xtcVRS6ZchKgqWmVR0dm7JS3dHg0PuNyGe+o1LSk/fax3lDwtgCNs/URXRzZ0hemphthfTInt3yRumhz8e/mlzzQ1I8Qc05WInl++B5z3eMPTR/9f4AKW6WHeK3yJPHUu0TrdzfHPcR24zIQP0ssg1wORUTR2xQhPIHUZdeRqz5rsJVS/eQjzWmG6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=casHohu+cgSDpVY0bNIaGPZFxDAsdNd7PAS2Pc3Ou8Q=;
 b=ZVVunVW0+aPXbOiIIgQiiDMOGKZmC+1JgPFO0FD1MZW956T08Am3cufxUDA5EVV1QzE1QxNjUSkzFDjq10mTPqvdMMmHzhHN12uz2MC6TMvPQH6FXTXfNct01BuTnbEeQhsLNBQick5qRd7gdyDf1lCgeQjrjmlv3hZIRqXnHQgav0hfmDJZwCTQdSe8rINE1QfvF7NANpwb/9KZoRIu8gAWwYs57fEd8P8MNxD6Rw1ZTzfJ3mAMDJjBzRLGgIkLLk2eA6lgZoEmBjkH1nGmB9kAolEvp/Hd3fVBwqxLgKZGm0IHfc+5PyFoN8rJbx3W+dxL353U2vKEYQOVIa1k7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6970.namprd11.prod.outlook.com (2603:10b6:806:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 16:26:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 16:26:04 +0000
Date: Wed, 12 Nov 2025 16:25:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix path selection for QinQ Tx offload
Message-ID: <aRS1F-DcRk1qoPzF@bricha3-mobl1.ger.corp.intel.com>
References: <20251112115726.1286735-1-bruce.richardson@intel.com>
 <DM3PPF7D18F34A14733C367584A08902B1C8ECCA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A14733C367584A08902B1C8ECCA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0346.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: e1604500-fbce-4052-9646-08de22082ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UWO7gaYFPyp9CJAole73G8fewKtzew98NlCybvdncmizZqcT946+qI/iY8F+?=
 =?us-ascii?Q?5QTS1N4NNO32U3/B6Mpk6gR8rqiPtyw8dHPiAEaxOrNhveHtIBJuTViwSs5p?=
 =?us-ascii?Q?8wPRhXdzasZdKHVkTbqcjQx9R+wV9gJk4C10q9qYj/x0xzvQmnjsgh5AG0nQ?=
 =?us-ascii?Q?0852WbfirD9pkYAmZ2SBCgebIHHQlIUuMkmtKiK5oQinrMWi1I4wTD36NQoN?=
 =?us-ascii?Q?CRPgNsmp1eCFlBNzuwZg8iF8em1qgmLvQ9JvXb1pqjlXecexL2xzclLFN2vT?=
 =?us-ascii?Q?2Acr6dl62WjSDC6ksBIK4YKybQgdU3NvaoOby1sUTOz7bgxMy9/dfi78jLbw?=
 =?us-ascii?Q?y1dk5d75L1m+kCi95cxkolATEXJCOquiMRYiImFYjbpGApGag7qz/Ry0ickk?=
 =?us-ascii?Q?d2PGVwtu8cDxyN5SeEHvRohCO4xO/KQU5yMK1GD/Oyk/+STeXT1Ek0QcGJOn?=
 =?us-ascii?Q?QmDfGoGEbuiH/EngEr0PTFcMCv1DamgkQT1aRorCuVkD8+07QwEzUHN1Fxaq?=
 =?us-ascii?Q?t6YgGGgs7rHJ1o2Uv+JFPE4V4g/5909InQScwzkPL7kBuoOMKJKZM6XK9bIt?=
 =?us-ascii?Q?AygGD8/BF/vtki5HpRylvk/M1vJlN6yf07sxbmhPQdldFhRd4+MNt8Viu3AA?=
 =?us-ascii?Q?6hNcKp/Rh3dOSAecfabnXHsOy0dC4Atwas1QMhP6Dmph1JrYIHXgFdwjddAQ?=
 =?us-ascii?Q?XLOJouF+5IxqAunoeA646Ou6hmVYtRdU08fyeZvYickmPIxm6bfCgdheVztl?=
 =?us-ascii?Q?BLNNKLjntJiiC2gj3GIc6USXfutPmJKaJzabE9ildC1Y3uh4lDuOtBpVRpdA?=
 =?us-ascii?Q?GsHPv+Gmahtgi8sxIN1d7uRi6SYrIHenG2YS1abu+924Em3xlvm7c5LP4JTk?=
 =?us-ascii?Q?6yrQJjS9OvzIHIvy8hO4RxorX34JSmAwOluKQkuv8FZ1oRM1PVjBuiqoe9Nn?=
 =?us-ascii?Q?e09qxQoNOwwnQLuWUDUovUDf29vFERWjXdQsZ+FWVhUNlMtoj6UuqjYct9ZZ?=
 =?us-ascii?Q?mRB8wzF8CIrMGWh9yEYGCMABob1YLuPQ4KLnzSiNh1BKkYqKQC6QOVFsNRln?=
 =?us-ascii?Q?hqbcRBHRSMcPaUTdPpiZeCVw3WV/Ro9cuK8tySs7pDKTg2Qlc673pvYPiyam?=
 =?us-ascii?Q?WNJX/0TJNoDK51x2DuSFsO0sIgTcgdoXXNxdaircfZFyL/DY7uL9UXGDK0+t?=
 =?us-ascii?Q?P/G4Jgvc6R6aCARQQteF/dEDZmRNcQMzaDUhCeeMBFmq6gBhD1uM6TRu+LHx?=
 =?us-ascii?Q?FFog9TfwDoUhmKlHN3t8UNHScvhskqZSh2/B/T/vViGGZ99PM4p8zUSkj5uC?=
 =?us-ascii?Q?r9De4t/26GQzszyvKzr61yLHUhQv2S+H3dyvsPycHVZBSxut+gv7r/AqCiK1?=
 =?us-ascii?Q?T3EY7yVzkRPMKkq6qziSr2h1friBIP1tnpf3uZDzVUZjGMca9/K5ze+ZaaK0?=
 =?us-ascii?Q?hxvAG8bqEL/yFR+xRO2HAuJvv1wlGK4I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lfWUmjO7ocpuigjpkrnL45swHddTJxMGaUSjH7PqUN3JamdObPlw7nRnnSop?=
 =?us-ascii?Q?Y5ZzFrHlcXk+aq/bHUt/J11lcotZlTHXqownUIrzrGykspNdulAEVLwxy4Z/?=
 =?us-ascii?Q?+ygutwFqipWl/tKByUM6QNB+lYxHmA9F1Vq8QyEa438Hclx84x5iAIJIBY/4?=
 =?us-ascii?Q?oohlIl3MiPlYND5zsXX0viHJ58+P6Q6NQvTnl83CqFk2+PlN6+BGrln/mKgy?=
 =?us-ascii?Q?a7ZdzEGadnYMnWxm857H5Okf6lkKpec8mljlNvnHY7ZLGHIk88Nl6a1xrBR2?=
 =?us-ascii?Q?0ygyTO51hZ1gxOgfs8MfL0nAYluq6CunTRH9fxk6danSztybBbYzvOBbp5wd?=
 =?us-ascii?Q?L4PGgrAUEHgu5dAtOBXEtKLGIfuCf+l/VkPPMbaiOh+jhC/r7ZQ46o2bV+He?=
 =?us-ascii?Q?fyKtSTyqK6NRFk+B9dB0DOSUuOuUDkFKE73tbaybG54CpNgfHv2XOqxZfBV7?=
 =?us-ascii?Q?d4SM7cVt/RhCCuRPQx0I7/Syz7Pq6MvQxU+Z9l4Tm6eFiVeAii6RawVQLNGs?=
 =?us-ascii?Q?YnF9Pxp0qT88Hv6HfXte3mGDEMyBkTPbM1pM7L4wRuYeJwKdOZ2r8gU42fw9?=
 =?us-ascii?Q?IDIfoOCKY4P7iz99/FyiN6eRfBqqHeeXVpqqPhBRGel8fwN4qUopCrYx18kf?=
 =?us-ascii?Q?BU28YCdV1+B51XdtcB+PEydfDk/VB3rnHdhoa6GQ1UHxdMOCxSmDEYNQwvhp?=
 =?us-ascii?Q?VQN1F5b2oWtmITYWNmu3PUIhzi7eFdGj5Sh4LlrVofnsiSFoC5lzYvMJ5FH/?=
 =?us-ascii?Q?Opcdfo5v+0pSvqUjoF3/ojkQsALejGdbMwTUTq2OukeFA5VP+cNBuOz+Otv/?=
 =?us-ascii?Q?vwF0slZsz4RxXm+0UWGD5KjI1ikW46x+CJy2wT+xKQq4YJa+AUJ+bjAT7czT?=
 =?us-ascii?Q?dYnWNDCmLKQ0AINtErDZ09R5cpg92HO1FnV8ZT5oHp+S5/XpWfCMkA/wJXQd?=
 =?us-ascii?Q?do6dr/2yZmJu4yZ11/vNSPbclENb/ppFcENYUQti5E9MDkV0l96mmiJZNP7y?=
 =?us-ascii?Q?aX8rnbMU9Bk3y1WNCilWpUtnwzHqdLG/+x+bGa6rhmRISKG9Mjpv3k8siibE?=
 =?us-ascii?Q?PUVjjY4Y4qufWR19XxwNqaTcomEje6JIlBo8LV91UK1E0LE4fiV996D22w2N?=
 =?us-ascii?Q?6HDGtnjLtvJUVq/dZqTCkwcWW0KhNjqGfggSt7mlcYY0qg2d0uF8cBeLbrFs?=
 =?us-ascii?Q?7LiIFCu4GO+otcHDT2Nxsm8cwmqqZl9dl2FeBPUrHQPam5xhavErtpzg/RPL?=
 =?us-ascii?Q?wrSpVhktyjazaHX8xZ7U+bI+lO1YB+gTDsOyKQFhtpPm4Yx+in+69SDqFsjd?=
 =?us-ascii?Q?7XUvH2La9G5s+E7BvyNuqjHYvo7qo3w4BaIv2wXzn1sF/UY8o8qAKlxzk9mq?=
 =?us-ascii?Q?VNgHafl56jo1fgeVhKDZGj+ds7SLzUsOSUHFhGjCsLhbFa3J3ILaf7WJ9Oh7?=
 =?us-ascii?Q?p9uqxDmxiTSU7F91Bd62mKdyzGz8RlTQI0SYrPZJn5hMwGXJh070finDnUOZ?=
 =?us-ascii?Q?LM69Qx8HO9Idw6OfzTwuCDLlFJAn9EBHrft6mhjl9vdULInuvCqZm+iAryr0?=
 =?us-ascii?Q?QuLMBkpdPPsNBIFpfwMAh6UkbYPkZbWsjqFk4TCGyNATlhVs9EIFr3VOaacI?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1604500-fbce-4052-9646-08de22082ccb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 16:26:04.1530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7fJYJK2vqIHEk37lqZFnmFtGAvdLzDr5xNmsyi3N5fxfISMdv+j7SPUmuG2eOHOKdb3yu7Q6KTMT3EIl51u+iIW+6AxoXr+Izs3B8e2LVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6970
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

On Wed, Nov 12, 2025 at 01:46:58PM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH] net/ice: fix path selection for QinQ Tx offload
> > 
> > The capabilities flag for the vector offload path include the QinQ
> > offload capability, but in fact the offload path lacks any ability to
> > create context descriptors. This means that it cannot insert multiple
> > vlan tags for QinQ support, so move the offload from the VECTOR_OFFLOAD
> > list to the NO_VECTOR list. Similarly, remove any check for the QinQ
> > mbuf flag in any packets being transmitted, since that offload is
> > invalid to request if the feature is not enabled.
> > 
> > Fixes: 808a17b3c1e6 ("net/ice: add Rx AVX512 offload path")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
Applied to dpdk-next-net-intel

/Bruce
