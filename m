Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6567FC77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 09:19:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7059440695;
	Tue, 24 Jun 2025 11:19:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 06D4740264;
 Tue, 24 Jun 2025 11:19:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750756784; x=1782292784;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SHMXIQPqG3EvcXa451zlQrCun2IlBidNKBQjJJ3/iy8=;
 b=KVwODUjjSSORfQbwVu/S0PVq02DdKubJxy5ZxTcwghKfUJK29aXKWPBX
 waOK14A2y7o7nRAi75ECUEaOFY+UkK4EsC+1C5AaO8Hlhfz1VYyrRO24f
 FbGzcBjt75Pyip+scmNMBWJ8jTVxnCwX4cwm2mfIB5+j6kHOYYT5AuEJX
 +uozKpryyNbIPQTPO+yiD+kiPVPxohFrhPEsG6YkiSwT3hfY9KPqqsvrG
 No/NCefyLoXw29eSYSPtG7kRrJRdaN4t+YtSrl7VySHSMiWC5q6i9V0E8
 b91Rfq9/gdifciYZGJ9atV7qzsPecmNLZ8Hk2f0xb8GZAk5gr5iwPaUyV A==;
X-CSE-ConnectionGUID: 6peh4bhcSFumOqfHt5HnNA==
X-CSE-MsgGUID: rgxvEc3YRWi6xnS9PjudMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52217180"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="52217180"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 02:19:43 -0700
X-CSE-ConnectionGUID: cslguldoTrCzsqj2IMBhpw==
X-CSE-MsgGUID: ID5Va1mjQFSpcJ5pbVCLWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="189058140"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 02:19:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 02:19:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 02:19:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.73) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 02:19:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LotOtSjF4eEr6zA+OYDZtVw1kCYTSBSAfoPoaF1J3vISvtdTaWgQlFbcDoM5gacUeclAnohvgAEe5B7MMCejrp8CTrGgoLyBpJoaNMfKLOMc+Z5AaBof7lmVj0xdQLclnzEsW0SVK/zc11lPaXBtfGGrI3gn3WfUyZQJuUuyLAfouQCEKTaQbZCZFIGyh8x4ZkqCF7ShSwpGzzrzEknktdFB11fJfP7D1zEsCGnJzRLwXzYOHVPFPa5Y2UDDwKQSwide46tdCr3fd1faEUoUFzSg2Kthmv3nzHZK1RtEwpeC3w/cbm84iuNEHbP5udF8Hmwvx7g1aqEaQvCz9HjyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHMXIQPqG3EvcXa451zlQrCun2IlBidNKBQjJJ3/iy8=;
 b=Qk95HcSzQPJ/Eq59pCecVGLOyemzpVRk9ZXDdKxCgxnOxtVC0/FYwBVvhnu+xamtFzLiowzEg+6EUkav+9Xa2eZ5L4gmaTRb85agrqtz9ZY8G/xAkAZ/+t0BM+E6EgGv19N3UEyNczp367H5/q3BSGqbXxkdVUSGnWl+6NWzg1B8IGtOlZinAY12Z25jxxeM9FG2dcwRbGW+kdVW5JJbKcaE9jfnSkNfaj2MihCGiygxjxq+oWbSAttrn5ZhQrkQp7YPkPsiH0K6obtbg0r+1xAQPe7h+T7Itq3HwmUq8r8hVPZw6dBoXrfp7kEWiogndb4JThry5FWb5u2S4qef3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 09:19:19 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9%8]) with mapi id 15.20.8769.025; Tue, 24 Jun 2025
 09:19:19 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/iavf: fix VLAN offload strip flag
Thread-Topic: [PATCH v2] net/iavf: fix VLAN offload strip flag
Thread-Index: AQHb5Gpb7TXAi/b41EmOaR4zKI/ft7QRFnSAgADyFWA=
Date: Tue, 24 Jun 2025 09:19:18 +0000
Message-ID: <DM3PPF7D18F34A1A1141693EF5A3DDF8B588E78A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
 <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
 <CAL+mCpOU+q542mGrA+aT+nO8Rs4dtAY==U2SbvYJFvVd1e4qCA@mail.gmail.com>
In-Reply-To: <CAL+mCpOU+q542mGrA+aT+nO8Rs4dtAY==U2SbvYJFvVd1e4qCA@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SJ0PR11MB4798:EE_
x-ms-office365-filtering-correlation-id: 2a084710-51af-4e36-6ad4-08ddb30032d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eFVHc09FcjJ5V053MzZ5SjBvU1JUWWtKaEt5a1ovSzg5UUFZb2p3Tmk4RnZ5?=
 =?utf-8?B?eE10VXJxSGp5QXlPdVZrSG5yVVNrWFRtanVIb0VnZTJGVCtZVTZyQW1ObWQr?=
 =?utf-8?B?bzU0M0ZsRzdUS1F3R0NDNTEybnFSQ2MrbkNhaE5Ja0R1aWZUSTlGQ2NQbHRR?=
 =?utf-8?B?YjJobTNtc0ZWRzFoaGF1SUJIWDFDaDNuZ2JBT2Rod2xqbTJ2ZkIvNGxQcDFY?=
 =?utf-8?B?V2h5NnJ3b3MvQkJOc3BxbjR6QUNNYzV2QUU3ZG1XWE1PbGVIemxteERzRE1W?=
 =?utf-8?B?WGFUUXhvNmpidG13OEFuMjlUVjh3eFlLZkd6RVA3NFZhdS83QzAvWXBjT1Iv?=
 =?utf-8?B?SWRkeDlCOXYwRjBNdytIOFZnbDZpVEtCTHh5Q3VrVjE2UWdLdTJ6OStkTDIv?=
 =?utf-8?B?T1RxcUczdTVzU292L1Q4ZGlGd0QvdkxiQzduZStaaldnV1FoU0tEY3l0U1NX?=
 =?utf-8?B?UTZDaXlER0l0L0oyVTNhNlE3RlFUOEFiNGdDUjUxbm5zWU0vOVdiQ2xtK2dK?=
 =?utf-8?B?R3poek9veVhUU0hKcW9yR255UVBHNFZMWkc0ZGJ4bWtieEFkTFF6WTlXWTFz?=
 =?utf-8?B?VU9GL09CaWdzQmpMN0pyL2pCZnUrai9OUWp6VjlWV25OTVVkK3ZrWVdvVzZ0?=
 =?utf-8?B?Z0ZwUlYydjc1UWxlV0NLemQ5ZnlNZGNHdHRCTGpTMzB3N0hCbEhwYkt2NFQz?=
 =?utf-8?B?ZXVKV2pzc2ZiUVg0eWNUQVpXYnlYaENEZUxhWTFVMWxQQVRnQTZaayt3UjE0?=
 =?utf-8?B?cnFjRG9sTnI5b2NqSWNyZk1zNjZSbTdSdWFjUWR4ZTlVczlLOE0zVWQwNmhK?=
 =?utf-8?B?d0N1ZzY2bE90ZUFOU0d1OFVVZUtaWnNUTE5CTklkUFBBaWRWdDlYTDhTblV3?=
 =?utf-8?B?WXFobjRaV3ZLTnY1VUZYRE90bzFPeG10Rzh1emlQZ0dRbHpVQnNlTkxiQTcz?=
 =?utf-8?B?MkpFNVJQczduZXBRbXpqVTJQemxUaWdSYmdzaGFVNnNramVrRkRmN2UrS1pS?=
 =?utf-8?B?OTRVclJGSmFGbzZoNjV0ZEk5SWNRbU43ZDZBM2ZBdWk3SnhSNC80RTBOYXR1?=
 =?utf-8?B?YmQ0R2V0b1l2cytLeEFlRDZzb3padm5INS9KanNVamxLVDRtMGsyT3pYVk93?=
 =?utf-8?B?TE1NeTdtOG5NZWR2eHQ4UlU5a0U2aDB5dmZPblE5ajJaMlMvNWVVVm1kWVh6?=
 =?utf-8?B?S2RQUDVjR0UxbmhPOFpoUGFLUERFMGZhS2kxbFBSR1hEYm5heGdqMENOMWhj?=
 =?utf-8?B?RHg1MzBTcGV6OUh2K3FXcEgxV01KYnVhNmNyRW03Y2dMWHI4Q0gzSGxKYTRY?=
 =?utf-8?B?VHNoYmdnRkp0ejlZMTUyYkNhTFQzd2dGUnkvbHNOMU5sTFgvZWtsaVgxMGF4?=
 =?utf-8?B?L3dERGp5eE11UVdtSHE1TW9ob1JCYzZ5eGM4TVRIZU85SG05M2NiRHR4Q3hS?=
 =?utf-8?B?eWZJZTd0VG84M1lKMDQ5a1hBLzduVHcxV3NYZnUwSWlGQVN3QldIV1NSMXdY?=
 =?utf-8?B?TjBsb2hCdE9iQ2I5OUEyQkJaZm9ha1RDdCtwNzQzZ2U4WEFVVHNOWVlEcVRq?=
 =?utf-8?B?bEVVRHE2L3ZIUDdNWVBadUw0b2hVU2dxZ0FRRkJsZlF0clVFaDM0eXJOdWt3?=
 =?utf-8?B?WGVyNlhJdVJLYUtrQ1ZYUVBkbnJ5SjlWdHlESGpUMWJNMHprYTE0emVBTUlm?=
 =?utf-8?B?UjdVWHlhYjZjWitNUE45czdkOVo0b2QyckRyeUJ0OXpTZ1hxTnJoVkVUL25Z?=
 =?utf-8?B?VUFrUDI4Z2Y2SG80dDl2Vm15c214cFNkcU85Y1A4aUVPZkd5d3EzMXJaTmNo?=
 =?utf-8?B?dlN1b0lVS3ppWUYzS2p4L2hDZ25Fd0xhQXBWSXN4dnlVdVg1cHZvQ1M2NmJn?=
 =?utf-8?B?VVVMdVB0VFJzdW5kOFFWQUNiSEdHQU9iZnluaVZQWlBaSG5DdnBKNWR5aVpZ?=
 =?utf-8?B?WkpweUdEL2I3MHpFRityTFJtL1hVUVZmR01ZV0p5NTBTdEtMWWdQaTRmTjkr?=
 =?utf-8?Q?G788X3nvPCNle0KnJfOVRnRJQNQexs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHRaWHMrR3NvY1BxSk5Lbm5OS1IyNFhjVWpoL2tTR2d3cXhSblg5ck84SnFZ?=
 =?utf-8?B?aU1kMTRJQWNXVzNHU1Q5bHhYNmM4ZkR2YW9PaXB0M2RBMk5nYlRFMmxnMmR2?=
 =?utf-8?B?K202K2g3cm1qOWN6cFcxZURUOFp0NEdnUGhkWTFVS3dlRnBqYVIyN09SQm9V?=
 =?utf-8?B?UklVRXo5bUpPL1pRVlh1STVERFpSMVFkODQ0anRYU2RHeVdxZEhRMG9EMlNU?=
 =?utf-8?B?L21hbzV5RGVPWTdBZFpoT3ZHdW1HcGxsM1BMcnJJeEZoQjdNQUx3emVKaUpu?=
 =?utf-8?B?S3J2UXFPVTIvdkNscmNsY2ZkQjdnaGhTYjhnL3FJTFJlMXBmNEl2OHUvN0pX?=
 =?utf-8?B?eTJaZ0xiMXJQVjgzcy9wU3pWY1pLM0tMbWQwT3c5akNtRXdwM2RNTmp5dGxI?=
 =?utf-8?B?L3cwSHlYVkMxMGFTbXFHTzBEemJyajk5U1p2TzBiU1ZwWFJSUXc2RTY0VHhl?=
 =?utf-8?B?RFVFMVdMcEtiNk9DN3RwbDhtQjlCQ2Q3b2RkN0w1QkFiSVM0eittbWFUTXNv?=
 =?utf-8?B?RWhIRUdTYzdxSlQyUGdZNlN6cVpzS2R3bDJ2ZEwyVTFvZ2drbUlvUThqL1d4?=
 =?utf-8?B?c1hEb1Zva2NmOW02N0hzZ3ZNVituOU5PcjdmK2l5MHVVWm5hajhXcmxjTjU2?=
 =?utf-8?B?Z2krdVlJY0o1ekdvblRvSEpVbzAwbm9uVHpJcmhHL2NqV3NKWHExbmMzNEwv?=
 =?utf-8?B?cjZLNzI2Q1d4ZnVrOGNVQ2dIWGxyRTRTeHQwd211VitCbDlraURXWVowbHFq?=
 =?utf-8?B?MDhTZnRsWTFFZC9hTjFJUWd1ajAvdEVEYmp1SkY3RDF3azJEaFREOWMraGE5?=
 =?utf-8?B?OE9sbGFHbFRBckIvSHI4c2x2a3lIc2grVStwYVRZOVl0VWl2emRYQVorQXpa?=
 =?utf-8?B?c0RDd3JGb3JqMVFTVG8wak9GN3lic1BoeFUyaC9mZnlUemh4cFRhcmhBVDY3?=
 =?utf-8?B?L0REdnRxakNZRnpPcUdJeGdVdXBjN2g4Q09hS2IzellKcm9UaGMvNHN0T0VO?=
 =?utf-8?B?ejNvaU9vRmFvR1NNSFA0ZVRNbkRIeTlHM0s5YVp1QzR0SVd4SDRKbTBNbGt2?=
 =?utf-8?B?Z3JKLzlxQ01EUWZMckkzVERjMjljWlplRTh1VzYvRThYclFKVW5qc05jQ1ZN?=
 =?utf-8?B?V2RaN0Z2Wmd4TUppNDdQZ29GZE4wZ2pWZ0NwTE9mRitqWTZ3TmJxYng1NjBo?=
 =?utf-8?B?cWkyZms3ZDgwbll6T0I2YTRoR0NzaGU3ay9GYjMxSWtYWThUZlZUaTB5RUU4?=
 =?utf-8?B?TGdxTmNMTFVBU1h2VUtXZHMxTXh1N3UvcU9GZ2lCbXBkTWpPbjZMYzBHNGJD?=
 =?utf-8?B?eFpTcGE5QTlESzhtL1UwR2ZSMW1QNnJJWDZ5Q2tUUklFU1lXTXpsMmxESGpY?=
 =?utf-8?B?bEtPaGFmSTJWc2RnTG1nQlRoVjd4UVlHTXZwaDVuam9USnhvZXVqMzZ2SUUy?=
 =?utf-8?B?MVdQQ2wwSzd6U21lMmNIZmlQT3lUUjdJQktFS1Z6YkNCSXVXZGtyVjljMjdY?=
 =?utf-8?B?cGkxNFdBajNNbG9zd2VPdDAyYWVwSUV2Q2dvZlFINXljWUU2OSsrNU9wOWdL?=
 =?utf-8?B?RGl3dWhsUUFnTGdqSFUya09HaGhkU2NENVQ2Z2ZPeW5IYVRMUEZNYnJLTzV0?=
 =?utf-8?B?Qkx4MGFVOFRBTEw5U3V3V0ZadUxnSkVqby9kS2ZoTkNNUnB3NFgxeEFuK0xh?=
 =?utf-8?B?MnFmTXRiSEp2dFhoTUxxaWJQL1VVemZybm5ncWcxMjRxdGZIV1FhVkZuNzky?=
 =?utf-8?B?QlA5L3lsVUR1aFMyUUdhVkViaEd3eEduZ0cwMUY3dHFacTdwS2JhNDFRdDRB?=
 =?utf-8?B?ME5Yc3ppNU1hMnhtaGxIU1hYcTlORHdrR01wbFU0STNYNEtncGdwVVdQVFB0?=
 =?utf-8?B?MVdiMWtpdW95SDFIRitCaldVNW1vL2hvMW1lQVNMWUlhTnFwM2FkL2xyWW5p?=
 =?utf-8?B?Z2poNVNkY0o2cmFyby8wOVdNZXdXeHBzajJFVURZT0xGSUNVODJTNGJwYlBz?=
 =?utf-8?B?bmRmUW5vL3dzemVsSWMwOXl5S0lqRzFaUW16SlBaSVV0Ukl3S2hVRXBzL09T?=
 =?utf-8?B?SkZIUm5uckwvSjRQSzA4eWdkbXZBcFhGbjVrM2VrREd0aE05OWRZblEvOTFN?=
 =?utf-8?Q?+8A0LYrPMFqtpzitoa21yF4+P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a084710-51af-4e36-6ad4-08ddb30032d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 09:19:19.0281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vYirYpNyACW6lO+hroXqgdYJVUqfpqDwEO1ttpBQDMbhktjo92zQJWQriFtrg0pCl+9mzCB/URqvQEN0y0k0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBuZXQvaWF2ZjogZml4IFZMQU4gb2ZmbG9hZCBzdHJp
cCBmbGFnDQo+IA0KPiBIacKgQ2lhcmENCj4gVGhhbmtzIGZvciB5b3VyIGVmZm9ydCBpbiByZXBy
b2R1Y2luZyB0aGUgaXNzdWUgYW5kIGNvbmZpcm1pbmcgdGhhdCB0aGUgcGF0Y2gNCj4gd29ya3Mu
wqBIb3dldmVyLCBJIGhhdmUgdGFrZW4gY2FyZSBvZiB0aGUgaW5kZW50YXRpb24gaW4gdGhlIGNv
bW1pdCBtZXNzYWdlDQo+IGFuZCBzZW50IG91dCBhIHYyIHBhdGNoLsKgQXBwcmVjaWF0ZSB5b3Vy
IHJldmlld8KgY29tbWVudHMuDQo+IA0KPiA+Pj5QZXJoYXBzIHdlIHNob3VsZCBtYWtlIHRoZSBk
aXNhYmxpbmcgdW5jb25kaXRpb25hbCBvciBldmVuIGJldHRlciBtYWtlIGl0DQo+IGRlcGVuZCBv
biBpZiB0aGUgc3RyaXBwaW5nIHdhcyBlbmFibGVkIGFsdGhvdWdoIEknbSBub3Qgc3VyZSBpZiB0
aGVyZSdzIGEgd2F5DQo+IHRvIGNoZWNrIGZvciB0aGlzLg0KPiANCj4gSSB1bmRlcnN0YW5kIGFu
ZCBhZ3JlZSB3aXRoIHlvdXIgcG9pbnQgb2YgZGlzYWJsaW5nIHZsYW5fc3RyaXAgYWZ0ZXIgY2hl
Y2tpbmcgaWYNCj4gdGhlIHN0cmlwcGluZyBpcyBlbmFibGVkLiBCdXQgbGlrZSB5b3UgbWVudGlv
bmVkLCBJJ20gYWxzbyBub3Qgc3VyZSBpZiB0aGVyZSBpcw0KPiBhbnkgd2F5IHRvIGtub3cgdGhh
dC4NCj4gDQo+IEhvd2V2ZXIsIEkgdGhpbmssIHRoZSBjdXJyZW50IGNoZWNrIGFsc28gZG9lcyBh
IGdvb2Qgam9iIGJ5IGNoZWNraW5nIHRoZQ0KPiBkZXZfY29uZiBwYXJhbWV0ZXIgYWdhaW5zdMKg
UlRFX0VUSF9SWF9PRkZMT0FEX1ZMQU5fU1RSSVAgYW5kIHJlLQ0KPiBkaXNhYmxlcyB0aGUgdmxh
bl9zdHJpcCBhZnRlciBldmVyeSB2bGFuX2FkZCBvcGVyYXRpb24uDQoNClRoYW5rcyBmb3IgdGhl
IHYyLg0KSSB0aGluayB0aGlzIGFwcHJvYWNoIGlzIGZpbmUgZm9yIG5vdywgaXQgbWF0Y2hlcyB3
aGF0IHdhcyBhbHJlYWR5IGluIHBsYWNlIGZvciBWSVJUQ0hOTF9WRl9PRkZMT0FEX1ZMQU4oVjEp
Lg0KQSBmdXR1cmUgaW1wcm92ZW1lbnQgd291bGQgYmUgdG8gZmluZCBhIHdheSB0byBkZXRlcm1p
bmUgaWYgdGhlIHN0cmlwcGluZyB3YXMgcmUtZW5hYmxlZCBhbmQgb25seSBhdHRlbXB0IHRvIGRp
c2FibGUgaW4gdGhhdCBjYXNlLg0KDQo+IA0KPiANCj4gVGhhbmtzDQo+IEFtaXlhDQo+IA0KPiAN
Cj4gT24gTW9uLCAyMyBKdW4gMjAyNSBhdCAyMzo0MSwgQW1peWEgUmFuamFuIE1vaGFrdWQNCj4g
PG1haWx0bzphbWl5YXJhbmphbi5tb2hha3VkQGdtYWlsLmNvbT4gd3JvdGU6DQo+IEZvciBpNDBl
IGtlcm5lbCBkcml2ZXJzIHdoaWNoIHN1cHBvcnQgZWl0aGVyIHZsYW4odjEpIG9yIHZsYW4odjIp
DQo+IFZJUlRDSE5MIE9QLGl0IHdpbGwgc2V0IHN0cmlwIG9uIHdoZW4gc2V0dGluZyBmaWx0ZXIg
b24uIEJ1dCBkcGRrDQo+IHNpZGUgd2lsbCBub3QgY2hhbmdlIHN0cmlwIGZsYWcuIFRvIGJlIGNv
bnNpc3RlbnQgd2l0aCBkcGRrIHNpZGUsDQo+IGV4cGxpY2l0bHkgZGlzYWJsZSBzdHJpcCBhZ2Fp
bi4NCj4gDQo+IEJ1Z3ppbGxhIElEOjE3MjUNCj4gQ2M6IG1haWx0bzpzdGFibGVAZHBkay5vcmcN
Cj4gDQo+IHYyOg0KPiAtIEZpeGVkIGluZGVudGF0aW9uIGluIGNvbW1pdCBtZXNzYWdlDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBBbWl5YSBSYW5qYW4gTW9oYWt1ZA0KPiA8bWFpbHRvOmFtaXlhcmFu
amFuLm1vaGFrdWRAZ21haWwuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL25ldC9pbnRlbC9pYXZm
L2lhdmZfZXRoZGV2LmMgfCA0OCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9ldGhkZXYuYw0KPiBiL2RyaXZl
cnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9ldGhkZXYuYw0KPiBpbmRleCBiM2RhY2JlZjg0Li5mOTNl
N2JmOWFlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfZXRoZGV2
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvaW50ZWwvaWF2Zi9pYXZmX2V0aGRldi5jDQo+IEBAIC0x
Mzc4LDEzICsxMzc4LDM4IEBAIGlhdmZfZGV2X2RlbF9tYWNfYWRkcihzdHJ1Y3QgcnRlX2V0aF9k
ZXYNCj4gKmRldiwgdWludDMyX3QgaW5kZXgpDQo+IMKgIMKgIMKgIMKgIHZmLT5tYWNfbnVtLS07
DQo+IMKgfQ0KPiANCj4gK3N0YXRpYyBpbnQNCj4gK2lhdmZfZGlzYWJsZV92bGFuX3N0cmlwX2V4
KHN0cnVjdCBydGVfZXRoX2RldiAqZGV2LCBpbnQgb24pDQo+ICt7DQo+ICvCoCDCoCDCoCDCoC8q
IEZvciBpNDBlIGtlcm5lbCBkcml2ZXJzIHdoaWNoIHN1cHBvcnRzIGJvdGggdmxhbih2MSAmIHYy
KSBWSVJUQ0hOTA0KPiBPUCwNCj4gK8KgIMKgIMKgIMKgICogaXQgd2lsbCBzZXQgc3RyaXAgb24g
d2hlbiBzZXR0aW5nIGZpbHRlciBvbiBidXQgZHBkayBzaWRlIHdpbGwgbm90DQo+ICvCoCDCoCDC
oCDCoCAqIGNoYW5nZSBzdHJpcCBmbGFnLiBUbyBiZSBjb25zaXN0ZW50IHdpdGggZHBkayBzaWRl
LCBleHBsaWNpdGx5IGRpc2FibGUNCj4gK8KgIMKgIMKgIMKgICogc3RyaXAgYWdhaW4uDQo+ICvC
oCDCoCDCoCDCoCAqDQo+ICvCoCDCoCDCoCDCoCAqLw0KPiArwqAgwqAgwqAgwqBzdHJ1Y3QgaWF2
Zl9hZGFwdGVyICphZGFwdGVyID0NCj4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgSUFWRl9ERVZf
UFJJVkFURV9UT19BREFQVEVSKGRldi0+ZGF0YS0+ZGV2X3ByaXZhdGUpOw0KPiArwqAgwqAgwqAg
wqBzdHJ1Y3QgcnRlX2V0aF9jb25mICpkZXZfY29uZiA9ICZkZXYtPmRhdGEtPmRldl9jb25mOw0K
PiArwqAgwqAgwqAgwqBpbnQgZXJyOw0KPiArDQo+ICvCoCDCoCDCoCDCoGlmIChhZGFwdGVyLT5o
dy5tYWMudHlwZSA9PSBJQVZGX01BQ19YTDcxMCB8fA0KPiArwqAgwqAgwqAgwqAgwqAgwqBhZGFw
dGVyLT5ody5tYWMudHlwZSA9PSBJQVZGX01BQ19WRiB8fA0KPiArwqAgwqAgwqAgwqAgwqAgwqBh
ZGFwdGVyLT5ody5tYWMudHlwZSA9PSBJQVZGX01BQ19YNzIyX1ZGKSB7DQo+ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChvbiAmJiAhKGRldl9jb25mLT5yeG1vZGUub2ZmbG9hZHMgJg0KPiBS
VEVfRVRIX1JYX09GRkxPQURfVkxBTl9TVFJJUCkpIHsNCj4gK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZXJyID0gaWF2Zl9kaXNhYmxlX3ZsYW5fc3RyaXAoYWRhcHRlcik7DQo+
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChlcnIpDQo+ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUlPOw0KPiAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9DQo+ICvCoCDCoCDCoCDCoH0NCj4gK8KgIMKgIMKgIMKg
cmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gwqBzdGF0aWMgaW50DQo+IMKgaWF2Zl9kZXZfdmxhbl9m
aWx0ZXJfc2V0KHN0cnVjdCBydGVfZXRoX2RldiAqZGV2LCB1aW50MTZfdCB2bGFuX2lkLCBpbnQg
b24pDQo+IMKgew0KPiDCoCDCoCDCoCDCoCBzdHJ1Y3QgaWF2Zl9hZGFwdGVyICphZGFwdGVyID0N
Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSUFWRl9ERVZfUFJJVkFURV9UT19BREFQVEVSKGRl
di0+ZGF0YS0+ZGV2X3ByaXZhdGUpOw0KPiDCoCDCoCDCoCDCoCBzdHJ1Y3QgaWF2Zl9pbmZvICp2
ZiA9IElBVkZfREVWX1BSSVZBVEVfVE9fVkYoYWRhcHRlcik7DQo+IC3CoCDCoCDCoCDCoHN0cnVj
dCBydGVfZXRoX2NvbmYgKmRldl9jb25mID0gJmRldi0+ZGF0YS0+ZGV2X2NvbmY7DQo+IMKgIMKg
IMKgIMKgIGludCBlcnI7DQo+IA0KPiDCoCDCoCDCoCDCoCBpZiAoYWRhcHRlci0+Y2xvc2VkKQ0K
PiBAQCAtMTM5NCw3ICsxNDE5LDggQEAgaWF2Zl9kZXZfdmxhbl9maWx0ZXJfc2V0KHN0cnVjdCBy
dGVfZXRoX2RldiAqZGV2LA0KPiB1aW50MTZfdCB2bGFuX2lkLCBpbnQgb24pDQo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGVyciA9IGlhdmZfYWRkX2RlbF92bGFuX3YyKGFkYXB0ZXIsIHZsYW5f
aWQsIG9uKTsNCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGVycikNCj4gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC1FSU87DQo+IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybiAwOw0KPiArDQo+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biBpYXZmX2Rpc2FibGVfdmxhbl9zdHJpcF9leChkZXYsIG9uKTsNCj4gwqAgwqAgwqAgwqAgfQ0K
PiANCj4gwqAgwqAgwqAgwqAgaWYgKCEodmYtPnZmX3Jlcy0+dmZfY2FwX2ZsYWdzICYgVklSVENI
TkxfVkZfT0ZGTE9BRF9WTEFOKSkNCj4gQEAgLTE0MDQsMjMgKzE0MzAsNyBAQCBpYXZmX2Rldl92
bGFuX2ZpbHRlcl9zZXQoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsDQo+IHVpbnQxNl90IHZsYW5f
aWQsIGludCBvbikNCj4gwqAgwqAgwqAgwqAgaWYgKGVycikNCj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcmV0dXJuIC1FSU87DQo+IA0KPiAtwqAgwqAgwqAgwqAvKiBGb3IgaTQwZSBrZXJuZWwg
ZHJpdmVyIHdoaWNoIG9ubHkgc3VwcG9ydHMgdmxhbih2MSkgVklSVENITkwgT1AsDQo+IC3CoCDC
oCDCoCDCoCAqIGl0IHdpbGwgc2V0IHN0cmlwIG9uIHdoZW4gc2V0dGluZyBmaWx0ZXIgb24gYnV0
IGRwZGsgc2lkZSB3aWxsIG5vdA0KPiAtwqAgwqAgwqAgwqAgKiBjaGFuZ2Ugc3RyaXAgZmxhZy4g
VG8gYmUgY29uc2lzdGVudCB3aXRoIGRwZGsgc2lkZSwgZGlzYWJsZSBzdHJpcA0KPiAtwqAgwqAg
wqAgwqAgKiBhZ2Fpbi4NCj4gLcKgIMKgIMKgIMKgICoNCj4gLcKgIMKgIMKgIMKgICogRm9yIGk0
MGUga2VybmVsIGRyaXZlciB3aGljaCBzdXBwb3J0cyB2bGFuIHYyLCBkcGRrIHdpbGwgaW52b2tl
IHZsYW4gdjINCj4gLcKgIMKgIMKgIMKgICogcmVsYXRlZCBmdW5jdGlvbiwgc28gaXQgd29uJ3Qg
Z28gdGhyb3VnaCBoZXJlLg0KPiAtwqAgwqAgwqAgwqAgKi8NCj4gLcKgIMKgIMKgIMKgaWYgKGFk
YXB0ZXItPmh3Lm1hYy50eXBlID09IElBVkZfTUFDX1hMNzEwIHx8DQo+IC3CoCDCoCDCoCDCoCDC
oCDCoGFkYXB0ZXItPmh3Lm1hYy50eXBlID09IElBVkZfTUFDX1g3MjJfVkYpIHsNCj4gLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKG9uICYmICEoZGV2X2NvbmYtPnJ4bW9kZS5vZmZsb2FkcyAm
DQo+IFJURV9FVEhfUlhfT0ZGTE9BRF9WTEFOX1NUUklQKSkgew0KPiAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBlcnIgPSBpYXZmX2Rpc2FibGVfdmxhbl9zdHJpcChhZGFwdGVy
KTsNCj4gLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGVycikNCj4gLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FSU87
DQo+IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0NCj4gLcKgIMKgIMKgIMKgfQ0KPiAtwqAgwqAg
wqAgwqByZXR1cm4gMDsNCj4gK8KgIMKgIMKgIMKgcmV0dXJuIGlhdmZfZGlzYWJsZV92bGFuX3N0
cmlwX2V4KGRldiwgb24pOw0KPiDCoH0NCj4gDQo+IMKgc3RhdGljIHZvaWQNCj4gLS0NCj4gMi4z
OS41IChBcHBsZSBHaXQtMTU0KQ0K
