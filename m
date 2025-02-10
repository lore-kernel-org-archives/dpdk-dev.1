Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E2DC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 10:55:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DE6D410F2;
	Mon, 10 Feb 2025 11:55:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id A271840268;
 Mon, 10 Feb 2025 11:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739184955; x=1770720955;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8FBLG0/v9P0JhzSlsyZoRDzPzWiB6fyAGxj96sE+6gE=;
 b=jN4XTOaVo1+ZOwKHWFIFj6jgzPufE2wweFPscWnzphScynd8VL4tpOr9
 6PTrPnLVMxouoQpkkqzO3rZf2iGnpP9DDWLb8kIrZGKS+q+DVFOZT76oI
 SwBbUd4OH/bROK31yzJH2fm34sapiLpMxcFkc9dBJpW4hL1+BwXLgqFje
 0AmfWiTlXLJgqq/xWGyadaOJnJuQPi2ugsm6GKQWcEDangY5RJ7yIazHN
 9Lz8Y5vkJzHUI39W2RO0yVB0pUsBU6ZmaiN0DNMM/c6c3GaPKRoJ3shrp
 uBJ1tVn8bKtyMZACP73YTW+C3Lx9inToLNZjzXW6wjqtprVKTILGW9Nsg w==;
X-CSE-ConnectionGUID: S3ZYbXG1Q624cnl/dHGviQ==
X-CSE-MsgGUID: HsHWZ7+USKmR9+PF8vabYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39781398"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="39781398"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 02:55:54 -0800
X-CSE-ConnectionGUID: V6tMMm9QQyuZM4YtP/H6rg==
X-CSE-MsgGUID: m/a7/YA6Tf+KHd0E4AwAgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="112597583"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Feb 2025 02:55:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 02:55:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 02:55:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 02:55:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVixQKGpzX3SlXFi02vHYcuubiDYUE4d+xkuW15jrNLmc5Qxb4h+cDqZyQvgn1emuhTJkVRJseOmYeNQv/RrRDIyMop0YTWswtStSFK3Pdbs8yusNuRmLD1umfcuhp0DZMZErx3Y0eSDrn7dSSZvfj3Vw8xtLtfP36uZMpy3KfSEAoxht7IGVJFBUYvIAUu470PJ4n6+JAxLSHDNE9B/nwoVDFb9kbfBsA+bGWt9Q8K/Ch/KCm3OO0ZBRwP4xI+qvd7yyEnM/5xOP7I5nCgSBP9xtZ5BHGwcVjfdVXZGb89bohawEUlIsF98QPZzOBmMK9w836vAvjYVrARTsXeBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bXDvslNpdQpX1sWAtrFY2LDXQPe5O2JGh+eG4O7tW4=;
 b=pgsCCMNjcpXaJ/1d5H9eJwcLT89YnxaTKMVdNTDllhtMYpMJRcYBVk2ahgRok//fhIJ/MlkiQNK2NB2NwnDrUvdQ6lmFjkhrqV2pdrWjdxLUgWkQEJYZ+/F6MkC415IvCcjMW2+rKBAjJCpNnCHV0rrLFExl4UY/SptinfVq19MZOHjN7SJ+EIvseeNzytdHv4RuDK6IyPAwMhdVzov+0sXxETmWO/fUS6dXcLk/osD6PuENOc+Ln6mKNkVAi+Fd36mf3zx2SDLoOjGvBmbbt7DOgVW9IDkWlArEi6vv63hPd8kUwCjKrR719JWVa95NqZuju1HqliIE5KU+Ll3adg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19)
 by SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 10:55:50 +0000
Received: from MW6PR11MB8309.namprd11.prod.outlook.com
 ([fe80::ba43:b01f:aee0:10a8]) by MW6PR11MB8309.namprd11.prod.outlook.com
 ([fe80::ba43:b01f:aee0:10a8%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:55:50 +0000
From: "Stokes, Ian" <ian.stokes@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "Wu, Jingjing" <jingjing.wu@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>, Leyi Rong
 <leyi.rong@intel.com>, "Zhang, Qi Z" <qi.z.zhang@intel.com>, "Xing, Beilei"
 <beilei.xing@intel.com>
Subject: RE: [PATCH v2 1/2] drivers: fix build warnings when using icx
Thread-Topic: [PATCH v2 1/2] drivers: fix build warnings when using icx
Thread-Index: AQHbd/vuYFNo3fJaBES7GV6FegWYEbNAY6KA
Date: Mon, 10 Feb 2025 10:55:50 +0000
Message-ID: <MW6PR11MB8309953B8CB8BFC8F18C097A92F22@MW6PR11MB8309.namprd11.prod.outlook.com>
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
 <20250205182918.4041268-1-bruce.richardson@intel.com>
 <20250205182918.4041268-2-bruce.richardson@intel.com>
In-Reply-To: <20250205182918.4041268-2-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR11MB8309:EE_|SA1PR11MB8279:EE_
x-ms-office365-filtering-correlation-id: 0b8ca6c1-3e9d-4a1a-687f-08dd49c17b92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?triNOA8Lv9byOj6m5zMstRk+aklqbINzZhBTt3grS+ytiFzJiUmDwe5EqepJ?=
 =?us-ascii?Q?I4TE5Ol0283w0uzYoncAlexGv9PGWnHIfKNtEmtFDGQVMANkiBfPX992LkQG?=
 =?us-ascii?Q?hbrmLSSAS8Ht4SGM37Ca9rgYhLqZUaxDAnEUsDkrd7iX3556EuCBFPMoUGuQ?=
 =?us-ascii?Q?XlnDJjvOo7OQaPljXYptVoYaDDKpkQP0sQV0JQ70e/TE4j98mILiIDE8ebIJ?=
 =?us-ascii?Q?ZlflnK9J12KWAEmY0hZS/Kqx3wN7iUG3w1//EySb1PZamLd3Dqy+CUCIOeVN?=
 =?us-ascii?Q?1RbaWbXHGsfHU19UF2PvFIsHnGidf1Xtlsr8T5yPds9bQK81/MpBepqJHea9?=
 =?us-ascii?Q?zROJF2BTkMepofqpLNHkFRdJAYBjxvMc/dam62RZLm8Pk4ICnPbDkPYe5mgw?=
 =?us-ascii?Q?E+1YICK5RBUi+tGXANm10D7pcLRAqTnrGrhQ+5Gcqfyhhl735MeCgHrDUSgV?=
 =?us-ascii?Q?sG2mO3WhkQj1igI9eYus5vmjx9dlp67Zy5ePKMLgAQnk50oboTDX6NEFKtCo?=
 =?us-ascii?Q?a58F7Iq2/kkRP2BjU4kuZDaF3zWJZw8lbxJU2LuaipeXwdwG+GiTwj4UT9rh?=
 =?us-ascii?Q?+ba2mhzQER7+Rk8Ufj/c286RLmQ6QHZuZizdqWgBTurROm99nP32EHCV5tSh?=
 =?us-ascii?Q?lH7S81SmnP85Wcybx5nTM5T+l/KagVTmnWgjIViWMY7AfNDtxJJIwBeXFWu0?=
 =?us-ascii?Q?B+MLMfl1Dmb74Da2bXpAqPi4BX9ElQ2ml/5tsik6d1sgSwIOEPqqCY44bP8/?=
 =?us-ascii?Q?9Jqk0uZpy0fjMBGVKb7+b16vBAIby8hxCuQ/R5JQAditSoH7TA0qPwp2eYpZ?=
 =?us-ascii?Q?MfSbixNWUABTZ5WQOKI7t/wA6edxPnQ2x/IG9/tGhVIDlCWPeHSy4i7ojODo?=
 =?us-ascii?Q?IkgxCN45mUPgHqwyaxf2HKB6Iq7tyldkZ5FQqSOvxZPkEyKS+EOAtVdgqztc?=
 =?us-ascii?Q?1mLGWGq17sTLdBtltCW4oCji/uXAJannL+9dKAAXKMsI8GJiPSHKM612gXvV?=
 =?us-ascii?Q?h6ZmDKt5XvrLE9xVhIF3lu6olFRWV0djIIMdao6OaOqp7C5i3QUYUctOWEp+?=
 =?us-ascii?Q?tMFAgQT5AX3wkM9FsdAjcPIJrqq5ffaHZgjELccmfMc6CAH2C01LGTpkVAq0?=
 =?us-ascii?Q?4BrmCl9v2euUb9G9W9I28a9Cj5eodnu/wVsbonEihA3/aGb9jpGHFkndpnYo?=
 =?us-ascii?Q?swK1NPFtmOAOG015faFYMNKxclMY7Sy32YCLghoY8twL/ZHcK4HPmoPuAzoW?=
 =?us-ascii?Q?zLBhW+JIsVs7pUq7VgDQG+XEtDKqsCOrWSk3eiBtGr9CtP8yflhd9jqaDYTO?=
 =?us-ascii?Q?95f6joIlkHyoDrZKFbYZC1on6eFTAP+YqO4fKHuXz8lJhd6qo7oQeHL2Y1s2?=
 =?us-ascii?Q?/vq3i5B9c3YiXSbpLnzsAzv6Se3VteD3bXfSDwGYakNURoCzEmmKa1etJ8W6?=
 =?us-ascii?Q?8p772Yn3BdsvW/kXiDkpfY8Uela2v/5b?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR11MB8309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kA/Ggi3kO/+pHoeiYwlP7/Ktaj0iBR90NrW7JZylyYDWjMomE02PrX1gC2jy?=
 =?us-ascii?Q?+Szu5AjNEJ3maLDB+LCgc+JpTaxrNP45BrJLTDRo/nO+/pITVY+zyaNuOJpu?=
 =?us-ascii?Q?gecFJ9EKxLhG2wVfEEsCT2aYtLVk9GIGWqKNF2MFOh9vNnnryfqWNUsIfb5x?=
 =?us-ascii?Q?pbGvWMusZoLXz5MEnbYmAs5TdLTaqVL++pkdGyyiJ1rstCVl64kRtrfDnd/F?=
 =?us-ascii?Q?nKOnemSDONdKHKF7dM6hLz5hBMw9iN0vGkws8pu9qsvFFx8kEeRSUc2K0GCf?=
 =?us-ascii?Q?gREK6SNH226hMhNFFxwLHWJB4e6Ko4ELYAE/X/GEC5FWBEFCbsZ7x4XsSM4S?=
 =?us-ascii?Q?/j1qLOxY3CLUDaqX3sucbvB8ub/LqswUpnQVbGiUE2Wp68BZacU7rhP3engA?=
 =?us-ascii?Q?tZBg5X5/2yaEmWHISfbqguQKMS09cPwNib2pR4cYj2Q6HxR5vH18SFNMcma/?=
 =?us-ascii?Q?b8XTU3L7zBmuF2Ci5vQgbxEUNOuKv7dy69PRvBqCOY54rTZFDhvU9NLYTIzZ?=
 =?us-ascii?Q?gXCwjBk1+HRN0Y6NN0eLFtS0FId4fbW+PV6ouH7u9rDoTfiJEhBG7PIHLEU7?=
 =?us-ascii?Q?D/U3drO2Ktsyn2MQVLoN/LD1ziwynDPwP0XN4xR08c9w/xnlO4Qec8YWnVom?=
 =?us-ascii?Q?CpYby1z8m9KgESolVNZjLBs2yn2MeatwNbqk/TbwcxlHEEMYTWApyUPmw6TN?=
 =?us-ascii?Q?11wvmnhqiAV4FmKFHgjWO8rJrQgUOIyWbnsrVrYU2lx4C3aX9jfpgOH+kHTU?=
 =?us-ascii?Q?9HY/TZiFfIgMLyKSWOU5YoH30DEsmO3KtSKipcwiScRlF2Jr4bIHuR/gJVnz?=
 =?us-ascii?Q?eOgdFH2HH5aTU5ghFLH+11ee5DRUbY7RnqLoE4g+jUC/iEA/b8e0LNWNuxa8?=
 =?us-ascii?Q?OtG916GZrXzk3jVg4hdQeOLjBO+nG/U7pYSXjkxtvSMKtuYcmvAHMRi3iYIZ?=
 =?us-ascii?Q?YAAVL9Ju41ZWtp2mp3UkfCHTVceau6aWNGAHTURzWw5jjhONyWdiDC+Pm3DP?=
 =?us-ascii?Q?A/b9skv5yjAk/RzgtVzctsBNxED/rBPeXmNFZ7BmggDgP2Ztqia+JfdtJtD4?=
 =?us-ascii?Q?qRe+Oq6a317GvNZ8HSGNUsIGz3zlaf0QjLNkpkvW2E23VGcaLFi+SEL4kPYA?=
 =?us-ascii?Q?AKW+cR5MpSp7Vv7toCRrgXZuQyxPXyq4Rn35EkxB4OBc6lmaFL8UBstgF7Nu?=
 =?us-ascii?Q?pTzc6ordFqT5gQEgGXFAzRYLGUG3qB8Dhh3NcNCABmjI0F/fZE1imCD+pHZW?=
 =?us-ascii?Q?ZOxb/9dqXZsjoQgK6qg/zqYTuE1Cd0YtC7+PzjlgEKM0WpatalUlpedsBkFA?=
 =?us-ascii?Q?rMVL6+DFlgYxKqsjYgQ4KsCmw9mCrbDAfaI/h2WP+55G+sLd/7wgQTCd6ZO2?=
 =?us-ascii?Q?Vfv2VM2ww7MQrFcpPDrPGf2iI7Ak65t9IHD5+bVQGLS7boCylC2EI4rdopQi?=
 =?us-ascii?Q?jz2FR/K/I6wXclYZKsOLjcRqHg05TQrSjIdXYORSjEKK+hLl69JE0B8kpaC7?=
 =?us-ascii?Q?bNy9ysSYxOw0yqL/zY2W4aDcH5LyYVZGPB2qt2/IbpeEtmgiKGqRKSW1E1qW?=
 =?us-ascii?Q?qkz9GGCuKCYZP4DvKJo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR11MB8309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ca6c1-3e9d-4a1a-687f-08dd49c17b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 10:55:50.6708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKaIuRli1A0bg+Ka5hpo8clwb4j1xQbJWwlClFQ4k73WYqq4ZCi7A/zjNely+c48ohpDQ6koLbzka/8QUU92CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8279
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

> The Intel oneAPI DPC++/C++ Compiler (icx), issues warnings on build when
> the "-march=3Dnative", or other configured global "-march" flag, is
> overridden to "skylake-avx512", when compiling AVX-512 code.
>=20
> Allow building with icx with warnings-as-errors flag (werror) enabled by
> disabling the warning for the cases where we pass that extra "-march"
> flag.
>=20
> Fixes: e6a6a138919f ("net/i40e: add AVX512 vector path")
> Fixes: 31737f2b66fb ("net/iavf: enable AVX512 for legacy Rx")
> Fixes: 7f85d5ebcfe1 ("net/ice: add AVX512 vector path")
> Fixes: 0fac6a1c44d5 ("common/idpf: add AVX512 for single queue model")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/common/idpf/meson.build    | 3 +++
>  drivers/net/intel/i40e/meson.build | 3 +++
>  drivers/net/intel/iavf/meson.build | 3 +++
>  drivers/net/intel/ice/meson.build  | 3 +++
>  4 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/common/idpf/meson.build
> b/drivers/common/idpf/meson.build
> index 46fd45c03b..7dbcdabd90 100644
> --- a/drivers/common/idpf/meson.build
> +++ b/drivers/common/idpf/meson.build
> @@ -21,6 +21,9 @@ if arch_subdir =3D=3D 'x86'
>          avx512_args =3D cflags + cc_avx512_flags
>          if cc.has_argument('-march=3Dskylake-avx512')
>              avx512_args +=3D '-march=3Dskylake-avx512'
> +            if cc.has_argument('-Wno-overriding-option')
> +                avx512_args +=3D '-Wno-overriding-option'
> +            endif
>          endif
>          idpf_common_avx512_lib =3D static_library('idpf_common_avx512_li=
b',
>                  'idpf_common_rxtx_avx512.c',
> diff --git a/drivers/net/intel/i40e/meson.build
> b/drivers/net/intel/i40e/meson.build
> index 5c93493124..ffa40c5d64 100644
> --- a/drivers/net/intel/i40e/meson.build
> +++ b/drivers/net/intel/i40e/meson.build
> @@ -57,6 +57,9 @@ if arch_subdir =3D=3D 'x86'
>          avx512_args =3D cflags + cc_avx512_flags
>          if cc.has_argument('-march=3Dskylake-avx512')
>              avx512_args +=3D '-march=3Dskylake-avx512'
> +            if cc.has_argument('-Wno-overriding-option')
> +                avx512_args +=3D '-Wno-overriding-option'
> +            endif
>          endif
>          i40e_avx512_lib =3D static_library('i40e_avx512_lib',
>                  'i40e_rxtx_vec_avx512.c',
> diff --git a/drivers/net/intel/iavf/meson.build
> b/drivers/net/intel/iavf/meson.build
> index d9b605f55a..c2bef0230f 100644
> --- a/drivers/net/intel/iavf/meson.build
> +++ b/drivers/net/intel/iavf/meson.build
> @@ -40,6 +40,9 @@ if arch_subdir =3D=3D 'x86' and
> is_variable('static_rte_common_iavf')
>          avx512_args =3D cflags + cc_avx512_flags
>          if cc.has_argument('-march=3Dskylake-avx512')
>              avx512_args +=3D '-march=3Dskylake-avx512'
> +            if cc.has_argument('-Wno-overriding-option')
> +                avx512_args +=3D '-Wno-overriding-option'
> +            endif
>          endif
>          iavf_avx512_lib =3D static_library('iavf_avx512_lib',
>                  'iavf_rxtx_vec_avx512.c',
> diff --git a/drivers/net/intel/ice/meson.build
> b/drivers/net/intel/ice/meson.build
> index beaf21e176..3b13a5913d 100644
> --- a/drivers/net/intel/ice/meson.build
> +++ b/drivers/net/intel/ice/meson.build
> @@ -40,6 +40,9 @@ if arch_subdir =3D=3D 'x86'
>          avx512_args =3D cflags + cc_avx512_flags
>          if cc.has_argument('-march=3Dskylake-avx512')
>              avx512_args +=3D '-march=3Dskylake-avx512'
> +            if cc.has_argument('-Wno-overriding-option')
> +                avx512_args +=3D '-Wno-overriding-option'
> +            endif
>          endif
>          ice_avx512_lib =3D static_library('ice_avx512_lib',
>                  'ice_rxtx_vec_avx512.c',
> --
> 2.43.0

Tested ok and looks good to me.

Acked-by: Ian Stokes <ian.stokes@intel.com>

