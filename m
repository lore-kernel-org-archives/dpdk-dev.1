Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F26CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 13:35:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D8DA410E4;
	Thu, 14 Aug 2025 15:35:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id E86FF402CA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 15:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755178538; x=1786714538;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x0Dw8ysOVOpw7yC1fvKfPszRC42HpS8WJX3OtwdU4QY=;
 b=lvZh8zIC4jMOIAbjW3deIyOJTeyRkxUATvQ89Z8X1dGdzEZ6xF/hOWvg
 03GNtPaHnDtA/79TRBSxxh4tfe5OHM2/BWGEQWkTgi+fqirrx+pjQTMXq
 lnvLJ/Vetoq2sr0JkZIS8hKyCvSjDlX8TmC/wcJEOonWbIBDtpR7gSD60
 uHaqI0B4GWGW2ybWlHl4Sge7xSpbRLhhcpokUkFJHMSqz5G/jAB7k4VNP
 S41Ol96mmD1uxcKG5QB02sMkcmXLcRPzwb91FP/YwAueAyvKq5LdLo02B
 XXKeyy6+7V7F13ongFif+iI6gjn1afF30Ae671UiMmMbW4S2pQ0J4XZXf Q==;
X-CSE-ConnectionGUID: +4bmOxFBRdy84QeOaLvkxQ==
X-CSE-MsgGUID: 2x+bbfSsTMi9mdFmUz8Nog==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68948132"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="68948132"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 06:35:37 -0700
X-CSE-ConnectionGUID: 30vWyQ5mQ0iOAZg1HC2X3w==
X-CSE-MsgGUID: LpkUBlRsSmifB2zTNshYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="166254224"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 06:35:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 06:35:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 06:35:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.81)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 06:35:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfsexlufsELbVIvVzHEra3v0Lf75slegPgAxrQbyeV2iZQlSqa3EFQrZeG9z3/4jkmjjBKnGHlOuno7b3G8jFUiTKqfMCi/zZasNjHMRG0xSySSrYvH6REwg5VnsJlQMDnhF1Ak62rxgPR7skzXaHjkqPXtajDbxTHwK0C7TusiDGdChW6K2HDP5tlL2BSZhJRS62yjvZjwfiloWuOrjpQNstFISw8FCdhpo1dq9cZBZdDArkz9mWm2SeaEWZlHuPafD/fYt9NxrJg4ndM9TfPiFZZ0hrlN7uYpo18dbsfZpXW0fE1tJD4rEpr0AKH4bzaDkL9FTeCzKgezrqyC1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA5EUFodyWhXXi7ydmbUILB2Sct6unI3P5VCmK+K3g0=;
 b=Qw/mVdlaBJFsd4CjzqLhO7NaEw9ucHIdnPH7tqhIQwJojmSlNPq6wZa9JCmBoBUDlDaw0oUJ4t+1gEEOOP5e7G8EDJaQ3GeBapYFRs3yxHd/auh98Ku9cgpLEd//jqbZGPrUOzVHKlKEryLJzZdnTD/yp1RvFlHx2Wqy/J/xXDMJ6ui1/8k3clsKKDgu1FNbE0li+/BbP325YfXbcg5b+FESWjxbukTqfK8618SPhx1vs/oKrZNVOBjvSAY3rM4D+2/ZE57hSUvBrz4k8NWPBcgdbRg6QEcoPWqNIeTLVEerFQzutzFa8ACoyq76Q8AP/mvvjX/qG9nOuKTEgVhhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DS0PR11MB7903.namprd11.prod.outlook.com
 (2603:10b6:8:f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 13:35:34 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c%7]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 13:35:34 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 12/15] net/intel: introduce infrastructure for Rx path
 selection
Thread-Topic: [PATCH v2 12/15] net/intel: introduce infrastructure for Rx path
 selection
Thread-Index: AQHcB5hvPBoHzzwUFk6K0Ht+0EJHb7RdWSsAgATTAIA=
Date: Thu, 14 Aug 2025 13:35:34 +0000
Message-ID: <DM3PPF7D18F34A14E9758E3D0F2CCE373428E35A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-13-ciara.loftus@intel.com>
 <aJnVvjcg_nhgnesS@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aJnVvjcg_nhgnesS@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DS0PR11MB7903:EE_
x-ms-office365-filtering-correlation-id: 0437a1e4-9d1d-4c8e-6eff-08dddb377262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QodzegrQeU7ndQa79v6C8JQlDiOukLzFyQjtPP7cRq2q3R8a6BV3MCX2AGH6?=
 =?us-ascii?Q?qSrffObJQZJZ2vwgD8NxdMkj/eNaZlZ7g6DU19X3ApAZeHrN7GsCGefXMP3i?=
 =?us-ascii?Q?zDLB40QCChxcZJ2wfrzOZmX8ofDegFkxg5g/s0IJk1LVVxtbo5Y8TdJflkM7?=
 =?us-ascii?Q?bJ9gjLX+GudFn+ZxEQKu5GPkvHdZvlOvUWwa86V0bJXlai5ukYKpU3cwibsp?=
 =?us-ascii?Q?/0L0+TCcH0kcBFAgj70Kq3jLlppQP3l4XbvDZPUY/SS472cztVqj7guNdQnF?=
 =?us-ascii?Q?bIbE17thTD0+f+2234YvmwxS3lyg/V2xBONeYCdFMDGNbzOGqRsqNx+1HkYP?=
 =?us-ascii?Q?HI984ULenssXKxAZFWGTX1yVgXJlILjOdUNFB1/wmuptWkVUXAQmg0P38FWu?=
 =?us-ascii?Q?tCuko1UWBO9nrDg/XiokddkPRoEAScAMIi2b3aY7QO120b5juXYV3ivo23UN?=
 =?us-ascii?Q?mcdjXCSI2nA3ok7nT97C6Y6B5VXvlN/NcHAAHv7vF8+y3ywzWyqAPelBb9bc?=
 =?us-ascii?Q?eqXwD0wsLUOSOkI+nH3y+RznT2v8wVH/3V4drLp83RhffLv16tnHCa8U31Gw?=
 =?us-ascii?Q?AvUukpfgkaCy7SlxMzRtYvyJA/mkk91BqS3EtnQRM2TYrLq+Ak6wyfgennDL?=
 =?us-ascii?Q?BOTWwqw56BHi2UcrmrbNSlke8Yes27igy0EraRskAe0bT+3Ya+QJIP1wIeAE?=
 =?us-ascii?Q?G06wE48sChCMoMyHIHaIWXnxf7U3HQZ+S4uIFaslSGGUj8WPrrbDsze1wmfj?=
 =?us-ascii?Q?QAlX0suVnLp91Yvk7uG9mjt5PAZL5G8deyU4HSwmIdkrlQVKOLuzbSpOuat2?=
 =?us-ascii?Q?bC5V/uHuMG+AN2F8F32Toemae/gzXQXFJHu6Yha+BNCJ1bLJOpxZLRgcXp22?=
 =?us-ascii?Q?ojbdq8YGGJADJ9EBh9w+oYVynFOl9POV3CpJ9HXWPpkjrg10sd+mtsUHZmaI?=
 =?us-ascii?Q?JNDflGgEvnjRn8pGMTfGdDJE3naLnmLSjxDietaVwPoMoTTnjM5uvT2hqBBT?=
 =?us-ascii?Q?VqI1lK/FGhGO+qBS7/aY6Y49SOahdBp7XZt5wFDAC2GH/C023Fe1Ra41caYQ?=
 =?us-ascii?Q?extw+EfvWOnRV3BaFem2O02aP9WJtzIIo0+M5vkWQigDgWaoikZr/QxAp+Ii?=
 =?us-ascii?Q?XIhruZvgqDhVjRlUwmdVOT1BEu4kZOW2NgtdNFdD1uHPv8KczJ6l0l3OhtyU?=
 =?us-ascii?Q?ZArhn5PgfTjkeObPvpMw3gQosdzoCDkVlFc2QNGRiVe9FfViDH+CeQEnCnNk?=
 =?us-ascii?Q?+JVo89jFlzJjHHxxA06Ji1iafxLKdgqLH/MZAcSZ5jlma95YQtCRSX2PPa5i?=
 =?us-ascii?Q?TbRkffcK7uaYqHbOaHep6zZrbfmGOBO4W04b0ResQfjGCExJGC0+PFlUm1/b?=
 =?us-ascii?Q?W4DHkG8n4WH0di5vGI6vug8fNoYP4DO2bt/Y36A0muLUTT6HkDjKcOFA/2a3?=
 =?us-ascii?Q?h21XbTXHCTt+8WJRe2UB1FP6ZCL/H2e4v2pNrg26vj+yxbRDWjqwT+MCytTH?=
 =?us-ascii?Q?Bjyh2QjKY43dG/8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FYnZRDQNWHHjqTVoC3OimlxTjt+cYmMHI0ie/J7uwZcbR9dMXaJCjfrR45Y8?=
 =?us-ascii?Q?NIpV+f0JMX9thtGHmJfCoKaYOcmA5mV6HM3ynzLAf9kSUJxqardsEsCauCMN?=
 =?us-ascii?Q?RGOkHqmDZm+rN9e2Nh6FwOG4+sygUTkZ1iPXrB3B0ASyY4avEZIkvqVzBV7d?=
 =?us-ascii?Q?ZHgdejOcPErHa37MXPc9MSn6N33tX49KNWrUnepieLKpLiY+L65SravO2lZw?=
 =?us-ascii?Q?MqzTC2OTAZcDicMDl1UybDg26SFWQsRPz9waCBUAYDGCjY3y7UtmshUHtyaq?=
 =?us-ascii?Q?Cjmwqot/GF8v56CnGYGB7iFtFyzfnteCIBf6WQtHU5Wt1PRb1zJ4cDiGgM2I?=
 =?us-ascii?Q?MR+8QDMbFARTimkOnpiTAKfctkP6X+VDUnfCrgzqHXhd+UU+0aa29JzGfZ/U?=
 =?us-ascii?Q?0Tc1qzXmK6WIaMKGrgXmpOLxyNtH8Y0qPqAvZh/GcP5egM5XV/PdIzYd6qA9?=
 =?us-ascii?Q?K5HUeNEl2IUV9teCrfPQ20PMXcpR1G9EmlCq8DT+BeMQL8ypDs4FTAaeAB+r?=
 =?us-ascii?Q?s9RJhXSEDmXGNPUTPC66AJhVfaPyinhlTi9J+lfTmsj42tCpVaNgYhb2W5zz?=
 =?us-ascii?Q?lgJWH+S7WgTfovBByywSOq3FrA2g7hkN1icEttJioNI/IK2YbHkWvSt5a7bc?=
 =?us-ascii?Q?LXuJD9bAWeC2YLWkw3uMgXxgqtzpUgxxbcqgDBDpnIaZjohGASkTGWPltKm9?=
 =?us-ascii?Q?bSb36U/D/41S06J3DXqen2Z2xh0hnIcETJByCOeYjqwzXCLj4LLRTdGNtdkQ?=
 =?us-ascii?Q?IhrqH6+88IAT1Z0KaB2ufa9hbR3zxmkip1G5I+jHvMKpStOwdZdTgcBiUXwD?=
 =?us-ascii?Q?itN1qwgV0fVJ9ybARKr+JpmIrELkv7M2y5VXU4IYCvICJxSj2b1lQ0zraqli?=
 =?us-ascii?Q?BzDyIvfMC6XxAJ/MB8uqaiJEiDnZs/XH8rzDrXaQjH9Xt7ZlWckuak0AcsfD?=
 =?us-ascii?Q?uToDX8OxIb0J8qY67KM5UGW7eIXbYLhhuxVkOi6oHKRpIZ7stbBjoJLYjVuX?=
 =?us-ascii?Q?Cbx1Y1wZP7YbT8YY4Tc419r7fRTUmcZrFqtUPmT+46CnuVBJzfpOc6nVvQh5?=
 =?us-ascii?Q?BrXxKWUqUAF5IPiKPN48coZiLqVco2y3J4w4VKTPWtfCVQMkHsioO4rMHDJz?=
 =?us-ascii?Q?ZX4Ts2Q2wgLXCmYe82IkEi5IgMq1Q4LfPkncsoREBG8rGtDWbXz3LTDdJd73?=
 =?us-ascii?Q?t63TGybZUTguU4yzwZbAN5kCY1CTeFKys755VNe6BeeRbinA/ZRIV8cxGWEE?=
 =?us-ascii?Q?HnKH9JzvAipG4o0040jB1EMCoevDV38WEaftPeH9VEwCl26ObCUEdTuS5jn7?=
 =?us-ascii?Q?+qmrMOqzn8xLxbwfFCcPJAxTPGAItlT6Jw8WhUHqfYrhYDpg5r75ENpYbG+B?=
 =?us-ascii?Q?OqQbBLD9IELWJjhpDGxnhHAB4OVTyH7wPUA2X7ficX8GLUv34OfrHuzy7zA8?=
 =?us-ascii?Q?gCXP+10wALQTmm5yMaiGmN1R8LR101k0tHUUXuuYzdxlzfFe6glCHDxE29+V?=
 =?us-ascii?Q?fragZhJqwkmU2BWnU6bcORBxO0F3H3IT0lGcBFm7DKIoqi5Ov++yihdqq4Hd?=
 =?us-ascii?Q?WZrpHM/enX4X25RYQeegEtirv2Ssm7VXnYRAA8CU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0437a1e4-9d1d-4c8e-6eff-08dddb377262
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 13:35:34.5128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sonZPTmEuDQUz7FxLvObjCoyt/ibvQE4S1OWpHrr3ubWnuEvWfXfeMlU6/x5BzBjid7i33Zjrj4kyyVcSol5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
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
> On Thu, Aug 07, 2025 at 12:39:46PM +0000, Ciara Loftus wrote:
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
> > ---
> > v2:
> > * renamed various items from "burst" to "path"
> > * added missing doxygen comments
> > * attempted to improve the logic in the select function around the bulk
> >  alloc feature
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
>=20
> Two comments inline below.
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
>=20
> > ---
> >  drivers/net/intel/common/rx.h | 103
> ++++++++++++++++++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >
> > diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/r=
x.h
> > index 70b597e8dc..6d134622e6 100644
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
> > @@ -125,6 +126,26 @@ struct ci_rx_queue {
> >  	};
> >  };
> >
> > +#define CI_RX_PATH_SCATTERED 1
> > +#define CI_RX_PATH_FLEX_DESC 1
> > +#define CI_RX_PATH_BULK_ALLOC 1
> > +#define CI_RX_PATH_DISABLED 1
> > +
>=20
> Do we need these defines? They are not used in this patch anyway. With th=
e
> values converted to "bool", using true/false should be fine I think.

They're not necessarily needed but I think they improve the readability whe=
n they are used in the next three patches when defining the features of eac=
h Rx burst function. If you don't agree I can remove them.

>=20
> > +struct ci_rx_path_features {
> > +	uint32_t rx_offloads;
> > +	enum rte_vect_max_simd simd_width;
> > +	bool scattered;
> > +	bool flex_desc;
> > +	bool bulk_alloc;
> > +	bool disabled;
> > +};
> > +
> > +struct ci_rx_path_info {
> > +	eth_rx_burst_t pkt_burst;
> > +	const char *info;
> > +	struct ci_rx_path_features features;
> > +};
> > +
> >  static inline uint16_t
> >  ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs,
> uint8_t *split_flags,
> >  		struct rte_mbuf **pkt_first_seg, struct rte_mbuf
> **pkt_last_seg,
> > @@ -222,4 +243,86 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t
> rx_free_thresh, uint64_t offloads)
> >  	return true;
> >  }
> >
> > +/**
> > + * Select the best matching Rx path based on features
> > + *
> > + * @param req_features
> > + *   The requested features for the Rx path
> > + * @param infos
> > + *   Array of information about the available Rx paths
> > + * @param num_paths
> > + *   Number of available paths in the infos array
> > + * @param default_path
> > + *   Index of the default path to use if no suitable path is found
> > + *
> > + * @return
> > + *   The packet burst function index that best matches the requested
> features,
> > + *   or default_path if no suitable path is found
> > + */
> > +static inline int
> > +ci_rx_path_select(struct ci_rx_path_features req_features,
> > +			const struct ci_rx_path_info *infos,
> > +			int num_paths,
> > +			int default_path)
> > +{
> > +	int i, idx =3D -1;
> > +	const struct ci_rx_path_features *current_features =3D NULL;
> > +
> > +	for (i =3D 0; i < num_paths; i++) {
> > +		const struct ci_rx_path_features *path_features =3D
> &infos[i].features;
> > +
> > +		/* Do not select a disabled rx path. */
> > +		if (path_features->disabled)
> > +			continue;
> > +
> > +		/* If requested, ensure the path uses the flexible descriptor. */
> > +		if (path_features->flex_desc !=3D req_features.flex_desc)
> > +			continue;
> > +
> > +		/* If requested, ensure the path supports scattered RX. */
> > +		if (path_features->scattered !=3D req_features.scattered)
> > +			continue;
> > +
>=20
> I think this test should be in a similar format for the next bulk-alloc
> one. After all, if scattered Rx is requested, we must provide a scattered
> path. However, if scattered is not requested, a scattered Rx path should
> still work fine. So:
>=20
> 	if (req_features.scattered && !path_features.scattered)
> 		continue;

This would be a diversion from existing behaviour. Currently we never selec=
t a scattered function when it is not requested.
Like you said it would still work, but the path selected may not be what us=
ers have come to expect.

>=20
> > +		/* Do not use a bulk alloc path if not requested. */
> > +		if (path_features->bulk_alloc && !req_features.bulk_alloc)
> > +			continue;
> > +
> > +		/* Ensure the path supports the requested RX offloads. */
> > +		if ((path_features->rx_offloads & req_features.rx_offloads) !=3D
> > +				req_features.rx_offloads)
> > +			continue;
> > +
> > +		/* Ensure the path's SIMD width is compatible with the
> requested width. */
> > +		if (path_features->simd_width > req_features.simd_width)
> > +			continue;
> > +
> > +		/* Do not select the path if it is less suitable than the current
> path. */
> > +		if (current_features !=3D NULL) {
> > +			/* Do not select paths with lower SIMD width than the
> current path. */
> > +			if (path_features->simd_width < current_features-
> >simd_width)
> > +				continue;
> > +			/* Do not select paths with more offloads enabled
> than the current path. */
> > +			if (rte_popcount32(path_features->rx_offloads) >
> > +					rte_popcount32(current_features-
> >rx_offloads))
> > +				continue;
> > +			/* Do not select paths without bulk alloc support if
> requested and the
> > +			 * current path already meets this requirement.
> > +			 */
> > +			if (!path_features->bulk_alloc &&
> req_features.bulk_alloc &&
> > +					current_features->bulk_alloc)
> > +				continue;
> > +		}
> > +
> > +		/* Finally, select the path since it has met all the requirements.
> */
> > +		idx =3D i;
> > +		current_features =3D &infos[idx].features;
> > +	}
> > +
> > +	/* No path was found so use the default. */
> > +	if (idx =3D=3D -1)
> > +		return default_path;
> > +
>=20
> Very minor nit - I think you don't need "-1" as a sentinal value. Just
> initialize "idx =3D default_path" and drop this block. From what I see yo=
u
> never make comparisons based on idx, you use current_features for that.

+1 I think this was a left over from some logic I removed in v1/v2.

>=20
> > +	return idx;
> > +}
> > +
> >  #endif /* _COMMON_INTEL_RX_H_ */
> > --
> > 2.34.1
> >
