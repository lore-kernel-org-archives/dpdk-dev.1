Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23546C0219D
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 10:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B19C40156;
	Tue, 11 Feb 2025 11:09:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 384D340150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 11:09:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739268571; x=1770804571;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=5rXIOTpW6UT6MnogK9BKO2RXVLwHOQ6jhcN9hE9dUNI=;
 b=FkVQ3OAwZONcd0sfjeU5hXxQNGYVrknSKfGRaY9XEL5edi7a14CFRjn/
 QlfjYcY6NBgtA/3SMGWbmSnkXfm1DNye/wByhnZxTS3E9HFkObXhd/NPS
 VFkIggqCYSdfeegwWKYCz2p7zq1CE/Cm+2KymOndqmGRso2AO9OeKQ2Jr
 ZzuZoNdermAw88c+Lns17utZTQeQABehPCQwu/+O9Ixjn7gFZocxLFsRF
 jMYd9dJ5JtrudZqgABbTPjpdZRsuOQs9OO6O3OfYt0Sqo0NbiixOHdFk+
 Zw/GqJUPWfkmnrOXLxg0qECr1SApbjaRE1NdNI+6FdCFkmu8Z8lebHY0U g==;
X-CSE-ConnectionGUID: R25nYGV4Td647cuWeuUIow==
X-CSE-MsgGUID: hnwp2b8dRZmdC1NrBOxP5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39796759"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="39796759"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 02:09:30 -0800
X-CSE-ConnectionGUID: j530feIbRca1fKVIrnDigg==
X-CSE-MsgGUID: FbnsFV/sRIOpc22m85ZPcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116556745"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 02:09:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 02:09:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 02:09:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 02:09:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZFVdURCFnS5yWKS7pSGnDtyo5d/+AyDwOmKsgK+d5c/GG0KN3T6/nvmjzIFYvayxzH7zfmApQW59EKP8V2RNjtFG56Wwzd/oGiWSYfan3nkGC0DNIdRGqRkWXkO8l1l/rIzqDC/fsMrWeDHVmCEv1ckLkSHfIvlQHNxj/bJhVJMi7zC8eAXF1bpcaHJB2t5wuDrISpOE3FhTm/N3Daya6ZVsSXMQOWcuh5oN2FO2RQLItrtaAgGOXfW+Q4SSwvqwfmQdt41/46mjmhr61QEj3dzCiF08UBuntbBgf0VahUbb6pyfoOzWsi8k+3ojTdbwV0HbL+nZTKxj5DwU86MNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17pdY/d4M+uSQt3bvEe0pTFso5kuVo+uEsCZkAxcFFY=;
 b=jukX2Bxm9Gevq40L53INcH0ErF6mmfqN94uHTq5ipwvTaClQzcQ7ltJ6+qe6k5f/fb/dCIzUqmF06S9BK4QBWJip5k4pruuFct01OPZgF9LOsugxIg9W9AHp9PE+2Z7hOGkt6lJJlvUsJgqZmMFoPF50fJsAHBmownVyI6QWiKlpoScdRQ8WbT3ydnSJiNt4bFYbHTyWX4SO9+HNvlVq18+G8kq3QFdvWrB1Nez8VaY6RS0s69DusLbwxi1GsaXX9TnEweG2Mk1mPHolnFfYw14NcHbchLpI5FQpqSIVdgXQ4mDisY+m9gsrWxNGqS7xxwuYzFyVD2OZyT8ekaLl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6777.namprd11.prod.outlook.com (2603:10b6:510:1c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 10:08:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 10:08:50 +0000
Date: Tue, 11 Feb 2025 10:08:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>, Ian Stokes
 <ian.stokes@intel.com>, Patrick Robb <probb@iol.unh.edu>, Paul Szczepanek
 <Paul.Szczepanek@arm.com>
Subject: Re: [PATCH v3] build: replace support for icc with icx
Message-ID: <Z6shrO5njIJtB_3p@bricha3-mobl1.ger.corp.intel.com>
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
 <20250210171845.1669874-1-bruce.richardson@intel.com>
 <CAJFAV8xqY=XxNy-fN7VTX-MOdtTCAOVGGW5HGPayfARqMsrFFQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xqY=XxNy-fN7VTX-MOdtTCAOVGGW5HGPayfARqMsrFFQ@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 319a0da6-114f-4bfa-077d-08dd4a841487
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHNQSVFZRi9DLy9BZUVPcEYyQmF3clhDMVNzRUhGaGRiTWVSV3A5WCthbmVz?=
 =?utf-8?B?Y2hxTXR3VCtkSi9oaWhTczMvYktzSHRna3UwNVI2cHBpTHdiQ2hLWElzczU5?=
 =?utf-8?B?ZXVITDcrMEplR2g1NGZ6UVoyemtZM0VET3gwNlEzaGZYRlNhK1Z1QzhIck13?=
 =?utf-8?B?SUNXUExMNE5pczhSQUx4Z3A0UXpqUFBQREhFYXU2R0RBWml4aHU2cWtKOWhB?=
 =?utf-8?B?azlUa2p6VTZGMU94bnd1NW1sRnhMTUNaZk9zbmxqeTF2SUtQUFpHbnpkMDBq?=
 =?utf-8?B?T1UxVmx2VTE0dytaaUdvVUdjN2xQMGttVGtpeTRHVGJIT29tZU9ycUEwSEJs?=
 =?utf-8?B?a0FqK2Z3NTV0UWFNOGlLbndHYWtqNEF0a0x2YnFqM1J5cXFDcnRxOVdvSVl1?=
 =?utf-8?B?TDI0a2YxMDZFeUpneVpSS2h1QWtVUXRQNTNMb2ViN1l3M3BESFl4c3VHckRI?=
 =?utf-8?B?Nnl2REQ2OVltZHRPMy9qM3VUbEZ2MlNFVlQyUk82UFJjbkpUbUp6blN3WnV4?=
 =?utf-8?B?ekhVeWExWlRoOXRMRktsQlV2b09zMnV0b2k4NFhFRytUWnJQSzBwWEE2OGVw?=
 =?utf-8?B?a084MTQ2aWltc2lFTSt1MEZ3TU00YmRDdEJqTkNFRjNUUmJiT3c4Z2hsNlBE?=
 =?utf-8?B?cGRYY1ErTUNqMmRjdTlLVVNHb2JxWDRsUzg4MnNBampuRHVhZEVmbFRmc2dz?=
 =?utf-8?B?bFdIbmVNSWZCZks1L1RpVXlHMTh0b2pMSnpEanRsdkFCTFBSa1U2K0NVYmpQ?=
 =?utf-8?B?ck9XOU9PS0p5MGp2MHlQL0c0VFRidTI0MHlXS0NCWkhXb1pMZjI4ZG1ZYWpm?=
 =?utf-8?B?TTN0MGN4WDhENVM0TUNvaGsrNWY3Qm5qK2xxQ3Qzb2pDL1E1eDFjbUViMXZJ?=
 =?utf-8?B?aVhmd2VrempidFRRYWwwOTNXQXBvTzVLbnFTOUJTbGNKL2Y5Tm4wTEVjZ3hB?=
 =?utf-8?B?YkZvbkFlbGJzTUdWNlFiTWtOTUdKaHlKQ0hGYXVENG1CUXllb1pQWXZQaU45?=
 =?utf-8?B?VzFBaVdiR01BTnl3RS8reW1YTUdZZlZWK1o4OVFSb1pMSWhvSWc5T093TVM5?=
 =?utf-8?B?OFhrQjFyTzYxbWpIK00xa2VVRTg1alMwdy93V1BxUFp1d1J1R1lSMHM1MjJh?=
 =?utf-8?B?NldpQVFXMVNMdVpFQ1NPTUlzckRhWHZuZzk4UWFZRmhudWtVQlB2TmtDNUsr?=
 =?utf-8?B?bHFHQlVtbUoyVUJXK2FOWmM2dTlDR09UdUVnWHc1b0pVRjJ4d1o4dDFZNmho?=
 =?utf-8?B?OVNUbHdhRzF4QmVINDQxdlI5ODVXc1A3aWZtVmlZVldaaHBjemJ0eUZnM3Fr?=
 =?utf-8?B?ZUVObWsrbnZldHo0Y0NSazU2Q1ZWenkrbHA0aWljUnFGRC9zYzZrSzA1WkRt?=
 =?utf-8?B?RlNkL0djYXh3L3pSQm5pc2hVTk5QTmVmeXQzclF0RGFuNW81WDhpT0pEaUhs?=
 =?utf-8?B?ZHZ2Qy9CcUlzaTdCZEVCWW5OWUx6RzRFM3NCY1d4RGJtMjZydEdZYjhUWUl6?=
 =?utf-8?B?S244R2dvOTBwckQ2Q3ArUENBUTh5M3NwaVZIQXU3OWFnYkd5UmlraEMwa3hp?=
 =?utf-8?B?dktuNkRlSGVGRHlWL1ZnWFBUT2Q1R1RMd2tJbVYxTFlQMEY5SzkwZXIwSGtq?=
 =?utf-8?B?SHpjdnQrdnZqem9nZE1lZzNPL0RFRFhaNkgzN3VYLzM0SGRaRnprOVd5ZnVt?=
 =?utf-8?B?eXlXTzlVYjNYMHJxVTdJTzY5d1c1R0xaUlNaNXBQdWt2RXIwZVBOZmlwWVU1?=
 =?utf-8?B?elJVTGN5YzlyRkdKK29EK3RuL0c0ZDZzU2JwN011OEsyUkhmRW9nUm1vV0Iv?=
 =?utf-8?B?ejh0cVZid2NyRlVmOVI3QlhYVmFxS00vUmlxbk9HR1VQZWw1RjF4L0ZPeHBH?=
 =?utf-8?Q?/vINm1QXf4LQg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blFGeEJlTFR0Y25TcVRmbDdCZWswWTZTYVdKeVIrd2NNRUdWMVdWenhScVRC?=
 =?utf-8?B?WnZTMW5kczBYdGIrZUZRY1ZCMW14cENBaWZHUW04azIxVnVVRU0wN1RBRG1o?=
 =?utf-8?B?N2V3RlRDQmQxaXBtTmZzWW0zVkQrY3UvbmMvRFJOczJLT2pHY1dmdllEMHI3?=
 =?utf-8?B?WE8xQ0k4RHlBQ0RpT1AvbnFFK2JoV3lIVFJFY2krbjBhbk1FNjdXWHlQU1Av?=
 =?utf-8?B?NGdPczRBZUFncVJ6R1NzM3FzL1JvQlh2Z0taL3JtZzlLZkxETFJVMGRqT21N?=
 =?utf-8?B?NyszS1ZuV2VacGFKZC96WjRkSzVmQld2UENWWW5HNytvdHg1b0dQbzE1dnhX?=
 =?utf-8?B?czN6NlZqNityTUFrV0F3RTJsR2VXblR3c1VxWTV4NVNHaDNwWHpBR200emNM?=
 =?utf-8?B?Q3loUFlFMjgvY016L3RteVM3RUhBazRuVVNBQk9MZU5EQjV1Z3pJM253Kzlp?=
 =?utf-8?B?WGU4ZFh0Tkx2aWpDNlVCMnJIMHA5dGZwaVpXNXRwZ0NMeWdEVEpuUDlZY0Jp?=
 =?utf-8?B?STc3MHkrSXNiK2ZPVXZtTnNaanRld1dEdStjbXM2dXhXQmcyeDNrWFFsbUJj?=
 =?utf-8?B?NVNuWlpJRnROSWpISlVtMXdsTi9aQUJLZGJtK2pQZERUWVNOU01kZjFvcHFx?=
 =?utf-8?B?WmpoZTVLKzhOblkrdytzallKWEgrNU5KbGZKQjAvazl1R1dFZDBWVk5jaHB1?=
 =?utf-8?B?YnUvdXNhaFNjMjh1cU4yMEV2MmdFbFlNYlQzS29tZGlZSThNQlJVOHNRTmFU?=
 =?utf-8?B?L1d0bUwwSHhDWUZQTFhDNFpHYkxTYjlwME90ZWpNODVZNzRJeGZiQS9DTU5s?=
 =?utf-8?B?TC9sejlIcGNBaUl5S1pEWjIrY2U3MXpxYWpJZFpjTTVKTmdPOE45OWF1bXFR?=
 =?utf-8?B?ZEF0Qzc1dmFFWUpiTURxME5OTEVQOEs5eWp5c3duTUE5MGI0N3A2aGRyTHRE?=
 =?utf-8?B?QklUMUVIRXJBSmpwRlRBeXhEcmZJQ0poV2gyQzh5c0dKdUlFb3ZJNmZjenlp?=
 =?utf-8?B?Z3lYSGlFQyt4cUo0MSs3Vm5EQUNmNXRFT1o1TVkyUThoV3M5bDZGckZaMDNV?=
 =?utf-8?B?algrS3prY3dhQVdzMXlTMkRmRGJKMkIxamd6WGx6cm1iNTFNcWFyK0l3SjNn?=
 =?utf-8?B?TVJHWFV0dENnRHVnT1F5NGVZU3h3RDlMUzlvS3N5L0Q4L1N4N25IVy8xMllu?=
 =?utf-8?B?TXdPR1luU3dORnp0cXgyU2thS3hOaURtRnZGSUc4QlJWSHRxd3ZkRmpXVFYz?=
 =?utf-8?B?ME5ScjZhTzEwcWlPNnE4ZTZNNVNiNTBqK0lYYWVrNVpkUkVTcGkyVXNkbEVX?=
 =?utf-8?B?MVQ0WWZiOXRnT0dxMmFTeUUycDBheHlzQVJNNVdXcityUTJ4dTlIMEx6eElm?=
 =?utf-8?B?aEtoVlMvdDZqeWdBUmFYaW9ZTWc5V2VBdDY4QVpXQUs0VXJ6YUhNUGtkY0lI?=
 =?utf-8?B?MzFpTGRka0cxbDgyZEZjSWJ2UllHcUt3VUVsWlkySFVCcmM2UWplL0FRQUF1?=
 =?utf-8?B?YTE5ZDUvdkF4WTdXT2l1d0RnZk5MYmtzYWRzN0cyQTRwWG8xOXAzMW1HYXdy?=
 =?utf-8?B?a0dFeUNEMkk4RlErdHRsdjk1MlpHSVNoTzFJcURob0hlay9FSmVUNy9ORnh6?=
 =?utf-8?B?cTZFQVg0TUwwNWc4dVU0cnZDRHlyNE10YnZZQm9zR1J2NUtSc1RPZlJ2L2dJ?=
 =?utf-8?B?bW9YTnVQdFBVOE5MM0g1ZTh1ZGE4bjJUV2x4c1BEcUxvMjV3OS93TS9IOXFq?=
 =?utf-8?B?U3ZYYU1vbXV2L09HMGFGbjFWOUpNeHdUek1JV3YrZWE5aVArTSttR0hrTXNp?=
 =?utf-8?B?dGtya3FHOG1LZjcrRFVmSzNPZlpKRG4yRnIwNUllRGo0V3lySFZoaUd2QlF1?=
 =?utf-8?B?M2R5cnEwSk9NVUpjNUx3MEljT2IvOXRiUUtCT1ZIbU9CV1oxc3BCK2o5WlF3?=
 =?utf-8?B?elplWGJVc2h0UndPTVlaN3RSZnlwWGliUW9YZWpwbmtCVnVmbVY4QWROek1a?=
 =?utf-8?B?bE1EREQwVzF0akd0c2tRQkxlVHpiQW5yRUVjZUhucWNxRmh4OE92OUtoT3JX?=
 =?utf-8?B?K2xrQUV4dy9CZ0JrQXpQWGpCODdicHRndnVoZkVNZWF6TWw5QnY1cmUyZEg4?=
 =?utf-8?B?UEgxTmwyeUZsb2VhbmV0VHRmSHJycytyZi9LSVR2d2JWaUNkaXFEZ0RBcmRS?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 319a0da6-114f-4bfa-077d-08dd4a841487
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:08:49.9088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+FhVfz7CUR7S8RNKsMCh5ASgS7kHcLN8Ut7XBBdoEnwNEj0Q0jF1e0QcdhaXEQ+VJZ+iXc1X7NG8Gicd0E+xvUifVE+BjOaZQFeQeUWYkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6777
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

On Tue, Feb 11, 2025 at 10:50:23AM +0100, David Marchand wrote:
> On Mon, Feb 10, 2025 at 6:19 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
> > index 981600e24c..eab08a90ce 100644
> > --- a/dts/framework/testbed_model/posix_session.py
> > +++ b/dts/framework/testbed_model/posix_session.py
> > @@ -391,8 +391,6 @@ def get_compiler_version(self, compiler_name: str) -> str:
> >                  ).stdout.split("\n")[0]
> >              case "msvc":
> >                  return self.send_command("cl", SETTINGS.timeout).stdout
> > -            case "icc":
> > -                return self.send_command(f"{compiler_name} -V", SETTINGS.timeout).stdout
> >              case _:
> >                  raise ValueError(f"Unknown compiler {compiler_name}")
> >
> 
> I think we can drop icc = auto() in dts/framework/config/test_run.py too.
> Wdyt?
> 
> I can fix when applying.
> 
+1
Please fix on apply.

Thanks.
