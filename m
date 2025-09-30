Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D936CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 15:21:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 255F6406B6;
	Tue, 30 Sep 2025 17:21:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 21AB340151;
 Tue, 30 Sep 2025 17:21:25 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U7ruFt005941;
 Tue, 30 Sep 2025 08:21:24 -0700
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020129.outbound.protection.outlook.com [52.101.56.129])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49gb6r16em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 08:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hST8itbV/tBfv1DtclUaUt4RR4o4NWGObeGOdnjZEaBOtLIXoBTJ82MHawfrX86k+cEVfaT1ByU9sx7I5qyPUaTvaDgkGxXTZq/fFfjFZO2Rp+49tXGNI8TqeHsox3HeK1nLG+TPj3+U6QEosYP6DZCCx89UPfbZtHS5MT6XsatXNGOxkNGwimWDJVMGroGmrIy+JzH6EaHRGhYyg0Elg6PIVxesYrOG2vS/E5dRIiaSKRp7kc5x3ZAvJa21YPJyspPnPrZundNIIjqotaCe9/0TPOTglXc9A0sGPIqmvlWacQxvPyqEuQrHVEa71YC1ZA+/h1EnbtNphqhJpOHEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXWJ9ryZ+7nPAGRkxvCe9yvxYKUzo8bqAPYus/LfoOg=;
 b=fTq9T/j2ORMfU5tD1HJyZ8uGdtL1CNUcPtQDmVlpRpRfywlHf2CLeHuie47rrdJ/hNRmpH0ZgM+S7hj29odXMLFS5wwmrSsuyWbTVHKQXW+qiXm4jHCYGi+kWZIRW1Njlg2zaVnoeR5AaHeSK9vOP9PlsgrkTnmPbkAtH8NwS2n/pRuhVatKTY2pDc1CZw3KuaIEEJMcLkTAqPF+suUrMk2YqGGL5oFST7Un7y3xq0/6tH2wLhc62qvOE7Z68/K04zE0fNhLoAkfehw2vnB3RrfYN6Zk+3wQI9PnCQWqHIzknOo5POoEHfpFffGMNr9T4cXOkRPIxqKFspgeoji11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXWJ9ryZ+7nPAGRkxvCe9yvxYKUzo8bqAPYus/LfoOg=;
 b=O7RcTNvdt3G9yZfd7nMGwmAI4BbTF9N13MCMAS/isBJQtVHeqOk2e2ypeYPHo9Xl577uGKHK+Sz1ONz03kkJQEbgG9LYfwXMTegTJOBnLhgQtvdWn/OgFpk1dyfbheLEhOQSyQZPqdOkIj3DZvQNNKnXmdDI4p3SJ0Io2PKJwts=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BY1PR18MB5924.namprd18.prod.outlook.com (2603:10b6:a03:4b8::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Tue, 30 Sep 2025 15:21:21 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 15:21:21 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [PATCH] crypto/qat: fix source buffer alignment
Thread-Topic: [PATCH] crypto/qat: fix source buffer alignment
Thread-Index: AQHcCqQTCIs7VTe8wECRjY12tJ+V07SsJmag
Date: Tue, 30 Sep 2025 15:21:21 +0000
Message-ID: <CO6PR18MB44845FC90C81E50B253BC0B1D81AA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250806144832.3507786-1-radu.nicolau@intel.com>
 <DS0PR11MB745868D172453A9F1AA4DE0B8128A@DS0PR11MB7458.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB745868D172453A9F1AA4DE0B8128A@DS0PR11MB7458.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BY1PR18MB5924:EE_
x-ms-office365-filtering-correlation-id: 57a6c489-506b-4444-5728-08de003502a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TGdTRjhEZ0pXNU51SExXTmh6WFVJczRlQkVMa0RGd01OUk9Bd25seFVJTSt0?=
 =?utf-8?B?L2U3SXZXRmVBeXdhVTQyeUhOZjZxdUlvdkF6ZUlsTm1NQUNQTy80WHE4c0pm?=
 =?utf-8?B?bzFmZE1ISFczTjBjQitLaGM5M1A5cFc5ZnJnWWJvdHAyVjdtQVNaWlE1bzZ4?=
 =?utf-8?B?RmhFb3pvRG9wclpCUmYyQWd5WFpNNkc5UjRBY3FtWDZXNFp3SEVWVHp5UEVu?=
 =?utf-8?B?UklGeXhxaXFkUU5LTTI5WVhUeU9ocGlxb09UT1E1M0FMQXZOMTh2Mm12VnBM?=
 =?utf-8?B?UWVzNk4za2lOVFZRZ0RaQVZ3MHdsOGUraVNkQm1ma3Yzekw1THNTZW4wZjZM?=
 =?utf-8?B?QUdBazBEQVhvUThnL0M0eUNIQ0N4eFpJODB5dGpBZHFYUklTWXhzQk5jbmls?=
 =?utf-8?B?clBKWHJWV1B5eFVXSEpXaW5HUldZM01pbk1KdjErVHAzQmhXejYzTTZDQXow?=
 =?utf-8?B?b0JMWm4veFk3Q1d3Z2VZNUVrYStFaldsS1kzaWRUZTBqV2RVWEFzUTJGYjND?=
 =?utf-8?B?cW5vUXl2TkdrcVVWUTMwVUUrQlZjaEsxQjdEUWNmeldFNmd4aTVVcUxNZGM2?=
 =?utf-8?B?UUNDdEhIdUwzRXMzeEk5WjYwaEg5WnVhQ2dMN2QweW1PRXJ3b0JtZTA5cTJT?=
 =?utf-8?B?S09aeXF0ekFzRGQvaGFhaXNtWUlsMzdEY3JnRnJSNUJFMFF6elc1dDdKZ1pN?=
 =?utf-8?B?bDZuVlhUMlZiN0t1a243WXMzb3RzeFlyb0lWeE05ZWsrdnFPNm5HanFlY2s1?=
 =?utf-8?B?NTRGbkJJN2k4NThDRndMYlVtQmwvTjN5WXMrbE1zc3Nkczc5L251WFdjK3B4?=
 =?utf-8?B?Rmg2cVJkWEZzM0FiRGY5NGhvY2JpcXBjd01kMDBpc2dzcDY3YW85UElNRS84?=
 =?utf-8?B?ZSszNVFTVGQrTDRQbW1lUXdvRHR1eDBNNmFaUFhKZW5ZNkZKaWF6R3JObHhh?=
 =?utf-8?B?WWtoQVJSNzgxZXBoQ253Ri9pRjR4OTYyNHpGd3JUdU9qWU1TbVM2ZlFPazh0?=
 =?utf-8?B?eXYvS2Z1Q2I4RitLNTlKczk5OU4vb0lmcTF0eGZQbGhhbW9SWnB0aERjajh6?=
 =?utf-8?B?NmpQVElWeHUxelFuSDBVeFRFQlNXc1JHY3BQeVVHN0w2aWRmVnRhK3lmemZk?=
 =?utf-8?B?cVlIcDVhUlNiVTRjdjdsNzJuKzhUWE9GTmlUTWRzRVNrd2FkMm0yUkc0Si8z?=
 =?utf-8?B?dEhJUjJNNFBFakFuc2dCc0dNYXNUVmY2YU1TYmk4QlFRZmZzVDc2NGxyMTM5?=
 =?utf-8?B?aEdvTmVKRWhZcUR5d3R1cnJKT2Q5VDdyWjM1WFB6UFhqZ0NoUG1qcmt6MXZX?=
 =?utf-8?B?UGYwcnBORHpQUklTK29Sek9qWGJYaVdpTm12NW9OVjIxa2pDQldDSUgxMGlz?=
 =?utf-8?B?R3JFUlIzak5wdU9Ud2ZHTmhCUUJzRGFleGJaRE42TFYzVkM5TUMvN3Y4QnRs?=
 =?utf-8?B?NkswdU9xN1RSMVBZdEwvcjFSWUpsRE9rZVJJVjh3UW9MeVVJaVFIekw4K0ls?=
 =?utf-8?B?SlZSUEZiTC9QQ3VzK0RYZ1V0WWhHbklaU1liaHE2NURVcGVWTnRtZFNoR2VF?=
 =?utf-8?B?OW9FL0UxNVUrV0QxWjdNZHVONU1pdnlmbkZrOXpsVUdNcUx6cEROTHI3cEdi?=
 =?utf-8?B?S2hSbFF2U3oreWlRTS9BQUI3VExPN2c3Mm9yTWZuNWJmQUFNY21pSDlDNE8v?=
 =?utf-8?B?UmphdGt4Nk9MNmZnVjRudXFkOXBuWGVielgraVBHZ0VYeXJQZjczdzZ6L1Bo?=
 =?utf-8?B?UC9PMGJxUEducXJ4UU5oOHBoRmhORExoekFXYmxYekhyMWFTaHBkSVV6ZUth?=
 =?utf-8?B?UjhTNlR1d3gvQlEwbmNhWHM2RlhFT1FiL2ZZWWRyUzRKZkoxSG5JTkNpR0k5?=
 =?utf-8?B?UWtpM0E4ZXZrTEN4V1IwTERlbWp0WmJYQkN6anpGWXJxaXRiWnJ3UlRFSFQr?=
 =?utf-8?B?WkpPYUpJK25PQnc4R2dWWEZ4M3RUT0V4dzBkaTU5ekRTK1VoTFhaMU9KaFBL?=
 =?utf-8?B?dllNY2V5L2x3MWhvTVAwTVBjYkU4SldWSzRvZ3lYTW4wZHRYY3VYQnlWZVBp?=
 =?utf-8?Q?K3NbXc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3ZFeVFrR0ZZaFF4a25MdkphazFOcGVWdnhMMWE1Qmcwdzh2S2EzaURHYWt3?=
 =?utf-8?B?dEYwVlFjM2pQSEx0bHRHQm5RODZtZGZSc1A0Uml4a09pNk5yaXhRNTNhMExn?=
 =?utf-8?B?VmJ5SzdQZkVaNFVQWUwwTTZIOHNSNlZvY2pwNDVxSWkyMHJuK1VkODZFekZz?=
 =?utf-8?B?NlRVSStnMTdxKzVUOW5aN1piZzZad1FEeWhER1QrMWVTcUkxMFJJOEN6SDNl?=
 =?utf-8?B?UUN5QVM0RDlVd28zSmMrVnVCL05QRDUxUFFKNURGUkVVL25SZWJnM0JCaGRC?=
 =?utf-8?B?UEZBTUU5aHVxOXJYa1dheCtWL21YNytTMFZKWEMyQ21FOEZZaVliSTRSbStE?=
 =?utf-8?B?M01RWUNjL3RtQnlYV2lqTzJxREk5UC9lZGZQVWFEbUQ0MXlHT014d3JNQ1lR?=
 =?utf-8?B?Ui9YRUdTRVNyN0k4RTUvTjJ0YUJkQjJPUEdRc2hucVhBdFhTV2pnT1Fqa2pE?=
 =?utf-8?B?bTFDNGIzQUp3ZWVzMmczQnlldFJaeU9CZ3EwQ0Zrb3dFditSaXFIUWNYSzhl?=
 =?utf-8?B?aUdSVmVBSjFkYTJieENpZDJGUndQMmRlQUl3eUdOVU1MTVk3L1N3MWpiRWY5?=
 =?utf-8?B?VWxxdVlQdjM4R3JxQzl4K3NTV2ExOHkvdmJRV3AyNXE0YXlWSVlOSFI1M1BC?=
 =?utf-8?B?TGFLa0hDTXU4WWFCK2pKdFQzOFIwWmIreG9TcGN6RDJVdC9YVGZlb0VwSzdN?=
 =?utf-8?B?OElnNVMrRlFkSTBVK3JnS0xuK2E3bTRiNXZkQU5ZbmdaR0tQT2oxSzFNZCsw?=
 =?utf-8?B?ZFJJMVIrZXZOTmR1cFNHYWxRS0wwOS9zRUluZy83emdHT1Y0elZUYWs1cmlk?=
 =?utf-8?B?ZCtwbUhnQ0o1R0g1RkZObzIwZFVsQXREM0x5dldvMjVsSFlCVWZvT2ZSNFJy?=
 =?utf-8?B?M21jaldEdE9Cd1Njd3B2MzQzOVlZb0NwblVOMXNmNWd0a1pvZndleGdhVmUx?=
 =?utf-8?B?R01UVWRQMFJQbnp0T0NwRFdnU3V4ZVB5MjF4SE95c1RpNmxuQWI1N0hhQk9E?=
 =?utf-8?B?OVkzNHhIY3ZPbVNlQWRkaXdYdVNPRnZHVFFuZHV1bkdud1VEcXc4SXJ1RDhz?=
 =?utf-8?B?Si9mSVBIYkV4eHRGdkYxTkZDQWVKK2FBeGJVR3dqNjFoaWlEaDFRZUZMRXZk?=
 =?utf-8?B?Z2drWjN4dW5SLzh1c1NUQk54akM3a256dEtlTVczc0tsYUVXVW82aEM4d25Y?=
 =?utf-8?B?bXNSeGlSUW5QQ21DNzBvcS9YdFZsdmtzd09RbFc5WTVwSW5jcXQrOWw1bFlI?=
 =?utf-8?B?OGNBdGJuSEtnVzM2ZWdscXlEYWF1WU5qbUw3QVJsS20rTWxDN0dpRERkaTlE?=
 =?utf-8?B?ODFrRnJWMjhaR0J0SG5YMzFzVTRvU056SmdrMzkrMnNrVG1CRnpqT05tU0po?=
 =?utf-8?B?emM0YWFFdEZIS2M3VFRGR1hjcDA4UmIyTlpsYkdibkpJekVzSzhSZGthNHJk?=
 =?utf-8?B?WTNYYkpnVlY3RWFTT0t0djhnNTd6KzJtMzhPRmVWd2JyVzRBQkY4TGJMZW9B?=
 =?utf-8?B?czdadWpMeitKZFFjY3FjdVl3bUhWY3IwZEltMzMrYWdyZ1VrVDlHZkZDWFhV?=
 =?utf-8?B?M0RhRmtLcXI0dUJCQnA1NVdvRmd2Z21UQm13aHJFQm1temNMbWVSZGN0WUg4?=
 =?utf-8?B?SUFGeFFlNjNWNllSd3lDTTBPdWxWanEvYkhwMXpucUF6akJRRU5QRitCV3dp?=
 =?utf-8?B?aUs4QUp5WFdkeVV5b21WdkYwa2IzUnM0Sm5neTRFS1ZyN3h1OXJNOUFWNEF6?=
 =?utf-8?B?SitJOXM2MTZYckh2ck1KVXJhSkxsbkxZMzBhVS9OZW5jYlp2UVp4MjVlSXhC?=
 =?utf-8?B?U3NaeDhuS1p1Z3lVSWp0bTRPZCtZR0toaGhlejE5K1d1OFp4SWltcWJHSWZ0?=
 =?utf-8?B?MCtJV3ZVRHgzQUJyZllZSmljWWIvS1labkh4ZjYvVm9VS0kxMUNPMHBmWUFz?=
 =?utf-8?B?dE53c29KTWlPVW1JY1llc1lpUllWYTNqaTdIeW56enRGTVFienA1MzBVK2hs?=
 =?utf-8?B?bmdsNEpQK3pWTE1oRHkwa2FIb2E3N2FHNEJWYk9qOGovczF3elFaM1owME1R?=
 =?utf-8?B?cS9ERkw4TEVLL0RkQk15VXdialppNWd4TGRoU1pJR0g3VzFnT2pyRkJtOWZV?=
 =?utf-8?Q?igOc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a6c489-506b-4444-5728-08de003502a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 15:21:21.0310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlD9XXX2uyw1HDRzyvgQ4pnlP563wGYqb/PKbWvQ/D95WPItx6gZ9fW0CNou3H7VMunNNS1O7nf3ena9SXZKXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5924
X-Proofpoint-ORIG-GUID: uYHf9MutwnHO8drwKrGOqrs8Zql9iAoB
X-Proofpoint-GUID: uYHf9MutwnHO8drwKrGOqrs8Zql9iAoB
X-Authority-Analysis: v=2.4 cv=dN6rWeZb c=1 sm=1 tr=0 ts=68dbf574 cx=c_pps
 a=68tMKWLL5ro13Q+0o2tD5A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=QyXUC8HyAAAA:8 a=6cfKoZeCOb_vMps9ZOYA:9 a=QEXdDO2ut3YA:10 a=XqwKkIuMdFcA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDA3MCBTYWx0ZWRfX4ykWR3rj+bQv
 DCZXr/3EKpaeWXRWjmpQrjJ0rs6hmmRlMu3LHyHJlw5LoZ2FmRRvTzJGjwnX1yi29x3NSkdIX6h
 /673Zy4tgSFi6dG1a4G1DfHihG+mSOeWw0+oc1op+lsBEv5b00bJSABzQOkqeRj8e7mz32ByI6Y
 9TjCDjhObUdCIj1kFpJfMh3/sFSqzf/0SXOO1QJ0eB/73VQOHGCDcIMOtqMOp9TAflO1srPg2Sf
 JioVEmYyI2wcMlsjsPkcBl9PGIcw1B9xTPLO73RZOX6rPoc9s5e87Fm17JMSUU4PZ0vOOCBvrtM
 WhPYZzq7onKCa7U6HE7V24EHdpzfpmXdqRVeCBG/HfAvZV4V/7pgbROq5mzlnSwWvd1WNlWXLYt
 uBgmNcM+/tVxDAkYPxukjham8o7JCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
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

PiBBY2tlZC1ieTogS2FpIEppIDxrYWkuamlAaW50ZWwuY29tPg0KQXBwbGllZCB0byBkcGRrLW5l
eHQtY3J5cHRvDQpUaGFua3MuDQo=
