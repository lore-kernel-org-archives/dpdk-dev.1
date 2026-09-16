Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97335C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 09:03:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2259427C9;
	Wed, 16 Sep 2026 11:03:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 34409410FD
 for <dev@dpdk.org>; Wed, 16 Sep 2026 11:03:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789549386; x=1821085386;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=W9tZ0GQIVZzKoVt0lR2CRcd8v8utsAFClC+chD/g7YM=;
 b=F5CqsEYb658D3WBJCymTRtuu0nq7o57RS7DHVPa9bHhBlpvTaSfHhONo
 9jZpN4uNGOh/EuFPhOxnDWjtigBqBMjVonZzrFD+TucvVD6t6m4ewgxeC
 MzXVchyhRBBKyaxkPHy3KN1VbhE14b80GlZp2hS3G0NzcV5x6A0WyAHVB
 Pmxc2HT0zUL+x9CImT15CoSj6MAQZLp1bY/t3rDCXzGNmd4MP3rkOeaKs
 8ZyfdiFdkNjRbaeO544Dx+ShlXPVTWsjfMlxxbXL/gZqe1FP6yIUPTJ8N
 KbO4p1CI1PskzW0DSrVLM287ehhbhGS70S2A+Tb+rx9ZND+jHCnaUTTe8 g==;
X-CSE-ConnectionGUID: zm3fe2UgQo27VA++4KP0sA==
X-CSE-MsgGUID: t3Joh5UZSi2cjsMPZjgw1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89938774"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89938774"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:03:05 -0700
X-CSE-ConnectionGUID: ymnCgVj1SNC4EbU0EWvVzA==
X-CSE-MsgGUID: tF8dABI5QG6oW5XwlrLLCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="303161584"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:03:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 02:03:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 02:03:05 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 02:03:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDApuVZVGyRCIZ8nSAooAVKQRfhDyrRUVi4kTXHUTSvhLv3fOKkkHJ4LyTSMh36QJgGoUgNzrdrIDvURAnOlBIkyRrwLmqVW1ZocmYelEb6GKqI2e9hOIvkCNZBeLYUMKok/zz/UJErJM8gVsw6yKgHp1S1F3VFT6wU5SWF2RjqYGHkSBIgFl8/Ps8Ht+XvsEMYSEa4CG7jnBEX2J5PRPNMstHKIabGIWfHlU+5lnUsErZefBtaTGBTpmFBHM7+sI7+IIFSCvHaDbfbei0LXo9LpHloKazJ881FbeRuZcakpET2p54NkKm4aMO0DDEPUw0XjvmUVKfDmH+XKBqvPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V3KRnzRBD0DqwisuPoxdqj+fnCP0ppUaI72Apf/xjw=;
 b=WPsH/NCL9WMYAFgs/nVQXrneh6XnZfSU9Sz+KunadF8/GGWmx94Z9Rd/WnO8R/FeoETx2mjRkz8mEnYW0ZsyogVscW2MPCUt6JQLZnNsMENWxEvYyHskGnO8FrmpuDw2jxfs0BRvbL7btreXBKy/YApB5bXD2deqR67lSHFWD4FBqD/Q6I5ROxQJwfM6Zkyso3iSMJ8lR1UQH1Iu912B1Ew36cxOqlnvDJ69JDtkSlBuA/7GKDpKu+dBUbtcXRxLRdNPMCLth/VP5rLF0BwWMgP1nXsbXFu845v7j08G+1PqgiKWa0WPSNTt5M73/adNQDpUjfT1I+8HeGLcDkDvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DM4PR11MB6312.namprd11.prod.outlook.com (2603:10b6:8:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:03:01 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 09:03:01 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v2 14/15] net/ice: enable context desc offloads for vector
 Tx
Thread-Topic: [PATCH v2 14/15] net/ice: enable context desc offloads for
 vector Tx
Thread-Index: AQHdRRemvzMpTccUbUeC736IzQiuE7bQ6M0w
Date: Wed, 16 Sep 2026 09:03:00 +0000
Message-ID: <IA4PR11MB9278BF12226A4284EBACE2A18EB92@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260915133654.278780-1-bruce.richardson@intel.com>
 <20260915133654.278780-15-bruce.richardson@intel.com>
In-Reply-To: <20260915133654.278780-15-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DM4PR11MB6312:EE_
x-ms-office365-filtering-correlation-id: 12cbc576-9508-41f5-72d9-08df13d14f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: ospe1Q2l0yb18UsU+SnkWwNG07/filIZ8XqXPXy+XhMjQyT54lStG6P6/ippC2ANlkmfHpe4SksScG0S1BZnRi0w4gZwFX+HicJjwq2FwdMRbmBXjX7pxO6QpJ9IT1CW+KdzVk0KktAvgTpF60D/egVpmqYj1OuyEMtvuz0m74Hd5mPWdCzEARNFonyA855mcQikg8EGOUnuKYytQPRwc5bipK5se7yzOEzd1wLVtWaPsLRWMwTCF6HxwWVCu98yRljeDqfhcKqQvh9Xig4kET9koPLodpDLiphmOj64brADDcFh0tvwvU0TXeeCkjlg1uTLWKcovdaOzw+OyARLOD5fk8p0fYe+Tl3XgBBxHC/NIzsp2OGujB5OigrWvmB92kMjzLPqx644f9MUo3MXUWDKtZpjTWsaAIDOdnA7dSeGm7YYjhYaZGMB65eiMbkQ26v8ktsg3sF4smxx+q2QV1vJ6Ighjz4zGbFlRuKcnrm4wDS+/bAZhOdLLZEctEqqNEnW1tae/13DEiucmTzpFBFs5Un7eojjbNulgRia/SYztHSFDTFGK6P7vG4+v6gvlMpMXCg2ZXZbflsJ8m51+DaMF3MaUuINDMDYJGBvmHgj8m5CwyVE4l+kOZnai7UoH9eLjf6BFsrkYA7+1ZcvouADIRrD3j6B+TvkpEOr53fUZHMI/yKQmTo5sFjebq01WrAg5ZuLojbpAZBuoP7IpsSKrUaUwvG6shwxd8Mpx84=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/FBPfiim/bOYrg4vgUa9JLioNBwOtpvwhf8b9pvsZ163jT2B3vLvzm6VlkUc?=
 =?us-ascii?Q?h+Dyrixl/tGQbpnieP0VWl0kRu5cvm6O8an0dYnzqi0NvJ+U+997b9n29c8T?=
 =?us-ascii?Q?5OFw7gIzp/PAoPxIJn3bZrhVoaMYBx5T+0sHUUH0mKGYILeDX18BsjMpawi+?=
 =?us-ascii?Q?ouA1jUCFkRTNW5V3eci4dV+ZBSAPTMMzxqjvRjUMwAniS8n53DVRDAN554au?=
 =?us-ascii?Q?z7x3N2pMPffM6eqYcirXl0k0uPEa8MriBDIeLtegYCjKiTCr0IPl9WyydA6g?=
 =?us-ascii?Q?DzzTPLv1osPe8NAkeuyDg9rzx1bRO8GHfVAaYKbHLy2Iv2rw4Rqz8989Abc5?=
 =?us-ascii?Q?LlcT+e00v7I2ZK32hv1MpGXNgzfLP21PVLjH3wXqozwoi5ynIVWSGyrA6v5r?=
 =?us-ascii?Q?UWjClQXHW+orcclTrfIXCb5dPF8AAFIOf/BgnD+BxxnE+aHam43a05vEY+v+?=
 =?us-ascii?Q?plUd+OZjagZlRXP/zDLfUPJKR69QMqRgBuvTkieefuGHiCxzyJWEFXKeVJVu?=
 =?us-ascii?Q?w1D2m/M/VENxAPHuWm4VuAQozpoRg7pgdycBqmseai9XYXdzoIz1kbDQt0Xn?=
 =?us-ascii?Q?lRp+qRvBVay4R19aBHArknoFYYyJFu1QAhOvJat9msOyom8kXYIk4njwCNDz?=
 =?us-ascii?Q?KybDcNvB5+4KGGXxsW3/OByp4uQv60QoINBBUKNTKIUcrgdyoHDuj//26HXh?=
 =?us-ascii?Q?Xz4AbwYCgx3EKvlW6O/mpE63puPTIAUrVvT55YZd1mjwDldKPq8vcGlpsPcU?=
 =?us-ascii?Q?Jr3H+jgvseBdgxYaxD1Zc8PQPC7sPZbclWr9ysdKNnQbjICcE8wsGo1XAO5W?=
 =?us-ascii?Q?rwZtZbhSdVSl+e/q/X03s6mgkyXY14DMW1Y8cqIw6UILou1JpAcriXkElt/4?=
 =?us-ascii?Q?xhI1df6ecDGXfVL6DRRRt33csDKIwhgUudDEVwsRHZF7aC9ODMxlMTUKzise?=
 =?us-ascii?Q?by7Wvtp0V7yvLPacCk8IY+t52E/HzahSfa2qFxgTgyUne+8FoTzpaqsb1coq?=
 =?us-ascii?Q?BUNvvU1LpqRyWXVKSFpmgrSUlmZXabMmTRF3n6Nd4T8zDjT9AnIQ5680Ldne?=
 =?us-ascii?Q?ghlUSGEW1iEyIPzQZAezXECItEdw4OMKTm83/4JU6F4ydJ54LZHAnH8q9aXy?=
 =?us-ascii?Q?BJdes5RMnF5HZ/vQ5GYbTS76iUKWPHdwDBvpzzB28uCYOxq+fLoS8lcxNtcs?=
 =?us-ascii?Q?PxQwPxCq3cFX29zS6sX+iK1n1d9LNer7oAl4mluqxepq2r0j5xGtVV4u2b3e?=
 =?us-ascii?Q?U54DmixwTOy7qUS0+0wtjxstJ3rGVz7KlP9PQm5RumKruCXzImnqz3AK6yQv?=
 =?us-ascii?Q?ydEwebsh6kJrXRzYW/Ccc7TE1uneivsqB/s7t8Wt3gTABNeVPfmjiFaf050c?=
 =?us-ascii?Q?yi4KeYCwzupcGg8EztSZBP9GK3DVhBxDrOsX/UXaqnja7Kfw0YUhKeM5C7hg?=
 =?us-ascii?Q?6TNrfrF6rp2gwyNakfoz49g1FrkIRlOFdltVRh36J4iZ9rO/NipWRC6HEw9w?=
 =?us-ascii?Q?0O9S49zaGsx4xhHL+8WHQOx5wmZeYMo1K3EPP/ejYFM1rmphfLLGdSntkf0z?=
 =?us-ascii?Q?cznlVBLITe/N9wgkXDlNK38TIshlIdZ6sEnw+TX6BUvsIXKBj0rIjfqFR04c?=
 =?us-ascii?Q?EMEh16XD49hIXvg/O1bXCULjCQ9berHF0K572l2e9/8YwxSiGIvGu+Z9+0Sj?=
 =?us-ascii?Q?u7nKKSPpGr+l6wzBsd00wzS6s1GYI14tQ6VeyslT7EWcjVMd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4lkhuOf5khT7kxxaVaF3l2NDR7c908PzBg35ypYZhbD2ODObwa3lYgRNKFBwlHEEJ0WJFg3aPV++JohxEf1rLLmFZzlaeLa5nvPOHOhY9wDtFUmETUZRmtHtOYz6ctxEAdlIPhK3PXpiDqR/ar+ZOQfPGRGix6lYtDYd5Db5eIzJd4YNbY4pL9/vufyGqnJLq69r1gUMu9jt/2bYm4FGWK32TprRnki0g2s8xz1DMQz+R8K/6q9CxLyS1XPSEGecEksnu6SlgpUyHlc3GiTp4D2DaBMDILCqMhxmcvWDSVIo0UbEI4sWVIaGaHq0ldq/Tfm9ou4NCaWHULn0k0eBUA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cbc576-9508-41f5-72d9-08df13d14f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:03:00.9283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtjXVdXW/tOLOQffyLG2ZNmRVrEhEgEv+IGL/Ge2O0NcVIZ8FBybsf/uMZK+M3fyQz+6BEbcOKWIB2qQDlhamA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6312
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

> Subject: [PATCH v2 14/15] net/ice: enable context desc offloads for vecto=
r Tx
>=20
> Use the context descriptor Tx vector paths from intel/common in ice
> driver to enable more offloads on the vector path for ice driver.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/rel_notes/release_26_11.rst      |  6 ++++
>  drivers/net/intel/ice/ice_ethdev.h          |  3 ++
>  drivers/net/intel/ice/ice_rxtx.c            | 31 ++++++++++++++++++---
>  drivers/net/intel/ice/ice_rxtx.h            | 11 ++++++++
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 24 ++++++++++++++++
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 24 ++++++++++++++++
>  6 files changed, 95 insertions(+), 4 deletions(-)
>=20
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
> +* **Updated Intel ice driver.**
> +
> +  * Added Tx context descriptor support to the AVX2 and AVX512 vector Tx
> +    paths, enabling QinQ tag insertion and outer IPv4/UDP checksum
> +    offloads on those paths.

Check if any updates are needed to the ice.ini features file, now that thes=
e
new offloads are supported.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> +
>=20

