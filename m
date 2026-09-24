Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7565AC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 15:01:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8127240611;
	Thu, 24 Sep 2026 17:01:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 7EC6540144
 for <dev@dpdk.org>; Thu, 24 Sep 2026 17:01:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790262098; x=1821798098;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=UkAPuerQdGeK1LSpNzmklwAeHwjM0++53q+uMt39hmw=;
 b=RfPihQhZoe5vMbBTfjdPAsEJcAVP0hIFSnp1AJCezZAMVyKO2EbAYSs1
 x0fhbHKFD0Kc6ljBzR4fBDP/WeJ+svbcIECD179z+8HLI5CsdYmQ0KQkz
 gEVlU+0J/rT/YkZ7eqUB5asTrzQqSW03xb9AfAgT6F+4Rlaz/3wMCVuwn
 4ACy9swNK8D8xi0Txm/My74uS4k5IDbT/Jaf6WtWLkBxcfMyggbF0dpBz
 RbhCC+skoPBz9gznS/NEGUJQ6AwcXxI+UjizHYBJTWQicM9vgRYEahw2U
 eexfJhvHDHMa3x6vESmhUy0p7xeOQo+p40EzFdWiiOD+U3172RrMYTvtb g==;
X-CSE-ConnectionGUID: qzgXGtxKTRayzxIBGiSvNg==
X-CSE-MsgGUID: N0HY9GZoRAOklxkC1Rhq0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="116560970"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
 d="scan'208,217";a="116560970"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 08:01:37 -0700
X-CSE-ConnectionGUID: 4GMWhfHaRE+7GKo6IN0E9A==
X-CSE-MsgGUID: V1Ixv6SyS4COu2D2CSeaqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
 d="scan'208,217";a="273621737"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 08:01:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 08:01:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 08:01:36 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 08:01:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/9qos3KLmyKMJOirtI1HXh5nyaqx2JKDeFnXrT1TgqGqoMtjUpXm0zHV/bTdTgQFGA55ohZeVPR8zGfI4Ey4JlBZKkmUYb3YEE8QPHddGMwu3f2UK61Rz0u7z8VO3K77tflSq/p2N8xKytDeCEWS0z2u2ONlhIXRfYRG6jkdeYFD5X9UWdrGdGZeF31/t1REcAxE2gAr4M6W29DnMR7jXwj1nK8qABQDe5Xwz8cEjJjS9zAwzTvxCyIvf6CoLYZ6P6oDXaue/bwMVx1rALCcyru0pJQ7TioLu1Ecrq/Sr8H7Cgezp0Ps6WVrKfCD+V8BrzqNOZ5NF4mBFe8QsUf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Akls2VgWc54CVfQTKqj8lPuOqAV3hz8rN+iQlEfRRW4=;
 b=ZAiKJNAL0AgEgvR2/PHqdcDmVBY5yJvNdsLc5TYUgYxACwhO6s4Jj8r+5ODuVoce45AX/oOOnu3G1Z9Ao3ObeUjUPtWOLhzC2mMX87HV3Eb9ypI2Jo0xrl539O+y4mwXP6RXddeCvsgLYSq9I8kLXozOL4F/f2evC07iYteI/NVFQi9wLqhun+nXvsqTvTjt3Zc9VJJA2lJ9nkqjiAP7tn8GVyG02TuQ3WJD6DetFLcc6DJHuhGg4IHw0Awh1SMA9kCa2ZjBIyMV0/3YgXDF4tGOOLDqj+TZdkScqgQ2Qo2xS9kcI0812RK2f3JmC5aSIbGpUFEjOWvOtpxGGrPS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by CH3PR11MB8548.namprd11.prod.outlook.com (2603:10b6:610:1ba::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 15:01:23 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 15:01:23 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Thread-Topic: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Thread-Index: AQHdS2ztqX5wS6X2YkaTStj9V6UhG7bdzPeAgAAFXkw=
Date: Thu, 24 Sep 2026 15:01:23 +0000
Message-ID: <LV2PR11MB6045AC38B49432A2FEA9C20281812@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20260923105003.2811322-1-kai.ji@intel.com>
 <20260923150454.2831132-1-kai.ji@intel.com>
 <CO6PR18MB44847C8EDAB63BA96FAA586ED8812@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB44847C8EDAB63BA96FAA586ED8812@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|CH3PR11MB8548:EE_
x-ms-office365-filtering-correlation-id: 6c668713-ece9-4f06-0b92-08df1a4cb312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|376014|366016|42112799006|10067099003|56012099006|6133799003|11063799006|5023799004|8096899003|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: PTzd5UGIWXK4m8hM4fQzFdi4XViwyXXgpO+4CuKDkZkORAEsF/NHsg11hRG4pqgvpbwfaWz0rNQMYy9aOACNUpxiaelh6AhkOs31uSE7YWUW+1OhTUzLMEMvIde314zLiGcIUR7kM6uTmAzxXdr7W8g7MLjr4OfykmBxEE60j5bSE2ylDtK1ryg8LO9UqZLGM1+1QBN3QIuQqsAF51hpmuo+uQTuiahH1X04B4HK2qLMS+7UiTRujPcS6fwO29T5mZXvwOWPeaE/sGQWX9mMS1XOZYg2H6zMaV9OCHuCNTnyR5CTqrFcnvDCfddJcg9iP9X369iNs5F8AC1cvqZy7Wcjxggq0jMqJBYAU0fx9PfLkFGkK9/AYECk76ZR+RGEAC/L63Q8NBwhbe6NdYGYvQ9Gum3/uW77FDpN6izObjz4vklFEZHtiQJ3WDAbYGMrwhu+arZf3siSTobn8B6Q8/+HTpHhdyAgx9bDAc1Xh3OG/qRrftwZueJCWAVErtC8+Vm2apMdzFTjgTVugSu1KiSGDhJfuFg4Edn33AXK2Zi35MP/hNet+v9kWXnhobey2oSUADY7nHyXa7MK261bTvKtMcBFOgg0gGGliOybolfCbLZm7sWFcMwA3zIuoV1cvOBC2PM84sLNMhfyI3kGAoEsSryMOodlH8XKcX5GoZtnYB+SU5UUVd5om9FMMFJIZe4u4YgPU3R4ssf+IVfPd+qU8PVKrADDzDt9iNK5qFY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(42112799006)(10067099003)(56012099006)(6133799003)(11063799006)(5023799004)(8096899003)(18002099003)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6fanprJ/VBsZlxEkxKIpuktS6x6msluq+YBaaGGTsPnNdZ3UTGzhseREqQ?=
 =?iso-8859-1?Q?RfM78cHFz96s+Nw46MMnIBhTQwhNamXgeNK8UJp+0qDBa/o2lZ9wDnKbQh?=
 =?iso-8859-1?Q?ODIhFMEFTZwgSvfhOX4j+VsG29AU0oe/2CpuiUxEJnR+gNgnTEMcUinJxi?=
 =?iso-8859-1?Q?9S2+6d0jcW3qy+s6J6AB+8n0SqwgpZEA14fBu9D++RNZEvik4MmlnCHqal?=
 =?iso-8859-1?Q?RPqYvqewRjdq5bLbJpozlqrXKZRthZBlK6RluSBuq83bYggaDawViB4to/?=
 =?iso-8859-1?Q?Qcv/d4JZ3r6VnDuIWmlc9doLGQx7cYwP92+l0mdykjNvD9Aph4dzViqVZ1?=
 =?iso-8859-1?Q?yKvE6Z926iVO6Jrdnm+c62gRAXN/dbOo0IIVthEI0UzlbhAmxrU8hHsXaM?=
 =?iso-8859-1?Q?VZJeI1OMAy3u5E8PKUNnbF00rrTsom2zsbRKsxNOM3cBE3Rw8UiZ1SpahS?=
 =?iso-8859-1?Q?hsmMUUj4UTwQ3sbGBhEmXomwbg06VAmJ7QEVKhwmeRo6AOx+OH6SnoojuE?=
 =?iso-8859-1?Q?Wx6RIbc7j6319uALT37wV5bYACuL7fiM9AaTfqjp3TUlWm+6U82mVUMtLI?=
 =?iso-8859-1?Q?qN8yBMe6ABsOyDpJ+8onif3RO1l/Ass4KEusJmCbkWOyowwciChZs5cCjM?=
 =?iso-8859-1?Q?rFFA2yK/Oz4Lo2ydXUfB+rs/LPhVoaxb9LVxyoIczeluUpONKK8bgMx18+?=
 =?iso-8859-1?Q?Y9WRz53IAY/Ah0gj0Ti9Kx2LTUhzfNtWEjW9yvrIrtNgpyh8c/FfEiR0ZV?=
 =?iso-8859-1?Q?6+etEepPPBqlF58TEe1s+ywyxCrUCga7zikLhGhwo51gXFbLS+ZM4aTb5s?=
 =?iso-8859-1?Q?XIMbcKC2cuSmvxUHIIaE3yfyyhX9T8KMUg8qMhyeMXjZKh5zHfMp+eWteg?=
 =?iso-8859-1?Q?zP68QXrERGMHdmDSX+IiceU926wQp3p7aI8ZoKlWDvvWKowvf9MaI3ozcN?=
 =?iso-8859-1?Q?1SNLkrDBc5Py8rYodowCDemICkl2qC/NLnloJmzCI3o7mB88Zh2d6EODul?=
 =?iso-8859-1?Q?SD92R2tSHjWMIn7qKkclhSG44AGKZiPuLFvbaWXBsdhXrSbK4KY53fL+oH?=
 =?iso-8859-1?Q?+OjvX5FDtuwQ017Knsnu4yrulopwe+GSZyu/MX8FZ72wcLQoCY7EmFh6II?=
 =?iso-8859-1?Q?otYY4AGdq9rCd+32ty49CNNL9EQS+SkzxyPr0JQgM4UWYtHd5f4htPVW5j?=
 =?iso-8859-1?Q?4XH15CWbsXoVpIjXvRa84tiUpIbe5yGK67gktCFq5unKjnDC2Q7w/NazYl?=
 =?iso-8859-1?Q?DHRQpiDEnbvx5K/306D4BRhShBUq5+siocHcqQ4ZWO+L/ySWMp4qoEr+wH?=
 =?iso-8859-1?Q?gvQZtMjuAnUoqK2N4EMQR6sBQQOXNxp5lFVYUPSi98N3zK2wXksqIiB+10?=
 =?iso-8859-1?Q?ldf/Jk33rORoTpLR5dTFzprDyUaA68DbdIoKWk6RNhdgHlhVP6g+mMN0K2?=
 =?iso-8859-1?Q?/JPfBRASR3nemFBERm7nPjvzHAjE1V/6akMpHXfgoh2hXACRiioz3A5cwP?=
 =?iso-8859-1?Q?VrRWjBWnNxD2vqRzuwzIlyLnwW7kgk1RYxcrJM+K75Y9G1RCBzpt/dF6R2?=
 =?iso-8859-1?Q?QahMECHQ2yRY+23OIgrs0loyRO8qO1IqHpK/riyyygfcugTa5D3Uve5d+I?=
 =?iso-8859-1?Q?o5dKS5wP9rGKK3a0yY0w9H5dRY74937LtfIFJcbmQY0+Za4kmbUk+wpfy6?=
 =?iso-8859-1?Q?THp4v1pq+8U36goO+/Exq26IZ7naRxDv/9T3dI4yavKwTBIc5ufrcDyETp?=
 =?iso-8859-1?Q?XMnzYk18D0bYlJQUxB2lhqbHuF9Cb+6XJTbwZqrZuaNHqoVrbEdBE6/POa?=
 =?iso-8859-1?Q?z7/QSUW6t2BTlQtSIfjlzun8lEzNJQoU4LW7HEzcW5xB5krzMqd8?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB6045AC38B49432A2FEA9C20281812LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kt2VKtCm2Re24eZAzZHhLebIyKetno3mQ3BipcxLBilJQTLHry+02VE1V3gpWj0yUwgLWfK82g/z1ujMqWFbAmA3MOXLcBa/IZjTFfq1AAxJqD8LQozF6F3xUvVquIixOTLW3p2ZsX7vOQ0Wy8blqsvdrfMha2j4cxXYl2i/zZuCFyPj/SSswecyyJKBAGM08JyMfS8o6ZkizVl77zWGzU9RKgNXgPmFeGiMw233yTMmdkU4aUg2VK+XvxyMi1fGW75/kmbp99CpqQu0Co6eifB0Sxwsf6453xSXk/qD8UMXUfR5dpiipRhYR7TMPJmxR/JiRyaAn39WBcVLmeT5AA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c668713-ece9-4f06-0b92-08df1a4cb312
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 15:01:23.3881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W33txgmPd8giPBIne9pSKCPBYAos41aawrPbQN+GfIrZSJx9VVnBm2fCsU5DCpgHGS7Ufe4Z+ui1I3Puu1UCrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8548
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

--_000_LV2PR11MB6045AC38B49432A2FEA9C20281812LV2PR11MB6045namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Wycheproof differs somewhat from the existing cryptodev test vectors in tha=
t it is an externally maintained collection of JSON test suites covering a =
large number of edge cases and negative tests. The intended usage model is =
to load the upstream vector files at runtime rather than embedding them in =
the DPDK tree.
I think the existing examples/fips_validation application follows a similar=
 approach, consuming external CAVP/ACVP vector files rather than integratin=
g them into dpdk-test. This patch follows that precedent, with the goal of =
providing file-driven conformance validation as a standalone example applic=
ation.
I agree that the documentation can be improved. At minimum, the .rst should=
 describe where the Wycheproof vectors can be obtained and reference the ap=
plicable upstream license, as the current example command may give the impr=
ession that the vector files are included in the DPDK source tree when they=
 are not.
Regards

Kai

________________________________
From: Akhil Goyal <gakhil@marvell.com>
Sent: Thursday, September 24, 2026 15:35
To: Ji, Kai <kai.ji@intel.com>; dev@dpdk.org <dev@dpdk.org>
Cc: Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app

> Add a Wycheproof JSON vector validation example for cryptodev PMDs.
>
> Support these algorithms when advertised by the selected PMD:
> - AEAD: AES-GCM, AES-CCM, SM4-GCM, ChaCha20-Poly1305
> - MAC: AES-CMAC, AES-GMAC, HMAC SHA-1/SHA-2/SHA-3/SM3
> - Asymmetric: DSA (P1363 verify), ECDSA (P1363 verify),
>   ECDH (ecpoint shared-secret compute)
>
> Validate valid vectors against generated ciphertexts, tags, plaintexts,
> digests, shared secrets, or signature verification, and require the
> expected rejection for invalid vectors. Digest inputs for DSA and ECDSA
> use the symmetric auth path, selecting a separate symmetric-capable
> device when the target device is asymmetric-only.
>
> Skip parameter combinations outside PMD capability ranges and identify
> recognized vector families without a compatible DPDK transform. A
> --debug option lists every failed or skipped vector.
>
> Add Meson and standalone build integration, with usage documentation.
>
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
>  MAINTAINERS                                   |    5 +
>  doc/guides/rel_notes/release_26_11.rst        |    6 +
>  doc/guides/sample_app_ug/index.rst            |    1 +
>  .../sample_app_ug/wycheproof_validation.rst   |   50 +
>  examples/meson.build                          |    1 +
>  examples/wycheproof_validation/Makefile       |   40 +
>  examples/wycheproof_validation/main.c         | 2090 +++++++++++++++++
>  examples/wycheproof_validation/meson.build    |   17 +
>  8 files changed, 2210 insertions(+)
>  create mode 100644 doc/guides/sample_app_ug/wycheproof_validation.rst
>  create mode 100644 examples/wycheproof_validation/Makefile
>  create mode 100644 examples/wycheproof_validation/main.c
>  create mode 100644 examples/wycheproof_validation/meson.build
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 186cc82b39..580e2c2591 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2099,3 +2099,8 @@ F: examples/vmdq/
>  F: doc/guides/sample_app_ug/vmdq_forwarding.rst
>  F: examples/vmdq_dcb/
>  F: doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
> +
> +Wycheproof validation example
> +M: Kai Ji <kai.ji@intel.com>
> +F: examples/wycheproof_validation/
> +F: doc/guides/sample_app_ug/wycheproof_validation.rst
> diff --git a/doc/guides/rel_notes/release_26_11.rst
> b/doc/guides/rel_notes/release_26_11.rst
> index dec96ccbc7..cd2711ddad 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -133,6 +133,12 @@ New Features
>      with per-descriptor mbuf free (``rte_pktmbuf_free_seg``) and prefetc=
h hints.
>    * Changed the set of per-queue xstats counters.
>
> +* **Added Wycheproof validation example application.**
> +
> +  Added a new example application that validates a DPDK cryptodev PMD ag=
ainst
> +  the Google Wycheproof JSON test vectors, covering AEAD, MAC, DSA, ECDH
> and
> +  ECDSA algorithm families.
> +
>
>  Removed Items
>  -------------
> diff --git a/doc/guides/sample_app_ug/index.rst
> b/doc/guides/sample_app_ug/index.rst
> index 28c4c9a5b2..2458b06ccd 100644
> --- a/doc/guides/sample_app_ug/index.rst
> +++ b/doc/guides/sample_app_ug/index.rst
> @@ -51,6 +51,7 @@ Sample Applications User Guides
>      ptpclient
>      ptp_tap_relay_sw
>      fips_validation
> +    wycheproof_validation
>      ipsec_secgw
>      bbdev_app
>      ntb
> diff --git a/doc/guides/sample_app_ug/wycheproof_validation.rst
> b/doc/guides/sample_app_ug/wycheproof_validation.rst
> new file mode 100644
> index 0000000000..17c8bd2b55
> --- /dev/null
> +++ b/doc/guides/sample_app_ug/wycheproof_validation.rst
> @@ -0,0 +1,50 @@
> +..  SPDX-License-Identifier: BSD-3-Clause
> +    Copyright(c) 2026 Intel Corporation.
> +
> +Wycheproof Validation Example
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +This example validates a DPDK cryptodev implementation against the Googl=
e
> +Wycheproof JSON test vectors.
> +
> +The application reads one JSON file or a directory of JSON files at runt=
ime and
> +checks the supported algorithm families against the selected PMD. It can=
 be
> used
> +with a PMD that advertises AEAD, MAC, DSA, ECDH, or ECDSA support.
> +
> +Build
> +-----
> +
> +Build the example from the DPDK tree with Meson:
> +
> +.. code-block:: console
> +
> +   meson setup build -Dexamples=3Dwycheproof_validation -
> Denable_drivers=3Dcrypto/openssl
> +   meson compile -C build
> +
> +Standalone Makefile builds are also supported from the example directory=
.
> +
> +Run
> +---
> +
> +Run the example with an OpenSSL-backed cryptodev and a vector file:
> +
> +.. code-block:: console
> +
> +   ./build/examples/dpdk-wycheproof_validation --vdev crypto_openssl -- =
\
> +       --vectors ../wycheproof/testvectors_v1/aes_gcm_test.json \
> +       --cryptodev crypto_openssl --debug
> +

Why do we need a new application to perform test vector validation?
Is dpdk-test crypto tests not enough?
Can we integrate this in that?

And I do not see the .json file mentioned above in the patch.
There should be a sample file atleast.


--_000_LV2PR11MB6045AC38B49432A2FEA9C20281812LV2PR11MB6045namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
Wycheproof differs somewhat from the existing cryptodev test vectors in tha=
t it is an externally maintained collection of JSON test suites covering a =
large number of edge cases and negative tests. The intended usage model is =
to load the upstream vector files
 at runtime rather than embedding them in the DPDK tree.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
I think the existing <code>examples/fips_validation</code> application foll=
ows a similar approach, consuming external CAVP/ACVP vector files rather th=
an integrating them into
<code>dpdk-test</code>. This patch follows that precedent, with the goal of=
 providing file-driven conformance validation as a standalone example appli=
cation.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
I agree that the documentation can be improved. At minimum, the <code>.rst<=
/code> should describe where the Wycheproof vectors can be obtained and ref=
erence the applicable upstream license, as the current example command may =
give the impression that the vector
 files are included in the DPDK source tree when they are not.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
Regards</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
Kai&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt;"><br>
</span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Akhil Goyal &lt;gakhil@marvell.com&gt;<br>
<b>Sent:</b> Thursday, September 24, 2026 15:35<br>
<b>To:</b> Ji, Kai &lt;kai.ji@intel.com&gt;; dev@dpdk.org &lt;dev@dpdk.org&=
gt;<br>
<b>Cc:</b> Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>Subject:</b> RE: [EXTERNAL] [PATCH v7] examples: add Wycheproof validati=
on app
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">&gt; Add a Wycheproof JSON vector validatio=
n example for cryptodev PMDs.<br>
&gt;<br>
&gt; Support these algorithms when advertised by the selected PMD:<br>
&gt; - AEAD: AES-GCM, AES-CCM, SM4-GCM, ChaCha20-Poly1305<br>
&gt; - MAC: AES-CMAC, AES-GMAC, HMAC SHA-1/SHA-2/SHA-3/SM3<br>
&gt; - Asymmetric: DSA (P1363 verify), ECDSA (P1363 verify),<br>
&gt;&nbsp;&nbsp; ECDH (ecpoint shared-secret compute)<br>
&gt;<br>
&gt; Validate valid vectors against generated ciphertexts, tags, plaintexts=
,<br>
&gt; digests, shared secrets, or signature verification, and require the<br=
>
&gt; expected rejection for invalid vectors. Digest inputs for DSA and ECDS=
A<br>
&gt; use the symmetric auth path, selecting a separate symmetric-capable<br=
>
&gt; device when the target device is asymmetric-only.<br>
&gt;<br>
&gt; Skip parameter combinations outside PMD capability ranges and identify=
<br>
&gt; recognized vector families without a compatible DPDK transform. A<br>
&gt; --debug option lists every failed or skipped vector.<br>
&gt;<br>
&gt; Add Meson and standalone build integration, with usage documentation.<=
br>
&gt;<br>
&gt; Signed-off-by: Kai Ji &lt;kai.ji@intel.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; MAINTAINERS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp;&nbsp; 5 +<br>
&gt;&nbsp; doc/guides/rel_notes/release_26_11.rst&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 6 +<br>
&gt;&nbsp; doc/guides/sample_app_ug/index.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; .../sample_app_ug/wycheproof_validation.rst&nbsp;&nbsp; |&nbsp;&=
nbsp; 50 +<br>
&gt;&nbsp; examples/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; examples/wycheproof_validation/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 40 +<br>
&gt;&nbsp; examples/wycheproof_validation/main.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 2090 +++++++++++++++++<br>
&gt;&nbsp; examples/wycheproof_validation/meson.build&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 17 +<br>
&gt;&nbsp; 8 files changed, 2210 insertions(+)<br>
&gt;&nbsp; create mode 100644 doc/guides/sample_app_ug/wycheproof_validatio=
n.rst<br>
&gt;&nbsp; create mode 100644 examples/wycheproof_validation/Makefile<br>
&gt;&nbsp; create mode 100644 examples/wycheproof_validation/main.c<br>
&gt;&nbsp; create mode 100644 examples/wycheproof_validation/meson.build<br=
>
&gt;<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 186cc82b39..580e2c2591 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -2099,3 +2099,8 @@ F: examples/vmdq/<br>
&gt;&nbsp; F: doc/guides/sample_app_ug/vmdq_forwarding.rst<br>
&gt;&nbsp; F: examples/vmdq_dcb/<br>
&gt;&nbsp; F: doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst<br>
&gt; +<br>
&gt; +Wycheproof validation example<br>
&gt; +M: Kai Ji &lt;kai.ji@intel.com&gt;<br>
&gt; +F: examples/wycheproof_validation/<br>
&gt; +F: doc/guides/sample_app_ug/wycheproof_validation.rst<br>
&gt; diff --git a/doc/guides/rel_notes/release_26_11.rst<br>
&gt; b/doc/guides/rel_notes/release_26_11.rst<br>
&gt; index dec96ccbc7..cd2711ddad 100644<br>
&gt; --- a/doc/guides/rel_notes/release_26_11.rst<br>
&gt; +++ b/doc/guides/rel_notes/release_26_11.rst<br>
&gt; @@ -133,6 +133,12 @@ New Features<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with per-descriptor mbuf free (``rte_pkt=
mbuf_free_seg``) and prefetch hints.<br>
&gt;&nbsp;&nbsp;&nbsp; * Changed the set of per-queue xstats counters.<br>
&gt;<br>
&gt; +* **Added Wycheproof validation example application.**<br>
&gt; +<br>
&gt; +&nbsp; Added a new example application that validates a DPDK cryptode=
v PMD against<br>
&gt; +&nbsp; the Google Wycheproof JSON test vectors, covering AEAD, MAC, D=
SA, ECDH<br>
&gt; and<br>
&gt; +&nbsp; ECDSA algorithm families.<br>
&gt; +<br>
&gt;<br>
&gt;&nbsp; Removed Items<br>
&gt;&nbsp; -------------<br>
&gt; diff --git a/doc/guides/sample_app_ug/index.rst<br>
&gt; b/doc/guides/sample_app_ug/index.rst<br>
&gt; index 28c4c9a5b2..2458b06ccd 100644<br>
&gt; --- a/doc/guides/sample_app_ug/index.rst<br>
&gt; +++ b/doc/guides/sample_app_ug/index.rst<br>
&gt; @@ -51,6 +51,7 @@ Sample Applications User Guides<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptpclient<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp_tap_relay_sw<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fips_validation<br>
&gt; +&nbsp;&nbsp;&nbsp; wycheproof_validation<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipsec_secgw<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bbdev_app<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ntb<br>
&gt; diff --git a/doc/guides/sample_app_ug/wycheproof_validation.rst<br>
&gt; b/doc/guides/sample_app_ug/wycheproof_validation.rst<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..17c8bd2b55<br>
&gt; --- /dev/null<br>
&gt; +++ b/doc/guides/sample_app_ug/wycheproof_validation.rst<br>
&gt; @@ -0,0 +1,50 @@<br>
&gt; +..&nbsp; SPDX-License-Identifier: BSD-3-Clause<br>
&gt; +&nbsp;&nbsp;&nbsp; Copyright(c) 2026 Intel Corporation.<br>
&gt; +<br>
&gt; +Wycheproof Validation Example<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +Overview<br>
&gt; +--------<br>
&gt; +<br>
&gt; +This example validates a DPDK cryptodev implementation against the Go=
ogle<br>
&gt; +Wycheproof JSON test vectors.<br>
&gt; +<br>
&gt; +The application reads one JSON file or a directory of JSON files at r=
untime and<br>
&gt; +checks the supported algorithm families against the selected PMD. It =
can be<br>
&gt; used<br>
&gt; +with a PMD that advertises AEAD, MAC, DSA, ECDH, or ECDSA support.<br=
>
&gt; +<br>
&gt; +Build<br>
&gt; +-----<br>
&gt; +<br>
&gt; +Build the example from the DPDK tree with Meson:<br>
&gt; +<br>
&gt; +.. code-block:: console<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; meson setup build -Dexamples=3Dwycheproof_validation -<b=
r>
&gt; Denable_drivers=3Dcrypto/openssl<br>
&gt; +&nbsp;&nbsp; meson compile -C build<br>
&gt; +<br>
&gt; +Standalone Makefile builds are also supported from the example direct=
ory.<br>
&gt; +<br>
&gt; +Run<br>
&gt; +---<br>
&gt; +<br>
&gt; +Run the example with an OpenSSL-backed cryptodev and a vector file:<b=
r>
&gt; +<br>
&gt; +.. code-block:: console<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; ./build/examples/dpdk-wycheproof_validation --vdev crypt=
o_openssl -- \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --vectors ../wycheproof/testvect=
ors_v1/aes_gcm_test.json \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --cryptodev crypto_openssl --deb=
ug<br>
&gt; +<br>
<br>
Why do we need a new application to perform test vector validation?<br>
Is dpdk-test crypto tests not enough?<br>
Can we integrate this in that?<br>
<br>
And I do not see the .json file mentioned above in the patch.<br>
There should be a sample file atleast.<br>
<br>
</div>
</body>
</html>

--_000_LV2PR11MB6045AC38B49432A2FEA9C20281812LV2PR11MB6045namp_--
