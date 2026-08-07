Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8284C5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 10:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1F494027E;
	Fri,  7 Aug 2026 12:52:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 86D0640264
 for <dev@dpdk.org>; Fri,  7 Aug 2026 12:52:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786099922; x=1817635922;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=53x3TgfsI2PtKHJd+MCcXrLji4Wq4Gqr0HWovbWIc1o=;
 b=MB/aeZElt2Av0rTsoWf4yeucbnfmV/NNttPgAgfgNq1tcHfGS0xplpEw
 DN24rJ1WTPlS1nioKYtVdmsPvEo02kPRSicNji5dksCYcbVYzGXQisdkC
 3Vd+WuW3FSVCBl2Y1bSdwfUyTSLc9D4oBZKF+E3OGq2AlNr9FtMnqe6Yb
 xMiwsMdEbuXx7cSwBbktDDm43dB53Eduu56EIJC0dnTmXbtUGQUDI4S+z
 vZghvpckG0PvgtTLDEj2cnI+fCdL3kKE3R53pmDKSYGuKswNeaJJyiCtE
 NDc8Glr+n19PI3b/MQr3b99dN9aS+MvSk1+2Q00PcsZQcReg+eKWTH0CM w==;
X-CSE-ConnectionGUID: uhlAFq9cSTiPiZBzEorBLQ==
X-CSE-MsgGUID: D5luZOJ+Sy2fDncQKHAb8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86469341"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="86469341"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:52:01 -0700
X-CSE-ConnectionGUID: K1IAK+0lT8ueb4p864ykJg==
X-CSE-MsgGUID: xkTLZS3aQueM3OMOqyjBVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="287049600"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:52:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 03:52:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 03:52:00 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 03:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gdywo7ptrRy51/M7CUvm6iLVucbYVDNN0Hrp7PaLrpvarWx44Y0qJZ0qLX5MOKN5zFplOQKzpQyw23RdwJhbopbG4iTcLvZNttJcLJKm9x8fc8n91pNYB7rmmbPcSfqzPEG7FhjpjQyBESQmwR3fr8zYklZplKIfdoZbmNjKzZG/CNC5uTx8JexVRoSRebA2JTgWDcfn/jATeoK9N2+/JZFiusPEhwdMWNOBMs8Z6PVTkqxUm2mfW7zb0SEQ8jOYw/jH0c1/4XU7X33I3hhIN4WzIWZZXj3AWSCCUduCKfdTGvsySRz+g/cyN8KEj56WwjR7kCRpgSnQa2z4F2B90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVpYFHD0HOj6MmPmrH70r15dVm4KdsyvjokSamL8/h4=;
 b=gj5iFVdUxKIPOaLtlqBON+4RfCaYdBV13wiurYaEnZDzFo6X3gm1s0GarOGp3iJkZ3K0njI3j8O5qOA6TOrmB4WACGZYPlWannUhvJ99BDGkkBDdaaXBQUmJnswc8hRRKD9EU6cFcIU1NQIMK3M5WdyUkrA/VFjbcyPEmGrAbmDXQTjQaYS1NmeLyaXLg8JUR2W0ki4Ax97k61pazY3rYcF5DtTAGZ+9X5lyWnhvtQXFZvEBOHMcJExajICDGOCLmvABdGUbT7fuV3i98wMjKiv2U+QKLYb4L/joSpBYm0T0OuqUiWH6uzh63Rs1FaAFKfdz9AkGOyoY6UiHAVE73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DS6PR11MB9895.namprd11.prod.outlook.com (2603:10b6:8:460::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 10:51:59 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Fri, 7 Aug 2026
 10:51:52 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH 3/5] net/iavf: drain in-flight Tx before reset
Thread-Topic: [PATCH 3/5] net/iavf: drain in-flight Tx before reset
Thread-Index: AQHdJX19LbjCe/lDAEGtE7CwRggsTLaSaTCw
Date: Fri, 7 Aug 2026 10:51:52 +0000
Message-ID: <IA4PR11MB9278F463F4212529A291E3728ED12@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
 <074c789358709981d30f637e7b2715c3c92bdfca.1786004043.git.anurag.mandal@intel.com>
In-Reply-To: <074c789358709981d30f637e7b2715c3c92bdfca.1786004043.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DS6PR11MB9895:EE_
x-ms-office365-filtering-correlation-id: 1788757f-75c8-4a9b-320e-08def471e3d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|22082099003|11063799006|10067099003|4143699003|18002099003;
x-microsoft-antispam-message-info: KJtj/bswVIYAdU6LyivkKFAp6oetDF9k7V14mNm+gb7giA+rMDM43q8Y94zB9q6l37Y86yBlTD29CeyYiPcn5j8Q3C+5u0+49wOy9Bf9Jqjq3oimjAL1bbyBG9RvCKOuiOJqoX7iGG2GgL+IH2Ue3i03bARhQhViv1evvr1iMYPS5XiDdg5PQnQC65ocXETZ4wErjmWs/Dt9AUSUgg/IDZJe/4Ky9PZ+zrm7VXsbE8BuOyw1eCnqoyM+xsTwsfywUeyjRK4IApqcli8fiyETLBHf+pfkgry/zoX48CFKfn5s0tv5iI8A1sZNCAe+9NtzzOdqObsw5ZbPkao0YjvK/hchfuEttSP9ctidTPIB+GA9UJ9s2QczhwnnwurInFElZDklArt5vmB6JQJeow9mPWxJ9gMMxGqJg4oGG7IzHftYu1AsW3bizGm1t/rRod/RqFiSDuVzPb6KqJNW9wm3gB/SoY+rPBoUUQ75e9jPscGGw5faqydHnsGPYK6lKzg0EwvNL00+/RQ3s6mveMJREHjC2xWT+cc5vhq0eB12Gf4ySC56fv2N5lRdar5Zm5EJhd3ZIm+r0x7izs0HLa+AFVgTOSk9JrevMKKpeT0W6Jxlys4bkuKq0W/GP5r3lW9M7UagqdLJN+R6Ve6d1eHX128/kt2KzPKjw84AwonXqHf0w0WCiCloywOYAVH9C99g/D7+eaDlCCTKjz21ksUEAmy+NakTnndsALXNLyABzBE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(22082099003)(11063799006)(10067099003)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AvY6XQedeUSt50RxUUJNuvcSfSTt2qjaDvG7rTyXugI+hd/K2BND12tQS0wr?=
 =?us-ascii?Q?1mw+/4pheKNFBWvUKvpmWjm/h2WtyZgUD1FuvZ+eRHq1JXOaWPaS6HjLpKje?=
 =?us-ascii?Q?6vudFOwmv+3zCoKZqgWg0ykBJW3uSnJF/KFLypiSPU5bNRqVK8CzTzKQwtnG?=
 =?us-ascii?Q?NAwxxmB9S8YKR/Rbl1bFAkGvc4EVfwQfT7UuCIbfMuBGJQf9Ak70PrXh3dFi?=
 =?us-ascii?Q?QKHlB5ZnHL8nwZ4qvlmSWFPHIpF76GfTmPQbR1pYSLtbmU1+DYfz9pL2/1DS?=
 =?us-ascii?Q?BrdOndfGxfoOFci2lp2KrjKaXAxg5Vvwm8qqpKp+BnSKPsx8vXCmOLyH+4to?=
 =?us-ascii?Q?2wpBcgiypxb7YxrbPxw72aP5B3xf4Lzk3k2t60Xux0d7b5kcfK376RoMYViM?=
 =?us-ascii?Q?L9D5yWnmxMhowtidwuOY6/j4Vt724+QK3r/+PIoEf32JzT0n1asEyWJWLfT7?=
 =?us-ascii?Q?lD3xzEe9slKxHsDQym7ZwGA9ogJNqT6vxRx1Go1GPQt7hWtyTv3fJtZqYUgV?=
 =?us-ascii?Q?PaP3gbRxBF4oz7rJ2/+yBabxqZuC39nw//sGpu6/S54NBaAazuYvP1yaBTMQ?=
 =?us-ascii?Q?V/OvaXMoQ4DMvsDImwTcKCQNY2CgnF+s0oiLdCfLmd3IQ7ns50NphF6EV4Ta?=
 =?us-ascii?Q?kWhh6OrM06pHc47hzykVep8sFBY6WOP4KeEXC8JwyQDw2uVAlkLK8QUfJuEJ?=
 =?us-ascii?Q?ZcN27trcQVIGFfCpJn5eOLKozDR3tOXDdZz/mzH7kNMw6ihkt6lwPFTZ3XXs?=
 =?us-ascii?Q?sJdbnlT760+zncQQr0PiLuh2ZEljhbiNkCKpmlWvhOOlS52n6RaIAolIeDaD?=
 =?us-ascii?Q?5VxtM+TD9IXjpADmdcHf4SP5rsWg88Ga6BfyssJhEt7AO+p5VnXHrQkyXb+o?=
 =?us-ascii?Q?JK4d7MDHcmiGxtRS30cV613yurgh37JfD712E7JcmzEbqK+GLPXq7y55L/wO?=
 =?us-ascii?Q?UbT7ubyxAzW2VkaNTqPc3GUQ/4aFRlsrbi9GZEMXKxOGHAq72aNQ6URBZtF9?=
 =?us-ascii?Q?wZmCSO/GNVkvSdwIjqYzAddUNA7VtOTTdo0EzXPMV/lvIwv7zF/b3JjMLijs?=
 =?us-ascii?Q?Qeh+rmzVjrDiAfQoWBjBCUy10+gc3th+3XFgnpGLUkZD9VqyKVOT8p+hd922?=
 =?us-ascii?Q?YylIc9KlXOiSKTy0CLskXjAhLIoydLfkNhSL46cxwWU6iiKyFu+zKRPlLtIZ?=
 =?us-ascii?Q?stAY/di5XcM/HSMNlgbFdHYuSymfieV87gous4PnilgjZ5R762KPHXvCp8WW?=
 =?us-ascii?Q?AmjOfRaD1DxXp9ryzH4eV3smzZCbYpaBLSiywC0GtBORmPIozKjnR2r3umLo?=
 =?us-ascii?Q?j+x8x49RHlWH//vQv5T9xcpM5GebUJ+epPDqpB9vZLlcvplTOqIh7zrcm01/?=
 =?us-ascii?Q?v4hj0lJsTZhtUPX2T5Z8IOfr+PyDheU+jMDHTecP9hFXl+byxdiYBFjQ3xsZ?=
 =?us-ascii?Q?fmfHqil/pdWicDEpJ6P0wlioFiagjKYk8TYweEWiUNTkNdxpYBNpmxA1Pk/Z?=
 =?us-ascii?Q?7Dnfh2fUiBaJydTDuce+NLxY8CQ3l29efU6CO+579qMD8MHMJIbuGpi6dK3G?=
 =?us-ascii?Q?S1WB1p/b3pgaZzCl+SJ/jZFFiVOg2Ovp+YJGKHck1PlTycTp42KILNxl9D6Z?=
 =?us-ascii?Q?u6r11z2Ba3MdqGphHB8/5o7aXL5jQKGnKYxJK5kc6UWndC2OBSA/4w7WU5uh?=
 =?us-ascii?Q?7m8UbuQbVeSHIG7FiauWtzi4WC36GAkGGzM2J2Bq7xxUrMC3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D08hUdZaBc3mvRccBurD6GVlKhqH4Uqd6MPVBe4Dc+ApVoSBPZMyV3DqqgTIeYN7J/oO4oKjT9L23bDTBymcm4au7fjDQIxYyT/JgERTSNLBlgczXFDz1Gz/mnwG5Gi/QU3qFudUtguTNFSTSv8Vyn6s7UBJL80Kxp/CZ6N3Zzjy1/o1J5+RmNiVOtfcAKOuM4oZJBPNh+o24jdzowNpZ2fJpNOyit6Nmj+stt2DtDMvCuFHJhrd81ZosIKjSCQwCNmwJUHRof6S5GhuAeZvx0Z04/WMIqS8r6dRF218T+om/WO/QK0c07RknMmANOCyffOfcohRgBIi+cDJUP9E1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1788757f-75c8-4a9b-320e-08def471e3d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 10:51:52.4055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThdgKDx0I9SROjIvXgMCuaPVeBE5cEr7miEnIN/aynZIPfoQc0oFENxNf84dFmTuaOYvle95u/Oc/L9EPOhN3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB9895
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
> Sent: 06 August 2026 09:26
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Loftus, Ciara <ciara.loftus@intel.com>;
> Mandal, Anurag <anurag.mandal@intel.com>
> Subject: [PATCH 3/5] net/iavf: drain in-flight Tx before reset
>=20
> On a link-down or impending PF reset, in-flight Tx descriptors
> were left pending when the queues were torn down, which could
> trigger Malicious Driver Detection (MDD) events and
> leak descriptors.
>=20
> Added iavf_dev_tx_drain() to let already-posted Tx bursts
> complete and flush the rings within a bounded budget,
> and call it on link-down and reset-impending events
> before teardown, preventing MDD events and descriptor leaks.
> The drain selects the cleanup routine that matches the
> active Tx path: the scalar path uses ci_tx_xmit_cleanup(),
> while the vector and CTX paths use ci_tx_free_bufs_vec().
> This matters because the scalar and vector paths track
> their software rings differently
> (ci_tx_entry vs ci_tx_entry_vec) and using the scalar
> routine on a vector queue would walk the wrong ring
> and free the wrong mbufs.

I think " The drain selects the cleanup routine that matches the
active Tx path" is sufficient detail, you can clip the rest out.

>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx.c  | 104 ++++++++++++++++++++++++++++
>  drivers/net/intel/iavf/iavf_rxtx.h  |   6 ++
>  drivers/net/intel/iavf/iavf_vchnl.c |   7 ++
>  3 files changed, 117 insertions(+)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> index 4f2ffe6188..931bb8420d 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -32,6 +32,7 @@
>=20
>  #include "iavf.h"
>  #include "iavf_rxtx.h"
> +#include "iavf_rxtx_vec_common.h"
>  #include "iavf_ipsec_crypto.h"
>  #include "rte_pmd_iavf.h"
>=20
> @@ -4025,6 +4026,109 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue
> *txq,
>  	return (int)pkt_cnt;
>  }
>=20
> +/*
> + * Reclaim completed Tx descriptors for a single queue using the cleanup
> + * routine that matches the active Tx path.

> + * The scalar and vector paths track their software rings differently
> + * (ci_tx_entry vs ci_tx_entry_vec) and keep separate completion
> + * bookkeeping, so using the scalar routine on a vector queue
> + * (or vice versa) would free the wrong mbufs.

I think the above sentence can be removed (verbose).

> + * Returns true if any descriptors were reclaimed.
> + */
> +static bool
> +iavf_tx_drain_cleanup(struct ci_tx_queue *txq,
> +		      enum iavf_tx_func_type tx_func_type)
> +{
> +	switch (tx_func_type) {
> +	case IAVF_TX_AVX2_CTX:
> +	case IAVF_TX_AVX2_CTX_OFFLOAD:
> +	case IAVF_TX_AVX512_CTX:
> +	case IAVF_TX_AVX512_CTX_OFFLOAD:
> +		return ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true) !=3D 0;
> +	case IAVF_TX_NEON:
> +	case IAVF_TX_AVX2:
> +	case IAVF_TX_AVX2_OFFLOAD:
> +	case IAVF_TX_AVX512:
> +	case IAVF_TX_AVX512_OFFLOAD:
> +		return ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, false) !=3D 0;
> +	case IAVF_TX_DEFAULT:
> +	default:
> +		return ci_tx_xmit_cleanup(txq) =3D=3D 0;
> +	}
> +}
> +

[snip]

>  	/*
> @@ -341,6 +343,8 @@ iavf_read_msg_from_pf(struct iavf_adapter
> *adapter, uint16_t buf_len,
>  			if (!vf->vf_reset) {
>  				vf->vf_reset =3D true;
>  				iavf_set_no_poll(adapter, false);
> +				if (adapter->devargs.no_poll_on_link_down)
> +					iavf_dev_tx_drain(vf->eth_dev);
>  				iavf_dev_event_post(vf->eth_dev,
>  					RTE_ETH_EVENT_INTR_RESET,
>  					NULL, 0);
> @@ -579,6 +583,9 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev,
> uint8_t *msg,
>  		if (!vf->vf_reset) {
>  			vf->vf_reset =3D true;
>  			iavf_set_no_poll(adapter, false);
> +			iavf_dev_watchdog_enable(adapter);

Is this enabling of the watchdog intended?

> +			if (adapter->devargs.no_poll_on_link_down)
> +				iavf_dev_tx_drain(dev);
>  			iavf_dev_event_post(dev,
> RTE_ETH_EVENT_INTR_RESET,
>  				NULL, 0);
>  		}
> --
> 2.34.1

