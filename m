Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B558DD6409B
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 15:33:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8EC540430;
	Wed, 17 Dec 2025 16:33:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 709444026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 16:33:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765985607; x=1797521607;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=s2dJP0K3kPL91yQ9+K1uQHX3ec2r887IoaQv4p9Zgso=;
 b=E5nEQ68+v283QvWSPW61xRO7YVTjaxBjleap540osY2fOpujrmE9IWvf
 Kr0LJKkZ9cU2rUSWSbo/SxP68Wqvpo7bZ/Thj+D0pz3Tw+14aR7GNE9Bw
 PY6dx6FSCS//+RDS3zKNiY89F8hDG5HRDRsPBpFVeKyYSDl/fQLIGISvW
 wgX3puBVGlnJ3UUUBn0uIT4Xw7WsCSF8/P5qGqnaUhUE6DI7sGmzEQ9ew
 mVgdPdCAPUaecjWDJbWiN9JnVsS9bAQUJGskWEKG0JlGyjtrXf3z4NQQe
 DXCX3W00BSCNhko5ylJPagqj3Dl1hM58kIuqjMSBlrLK07hkbaAQyYuI+ w==;
X-CSE-ConnectionGUID: wJgEvIQ4TeySYKH3Ip4l7w==
X-CSE-MsgGUID: eYrupHoTToKQ0CenjBQMUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="66919482"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="66919482"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 07:33:26 -0800
X-CSE-ConnectionGUID: gb503cJeQOmpDRHBfdjZYw==
X-CSE-MsgGUID: TItYYtK1RSiGWACKMOLHxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="197596147"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 07:33:26 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 07:33:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 07:33:25 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 07:33:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua3yPDmXeG8RPd00hAtPfIdO4nGnmi4vmip/GpbcdWUTFAdfEEqT26AA6Q7G9rSm5xF2GwDMoMdp2VQMM4wge5ykhfnLkHes3KT24DtfuOIDje24PcsVYz3+++Em/CYFo+xBXm/DD+qlg0ZcRMt7s/lC6yUXNsEsbMRMUnPi+M9jLgmFFYjLkyCB9szUZ5KsCo9xZL69W8DmTuDzL1r0CFHg4qWT1Xgj7lhDHtNq4/Rftw34WHq38a5Ri7q6XPW/oj+e0BVg6N2NcBMdEgZoTzu+i/kvzxe+0UCzEaxCeMtd2B4mTsc9rUYfJUqpqpvZmSMCHCrnv6uRAL6G6sOZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6vt06REhA3k2IyUnP1u6WJaSZAFh+sM01iqtlOD/do=;
 b=J5Y+fsfmuLCXH2P86r/4Lewmn2AbJNRhLot0xj9jpJ0jOEgAWvGFb8H8EuzSKoYI+e5cBZIUY7Gth9LtgMCpWrYKIVP/iBp4rIhhoJ7bi1yIpDfFFFenPmYAryWwPLvdqgkUWCuPWjZPiv/9zXeWWfy8TkIGpvHa+pXWeHKiyH3YhGSGHGR1LYEMF9OeyB/fJpOq+gCZ0rvt0VKF7PWeJ4589KcEaY1WUUiKviOqUmC1LJ721bwQ2zGGiOKoesyxrHGOgrDQGTZ4uUP2+whM88xyxWlshE6EcRaQ56y3WbB0aGX/lmkrw1MfVQk4DdJXDuB/ZKjzQjziXhcXnVKmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:33:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:33:18 +0000
Date: Wed, 17 Dec 2025 15:33:13 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 1/1] net/i40e: unset vector flag when scalar path is chosen
Message-ID: <aULNOcN6-wCBIFNY@bricha3-mobl1.ger.corp.intel.com>
References: <20251217145436.3217068-1-ciara.loftus@intel.com>
 <20251217145436.3217068-2-ciara.loftus@intel.com>
 <aULHeab_ajR0ikgu@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF7D18F34A12F8DA79F7B83D9E2C3E18EABA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A12F8DA79F7B83D9E2C3E18EABA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0287.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 250a096e-0765-47ae-9f6a-08de3d819a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q06kerE7Dfcjcf7qVRmxjFgc6Y2wuQUtT5oBK6ETd2vupNQKF8JyEDO6tf0b?=
 =?us-ascii?Q?rwFnBHvCWqUznfY53Z23GujMlErPwngwHFc/tWRuOirk42tyAgTTxC3HppOz?=
 =?us-ascii?Q?wPYJ+nu7eIKRXYep4KV3IAjzMNS15oImdn6dUkFaYWUMtDzU8oGwUCtLTUha?=
 =?us-ascii?Q?TbeDBX0CUuxjH1UKBxMu9NgnUWmiGYQnnvVugbiIPmJe625DloGAUF7uoOrn?=
 =?us-ascii?Q?FYKM5tTmjhG8fhBKDYCzhOlSqHvjphzB1rRJUOQJFi2F8Cukx2TaIJ2r19Rb?=
 =?us-ascii?Q?RCI2owIe1tXkl5b9JOTdQiPfKu9IohH0YFjFeWglSCVlEzE9Dfu0TDVPHUT5?=
 =?us-ascii?Q?pwpnPGb2g31Bsizczjmpi0Vl0k2fx7JtSr1VUhhHkDUKnIo6WbIeBiyYN68L?=
 =?us-ascii?Q?SsGFdd4VNNe7zpM0JQ3nWDUXV0+gZMLZnwCh1mYZIZ+eWxl8fGo54Bv5glAB?=
 =?us-ascii?Q?mCx9e5cFEotKSUxc8RsP7TvviJQUA88mUjULQ7fsDp1EmQPgWtyB0auBT2Vg?=
 =?us-ascii?Q?A0v2TmNND+G4pMA3U2r0SlS3xadW6+DrFu+wi5gm6DgQvwlswjDm2NUekyLT?=
 =?us-ascii?Q?FPNLkLiEizqsxgUX7ZB+NyFCS7jtNu2nAtOd4/svxFDPXdcAJt4GXw9m5xb1?=
 =?us-ascii?Q?XcSM3akC2WhCvQGU3Xz8Lgg9keG6XgYPj18JqVDY308xkBdIDVq3QQ2Vcreb?=
 =?us-ascii?Q?+ElLFJxT20ZqaO7cvRvwhpW4Tp/VtM5jS+CQ2XwZF3dohxX+1yopYX4P40Pk?=
 =?us-ascii?Q?YsfEhCK+/UmQTVtJ7jtXKp+6vJ0PHrzr2v9Zh0x74AvXbLMObp1vFSuwvlA7?=
 =?us-ascii?Q?lE06EEDuC6utm1MiQLDuFaLzV4+QBGeVHgBe6l/3fRpjy4hC/115DwSEacUT?=
 =?us-ascii?Q?BXzUKsLdbY4qoTTEtsByGTE4TwEYrKCC2nCnGMZZnVXjfxWfonDGvlrtav/d?=
 =?us-ascii?Q?iUWPdcfCQmLq1wfUjJbl+xYEDFdmApiwjl9o97gFVDEC+LqLeM9rk+AlOrxL?=
 =?us-ascii?Q?ZoRlUOH9KMtzFVdnu9L6vzOyaLPvVXr0/clh0d+iGedBt4haPNQl94tIbhs6?=
 =?us-ascii?Q?ShVq5mAFO7pNbEqFwGJ/2ELqLOLSV05VX6k22Vv7eBjXeei/o9wradTjSmQK?=
 =?us-ascii?Q?hRHf5GXMxnb1tuTbdPBJciFWgfDKPrZk3pCn8v4/osDjFxx77Locohzh9RF1?=
 =?us-ascii?Q?ZOFRxUZ7v/nBm+H8lJCayoBKstlo30IaMDjin2NwkwXG2VBDKz3ZYVBw6ad2?=
 =?us-ascii?Q?y+kIqxjYvJ0zQ1yFg+HRBYJJUK+9dzTVmwS/55EnMvOoYgL37H2Xn6Agj47U?=
 =?us-ascii?Q?5xSMZj6JXoAoPmoBCoyxM8gAnucqFm5iK3KevfJx9pVZdPMHeAeIIAv22IzC?=
 =?us-ascii?Q?109ZhXpEJfoh0mQXRhi+vXyTa9SjB6bRMr0WmsDueWRW7MbQctjn8U7el3Z8?=
 =?us-ascii?Q?H1nnX6LQWaFOzdPbB48Ou2V9etWgdRVp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JofBxmPTa+me6C1nAfzkduFcFHIBiM2hW0VDpUZ3NTj6VtfpqW50QMrAb7g6?=
 =?us-ascii?Q?F/bGiJDM8Ucv8yW6o6VM7vYO7rlubBzlgQA2tkMeSPI3iQojrRwdke6nszbF?=
 =?us-ascii?Q?+HRohHSjZttsmmXtNyF4sEk/TwP7090CYaEzCHMhiPROG2IHrV/CLOD6H1tI?=
 =?us-ascii?Q?nKL0j9crAeY+feEQYsKsQpJ4ro5TknWtYf0Mm87M4DRx7uaKHRTGlanoIVZS?=
 =?us-ascii?Q?tmjLwUXCdQeyoeK3M1jyWUQxIPnwtsUTP4IjCGHAh+EDfyotmysvT+t28rFW?=
 =?us-ascii?Q?RHe6BxiXVfRKOnRsohPhlEWj1il0VPIRUPcDqHuXbpK3otLeE7SUHff8eO0K?=
 =?us-ascii?Q?A0JcAePsGE0L4Fh/7eRAniO8WajuCFoKjxEc0WOcreCotIl4eScmCD1VtK/u?=
 =?us-ascii?Q?81ucwG80+8voC52gUAmil5pkaKV1Zakag0doW5dg5MXiFXqKBFXROHOgKmAd?=
 =?us-ascii?Q?kHkhjP4EuOwDW2QxBc2thbj1VDCduCUz6ndSbMbDM05RF1PVZAr+BUHXWOqV?=
 =?us-ascii?Q?VGkRLS4BVVPsePINRVyPdXUVQXEM/C4wCqkUYXj/1w0fDr0v9Uee69aLpNVR?=
 =?us-ascii?Q?9BZx9H4J3IfPHkEI007/bAJx47Mzb5NnhB5NJcsg6GKUitm7tP1B69DmY8Pb?=
 =?us-ascii?Q?hPKA5xmf2Z7aJbNp4GmF7Ss9VSeW1wNcoegwh9MM3/yj8Lh53uA/c8JtfM9D?=
 =?us-ascii?Q?jZBioT1o6BW5FOEYfQHVZB0S2kEmczrNJxv5q0ZtobF64KWYQaC1RDzqje0D?=
 =?us-ascii?Q?ouuIkhQFFComtnLqSQZc7Ntw/ymiAHPo2nuNXP0gD56LF/gBgL6HQy9SM+ki?=
 =?us-ascii?Q?UGq1MqD9mg2x+OVEBdWJ0EsM9eJQZk2IvdOukZjqyuTKy+MySaMUWWGVZu8c?=
 =?us-ascii?Q?7+TEyiBzVM5bzyqSy4droAhvJsHy9HK6SP01dz3tymToYBuWaUUQWMSkxm7T?=
 =?us-ascii?Q?PFPJZpNCPaMoWrljin2jrlNIka7Izxn/VKvJGa3g5fcQTbGflULrjNkrGVZC?=
 =?us-ascii?Q?HHtoIxXtp6AS1M9AU3DC9949Aahr/+YMwTLCjiJDXntRUgXwsOLwGvgn9O1+?=
 =?us-ascii?Q?Z9+9liWaOADN6yYrED8f6eerygokyK0e9fhCo2pY845jMs2kUOLHUihHxC8Z?=
 =?us-ascii?Q?C9WmzvK/vCxbnCLXck1CWPYa/5DOqTvcxH0NGG4ijPpuF51f3dh+yhUytHy3?=
 =?us-ascii?Q?EbXOsJEDjThPusBSsn8gtpdi1nGEg/TCcPvKQfEfmUH2fsOXLcRI7xtKK/sA?=
 =?us-ascii?Q?djdukfXKkQCxZO96l9ub6qVC5nSwdsdnAEAQu6vbiJfOooL7gZbxcDU0dlno?=
 =?us-ascii?Q?Y3Nx9pp14NAhqOmxD0DJEGXu+FvaK1JUYFBmkYRqPvBqFjqlh1TcHqBUoKrB?=
 =?us-ascii?Q?XOY9zKF+abqCwq0vBul/cy69DzkJuSSQ/LMSoFiCxRH9m1lKzkWRuqqHquvk?=
 =?us-ascii?Q?atcdk/ebC4KjNWlD/Mv26QOOY46mlPVgA5JeJ0lPmABFMB3BXLE/jJ+gpu06?=
 =?us-ascii?Q?+m8BPH/ddSlFaTYpzh8CMPD1nQC6noz7UpCrhXJ8C+b1I9/zXD/5Kawmq+F7?=
 =?us-ascii?Q?p190ozIm5Wueeh2l3joUIv/2nhcbs1pDwzlT3cbNinWR8pGd0fF3jemVqGIa?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 250a096e-0765-47ae-9f6a-08de3d819a24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:33:18.1252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ5gmFq36rHt2seXezIb6Nv9jG/C/pkZu48Cw+3C2cRuFfiQiS/VZUzK6IoXP0lKff66pIExrIT0P+m9EWduqJ1d/HzdhGDIMVsyKHaQhPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
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

On Wed, Dec 17, 2025 at 03:18:42PM +0000, Loftus, Ciara wrote:
> > Subject: Re: [PATCH 1/1] net/i40e: unset vector flag when scalar path is
> > chosen
> > 
> > On Wed, Dec 17, 2025 at 02:54:36PM +0000, Ciara Loftus wrote:
> > > The tx_vec_allowed flag should be set to false if a scalar Tx path is
> > > chosen.
> > >
> > > Fixes: 1ff08bb7ad90 ("net/i40e: use common Tx path selection
> > infrastructure")
> > >
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > ---
> > >  drivers/net/intel/i40e/i40e_rxtx.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> > b/drivers/net/intel/i40e/i40e_rxtx.c
> > > index 2db58c6b24..dd859bda4e 100644
> > > --- a/drivers/net/intel/i40e/i40e_rxtx.c
> > > +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> > > @@ -3631,6 +3631,9 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
> > >  			ad->tx_func_type == I40E_TX_ALTIVEC ||
> > >  			ad->tx_func_type == I40E_TX_AVX2)
> > >  		dev->recycle_tx_mbufs_reuse =
> > i40e_recycle_tx_mbufs_reuse_vec;
> > > +
> > > +	if (i40e_tx_path_infos[ad->tx_func_type].features.simd_width <
> > RTE_VECT_SIMD_128)
> > > +		ad->tx_vec_allowed = false;
> > >  }
> > >
> > Under what circumstances would this be a problem, or under what
> > circumstances would we have this situaion?
> 
> The circumstances we would have this situation is when the driver
> determines that tx vectorisation is allowed but we end up selecting
> a scalar path. The result would be "vector_tx" being set for the txq
> during tx_queue_start and later during tx_queue_stop, the wrong
> path being taken in ci_txq_release_all_mbufs
> 
Would this be better fixed by some refactoring to chose the release
function based on ad->tx_func_type, rather than having a separate vector
flag?

If not, may I suggest that you remove the if condition, and just do:
	ad->tx_vec_allowed = 
		(i40e_tx_path_infos[ad->tx_func_type].features.simd_width < RTE_VECT_SIMD_128);
