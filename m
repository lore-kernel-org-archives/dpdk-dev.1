Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D33CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 15:52:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FBA240272;
	Mon, 12 Oct 2026 17:52:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2AF354026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 17:52:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791820373; x=1823356373;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=1cc7S2rGRJDBVBTR68sZQdNG2qaSJfsTWJhccbgoSS4=;
 b=MwgOiE0uYSmKuwy+vVngIm4je2BUz+1gyyyRlPeATLWVQCB/WcMD1xmz
 q9dcfXHKtQeuN1xDFPKwQK6/Q72YwMtWho/C0ssOom/eIOtHbS7qvnKkh
 EaUnT2Hm8fm2rRfDjLc7iiAblkYYmxyHJpJq1KLbg6uzmKmzVZliKWCI6
 yZzFeXRko/vZSpo2wdip640PM0yB4ECsFVn+Mw01tnDLTJsOC2lbs89Wc
 6sYY2AeOrDtF65lGFx1p5lTqxRec3wBL/K7RiAeB1esyKcnKYQFp8DmT2
 QF+Xn/ks2/u5PZhQh9u6z1wRXAtKLMKG1rh4TSgApfFop7TlWrwh5P/YW A==;
X-CSE-ConnectionGUID: s2Jrb6y6TSymG7PAVD80HA==
X-CSE-MsgGUID: 0er87pn5Q7mwu0Lpn+0r8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="426153"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="426153"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 08:52:51 -0700
X-CSE-ConnectionGUID: 2ae62ZJkTVeI+P6PMUVT8A==
X-CSE-MsgGUID: OkM8kxlBQBixxgHvldQ5Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1251067"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 08:52:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 08:52:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 08:52:50 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 08:52:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eptns6ehsoGMkmb3l09qxT6FJaVCkGuhuIGpB11egOUVaG7WhAaPlMT8fBouCO/T1n1M6U1nKdXHO/T84Mtied59tsRJyvQX1USEpN2PuaVTdKT1WQs7OVUskqYke2lrC+MI5IBpOOtTZxZVutupNNYXoNpqfMQdtSYyVos9PQFy0FGzmPExGgsDQKBLNOUkly2LjrEALiJCrTSRwBxsPvNE6FTrNIpp/0oUO18jYIAQlfDqRz9tL+qnzaDW3QnaJ3wTE9q1jcxe8ohYqqeg+cr9xZUFNKOJVAbA/VJRRALeYv0vqnpj83vXPVnxU43OAdGeMbnuCRVxPALa4DQcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0zuXG2+4yX7P0o4Oz1vbOpkua6IBJh6XUU3d2d/PsU=;
 b=aGFEVPW84BiNHtKQae1v8QKRnzRV54nn9ZIPLe3AF2lTa6EgYIcAaXvGu+U53ble5bZZ/anRp9iWryVCTMg0OGwMMjr7IjioEGFcqVjXXr79sznRxJUtLKm91wKLtxw77UMUhm6chYRhuQd5PxHCrbh8BFXWTyz2vdpp2CbBcE2wqZGelOpuNUApYt/Qdewe9b7kt6gLmvM72/dAH6t/rxrvXdG6arl8++KhgQBe50Jg1f0H+5D76OFjJp8R9eS2i5r5VQKiztMuHOTZtTBFEyrHsQWosADqNTOHXKD1h8d06SOKS/DtQ3eTuxch3y7m+tr7Ckj4si4ZN/EoJ/BKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
 by BL1PR11MB5254.namprd11.prod.outlook.com (2603:10b6:208:313::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 15:52:48 +0000
Received: from MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::45ad:ed1:a048:ac11]) by MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::45ad:ed1:a048:ac11%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 15:52:47 +0000
From: "Cornu, Marcel D" <marcel.d.cornu@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 1/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Thread-Topic: [PATCH v3 1/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Thread-Index: AQHdWlI3LpN+Ff3FakqqQ5uCA5FI6Lb6DRFg
Date: Mon, 12 Oct 2026 15:52:47 +0000
Message-ID: <MN0PR11MB62800F43FA65D89505A0DDBADA9F2@MN0PR11MB6280.namprd11.prod.outlook.com>
References: <20261012135947.1895429-1-radu.nicolau@intel.com>
 <20261012135947.1895429-2-radu.nicolau@intel.com>
In-Reply-To: <20261012135947.1895429-2-radu.nicolau@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6280:EE_|BL1PR11MB5254:EE_
x-ms-office365-filtering-correlation-id: 78a61125-2a85-48ac-ab7c-08df2878dcd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|22082099003|18002099003|3023799007|13003099007|38070700021|11063799006|261009223027099003|4143699003|56012099006;
x-microsoft-antispam-message-info: i4CntK1hgr1hALQGI34h6wY74Gnm/HVvNJDXu6dOTNlCa6k7dOZFcH7ob04W+MisWJXqM+bSrlaGi4feu0adh3202BXmat3icfD90fDGkn7KtMLvMjQ6PGyGM5koonCQ0S/XGoKyHjZeoWbxQ3PRwwQ71a9J+o/r2b9zXxi/UZdsUXfex8yXWth4gNMcvnJYFL875Woo1njLpv1T7TXGbcd/295UIFVEQwTyaDJ9f1CXTVlNnMOEx1M7jAOvODbsNYE8EpFNP76BhRwAdTCwZPJVGmtQWb0vGGTLWw0Wgq5eLpkaN3MLD2EOBxHQkiZyjWvPqSZBOZCOlaHh6GFjw4x/1hV1KfyrgbaFzh0/k9Y16/p7G5828l1YhJoNZtAHDChR7CR1tFOMP3A1OngIfsvdVWyamKWy4rkKpuY8S0HMzza3sDYBhRMwI0yqVPwix5739Seb6BrmBU1GJtqNhuXe9L1NQVkpyOfNmLGkfMl6EK4tZ1AFWCIkOITTLybEn0LaL+Q2f0nlmazQre2PPtsAFFnfZ+QFdVvhQ0oQT1VKGfoPlN96Lo1AhMfjoERNpHuIz9TnxT81k6SorlsIyOTd1Jx5qNBJjZcK+RpnVVkd4+HiMSQkE55nDklztqHNJ+39+5hf4930OjB3P8qhhlTRGsgwxSAYvm6zXWF18RE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6280.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(13003099007)(38070700021)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IliRU7IqDDynay4qT3F/Jxs9AxhbnyDT6mylsYEN2r0KIJjCJlDr2sM8SOYm?=
 =?us-ascii?Q?dsLUDYuRRbue9kjIv7EMT4WXs1fyIYNiL2CToIWtqV/nPxToYptu8k2kRVS2?=
 =?us-ascii?Q?noEphRSNadTlOPfvl8LRQAOBb5C2zB4Kg02gaudI47muz1mxJJSpoBHMJFpw?=
 =?us-ascii?Q?G2waX33Ru8c9sI4KmjnlBcmm0ckcUq5ckWXy2W3rpO4/SMlooypbVmM+w4w4?=
 =?us-ascii?Q?xbYfwMO2WUsP+QSKqlbgtnDeUYKKzJ5Onhp2lMCrzlm+G6270vL4/K787O3N?=
 =?us-ascii?Q?vMeLlBdsvral7YBk6iGwW0xQUwMriDisQIdp+XSrIkdOqdCLd10xINAbmX3N?=
 =?us-ascii?Q?b0LVGtBHMkp7RCocR2/+75LvlPBT2B6pPrRrzE0qlmzxnF6IiAhnzjInTCjh?=
 =?us-ascii?Q?CL5P/eVbzWALA2G95+ldXK1qddyfFJ6oOI6YvUsW+6fDhLz7I9MZ6158ds4j?=
 =?us-ascii?Q?1xXzUeBl510P5/n9+Mmfv/RnhypkPgw1ZdX11XB7IAhp837WEI1zigJTorPz?=
 =?us-ascii?Q?hAw6n1mF3FQxncHwd4u3Q/oYVHRbxCc4O7Gz9eqoSlKjNuejlnfrbTYdm2eO?=
 =?us-ascii?Q?2Caa1frjgZh0/uEoomrrRgE5X9AYwJ1KW+joyrQc1vL5mPfpS/VWis4C1lyc?=
 =?us-ascii?Q?UJidJr66Y7OoxJSnzvZlvd87HrFmzehYjESHHyY2y4tB4hdyhiqduX4a7yD5?=
 =?us-ascii?Q?dveNYix7L45sRg0/llKvh5fiphFL5FF+CD1G9KTqY/f+CquSVqRviIAZ5TAh?=
 =?us-ascii?Q?YzEW1sMn3w5v7R5247Jz0TOr+9UUMZVbHHfzcPywAQmvK6YtN4xkUljYqnBb?=
 =?us-ascii?Q?BwoR9iwoCQ2GqBLu5JSn+GpdCd7GBmJ5TLGnNGtOywdsb3OoO1LQoqO0UWtE?=
 =?us-ascii?Q?xFkBUHhei/Ey6ABidMRrWx1hry6zhJwvsB4onOzwXNJgMxXq4qbAJjKxMDsh?=
 =?us-ascii?Q?8WWbgUAUC6AbOgPlOchJ2eXC0HbKVpiJu3df2Pp49su2GiwAVIUaTXgCRGni?=
 =?us-ascii?Q?mUqICjVuBA9jjIb1PT8ebzDvlFl7xAnszncsmvKx4bJ50tvQLlpKC147Ts2+?=
 =?us-ascii?Q?HNu+4UAProbx/U2HC9ykAvtqo7ppY0Qaue6VwhF/mqOeJQOyB4E9irmt8HAZ?=
 =?us-ascii?Q?C5ieteET51as8r8sJgpfLV3pyi8zcT5m2xxOKenLP7Ce3qmc9zst6U53nTey?=
 =?us-ascii?Q?sRZ1ymtKllVSP1/682B83MpkLBE7lcjTObohWv8YjBZom53mqcuoSCcqonaN?=
 =?us-ascii?Q?D7pjL8qkkk3o8FhmCCetzZx4X2vZ31nqa8Prl4C8M9ceDcBv7duL/mRoMfR1?=
 =?us-ascii?Q?4w+kCa0u/0uVE+uoGoD3dS2ybKgK6jYm8DAOz+5dllNSZYXNqtVG/vTbop9E?=
 =?us-ascii?Q?BaVt9Av5uvDmGT9YH8dtFlsMoCqFIS34qFfX8FO1KQjhVaZ6/vv1wq5ryGZG?=
 =?us-ascii?Q?XSWrUyqMFfZdQ5qXEDkoKTWZTaJKHuC/eB9GmPzB9aqimbP5OVd9PYpW/mke?=
 =?us-ascii?Q?PbB6G15EL8jZXx6tFi40LqjQ43Qx3dtm3gHf16exBiNfnmRffjEo2d+14Xj8?=
 =?us-ascii?Q?5bOdXpErz2Apn/ofPcchllcHycM5ZSqARuk6ThW40a9mNK+2scert6q1Lv/F?=
 =?us-ascii?Q?hz9FAOoLgHLsLP0LSTQigaQDzBqmEV9dqbdGB+ASaYzGX/qWHdd1XJziV2RT?=
 =?us-ascii?Q?NLRqze45ufZbLI0kMH+8JZNsJG7I2QVFTRFWrSY0RATqUxpu20Iul2c/9+PW?=
 =?us-ascii?Q?3IRiNpEcfw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zY7QxwgaDwn+22Y+mrMgwekaPyE6Aj9jyXGaD/lINGPbMVQFdLVkETy3zW6hJZcqetfrXaEG3nzqAhRiv8O/3QXgdRRULPqAs6ri6SOWRyeOHeK1dA1HXq11URr5GXbLUPcN29P5zgUwlwqZMi9Hmgy1lNlpDu6YWs3tFW98IoVLijUAxvuwKJCy7r5iGA3maj50SLjzEVFJ7JJ2oaNewKibuf5GJ2p6CE571epfX5K12x0AhCSHP/Gpt+He9r8txbX5rNU7E/6Wn5pIS67LBqXENAoeXRrBKarSy/xbl896kdTPZu8dkcrh3vfmj84IjzICDJL0+W3gO5iz/ibB7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6280.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a61125-2a85-48ac-ab7c-08df2878dcd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 15:52:47.5401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vv61INUHTRTQVVnbgP+xGhtSdhhRNeQfaEVcucIUdSepZkMkBJXsqieefmYpaVOQ6MYtYZztPWco211BmJeuKE5HDr5o977l3qMfRUnqM44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5254
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
> From: Radu Nicolau <radu.nicolau@intel.com>
> Sent: Monday 12 October 2026 14:59
> To: dev@dpdk.org
> Cc: Nicolau, Radu <radu.nicolau@intel.com>; Ji, Kai <kai.ji@intel.com>; D=
e Lara
> Guarch, Pablo <pablo.de.lara.guarch@intel.com>
> Subject: [PATCH v3 1/4] crypto/ipsec_mb: add support for IPsecMB 3.0
>=20
> Add support for IPsecMB release 3.0
>  - removed all _BITLEN enums, all lengths are in bytes
>  - removed feature flag
>  - use non const IMB_MGR
>  - use IMB API instead of function pointers in the GCM PMD
>  - remove ZUC 256 support
>=20
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> ---
>  doc/guides/cryptodevs/aesni_gcm.rst          |   4 +-
>  doc/guides/cryptodevs/aesni_mb.rst           |  11 +-
>  doc/guides/rel_notes/release_26_11.rst       |   4 +
>  drivers/crypto/ipsec_mb/pmd_aesni_gcm.c      | 267 +++++++++++++++----
>  drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |  31 +--
>  drivers/crypto/ipsec_mb/pmd_aesni_mb.c       | 107 +++++---
>  drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h  |  47 +++-
>  7 files changed, 349 insertions(+), 122 deletions(-)
>=20
> diff --git a/doc/guides/cryptodevs/aesni_gcm.rst
> b/doc/guides/cryptodevs/aesni_gcm.rst
> index aefc1cedcb..e68dc4eb1e 100644
> --- a/doc/guides/cryptodevs/aesni_gcm.rst
> +++ b/doc/guides/cryptodevs/aesni_gcm.rst
> @@ -40,8 +40,8 @@ Installation
>  To build DPDK with the AESNI_GCM_PMD the user is required to download
> the multi-buffer  library from `here <https://github.com/01org/intel-ipse=
c-
> mb>`_
>  and compile it on their user system before building DPDK.
> -The latest version of the library supported by this PMD is v2.0, which -=
can be
> downloaded from `<https://github.com/01org/intel-ipsec-
> mb/archive/v2.0.zip>`_.
> +The latest version of the library supported by this PMD is v3.0, which
> +can be downloaded from `<https://github.com/01org/intel-ipsec-
> mb/archive/v3.0.zip>`_.
>=20
>  For Arm system, ARM64 port of the multi-buffer library can be downloaded
> from  https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-
> /tree/main/.
> diff --git a/doc/guides/cryptodevs/aesni_mb.rst
> b/doc/guides/cryptodevs/aesni_mb.rst
> index add3c03b74..4851997fd9 100644
> --- a/doc/guides/cryptodevs/aesni_mb.rst
> +++ b/doc/guides/cryptodevs/aesni_mb.rst
> @@ -73,6 +73,13 @@ Protocol offloads:
>=20
>  * RTE_SECURITY_PROTOCOL_DOCSIS
>=20
> +Note
> +----
> +Version 3.0 of the multi-buffer library removed support for:
> +
> +* the 256 bit versions of ZUC EEA3 and ZUC EIA3 algorithms.
> +* non byte aligned bit length
> (``RTE_CRYPTODEV_FF_NON_BYTE_ALIGNED_DATA`` removed).
> +
>  Limitations
>  -----------
>=20
> @@ -96,8 +103,8 @@ Installation
>  To build DPDK with the AESNI_MB_PMD the user is required to download the
> multi-buffer  library from `here <https://github.com/01org/intel-ipsec-mb=
>`_
>  and compile it on their user system before building DPDK.
> -The latest version of the library supported by this PMD is v2.0, which -=
can be
> downloaded from `<https://github.com/01org/intel-ipsec-
> mb/archive/v2.0.zip>`_.
> +The latest version of the library supported by this PMD is v3.0, which
> +can be downloaded from `<https://github.com/01org/intel-ipsec-
> mb/archive/v3.0.zip>`_.
This URL is outdated. It could be updated to https://github.com/intel/intel=
-ipsec-mb/archive/refs/tags/v3.0.0.zip
>=20
>  For Arm system, ARM64 port of the multi-buffer library can be downloaded
> from  https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-
> /tree/main/.
> diff --git a/doc/guides/rel_notes/release_26_11.rst
> b/doc/guides/rel_notes/release_26_11.rst
> index a19e9df3b4..099582b8e9 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -33,6 +33,10 @@ New Features
>    ``pss_salt`` field in ``rte_crypto_rsa_op_param`` to carry it per
>    sign operation.
>=20
> +* **Updated AESNI_MB crypto driver.**
> +
> +  * Added support for version 3.0 of IPsec MB Library.
> +
>  .. This section should contain new features added in this release.
>     Sample format:
>=20
> diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
> b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
> index 3c266cc47e..0c4358a7b1 100644
> --- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
> +++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
> @@ -6,56 +6,205 @@
>=20
>  #include "pmd_aesni_gcm_priv.h"
>=20
> +/* wrapper functions for library versions < 3.0.0 */ #if IMB_VERSION(3,
> +0, 0) > IMB_VERSION_NUM
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gcm_pre(const void *ke=
y, \
> +		struct gcm_key_data *key_data, IMB_MGR *state) \ { \
> +	state->gcm##bitlen##_pre(key, key_data); \ }
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gcm_init( \
> +		const struct gcm_key_data *key_data, \
> +		struct gcm_context_data *context_data, const void *iv, \
> +		const void *aad, uint64_t aad_len, IMB_MGR *state) \ { \
> +	state->gcm##bitlen##_init(key_data, context_data, iv, aad, aad_len); \
> +}
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc( \
> +		const struct gcm_key_data *key_data, \
> +		struct gcm_context_data *context_data, void *out, \
> +		const void *in, uint64_t len, const void *iv, \
> +		const void *aad, uint64_t aad_len, void *auth_tag, \
> +		uint64_t auth_tag_len, IMB_MGR *state) \ { \
> +	state->gcm##bitlen##_enc(key_data, context_data, out, in, len, iv, \
> +			aad, aad_len, auth_tag, auth_tag_len); \ }
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc_update( \
> +		const struct gcm_key_data *key_data, \
> +		struct gcm_context_data *context_data, void *out, \
> +		const void *in, const uint64_t len, IMB_MGR *state) \ { \
> +	state->gcm##bitlen##_enc_update(key_data, context_data, out, in,
> len);
> +\ }
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc_finalize( \
> +		const struct gcm_key_data *key_data, \
> +		struct gcm_context_data *context_data, void *auth_tag, \
> +		const uint64_t auth_tag_len, IMB_MGR *state) \ { \
> +	state->gcm##bitlen##_enc_finalize(key_data, context_data, auth_tag,
> \
> +			auth_tag_len); \
> +}
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec( \
> +		const struct gcm_key_data *key_data, \
> +		struct gcm_context_data *context_data, void *out, \
> +		const void *in, uint64_t len, const void *iv, \
> +		const void *aad, uint64_t aad_len, void *auth_tag, \
> +		uint64_t auth_tag_len, IMB_MGR *state) \ { \
> +	state->gcm##bitlen##_dec(key_data, context_data, out, in, len, iv, \
> +			aad, aad_len, auth_tag, auth_tag_len); \ }
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec_update( \
> +		const struct gcm_key_data *key_data, \
> +		struct gcm_context_data *context_data, void *out, \
> +		const void *in, const uint64_t len, IMB_MGR *state) \ { \
> +	state->gcm##bitlen##_dec_update(key_data, context_data, out, in,
> len);
> +\ }
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec_finalize( \
> +		const struct gcm_key_data *key_data, \
> +		struct gcm_context_data *context_data, void *auth_tag, \
> +		const uint64_t auth_tag_len, IMB_MGR *state) \ { \
> +	state->gcm##bitlen##_dec_finalize(key_data, context_data, auth_tag,
> \
> +			auth_tag_len); \
> +}
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gmac_init( \
> +		const struct gcm_key_data *key_data, \
> +		struct gcm_context_data *context_data, const void *iv, \
> +		const uint64_t iv_len, IMB_MGR *state) \ { \
> +	state->gmac##bitlen##_init(key_data, context_data, iv, iv_len); \ }
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gmac_update( \
> +		const struct gcm_key_data *key_data, \
> +		struct gcm_context_data *context_data, const void *in, \
> +		const uint64_t len, IMB_MGR *state) \ { \
> +	state->gmac##bitlen##_update(key_data, context_data, in, len); \ }
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#define _fn(bitlen) static void imb_aes##bitlen##_gmac_finalize( \
> +		const struct gcm_key_data *key_data, \
> +		struct gcm_context_data *context_data, void *auth_tag, \
> +		const uint64_t auth_tag_len, IMB_MGR *state) \ { \
> +	state->gmac##bitlen##_finalize(key_data, context_data, auth_tag, \
> +			auth_tag_len); \
> +}
> +_fn(128)
> +_fn(192)
> +_fn(256)
> +#undef _fn
> +
> +#endif
> +
>  static void
>  aesni_gcm_set_ops(struct aesni_gcm_ops *ops, IMB_MGR *mb_mgr)  {
> +	/* Set IMB_MGR pointers. */
> +	ops[GCM_KEY_128].mb_mgr =3D mb_mgr;
> +	ops[GCM_KEY_192].mb_mgr =3D mb_mgr;
> +	ops[GCM_KEY_256].mb_mgr =3D mb_mgr;
> +
>  	/* Set 128 bit function pointers. */
> -	ops[GCM_KEY_128].pre =3D mb_mgr->gcm128_pre;
> -	ops[GCM_KEY_128].init =3D mb_mgr->gcm128_init;
> +	ops[GCM_KEY_128].pre =3D imb_aes128_gcm_pre;
> +	ops[GCM_KEY_128].init =3D imb_aes128_gcm_init;
>=20
> -	ops[GCM_KEY_128].enc =3D mb_mgr->gcm128_enc;
> -	ops[GCM_KEY_128].update_enc =3D mb_mgr->gcm128_enc_update;
> -	ops[GCM_KEY_128].finalize_enc =3D mb_mgr->gcm128_enc_finalize;
> +	ops[GCM_KEY_128].enc =3D imb_aes128_gcm_enc;
> +	ops[GCM_KEY_128].update_enc =3D imb_aes128_gcm_enc_update;
> +	ops[GCM_KEY_128].finalize_enc =3D imb_aes128_gcm_enc_finalize;
>=20
> -	ops[GCM_KEY_128].dec =3D mb_mgr->gcm128_dec;
> -	ops[GCM_KEY_128].update_dec =3D mb_mgr->gcm128_dec_update;
> -	ops[GCM_KEY_128].finalize_dec =3D mb_mgr->gcm128_dec_finalize;
> +	ops[GCM_KEY_128].dec =3D imb_aes128_gcm_dec;
> +	ops[GCM_KEY_128].update_dec =3D imb_aes128_gcm_dec_update;
> +	ops[GCM_KEY_128].finalize_dec =3D imb_aes128_gcm_dec_finalize;
>=20
> -	ops[GCM_KEY_128].gmac_init =3D mb_mgr->gmac128_init;
> -	ops[GCM_KEY_128].gmac_update =3D mb_mgr->gmac128_update;
> -	ops[GCM_KEY_128].gmac_finalize =3D mb_mgr->gmac128_finalize;
> +	ops[GCM_KEY_128].gmac_init =3D imb_aes128_gmac_init;
> +	ops[GCM_KEY_128].gmac_update =3D imb_aes128_gmac_update;
> +	ops[GCM_KEY_128].gmac_finalize =3D imb_aes128_gmac_finalize;
>=20
>  	/* Set 192 bit function pointers. */
> -	ops[GCM_KEY_192].pre =3D mb_mgr->gcm192_pre;
> -	ops[GCM_KEY_192].init =3D mb_mgr->gcm192_init;
> +	ops[GCM_KEY_192].pre =3D imb_aes192_gcm_pre;
> +	ops[GCM_KEY_192].init =3D imb_aes192_gcm_init;
>=20
> -	ops[GCM_KEY_192].enc =3D mb_mgr->gcm192_enc;
> -	ops[GCM_KEY_192].update_enc =3D mb_mgr->gcm192_enc_update;
> -	ops[GCM_KEY_192].finalize_enc =3D mb_mgr->gcm192_enc_finalize;
> +	ops[GCM_KEY_192].enc =3D imb_aes192_gcm_enc;
> +	ops[GCM_KEY_192].update_enc =3D imb_aes192_gcm_enc_update;
> +	ops[GCM_KEY_192].finalize_enc =3D imb_aes192_gcm_enc_finalize;
>=20
> -	ops[GCM_KEY_192].dec =3D mb_mgr->gcm192_dec;
> -	ops[GCM_KEY_192].update_dec =3D mb_mgr->gcm192_dec_update;
> -	ops[GCM_KEY_192].finalize_dec =3D mb_mgr->gcm192_dec_finalize;
> +	ops[GCM_KEY_192].dec =3D imb_aes192_gcm_dec;
> +	ops[GCM_KEY_192].update_dec =3D imb_aes192_gcm_dec_update;
> +	ops[GCM_KEY_192].finalize_dec =3D imb_aes192_gcm_dec_finalize;
>=20
> -	ops[GCM_KEY_192].gmac_init =3D mb_mgr->gmac192_init;
> -	ops[GCM_KEY_192].gmac_update =3D mb_mgr->gmac192_update;
> -	ops[GCM_KEY_192].gmac_finalize =3D mb_mgr->gmac192_finalize;
> +	ops[GCM_KEY_192].gmac_init =3D imb_aes192_gmac_init;
> +	ops[GCM_KEY_192].gmac_update =3D imb_aes192_gmac_update;
> +	ops[GCM_KEY_192].gmac_finalize =3D imb_aes192_gmac_finalize;
>=20
>  	/* Set 256 bit function pointers. */
> -	ops[GCM_KEY_256].pre =3D mb_mgr->gcm256_pre;
> -	ops[GCM_KEY_256].init =3D mb_mgr->gcm256_init;
> +	ops[GCM_KEY_256].pre =3D imb_aes256_gcm_pre;
> +	ops[GCM_KEY_256].init =3D imb_aes256_gcm_init;
>=20
> -	ops[GCM_KEY_256].enc =3D mb_mgr->gcm256_enc;
> -	ops[GCM_KEY_256].update_enc =3D mb_mgr->gcm256_enc_update;
> -	ops[GCM_KEY_256].finalize_enc =3D mb_mgr->gcm256_enc_finalize;
> +	ops[GCM_KEY_256].enc =3D imb_aes256_gcm_enc;
> +	ops[GCM_KEY_256].update_enc =3D imb_aes256_gcm_enc_update;
> +	ops[GCM_KEY_256].finalize_enc =3D imb_aes256_gcm_enc_finalize;
>=20
> -	ops[GCM_KEY_256].dec =3D mb_mgr->gcm256_dec;
> -	ops[GCM_KEY_256].update_dec =3D mb_mgr->gcm256_dec_update;
> -	ops[GCM_KEY_256].finalize_dec =3D mb_mgr->gcm256_dec_finalize;
> +	ops[GCM_KEY_256].dec =3D imb_aes256_gcm_dec;
> +	ops[GCM_KEY_256].update_dec =3D imb_aes256_gcm_dec_update;
> +	ops[GCM_KEY_256].finalize_dec =3D imb_aes256_gcm_dec_finalize;
>=20
> -	ops[GCM_KEY_256].gmac_init =3D mb_mgr->gmac256_init;
> -	ops[GCM_KEY_256].gmac_update =3D mb_mgr->gmac256_update;
> -	ops[GCM_KEY_256].gmac_finalize =3D mb_mgr->gmac256_finalize;
> +	ops[GCM_KEY_256].gmac_init =3D imb_aes256_gmac_init;
> +	ops[GCM_KEY_256].gmac_update =3D imb_aes256_gmac_update;
> +	ops[GCM_KEY_256].gmac_finalize =3D imb_aes256_gmac_finalize;
>  }
>=20
>  static int
> @@ -135,15 +284,15 @@ aesni_gcm_session_configure(IMB_MGR
> *mb_mgr, void *session,
>  	switch (key_length) {
>  	case 16:
>  		sess->key_length =3D GCM_KEY_128;
> -		mb_mgr->gcm128_pre(key, &sess->gdata_key);
> +		imb_aes128_gcm_pre(key, &sess->gdata_key, mb_mgr);
>  		break;
>  	case 24:
>  		sess->key_length =3D GCM_KEY_192;
> -		mb_mgr->gcm192_pre(key, &sess->gdata_key);
> +		imb_aes192_gcm_pre(key, &sess->gdata_key, mb_mgr);
>  		break;
>  	case 32:
>  		sess->key_length =3D GCM_KEY_256;
> -		mb_mgr->gcm256_pre(key, &sess->gdata_key);
> +		imb_aes256_gcm_pre(key, &sess->gdata_key, mb_mgr);
>  		break;
>  	default:
>  		IPSEC_MB_LOG(ERR, "Invalid key length"); @@ -324,10
> +473,10 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct
> rte_crypto_op *op,
>  	if (session->op =3D=3D IPSEC_MB_OP_AEAD_AUTHENTICATED_ENCRYPT) {
>  		ops->init(&session->gdata_key, &qp_data->gcm_ctx_data,
> iv_ptr,
>  				sym_op->aead.aad.data,
> -				(uint64_t)session->aad_length);
> +				(uint64_t)session->aad_length, ops-
> >mb_mgr);
>=20
>  		ops->update_enc(&session->gdata_key, &qp_data-
> >gcm_ctx_data,
> -				dst, src, (uint64_t)part_len);
> +				dst, src, (uint64_t)part_len, ops->mb_mgr);
>  		total_len =3D data_length - part_len;
>=20
>  		while (total_len) {
> @@ -345,7 +494,7 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp,
> struct rte_crypto_op *op,
>=20
>  			ops->update_enc(&session->gdata_key,
>  					&qp_data->gcm_ctx_data,
> -					dst, src, (uint64_t)part_len);
> +					dst, src, (uint64_t)part_len, ops-
> >mb_mgr);
>  			total_len -=3D part_len;
>  		}
>=20
> @@ -355,14 +504,14 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp,
> struct rte_crypto_op *op,
>  			tag =3D sym_op->aead.digest.data;
>=20
>  		ops->finalize_enc(&session->gdata_key, &qp_data-
> >gcm_ctx_data,
> -				tag, session->gen_digest_length);
> +				tag, session->gen_digest_length, ops-
> >mb_mgr);
>  	} else if (session->op =3D=3D
> IPSEC_MB_OP_AEAD_AUTHENTICATED_DECRYPT) {
>  		ops->init(&session->gdata_key, &qp_data->gcm_ctx_data,
> iv_ptr,
>  				sym_op->aead.aad.data,
> -				(uint64_t)session->aad_length);
> +				(uint64_t)session->aad_length, ops-
> >mb_mgr);
>=20
>  		ops->update_dec(&session->gdata_key, &qp_data-
> >gcm_ctx_data,
> -				dst, src, (uint64_t)part_len);
> +				dst, src, (uint64_t)part_len, ops->mb_mgr);
>  		total_len =3D data_length - part_len;
>=20
>  		while (total_len) {
> @@ -380,19 +529,19 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp,
> struct rte_crypto_op *op,
>=20
>  			ops->update_dec(&session->gdata_key,
>  					&qp_data->gcm_ctx_data,
> -					dst, src, (uint64_t)part_len);
> +					dst, src, (uint64_t)part_len, ops-
> >mb_mgr);
>  			total_len -=3D part_len;
>  		}
>=20
>  		tag =3D qp_data->temp_digest;
>  		ops->finalize_dec(&session->gdata_key, &qp_data-
> >gcm_ctx_data,
> -				tag, session->gen_digest_length);
> +				tag, session->gen_digest_length, ops-
> >mb_mgr);
>  	} else if (session->op =3D=3D IPSEC_MB_OP_HASH_GEN_ONLY) {
>  		ops->gmac_init(&session->gdata_key, &qp_data-
> >gcm_ctx_data,
> -				iv_ptr, session->iv.length);
> +				iv_ptr, session->iv.length, ops->mb_mgr);
>=20
>  		ops->gmac_update(&session->gdata_key, &qp_data-
> >gcm_ctx_data,
> -				src, (uint64_t)part_len);
> +				src, (uint64_t)part_len, ops->mb_mgr);
>  		total_len =3D data_length - part_len;
>=20
>  		while (total_len) {
> @@ -406,7 +555,7 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp,
> struct rte_crypto_op *op,
>=20
>  			ops->gmac_update(&session->gdata_key,
>  					&qp_data->gcm_ctx_data, src,
> -					(uint64_t)part_len);
> +					(uint64_t)part_len, ops->mb_mgr);
>  			total_len -=3D part_len;
>  		}
>=20
> @@ -416,13 +565,13 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp,
> struct rte_crypto_op *op,
>  			tag =3D sym_op->auth.digest.data;
>=20
>  		ops->gmac_finalize(&session->gdata_key, &qp_data-
> >gcm_ctx_data,
> -				tag, session->gen_digest_length);
> +				tag, session->gen_digest_length, ops-
> >mb_mgr);
>  	} else { /* IPSEC_MB_OP_HASH_VERIFY_ONLY */
>  		ops->gmac_init(&session->gdata_key, &qp_data-
> >gcm_ctx_data,
> -				iv_ptr, session->iv.length);
> +				iv_ptr, session->iv.length, ops->mb_mgr);
>=20
>  		ops->gmac_update(&session->gdata_key, &qp_data-
> >gcm_ctx_data,
> -				src, (uint64_t)part_len);
> +				src, (uint64_t)part_len, ops->mb_mgr);
>  		total_len =3D data_length - part_len;
>=20
>  		while (total_len) {
> @@ -436,14 +585,14 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp,
> struct rte_crypto_op *op,
>=20
>  			ops->gmac_update(&session->gdata_key,
>  					&qp_data->gcm_ctx_data, src,
> -					(uint64_t)part_len);
> +					(uint64_t)part_len, ops->mb_mgr);
>  			total_len -=3D part_len;
>  		}
>=20
>  		tag =3D qp_data->temp_digest;
>=20
>  		ops->gmac_finalize(&session->gdata_key, &qp_data-
> >gcm_ctx_data,
> -				tag, session->gen_digest_length);
> +				tag, session->gen_digest_length, ops-
> >mb_mgr);
>  	}
>  	return 0;
>  }
> @@ -540,11 +689,11 @@ aesni_gcm_sgl_op_finalize_encryption(const struct
> aesni_gcm_session *s,
>  		uint8_t tmpdigest[s->gen_digest_length];
>=20
>  		ops.finalize_enc(&s->gdata_key, gdata_ctx, tmpdigest,
> -				s->gen_digest_length);
> +				s->gen_digest_length, ops.mb_mgr);
>  		memcpy(digest, tmpdigest, s->req_digest_length);
>  	} else {
>  		ops.finalize_enc(&s->gdata_key, gdata_ctx, digest,
> -				s->gen_digest_length);
> +				s->gen_digest_length, ops.mb_mgr);
>  	}
>=20
>  	return 0;
> @@ -558,7 +707,7 @@ aesni_gcm_sgl_op_finalize_decryption(const struct
> aesni_gcm_session *s,
>  	uint8_t tmpdigest[s->gen_digest_length];
>=20
>  	ops.finalize_dec(&s->gdata_key, gdata_ctx, tmpdigest,
> -			s->gen_digest_length);
> +			s->gen_digest_length, ops.mb_mgr);
>=20
>  	return rte_memeq_timingsafe(digest, tmpdigest, s-
> >req_digest_length) ? 0 : EBADMSG;  } @@ -573,7 +722,7 @@
> aesni_gcm_process_gcm_sgl_op(const struct aesni_gcm_session *s,
>=20
>  	/* init crypto operation */
>  	ops.init(&s->gdata_key, gdata_ctx, iv, aad,
> -		    (uint64_t)s->aad_length);
> +		    (uint64_t)s->aad_length, ops.mb_mgr);
>=20
>  	/* update with sgl data */
>  	for (i =3D 0; i < sgl->num; i++) {
> @@ -582,11 +731,11 @@ aesni_gcm_process_gcm_sgl_op(const struct
> aesni_gcm_session *s,
>  		switch (s->op) {
>  		case IPSEC_MB_OP_AEAD_AUTHENTICATED_ENCRYPT:
>  			ops.update_enc(&s->gdata_key, gdata_ctx,
> -			      vec->base, vec->base, vec->len);
> +			      vec->base, vec->base, vec->len, ops.mb_mgr);
>  			break;
>  		case IPSEC_MB_OP_AEAD_AUTHENTICATED_DECRYPT:
>  			ops.update_dec(&s->gdata_key, gdata_ctx,
> -			      vec->base, vec->base, vec->len);
> +			      vec->base, vec->base, vec->len, ops.mb_mgr);
>  			break;
>  		default:
>  			IPSEC_MB_LOG(ERR, "Invalid session op"); @@ -
> 603,7 +752,7 @@ aesni_gcm_process_gmac_sgl_op(const struct
> aesni_gcm_session *s,
>  			      struct aesni_gcm_ops ops)
>  {
>  	ops.init(&s->gdata_key, gdata_ctx, iv, sgl->vec[0].base,
> -		    sgl->vec[0].len);
> +		    sgl->vec[0].len, ops.mb_mgr);
>  }
>=20
>  static inline uint32_t
> diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h
> b/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h
> index 8a5a41fb19..4074430d6e 100644
> --- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h
> +++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h
> @@ -79,41 +79,41 @@ enum aesni_gcm_key_length {
>=20
>  typedef void (*aesni_gcm_t)(const struct gcm_key_data *gcm_key_data,
>  			    struct gcm_context_data *gcm_ctx_data,
> -			    uint8_t *out, const uint8_t *in,
> -			    uint64_t plaintext_len, const uint8_t *iv,
> -			    const uint8_t *aad, uint64_t aad_len,
> -			    uint8_t *auth_tag, uint64_t auth_tag_len);
> +			    void *out, const void *in,
> +			    uint64_t plaintext_len, const void *iv,
> +			    const void *aad, uint64_t aad_len,
> +			    void *auth_tag, uint64_t auth_tag_len, IMB_MGR
> *state);
>=20
>  typedef void (*aesni_gcm_pre_t)(const void *key,
> -				struct gcm_key_data *gcm_data);
> +				struct gcm_key_data *gcm_data, IMB_MGR
> *state);
>=20
>  typedef void (*aesni_gcm_init_t)(const struct gcm_key_data *gcm_key_data=
,
>  				 struct gcm_context_data *gcm_ctx_data,
> -				 const uint8_t *iv, uint8_t const *aad,
> -				 uint64_t aad_len);
> +				 const void *iv, const void *aad,
> +				 uint64_t aad_len, IMB_MGR *state);
>=20
>  typedef void (*aesni_gcm_update_t)(const struct gcm_key_data
> *gcm_key_data,
>  				   struct gcm_context_data *gcm_ctx_data,
> -				   uint8_t *out, const uint8_t *in,
> -				   uint64_t plaintext_len);
> +				   void *out, const void *in,
> +				   uint64_t plaintext_len, IMB_MGR *state);
>=20
>  typedef void (*aesni_gcm_finalize_t)(const struct gcm_key_data
> *gcm_key_data,
>  				     struct gcm_context_data *gcm_ctx_data,
> -				     uint8_t *auth_tag, uint64_t auth_tag_len);
> +				     void *auth_tag, uint64_t auth_tag_len,
> IMB_MGR *state);
>=20
>  typedef void (*aesni_gmac_init_t)(const struct gcm_key_data
> *gcm_key_data,
>  				  struct gcm_context_data *gcm_ctx_data,
> -				  const uint8_t *iv, const uint64_t iv_len);
> +				  const void *iv, const uint64_t iv_len,
> IMB_MGR *state);
>=20
>  typedef void (*aesni_gmac_update_t)(const struct gcm_key_data
> *gcm_key_data,
>  				    struct gcm_context_data *gcm_ctx_data,
> -				    const uint8_t *in,
> -				    const uint64_t plaintext_len);
> +				    const void *in,
> +				    const uint64_t plaintext_len, IMB_MGR
> *state);
>=20
>  typedef void (*aesni_gmac_finalize_t)(const struct gcm_key_data
> *gcm_key_data,
>  				      struct gcm_context_data *gcm_ctx_data,
> -				      uint8_t *auth_tag,
> -				      const uint64_t auth_tag_len);
> +				      void *auth_tag,
> +				      const uint64_t auth_tag_len, IMB_MGR
> *state);
>=20
>  /** GCM operation handlers */
>  struct aesni_gcm_ops {
> @@ -128,6 +128,7 @@ struct aesni_gcm_ops {
>  	aesni_gmac_init_t gmac_init;
>  	aesni_gmac_update_t gmac_update;
>  	aesni_gmac_finalize_t gmac_finalize;
> +	IMB_MGR *mb_mgr;
>  };
>=20
>  RTE_DEFINE_PER_LCORE(struct aesni_gcm_ops,
> gcm_ops[GCM_NUM_KEY_TYPES]); diff --git
> a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> index 02bacd020b..e8f6e77d21 100644
> --- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> +++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> @@ -161,20 +161,22 @@
> aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
>=20
>  	if (xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_ZUC_EIA3) {
>  		if (xform->auth.key.length =3D=3D 16) {
> -			sess->template_job.hash_alg =3D
> IMB_AUTH_ZUC_EIA3_BITLEN;
> +			sess->template_job.hash_alg =3D IMB_AUTH_ZUC_EIA3;
>=20
>  			if (sess->auth.req_digest_len !=3D 4) {
>  				IPSEC_MB_LOG(ERR, "Invalid digest size");
>  				return -EINVAL;
>  			}
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
>  		} else if (xform->auth.key.length =3D=3D 32) {
> -			sess->template_job.hash_alg =3D
> IMB_AUTH_ZUC256_EIA3_BITLEN;
> +			sess->template_job.hash_alg =3D
> IMB_AUTH_ZUC256_EIA3;
>  			if (sess->auth.req_digest_len !=3D 4 &&
>  					sess->auth.req_digest_len !=3D 8 &&
>  					sess->auth.req_digest_len !=3D 16) {
>  				IPSEC_MB_LOG(ERR, "Invalid digest size");
>  				return -EINVAL;
>  			}
> +#endif
>  		} else {
>  			IPSEC_MB_LOG(ERR, "Invalid authentication key
> length");
>  			return -EINVAL;
> @@ -187,10 +189,10 @@
> aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
>  		sess->template_job.u.ZUC_EIA3._key =3D sess-
> >auth.zuc_auth_key;
>  		return 0;
>  	} else if (xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_SNOW3G_UIA2) {
> -		sess->template_job.hash_alg =3D
> IMB_AUTH_SNOW3G_UIA2_BITLEN;
> +		sess->template_job.hash_alg =3D IMB_AUTH_SNOW3G_UIA2;
>  		uint16_t snow3g_uia2_digest_len =3D
>  			get_truncated_digest_byte_length(
> -
> 	IMB_AUTH_SNOW3G_UIA2_BITLEN);
> +						IMB_AUTH_SNOW3G_UIA2);
>  		if (sess->auth.req_digest_len !=3D snow3g_uia2_digest_len) {
>  			IPSEC_MB_LOG(ERR, "Invalid digest size");
>  			return -EINVAL;
> @@ -339,7 +341,7 @@ aesni_mb_set_session_auth_parameters(IMB_MGR
> *mb_mgr,
>=20
>  /** Set session cipher parameters */
>  static int
> -aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
> +aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
>  		struct aesni_mb_session *sess,
>  		const struct rte_crypto_sym_xform *xform)  { @@ -407,11
> +409,11 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR
> *mb_mgr,
>  		is_zuc =3D 1;
>  		break;
>  	case RTE_CRYPTO_CIPHER_SNOW3G_UEA2:
> -		sess->template_job.cipher_mode =3D
> IMB_CIPHER_SNOW3G_UEA2_BITLEN;
> +		sess->template_job.cipher_mode =3D
> IMB_CIPHER_SNOW3G_UEA2;
>  		is_snow3g =3D 1;
>  		break;
>  	case RTE_CRYPTO_CIPHER_KASUMI_F8:
> -		sess->template_job.cipher_mode =3D
> IMB_CIPHER_KASUMI_UEA1_BITLEN;
> +		sess->template_job.cipher_mode =3D
> IMB_CIPHER_KASUMI_UEA1;
>  		is_kasumi =3D 1;
>  		break;
>  	case RTE_CRYPTO_CIPHER_NULL:
> @@ -536,8 +538,11 @@ aesni_mb_set_session_cipher_parameters(const
> IMB_MGR *mb_mgr,
>  		sess->template_job.dec_keys =3D sess-
> >cipher.exp_3des_keys.ks_ptr;
>  		sess->template_job.key_len_in_bytes =3D 24;
>  	} else if (is_zuc) {
> -		if (xform->cipher.key.length !=3D 16 &&
> -				xform->cipher.key.length !=3D 32) {
> +		if (xform->cipher.key.length !=3D 16
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
> +				&& xform->cipher.key.length !=3D 32
> +#endif
> +			) {
>  			IPSEC_MB_LOG(ERR, "Invalid cipher key length");
>  			return -EINVAL;
>  		}
> @@ -1177,19 +1182,23 @@ sgl_linear_cipher_auth_len(IMB_JOB *job,
> uint64_t *auth_len)  {
>  	uint64_t cipher_len;
>=20
> -	if (job->cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2_BITLEN ||
> -			job->cipher_mode =3D=3D
> IMB_CIPHER_KASUMI_UEA1_BITLEN)
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
> +	if (job->cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||
> +			job->cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1)
>  		cipher_len =3D (job->msg_len_to_cipher_in_bits >> 3) +
>  				(job->cipher_start_src_offset_in_bits >> 3);
>  	else
> +#endif
>  		cipher_len =3D job->msg_len_to_cipher_in_bytes +
>  				job->cipher_start_src_offset_in_bytes;
>=20
> -	if (job->hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2_BITLEN ||
> -			job->hash_alg =3D=3D IMB_AUTH_ZUC_EIA3_BITLEN)
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
> +	if (job->hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2 ||
> +			job->hash_alg =3D=3D IMB_AUTH_ZUC_EIA3)
>  		*auth_len =3D (job->msg_len_to_hash_in_bits >> 3) +
>  				job->hash_start_src_offset_in_bytes;
>  	else
> +#endif
>  		*auth_len =3D job->msg_len_to_hash_in_bytes +
>  				job->hash_start_src_offset_in_bytes;
>=20
> @@ -1457,18 +1466,20 @@ aesni_mb_digest_appended_in_src(struct
> rte_crypto_op *op, IMB_JOB *job,
>  		return NULL;
>=20
>  	if (job->cipher_mode =3D=3D IMB_CIPHER_ZUC_EEA3 ||
> -		job->cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2_BITLEN
> ||
> -		job->cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1_BITLEN) {
> +		job->cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||
> +		job->cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1) {
>  		cipher_size =3D (op->sym->cipher.data.offset >> 3) +
>  			(op->sym->cipher.data.length >> 3);
>  	} else {
>  		cipher_size =3D (op->sym->cipher.data.offset) +
>  			(op->sym->cipher.data.length);
>  	}
> -	if (job->hash_alg =3D=3D IMB_AUTH_ZUC_EIA3_BITLEN ||
> -		job->hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2_BITLEN ||
> -		job->hash_alg =3D=3D IMB_AUTH_KASUMI_UIA1 ||
> -		job->hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3_BITLEN) {
> +	if (job->hash_alg =3D=3D IMB_AUTH_ZUC_EIA3 ||
> +		job->hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2 || #if
> IMB_VERSION(3, 0, 0) >
> +IMB_VERSION_NUM
> +		job->hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3 || #endif
> +		job->hash_alg =3D=3D IMB_AUTH_KASUMI_UIA1) {
>  		auth_size =3D (op->sym->auth.data.offset >> 3) +
>  			(op->sym->auth.data.length >> 3);
>  	} else {
> @@ -1585,12 +1596,14 @@ set_mb_job_params(IMB_JOB *job, struct
> ipsec_mb_qp *qp,
>  		job->u.GMAC._iv =3D rte_crypto_op_ctod_offset(op, uint8_t *,
>  						session->auth_iv.offset);
>  		break;
> -	case IMB_AUTH_ZUC_EIA3_BITLEN:
> -	case IMB_AUTH_ZUC256_EIA3_BITLEN:
> +	case IMB_AUTH_ZUC_EIA3:
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
> +	case IMB_AUTH_ZUC256_EIA3:
> +#endif
>  		job->u.ZUC_EIA3._iv =3D rte_crypto_op_ctod_offset(op, uint8_t
> *,
>  						session->auth_iv.offset);
>  		break;
> -	case IMB_AUTH_SNOW3G_UIA2_BITLEN:
> +	case IMB_AUTH_SNOW3G_UIA2:
>  		job->u.SNOW3G_UIA2._iv =3D
>  			rte_crypto_op_ctod_offset(op, uint8_t *,
>  						session->auth_iv.offset);
> @@ -1616,12 +1629,19 @@ set_mb_job_params(IMB_JOB *job, struct
> ipsec_mb_qp *qp,
>  	else
>  		m_offset =3D op->sym->cipher.data.offset;
>=20
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
>  	if (cipher_mode =3D=3D IMB_CIPHER_ZUC_EEA3)
>  		m_offset >>=3D 3;
> -	else if (cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2_BITLEN)
> +	else if (cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2)
>  		m_offset =3D 0;
> -	else if (cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1_BITLEN)
> +	else if (cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1)
>  		m_offset =3D 0;
> +#else
> +	if (cipher_mode =3D=3D IMB_CIPHER_ZUC_EEA3 ||
> +		cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||
> +		cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1)
> +		m_offset >>=3D 3;
> +#endif
>=20
>  	/* Set digest output location */
>  	if (job->hash_alg !=3D IMB_AUTH_NULL &&
> @@ -1701,9 +1721,11 @@ set_mb_job_params(IMB_JOB *job, struct
> ipsec_mb_qp *qp,
>  				session->iv.offset);
>  		break;
>  	/* ZUC and SNOW3G require length in bits and offset in bytes */
> -	case IMB_AUTH_ZUC_EIA3_BITLEN:
> -	case IMB_AUTH_ZUC256_EIA3_BITLEN:
> -	case IMB_AUTH_SNOW3G_UIA2_BITLEN:
> +	case IMB_AUTH_ZUC_EIA3:
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
> +	case IMB_AUTH_ZUC256_EIA3:
> +#endif
> +	case IMB_AUTH_SNOW3G_UIA2:
>  		auth_off_in_bytes =3D op->sym->auth.data.offset >> 3;
>  		ciph_off_in_bytes =3D op->sym->cipher.data.offset >> 3;
>  		auth_len_in_bytes =3D op->sym->auth.data.length >> 3; @@ -
> 1714,7 +1736,11 @@ set_mb_job_params(IMB_JOB *job, struct
> ipsec_mb_qp *qp,
>  				session, oop, auth_off_in_bytes,
>  				ciph_off_in_bytes, auth_len_in_bytes,
>  				ciph_len_in_bytes, lb_sgl);
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
>  		job->msg_len_to_hash_in_bits =3D op->sym->auth.data.length;
> +#else
> +		job->msg_len_to_hash_in_bytes =3D op->sym-
> >auth.data.length >> 3;
> +#endif
>=20
>  		job->iv =3D rte_crypto_op_ctod_offset(op, uint8_t *,
>  			session->iv.offset);
> @@ -1772,12 +1798,19 @@ set_mb_job_params(IMB_JOB *job, struct
> ipsec_mb_qp *qp,
>  					op->sym->cipher.data.length >> 3;
>  		break;
>  	/* ZUC and SNOW3G require length and offset in bits */
> -	case IMB_CIPHER_SNOW3G_UEA2_BITLEN:
> -	case IMB_CIPHER_KASUMI_UEA1_BITLEN:
> +	case IMB_CIPHER_SNOW3G_UEA2:
> +	case IMB_CIPHER_KASUMI_UEA1:
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
>  		job->cipher_start_src_offset_in_bits =3D
>  					op->sym->cipher.data.offset;
>  		job->msg_len_to_cipher_in_bits =3D
>  					op->sym->cipher.data.length;
> +#else
> +		job->cipher_start_src_offset_in_bytes =3D
> +					op->sym->cipher.data.offset >> 3;
> +		job->msg_len_to_cipher_in_bytes =3D
> +					op->sym->cipher.data.length >> 3;
> +#endif
>  		break;
>  	case IMB_CIPHER_GCM:
>  		job->cipher_start_src_offset_in_bytes =3D @@ -2047,8 +2080,8
> @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB *job)
>  				aesni_mb_digest_appended_in_src(op, job,
> oop) !=3D NULL) {
>  					unsigned int auth_size, cipher_size;
>  					int unencrypted_bytes =3D 0;
> -					if (job->cipher_mode =3D=3D
> IMB_CIPHER_SNOW3G_UEA2_BITLEN ||
> -						job->cipher_mode =3D=3D
> IMB_CIPHER_KASUMI_UEA1_BITLEN ||
> +					if (job->cipher_mode =3D=3D
> IMB_CIPHER_SNOW3G_UEA2 ||
> +						job->cipher_mode =3D=3D
> IMB_CIPHER_KASUMI_UEA1 ||
>  						job->cipher_mode =3D=3D
> IMB_CIPHER_ZUC_EEA3) {
>  						cipher_size =3D (op->sym-
> >cipher.data.offset >> 3) +
>  							(op->sym-
> >cipher.data.length >> 3); @@ -2056,10 +2089,12 @@
> post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB *job)
>  						cipher_size =3D (op->sym-
> >cipher.data.offset) +
>  							(op->sym-
> >cipher.data.length);
>  					}
> -					if (job->hash_alg =3D=3D
> IMB_AUTH_ZUC_EIA3_BITLEN ||
> -						job->hash_alg =3D=3D
> IMB_AUTH_SNOW3G_UIA2_BITLEN ||
> -						job->hash_alg =3D=3D
> IMB_AUTH_KASUMI_UIA1 ||
> -						job->hash_alg =3D=3D
> IMB_AUTH_ZUC256_EIA3_BITLEN) {
> +					if (job->hash_alg =3D=3D
> IMB_AUTH_ZUC_EIA3 ||
> +						job->hash_alg =3D=3D
> IMB_AUTH_SNOW3G_UIA2 || #if IMB_VERSION(3, 0, 0)
> +> IMB_VERSION_NUM
> +						job->hash_alg =3D=3D
> IMB_AUTH_ZUC256_EIA3 || #endif
> +						job->hash_alg =3D=3D
> IMB_AUTH_KASUMI_UIA1) {
>  						auth_size =3D (op->sym-
> >auth.data.offset >> 3) +
>  							(op->sym-
> >auth.data.length >> 3);
>  					} else {
> @@ -2550,7 +2585,9 @@ RTE_INIT(ipsec_mb_register_aesni_mb)
>  			RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING |
>  			RTE_CRYPTODEV_FF_OOP_LB_IN_LB_OUT |
>  			RTE_CRYPTODEV_FF_SYM_CPU_CRYPTO |
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
>  			RTE_CRYPTODEV_FF_NON_BYTE_ALIGNED_DATA |
> +#endif
>  			RTE_CRYPTODEV_FF_SYM_SESSIONLESS |
>  			RTE_CRYPTODEV_FF_IN_PLACE_SGL |
>  			RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT | diff --
> git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
> b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
> index ad38a1e28a..6afda45414 100644
> --- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
> +++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
> @@ -19,6 +19,15 @@
>=20
>  #define MAX_NUM_SEGS 16
>=20
> +/* bit len removed in 3.0 */
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM #define
> +IMB_CIPHER_SNOW3G_UEA2 IMB_CIPHER_SNOW3G_UEA2_BITLEN #define
> +IMB_CIPHER_KASUMI_UEA1 IMB_CIPHER_KASUMI_UEA1_BITLEN #define
> +IMB_AUTH_ZUC_EIA3 IMB_AUTH_ZUC_EIA3_BITLEN #define
> IMB_AUTH_SNOW3G_UIA2
> +IMB_AUTH_SNOW3G_UIA2_BITLEN #define IMB_AUTH_ZUC256_EIA3
> +IMB_AUTH_ZUC256_EIA3_BITLEN #endif
> +
>  int
>  aesni_mb_session_configure(IMB_MGR * m __rte_unused, void *priv_sess,
>  		const struct rte_crypto_sym_xform *xform); @@ -573,8
> +582,13 @@ static const struct rte_cryptodev_capabilities
> aesni_mb_capabilities[] =3D {
>  				.block_size =3D 16,
>  				.key_size =3D {
>  					.min =3D 16,
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
>  					.max =3D 32,
>  					.increment =3D 16
> +#else
> +					.max =3D 16,
> +					.increment =3D 0
> +#endif
>  				},
>  				.digest_size =3D {
>  					.min =3D 4,
> @@ -583,8 +597,13 @@ static const struct rte_cryptodev_capabilities
> aesni_mb_capabilities[] =3D {
>  				},
>  				.iv_size =3D {
>  					.min =3D 16,
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
>  					.max =3D 25,
>  					.increment =3D 9
> +#else
> +					.max =3D 16,
> +					.increment =3D 0
> +#endif
>  				}
>  			}, }
>  		}, }
> @@ -598,13 +617,23 @@ static const struct rte_cryptodev_capabilities
> aesni_mb_capabilities[] =3D {
>  				.block_size =3D 16,
>  				.key_size =3D {
>  					.min =3D 16,
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
>  					.max =3D 32,
>  					.increment =3D 16
> +#else
> +					.max =3D 16,
> +					.increment =3D 0
> +#endif
>  				},
>  				.iv_size =3D {
>  					.min =3D 16,
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
>  					.max =3D 25,
>  					.increment =3D 9
> +#else
> +					.max =3D 16,
> +					.increment =3D 0
> +#endif
>  				},
>  			}, }
>  		}, }
> @@ -888,9 +917,9 @@ static const unsigned int auth_blocksize[] =3D {
>  		[IMB_AUTH_SHA_256]		=3D 64,
>  		[IMB_AUTH_SHA_384]		=3D 128,
>  		[IMB_AUTH_SHA_512]		=3D 128,
> -		[IMB_AUTH_ZUC_EIA3_BITLEN]	=3D 16,
> -		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	=3D 16,
> -		[IMB_AUTH_KASUMI_UIA1]		=3D 16
> +		[IMB_AUTH_ZUC_EIA3]		=3D 16,
> +		[IMB_AUTH_SNOW3G_UIA2]	=3D 16,
> +		[IMB_AUTH_KASUMI_UIA1]	=3D 16
>  };
>=20
>  /**
> @@ -922,9 +951,9 @@ static const unsigned int
> auth_truncated_digest_byte_lengths[] =3D {
>  		[IMB_AUTH_SHA_256]		=3D 32,
>  		[IMB_AUTH_SHA_384]		=3D 48,
>  		[IMB_AUTH_SHA_512]		=3D 64,
> -		[IMB_AUTH_ZUC_EIA3_BITLEN]	=3D 4,
> -		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	=3D 4,
> -		[IMB_AUTH_KASUMI_UIA1]		=3D 4
> +		[IMB_AUTH_ZUC_EIA3]		=3D 4,
> +		[IMB_AUTH_SNOW3G_UIA2]	=3D 4,
> +		[IMB_AUTH_KASUMI_UIA1]	=3D 4
>  };
>=20
>  /**
> @@ -957,9 +986,9 @@ static const unsigned int auth_digest_byte_lengths[]
> =3D {
>  		[IMB_AUTH_SHA_256]		=3D 32,
>  		[IMB_AUTH_SHA_384]		=3D 48,
>  		[IMB_AUTH_SHA_512]		=3D 64,
> -		[IMB_AUTH_ZUC_EIA3_BITLEN]	=3D 4,
> -		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	=3D 4,
> -		[IMB_AUTH_KASUMI_UIA1]		=3D 4,
> +		[IMB_AUTH_ZUC_EIA3]		=3D 4,
> +		[IMB_AUTH_SNOW3G_UIA2]	=3D 4,
> +		[IMB_AUTH_KASUMI_UIA1]	=3D 4,
>  		[IMB_AUTH_SM3]			=3D 32,
>  		[IMB_AUTH_HMAC_SM3]		=3D 32,
>  	/**< Vector mode dependent pointer table of the multi-buffer APIs */
> --
> 2.52.0

