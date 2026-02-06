Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0789EE208C
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 11:37:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9F7B4028E;
	Fri,  6 Feb 2026 12:37:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9D3B140276
 for <dev@dpdk.org>; Fri,  6 Feb 2026 12:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770377840; x=1801913840;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ggiz3ROaVsLcnWGs9liMoyRjHc3Gj5fVwGzlxqhAr+g=;
 b=iGLosUZuPkJMToW+OO+Tnnd66HQ8Zanb6VyEE+z1nAJxWlF3DQLUerCg
 OLA3A0qG/o2g33107tV8uLluM7byNdYY8xKTnctCqQdDPr7gKy0PPOH1w
 qtEWHs+LrfFkFlCRozY+O47L8XpfV7hqLdZE72vANs29WsQMAjL0qPFN4
 fuRv83BkxQeFgpAbVQKAq1KKWcC9MHOVTjd8CsoUxvyTIen89I5GWM1nK
 JrZZORdv8TccLTVepKIRUcrJxVbTI7lqoWpkz3v06VeNBUC+WZSXxaBuR
 dYz5QyG5AUDgIgIa2OQmJs3l+peLgBnynk1d8zilKQVW6ZE+Srr8UVAzT g==;
X-CSE-ConnectionGUID: niKm4ooYSnm26ZwfCqpfgg==
X-CSE-MsgGUID: zC/u4NU5TgGxwGtkYkr9sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="89008171"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="89008171"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 03:37:18 -0800
X-CSE-ConnectionGUID: PowVEWHcQbufHDNmvQaGyA==
X-CSE-MsgGUID: UpDAYt0mSniNdvJblzaTOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="210891301"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 03:37:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 03:37:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 03:37:16 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 03:37:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNOLnAiOdYPiaxnUjdAEeWpiiByGuiQ1wJd57H4HbPC9oymfvLz4qehGbwu4seXtmhYqbQnY1D0ldcUvn+XGxcF2G18Gl1G06VAjS5MMUXqZRz2cXin9MWur6LnQwMFLwo4dQM2fH6qvSWngWmLI7gP+LsmaXd+aoMkIq7mSh2NsgPX+l59+C9Uhj7QmwK300H0ldBppULfu/Bpp7iOQAfg+MbT6PcHxZZJ2UgzVKW4zFNE45Zkbljlz+QNqpN4iPeRkVdonmpprfOhgVpaBm31Xf4O/i0wVucERQnk0Ngtm96mQ//DahR3eVi7VpURevrLVuT/P803ACgb8YXdpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tioz6QFSjKcqJZeEYdqg7payfikUPDeXTjnBYcuMKdU=;
 b=of3X3aokLyL4oTra98ldP64hTOQEavTNR2tzYMWYsrdnsz6yg3uGtzKVNqzp9iIARAdTaQ1p5XpowOAwgbnpaQ5ex0Qpfb9Mea4RvimHQ9d5DsiNpSypjhzJ4BHbKJF2pw2TGhN6w0oYX7nc+v+wOPPdJkt4y81Pl6G1tNYfOadAdzOLsoDL+yexcMRZqOz5nmBwCGUEMHCmXYzfyh5Gqpg1Ka0uqCDF+5K991slz6ylG6I7PboAFtaTerbL5hE5iOkYKqA8mteNqNKt2Fg9dgsRN834mPICTQn78C/VCIcskYVbNM8YhR/G2kpEfQ9rtJL3tz+BRSFJM3kHY6pnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SJ5PPF035FE4CB7.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::805) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 6 Feb
 2026 11:37:08 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 11:37:07 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3 11/36] net/intel: create common checksum Tx offload
 function
Thread-Topic: [PATCH v3 11/36] net/intel: create common checksum Tx offload
 function
Thread-Index: AQHckd27aXeapIAvr0ukTGvaPsW8c7V1lFQg
Date: Fri, 6 Feb 2026 11:37:07 +0000
Message-ID: <DM3PPF7D18F34A1D6B3363472AEEF97DA0D8E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-12-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-12-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SJ5PPF035FE4CB7:EE_
x-ms-office365-filtering-correlation-id: 04ab1efa-a402-4b06-4a74-08de65740f32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?dKaNXYYIsK0UDALgJo5m/HKV4l1lEsGQjx/G1hj9JvLpqwDJ+/5B+he8b3Ev?=
 =?us-ascii?Q?NzbG67US6W+yHEX7iB7S5RzrYhVICn+y0S2y9ftVQDTd0XY84Q3SB314KTeG?=
 =?us-ascii?Q?mlIYFEkS/RYtrmd57XCTV2wLYyIOeZ9fsMWac2S0WkW0qe19MLyDke5piAml?=
 =?us-ascii?Q?DD+94SoXMMLLP2hBv+7rdpyBa9vp4fWahqMXwZ0vwn3d3Xpjm2XQhZXLivHO?=
 =?us-ascii?Q?NDrklktBLZF4Wtsq0A0IN8qJSNii0fMQ98fbCf8pFgKf9gRGT9qy6hYNGKhV?=
 =?us-ascii?Q?AbSGDFYMEtGGssxv54K66DRBibAGG9P8opJKRUWcUY160DbtIgfbfIRYSyuW?=
 =?us-ascii?Q?R0CXSt+W51d4bsG8lIVtpreMclW2WTooyBGFbDTbkr9hf2KH0Vs5fGJbsIO/?=
 =?us-ascii?Q?BgV4HQcNp8F55T30pGLLlVMtfzZekqpSAAd5es8juI2hgd9FawgHN0EXmOEQ?=
 =?us-ascii?Q?XQ8f/bmvDq/nQfBysUDsmYdYb+FqekugL50cAjBWFRl7K5gX5aIu+L5DnLlG?=
 =?us-ascii?Q?kzR8yQiI3k5Pv9RP6h6cNgkvO+aahJw6ZnnEHPwMFdEuH7/zlqcDQU0TKhVG?=
 =?us-ascii?Q?Zn0GizcbJ1t6TpQDZNIaJKbCVLESDgT+YL2SRiHM+s7grbyfC9yT77zfx1i5?=
 =?us-ascii?Q?9KwJhPkd3llx6emCzgAUzYx6XgWNYZifUEys/smmXWKE0tT7srDakvOcHdyH?=
 =?us-ascii?Q?VFZtnlTpAXITzf7S+Jd3maQGdUm3XtYIVDrwJs0sHSMTYZ0ELfImaBcAoW0n?=
 =?us-ascii?Q?kKfclPNI4x0bP68RBnTmPh+htHT7BYZcmZ+Hu4BjhO6JhT0NeDOD3AnYamdJ?=
 =?us-ascii?Q?JBh7YSg+RebqUHS1KTZcK3kT95ru1vdlVd1TrZDMEBQxxdwXE6LNDNupOH4J?=
 =?us-ascii?Q?q+MZ5tx+lUEhw6rgv98sN8A8xm/LIXsOvrOlzbtpC2/pyQop1yLndpzIObBC?=
 =?us-ascii?Q?MZ7sfMPW9ezF9OCSgid2PmOuRRrYzG0yw9Eqe+/Uzyloa+EJdULoNEEQz0LN?=
 =?us-ascii?Q?tRGOqZmLFy8zOsDX6DILAYzsI/Ku4i5r1FMtiA1du6/1JfdmNIaSi9HTd+AM?=
 =?us-ascii?Q?RkpfXjC9wGm2yznCrrIIShYEJR2x+wfHxLLhdltEsc94ZCVv0jdxBQNo6Qmo?=
 =?us-ascii?Q?YgquFbxSN7G6YOXPeJuU8n0I3O2lhfGyYnT1J+56567NQOxaO7aQL3Q/rpgd?=
 =?us-ascii?Q?u9OizEt5NqroGK/goFM9qYq0cpI92sLHMAb+yWPm8E8STFMRHwzUsmxJo/2d?=
 =?us-ascii?Q?NA1t0185DT48xvSSa0sRynkvKKsfWmFlaATSW1EGThylef8Wo1VJIGCgWaUd?=
 =?us-ascii?Q?33ptJ1HIasfAH/F6/rOBuiEWwIjVSxGCoBQkJswMxTriQif+wfQwLMs+buak?=
 =?us-ascii?Q?oKmFFyf1x1yWHjnt1xBs7H1owJVMWngQvcXIwXLFdnidN6BYOJKI/cSI6M+C?=
 =?us-ascii?Q?pnDTXBZDD+0UcDND/yb2zRea5lQbevFoswJ5Lt1peBGmu41Nd/r/IgXWh22D?=
 =?us-ascii?Q?EiqxD6Iv6guL5dD1NWDRhzbh3uLZtolrx20xEraneKXbiLKeiLDbnn3876qW?=
 =?us-ascii?Q?LbZgesfD492W1Pj95VjhhQ2tMqAG7f9/o3/KizuAJDjA8XwyC6u8fRC160Fg?=
 =?us-ascii?Q?8ipCN7SxXoc4QhDAcKmLzlw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?amyOgBLp5TVGyhneWT94Vul9DnAt+pO+jYrMybFIRMujUZbnYHq7A1lq99XM?=
 =?us-ascii?Q?IYLTugBzuywDoAufu8N0Sm8sD9B+IHdQxcy5QNqDw5yj7l+QzHI7Kgb1Yp02?=
 =?us-ascii?Q?Gg7l2OQuh0g4ty2wjuj3Jzgm6de87zQqcE9tNfWvMvOe7yGyG6LRtSXM0uN9?=
 =?us-ascii?Q?QzVJBIJGMZqFHEUHAb9fqC4pTWC3M6OMEUCPbDizkejHKshOSKYwRHiFxBzN?=
 =?us-ascii?Q?tOKnxWq9qq6q7AEI2p9VCWR1FIqgEAww7IkGIKI7qfG+6Nmb9MvJywFvg5DE?=
 =?us-ascii?Q?sMrSAlWC5kI0NBg5Ij/YLlvegbPECZ+JjlzMel3Qn82ATq5mS6ccKtp4dEw3?=
 =?us-ascii?Q?2yhTbYUfuVK5z44UEFlEd0KgnwGq2N5m53rEAdNVBfExXP0yNYxc2F/YzrFk?=
 =?us-ascii?Q?4pTAEAbkb9RG/EVPAFCatjCokg2hpaYMgAsEnl6VYCGkjHH0LNyAsK6hACQF?=
 =?us-ascii?Q?lT+Xsbb/oawIZh5emDwEAThSeYuLOPa+2R9thPAdAvTuiK2n4Q/kSvgBefMI?=
 =?us-ascii?Q?5OSUhtIxA6ED+hF7UbDKwftAiHHLBjU8oyl+NnNULxq8cphB2IgWd00aeF6J?=
 =?us-ascii?Q?jT0wEJ+P00hhbhpLfnLKd17NfIoPXGNCOU38eW4Cxxv2WAeBRsCW3lSIJjFj?=
 =?us-ascii?Q?tkYdyju0IFiEqbxxhvJ8wu+quWC5OfG7wstUe+Mkr18SwmyqslcKGJhcFf1C?=
 =?us-ascii?Q?D9QuBM4t/5DfEs5epgV9Yj65t6f5TaRBesBnctYoCwLaD4JDBRFug9KwNLeS?=
 =?us-ascii?Q?zkShwNy5dQ197vdP+T11t8cT5hhndHIlBf9kK5H056p0nDUx7MM9z26hu9GB?=
 =?us-ascii?Q?goiSZRVOK9Kzun5WB8qpvC7RcGIYF28Hu0E47mbfipt6ZEdkQViR+ZkQikLZ?=
 =?us-ascii?Q?eozr4yz/PlQH2V3EHEGtdbneMBnJOuPUBGj2NAnu9T/UZvjEOukJLpnFl6LX?=
 =?us-ascii?Q?RDDMabsCBzL+yCcFNKeuun2bTEugqJI9Bes9RU4tZlQDH7oVXXsoVNgO4vZe?=
 =?us-ascii?Q?FbpyXCMVcyehTG6Xpg0IIOOZTVmcymf11J35Ezp88u03/tdiv7jFIQdEf8Vo?=
 =?us-ascii?Q?gZSXaq4potJEXzWr1f15PaxgW1r2pGzBZIFDi+hCekJeRwPTxTUcSADo+wHD?=
 =?us-ascii?Q?BUzC2FFK+4PHVFLhyli1QHQfDCdqc83/DQ0on93hPpN2f3EPVXuk5NATSxp5?=
 =?us-ascii?Q?OKTMi3YYDARuLZ1Fk5t9Z1DmStmcKnBnFYBUg5v5OAjGa0DgTk/eyLobpsaT?=
 =?us-ascii?Q?+ldeUqhJo8/5NZJ7wOyulgzFXM2HCBnqwkd0K3lEfH98ByVnOSFoyi7WlXCn?=
 =?us-ascii?Q?igGl1S8VHdt6YHOmJvyR18Cmdpev4VLp9BgzlTKx2qHt56rB8ngf67Fw5eob?=
 =?us-ascii?Q?F933F1hLI7ua3UnmNVgAGIAwDbIVp+944fVZnelcQ/JnPBLrpq5d8j/XVgFC?=
 =?us-ascii?Q?gVRuaa9He3+9S/4mw/Wdcq/l7wp7ZF23gk8CyTmjwIDWFLSixUX63Y/eYPn3?=
 =?us-ascii?Q?LkC7laAH+qQw58mDW+UN/mX8agDYNbNo82g4B3WVHOOYVr6cjHQFSGdtPWna?=
 =?us-ascii?Q?DU+speBqPZ3/fFUpvoxpEAEjsHcib+iOrkeqIjj0s8tttvFvbjAbMQI0oTDD?=
 =?us-ascii?Q?593vktjyI3zxrzBlqd874LXjVK/5gdCYMnaAiZzYa3zsrdULROydGm3B8uo2?=
 =?us-ascii?Q?uaACdJg/82CNr5p1ZVBWZ/jaUi8ZTG6sCn25ToZ9BoOo7ZNoTa7mcePHKoC3?=
 =?us-ascii?Q?SiAoAnOFEA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ab1efa-a402-4b06-4a74-08de65740f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 11:37:07.8506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzP1N2vBLpj8iBP9IVLJq7+UaCwjgckIs241xVhCzzzuCFnDJOnthlT3mK3HwnABAR2d3wahONUmUnF7wxDzQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF035FE4CB7
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

> Subject: [PATCH v3 11/36] net/intel: create common checksum Tx offload
> function
>=20
> Since i40e and ice have the same checksum offload logic, merge their
> functions into one. Future rework should enable this to be used by more
> drivers also.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/common/tx_scalar_fns.h | 58
> +++++++++++++++++++++++
>  drivers/net/intel/i40e/i40e_rxtx.c       | 52 +-------------------
>  drivers/net/intel/ice/ice_rxtx.c         | 60 +-----------------------
>  3 files changed, 60 insertions(+), 110 deletions(-)
>=20

<snip>=20

> -
>  /* Construct the tx flags */
>  static inline uint64_t
>  i40e_build_ctob(uint32_t td_cmd,
> @@ -1167,7 +1117,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>=20
>  		/* Enable checksum offloading */
>  		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
> -			i40e_txd_enable_checksum(ol_flags, &td_cmd,
> +			ci_txd_enable_checksum(ol_flags, &td_cmd,
>  						 &td_offset, tx_offload);

Now that it uses the common function which handles
RTE_MBUF_F_TX_UDP_SEG this means the scalar path now supports the
offload RTE_ETH_TX_OFFLOAD_UDP_TSO so I think it should be added to
the I40E_TX_SCALAR_OFFLOADS. It seems to be missing from the device
capabilities too. Same for ice.


