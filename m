Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECD3C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:43:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB3DB40661;
	Thu,  7 Aug 2025 14:43:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2454A40395
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570582; x=1786106582;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qTFh827NPqhrbSJgxSrL3+QLWsjAumXp9X8X5qvUqG8=;
 b=OaHQ/tA3PMgx0Ue1nCVn5jy9xzegARm1aV9MRi0mo2WLyiEdD3BBKlrU
 erx9ig7BfVjN1zmyY8Naa0Kgj0nk4eP/9IV8RwRURio2Xx2NE1CwaJVVc
 CK1ZUx5sAdhnBZDoLvCtY/ibqSmuZtDdZftq2gIyoTVSivG4i8WB3iIyZ
 0kIImPTMruAji++V1sdDsOECFe2lq7tB4I/P4QK79liL7/J1BrO6vYt87
 CNXXsdVos93T8/iV9lmfQZzYvcaZbPi/74YGCSN1OqrPZz+8niIzVHfA3
 +WSgH6i0YxT2EiMKDf4zpOSbNNiu+vCIkC4YMz0VgfhFYSLm7JOBriui4 Q==;
X-CSE-ConnectionGUID: 5fKdK/eNTvGUjgOrrLU00w==
X-CSE-MsgGUID: 8FhnUR0RR+mkGVCPr8UxGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56774107"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56774107"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:43:01 -0700
X-CSE-ConnectionGUID: LfRR2zrfTBGDMOodKUdvrw==
X-CSE-MsgGUID: TCWmNz6cSt6B0hpwXZoNJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195887032"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:43:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 05:42:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 05:42:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 05:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLLLE3hkJWrsxQ8mfN86UoJCTApEaDHCECtMRnt/PCu9Bj6BqFKVUzqeIES6vH8j5F4GiG34HPwqkLz73yWAAE830lDSU/ajYiOPIWRhtNOFJM3LOHSOSi+j5VqHGR6HJDRzqvojfUeYjqU4tfZTMHujOxQdi8IhBs5XSNH5tPT7K13wmzdKtWP1C2CR1OSgPion/9NjCW336xIwJa5Xuft6oq5P8ZK820AWbCuFJEuRVbu32muml4lQ+5KklN5sIGSCDJEaOyQIfldFuFhIVt5SCvEkQTRqCbOD5ZXqK0LLdTQf3LdWigE7UaXxCdSktUqGyDMdm0lAG5Dc5DKjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3ssCAQ8zus2vlg3Fmir38tqZyppjKYvjUFmpGVanMs=;
 b=mYn4XqrRuVqZIWyooKqxGtEZK6TdoCfgDqTTfQr57JMiAS7AqPjVwACWhSoS8/svo2YPkpYhmu8UZkM70u/YvSaPt6rVNtc6Qdd1gnfjD5FIUdraXUBHxOlPSu8s4zuqaPPfcltNPj0BEB5h+ikv4/vULBNlVQ4V8nne6gI94ZjsaGiC2wGQWcQeBxx8sfv1e2jS6yd0Gxx9Sg+UgrduvX+6QNdH4iNHyv0GtEHOvJ1bmtaQOtZN/3790z1TKpVbxDwKp9MeffqUGegOK1/NkJYr+2QGHSTEfcUpsxAnnNgBJ335OpinmovQ6wb2nU0eOpjPmOJ6NQLDeqkNvzgY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by LV8PR11MB8605.namprd11.prod.outlook.com
 (2603:10b6:408:1e5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 12:42:54 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 12:42:54 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] net/ice: fix Rx vector offload flags
Thread-Topic: [PATCH] net/ice: fix Rx vector offload flags
Thread-Index: AQHcB4u1Ko+UkHyznUSfAeAXNmvQM7RXIhAQ
Date: Thu, 7 Aug 2025 12:42:54 +0000
Message-ID: <DM3PPF7D18F34A1D78C76357CD3EC36F7AA8E2CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250807110843.54385-1-bruce.richardson@intel.com>
In-Reply-To: <20250807110843.54385-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|LV8PR11MB8605:EE_
x-ms-office365-filtering-correlation-id: e19d5c73-178d-47d5-130b-08ddd5afede3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zEQ8ZN/dSKBitlw8lpu7NxPBrDK683mmfbPkqndzoejSSKYtJP5anZGVZbEA?=
 =?us-ascii?Q?13h2OGav5/9/W0/WgkwEQEP44X+41Aeqy2IKVpkJ7bg34bthYecXjTOsyw5t?=
 =?us-ascii?Q?KT2mBRA3fYQW/hPG61kD9WQfw9R6OvrY5BWvcj9jIrQMC9qfWjU2vjT2SWmB?=
 =?us-ascii?Q?v88wtRRy0GuLGc9w7mZ8QgpgjD9ZCA+c8swsKH6O38UQRLJQHS3DO0/09i4m?=
 =?us-ascii?Q?kMdkhYuNBkmipKu8Mbao+06G1ic7oXHnaSPEaKrpq/SG9NqJDfUsYpW0Jj66?=
 =?us-ascii?Q?salkSnqHnxjTEsbhzNnotsTdfDUy3/SGTz8zlOWLH56gTDHNHLuzgK9eSSqt?=
 =?us-ascii?Q?Vhp2kTor1WumH1YRUchKK7YLI76PuDkeTntsyPC4fNBxqLEiI4Z92E7vNJdN?=
 =?us-ascii?Q?0ETil/LWttR36nfKCyyN9vXQ1ixscsiqxrfbLAnfK1EPsBfLIfU/spgQngo7?=
 =?us-ascii?Q?H1A0IwKTSnDAIVFLPHU0MW8V2PvBCryr7UfnCbHIY3hG+EuMjvp0jlwQpnFx?=
 =?us-ascii?Q?0bnzh33xnBuovl45T1Pfy3ToEqOSLdm9G5HujeRVgrjWGmZl4juO9p9jbK/o?=
 =?us-ascii?Q?0wabaL5pLdEqiTsURrUk21iKnd1MMcVGKpC++OnUYpp8fKXeZ9K1vbEC5/Qw?=
 =?us-ascii?Q?aDouc1bwGydDaZgfQCb5JL9tOWGL08DBMMgf2crI6AJDrLkeBDGIRpRflwPC?=
 =?us-ascii?Q?R6r7vU/Z6SnezuPqxwG+j9jYJtHAZnmfQwuCJ78JyqhfowzcEU8PxWdh4YRo?=
 =?us-ascii?Q?4/ohP0C7YxNKJW2zoth9xTiemDY/MpLPULZhaOaBjUUszMtIIrQxX3HUQKhA?=
 =?us-ascii?Q?2hVIu/SF5dWCjiquLyI08UaVhHLLeUcJOvQB0X/xOGSgFgbSadu67DA7A1dv?=
 =?us-ascii?Q?q6txWzxtAAB/OeRxMgfoevnL+cogLUq0u8pejrp/Tmngol7LFEwVB4oDNVXt?=
 =?us-ascii?Q?ZP5uiI2PIpXWGaIxsINKgwlmBkhe8t2zVJ9X3rL4JXyxk5Rth61LGEr+3l2+?=
 =?us-ascii?Q?qAyu4UpymETHzTwCss/pRTO2s3B52/AqsEYlL4UzyNA5m2GLOBOlb26MtZT/?=
 =?us-ascii?Q?ZddVi3DFafmlx5qSFLPdJUQIg/BbIWL+omVAwF6uj9HYBn3a5pi9d0KfMtIE?=
 =?us-ascii?Q?vd9C5Ey2MIO8XolmZ4T4699DYPsof/B7ikjbEZRoovLXjf6gNdVXW1LEF9zu?=
 =?us-ascii?Q?z35zXa1SM4Gqq6lOaH7UtLvTT4K9xOFA1HFEK7WcZC3BlI8lajete1RvlM3F?=
 =?us-ascii?Q?QCMkPPdYmWW+Z/ZMXRAIGlfSOHip9zuJonv8zxtR29cL3FMrsnFsaezdkFLH?=
 =?us-ascii?Q?pbC/YpQ2j9KOqBJGaODWyR1HKbhHFFCSaIdKVFM1SVYyLtRNgaThEx+rSDBQ?=
 =?us-ascii?Q?VJuxWQR/PP1paGATxf6iG3oJFogNI8MShkGqL/CGHQ53kw9zD6cWgHhI5eQu?=
 =?us-ascii?Q?cMQbAELKSqi02RaMpEYysPalp/RrMvfnewIqldgpm6er9QEZtKZzvaXajMUH?=
 =?us-ascii?Q?o7yPq5fCzn3ZX/Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1YWoYhLJsXo0U0ap6/pCifGlbjuFqvaQanD0cnRkFmzl3rqSWtjCeaaar0ZN?=
 =?us-ascii?Q?YGV2x40eq84jSjCqltRwzYf9MDdh7iLuDI/CysiDvltRyAYXfZh8ueIN+V5f?=
 =?us-ascii?Q?OtuALyxI1xxxKlteFXsV1tWnjqOpKc/tEERG0xrEQtdupFmsWHNFRsv9jwDS?=
 =?us-ascii?Q?VQwz0B/xC34pEd6NKgSg0b/dREDIEoIEsPYfr/Zji+FY2wqjiaKTN4UCHmwW?=
 =?us-ascii?Q?OhNBe7NFcH0LfYldlsmf1CoVZOS6COInx6UCqlzVu1wOcXqc3jG9k/7/8RKO?=
 =?us-ascii?Q?phvKTAkfYjasH143AMUzd/Udjo5elZDe720aaanMqGLYCRtR0U142ImOtjvl?=
 =?us-ascii?Q?ZWuMm1rpoplSqGokKB4sW5lNNP38LB1vTuVpcah/dj8gvduhEkIZlkR4WFyS?=
 =?us-ascii?Q?5nsY2rJoMVLu/m2cZPDGdZfxZO7GNV9EoIYr27GjzFDxizBFu/hCvwdos0w8?=
 =?us-ascii?Q?zMoAmHply8HEPTJddNbwl1c+LTszVZgSidMmjjwe3FnKpn4nsq9OxZd4rOvI?=
 =?us-ascii?Q?f9zJczpN/58EE6psvUx89RppU0YLPTK1Hlmk8/XzJUupRW/KgYF2s8/kYUXV?=
 =?us-ascii?Q?7S4b0tYwvm1ZLQxgDidKaanY++duwM8vCiSWExReXh0ye4ncKfda2pxXcGOU?=
 =?us-ascii?Q?6E6yyFd+EIPzLul5u7787TmtPQq2L1uHgeJuRYPO5lUQjP3z5kWxdg+08HN3?=
 =?us-ascii?Q?1d4Q+scoqr6ZVdXFS+2ZKRXv5LBy19QO9VgWRVVwdP5d+yGH1rqjjx8fUCT3?=
 =?us-ascii?Q?dynLAac9DSWPWZJVSazah5Tl6GyisTqmJaflUPlRzQXG4lAEkQUNTSuTimex?=
 =?us-ascii?Q?LtmYH7ZtH9iwwZaWK3aJ4XlKUG8Jec78evtL9oXbaJELslCLeXKUwnoC7p/e?=
 =?us-ascii?Q?aus6rL10crZkzGS/bqd4UB9JegKJiPGl3cAoi07HBhkpA5luzj1ufv6n4BAK?=
 =?us-ascii?Q?8aWJVyP2o0JzfFEyee+kc4eyg2vs2U3QxVdoaW4PEjR8t75u9CgyTRZbxJW3?=
 =?us-ascii?Q?OU+b9ad6cfKGIgULn1W6/gh4cNT1LU7YiZdghwstPigB+Mkwe506C84anmLr?=
 =?us-ascii?Q?9qCEXS7Uxkw97EtyqaIBlzC7HvZ6u1KtTtGnsbFshB0ssIzOyvkE0zfYIUfG?=
 =?us-ascii?Q?wgq6UJHzxzzRC8SYcTXVgqgBkcJ4DqxQ1DaTnpf7KvMq4/PwhP1A9RoZU8Az?=
 =?us-ascii?Q?e0ZL3vvkFNWHApUlER+DFahgjMT67WIK3UC4DMqGm3heNSAU6bX6uGiJrNyE?=
 =?us-ascii?Q?gycg7ZxOULjFC7ixRUgO4rE/0DbGWy9atn/T6Lk1ticLE1DF/+eWqOwmoEpT?=
 =?us-ascii?Q?y67AI8IA8merB+s3aNcNSmr1C2NSrJS8E+Xdd2V50f1sP/bUa3moe9SmGV3p?=
 =?us-ascii?Q?SKKktg2EsdIRCDtmjxN0FFFud+tW6y3Cz/WJKDymLlf1mpSXtk+D4yBUFKYd?=
 =?us-ascii?Q?hsCHWhJNgW8aWAQ1Cu+1UlGFAF8x/GSjDqggv8BfhEBdLvZSUwCc0Uw3jm4s?=
 =?us-ascii?Q?7c59ApB7M5VFomu7EEZDdvuyCh1VpKhm9vJlhv1hXcXwnc5Ar5JBz/flZ51J?=
 =?us-ascii?Q?i/Ux6IvzTVVcmrtY/48FcBMd/k2ZNck6HLOn8oTS1UUpYY3LG8KrR6F11WUZ?=
 =?us-ascii?Q?JuuY2FpH8hNbPV34lu3p9eTBmVSIo+4VrByX+TYM6bf9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19d5c73-178d-47d5-130b-08ddd5afede3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 12:42:54.3331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zuO9AW6VfoozP+wGd6dZyUUbndtDu+ZlfVSBKiurcCg9cPEzvc6RWlDHUrr8tMeH8P8YP3jurQJyYQM9jXPhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8605
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
> The vector PMD datapaths for ice do not support QinQ, so we need to
> update the vector offload flags to not use the general RX_OFFLOAD_VLAN
> flag (which sets all vlan-related options) and replace it with the
> individually supported VLAN options.
>=20
> Fixes: 808a17b3c1e6 ("net/ice: add Rx AVX512 offload path")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx_vec_common.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> index 9430a99ba5..e41fd8fc7c 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> @@ -72,7 +72,8 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue
> *rxq)
>  #define ICE_RX_VECTOR_OFFLOAD (				\
>  		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
>  		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
> -		RTE_ETH_RX_OFFLOAD_VLAN |			\
> +		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
> +		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
>  		RTE_ETH_RX_OFFLOAD_RSS_HASH)
>=20
>  #define ICE_VECTOR_PATH		0
> --
> 2.48.1

LGTM.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

