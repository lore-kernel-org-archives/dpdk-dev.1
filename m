Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7780FC0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 09:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84EE240281;
	Fri, 31 Jan 2025 10:03:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id DD897400D7
 for <dev@dpdk.org>; Fri, 31 Jan 2025 10:03:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738314201; x=1769850201;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=FxmIMN056AXfMaiYtVOJhDIeOsPrSdix72xP8/3c9fg=;
 b=EaCLybPPwAK1Rfld45QVX5MUlMI+Bvl7NwdJE8bCWdEWBBDNbfGx3xEu
 YMUlsdxS7UdprndHUs7V2PMqjwLFy83qnjN5N4MNe+mTVgBme5nnm3xK2
 m5nic6IYlmuu7B7lKPNxX+IfixCKLrj4WfpdI1h+1yUohMPKNSQCfiehm
 kng297OKw35eobYNAW7B1gNqKCef5yxn3Mv4VR1I/Arc7sCZPYLAgeSfe
 W1IR29dqNfhJzp1ZVeeruq0NRd/1lhMjV0RyP+2jEidi/yEtZji6S+qVi
 0BEkCpzgv6qhdOvJZbn6UcdYHN6IbFsi7xjF87vT2VmGXEAXYKNiuOBKe Q==;
X-CSE-ConnectionGUID: cjr9RWo5ThmPt9XOaIsmnA==
X-CSE-MsgGUID: OJNyiicuSsqOcHs323wxHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="56425936"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; d="scan'208";a="56425936"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 01:03:19 -0800
X-CSE-ConnectionGUID: 7LGgjjtgT1S1tN6ONarrrA==
X-CSE-MsgGUID: fMQlwvNWRpaOWx79XNVhSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; d="scan'208";a="114579148"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Jan 2025 01:03:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 01:03:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 01:03:19 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 01:03:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnkQkRaMxhutv9YsM8xP8DsBGA7D6yn2KYU6cZHHfky4Dk5WY5hlB4mm1zla3Lp/3f71qpiHBizNrJ6uTd9Lu3/Y5g9LNMmmupWMRG+NghSDXIBuS7hM2Y9zZuYy09aKa5Ankp9bMhcQtxT2iDSktZihOMgqi7AlMvGc8CvIkmif0dQSWcDqVqADMiPoCG9svqmYHeYYTENnpwxTaVQ5z1GcvXTzuGpSA+AgOAEsvsvHwy5iCtb74AbjRomLmJ0rbvCfgSyYk3c7LfDuwSaEDazjXN+IaJl/Ml2qt+/Jw4h+A23Ykl/HpEt+AbS0E/eLyVX6RbitweLkWvpQkTcIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V+PrShMUl8jEle8zbRKlsj8Wda6Oe2DIgXl3jJFWBk=;
 b=T77XM/WkdbFxgtfgTMUFaJJgXl+ACaTkjf5Ho/wIlzFT4YZON3CtS2ficq8UBcAb8un5MnngeQWq3wd/Q3ro5KxWKEqKXQLdXSitT9FVKYyIv5oG8SR2cw/wsejIogb/Y0U3v+EHsWvzCbI6k0WWKyDkn1D6ZFGSR5hnhHVTckyKUNdAPYWOG81wHJp5KwINw7lWTRXUBcP4VWl53wMHjng959wcLcwQu6ksCocPQDLFCbGessUD61FATzGr4j0xcChg2scMQQCy5n8LCbusbpnRdJnE7lTgg7A4b6lhFj5FmRqWfyZA1c+OrUXALEKAyaxz2M8jyyQkozUCqCCbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22)
 by CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 09:03:16 +0000
Received: from DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::60c9:10e5:60f0:13a1]) by DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::60c9:10e5:60f0:13a1%4]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 09:03:16 +0000
From: "Xu, Rosen" <rosen.xu@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [RFC 7/7] raw/ifpga: use EAL version of TAILQ_FOREACH_SAFE
Thread-Topic: [RFC 7/7] raw/ifpga: use EAL version of TAILQ_FOREACH_SAFE
Thread-Index: AQHbcOaT19u1PcnBfEa78kiVMCT86LMwm/SQ
Date: Fri, 31 Jan 2025 09:03:16 +0000
Message-ID: <DM4PR11MB7757647941F165C69798313F89E82@DM4PR11MB7757.namprd11.prod.outlook.com>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250127180842.97907-8-stephen@networkplumber.org>
In-Reply-To: <20250127180842.97907-8-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB7757:EE_|CY8PR11MB7688:EE_
x-ms-office365-filtering-correlation-id: e1873704-9e2f-437d-b457-08dd41d6197f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rRMSMlYDh356A/2DeOSTury8mBkgl03roofEOFrDFKpdo9Q3wHkxntNDKGN1?=
 =?us-ascii?Q?9uSa967lwV7qAovr7dY2IRcvXqtG2V8H0xYreZu7LfxmoDqvTIDZcWL6yJsC?=
 =?us-ascii?Q?rfGOo6EuuarSdjwRxcK1nSWT+XFwTWCwpQhjfgJcreO7fZpVMfdunwlDqYX+?=
 =?us-ascii?Q?ElfQ4L+b7QB/9WYq38W0YN6rE1W1n3N4M3F1fUFz4Bh56cA4A4xtoedwYEz6?=
 =?us-ascii?Q?PapMckPIMj/XrkCIfh6jlu0oGJWmvXf+isubdTpVb+jusfhl7KG1FcHKGMln?=
 =?us-ascii?Q?yKWI86idwVUgGC9bqbVPv4JHqt/0W4ZQxMJmWB1gF/mtdBnjaabyYsiHEOtU?=
 =?us-ascii?Q?pLRQLWpDnhDq5++T5tk4/U5lkXpOCfptIeUWp7r6DrH8iMkQMH2mp+P+waEk?=
 =?us-ascii?Q?9EUE9SodFW0i0J8HwDZObboVtczuzK/ejmxk4qRw5hwO7O4DjUwAleYNy/8F?=
 =?us-ascii?Q?mrwe4KIfxCOwMPF6at1NQDKSHEoazC/6Q9GCRkNvHEGyoWE+uSXunQNwahRc?=
 =?us-ascii?Q?FXq5x0PyWM1YlR19PA3PMyubKFS8aDut/4dFEoKfn4tMWgXC+NrIKV3qlUcB?=
 =?us-ascii?Q?PBBtfrttgjF20PZ9khgueYxC66zJxCw+RoExAGTdofPoVOsnqkZfOhR1p1ac?=
 =?us-ascii?Q?9VT6ymuX9iA58C+qPvbOWJe5R0y8XtHZDeIi8KCInT04RZkuWG2G8jsu9h8c?=
 =?us-ascii?Q?htyAufWnmEW70gm1/2hxBCAzc9671JDpeIQ47NCAxXlUvmZXnqdMY9dl8Lo3?=
 =?us-ascii?Q?0VS6ma4/GhKGYTELYcDYB1mUpmBMDmEXttPF9B+eI2P9x2+5av7/I6QFzIYz?=
 =?us-ascii?Q?3SgSQ3rU1eFylFVitGxMZfzd2aWtxAHWxxeYjMtxnvhASnEZz0cmY3d4Eq67?=
 =?us-ascii?Q?iIif0yuaazG+poAj2Sol0xorij9Hp+9P1O2gXNnB+0bF5vsX7zjAq1tn2tWf?=
 =?us-ascii?Q?UchP+kVzcWyrzuY8tSAz3R7q2WDK5+rW1G7f/6JbGPN9YjaxBwhb0RVqAZLm?=
 =?us-ascii?Q?/sIII9N2TqW60oxsMnpPT15ynHbO4EWjO0fZazsArXxtL6RsJZkBhBQBOckR?=
 =?us-ascii?Q?pVlMpBE6xvzpLbSeUS3oW/Ik30OTuvhPS7igJzV0UY78Klrl1yRiwER7XNTo?=
 =?us-ascii?Q?tHTz8i3soA1S6lCh8NhtjYYHxX+eanx5v3wmq2qn6adx5IXEXUmzqhcJndUx?=
 =?us-ascii?Q?ZSj2LsgtOjpdD40NNNfNOAAM5Vaomcl0F6pb1WaHNQKdThzK2a/Rry6ZD5QP?=
 =?us-ascii?Q?yeBGc5GpKdFKY5MPvbYOmnQYLPfcDakup9nanaxLhdR0uzcQWu6s0g+TtLzn?=
 =?us-ascii?Q?PvNU68Hs8pnKdnmwi50skOnLBIOO6UJP1kXWSaU9n+D4p6VgLT5Mfw4kGf67?=
 =?us-ascii?Q?jSJVcdI0Km8RL2NhR407dTsXmZp6x0WZEbLLEFvUuvCxqogKFYgVJqY0aTPc?=
 =?us-ascii?Q?vS8N96qVvG0VIkJZK6JIcoX0Hqm+X/ML?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7757.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d/ZeQ3XQoXTJVKJYGtZq1BN/dI9fQitBO1AZZn9nu0J1PeoLCr44+R0iSb8a?=
 =?us-ascii?Q?taDZUsFxBxSmPJqDR4x1JiVHwes1MdCupV1/7mgEqcE9+OhXH+iD2fSB1dUQ?=
 =?us-ascii?Q?5Vw855UardkPNcEeCRtKe/bKlv/8+ab1jjhyLx9WvDG1/PdSAwfytg2Of0fw?=
 =?us-ascii?Q?4Sv3AfDzJyKM/llgff9QEcgZ/TgmIKQ7FFuuUCz7M7Rda21m3q0YJIY0v2Df?=
 =?us-ascii?Q?k+CNs2mB7/e1Lgta89Rqau1Ge5NCDm8cdnZzv19rpEMGe6jOS2g2wUlpp3Se?=
 =?us-ascii?Q?mPVU1k69yPAziMPxA7iNxVwGWzosnj4828wqx/uvtw+iNSVbr5X/79MZkBtj?=
 =?us-ascii?Q?Tkedj3gwaWMrVGHDsgR2cuBPsdNlezv2UAGsCH2XstxQPPCkOKOTvdM1Dvx5?=
 =?us-ascii?Q?kY8vBHSsxobsydjYnEQDS0wICyYFTX4z+83n6KGEj2/k3MQD92/3eQli2UBM?=
 =?us-ascii?Q?HZBWG7qK+f8+8CV4f9ILjRwYhir5GgQhXDxlMiZbFG1o5B+JL1jWOZReszL1?=
 =?us-ascii?Q?8lL1qQkXnE2E4pxB2dz/usyOpGkGWlEuzcNOIn5/CwDbElIdq1D2DZRIFkH3?=
 =?us-ascii?Q?wd0WV11d8BOl3EMhd78YYoIJ/cXJSMR+ylAPxYFc+p63teL9gt50cP/l07d9?=
 =?us-ascii?Q?FiDFQfYlEvSfBbXBi1o4L4UOpxLPIZKsCaf3DmUcjeCWFoiQWtL5DJ0arE64?=
 =?us-ascii?Q?1n09T4iM+zjb67+ZXn5No2SGZ73PysOXdB43nQYNliqcHeX3N4PvkZW/7qgB?=
 =?us-ascii?Q?E+6Dw4Gh6ttR7ifdcvSEBO7/LwSVjOjyPUDwYGth0heq8GaIdGhCJb2e7b35?=
 =?us-ascii?Q?/Hvuic6cBYQOieKq3E/liKkKzxVLiGrwmlAgaaJPnNs7myV24gwSUOdhhZm3?=
 =?us-ascii?Q?j15d0ik3D2TQV2iSBfc3uNC8fZ7rGMiPFoJDtDJp2fr38O3IcrPoDA8LLHW7?=
 =?us-ascii?Q?8P7gTouc0st9NVs08juu0NneSZedcOioriDRtK/M6cbuD4kYuhcCwaz8yLrR?=
 =?us-ascii?Q?UcFseCte9cUkiaDGRe/yhGV1l5b+hxAUN5wA2FkBXql1CXvR0RApM/pZn4Fu?=
 =?us-ascii?Q?wv3oXgtJrWHs5KetjihONJju6MGZycKP9F51QI80t31X5Cde4zCjvSywBRFn?=
 =?us-ascii?Q?mEnox+3A58e4+akJ6goBOBK0JvDcfWyxLV2Lfx/yoIyHPNwaZy3eDQ9hCOpc?=
 =?us-ascii?Q?le27s9RQX1FpjrRePuiyqHJKEs2V02a7CohsMquWGUhavKO7Be2s7kqNgNBK?=
 =?us-ascii?Q?B9ugfuOdAseJer7CM7QYKX9B7Uty6UEIqDyYdmSocMIuRJLwqqK6DVs3GWbJ?=
 =?us-ascii?Q?XnBMT8pcKUcEBEBKfOctYQee6+ZcIE2gNqzQ9It3b6VwAd5N2M/NCCxRMWzL?=
 =?us-ascii?Q?CO72DQmgDiBufOPjxyRnojRClC0dvE06lSZAGhwdEuX0PeAMSLZTQpf8ih0i?=
 =?us-ascii?Q?R2WkrSgkhtKKEk+Zww7KscgpyzKharkVYB0T8Bx6LB81bbDv99QXZTqmyDn0?=
 =?us-ascii?Q?v70KAgexzObJKz2KROZnxk5RQmaBPqEw2eHgAuFafqDbZD+RzXcEoo8Yfo5v?=
 =?us-ascii?Q?exUSzU6Z5jLpnC+tmZU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7757.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1873704-9e2f-437d-b457-08dd41d6197f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 09:03:16.2860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bt4f9kyUO/Y1A8i8JIagP/2hws7sbqqV/0jc4Yxze5bc/5YH9ltfELR/jnxLW0uQ6Qj1b50Ne3gnA4WyUqxgBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7688
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

Hi,

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, January 28, 2025 2:04 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Xu, Rosen
> <rosen.xu@intel.com>
> Subject: [RFC 7/7] raw/ifpga: use EAL version of TAILQ_FOREACH_SAFE
>=20
> Prefer the EAL version over local version of macro.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/raw/ifpga/base/opae_osdep.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/raw/ifpga/base/opae_osdep.h
> b/drivers/raw/ifpga/base/opae_osdep.h
> index e35a21c80e..b483d00a54 100644
> --- a/drivers/raw/ifpga/base/opae_osdep.h
> +++ b/drivers/raw/ifpga/base/opae_osdep.h
> @@ -11,6 +11,7 @@
>=20
>  #ifdef RTE_LIB_EAL
>  #include "osdep_rte/osdep_generic.h"
> +#include <rte_queue.h>
>  #else
>  #include "osdep_raw/osdep_generic.h"
>  #endif
> --
> 2.45.2
Reviewed-by: Rosen Xu <rosen.xu@intel.com>
