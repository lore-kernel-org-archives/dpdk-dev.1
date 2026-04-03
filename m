Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E3E85367
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 13:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6E0B40296;
	Fri,  3 Apr 2026 15:36:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E82AC4028B;
 Fri,  3 Apr 2026 15:36:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775223390; x=1806759390;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=a+0XHBrnIH38QIA9AXLagXWUpT0kiWEuhS5q8tdOIwY=;
 b=C0wh0upo7xk5TBtiHzD1MISYoDR2INmFeUeNgNtZmlYC6EiDJC9n+liM
 m2LtqiB+JElXjCAx5e1iKCd57SxK0titZEODBTDmpu8i6w/mo3Sjy9xwz
 imxLXhdAMd68cl/hD2KFOoRTR1S2PqfNCEh3vIj1ksXThvQsEC7HzUr7f
 sEnhLCXRbZygxwFHGJcYgIVBWk4CxkP86o4iyaPrQ4vsw4w1MS9lb2hv/
 9Hs6ZkzqmxIEdxmHFxzoDTmfTMlDIMjZp/TZXiVVaNuV3EpBgpjDhCICw
 Tj80lfICB/MJWjKkIV/SHR9fcDT4IcIgeCrKq/IpzRg5p3/MhT9XwEAet Q==;
X-CSE-ConnectionGUID: OuaFs8dATGCHFhtHRG/fqw==
X-CSE-MsgGUID: un4yWk0dS1eYdHboFXw+3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="93867533"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="93867533"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 06:36:29 -0700
X-CSE-ConnectionGUID: VhqSG1USQ3a6vjGmwwyAvw==
X-CSE-MsgGUID: kE6gRwctRz+DFOTEhDf5MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223994606"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 06:36:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 06:36:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 06:36:28 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 06:36:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHIO2j3cVsw3juv8u9ZcsMyJfCTu8dtn4h09uHwSaZ5E7n+Hj47p0n6dCQeNN0CHVfcoPSYeYK/mJ+LeJdGujhqnJufLRQu7kqAGXkn77LU82nWE0OQ1cLsywYq1wnLyy/Uq/lqETkCnry9+BBV77srD+LhsgUjFz1akKnPhAgtxQW5Ug0V0IaEbMOdkVZ1d/A33vmvmEJLJa0cHVdV4tAO0DyfJcgTfcNl+XgEwHjsJTnd2zTujodBhmOx8RAlibJz9b1Ny4ef7hQg5YeXIZYB2US2WPLn9JV5/EoTbmRKvo4CTlJif06tqqunlekxC7SHSP2bdho9AvKH2HNRgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7KjTj6KP/DPOqy1ZVFcgWmEptmy/7eP2+Y8ebRL/vQ=;
 b=DA/GfIkom/szFXg5zNo723P+k4qX9ITulVX1AKjhRW30Nr6pQcywWiCHDkiqHnn0T07RPpKfwHhch50OWQA07sKjVliqSWxAMQokxRyQYx6yT8Go0BuieVWOKP2r3F/SMLSpmJmWUF00Lh2QzxaTynS6GpBF43F5q6MnIG2I3QH82NPG/JF6heIYTb69GikV0BKrzsISboqaYBAhIHVotFbPOrXFbZ+9Nv24P5aDjYH+ZZBcb/lrf9rpqwIBsXrpjY80FXPF6vqnT8QwpCwNHfcrb9nNSOECNi3UGTHD4FTSZwQZxPZjMzDDtiFh2jHGNr185XCRdj8X9qWZvS3/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7600.namprd11.prod.outlook.com (2603:10b6:a03:4cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 3 Apr
 2026 13:36:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 13:36:20 +0000
Date: Fri, 3 Apr 2026 14:36:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix simple Tx prepare rejecting tunnel type
 flags
Message-ID: <ac_CTym_2pMe6ehi@bricha3-mobl1.ger.corp.intel.com>
References: <20260320111459.1396374-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260320111459.1396374-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0273.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 006c10e5-5fdc-47a5-df54-08de9185fd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: +2b0ev9beITv69fj8bMyFzEKkTGrVBGKFNBrjn4WjkTDHvf9KoivGX0Zz9SNvJB98qmFabndwiyOlt4oSh2Wd0TJ+4pfAKxSBAmAX1056dfYgDNu/yMtH3EMB7lnxFoiYZSrtCPTztMns1FqpcYERpEP4RCqxpuhln0XFU9xi7/zCeBomHuuFiqBKxaQ0s9F+lhe2gc96zfti/ChQNu0GGT55nu3+L75jkDkivmCEntqJ29OJifjKmh6zxqIzgUzTS70nU7K37+Tp+jeCoxivFSzcL418PLA76iaS8/c3d8L3irFMkwKq9VNe9edtqAW71PyggrM6MobVgoZ/ayklizl2bgZBfrkSuzpfsAsu/cbdvQ8rrbNoXVnOgpWGv/e3+QLDGaDAy2tgvCHxbBi01BNsVtXPLHQIj/7nFxy44zakxiWNtCqud2wREiI22HEw9o7QxAoOtVkEuhuHic7IgHxwoqHmXTfnc5c9VdPnpzJz2lVEM9TZOolYn+tIdPUtLGkwEO1K+d7zvqwE5cXPGMLT4rxvskgXM/kmUQFBga5k6fQQ6XOwiE3IDWlwKXGEZwwJnX1djBIrmxEzIaHVxygov8a5D70L8iydg6g1MyR+VeCF8tPQTA4fchOTiVMuJSCrkh2Y/XdHnX9gRDudFiB8DOQkDQwVb6ouSHm9na9SM48CzjlYVGRIHGvHlDbr/9wnvIin+dZZP+CwOnbIc2/ocShWbip03njz+9ZqKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F61qpEadr7i/8/EhxYwKttIJi7LXyoXiECJwzHkkwsEbeGEazarlO6xjYL9j?=
 =?us-ascii?Q?VQr5KME2KoYBiQlmM/5bmrPmHFpQYlAfsZRRr7lO+RisADVSbP0Kdy+M14et?=
 =?us-ascii?Q?+gY52oAebYNQH3KJ/jhJbg0DgBKZjd7fefkiUTWCvPDXAYjLpREp7vDAKq46?=
 =?us-ascii?Q?HPNJ33CewYRC5EgXMZY5fegWxEH1eoGlkVMi+sLYIMlo3Se1kXg62HFUrNN2?=
 =?us-ascii?Q?tEMOMKJrKSaYXfzHRypGoGf5tLSlYCKFpR2DBRUrU24pOh+HS1Zh+DWg1vL0?=
 =?us-ascii?Q?+s65+EHOLPGP1emtCaQ72fimfJjbyK7So3UDzK7fhQauuLGH1Vx+LpgF82mT?=
 =?us-ascii?Q?UDV/oyKWR1uVTxb2mn+IrIbKHrjrSOKIW2IWQt4u7j1fjt6sacjMF7+mV3Wr?=
 =?us-ascii?Q?y3wegjyP53Dbchegi1PAOS2edCah2HU81KHwPTSaVRcN80HbIlWBCgsjCdDm?=
 =?us-ascii?Q?PxhJa/hOoP3g6afHC38zdj6BlJKNNftnAC3YMdlLiibRLr9pIyf/yTbmKFkY?=
 =?us-ascii?Q?bZbCZ5XOB3eQA8PgxzozQQt7Mkwgzgd8Tbxs5gWwdqOjYXLgZIx8kYa/5AYx?=
 =?us-ascii?Q?JSiIBo+cVbtoEVUL6agOztXVHysCsvy8LWll71ZAo6ApXQpJOBXscufIJMB9?=
 =?us-ascii?Q?Jk+fvGzh9fzagxxqzx8+vILWMS2BKinVaGok1yH6V6u+MoBnWqG+5lYnmDYh?=
 =?us-ascii?Q?VSnR2xYhz7FymohaBradZ50sIWj3rEClxvdEW6OkfqCaBeSJmLBTZIQsbEWp?=
 =?us-ascii?Q?2phiObKaLYyJlhCQG+L+yoFFZHgLVtkKmb9k5TAhJhpJjBgIuId+f1wuF2w2?=
 =?us-ascii?Q?TjaoWeqIQK9t55vL1+ylbxXHc578TFMd51WB06T+pF12Dj3AzBp4svi87dWK?=
 =?us-ascii?Q?gFl9RM++mNyVeBHma2oZ8nfBdHFv/gujmg8c+yR8IruHtu96h8Z1Jy6TCLZC?=
 =?us-ascii?Q?sC6jVjtFKMgw8V8pcM3a/zqkqcS+UerOWst73ae4klm9cdbque2M79oYKmeq?=
 =?us-ascii?Q?cp6myR2YYP+EW6Yrw2tOSEE++W+YSn3CtE93Rr7r6SU7JGkwvKdQ7blB93Wk?=
 =?us-ascii?Q?FOqsskAlKpQ4Ihf1alQ08VTcysEhC2zo57UzFEcUQtpxJATKZjuLiCXvMyzJ?=
 =?us-ascii?Q?91o42CfNlxVRMZ0BpoqFgm8goKVBUW7RIY+AqxZ96gTxvYgc1/vlUSvAfL7R?=
 =?us-ascii?Q?Pz5aOD+sCDjAGsgwEySie4r1JESIwfwyYp+5pwmrLi8OdDdxU7zwKa28SYPL?=
 =?us-ascii?Q?RFL3mh0Pu9G6kzvlkLe72DgBSCFMGp3/DkIw1r0y961fDvx042XBt3Kw8RMB?=
 =?us-ascii?Q?tHs6mTgmOnNuIE1+PpeV6lrV0kfFo1FqhCDpIIXKn/yLlWhYE9uCINfk6rpy?=
 =?us-ascii?Q?5Tgtk5Af/2G/9FD3rqFsfEwRvW9+gpcNxaxvr6u374Ub5NODdTiWZ2d8wXIF?=
 =?us-ascii?Q?6a/7+Uy5eWyNIKmARRf1HRx/Eykm/ssIrp4vQOQnmWgSZzn9jctxuJUn5ehR?=
 =?us-ascii?Q?GUf5+yOJcWUT1IiA7fV6P29dG666vO3DsPHoUBo4gpxEXr1q7Z1C7OdLiTfi?=
 =?us-ascii?Q?aLxaiwrlvlhqv/9cQAezbxyVwvJDIUlA+bay+2/0nHCBmxm4zDjDpd2EmQ3U?=
 =?us-ascii?Q?ZIycCd4efeke4L+8AU369kY7/1HT5Jf/8qwwzovFmYrFR1vU4pwmq5TXZpNc?=
 =?us-ascii?Q?epdMC1Srf09gQGiBz5v/x1j3vSCtTLcMKPwE/sFw43xLvxeDpDF8zgreDFDX?=
 =?us-ascii?Q?nNpGgZs8AWwCp7QGxEB13xxsnn4E0xw=3D?=
X-Exchange-RoutingPolicyChecked: j8kurr6Oj2Sg2vUpNbrWgl4DeDRIG8Wa1MnMtwlrPzpbZY1V+IeO4E6C1elD1iwBMmBuXLbzyEksCxBepqoyCY4uIK6M9s9bzE6AEpTD69A3iS1gIUlJn8au26xftNcZYy2wOOrvoFdICgx246doWYMACn8d4Sz8p9cUjOWVfF7rnRfOqZquYeSvMx6QTDTvcDiNwluqOmdFG0Sk1DD7s4ZRiFpT0Gb2O18k5eHa1j9cso5zogIi4umdLh9ng221Ww9wk0NjmB/akxBS6U4TvNGBWc6x/GRxDs0uFWgTIu3XovRGYOQKDPDJyeI9249+VT2/5BeSvwYdwJzoyXF3LQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 006c10e5-5fdc-47a5-df54-08de9185fd35
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 13:36:20.0703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdY0uPlC/MhG0BwOshf98YdSG9x/6pSwVJCPcQgXllpSy0gW0P8A4NjiryleXIVD4AQM1/y5lOYz9leiw9zoMQpFbVEf5CcE0PGajs7rMHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7600
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

On Fri, Mar 20, 2026 at 11:14:59AM +0000, Ciara Loftus wrote:
> The tunnel type bits in ol_flags (RTE_MBUF_F_TX_TUNNEL_*) identify
> the encapsulation protocol used by a packet. An application may set
> these to indicate tunnel type without requesting any tunnel offload.
> The simple Tx path was incorrectly treating these flags as unsupported
> offload requests and rejecting the packet.
> 
> Add RTE_MBUF_F_TX_TUNNEL_MASK to the set of permitted flags in the
> simple Tx supported offloads mask to permit tunnel flags in the mbuf.
> 
> Bugzilla ID: 1342
> Fixes: 146ffa81d05e ("net/i40e: add Tx preparation for simple Tx datapath")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
