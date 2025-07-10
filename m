Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5CBC83F09
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 04:34:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B355F40657;
	Thu, 10 Jul 2025 06:34:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8E47C402D1
 for <dev@dpdk.org>; Thu, 10 Jul 2025 06:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752122096; x=1783658096;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vpN6/v6agAxwnHXxTEu81Mmqk6mYg8oORyHiHYHEndE=;
 b=BMuhv1QfxZE0hX4/hQMS5xfMDDtvvyjU5qi8sPsaf9ijwD7Wd9t56p/Q
 EIzxkv6/OvSVzdJAPXeOE3K2FP6ZhIo41Lj66YopJ4bKa0cVRanol3P5+
 usUMrbOpHN5aUvE0n4uPc3OZUrI4YAnVbM0rZGSbxqwFqAg8e8LQiLWUd
 +OrMsPVag50vb9wTvTJnWFKj3D+M4gRv0gnSSs2P/3p6H+gswlBNv9Vjw
 66RWoLphOg6RndTaVQODIbJ0S8iWQ9ItGixJesnet7kHDeQsbfd/fdu3c
 PoWEC8R2k+552u0a8JpvQ1SafmLgktQdvrIsWol8vi6WcuXmtxyorj29P Q==;
X-CSE-ConnectionGUID: P0P3qiFYTUiIbyfgVRohaQ==
X-CSE-MsgGUID: pRQPcQ7UQb6aEILg4cosnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="53611639"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; d="scan'208";a="53611639"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 21:34:55 -0700
X-CSE-ConnectionGUID: rfv5p7jTSOyF3fRYydCy6w==
X-CSE-MsgGUID: dAMKGxyoQlKtUqT3N5bGHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; d="scan'208";a="156296573"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 21:34:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 21:34:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 21:34:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 21:34:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6m/a+rIc5AoJbHESW2hCnZbhl7Ejf3nbxM0KnFudbbalqsX21HPwRAxhjypOV/rs6g0z9gta80fZ4xXciAfnZsbqW+66uOR/x1D30Nitto70OsWTJ2j349ZzwKmCeVVF2/qdoBq3XFJM3UZ02U0XYd5Xg3fifgy0M/WR/ek78J/z4vpEAlP7SkBsl0IkE+YRiZak0QI409NzwtjNSaSJASTZWNFPEFKZ40FrMRnJXmlyaRrL2CWrYhohEZN4+blC7hIKnAF/sBqp/8cDDGoyakBdvBR+UCPUdPmWkhdQmej2IQgH31e9TEQjaU/2rLPzlyFRmA9x9enM5Z3zl1how==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpN6/v6agAxwnHXxTEu81Mmqk6mYg8oORyHiHYHEndE=;
 b=rM6f4YifN4GelYVvdp6vkuMZl93TDrOHYCXDUELFkwDPOFsFT2hf40itNeXTxxgh6zBXM64ADFJHLkS80eh0u8W6OtSnfunrpgCVXr+K9d0ZZ69rXXTOxqmWi/9OAK2/y26wprqkUZ87fhT/6TVcP4XW05YhicgsUw7Q0uHokUN1Prp/ZpmAdAirBpu92iefiUMoYUsxyPsVcz8Wo0dGCLKWAQV3od9T/oJpT9/RB6vb3aRqwFmq6PSvKdFTAloV5zc1QXY7oW+hnWwWRMZJQ/BAsnksD5FB2XcM8DlaHhwjDShXZnk73cE6ugxOgbJFOgYuGe+ct4dfTyalsORhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF56FDAD370.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82a) by BL3PR11MB6505.namprd11.prod.outlook.com
 (2603:10b6:208:38c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 04:34:35 +0000
Received: from SJ5PPF56FDAD370.namprd11.prod.outlook.com
 ([fe80::f9b:966e:2823:f229]) by SJ5PPF56FDAD370.namprd11.prod.outlook.com
 ([fe80::f9b:966e:2823:f229%3]) with mapi id 15.20.8813.022; Thu, 10 Jul 2025
 04:34:35 +0000
From: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
To: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <hofors@lysator.liu.se>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, Peter Nilsson
 <peter.j.nilsson@ericsson.com>
Subject: RE: [PATCH] event/eth_tx: prefetch mbuf headers
Thread-Topic: [PATCH] event/eth_tx: prefetch mbuf headers
Thread-Index: AQHbn6YFqAHfW3ID8kGgUvaUsg96ILPmqzjQgDkyxQCABx0F0IAAMk2AgAQ6kGA=
Date: Thu, 10 Jul 2025 04:34:35 +0000
Message-ID: <SJ5PPF56FDAD37049CB189719E55D51A823A148A@SJ5PPF56FDAD370.namprd11.prod.outlook.com>
References: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
 <SN7PR11MB7044C3B89BCFC25021522487A164A@SN7PR11MB7044.namprd11.prod.outlook.com>
 <ff692fe7-03b5-408d-8112-5a4b30d9f96b@lysator.liu.se>
 <SJ5PPF56FDAD370AD3B60F4AA326723904BA14FA@SJ5PPF56FDAD370.namprd11.prod.outlook.com>
 <3c82f05d-216d-428f-a315-30457da0f94c@lysator.liu.se>
In-Reply-To: <3c82f05d-216d-428f-a315-30457da0f94c@lysator.liu.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF56FDAD370:EE_|BL3PR11MB6505:EE_
x-ms-office365-filtering-correlation-id: 0e8b20e3-95ff-4da7-2128-08ddbf6b12d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RkwvdDJ3Q1hSY1BJd2FEYzdvaEt3MEl3QVFSYUpvWVFxazNZWXoyU0x5U1cv?=
 =?utf-8?B?SmdLQWpCZHc5bTRsYWhHVVU2VVIrZE1mUndZWkVvdHlwODZWaEhYblZrN2hB?=
 =?utf-8?B?QWNKMEtVcFVra09rd1JyaUl5M201QlQ5ZmEzR3I2OGFzTDJzK0IzZ0tVL2Nt?=
 =?utf-8?B?YTMrVVcvOTY0Wm52cFZndGNtUmtCa0h5Nks5WWFBcTQyd1Y0R0xhaWJ4MTRS?=
 =?utf-8?B?YXdhUGpCdVlkUTJRSDVyaWRqb2VoYWZxTmoyUFJHVjk0dTU1N2FBRGk0WUF0?=
 =?utf-8?B?aktWL25FblhpSGZUQWtHK2gzbUlCMHUyUEU4Y1VLRXBwc2Z0L2FOOXBTUXkw?=
 =?utf-8?B?cjVMcElzdGtBbmd5OWc5RnJaak13MVlEMFM0UWhqZ2MwZjBhdjNVUG8yc2RZ?=
 =?utf-8?B?Z2FZV1F4T0RVQ3dhelhUeU4wNEkvSmlvb1NwOVdnd0pnRGZldkxxc3BIMlF4?=
 =?utf-8?B?TTBIY1RqTWYvUXpESDl0Zkl6aUx5eFhudERWVTZ0YXhjYmtZV0ZpMlBMSVBl?=
 =?utf-8?B?VTZsSjJOcTI2U1BQZmJZTGpTTGliMmpkeHh1dTRFZWxtTURJLzl0OGlPOTN2?=
 =?utf-8?B?SnpMZnl4d0JZQ2VrZ2tWTlhOcmlWdG1ZZEpmV0tYV1VBdGIxeC9wSDFKS0Ni?=
 =?utf-8?B?Ym5VeittbTFGNUhMNVBxU1VnMUI1NFJldHdoNFRHRGdNSUNhVmI4RThiSDR3?=
 =?utf-8?B?RGFBeFJVMkxUUG9rSkRoTUhyUEdLYUc3OC92YitaLzVzQzMzQUNEano4MENK?=
 =?utf-8?B?L3JhaEpjdEpBcWl0Q3FZK1hLS3d6THdXTFhqYytFK0lRZ1gzbStwNThzc21H?=
 =?utf-8?B?U2RuZzM5TTg1VlhTUWxmaUl5V3JTSW9SZkh6MmVKcE9WSzZlQW9xMFRySHVD?=
 =?utf-8?B?TFVCV1A4ajY0MmVUV0NkNUJqVUpoTXptQm9oazJpVHUrUjJaZU13amlJV29S?=
 =?utf-8?B?VkxrQlFaaDFMZXFzWTVEckh0ZHZic1gxNmhmalhYS3dnY0d5cnZBN2dGL0FF?=
 =?utf-8?B?WTcrVjNUUDVpWkxxa3p6ajhNV256eWt2eERJVU96SUEydUVpN0YzeGlNN2NY?=
 =?utf-8?B?US9hR3lVcjY5Nit2T0pBT2krTzMwMGtvYlM1OEsyVVNwbmJkZ1NJaytldTlq?=
 =?utf-8?B?bURsU3pzeDduMGdyQ2cxb1ZjVzY5Q2g4MGs2T3NhM1Z4c2VPRWZRYzZqc2Ri?=
 =?utf-8?B?aG5UaWpqU1R1MFpIYTVoaVgrbDJMb1JqS3FhSWJvalAyeFBhTGtmNWlDc0ND?=
 =?utf-8?B?V2Y3YlV4YWFHMzhrNEdmZGVHTW4rN3RpUGIzUHJrQmhYWEFtTk81Vk5haHV2?=
 =?utf-8?B?blJkd3R4VXk3ZTFNbm9nZWVOZE5BNDZQK3BQSE1RR0Z6RmF6QUd2TkV2MGtV?=
 =?utf-8?B?bElMRklQbE5DRzBSOWdpQ0V4L1hRUVZQSXdaTDVUNFgwU3g3ZmY3dCtxTFVa?=
 =?utf-8?B?VnlxZnU1b0JURVg3aVNaU3dtWTJZd1F3anpPbFJ0UjFzYWNEYnJjSytFRCtv?=
 =?utf-8?B?U2JLa0I2Q1JpOENheWpVMmZFcWZJUHNqVi9IcHJSRXdxK1BWYUFqSnJYWG0x?=
 =?utf-8?B?eDZPVnFrN3hCbkRScVNKRVp5QnpsQ1hxMWRuR1lhZ3lUZk4rNmNZNmVCVEl0?=
 =?utf-8?B?bzZCNlI4aHNWejdjNEluZ3hqbnN0MUE1OGM3UGxaWE9jdndobjRVMGw3R0dp?=
 =?utf-8?B?NXpMZC9CZ3pOeXBEZ2NjR2tZZ0M2T3R5bkZOcnF3K2E2MjdYWmNMR3M2eHVm?=
 =?utf-8?B?WFR3RTBWbTRGeWJJV0Znc0lzcm1wU1h4aGFDeEo0N1hneURKVFJPaklYWWVz?=
 =?utf-8?B?ZWdkc2JnK0xreVRaOUUxVGZPR1dSY0Z5NTVWUFVBMGMxWXB2N2tSZ1dCdW1Y?=
 =?utf-8?B?eWt4NjVPQURGTll6V21vT1JlYURrQ0RualZ4aDJnaUd1WitMUHhzcVV1R1Fh?=
 =?utf-8?B?cVBsNlNobWNndERGL0EwOTNaU2J1QTBnbFV4TzJsTXk1SGJaN0NlbUVUbWlC?=
 =?utf-8?B?aGxiKzN4RmJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF56FDAD370.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0ZYblluU2V3b1hKMCtoZHZuRzRGSk5kM0l5NE9zZFNZNGZ1N3NKSEp5TlQ5?=
 =?utf-8?B?TzNkSlZ3aWlRZ3NHNGticEdGajhGMDgxZktiRUFEK0x6UWc4aUhGeWlKZEVC?=
 =?utf-8?B?YUZ3REoxNHNZTFRwTld1czU1NkZ4OUFpRWxSaEdzL2c1TTFNdm9RYXRKU1ZC?=
 =?utf-8?B?cWpITGdsRFhOODhPZnpTdmx0Q21jMHZpTmJvMDhwUFVxYXhFd01TVlF0bjJ2?=
 =?utf-8?B?NktRcHRsWWltVEswUlFoN3FXbFl6QmpyMXh3SzY5SjNjdUQrRkR5N2drMldX?=
 =?utf-8?B?NXRZZUtVZVRVWjZhamxaL1NjeEZhM2J1SE9yc3Y5MlhvOE9rQlZndlpQZWJJ?=
 =?utf-8?B?NjdFSWxmbVZ3QjZya000WXMzNlA4dzNOZyt0UFBHR1oxQjUybDRsT3l0Y3Ir?=
 =?utf-8?B?UklsQ2k1eDA0cmNFTDJpWDdTbjZ4ZXhnZEVIL3FQT3pqb0VBTkJnbi8wWXpk?=
 =?utf-8?B?TmxxejZnc21qR1VPelhRSjNtLytER1hGczBkM3gxWjJoaTVuQUpxU21pUGhT?=
 =?utf-8?B?bzVQdUkwclovcXFnZDNWT1dVVGJhKzczTmNHc2xHUDV0eVhpaTJCNGlRdjBK?=
 =?utf-8?B?a1pnVmRiUER5ZkxSU1VKYmxPdWNCYUpwVVRCSzRjeUIxRjhrUnZRYVFGYXhl?=
 =?utf-8?B?V3pRVTFsMzdDYjlhWVczclNhK1ZhMVR4Q0IxS1hCQzZVYWJDcXorQ1NvZUll?=
 =?utf-8?B?WG9hWkhwYkpIVTZmcUpPR1d3QlRTRTc5eTVqTVIvQm9YUkowa21sRkY2cE92?=
 =?utf-8?B?SHVISDFtUTlvRUYyNzhCem5TMjFjYUN0RXR1UDBnTFkxQzMxZGlBK3B2clZN?=
 =?utf-8?B?Rm1ZTDArc085Mm9ScE9ScGlBa01ERTRFUnVBRzh5dDNwSVB1cTBvZUVnSmZO?=
 =?utf-8?B?UE9MTXRBR08vcnY5Sjd3b0NMK09uaHEzOGxnTnR2MkZ1R0NibHlVeDFUVzU0?=
 =?utf-8?B?S0dMSWFGanNJTEp2SjdjZ2dCV3ppd3ZWVEZiVTFGMkxPS0E3RHRXdC9KcDUz?=
 =?utf-8?B?V29pK3hoVjRZQXRvYm9kY1hMaHdMd2hFMytkOTRsZy80c0xEVjIzWEczQ0ZB?=
 =?utf-8?B?cHI5Q0ltQ1p6QUZiS1RMbklwZzJ0OHZuZVEzNCsvektkS2lOQ25yNHQvK055?=
 =?utf-8?B?aStGaEptc0ZHcVAwY3FQSldPeWoxZ2FsNTA3RWFWNHd0RGlsU05ubkE1YkQ2?=
 =?utf-8?B?TDk0YVE4Vm9ia01DVjlQMmtBcUZCdGlRaHkrV1I4Z3RKdzBYTWZySGNHWWlz?=
 =?utf-8?B?Rkl6RWVMWVZOSGZPa2VoZTB6b2NpdGtCTmJnRXdCUWU5Y2VNUXdvTWI2WUxy?=
 =?utf-8?B?Vmd0QVEvQnBtUithanl0NnoxM3h6L2g2UDQ0OXBtbThwZmdMZ1FPSVYwZnQ0?=
 =?utf-8?B?TS9lYXNtWWVPZG9xOG9nS0xRbmx3aUlGaGNnQnZKSFlpRmJBNFpmR21WSnkz?=
 =?utf-8?B?ODA2K0Z0RFU0a2dZbFcydm4xek1BODZRL0NiYk45WjlkTys4ZjZtQ2VURktB?=
 =?utf-8?B?d256aEVuYWhwZXo0cGtPSm9kQ2JQWG1BTDA3Y0R3UXVqekI2cTZsM3ZGdVZZ?=
 =?utf-8?B?bWVIQjEwRzVOREJGQVhsbnBHRU9GRTVNREIxTERuMTVIc080V2IrOFRxUjIz?=
 =?utf-8?B?azFmYU1FWXBBd0JxZlZIYm9nZjRadkZsSVFOY256VWdENXVhdis4VlFkMTBR?=
 =?utf-8?B?dHBQMnpnSGVSOGNKdUlYR0RnVDIxS0RLRHBvVHFZc1N5TVAwOW5QVGUwRlV6?=
 =?utf-8?B?UmlveVhQdnl4UndSS1lQWlRMaVdUcnhnNzBVbjZ5QjlmZFdHN0NiR3FFWVJK?=
 =?utf-8?B?WWl3WWpwdE1VYWNndnpMSjA5UE85RHk0WHYwRzlsbmNuMXNTU3NacWVqT1Ft?=
 =?utf-8?B?QXBHWWNsN3NhSnhxNXJmLzFVUWIyZXVuZmErTUUyUlhjTHNyRm0ydVZpWmFY?=
 =?utf-8?B?SkdYTkVxOXRPU3RKcGs2QThrVlNYTG9UYkVpdzlwbjAyN2RDMEVId0JObXNV?=
 =?utf-8?B?M3RYZFpxM1dGaXk1ZmVXbUYxRVdHNGhnMHBQdVFTekk0NzNJZTBTbGtQSlRJ?=
 =?utf-8?B?NU42YnZ2cFNxY2lPcDFuSmtId3EvdWJneXFLSGxkSFRSUVBSazZYQ0xick5s?=
 =?utf-8?Q?IAc6geIfWTy6DBBcI0I+t/U29?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF56FDAD370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8b20e3-95ff-4da7-2128-08ddbf6b12d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 04:34:35.4719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAU3oLkcVPONns+wcwaTapd3cdwd9Jl5RaGkOEjETRj6l+eLGCcWRsSyEoP/kD13ViKzy2ESb8I7E14ZWj8jSS5TQsAl5jAPk3YVshKHwf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6505
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0dGlhcyBSw7ZubmJs
b20gPGhvZm9yc0BseXNhdG9yLmxpdS5zZT4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDcsIDIwMjUg
NToyNyBQTQ0KPiBUbzogTmFnYSBIYXJpc2ggSywgUyBWIDxzLnYubmFnYS5oYXJpc2gua0BpbnRl
bC5jb20+OyBNYXR0aWFzIFLDtm5uYmxvbQ0KPiA8bWF0dGlhcy5yb25uYmxvbUBlcmljc3Nvbi5j
b20+OyBkZXZAZHBkay5vcmcNCj4gQ2M6IEplcmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+
OyBQZXRlciBOaWxzc29uDQo+IDxwZXRlci5qLm5pbHNzb25AZXJpY3Nzb24uY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBldmVudC9ldGhfdHg6IHByZWZldGNoIG1idWYgaGVhZGVycw0KPiAN
Cj4gT24gMjAyNS0wNy0wNyAxMTowMCwgTmFnYSBIYXJpc2ggSywgUyBWIHdyb3RlOg0KPiA+DQo+
ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTWF0dGlhcyBS
w7ZubmJsb20gPGhvZm9yc0BseXNhdG9yLmxpdS5zZT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEp1
bHkgMywgMjAyNSAxOjUwIEFNDQo+ID4+IFRvOiBOYWdhIEhhcmlzaCBLLCBTIFYgPHMudi5uYWdh
LmhhcmlzaC5rQGludGVsLmNvbT47IE1hdHRpYXMNCj4gPj4gUsO2bm5ibG9tIDxtYXR0aWFzLnJv
bm5ibG9tQGVyaWNzc29uLmNvbT47IGRldkBkcGRrLm9yZw0KPiA+PiBDYzogSmVyaW4gSmFjb2Ig
PGplcmluakBtYXJ2ZWxsLmNvbT47IFBldGVyIE5pbHNzb24NCj4gPj4gPHBldGVyLmoubmlsc3Nv
bkBlcmljc3Nvbi5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGV2ZW50L2V0aF90eDog
cHJlZmV0Y2ggbWJ1ZiBoZWFkZXJzDQo+ID4+DQo+ID4+IE9uIDIwMjUtMDUtMjcgMTI6NTUsIE5h
Z2EgSGFyaXNoIEssIFMgViB3cm90ZToNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogTWF0dGlhcyBSw7ZubmJsb20gPG1hdHRpYXMu
cm9ubmJsb21AZXJpY3Nzb24uY29tPg0KPiA+Pj4+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjgsIDIw
MjUgMTE6MTQgQU0NCj4gPj4+PiBUbzogZGV2QGRwZGsub3JnDQo+ID4+Pj4gQ2M6IE1hdHRpYXMg
UsO2bm5ibG9tIDxob2ZvcnNAbHlzYXRvci5saXUuc2U+OyBOYWdhIEhhcmlzaCBLLCBTIFYNCj4g
Pj4+PiA8cy52Lm5hZ2EuaGFyaXNoLmtAaW50ZWwuY29tPjsgSmVyaW4gSmFjb2IgPGplcmluakBt
YXJ2ZWxsLmNvbT47DQo+ID4+Pj4gTWF0dGlhcyBSw7ZubmJsb20gPG1hdHRpYXMucm9ubmJsb21A
ZXJpY3Nzb24uY29tPjsgUGV0ZXIgTmlsc3Nvbg0KPiA+Pj4+IDxwZXRlci5qLm5pbHNzb25AZXJp
Y3Nzb24uY29tPg0KPiA+Pj4+IFN1YmplY3Q6IFtQQVRDSF0gZXZlbnQvZXRoX3R4OiBwcmVmZXRj
aCBtYnVmIGhlYWRlcnMNCj4gPj4+Pg0KPiA+Pj4+IFByZWZldGNoIG1idWYgaGVhZGVycywgcmVz
dWx0aW5nIGluIH4xMCUgdGhyb3VnaHB1dCBpbXByb3ZlbWVudA0KPiA+Pj4+IHdoZW4gdGhlIEV0
aGVybmV0IFJYIGFuZCBUWCBBZGFwdGVycyBhcmUgaG9zdGVkIG9uIHRoZSBzYW1lIGNvcmUNCj4g
Pj4+PiAobGlrZWx5IH4yeCBpbiBjYXNlIGEgZGVkaWNhdGVkIFRYIGNvcmUgaXMgdXNlZCkuDQo+
ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXR0aWFzIFLDtm5uYmxvbSA8bWF0dGlhcy5y
b25uYmxvbUBlcmljc3Nvbi5jb20+DQo+ID4+Pj4gVGVzdGVkLWJ5OiBQZXRlciBOaWxzc29uIDxw
ZXRlci5qLm5pbHNzb25AZXJpY3Nzb24uY29tPg0KDQpBY2tlZC1ieTogTmFnYSBIYXJpc2ggSyBT
IFYgPHMudi5uYWdhLmhhcmlzaC5rQGludGVsLmNvbT4NCg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICAg
IGxpYi9ldmVudGRldi9ydGVfZXZlbnRfZXRoX3R4X2FkYXB0ZXIuYyB8IDIwDQo+ICsrKysrKysr
KysrKysrKysrKysrDQo+ID4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykN
Cj4gPj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9saWIvZXZlbnRkZXYvcnRlX2V2ZW50X2V0aF90
eF9hZGFwdGVyLmMNCj4gPj4+PiBiL2xpYi9ldmVudGRldi9ydGVfZXZlbnRfZXRoX3R4X2FkYXB0
ZXIuYw0KPiA+Pj4+IGluZGV4IDY3ZmZmOGI3ZDYuLmQ3NDBhZTAwZjkgMTAwNjQ0DQo+ID4+Pj4g
LS0tIGEvbGliL2V2ZW50ZGV2L3J0ZV9ldmVudF9ldGhfdHhfYWRhcHRlci5jDQo+ID4+Pj4gKysr
IGIvbGliL2V2ZW50ZGV2L3J0ZV9ldmVudF9ldGhfdHhfYWRhcHRlci5jDQo+ID4+Pj4gQEAgLTU5
OCw2ICs1OTgsMTIgQEAgdHhhX3Byb2Nlc3NfZXZlbnRfdmVjdG9yKHN0cnVjdA0KPiA+PiB0eGFf
c2VydmljZV9kYXRhDQo+ID4+Pj4gKnR4YSwNCj4gPj4+PiAgICAJcmV0dXJuIG5iX3R4Ow0KPiA+
Pj4+ICAgIH0NCj4gPj4+Pg0KPiA+Pj4+ICtzdGF0aWMgaW5saW5lIHZvaWQNCj4gPj4+PiArdHhh
X3ByZWZldGNoX21idWYoc3RydWN0IHJ0ZV9tYnVmICptYnVmKSB7DQo+ID4+Pj4gKwlydGVfbWJ1
Zl9wcmVmZXRjaF9wYXJ0MShtYnVmKTsNCj4gPj4+PiArfQ0KPiA+Pj4+ICsNCj4gPj4+PiAgICBz
dGF0aWMgdm9pZA0KPiA+Pj4+ICAgIHR4YV9zZXJ2aWNlX3R4KHN0cnVjdCB0eGFfc2VydmljZV9k
YXRhICp0eGEsIHN0cnVjdCBydGVfZXZlbnQgKmV2LA0KPiA+Pj4+ICAgIAl1aW50MzJfdCBuKQ0K
PiA+Pj4+IEBAIC02MDgsNiArNjE0LDIwIEBAIHR4YV9zZXJ2aWNlX3R4KHN0cnVjdCB0eGFfc2Vy
dmljZV9kYXRhICp0eGEsDQo+ID4+Pj4gc3RydWN0IHJ0ZV9ldmVudCAqZXYsDQo+ID4+Pj4NCj4g
Pj4+PiAgICAJc3RhdHMgPSAmdHhhLT5zdGF0czsNCj4gPj4+Pg0KPiA+Pj4+ICsJZm9yIChpID0g
MDsgaSA8IG47IGkrKykgew0KPiA+Pj4+ICsJCXN0cnVjdCBydGVfZXZlbnQgKmV2ZW50ID0gJmV2
W2ldOw0KPiA+Pj4+ICsNCj4gPj4+PiArCQlpZiAodW5saWtlbHkoZXZlbnQtPmV2ZW50X3R5cGUg
JiBSVEVfRVZFTlRfVFlQRV9WRUNUT1IpKQ0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBUaGlzIGdpdmVz
IGHCoGJyYW5jaCBwcmVkaWN0aW9uIGFkdmFudGFnZSB0byBub24tdmVjdG9yIGV2ZW50cy4gSXMN
Cj4gPj4+IHRoYXQgdGhlDQo+ID4+IGludGVudGlvbj8NCj4gPj4+DQo+ID4+DQo+ID4+IFllcy4N
Cj4gPg0KPiA+IEkgdGhpbmsgYWxsIGV2ZW50LXR5cGVzIG5lZWQgdG8gYmUgZXF1YWxseSB3ZWln
aHRlZC4gTXkgYXNrIHdhcyB0byByZW1vdmUNCj4gdGhlICJ1bmxpa2VseSIgZm9yIHZlY3RvciBl
dmVudHMuDQo+ID4NCj4gDQo+IFRoaXMgaXMgbm90IHBvc3NpYmxlLiBPbmUgYnJhbmNoIHdpbGwg
YWx3YXlzIGJlIGNoZWFwZXIuIElmIHlvdSBsZWF2ZSBvdXQNCj4gdW5saWtlbHkoKS9saWtlbHko
KSwgeW91IGxlYXZlIGFsbCBjb250cm9sIHRvIGNvbXBpbGVyIGhldXJpc3RpY3MuDQo+IEluIHRo
aXMgY2FzZSwgSSB0aGluayB0aGUgcmVzdWx0aW5nIG9iamVjdCBjb2RlIHdpbGwgYmUgaWRlbnRp
Y2FsIChvbiBHQ0MpLg0KPiANCj4gUlRFX0VWRU5UX1RZUEVfVkVDVE9SIHdpbGwgcmVzdWx0IGlu
IGZld2VyIGV2ZW50cywgYW5kIHRodXMgdGhlIHBlci1ldmVudA0KPiBvdmVyaGVhZCBpcyBsZXNz
IG9mIGFuIGlzc3VlLiBTbyBpZiB5b3Ugd2VpZ2ggdGhlIGltcG9ydGFuY2Ugb2YgdmVjdG9yIGFu
ZCBub24tDQo+IHZlY3RvciB1c2UgY2FzZXMgZXF1YWxseSwgeW91IHNob3VsZCBvcHRpbWl6ZSBm
b3IgdGhlIG5vbi12ZWN0b3IgY2FzZS4NCj4gDQoNCkZpbmUsIGFncmVlZC4NCg0KPiA+Pg0KPiA+
Pj4+IHsNCj4gPj4+PiArCQkJc3RydWN0IHJ0ZV9ldmVudF92ZWN0b3IgKnZlYyA9IGV2ZW50LT52
ZWM7DQo+ID4+Pj4gKwkJCXN0cnVjdCBydGVfbWJ1ZiAqKm1idWZzID0gdmVjLT5tYnVmczsNCj4g
Pj4+PiArCQkJdWludDMyX3QgazsNCj4gPj4+PiArDQo+ID4+Pj4gKwkJCWZvciAoayA9IDA7IGsg
PCB2ZWMtPm5iX2VsZW07IGsrKykNCj4gPj4+PiArCQkJCXR4YV9wcmVmZXRjaF9tYnVmKG1idWZz
W2tdKTsNCj4gPj4+PiArCQl9IGVsc2UNCj4gPj4+PiArCQkJdHhhX3ByZWZldGNoX21idWYoZXZl
bnQtPm1idWYpOw0KPiA+Pj4+ICsJfQ0KPiA+Pj4+ICsNCj4gPj4+PiAgICAJbmJfdHggPSAwOw0K
PiA+Pj4+ICAgIAlmb3IgKGkgPSAwOyBpIDwgbjsgaSsrKSB7DQo+ID4+Pj4gICAgCQl1aW50MTZf
dCBwb3J0Ow0KPiA+Pj4+IC0tDQo+ID4+Pj4gMi40My4wDQo+ID4+Pg0KPiA+DQoNCg==
