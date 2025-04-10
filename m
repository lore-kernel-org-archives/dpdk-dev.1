Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922C6C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 15:09:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B4AD40670;
	Thu, 10 Apr 2025 17:09:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id D6B30402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 17:09:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744297743; x=1775833743;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=G9rS/gQoK5DPfV5Sv62NmE1MCnbTbXPUeNcNjePcT0g=;
 b=EIfyMyEtV4sE5kcK5UnGKHu5NdAlIx6sHYfWd65GNOzyF3ZD3dB1/np5
 HhuEym8gE6AgA08NLZdiMP7gdwfC424+RboKg3pM8xWmXTpTR36yOSnIl
 3bWPwVhVVSv8onPEg47CyqDgVAL0KlwXKP0ydv/43IcU0DyHog9M8Q1qh
 NPVOh8ttUhiyZXAzlyrJSvVT9mzP+cCLEAqsHOeRMClRDpd86iV1/tvJX
 xjud0U0OHEhFfMXS6eXlJf4d/q6v+WR+43mDsJqPepAtiTl5RknLCcXo/
 u+JCJXIoMJqpep3QGIWKS8oa4f5D5HZLRq8WkyjkcxHMbQ8orzEvqJ/+U A==;
X-CSE-ConnectionGUID: 2GnzOeuDTp2D2MOdXLdthA==
X-CSE-MsgGUID: hwFNs2NBT4CPQhbqjJWBoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49663180"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208,217";a="49663180"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2025 08:09:01 -0700
X-CSE-ConnectionGUID: zakxQpDETsq4vUsECD4xQw==
X-CSE-MsgGUID: dR0GGziCQV+PmzZGhqNocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
 d="scan'208,217";a="133907870"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2025 08:09:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 08:09:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 08:09:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 08:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTQE0aqcjXMG0K6iwii0XBhxna92K8tQ8ofOSnkTSzRFMUtGAOwJEBNIMcWgXbsU1qqBVKX2vmu5UnHVV9B+AQZiuKdecAFnZR79u+gyTxkgPHKBnkm+jiKqGM5NHlXfs668Hex5zjuoqrfUXt4UoNvHNXm9sctunUkjd+o14CDfW5PNby4/FLFIg2Z/iuzWV1nQlcMc03sIE17GtUdyR9MW8A7jXGx6Ca//W05Jere9qcaMBZQ5PnlS015gp6seAc1uw2VO9vxsMacFT3r4Bo2FP3SepskNAARRpov1D3Ti+e6+7Pljay4lQOXQgLIRly9QY85m995TFiIDRgKzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLmJmbHBC4bUPK6apeUhm5LrxqwuvF8ZdadQ64T8mgs=;
 b=X1Vc0+2XIeCsH0l/UICYaCxUrihxbX9/M0W9EEVXpwyNTRR6KnVvsfURqquT5kFoRepn2Zoi8Z9P8K9JWexxfKbM/sQ+MOOwvfgAD8oZcXThXOmXd/WhELk/WS5yExlTMPO4TLNT/n9cQVv74ws2IfouI5pis3DbTRQGjsFEIlfZ29mIFdkHEnVlVANdvQz+//MoaheqsfJD7xlKKFtv8eC6KXX5/OK8W1TiyCXzrXfm+ruU7zJwsDPFQfDF080pXzk/siHkgEJeshdC3GU/jkaSzjq3kgkW2fAhXGVtbEo8kAEnagU2L5f4v9JTw6SJToccP5leL9Lj//fcRSizVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by CY8PR11MB7900.namprd11.prod.outlook.com (2603:10b6:930:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 15:08:14 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 15:08:14 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] cryptodev: add SNOW-V algorithms
Thread-Topic: [PATCH] cryptodev: add SNOW-V algorithms
Thread-Index: AQHbqHak02gPqQw0bE6Rj4zGe3nyprOdA7XO
Date: Thu, 10 Apr 2025 15:08:14 +0000
Message-ID: <DS0PR11MB7458D01906C92485711FD0DD81B72@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250408110851.2952910-1-radu.nicolau@intel.com>
In-Reply-To: <20250408110851.2952910-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|CY8PR11MB7900:EE_
x-ms-office365-filtering-correlation-id: ef79082f-ccf5-449e-4801-08dd78418463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?loM8DA0WTz4AFdR0GbM1T5tZw6EUG97D+NxX0v7bkltWQclDDwrxhw6sTD2F?=
 =?us-ascii?Q?kOxYwT4MTNXaifhS/KdUUuenEsXT4QkrsTkciFtRJPr1M4vgaCoNk0KTsJIj?=
 =?us-ascii?Q?8exFbrDZh8vdtPwvOBCFHOaNdZH9sukvJjbEiUP1+vISb8w9pV8xAczaDEGg?=
 =?us-ascii?Q?l5CZfrhIsmBrO+Q/96HrZWiEp6vlYFb6YavXUoFb3OyOJRwHtd5os7UriY7+?=
 =?us-ascii?Q?vvob0EwyTIs3LdyyL3yK9wWT2JmK0HeCSFIVzvv/4VYk1vj3xxlvKZNUvIiH?=
 =?us-ascii?Q?bE7D0M2CsLKAvRMWog1DEibECPBjKEYJw8yRotQ0YBj+y1pTOqnBgf7zjvD2?=
 =?us-ascii?Q?tcV5nINXVNDkAqGSU6OkU2V7V1bhEIEMfFwwT/e5soNareWl4cdG4gYQR0zM?=
 =?us-ascii?Q?KcRc7KRqlgGoLIO9A4HINSIcmZKT7UZqAv59dShMGyciSTG4kj/cBb+Ylcy2?=
 =?us-ascii?Q?mev7V3TMYFFRLETTGwpKOC0/Dgd4N9whwyrFszVEQFIf3dOelfA8aMMmPTA5?=
 =?us-ascii?Q?k7CIYD7e+yJjezfqS5MLmqbptU5hudAd4B2+LfMaO3dEuaFN4P1LXpSCfclq?=
 =?us-ascii?Q?5ArPXsfsIXx2+8IAKGBhKp68fAwtl2R7r2ctRDzD/FmctFyOQuJ88rT8ugAB?=
 =?us-ascii?Q?6dLgCQo5Tuz+YABL1pNlW6xpvZ5kFIMhkgt3V9xo5D/IAp8O/6eWQkD1zAob?=
 =?us-ascii?Q?/sKNRpDpsuPskzPD/cT1TxsWqAKkpbdBfzbBBUmGTqwy/nOqrEQ8TzuM1jQC?=
 =?us-ascii?Q?hYqT4q2eyqzCwG9IC9lQpGEtIKKrTdRhxeAQm+w5zMRfUBppZicqtkYAPRvV?=
 =?us-ascii?Q?tIfufA7YTDWGquU4Y5nIQ1tcgpLvzov9WdoQK1Mt684Bohiyx+ruoXIPYzie?=
 =?us-ascii?Q?BwcGYqzB6z62Gee7vutngv5GjbYBQ2RmmcIiU1H4bz3gmBenNNE3h7TW5oEg?=
 =?us-ascii?Q?AqAl87qUlh5KmmeAcHKpBFNFqZXbAAWFZeJ0th4yErvrToOcFcNI8JlJHz0p?=
 =?us-ascii?Q?x9vaee4pYF02N+Cu5k1U1bd4N/Qhq0qp86yDEnlPPm2fI16+BKp/mgZr6WuD?=
 =?us-ascii?Q?ZsecBEJqhqMaFrEf5UcTHW/s3/GDPdXNlBjdsGxvmh5559xEkXEtr8rygB7v?=
 =?us-ascii?Q?FGPjv7IUd004X851gVDaFdzqOExO0ZXqHVfORRV2CBHJ1U7GjC51bcIevxV7?=
 =?us-ascii?Q?shf4E6N1ht2ZjOIOdLL2S8Rn6MaW9SzyHj3vhiaqssJuL+ao5A7FffQsXlnN?=
 =?us-ascii?Q?+sRSj+eWVk9NkWRgMPKvH/LgWjEIFzKJNUvuHfmioWFZ4Z4gfMQXoWH7YqEp?=
 =?us-ascii?Q?JKj1D+xsenkZmqe2Kx9D2Giu6dOzExBzR+wYzM1/ngfTXordQwZnyT35Bn3w?=
 =?us-ascii?Q?bYePHrb229b8wMFTAD5zlnc9ZQj5XcfrzjZQe1tC1Z2nD1S+Zf8sRHJHcBQZ?=
 =?us-ascii?Q?dVUsqXqP0jwGnr/fmQXmHbMGm6uOBnyMcYT0IyAx01QewlX2JEyzEw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?op+3NQCDJ/QlTHIX5rebFclStSl7Fm3PSbxncebdIjptQXzPX7EkDW0NVQoO?=
 =?us-ascii?Q?yjUARLMo7mCiLOo3XdCYE+TyZqHhKelFfLzSj82+CkakWEboV+CrHYNXC3bD?=
 =?us-ascii?Q?aGNPILLpY+9EGTWaNFEXhNlscBE2ZG8FV08OXdVWD8faUEJbpHRBND/19pRT?=
 =?us-ascii?Q?VY9FsCfy3tTC5WPqP8UuaeIugtnxaWjx92ws0yHaJ/S9hwpwU6FfTuxkTE0b?=
 =?us-ascii?Q?BvIzsQDBOZ9aU4xI/o72THqhfreroGbpEUamFVUX5IgLEABULCrw3QdCRkAF?=
 =?us-ascii?Q?yjHcAdfEXxdTcw2vdcuodIXiBodWNfmMbRd2y4BxtwGqy3/m/efSusNvCi1N?=
 =?us-ascii?Q?Z15/vOSpXje/zDIMDw6qFPDUqP5EQj8wG1TNFh8iFFekOKAF3UC9kK7EA66Q?=
 =?us-ascii?Q?ljVhO74sTYIq+PsubYSlSZFXaO3s/tcgGGtMeDpbo7axFNFaqLS54WLO92av?=
 =?us-ascii?Q?XnK/84fHFLeDDSZsak+nvO7esiUW4GHt9SZGlyvue5TZ/FA2c659YyGrJHoa?=
 =?us-ascii?Q?TkQflLbIxL4I7Ctw7OFBobNRpvm6avpKm6DZum1dl9e+VoBGHFuzAiZQRV5U?=
 =?us-ascii?Q?XdJh7LcuPm3De8wCTnXq/W/1L3E+VtCqeSpP5dzJvKNQHke+mU3WiOBh//Xi?=
 =?us-ascii?Q?5K7frEruOt6qJch/HvhNVeTSZreiuJqoQcx0U9fxahW2WiDWUHx3oy6Wzehl?=
 =?us-ascii?Q?9OW9LQm+qc9A+8METt9QBGfgkheqoKUeHK9rO1s2dxo1MqTO+xzy68djYVxx?=
 =?us-ascii?Q?1SfKJCaikNv9m3uW67Z2LXixriK98MVbPnWytn8GMtDyYMFAUmRvlo/BbmwM?=
 =?us-ascii?Q?FsDByW3vCWLW/Q+2NIJ7331/nQnmvvB/dUk97zprvJR4s+1GOqsjzfb68Kc3?=
 =?us-ascii?Q?LLe2CUWUeWNcvlygLJGTT5egOQihZpf7NASDT2fLa5cxPJNWkM0u2tNFF4LY?=
 =?us-ascii?Q?SQXJzzDWHzrzIlmrI+c8TU48EMyC4nNg3nyngAFeF1b/myMkgTtHF0ihBOSJ?=
 =?us-ascii?Q?XRwyZkcR/HOhljqYV3DmT+6rdBMxq6lZ9XBbk+svSBn0eQgiCVkRO9vsaFWJ?=
 =?us-ascii?Q?WMJBE1w9rfce7XwPaGHZYEVB07eMd1UU9fL7fto7Ki3uYNANwt3LyOB1kBfc?=
 =?us-ascii?Q?JpgBzo7pgaXeUsnTObMPnIkCuCcSw2CAStKBYzgSosweQIAhEVIQpLpkzzUU?=
 =?us-ascii?Q?tALLi/yAW/0gCZrwyrXG68SIu9jJFVQkBk0EUTaurC5kO4GO+XoEhz+geDoC?=
 =?us-ascii?Q?AObdLnhPcZWePFU3FpwP4ceE9rVapJCVEt3Nb5PJFr0Zut1Qnmx+H2MjOrC1?=
 =?us-ascii?Q?KpnpJT0q28bGMPftynanWp87yVwJ8JlUzj+pI0ZzWd816cquiAnM54PUuqmJ?=
 =?us-ascii?Q?SNGbWLGoV1W9C7vJfgXVU1fe+Jpy+dV+UQLrZI4SJwv5GkiS0iPGynvDQXDU?=
 =?us-ascii?Q?BvRqGHFrIVEeFwjMyZJwxXw8SK/JD19QOKqf+nMtMDQ3NLEnLoFa4JrFwKZz?=
 =?us-ascii?Q?MLePNgk5DqoQPMbLrjeciyDRKfWxU4CR/GxuCCON3lyqFELBmNvUunEre1Zs?=
 =?us-ascii?Q?ZMfH69SUgh+fj7gzzS0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458D01906C92485711FD0DD81B72DS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef79082f-ccf5-449e-4801-08dd78418463
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 15:08:14.5502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dqWAnuxhn6wKMoLowt7cuoFzxUemyFyy37QpR+Sc69wMqPuveTQRCshC70+PSf3yf+TVjltYH9VXdT62r++rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7900
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

--_000_DS0PR11MB7458D01906C92485711FD0DD81B72DS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: 08 April 2025 12:08
To: Akhil Goyal <gakhil@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Ji, Kai <kai.ji@intel.com>; Nicolau, Radu =
<radu.nicolau@intel.com>
Subject: [PATCH] cryptodev: add SNOW-V algorithms

Add SNOW-V and SNOW-V AEAD mode algorithms to cryptodev API.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 lib/cryptodev/rte_crypto_sym.h | 17 ++++++++++++-----
 lib/cryptodev/rte_cryptodev.c  |  4 +++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/cryptodev/rte_crypto_sym.h b/lib/cryptodev/rte_crypto_sym.=
h
index 6268bab327..d6033ac4a1 100644
--- a/lib/cryptodev/rte_crypto_sym.h
+++ b/lib/cryptodev/rte_crypto_sym.h
@@ -178,8 +178,11 @@ enum rte_crypto_cipher_algorithm {
         /**< ShangMi 4 (SM4) algorithm in OFB mode */
         RTE_CRYPTO_CIPHER_SM4_CFB,
         /**< ShangMi 4 (SM4) algorithm in CFB mode */
-       RTE_CRYPTO_CIPHER_SM4_XTS
+       RTE_CRYPTO_CIPHER_SM4_XTS,
         /**< ShangMi 4 (SM4) algorithm in XTS mode */
+
+       RTE_CRYPTO_CIPHER_SNOW_V,
+       /**< SNOW V algorithm */
 };

 /** Symmetric Cipher Direction */
@@ -486,6 +489,8 @@ enum rte_crypto_aead_algorithm {
         /**< Chacha20 cipher with poly1305 authenticator */
         RTE_CRYPTO_AEAD_SM4_GCM,
         /**< SM4 cipher in GCM mode */
+       RTE_CRYPTO_AEAD_SNOW_V,
+       /**< SNOW V algorithm in GCM mode */
 };

 /** Symmetric AEAD Operations */
@@ -714,8 +719,9 @@ struct rte_crypto_sym_op {
                                           *
                                           * @note
                                           * For SNOW 3G @ RTE_CRYPTO_CIPHE=
R_SNOW3G_UEA2,
-                                         * KASUMI @ RTE_CRYPTO_CIPHER_KASU=
MI_F8
-                                         * and ZUC @ RTE_CRYPTO_CIPHER_ZUC=
_EEA3,
+                                         * KASUMI @ RTE_CRYPTO_CIPHER_KASU=
MI_F8,
+                                         * ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA=
3 and
+                                         * SNOW V @ RTE_CRYPTO_CIPHER_SNOW=
_V
                                           * this field should be in bits. =
For
                                           * digest-encrypted cases this mu=
st be
                                           * an 8-bit multiple.
@@ -732,8 +738,9 @@ struct rte_crypto_sym_op {
                                           *
                                           * @note
                                           * For SNOW 3G @ RTE_CRYPTO_AUTH_=
SNOW3G_UEA2,
-                                         * KASUMI @ RTE_CRYPTO_CIPHER_KASU=
MI_F8
-                                         * and ZUC @ RTE_CRYPTO_CIPHER_ZUC=
_EEA3,
+                                         * KASUMI @ RTE_CRYPTO_CIPHER_KASU=
MI_F8,
+                                         * ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA=
3 and
+                                         * SNOW V @ RTE_CRYPTO_CIPHER_SNOW=
_V
                                           * this field should be in bits. =
For
                                           * digest-encrypted cases this mu=
st be
                                           * an 8-bit multiple.
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index bb7bab4dd5..ae44c5f385 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -102,7 +102,8 @@ crypto_cipher_algorithm_strings[] =3D {
         [RTE_CRYPTO_CIPHER_SM4_CTR]     =3D "sm4-ctr",
         [RTE_CRYPTO_CIPHER_SM4_CFB]     =3D "sm4-cfb",
         [RTE_CRYPTO_CIPHER_SM4_OFB]     =3D "sm4-ofb",
-       [RTE_CRYPTO_CIPHER_SM4_XTS]     =3D "sm4-xts"
+       [RTE_CRYPTO_CIPHER_SM4_XTS]     =3D "sm4-xts",
+       [RTE_CRYPTO_CIPHER_SNOW_V]      =3D "snow-v",
 };

 /**
@@ -175,6 +176,7 @@ crypto_aead_algorithm_strings[] =3D {
         [RTE_CRYPTO_AEAD_AES_GCM]       =3D "aes-gcm",
         [RTE_CRYPTO_AEAD_CHACHA20_POLY1305] =3D "chacha20-poly1305",
         [RTE_CRYPTO_AEAD_SM4_GCM]   =3D "sm4-gcm",
+       [RTE_CRYPTO_AEAD_SNOW_V]   =3D "snow-v-aead",
 };


--
2.43.0


--_000_DS0PR11MB7458D01906C92485711FD0DD81B72DS0PR11MB7458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicolau, Radu &lt;rad=
u.nicolau@intel.com&gt;<br>
<b>Sent:</b> 08 April 2025 12:08<br>
<b>To:</b> Akhil Goyal &lt;gakhil@marvell.com&gt;; Fan Zhang &lt;fanzhang.o=
ss@gmail.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Ji, Kai &lt;kai.ji@intel.com&=
gt;; Nicolau, Radu &lt;radu.nicolau@intel.com&gt;<br>
<b>Subject:</b> [PATCH] cryptodev: add SNOW-V algorithms</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add SNOW-V and SNOW-V AEAD mode algorithms to cryp=
todev API.<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;lib/cryptodev/rte_crypto_sym.h | 17 ++++++++++++-----<br>
&nbsp;lib/cryptodev/rte_cryptodev.c&nbsp; |&nbsp; 4 +++-<br>
&nbsp;2 files changed, 15 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/lib/cryptodev/rte_crypto_sym.h b/lib/cryptodev/rte_crypto_sym.=
h<br>
index 6268bab327..d6033ac4a1 100644<br>
--- a/lib/cryptodev/rte_crypto_sym.h<br>
+++ b/lib/cryptodev/rte_crypto_sym.h<br>
@@ -178,8 +178,11 @@ enum rte_crypto_cipher_algorithm {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; ShangMi 4 (SM4) al=
gorithm in OFB mode */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_CIPHER_SM4_CFB,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; ShangMi 4 (SM4) al=
gorithm in CFB mode */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_CIPHER_SM4_XTS<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_CIPHER_SM4_XTS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; ShangMi 4 (SM4) al=
gorithm in XTS mode */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_CIPHER_SNOW_V,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; SNOW V algorithm */<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/** Symmetric Cipher Direction */<br>
@@ -486,6 +489,8 @@ enum rte_crypto_aead_algorithm {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Chacha20 cipher wi=
th poly1305 authenticator */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_AEAD_SM4_GCM,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; SM4 cipher in GCM =
mode */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_AEAD_SNOW_V,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; SNOW V algorithm in GCM mode =
*/<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/** Symmetric AEAD Operations */<br>
@@ -714,8 +719,9 @@ struct rte_crypto_sym_op {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * @note<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * For SNOW 3G @ RTE_CRYPTO_CIPHER_SNOW3G_UEA2,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * and ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3 and<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * SNOW V @ RTE_CRYPTO_CIPHER_SNOW_V<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * this field should be in bits. For<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * digest-encrypted cases this must be<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * an 8-bit multiple.<br>
@@ -732,8 +738,9 @@ struct rte_crypto_sym_op {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * @note<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * For SNOW 3G @ RTE_CRYPTO_AUTH_SNOW3G_UEA2,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * and ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3 and<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * SNOW V @ RTE_CRYPTO_CIPHER_SNOW_V<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * this field should be in bits. For<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * digest-encrypted cases this must be<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * an 8-bit multiple.<br>
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c<=
br>
index bb7bab4dd5..ae44c5f385 100644<br>
--- a/lib/cryptodev/rte_cryptodev.c<br>
+++ b/lib/cryptodev/rte_cryptodev.c<br>
@@ -102,7 +102,8 @@ crypto_cipher_algorithm_strings[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [RTE_CRYPTO_CIPHER_SM4_CTR=
]&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;sm4-ctr&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [RTE_CRYPTO_CIPHER_SM4_CFB=
]&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;sm4-cfb&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [RTE_CRYPTO_CIPHER_SM4_OFB=
]&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;sm4-ofb&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [RTE_CRYPTO_CIPHER_SM4_XTS]&nbsp;&nbs=
p;&nbsp;&nbsp; =3D &quot;sm4-xts&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [RTE_CRYPTO_CIPHER_SM4_XTS]&nbsp;&nbs=
p;&nbsp;&nbsp; =3D &quot;sm4-xts&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [RTE_CRYPTO_CIPHER_SNOW_V]&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =3D &quot;snow-v&quot;,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -175,6 +176,7 @@ crypto_aead_algorithm_strings[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [RTE_CRYPTO_AEAD_AES_GCM]&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;aes-gcm&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [RTE_CRYPTO_AEAD_CHACHA20_=
POLY1305] =3D &quot;chacha20-poly1305&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [RTE_CRYPTO_AEAD_SM4_GCM]&=
nbsp;&nbsp; =3D &quot;sm4-gcm&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [RTE_CRYPTO_AEAD_SNOW_V]&nbsp;&nbsp; =
=3D &quot;snow-v-aead&quot;,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB7458D01906C92485711FD0DD81B72DS0PR11MB7458namp_--
