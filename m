Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7108EE36AC
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 078224025F;
	Thu, 12 Feb 2026 18:14:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6933D40041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 18:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770916464; x=1802452464;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MaaupZeonkDn1e2efUKqhDOigk/ubUr11O0OLzzi4WY=;
 b=K/RYOC+/4h+8Ium/j9/R49SwKaSO9L+SR7Fd33hvgbm/YcRRnQX29/Da
 7qhE62XwLDVM10XCFkyY8VHNF+6pq8li/4fEBP1twv1HqyNeirCyY7Oom
 unqAekWCDy0oToyOrdRDX/YzWraODP3nM6laT/J69G2z6I0Hh0FH5cokF
 wzPdj4crgHDBSo5ZfN8QxHS4bEIXldHNa4cdzSWcnx62PJgD4LXpRl5zd
 iNWCGWJ9b6pNi4+tOcRjP9aCujz0Xn1Pj7AymWL0ost5FnOohCA9HYvpZ
 TCQ0jLSSzzBNwXoXwPnCb0hh5YLMbB0RD1hw/eXF0Hk7EBvRUhmCw/iNK w==;
X-CSE-ConnectionGUID: AibNRgygRzaP5HhiVDxZcQ==
X-CSE-MsgGUID: rC+ZHJCNTHaXB2Yf9ZRFbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82734074"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="82734074"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:14:22 -0800
X-CSE-ConnectionGUID: Q5kls7TgSjWIInYqtT+VjQ==
X-CSE-MsgGUID: GpxGqb63SlqBKXy9+u9r/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="250343374"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:14:16 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:14:15 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:14:15 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:14:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1//q4ZVF+o8eN60mrP4TL2ORjNr/GkSWYhejcqDG8sRUTBGyCvuYKcjZGrlA0ryPcudjSV+IvnvHWpdaBSbBsLMK9nn7pr9+DRmgXipjKVp6TrGgVXcu/0x7PvvkVIwcyI7NOuo8tRfDa4khzZXPwTQruQErMWZRZBv389KUyppZ4/1G193EwR9pzwnfjmkO2SJVlsm6fVOl5i0VhpaLn3fv13GoE7rCdLUaRN41wvOFLIMG/MBXrJyhRmL0dHRb8PXbYt2z4ublUonFykWKR7ZgbUWBrgNZauDZXl8c3SguGzRbn+WrXDmcQVNMu+X15R3tl95idJe6x6hKuQDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4CO/ofVdGd8iyNNsigil4CNXGXwSrWud9s1UcFXzcY=;
 b=swHXtReq2Cy6mEAv9TqCYxFueUITICO2VEN7mqDlxt+x2V2jLzFv0uOmZea9er/ln33ZIJtdSi6GO+Al0LWeFwU6QrrVZda7gTj0URiNwwbcAN0xp0aW2gtkt4ZINK/UIVcozAc8dUWKhL39suqcoqm5TmSZ0w77q6gcDV6rKs+VLGAis7T5EVb1QaU+z6ACFw7hPfwVankHhrdy84g9uBv4dV9LgFGrYQhY/3xhOyKyhh+L/AItiU7Qr/vqw/SnIg5bV+lanXgROlctlYRKaas/MnK/cS6f4DbWtyYNIqP9odTwN6TFsI2vWGrtJFZexVkmT/il9vP7P9YZdHRg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7496.namprd11.prod.outlook.com (2603:10b6:510:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 17:14:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 17:14:08 +0000
Date: Thu, 12 Feb 2026 17:14:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Declan
 Doherty" <declan.doherty@intel.com>, Radu Nicolau <radu.nicolau@intel.com>
Subject: Re: [PATCH v5 02/12] net/ixgbe: fix memory leak in security flows
Message-ID: <aY4KW08xE8eI0ZW1@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
 <25cd42dbf99da44057b6e48cb04f61bd406db3f2.1770900758.git.anatoly.burakov@intel.com>
 <aY4Jnsjw2DDRW1QH@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aY4Jnsjw2DDRW1QH@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0296.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 630891bf-76b0-4c56-d41f-08de6a5a21e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?81f5s+SSod6SAQnF+ps/7dKOY4DZQ+Pp8BjSvJjNe0IGwvZ36KFEBOKq/ZVU?=
 =?us-ascii?Q?mi8aJ86CNxzFhfD6bjamWGuGAY4+q0j6Skn/g56FqDBcJbq/Gn+8piVauMw+?=
 =?us-ascii?Q?MZkYY+NCJX/i3qLfk0GsUg5GvGz3LctfwF/lgXJN8L06dIun7w6gqeCfq5dR?=
 =?us-ascii?Q?TvYvsJNy9vJgNjXzWsEvw8Ny9RsAnc3FGMjtMJgK+qGkGsyz3fcU1D5UxS0K?=
 =?us-ascii?Q?kF8j/a0GlNLBz35fO0x5kqQ90kb5+jjcuftV3aOSTNIA4Hy2wxXjEPoH1L/T?=
 =?us-ascii?Q?EUIEvHSK+uyX7PUbvyAOvjltB6Z3OoepwsF6Z7RVNZVsCToDJEWMfN4tGrBF?=
 =?us-ascii?Q?fwZo25fABbMXZTCeh93B8fX4b9oWNt8u64R4R3Cq+KZdyHu4anRcdL093FTu?=
 =?us-ascii?Q?5VcVgsSiwlbUFn4EDi5evm3eKbaRD9nk9f5Yhd5EEAvVXd0eZE5XxKG97xDQ?=
 =?us-ascii?Q?70wi/NDpB0p/TQ5S7OPs71Eek7Vnm5d/Ahb3mTfuvufXJ/xNaeSnsNJWbMoQ?=
 =?us-ascii?Q?fI7OCI1Hfi/eCZ6VxoG5sXk1AF3pFHujh7KytOHt3q87jOgCcf43W14Tlmfq?=
 =?us-ascii?Q?01qMDmQGXTim+k2KdaRVrKXlzX/LVPNVaIA8L/Qw5y5l370IDKFJl4W13zKe?=
 =?us-ascii?Q?M81kj4ty+RoLAfVsKTDVuHyr02nJOAimmqURaGR/mNV6UNwjSX0bDCX/XTAL?=
 =?us-ascii?Q?8GVeZbNVzyBNU2UFK9V7AtBQHLJweaa3ZJopayD41mwUJJNGMDd5eWoV8zkC?=
 =?us-ascii?Q?5IB0XgjyDuUrBYYG7b63p8Nh06NCu35HmlRHbyY/bwdVX0dXyOUCeBAP2Qky?=
 =?us-ascii?Q?tH86/gqcWgIOgVjkQaTsBIWWHlMZ9Uaj8fbCqHiNqvhcR7Cu5cMia60zeW6Q?=
 =?us-ascii?Q?XZyBxPtCUaCNEpahvUcqQByo+FyfgQ8aAmHfn1LlIAMDlk5o0uuLNBTxPxzJ?=
 =?us-ascii?Q?POYwy4wRhaSRwUv8v+pRsQfBisg5GslECXqYdmH8miN1PlS9eEoCNP2CJzbM?=
 =?us-ascii?Q?SuRPxePX1xpvQsoKVUOObC7dzKHVrXlCJPAS3bt2uCcAo4loVx8PVzmT9APo?=
 =?us-ascii?Q?g2cfGLlvJ/Xd2Da+x8N2O5sZkubb5Tr7e9fQgvWLdh+ezWPdPJXUVXLHwBw1?=
 =?us-ascii?Q?QNX2woCDcZREZWTBzErBUNmr1iRFZ5f9Hq7QxbPIvv7ogfiFrMChhbtqQp2p?=
 =?us-ascii?Q?0ykdHM54liv9Ctjgow4zg59n+/lPO617+nyLhC6qIwfRyG6lwNcxVKFhS8Xq?=
 =?us-ascii?Q?q5F0eMGA8YNTV4O7acvMYWGnvitp5E/Fp9khTNAfwQN4PY43edrpBwVZtdQr?=
 =?us-ascii?Q?DEX6HTd8Mk3DXZOq874fRPKYFfsCnH4fAshGBW0ssZ7Vjj8RfraIrjXRIQ+1?=
 =?us-ascii?Q?0+psAQumeq06pieYwg5Whb8QqiyMrD5ES33AWXNuQHX3Z03C/etd3iMLAAys?=
 =?us-ascii?Q?rl3Pgp4EMB9XTvH1RsS9vNuLefhCsuSicHG+tKl7AVWJgrfzkbpkazNoYiOy?=
 =?us-ascii?Q?gWQF1CZkdox69nk+/4gbYG7En12NwuEXT8pTDJn3+Z0ZJ8GrznzoTTOQN7Q2?=
 =?us-ascii?Q?uRiyHeta/sYZkHvDoMg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2C52vUy3LkHhTllp1YC8HVFZKdw+uPeHw0U4GK33YSUEfeL6LD07bw6BJOhA?=
 =?us-ascii?Q?GU0keu0E6lirLCkD6zEwBSPXYW7B11Rn65fZTIH1l+nmld98WScVs73EbSbz?=
 =?us-ascii?Q?M6oAEujcSJYMImPL1+0g0a23OHhsHLBu0RXEJATkcJe2twg0grJ7ZxASNPTX?=
 =?us-ascii?Q?Xv9S8yT91xv1j0bHtwr0KGRqrTMnrilt1qHS65mbm20lzYSdYFP5XCS/7KP7?=
 =?us-ascii?Q?r/yG6/9udAe0Uu+xCWUZkVbUWVuSOpfZA9E2KvpdWR3/MP+B8qFZLdAenQ1Q?=
 =?us-ascii?Q?ThyrolMV327wq54pY6psPsmx9UF7X86/xeNO3V2O0fftm2AapfItLABZP+Oj?=
 =?us-ascii?Q?7QINYC/V3P0tdoGmAeIyaadW1WL36bdWWkkvVhuD+xhpoBlXJxieXSZ0QD7E?=
 =?us-ascii?Q?haZ+Cs7z3+1Qcg3oxeylMzTs52gN+B/3Q9yT8HiJtAwixvvBIFHv8HXN7ult?=
 =?us-ascii?Q?H16xWSVkMG9TpqM7AInLG46T1RPZaU4YycylNNTDpZLu/N4IUb4wZQrJYVkS?=
 =?us-ascii?Q?KMo0HVb51H8ZOh3JQdfEO59UKHl0e7pBx82ndBetGEI9CJ22qd6R4H4vrWLu?=
 =?us-ascii?Q?MGmswss1UnZleec05JqVE7+Xxe3S7BKh9/1nQR4cqJKEoU0CKuXlYlcomo8+?=
 =?us-ascii?Q?ZJ9H7AUM6jfJf/d2CurRZuF+YlDWewjfBSmjw2f728OA4AiR5GyBYwgBsm17?=
 =?us-ascii?Q?L3FbJbKiqOXZO9GrrfpSLcE84b3cGNi59KHyrQf76gXV6dUVJV8lzXZmk6Kz?=
 =?us-ascii?Q?jbuTCzMOoZoDqM5SwMqNMTcCoRLUcR5AUn5NLy2Dhjr6/+yGtN0fI1hEozsy?=
 =?us-ascii?Q?7/QvNQN3vYrkhCgl78os8Rk+gc0PypOZ3TvOfQ+XYxuec1u26HJGHRno6Fg6?=
 =?us-ascii?Q?pHjPTYWjFskcf0b9Hfo+64xEGOAop1E8tdVoQFg/lf2kVym3F5bo5gmDIEVH?=
 =?us-ascii?Q?XYSJvObTeGSQdtTceHqFdguU3IQUgaV7Zd7frpQU8SuLr6pJH3/kLajF8iRK?=
 =?us-ascii?Q?yyUdS3yMb10rpeKt3e20gmMFVu6nkXMkZ3rkJnuMU7c5xu67e5k06PU8ObMG?=
 =?us-ascii?Q?2Y60FrBl9xar3+i+eBAcXlqw0VKZg6xERu5128V/nZllyBF9gy7w+oE6w0d1?=
 =?us-ascii?Q?7N1+cx2gwaiIt2qdRr019VuUJQTQofwGGkqe3XP1etiBCJt/I2eKvCOM1DUh?=
 =?us-ascii?Q?B2eHIoolOnpvFdmr9kcZAuAywsl2gA+/maTpO9VH/KTT9sVl6oXUtDX0Tt/N?=
 =?us-ascii?Q?pRDu2/Dxpbmc6Bh9eqjsjv67Hsaw6STPwXe8+qU56KH8qSVIKSx60PbRIG4g?=
 =?us-ascii?Q?OfC5d8Jbe0ZWCwgv0CAXZncofRsLmq7EhpHoLxSOcSpIsUnfaSzPi9C4ydux?=
 =?us-ascii?Q?jqF11VvqFlhLvcJfp5d3TohGUkPq9tH93v08rlE8aX67WnazoFgRa8+xsqwu?=
 =?us-ascii?Q?THed5E4Zbx1Z+DLr8kc3SdyujDNk5cjISAvY1XrmqFYUak6Xwg0mvdLmOB4b?=
 =?us-ascii?Q?ogA/ZRHeBHK51mqAv+VFJ01V7WXuObunuhwpUsdY0YSb7W8NPbIb+p/akqiF?=
 =?us-ascii?Q?IBrmk4E5BwLOlxQ1YwNtMBD+LCDD1uK4Zuaig8EIcIKAuk9M5ju0GOAt/ik/?=
 =?us-ascii?Q?NNOaMRsvvrAmQGxPHqAJx0jlMMKyLBOIekAuKM/gv9+GdIYeSt4s8ED8QNp0?=
 =?us-ascii?Q?RQ4xTTuTkSg7MbQ56fQL6VqGeTmIK7IMEOsJOvKbjiLZhCp5A/1VpJTiiqs+?=
 =?us-ascii?Q?diiu7nhA3ETh1nP1qfNploycCVhQkuo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 630891bf-76b0-4c56-d41f-08de6a5a21e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:14:08.3607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGFjhD8uFfVDh9qd08+urP8bEUjolL2DLCxasyUOlHg+dCY5psDtJJ5Ry6QX1rWQIqyhKOL2e+9fDq0rXTGrCvQpLKW8GRNi8uzSNQT1Evs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7496
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

On Thu, Feb 12, 2026 at 05:10:54PM +0000, Bruce Richardson wrote:
> On Thu, Feb 12, 2026 at 12:53:25PM +0000, Anatoly Burakov wrote:
> > Currently, security flows are implemented as a special case and do not go
> > through the normal flow create/destroy infrastructure. However, because of
> > that, it is impossible to destroy such flows once created. Fix it by adding
> > a flag to rte_flow indicating that it is a security flow, so that it can be
> > destroyed later.
> > 
> > Additionally, security flows return pointer to allocated `rte_flow` struct
> > unconditionally, even though the underlying call to ipsec code might have
> > failed. Fix that by checking the return value from the filter function
> > before returning.
> > 
> > Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> > Cc: radu.nicolau@intel.com
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> Not an expert in these security flows but the patch looks ok to me. One
> minor nit inline below which you can take if you do a respin.
> 
Correction :-): Wrong shortcut used!

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

