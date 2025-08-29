Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A90CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 13:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66AB240263;
	Fri, 29 Aug 2025 15:14:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 46A044025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 15:14:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756473263; x=1788009263;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BmslHECsTZvDvu9jcFnkrdMfcKq5IJLira2tGwpdwy0=;
 b=l5NxI4Xs1ZzVMZMZX/er+BxUjOOUzkHvHZpbU9ay/nM1n70hOoIZX1pV
 c7x64eyuu3+R0LvrPddt26S5ysOF0jDQ5mQf4OpPHx3SmyWe+Ld27/TQj
 lkVYUPTZWmt4eGMQpEX6rWz4Pca5zBMa+to8RKEkf6et9gRqoHusVWpxY
 XiSs+hXP3TrcrMqLC+3zBs2e+6G1oFEs8ukAfS+YjC8v5hIAXOLz2cWec
 AZS1LFHKepbtILVTspoDrw+RT157kG3ayGsRILW1kr0R6420+5DAUksgt
 bMF7ikoZkcnb1fhYg+zj4wo1xR+OdBNxNfjvU3HTiKvSQkIdh761fZMVK A==;
X-CSE-ConnectionGUID: LqU7HHvrT9yYfaTA5POu9g==
X-CSE-MsgGUID: r3R+EgpHRTaBF0rMdqgVrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58859167"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="58859167"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 06:14:22 -0700
X-CSE-ConnectionGUID: M0GOSbNVRbqbWgPMXpTv+A==
X-CSE-MsgGUID: uThpYXMFSkq/2END2gfEBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="174750573"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 06:14:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 06:14:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 06:14:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.85)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 06:14:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2Jt5jBeHVB33BKGVGI0dB1whYRD3Bv865eG0ZIhucRvTOEm76S4E/fAVrQDfY8xYHFgM3T6Wyzb5HWCNuhLS97UwvOwO4gBriBU5/thOBDzlc5wMbMnIdOvBYyVTRFuUZPcOuGwg4u48sPf/tq9ViLC2MDr4kvO8T3m3pQHwfu/bal+udsTYEpJu12zGzcUN/zLxMpTZIVHdSY9+2IOQVFuf+CdF8EffkRG15rRS0yvbw7TGJMGulGLTw20is/LFHq4yJx57ogwy0hpGK1mbdZTiZtxwbuCcSGg5apCZIeFoIdjCHFaPa+cJe+D/zN9/ApNfRNP7d2n3dARt2arVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmslHECsTZvDvu9jcFnkrdMfcKq5IJLira2tGwpdwy0=;
 b=DIApl4BVDkfOHIUO9mGlZMFCtAaVe+5PkgQgFUjmL4kjdgDuE+CwZgs0qWecsf/nElCMb5S851TlcsnykmjVewCvfCJGYXkEol/xQY9aL51Uw+A0voGfNYSSb1ZoELlbBI1q9QS62BpJgiH2W7Ms3L3VP8aK83eoIw9jqwXtkr+eW/AOSLNgcuv1jgw4Eq/OVhtgn++adRYcyPVyaQVy3L0caoYS7oH6Ysgp/jsytvlRK6Aa7MnNzjsDpsoB9Quko/zrtLQ+N2xdzyrU23n4XIkogSMlpKdnuFMp9S4CWgqtt2Lm1ggpKfXuhdx6w5fln1fu9DfRgq0ggSit0EN8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7845.namprd11.prod.outlook.com (2603:10b6:930:72::18)
 by SA3PR11MB8001.namprd11.prod.outlook.com (2603:10b6:806:2f5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.18; Fri, 29 Aug
 2025 13:14:09 +0000
Received: from CY8PR11MB7845.namprd11.prod.outlook.com
 ([fe80::bf13:a047:3bb3:3cb7]) by CY8PR11MB7845.namprd11.prod.outlook.com
 ([fe80::bf13:a047:3bb3:3cb7%3]) with mapi id 15.20.9052.023; Fri, 29 Aug 2025
 13:14:09 +0000
From: "Finn, Emma" <emma.finn@intel.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling pointer
 for SHA test
Thread-Topic: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling
 pointer for SHA test
Thread-Index: AQHcF/4lYAFyVfvK0EK1wLnj+HAwKLR30B4AgAGYqhCAAAUkAIAAAKSwgAAe+wCAAA/FAA==
Date: Fri, 29 Aug 2025 13:14:09 +0000
Message-ID: <CY8PR11MB7845999CCF5464976CFF3DF8EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
 <CO1PR18MB471416C114E8D59E97EEBE2FCB3BA@CO1PR18MB4714.namprd18.prod.outlook.com>
 <CY8PR11MB784530D82EB6D7A7D4EF1F99EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
 <CO1PR18MB4714A60A5FEED89BA023628CCB3AA@CO1PR18MB4714.namprd18.prod.outlook.com>
 <CY8PR11MB78457F3C1B8380E1903391D8EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
 <BY3PR18MB4705890AC3B3EC7AD3E89F3CCB3AA@BY3PR18MB4705.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB4705890AC3B3EC7AD3E89F3CCB3AA@BY3PR18MB4705.namprd18.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7845:EE_|SA3PR11MB8001:EE_
x-ms-office365-filtering-correlation-id: ec2f9c74-df73-4fcd-523e-08dde6fdf07e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GlLsUncctRy6S8fjNAw4rq/e4r78vJd/d+oxj9kh4D3UZRNrV/I0vFM7ARho?=
 =?us-ascii?Q?EoFUsS4nVTm2xCAGZbxdZ1NWX/xO+FyyRABEJERdmb6LYlnQV4yM1ajTSEUV?=
 =?us-ascii?Q?OQ2msO7Hbbe7QjlNNmo6zEl7x190Sb/9u3zVuZHEkRmCMsV5/t6m3Nt/roQp?=
 =?us-ascii?Q?D8HlwZ0TRuDg+NsOHTVB6/gRNKxzz0/ISV5OlvCBychD0ZzMVFABPqJp+O2d?=
 =?us-ascii?Q?KItD7SZabaYtOR3Ns+Hs0DOI7urEn3d6pMLqGiCI4R6bxIBrmdR/hVNeSoTr?=
 =?us-ascii?Q?j8B7AkKUWdokzFLaevKVPMreLWjtUnx46US531axM8SXlaLhxnnItbvpWyXx?=
 =?us-ascii?Q?iwFOechCIlG6xZKRiYSHuYks2Lc762p6kuYNCLTbLHHvzSZPssSgcSVtATH1?=
 =?us-ascii?Q?Kh8LuekXUhqzDJPP/fKxEpUxPttSJiFOm6lWUOzSBibTsCuwUG5Ks521pPfL?=
 =?us-ascii?Q?irsipQeU+7jMZciOWBt+IWwZdNg65k4pXyjbK1PfRAjpo5I1hof9uL3W+WGM?=
 =?us-ascii?Q?jg4X3cIgWCanKZZqCgkY04kjxtBXsvOsS4YrIpSKWbBshR5NTUIqRxQZV5Vc?=
 =?us-ascii?Q?rQu9Zb4sdpBBRnDFt+CUQkmCeWAA3usggqAGE2hHG7OGSuiLwfSHqDTamCeO?=
 =?us-ascii?Q?ro0H1wWNUtzTZYlSsq+EL5lBxjJchzgHydjejq6SsnEe2SwfUj5epx62jGTR?=
 =?us-ascii?Q?Qun9Ex98ssymUtQiESB/9sPSOTuI/MukVqcxwD2gekC7hz6TuNL3/jv+jNLy?=
 =?us-ascii?Q?a0BOeWJdrxyG+nkwjN3YyZe3IE/o5qArvg/BjGfDBz6acd0JlhNnfICkEKrd?=
 =?us-ascii?Q?8j8jGRE/1voiPhCzRF9F8+romDk/zo2IugPb2XmSjUlkcdzLgEq3mMmkk5/6?=
 =?us-ascii?Q?ucSORdqc1qC1EEQ0r2fdJI/1WS81NQhdmmBKfsCiQ+Jl3K5ZH3v3HYH9pTjq?=
 =?us-ascii?Q?kPc6f+4BDtqP9ZfW0srk7r4HD0u2EC0FGhKX0NMii+K1PdB8+Lz4AAhnqTFY?=
 =?us-ascii?Q?PZxZUTSmYB2qAT8BhCcNCOdHP1giZf0vzjV1Tf5+ltNpsvWaoAPZWKZFAYDV?=
 =?us-ascii?Q?Xe0wTNc2F3wqo0eAMATDnVZvhS0gUJ9Sx0SB04b5QaPVLJjic5Y1VbC9wwoo?=
 =?us-ascii?Q?HXyyKuKuHPo8+j+B04sUDKGEkfhwr0nasde1G2iRnh83Cc9zSlLDTw+cxWRE?=
 =?us-ascii?Q?WpYsAdPNFSvvZUUiE2yxs551f94XcWzkl23P6/tYuJhPCtHQm7GYdUyT7VZc?=
 =?us-ascii?Q?g6FPXJjBBn8uL4eD/cGS2+5IN2ueiZ/kaYMQ6SQhl2L609HHopoqt0tRL0TC?=
 =?us-ascii?Q?1KzfBR9BKYfY70AEMv34k5CSLQC/psTqrbGovoy/+UIJcjeZO01SGckBsBwV?=
 =?us-ascii?Q?8aR3w+nadB54f+wVgjk4IVwtfdfTGa3Qz8dzvgXSzJm/zJ6Ci+s1Jz8bNAfj?=
 =?us-ascii?Q?4yBX+ZB1l7qYhB4ae3QGSq+pidAorqAAtsbyOzq+boOGE+20v9pd8DgTD/2R?=
 =?us-ascii?Q?Ygm8+RZy+4xvYvI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7845.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uhieKND6KdFHm7JC5LzbMCZtnbEmA33k+HH0DmfwC3EFNKaRf8qI0Zorh5cy?=
 =?us-ascii?Q?ACKTKs+tqrFx2sTQVWec5AogQpY7kAvO3QgUYiHerXmU4/Rdc/OVBY6lqtpt?=
 =?us-ascii?Q?1EPu8pUPjv7pN66Q1iz9RGBjgYKvxv39mEEm8yJfH/7xjkiMgou7eYKJCKgk?=
 =?us-ascii?Q?uZnytHUgd8L/NwzweApBH73CGPe++23xZTygtBtMeZ8aNTGsR5pTLOqm6W+I?=
 =?us-ascii?Q?X37GskGB5NQnttk+IShfySq85yQpNdSluzhZVcqkIh5pWMFkTWKj1c7jpHiv?=
 =?us-ascii?Q?qr/BLM3e16A+p4rBqMdJhA4j9TJctBObaVXlCtpw2dDffpCvPqyOWTrtV/Uk?=
 =?us-ascii?Q?D5XYovQOrMF2rmKYCFlvpnmIcNz8BLztRLhCTSg225XritwuUd4AxPJ1GgVR?=
 =?us-ascii?Q?l0nvcnMggndpy1JerFNecTgXAUypOHIvrW9o+kt2fpKCibRxVHkBX+nOeWSu?=
 =?us-ascii?Q?8Le3u+duNFZ8SmXCqfcsIpx3P6bAVFZjYT5ReikqixTD9uHuXejd7TmiUzVM?=
 =?us-ascii?Q?GJbo5Il8Z8n2h1VBqgzscFwH/xKHR9PrMWOqNiuRTXLLoyS1Tp6iOtLBbQSa?=
 =?us-ascii?Q?JQVPpyaGHo5SHr1TFu4qnE031m3t1u8GHk6kz48J68S/KxGu+22lpNqAyPQ7?=
 =?us-ascii?Q?v/8unVIsJpnN6kgL1fZ9Q2wNiBl2rbtiyyFrfWjp3B8hSJz70jRG6xBb3V6W?=
 =?us-ascii?Q?Kyo0Y4Yjy8UbuB0kqAFrKOlUtmg29mExyo0W4pbJkNtWDqVEuBCECvtqqvS/?=
 =?us-ascii?Q?fPv9oUcXO3elfZs0mHA/J6vcdaf7EsvC5Eq6K8CEzxVdG/rjqEFWqYtoJ9ku?=
 =?us-ascii?Q?dS+EpnVf0V53B5bAz3KOpP29QQAdjtkzL7tbG2niOy7k1TAi0l8c5E18cfXu?=
 =?us-ascii?Q?7d6ySVEC6vez9ESMSRJ42/3hQY1mGkcpj0Z5IrmP4RG62frU5F90vLTMiN1z?=
 =?us-ascii?Q?lFUjNvxdz/yfo6kvZGVPi2NH9LQP/cPPk04y5A8gtCDFQBTV+h5LVUa0v1js?=
 =?us-ascii?Q?csQRaZEN6lg27h9B3eFS6fOnkzUmmV26FfxfU9gQ7L7jvhfZEMErQzgCaogW?=
 =?us-ascii?Q?iQ2ymzjJURnS7F7jmdtdk5Zi24aWoV6j3M9PRCY7HyCzKGCUuz5UCnSbeIkY?=
 =?us-ascii?Q?ux9qDVA7Cg5zYFVDJGfU+Mg0nphjH01+G04bKw886Jt8QmQdJLMpWnijM5Gx?=
 =?us-ascii?Q?pgY0hlMF5MMmMQB6b4Yb6O+LSfo8UUP917+EYOU2mT8jd9v5XhK/z0x/6Ndy?=
 =?us-ascii?Q?P8YxR1K+12a+DuLRCgAdq68vZvzOErUYGLVvNTDHiZEnegKCS4bYqRpcTyYa?=
 =?us-ascii?Q?UsTPQo/0bc+wUKRH91L0JVaVluXbJJ8qzrd4D5YcAtbsWJnbEsfbNVb/ymtf?=
 =?us-ascii?Q?Qkm+DdfcwfPLWdQhVHUBBmOdujht71zmbCvM7+XVUGceQ3eQP6tw50hEvDCq?=
 =?us-ascii?Q?8T9pX7fdHKChfV+UtecrGkqwfJRt/17hl1y4k3PTULzi8KAY52G657QeBvn7?=
 =?us-ascii?Q?h9zBuJLg0/OKIMK/6zihuKS9UkdDU9cPo0pkiz2yQrTuViLdEgxOJf1SucrR?=
 =?us-ascii?Q?v6j9uO5r+NnVaAiTrwvQ5DllhS1FkTcn6ZVLo2z0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7845.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2f9c74-df73-4fcd-523e-08dde6fdf07e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 13:14:09.2019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OaV/8Xahozv+iySw9QgvY5evEuxcWa+++z2Y2lNxHpQ1duluAHpp9PtDjlWiqz+lFR6E8Vy4WzkH500b42oiag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8001
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
> From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Sent: Friday 29 August 2025 13:17
> To: Finn, Emma <emma.finn@intel.com>
> Cc: dev@dpdk.org; Ji, Kai <kai.ji@intel.com>
> Subject: RE: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling po=
inter
> for SHA test
> Importance: High
>=20
> > SHAKE is not supported by these hence I did not catch it.
>=20
> OpenSSL PMD supports SHA and SHAKE. Could that help verifying both lines =
of fix
> ?.
>=20
> Thanks,
> Gowrishankar.

OpenSSL PMD only supports SHAKE-256 for EdDSA operations, not as standalone=
 hash functions
