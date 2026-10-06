Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF3ECA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:55:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4319740290;
	Tue,  6 Oct 2026 17:55:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 575E64027B;
 Tue,  6 Oct 2026 17:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791302141; x=1822838141;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=I/sHkY2xZ1s5nTxRy6qogv9cZTrNKMLXKNgC77NXeHE=;
 b=IobBciZLQ8Ngb8kopaWvTP8K/EOTmySKeAu7FPPLXMzFYmu6jcT1O0ym
 U4CUz+1TsxsxxD1btT5D4wPrPSn62Q8tPpC7QJ+HkMMPsHtfuKMTLQMWT
 0RIcVLRDb3kCsUtw6O8jnIzAFkDugAYyDJYmkVTqo1U3/NPdKClW/IvNa
 Y6cyJqgo2+zfPQ03/IP+hDXcSI1phd8gZ7ZLHRRXwFw+IW3uTr8iSKC/S
 vNJkWVIAXHACjeM8ag4e2SNX2DZJEg+73Pui3FyXAm67f8exDMobcB1oQ
 tOVfm5MNs1L/JgpBZHU/nPPcqGa9FUFu5QQVfq/0OA4odXy+ExK7KJ9M5 g==;
X-CSE-ConnectionGUID: Zi9VCutqRfGLAU4+Ig9ZcA==
X-CSE-MsgGUID: vgXhMa2QSPGavHpzaRyFMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="55005"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="55005"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 08:55:40 -0700
X-CSE-ConnectionGUID: h11Gw382Sw2L3ojkE8uytw==
X-CSE-MsgGUID: o3TT03rZSHy9Vkqg0zVWVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1283054"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 08:55:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 08:55:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 08:55:40 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 08:55:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfjvsQV5vTMbaXelMJrj1fbtmzupQzgpVNUGoNet1WiLsJhX2VfBuHOXg03ONKjefRe3M1BYV/IhdkECoB9N6fE6DqmV0Dwlx4y/OENcph3PAOTt56zGixJPeAa+euVGrT+oKlu4EtJFhQ2sd0A9hfX8sDNp2S4ASc0h4Psum9SLgfL1MJV9xh6ujXNEkBoXwVAJaM4bZDPXXlf+mcdB+K4LMbEJfzSW259tCpb1zPcDrSU2pcVTvl9HaMVSpYBw0Nfu2ns4P12K0Bz9V76DnnTtQI+apZRnzw7gP1WJ1B4VyP2lQSjefZfVAHHHtC7kKUks3xvp/TQEj890YkwGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkOsaDgwuFjA1QbLWiM5w4FXxmhlL8/iydV/8POnaks=;
 b=KQP8QFQi8rYTAPIjl+GRxS+KkeImTaZsrX1sU1O6vXJrDg3CQYkTfESixyjLHOLEakk89cEg1xkc9V5m9XhYsBkTaNVKpIF8HyLFp9wc5nuxkRKXr0qZ5AmLWiNv3R65CBSVmllYg8BpRDVDnOk+UStIneZC4BFofBm3kCILifnwsW4FSTl8UY1u2tzymUgTjwLguYvPc+llRYHIMu1o9sNQHAQMgSNl+zKRLIwu0pLOSjcsUsiv7nUbU1CkSWGx5LDrsp3T9kNCSNaRVsbmVxkuMbmJfbr3JokglFYRZpWAkK6zGvhLOBCJnviz3Qz+5lks1B+JJQvO6nD8xGO6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS6PR11MB183042.namprd11.prod.outlook.com (2603:10b6:8:530::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 15:55:37 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 15:55:37 +0000
Date: Tue, 6 Oct 2026 16:55:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Anurag Mandal <anurag.mandal@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix disabling outer VLAN insertion
Message-ID: <asUZ9cih29VI5xIe@bricha3-mobl1.ger.corp.intel.com>
References: <20260930024839.337910-1-anurag.mandal@intel.com>
 <80976d36-a074-4124-83c7-003966851277@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80976d36-a074-4124-83c7-003966851277@intel.com>
X-ClientProxiedBy: DUZP191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS6PR11MB183042:EE_
X-MS-Office365-Filtering-Correlation-Id: 222d18c6-f3d2-489c-a49a-08df23c243a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: FybyXhi0ST7u0LCaI8GLhNvyStgFccK9Ip6EENdVpMylQjNJ7U8rQOLR+xmFJyrcY9R88px+b3ZcVi+5JGXobcJxOdlnZHghwugvROeufgyFrvv2t0xDDfVjphrSL+BaFcXjtaB+j3NOvGeDhxnhPgCbD/jkmc0SO7pAqaZN3XqIg1LTKbyxWPYK19seCcEQEjmO3+LLAlD8XEo1ktOlK4DKH3XYnEvFc47r/3j8C2Bc+A3yceA1mFyAE6yyHkyelukcvjUtUgWruuzWd7dnranybqdv1NH+fszZoSgHgTroy/avCRSeXD1X2vq6TD/RTiFrbpbvlWOcmMFvOWr0cjgB8wOZYFaUwPxSiZFIf/lozWyXwtB91j2Ky3HM6s2rkNvFuvLhIFkOybS2pJ3Ojz6pWep+lVa8JP0X3yULuw7/xQxwSfpZ59WdN3yxfB3b+BOj+g4wUM5zIFXi+V0SoUVARkbtbEmb6W1KK+UDVUBlNwJuZTTFFKIST37KW16lyctjDs+wWpZXGaHcCpEkdMuh4DNrUm9fv8iQ1Q4bjXKNwzHCuRDr2/ndWSx7Z+buox7uZfIvrviMtCAvIEgHaZ/a8LxMUM3tCLDXeSHEy0LZdv+46w17vZAkwE3fl9cY1ypDExz82zyB2lDVDIpJPonoQD+9Ix+6q0f0VAsDZOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I8MGqHvsXK6299e6+zCQMcz7UX75+tstBvR4DFgMMtufnFFtMlXibQJJYMBn?=
 =?us-ascii?Q?ZrOzZl5Z7BNrgdQhIfNcrqnHDBw6znFo0JbTorHg8rcsVqazuTKcrUHMMVHE?=
 =?us-ascii?Q?gx5iwRIMc1IXhMp9kM93O2j+/SrgpHtOn54EQc+8ZDH+ZcCHFI00AIWRWYCG?=
 =?us-ascii?Q?jkTac7EfNof55N3pCkM3YBYIH6xZDUh9/lUf0ds/dQIzetPK0g/YVaBdA6O1?=
 =?us-ascii?Q?RZjLwHhWAr95mI6BldKgwsk4mlbOykjGGZhsDpn09qXZqg7ZpaCd9vKfp6TE?=
 =?us-ascii?Q?RvT3sZT06irPBSGaftDBxJdy9htrtt83bsoQEekkT+O/0RWxfDknvrminSvu?=
 =?us-ascii?Q?7F/ZlfpRmr8r3VWyt8sdjCW65EyQgOBSmRmjncEHSC5TEkAZ61uH0alrspeI?=
 =?us-ascii?Q?kzKcftjOPheX5YZig1jvef76zwLSQgRsgmvu0bsFwomk53I4DyN4U25FretT?=
 =?us-ascii?Q?YWzHhsnHwgOuzw4Lw0+4hBjfNtvRorPcIFjduOqMFBsczqNktPJilPN1IJ0a?=
 =?us-ascii?Q?LTNxU2Laq+40sIyAOjz+Ts6PBgB+PpLO2aXR0OqwAemLb9t+OejXZLxz6j9w?=
 =?us-ascii?Q?Rk9QaB/nb6myEmIX6NyWx7gfEUAopEfi4OoXqL8xtIJy8ITH4yXWl/8wItz5?=
 =?us-ascii?Q?KrJS++4hjBh2L1Y94BRul26UcxiqaVfEvFfQij6/67VnCDSqv2r34Y7GZjZ+?=
 =?us-ascii?Q?al66UteoTCQBoie8Vuo97oa3BKAKxmekrdvtyEjd+0neiI9EqzDdQgeAX86K?=
 =?us-ascii?Q?eLuCwBXpyDqpUgrskZ9AWUJA1OyaU8EuPfaNy5+CQZnexRRDqBJb7zWbOpgk?=
 =?us-ascii?Q?R42dsPLr950P3RKNkp2UCG2YARCsv0YeeLupyQRG7ap2wyH1cD6Yv8K7mhJJ?=
 =?us-ascii?Q?iLwLFy5ePZCkSvtqZtSJrEZqU03StMp0Qd7OdIJ8Xc+FyPaC62z7cR/vbfKx?=
 =?us-ascii?Q?vOPVRT2eRtarAqTUZlYNDrSdD36h554Fb+8EjtrMt+vlsDzP6Ez+4hMrm8/p?=
 =?us-ascii?Q?Pk7FJJeH7ZMcLCpnRsvpIefCT/xDX/1iBJCWwm1p9QXaLoUVb3yP7RuAX++T?=
 =?us-ascii?Q?zg6366RccclVf7SosEI7e2AH7trdkny/zs+8uJbjEoi67zbVW53uK+658K0C?=
 =?us-ascii?Q?gneGB/N8soI2B1+yY/vIrn8nRjWyMw6Kdx+Bl8iPXkPy/+QW6p/zUsPZQz/6?=
 =?us-ascii?Q?M300UzZ46lw2vvqQPQ0cgsBptrNMUmumIzC5y9Q3ydvpo8QO2MuTCh0jcWA3?=
 =?us-ascii?Q?DCSQAVnorsv8I1+xLcfNNLyS00X1yxq5WgirLQNL6onIMvJM6Syp48Wf8eAT?=
 =?us-ascii?Q?2RIDa3R/gPlyRVCdpGTpL5rFP3yqp2GdGZMmvLjEfkXuhN8XJfRgD1shjOly?=
 =?us-ascii?Q?ZokBa4Sy2GGCh6gIg6aNcF1F9k6xraJt1nTsyWahI/dxMda1q4IDj1s3xLjV?=
 =?us-ascii?Q?1YexMkWzzYZL0raA3l9o6q8WwUNgOTseehqJe9rjhGIEF1KMyywEbtNEmDq0?=
 =?us-ascii?Q?RyOFey85oC45dQ5j0k8979lGkNVt2h1MRwDag8iW+LpDLNJY/alQKdfewbMm?=
 =?us-ascii?Q?1nMtm5Pycq7D/QZCuiI1kYcSodHtbRfYBefEBkOnB4L5miyXLsTJxc7rGBty?=
 =?us-ascii?Q?nb65zTX8hxR2f3EisUiXdNph2MqsalPXeQaKCfQsmbKyRL8HPMv2DH14BVAT?=
 =?us-ascii?Q?naaC0Jz7ciDrhdfKaY/aaXoawnjs1TKcf9yTClVK5W2fRdHLFiL152XZK/Kd?=
 =?us-ascii?Q?icE96mXlkenIxUVE5ZzZHYbwFCLK8n0=3D?=
X-Exchange-RoutingPolicyChecked: DWlBK6pvTLC5gNaPAb4PWhOZfAHgu8UCETTBee8e07DYBHUSJDnEbmN36yeoioIiLRfZcgii9Ocmheq5A0AmF7vmwx5/rjDVxGw1TKfweCFw4/A8OtumwagFulsKEjryasOySjCZuMbr4Yrv0RaDgWN+O0nJg6zjpl5oqG9yV3JrUeqW2RfwA0WwM45qlvdWaNbcrsIGxsMeoeTem+kDJPdAmsxmRX+3mTaA8oSexjEFXLOJSR4Xp5kVthqySbxwug9n/H6O6LfseOpjrnKva5r+ERJtcvONt+GdPnpIGA4raT5PD4r+azb1rEd41HY8+bo+T2LtYqKdxsazw1AB8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 222d18c6-f3d2-489c-a49a-08df23c243a5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:55:37.7871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: om6IZtDrqcSr5Gvv0QCpU/mFzydCPwRwKcI5KRYf6OFDA+gG2Ykwt94YP344lT6x4+WNQiLQ6N9A7yVF79I4PQ78A6/W+PNvTj1N6ThtSrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB183042
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

On Tue, Oct 06, 2026 at 04:33:50PM +0200, Burakov, Anatoly wrote:
> On 9/30/2026 4:48 AM, Anurag Mandal wrote:
> > ice_vsi_dis_outer_insertion() treats a 0 return from ice_update_vsi()
> > as a failure, but a return value 0 means success, so the error and
> > success paths are swapped.
> > Removing a port VLAN in double VLAN mode logs an incorrect error,
> > returns invalid argument, and leaves a stale
> > ICE_AQ_VSI_OUTER_VLAN_PORT_BASED_INSERT bit in the cached
> > VSI context that later VSI updates replay into hardware.
> > 
> > Inverted the check to avoid this bug.
> > 
> > Fixes: de5da9d16430 ("net/ice: support double VLAN")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
> >   drivers/net/intel/ice/ice_ethdev.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> > index 163304ba1e..2c5ffe07f3 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -6447,7 +6447,7 @@ static int ice_vsi_dis_outer_insertion(struct ice_vsi *vsi, struct ice_vsi_vlan_
> >   		 ICE_AQ_VSI_OUTER_VLAN_TX_MODE_M);
> >   	status = ice_update_vsi(hw, vsi->idx, &ctxt, NULL);
> > -	if (!status) {
> > +	if (status) {
> >   		PMD_DRV_LOG(ERR,
> >   			    "update VSI for disabling outer VLAN insertion failed, err %d",
> >   			    status);
> 
> I'd have preferred we do not treat integer values as booleans. This
> particular function returns the ice status code rather than int so perhaps
> we should check for `if (status != ICE_SUCCESS)` instead.
> 
> However, this isn't a big deal and can probably be fixed on apply, so
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel with suggested change applied. I too agree
that it's clearer to compare against ICE_SUCCESS

/Bruce
