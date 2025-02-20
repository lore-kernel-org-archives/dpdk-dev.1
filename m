Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66709C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 15:40:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C0DB40041;
	Thu, 20 Feb 2025 16:40:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 616434003C
 for <dev@dpdk.org>; Thu, 20 Feb 2025 16:40:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740066037; x=1771602037;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LpU9BuefaGw1iZOqYj7dqNPJXg8Mwp1yRM/03gD/+0s=;
 b=UfXHryeveUhjbTbjW1uL7zshmilFuo4oXCyKL2XRsx+Shb+TQTb/06+I
 IocbMPozqyHrp7mdFubVUoJ303iMBhBV5qpj90zFhxz5eKk567EtijJw7
 CBS744elGgNcOhPMZb+w/IccbXm+Ts1hBZHGJrLuT571WqQMU1IAd1rzW
 eTbWrVV7D7dHULmj7qOQlQy+KZ9tpPMdpqj286IfsH1507afyr/Y8Kor4
 hD2jvjUhGH+9/anmmsaGiQ9YVf25AEyyRdDmRbGA+W+FjPMmgULsL0szQ
 0Z8pjp23JfyVUANhHYdNqXDCvq2hmjLpTO62yFM18v57bCqPPn7dA+3oE A==;
X-CSE-ConnectionGUID: ITH4PhVVS7uHXQwZwxoJqg==
X-CSE-MsgGUID: 3f/OINnfQn+sWKXS6zV7Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40775242"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; d="scan'208";a="40775242"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 07:40:35 -0800
X-CSE-ConnectionGUID: d3xXvC+uQBqAZcXoL04FPA==
X-CSE-MsgGUID: USlKp/CrR0msDVCNyuN3XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; d="scan'208";a="114911536"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 07:40:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 07:40:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 07:40:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 07:40:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+PKzt32dUxg2NHX7oLHRXcY8j/h76m45oiYd5yyQQiOAG50oE1Xp6BfVysoqqAtkksZRTIQi339kYE9iRj1S5is8+c3v6F9Hf4dSxg49StDfk+sgM3fsxXrl73aAFaYeV7ET6HhkYaEtS8NtZSWoq/b/xvRtffoX4C2U7o+FbigWb879bQ8A+7F0jgGWfBXtxNzdw/kUf+SY7thG/kKvtMmqGh92SWRl1grDeDpBiZsHKujtG7v581Pd1QLiS/qSKOyQYoiY1PKPFbIGSgW+BaS1IY55u4S+F+VZlNYRB7mTupDW8OFb86Pq4unQ9iPAM95NqntgZEhmQOwm4NSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jim5eqChW1los1R3TYca0TB3jYQQ9YMG5SCBEVHCPs0=;
 b=p5A5MeX4ZVO5iqIojAI/hP9elmPCqECVeHaOuYmaWWEPajlmDEKou5VJiGJRQfy4RMueoEWlBjr75fWv/asqwM/JOzgT21+9WStGuCrzAZw/uhWnozyCYitrXIhDPBM606WmRxnSaoOACAj/2cBX5XrxHjTryK8BvWO+jkz/C/hJGmpVpsPrNZ9LXfdbiuyGNlWHE5dg4tqEOXUXzWN0rkh/AwoJ6i6YGptRliIxcHrXRe08BHbRvIyW9E2cr7VIrfilpqo72GkMkvWXtkXbFtP83URGGW+7RFJhhcWv7qjWqL2JjQepzr1MU0p04XnyOcUMg9dhm36WuFVKyTt0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Thu, 20 Feb 2025 15:39:44 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d18:36da:367b:5e82]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d18:36da:367b:5e82%7]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 15:39:44 +0000
From: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
To: "Dooley, Brian" <brian.dooley@intel.com>, "Ji, Kai" <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "gakhil@marvell.com" <gakhil@marvell.com>
Subject: RE: [PATCH v4 1/3] crypto/ipsec_mb: add SM4 GCM support
Thread-Topic: [PATCH v4 1/3] crypto/ipsec_mb: add SM4 GCM support
Thread-Index: AQHbgsR6JAyC2Ay8gEKOwHNCvGMU77NQVVeg
Date: Thu, 20 Feb 2025 15:39:44 +0000
Message-ID: <DM8PR11MB55917A14C1A47BDF6C71F8D184C42@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
 <20250219115001.1047145-1-brian.dooley@intel.com>
In-Reply-To: <20250219115001.1047145-1-brian.dooley@intel.com>
Accept-Language: en-US, en-IE, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5591:EE_|SA2PR11MB4892:EE_
x-ms-office365-filtering-correlation-id: bb06852b-7231-40ae-1a53-08dd51c4ccd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1Q8qt8jpzVQ2QrtLcFYg1A5szVV4wXVmhz3h/0WqGD5ip4YsS35lLOKLwYwL?=
 =?us-ascii?Q?dCc/FXECy8eNCKpNeJaZfjQ+J6wcTfQIg3fTtSAr2WpInP5Ubtkorg5Ug3Op?=
 =?us-ascii?Q?BwE5I+axoP/5gn0hEMSnYegh+YBA59Ln0bN3SHbLaFAF4OJVTyNc/N6py6Cz?=
 =?us-ascii?Q?7ERxd53U+0NNeTA5rZSeiaYW17LQJ19kb1hTdKXqIDBnJWHIqHrCUfAhWapg?=
 =?us-ascii?Q?A9LkJCM5oDSS0Y+w6BYfDsOMmQF9rXzmReuUpUxYSHiB/EsZst1yMQ1Zi0SK?=
 =?us-ascii?Q?DLFBSgxMVJHUZCjnokl6s0RcIZazeD4rPINeO5t317Yzis2VkZfU5ovYElSp?=
 =?us-ascii?Q?txjNbq7OPLtybWaJJHgkwyBcOdvxMvzLP1vCFBixSe+G5F1LpOtBnmp0/yRz?=
 =?us-ascii?Q?qL/ajvnAVHgkVFe9pUXzP63RPzqR3jmEY3gOLu/4tbvqnsQw6WxHqlNGBmng?=
 =?us-ascii?Q?jsCvHvQnhGsnicu11MgzHSSOrR32rvjJEtpDsE/XzLLbQyvzDb1kfa2VFozQ?=
 =?us-ascii?Q?Z53daL2gPH8YRs3H1x8GX8mh1bOYKgCoaEPwXC2CQxujBG438sG4yH7upOJM?=
 =?us-ascii?Q?F3mvmhBjlQbYE/GsgGxTg+yQ0R++sc6qaSJOosn2PlvkWGwPP2+gj/skXqbv?=
 =?us-ascii?Q?cnXBm1bPP63fDCOYIl4tcEV3vr4+gjEXapyUlMHDTcNBJu/3vNUOavgdkF11?=
 =?us-ascii?Q?EnVw392E3OdDqIipOfj5TXa3mC3fId5TBd4gXGhJdU0G1Hnr9LPFWUkDe9su?=
 =?us-ascii?Q?kv3tHbVcOrJfpePUjbZX9A9egIM9OoiDyQ3JJ/maBL1aXwIsYvPuh2X9ED05?=
 =?us-ascii?Q?v/cUrgNv8sNtDeDuDzzc7b7OV8WqrFTnZISklpfuYG3Skip/1Iq1EUf/O4M7?=
 =?us-ascii?Q?ZjCp3kVNzQzYzxfgmlEPJNLlZP/n5l8GoHWDgWuAATyuWz+oocGUZPhiwSky?=
 =?us-ascii?Q?TldZEvCC6dmpWpuNN0oHKToJCBEObP7S79cPyWCuvG5n9Tx0pVMLNjELhKUe?=
 =?us-ascii?Q?rT9fM1+heYQlTAhH/Bv26bYIV23Mmm9BDGbBYjCFqbFwYEb0pfOF/zAIM0Mz?=
 =?us-ascii?Q?hTaKkIX/cdqxmNdl8VtQgtldiau3X7TpN/teqNHpZ0ipnuOPMwW7nl6T3F39?=
 =?us-ascii?Q?5hCldfaPmNh/pvh2v69oqUamt7V+L7vA/QTBXaiShv+/m1uxMBWSaLAXGa3D?=
 =?us-ascii?Q?xwRMXbTNnluNDCEBFn19K6P8sRefSj5/CaMYvAzQuUL8UP3BIw477q00JfEZ?=
 =?us-ascii?Q?sBl+IoR/dRPd91ekEwHyK/ueENamlenYShBqVJ/dF9TaECFBf5VEgfsS3V+6?=
 =?us-ascii?Q?FNQg0VADqjjxHDm4oJmkH4ZdoNogKdklOY5TiwsenuRMvgA6bN0DLek512ov?=
 =?us-ascii?Q?w0hsuNtuzE4E5iVeLw8t+tD8CP91Vm1Ed5DjlMBvHC2QT5CTL/fW/7a46CzJ?=
 =?us-ascii?Q?Uf3ih2otNoSuwcElxZxqQEDgePXnO1nt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5591.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xu+snnG4clIrNX3ARGLnw5hCLHAphzHY4O4SZHWJUsSAbfKyVpQk6bII5vE4?=
 =?us-ascii?Q?fHUV0rlbr2GyxGoTrDOuyE04n//dEcDYAQQBOPU2MJzSYRNLGTDuhPCfvPwS?=
 =?us-ascii?Q?CpIBNg0WNaecoYsZzHYlK5KeQNCJ9q+eGgIcIpUohuaDEvlhJBZpgJSP7VX6?=
 =?us-ascii?Q?Ll0vaB49RIDIpYDKEpus9Q1CvUHbohPCYt3BWMWdYG4u2Weqwse534Pzm4s7?=
 =?us-ascii?Q?fmOKwxr7wPuOuxvqf/kdBf9RoyzF8iwfT7AMMhUZkbgHM3gk+t99vUj6nrmm?=
 =?us-ascii?Q?9hRVcNJWRiSUUn2Q7UtwSnpPkW9uG3jo8/30fWUHdEZ/SbEX70WjxFPtzkqg?=
 =?us-ascii?Q?MfFOG1kSp5dRgkJXls/UCtgSXjRNd18iLRoCs2Zgo52/hZYcGaGR64Rs7OIT?=
 =?us-ascii?Q?toJusldkz1NproFx4DOD6glqK3lv2MUvJ3LcT9it8/7lTiWlZGVfmOP+6APw?=
 =?us-ascii?Q?itvfVmNWSShES1lgsrlG5iM/lhTGMrrSdwiQCBTJctqiDe3uHlXNK8S2aZY5?=
 =?us-ascii?Q?B+tB2S4EaPnWhFMKrK+wUktJrcBiNTuLvdZ/ZleFdUSMzhjRQgoez3g+GuKV?=
 =?us-ascii?Q?NPaFqZ/qVWKoS3t5BxlSspuwNmim83o9UL2r70Rnap9tt1e4IIpFQfEFcgYR?=
 =?us-ascii?Q?JOyXEkL9qyIAoCdmzYHhh4wI9g5MiWP6MwOrpyJA8iwFyDaZGaDdW1ZFgaRh?=
 =?us-ascii?Q?I/i21liCnHcoISCYt/UV5M6d1qT51Ob7dRJI+Fd6vJokUnFqJJoHD3qFMjUJ?=
 =?us-ascii?Q?ZjfcGr3gmbom2seCjOKBmMtpROUEDsrCLuIw/+GsxPu9rg7999OWFDZDy20L?=
 =?us-ascii?Q?sjiSTbMx1r4SP/1CHBS7VKK08iZ+5Fen17nf8M7JptQkNSL2r77wShsktiB7?=
 =?us-ascii?Q?8hBQMCF0K/0gI+GayBUSV2NavME+Ox2w+TYeAW8oj8SyKH6J9OF70mq/xlSq?=
 =?us-ascii?Q?dnBzhWPQWqlCuJZBFugRycwv1pcH/nAeZf3QV5k8eXEu/Da8OQK2aFd8F7An?=
 =?us-ascii?Q?0p1chh1JwyJTZbqqur1fd8q980ZcI7s4XlR7QEWT+TpGuEF34X6R2Z/FNPSA?=
 =?us-ascii?Q?PRVbYBQT2oCNWhMqWhe3+ei0+v3HV66YMB+7kOst9CitvXTILJL607zTukkH?=
 =?us-ascii?Q?jroUrEMQT+FOlxXIqificFKcrl5TeYZzXOq0qzvnEruPuVSyUHqs5R3HMRIB?=
 =?us-ascii?Q?1R1hAH0ZlD5eLDJoT8AHEq0TkmxDqOu3pL3N1HcFbcojoY5/jrKW29h/P8f/?=
 =?us-ascii?Q?gO3NyZOJ2zN5MKGX4q0vLfyiVY4QfDCOBp0kkZV4P94+kLPHl430QaOb8Njr?=
 =?us-ascii?Q?zrPDHn5V+o1cEOKQquu1Sx+abLTV2SCR0lKrVNmh63lfSFeSyd6fzyfmo2M7?=
 =?us-ascii?Q?Ys0Khj0WNMsWUCTQZWuBopzw5gPlOK8qLZP2AKUnhYNjqfC6z48iVTZShQso?=
 =?us-ascii?Q?pWtb2wNi8U9fJGpG66OYYeqE/ZwadxPrZ6EDK8kMuj2D2anipEiW7hsWwElh?=
 =?us-ascii?Q?hIKwM7YlGFcKwksjpzuUuMskKW13XtMo1ZYIeuf19PUAE9XIyFubYtjXvCg6?=
 =?us-ascii?Q?ksen2zuvgXFu92C+loC9881NRodJdvT3wiKIzmnp/YRvECzJ4xscNmXbjG6T?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb06852b-7231-40ae-1a53-08dd51c4ccd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 15:39:44.7724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eG3dJjXBwUj0vYeU23zYOKM+cT0frvDBrgPzOMmY8WWNo3SKEeNIY50aWzMsQUWvf2q19LXSKlRkLDWBRONhQphWJgNwpOUMR/8wVuvrF1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
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

Hi Brian,

> -----Original Message-----
> From: Dooley, Brian <brian.dooley@intel.com>
> Sent: Wednesday, February 19, 2025 12:50 PM
> To: Ji, Kai <kai.ji@intel.com>; De Lara Guarch, Pablo
> <pablo.de.lara.guarch@intel.com>
> Cc: dev@dpdk.org; gakhil@marvell.com; Dooley, Brian
> <brian.dooley@intel.com>
> Subject: [PATCH v4 1/3] crypto/ipsec_mb: add SM4 GCM support
>=20
> This patch introduces SM4 GCM algorithm support to the AESNI_MB PMD.
> SM4 GCM is available in the v2.0 release of Intel IPsec MB.
>=20

The first patch of this patchset should be the one adding SM4-GCM in crypto=
dev,
so compilation is not broken between commits.

> Signed-off-by: Brian Dooley <brian.dooley@intel.com>
> ---
> v2:
> 	Added aad to cpu job params
> 	Added ipsec mb version checks
> v3:
> 	Fix naming for patchwork
> v4:
> 	Remove cryptodev changes to separate patch
> ---

...

> +++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
> @@ -826,6 +826,36 @@ static const struct rte_cryptodev_capabilities
> aesni_mb_capabilities[] =3D {
>  			}, }
>  		}, }
>  	},
> +	{	/* SM4 GCM */
> +		.op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
> +		{.sym =3D {
> +			.xform_type =3D RTE_CRYPTO_SYM_XFORM_AEAD,
> +			{.aead =3D {
> +				.algo =3D RTE_CRYPTO_AEAD_SM4_GCM,
> +				.block_size =3D 16,
> +				.key_size =3D {
> +					.min =3D 16,
> +					.max =3D 16,
> +					.increment =3D 0,
> +				},
> +				.digest_size =3D {
> +					.min =3D 16,
> +					.max =3D 16,
> +					.increment =3D 0,

Digest can be between 1 and 16 bytes.

