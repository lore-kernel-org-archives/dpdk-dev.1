Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02460C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 10:51:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 315C0402F2;
	Thu,  3 Jul 2025 12:51:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 88D2540264;
 Thu,  3 Jul 2025 12:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751539912; x=1783075912;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FSwOP/aU30NFxeIpt2VaDWF9E9LAA0BIQSaMAnfKSAM=;
 b=f3rwOkbOvHx13JNF/CE5hPYpnV4zKea+iTWHk46HCnpGKfFt8dbUWGt3
 Lbl3I4fygLsOl2dXwWiv/sdishlC5yjNTzat1z2nypNRoZ6OZTrtMTuDU
 tMK4JHk15sJe8olo3+8BzoE4p+A5p29KN+8ig3S/mv5JpopqbF00f8o3l
 zKQyyBoq/bW0EHRkjLguuicKYT2RTxVV+jEAKXSuymhwxdW0zp8AuOUHA
 lnusQRQQNqetRxxA860PB/D613jgVHKvPWW1QP0N4HNfvFXhJbGMRA2i1
 Mm6vXkhYI5KavDMIGCk/1pou2AvLNw1Z2hSsuNfw+xqXeXmFpE/lYxi3h g==;
X-CSE-ConnectionGUID: gWFP5LdtRd+L6qx8+PHBeQ==
X-CSE-MsgGUID: XLtZTjjsS9COXLZ42Cb0CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="56482612"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="56482612"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 03:51:51 -0700
X-CSE-ConnectionGUID: nCjB+TiUR4WFoUvJMcol7A==
X-CSE-MsgGUID: qZdaI4YCQIKEtHPUf3xBiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="154912624"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 03:51:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 03:51:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 03:51:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 03:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmVriw14DP/zWKgnB/8EXeQG+zYRgOw2BqAJULebjdSTJKqYd6a4NghTOn4c0p9YfK/NXCn72SG03uKYVRurSIXZySUBFf68Vjz4o7+Y9+9SxGKaYp556T4UikN/fUHSXOXLSObw0RsD4kyY+IIecmFyrI2A965v4Zpy/9elcHEC/LeqtBdm5LUaF7aeh2iTzc5k+CueJsuhwzZjmN0cL9v1zTDMemCU8x16E761KDfdAaMFGkRXK5w5bbgRIJniOIsNdWRHYNwfi/03Z9gS5iH4soyd9ZDlwFl51vIpRkDALxHlTd6A23lovLMQIWFqlD0g8drtLe2IsEaYhFmolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dac3RvFq6yQpivDnGn3nAUuRvRCcdFDmaR5Jp/0xweM=;
 b=r+HHq9ggmd5r26XkhNO8bkGfbcDHsiu3chwwxqqrumd43B0XwE/u6ZuTHvg6Ieis5YAGfVafFXe/i+JxvaJAbaXhd94NddoXzPQFaTUfBrMcWVhtvmY6qwEoUhTyOoZSg5GdhiNxBaBTBFe6bu3m2XNae0rWdEI4s9X03iFzzx7PcAG3q/QhNGsZgRcppTyxnLb4bAzm3Bh1J/ydE5zCyc5CF1j9ENHCvSIom+HgoGq1Hw1dL7PvnMWjAvLfJSQLbq+/VNidaUCd6etMF+Ul47qqEwdc8lJnsE6wLeJE+QVhqzB9B0bt8uKc9GWFKXTAcrnqgoZUyB12g2bzYZqmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by IA0PR11MB7355.namprd11.prod.outlook.com
 (2603:10b6:208:433::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 10:51:21 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9%8]) with mapi id 15.20.8769.025; Thu, 3 Jul 2025
 10:51:21 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v1] net/iavf: fix VLAN strip disabling for v2 capability
Thread-Topic: [PATCH v1] net/iavf: fix VLAN strip disabling for v2 capability
Thread-Index: AQHb6/aGyumuHJ/Rb06fvpOWbm2s6LQgOLNw
Date: Thu, 3 Jul 2025 10:51:20 +0000
Message-ID: <DM3PPF7D18F34A16844E8E1F7A64C3DF7598E43A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250703084234.8037-1-amiyaranjan.mohakud@gmail.com>
In-Reply-To: <20250703084234.8037-1-amiyaranjan.mohakud@gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 9776bdc7-f4d9-4e6e-9efa-08ddba1f8bf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?puYg+UmTlakcPKmFFYKteLuTug2EPrHSeClO2oCrHwXo7lAcJtPBQXFqI26J?=
 =?us-ascii?Q?f7rR6o8Jw3wCul52BnfJvDa+fS4YGOWhGpqsaB77faDVAsSm7Nn4AUCzQ8u3?=
 =?us-ascii?Q?y2MQHm6o/pCLd4hC1khALKO4biWCbAk9fHiSiTYy13cWS16ZAkvV0N+dCGnG?=
 =?us-ascii?Q?j/vNJbc0rtw3kYNQ2m7gfgqXundY6ngUagfGEx6hL6O9K+Vis/m6jkRWbru2?=
 =?us-ascii?Q?k4A3NxJTAhfU5oIzFu8bKWOu+04tIdRaD2NHyLV3gP/pzpDgpP6ISc3GjPsd?=
 =?us-ascii?Q?Uw58T6oWGF5PnY0X4NLhwjlOrG/MQYbxj7bk/AA4jYgSdxA49+YUDsZMck4T?=
 =?us-ascii?Q?+klAlHe4xAkQGXE7kZnrHbkzzZl3/Ya4qd9TZ1T+kyjQ9zVvcfy/Mcsufd/V?=
 =?us-ascii?Q?iYRIAStV7UOdBnw12EZLnGqmjZxe4qL3KT/wVxS1cjIYaLShPQjnQRPDQO2+?=
 =?us-ascii?Q?9zxp3ifYN/kHZf8PndIbw+SKYky2wfjB7rymi8MS8gRIlhq573cu4h9+YiiU?=
 =?us-ascii?Q?JTwsuCIS3kY8nuR+oir8P+r6Cjggz0Ecll5JuCTd2/HEVdcbem65k6Llhjwn?=
 =?us-ascii?Q?OlJCFUWj/+QAFKXJxzbx3R3UWbYQYYAmOMwAxD9WqpRJrEmvdJXtJ0vGoL/0?=
 =?us-ascii?Q?ueR/lJCAZWNxpeR5qFN8WvhD29lzGozspaU4judFloyu0thaEp1IlcngHpZZ?=
 =?us-ascii?Q?7lGKsHorV2fG+jRfq71czBnwAVgrL9Jfx13KV3rjZN1TK6ldOQsHxkJVi9DB?=
 =?us-ascii?Q?F3XIG83xqnOrk8u50ZcbF84v+kzyJlR2OlUjGFAQ2XbINRHjJH11bJ6twO9j?=
 =?us-ascii?Q?XQvMslmPQP7Kdd9MP87td8+BAUsT8W/gvrHARe0e3fLtUWoNqcN3qFBgK5ky?=
 =?us-ascii?Q?/KISaMC6dwhsOAZCeeOUSjgDx/Igxf3WApZz1+6T2rywLoVa0QcnBY0LLf9k?=
 =?us-ascii?Q?WqNfkk7m4jY9HkFdncW0/2BxyHx6W4nQvv1BSvr7XbNSrsBXTF6swlkOgsmP?=
 =?us-ascii?Q?LmjN7B9p8ty8BMIDU7u6gMteroFGVlj3hfbsWVZ92S4R09vKxf8zS9HVtSGN?=
 =?us-ascii?Q?uwaudQvmmuIibSIIw0XsrLMT/GMuU+YZVDCnocMf9zoSYeCm11OyvWDijKH2?=
 =?us-ascii?Q?O03XR1i0S8Gbphfw233tYTncThspd6tjMgW8YobxVUPTMxHqsdis776iJc//?=
 =?us-ascii?Q?edvpi/M1yIqJh1sEqjN4erxdGDeiB2Q4jckZQwks5TeaApbrFiuRwy78R2Pw?=
 =?us-ascii?Q?+UerHyPRgrunM6GlxzCkBq5O/mUwGFsbBBnuHhWJE32f9opB3V1MDf6OY0+b?=
 =?us-ascii?Q?6MwAgbj0ODvbNDnE6F4z/HiC4PsvmeVXtAUk1TgWIFporIQ0msi09DFX1vxI?=
 =?us-ascii?Q?67ZqLQ7PoQ57ln9EY00p5m6q6Xi+ZUfXzUvrRa59A4hyqnWHw8vNTmWqXCKl?=
 =?us-ascii?Q?xtF+li3lrwYS0oVE2Eyi6HLbeOrtuh1AUZ7ONwjWGm8zV4lGmDhb0g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xWl2sHFJyImAkADay8bWTDIEdrbNNNG8gjoBBRe3nrh1lx+yizIffoCq7bQ7?=
 =?us-ascii?Q?nNr3tRh1fJUPizS2IRtF5+VwbSbV3l4Hh8xBQB4MzPGYfkF8wJr5rVOYq0jg?=
 =?us-ascii?Q?JGtTzeLirY3R0tq1ANQAquvO5YvIAKX47Q4oZT4aDvANTm5Zaoy5vp1C3pe0?=
 =?us-ascii?Q?6xfnTmsr5gSMbLRc6Q4vMElznvMOq6MrOl7Q7ChCBwkjcxuu5OGbhaITsU5k?=
 =?us-ascii?Q?6RMfk7jrby2ggbSa2n80Gu6DlpqRB+WRVVEYgqxfXcFYjjRIHtGvIWbIjNbX?=
 =?us-ascii?Q?TrWWxoSb1LkWAFyoLP28uSFTVsYjvl0wOqzItmG8BS92nmOsYGwKpN5HYlqq?=
 =?us-ascii?Q?9Oo9lu/cf+FG8s47FE0RKr6O3HQL9LhB9H+YA++IGsUGhx+n8fFlXL+hJhgl?=
 =?us-ascii?Q?yIK9aOdWqStvfVG4qRsdAifcStiNTWZD9aY2QcwDs2CWayzlLmZBUBI1qB11?=
 =?us-ascii?Q?ttkDMS5XjMw6A5woufKIxJlELd8G+K3CFhF9nC+Up6HDjGb/Z18pZJscc2I1?=
 =?us-ascii?Q?THtvbBLddeYdA3t2yjxEBQA+ay8Fjf4sWVY3+AZwsRiZnX3KJrcMWUldo2KL?=
 =?us-ascii?Q?ZeOEEHP27LLgE5nQadpbpc9hAx5gCL3Sswak0sEeUsdgfPJ30TcyVXitbh7J?=
 =?us-ascii?Q?711XTm+LubBGFL+dqYaekAGJlxb9ObxAgSmb3x/bAc/UuQweSn/tXcaSMqYm?=
 =?us-ascii?Q?tAWuAhMXo2OUro7o4ks0cU+Ccz1/jbRfEPBv1yGA2X+n4RxfcEXaQe1Yp9LY?=
 =?us-ascii?Q?MADE4C2zdWK+fzjfdpJLfl/ARYh9J2NOk86mzHC0vwhRu7mGs5lFI5U4qZXi?=
 =?us-ascii?Q?uZQlMH9+xl5N6GMCu2wfn6Pnd3y0Q+NKFK5m3LcclFw+KbuDgStfIPR5TDUJ?=
 =?us-ascii?Q?TJsKmepdSNLHkpwl/aVKdkzD75/6blhNCmA92zlyHsf6Ecyi4ANBiuAfU+An?=
 =?us-ascii?Q?05ZwGWPNHWqUNgbnjz33HrXiKFgYoQajvCccx1u+CT0Jb/RWFvr6Tk41LLHU?=
 =?us-ascii?Q?1gL9DGDazKooXR8UXfRT9KgLSJXq2i3t4iC0gRbxxtAo22a0UU/K178Wk4lG?=
 =?us-ascii?Q?y4qoPsenezDbzHqYLWtZxkpQfpWSQeRPdJaDxsWo8HcGKx4k2Eps0wWmVsB2?=
 =?us-ascii?Q?ZlPctCz54q6shYgF77S94URWJlmYByLXsr0nk/rz2kbBtwsDiCzSLI0xPtpL?=
 =?us-ascii?Q?0fKd4TaAJBWds7qVMwgahj5Rh/GNYwnQpKnAaGRuPp1s+5Vizecz2fFBg/o8?=
 =?us-ascii?Q?iwVhSWlkEX+msMIK1YmoTN38+hpPU/0MVg8U35OE7n6JRYTl+U6SYfSwA9Vv?=
 =?us-ascii?Q?6jsPTQJT8KZmFUXDCZDfCpldnjAbMqXvK0Kg5PGHxUHuyqJz6Bn87sZVNoVD?=
 =?us-ascii?Q?mXPTozAXp5o+0zdc/J13G5L9HPVb+z9btvRp/ZfVCraEae82z9Fu/382dg/I?=
 =?us-ascii?Q?0tj2RGeG+fHlQBG7OFXjYG+oJLcVBhLzStbNWu131IJ0//43DEKXu/K5wdFx?=
 =?us-ascii?Q?VdjGKeb8DRhXmU6wj0Mr/Qohm3Q9oEev1ybZLW9MGjQBARJ1SsQfpVrnLthd?=
 =?us-ascii?Q?IGY8j1xazqYCNuqHNFc2H6v0NATX1dQ4H65Oevcl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9776bdc7-f4d9-4e6e-9efa-08ddba1f8bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:51:20.6804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFF3dvBP5si0247zsQCqNd6gU4khB5+U8uKgbkYNE+gT3BAHAAL0OO+Q808lKkDmyLbo39VkcXRO47agf/M/2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
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
> Ensure the correct virtchnl op is called for disabling vlan stripping by =
checking
> if the device supports either v1 or v2 vlan capability and choosing the o=
p
> accordingly.
>=20
> Bugzilla ID:1735
> Fixes: 3bfad066f9b4 ("net/iavf: fix VLAN strip setting after enabling fil=
ter")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>

Thanks. The CI is flagging an issue with the commit message format but mayb=
e that can be fixed when it is applied.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index c33fdd9069..335a8126c4 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1388,6 +1388,7 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev
> *dev, int on)
>  	 */
>  	struct iavf_adapter *adapter =3D
>  		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
>  	struct rte_eth_conf *dev_conf =3D &dev->data->dev_conf;
>  	int err;
>=20
> @@ -1395,7 +1396,10 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev
> *dev, int on)
>  	    adapter->hw.mac.type =3D=3D IAVF_MAC_VF ||
>  	    adapter->hw.mac.type =3D=3D IAVF_MAC_X722_VF) {
>  		if (on && !(dev_conf->rxmode.offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> -			err =3D iavf_disable_vlan_strip(adapter);
> +			if (vf->vf_res->vf_cap_flags &
> VIRTCHNL_VF_OFFLOAD_VLAN_V2)
> +				err =3D iavf_config_vlan_strip_v2(adapter, false);
> +			else
> +				err =3D iavf_disable_vlan_strip(adapter);
>  			if (err)
>  				return -EIO;
>  		}
> --
> 2.39.5 (Apple Git-154)

