Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC9AC87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 10:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DC0740264;
	Wed,  6 Aug 2025 12:15:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 290EA40263
 for <dev@dpdk.org>; Wed,  6 Aug 2025 12:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754475308; x=1786011308;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jpt3Oua6GVo+9bHVUG/qcwA4WeyfCdqUQwGhL+LV3pc=;
 b=lNIPFB7psUXagH6qRH2hnN9eJLur2gmNDPzABP/jlAFgNs83wi9+rris
 HT3Lnp2ZKYw0o9Apgns8ZiK5m2/BLLu4fE7gwk6NMmvHFKXhkSxFcxgdy
 a8I8r4wBHQQAbyKwTtIpx0Gn/iUDzU7YIT/loQ0/QUieJ3mZIxfue+2DG
 A6h77fMc3hSzSQQNsCW8M4no7DnP/qBNfbMXqbJ3B13vNm6ab43fpciLj
 /jGrju0cV+Ra0TcB7nIqnQQEspHiRbb1PO9r5r3Heov2hlo8VwCpaERYj
 Bpgc5/DlfPrlGAs2YHLrjGLuJo0zExgNKEnNmjsfIyk7E3LunbprvyY7w w==;
X-CSE-ConnectionGUID: 96p6/1FkSkOinEdBSeIy8w==
X-CSE-MsgGUID: 9Zx2nwIbSfOruP598gqBVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="68160419"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="68160419"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 03:15:07 -0700
X-CSE-ConnectionGUID: NANbr3+iT4ypg0ypmg0eCw==
X-CSE-MsgGUID: +jd3YL+6TcaVCtQGcRTZ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="163989259"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 03:15:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 03:15:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 03:15:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.78) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 6 Aug 2025 03:15:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7kxjE/g3/lFdBDNeWGfc6sntfZ2LEIC6lM2bpdMit8uCNQZZVUXQkdVpsgwafKBLBj+ez0+qy9xoGJA6ruVyo0HH7wvkG1q9qHOSNOOwumPltNymL3CRdg0uCHjwGNDJcgBVkLQubeIyFYrRKJcp624dtUpbBMceGCisRFVPRre7JK0A35MM4iEgH/MiBurjgLCL55sWextcl69dRXQV5jOla/8iY4eJIuvA2HjONeFOR6h9xN3PsWJqdvSK410PuyqdQ/iwEZwSzMWr4Yp6+E4yrY4nWEurZGawAEBKK07ETqbv8hxaQtbAPy8+GXVLrvCfSULmkbof2rgmNFnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMueUQbv1tOQ5qhKMvmrbnCMxPECfKS7m8s98pfbqv0=;
 b=gxGEL9vVQwaeBWkUARbimYuli2NXvGxhxnKy8aBNicXM7sucJOf36AzMLLZWFmRUrgOk+5zfg6jp5/ALbQKBLDvJ3mxcQj6xe6sNYitO3vh/vCFzhJiGDMaQrm31xm4MkpNpdJKxzvcUV0zIoKW/IKWewM7T3+iVtEQopcjGOattx1f0Yo30fZqoDShPn0o1a5dQFFPRFeF/9lp1CpPSnnVWwz4PjbYwfxBGrEmCGDbKJnRlNrgsCfv6kfZ601LWyiK4tXjsg8+o0iEINJHg0Zd38jxIgSgWsubkikigf6OkQI/uGGDLmiTeh8iCYw/qJJcydWIjneIIxS1/KvxDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SN7PR11MB6994.namprd11.prod.outlook.com
 (2603:10b6:806:2ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 10:14:59 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac%4]) with mapi id 15.20.8989.020; Wed, 6 Aug 2025
 10:14:58 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC PATCH 10/14] net/intel: introduce infrastructure for Rx path
 selection
Thread-Topic: [RFC PATCH 10/14] net/intel: introduce infrastructure for Rx
 path selection
Thread-Index: AQHb/WK0JEQd1FbuokyOxykTFBDhgLRC9PEAgBKFWVA=
Date: Wed, 6 Aug 2025 10:14:58 +0000
Message-ID: <DM3PPF7D18F34A175CDB2701F500BBD0EF18E2DA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-11-ciara.loftus@intel.com>
 <aIOhFIwIpdo1nghY@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aIOhFIwIpdo1nghY@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SN7PR11MB6994:EE_
x-ms-office365-filtering-correlation-id: 367adac8-581f-44fd-abdb-08ddd4d21945
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yIWRYmds+uIRTUA4Ype1HjUqMREpjvun9CI4yhDLkcOh8Qr0ZEKaf+vD26JU?=
 =?us-ascii?Q?Pa+566I+ZhfXlsGIMHA1VgaAaO3NJ+hQY8kaksrhFO6oz0YdovNvlEHALdlR?=
 =?us-ascii?Q?iTmCvQ7ce+xA3URaenbvs9HNSRQoZ3csB3zJiQ24GDD8S6Drz1Z9NnWBjq3i?=
 =?us-ascii?Q?UXl7QYpKzhyiUACKeLzNlN5hu6bvWYa3tshHBQbpvT00pvl+E0ZQcgFabFcP?=
 =?us-ascii?Q?kAeikd97iLJncVluf9+mRI9Bl0ZRqslSp2DHu/kdLSF66XVKAV7hcvYrnhtC?=
 =?us-ascii?Q?/ncLev3lu8HTf2QrMFMe325tQk3ZIagTonU9yS+xcNIjAsRIQN2zNT1rKgqB?=
 =?us-ascii?Q?nGlJEX05JDNSrKBu5zPuUbRhXw8Pu7uFv7oZEqi/4iTTUlxfZb6edgGC7zow?=
 =?us-ascii?Q?J+BGMCcLN0jxtytSba0yBt6W0jJRO/dAZl/43NdhbDZceGHuOEZPkUIA4URt?=
 =?us-ascii?Q?eWudkKg4aj0lUUjlgydipohfLbEkbit7bHHKTkcuQsTPqjb4ns/oF81B0+nn?=
 =?us-ascii?Q?q9Hzz5olU7qs1vJSjuwpQenLcaj3UQTnNAf9bXhCZRpb6XoNu6V+ZrB1r88E?=
 =?us-ascii?Q?XQrJICyINrFGnio7hl1r6R0ZheJQDWxI73zWt5iLs9OZ3pkhj2vRyn2/6Dk3?=
 =?us-ascii?Q?QTJ3RBZqdUJWED4TuLNw7pEiFtIDjpeqmoM6B1z/w3UQYSNT3TwGVMdz/dDn?=
 =?us-ascii?Q?h3pNhyt7QJwlxgr6dcv6oMxn+lerHoOE+R9E15ZoXd3uVF5LuK/9DY54klbb?=
 =?us-ascii?Q?OWyhC53Rjeryvwx1ANVY3EJDV3wlGyFa2vkPHI6FKzbD8XfIIXDXFiFVXbHK?=
 =?us-ascii?Q?hNOWM1i+j3VGSE5SHkbfIMDpiPbxD4qnZpsdNelw8a7MJemJLO5CAWmDP3el?=
 =?us-ascii?Q?pDODhR3ZVZwVndM/Ds4GU5x6BiGhsEj7yS28h9/FA1sVVBr992KwcIG+pQqj?=
 =?us-ascii?Q?hqmF6QB3tO8RrqqNBH6MoBNb85TLMOL4w4RCDGc2TEfks3QxzyvG5G4W+/yE?=
 =?us-ascii?Q?KxJRfZAfRkeXr04t+HNY5p3ejxIzTsca7jPc1FQ5sTJ+elyf4OgKSWOGy3Hj?=
 =?us-ascii?Q?FsUq5WRynBs98InOehHwnGE3sv/BRmwkc8wifhOYIZaq6lCoj/3Q/QMcO81b?=
 =?us-ascii?Q?fk2KeFPpTTZ3OUDTtxEnaaeDdxDL/xox8AoB77Eoo0GHrFBKpurG3RetaJGi?=
 =?us-ascii?Q?bFHo7toIFU4gVSYJuMoedouWKZWXpq6wp2Gif5lB+tgy9V2KpkBi6IFoS6/k?=
 =?us-ascii?Q?eS9Zm/ZHL+XSuvRGh7q5A5LzNY2JsTVgHLiHIp7VQy/xvamnHPIF28gBMEYB?=
 =?us-ascii?Q?PY6vSqj75A7WbgNQAmQbMmoVluNEEnSY7fftUqz8T9BObwiZ5x3g7VuQbgiJ?=
 =?us-ascii?Q?GP4XaZewvbfzd6zNygqSOHo/RGpHEvxCYiKt6iMtT8Lsfllohe5XVc7gx9qx?=
 =?us-ascii?Q?OSc3ExD0Kq1DpBjbYoBBd7FhKin19BPjCBtGkk9lZ9Yt8L9J7SRGxWxZs2fz?=
 =?us-ascii?Q?0P+tX6/0f/Yn1b4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DTVYBgpGfS8I9gyqV/buY7D8t6VTAJ7LvDCthQl++5Ttvw9QrchjgaBEq8Jf?=
 =?us-ascii?Q?y6XsPecdzyybCLHi7jHX+nOw7pFBBY6hApYz/CR1lXOlKk6TnOna6PrvR39C?=
 =?us-ascii?Q?i9gwFWgsQljPLryjl5TrPuLAYdcks6wrmN3hgT5Kl7sy4oFQ9pc08C5YBk/T?=
 =?us-ascii?Q?yPkeZb30mxa+83sVp8hfOOTyWXp7kMSu4AVQKdiwfpXPOxWzSvjSr/6TX7tj?=
 =?us-ascii?Q?4zqr9HZItsoN3EV2LcEQN4MCq84g1rkps+l+ADyZAmMaxQUps71NCo/nfLSt?=
 =?us-ascii?Q?JVujKkI6pS1GqVmYNuPiaRibg+2qMQkr3l5b8J/uAZiGrnSmuzj1XK+DE8V3?=
 =?us-ascii?Q?AHpW7p7d3ra9X9CkfPpxxC/bzut7uciuNIn6HRYfhqqh1ehlaEfKFXjqf4tH?=
 =?us-ascii?Q?GUlArwIaOsDG432V3eafCGN3iUw1e3ed16jJoPlj0arWfLLEyoThTdwBxPHB?=
 =?us-ascii?Q?DxtLdJXVvsUrP8GLKr8WKIk4yGCMQ+5DbnbOd6A1uH7kbgRIDmOt+7y6gjHv?=
 =?us-ascii?Q?1MGibY73vLGa5mAasGXJ+nXc3JGyi/Ol3VbJVcgl7bsYZTde31RXkw9mO89R?=
 =?us-ascii?Q?53s/txmvCVSpC84aeGbKHa9u6pgkpzE0FXO2nTnsStGh371iI/WU886MMhYE?=
 =?us-ascii?Q?7+HCFUDd9qeXg/owProrzHVn88Mo+Cz8W1YofCAWRDhL5m+TfnhuSFYIIl2S?=
 =?us-ascii?Q?6sCyawZaATiIshm6JSEO2uItl2VvQQPvEkRPQvFNWwwYMnbHTcpQonVUPuaq?=
 =?us-ascii?Q?KjjdAkAr1JEWyD77PfpCSF/R1/a/b+RV77t1dfoH/TvVjHTP8T79/gNYKMKU?=
 =?us-ascii?Q?L7AR06RkqIdAJpDgTvsL5D3Sm6Hk+bKR3JSEkGvk3pHjOk51mp4pAnP1emXQ?=
 =?us-ascii?Q?LpFG2P4YeVerJZvwANxm6JUJbgv0L4VVRMzxYKKSGCyr8WZPKJqCGS+i4ew3?=
 =?us-ascii?Q?fjoj45BucN7JIbSjJ5F2p3TcPasVvTit4WCVW7IcB7ZBNZzmx7CXknkTRaZz?=
 =?us-ascii?Q?dSG3BFm3kAaEwY2GDJPt//7R9K2n/FwWn6ZUeecvHpI2ZtBrLDQLffvxpYvP?=
 =?us-ascii?Q?BivZ9iEFiniBj1JhcNDjXr7ch+CXpLFBxcdwBAEE4FWJ++OQk8ljhTsBqxM9?=
 =?us-ascii?Q?pEsKaJAWNVKL1N7ii3hL8Jj7iCqjxBQfyyrsQRIK7Dm6/E4PrBZjx7YvFqbV?=
 =?us-ascii?Q?C3iFo+sO1Afdo5L7Akb2YN9EVaa/R+P+bZaae8weV3uBqM1QHPwdBTKSQ6d/?=
 =?us-ascii?Q?sEkUEa/NH3LUvcK8rbccZMi8Mw0sYsIJpyJUK6cCj6t6ZvrLLsqo1ZrCJQfu?=
 =?us-ascii?Q?EEVjH1pSAUYTtmPFxKeuawyunwy034G6e0yqlRn1yYS3nJjjrEliJ6VWx70v?=
 =?us-ascii?Q?wlqGETu5p2vL5pS+dAa4Q4D2dECfv3nNn/Qaa44oBLKjwS8cvhH5Cklg+C/w?=
 =?us-ascii?Q?W3ixI7GTLAv4n21UIi999Mn9m+r0DGnXZKGaWFu/RdiIvxz/ssB/xUVbsWi+?=
 =?us-ascii?Q?CsmhYa60sBII3QwTuG8bOdigQ2Vdl2mnmmN7DXgATKcIj3bJsQkDWTeHi69r?=
 =?us-ascii?Q?t7X4wh04g2iWIL8A9UQsdbp0rEnRpunfyg3rypOl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367adac8-581f-44fd-abdb-08ddd4d21945
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 10:14:58.8126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leX3kPsNVXgt9y+SSEPzeJxX0bco9RGq6Bm5jXghN1NQcMMq2X400TA3V/wQCMjTiGSA+blJfej0Mq5P7cdLjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
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
> On Fri, Jul 25, 2025 at 12:49:15PM +0000, Ciara Loftus wrote:
> > The code for determining which Rx path to select during initialisation
> > has become complicated in many intel drivers due to the amount of
> > different paths and features available within each path. This commit
> > aims to simplify and genericize the path selection logic.
> >
> > The following information about each Rx burst function is stored and
> > used by the new common function to select the appropriate Rx path:
> > - Rx Offloads
> > - SIMD bitwidth
> > - Flexible RXD usage
> > - Bulk alloc function
> > - Scattered function
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
>=20
> This is a good idea to simplify things. Some comments inline below.
>=20
> /Bruce
>=20
> >  drivers/net/intel/common/rx.h | 110
> ++++++++++++++++++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >
> > diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/r=
x.h
> > index 70b597e8dc..6e9d81fecf 100644
> > --- a/drivers/net/intel/common/rx.h
> > +++ b/drivers/net/intel/common/rx.h
> > @@ -10,6 +10,7 @@
> >  #include <unistd.h>
> >  #include <rte_mbuf.h>
> >  #include <rte_ethdev.h>
> > +#include <rte_vect.h>
> >
> >  #include "desc.h"
> >
> > @@ -20,6 +21,12 @@
> >  #define CI_VPMD_DESCS_PER_LOOP_WIDE 8
> >  #define CI_VPMD_RX_REARM_THRESH     64
> >
> > +#define CI_RX_BURST_NO_FEATURES		0
> > +#define CI_RX_BURST_FEATURE_SCATTERED	RTE_BIT32(0)
> > +#define CI_RX_BURST_FEATURE_FLEX	RTE_BIT32(1)
> > +#define CI_RX_BURST_FEATURE_BULK_ALLOC	RTE_BIT32(2)
> > +#define CI_RX_BURST_FEATURE_IS_DISABLED	RTE_BIT32(3)
> > +
> >  struct ci_rx_queue;
> >
> >  struct ci_rx_entry {
> > @@ -125,6 +132,19 @@ struct ci_rx_queue {
> >  	};
> >  };
> >
> > +
> > +struct ci_rx_burst_features {
> > +	uint32_t rx_offloads;
> > +	enum rte_vect_max_simd simd_width;
> > +	uint32_t other_features_mask;
>=20
> Rather than using a bitmask here and having to do bit ops, how about just
> using individual boolean variables for each setting. Given that we only
> have 4 settings right now (disabled, scattered, flex, and bulk-alloc), th=
e
> actual struct size here will be the same, but the code will be simpler.
> Since this is not a datapath function, I'm not worried if the overall
> struct size grows a bit over time.
>=20
> I'd also note that in the structure below, we need an extra 4-bytes of
> padding anyway, since the pointers require it to be 8-byte aligned, so we
> can have up to 8 flags in the rx_burst_features struct without affecting
> the size of the burst_info struct.

Thanks for the feedback on the series. No objections with the feedback on t=
he other patches.

The choice to use a bitmask here wasn't for space-saving rather for readabi=
lity in later patches when we define the ci_rx_burst_features for each path=
 in each driver.
For example, if a path just has the scattered feature, it's features can be=
 defined like:
{PATH_OFFLOADS, PATH_SIMD_WIDTH, CI_RX_BURST_FEATURE_SCATTERED}
instead of the below if we were to split the mask into booleans:
{PATH_OFFLOADS, PATH_SIMD_WIDTH, CI_RX_BURST_FEATURE_SCATTERED, 0, 0, 0}

Maybe it's not that much of an improvement in readability. And I suppose it=
 introduces a little bit of extra complexity in the select() function when =
reading the values of the mask instead of reading simple booleans. So I'm h=
appy to go the boolean route if you feel it's better.

>=20
> > +};
> > +
> > +struct ci_rx_burst_info {
> > +	eth_rx_burst_t pkt_burst;
> > +	const char *info;
> > +	struct ci_rx_burst_features features;
> > +};
> > +
>=20
> Just on struct naming - would it be better to use the word "path" instead
> of "burst" in the struct names, as in:
>  ci_rx_burst_features -> ci_rx_path_features
>  ci_rx_burst_info     -> ci_rx_path_info
>=20
> Given that the mode_select function below takes as parameter "num_paths",=
 I
> think this would make the names more consistent and meaningful.
>=20
> >  static inline uint16_t
> >  ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs,
> uint8_t *split_flags,
> >  		struct rte_mbuf **pkt_first_seg, struct rte_mbuf
> **pkt_last_seg,
> > @@ -222,4 +242,94 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t
> rx_free_thresh, uint64_t offloads)
> >  	return true;
> >  }
> >
> > +/**
> > + * Select the best matching Rx burst mode function based on features
> > + *
> > + * @param req_features
> > + *   The requested features for the Rx burst mode
> > + *
> > + * @return
> > + *   The packet burst function index that best matches the requested
> features
> > + */
>=20
> Missing doxygen documentation for some of the parameters.
>=20
> > +static inline int
> > +ci_rx_burst_mode_select(const struct ci_rx_burst_info *infos,
> > +			struct ci_rx_burst_features req_features,
>=20
> I would swap the order of these first two parameters, so that the request
> comes first. As well as (at least to me) making more sense having the
> request first, it also means that the "num_paths" parameter immediately
> follows the array to which it refers.
>=20
> > +			int num_paths,
> > +			int default_path)
> > +{
> > +	int i, idx =3D -1;
> > +	const struct ci_rx_burst_features *info_features;
>=20
> This can be defined inside the loop.
>=20
> > +	bool req_flex =3D req_features.other_features_mask &
> CI_RX_BURST_FEATURE_FLEX;
> > +	bool req_scattered =3D req_features.other_features_mask &
> CI_RX_BURST_FEATURE_SCATTERED;
> > +	bool req_bulk_alloc =3D req_features.other_features_mask &
> CI_RX_BURST_FEATURE_BULK_ALLOC;
> > +	bool info_flex, info_scattered, info_bulk_alloc;
> > +
> > +	for (i =3D 0; i < num_paths; i++) {
> > +		info_features =3D  &infos[i].features;
> > +
> "path_features" is probably a better name for this, since it refers to th=
e
> current path we are examining.
>=20
> > +		/* Do not select a disabled rx burst function. */
> > +		if (info_features->other_features_mask &
> CI_RX_BURST_FEATURE_IS_DISABLED)
> > +			continue;
> > +
> > +		/* If requested, ensure the function uses the flexible
> descriptor. */
> > +		info_flex =3D info_features->other_features_mask &
> CI_RX_BURST_FEATURE_FLEX;
> > +		if (info_flex !=3D req_flex)
> > +			continue;
> > +
> > +		/* If requested, ensure the function supports scattered RX. */
> > +		info_scattered =3D info_features->other_features_mask &
> CI_RX_BURST_FEATURE_SCATTERED;
> > +		if (info_scattered !=3D req_scattered)
> > +			continue;
> > +
> > +		/* Do not use a bulk alloc function if not requested. However
> if it is the only
> > +		 * feature requested, ensure it is supported in the selected
> function.
> > +		 */
> What the is benefit or reason for ths second part of this - checking if
> it's the only feature requested, vs being requested with other features?
> Can you please explain a bit?

Sure. I agree it's not clear.
This is a way to ensure that the scalar bulk alloc path will be chosen over=
 the basic scalar path in the case that no other features are requested.
If other features are requested eg. scattered, they take precedence over th=
e bulk alloc request. But if only bulk alloc is requested, it should be sat=
isfied.
I will try to improve the clarity here.

>=20
> > +		info_bulk_alloc =3D
> > +			info_features->other_features_mask &
> CI_RX_BURST_FEATURE_BULK_ALLOC;
> > +		if ((info_bulk_alloc && !req_bulk_alloc) ||
> > +				(req_features.other_features_mask =3D=3D
> > +
> 	CI_RX_BURST_FEATURE_BULK_ALLOC &&
> > +						!info_bulk_alloc))
> > +			continue;
> > +
> > +		/* Ensure the function supports the requested RX offloads. */
> > +		if ((info_features->rx_offloads & req_features.rx_offloads) !=3D
> > +				req_features.rx_offloads)
> > +			continue;
> > +
> > +		/* Ensure the function's SIMD width is compatible with the
> requested width. */
> > +		if (info_features->simd_width > req_features.simd_width)
> > +			continue;
> > +
> > +		/* If this is the first valid path found, select it. */
> > +		if (idx =3D=3D -1) {
> > +			idx =3D i;
> > +			continue;
> > +		}
> > +
> > +		/* At this point, at least one path has already been found that
> has met the
> > +		 * requested criteria. Analyse the current path and select it if it
> is
> > +		 * better than the previously selected one. i.e. if it has a larger
> SIMD width or
> > +		 * if it has the same SIMD width but fewer offloads enabled.
> > +		 */
> > +
> > +		if (info_features->simd_width >
> infos[idx].features.simd_width) {
> > +			idx =3D i;
> > +			continue;
> > +		}
> > +
> > +		/* Use the path with the least offloads that satisfies the
> requested offloads. */
> > +		if (info_features->simd_width =3D=3D
> infos[idx].features.simd_width &&
>=20
> I'd probably make this an "else if", since we don't want to bother with
> this if we have just updated idx based on the simd_width.
>=20
> > +				(rte_popcount32(info_features->rx_offloads)
> <
> > +
> 	rte_popcount32(infos[idx].features.rx_offloads)))
> > +			idx =3D i;
> > +	}
> > +
> > +	/* No path was found so use the default. */
> > +	if (idx =3D=3D -1)
> > +		return default_path;
> > +
> > +	return idx;
> > +}
> > +
> >  #endif /* _COMMON_INTEL_RX_H_ */
> > --
> > 2.34.1
> >
