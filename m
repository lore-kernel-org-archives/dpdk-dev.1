Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C737CD98C7
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 17:42:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 667B0402CC;
	Tue,  9 Jun 2026 19:42:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 206FE400D5;
 Tue,  9 Jun 2026 19:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781026971; x=1812562971;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oKo4JqsewBb2UwoAS9Kz1F4pRH8myvI3u5OlvUUvvsk=;
 b=GkxRLXE4KKtHGxNpYD3AMyp1II6iRMBOLLWNzMbcXZlTdEudFfXGU46g
 7S+gnFdLKZScjfpM7vRzZGBMOZSbKdJOJ9NJ60+7wzBDgYvn8urrhKF0l
 fRlCD9ujdkW1KX+OMFmjzsspvHcWn+5yLI7YFQEL9Gdevsi/rRiK03eK2
 LAtTyycWmOGt1HEzcjsg6I0oRRPiXHX5RT9boiHXaahKKXgfON1DhePRf
 6Qb8RIgrCa3UUqW8ikP4Ea1m6L0Ma3YUokU2KL1zwLLzN32HtOivjQCeA
 OxvxbihUTBJ93l7bfD2464RAHT0dAg0HpooX1t54GIa/aClQ9iYDhWyFL w==;
X-CSE-ConnectionGUID: 8Fac5CmWSfOuLv9HNlDVjg==
X-CSE-MsgGUID: 48iJGvdYQ2an0UqiZ+swJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92364499"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="92364499"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 10:42:49 -0700
X-CSE-ConnectionGUID: kbMpisDgQEywr8oe8VrbMw==
X-CSE-MsgGUID: dEMJ3Op1SIG6uthL84cR8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="250856237"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 10:42:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 10:42:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 10:42:48 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 10:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpPGGd9Ku1al6PRVUCWXqUqluWdGoaNej3apPA0YMrxi0w84Xk92zOWctvJnZRUskGncOx8Fr/nax7yCotoT7YvueJpGkAEqWy2iSSFOZh8qwwotjm37paxRcXLi4JgDihtZg5hNwvgKWbtMRBVTl8G7jPe7mTDGH1ZTjy4GPMCGQfIuHv6ieQzmSe40kZ/6Y86xKjDsVo00FyvCwQwH7Tc0BOo8efpulycgHV9Hswht9moy67pc8fVUSIcvM1IILur90CAt2HX89AJwUax2wXeDW8n9tVqL7HeM8m4rzrRWxFCBTvvvp/IoG4GErQyDeVNMaMD8T8PseNctdLHCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UsMoTqFRBs+mpazr0fRvHO7wc/tKSpymX/qe8hSUw4=;
 b=NZJHM8hS+E561po1+sEuhFQ/yhMXn8h/2e1TQ+03qkpjgpp8BwfZaQnmjDpiUPcNVlVWMSm1h0Vy7N3LpUMabpeH2G3/nSbly2LR4XjTQ/6n+1Zh6D5zr3As8x+CPQS1zq8mEnnUXR6O/qxRs3SKxZVZzpU5p1ZCZhE5o478w5yESH9/hMObVYbVXgNDVVhaoJhtGvLXHo+TdPC8VMBeoaLRhqOVSpJF+hbXrCQxCBkueB5+vNswhXRCj6nQPFqEm0HJ0YkMcdNRgjpIV24y/V7hJ1rJ6GKGtfJw9/n2ltTphNWW3Z86F4zzVZaI3Q2g+ld23AcLagyCzr+23uiKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 17:42:46 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 17:42:46 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "Loftus, Ciara"
 <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/iavf: fix to consolidate link change event handling
Thread-Topic: [PATCH] net/iavf: fix to consolidate link change event handling
Thread-Index: AQHc96RYhglbJRwunUu4iGgNKu0KGbY1/tUAgAANmLCAAHJ68A==
Date: Tue, 9 Jun 2026 17:42:46 +0000
Message-ID: <CY5PR11MB6116CCF98503D4DD359A3C43E41D2@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260609001022.357509-1-anurag.mandal@intel.com>
 <IA4PR11MB92782B6A7F4F58953DE954DE8E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
 <CY5PR11MB6116C94D51C347DEAD15108DE41D2@CY5PR11MB6116.namprd11.prod.outlook.com>
In-Reply-To: <CY5PR11MB6116C94D51C347DEAD15108DE41D2@CY5PR11MB6116.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|CO1PR11MB5028:EE_
x-ms-office365-filtering-correlation-id: d86ca815-cd22-4f3d-5abc-08dec64e843b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|4143699003|11063799006|56012099006|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info: e1aEXEK4y0K+lWcYSTHzniEWQVZRtYSBjYQgsjpr6Ci3C+NVOAudDKJz9pQ46ZsG5OvBOtwbf15R+JtzHKgZ2HO7ZnRKQWJAuK3IZHHM12M1hRO1gU9B6U4IY8+am70MVUl2u+SqUy+qkIKso9+MUVEpbvRPQajyT9ax7cXty1Ef53setPKx5wKw70H9xo5KsKd/Y1z212Ohq+8hyy/QAKkRuaddAPOxJx3PTh5oM03sVUsrqH22AsIqHDV7wSHvlvqTUJdFaNjR7TwYq37yvGtdej1Rmm82u3zz68mBveiCJSKbmfg64RIVrlYPCCsv1RxHQYw3NW5mZssERzU5HJpeY1fk+CmH53jQCM9bh3+/liMo/8mZFxwFwNJG3JYoSRiZkNUvZi0EYnjpt8ICXMB22fUlTXjPkLqF9gDSxcgGukh3/OQTLlUutyNXSsOWcaNhIa2LW/oHEgyjlB3MrYEa/sFhd9rjTlpSohkfw594kDwK9+IM6irmrmfvtNIY1EtxLMm4uCiNXVS02mv5/lzHypTg5o6ObYmnHuNz33Wai6bgogFvA1xUBOCCJHN7uzV1UJXdf5W4kDIU+RYKHOM2sIRJtHY352kLzfIGaATII3CDXS1WrguCZTPT3j5AEAtzywmI7foywCjtidX/LQhufTSXh946BDpbxymxlCZ9rCMxKOyj0XA2Cr1i0WqvARGZbwvaA0NPWlUfgt7u2O1o5sXjxgJQEiQ84pBFnb+J4GzmCvE15ZRTyvVcxLZT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OtGJtS06RvctD/RtcCeD0UoDbPrCqjhRHvg2b9yXFb5Afx0LLDtH1sorMBAm?=
 =?us-ascii?Q?gBc8OZIuxHhEUP/Wrhn5ZdD0PXle+GmFb3XO6JNyukMCKNlSbKjUKvXZyG3Z?=
 =?us-ascii?Q?AEN6Tpx7RFI9F+d/NxROP07WNSgytB/BgEZ+W7uxfQxwCvoDUlOSU72l5htG?=
 =?us-ascii?Q?5a0yTuhpklbkOav137dxW4xkldkwkmNOdY/As3telH22nLw9FAxS7BYGHwI4?=
 =?us-ascii?Q?TCsB6MifWmU8SxAIdoMEqCQuCGeeJ+1rGM9nlHAhu8HIxUhmQUnbfwgmuGq3?=
 =?us-ascii?Q?jSpp6HWKxIxkOJtE4MIBeziTlLF73g9GAg1yL5PeKcrdMV5LBQSFB9zzv8dU?=
 =?us-ascii?Q?J1lvb6szEBMe7XNagiIKJmfdhzjmuLEbsU9IpkA+lBWWBi36cyF5qVFZ/+Xt?=
 =?us-ascii?Q?Rs1ZMMqtshq9uQviaNH2qayY8yiW6k7rVUjFAitUeoZJESNdUla4/rgI4pLD?=
 =?us-ascii?Q?pvZuRgf5Nnxd+p9wBZLGPgqT11ATOtPNpGcFhgxCVgYlKBPrIDczjGHXXdLk?=
 =?us-ascii?Q?osRu/fsnY8uHWGCg8Hl92jhQXCWlnK+EIvTr8Me9HRBGNrYDUQleVir6qRQJ?=
 =?us-ascii?Q?ZqK3NykP0PKMz1Ra7cnFFAFQ8znWlYlS5yXN11xD+hEd3/14gZ5TL9ObC4Wx?=
 =?us-ascii?Q?XpqoA84PX4RngU6/eTVyoOXEgVLYQLNf0DM93JDDl35ftaaEW4f+iK8JMvfz?=
 =?us-ascii?Q?peraanctWzRcT7Ob1STjg3TObow1xpMj3iLsV/v0tlzQ22Co+Pee9U2RgSBP?=
 =?us-ascii?Q?r9pwCJIXixaXmBX3OwfHTQCEdBl77OYxI8HfVZSPfvbLOxPKfuQKMYMv/fRm?=
 =?us-ascii?Q?qn0+G/SesXA212vHXcJMmhtMMtFjcmi8d3d7u1o842s8HBRZJfVJC+EhA3XI?=
 =?us-ascii?Q?Rdd6U5qNDO2X41JWO+oNJhH713v3QB7QaNqmNIdZSXGTXzGf6eEXp7bBFOzU?=
 =?us-ascii?Q?obt15Wbfiy5JnC0LMRur6CfdELGho8+rYeXW2HgJvQLhwyEP8ySkq4ZI8P1K?=
 =?us-ascii?Q?6EgxXNiNB5lzbB/Al558BJK7W0LpLcMKHn97CiBDt54xTtHvpacuvYC4Lsrg?=
 =?us-ascii?Q?iZT8Xm2V4PsIeSJ/CiLaUYXn5pC6KkutgI6yIUBxWyW54z8l0MZbxD472A6Y?=
 =?us-ascii?Q?gs7ZvfxiCe2QOmL8a9mJ5lmpOZSTPubMsaS+gujT7pselm7c7tBFSYYBPym/?=
 =?us-ascii?Q?ItAhsx9L+jWxMkdsGTLcBlokWWU+yYOal0sZLmknTfOB0e73Sg7bGVxcJ7xn?=
 =?us-ascii?Q?EXwgR7TZMV+TyMICjzMmwflipr5zg7K/2kzAlzX36no/ObD8Z9hb7rLTy8wX?=
 =?us-ascii?Q?ZcbX6+XPkFCC32H0XUOzr3GsfP3UqeJtwn/EInczh0x+UEah+eCzapliDrPA?=
 =?us-ascii?Q?ZVY2sOWRUGENcd7ZOMjJMawgulK14jXAZYmfwH82eKocZpBid8LNwJIJzHdL?=
 =?us-ascii?Q?hhZmTDeiKQO2xye2iM6foy/rmOSKZ4/xXyfUju0NDgiqT9vXVSIgu1ql5k29?=
 =?us-ascii?Q?oborsPM0BZWHJtlERzYpaCptyJwlsIJO/JRb2sr0I/1ivAKv8GJo/oFR3dR2?=
 =?us-ascii?Q?yszakbOOCgXOKjRdu8pOb8e7hW49r6XS9LyIHzUxgSgx7ZZtRISD5Mczufwt?=
 =?us-ascii?Q?+WULaqTDk/K/s+dRj8KAXSzpiH5vruwk3lOOJmc79Ql3A8K8MpVsHWcNtBu4?=
 =?us-ascii?Q?4ZogrJCBP8J6WDEZCeY3wm8r96CfMt013TryZJGyhYzKxtsHkrz3fbcZIu6U?=
 =?us-ascii?Q?zpuKIKn9PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YlxrRCNnO4Mq26m2nxtQ+zCQAOuHB42hyuiLb96/dXDIVhmY1aEX1uHulhb4sDTPZp/Ne+vgje4u6oFrbOM1VFequVKopIt6a45XRmXInzvSuGnsZ+51lSh+WdYYbIIthoGPBONl8PkmP3O/iEKt23nB3m5HR7vYh3EzWJbRvxQVbaNZh9s78qfpJ+dcewEkYXLgLgZv2f99B96O6oWPZJpWTEvC3dUkkSSJcCq290PdwFRU9UKIZ/TSkRta3CkzwurtWhP5c8kfFcrcK5+gJIX7eQdwtbJ+JpNbH8YGs4ah2n2iBnRBR0pG4yrNPfEcGb0l50Tr5ukDjW/CGEqa9g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86ca815-cd22-4f3d-5abc-08dec64e843b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 17:42:46.1086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxE5CItBjxPntDUNLsVk+yNq249wD/RVhUTA6qj0wiuQLHePyOrW/E0KGu6Qbje7v6KxPRgRG4g6Izv3y6oMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028
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
> From: Mandal, Anurag <anurag.mandal@intel.com>
> Sent: 09 June 2026 16:24
> To: Loftus, Ciara <ciara.loftus@intel.com>; dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; stable@dpdk.org
> Subject: RE: [PATCH] net/iavf: fix to consolidate link change event handl=
ing
>=20
>=20
> > -----Original Message-----
> > From: Loftus, Ciara <ciara.loftus@intel.com>
> > Sent: 09 June 2026 15:32
> > To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org
> > Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin,
> > Vladimir <vladimir.medvedkin@intel.com>; stable@dpdk.org
> > Subject: RE: [PATCH] net/iavf: fix to consolidate link change event
> > handling
> >
> > > Subject: [PATCH] net/iavf: fix to consolidate link change event
> > > handling
> > >
> > > Handled link-change events through a common static function that
> > > reads the correct advanced & legacy link fields properly and updates
> > > no-poll/watchdog/LSC state consistently.
> > >
> > > Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message
> > > without
> > > interrupt")
> > > Fixes: 48de41ca11f0 ("net/avf: enable link status update")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > > ---
> > >  drivers/net/intel/iavf/iavf_vchnl.c | 133
> > > +++++++++++++++++-----------
> > >  1 file changed, 81 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> > > b/drivers/net/intel/iavf/iavf_vchnl.c
> > > index 94ccfb5d6e..6454632541 100644
> > > --- a/drivers/net/intel/iavf/iavf_vchnl.c
> > > +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> > > @@ -216,6 +216,75 @@ iavf_convert_link_speed(enum
> > > virtchnl_link_speed
> > > virt_link_speed)
> > >  	return speed;
> > >  }
> > >
> > > +/*
> > > + * iavf_handle_link_change_event: common handler for VIRTCHNL link
> > > change events
> > > + *
> > > + * @dev: pointer to rte_eth_dev for this VF
> > > + * @vpe: pointer to the virtchnl_pf_event payload received from the
> > > +PF
> > > + *
> > > + * Handle PF link-change event: decode adv/legacy link info, update
> > > +VF
> > > + * link state, sync no-poll/watchdog behavior & notify app via LSC e=
vent.
> > > + */
> > > +static void
> > > +iavf_handle_link_change_event(struct rte_eth_dev *dev,
> > > +			      struct virtchnl_pf_event *vpe) {
> > > +	struct iavf_adapter *adapter;
> > > +	struct iavf_info *vf;
> > > +	bool adv_link_speed;
> > > +
> > > +	if (dev =3D=3D NULL || dev->data =3D=3D NULL ||
> > > +	    dev->data->dev_private =3D=3D NULL || vpe =3D=3D NULL) {
> > > +		PMD_DRV_LOG(ERR, "Invalid device pointer in link change
> > > handler");
> > > +		return;
> > > +	}
> >
> > Thanks for splitting this out into a standalone patch.
> > I'm not sure if all of the above NULL checking is necessary.
> > Especially vpe =3D=3D NULL considering you've checked that for NULL in
> > both iavf_read_msg_from_pf and iavf_handle_pf_event_msg before
> > entering this function. It's recommended to avoid overly defensive
> > checks that can never trigger so I suggest taking a look at this again.=
 Other
> than that the changes looks good to me.
>=20
> Hi Ciara,
>=20
> Thanks for the review. Initially I also did not add. Then I added it as p=
er
> suggestions from ai-code-review run by DPDK. Funny thing is now, it is sa=
ying "
> overly defensive checks". So not sure, which suggestion of ai-cdoe-review=
 to
> follow.
> Please guide. Will act accordingly.
>=20
> Thanks,
> Anuarg

Hi Ciara,

I have removed those overly defensive NULL checks and sent v2 for the revie=
w.

Thanks,
Anurag=20

>=20
> >
> > > +
> > > +	adapter =3D IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data-
> > > >dev_private);
> > > +	vf =3D &adapter->vf;
> > > +
> > > +	adv_link_speed =3D (vf->vf_res !=3D NULL) &&
> > > +		((vf->vf_res->vf_cap_flags &
> > > VIRTCHNL_VF_CAP_ADV_LINK_SPEED) !=3D 0);
> > > +

