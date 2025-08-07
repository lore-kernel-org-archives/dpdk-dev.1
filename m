Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F1C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 13:33:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05D93402B3;
	Thu,  7 Aug 2025 15:33:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 7355940270;
 Thu,  7 Aug 2025 15:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754573629; x=1786109629;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pKeBUFF2dat/cpLWFbaC6lX2rd+g9xDDPzeIAe1etWI=;
 b=Ix/4gtv3UNaWmm0LQzf48LkNxMo60hCWAZbL/NkJAfg5RpxlSC2eBCBG
 LpR/RULEDrex77pk/As+IOg+KrY3+f1pw/K9xuCSAZE+oSMtyYur6cnvj
 JBKn6Le3fQ9Zvj04ptV6RvkiidoDTAgq90JqG39DkQco9Nc2CWb60rKTi
 eC0wpDGspLM5oFWnd67wkpkVaV+bGcWYSXWTSuqFpv9Zd0gva7d67g30P
 PYTkiy8D7GTmRyjJDqJgXY14oTu9k/zd1kqRxeA8Uv+ZAa1gabu7bsBaW
 jCm+/Ehd1cYmGxXigani9oW4KcVqy0beNuTmKu1enddszEDLPJLqkLGHd g==;
X-CSE-ConnectionGUID: ReSS9Ig0Ru+yiSj2mFpusg==
X-CSE-MsgGUID: +O93kN7DS1Sz1bBDse0Rtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="82355642"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="82355642"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 06:33:48 -0700
X-CSE-ConnectionGUID: PavNTGLFSnmvnV3NeR/pIA==
X-CSE-MsgGUID: L4ClGLotQya4xY2trKCtdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164315166"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 06:33:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 06:33:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 06:33:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 06:33:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGFRwiwrAOnLOZy6GSN4K16Vov2DrZbe/ZHzHtHaP0wYKzCnMpGBDKtV1CScQyAz0GEKWsGdWcfrEPnYeoIpglqWTDIAQw8J3kXOLonQ42qI29Wi4+Onyk3KGwPx497EZtwYRhMtStwPCKYPHM9b0XFZ6FJfuDtrNPLRk9xMWzPptfbgFW0QfYgOjbn2M0uW2X5wgwvOM/Riqy1W3d8Nj2vOMzVFmO2CN5Cac1pyCGdzjM1NyD1Rrt7ktvZ/ttjP1u9Lb6A7UUbw0vvRuk7QsTf4usQmr92mZoO/UP7FcvpClQY/cq8tUdMkIUak9yAULFloNH7Y5PvraOwjvjDbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESaDgELUgR9xOtmInq5v4QQubbVcAnxTGvUA7RI62G0=;
 b=gDZpkPYEN4NTT4+yOrj30wu/VvSUk++6GfuJCOcKbD16fsQoky5T/GZSj64ahBn+9pzu2kjIWIJMhSug3dpt/hhWx5EFa6AnpxOWbye4eNqYVmvPqs6ra6n3an8whAM4VjhTADYCG/VH7w4TPiW5UnpQoaot0IOYwF+XEnbxUpWiu7LEKFLwCt6pGKdOICCIaemVlU0mAEV3byavVJ+KibeOc206lyiJiYoA6h2tmrqM6s44jYmFmP0+xx+AGkW91Qth71uQfwV5nUWJ1bBdNj5t78teszRiK4akAW5ENkyG5Y9Ez2Q0k1JlooSAMN9UcRzKl5vauKm+Td9PpbnYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPFBD6B1667A.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Thu, 7 Aug
 2025 13:33:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 13:33:44 +0000
Date: Thu, 7 Aug 2025 14:33:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix VLAN tag reporting on Rx
Message-ID: <aJSrM60ncRIsDBde@bricha3-mobl1.ger.corp.intel.com>
References: <20250714161050.289375-1-bruce.richardson@intel.com>
 <DM3PPF7D18F34A101278BEFE9987464A1A58E2CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A101278BEFE9987464A1A58E2CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU7PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPFBD6B1667A:EE_
X-MS-Office365-Filtering-Correlation-Id: c143c4e4-1d8b-483a-2f92-08ddd5b707a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AMI2cQ8BnOCdKT3kvlQpT/GDtEghIBt4yMBApIvTsnxVeSVa2b4OTt+3rEpM?=
 =?us-ascii?Q?4XVdIOTqspEHqs1pJ5fFfG5CuCNxQvePrVLmFR5o4byPvJqmicd81htaXq/S?=
 =?us-ascii?Q?1By7bp9MBlRQKCdrpwox9yx+y1vSGxU383cAFkPqUCxiHhypyqlcFO/xxvE6?=
 =?us-ascii?Q?XIu8P1pL0qM7QSdLk34+xOqBZ8XZduWdGyzbMP1U83IPCoF0U8pA88pYg9zC?=
 =?us-ascii?Q?jCbRXx0kzR9an7uWI1uo9dOOj+H8BztQiihVKNps0Imp1oDPbndpFLsfgurq?=
 =?us-ascii?Q?nH57oKhhGs5jjWmvTbx71xMmOcTuynsN4/b0UZVRTSngrYiMf1J8zkkL6oyN?=
 =?us-ascii?Q?xbHoiOVymh9Fbc71REuGDqEilGn3Z0gbTt+bD2PC/YhzJMupCmv+SUgQ/m7i?=
 =?us-ascii?Q?AR824vgIth0bImlNs9HBPUxhwQA/yD4YOKjv+DxEyoDCsMdABGmWaWQA2bir?=
 =?us-ascii?Q?kNSQC3ECiKcVvPo3mxzlH6Co7flKONPxfXInqsYtV5FvxKYfm5CV+gFYdVEg?=
 =?us-ascii?Q?68X/ryKiSUINtHHcYXk8mR9mNc2m/wVvFfFCmersxXRKG9/x0X0JoPn12YqJ?=
 =?us-ascii?Q?Xr4GmNWt+Uk1fP9rlG8zBS5wZZzL5v2lDAXAEE2iL0NNa4hAxr9Z/HuJOjhy?=
 =?us-ascii?Q?TP8MiEmhu61cBzBw6VyKOiDqseAIquTHHYVdaQRz1gU0SoInVHyqv71Ci/H8?=
 =?us-ascii?Q?WtrBYsTjeY8sx3q8RSfcTGZPXh3wTaQ6/Lfqg+Lvo+316qZWeHno4uNHIgnz?=
 =?us-ascii?Q?VnP5xLTlSFYNrwIvdbA1/nit92rwBzoPGzwm0RZVs0SAR3veDAlXx20uxUsl?=
 =?us-ascii?Q?zM/VyZOoGaYQh8I0rgVzpCEWO1wE6Qy7dMXgL3T0U0W/2fhHjQCPazg7Fxai?=
 =?us-ascii?Q?HLIqbvIG8UdOlWyG4j7KQOf+HhnyNMKtwZHVQ4JLXtb7zz18wr0Yg7v2aEl7?=
 =?us-ascii?Q?ba3B0FZ6lEOs7kndACWRIKHjk1gHl559z7KV6B16Oy4cW+KPYmwnic0pSlVi?=
 =?us-ascii?Q?r5c9OyiTpppBH6NVKTCs1HNxXoR5tcwx+pGXTp1hSizg7LoDj+9QAYsXbO0a?=
 =?us-ascii?Q?dddtvGsuG6BLdrNtkTvzmwzO+UHp2ijk+LkJMGF8Il83tarcKELOLBLMtnrv?=
 =?us-ascii?Q?HF1aLksabucVrqomSOGMf8WVm5JeFNlFUEwf1uhln4L+wclu4RJf3a38PFq/?=
 =?us-ascii?Q?Vd92MEg/KzLwyML7oFPlU3l9GbzKkNAGXmsX73i3rpGvh2heS1wjQ7ItZdlU?=
 =?us-ascii?Q?CYfTSTkjICp3YU+huwl2QJYBXp0x8Rk2+oJfUJD9fv3bYpzAX48DaebisFkw?=
 =?us-ascii?Q?jzZyfPyBm5eiZgQd1F6HRPiSNK4pG3TOsG5sIyt8GeFC8H0SDpSvOlsm/LwW?=
 =?us-ascii?Q?qBV0aACuI8DWE/vqwErnk8H0t2iZ28kMkAh6GWJtr2a4E07AOC5IgPji7zpB?=
 =?us-ascii?Q?g2gp5ZvFom8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQgR1ZO1TKUbQ4ObBqJXBhl/5mN4XVprOFX7wepEGZFgf8wIE6EIryklBbuJ?=
 =?us-ascii?Q?cBcP0JkY9umnTrlXMZFN9X1nIJgBIcszNnc845ts83x8a7I8DTPyh2ZidqRU?=
 =?us-ascii?Q?uMk05ViGrTVEdX1EWBhxdocWol5qTEw8Sv15glNWiDmmPFqEqlWMKAn7Q2C4?=
 =?us-ascii?Q?YjW35kL1UA8bot1y3LnNdttObRnkuI5Md71dW9vHLEdQu73XqbspaQroLjBG?=
 =?us-ascii?Q?NlUa0KhX5fzQLPLU1De70+QROgJjWwnmWOK2srNkHsbDzZBLIZFia80r/D2v?=
 =?us-ascii?Q?g7UbYbiudzdz5ClOW5rLcAE2a4YtEBYwtZf2s/RRBLvPLbKFzWUDOdZdRA/j?=
 =?us-ascii?Q?Py3SmVrU16hWaaKIwm60RUMlN9PymBCMstMvMFxTZfv5ffhG3CI331t4yu6u?=
 =?us-ascii?Q?NfD+HPzUPRqnpqybm2SDnRfvOf+mSuOCtH53Tj0X71dahUOOsojV8iHWrmHn?=
 =?us-ascii?Q?nBOBxTVKCdOB/ovE8pJb8zzRMoP6AKqHFNoB7Iu1xaT/iJ8dmhQmzFvwfbdN?=
 =?us-ascii?Q?nnz6FiYP82ihqCw+kQs7cOjAVNG3Z0uqlE1URVl+oOvTdUgikLu+XPvNXVTQ?=
 =?us-ascii?Q?y9BuK+iZjTbkFpXRLdEF0+Qu4za9Jyxeu3zeNDgvzE376ZOv7dvIzmkyayDQ?=
 =?us-ascii?Q?+qaDP2LR3WuQ53rlNr8zI1DmJsqihc+g7RdEoPFRQh62RjHo3xEkl+efYSzu?=
 =?us-ascii?Q?24qccSu8yEhC4Tz13Cft8qOa8uxWboWBYOq/qEovz+7inIjCKDbiz/N9ioDr?=
 =?us-ascii?Q?VjTTNE1fyGX0HSnYCfPJqFIMb1Zd9oPDeSm9E9GTQchQU/LldJ45pZrXQfHo?=
 =?us-ascii?Q?GzHMoziF1/FAVW7mGCaWMNMABesZxL6KYQZeG0EmnNTxb8nNUaNHp+uEC3ee?=
 =?us-ascii?Q?DD6Q5gaQhI/qam/EjU9TJgcTcoAqv8plAx9rHWSVHTb8SseLK6yTZr2XNr8D?=
 =?us-ascii?Q?etMbka6RgSJlpd6cDIjibooYr3i5a8yed7P+jT/ffYoWqVKivZQImZ/hAli8?=
 =?us-ascii?Q?lcw+vqrdVCk35Y6TSC1xN3Y2JtRvj/i/ITcbhbyUjvTZxYoGmgP7Qh8kMVc/?=
 =?us-ascii?Q?v47mesNCqct0Ed34tdIa8/G2pVBboX13X3r6lUjlhI2ldSUT9fG6IFweFPWo?=
 =?us-ascii?Q?z9SZlW4FA7MtBf1M5d4FILnmDyv3UzBQ43x/eycX18VlOdiHm+9KvRwJlPJW?=
 =?us-ascii?Q?InSC3s5vLFTbFMDBN+DLJy5zgveJObq/KAzleNmwD+I1CBjKMwBO2Ndg5l4i?=
 =?us-ascii?Q?C15m5PyYcynDzU9ynHMpsfvUVNDqcVz5eG0bMsZel8kdkWGaQYDLszEvb05X?=
 =?us-ascii?Q?OQBBCowEGfX+aeOcFijGZBAwQ2JVIZJM56WVtGD2Qgqktw1a4n7RjksvZ+0i?=
 =?us-ascii?Q?GGb8XeQ/KQxHEuJkJTLFNuVGiM8w113GCWo+lzPd8f6jXimKGec6GVt1XmLJ?=
 =?us-ascii?Q?cSvg8DCRz02yzZCTRvbx2hCOx6JcmbaHiceSYUGrhMEY5qwQruZxGeel/dVL?=
 =?us-ascii?Q?5I1QRUZK1MysYsFkaV6UfEkNYFYoWPbqMP4gHmp/IALn1HNJRwzCPhB8JFm9?=
 =?us-ascii?Q?lJ5iZNqGcICj0G/1GJcjSPn40hzjl6exT6rBwd9bbUt8kLTZvmJkJz2IiIJw?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c143c4e4-1d8b-483a-2f92-08ddd5b707a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 13:33:44.3520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEVm2Ps3ScIoDRv9VOJfVYg7ze89+CzUvIMOgKaAIKZIUblXnr+/bIB6BBslcy4mCZhKBgtMocnYJ0cZShFPv5u0b48PDKnVEf2q4gEqUG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFBD6B1667A
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

On Thu, Aug 07, 2025 at 02:12:37PM +0100, Loftus, Ciara wrote:
> > 
> > The ice driver expects the first, or outer, VLAN tag in a packet to be
> > written to the L2TAG1 field of the descriptor, as configured by the
> > l2tsel field when configuring the queue context initially for the
> > device. However, when configuring the actual VLAN or QinQ strip
> > behaviour, that l2tsel field was changed, sending the single/outer vlan
> > tag to the L2TAG2 field in the descriptor. This meant that it was not
> > getting picked up correctly by the Rx paths.
> > 
> > This issue has been around for a long time, but was previously
> > partially hidden by the issue fixed in [1], since due to that bug,
> > the l2tsel field was not getting overridden in the single-queue case
> > (since the single queue was the final queue).
> > 
> > Fix the issue by just removing the code updating the l2tsel field, and
> > leave it as set by default in the initial queue configuration.
> > 
> > [1] https://github.com/DPDK/dpdk/commit/4cd8c72f6
> > 
> > Fixes: de5da9d16430 ("net/ice: support double VLAN")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_ethdev.c | 75 ++----------------------------
> >  1 file changed, 3 insertions(+), 72 deletions(-)
> > 
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c
> > b/drivers/net/intel/ice/ice_ethdev.c
> > index 513777e372..4a6e580628 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -4965,49 +4965,12 @@ ice_vsi_config_vlan_stripping(struct ice_vsi *vsi,
> > bool ena)
> >  	return ret;
> >  }
> > 
> > -/**
> > - * ice_vsi_update_l2tsel - update l2tsel field for all Rx rings on this VSI
> > - * @vsi: VSI used to update l2tsel on
> > - * @l2tsel: l2tsel setting requested
> > - *
> > - * Use the l2tsel setting to update all of the Rx queue context bits for l2tsel.
> > - * This will modify which descriptor field the first offloaded VLAN will be
> > - * stripped into.
> > - */
> > -static void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel)
> > -{

<snip

> > -
> > -	return err;
> > +	return on ?
> > +		ice_vsi_ena_outer_stripping(vsi, outer_ethertype) :
v> > +		ice_vsi_dis_outer_stripping(vsi);
> >  }
> > 
> >  static int
> > --
> > 2.48.1
> 
> You can also remove the following #defines and enum related to the code you have removed as they are not used anywhere else as far as I can see.
> 
> #define ICE_L2TSEL_QRX_CONTEXT_REG_IDX	3
> #define ICE_L2TSEL_BIT_OFFSET		   23
> enum ice_l2tsel {
> 	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND,
> 	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG1,
> };
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
>
Sure. We can always reintroduce those defines again if it proves necessary
in future, but for now, I'm happy enough to remove all unused code! I'll do
up a new revision.

/Bruce
