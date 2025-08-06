Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13669C87FD3
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 14:46:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D30D74029E;
	Wed,  6 Aug 2025 16:46:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4508340291
 for <dev@dpdk.org>; Wed,  6 Aug 2025 16:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754491566; x=1786027566;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/Jdy1vTaQs/HBtrDtbRDX4+Dc9pVdhlfYImRMYosrR4=;
 b=dYoWN0qTPdhoOV/febpb3DK4s6+pudFv/04jNW3azx5C3lME0Qg8/sXF
 orCQXS+JY5B7PWjIH8eBm1AC27oLA9geX1F+GY/RhzWwIImdAcvsrHodW
 Qsfu2OvhtWTs3CjHtm9p5N8mqGZx4oDNmT8YIK7Ojn2slEI2+OZRRUVFG
 uCfV4krhyZ5JxtrYRovYDCuY2580uLGoFCXyb1Jb4qECI7Az3Ah7T+eRD
 6ZXX06mc1b0OI4i8qLw7uLGqmgviyPYQq+yLOwwCw1rQByadVVUA8s/ck
 pOU8/R/cqB4kiRTpy/T67rxEsQsuLqjO7O5fwpfePyc+C5sPBglUm142Z A==;
X-CSE-ConnectionGUID: WIj/96pgQCyGDn/4E8mGwA==
X-CSE-MsgGUID: iWRkQyF5Sjq2YumFSAvzpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56953793"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="56953793"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 07:46:05 -0700
X-CSE-ConnectionGUID: Jq20gzh1RcyNo41+qaXfnA==
X-CSE-MsgGUID: l6OdwUHvTUGuUiy1MmaGfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="165211608"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 07:46:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 07:46:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 07:46:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 07:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5vYurhnYpQEBWZFslEgdxeE0XX7eDIIE7/415ggsBYPl4DD3tggxekUFuFq9jgIEXQCXLnpWvDybleIu7YsOiIvI2mjJAXLBNHjmZdMNAi3Rvj43R75U6TsxEhwNkxGOjaY6MKRmzG92e523j1wQh6BMCKiTjgoQ0vRbBWdtnuGe2sNWseh61EPNhz/rhgX/v874elwgthqhyu1wbW6syeP5eKUZfGOOkPhzqWeTNjvEuNN3z1qlhF8mEm7HxPE7GdG+wP5BM9AkG0fwx5J324CxpB56EZr90w9CP5CZQVC4lER+v0pRQJZTLLAYvKPxmGLvTwgFnFcC1f1RWaxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cExi5WAL1SFujHVG3+ysJhi5trIZTVbJu3gjyQXp3h0=;
 b=cG7Ck+EvTu+xl+yylaCIKs5coAM8psbXyvCoWpuI6WyxwAwrB7/gvBppVh/+GRw0uYAP1MHlExcG5abY/BmCUYt6Skw+zRDvDtXPJiq2nu7rjSL7J/cFkaV/4lkenckjIAgcWlD/nQfPAotCre+nhkOYFtOTuXd5RgmXeCj/FL9l5g+rBfk3PhLS8emToqM0+OkYQBcZUVmtSBK6NAHzZo+Z4fSTfn5bgA/6r+hUAIIi/5CK4dj5HDVVUs57w/PFNgI3euwFmY81sxgLQ3YpSoNmF4MhBrSGXa0EOJLX6lsgj5BnJk/ksEONKVtI8tNHD/FXzo2wS6Sx/gwWEQeMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by IA3PR11MB9205.namprd11.prod.outlook.com
 (2603:10b6:208:573::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 14:46:01 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac%4]) with mapi id 15.20.8989.020; Wed, 6 Aug 2025
 14:46:01 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC PATCH 06/14] net/ice: use the new common vector capability
 function
Thread-Topic: [RFC PATCH 06/14] net/ice: use the new common vector capability
 function
Thread-Index: AQHb/WKxV42nIm3zW028n7nM+BRAD7RC3TMAgBLoQWA=
Date: Wed, 6 Aug 2025 14:46:01 +0000
Message-ID: <DM3PPF7D18F34A1A2E79F6AE9ED95D1AF1D8E2DA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-7-ciara.loftus@intel.com>
 <aIONKnXhTZ9UK6Cu@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aIONKnXhTZ9UK6Cu@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|IA3PR11MB9205:EE_
x-ms-office365-filtering-correlation-id: 6653f057-e9d5-45d9-5e34-08ddd4f7f681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kU0D69AnQEhE5yOiG2vTtp7oitNULpmV8zfHmsLYCRbsM89c0WLTDT7X+WKx?=
 =?us-ascii?Q?pVhtmHzwP3fg/awsvnnS1hO8ytMwief1uA4XRkfd4dIUlJD6xyZieKDHjV9I?=
 =?us-ascii?Q?bbrsGpdyhnRVuasiklGyufds5ABegtg9i3YDdhNHD+oBUiiVzopxUEMmY3hZ?=
 =?us-ascii?Q?PRDoXJiVnlB3QAf5XxfzOmKpaMUduW/3r1nDklBZIhT6Wquu82TCvggrsue4?=
 =?us-ascii?Q?+tEtW+Frn3Nz6tE7jOoKcagTjTiOgUR/u9w1TDmd/TUpCrJmpc41FtS4gGvp?=
 =?us-ascii?Q?XPzb6OugqajoE8jVlVZF78mhmgiGfp6HvlBJCSbBO4VvKB0MDb3Vv8pA3NMm?=
 =?us-ascii?Q?zX0zq6iw+e4qs5KSvq9v2AwcM3plxSVBqjTKmhI8DEb1znKQNqdhmG3siKTx?=
 =?us-ascii?Q?OhIwa/DoJb53xzygrUS6ub7DP4OKLL46XjSQT8uS9DEOzWRe9xvVED1DmJI1?=
 =?us-ascii?Q?NnLW5Zm+gBsr3Psww3EX9YK5s9mPD4uJdXaw7EeUp4yHCj19XXqhah8c6Xn4?=
 =?us-ascii?Q?EzeEexYpKaQ/u6RLCgFpznBWyWhKqPGwy8db9m4cgV1Xj834Kb4x+UZ8s+7R?=
 =?us-ascii?Q?/JNpxGregblXE0wqSx5sUmVMdAjEjMKbWvaUWYYhKwAN+qLBp7aXoNcHGN5F?=
 =?us-ascii?Q?k47ISCwsK2YVvT5H8sgADdkhqPDIha5cg3qtwwbzQtyxs2eQP5Azrljet8bf?=
 =?us-ascii?Q?OajyewFlywO/wYUW09NrNUkl4Ox4ZPi7vrPkUcjZKZGBtaj2+xKY4kCBkdY9?=
 =?us-ascii?Q?tfFOcij3YjlisBxAbuXCm4L9Ip13tX4gx7tNrjfheLZHYW+jbDALIvdURSjo?=
 =?us-ascii?Q?w9zUaMxx38Ce2Fe8APvsLoqZdLWLvZtRWZ/0vWGJpPyiw/Tz1lyZQ8QDZns9?=
 =?us-ascii?Q?a2RhTr8INZRs4x9NG1PunJTJwVZE2uaKWnpIQkOJ5eYmPkPid0O9TI2Cqs5U?=
 =?us-ascii?Q?BC9JhvSDFslz4/m6oiwOYJXgDKygjEaHnSPCho16R1G/JtMgaoO6hA1YKIYJ?=
 =?us-ascii?Q?R5RVX1mPBIDagOvMmYKsaSi8LlDTDXv8/AqrEnxBzK+eow4CfLm4E3+NzcXa?=
 =?us-ascii?Q?KT9NgAxKwuYKfgGMn76gbaPEiORsQDcjreq1ate2IoheRiinJmGDxQuBEBWd?=
 =?us-ascii?Q?vAd9+cWEhosZsV403nFxD6bSUokzMMHa4D0iID+0P4oy6TtoYG4koqhBmT4W?=
 =?us-ascii?Q?OFV2fXC70XW/mfvOa80XRFRmA6vvxPeAyt0/Tgn4PfLdnq9PAuZ6XE9vk621?=
 =?us-ascii?Q?ctoEYUCnzsOeM3Jj55jIGlrGMK7OCpMZXl5j7nZZYrT0j7ENlsdSOdREvfDU?=
 =?us-ascii?Q?QitxX9BeeHLXY8RFibX9OH39sgRHxp597tCc31xb+u/v7tr3+8R6+FO6U8Yc?=
 =?us-ascii?Q?YMa+Xa/OouwIvo8dy3T6uJWCfw0G04YqXqFqkuRMqoa+rhh6B9n5KYyZ/2Xk?=
 =?us-ascii?Q?bAfmIxNR0DQ9hngK46wE7dHDFy9GOYMpiFho8bwywVQAMf8RhD0KjA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rf1DVLchzTYJvxeWCLLnY7Qr26aElX+cVsH+VcrHdDSabzRo1Z0jOoBhBP04?=
 =?us-ascii?Q?VUqXUGM5B4eW0WQLhK2H2vjcSS/a+jkAVe+DIPk9Ke62/J7hhGxZlzYEM4Fs?=
 =?us-ascii?Q?WljstHLLh1qJP57esSa2/aq8UKOZd1IwPJaMsWsaeMBxMHLzWbnpM212b0LE?=
 =?us-ascii?Q?JkDYJk0pMtuBIu+uQvqGrWnSykU5I8+kuDZMY9MynObwQ+ocyyYOeoQ3Ri2U?=
 =?us-ascii?Q?QYV3r0SX6Q7t3Qay3Ir2D9jAf9kPJkXxsWcgSNwx/TYcNLZ/4aSnXdI0kzOq?=
 =?us-ascii?Q?kP6mazUboWIb9C9USTFlKCBm6HGclIXuiED4EZClHP19bNP26MvxH+C03OAh?=
 =?us-ascii?Q?MU0Fot7JCvpLXpP9nZAEPAsTo0+JvKQ/oetzUAEdQ/yDhuEkPmFdbgSWwgEK?=
 =?us-ascii?Q?i+uO7qpRQtGSLSdLrei3y8fonUS6dK7SAZ6ogmhprKQiWCb3uxRBSLdR/cco?=
 =?us-ascii?Q?e1VouclER74nXIFgLWSEtNmEMAjWR2o819ADCaZFQgZJIcy6Yb8Xh8n0LM+S?=
 =?us-ascii?Q?3ZPBtr3wryZUN4i3U2jefOBMgc/x1+jGNVegCl7ErMLa1gVZvMTSAn4nQWj8?=
 =?us-ascii?Q?rZkZNOkBCd8o2p12QXiLfdEZwxWwT0g68a41ZUzSioYs8Cy+kafD0VMWsFEj?=
 =?us-ascii?Q?yVmeX2uemOg8FykXtjTaipd9HiOe9SUGxhn5Cg3w/w5Ttljgk31WkeglERcr?=
 =?us-ascii?Q?ET2CV/UVbv0cpfiqxYyHmffn/l0mc1awsgjaMPQC2BFo0G4Iy4OauwWr3WyV?=
 =?us-ascii?Q?24EHFx2zYwXtEMLVgxHp274wooTBMpKIHLwrdUBrd/+QCoNFk4X3Iul8YpW+?=
 =?us-ascii?Q?GpqvS2+/fE7icR3rSTnL0/j8NhaZ/LnQgoFBHU6YgcUsCOmBgq6kuyXDehXO?=
 =?us-ascii?Q?JC2s3zzrwryFvHziTU8hMBPX+ZkxXEHN/5nL491Mb/xPM2f5J+tsc1BVevVG?=
 =?us-ascii?Q?QnsA3cg6aZAl8+K0Oh+HnWCBxvEpFRgsTdYLJQ8axb1MQGWgSOWm5++OdsqR?=
 =?us-ascii?Q?KKN6o1UfnhojoC3JkSsjm1u9FcqQni8FnYagaS8nqZRzRK07kfBPhtuoT/u6?=
 =?us-ascii?Q?JVzmrmR46/wI7kUky+u0bwjTkFxCYV5WGh99xlDYAv6PzQ0i/AswVwe1Uiut?=
 =?us-ascii?Q?RVEglYyS7zQpZX/4VBlX87dbTu4PeH9ec6oWUETkHTxKovBpAG0sLdv303sA?=
 =?us-ascii?Q?1rB1WeuiJuYIbGrDUSLO6p+K/v8EUgH6rvUw54BboJDpeiVqlTtkAFoy8wur?=
 =?us-ascii?Q?Nws6L0+PSw6fPbg7euJBWd0I5cFj32B91eh0my9x69bJX1XjRcdP57dohk3r?=
 =?us-ascii?Q?bZ4WILKUOvfw4W05ZLsZokIVJHj/dpvLut8vwbf12Uy6PaQjnszAch1OC7J9?=
 =?us-ascii?Q?N1NW/uxeaU7nvoGZDsU4sV7rjBYZiyGzyFHGbzbOf8XRtPsq78ZzHDVPmKwd?=
 =?us-ascii?Q?g/r/IeozDwMvOO635y1sPeqkeQbKkcs/nWiwetp3gE9LRhIPKZfnZ1lKN4i4?=
 =?us-ascii?Q?i3Pkt3QSXN21DaJHcTCk6Ux9TtiB+SgxrJqG9bbsBJOKmwaqa/fdqAVIoc7V?=
 =?us-ascii?Q?VHTDRCvV6ghLNqnEtnCp3vTLPmmVI5hLxe6l8EIB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6653f057-e9d5-45d9-5e34-08ddd4f7f681
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 14:46:01.3657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8SjdUgJGcHgSFfgjLn6nhxP1OfvpjJvU/l5mYPpqh7WreGdX1PrYyjvHGjG3xxtOUK1zUdUCZtG0mJabWJPlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9205
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
> On Fri, Jul 25, 2025 at 12:49:11PM +0000, Ciara Loftus wrote:
> > Use the new function for determining the maximum simd bitwidth in
> > the ice driver.
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
>=20
> Few comments inline below.
> > ---
> >  drivers/net/intel/ice/ice_ethdev.h       |  5 +--
> >  drivers/net/intel/ice/ice_rxtx.c         | 52 ++++++------------------
> >  drivers/net/intel/ice/ice_rxtx.h         |  1 +
> >  drivers/net/intel/ice/ice_rxtx_vec_sse.c |  6 +++
> >  4 files changed, 21 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/net/intel/ice/ice_ethdev.h
> b/drivers/net/intel/ice/ice_ethdev.h
> > index 5fda814f06..992fcc9175 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.h
> > +++ b/drivers/net/intel/ice/ice_ethdev.h
> > @@ -11,6 +11,7 @@
> >
> >  #include <ethdev_driver.h>
> >  #include <rte_tm_driver.h>
> > +#include <rte_vect.h>
> >
> >  #include "base/ice_common.h"
> >  #include "base/ice_adminq_cmd.h"
> > @@ -674,9 +675,7 @@ struct ice_adapter {
> >  	/* Set bit if the engine is disabled */
> >  	unsigned long disabled_engine_mask;
> >  	struct ice_parser *psr;
> > -	/* used only on X86, zero on other Archs */
> > -	bool tx_use_avx2;
> > -	bool tx_use_avx512;
> > +	enum rte_vect_max_simd tx_simd_width;
> >  	bool rx_vec_offload_support;
> >  };
> >
> > diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/i=
ce_rxtx.c
> > index 85832d95a3..79217249b9 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.c
> > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > @@ -3703,7 +3703,7 @@ ice_set_rx_function(struct rte_eth_dev *dev)
> >  	struct ci_rx_queue *rxq;
> >  	int i;
> >  	int rx_check_ret =3D -1;
> > -	bool rx_use_avx512 =3D false, rx_use_avx2 =3D false;
> > +	enum rte_vect_max_simd rx_simd_width =3D
> RTE_VECT_SIMD_DISABLED;
> >
> >  	rx_check_ret =3D ice_rx_vec_dev_check(dev);
> >  	if (ad->ptp_ena)
> > @@ -3720,35 +3720,22 @@ ice_set_rx_function(struct rte_eth_dev *dev)
> >  				break;
> >  			}
> >  		}
> > +		rx_simd_width =3D ice_get_max_simd_bitwidth();
> >
>=20
> Since this whole block is in #ifdef X86_64, do we need a generic ice
> function here? Is it worth just just calling the x86 function directly?

We'd then need to include the rx_vec_x86.h file in the common rxtx.c code w=
hich I think is probably not desired.
We could move the function to rx.h but then that file would have some arch =
specific stuff which again is probably not ideal either.

>=20
> > -		if (rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_512 &&
> > -
> 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) =3D=3D 1 &&
> > -
> 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) =3D=3D 1)
> > -#ifdef CC_AVX512_SUPPORT
> > -			rx_use_avx512 =3D true;
> > -#else
> > -		PMD_DRV_LOG(NOTICE,
> > -			"AVX512 is not supported in build env");
> > -#endif
> > -		if (!rx_use_avx512 &&
> > -
> 	(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) =3D=3D 1 ||
> > -
> 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) =3D=3D 1) &&
> > -				rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_256)
> > -			rx_use_avx2 =3D true;
> >  	} else {
> >  		ad->rx_vec_allowed =3D false;
> >  	}
> >
> >  	if (ad->rx_vec_allowed) {
> >  		if (dev->data->scattered_rx) {
> > -			if (rx_use_avx512) {
> > +			if (rx_simd_width =3D=3D RTE_VECT_SIMD_512) {
> >  #ifdef CC_AVX512_SUPPORT
> >  				if (ad->rx_vec_offload_support)
> >  					ad->rx_func_type =3D
> ICE_RX_AVX512_SCATTERED_OFFLOAD;
> >  				else
> >  					ad->rx_func_type =3D
> ICE_RX_AVX512_SCATTERED;
> >  #endif
> > -			} else if (rx_use_avx2) {
> > +			} else if (rx_simd_width =3D=3D RTE_VECT_SIMD_256) {
> >  				if (ad->rx_vec_offload_support)
> >  					ad->rx_func_type =3D
> ICE_RX_AVX2_SCATTERED_OFFLOAD;
> >  				else
> > @@ -3757,14 +3744,14 @@ ice_set_rx_function(struct rte_eth_dev *dev)
> >  				ad->rx_func_type =3D ICE_RX_SSE_SCATTERED;
> >  			}
> >  		} else {
> > -			if (rx_use_avx512) {
> > +			if (rx_simd_width =3D=3D RTE_VECT_SIMD_512) {
> >  #ifdef CC_AVX512_SUPPORT
> >  				if (ad->rx_vec_offload_support)
> >  					ad->rx_func_type =3D
> ICE_RX_AVX512_OFFLOAD;
> >  				else
> >  					ad->rx_func_type =3D ICE_RX_AVX512;
> >  #endif
> > -			} else if (rx_use_avx2) {
> > +			} else if (rx_simd_width =3D=3D RTE_VECT_SIMD_256) {
> >  				if (ad->rx_vec_offload_support)
> >  					ad->rx_func_type =3D
> ICE_RX_AVX2_OFFLOAD;
> >  				else
> > @@ -4032,29 +4019,14 @@ ice_set_tx_function(struct rte_eth_dev *dev)
> >  	int tx_check_ret =3D -1;
> >
> >  	if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> > -		ad->tx_use_avx2 =3D false;
> > -		ad->tx_use_avx512 =3D false;
> > +		ad->tx_simd_width =3D RTE_VECT_SIMD_DISABLED;
> >  		tx_check_ret =3D ice_tx_vec_dev_check(dev);
> > +		ad->tx_simd_width =3D ice_get_max_simd_bitwidth();
> >  		if (tx_check_ret >=3D 0 &&
> >  		    rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_128) {
> >  			ad->tx_vec_allowed =3D true;
> >
> > -			if (rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_512 &&
> > -			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F)
> =3D=3D 1 &&
> > -
> 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) =3D=3D 1)
> > -#ifdef CC_AVX512_SUPPORT
> > -				ad->tx_use_avx512 =3D true;
> > -#else
> > -			PMD_DRV_LOG(NOTICE,
> > -				"AVX512 is not supported in build env");
> > -#endif
> > -			if (!ad->tx_use_avx512 &&
> > -
> 	(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) =3D=3D 1 ||
> > -
> 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) =3D=3D 1) &&
> > -				rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_256)
> > -				ad->tx_use_avx2 =3D true;
> > -
> > -			if (!ad->tx_use_avx2 && !ad->tx_use_avx512 &&
> > +			if (ad->tx_simd_width < RTE_VECT_SIMD_256 &&
> >  				tx_check_ret =3D=3D
> ICE_VECTOR_OFFLOAD_PATH)
> >  				ad->tx_vec_allowed =3D false;
> >
> > @@ -4074,7 +4046,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
> >
> >  	if (ad->tx_vec_allowed) {
> >  		dev->tx_pkt_prepare =3D NULL;
> > -		if (ad->tx_use_avx512) {
> > +		if (ad->tx_simd_width =3D=3D RTE_VECT_SIMD_512) {
> >  #ifdef CC_AVX512_SUPPORT
> >  			if (tx_check_ret =3D=3D ICE_VECTOR_OFFLOAD_PATH) {
> >  				PMD_DRV_LOG(NOTICE,
> > @@ -4100,9 +4072,9 @@ ice_set_tx_function(struct rte_eth_dev *dev)
> >  				dev->tx_pkt_prepare =3D ice_prep_pkts;
> >  			} else {
> >  				PMD_DRV_LOG(DEBUG, "Using %sVector Tx
> (port %d).",
> > -					    ad->tx_use_avx2 ? "avx2 " : "",
> > +					    ad->tx_simd_width =3D=3D
> RTE_VECT_SIMD_256 ? "avx2 " : "",
> >  					    dev->data->port_id);
> > -				dev->tx_pkt_burst =3D ad->tx_use_avx2 ?
> > +				dev->tx_pkt_burst =3D ad->tx_simd_width =3D=3D
> RTE_VECT_SIMD_256 ?
> >  						    ice_xmit_pkts_vec_avx2 :
> >  						    ice_xmit_pkts_vec;
> >  			}
> > diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/i=
ce_rxtx.h
> > index 0301d05888..8c3d6c413a 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.h
> > +++ b/drivers/net/intel/ice/ice_rxtx.h
> > @@ -261,6 +261,7 @@ uint16_t ice_xmit_pkts_vec_avx512_offload(void
> *tx_queue,
> >  int ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir=
_desc);
> >  int ice_tx_done_cleanup(void *txq, uint32_t free_cnt);
> >  int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond
> *pmc);
> > +enum rte_vect_max_simd ice_get_max_simd_bitwidth(void);
> >
> >  #define FDIR_PARSING_ENABLE_PER_QUEUE(ad, on) do { \
> >  	int i; \
> > diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> > index d818b3b728..1545bc3b6e 100644
> > --- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> > +++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> > @@ -735,3 +735,9 @@ ice_tx_vec_dev_check(struct rte_eth_dev *dev)
> >  {
> >  	return ice_tx_vec_dev_check_default(dev);
> >  }
> > +
> > +enum rte_vect_max_simd
> > +ice_get_max_simd_bitwidth(void)
> > +{
> > +	return ci_get_x86_max_simd_bitwidth();
> > +}
>=20
> If we do wrap the x86 bitwidth function in an ice-specific one, we probab=
ly
> need to provide one for other architectures. However, as I comment above,=
 I
> don't think we need to wrap this - though perhaps I'm missing something o=
r
> its needed in later patches...
>=20
> > --
> > 2.34.1
> >
