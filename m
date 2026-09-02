Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE36FC624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 16:35:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E52EB40E48;
	Wed,  2 Sep 2026 18:35:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5F70540DD2
 for <dev@dpdk.org>; Wed,  2 Sep 2026 18:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788366901; x=1819902901;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qQZP9gyLbEykUZrcO9G56Xvf6l70/8WbOEyEzsYc/QA=;
 b=EQvGFr5UqG68XhmkF07yOY9Dn0OhJrwLXRheleRoKnz/IoDYixktL3fj
 SrdYMnfqiHiDqnD/h7SqYnpokZ4MK/tR74gpMyEPMD7L0C5uVq4TmWZmz
 pPTwrUnMvkVUsEUoqs0OjFi0+17XvGlckxQzAXrjneJ68siJQtlEHCm7E
 IGkPxvc1onrsWXg8/47hbdJNnwgrSF3JtNrcWfO/dG9eQfaHldnPRKLfO
 dexFc3qGvpUHORd7v3hjxkHy5ET1tx3Kl6Msdgwua06rqHMkTwIzd+V3K
 Omewk9bdMRlaomckNXo4sLvbC6MJTqg4Rp8JK6HXx78Dk+9CNj1UHZ8rx w==;
X-CSE-ConnectionGUID: r9QjWb0+SHamulc89JPx4g==
X-CSE-MsgGUID: bAJyOpQQRV6a4b2jNmt3hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100347501"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="100347501"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 09:34:59 -0700
X-CSE-ConnectionGUID: 6jR9p3zBQsiQP2t18CO2vw==
X-CSE-MsgGUID: Bv2rmKrrRSiirxmCzx0RiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="267690509"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 09:34:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:34:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 09:34:58 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqAfa/NMV69AoXgnElqP67nZIzgDVdiR9gvsMZn0RRadrh9D9abS0okXx3oBbdEf9uQtn0SGOOwK3VZ9/XdvZhasktGfXTvWKZbS9COdKWqBD+VwYjE0sQYBorKe/d9I6CPozmeeayHIMk7pGkd+T2eKyTj5beQYpKOfRbptCBPTJlchCGhZuhdAripSIE93/1eWiJ13sEnKPuoGfScxNocV/QsvSKRaI6E7tE57X00CNC1YAUZZVhgXjx5en5qc2a7jCy4F/1x191XWeFovgCdZXMtAsKY1LRi1CLzDnVFjWXXksh4iAnadBlzWdPfjBzBDaV88Cl6AKN9QY6y6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpVZsinq1S6tqKjWX+O+MNW1y2jeeNar3b9L42d9AxA=;
 b=YrHeCRf0WgA8x2UdQ8I05yAgcxrEw3R7nMjv9EGYXllpTsRtbTHxKdP6nhXeL3pDtxk1DEHDSte09privRZ2TqpTbIAvJq01hYrZZ0SQ/7TwziLW9C04tdz9OEfTMec6y/INFWDVvpFzFdutW5lVubukxb4mIjucQw9G+ToQUQs2iEtPQXMaHNZiFl90ixjtnrxi/gELmFpmsZJVydRuEsQO690zdU8Y3sPM3TOFWLrRBjqIssFL5c7O7mj5p4KzsZMo47POYdkkxt8s4zrc/76mPx4l++3dEPWJZ5L9726cV191eFxM6axlXqPEjfCLCFZ24Kctc1yasPVHPWwQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB9456.namprd11.prod.outlook.com (2603:10b6:8:290::17)
 by IA1PR11MB7754.namprd11.prod.outlook.com (2603:10b6:208:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 16:34:49 +0000
Received: from DS0PR11MB9456.namprd11.prod.outlook.com
 ([fe80::6132:66e2:d774:92cc]) by DS0PR11MB9456.namprd11.prod.outlook.com
 ([fe80::6132:66e2:d774:92cc%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:34:49 +0000
From: "Gujjar, Abhinandan S" <abhinandan.gujjar@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>
Subject: RE: [PATCH 3/6] eventdev/crypto: promote adapter runtime params to
 stable
Thread-Topic: [PATCH 3/6] eventdev/crypto: promote adapter runtime params to
 stable
Thread-Index: AQHdOvPegAb8feAleEeI0roY+2pejLa7e/hQ
Date: Wed, 2 Sep 2026 16:34:49 +0000
Message-ID: <DS0PR11MB9456BB398F1D0E4AAD28FA7CE8B72@DS0PR11MB9456.namprd11.prod.outlook.com>
References: <20260902155722.577747-1-stephen@networkplumber.org>
 <20260902155722.577747-4-stephen@networkplumber.org>
In-Reply-To: <20260902155722.577747-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB9456:EE_|IA1PR11MB7754:EE_
x-ms-office365-filtering-correlation-id: fba436d0-8017-4b3d-6e87-08df09101bb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|38070700021|11063799006|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: tFEPzla/JeyN3Fe70lFMIAiLtPzf5eBHFPeeAT9xQ4ZdqwxeWNZYNUFv26rd18KHLSY0z3hqweauWaqK8qv23rJIyCMC+z5eLAXb8lTgg3ngViSkekdm8U89AeOunzhDRUYTw7mdkRv2Nb9PVuFFQzc5rF5KSnZrutaX1iNE5wQyPH8fF5QuTx9DbOmU/Y8Zz/qgsAyuwQ59W3iRQcjjdkByuHDZSX/6CeUalSFvyV2oFPlHUlNRCPidgARdJi/EtYgYOd7mc7a+w15al+3XL2n5TPF71KGn+29atbaRIr42F/t7Vg8gcYIumME64rcT9Vzy3sUHKms8SEFx+31yqmZ0oComZFAAT8uxl1O/pAoT9nuubb36Y0y3CridIHXWmF4KrW2mYF+6RSow/6v8PbJsbJlEt60vOz95DvYR1EukT6FH0Ek/CskYrj34FcV2LyGn2msXIWrgXaYfrRp/OVkVALIroPfpXPkYGJwTNvo8vJXYLVyFQ0w9kKqJ6bnSXc/cRugS/kZKYIL0pzyNGT08TgOWI/y7JGgGRxD90EhyfWs+Nb252oxz9q9panuCetGEnQYujri27HPvQqN64Zpn3/hlmK2FgBUTO4PhCzpc4qD0x86v1+2OcgYH9EWtXA9TEI3CiVFDpaFGrBoR4TpLfhdmI1UIqhNI0fbe6J5nO1STzykyXBbzK53jVf85BxJF8zEVg4IB84h5StYE2oXEHpHStLf7OM8FVpOgngY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB9456.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l/LcTgO8LvR6xTUgdD6JOpvopuOXiI1GE62OoaPZ/j1wAeM8/f3Yi0I5rCcV?=
 =?us-ascii?Q?wbRrV9EID7uWLsm4qAufOeD2F67IW6RS3VeIYOnx/JGMvWZWXhYhpOM7FldB?=
 =?us-ascii?Q?oeLgXtRt+JsF5vN0IPP1BMV1mFTw6qFE3jkah0axGkVaN9WhQ6kBWjN8VLUu?=
 =?us-ascii?Q?CdjGH6ok4orH5Ob3Iv/x5RQ/1JQ1E1mGhRHQ6w/BHoeFBjj5C+ppYhb8UsJH?=
 =?us-ascii?Q?VwUFmUPhAm++U/C2tm9Xgd0npM9uWwywfiM/UBcv0rFRptol3fT+hYhba1z+?=
 =?us-ascii?Q?rpuXaK/jztdHY8rQVviDFaIyN2wXCvHwjqiA8wGi+D17s1FJXMevoZNbHyno?=
 =?us-ascii?Q?bQQgVAaMZvU9RTF22G5NzhRu6vxrfi8OId/3BRnkGLNXcgjxVMiNGArGVAGB?=
 =?us-ascii?Q?Of5nwg9o+LUu+lTERp6aimQKaX3vJQnZwOd9yWDTjmoFl+sDZBOo7P5AozOR?=
 =?us-ascii?Q?bzBuR6ra/uHomMmQMiOPil5BmTM5QYjF+gBIwkDCkKZef35YhBCw2gBgaZ9n?=
 =?us-ascii?Q?AKy5hvySQsQc1cXlAE0IgoqO9UCmOXzRTPwDIrBY1I27mxD50bfyeTlh+8od?=
 =?us-ascii?Q?A/7cZXk+I4FeyRhGiqfjTrKOYsg3/XLcO7olyzXBqUN2UH/K5wpt+ZfBDrPN?=
 =?us-ascii?Q?CqGMmTXoYsONot/1qqFsM3j9X9miBAADCrPckbZlRVtpGwRRg2+G+a38IoDq?=
 =?us-ascii?Q?uW8hSv8/7xflFnLQIFmqVkzqyDVAqUmCMdVTT8oNmT/fsYIh+gEJ4J96TAwb?=
 =?us-ascii?Q?e3rNVVAftVhamZpK0fipLeABSp/qlFgJmcRRLsRDBZCp38B4vVwUq91abSAv?=
 =?us-ascii?Q?2PjN4jgkxQTaMHubH6UXOuNUi+8vXf9BBU+5KfyhlIxdzazXTXtKx0ZC7wNF?=
 =?us-ascii?Q?ZNH5K3SZn+UjzH1YiJ2CRbbFl1FRggZxHUoCoKOIfTLznAHtvFEfA9+P9mkK?=
 =?us-ascii?Q?+BWhv6FKIlIgHLsRhhyMUyKD3eC11Ls1UpCLaTVnvAF2sIVBWf787RW+RN7P?=
 =?us-ascii?Q?iKBoLpW2hGmL36o3jHcOiBAIZ8+bbjMzFxQjVXWzBHFMY5HP+CIhbwsvH3Gn?=
 =?us-ascii?Q?pZM80zcB5vT5651UqzDL6et+M68AMsWPAiCdg6mDc4YJX5xgzecq1THniBrp?=
 =?us-ascii?Q?6vh7yi3GQ7GdjzEw2p2v1XBMT4zuA361sWH67oHpDOxX9HDAGqHyZKgNUj/a?=
 =?us-ascii?Q?4EWmwCjuv+daSADV70fE9kLQdkRddLNcaolEi9LWgSyXzXtihFFwWidMFHel?=
 =?us-ascii?Q?mto1ysBtw0kJlYNj2/JzuHBpX157YSBTOQ3+4q4+JJW89Q8DbkC9HABywLuv?=
 =?us-ascii?Q?NnKZPb3vN67rsN4A0S1+3lFi4iCf2YDXBG2GSbvfB9S8l1O46prTJGBRgiRl?=
 =?us-ascii?Q?Best/1UO5+C85BejuHPlQwUeZWpeIAKV4ZqQZro8NDAtjPnSqpSOWG5SIKYA?=
 =?us-ascii?Q?VlSYanB2vhRzZ2hUF4WUT77CLNkgairVGiJgSHWyMYZynzbEkoShNb3l7sFx?=
 =?us-ascii?Q?6SPEQLZdhHr0k8PsI6QAQY5FHU8Cvi0fJZ5dnQOtfQ8Now+6zHOZGpe0Jlcg?=
 =?us-ascii?Q?FAP17I8QFhKO5dRKQj/LQB2PIi96RjQTnzgXCD2Jp/PIQXG4w/oX7OqykhtM?=
 =?us-ascii?Q?l9C1kGkl8QQq2Ny8nLGDSmH50nnKXuZIKEzj2a0T/kwAYATbAYKN7DuuACJ4?=
 =?us-ascii?Q?eVm386kxbpGUJna3FSlU7xEBxZSgN7oYdaiQ8DIOnZBcKeBOCAJMb/qspazU?=
 =?us-ascii?Q?w/Du+CgZIw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PGIJ5c3irHNTQ/LAMcFi3T9255SH82uhndcKYbVOghF+6dqI3dl1w2VamfMtdIEt1P0/PF9BaXg2wvPKWFprgBw5jNTXMTp3bH6HLAYyTaTfeZxiIqzVnetJxZZIqYwZskeg2Pt+T+WKPOGt7h1UsvSvmgHUTrz/TLH31Kg1n/+JO3tJ0rTpA7kLuIQuWauIWJ5WO99kyEmPpBhrhLEz0/1hzsa9qdA6xw+xO36/tvHFQnjS7U7qQc1b9yCIIbtuSbEPlPdWzqs3homXxf22Ea2r6vwi10ybfksYjDwbe9c9qY0vuESjX6ZrRoQ+lCsLUrTn5TBg7xrTpi3wmeTh6A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB9456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba436d0-8017-4b3d-6e87-08df09101bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 16:34:49.8261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6WGEkvrRKzIBtjSXr/ZokKC8cc8XdsarB7+5pv89M9pB5x8qyZRhBgV/Qbkju0Iz/0HHhjihMRxdidVCgwzZPfBhJrzwMiCt+0VRwtNNR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7754
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday, September 2, 2026 9:24 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Gujjar,
> Abhinandan S <abhinandan.gujjar@intel.com>; Jerin Jacob
> <jerinj@marvell.com>
> Subject: [PATCH 3/6] eventdev/crypto: promote adapter runtime params to
> stable
>=20
> The crypto adapter runtime parameter functions were added in v23.03 and
> have not changed since.  With this rte_event_crypto_adapter.c has no
> experimental symbol left.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: abhinandan.gujjar@intel.com

> ---
>  doc/guides/rel_notes/release_26_11.rst  | 3 +++
> lib/eventdev/rte_event_crypto_adapter.c | 6 +++---
> lib/eventdev/rte_event_crypto_adapter.h | 3 ---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/doc/guides/rel_notes/release_26_11.rst
> b/doc/guides/rel_notes/release_26_11.rst
> index 792a5a35d0..18f0641ef2 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -104,6 +104,9 @@ API Changes
>    * Tx adapter: ``rte_event_eth_tx_adapter_runtime_params_init``,
>      ``rte_event_eth_tx_adapter_runtime_params_set`` and
>      ``rte_event_eth_tx_adapter_runtime_params_get``
> +  * crypto adapter: ``rte_event_crypto_adapter_runtime_params_init``,
> +    ``rte_event_crypto_adapter_runtime_params_set`` and
> +    ``rte_event_crypto_adapter_runtime_params_get``
>=20
>=20
>  ABI Changes
> diff --git a/lib/eventdev/rte_event_crypto_adapter.c
> b/lib/eventdev/rte_event_crypto_adapter.c
> index 3f9cc7379a..6ac64cafb1 100644
> --- a/lib/eventdev/rte_event_crypto_adapter.c
> +++ b/lib/eventdev/rte_event_crypto_adapter.c
> @@ -1430,7 +1430,7 @@ rte_event_crypto_adapter_stats_reset(uint8_t id)
>  	return 0;
>  }
>=20
> -
> RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_p
> arams_init, 23.03)
> +RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_runtime_params_init)
>  int
>  rte_event_crypto_adapter_runtime_params_init(
>  		struct rte_event_crypto_adapter_runtime_params *params)
> @@ -1469,7 +1469,7 @@ crypto_adapter_cap_check(struct
> event_crypto_adapter *adapter)
>  	return 0;
>  }
>=20
> -
> RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_p
> arams_set, 23.03)
> +RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_runtime_params_set)
>  int
>  rte_event_crypto_adapter_runtime_params_set(uint8_t id,
>  		struct rte_event_crypto_adapter_runtime_params *params)
> @@ -1502,7 +1502,7 @@
> rte_event_crypto_adapter_runtime_params_set(uint8_t id,
>  	return 0;
>  }
>=20
> -
> RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_p
> arams_get, 23.03)
> +RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_runtime_params_get)
>  int
>  rte_event_crypto_adapter_runtime_params_get(uint8_t id,
>  		struct rte_event_crypto_adapter_runtime_params *params)
> diff --git a/lib/eventdev/rte_event_crypto_adapter.h
> b/lib/eventdev/rte_event_crypto_adapter.h
> index 9a663c6227..463c90b843 100644
> --- a/lib/eventdev/rte_event_crypto_adapter.h
> +++ b/lib/eventdev/rte_event_crypto_adapter.h
> @@ -646,7 +646,6 @@ rte_event_crypto_adapter_event_port_get(uint8_t id,
> uint8_t *event_port_id);
>   *  -  0: Success
>   *  - <0: Error code on failure
>   */
> -__rte_experimental
>  int
>  rte_event_crypto_adapter_runtime_params_init(
>  		struct rte_event_crypto_adapter_runtime_params *params);
> @@ -669,7 +668,6 @@ rte_event_crypto_adapter_runtime_params_init(
>   *  -  0: Success
>   *  - <0: Error code on failure
>   */
> -__rte_experimental
>  int
>  rte_event_crypto_adapter_runtime_params_set(uint8_t id,
>  		struct rte_event_crypto_adapter_runtime_params *params);
> @@ -688,7 +686,6 @@
> rte_event_crypto_adapter_runtime_params_set(uint8_t id,
>   *  -  0: Success
>   *  - <0: Error code on failure
>   */
> -__rte_experimental
>  int
>  rte_event_crypto_adapter_runtime_params_get(uint8_t id,
>  		struct rte_event_crypto_adapter_runtime_params *params);
> --
> 2.53.0

