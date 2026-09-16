Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2549EC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 08:58:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20CA842E52;
	Wed, 16 Sep 2026 10:58:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8910F42E5A
 for <dev@dpdk.org>; Wed, 16 Sep 2026 10:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789549097; x=1821085097;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UGv1V82D3c0Sgrnbo/nyQMNvgCRwuCl/JPUDuBgHfvM=;
 b=lkC87zNMywDLcpklpd3zxn7kkXKT+RmyUexHDCa/+Y6/e3fViaNWTrwV
 sdf4NJ8eEhV74xiMWAgHfr/u1B+0ZeMYV3mn2dbTwmyF6fwZgj+eQg8D6
 jEHBzDKsxa3Y93vQmmpfJD0fo90vuLENoa9fh6Zvb1Ts6okTAZEh6S+16
 HvEBOM5aEJ8gVS3FjHQTvSN3SwMHR9F5FjyTlMVLdqjWwKXJTjnvuTWf0
 du/dWukYg8qULorVgTSt/JPyPeXp6647+vr3udqWBEHduGs5mvh89+6qE
 i7MABSvSeuF7FfhKtFG/c4HmI5F8nk3stiGYlrG/zDtqW+/YNK1DcQBPL A==;
X-CSE-ConnectionGUID: 88RMJrZEQM2NByY3evnxMA==
X-CSE-MsgGUID: EQbFYhIzStWFDd5WPdcuzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88857635"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="88857635"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 01:58:16 -0700
X-CSE-ConnectionGUID: AtAJEHlrSnWTShvwHWHgNA==
X-CSE-MsgGUID: oMiqVtJnTK24MIpywuIbCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277025327"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 01:58:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 01:58:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 01:58:16 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 01:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvY6zLqYh5nVUG+5JIjcgiEZzvptHO1bNYrrTXPT3InbpsQM0E6ILC4C2l6wGLcwPnkXpxKbxFc1yFbk0SDWy54qo6SxzbtLe0MtfLaw+PX0HfudjrOsP23P+936YYzE5o1Edtn5gcFYeiiLhZJ8CfK5+dNa8jJT5hOjK9+XgHkbQK339re8msHT7b4Qp2NyalHNVBME5Ob2U/jxA/rVTqvryuUFv5Uuz7XxXyBH2AeA1rldW73wZQBAP0f36uzJbCyNOFBx8m1bZz3n8yUU0fKLJHC/VFRfkpBnEkLcm4pWiYo2ZfGMhZYlfnSqQvFEF1Zy7WPO+NqOI9CaWYfAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/sfz+i8TJw8lbBhIV6BlkeeyTUl4piaOrG0BkCexAQ=;
 b=QSjnNbcFJAhAZ4OJF4b9NfBHggiNItPsGZbtoLyaq52P5dTer9l7x8ApDTRmqoOptAmhBvE3U1rpGd5OdQebrdguakdtIZw3x8xt40EqohmwSDOTOfW1vbHJiGHj9D5FnVeQU7/5H+JDTtmb5Zcc8DTqEt69Te6LH8aVAxOWfBiFZQft0+ieUvPYjoNmqk1BLp+8gePeRdT5/Izc56esqhRDkA8UQNkXrwYkqHG0MJujXAWumMFlBbm5Yb4fnPIyR2d5bGAYYxuhpmpMRakvqvehVnm6BL/KurEdd04WHmrO0ynX2IN3UjGJ+rFJQaYY86JRXpMjxIiB7gYWS17zRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DM4PR11MB6312.namprd11.prod.outlook.com (2603:10b6:8:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 08:58:05 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 08:58:04 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v2 09/15] net/ice: use common descriptor creation functions
Thread-Topic: [PATCH v2 09/15] net/ice: use common descriptor creation
 functions
Thread-Index: AQHdRReJLCcxtVZQTUG44F9rKenVRrbQ6J1Q
Date: Wed, 16 Sep 2026 08:58:04 +0000
Message-ID: <IA4PR11MB9278ADD2166D624BF94356558EB92@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260915133654.278780-1-bruce.richardson@intel.com>
 <20260915133654.278780-10-bruce.richardson@intel.com>
In-Reply-To: <20260915133654.278780-10-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DM4PR11MB6312:EE_
x-ms-office365-filtering-correlation-id: 5a1dc088-7d08-4f18-1f80-08df13d09ea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 3i5JH1eSh+6mIMer1qcs1QGxgPRaYu/R61IBxWmvZTRdlDRENERFrP9NbfnqToj1L/84mRTKci90e1CRv2TMLk46YiweXVRXT3P+dbLBJ1Uxxc0LDEzYCDMmkQ+TdY2eggLbq8vM6gRuayQ61Vf5xgqKeEpsmg5Ixu0sW7VtSz05umPzUXBflA6TqLcRo/nKpSE33XxftAeLUt9+LPEeTu9ddrU0lT9ya1Xs985uUH8h1Zkul0U4mHx0+n0dpyxFexBPNxWjH4Vz+a8YyASddf4aOX2Mi7nA69DIHmfdE/KIrcs200uu8RXwne0Lk1qMIVHiZu58lFRpIGzwBexBLD0DnrJefFiZxsrp+a7rHReM5XtBrbJ4rPaY4i5edHvsaBoBgiD0Y8WIX5aopohG4HfD5W66dxYK0Uqy/RD2kmGtcbAyhqnMR7wwVfTinZNznK5IvZeIoAKnKhmq1jr+oJKRi53HMCZp1AUH3R/Mi0ZgLOeSELnEQQ6WhWF0O6Es0e2GsEIeGwUjXcOTS63L8Xe0y/kzU045a6npizgz1HRQYE7RAsy394w7sTIjkLsD77+yzQmVgkqooUKdkj0e7wzfVfMUlnYmJys+8GPFektP4T4uTdxrC+rmpf1foIoro67NEJ/8Ipd/eH+1l3InWbLXoyfVBf6QYyfsZnwzeidlcF37/fQX9RKjwLpz4bHWV2S/F7d2Ye1Oc5lPJvGhix4SCjF0P5Awcoompe+kVD8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/OKJFSUuHkJ53XVYfpiyCcIxbOcJz2B/a3IdaaN0EH4yXw6DaQmmooKs76hm?=
 =?us-ascii?Q?pQ/HNmHwRY01vkTrRd0oxWCxhL/YXtd8/hyzGEkaaASIl32DXT9XGitJ6OLj?=
 =?us-ascii?Q?tOfezOrWK5axQSCcP+2RnxzMzFddf9cgyyCn+BEduF+atGI4lsv8rMSJviF2?=
 =?us-ascii?Q?8qlHCEvdz2i80zVYhb2efamnSEiLT1HrxqPWOHH5gw65gmi7Xo9sjC4yZ8Xn?=
 =?us-ascii?Q?Z7wBkm+31APY6Xi5PAxjqD4uKmZAmtIJtVQZ6a3+NKqHfvTVkREM9lEJQpOc?=
 =?us-ascii?Q?v6htBBPYCmwSmostyB2U1LvuZTEdrKoTVv4yVTUdorJLNvFJXcKoxdE84OFs?=
 =?us-ascii?Q?Gamu8zPmL+1BTsN//U7DYPuqpNEszD4nuB1p4+hprpgg6DhNN27/GgHA97PN?=
 =?us-ascii?Q?92YXHmCTAGqaxELK8uR5g92ktGaCibO8vNRZIsamtkzPFDb+g/zSWnL2rMiX?=
 =?us-ascii?Q?JQ7lwpCWthCAIRoEXL9PHvJktu908z0lu0ZaeMkWzvbZP6pzCJ4hMYL+KJsc?=
 =?us-ascii?Q?GGc7ew3fsCDhba55P3b5dA8pUgD+an5pl0L3K/gmc0WZ+XXiSdcDE7rn/M+M?=
 =?us-ascii?Q?4Ux0Hh11tfn4i2RIU4O6nY62e9bWol4qCxSV/y9rQPwbksBWb4806AFnKV7S?=
 =?us-ascii?Q?Ibg+5TC7PzXoCvEUdENV+y3/Qqg5txd7EK3UkqH7jYXO20/EAgGZbYfAz/oL?=
 =?us-ascii?Q?osEn9hcAqSbfr5BGfIkdTLBixmIiSwp855ZSlyILaNgsNnQlAUsva5V3BUBZ?=
 =?us-ascii?Q?qB5BANN8giEchW7Ri7VWBabZJM+FjHC3MOgO17VJeD5ILPPm72V7ITJgFxxN?=
 =?us-ascii?Q?U8fJY24WZc3x0/bNvi6prjyjd/bLEDpwkc3z0N9MVAaQkAcPZeYu/I0KtL77?=
 =?us-ascii?Q?sUWwFkf6nEMRb+ACLa7ok1rqZF1o1RUHznw+9PWffpChRf1zvsxaunHIsdQL?=
 =?us-ascii?Q?2eqE8mhrrGEgTF9jEED51oIuSr9yYRt5XKTD9XPy/wyUTCm32j25855qXJcs?=
 =?us-ascii?Q?b9E4lNGjimMEL0UUYQ8Gm3oiBhfTabzE/yX7dULf/On+IB3Us/Z4U7rPVH1j?=
 =?us-ascii?Q?tkE2bGMWecRfbcMXGUOIsvryVmm46lJ/zTE8jh3N4LDw6UGtpEyhFItx8ghF?=
 =?us-ascii?Q?YI2aVtMr04fmbiUgJAfXp/ktiQ1NHgkp8JSakjXrdrVGx2VSmmbtN/4goKWA?=
 =?us-ascii?Q?vKNkBwf1JaiHE8DmodWEjmR7wyUTj8qYbrasLHCGjY7a7ZDZoCZFATS3k49+?=
 =?us-ascii?Q?0CMx9zFPerHIhd+VU5DPEL1+mAlc8qORKn5a0sF1cCAynPMf/RdxgQcopmmP?=
 =?us-ascii?Q?2PWyeiAXYRhkSvkPSNDl1BnWOC4T9gfwUJJICW5hjA3IURWj9t4zuUOI60sp?=
 =?us-ascii?Q?jzM+lw34+SDO6Fdb1CyqqOk1eDK9JCil//PpWhV2g/+7SpJ5PQ2jt3NSfKIu?=
 =?us-ascii?Q?2+0dlLh2KG3npNjkvlsRrBac4nfi/tDNuKSMWCHLzCg9sC1+hymArR6zJ7kF?=
 =?us-ascii?Q?1d5fOvB5s5ZliZN1lYDtL+xoYQQxca3/Lz6Zch8tTffsHwSRGadQTbe/bVf5?=
 =?us-ascii?Q?rjQ9/eci72MHKNfmpDYQ7mEfdVCF5WxrQ0+kWfKv7UsAg/Xa8Dz/ZIanMqlt?=
 =?us-ascii?Q?ClJiQM1aJegP/3Ws9cQJ6hoBKaXu0hyVkiXNuOTr9HwMG4YLB4nr+FfkQK0I?=
 =?us-ascii?Q?rWmu6F8mjxtz77qw5Wz2oNsvjLaxw9TrvGer/kPPgebXrSk9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S7krYAy/YS+zd6GhwmcUzO8ffz7UuAO1FpubZ0vY3daZumOIbO7Z4pvGSXmE4RIGNttoH+PmvCRGWn0BK+3TaSlxzb50SZvOM5ntYRL2acjuKGU2o0nAF25eGPiBcZOaEjTdR5pA0mxA1Owl3r/0tVD+2SlHyOhgCHdoGeXYyKEKmZ5K0zRipPbXQtysH70VZa6fEUpcKY1SIfuiQWCaASl8Z1OK1xm53nRb+ZWTz+L3nJWk/RIPzf0YyCRld2UFhDrrKGnRgnvwFHOUNgpB3N0Fi9INMK6oaiw9UE9/ow+6Dg56DTzXUB2vTvowVsOXg23WpFqL49zzIoUO+hQeLA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1dc088-7d08-4f18-1f80-08df13d09ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 08:58:04.5267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOBXE2JWMXw1hF4oswINKyyP0X05Wuh47nXa1kdnFKNHxwuzToI71qUV9jZaOvA1SeX0IF56654/QoUv0d+CEw==
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

> Subject: [PATCH v2 09/15] net/ice: use common descriptor creation functio=
ns
>=20
> Update ice driver to use the descriptor creation functions from common
> rather than having it maintain its own copies of them.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 73 ++-------------------
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 64 ++----------------
>  drivers/net/intel/ice/ice_rxtx_vec_common.h | 59 -----------------
>  3 files changed, 12 insertions(+), 184 deletions(-)
>=20

