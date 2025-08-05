Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443EEC87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 11:10:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C9C340DD7;
	Tue,  5 Aug 2025 13:10:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id B2E5140A4B
 for <dev@dpdk.org>; Tue,  5 Aug 2025 13:10:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754392222; x=1785928222;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lpTZ8x7DUumm1Jdw/ewKqAlxCYSktLGOWAjToX9OZX4=;
 b=L4d4Pd43A2WmYwtwTrqz9EzGnq6GAObZpz9IAREwJh94Cl5cWdV9oeMI
 pLZWBreGDRQzAXGZ8ioJsJ6RlM+Ycb9odDRigGJRy+eQCQqZFmr2W487j
 sfbSRpkHDl/S34LaMHcGqwLvTqmeRPgQPKWByYS0M78e0Axnf0pD+IY9e
 aiF8iF1ACRlRNWnGPSNt46XbmOOSCjZWKyD1xO9dR0ZetBgZf5j1Pa4ui
 of6+h1CMwMPhSexfo4BO1q6SJj5pwZHR3gprjhirTyOKi2bg4DxVnpDP/
 KIei4/WjbcOgpGc+yLIDNJc0k5Q+dzTuC6o22g7dgqXfnSBOb0uqFpsb2 g==;
X-CSE-ConnectionGUID: 6Ymz3SuESdGtl4FE+8Fx9w==
X-CSE-MsgGUID: OQyYmQZtTqKLDdPYPB5XWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="79235488"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; d="scan'208";a="79235488"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2025 04:10:20 -0700
X-CSE-ConnectionGUID: uM1/AEdhTPGaZbRU62G1kA==
X-CSE-MsgGUID: q6BzcouDQ4+x0GaceAAzxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; d="scan'208";a="164824708"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2025 04:10:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 04:10:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 04:10:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 04:10:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjSv3DDaTOPI5ZmFCJbH6JoYuz9muaxLXFUG7I7XquplSgGP+5TyqrDy3mIumYj88RffxnsuxMjzou17s3uGMjgMGtuQYPorEJNOULveFbUfuAX1/5JNAaQnt2TlKzHA6ajrUdWNb6M1hwPEh2sEZSocpK5kqcAGemaIJKHhgdxGkweuF3+3+oddn1zwH33P7yvgsdAYg5vOtWnCXXPsK+az0nkoxJeRHdeO4mRbwyLZXlgM/bHw5TBM3IHYxlcsxpOLoHZ1iNcMnZafXAryG1qF2I7uhbjFzUFp/8HDPkmSzl8bMIgrwzQAMWjb+kSemSdxVvhfgIy/9V+u2iP1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTkrYLU6iypcK5EIf8/0OLJRa9Ckp4javpQgQYR1704=;
 b=L8YpFdegwauN4V9ZOx0KEOWBg7+w13NAn1X5Yn/38UfAyP776z8UUUCHeg+F58nH4GkR6qu4beoIjXXZf8MLPBF9yZlHjKO9rDBoLPFZTAvm2oxP7SdVoT6JpKDyllF0OlvuvwNOAHVWXCYVJJiT6L80rE4hsYxdeDxl5eYe1Q4HIR2P5XSz+xFcOTIdk0zzvPFTdIH3LZjCoifGaOUdLIdwrpvAS2UacivEEgqwRMp4Nv18yV9fYeDa7+h2Fjn2zuHYCXnPxCMPN0qVvYSq8zTXhqTr8fskgPkRkOj7//pbfe3cKAb1rMPhzhM6yvngRhS4BZC6/467GxwULAiKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SN7PR11MB7439.namprd11.prod.outlook.com
 (2603:10b6:806:343::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 11:09:58 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac%4]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 11:09:57 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH 1/3] net/iavf: support qinq insertion offload for scalar
 path
Thread-Topic: [PATCH 1/3] net/iavf: support qinq insertion offload for scalar
 path
Thread-Index: AQHb4R9JCYPxHVhW5UKjp18FAfxvcLRHoQEAgAyMwYA=
Date: Tue, 5 Aug 2025 11:09:57 +0000
Message-ID: <DM3PPF7D18F34A15BEE3066942172FC92C28E22A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250619133658.13494-1-ciara.loftus@intel.com>
 <aIdc_kAgHNGL853b@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aIdc_kAgHNGL853b@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SN7PR11MB7439:EE_
x-ms-office365-filtering-correlation-id: 368a48de-91c5-438a-f95a-08ddd4109d32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rpoAoX4lZNvNVpffJDNetPQLzZrTBZ7smpGo0HfNoHZpb0A4S/DNJL3EscEM?=
 =?us-ascii?Q?XsQ3d5bOp9t/CUlW6tPHSdVFvH3iioDNiTJWjKe3ufIhEpiBZx5bqWvxfWah?=
 =?us-ascii?Q?ec0ThhmGdcS3nV3xwynNoo48r0bMrLUdRoNEVesulrMfcwtd3LXHGr8weLXc?=
 =?us-ascii?Q?ZBjFMIisoAPoC7DuZtbLJ+lfal8bEryM8/u5QmJyiecAkn7BnO/52z8YLdDW?=
 =?us-ascii?Q?B1pg1MxC4vNPiNm+xH4P/6oFatbGLo/FzBS/QUlrCUJGItIGWgmTHHJpIfvv?=
 =?us-ascii?Q?/Tu29Bdik37oPyZdbQ8FckM43fVHX3drl9GRfcieQfEGHJHaYdNEXGWykWPz?=
 =?us-ascii?Q?J/G3OVAie0aLg6DmnBsG9DeeTZSvMhlqJA5MVosGf6dW/eHhO6Ii6KQkas/7?=
 =?us-ascii?Q?5I9ELPhwMG+bBCTYHcDBStM06TeztQhEt8PgHC5JhkbXWnEwBr7UVKuV09jR?=
 =?us-ascii?Q?axQgV5Atiwd4LjSQIiLqbOnqiHmmz774xyaf9SSJOLBBVqMfWhhoTeQYSEv4?=
 =?us-ascii?Q?8lPhDcemVu7/PnNHteqH0eDtbG6r2ytMeej8NnSnHWDrzvTwfvMraYElMAjk?=
 =?us-ascii?Q?h27mwpJh56kv9SMBGoK15Sj66vKut3CaRlyGr1sO+5KWDa4AY7S8d7sE7FwS?=
 =?us-ascii?Q?q2pH7fb7TC3c3YIQ05HHhYepdrQN4dsz6juFHt1BZ633bMdrQAWwzNVv68Ri?=
 =?us-ascii?Q?h136P6FP25341d1EgU0ZBcDrg19SJBuTzw8OEmR1nFZl+yLVkUHDxL08TwzH?=
 =?us-ascii?Q?aYem1p8TNgjvuwDpW4ci+2HqxXsWBEwRZNtCM0wQfkbY/aZe4um3IJkoq4zJ?=
 =?us-ascii?Q?E1/9OG64CsePiUYTeTJmrs944tvnh8BbisMr0VOdy2MOF54Tr+XP34tVEG25?=
 =?us-ascii?Q?6/neWZhaHvDIvc+PzIcAoVEVOtwpq3X5oMGAVg8tt7Prdav1g7hw+14xsgRP?=
 =?us-ascii?Q?ucCwGsrm+9MEWO19oQ9WecH3d32zWkWIbf40S8vAmaMEFB5nr6PALL4eSR+e?=
 =?us-ascii?Q?efnb+ZhZ0tKD3JNQVUyd6rv7PMlDFXOs+cEEYHgY5VpYHMDnv8xOHtKQMsI3?=
 =?us-ascii?Q?VgMPJIw/TmW11xmEMyQsildlgcVsOKY73K95IQYxZKXPIyVRn7hHWKVDWpYw?=
 =?us-ascii?Q?27wkzYaBf3RrlATFxhOVBYbjnGJLqIlsB5C728wTJQutpjdOxq2FMq/rlEaU?=
 =?us-ascii?Q?U8C73ZwneTaLxSHFQ9fHrMnR58Z5Z3Fjzhm4eFq88aqlIl5+E3wqaaCGUY62?=
 =?us-ascii?Q?GWSIKY5uggKzRlh3G7BEu3xji00UlePzQblsVxmGVxfcGf0B612TnK00o4Pk?=
 =?us-ascii?Q?v3BGAYK7ze26qUhFL8thdJ3vPgF5zEkMw53BLJOSgufd+lpzsG+kuK1sEHL3?=
 =?us-ascii?Q?FycQ8KscE3HfjTJF65tE/5u71tzUvJlJJl+6OwRZR3GM38nL0GvZEP9Gn9m4?=
 =?us-ascii?Q?cmdIlBixK+9i8fhzwxkztVH5xAV71ADQR2H432PVx3k9fLEPxYty7gTmQjEy?=
 =?us-ascii?Q?61tLWPSXMYh/vD8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qbRZ9pjyppKd/mZs4t4pArPvP6lleFKuA97AKo7MpRbcPqAM/RhzpFFasgjB?=
 =?us-ascii?Q?tjSaYrMiHh3H6fld2ZmR8Qm3ExSMWkwtot3SITgrjvlbYKLX+UP6pokzuEG5?=
 =?us-ascii?Q?TTDm/T7ryGzLS/6cTGe2TzBVFtHVNCduZCdj1RhoDtt1ob4sK5lU1UTAsr7M?=
 =?us-ascii?Q?wWvX7xdAXhI5TtnTVz9HN/U7f2XGc1yPbON+wInaOfLphKMG4VaalzdZY0FM?=
 =?us-ascii?Q?aQPlLoLzeEpnH7vJIendcBXTWioozv5ZcP/UoFfPVS2kvZWiWDaCQCZQgYyL?=
 =?us-ascii?Q?MWyDGk2+Rr2HcSVTPxO8IqIdmOzLOAoF+kJjf2oAORYUWPHcEtajCi6BkPk5?=
 =?us-ascii?Q?7vAOZADMyhVRRd27OAF7z7sVegyCkxD7Oj0h2uD3uXnvj3PTb3KhirgcZsOK?=
 =?us-ascii?Q?H7q/nRYQzYoeOEi8RtziwaI5Ie8iWaLbT1597Cc5060uzEINmxlbcYDSteoI?=
 =?us-ascii?Q?q4PfRVTRLDEeiz60QZME6zciVnQTyFLxi45kg/GlZWKlNio1+Hz9N+7DWF22?=
 =?us-ascii?Q?ljSdr78aO9zYueHaSAM13tloUfLzKgD9paDqa+y9VQoyPkohufZksXv/OjNE?=
 =?us-ascii?Q?NS6mo8tD/rUkbShRkHUg/TJmCL4nqezgTBdKnLizw99rKcRabM0HlYm/ifLU?=
 =?us-ascii?Q?SwMQoWx/MGQVXqbQP2ISHcasCkJK1CDPdGCwVRgjve4TqKSZbakfDJIcCjEI?=
 =?us-ascii?Q?GZxPR18vpAUSHLNvfSo7/LU2j6LP/8jCXfC4jtv8ik5yDrTDYXubuDKeujot?=
 =?us-ascii?Q?tQvfbHFr5bJOz0XrvFIRJFOlWxss3uBSxmjIwOx5xpypmkAqYr8K3uVc92sd?=
 =?us-ascii?Q?0qwbnjdobbL2uME6cKxrbKvAuqWXym40cy1+Tju3ocnJDvXn02HU8bH7K1sq?=
 =?us-ascii?Q?gPhFxnLel+yfWYj0m9nPrHdRHBxV6izEOL6ud4IhJecsGmSYsfbkOyDQDWXk?=
 =?us-ascii?Q?MX84sknVT4uIvuDdJ7/BSJkhCNqdzdJ6Vii4BiLyVUJEgeSRA6bPX3FCvwQ/?=
 =?us-ascii?Q?WTC7SEvQXDGifLvXZWWtV+zWlvdMVYOCA7ZoukudxAR8jL8hjrq2Vi8QyDyp?=
 =?us-ascii?Q?KFqV8xE0x0OUTqdhnR07TYEQ2LmUObFocKyUoMe8J2jHpqUMUufCW51AWrv5?=
 =?us-ascii?Q?dFoFNiZAD5g1Vm6V7U+Kj3BMn0FG9zdI0EocRlZ+IXnGRBc+Y4Is1kRl7ZZf?=
 =?us-ascii?Q?y5Dtky7T4SnJlH2yhceNC2f9paFr1YtLX+uC4gMbb8RP/Ro5zwlQP346M1R6?=
 =?us-ascii?Q?se3Aoo/qmo12MKBhYFuxpoB3TnvrE4Mx7UNRPsbY9h1qEJQGhoCgQc4Hm9ym?=
 =?us-ascii?Q?BTMtYyKIYODbCwB6SMwgVG5H+M/4hthmv6ZR5kwmnRy8luShsyCGkYYf3aDn?=
 =?us-ascii?Q?sMEGlWGeyXfu9rwaOkVc4ACQFjUCmfSpmTmsfvASLXpJ7HSHCRqgaCUbakkE?=
 =?us-ascii?Q?WVCuHS+cVDmHGo0BpkLy2z1FGnjCZLKovlHIki+nLV6tmqDEh4WrVjhQqCdc?=
 =?us-ascii?Q?Ps/o/gjErv2258TD3LLN8gAAvMw5g+208eeNcOYQYZuG9vrts1/YkpvojkgL?=
 =?us-ascii?Q?8xu5BGvZvBueDQqcfbikebEn7VVC/Wq7KTACsFdpif2mbIEAZ/oG1FCqiSVd?=
 =?us-ascii?Q?jrMvgFCPmTRw1fE5EdHRXR1KoC+rVaeNVA2fvfwU2aUP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368a48de-91c5-438a-f95a-08ddd4109d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 11:09:57.5282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyZJCbXKHTg9/1h8N8AXRikCtI3N29NxHZHTBCNmaBR7eNVae9+FXaj+S/oOiZKQSBf27K35A2zJPSbV238pjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7439
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

>=20
> On Thu, Jun 19, 2025 at 01:36:56PM +0000, Ciara Loftus wrote:
> > Enable Tx QINQ offload if the VF reports support for inserting both an
> > outer and inner VLAN tag. The VF capabilities report the locations for
> > placing each of the tags - either L2TAG1 in the tx descriptor or L2TAG2
> > in the context descriptor. Use this information to configure the
> > descriptors correctly.
> > This offload was previously incorrectly reported as always supported in
> > the device configuration, so this is corrected.
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  doc/guides/nics/features/iavf.ini    |  1 +
> >  drivers/net/intel/iavf/iavf_ethdev.c |  8 +++-
> >  drivers/net/intel/iavf/iavf_rxtx.c   | 55 +++++++++++++++++++++-------
> >  3 files changed, 48 insertions(+), 16 deletions(-)
> >
> > diff --git a/doc/guides/nics/features/iavf.ini
> b/doc/guides/nics/features/iavf.ini
> > index ce9860e963..61c4742197 100644
> > --- a/doc/guides/nics/features/iavf.ini
> > +++ b/doc/guides/nics/features/iavf.ini
> > @@ -29,6 +29,7 @@ Traffic manager      =3D Y
> >  Inline crypto        =3D Y
> >  CRC offload          =3D Y
> >  VLAN offload         =3D P
> > +QinQ offload         =3D P
> >  L3 checksum offload  =3D Y
> >  L4 checksum offload  =3D Y
> >  Timestamp offload    =3D Y
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> > index b3dacbef84..d058b87d54 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -622,7 +622,7 @@ iavf_dev_vlan_insert_set(struct rte_eth_dev *dev)
> >  		return 0;
> >
> >  	enable =3D !!(dev->data->dev_conf.txmode.offloads &
> > -		    RTE_ETH_TX_OFFLOAD_VLAN_INSERT);
> > +		    (RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
> RTE_ETH_TX_OFFLOAD_QINQ_INSERT));
> >  	iavf_config_vlan_insert_v2(adapter, enable);
> >
> >  	return 0;
> > @@ -1158,7 +1158,6 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *dev_info)
> >
> >  	dev_info->tx_offload_capa =3D
> >  		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
> > -		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |
> >  		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
> >  		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
> >  		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
> > @@ -1182,6 +1181,11 @@ iavf_dev_info_get(struct rte_eth_dev *dev,
> struct rte_eth_dev_info *dev_info)
> >  	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP)
> >  		dev_info->rx_offload_capa |=3D
> RTE_ETH_RX_OFFLOAD_TIMESTAMP;
> >
> > +	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2 &&
> > +			vf->vlan_v2_caps.offloads.insertion_support.inner
> &&
> > +			vf->vlan_v2_caps.offloads.insertion_support.outer)
> > +		dev_info->tx_offload_capa |=3D
> RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
> > +
> >  	if (iavf_ipsec_crypto_supported(adapter)) {
> >  		dev_info->rx_offload_capa |=3D
> RTE_ETH_RX_OFFLOAD_SECURITY;
> >  		dev_info->tx_offload_capa |=3D
> RTE_ETH_TX_OFFLOAD_SECURITY;
> > diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> > index 5411eb6897..1ce9de0699 100644
> > --- a/drivers/net/intel/iavf/iavf_rxtx.c
> > +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> > @@ -797,17 +797,32 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev
> *dev,
> >  			&adapter-
> >vf.vlan_v2_caps.offloads.insertion_support;
> >  		uint32_t insertion_cap;
> >
> > -		if (insertion_support->outer)
> > -			insertion_cap =3D insertion_support->outer;
> > -		else
> > -			insertion_cap =3D insertion_support->inner;
> > -
> > -		if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1)
> {
> > -			txq->vlan_flag =3D
> IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> > -			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap:
> L2TAG1");
> > -		} else if (insertion_cap &
> VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
> > -			txq->vlan_flag =3D
> IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> > -			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap:
> L2TAG2");
> > +		if (insertion_support->outer =3D=3D
> VIRTCHNL_VLAN_UNSUPPORTED ||
> > +				insertion_support->inner =3D=3D
> VIRTCHNL_VLAN_UNSUPPORTED) {
> > +			/* Only one insertion is supported. */
> > +			if (insertion_support->outer)
> > +				insertion_cap =3D insertion_support->outer;
> > +			else
> > +				insertion_cap =3D insertion_support->inner;
> > +
> > +			if (insertion_cap &
> VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> > +				txq->vlan_flag =3D
> IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> > +				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap:
> L2TAG1");
> > +			} else if (insertion_cap &
> VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
> > +				txq->vlan_flag =3D
> IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> > +				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap:
> L2TAG2");
>=20
> Is this scenario possible - we only support insertion of a single vlan ta=
g,
> and it's to go in the context descriptor. In this case, do we not need to
> add in the VLAN offload flag to the list of offloads needing a context
> descriptor below?

This scenario is possible. It's the case I hit when I test with a VF from m=
y Fortville card.
This code block is the same as what's in the existing code, it's wrapped ar=
ound a new if condition checking if only one insertion capability is suppor=
ted (inner or outer). The new code is in the else {}.
No update is needed to iavf_calc_context_desc because what you are describi=
ng is already in place.

>=20
> > +			}
> > +		} else {
> > +			 /* Both outer and inner insertion supported. */
> > +			if (insertion_support->inner &
> VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> > +				txq->vlan_flag =3D
> IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> > +				PMD_INIT_LOG(DEBUG, "Inner VLAN
> insertion_cap: L2TAG1");
> > +				PMD_INIT_LOG(DEBUG, "Outer VLAN
> insertion_cap: L2TAG2");
> > +			} else {
> > +				txq->vlan_flag =3D
> IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> > +				PMD_INIT_LOG(DEBUG, "Inner VLAN
> insertion_cap: L2TAG2");
> > +				PMD_INIT_LOG(DEBUG, "Outer VLAN
> insertion_cap: L2TAG1");
> > +			}
> >  		}
> >  	} else {
> >  		txq->vlan_flag =3D IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> > @@ -2391,7 +2406,7 @@ iavf_calc_context_desc(struct rte_mbuf *mb,
> uint8_t vlan_flag)
> >  	uint64_t flags =3D mb->ol_flags;
> >  	if (flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG |
> >  	    RTE_MBUF_F_TX_TUNNEL_MASK |
> RTE_MBUF_F_TX_OUTER_IP_CKSUM |
> > -	    RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
> > +	    RTE_MBUF_F_TX_OUTER_UDP_CKSUM | RTE_MBUF_F_TX_QINQ))
> >  		return 1;
>=20
> In this check, do we need to take into account possible case for only a
> single vlan offload, and requiring an L2TAG2 field for it?

This already exists. Here's what's already there:

	if (flags & RTE_MBUF_F_TX_VLAN &&
	    vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
		return 1;

Thanks,
Ciara

>=20
> /Bruce

