Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E81DC88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 13:00:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40A9642EDF;
	Wed, 16 Sep 2026 15:00:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 396FB40E12
 for <dev@dpdk.org>; Wed, 16 Sep 2026 15:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789563653; x=1821099653;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=pJ3NyTrvjVpqcRuuo6CC9WvTpVWlZunJ6SvQ11rJ3pA=;
 b=CmfmjKl52Z7mCexyvarqGzxZsxihaIoWLadkJchccel9DeeSFrL3QFtV
 EBJCpJ1zphLmcGH5teEvcorV4/533iGLXLMdwe+/D5SJ+LT50eUl9125z
 CbpqRyo5D4N7xAK8LHyCSMJKifHqT1RN+Agw7+vEN1V5PYJpY8mzhTOoT
 nvtK22QlQX7PnxXLdJHmKrjullpyqiJO34oJ/+4HF+ZayNX3VuWJVD45H
 Rw3EIbFct8wJU35rbJpkuR9GbAugLWpi7yUMQdVapNR4o2GJycdqZAYBr
 cMpaLTXxoHByDlZ1Vu3X0zfktKNP6iznqx2FtinR/6oIp/hHNhQkZ7TEj Q==;
X-CSE-ConnectionGUID: 5ywNxsi2T2Kn4L4Q4orM5Q==
X-CSE-MsgGUID: 9Fdm01DUSme1MAHiYk+i2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107448052"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="107448052"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 06:00:52 -0700
X-CSE-ConnectionGUID: 996notFsQKuUHISaWAcArg==
X-CSE-MsgGUID: XlmOprdVQIi3ENMtxMq69A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1559917"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 06:00:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 06:00:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 06:00:51 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 06:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vb2JVQ/gZ70NNl+GuEJNgkefyLXddndQFgF3d0SRWaG9yCcoX/SlvXhVn9sQhyucWd2iZeryIYrPAsTwoBDBAjpaB3CySlmzxCdbMr0cO32rMzmiOsJGq1tQFKfVftrFN52hrMhpAncUUPC7Bpc2+bJ0R3D2PZhm2Hqq64pKRkP0SgpYqis9pjn+ERB4XLXYiwY6bpxEtU8IKWcDMOxol8/c2UhurlmSoZDMT+sxmJVmXmaZ0NuyW6hog7ByLo3X5mOY5KCFkMemVjx2stFACmNJYN+cpdtBeXCxh75iViiWZbt0AlYCuJydeJXkYmiu+74EmB0dR7EJ6rJDXYakbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/Q21jx7TAMuoXLiFcuVrUOIlWxv9yRty2T+JTjIOVM=;
 b=QBgKPVXHFuhK28zPbB2pNu1L/C7F4qp5wFpiotijb7+2WBXSFwhlhV5lSTOUEtaLuubIXVl42TVKRaXga+WXYpgXSCWH1iIitST7A18DCO9ICnJp0h0n2MfUiMT6VOhaT5WcOx/lisSUbyOhMUvQfbYGQkz3A+rsuXOdnx7t1kxs9xzJXAnpNI6mxxT4tYnBxaJ2Ke01xOmLEO7GKLCXq0tw3Gw/A7rruncsqDLurAMstAGSl9knwIq1YtdlOyPAxAY0/YUNM0hZG1hL/3ex34H8JZNhIvC+zf8AjZLACXjD5EbTAF9wEbQXs6BIiTVZrQOKPHaInv8BSKovJGE1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by PH7PR11MB6332.namprd11.prod.outlook.com (2603:10b6:510:1fc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 13:00:39 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 13:00:39 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 14/15] net/ice: enable context desc offloads for vector
 Tx
Thread-Topic: [PATCH v3 14/15] net/ice: enable context desc offloads for
 vector Tx
Thread-Index: AQHdRcdLvzu4/NFQok69l1Lv4jCy9LbRKhVQ
Date: Wed, 16 Sep 2026 13:00:39 +0000
Message-ID: <IA4PR11MB92785894E1A756E6978908798EB92@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260916103622.319874-1-bruce.richardson@intel.com>
 <20260916103622.319874-15-bruce.richardson@intel.com>
In-Reply-To: <20260916103622.319874-15-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|PH7PR11MB6332:EE_
x-ms-office365-filtering-correlation-id: e588f18f-b3d8-485f-f931-08df13f281dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|4143699003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: FL80A1SPmWmeAQ8lo1xRaNIskCRvZOKu2lARE5MS0Mz6CbXnjJ0hORCmVkJWEXX6+ZReTAMqE8gxSFYCsXDI70azNTbdul9d8V0t7b7smTe4ga+ie8FNv4XJrTiLpK92TJIjIOhsF+81dmN6Hsr6Nh+P4bUW6plgRQoGgYyY8vU+pAeMqpCgpDyjTh1ItChHIi47UO2IVe5s74yNCGWoTlCIE8ZkeSJgBN8bUzCl9dH0IHapAojISJsl0ubIvRLVUFYHQ6Dq4+LW8qpABhTqpWBsYqulT5ylk22b99InlxNdu8wkFQZICuQi0RgiMvxDoPDFhIqceWRG1aYcfC4kCYaIgAKhXujzTK7oWApReO9rchDfhkkO/91oVOVw/2OHxeS1VNLRmIOeqPLET46d8HGdzmMKiQnpoKrqWc3eTu1LrgeXV8e4bkC6aP3FwH5WVBjpLoGYhUpo82fKOwq/T0li4g4jv1JCJ0BPf6zY3Cp1M8A0u4p8g41qEOt2eTuP9ztRxUOkv0/96+y7Rwl6yiy5jLX68zYxfGtBlPSrOJZ8c7KASWxM2B6MamvjUYe0+F3zswqPhnhX52KMakYnyXreqCcFgQvhgxmRr0NGRYLCV+Bxql3aAMnXaXdr2PUFDReuIeo0CSgpit6KluaYFP46rxGB9Ka2b5OChOu6iy/q0pw4ny8/aIXx+13SFvt8LeB0J4+TzNc3cBo8rZRAsIxezs76ITr47/JKVq3riTM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CJHnLH3WirPR5gcVU1SWW5d27/Iu9pFpIfJnRFFfofCvDf9dt9AWC/g7+lYT?=
 =?us-ascii?Q?BbaiFZ7dsl0arKGLEEVnZA3TMyDJa7njZGmhY5WN625L2tbaw+ygySYPCfpD?=
 =?us-ascii?Q?uqlNKHbvF9wYpJz0eokqNpY6ASKY3qxgdwtyZ2VTRl26cO9oYOxaMAz1pO9G?=
 =?us-ascii?Q?OO2U/obTP4uXK06wNJnoI3OUwt5kTlCvz/veG3MxcC5rBxAmzBVT53bKeAu1?=
 =?us-ascii?Q?wBTEAwspFsuEvz25CIIBr0Uaz2jg8azyyHgh68OIGaoUywuMJDrbNJxwb/Xv?=
 =?us-ascii?Q?SMpAkWU4B+nlBSMdZ8CXQ83YkymvXm2DVbXPBbyyxM9MSSCGw9+tBXaOsgcE?=
 =?us-ascii?Q?x21trEg8wNaJVCZaaK+qo+u1ahmWuchER2KojOswwNMLWSVyoRqIb+GktrTE?=
 =?us-ascii?Q?YLTUHxK42kr6HAG4F3w+32zMuHIT6N1yj2+zoFzE4YdGK3ENbhp4wXIdol3f?=
 =?us-ascii?Q?yEvn7LFpqb9GQ4oxY1/0p8/pZeY13nj06PFVRHCCBSRZFB9HCdjHNEcMhAOq?=
 =?us-ascii?Q?QCCGpFbII4H6SFlenzl9yoap7PgJbyxkNomK5b2Acm8TA//B80YdFxDURc9i?=
 =?us-ascii?Q?wP07BCps+uM/dburnbebSLYmgeSIMUo/Rn3+uKrMtvPvo/dnN/7PNq11sqPo?=
 =?us-ascii?Q?agkGm2a0a5flzr+x3ADdzOmdQIj3D+s11q3lTXyKCDzVPzW4W71A/gxW/YVr?=
 =?us-ascii?Q?ffZpORF7Wb32vYfLcqdutiWkgVweb/l8Z/iPyAzFOp4uxBlBLCSVlKSwQcvG?=
 =?us-ascii?Q?Vki6f3/NAQ6obdJas4XdP7ICKu1wTs5opBEvnplexI33hkHpLK8FeLOpf/jP?=
 =?us-ascii?Q?NsWWcZlx6TqwIxQBBJnkvVYIYzzYr+q103WIqZWVTSRghqbwJNImqPBNSMPY?=
 =?us-ascii?Q?JWaeysCqY89SiQid2Q5Okwf6FaVlycycg7re5DU/Gr6j5DKwh43kTF097IXu?=
 =?us-ascii?Q?kBgbm/RDjkq9SXTJh85FMcDip1ugrBNoZuhVO4Nb+DyWYEmPDYHKah/lZl2X?=
 =?us-ascii?Q?0jjgFwcdVjqhLjZnKpBsXxvYPUcmyp3lQBg5O6zC8XMd32t09uJUccO+4y0v?=
 =?us-ascii?Q?xhwxeqVmYFl4kdxmgfZq6OkrSmHcBnm8OcmPhM76IwaUpQt+wFLmMRtJKRbT?=
 =?us-ascii?Q?3LeT40g8qOHEfQvEb37NOuqXogB9mLd2R9yygPbr3CWnmGf3U1zj9qc5AKdm?=
 =?us-ascii?Q?wNKX/OruwUiKp11txqoFzPiuUb7bORoUUGEe/N/ICigUKYxLN7YI6fU/TCHm?=
 =?us-ascii?Q?0yaUhzBWBGW2dyPSx0Pd+2rgZrnx3DvlpbPni6Jp9soKzEPx6J1XK0toMbu7?=
 =?us-ascii?Q?BQKv6PmMgBjBQ51ktn9yyocHOdE91A0HfEohTHCU1bbG1DYulR82jY+SNNod?=
 =?us-ascii?Q?X4Q3RJ0Heslxe4P6CqZ5oogHR6RPmdbNgG1Ra0omdZm3YbvAVcpQfuBWmH8I?=
 =?us-ascii?Q?/MQ5/oDN0L0XK9KPhBMxk+3PcTSWUvBXLlhpLmpnGV7kEW1krhgkaw/Rd7p/?=
 =?us-ascii?Q?TZiSoDIPIlxeA//voOLnTpatYUn1fawsGNSRp06ARILBNzEelusRInhycZjI?=
 =?us-ascii?Q?uJ3VlJBhEKuGAC67mIjuwaKZ5075A9qRr1J/mWK0bobxaFk8BvusiAk/Pn+3?=
 =?us-ascii?Q?Y8AYinD9DwJAEzzRwFZr+vWXqrdDgElWDfGTHqHVhKt4NM4OSTTFmIWTxEq7?=
 =?us-ascii?Q?EUFOmuMfZ8br3puItHJIW79BjhZUpXYmon83F5/IYW9GBMRbxSMH95MQw56m?=
 =?us-ascii?Q?DrAulfcCYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m3Daay+lu6lv2iB5cIoid0dmQCVszxWkkXCTxEhEMLedMvo2xJVMlY7fZ3zQyL+DrzWyV3PrMj4DyiL4XlyTWKiaUnvqrYg5uJWbtUKcnoamEN2E5ivv3urYQS7W8zbB5Fi35do7S+FRZd3eqPnCE1DfSWf3Oyv3YIjTwXjHyu6TDNOn9JrQtCT9/V4ScD5fnrry9MYGVPeM/zDETfZnn/Je/KZxN8MjHNz9AKZMna5D2+usNlqBNObifTcyNrkrgEuyP1QZ1VOEJsyX4y4jo9sExdJTQwDOqCJXq6Zyw+5nyQKpUzAY66psxyuJm4yG+OJHd5wQd6Wbt5pPH4VEMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e588f18f-b3d8-485f-f931-08df13f281dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 13:00:39.1263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83H1MzavQ1Kisltnf2lEaU3vG+P33HifXA0NUN96hZWknMZl8vK38zyj9QiolcEGtrGQ8sh7OfDdoMMprlEglw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6332
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

> Subject: [PATCH v3 14/15] net/ice: enable context desc offloads for vecto=
r Tx
>=20
> Use the context descriptor Tx vector paths from intel/common in ice
> driver to enable more offloads on the vector path for ice driver.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/features/ice.ini            |  8 +++---
>  doc/guides/rel_notes/release_26_11.rst      |  6 ++++
>  drivers/net/intel/ice/ice_ethdev.h          |  3 ++
>  drivers/net/intel/ice/ice_rxtx.c            | 31 ++++++++++++++++++---
>  drivers/net/intel/ice/ice_rxtx.h            | 11 ++++++++
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 24 ++++++++++++++++
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 24 ++++++++++++++++
>  7 files changed, 99 insertions(+), 8 deletions(-)
>=20
> diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/=
ice.ini
> index 893d09e9ec..8674b588ed 100644
> --- a/doc/guides/nics/features/ice.ini
> +++ b/doc/guides/nics/features/ice.ini
> @@ -13,7 +13,7 @@ Link status          =3D Y
>  Link status event    =3D Y
>  FEC                  =3D Y
>  Rx interrupt         =3D Y
> -Fast mbuf free       =3D P
> +Fast mbuf free       =3D Y
>  Free Tx mbuf on demand =3D Y
>  Queue start/stop     =3D Y
>  Burst mode info      =3D Y
> @@ -33,12 +33,12 @@ VLAN filter          =3D Y
>  Traffic manager      =3D Y
>  CRC offload          =3D Y
>  VLAN offload         =3D Y
> -QinQ offload         =3D P
> +QinQ offload         =3D Y

I think this should stay as P because the vector Rx paths
don't support QINQ strip.

>  L3 checksum offload  =3D Y
>  L4 checksum offload  =3D Y
>  Timestamp offload    =3D P
> -Inner L3 checksum    =3D P
> -Inner L4 checksum    =3D P
> +Inner L3 checksum    =3D Y
> +Inner L4 checksum    =3D Y

Both of these are OK. Although I've noticed that Inner L4 checksum
aka RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM isn't advertised
correctly in the path offload masks / rx_offload_capa so I will submit
a separate patch to fix that.

>  Packet type parsing  =3D Y
>  Timesync             =3D Y
>  Rx descriptor status =3D Y
> diff --git a/doc/guides/rel_notes/release_26_11.rst
> b/doc/guides/rel_notes/release_26_11.rst
> index 6c29513041..c1c51c62ec 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -69,6 +69,12 @@ New Features
>    Added ``fdir_buffer_size`` devarg to select the Flow Director table si=
ze
>    (``64k``, ``128k`` or ``256k``) at probe time. The default remains ``6=
4k``.
>=20

