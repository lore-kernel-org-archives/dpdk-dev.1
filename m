Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0E7FF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 17:19:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D94040661;
	Tue,  5 May 2026 19:19:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id DA4F34064E
 for <dev@dpdk.org>; Tue,  5 May 2026 19:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778001588; x=1809537588;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JOxH8q3SOGtQSGv1tao1xZGiU3FNrIJECVLPDBa7KdQ=;
 b=MTy+jKoKVBWSgpuyR9j3A89pjrlQ0b3WkYAcY3EztXYGtz9xnm19zNm3
 KyDKduWi7wyacZZWgb5pD7FjuYQi5rNRUb4p5Gi7+LwRCv1Y6b7mOLMzR
 yCoeo9RaSY7Rc9tU28Sjvpis0npJjjRxhvkF/P6JbWjTaN6Wni4ubaqTL
 RggPoyOUY/lAx+2k06jOAmlj/hYdk28tk8sELwehvKBY8jNp90zRoU4gQ
 yOxB2kOSTJYzmTK+YdyOIMF74bJZ+WdLRC0g5HIQXPu8bZaMLxs7cvo91
 3zNoQ6+bR0/8wHsznn7GSfOO8zhgFmhCGgQTEWYXeO/gv5BMqaBCwsf+m w==;
X-CSE-ConnectionGUID: y7TYX8HRTa+d0lenNw7Fxg==
X-CSE-MsgGUID: a2dByf0PQMCvuB2dEOfB9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90255557"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="90255557"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 10:19:47 -0700
X-CSE-ConnectionGUID: uGrkuuGcSReLyiL4cZYo1Q==
X-CSE-MsgGUID: 2mfCwIHoSVOTWCge6WSpTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="259544742"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 10:19:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 10:19:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 10:19:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 10:19:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQBdYcwO6UTYrlNDft67UUiOcUHOfyu2Au7qBPQmJZQQzVUC8w92NKsh2QwCgLPcntN399pwDk8XGIr8D8rcUugY4UJ/HhkomBiBwhOPkBCd7ZqgptyODNzu4ay1eTbtFWjhVz9WOtK85qW9IPN7dFgbQIw+Ts0KXDv3aGRjwZyc8iXoAvMPTifU27VzKi76XBkOOmwhHN1uB4i8NvzsTum8UjOr/YQy0KLWbNngryNAyvC2s7DTxc9WYwgKcL8WW1iJznP2rDyFnt6PPes6e5jXuEbHVt/IzJmLxD52MhF19FksotEPshUrXYaNdZUKsQLUOnkV+gobjiS1SPN2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMEAq6IUtLApjhpcchHVBPkLVKdezPyfVxyLt3NOU18=;
 b=FTaGWYCx6bspcQpfrr/sjOqo1cK1Cqrj+oJb/di4Wx1qiqWdl9UYmF1Wt76IzIWvqw785Co+pLHsAn3s0k9ODFlwR99luXlcqi+4Y87pbCYz162wQ9AprERpREdg7USDZ7r/kvhg7sL8yg/KXKEHYI1zxumDMgRzEViKV+CV2mCDlo/C6o1PJv9OXq6fcP/vBZCP4JljQkDbj7QPj+8473yd8WYyL2mLIuIX5EX6oIiDAntJT08H/niIZRl11QEkvfdD1yXRZ8D+1LdxSdORZe5EyBkxMznXRyHG1Bl5VPtIEm+7AWf3SIRVy03UlbZ21gz/1WPbTCrYHnKH56hH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 17:19:41 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 17:19:41 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH] net/iavf: add support for QinQ insertion
Thread-Topic: [PATCH] net/iavf: add support for QinQ insertion
Thread-Index: AQHc2H9o10ATryObdEyES8aCN9gqvbX/nkCAgAAQQRCAAAMSgIAAAH2Q
Date: Tue, 5 May 2026 17:19:41 +0000
Message-ID: <CY5PR11MB6116BAB368E9537B8CE07205E43E2@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260430085813.230798-1-anurag.mandal@intel.com>
 <afoS_fPQcRO87406@bricha3-mobl1.ger.corp.intel.com>
 <CY5PR11MB6116EB1F473401DD8338FFE2E43E2@CY5PR11MB6116.namprd11.prod.outlook.com>
 <afojM3C73vTAgxlA@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <afojM3C73vTAgxlA@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|CY5PR11MB6307:EE_
x-ms-office365-filtering-correlation-id: 88cd257d-4348-495d-3c8b-08deaaca7e4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 2Wd67I55wm65PwYDmRWuraxGK3p8TUUBGEBL2TDCU6tHiGxXNoHd6faxNCyvAONS8cIircQF5jP+sv69rGpEO0TB6OgJl9eePLf4uHh/ifyVBd9qIcgS3XBfO0BCOw/o/TJd7epJVuUitpphD1EaKhP59BTkZ+Q0LP+J/tDl2zkLjEYIjlQxlUKS6Js3udSsL+XV/NN2dfcn0t4ws5uDJ1kOgrYTDnFSZ7CmMx/F2Inm2fG9vdWTUrw4HR2S4PFr2jVpStPs3U9RBedniOJXf7ptSnxOZYarn/TNfVUErR1F9xUAPfEsmGSQDSC9K0yzmTw8x/N4zU25GbpEJt1Ibz7OS63Yp2iI/VmoUOwrVpp3zNGfloUpiXIof4rznfXkWXGbyvNGrtklQ9WCJH2p842Logfi8neiwwrs8rxkw00jZtYgKhAVDrfqFNOuJCRP5KL1b/KKXkNsVMttWrAXihVBaXehNav6s7Zb1b7mCv8zvnC1OdonzOS38l4JsiPpSQClBVZsaXXAo9JBHG9w7wrRTaQ9sBF5kXDr37QOqVWSm3UKGPXEtnZhyWHooJpPHo/3obuEcQDIGVEEFFTmLzn5s0HSVMVBhQ4LMpDwtPobtNESUnYT37vvL3ALTo/PaYMbd2/MduuWhF0baUwDrs4f59Hncap3WmEogHD7WuowwiuqdAYANfvq4xrGEVwCCPP8mAE9uk08VSF0iXBOaxzcSq1ewSmzcslQNOAZ2p0ztHIEL4JyGCvjfubLnY/g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Rj3/5ORLShf6sep92D5JHSNMgnD5/z59TTtuyN4axvTKkcj4w7a96jJ+01P?=
 =?us-ascii?Q?yFtD2x2dJkqBbSmZnF9v4SyE/XkqHIJBnmqZALwCM9oqT9XLlDyTwMcUdJWi?=
 =?us-ascii?Q?X0YljQ0ONWNPFIjFwtlZuWbWb+0jcli1nnfNQMvonRHcZBF0PxsVru/dlkFH?=
 =?us-ascii?Q?KItQccsWFKZ56WcT5scfTaAGEtmrwUjGIfoMkjbMkfx2YI/sTEEdsdGA9gHc?=
 =?us-ascii?Q?VXTqkAtb1H/XZB9mEvZTvpXusxBYZWG8MWuU7sgI1LUmB6KLdKNNKxK1uf25?=
 =?us-ascii?Q?k7jBiiTl+Co9u8KXLYV8/4czQ/wG5rTRBvkdGvT2L0HvT8naScG13BfrNaNd?=
 =?us-ascii?Q?jLCTBv2OfTgSssBZs+uq0vP7UQlC6g/Akc4tsDMoUbeizPheNBtvOzV2GPMf?=
 =?us-ascii?Q?LcRGbGiuB7zneyLKXzjXnzsI5dERAYsKfy7QRKymO+OKWSODcM5kiG64acp3?=
 =?us-ascii?Q?XLNJCaKEGlov6aZQn4szkB35RpGSNZu0AzBoVwElzo59zqUeeMnUXCWXi64l?=
 =?us-ascii?Q?xWEvKJbPxONNvTvLNV89Ff+zNfKQeY4DZ9+r5kQKUM6QjOcRIi5QOjTewgWQ?=
 =?us-ascii?Q?pkNWIcZAGFyfmys5DwyB/W/Lh6esz/UmI9VFQwdaxoqXoLdcEh2nCmLmYGmr?=
 =?us-ascii?Q?NjoRU25LY9o5iDeAlKC93ftEgzqU4hfAFPN2wTDtxtOIHZ9mp0cN0BJfBRmI?=
 =?us-ascii?Q?yEehMqujk7oNxwnWkUBp1UEoj3MkX0Zb3dAjs0H1NpcCOiq8kGw/MOkFYuxF?=
 =?us-ascii?Q?1NQy0Ec6UiQb2eszbVtxO9pideT52eF4eAwuZfy9ltsCYhpyTdMNBPalOHSE?=
 =?us-ascii?Q?Fw5rNqg/0hBQmE2L7uK/1A8yuV82oL0pcaeKXq4lXBQ8xmmbvILv8QFqvt4D?=
 =?us-ascii?Q?uArM+47DPLJe+jV+8AC0qPc3KeXhz4WeUUQUxfp8uV5ZS34EvO19RdRzkglc?=
 =?us-ascii?Q?qvCdBOCXqj+8IdA21JpiWqpRiXQSvZqTTowbf77YCxafAEntMgcSd8h/8YUW?=
 =?us-ascii?Q?cjfRxS105n1ekzDAfITPWaogZyacs7xv+nV1m2RNMhCKc+Bru3UKTWoQpEjp?=
 =?us-ascii?Q?GOlwVZLTN+WCX+Gin7X2doGk/T2BKF8bpxLyS0/dm2BEWXRd+nIWLKjYZoKk?=
 =?us-ascii?Q?zhN70jMt/DwWeu0O/87lGZczsjVKyBGrASu+uPkHrfRtq3y+IrlmGj/pe2wx?=
 =?us-ascii?Q?zV0ThKtFrrHEwp7mVD33BxonB2vuJh0gqwY6wUIeRjFL6LG2z0TN4B13v5Vh?=
 =?us-ascii?Q?EsmQQIpnM2rh0Fle2pboZATBUxSDu+XzbcqRab7/ZOL1CaibkoSs246XPPcu?=
 =?us-ascii?Q?4eNVNvuuXpoaM8lqyw4ZNJm9nSe1Ue+484DxnDn0dQkI8DHbhS+H7XVxi10y?=
 =?us-ascii?Q?eqvTK1t9vYh3OkclmNwxhNLXPirTwBx+dgKkRH/r1+XALDU7gadrHilSTNhZ?=
 =?us-ascii?Q?r7pQeYpEwyXQcoEdBh2qWWtimQdHa3xuMGqcBWTrBw/P7Bhozj34WYZ+rncE?=
 =?us-ascii?Q?zSDO9O/oFMxfbYaiqRhbI6tJWuExLtcuypjAv2Hic39rPVocKv9HCd3Af1yG?=
 =?us-ascii?Q?nNHcHixpiV6aGxve1XcaQoE672VNyUbCKCoSH38kQRqf+YgIafjGE9I6CQEC?=
 =?us-ascii?Q?jZH95rBmDAqE9BDFMAU7ubAeKidlXaWFQ5I7puM2kJcEUs8+fy58bHGu2DVS?=
 =?us-ascii?Q?VNzejU09lF+yC9uZdKLbVdaze+VIaxqyoPGG+iL/0CnZDqi9wr4Qoi6569ad?=
 =?us-ascii?Q?qe8qJyNp2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W3VOixcpqa71/4FhJE40qqo60g7C89AAyEaF4EAz36PMtRbMto70IoTDMxkwP8rHEtqF8Av5oF0zTzcVwSnOM5DjF8K6F36RAJDj0BIcxWtnlGx4k/9QAFOm6q7YKQ+H1PKHeg74rinG+KxxkgYIfpThcIb7pIO8xsqAyaugdlVWbl8aSow6SacbsUC3QPmVir4usZ1c/a1IpDYKEdTxC42ynoovffoYOwiSmX4mGocs11uUQZDGOMGMr6zkDCv0ZhLhLh/MKKZ89l9wReXaK6tlqr+ZaTZEtTN2Vfj+XOXVb8OjHGtvK8qew94EbaqH1bW8yn3K/62nl8zFIX7K2w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cd257d-4348-495d-3c8b-08deaaca7e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 17:19:41.1681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgnRn8wiSI8EjN8p8gl+EvWQSnQc9rdhY85rTjrwRfkxQd3IrL/oCgEoN0gzuJEGGVqoO5n81gqCup/5E4czHg==
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


> -----Original Message-----
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: 05 May 2026 22:35
> To: Mandal, Anurag <anurag.mandal@intel.com>
> Cc: dev@dpdk.org; Medvedkin, Vladimir <vladimir.medvedkin@intel.com>
> Subject: Re: [PATCH] net/iavf: add support for QinQ insertion
>=20
> On Tue, May 05, 2026 at 05:58:27PM +0100, Mandal, Anurag wrote:
> > > -----Original Message-----
> > > From: Richardson, Bruce <bruce.richardson@intel.com>
> > > Sent: 05 May 2026 21:26
> > > To: Mandal, Anurag <anurag.mandal@intel.com>
> > > Cc: dev@dpdk.org; Medvedkin, Vladimir <vladimir.medvedkin@intel.com>
> > > Subject: Re: [PATCH] net/iavf: add support for QinQ insertion
> > >
> > > On Thu, Apr 30, 2026 at 08:58:13AM +0000, Anurag Mandal wrote:
> > > > QinQ insertion with VLAN TPID 0x88a8 support is absent.
> > > >
> > > > This patch adds support for QinQ insertion for both Outer VLAN
> > > > TPIDs
> > > > 0x88a8 (802.1ad) & 0x8100 (802.1Q).
> > > > VLAN Extend should be enabled for the same and Outer VLAN TPID
> > > > should be set properly for TPID 0x88a8.
> > > >
> > > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > >
> > > In general, looks good. One query below.
> > >
> > > > ---
> > > >  doc/guides/nics/intel_vf.rst        | 19 ++++++++++
> > > >  drivers/net/intel/iavf/iavf.h       |  1 +
> > > >  drivers/net/intel/iavf/iavf_vchnl.c | 56
> > > > +++++++++++++++++++++++++++--
> > > >  3 files changed, 74 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/doc/guides/nics/intel_vf.rst
> > > > b/doc/guides/nics/intel_vf.rst index dfff69b982..ce11ea6363 100644
> > > > --- a/doc/guides/nics/intel_vf.rst
> > > > +++ b/doc/guides/nics/intel_vf.rst
> > > > @@ -802,3 +802,22 @@ To start ``testpmd``, and enable QinQ strip
> > > > for
> > > default TPID on port 0:
> > > >
> > > >     testpmd> vlan set extend on 0
> > > >     testpmd> vlan set qinq_strip on 0
> > > > +
> > > > +QinQ Configuration
> > > > +~~~~~~~~~~~~~~~~~~
> > > > +
> > > > +When using QinQ Tx offload (``RTE_ETH_TX_OFFLOAD_QINQ_INSERT``),
> > > > +you must also enable ``RTE_ETH_RX_OFFLOAD_VLAN_EXTEND``
> > > > +to configure the hardware for double VLAN mode.
> > > > +Without this, only the inner VLAN tag will be inserted.
> > > > +
> > > > +Example::
> > > > +
> > > > +  struct rte_eth_conf port_conf =3D {
> > > > +      .rxmode =3D {
> > > > +          .offloads =3D RTE_ETH_RX_OFFLOAD_VLAN_EXTEND,
> > > > +      },
> > > > +      .txmode =3D {
> > > > +          .offloads =3D RTE_ETH_TX_OFFLOAD_QINQ_INSERT,
> > > > +      },
> > > > +  };
> > > > diff --git a/drivers/net/intel/iavf/iavf.h
> > > > b/drivers/net/intel/iavf/iavf.h index 6a77dacf59..0b6ed221d0
> > > > 100644
> > > > --- a/drivers/net/intel/iavf/iavf.h
> > > > +++ b/drivers/net/intel/iavf/iavf.h
> > > > @@ -459,6 +459,7 @@ int iavf_get_supported_rxdid(struct
> > > > iavf_adapter *adapter);  int iavf_config_vlan_strip_v2(struct
> > > > iavf_adapter *adapter, bool enable);  int
> > > > iavf_config_outer_vlan_strip_v2(struct
> > > > iavf_adapter *adapter, bool enable);  int
> > > > iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool
> > > > enable);
> > > > +int iavf_config_outer_vlan_insert_v2(struct iavf_adapter
> > > > +*adapter, bool enable);
> > > >  int iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vl=
anid,
> > > >  			 bool add);
> > > >  int iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter);
> > > > diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> > > > b/drivers/net/intel/iavf/iavf_vchnl.c
> > > > index c2f340db81..6dd7d455ba 100644
> > > > --- a/drivers/net/intel/iavf/iavf_vchnl.c
> > > > +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> > > > @@ -920,6 +920,51 @@ iavf_config_vlan_strip_v2(struct iavf_adapter
> > > *adapter, bool enable)
> > > >  	return ret;
> > > >  }
> > > >
> > > > +int
> > > > +iavf_config_outer_vlan_insert_v2(struct iavf_adapter *adapter,
> > > > +bool
> > > > +enable) {
> > > > +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
> > > > +	struct virtchnl_vlan_supported_caps *insertion_caps;
> > > > +	struct virtchnl_vlan_setting vlan_insert;
> > > > +	uint8_t msg_buf[IAVF_AQ_BUF_SZ] =3D {0};
> > > > +	struct iavf_cmd_info args;
> > > > +	uint32_t *ethertype;
> > > > +	int ret;
> > > > +
> > > > +	memset(&vlan_insert, 0, sizeof(vlan_insert));
> > > > +	insertion_caps =3D &vf->vlan_v2_caps.offloads.insertion_support;
> > > > +
> > > > +	if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_88A8) &&
> > > > +	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> > > > +	    adapter->tpid =3D=3D RTE_ETHER_TYPE_QINQ) {
> > > > +		ethertype =3D &vlan_insert.outer_ethertype_setting;
> > > > +		*ethertype =3D VIRTCHNL_VLAN_ETHERTYPE_88A8;
> > > > +	} else if ((insertion_caps->outer &
> > > > +VIRTCHNL_VLAN_ETHERTYPE_8100)
> > > &&
> > > > +		   (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> > > > +		   adapter->tpid =3D=3D RTE_ETHER_TYPE_VLAN) {
> > > > +		ethertype =3D &vlan_insert.outer_ethertype_setting;
> > > > +		*ethertype =3D VIRTCHNL_VLAN_ETHERTYPE_8100;
> > > > +	} else {
> > > > +		return -ENOTSUP;
> > > > +	}
> > > > +
> > > > +	vlan_insert.vport_id =3D vf->vsi_res->vsi_id;
> > > > +
> > > > +	args.ops =3D enable ? VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2 :
> > > > +			    VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2;
> > > > +	args.in_args =3D (uint8_t *)&vlan_insert;
> > > > +	args.in_args_size =3D sizeof(vlan_insert);
> > > > +	args.out_buffer =3D msg_buf;
> > > > +	args.out_size =3D IAVF_AQ_BUF_SZ;
> > > > +	ret =3D iavf_execute_vf_cmd_safe(adapter, &args);
> > > > +	if (ret)
> > > > +		PMD_DRV_LOG(ERR, "fail to execute command %s",
> > > > +			    enable ?
> > > "VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2" :
> > > > +
> > > "VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2");
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  int
> > > >  iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool
> > > > enable) { @@ -929,14 +974,21 @@ iavf_config_vlan_insert_v2(struct
> > > > iavf_adapter *adapter, bool enable)
> > > >  	uint8_t msg_buf[IAVF_AQ_BUF_SZ] =3D {0};
> > > >  	struct iavf_cmd_info args;
> > > >  	uint32_t *ethertype;
> > > > +	bool qinq =3D adapter->dev_data->dev_conf.rxmode.offloads &
> > > > +		    RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
> > > > +	bool insert_qinq =3D adapter->dev_data->dev_conf.txmode.offloads =
&
> > > > +			   RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
> > > >  	int ret;
> > > >
> > > > +	if (qinq && insert_qinq)
> > > > +		iavf_config_outer_vlan_insert_v2(adapter, enable);
> > > > +
> > > >  	insertion_caps =3D &vf->vlan_v2_caps.offloads.insertion_support;
> > > >
> > > > -	if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> > > > +	if (!qinq && (insertion_caps->outer &
> > > VIRTCHNL_VLAN_ETHERTYPE_8100)
> > > > +&&
> > > >  	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE))
> > > >  		ethertype =3D &vlan_insert.outer_ethertype_setting;
> > > > -	else if ((insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100)
> > > &&
> > > > +	else if (qinq && (insertion_caps->inner &
> > > > +VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> > > >  		 (insertion_caps->inner & VIRTCHNL_VLAN_TOGGLE))
> > > >  		ethertype =3D &vlan_insert.inner_ethertype_setting;
> > >
> > > Is this not a functional change for existing code/apps? Is it
> > > possible that there are apps which are depending on the current behav=
iour
> with no QinQ support?
> > >
> > > /Bruce
> >
> > Hi Bruce,
> >
> > Thank you for the review.
> >
> > QinQ insertion support is already present in IAVF PMD for TPID 0x8100
> (802.1Q).
> > Meaning double VLAN insertion resulting in packets having 0x8100 (802.1=
Q) +
> 0x8100 (802.1Q), is already supported.
> >
> > QinQ insertion with VLAN TPID 0x88a8 support is absent.
> > This patch adds support for QinQ insertion for both Outer VLAN TPIDs 0x=
88a8
> (802.1ad).
> > So, double VLAN insertion resulting in packets having 0x88a8 (802.1ad) =
+ +
> 0x8100 (802.1Q) is achieved by this patch.
>=20
> Right. However, the change above adds an additional condition to the chec=
k:
>=20
> 	else if ((insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100)
>=20
> meaning that while previously this check passed if the insertion_caps->in=
ner
> value matched, now it only matches if the inner value matches AND qinq fl=
ag is
> set. Will that not break apps that rely upon the old behaviour?
>=20
> /Bruce

Hi Bruce,=20

No. It will not break. Let me explain.

There are 3 VLAN insertion scenarios:-
1. Single VLAN insertion which is 0x8100
2. QinQ insertion 0x8100 + 0x8100
3. QinQ insertion 0x88a8+ 0x8100.

Now for QinQ insertion, needs both  RTE_ETH_RX_OFFLOAD_VLAN_EXTEND and    R=
TE_ETH_TX_OFFLOAD_QINQ_INSERT to be enabled.

For case 1, in function iavf_config_vlan_insert_v2(), qinq is not set, so t=
he following will come as Single VLAN is considered as outer vlan.
if (!qinq && (insertion_caps->outer &  VIRTCHNL_VLAN_ETHERTYPE_8100

For case 2 & 3,  the function iavf_config_vlan_insert_v2() calls iavf_confi=
g_outer_vlan_insert_v2() which does Outer vlan insertion be it 0x88a8 or 0x=
8100.
> > > > +	if (qinq && insert_qinq)
> > > > +		iavf_config_outer_vlan_insert_v2(adapter, enable);

Once, outer vlan insertion is done, then call comes back to original iavf_c=
onfig_vlan_insert_v2()
and does the following as 0x8100 is inner vlan here :
> > > > +	else if (qinq && (insertion_caps->inner &
> > > > +VIRTCHNL_VLAN_ETHERTYPE_8100) &&.

Basically, iavf_config_vlan_insert_v2() is responsible for either Single VL=
AN or inner 8100 insertion and iavf_config_outer_vlan_insert_v2() is respon=
sible for QinQ: Outer VLAN 0x88a8 or outer VLAN 0x8100 insertion.

These are done by checking the flags RTE_ETH_RX_OFFLOAD_VLAN_EXTEND and    =
RTE_ETH_TX_OFFLOAD_QINQ_INSERT.

Thanks,
Anurag M


