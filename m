Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A42EE2084
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 12:01:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A80D4028E;
	Fri,  6 Feb 2026 13:01:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id A5E9C40276
 for <dev@dpdk.org>; Fri,  6 Feb 2026 13:01:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770379306; x=1801915306;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3vWIJTVdxNJG69m+D6VFBttZphLJGiaKOiekDbTWsYk=;
 b=B2PuB5InbZ/SQ6hdGZqZJDYLNYBObnCLaUQorU1vYv02X0gT2aT0HzGK
 Sw+mUqIDoXjR3neWAdbxkPy9jT2r0lP1gu/ElPnwS9mt5FmDbu0svxvhi
 VUw49zQVXYOtgsEjtRurJMuzGZVaHPfmRQnK2cL9dxJGVjglL39bCC5dT
 1eHs/gh8/KM9shZ1FcaseSe3O0kag0X83/8f2EsbvYUmTTI8sNcMMAnpC
 X8gWM+7NtDxgQVRwe0Qm3X6g9N444utDaWbuRDnVOl+/yTq484gfjleLc
 FoM+5i1/YRI936ENkeiZqWggwgpIv8uVM22rfiReOKDiT4JcWgY3wazaS Q==;
X-CSE-ConnectionGUID: WDBzIQX/QXmk4n6jxLGcCA==
X-CSE-MsgGUID: T5JKpYhkRpWZ63WqIH1wVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="97041173"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="97041173"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 04:01:44 -0800
X-CSE-ConnectionGUID: tSaE+gioREWTBd4atgJaLg==
X-CSE-MsgGUID: OoIZdeOJRA6BVOI7g26RhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="215375635"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 04:01:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 04:01:43 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 04:01:43 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 04:01:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TihdwmpfPaoTwkcifvBk7m+Xx3F9K8ttmoGXrKWUxjj17VW0YLRYeBsYnhOtjZyu14JimyKCjHxqrinzkLQ0gbKTfya9+7DCPkf0Yj+k1r9aO8u6g1wzzqHvceFLWaKR7tK3NAjltALJ0IqK9DaO6o39ZWHTwtugdkIQVEQRokD0XZ2pG+cgDWuKnTYkN1SRaSGD1VVAIASMxsr5JD7kHAQTTu4XtTAb1fLjHphU+KE1CZvce0AYmtp0ZpKM3lQ2pCd2cNyLrYJu0/TH01PkxXMbtLEe7RILDe+N8IuGY3TUbep6rcMY2MuUgoKa+CXXsZ5MvxINOorf9sHxHgjkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE16TooJTRDrRPHTp+cNWldL8KZcgvLoAqnFp0d+BZA=;
 b=Nin8W+j0bw5speHFD2w81VtHEk8vEzUE90NghDhy1c2iYNxSq4h0Vndkg+/uDB4oUR98sLo/DCVttPItDfiIYSnZ4Rwwr30oe9lvPlJyF3GKzT9dglgBUw81a9ZV7M6+GN8+r39DCEMmJWTS2fELo4xCEW67iRGY7zFmyT8KfiRc4Yf8HTrRK70vnSHgE0h/j1mFXGy9SahpA4u344HXKb7IgBX/T3S4yf9PBU8Hoe+wgkowVlevBcddDb08hH7GfZboTc+YOtCTrcqUL8wyHYBQPlrnnkfE87mdK9Bnqd+YNdtQHwXaQJbhJR3J326Zq0K7BYPwbMDuLtejgmc2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DM6PR11MB4580.namprd11.prod.outlook.com
 (2603:10b6:5:2af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 12:01:38 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 12:01:38 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3 12/36] net/intel: create a common scalar Tx function
Thread-Topic: [PATCH v3 12/36] net/intel: create a common scalar Tx function
Thread-Index: AQHckd2/UsJIHbT2nE2wMug4r+DNIbV1mqOg
Date: Fri, 6 Feb 2026 12:01:38 +0000
Message-ID: <DM3PPF7D18F34A1A9D1B959705F1F8BDEBF8E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-13-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-13-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DM6PR11MB4580:EE_
x-ms-office365-filtering-correlation-id: 325ce11a-421a-4360-e477-08de65777bd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?hCTJJZWCKnyPNUg6Vn6SKFmOIxFk6AAL3osCKN+JGNBYDQjz15jFkjt1phtx?=
 =?us-ascii?Q?xXKfb2SB4ajwMPMbaFmoisuqUifChdUM2itNJB9DbTA2UN6f5r76ZJ/xBwm8?=
 =?us-ascii?Q?aJ4rC7lTgVwQ5reImCzrbkhwkQgjuFI1rrJWOoMaugmzQT9K4Sk6jao2EGgI?=
 =?us-ascii?Q?bIoElP1OqMGk+O/2eU9S2TrR2FMSCyOtC3FM1+1UOJoY19wCy+EfTvg0X2bA?=
 =?us-ascii?Q?SWybgxDfqhR5mvkAKL3p2VcipOrkzdBkpuqa4n2YEUlmJnbg4vy9OfwOJjkV?=
 =?us-ascii?Q?lrjsPzLaAKde2nMYPRV8dqmom5OJMEvz3a/IOyYsNTTvAhqnt9RxqSR9pqvm?=
 =?us-ascii?Q?4XKGQQLmgEli3uc3TT31TL+AO3HPdBsRT2GYir44awcoskWfiA2xAl1RwquS?=
 =?us-ascii?Q?pEzj07I3wvDZnaAX4mnINI3/Cl5bx465XOZiWeNRTaPqzz883sImiPt5FNg2?=
 =?us-ascii?Q?us1dNHT7OX9aE6KseQ4/ffs50Fm6pnl0B2BDkUQpAs3mn88fOvvhEsRRlma+?=
 =?us-ascii?Q?m56SqSahwHwqfz4ygQ3uJkMytjZWSRchKzDK6SUxevvD8djrrgO18uyzkMof?=
 =?us-ascii?Q?gLBujanqBs5ueVIS1jIDJf2TwYwRp0fjMYkQShDbTon0gqKmJwtHAN+yttFI?=
 =?us-ascii?Q?9csHy7rgW4BKcpAgaBxiruiaeSpip7adXHu/U/Rid0TtT4bR3peVYP+/5+Al?=
 =?us-ascii?Q?D3+pSXvZFQGqgVDg47967MfAVPt58qUPlcPdv/PNJspqGoB0gsOyQaVY9yh8?=
 =?us-ascii?Q?NifVE+wBd2y4GmLNjqvcXoF3QmV0BvSFS3TCpBuofc37Y0yPobxMQUwt3sT+?=
 =?us-ascii?Q?bFp0F/Js3/1+PO4XoU/wjcbHUYizcP1HrpAZa9A023uyCJ1y1b9Nc4ZMQLfq?=
 =?us-ascii?Q?suCy/UbVeWeKrcwBN7PaZmpEpnCqW0f6a3+dtkSnpNZr4VNbsbxeljVc5RCe?=
 =?us-ascii?Q?246GPogjk9tgouFdwZDdcFdNFxgO3Zh5m5OSimdIix7l+hkh7G8wg8evhjL/?=
 =?us-ascii?Q?piHidMNuCP9ggB5377I0qs8xsE8EHxeIdgzJ1PTRrt0s5zPZL8k4QGrksl4C?=
 =?us-ascii?Q?JB+z02QnLcNNgApeu0VYianRNCMd+R4bibz4F8dmVzX0SoH3PPpv1QuC1iR3?=
 =?us-ascii?Q?1YDsfuw7AWGJQcUjrPZ2q2YvdJKZYxCweLOp9SQECOJa2GilM9y8d88nm2xu?=
 =?us-ascii?Q?519rGoQRue+32CBmDb4ndVmi2EgGWm5eMIrXfZ3ZgPqDrDyYnhjd97UXDV5a?=
 =?us-ascii?Q?SLuTG9I+QaEME848qh5ngVCpoAHEFkRTJBIJIvh6e2lz9VAjcd6wncv87duM?=
 =?us-ascii?Q?+Pqeyf66n3FMPTdswEgWvTc90NXZSAVHxzyVcEDBDzz5radNQZ0jvAXlY0ZW?=
 =?us-ascii?Q?0IaxTppxau0dHgncI1hQsXZ5aT82CAI6//K+/QTfuYyOpD0g9kXx5AFeYjGe?=
 =?us-ascii?Q?YlGApW6lTBt+OJrhKYoNWzhijJTxf+kkbWwEQ7tqY7NL78LE35vJBqaExcEU?=
 =?us-ascii?Q?4v2az28rZFeADqoAnrIDb0ARj7x9rZafjBy3vIQD6WJbPCqGx6hhJMxtILne?=
 =?us-ascii?Q?7MV/qVRJdcs6JheH90KzOiqC4WgMzLunfBAE0dlJFlrzvGHz1U4JW0+u1C5X?=
 =?us-ascii?Q?RCkhnp0eA8VQks00mE0cRIg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MrIJuWu0xghmLaJhaD5UOyRTvwbZ/6Fhr+qw26zOQX5BhW9EjGHrrTpWXx7V?=
 =?us-ascii?Q?por17/u1BumY5tPlLrORhnbKT0sXd5271+KYreritufUvY7Xi1AaJlPut2WP?=
 =?us-ascii?Q?STL+vPr9lQCDTXlOG9ykWSnuL/Qyr5z5+oEjgECWuSdwYuwb7SLHw2e+YmBP?=
 =?us-ascii?Q?MvXFRGeWI9SALF2NX49PTqvRU99dS8B/Ad+rFW5BgcNwo4vvjX6NHJAC4mmu?=
 =?us-ascii?Q?UsfPTW7i6M9T+qqbrGQWTv/+/mz84HofT3Rf6GyiILwMGn6CTpgdQsHfLh6t?=
 =?us-ascii?Q?axMYqkKToUlr263Us3Zzi7C3/z7UMYhEuYWJ5ZRMjQxbWC8rO7XwIsL7NTJu?=
 =?us-ascii?Q?NoriA3JhCkgdj0F77m3zUqbZ5M8loSkC37byf4ob1oGlOJIaF0QwxU6cFgk2?=
 =?us-ascii?Q?oJzzUoDK0jqf5v3pnqEBRtCA/cLhORGtQmZdJlwdVD1quCZeH4XTe+akvrTH?=
 =?us-ascii?Q?WkIGaw/F4RgdGBnx+OxlTDWmjIG1joB99ue1OBdSIk8DLySvRnPB2E7HTxm2?=
 =?us-ascii?Q?XTeBppCB7c1+5eYWWbRoFqv/0GgckXVHkfiryG4clSsBRTeBpaPbIa2hcNwZ?=
 =?us-ascii?Q?d0ZCPTk79zmA6P9vBUkH3TLtglHMVoZVV+kkE+qjGNWjU5T+K3oKa8ps6Lxt?=
 =?us-ascii?Q?tyf1jP8zBtFXRgu4MEneTzTS23RlH/m2aaFSvAIeFaJCdSGHGpGXt3uWYjoA?=
 =?us-ascii?Q?KNBah6vg56cz7srfHgRyARvKt5f5A0yGRUwpTPvQ0BEC1HHO0BtLb/p4QxM8?=
 =?us-ascii?Q?a4OpSvj80MZ7yyj9Dbi1BC3HxeY1ejwb8TLKJFi8hrv85/HA9PX0mYbZxqID?=
 =?us-ascii?Q?xcSPgf2L+qMPO6rHYDHv0cs61btA1Xh5NOAsDUAJ6dFQsw410O4Y1DpSK8zY?=
 =?us-ascii?Q?cs7z1VW2SYRU5HJEZRrDOAR7sgrCl446aqB4EDkRIdoWLN8ugkV3qZKEe+6G?=
 =?us-ascii?Q?nhishtyLNuSPyGLm2YM56ITAH+6FVITlyJQFiP+BdlnYuj15Jd0ujhX08WcO?=
 =?us-ascii?Q?KF70R4kFhm8X8DcbxsmimwbgGqaYPRl2POgL7/tl3VfwflZSma51F3wwyALW?=
 =?us-ascii?Q?PBTE0Y81t6w7Ljy9Lm41O0jYNN1S+O5ChPv0dWaPB1NuW6cdHBP03xwAG53H?=
 =?us-ascii?Q?Mkb5ryCRZkNZBo5H5kV+PcK1170n+pSQ0YNhbZBK3fA6fZcYTwMTQg7pzZES?=
 =?us-ascii?Q?SQY5RVINedmxa5m0iLfZZPGrkhqnbiG3uuuG4xKZ1iN9umcSCj1f8u1/+ljE?=
 =?us-ascii?Q?YBCeBNGLpetpZMhLjS7figcZd7giBNzS1RqCURMFOo4xdRw+PgVcSUh2l2U6?=
 =?us-ascii?Q?Pqssm3ZtOSnTYyekZ6TPyEeer5N1SgJtnPYDNswMWqJ6WRDuivfTbhQOAe4N?=
 =?us-ascii?Q?DgnyAkBAEwFBQtLllJEtcZCyXTgpaHiaVInvvK7dyliDYWUw6J2eIh4LdjjY?=
 =?us-ascii?Q?SsQUqXbyWPcFrDbNchdT/gv7sJEKW4AOH7EsjEqdtOxbFpZbZrbucLZyNUGg?=
 =?us-ascii?Q?1x0QjmSXXbvPAhcRoOFBJRNAVWdf92t4N3d8JOi0+bQkUCL49PKsIGWPBKBc?=
 =?us-ascii?Q?dE+DNiNm8r4NGnXugizKQdlt8YXpy5p5soKagzSBF2g0lsg7C57GcKep7+J3?=
 =?us-ascii?Q?c2NMOR3gfCDiVLbm/cf1I7dfdw+vHTRb+s0/dEzFcUWt8hzAJ1HsIpux+RGt?=
 =?us-ascii?Q?aawQ58Atc/E4NdEHF3NjYv2b3kejrB5+DItgZL+usW10yu9O0vIFpTwkukoB?=
 =?us-ascii?Q?eNAMZidJ9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325ce11a-421a-4360-e477-08de65777bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 12:01:38.5646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vdvou1je2LwY8KYOKzMFLhwREGhY4MXz2McWEB7eM19nRby+P9vNOBx/5Pp/Sh/Pgek4Nxwv8LcUkEaLIbeC8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4580
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

> Subject: [PATCH v3 12/36] net/intel: create a common scalar Tx function
>=20
> Given the similarities between the transmit functions across various
> Intel drivers, make a start on consolidating them by moving the ice Tx
> function into common, for reuse by other drivers.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/common/tx_scalar_fns.h | 218 ++++++++++++++++++
>  drivers/net/intel/ice/ice_rxtx.c         | 270 +++++------------------
>  2 files changed, 270 insertions(+), 218 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx_scalar_fns.h
> b/drivers/net/intel/common/tx_scalar_fns.h
> index f88ca7f25a..6d01c14283 100644
> --- a/drivers/net/intel/common/tx_scalar_fns.h
> +++ b/drivers/net/intel/common/tx_scalar_fns.h

<snip>

> +typedef void (*write_ts_tail_t)(struct ci_tx_queue *txq, uint16_t ts_id)=
;
> +
> +struct ci_timesstamp_queue_fns {

typo: timesstamp

> +	get_ts_tail_t get_ts_tail;
> +	write_ts_desc_t write_ts_desc;
> +	write_ts_tail_t write_ts_tail;
> +};
> +
> +static inline uint16_t
> +ci_xmit_pkts(struct ci_tx_queue *txq,
> +	     struct rte_mbuf **tx_pkts,
> +	     uint16_t nb_pkts,
> +	     ci_get_ctx_desc_fn get_ctx_desc,
> +	     const struct ci_timesstamp_queue_fns *ts_fns)
> +{
> +	volatile struct ci_tx_desc *ci_tx_ring;
> +	volatile struct ci_tx_desc *txd;
> +	struct ci_tx_entry *sw_ring;
> +	struct ci_tx_entry *txe, *txn;
> +	struct rte_mbuf *tx_pkt;
> +	struct rte_mbuf *m_seg;
> +	uint16_t tx_id;
> +	uint16_t ts_id =3D -1;
> +	uint16_t nb_tx;
> +	uint16_t nb_used;
> +	uint16_t nb_ctx;
> +	uint32_t td_cmd =3D 0;
> +	uint32_t td_offset =3D 0;
> +	uint32_t td_tag =3D 0;
> +	uint16_t tx_last;
> +	uint16_t slen;
> +	uint16_t l2_len;
> +	uint64_t buf_dma_addr;
> +	uint64_t ol_flags;
> +	union ci_tx_offload tx_offload =3D {0};
> +
> +	sw_ring =3D txq->sw_ring;
> +	ci_tx_ring =3D txq->ci_tx_ring;
> +	tx_id =3D txq->tx_tail;
> +	txe =3D &sw_ring[tx_id];
> +
> +	if (ts_fns !=3D NULL)
> +		ts_id =3D ts_fns->get_ts_tail(txq);
> +
> +	/* Check if the descriptor ring needs to be cleaned. */
> +	if (txq->nb_tx_free < txq->tx_free_thresh)
> +		(void)ci_tx_xmit_cleanup(txq);
> +
> +	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
> +		uint64_t cd_qw0, cd_qw1;
> +		tx_pkt =3D *tx_pkts++;
> +
> +		ol_flags =3D tx_pkt->ol_flags;
> +		td_cmd =3D CI_TX_DESC_CMD_ICRC;

Why change this initialisation from 0 in the ice code to this value in the =
common code?

> +		td_tag =3D 0;
> +		l2_len =3D ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK ?
> +				tx_pkt->outer_l2_len : tx_pkt->l2_len;
> +		td_offset =3D (l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
> +
> +
> +		tx_offload.l2_len =3D tx_pkt->l2_len;
