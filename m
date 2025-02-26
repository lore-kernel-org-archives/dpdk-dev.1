Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F00C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 11:57:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25A744042F;
	Wed, 26 Feb 2025 12:57:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 60C894026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 12:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740571036; x=1772107036;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BaIIXjiL+8XKug9VjhPCcSrJMMdssYCcNkFwdiUFiYY=;
 b=QNcElyulGzqFQ+XMmuH7TTDuevgH1l6KY8Se/h8GeUNtB2HVl94drXFw
 uwOl5HkrV8SGpyclVbDc6zcvh2DU0IJLL+Y0hd+ZNTdxj8ZX7yOyO/fzA
 vJd+3LQ1eZ8idDupW1shcKReuD43qVhk6SVSaj2biAAFHiz4KXAtiaVCZ
 4vNdEPPyv6uMO8zaFTIbBJlfBMdDtOZr1/FwnBy7yHYHVSR6HTXJo2Qnl
 gEw80supaHPdUldb97t010PVP82DJaSjngne1bFTGXiyRkyivixITBnCm
 ogsMaO6fQRovge8zFdW7bqvnsijL6UsmyAltntXNuyjqU8OOzLbZkIKZP g==;
X-CSE-ConnectionGUID: P0iroQAOQom44knq9XE7RQ==
X-CSE-MsgGUID: zRqnjaNeReyyFGuyqVSjJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="58947110"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="58947110"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 03:57:14 -0800
X-CSE-ConnectionGUID: nQWFiECORrW/+dJ1IqAy6g==
X-CSE-MsgGUID: DDMqXjczSJ63vRLYzCE05Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="116493370"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 03:57:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 03:57:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 03:57:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 03:57:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqVVvHs1UiouK+eyKN25DHRt8zRsM8w+eA3YmPs07uE40AoIyW40c1TnTGPDZsR2AUr1WySul1IHeQ8aA8reFTXBBcG0N74wOCy0uXMWOu/gCnZfNwZEFOK7FT9sC3Pn8NTV9OU78HMayzmJsRSMaeeg4EpLBm1JuLVDEhQvblQRhqS/+jqQaCK1I9fh/cmgipsLkiFk1o8IeutrYMTUBo2L7maqG6gpXfRu9ruZ1IQWz7zRrqSL4bhbAZ+g8xyePhv42/eDW2a4lxERsP5omMQeAmjr8yK5XPzZ0SE4lC3B5+qgzPIcpJIdi+X+QlF+IxFnqKpfudVEtW1C4Qz0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaIIXjiL+8XKug9VjhPCcSrJMMdssYCcNkFwdiUFiYY=;
 b=t61S+aqChCGpYZoEluH2Qr2LrI+t0qUQD2Zf+s9Jl1XLDwkkV4HtYKa2gJMQIJqOFXhX70nzkqWBLQ5KOl+utBJrsurC0MemRaITB4cGptyD1DeeMIbhFwPx7hhahdcTqifgEvuPLtElycs+f+N3WMKiuBShnC6djbgLkNgZR4CO228y1J6YPTCVEsoQeDyRuBiREOwK1jUiCMg7+qlXXU/n+paAAOlldiD6CtxxuuC4cL/BNCTlq+B9RBVCYb6maqhnvHCG49qncxbYKM+bQH6KZVebvpW1Yoso7ERgqeX6gBCcKGtiml/XMUkaE6pjda2+gufSFcNwOsHX0Pt0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 11:57:08 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d18:36da:367b:5e82]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d18:36da:367b:5e82%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 11:57:08 +0000
From: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
To: "Dooley, Brian" <brian.dooley@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [PATCH v5 3/3] app/test: add SM4 GCM tests
Thread-Topic: [PATCH v5 3/3] app/test: add SM4 GCM tests
Thread-Index: AQHbht2K9dDsuZpoSkyd6zTLEKF0IbNZfU1Q
Date: Wed, 26 Feb 2025 11:57:08 +0000
Message-ID: <DM8PR11MB55918BB0C132570DFC9AA19E84C22@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
 <20250224165939.717714-1-brian.dooley@intel.com>
 <20250224165939.717714-3-brian.dooley@intel.com>
In-Reply-To: <20250224165939.717714-3-brian.dooley@intel.com>
Accept-Language: en-US, en-IE, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5591:EE_|SJ1PR11MB6083:EE_
x-ms-office365-filtering-correlation-id: c3abdfec-cef7-451d-3316-08dd565cb27a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jdpmYRQxbnELuU/PimMJynZ8FSa9l+THn3aqgwqKsMvqvpkg82eL2yloYjZ2?=
 =?us-ascii?Q?KuIxI7iq4ZjKsviUJYiZFy0tzj3q31VqCeMJQFjyeUG1yfrkWa3SVyJ5pv2C?=
 =?us-ascii?Q?LGUcc0WaLW9Kwo1GVlOsrmOTk4mIk9PlpeQMbk2IczCzrTlcSZ8vCAotelkU?=
 =?us-ascii?Q?7OJdA+CY/ueQAZtd/dhpH6GMfmhOEeFfEaoDvEzSNCo+Ytg6Tagf3S6xNhIa?=
 =?us-ascii?Q?aRrN28/vYcgZh7Hc4owC595zJHAGtwaJQdwIjmJNVR3/L7Od1+94jijnWIKE?=
 =?us-ascii?Q?zAUOwW2uKWOlOxfi7ylBZuupFggN4jD6EcmLH7BF4W71VncZVSu+KMQjllv+?=
 =?us-ascii?Q?9/gPa8MsYQ/ZSJk+0KycbI8W41EvUy/xsLrKI7IDaEDR/9m0r4rAq0TC9hXv?=
 =?us-ascii?Q?MXEQgSBurpO7KoXKsSUUwT+hQSrFLzwBs8Hqvhcz/B2DO3Agwf0U48qrQBE4?=
 =?us-ascii?Q?j3S1JvMULS1/Wuh6Vg93NbT7JhNZFyGyWLjF99xlhQvtoShvEyW9V4fO6vS1?=
 =?us-ascii?Q?MWSrLmbjfNB5JYXG0+tXpgOvaOJPezGbVyK3DSbXq9QrApkKJf3iqD/Ng7lc?=
 =?us-ascii?Q?NGW+haV+/xKeNsO+ugi9zvb2jV45KOdGXdjonlc5n8MdcINpid4pCzCh1scN?=
 =?us-ascii?Q?6iLif9wxkikzLk162OrBEpKQAOzDZurfWdaAPKlyVgYbVw1RMRuFr822g2V8?=
 =?us-ascii?Q?x4wtmWaEDZUC3SaIRaqbY5oWYI4+h6LhlA0Lk4xsiRQuQjSlssf+Y2ef+jU6?=
 =?us-ascii?Q?JTc1vMdi8ftNNAVuNEjTiYDZqGIqxveCt4/MSInIWB0HoO+jG4bN2Q+L5Tzs?=
 =?us-ascii?Q?a19RgdwoaVbw94bD0sAYmO7MkIqDz72N9SnCpW2NsXtzTBZy4O/Zi7WvYHbf?=
 =?us-ascii?Q?OkWoU3UTJAt3nI4DFzS1wGlLuGeQWat/0AsSEv3uNV7UZLu9iXvtzNvVGwpw?=
 =?us-ascii?Q?0yBPCTWc+1RZAKlZGoEpF9MW+tvMn748dO1gyp+WwC5xwhyodEfzuH3mFb2c?=
 =?us-ascii?Q?B2xx2AtFGXPq6Kcgc4alMC3sRnZZw6EBgUCB3qtFG5CFMq/fPFLpQm68bfrw?=
 =?us-ascii?Q?lrE/WipFr85y1I2K9cvcnZ/oUrwVAOKAOKaolnOWGW8IiwfdczEVhDX2t5kR?=
 =?us-ascii?Q?b4pJ13fw/wfKGzx37yOO+2r7Rd598e1SNel8lhm8ueGwWTLfK7s0Cj9GmY+a?=
 =?us-ascii?Q?Jt/bE1ic8XShbifEa0G8A5oFLi4GKiEymqrPkPd+UICjKnvO4LHPLgSazLY+?=
 =?us-ascii?Q?mBTe9MEVPYo1x22VaYEYlU5f8SKPGx8lkFbnQozWwak8q0DHZJ/OT2vCE0fP?=
 =?us-ascii?Q?o/d/Vfr6ndghVVyy2rn/J3Abj5egyt66XqetBm/FLKIbG1pryWjam1jGcOSv?=
 =?us-ascii?Q?sID/HqdsApQOjCEbmg6dWiHaxanh/IlGr3iKxFTErkz11Oc3jFkWw3S3c2D1?=
 =?us-ascii?Q?gkhZnY8aGsTZZ7g9anXTfDrxl05Rkb9e?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5591.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IUvMAeCVxs3vfM3KsClECkx/6KzqgAd+FROpJfuIDgW17L/gK7VJY5eo+tNz?=
 =?us-ascii?Q?aR+2bW6qZu+6fhpQCTO+8dxdud3G0nY9GPKbT9VEilGpMd7y5dcmNgtOVInC?=
 =?us-ascii?Q?Md41gcEmnYwem/Dq4gAAeL35AaLFedi3obayuobXlCkqnxlml5pZgpyUuV7D?=
 =?us-ascii?Q?XYMmp1EvZrDLNEVdaOpg5cZIDnCmFg7xuKT3PfPCxc97ouwqdrzvRZoZBySe?=
 =?us-ascii?Q?v4+Lvwv2aCJld2eK6Oes4gZggvJdxEfJcVXOWMIVwxFSSB2cQio6W8QJmZB0?=
 =?us-ascii?Q?vxMYKHCyfsU5fyIuCTPh1BcIusJSsR32EmEZjPXNZ9jMYzbsGG8w9V6jJgjZ?=
 =?us-ascii?Q?/FATSPPK4RqYVSQvcPflCqqTEefUiMZn+rUpBMjZnD70qxPeMFs8WY5OyX0s?=
 =?us-ascii?Q?k4QheOVH/Vo4s80l+M1as9e9kpH17JTCnYyHeLkxTp0uYyAu+bvztnWQT1sf?=
 =?us-ascii?Q?hJmc0DD290o8suG84mBsKjrrNU26eYiU9q1E2uzfecaz3e5R8NHECXNQ2UTs?=
 =?us-ascii?Q?wh4ktGCib//Hv4vocfQ9XCHu9op5tcKWdfSn+g796h8glxYumrg3ZYfn/BXC?=
 =?us-ascii?Q?O3vpKtYGuhY+BuiQdsc115G5K0fTLUgdpEzATh59l8zlBsZlc8GHSxLugXUB?=
 =?us-ascii?Q?+pRBynD+zlANK/ZipoSu8vE5b8WuiZLvm7QF7P565BaZeQSpI1gL1Wx1hkFG?=
 =?us-ascii?Q?Llfk0zaUsNo8XACIcHCWoQ5Ct/7fiSpr/6BbokNuN0RsABdu9GwC5svihZAH?=
 =?us-ascii?Q?XvL+HsL3KnN/V4AE0dn5s+bLRvgOFjJnVDTFLyDxUTrPf9OLaB0e03ogWkRq?=
 =?us-ascii?Q?A6GN4oETlv5F4AiK0C5zbXZVRva6uZGqHFwh5KCld1QLz462pDaENEyRsTU8?=
 =?us-ascii?Q?j/ETqcqkv7Iggwt0riNSyyrLLr6bqv4mywbWyhrK+iqA+rHSILE6Lp7r6rVm?=
 =?us-ascii?Q?NFcEhgKoBl/d1ZqHBRlpITdExfgvgMkCg9MRIGAC/vCimFwHzNoGAS372n8E?=
 =?us-ascii?Q?L3oE53PjRqeXp8K/XqODL0DO4mfSF/NwioygZJmwrha4NvMl3IpHZFl1x8dj?=
 =?us-ascii?Q?DqhB/6lbAgG/8baN2iJwKHq9mOeRfV9h5kfyNITKWdrQz8R9HpwWMrnH/djj?=
 =?us-ascii?Q?TOrLhL/wqrVHRiwJmuOPX+EbIzGabpQWgZtsxTlK88LSCDL6/GbKQ+k7Sde8?=
 =?us-ascii?Q?Kb52X6c4cjY/aeffbGM5riQVMyPV29Soz3wO6tc63AKClBxREr87X68TDjxX?=
 =?us-ascii?Q?ephJRIqDCiqgiR+ZQjSID8o1WPekec3ZO6oIay1fLUZe7t6dFBdYB+roribO?=
 =?us-ascii?Q?0QwUymdskLj8goUDn/06KJs3MWrh/ykv50k6MlGjh4WbjYJL93WV7L1SNc1c?=
 =?us-ascii?Q?o8WR8LxMu37DRx2MdR6w4DxqqXplY40w0CT1loo+JHGpJfzWYnfNI0bEz9D6?=
 =?us-ascii?Q?io+ZjvvSrUQlD5NSeQ9TFC2WrHcFon3houZZAAryKWXngZp3KaIkZ/WnT8+f?=
 =?us-ascii?Q?vqxdmELtmfSHcibIo6lv8mKNc2r2Lmah7Hwh2rEe6yDEYsC7hGiHqHEdnN08?=
 =?us-ascii?Q?5QQi7AZ6zArvVWo8px7Z5LkSoJmNYMWtfFW49yVvUsnJH0Fbh3KOCFQnz1Jb?=
 =?us-ascii?Q?PV9DeIenq/y+Xv3NbVhfnqd+ptLZBhtUfv5bQHFZzAQFiMj9qf0D30kfV6H8?=
 =?us-ascii?Q?DSLBCA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3abdfec-cef7-451d-3316-08dd565cb27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 11:57:08.7577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxvRs+gQydPYNf3FEsrFiMFNHGpeXVfqHaSLWfzDOVEbUylYedYjX3ScCdM2Y0NjzyqGsBmhCXOhPatlmHnxF9k5TMNkH8HNisWK8Lz18DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
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
> From: Dooley, Brian <brian.dooley@intel.com>
> Sent: Monday, February 24, 2025 6:00 PM
> To: Akhil Goyal <gakhil@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>
> Cc: dev@dpdk.org; Ji, Kai <kai.ji@intel.com>; De Lara Guarch, Pablo
> <pablo.de.lara.guarch@intel.com>; Dooley, Brian <brian.dooley@intel.com>
> Subject: [PATCH v5 3/3] app/test: add SM4 GCM tests
>=20
> Added SM4-GCM tests for the AESNI MB PMD.
>=20
> Signed-off-by: Brian Dooley <brian.dooley@intel.com>

Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
