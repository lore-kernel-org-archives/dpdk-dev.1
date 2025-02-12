Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECDCC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 05:08:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73654402A7;
	Wed, 12 Feb 2025 06:08:38 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 92C7040269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 06:08:37 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BFW0ou012098;
 Tue, 11 Feb 2025 21:08:36 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44r990sjas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 21:08:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V11+fgfFRPnCp3/Y9WgdKwNlOShkSjHqyYp/MCUJ2IGqk0Zl1kvPzbldmzqa/3Yx6ZxUp6IzILZ7e/TEQB3wndA3nrgnAD+UOldMFk+j5poy3Rgrq6lwUwg0MHQciPp0XTFFPKcfGeIb0n/73j79MdSJlZvf+kEEFIMb6Dif4mv5xpOROBVf/FmckFKhLzrdXxBX1l5p4hjOv/tecrPH2xSdpzC8Tyzv/mhfSHb4Krvn1j8CKVmJ4pPXa/nc11FOAjHUUIAmhfOMB+Ikh+NxLKGejGjF7ePJs/3gpNWFHT9yBEgrwbUvClszhTFFZai+mc4+itUk3ViytiYuYdlhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2qZ3mBuBMMGsnjt712M4t1OeST0VH1bGF/k1JT7dAM=;
 b=OXzwV7y43h/Vl5MfG2a9nHq41jQCjKTY0NSpXsrJBgGlczNATqiVQHEqymXn9/7gm9dHMRcuFj+3FWwZQ746Bcop0QozA6fbMFVyFLizYdHSq+ZDaQRCmzokqDOCQzB9ynHEKkiWUBpYE18S1DsqEn6IIDS86ydUhGPjE+4ju9+g0lEBqUi2scSiA3pGa0HmJm7HAykfaa2EK69x2gHSOeCQ+y1AjxQF/j6adP+m0mQB7g5dVafZ2N3QFD/7huq/LAjl6l6O/g1ymPskf3ZuGyqZctgiyQQSs/eQ18bb9hcnu6yt620drGlNKEZIKNiSp5G2Ddz3hK5UZTcWPVDCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2qZ3mBuBMMGsnjt712M4t1OeST0VH1bGF/k1JT7dAM=;
 b=TjvlgAGHssTpj7w8J0wiQgoVeqNSFaeJOKbXUu37odJSWQ7HA0ZEum8laAqEoxKbqfCohz0nE6uPN1fEH3oSOvMXb4joUWcmc6LALcIQy5gd8NiljXxfA/Ir/837gPrji4sm1/m09LBZqgRuZu0Kog9F5QO46isZzHl1ieCglts=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by DM8PR18MB4487.namprd18.prod.outlook.com (2603:10b6:8:37::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Wed, 12 Feb 2025 05:08:10 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%6]) with mapi id 15.20.8422.021; Wed, 12 Feb 2025
 05:08:10 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v3 2/6] trace: support dereferencing arguments
Thread-Topic: [EXTERNAL] [PATCH v3 2/6] trace: support dereferencing arguments
Thread-Index: AQHbe+N+1RrkIkA4JkajwQI8zdBQhLNBydUggAAUCoCAAT9+IA==
Date: Wed, 12 Feb 2025 05:08:10 +0000
Message-ID: <CO6PR18MB38603D365DF10F15AEE31CA8B4FC2@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
 <20250210174424.3364021-3-david.marchand@redhat.com>
 <CO6PR18MB3860449F9DE83AF498DF2788B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
 <CAJFAV8xLJ_0v8S-OGoJGYPmxUR3yZ7SGEbok9SSOqv5g1t9o1w@mail.gmail.com>
In-Reply-To: <CAJFAV8xLJ_0v8S-OGoJGYPmxUR3yZ7SGEbok9SSOqv5g1t9o1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|DM8PR18MB4487:EE_
x-ms-office365-filtering-correlation-id: 4563aff8-7003-4156-8890-08dd4b233ebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MW5FcUpERzhCYmxlSzN1Q2FlV21jSVY0RGtXZFBDRzVOaWZjSTJEd1BKZy9i?=
 =?utf-8?B?YS9MUDd0em5HaDFZbURSTU5ha1AybGQybW5LMGN1QjBJT3o0b1JUc0VJYU8z?=
 =?utf-8?B?ZGRNR1BPSTVsdE9DQk1TT3FkUHdwUmsyaWp3MUhPeE9GMUhFOHJxMFBOai9v?=
 =?utf-8?B?QnpNYjJLenlxNU9veCtpTWhlQlRQRnVxZDllZnk5ZDA0QmpIbm9vV3B1RWgw?=
 =?utf-8?B?Sm9mSTBTVWx4alFQbnMrc0twSGNPdUJwVm5HS1B0QVZ6ZDhya0FZZmVYUk1o?=
 =?utf-8?B?MlFKbjd4QmpVMGtmMlcwWkZHdjBGZXE3cHVXRE5HTlVETm8zZy92d0FUOVpR?=
 =?utf-8?B?dUJiRzV6emxDRHp5bmp2OU9WT0NhbUVGQThNUzh3a1VwZTdxMzF1ZmRtVHVO?=
 =?utf-8?B?aTAzRnJlOVh1cC81Q2o3YnVFTlJUaHVUTHVJa29YRUwvRE9JUHBrVXZoUmU2?=
 =?utf-8?B?c0hFQnFCTFhpMm1IeG5xRDVsZTM3cmdFdUtXRmwzZTFPTGJMNVV3cG9XdXZS?=
 =?utf-8?B?YlBEQUVnTlBBcmdlYXV1UngrUitiZ3dGVmVZQ1BQenZKSk50MHFZOGl1cDFY?=
 =?utf-8?B?eWdETGw0QjJDWTJtYTRpRlNMK1BQNVpVRjN3Yi84cFhwdUpCL215Q29kazgv?=
 =?utf-8?B?L24wT2plV1A2R0RqUGh6TFZETmxyVUcvQ3ZabXpyNm9OSTQ3YkxCOGlBNXp2?=
 =?utf-8?B?WXllbEpOMmZndlptWjZzOGR6K2t2TkFBT295RkE0Z3ZkRStLZXA2QnRKZnND?=
 =?utf-8?B?anR1dXM1U1lTdzlOUVd0R043YlNVRVo4OTg3bHdHZlA3a0lnWmt1dy9MV0g0?=
 =?utf-8?B?cEI4KytRQW9uVTNZUnNoOUwwMStEdmd0RUNSbElPaEZjTTFXVTdYQ3BsMEZN?=
 =?utf-8?B?eXErc2J4QjNrRDlXMWU3TjFzYWM2WEJVNHJsV1c0K29zQTZUT0hibEQyUW1H?=
 =?utf-8?B?aC9IZ0xCZ1F1bUd5YjVVaVg0UVZVVi81MXkySHVyRUljWFIxcGZWaVVyY2pt?=
 =?utf-8?B?MjhWR2l5cmd1RENXYmI0amx5QlpVVDZ1TzQxSEkxS0E1eFdrK1JvOGZjZGZ6?=
 =?utf-8?B?MFE5VUxycjd6N1c4RC9Sa1YzbzFuOGk4KzBvbnNJeGF3VmR4ZmxsbDZxV21a?=
 =?utf-8?B?K3RsL0FLR09ORDZUeVlCLzFFSUdibnIrR29DeGtzT1BudnM0dlRacGd6VUx2?=
 =?utf-8?B?NWJtMm5meHcrRzJoOU1yc2EvN3ZZSm5FM09BazF0TkxQdVpIeFlwTzVEeGZU?=
 =?utf-8?B?cUlIc01SSk9vSWFsUUpzV01heGR4ci8yaTFSR0RpK0MzYTZIV3hkU3ZjVVhm?=
 =?utf-8?B?WllRQk5udThiYldHeU1FSUtGUU9zWklRWUFVMmZqa0hFNzdwS21OZTZxQmYz?=
 =?utf-8?B?NStBSHZPbUhFSmFFaVh5alVMVmpmRGJjNHhxdkNoejVjN0RSUWFpUE82SXV6?=
 =?utf-8?B?RzVNY05aNkRmY2laWDZoQXREOHAvSUEzbEtDR2RSWXhEeTYralU2ZzNGUUF0?=
 =?utf-8?B?RGVUaThTdm8vQ1RjVENvZnJQbUNuVmd2Q3RoWEJoTi9aR3crakxRYlNBWmdk?=
 =?utf-8?B?bXpyU2hIVVcyaFZyN0xEeVpac3JhRGdhUUUrcUlydzVjZWgvdGV2SitsMTdi?=
 =?utf-8?B?WVZLWjFnZFdML0ZURXZTUG5RczJDWlZGQkNoRjRIa1N4YUk1a3FVOHE2UCsw?=
 =?utf-8?B?Z0NpR0hMUUlDRzdoZ1ZxMEJxYStOemlBV2lJTkNSYU14dWJwRHExdTNWcUNK?=
 =?utf-8?B?SmVoMzFkK2VuK1FmaWR0VlNDdG5aaEdkUjJmZE5YMGxqckdLV0lkSnZUOVdE?=
 =?utf-8?B?MllUNWMrVFlzY3N1LzNNandkbTFUV1dBRnpxcU1XZStwTEZyUGo0a3kzRFZO?=
 =?utf-8?B?RCtwVloxNHZROHVxTGt6U3R3eFREQWJsdHRLTmsySTFrWnFiSWI5by9KMkZR?=
 =?utf-8?Q?Gxwo7L1z8LCIEE8VHYIG1PwaDDcB1zRF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0s5a29HYXYrUWxsUnlJMDU0Vi9OZFpUbmtYamgvK28rdEgyUWtjRFlEbWRn?=
 =?utf-8?B?VThsdTd1OHc0N2dxNkxwZlVCcGZjb0lTek9tcHEyRHdVbWc4bVduNTkzS1Fa?=
 =?utf-8?B?ekZkSk5pVnRVMnBWSVVsMjB2QllId3Y4bnhyMUR6blo3bW4wSXczSzZvdTFs?=
 =?utf-8?B?ZkVNc0w5Z28yMDNJUVIrQS96MjkxZ0dOTTg4b0lSa1MzV2k3TXJINGlvcXVn?=
 =?utf-8?B?M09oeGxyTllSVzd2T3VBa2Ezb0krZXlGSnliNjQyRmJva0Y4bUhJZTZzVFZQ?=
 =?utf-8?B?ZFV1K2RXWXI0Q1ZKYmtlT1BPa0hLaXlGVnlqWldxSDNuL0p1eWFXc3FvNC9u?=
 =?utf-8?B?UkdUKzRQY1lCa29YUTZjZThrdFNzTjkyK1hZZ25oM3pOYVhrc0FrckMydGFh?=
 =?utf-8?B?YVNuSkZ5b2NFQ3V5a2dCajJwdXpJNHNWZWhWNWlhY1N1Y1luWXl4OE5rUy9M?=
 =?utf-8?B?LzZIa240VDZwSjVVakFqQ25ybDIxMVVpVklWMVh3Q0NmWFhnamtOZ1c0MXFh?=
 =?utf-8?B?eTZUU2FDSm00bHV0MFY0ZDdtVGo1V014dVRSS0xaUnpjOCtFVlNnUWM5Y2VX?=
 =?utf-8?B?VTNRalJOckxsZm56WGNXOVROUkdSVWpZempjd2FUV2pMYUc4V1hsb2E1NDRx?=
 =?utf-8?B?KytlZGZKSkFKLzdVTHI4ejJZSk5vRVgrQk5sdWIvWllnUU5GT1JxYXczTUEz?=
 =?utf-8?B?WWJGRWJWV0drbWhGNkl1dk9saEFGMUpyTHlwbC9HRFdXdUdmVGM1bjVjNnVD?=
 =?utf-8?B?d3huaEt5bEEyZHZ2eWVBY2xMdDFMYWpvYXM4Z2FBcGxLM0RJUVNtb2I5TlNi?=
 =?utf-8?B?MnhzNGIwYWtpRFhWYnkvN1N3aHM1YUxBelRJY2JHQVc1dmN0MmlYUHg2TkZK?=
 =?utf-8?B?b290WjBZenA0QldCVmUrRW5lSjVzcDQzY2UxOFM5b1E4NmQyZDNqMG9JVHJj?=
 =?utf-8?B?dWltbVlZT1pha2VXcnNSSldUaHdVTkhjU1Ara3U4K2J4S0dRV0V4eXYrbnJl?=
 =?utf-8?B?TUhQd0dVVG9qODFoNDFFQUZqUHFpbm9yU280Q2c5NlFQWjd4SEl4YlN4a2FH?=
 =?utf-8?B?cThSdUtCQlNSV2lRbzVUUXppeTl5RUh2cGpkakVreVRMZlFFcFdCUG1iVks2?=
 =?utf-8?B?Y2RtTjFKM0RWaEpYTXBoNXRIRWM2TnB3MmJrdFZQZysvOFNEdHM3dTdIOGVN?=
 =?utf-8?B?cFhyVUVHWHZFZk9NMzEzZEN6azlFcS9TSjh4K3BmRHVuYllVYnVSMU1pcmxv?=
 =?utf-8?B?MU5UOHdRbS9rQTRNOHhNblVQUEJ3eXFINXBGaWU4QUlpZDNkYnRwbHJ5Z21N?=
 =?utf-8?B?K09zOGFvRlBmNVhYYjhCZXo4K3VOVUlQaUtPS2d4bldmNHVaRUY5MnBOeVln?=
 =?utf-8?B?ME1uWTYxZ0twR2VlUlhVKzlHQm5YOTJZTitRSEh0Y25sNWd2UU1YMDlDbVpR?=
 =?utf-8?B?M3VJSjFZaXVpb3FIRkJrMzBLcEk1MWxOZXZKSWc2VkJud2ZqMUdSakZwbFJX?=
 =?utf-8?B?RE1sYnI3a3JkbjhqYXlURXdmMUNuQktDOUI1cDNJNXVBN2c4VVBjbnI4NXYx?=
 =?utf-8?B?V2QxblFDTjQzS2pKTmU3eTlqRy9qeU9BczVBTFQ1T0JtMzRPU2YvU3B3MjFv?=
 =?utf-8?B?RlViLzMxWHo0MTdFMFltcHphS1FjR1NkM2hoOStzbGNOTkt2aG5xcE9JeXNF?=
 =?utf-8?B?YnRRb0Y3cVJGWEhWMFR5T0Frb1prS1ZxNUdJdzk5RllKZmRmUUQvVFJCaVMw?=
 =?utf-8?B?cjlONkJOLzB6RTVRb2E0YVNRSXpyM09mZncxdVZqZUdLUTU5aFZXNGRBazU2?=
 =?utf-8?B?V3MrQTlSRlRKOGpsOVdYVEc0cUYxVXphY3ZCNnBUQ1lOWUdkUHdlcHU4Nllm?=
 =?utf-8?B?SXFKUkl0cWVzcE9iWi9KUW1ydXBjZU5ldmZyWlREbmxXY1hpNlFXQjd2c0NL?=
 =?utf-8?B?ZFQ2cVVhYks5S1IxWk10YXdSdU8rVEZEVWF4QkVUWHFCN0R0RThWc1FFZW14?=
 =?utf-8?B?VVh0MDc5VDFzNk11SWlpRDNVbjV6M3ZkVDhKcjJTdG92djVvQXFBNkgvYmYv?=
 =?utf-8?B?dm9oTS94eDlDNXF2Y3J5TWV5Z2czSzcrcjQvYkp6L0NCQlF6Qzgxb1dwejZ2?=
 =?utf-8?B?TVBLRnFPa1lQU3krUjVTOXJTdDV5SnFKRllOZG9aTjZLU0lYRUE5OWkzOHNq?=
 =?utf-8?Q?Ndmustng3JlsI01VXQFup3c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4563aff8-7003-4156-8890-08dd4b233ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 05:08:10.4556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Sourt0WtB/qND7UpHBOTnuFgXYhy9d/Y3zQSGlGfx43XzSN+ZAUJMSa08fBIj3SDKs2Y9ir2vo6gUuxhnectg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4487
X-Proofpoint-ORIG-GUID: CNaAtg76u9t3-vxZF-B2VO0zI8YhvV9w
X-Proofpoint-GUID: CNaAtg76u9t3-vxZF-B2VO0zI8YhvV9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_01,2025-02-11_01,2024-11-22_01
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

PiBPbiBUdWUsIEZlYiAxMSwgMjAyNSBhdCA5OjQ04oCvQU0gU3VuaWwgS3VtYXIgS29yaSA8c2tv
cmlAbWFydmVsbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbGliL2Vh
bC9jb21tb24vZWFsX2NvbW1vbl90cmFjZV9jdGYuYw0KPiA+ID4gYi9saWIvZWFsL2NvbW1vbi9l
YWxfY29tbW9uX3RyYWNlX2N0Zi5jDQo+ID4gPiBpbmRleCAwNGM0ZjcxNDYyLi4zZTQyMjhlZTdm
IDEwMDY0NA0KPiA+ID4gLS0tIGEvbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl90cmFjZV9jdGYu
Yw0KPiA+ID4gKysrIGIvbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl90cmFjZV9jdGYuYw0KPiA+
ID4gQEAgLTM3Myw2ICszNzMsMTEgQEAgcnRlX3RyYWNlX21ldGFkYXRhX2R1bXAoRklMRSAqZikN
Cj4gPiA+DQo+ID4gPiAgY2hhciAqdHJhY2VfbWV0YWRhdGFfZml4dXBfZmllbGQoY29uc3QgY2hh
ciAqZmllbGQpICB7DQo+ID4gPiArICAgICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHRva2Vu
c1tdID0gew0KPiA+ID4gKyAgICAgICAgICAgICAiLiIsDQo+ID4gPiArICAgICAgICAgICAgICIt
PiIsDQo+ID4gPiArICAgICAgICAgICAgICIqIiwNCj4gPiA+ICsgICAgIH07DQo+ID4gQXMgdGhp
cyBwYXRjaCBpcyBpbnRlbmRlZCB0byBzdXBwb3J0IGRlcmVmZXJlbmNpbmcgb3BlcmF0aW9uIGJ1
dCBhcyBhIHNpZGUNCj4gZWZmZWN0IGl0IGFwcGxpZXMgdG8gbXVsdGlwbGljYXRpb24gb3BlcmF0
b3IgdG9vLg0KPiANCj4gU3VwcG9ydCBmb3IgbXVsdGlwbGljYXRpb24gaGVscHMgd2l0aCB0aGUg
bmV4dCBwYXRjaCB0b28sIHdoZW4gcGFzc2luZyBhbg0KPiBhcnJheSBzaXplIGFzIGEgYmxvYiBs
ZW5ndGguDQo+IA0KPiA+IEhlbmNlIGZvciBBICogQiwgZmllbGQgaXMgZ2VuZXJhdGVkIGxpa2Ug
QV9fX0IgKG9uZSBleHRyYSB1bmRlcnNjb3JlKS4gU28NCj4gSU1PLCBtdWx0aXBsaWNhdGlvbiBz
dHJpbmcgc2hvdWxkbid0IGJlIHVzZWQuDQo+IA0KPiBJIGFtIG5vdCBmb2xsb3dpbmcgdGhlIGNv
bnNlcXVlbmNlLi4gd2h5IHNob3VsZCBpdCBiZSBwcmV2ZW50ZWQ/DQpBcyBzdWNoIHRoZXJlIGlz
IG5vIGNvbnNlcXVlbmNlIG9uIGZ1bmN0aW9uYWxpdHkuIEl0J3MganVzdCBhYm91dCByZWFkYWJp
bGl0eS4NCkZvciBleGFtcGxlLCBudW1fZW50cmllcyAqIHNpemUgd2lsbCByZXN1bHQgaW4gbnVt
X2VudHJpZXNfX19zaXplIHdoaWNoIGFjdHVhbGx5DQpub3QgcmVwcmVzZW50aW5nIHRoYXQgdGhp
cyBpcyB1c2VkIHRvIHNpemUuIEluc3RlYWQgdG90X3NpemUgPSBudW1fZW50cmllcyAqIHNpemUg
YW5kDQp0aGVuIHVzaW5nIHRvdF9zaXplIGNsZWFybHkgc3BlY2lmaWVzIHRoYXQgaXQgaXMgdGhl
IHRvdGFsIHNpemUgb2YgYXJyYXkuIA0KPiANCj4gDQo+IC0tDQo+IERhdmlkIE1hcmNoYW5kDQoN
Cg==
