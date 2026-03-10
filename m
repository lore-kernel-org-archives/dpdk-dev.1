Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E12FD4F03
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 17:05:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7CDA40672;
	Tue, 10 Mar 2026 18:05:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 6F09340662
 for <dev@dpdk.org>; Tue, 10 Mar 2026 18:04:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773162299; x=1804698299;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=DghNu4eyDzRm+KCyQ6AT3/USRyoCUIngIkkgrFm50Uo=;
 b=fm89wn1vXEEximhYPn9CuMfYgCWQYDNcPpuN0Gly7GlpDLDNJgDQ3ynI
 0l3TrksmCtIj4neBE0y+I4NFyznkYCOmzJvYSY2RtJETgF0awbs61CnYU
 aUCHt81Db4BXL/z6fxCzljkQsd1v8jMR37fDD633drUh3WY5BuEysclQ6
 4fgUeIpY/wV6etuaDEfDXZ5VaLppbuOMrr/ihUpMzxRTA1auT/UpUaeb8
 2mO76Bv6zF9olZwbb91xUXFmSSv0JbbQagYOjF5VDHRvpBEWfTg5Ubf3+
 iKqjqjEPyjpjJ16SpGKCgFtsvotkU7Lqjf1Ld2UjU/eWKAOW3O7VGXK6F A==;
X-CSE-ConnectionGUID: WPx9j6K9RyW2TcrPEjQu0g==
X-CSE-MsgGUID: Iv6FnxXrSfGFnqzU/3DBmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78074296"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208,217";a="78074296"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 10:04:58 -0700
X-CSE-ConnectionGUID: 305xKVpCTTmpC6VI76kLmQ==
X-CSE-MsgGUID: FZ4S7cxySwmaa4Not5bqpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
 d="scan'208,217";a="220231444"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 10:04:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 10:04:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 10:04:55 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 10:04:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9+63HvdlD2gDormpq+llq9ouJtDk2mWIfGixTPfYJyISZWaht5qD6XGLUt7TWGgqNsuyb0G6ba10CrdhrLn2CfNFJ1psryX7b96M8Fipn2hNR5laQbuDSN/2hO8dBFpJhTQrtufSN0otvJUyIC2BiHqFg+vTi4NxdCc4i72REOEZ84vwxS0rSHOFceGoOIIrbTGe8PG18a6crRYeL1HgDTv/O8Qw2ZkMvnoWiDGwqfvOQriW2OVmMBZLDhl3UnJbgOpv1AGwqQivOkvZgRG5vr+lFchIB2TJrgbb1MzY8MPg04RImbBQTMwM+nu4rbYlITVGMom3KD1Vk63kYhEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrUESXqTi91cjZjeEd1v99fPw9FxcCnem8P3aEmqyMk=;
 b=W6mbejuEppPP4bG7SKP7e/uhsMogVev3DpGmfoShRHT+0VafLHCWu7aM0gW1CZAKJ9Fw3YK1fUNFPs3d57s0vvoGh3kduHbfwOuqT520+9N+M0zGnHZYLcmO69gDFdc42hzzgdYvABNdmyPq1wZ00s1fRtsW4eNIR5PuISAT4skN8UboCZQIM3AoQkYU8hxo6/zz6Pi2E5MKAE4XAksCE23Y6r3Y52Mv3eMnDt73O+7vYbCRgLL2JWyJ/YlRmzGbNCkRuWFAS2eCJxjn0JezZPtBP5LbqB9r8/rrTSy7wl9rt9MT68Pgac0Z94NpRET/mHm4abQZZkYIpwZBmgf/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by SN7PR11MB6677.namprd11.prod.outlook.com (2603:10b6:806:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 17:04:51 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 17:04:51 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH] test/memcpy: reduce alignment offset coverage to fix
 timeout
Thread-Topic: [PATCH] test/memcpy: reduce alignment offset coverage to fix
 timeout
Thread-Index: AQHcpz/c1ptHPSmY20KlAXk0rOx9trWoDz+r
Date: Tue, 10 Mar 2026 17:04:51 +0000
Message-ID: <DS0PR11MB74580F7BC395E2044587F9628146A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20260226164843.183959-1-stephen@networkplumber.org>
In-Reply-To: <20260226164843.183959-1-stephen@networkplumber.org>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|SN7PR11MB6677:EE_
x-ms-office365-filtering-correlation-id: afe861aa-04e3-483a-9481-08de7ec724a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|42112799006|1800799024|366016|8096899003|13003099007|38070700021|7053199007|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: +/Tsp1Iz6w17WDfox23TFRYy+qdMZvlU2w6KixpctCBUU8XV4uwvsRBKSb/jF3M4ctdmjMhRNt1F0wRQYqH2yetldGeeMi7nkIpg7e/hRFh2VVKDV/LSp0w6k+J3xg6wNUdc6dkZasuoS5Zq7ZQBqcPmoRwXS2IDtmAObyf1j89Ii3LgOmIOua+l44L/aeyyyagWLdKlZZKW5SzRHkZS95Z7nFFNbZxoH5cLbfvvW1eJY3b+mvARFM3fcdhAYHBsWmHw5CKsfeUSCCokd9W2pNFwktk+KPtT6VIwhdEtfSUOuKXr7z6vk3P4LZ7Gyr4twQMxkeG5dX63fBwk9r+6iQt3evUNqOf6yqDnvvu1p6FPtbTSliFXVhp7R6r2NYFXJCPfAGV88Kkvvw+pvUTtc9UicuT7SAq5S0RuHBywPGM0uoTwZKO/QZ/XBby2pzA2GklyuItqZCbUm9n3BoNrIaOFexoZYqqq/VDH7+2xKUjgyrrFAXFKl6W+WXQod+bxqFYyMJg4U4dbjGHR8eI1rH7MfTQGyGcvzmV+3xE1sc0uto5vxwcwLgX1YR4IVHobfddCLprYcJjt+R8HCLuhMiidOmvrXOSRVRC3pt6X6kvAavyOoo1rNgM3AyFnXLHAlJBuK0+1xmhCbOkazdIyU4aeze5o4WJaCGJ2sYqkjBu8f9SNNGOdzoRG4S40g1RKFnAKSDvK2pAjnNl5UtdMycr9s7R5xtymvzHXYfLfITz9q6oyZpdk72ztI3gM/3jY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(42112799006)(1800799024)(366016)(8096899003)(13003099007)(38070700021)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ijlmgrxTL/E5br7uQXgeq6a7x0DKfO5kPPKFWIsSd0K+RnJVm6/mq4B0gr?=
 =?iso-8859-1?Q?fZBniTTK/YuPhCknjYRr+nZa2u6kD7StAK4P+T9sslHcHMj0mq7X2FlyrY?=
 =?iso-8859-1?Q?zHznwBo3FF3g/Lw8+M+MX/WHCtZW5h7SZoDUFOde+C/+sPY1Hyt1Ijo1Nz?=
 =?iso-8859-1?Q?3nisDMgyihcHV7xaBlK2zcmHTmVqxpqfeyRVvy8O7BIjB0H9Z5/gWyraXF?=
 =?iso-8859-1?Q?0DUFJHh8ZOX9buSFMujaA0/6xPqvtyjDR9nP1MKXVJ2LE3AFKZeU+FjExi?=
 =?iso-8859-1?Q?zK9YpgRG21bjLQ1/PGDKorKjIMQIHF4zYhaVVLpdC2cyJBI1pbMRYwJNON?=
 =?iso-8859-1?Q?P+ZGmV6ccufxcXRFnWdPha6+AYUWq6Vi32QBQa2iE5SMj/ov3SwZsBL7W/?=
 =?iso-8859-1?Q?CIJEO8OPqfV5Y8D2mTprMLPEBbHL0l3Nt5e0f4UMyiKPnLzLZvzggGkzUm?=
 =?iso-8859-1?Q?PZ4lL++Ie1ctzqwBhJIx10dJ9LF2u3MpMb4/KsNSMSdpEHCau0ujLBaref?=
 =?iso-8859-1?Q?juNmqw8Z5anl19Z+tLcx+H+0HNqhyX12EUpvx0YzJi+rBO+IXlkRF+RZux?=
 =?iso-8859-1?Q?ItdoLyAGKaTYunkpRaEECmesl+PoWOWzum20dSkf4byqpgDeYmkeGIfJfm?=
 =?iso-8859-1?Q?01zt51Qjn6Qt1jjiotJ1FKLgr+kXordcAwSdKBXyfPe5gt44ADavsgGddA?=
 =?iso-8859-1?Q?apPCk+PaNTPL19Qd+RicvwOF9RNR7ktrFz3gRG+t/Y3XXrZVgppiUz7N79?=
 =?iso-8859-1?Q?hNEigaXcYgbjCoGieBTTTqS+QMKNC9srOmJPlqbDeJcqus/LDPDHcSXmTz?=
 =?iso-8859-1?Q?6iP4bMstOn2IFoEaW/J8hVp8jdi8qk3YQZpMtl94f2pYHSaW1cj5Axjrjk?=
 =?iso-8859-1?Q?cdfJ9JdNFc1QNtgIJRRYMVyUvqd0RVM4YHDgdPCVYuruI8uy2P10w4I8jR?=
 =?iso-8859-1?Q?biPOunVX9igockOfnPqGt9/TYKgM6nr2sfWdK2hqn/z9u4ZcrswmpPKoXW?=
 =?iso-8859-1?Q?/ObjnNi6chhrtsckv3O8zZnRHvua+tWe8tW4R38VTB3YRmg8JHJ9XwIUjJ?=
 =?iso-8859-1?Q?Y3JrDtC/NLdfDZIckdxzh6oafHBbddLukI3LYYyeHn+CDma9U7mAPVlf5R?=
 =?iso-8859-1?Q?RqifJGgmZVWBQIgUTVCXFhJ7Gds2HFEGnqDFWQW2OAdC63WG1YNiCLoR72?=
 =?iso-8859-1?Q?C8Jhja3TQs3rV8c9DPiRVjfi6jw9Z9nqAhSA1cxLZoEssoNKe4+DfWjhm9?=
 =?iso-8859-1?Q?jiHSAQNA5zeArfTFhmGJrl7sYXaIjT3KgwNTYqa9C6Za0ktCS9SnW7DRG5?=
 =?iso-8859-1?Q?2HST3zBqJNuTCYkw5bd/C9IRZPTOGGwGFTY2cFEyjItJzNs17fKb5iElAJ?=
 =?iso-8859-1?Q?Aol7eIhhnG3Dif2AwXh/FqqHNvh9+LC/9sDHF1cCtgTp14JbzBDaNyZ77p?=
 =?iso-8859-1?Q?uCFSbtv5P5VVgTEnKySk16QqoTvRh3S2Hcyqr3ylSlTNdUPfFW/SgtFUEP?=
 =?iso-8859-1?Q?jzBQVnhTUQ0O3AVU1Z0B81G/vAhYF3c9tlGYi/puEkyfT0QG+XsJg0C/tP?=
 =?iso-8859-1?Q?S6G0OoSJgK8XuTuYYBpIIZgpB81QFPOzt3j9bxn4VfqXIgD0MEFl+Etisf?=
 =?iso-8859-1?Q?wxzf/Toh8QOLJiZoUnCJQLbozRz0AnrW4wtRpVazaqIwBnY5khmkropOCN?=
 =?iso-8859-1?Q?HrELlb7jrJ0OZ0QZ0Y6qhsHR04SOYGkUWeHkwOgZf8VBBUTOFvzgC1u/Dj?=
 =?iso-8859-1?Q?5vRKggAU1b8c0/s42yyYRuNudBhLEhhpA/7tzyfgB8PfHx?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB74580F7BC395E2044587F9628146ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: USRlswFBNebiiFqaxTRlJEtv4D3hEkC0trNuE95UAa3ioG8Pnjf20cKyKXALlkb0UP07BNKjjLSuT1JMR0j5EoCD6IDIAn2Qr0fczYgoM9wIlmUnMV+M5WRhPaKYWCL/0k2fsuWqSBAdvt45nC+JYvk4gJegm0b/dVX8yMBZAkyR58k/cwC8DWzz/KYjxY+2a5030HVo+YrR38fRPv0xHP2imskzJeT6ZsU+3jm+ro18CxyxkgtemfK+7RWZ0EHBiVRg0pJjpsQ9B/+HsM72luoKE4LW/S6kRi2z+6I6AKMQrw8y0ohCeo+BJrCjReYbBP67yLhNN7nG+NtV+Az7/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe861aa-04e3-483a-9481-08de7ec724a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 17:04:51.0285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ox1pRJ/H/VCPaU+LOZyGOgxv+TqakRPZwZoPzA+Q+kzVOlOSirXV9du9kbc7HrcTk3vy2ANfDqcRwznlU37Dxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6677
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

--_000_DS0PR11MB74580F7BC395E2044587F9628146ADS0PR11MB7458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

LGTM,

I'm not AVX-512 expert, but I think AVX-512 might expect  64-bytes alignmen=
t,.
As the original  ALIGNMENT_UNIT is 32, so I think the selection of offsets =
is no problem.
Maybe remove AVX-512 from the comments ?

Regards

Kai



________________________________
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Thursday, February 26, 2026 16:48
To: dev@dpdk.org <dev@dpdk.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>; Luca Boccassi <bluca@de=
bian.org>
Subject: [PATCH] test/memcpy: reduce alignment offset coverage to fix timeo=
ut

The memcpy test sweeps all 32x32 src/dst alignment offset pairs which
causes it to timeout on slow emulated 32-bit build environments [1].

Replace with a curated set of 7 offsets {0, 1, 7, 15, 16, 17, 31}
that cover the interesting alignment boundaries. This reduces the
iterations from 38912 to 1862 while covering the same code paths.

[1] https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/=
Debian_Testing/i586

Reported-by: Luca Boccassi <bluca@debian.org>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_memcpy.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/app/test/test_memcpy.c b/app/test/test_memcpy.c
index 7273c17a06..12e491034f 100644
--- a/app/test/test_memcpy.c
+++ b/app/test/test_memcpy.c
@@ -36,6 +36,16 @@ static size_t buf_sizes[TEST_VALUE_RANGE];
 /* Data is aligned on this many bytes (power of 2) */
 #define ALIGNMENT_UNIT          32

+/*
+ * Subset of offsets to test. These values cover the structurally
+ * interesting alignment cases for SSE/AVX/AVX512 copy paths:
+ * aligned (0), off-by-one (1), partial vector (7, 15, 17),
+ * vector boundaries (16, 31). Testing all 1024 src x dst
+ * combinations of offsets 0..31 is unnecessary since many
+ * map to the same code paths, and causes the test to timeout
+ * on slow (e.g. emulated 32-bit) build environments.
+ */
+static const unsigned int test_offsets[] =3D {0, 1, 7, 15, 16, 17, 31};

 /*
  * Create two buffers, and initialise one with random values. These are co=
pied
@@ -103,13 +113,15 @@ static int
 func_test(void)
 {
         unsigned int off_src, off_dst, i;
+       unsigned int n_offsets =3D RTE_DIM(test_offsets);
         int ret;

-       for (off_src =3D 0; off_src < ALIGNMENT_UNIT; off_src++) {
-               for (off_dst =3D 0; off_dst < ALIGNMENT_UNIT; off_dst++) {
+       for (off_src =3D 0; off_src < n_offsets; off_src++) {
+               for (off_dst =3D 0; off_dst < n_offsets; off_dst++) {
                         for (i =3D 0; i < RTE_DIM(buf_sizes); i++) {
-                               ret =3D test_single_memcpy(off_src, off_dst=
,
-                                                        buf_sizes[i]);
+                               ret =3D test_single_memcpy(test_offsets[off=
_src],
+                                                        test_offsets[off_d=
st],
+                                                        buf_sizes[i]);
                                 if (ret !=3D 0)
                                         return -1;
                         }
--
2.51.0


--_000_DS0PR11MB74580F7BC395E2044587F9628146ADS0PR11MB7458namp_
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
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
LGTM,</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
I'm not AVX-512 expert, but I think AVX-512 might expect&nbsp; 64-bytes ali=
gnment,.</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
As the original&nbsp; ALIGNMENT_UNIT is 32, so I think the selection of off=
sets is no problem.&nbsp;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Maybe remove AVX-512 from the comments ?&nbsp;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Regards</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Kai&nbsp;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
<b>Sent:</b>&nbsp;Thursday, February 26, 2026 16:48<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b>&nbsp;Stephen Hemminger &lt;stephen@networkplumber.org&gt;; Luca =
Boccassi &lt;bluca@debian.org&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] test/memcpy: reduce alignment offset coverage =
to fix timeout
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">The memcpy test sweeps all 32x32 src/dst al=
ignment offset pairs which<br>
causes it to timeout on slow emulated 32-bit build environments [1].<br>
<br>
Replace with a curated set of 7 offsets {0, 1, 7, 15, 16, 17, 31}<br>
that cover the interesting alignment boundaries. This reduces the<br>
iterations from 38912 to 1862 while covering the same code paths.<br>
<br>
[1] <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWAda924304-=
6866-50fb-d3fd-14b10fce3146" href=3D"https://build.opensuse.org/package/liv=
e_build_log/home:bluca:dpdk/dpdk/Debian_Testing/i586">
https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/Debi=
an_Testing/i586</a><br>
<br>
Reported-by: Luca Boccassi &lt;bluca@debian.org&gt;<br>
Signed-off-by: Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
---<br>
&nbsp;app/test/test_memcpy.c | 20 ++++++++++++++++----<br>
&nbsp;1 file changed, 16 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/app/test/test_memcpy.c b/app/test/test_memcpy.c<br>
index 7273c17a06..12e491034f 100644<br>
--- a/app/test/test_memcpy.c<br>
+++ b/app/test/test_memcpy.c<br>
@@ -36,6 +36,16 @@ static size_t buf_sizes[TEST_VALUE_RANGE];<br>
&nbsp;/* Data is aligned on this many bytes (power of 2) */<br>
&nbsp;#define ALIGNMENT_UNIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 32<br>
&nbsp;<br>
+/*<br>
+ * Subset of offsets to test. These values cover the structurally<br>
+ * interesting alignment cases for SSE/AVX/AVX512 copy paths:<br>
+ * aligned (0), off-by-one (1), partial vector (7, 15, 17),<br>
+ * vector boundaries (16, 31). Testing all 1024 src x dst<br>
+ * combinations of offsets 0..31 is unnecessary since many<br>
+ * map to the same code paths, and causes the test to timeout<br>
+ * on slow (e.g. emulated 32-bit) build environments.<br>
+ */<br>
+static const unsigned int test_offsets[] =3D {0, 1, 7, 15, 16, 17, 31};<br=
>
&nbsp;<br>
&nbsp;/*<br>
&nbsp; * Create two buffers, and initialise one with random values. These a=
re copied<br>
@@ -103,13 +113,15 @@ static int<br>
&nbsp;func_test(void)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int off_src, off_=
dst, i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int n_offsets =3D RTE_DIM(te=
st_offsets);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (off_src =3D 0; off_src &lt; ALIG=
NMENT_UNIT; off_src++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (off_dst =3D 0; off_dst &lt; ALIGNMENT_UNIT; off_dst++) {<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (off_src =3D 0; off_src &lt; n_of=
fsets; off_src++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (off_dst =3D 0; off_dst &lt; n_offsets; off_dst++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (=
i =3D 0; i &lt; RTE_DIM(buf_sizes); i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D test_single_memcpy(off_src, off_dst=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_sizes[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D test_single_memcpy(test_offsets[off=
_src],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_offsets[off_dst],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_sizes[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret !=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
--<br>
2.51.0<br>
<br>
</div>
</body>
</html>

--_000_DS0PR11MB74580F7BC395E2044587F9628146ADS0PR11MB7458namp_--
