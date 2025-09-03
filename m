Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D87ACA100C
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 09:38:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8309B40B9F;
	Wed,  3 Sep 2025 11:38:42 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by mails.dpdk.org (Postfix) with ESMTP id D0CC540261
 for <dev@dpdk.org>; Wed,  3 Sep 2025 11:38:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXp5yEzhfj8BbSttaq7ZFqKCd1AdAiovbGhcmaOsjmOzEi1hPMfFFzlF04Z+AlYov9E4YOxKJuOJhFvdKax8HTvkln6yy9d5FmR3RxADnWn19SmActjzU6PMKJ86kd7+RA1hxa0V5KnN51RscgDFgjslOfvxjeTaDwFSdIcxRXn4m1SX3xxHbCsJuDpOESCGwzNoKtYvRLYMgAEW2FQuiyqJcDNq7X106XbWN+qd7fXy7cVn8Yf4bHOvoMZRlpctGqovugaq6kqvKrpmcZ0mI+WUg0be6M0A28kPICUNYekZf5Bh+ZafD1kdqcGl1/Mwqxl8cwDoxJkAl6+htmjvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUdY3wmGWbRPuyfeRYxma8Qdh+j6TWI+wA+0WX/CHw0=;
 b=PQhLfQNDrv1++AlCkpHY/akWbytsQXF4P/RcDpd7RC0MNqRfSFsPEousaycFB1TfeYbn0RJtW2R3GJRxzr6gryCbO3lpqZEVuviPsnYtV+dhDhIrbBxYOOlqz49AM8oeDx44iywZhc9bP3B4kwWuWythImQGXWDNjyK1K9baTEFaAABqjdJOuqffN4E4T0KNCk+VmUsq1YqovsfRR0eDhEtGBSxtSzWBrHryCE6hy5E/16zz9HPxgzSJMflmNQgY6Z1NNM6hlrMwtpzhXGtq13rrMVtaY+C/qUk5C6KZsqQdfSVS3DPYj3Xd/01l8yyGIDip9ADP7wIv+QFigqsG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUdY3wmGWbRPuyfeRYxma8Qdh+j6TWI+wA+0WX/CHw0=;
 b=IZMikO4dGpzAtHi9NrZYkEOqqBaFpUIv03tlruVH+QTaGb7pX7vqLZHw5HjnBsg0D7W95d3Ph+JzfGP04wi2LQ9jYdknLcSr6MMim/G5EDMW9rkhiqrK0qqRFQTBypofj8UGSV9fNN5X++iA1I5sHh/dsTz70hSrw1HpZadQGYFMYn0Tq4FhJ/ziuMHG5y9QC+rma1RcfBICFy8bD4x0eB8LPl1rVwXRmuHUn1uPo/AROwtTamSrVqlLLSLXFn7p08SPDusOdKBA8csenM3MTHn+OUWIT8gEw+8oMwzBMA+vQI/199A/t0uzsHZvVFDQIrAqTjzXiRIDB4FkZEVrHQ==
Received: from BY5PR03MB5234.namprd03.prod.outlook.com (2603:10b6:a03:219::14)
 by SA3PR03MB7345.namprd03.prod.outlook.com (2603:10b6:806:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 09:38:39 +0000
Received: from BY5PR03MB5234.namprd03.prod.outlook.com
 ([fe80::5116:191e:bbfe:5859]) by BY5PR03MB5234.namprd03.prod.outlook.com
 ([fe80::5116:191e:bbfe:5859%6]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 09:38:39 +0000
From: "Xu, Rosen" <rosen.xu@altera.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "maxime.coquelin@redhat.com"
 <maxime.coquelin@redhat.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil
 Agarwal <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, Kai Ji <kai.ji@intel.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>,
 Chaoyong He <chaoyong.he@corigine.com>, Vijay Kumar Srivastava
 <vsrivast@xilinx.com>, Harman Kalra <hkalra@marvell.com>
Subject: RE: [RFC 8/8] vfio: use imported uAPI header
Thread-Topic: [RFC 8/8] vfio: use imported uAPI header
Thread-Index: AQHcHKSDmtnil51d3kexXMPARpDj0rSBM7aA
Date: Wed, 3 Sep 2025 09:38:38 +0000
Message-ID: <BY5PR03MB5234E61AF2F2BA9C4D1010B3FC01A@BY5PR03MB5234.namprd03.prod.outlook.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903072826.1727004-9-david.marchand@redhat.com>
In-Reply-To: <20250903072826.1727004-9-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR03MB5234:EE_|SA3PR03MB7345:EE_
x-ms-office365-filtering-correlation-id: e5bc3bb8-a3cf-49cf-af48-08ddeacda987
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?56kczP+zAjH+bView+ICHxswyqu7V+r5kaCjrGlB/NXeZi5/QfddFgUxYbC7?=
 =?us-ascii?Q?iZuG0QVINcbXAZAldBzbM40V/PRp9HU2ocdIN/0IMTefd0TkFesldTfBHYV+?=
 =?us-ascii?Q?vGS2p5qLJ85wn5X0poDNcFayIeyXId8mhSxjPx8hiuQjkkWljTiDjH4Hxiqh?=
 =?us-ascii?Q?ML6lxw06aChO/YROIP5eK5Su3bAPnp+euINCPc7dGR5wYrWjOxDlWzIsmTCk?=
 =?us-ascii?Q?Oomda4/ONQVtTnmR5l3cqCaGvyrAjxg13Jpq4e2SIzAON6mxxp7H2Cjv2i9G?=
 =?us-ascii?Q?oDKOWvn1qBoDHsQxtKh62+3Vh9U7o8OhQ3y2kEcAYZJyMmUVDRF1VJoulgcT?=
 =?us-ascii?Q?+2vz5cHykyO0Tf2DVGNEel3qPGkP2Jk42FxThkN1cCCJccYRF83TqgaKG/np?=
 =?us-ascii?Q?d9sfBDVJUqkVhTLtSRia2L6/b/bb3bo3Whxg0iSodm82ogyfqaPk4rJdVnqX?=
 =?us-ascii?Q?xIzJA81Hom7SMCO50/kuQqwbJ/+KTUztQ9DSuVxw4WnvnF4lf29MjWweGZij?=
 =?us-ascii?Q?MCLYzWlkfKdRBcIzYlIZZ5EHf141/6zvdT2S1JHad0F1Zz+FEnTpHpB+A7Az?=
 =?us-ascii?Q?gUfWX0y8dkIg3Noa3yhkUYnjjQvKcAG6pFy1RQxsowKVt71ahhHf97FF0Yzi?=
 =?us-ascii?Q?ItZN6yY4Pv2dnFxWII26F2aF/VpCDRVa4d0ms/FymCMY1zkwWvJEPp87/UBF?=
 =?us-ascii?Q?lGW8bsejtspm/owXOeoxeIgTnwKX52t0zHZKjy+cx8yFCwnIeErtVGhNu+7u?=
 =?us-ascii?Q?oj/ciNdcCgMbf7Ffcg8Gv7N1m7DDcb43dDAF5NW6vNlMT8HYO0YjhvhnVbqn?=
 =?us-ascii?Q?sr1eai4ZkZ6iapKV8sNUgQh2qv5ysuXAtwMvqqPeMftSoKzf+iNyANcVZw7Z?=
 =?us-ascii?Q?W8dtBm3qWqzuL27YE7HzgTfBvQ9HrqwDz+4xKpzI/57jXEvWQl0IifeSAfqe?=
 =?us-ascii?Q?UA6fwFEeHHQWkJdMsuP7vgtc356d5wNNlocYCInV3bWzMwB6LjDQ7vur8PlA?=
 =?us-ascii?Q?/y6Gmr/IzdUQwJq6oAYLL4L7oV3j2L8rnlePQVA+8gsz+74EoJV6nXSkvtc2?=
 =?us-ascii?Q?zUaYuuvG/2VuFReoDL3es7ynR/C1ewMu0kAilslL2NElXrCsalZk5OwaN5HQ?=
 =?us-ascii?Q?swH0LvG9UVgro98sHPbQznOnjONnWRFfONT63f4HeTNh3nVbY0VoGZ3Yv6hs?=
 =?us-ascii?Q?jNlEtE6T2c8okXUhk41xpggVY8fs2eVV1uZtKlzmVUO60exdhr6+Wrr6CD0N?=
 =?us-ascii?Q?HoNQEpX0l1xJKZHwJlNnp2c69LY1o9QVXY0gG1G26PIy8jvZHRHMYCkFRm0P?=
 =?us-ascii?Q?T5PaMaLAiQYNp+lIAZ8uxTg5A8h0QL7awtUO9Iwl+hl6iQVnoAfWquDREtFy?=
 =?us-ascii?Q?CoNaUyldnuZqNyJTc1aHEkiQyTDNk7p7FczZl62JKCXstw/SYmlUU7yb7UjV?=
 =?us-ascii?Q?CXZ8YEbLuASEcaYleHpLRNnhjWKU+ObKnXtIdE4cgygB58aGqV1pLQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR03MB5234.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LYCcDQ5w5tXeKbpdP8JSnxCURIFeZ7V2kJZ1864bZmjfAPsWMqyrp+8hDjme?=
 =?us-ascii?Q?RGvxRvY7kk23iAX63dQ0dgdJSNgI2ZGjsqFTW5Xp/o4gAogBx2vDFqpRSR4z?=
 =?us-ascii?Q?x4T9Xlfz/VKp/01QKFSdfgytTlaEDIeOa9aKyCChPE06BjDGoHbJLKIEobNG?=
 =?us-ascii?Q?zt+j0vWwMbrbi9cIMdlvFU6qxQADG4qtaB42QxpWrCcupfaclWCZjp0MpIqe?=
 =?us-ascii?Q?DVVccN9YuWpD7NVNruHvBRANWTUJS70ouKt40jPPrioOpdW7z5xP8NglIyxl?=
 =?us-ascii?Q?Tr7YPpKr6SdcJcMTeUQsEzQHGzEoAR2kxUfEbBMbeOyjoOBRqzA0O37TQuXg?=
 =?us-ascii?Q?kKauLkcNBq0xkP7gZabtSDS0dzDiO/06SuV+T7KTi+kngi5hYqaF3eqpCebn?=
 =?us-ascii?Q?nlQI9B+dy9Lx2l0sLiffQkdo4u3u/XKA2n9tY2hjG7nxVFGzqUt3JGwTEX/V?=
 =?us-ascii?Q?8vHtBBI8n4o8eN1KEVMU1wNbXtS0nIGhzxLLL4lpWsX28r+hmiP7Tj+eXs2i?=
 =?us-ascii?Q?ZfUP2ViED+Foh+rwJrGxynqz1Jb3cDdCIRmdE4obXboi/pECfSRDy0Ezc4KX?=
 =?us-ascii?Q?A2gdXaIE5/hGC0pzuGhU+15XnTzKDv5SJB9ctOf4+3j/4E8gASEtF+ztb2ks?=
 =?us-ascii?Q?pN9HhTWwXObxZ2JlX4DbTqbbKztY3+po+7OWO8JlZIPD4vz/NtYsfWi5Q1Ec?=
 =?us-ascii?Q?/NiK1b7hsVTbUeg+O/Piq+jcbZBT97bOb0CKlzZBLtJzYG9fKmHuPg7CuQuH?=
 =?us-ascii?Q?uZ0sBMI9ub6nINCDR5vQAPhyCMRMMl/RR+tmCud5IGD4newSgIlGRU2I9iIL?=
 =?us-ascii?Q?YaiFe3bAWIaxCg4JDcZnjHWa/fTdbcVGa1jqsjwcyVn+pQnYOaW8edDz0j91?=
 =?us-ascii?Q?x8owokXpmTIdgcPZfDbwOTgRNcUsIE9UvbVa76gEJI0UmsKnWvSFsTAqTBTQ?=
 =?us-ascii?Q?1+CJliiDAgMyKYUx5shn6A11XapfbK0nyX8KKiHjQoXL4E10JFsab+HQsfg1?=
 =?us-ascii?Q?tqwZEELWXLB2qs0wy/+vdZJy+QkLhsjDzY95X35OsvecBN/T1taTKRaUQJhk?=
 =?us-ascii?Q?D9U3EEkLZGYM0gVPzsr5KuYlvC7NCuJhknovTFmYg3fHM1wrjiYzM3h7DVJY?=
 =?us-ascii?Q?vcHktvFsHW16p8CcqAvOL/1KbEO3glh0B7ZPeos76gt4v1BpCC1rvMNU5uFy?=
 =?us-ascii?Q?ZT/noBFr6kHvJHY/ZpNnIx7HBBowv4lYzOBgqogi34q+6Z9eXTdbuTOSy8Zm?=
 =?us-ascii?Q?HJm+51o97kVGOC0NCfxFd1xXExJ3RiBDbeAgzhuzFI/0hOGjh6t7eG0av4m9?=
 =?us-ascii?Q?av9T/o060tIbizPcHs89z+pyRYREtRWzqOXgavHlpxLiBNEgE/JidGeDz4gl?=
 =?us-ascii?Q?RSScZ8k5E1UkDsZxuThD/IpsETcn7oL6mcUsx7wA73NggYAm4uuNynQqaBJV?=
 =?us-ascii?Q?OjhoQTM1xHuUaXrX9oWmtnOI+xXnQ5BZXySQVRunz2IU7fkMXz69lEDAbN4/?=
 =?us-ascii?Q?p+7GnBhctzQVCXNUyxgnS0g2d5TTPL/MEI2TYvq5WyPVe5oVhzNTbNFhDgYZ?=
 =?us-ascii?Q?lB8zOHEvJgdmMohVR4XfY4dyZbQOvVLrjYn8hsFJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5234.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bc3bb8-a3cf-49cf-af48-08ddeacda987
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 09:38:38.9135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xT2jmauJU9aMUgpQLQzvSwWpWa64XQ3qjPMxPqA13Z1JI90y8LqDMq2cFnxSw/cYc9m45tJ0wl4gRmjqtyhYgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7345
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

Hi,

> -----Original Message-----
> From: David Marchand <david.marchand@redhat.com>
> Sent: Wednesday, September 3, 2025 3:28 PM
> To: dev@dpdk.org
> Cc: thomas@monjalon.net; maxime.coquelin@redhat.com; Nipun Gupta
> <nipun.gupta@amd.com>; Nikhil Agarwal <nikhil.agarwal@amd.com>;
> Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
> <sachin.saxena@nxp.com>; Anatoly Burakov <anatoly.burakov@intel.com>;
> Chenbo Xia <chenbox@nvidia.com>; Tomasz Duszynski
> <tduszynski@marvell.com>; Kai Ji <kai.ji@intel.com>; Ajit Khaparde
> <ajit.khaparde@broadcom.com>; Vikas Gupta
> <vikas.gupta@broadcom.com>; Xu, Rosen <rosen.xu@altera.com>;
> Chaoyong He <chaoyong.he@corigine.com>; Vijay Kumar Srivastava
> <vsrivast@xilinx.com>; Harman Kalra <hkalra@marvell.com>
> Subject: [RFC 8/8] vfio: use imported uAPI header
>=20
> [CAUTION: This email is from outside your organization. Unless you trust =
the
> sender, do not click on links or open attachments as it may be a fraudule=
nt
> email attempting to steal your information and/or compromise your
> computer.]
>=20
> Now that we have a v6.16 header in DPDK, we can remove all remaining
> wrappers around VFIO uapi.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/bus/cdx/cdx_vfio.c               | 45 +++++-------------------
>  drivers/bus/fslmc/fslmc_vfio.c           |  3 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |  3 +-
>  drivers/bus/pci/linux/pci_vfio.c         |  2 +-
>  drivers/bus/platform/platform.c          |  2 +-
>  drivers/common/qat/dev/qat_dev_gen_lce.c |  2 +-
>  drivers/crypto/bcmfs/bcmfs_vfio.c        |  2 +-
>  drivers/raw/ifpga/afu_pmd_n3000.c        |  2 +-
>  drivers/vdpa/ifc/ifcvf_vdpa.c            |  2 +-
>  drivers/vdpa/nfp/nfp_vdpa.c              |  2 +-
>  drivers/vdpa/sfc/sfc_vdpa_ops.c          |  2 +-
>  lib/eal/linux/eal_interrupts.c           |  2 +-
>  lib/eal/linux/eal_vfio.c                 |  3 +-
>  13 files changed, 24 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c inde=
x
> 576718a659..f9f19b4122 100644
> --- a/drivers/bus/cdx/cdx_vfio.c
> +++ b/drivers/bus/cdx/cdx_vfio.c
> @@ -18,7 +18,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>=20
> -#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
>=20
>  #include <eal_export.h>
>  #include <rte_eal_paging.h>
> @@ -616,33 +616,6 @@ rte_cdx_vfio_intr_disable(const struct
> rte_intr_handle *intr_handle)
>         return ret;
>  }
>=20
> -/* VFIO_DEVICE_FEATURE is defined for kernel version 5.7 and newer. */ -
> #ifdef VFIO_DEVICE_FEATURE
> -#define        RTE_VFIO_DEVICE_FEATURE VFIO_DEVICE_FEATURE
> -#else
> -#define        RTE_VFIO_DEVICE_FEATURE _IO(VFIO_TYPE, VFIO_BASE + 17)
> -struct vfio_device_feature {
> -       __u32   argsz;
> -       __u32   flags;
> -#define        VFIO_DEVICE_FEATURE_MASK        (0xffff) /* 16-bit featur=
e
> index */
> -#define        VFIO_DEVICE_FEATURE_GET         (1 << 16) /* Get feature =
into
> data[] */
> -#define        VFIO_DEVICE_FEATURE_SET         (1 << 17) /* Set feature =
from
> data[] */
> -#define        VFIO_DEVICE_FEATURE_PROBE       (1 << 18) /* Probe featur=
e
> support */
> -       __u8    data[];
> -};
> -#endif
> -
> -#ifdef VFIO_DEVICE_FEATURE_BUS_MASTER
> -#define        RTE_VFIO_DEVICE_FEATURE_BUS_MASTER
> VFIO_DEVICE_FEATURE_BUS_MASTER
> -#else
> -#define        RTE_VFIO_DEVICE_FEATURE_BUS_MASTER      10
> -struct vfio_device_feature_bus_master {
> -       __u32 op;
> -#define        VFIO_DEVICE_FEATURE_CLEAR_MASTER        0       /* Clear =
Bus
> Master */
> -#define        VFIO_DEVICE_FEATURE_SET_MASTER          1       /* Set Bu=
s
> Master */
> -};
> -#endif
> -
>  /* Enable Bus Mastering */
>  RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_bm_enable)
>  int
> @@ -668,9 +641,9 @@ rte_cdx_vfio_bm_enable(struct rte_cdx_device *dev)
>=20
>         feature->argsz =3D argsz;
>=20
> -       feature->flags =3D RTE_VFIO_DEVICE_FEATURE_BUS_MASTER |
> VFIO_DEVICE_FEATURE_PROBE;
> +       feature->flags =3D VFIO_DEVICE_FEATURE_BUS_MASTER |
> + VFIO_DEVICE_FEATURE_PROBE;
>         feature->flags |=3D VFIO_DEVICE_FEATURE_SET;
> -       ret =3D ioctl(vfio_dev_fd, RTE_VFIO_DEVICE_FEATURE, feature);
> +       ret =3D ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature);
>         if (ret) {
>                 CDX_BUS_ERR("Bus Master configuring not supported for dev=
ice: %s,
> error: %d (%s)",
>                         dev->name, errno, strerror(errno)); @@ -678,9 +65=
1,9 @@
> rte_cdx_vfio_bm_enable(struct rte_cdx_device *dev)
>                 return ret;
>         }
>=20
> -       feature->flags =3D RTE_VFIO_DEVICE_FEATURE_BUS_MASTER |
> VFIO_DEVICE_FEATURE_SET;
> +       feature->flags =3D VFIO_DEVICE_FEATURE_BUS_MASTER |
> + VFIO_DEVICE_FEATURE_SET;
>         vfio_bm_feature->op =3D VFIO_DEVICE_FEATURE_SET_MASTER;
> -       ret =3D ioctl(vfio_dev_fd, RTE_VFIO_DEVICE_FEATURE, feature);
> +       ret =3D ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature);
>         if (ret < 0)
>                 CDX_BUS_ERR("BM Enable Error for device: %s, Error: %d (%=
s)",
>                         dev->name, errno, strerror(errno)); @@ -713,9 +68=
6,9 @@
> rte_cdx_vfio_bm_disable(struct rte_cdx_device *dev)
>=20
>         feature->argsz =3D argsz;
>=20
> -       feature->flags =3D RTE_VFIO_DEVICE_FEATURE_BUS_MASTER |
> VFIO_DEVICE_FEATURE_PROBE;
> +       feature->flags =3D VFIO_DEVICE_FEATURE_BUS_MASTER |
> + VFIO_DEVICE_FEATURE_PROBE;
>         feature->flags |=3D VFIO_DEVICE_FEATURE_SET;
> -       ret =3D ioctl(vfio_dev_fd, RTE_VFIO_DEVICE_FEATURE, feature);
> +       ret =3D ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature);
>         if (ret) {
>                 CDX_BUS_ERR("Bus Master configuring not supported for dev=
ice: %s,
> Error: %d (%s)",
>                         dev->name, errno, strerror(errno)); @@ -723,9 +69=
6,9 @@
> rte_cdx_vfio_bm_disable(struct rte_cdx_device *dev)
>                 return ret;
>         }
>=20
> -       feature->flags =3D RTE_VFIO_DEVICE_FEATURE_BUS_MASTER |
> VFIO_DEVICE_FEATURE_SET;
> +       feature->flags =3D VFIO_DEVICE_FEATURE_BUS_MASTER |
> + VFIO_DEVICE_FEATURE_SET;
>         vfio_bm_feature->op =3D VFIO_DEVICE_FEATURE_CLEAR_MASTER;
> -       ret =3D ioctl(vfio_dev_fd, RTE_VFIO_DEVICE_FEATURE, feature);
> +       ret =3D ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature);
>         if (ret < 0)
>                 CDX_BUS_ERR("BM Disable Error for device: %s, Error: %d (=
%s)",
>                         dev->name, errno, strerror(errno)); diff --git
> a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c index
> 3f041f447c..abf38a7bf6 100644
> --- a/drivers/bus/fslmc/fslmc_vfio.c
> +++ b/drivers/bus/fslmc/fslmc_vfio.c
> @@ -20,7 +20,8 @@
>  #include <dirent.h>
>  #include <sys/eventfd.h>
>  #include <ctype.h>
> -#include <linux/vfio.h>
> +
> +#include <uapi/linux/vfio.h>
>=20
>  #include <eal_export.h>
>  #include <eal_filesystem.h>
> diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
> b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
> index cffbf3c28a..18909811a1 100644
> --- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
> +++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
> @@ -22,7 +22,8 @@
>  #include <sys/epoll.h>
>  #include <sys/eventfd.h>
>  #include <sys/syscall.h>
> -#include <linux/vfio.h>
> +
> +#include <uapi/linux/vfio.h>
>=20
>  #include <eal_export.h>
>  #include <rte_mbuf.h>
> diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci=
_vfio.c
> index 46b87c7c38..ec54b7ac69 100644
> --- a/drivers/bus/pci/linux/pci_vfio.c
> +++ b/drivers/bus/pci/linux/pci_vfio.c
> @@ -11,7 +11,7 @@
>  #include <sys/mman.h>
>  #include <stdbool.h>
>=20
> -#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
>=20
>  #include <rte_log.h>
>  #include <rte_pci.h>
> diff --git a/drivers/bus/platform/platform.c
> b/drivers/bus/platform/platform.c index 149cba81a7..905b258595 100644
> --- a/drivers/bus/platform/platform.c
> +++ b/drivers/bus/platform/platform.c
> @@ -11,7 +11,7 @@
>  #include <sys/queue.h>
>  #include <unistd.h>
>=20
> -#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
>=20
>  #include <bus_driver.h>
>  #include <bus_platform_driver.h>
> diff --git a/drivers/common/qat/dev/qat_dev_gen_lce.c
> b/drivers/common/qat/dev/qat_dev_gen_lce.c
> index 466878bf76..8486dfa384 100644
> --- a/drivers/common/qat/dev/qat_dev_gen_lce.c
> +++ b/drivers/common/qat/dev/qat_dev_gen_lce.c
> @@ -4,7 +4,7 @@
>=20
>  #include <rte_pci.h>
>=20
> -#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
>=20
>  #include "qat_device.h"
>  #include "qat_qp.h"
> diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c
> b/drivers/crypto/bcmfs/bcmfs_vfio.c
> index e747bef924..5f309a6b34 100644
> --- a/drivers/crypto/bcmfs/bcmfs_vfio.c
> +++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
> @@ -7,7 +7,7 @@
>  #include <sys/mman.h>
>  #include <sys/ioctl.h>
>=20
> -#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
>=20
>  #include <rte_vfio.h>
>=20
> diff --git a/drivers/raw/ifpga/afu_pmd_n3000.c
> b/drivers/raw/ifpga/afu_pmd_n3000.c
> index ec2fdd46df..5e792ead8c 100644
> --- a/drivers/raw/ifpga/afu_pmd_n3000.c
> +++ b/drivers/raw/ifpga/afu_pmd_n3000.c
> @@ -13,7 +13,7 @@
>  #include <sys/eventfd.h>
>  #include <sys/ioctl.h>
>=20
> -#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
>=20
>  #include <rte_eal.h>
>  #include <rte_malloc.h>
> diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.=
c
> index c8e47e41c1..ce63abd275 100644
> --- a/drivers/vdpa/ifc/ifcvf_vdpa.c
> +++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
> @@ -11,7 +11,7 @@
>  #include <linux/virtio_net.h>
>  #include <stdbool.h>
>=20
> -#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
>=20
>  #include <rte_eal_paging.h>
>  #include <rte_malloc.h>
> diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
> index c1ffbd1f91..df31851cb6 100644
> --- a/drivers/vdpa/nfp/nfp_vdpa.c
> +++ b/drivers/vdpa/nfp/nfp_vdpa.c
> @@ -8,7 +8,7 @@
>  #include <sys/ioctl.h>
>  #include <unistd.h>
>=20
> -#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
>=20
>  #include <nfp_common_pci.h>
>  #include <nfp_dev.h>
> diff --git a/drivers/vdpa/sfc/sfc_vdpa_ops.c
> b/drivers/vdpa/sfc/sfc_vdpa_ops.c index 1ece47d373..dc64c4d213 100644
> --- a/drivers/vdpa/sfc/sfc_vdpa_ops.c
> +++ b/drivers/vdpa/sfc/sfc_vdpa_ops.c
> @@ -6,7 +6,7 @@
>  #include <unistd.h>
>  #include <sys/ioctl.h>
>=20
> -#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
>=20
>  #include <rte_errno.h>
>  #include <rte_malloc.h>
> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupt=
s.c
> index d1789cbda2..346a2d4c72 100644
> --- a/lib/eal/linux/eal_interrupts.c
> +++ b/lib/eal/linux/eal_interrupts.c
> @@ -15,7 +15,7 @@
>  #include <assert.h>
>  #include <stdbool.h>
>=20
> -#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
>=20
>  #include <eal_export.h>
>  #include <eal_trace_internal.h>
> diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c index
> 62f9d05e63..89a8fb0a12 100644
> --- a/lib/eal/linux/eal_vfio.c
> +++ b/lib/eal/linux/eal_vfio.c
> @@ -8,7 +8,8 @@
>  #include <unistd.h>
>  #include <sys/ioctl.h>
>  #include <dirent.h>
> -#include <linux/vfio.h>
> +
> +#include <uapi/linux/vfio.h>
>=20
>  #include <rte_errno.h>
>  #include <rte_log.h>
> --
> 2.51.0

Reviewed-by: Rosen Xu <rosen.xu@altera.com>
