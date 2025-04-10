Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F8CC369A2
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 06:58:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5C044067E;
	Thu, 10 Apr 2025 08:58:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 29857402ED;
 Thu, 10 Apr 2025 08:58:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744268307; x=1775804307;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XU09Z84uWKE9DJwy2euBnRdsv6vHeibCZomxnrF8su8=;
 b=dt+Vq7xceIEGReXEv4CjDPwzmzv6GZc/8unWXbfPIOGaQRGAiag3r9Bx
 UPEeNQQ+y10+RsECGu1HOvn5LJMe+70BUc2Igg9nC/oqc5uTruviWWubY
 tn5cNBHVF6bOGMFwuyEypZRgjLk8JS6yFs85hVqsq3xBc1q1dMLAmv6Qf
 c0SF3BkTAXTbgmRXZPIMwacvFanCPRLFtqTFeqAcfM+219WXVFTkeZO71
 ktw2ti1W1pWD7VGI1XTZ6+dSTm4pzNJQg/5wdRBLPGQclV9JeqfQR6VEq
 3N+hUGcrXgt8B5BTHPJQk//lgIZX7VCAKt4Qo2+0DiFAttLbOKkmJGO/w w==;
X-CSE-ConnectionGUID: Now6dFW8RUSkt5SiooK9EQ==
X-CSE-MsgGUID: sawG8uTkT1a7SJWxAfDhqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="63162755"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="63162755"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 23:58:26 -0700
X-CSE-ConnectionGUID: 30Q29J5yTAu4GehdnRKZJw==
X-CSE-MsgGUID: W1Z09oVCTzSVZ6mgpZymtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="133928798"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 23:58:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 23:58:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 23:58:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 23:58:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRDffwOWtZqqg3nahz/CpPCWKWeMABOWGt5bo3QbOxfvT9Ba2aYHHWeM4/BdKxeIVoJLCeIZV2y6PxU3AW0jjwG2Fu/wYpL0fewQMXy+PePAHRs3tPhTfvEeATR81WFDWD3uGUf2ilKNxaa3n1OICqKlIaMgNxLNHMtBX8TOSSlCLltptmVKaHS+yEh0yk2+9OUlaV5paqPsp7kwjBZZLTpz09cDdivWtMPPdVoK3EVpxhgjLOOWWY4Zo179WNbOwzkDwD6Iy6h72WcLBNQC79RCwuL1TpQVLZbuiuPDrZhNyoipkysUkbJmRsQr9eCl7yKSzwBX9ATNlI8phQpeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp9zrmHaa9MtB52atUdVSjK10cDZFIc8SlvNThkhmNc=;
 b=In8kKiX5LU15Xvm2JV5yVxLZzu65oBs/2+3ynum+nqYWE8/jO+SnxKz05EXryMdbhqFxYG83cMhif6cBMwy1jnkweV2XjvfY/yL0FeM55iHEsNjL3WoQ2PcIPk98AeYYrZIoBwvnOky23GLjoFwJd3go2TqEjOOWjTP0MmXyCbb7DkezdneBHLIjYdm/Cm1F7FNmg03UL1xg5iNQ3Carvs/vsCh9TDtwymvUJ4OYeFdHZ09VhMA4eIKekm6smdBTg5mU45OZN6TjPCwlUktHwV4UQhXRDkmCP/1Q0JPsCYhaL3YT0iatOTysJ/SX8p3Ji2pYDf40HRjeVHycT4bbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 06:57:42 +0000
Received: from IA1PR11MB7853.namprd11.prod.outlook.com
 ([fe80::7efd:f6ce:fbaf:1c73]) by IA1PR11MB7853.namprd11.prod.outlook.com
 ([fe80::7efd:f6ce:fbaf:1c73%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 06:57:42 +0000
From: "Deng, KaiwenX" <kaiwenx.deng@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, Ferruh
 Yigit <ferruh.yigit@intel.com>, Alvin Zhang <alvinx.zhang@intel.com>
Subject: RE: [PATCH] net/igc: fix xstats name
Thread-Topic: [PATCH] net/igc: fix xstats name
Thread-Index: AQHbqPRJajQHzRw1b0S8dF/8qM22TLOatLCAgAHEosA=
Date: Thu, 10 Apr 2025 06:57:41 +0000
Message-ID: <IA1PR11MB78530504A1D093BF6DDE341D8EB72@IA1PR11MB7853.namprd11.prod.outlook.com>
References: <20250409010711.761050-1-kaiwenx.deng@intel.com>
 <20250408205557.6152d29b@hermes.local>
In-Reply-To: <20250408205557.6152d29b@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7853:EE_|SA2PR11MB5129:EE_
x-ms-office365-filtering-correlation-id: addb73f8-d690-4e95-d12a-08dd77fcfd45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JXacwrzjWKjPIac/Cv90Zk5sw6yXDx4Qunw91ISxhRz542LENWqLZgqB1iBM?=
 =?us-ascii?Q?5ZJ8tAAbOPZ5TFVu2a+wFkfwC3uOkXeF+LK61+aq6aPUiqCyMaYZduPUyyKD?=
 =?us-ascii?Q?2N9xQboQBYhGRqiKzGKsr3+eNjbCrEniprrcRtPVAHBllcSoNflKPX5QvEnv?=
 =?us-ascii?Q?bfVMFoVC2Q6mQqdVjen5l8nOFEQKJHIV+ULNr2a8r1wwfDNCMUnku8mHXXbO?=
 =?us-ascii?Q?gy2mhajB2xCRzUU+GR2+piUC8AzD+p4VZqr7s4Nq6Ir+FzSxs+injDRmuzap?=
 =?us-ascii?Q?0Y5WQTFEQXEgoGocVuDLE547SKGd4nAL+u1VFrmkiijerx7fhjvS0JRbIVsA?=
 =?us-ascii?Q?5vQpafTHWbPB5NKcav1KbL4ZgZzdhN2HjSmUsSHTnO8MVlB43fTLZ+M2zVxO?=
 =?us-ascii?Q?haEdVcBsVyLOFgFYJGk/lTAICeQvzOku1SunwpHaxeJkfkvVErsrvbuNbFeY?=
 =?us-ascii?Q?SyOwFEDqjgOSAj6J1BV4EQypXZudxzTXenx2QqrriGkFhUzz71Q98LBHd0wk?=
 =?us-ascii?Q?ex/Me54ijqRE4MYSgXtrOwLwMLOnRMMwzNlMHYy9NpDhaumt4+VBomBKaSVH?=
 =?us-ascii?Q?ZbD5PjtqI8KQqCEOm6qfp6JogsWK1TYbqj41OxNrySNKNL4r8GdyZJh2GliA?=
 =?us-ascii?Q?MLl0UGy93rzcqtYx07zKdnsHFxKiCK6WGz6caAnk+L12Oe3hog8YBFrVzkJq?=
 =?us-ascii?Q?9s331CTznJjxchC1p24U1h1cTyeg62hacmNULi6WK/iprXXLLlFh3rv8572G?=
 =?us-ascii?Q?d0ZtJbppA9ClpWJkohQCsi91Su6mZl7XESP9WrL4P9GWW1/ewkh3LyIy9ZYv?=
 =?us-ascii?Q?1wQrnvVrKgQYkBVdeU32JgQ8V1g0y0lUXP2ip3p7vo1oGgpu222/ip7F5x3K?=
 =?us-ascii?Q?huXWM/gUcimPYJVNb+jbrIWLW+8RrlpsPb/WtGu2CMpLkiswYGtxa8y2p+Ls?=
 =?us-ascii?Q?lESNCZxIC0kQjtAKSeApUGzCZ3768A7wMNsmFk5kpEFjzKvNM5YrE3w7Q0+t?=
 =?us-ascii?Q?0YBpHZt0XL8tgeoCz9SPdwz5MGAtIJeA623h/XNb3LUFkrgDRmQhZz3x7bX2?=
 =?us-ascii?Q?VjHZUV2KEQ1H6XbBTPYqB5hK/Vvv9X7ex3nl5oa9jpcpxmSmUxedRfIQuooK?=
 =?us-ascii?Q?rc6KkmIwpkcJOG8u2lwTi/FOwukkNxfaZDtSWfZo4oIYG107sT4y2zNNfRsT?=
 =?us-ascii?Q?+E7YL5dz7OWu1M702EA6HRUmvSCecC3uZUrLJ2ROHP1Kx1SxJgKLDvnaIx2Z?=
 =?us-ascii?Q?otXE69Fn2lydl2zZes3UvFyTjKp/KFbyrJe/DvbzbVttjxTo+Pua02dnHRWc?=
 =?us-ascii?Q?1Aq8L3wo9xEJxjCqUG9JoUbXOyKfi0eSTKNRPdrdKIMCqvkxRkj5XkPGGDiQ?=
 =?us-ascii?Q?Mq7RNOagBX3ohUeLrAWs9k4tlwC4SOLuroo1/cY5OIGaa9g2Iq5SjxeMBVjD?=
 =?us-ascii?Q?J8ebmX+hxu33y0lzBNQTgQ5CUMbLd3sCw19lXXSTbQKKalyLfDlsBw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB7853.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L/EVLQky0p9LLOkiQHlL2d7lWvyAWO6dGUMNI7QuiLrxZdHkLCpN1txejN84?=
 =?us-ascii?Q?Km+ft93z9CSIdz49PtU8HpoPqR40Bt3+Owca91B3eXN5WHl99NOqYs+f26vp?=
 =?us-ascii?Q?Vr77jyl5LO0XZyRibpWkO75FJYc7MkrZxNp3XRW0ar0xojIQdsbHb8ZweITw?=
 =?us-ascii?Q?W8zzFXhd3+eeCYJANa76qVn46XKryoh4jA/K+2lnXCevu8BAFOKej1vD3oEb?=
 =?us-ascii?Q?psLo+rDn3xhZQR094A1APHaJSOyWCVniXDzCWcAMxPYxZN6OoXPJjYd+P7ff?=
 =?us-ascii?Q?HbEc5nwHy+O7IiQV6KNh9YWFVmspCJFgu4VsgMuHNTdRYBpUj4VBXx/gVENQ?=
 =?us-ascii?Q?2rvSf8XnzFY0yQSwZQo/WZfFSXAxTTnNRVu25oTvz3fYTdnb5de2oB027MbH?=
 =?us-ascii?Q?N/zbspVbQl0jRu/RCi5CZrcPrZBdJsoyYsnuwYoXrc64Ii5u5Zm42osEXM0A?=
 =?us-ascii?Q?kk1UCsUQTpGaEaJ2nw720e5zFIujuhhmNFJnJrvrrdzooKY+TfK5tD3xgVMi?=
 =?us-ascii?Q?glmcZU6T27D45T8Ic5wtierLYDXuWk4UQT8nvabgHbUWInws6Ud/+aE9xQQj?=
 =?us-ascii?Q?EN1VR1usw6BHAKPyDLPFhIFSlKChI8mbkbq2FyLkmwr+xkjXxvjVwsKjOS32?=
 =?us-ascii?Q?BWiGhqQ1GcuYnzssBlsSPctri7I0G0ejs1gSCC2sPZ45QzWEq5YBlpa6GX7W?=
 =?us-ascii?Q?adbv6M5XBwyMwxcyjRVeJgF7p5+IMdsReokPk5Jo/Nv1JLlzTCgcutiMVhAZ?=
 =?us-ascii?Q?oN32eZ31k5RzYoYdPRcZUfJQe5g9NPBRH9Mzicy+K9Dk9KMdQx0yk35ncqUv?=
 =?us-ascii?Q?LCf8xviSmylMY29jCnZOnLnE6svskVTxO+20bAoiicAxz+ZpjvJfeX3W3re5?=
 =?us-ascii?Q?iELufNELXAXVTteHXFGHdZD+2VOOP2cqkzJlochbyTWporzUIVJUj5IGxwZb?=
 =?us-ascii?Q?hbJTSGJKwsyPhi1gEphumhFcCCyVQ3lLhIX/zGt9EsFgonXGqsqnar/9E3iy?=
 =?us-ascii?Q?3KWHQvQLYatTw/VG+7Si+uIndDRl3vS7Ty72WY81x0MFJx3Qum6JMq04FwL7?=
 =?us-ascii?Q?l5Y4v0X3FYVKaoc0qi0OB4wivDSufrtcELT8ryy4Eolj/CRxhnaGxr4UfGTR?=
 =?us-ascii?Q?CLvHDU6hWXDc+FeHXT/Hrl2b7ZqkadT0qvxPNJ3Jmqe01WN99Oo14jdSZyeP?=
 =?us-ascii?Q?vIk/eFtyo+0GKLyndExrRALix7dqYlSJ5MLxXxgM4Y6ZIUFudNUsJwPZ0naz?=
 =?us-ascii?Q?IwSpUSGrhHk9rpgAhFWsEGkv/aj38F7iXI5PvqK43jLJGD3DMYIqUYS8ZhQi?=
 =?us-ascii?Q?9UbpuNiarWByUp6Rb1No24tDQdsOpXW3znlqAZrapr0n18n1ON5IoDsbyrax?=
 =?us-ascii?Q?Gk6EmfMyVsvuJtGuXhCVW9Mut19XwCTqIePneJ6SOxY2f6Ba1owBTu9GP6e6?=
 =?us-ascii?Q?BsWrfa6VQZvAR61qZwp/WvZLaNCnoyBA3WgPUIOwRem9CRIJhZF0TVjEJAZJ?=
 =?us-ascii?Q?nSlqLeDrV9/MIKe04cFb8iZxEu9O5IrK/K40SrPMV0kjezxG1CZx/tjHBH2s?=
 =?us-ascii?Q?iSXbJWeWOPkkEqAllXOaLfrLUFGlBMAjYDOXwD0+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7853.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addb73f8-d690-4e95-d12a-08dd77fcfd45
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 06:57:42.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvlsO+LkaIE3FREGCkhnRvWcir2zDPmWdg1hMvo7pPTgQLxQZ2nBxIe1DHpjSv4lRk1Wbj0lthrB2YhG0vS+dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday, April 9, 2025 11:56 AM
> To: Deng, KaiwenX <kaiwenx.deng@intel.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Ferruh Yigit <ferruh.yigit@intel.com>;
> Alvin Zhang <alvinx.zhang@intel.com>
> Subject: Re: [PATCH] net/igc: fix xstats name
>=20
> On Wed,  9 Apr 2025 09:07:11 +0800
> Kaiwen Deng <kaiwenx.deng@intel.com> wrote:
>=20
> > The xstats name needs to be changed correctly
> > tx_size_1023_to_max_packets should be tx_size_1024_to_max_packets.
> >
> > Fixes: e6defdfddc3b ("net/igc: enable statistics")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
> > ---
> >  drivers/net/intel/e1000/igc_ethdev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/intel/e1000/igc_ethdev.c
> > b/drivers/net/intel/e1000/igc_ethdev.c
> > index e712cfcf7c..68444e4fba 100644
> > --- a/drivers/net/intel/e1000/igc_ethdev.c
> > +++ b/drivers/net/intel/e1000/igc_ethdev.c
> > @@ -181,7 +181,7 @@ static const struct rte_igc_xstats_name_off
> rte_igc_stats_strings[] =3D {
> >  	{"tx_size_256_to_511_packets", offsetof(struct e1000_hw_stats,
> ptc511)},
> >  	{"tx_size_512_to_1023_packets", offsetof(struct e1000_hw_stats,
> >  		ptc1023)},
> > -	{"tx_size_1023_to_max_packets", offsetof(struct e1000_hw_stats,
> > +	{"tx_size_1024_to_max_packets", offsetof(struct e1000_hw_stats,
> >  		ptc1522)},
> >  	{"tx_multicast_packets", offsetof(struct e1000_hw_stats, mptc)},
> >  	{"tx_broadcast_packets", offsetof(struct e1000_hw_stats, bptc)},
>=20
>=20
> Please don't send same patch twice.
Hi Stephen,
Thanks for your review.
The two patches I posted earlier were fixes for the same issue for both igb=
 and igc drivers.=20
Now I merged those two patches into one patch to fix the issue.
