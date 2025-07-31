Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A5C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 06:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46E2C4026A;
	Thu, 31 Jul 2025 08:04:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 532DE4025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 08:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753941879; x=1785477879;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hdfkNsvrU8MdZ9FqcaQG7BC8xOUtPYveXyR4uVoMocY=;
 b=lzLPWN+5vQ678KhDWAKGtvURpiaRcCnasygSXq9GNzLWCpm/H1/J+AsH
 HQUaF2hPSKk8s3eiaQjqFgU+w0qBoFj4GC447Ry/DdIE8qF4WeRRIzsqk
 gXWgRu/H7CADfv8AaywG9taWfC5wWg8P62el+EbSD+BJO7/prpn9bDa/R
 C/lan6vOXu5bZGAnYEvRk60OAMrf8noPQ+XwDqwamyFWnLwrZ66JdGv8v
 9JVAlK6nlwirmkvFykJl+xARYBNAGaQkgqqbgB0vU5RrYlmCro2gcwme/
 Z8s1I1Cm0vjJZaJpa/ctvpXtb52xzROCfr5JKXnQAUyub+R3PLyh8KGl8 w==;
X-CSE-ConnectionGUID: iAYbEL7tRumjQAdvgusdjQ==
X-CSE-MsgGUID: OhvfJPFsSrGeHc5fQLv+8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56401866"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="56401866"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 23:04:36 -0700
X-CSE-ConnectionGUID: Y0P/mroKQWClijLc2tseNA==
X-CSE-MsgGUID: Ea3zV4c+QzaN6w4h/uj7Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="163521617"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 23:04:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 23:04:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 23:04:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.84) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 23:04:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCy/uVOBmdpR4FmFERmJXASZleFpoUyb1eKTx9DcCCEnVO8BP3uOAvOKTXpg6eLMRTRbCZVzAFU64zue+3s7cQMs44QzLjgHO1tRfx19+kx2IHhNPuP20QlHutZoplhhPBcOXyt/q8bUjoPYXMCs8kxvAds7yqhBtbaHlbR8TVVTiJNxbbWnnZGbetoA5QpJpOJDU0GHV1tNhhKo51T3QxHQvqVcskX915YpjYVc5Wxb8Qmzu4YjNQVdCiiPHBiZzMddx95+eOa9UiOxDuNVrcl/OePAPCtCp3EJAO4VLd5LRcNKwZH2YvLQDFnWABXCf+9i9xoGzscBSd2dcb20gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSaxVbjxdVCzj6PQ+FrVe5NGJxndxbUWr7cdUg8e9J0=;
 b=nZSYgqiMkHFVNlIGg/6ZEyUe1Ei5kUjU6ZaA8PuThfKE465WoAY1Hx5QHZl/bcGdYlRLCv2XugS6Dx3UdDJFfwnA5VkTNV4P9rAsxqk39OijBh6jrKwTqJMVFe2SX0F4GRmX7Xasmav4Cgy2cMMJsRzNMr5fGdAH8X1LXWoU0qmrKYVm+Wo8pEUFoD9h1vY57GSUCsPLb32mf2z8efjDpXfjcljcR01cLOxaAZ+BoDqPCJ0eSo/cyAAgWgcbQdWdTjDu6Sse+D6RKNNnlIq+nR5vUKJmgom0aEttRFdBDzppIiZ9OrPRSeNhgHFpWrxsXM7YHsJRLV2c5Ihh8fqaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9034.namprd11.prod.outlook.com (2603:10b6:208:567::22)
 by CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Thu, 31 Jul
 2025 06:03:52 +0000
Received: from IA4PR11MB9034.namprd11.prod.outlook.com
 ([fe80::ee0d:e6ed:9eba:e5a]) by IA4PR11MB9034.namprd11.prod.outlook.com
 ([fe80::ee0d:e6ed:9eba:e5a%7]) with mapi id 15.20.8943.021; Thu, 31 Jul 2025
 06:03:52 +0000
From: "Wani, Shaiq" <shaiq.wani@intel.com>
To: Ivan Malov <ivan.malov@arknetworks.am>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>, 
 "Shaw, Jeffrey B" <jeffrey.b.shaw@intel.com>
Subject: RE: [PATCH 2/2] net/ice: count drop- all filter stats in Rx stats
Thread-Topic: [PATCH 2/2] net/ice: count drop- all filter stats in Rx stats
Thread-Index: AQHcAdWZaq26DUZ0S0S7JLzyNRIEorRLuHcAgAAEeiA=
Date: Thu, 31 Jul 2025 06:03:52 +0000
Message-ID: <IA4PR11MB9034BCE5E858B262CB34B35F9227A@IA4PR11MB9034.namprd11.prod.outlook.com>
References: <20250731044132.110174-1-shaiq.wani@intel.com>
 <20250731044132.110174-3-shaiq.wani@intel.com>
 <d0ef66ef-b148-8b3b-b2e4-1b20a5307a62@arknetworks.am>
In-Reply-To: <d0ef66ef-b148-8b3b-b2e4-1b20a5307a62@arknetworks.am>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9034:EE_|CY5PR11MB6307:EE_
x-ms-office365-filtering-correlation-id: dc86cd22-d6e4-4016-3652-08ddcff80699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Mz2O2PASJ5RP3EdSSYQVxF9noLS/rNcMg4/mXMVqNzlH7VkAArIbmX9ghHu4?=
 =?us-ascii?Q?3aJ8I/ctflJCS7ScCJ0KJcbJ62MW+c65KYN6GBqhExFF88DIvIi/wNbRu9hr?=
 =?us-ascii?Q?g5nTEJS1OITegGeD53QrG8f6eMXDfUuOkG/cGV7Xc5+Tn6h8nmGg4V6Vy2Fa?=
 =?us-ascii?Q?HYj6qP9bi1vyppSvoc9pDrmK5Dkt/DBXrTGRvZG573EEughz1sMTTRuR7oGg?=
 =?us-ascii?Q?gwDJzu4JqLuAqfgVvu4LDNvM9+5xOecPWcI49wZmlHextUT2ab1Wjop+aNid?=
 =?us-ascii?Q?EC5JyntWqywpI0NneQSLl3QRwFqBv7Lj3YVZWwUySSLcuvEpY0p50mYOA7Bx?=
 =?us-ascii?Q?LkHIj3xGEsez42/TYhAOWiSLHCXJGzl7R7eUfBRwQgE6pihdGEVPS9IE8HVL?=
 =?us-ascii?Q?K+Y/J7TTHBeN750T4vOxSvQ5YrUl8D5Yyt2kuBXbCVVizOPk86IcsVeAmfe4?=
 =?us-ascii?Q?3swrzVmhljZbrd6mqw9SGocZgAlGtoW3zLgLVWb1JxGQSETjyz1A51gg7fcZ?=
 =?us-ascii?Q?C8HYbJG2XcoWyNANC3NNnUNRRQZJpTd80tx7Vbei7rz0IGAMtSL11R0yuz6M?=
 =?us-ascii?Q?kYIkajXlCG2ebnH24vtzLRXntdL/cE5NEMiMrm3PyynboPeG8H93q20uxasz?=
 =?us-ascii?Q?+n1uDvLs1kf0ovDUJTD0p/dswqLJiAuuFPURAfZx1pNMfneytwnep1JetnTm?=
 =?us-ascii?Q?8aYo7dozx+hvr9B/ipwkAI/52YCrNhhHto+0pY4wk9FpA7a79BD7rxqJ05qo?=
 =?us-ascii?Q?2xFdmF3EES9CFu3UY+pOlcmOU68m547j6YXS3Zot2BlX1DzBwURAZXHoF2tv?=
 =?us-ascii?Q?gZVPOH05kjLaBDjikq6gSpS+bzDkuygsg9d9fCwIUsvhZLmn4uSkUaEGQ82A?=
 =?us-ascii?Q?3IZrMraL72Wk52JCeP06x1mqareAZDn0eNnAyW7F6NipYvxk9PZiHei/SLFB?=
 =?us-ascii?Q?vQdQ4OR4OODjSUEnRHehuUrqhBo0FUI3Gc7/BhgGUo5+VNBIvBitAwvj6npe?=
 =?us-ascii?Q?aA6ooMDnFDQxdW56VZDvyP8xKuHrmh08BPhNHCP/zimqZWO2e+2dlyV7rC1j?=
 =?us-ascii?Q?ATHyVakgiy6Ah4KRfmhsrVyaj2stYUsuu2Po8ucstASCO/TRhj7VO+coBTgp?=
 =?us-ascii?Q?1t4w7sXZLOotPbylIJdEumYBaCzfQUK5Rq4n/WtS4VLpzHkQzVIfVGPszVco?=
 =?us-ascii?Q?JVGkAANOdjTPQYdJmXga6qJQR+EOyAMQ6YaUoWZQ+2s82mzKphHiHm8nu88m?=
 =?us-ascii?Q?DDupSYa2ZchJxcTz5PNB/l/tXOcYxKanyVIpM6R1JoHupI1tFi412REYC3wP?=
 =?us-ascii?Q?7H2PJctq0v55s8QD5doWEjG8ndRxBRAfJZtS3GGcevMryMrF4i1jZ248q/Nb?=
 =?us-ascii?Q?cd+UTWhsqPpRFx7Gquyi4KTaf6gLBqAW1Y3rT2wr5RHbCLTjWI7S2x6/PqTG?=
 =?us-ascii?Q?WgqaV1PjHGQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9034.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Aiau3LbrlXqQZCa7UslSRdds0h0HUAewYQCbPYlXgwJbAWEh4No6hrVvur0?=
 =?us-ascii?Q?ODhtjcCldfznPwnikxSWjUhJgVeybY0mFMsaJhMi9re4x6HM2nrkDa+08Zfl?=
 =?us-ascii?Q?1X8UzXa2oqJdsfqXqwdNtwNMkExpAU82eypRD/X/SJEk06XKjKk5xy5WcBcb?=
 =?us-ascii?Q?/0cYBUGP4JiZ0JaGf/XIVzu2uDE/rOmGaCovpOkGGpeTrW2JPLYmsW5Lrv0G?=
 =?us-ascii?Q?HHjPIER8XgDZo5UFG+KahBCJzOlwkVMO/8izyLd7QUxaxlJBjSWQWchAlj55?=
 =?us-ascii?Q?kB/t9qLxYhZN65wL8SXFxM3IzJ2ZFqTlu4Bl/tCl9sdPiNDQjzbcfFewK2vb?=
 =?us-ascii?Q?t9abOTtVxuy9T7gxA9jR3GfVs7+DaoZCrs3h2OPQeinhrGDecsfqICjh+GEB?=
 =?us-ascii?Q?yZGfUz6JEiiobe861FCompwzgQSJ8+Jwd4rJpaEu492hTXm10uoTJ2enWzvt?=
 =?us-ascii?Q?Hcp5u4cW8vFtjEUHxWaLq++BBNEZB7tEWfKnZDcqAsWyY/cYaKZEmNTd7rTN?=
 =?us-ascii?Q?QYrm71VgUNZalYd+/vXcD9HZgM7p3+BDGv6aTYjDUG+MMSBjZV7L+2uor4Tk?=
 =?us-ascii?Q?tCuZzw8W1FQct+GCnkrG565Jg5GZeilneLguywfBfKR5oqxvpzevGeH7EAdA?=
 =?us-ascii?Q?TsEe7MDwt4CL5rv2y9hOGjXf17GKxOReFBB+FhfakGjPrFGDyO3RTHNknAuO?=
 =?us-ascii?Q?PNal0sXu9gCB1RiYiti5gbgSsVsauTSPPpOCanAPtOZzesdCCd7Tevq5pamW?=
 =?us-ascii?Q?NO6OEO6hPKSL7oAZzXzlkl4m/9rQ10Too6dbvFPXA7fe836g6xrNoADaXH7M?=
 =?us-ascii?Q?80j6sTuLOj8JORrycDSzOEHk6UTDHjO2c06I4JfuG40iuFRS4Wua0motPzB/?=
 =?us-ascii?Q?J5sD3K4JNq7enLWrrvF8/ZsWpWluTScOPKrtiLbjGhWP4x1TBFIfZ0QcDRzG?=
 =?us-ascii?Q?zemT1LaACx7EkfLy12nqW7lniYDHbceAgdGg5i1t1H3B4VyGMp+axnKp13Y8?=
 =?us-ascii?Q?JbwJvqsXg74wvFkyOLowxLXcUPofdqVEGxB6HRu6uI5ZKl9QKCtLYeS3RY05?=
 =?us-ascii?Q?0UouI0iRR0plBKTVLKtgha79SvGnF9CPEExFZ87rEsv6feEBuuY56ePMcFD6?=
 =?us-ascii?Q?AEPodKS8/MPu8eplj6OKkl2wxH7R6lVTIAGVQ+RWzDjwjOa0qTu/H0NnIQG5?=
 =?us-ascii?Q?ONBGZzlvJtAKuVU4ZkoSFvefLRmpnIBCSkP0sL6cewBZvUlSyMw/qBNqh0r5?=
 =?us-ascii?Q?KFLLfv6CmgzNIfTpu32K6iBPCaNJoocYmt0phQ0AhE7mcgh2RvNfYdoXiXpC?=
 =?us-ascii?Q?cZ4MYAaCgn4HWBz6XOzCmO7ohDpSo/hv2ZbFVOqSw7WiekWjmWYte1AJceDT?=
 =?us-ascii?Q?BWop7tYDcFU3aZmAai+x5Ge01kcks2EQ8rppcHBUI0GOfPGz/hvOmW1pp1eA?=
 =?us-ascii?Q?pNTYolrXypNQpJBfOts99nsM58x9DRR6SV3PTa49/VUwdSGs3tQLkpjXfPZI?=
 =?us-ascii?Q?Wvm/t3gfDhcw3SIpQVrjXe3uTkF3sKQFRapCJ80rthiCvwCN/FbVcxZ1L6uw?=
 =?us-ascii?Q?8stfebBxCYWx+P6ODYNHrt29tspcBtDaBYe45trF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9034.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc86cd22-d6e4-4016-3652-08ddcff80699
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 06:03:52.5518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UMhNv3y4vbPv+XbXyIv17bRnpxtsYMCYVSLPld+GtN8HwGzAeEIVE0m60JnbPOl3TVN4C3g+++sLim9W2F9JcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6307
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


-----Original Message-----
From: Ivan Malov <ivan.malov@arknetworks.am>=20
Sent: Thursday, July 31, 2025 11:14 AM
To: Wani, Shaiq <shaiq.wani@intel.com>
Cc: dev@dpdk.org; Richardson, Bruce <bruce.richardson@intel.com>; Singh, Am=
an Deep <aman.deep.singh@intel.com>; Shaw, Jeffrey B <jeffrey.b.shaw@intel.=
com>
Subject: Re: [PATCH 2/2] net/ice: count drop- all filter stats in Rx stats

Hi,

On Thu, 31 Jul 2025, Shaiq Wani wrote:

> Packets dropped in the receive direction are counted as=20
> "rx_unknown_protocol" (GLSWID_RUPP),these packets need to be added to=20
> the "ipackets" and the GLV_GORCH/GLV_GORCL counters need to be added=20
> to rx_bytes.
>
> Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
> drivers/net/intel/ice/ice_ethdev.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/ice/ice_ethdev.c=20
> b/drivers/net/intel/ice/ice_ethdev.c
> index 513777e372..0ebe58f858 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -6383,12 +6383,13 @@ ice_stats_get(struct rte_eth_dev *dev, struct=20
> rte_eth_stats *stats)
>
> 	stats->ipackets =3D pf->main_vsi->eth_stats.rx_unicast +
> 			  pf->main_vsi->eth_stats.rx_multicast +
> +			  ns->eth.rx_unknown_protocol +

I may be wrong, but shan't drops and discards contribute to 'imissed' inste=
ad?
According to [1], 'ipackets' is 'Total number of successfully received pack=
ets', and per-queue version of 'ipackets' also exists, hinting at the host =
Rx nature.

[1] https://doc.dpdk.org/api-25.07/structrte__eth__stats.html#ac14b69830000=
494630c8897b70c5fc54

And if, say, they contribute to 'imissed', then no update to the 'ibytes'?
Please correct me if I'm wrong, -- I really prefer just to clarify this.

Thank you.

Hi,

To clarify - the packets we're accounting for were dropped intentionally du=
e to user-defined "drop" rules (intentional) not due to errors.
Since the drop is deliberate, not due to resource issues or errors, we acco=
unt them in ipackets and ibytes, not imissed.

Thanks.


> 			  pf->main_vsi->eth_stats.rx_broadcast -
> 			  pf->main_vsi->eth_stats.rx_discards;
> 	stats->opackets =3D ns->eth.tx_unicast +
> 			  ns->eth.tx_multicast +
> 			  ns->eth.tx_broadcast;
> -	stats->ibytes   =3D pf->main_vsi->eth_stats.rx_bytes;
> +	stats->ibytes   =3D ns->eth.rx_bytes;
> 	stats->obytes   =3D ns->eth.tx_bytes;
> 	stats->oerrors  =3D ns->eth.tx_errors +
> 			  pf->main_vsi->eth_stats.tx_errors;
> --
> 2.34.1
>
>
