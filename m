Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901BFC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 14:31:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D914402B3;
	Thu,  7 Aug 2025 16:31:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8319140270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 16:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754577078; x=1786113078;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PvK+7AwyP5E5ySKAg/CgUFRhFU2LxPyfKGxFM5WiyyY=;
 b=mOk79rqYondFuoR4d26Q9zI9hQE2aA+Kydz1/73AmbmckDG1gr0RQnla
 Sg86ur7vyWm0snRcT/kDIxXTdh8qRFrNgZUIw5ahdhq20L2fFJOaXYL5I
 qVby9bCR/2KdrjkvXBfQkaZMcgPRT8Jp0eiq3oucNTc89Gujgk/f7bHb8
 UkzY0UFfaPEsGXJpad061pt+yOqhjoXZN/WqB+N/MTdPGZ24aFW4akSv/
 4NXY0PetM/BqWmWaHfKYx9jyhS5Ins2p3HBpn2GAMnojDM94L/YNpy2SK
 /inGovuMTFbrdnGvmLbUmCZr+bDRFsWRW1KfhT0SbPFfRDrhpDAJ9AjYG Q==;
X-CSE-ConnectionGUID: XezQxvw0TY2hqAy2KuiknQ==
X-CSE-MsgGUID: 59wANrcSSKWGA9g7tJObwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67504906"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="67504906"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 07:31:17 -0700
X-CSE-ConnectionGUID: fIjYL3twQICq40Kg5PsUiQ==
X-CSE-MsgGUID: +IwVDZpbQOyaoVBbXNM+Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="170338955"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 07:31:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 07:31:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 07:31:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.47)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 7 Aug 2025 07:31:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYmDUlWxoqsNyXcxWK2EdrR4rQ6I4zeNBPUFCwsAZ4yw8yMNjH+TTXosJ+se0rrLiBed1JsvTSw81fEPBDyRVSuHKmTtnnMt0+/U6XUk2WyFdxVSJXQ9qapnorhVZCH/K6VSvtTmOjwgsa1pXvbGqj0tyDkEfeD8XF7VSuhw4QdLf144ULViBFuw20XQ7hvpVOhibFMjL6PQHsAw1tb1uyOk6XtofWtXadMQdIgveO/zyMozBeABoIGqHZCnm7xthCRUvkSzVRx49/sqv7YDyCKbKDvumzLQ6Y00xNgylvpCw5RCEaRrEKeVXKFnu7JruZCTSbDMyVSyqC9BVPWORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTnnXO/Fkz/fPLfx+1uYJ+kaIXwVg2K8j4BInuKr0mg=;
 b=r41WSFtAIUJVUVElb49+ak5akw4gmTI4FUmy1h7w03lDOpkbGdUczQf/g+labW2Mr2mjwFbElbvvX5MZYKYXhXbeBt9FG+8Gc+NASYc0ExIjrAXC/j9lYeEuZO5Xk1/WQO+Fz/LLeyqU4lCmKnhzayldEKxqA4CI5gk2HNjo7sVt9Zf3J5P+FPsUZeuEUtuJd+tHatZ/Ff6mlvEKszYebOPrtdboqdCteVwXQl4ArjmX/kqLjZdGxfp9GdAQOxvg5yFiBAy6AyWhVpAeZ/+rd2InOv4r8QTReaxkojQQ8zuiSnSBwvy5r9Iqircjg73ibJ/oMHjYno2wCuZK8ZgRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DM6PR11MB4580.namprd11.prod.outlook.com
 (2603:10b6:5:2af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 14:31:12 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 14:31:12 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH v2] net/intel: fix assumption about tag placement order
Thread-Topic: [PATCH v2] net/intel: fix assumption about tag placement order
Thread-Index: AQHb9/q+ipMir33pY0CDkksJ1wZb9LRXX7Vw
Date: Thu, 7 Aug 2025 14:31:11 +0000
Message-ID: <DM3PPF7D18F34A1F6C722854325BC750B9C8E2CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250716173922.688476-1-bruce.richardson@intel.com>
 <20250718154312.1716432-1-bruce.richardson@intel.com>
In-Reply-To: <20250718154312.1716432-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DM6PR11MB4580:EE_
x-ms-office365-filtering-correlation-id: c6949ce5-5fbb-4c1c-9cff-08ddd5bf0ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?knHpCc0Fipj5qAFLC5bI+GrtJThlgWOOpuhHvVylz8pzUdw68kr1LsoABhkM?=
 =?us-ascii?Q?JHoOCvkhuCg7MNHgzfJuezqgtkRQZw0SXhNtcBdlidXeQ2gwSU+HlBOfG6bE?=
 =?us-ascii?Q?1UkMSXv+GTyDOGz7WCi+iNt6+Opcxip0s13342MCyT7RAxS3U1dB85EF4QHp?=
 =?us-ascii?Q?U2LqLn7qFlIEOS+jtCmieLE1c3uyjIEnOFSy2OmLKl5BHc+oJ8C7wmDtYslZ?=
 =?us-ascii?Q?eMRikSPzIKKgY6ihVt8kWi4+QMjybx/Oz95dO9agshvGfqi3ZHcDiK1P5rcQ?=
 =?us-ascii?Q?9OSHx/286ZFqXsfJhxesL3DthDTSyTkxECkUNm79l2Z3bSg5zK8aLmj7zU/T?=
 =?us-ascii?Q?H1tqJzdM71AT3DhBiHxngV0J81R+ZXP5urTOwYvJqo5KYzH6AFUzZiZegbPH?=
 =?us-ascii?Q?vs34Hphaa+JkdkmfAuFeBSY132YU5yPdh/zE53wYT1dTs81UvH34p0JDcahA?=
 =?us-ascii?Q?4lNksnxN+mg7bifo9A3ygN2jmKhPlicnN8ZGIsOExrY1mUhXzsfKcjeFNr/D?=
 =?us-ascii?Q?nkLi5laJsU/ASNPHnMlHrMBQIHXiVE77dKhLn5t1/kcONBd1uxLZl2B/OeO2?=
 =?us-ascii?Q?Wtzw2mZ9HbMrld8YrFdB5CZFd0pv09dr9iUYXsgMxk1onTctTlfWur2aUnRs?=
 =?us-ascii?Q?O/fYxmmQKSDUZYG5AT6j6mSp0mZkt/Xr8EZ+fSY8/15a/73/q5Nk2DG1RRH4?=
 =?us-ascii?Q?fhCk1hsvDSCla0V43wq6JZD/Frd3IMjFbrmS6XyF698GTpYdcZJp/wKVXiqp?=
 =?us-ascii?Q?kbRDbqtO06SszTf0FAe0GD3pidDfJtYrcjkCQ2ZrMOD3Rq/oAO1dpjA5dxrs?=
 =?us-ascii?Q?97J74FUwVOnvLZlsXROPNMSnxuqHvY5Dt4FHslSb6Diao578PvLPVGt0afUa?=
 =?us-ascii?Q?dSgzg//9jdC4yhVg7qtYe0/TPil9QkhvS7BoqAD2Ipef/JKrkwc1T6teLtb1?=
 =?us-ascii?Q?A4ZclVJjtJ2Pm9NTBoDLFLfhNaUDEai1sVHmlbc1nXdxEcikEp6OYa19BhnP?=
 =?us-ascii?Q?nv4jfrbAAcwceejhRLhUzEM8rdvvY2oOC8ccMv5tOMwXzwTFmIuat4coJyH1?=
 =?us-ascii?Q?zHfZckleQwnUo94ApuoOhFcfNz8KM4T399lHjCmR45T5owvwb2vNV86S6OT1?=
 =?us-ascii?Q?Ko0xfLOx84CzeRqzDL+sGcYDFlKKpek5nmingbtuMXfrKepSZDimXX9XcKXn?=
 =?us-ascii?Q?gOu2r9G5y2ijF4zoLcDW7m8M1RUtKsRHGWhDePFDE4RRBj9gHI7A/UrJ6O6u?=
 =?us-ascii?Q?HtATjDBI98E0zIBrDkq6GBpSnayAlB1/N7QlEsspKisAlnDjSpIPYaZhTJFb?=
 =?us-ascii?Q?7UZMorctsWcz/RN61ao0TK5WU1Bs8eqXcx8g7dOUKqcnYeRTFps48KGHanhx?=
 =?us-ascii?Q?deQVxrNjQzReecU0gAjt9EF7DpRkCg4uPBuvMdjFFC4+NGGrmZI7yr+X60+c?=
 =?us-ascii?Q?X0zsrGAWS+EETyJ6UO+CNTBKHRMr5IVtA8M0aZGRpPHY1y+PIMXxiB0v9/Ll?=
 =?us-ascii?Q?ESciSOqNnLIQt7Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9IR8dxkC0E00LZn+qKj4Oitj8JFRJ0ItEB9CDR1pGCrExI9B8c187SHy6kQF?=
 =?us-ascii?Q?kYW/tj3G6mDlFiAdpQJ5QX6p1kMVT4vsa5xZofszBAEijpemQRe7yfbJdlt2?=
 =?us-ascii?Q?5j0ZznQvimklEYaANBkyWM+Y4qeBuARJjpBeeBLwj8JA9FCV5OStUs5Hh+id?=
 =?us-ascii?Q?cpkvIPbBQiTbKJBhUp93ygCVk11z7aCIYYL8vGKeXImMc7i9td8hYOuEzH3i?=
 =?us-ascii?Q?Udtr0pWBd1uK6TXYWDCF5g1pq7ClBRtyTIfQORok5cNkL9cTpkZ1t1LaaOJ2?=
 =?us-ascii?Q?P127QLM2cdKnnPSWi7ngMTDx2rP5CfdiAkYF1F+blimGl3fR47bJCRSiJ4St?=
 =?us-ascii?Q?9mmKDj5oXGUq0ymhqot2dWHXoQgq8tRL3wZvfwf1v1pgU7WPDIVb8+OgZiqt?=
 =?us-ascii?Q?HJ7Ghd2QbamT5RkN/TcE1hhOUPrdIxtnVtNSj05H8ZexR4Lo8pyCscDf0fy2?=
 =?us-ascii?Q?9TjzjqW1JESuJ2bi92UkuoytqEEgfQYhh1cKaR1KQxWdYeGsjKtKNeGtsvbH?=
 =?us-ascii?Q?ajQjfypmz6RqNlrKl2Q94TloOvQx2ow8Cb6lnCGTI8T4ww88ohlpaMOWWHMY?=
 =?us-ascii?Q?Mx1SrsiPL5GO2XL0n0gr7dySAhZ8tBhKlcep48Qzk4mTfxW/i/fBhgf+SW4K?=
 =?us-ascii?Q?UdO8DVelOgjRZsVqlW+gxQz83Rg3Oxj0at+73wvqJKLqgtom74oeAQrCWaJh?=
 =?us-ascii?Q?5uoOXCKQ2ay/gJogWO8ycZqzOrt0YnxOrnnSHhZ2NZ/q/SAXbcAS+TgUzvr9?=
 =?us-ascii?Q?Fcg9WJgaaJ5JfBVw4h8zvx3w3feIgLEM66xCdJ2w2u+RgYRWK3yJwL1cqams?=
 =?us-ascii?Q?V3N/Cpa/LfmDvu771CKgC/INYPoSnWTYhXqWPostnKxsyjERMaCHxVuZ8y5E?=
 =?us-ascii?Q?COIQS4dXftbqypiCGHIs0IxGfg8qdLlf77rKEzU+C/6aqzToJyQh1SaS1ye6?=
 =?us-ascii?Q?r9i8jF163+AA58Mh4TZhbidD4o6m63AThZwrsqCbVvjdGyPllgYMK4EgSkzF?=
 =?us-ascii?Q?Ff7JrIcQkFpzjKYLjlMuZxOI68iSiIdyV0g1CQxyVEhEov6RLokNt9g7WIlI?=
 =?us-ascii?Q?5LJkC/bYWd+QziZDxhk65FwlujAo/fbNaDg05HBGZHG+vWkcx7Lja+1/aERb?=
 =?us-ascii?Q?914sKix1aM0izQQq8xMDrl3AtENxvS20RoYBwk9GetGR8JhDtRt9a41dblne?=
 =?us-ascii?Q?8D/1jT4LQ4MPr+1oyz2Kcgbn6Cztbq6uUlawfhE/q/7afVPoNJetwNs4s+DU?=
 =?us-ascii?Q?aEHCcndrslZ/WRZzE0zxKTSpYEOZQPM8I9ZBmIlbLIV32B87Jn9XujgzO7ID?=
 =?us-ascii?Q?DX/rfhT6HcTnGm60OEZWRYl4u5hYJ+XMK+h6nxHEJ0EMGwLa6HVGRAuHi0Km?=
 =?us-ascii?Q?YJGS/gloPw+w/Kg3EVApUL1Tv4TbkcIgXl+gSQLY1+I0+mJVycua8L3S3anO?=
 =?us-ascii?Q?/HL0bDt64VgBOYYM/5EzjDuWJ5RyN7bJqLrCYd1rLYV5TadTGuf+DNUwez1m?=
 =?us-ascii?Q?XklPZzKkxlMQnWBnUFA/8d+w2Ro49bBJuoo81aOTF/CDewvSjnwrtTrjifY9?=
 =?us-ascii?Q?MNI/GQpXBLpUjPB/O1/bUVaQDEGpf+eEPI7cz4hjaN+bHsxH3RN8z10wcCUZ?=
 =?us-ascii?Q?kQNHgHwIvmm2vgmLS1GTjiQeHsXcq7+54ftS//M5aqaU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6949ce5-5fbb-4c1c-9cff-08ddd5bf0ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 14:31:12.0113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6E2Ggd+wOuH5d58ZwPjlB32cWmlMetLgS1Gz4Jp76lFW2AvmmTf7fUdIqE9pVtzEs2GsZyOppOwI1ZyDUwDBw==
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

>=20
> The specific placement of outer/inner VLAN tags in NIC descriptors
> is configurable. Therefore, remove the assumption that if the L2Tag2
> field is filled in, that the L2Tag1 must also be. Instead, check the
> existing mbuf VLAN flags, and move tags and set flags as appropriate.
> This fixes an issue where, with QinQ packets with different Tag ethtypes
> (0x88a8 vs 0x8100), we get an mbuf reporting two valid tags, but only
> having had one tag stripped.
>=20
> Fixes: cc9d0456b870 ("i40e: support double vlan stripping and insertion")
> Fixes: 1e728b01120c ("net/iavf: rework Tx path")
> Fixes: e0dcf94a0d7f ("net/ice: support VLAN ops")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 10 +++++++---
>  drivers/net/intel/iavf/iavf_rxtx.c | 12 +++++++-----
>  drivers/net/intel/ice/ice_rxtx.c   | 10 +++++++---
>  3 files changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> b/drivers/net/intel/i40e/i40e_rxtx.c
> index aba3c11ee5..a1fc320d05 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -128,9 +128,13 @@ i40e_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile
> union ci_rx_desc *rxdp)
>  #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
>  	if (rte_le_to_cpu_16(rxdp->wb.qword2.ext_status) &
>  		(1 << I40E_RX_DESC_EXT_STATUS_L2TAG2P_SHIFT)) {
> -		mb->ol_flags |=3D RTE_MBUF_F_RX_QINQ_STRIPPED |
> RTE_MBUF_F_RX_QINQ |
> -			RTE_MBUF_F_RX_VLAN_STRIPPED |
> RTE_MBUF_F_RX_VLAN;
> -		mb->vlan_tci_outer =3D mb->vlan_tci;
> +		if ((mb->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED) =3D=3D 0) {
> +			mb->ol_flags |=3D RTE_MBUF_F_RX_VLAN |
> RTE_MBUF_F_RX_VLAN_STRIPPED;
> +		} else {
> +			/* if two tags, move Tag1 to outer tag field */
> +			mb->ol_flags |=3D RTE_MBUF_F_RX_QINQ_STRIPPED |
> RTE_MBUF_F_RX_QINQ;
> +			mb->vlan_tci_outer =3D mb->vlan_tci;
> +		}
>  		mb->vlan_tci =3D rte_le_to_cpu_16(rxdp-
> >wb.qword2.l2tag2_2);
>  		PMD_RX_LOG(DEBUG, "Descriptor l2tag2_1: %u, l2tag2_2:
> %u",
>  			   rte_le_to_cpu_16(rxdp->wb.qword2.l2tag2_1),
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> index 7033a74610..887dcd1b2f 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -1169,11 +1169,13 @@ iavf_flex_rxd_to_vlan_tci(struct rte_mbuf *mb,
>=20
>  	if (rte_le_to_cpu_16(rxdp->wb.status_error1) &
>  	    (1 << IAVF_RX_FLEX_DESC_STATUS1_L2TAG2P_S)) {
> -		mb->ol_flags |=3D RTE_MBUF_F_RX_QINQ_STRIPPED |
> -				RTE_MBUF_F_RX_QINQ |
> -				RTE_MBUF_F_RX_VLAN_STRIPPED |
> -				RTE_MBUF_F_RX_VLAN;
> -		mb->vlan_tci_outer =3D mb->vlan_tci;
> +		if ((mb->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED) =3D=3D 0) {
> +			mb->ol_flags |=3D RTE_MBUF_F_RX_VLAN |
> RTE_MBUF_F_RX_VLAN_STRIPPED;
> +		} else {
> +			/* if two tags, move Tag1 to outer tag field */
> +			mb->ol_flags |=3D RTE_MBUF_F_RX_QINQ_STRIPPED |
> RTE_MBUF_F_RX_QINQ;
> +			mb->vlan_tci_outer =3D mb->vlan_tci;
> +		}
>  		mb->vlan_tci =3D rte_le_to_cpu_16(rxdp->wb.l2tag2_2nd);
>  		PMD_RX_LOG(DEBUG, "Descriptor l2tag2_1: %u, l2tag2_2:
> %u",
>  			   rte_le_to_cpu_16(rxdp->wb.l2tag2_1st),
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice=
_rxtx.c
> index da508592aa..f965aab6ee 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -1835,9 +1835,13 @@ ice_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile
> union ci_rx_flex_desc *rxdp)
>  #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
>  	if (rte_le_to_cpu_16(rxdp->wb.status_error1) &
>  	    (1 << ICE_RX_FLEX_DESC_STATUS1_L2TAG2P_S)) {
> -		mb->ol_flags |=3D RTE_MBUF_F_RX_QINQ_STRIPPED |
> RTE_MBUF_F_RX_QINQ |
> -				RTE_MBUF_F_RX_VLAN_STRIPPED |
> RTE_MBUF_F_RX_VLAN;
> -		mb->vlan_tci_outer =3D mb->vlan_tci;
> +		if ((mb->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED) =3D=3D 0) {
> +			mb->ol_flags |=3D RTE_MBUF_F_RX_VLAN |
> RTE_MBUF_F_RX_VLAN_STRIPPED;
> +		} else {
> +			/* if two tags, move Tag1 to outer tag field */
> +			mb->ol_flags |=3D RTE_MBUF_F_RX_QINQ_STRIPPED |
> RTE_MBUF_F_RX_QINQ;
> +			mb->vlan_tci_outer =3D mb->vlan_tci;
> +		}
>  		mb->vlan_tci =3D rte_le_to_cpu_16(rxdp->wb.l2tag2_2nd);
>  		PMD_RX_LOG(DEBUG, "Descriptor l2tag2_1: %u, l2tag2_2:
> %u",
>  			   rte_le_to_cpu_16(rxdp->wb.l2tag2_1st),
> --
> 2.48.1

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

