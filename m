Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143CCC369A2
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 05:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B4C640613;
	Thu, 10 Apr 2025 07:14:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9F27840288
 for <dev@dpdk.org>; Thu, 10 Apr 2025 07:14:09 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539Jx8xf001389;
 Wed, 9 Apr 2025 22:14:08 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45unnb1sf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 22:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3LTCxtBjRpVHc7GB8vX2VlIckw+GDOjktWrk9YtYyQZliWXOFjCNea1b8TUBTDtrAIesWGlhcBv7wXbO1LgOU2aCihrdvTKxTqI4IJgDrIQGPpnQDrqtKCBE07GKY3fNuckN5I+n9JwMuKTOq0zLmCPLjpqUY/EvEP8wbUbqCafIl4yk6xPkcL1Ih+SVGhLj2UnbSxERd8HTR3FJYZNhrOVtxEm3ldycPRQxzc3gEe4KzIsMHHIXh1muWHs4XOpHufqhxD5sLHWk8em4xX1p9z03yT9chIDqE1ebJCPUbDhlMcBFi+b0Ulwn2rkAUf8ch2bGLsRwWaGS4q+imQDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wyT4JWiNBPZlqWw5L9H+AIjupHVE7NpAcPrJwwtkVQ=;
 b=ZYc+NM5vthFSXepcp37imK5n4ktpEFaWG8zJwWPDYsleFXOUiXmkq7jJA3oqXzJh+MMAfW//L1QCWP0dpu0QueAcYtDdGsnkKv9d7l+9Y3UGTt5UrsqcMyEMxvtNUIaTsiux+5+90r2epc4NW6FmwRB7wL9+NmCoiAP/fhJi6yJF8dHNMX3y7BdSunyeBAhwZBN+IzdptSMIzcKRQe0qNaCyLdUS+jw/su1NL/Kp9S9kR1ZMR/L88t80KsMGJGm7R/IXCGjXpsZPaDmBnMug5H6+oKJy7/LkgwXQgm3xCq/kwK4rDhIKz8hcza1mRS/defPqa/H7LV0DEbDICmIkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wyT4JWiNBPZlqWw5L9H+AIjupHVE7NpAcPrJwwtkVQ=;
 b=KySPx6wlY/ZSl2XEUcvUmvAL9N0Oa1n1e1+Js40TgD/XrjQHUOe7bAJUjbDXpjr39b58yxxWJcfkf2/WOXYtCQEg/ZMU+tYhIwnaNgp5fint5cGVPuTvwOzxBJYWsVnwdmn3mLlh4w2XOiodvCwvphbt+FCDeJ+jxWyIpqr8agU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ0PR18MB3833.namprd18.prod.outlook.com (2603:10b6:a03:2cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 05:14:06 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 05:14:06 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Rajesh Mudimadugula [C]" <rmudimadugul@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>, "Rajesh Mudimadugula
 [C]" <rmudimadugul@marvell.com>
Subject: RE: [EXTERNAL] [PATCH 2/2] crypto/virtio: fix cipher data src length
Thread-Topic: [EXTERNAL] [PATCH 2/2] crypto/virtio: fix cipher data src length
Thread-Index: AQHbpJOZFIXxiTWww0m5lPmATsTcerOcZTTQ
Date: Thu, 10 Apr 2025 05:14:06 +0000
Message-ID: <CO6PR18MB4484D2E87067F8DED30C2D86D8B72@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250403122603.3508135-1-rmudimadugul@marvell.com>
In-Reply-To: <20250403122603.3508135-1-rmudimadugul@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ0PR18MB3833:EE_
x-ms-office365-filtering-correlation-id: 0fa6135d-e59f-43e0-3fd2-08dd77ee847c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEVNSnNxVXZMait2c24ybkl5MEhEdFJSV0ZMWEdINklrZi9VVHpJQkFjdFJI?=
 =?utf-8?B?ZUZydmFqeFB4QVV3bkZ1V0F4MVFpUXdyM3V4VjJFazZjS3Aralg3K1hIWFl4?=
 =?utf-8?B?ZEVHM1VDazFsMEVSQkRzdVVsbTQ5UVlnWFBLaUdmZloyakxEeCtPci9MM3hs?=
 =?utf-8?B?OTN4OXlIK0VQNEU3bjErZHpHaEFhOVJBOWRrT1RzVUZYN3o0L0VHUmthZjNH?=
 =?utf-8?B?ay9hYTlTeEdwQm1NYkVxOHNrL09wZXUwZDAxaGxER29odk5FcXdrSGNoSHE4?=
 =?utf-8?B?dzJtMEJ1c3hYbXMxVmNyMTQzS1YwanZZQWpROVROOWNTRUMyVGZrd0ZaMUpx?=
 =?utf-8?B?RUlvbzJXNC9MbVo1WEZTeExFazhSZGJSd0F6blV2UzFBMlBlK21hQWNVcjI0?=
 =?utf-8?B?NXBSYW9kZVJ6Y3FKZmpJY3VkZXZoVjBxSGR0b1ZPdjVxbW9BYWprWlpZeUk2?=
 =?utf-8?B?b2Z6K2VsOXU1elNXQlFlM3BKaytqanZqeHNvNy9keGU0ZjBHM09FQnBRZEVH?=
 =?utf-8?B?QXN6dnlWTVpFKzNqWkVQeVRLcFU4MEJDMlMzWnhuRTRBYkMxRGJHbk5PbHFn?=
 =?utf-8?B?TDcrbVFnLzVDOTFSdHJ2dUVlc3loZmhKNGRlNmhvZTlvSHphcXNoRGZjb0V1?=
 =?utf-8?B?eGR5K3YxZ1RSZ2lMTHpFdnlrdDc4OXQzZUlRd3JPeWNzSkkxeWw3Y3U3RERL?=
 =?utf-8?B?cUNVMEgxM2x1ellmbHpWVHJMYU02NlZoMXRKeXdvOCtXNjc5U1ZBdUlyRHgx?=
 =?utf-8?B?RlVFbGR3RzVFa3M2VWc3aGtQZmtER1g3Yzg0S0xWYWNWVFVyeEdLZjRYeHpK?=
 =?utf-8?B?L3JCTzk4Sy96cm10L3JWckJFdC9tcXgvU05VNnR2V210TmZHRGFvRStuNUxY?=
 =?utf-8?B?SHBpaHBDamRhbG5remJCTzNwdUh4TDJrZTVkY0tDTUUra3V4UUUzTEZvSldq?=
 =?utf-8?B?Y1lVdTUyT2pXTGZDaW5ETWdaZVk2WVdFNE5BU2F5RHRBWm4vN1dET3dtczdR?=
 =?utf-8?B?a2V3WDdDdjYzM2M2RVJpTkhwM3pudEgzVFlZWVdpU1Y5V3FYMnJ0VTFvbTVU?=
 =?utf-8?B?UGNwRk5XNVczTFQ3U1ZvSDZMY3VtOFJoQWNkeEc2T2VYUkJSS1FFMVpzWnov?=
 =?utf-8?B?dzF0bEpKZng5UURjTkZ6K1dnc1lnbmV3Q1BZa3N5bXJYbU9MbThEWWZKcUNK?=
 =?utf-8?B?RU41Nis1eVRBdkZoWXBFT3ZNaVY5bVV5VU54eWI1aFY3TjRXWHBicEUxM0pE?=
 =?utf-8?B?Y0loVW40OUp2ZGVXWk44ZHpxNlc2ZHRaV29TYVFRVFlkdE14am1kdGp0NDRy?=
 =?utf-8?B?L0hicGtnYk1zRjhuek9SV1Mya1JCNmtSbTdOOEpxNTZscFZmdm1KMUpFcVFj?=
 =?utf-8?B?NXE1bDBKVHFhUDhyYXJ2UVBrYUoyM252SkZTK0FtWUhQS3lNQTV6dUQ3R01o?=
 =?utf-8?B?UWlzRTN3bTNMSUR4NDVKVDI2WUVwbThKVDJhc0p3VWczbktSSEdzejA4Vkkz?=
 =?utf-8?B?elg2eDRkdFh5K0RGcW1qOE1iaGpOdkpKTVcyOXJIMlhJQytjdGVSN1dkaWU1?=
 =?utf-8?B?VXM4QlI2UjdkWUJETnd2NmVHRjUxM0JYRDBueXdhc0o1U243eDJwM2Vvblo1?=
 =?utf-8?B?enFpQ0pmU1VLZlhDdG1Yb0FWOTRkeXdzekxhTldXVXhpOU03N29PZVMyYVlX?=
 =?utf-8?B?TzFPVmgrR2E5SGloSkVXSnl1VFhrVWdDMkpDT2RocitqK1NDYmtyQWc1alZp?=
 =?utf-8?B?UERvNlcwQ0VBSTBuUXlkS0w3QTRzS0ZsMEhZK2kxdndUWVRlRXI4WlBkOTZW?=
 =?utf-8?B?K0xUa3VRQS9wUlRQVU4vR2t5QVlzaTMwbVNGb2JQOWNSenNPM3ZHVlBkOEFS?=
 =?utf-8?B?V0pXZXQwTFBpZ2paMzQ5bnBmSnA1WVgxUll1OGk0SDd2dEhQRU9GalV0VEc2?=
 =?utf-8?B?M2ZvZFU3Y3Fvdi84OVN1Tm5CUWVCRFZESm14bitGM2RPWUV3dEptdldTbnRB?=
 =?utf-8?B?S2ZGdENHNUNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHdwLzcvYndMb0lQNlJIOU0zRUs5RVhFUTBKd3FDVlB2alRpeEsxQWI1bWto?=
 =?utf-8?B?RTJOVjlEZHJtUGdTM3lzYkRxcjBLYmVTRUNZb0hPeGxzemNTRld5cmlGZ1M4?=
 =?utf-8?B?c3hXcVBLdkd6MlJGZmVibktNbEtRUDJUajd1RmIzc2RyU3BzVTNqTEdnR3do?=
 =?utf-8?B?eThTZlFjUGFNTk5ZcDhWS2lFanZudU95WUVHUTBmaWVIbFIrUnRJVFhDbTJT?=
 =?utf-8?B?UlNLb3hya3VWU0VZeHFDQy9Tbm9ia3ZOdEs4SThFa3UvU0RGdk9CLzhKOEFQ?=
 =?utf-8?B?OUVzaGZVb1Y0VmN5Zk43T3VIL0xocjRBNUpKVDhqaGZwZUZHY1ZpKzN3bXFt?=
 =?utf-8?B?UEpVMmJURHpxTEowU0drSi9OZm0xOVcxNTY1SGZRY25qVUY3ZnhBVVZ0d1Vn?=
 =?utf-8?B?SVFOU0VRdWpDYytSZ2IxeXEwbVJlWlJBdzNVODZMaHQrbGNWclJ6dURmMlMr?=
 =?utf-8?B?VlJBVWNUMGZ0c1FNcTNmMXNCTytuVzA5enlnOGZnbDl3TlAwL3dzTklrdDFh?=
 =?utf-8?B?Y29kYmpCOWw4NVg2V0YvNVVnNG0wWnF0RXFlRHBLdlkwWktXZmh6MlpSTU90?=
 =?utf-8?B?ampSRGVpRW1tUit2V1VYRFZwWHl3SG96UkFZbzNsUkFoekNpVDQ1dCtCRTRT?=
 =?utf-8?B?aEZZTVBndEkrb3Q3OWdoaURDOExCdm9tYWxWVTZSeGI4aXZIMzFsM043OXFO?=
 =?utf-8?B?MnlDREZjd0cvVXllbTFIZzlyTXhnQmdaTWpNTGRxRUhmSHlCVUd5V21Oa2po?=
 =?utf-8?B?VHY3R214c2dGMlgvajZpWXU2ODZtV2hydWphYUdsRWRyQkpJUUp0a0xXUWti?=
 =?utf-8?B?LzQvWmk3RUJGbjBHUEowWUp1RXdJdi9waHZMYUc3aXlzTW1FWXM5QjBlSXd4?=
 =?utf-8?B?NTBwSU1MWWdOQzBxWVZWN1dQR2l0dUpENHgwMlp1MWFiNGVxRWxpdThOQzF3?=
 =?utf-8?B?MU9uOHRFWFMyNHUydmV0Y0doTGpmSU15bEduTW52VFI3ODFrbXI5TCthNnRQ?=
 =?utf-8?B?QlhQcmo3MzNzNXREdllXUm5WQUVmTDVSZStVZDBLSkZJNXM3QXdhN2JrT2JO?=
 =?utf-8?B?RzJzaUhmNXl4U2o1UHJZNWw1NUNjd0F1aGhHQXFoYXRuWnFrQ2ZiU1NXZ2JF?=
 =?utf-8?B?MEhmOTYvZktTYTVjYXhuUU1DbmxycjZuSk93MU5QWXo2UXpKTThGRVBMWXNq?=
 =?utf-8?B?dUxMUFo1MWxsYjB1SFV4ZVBRUEZ5bDFmQ3VYbDN1M1RRZ0c4cjVLS1czM3BP?=
 =?utf-8?B?RS9jeDA0bEoyRU44NlBpdkFIYkVVWmlQc1I0bVh6dVZnU0lLeGNKcmw2L3NS?=
 =?utf-8?B?R1RHTlBSZFVqNTVyZG5TbExpMk0yMjNjcXNyWDVNcEduMldvTFpYVGIxYXZJ?=
 =?utf-8?B?RE9HSWR6M2d3WEJHaHNIemdUbUIvRjhnNG5rVWEwdjhIaVJKWGpzSVNyRFBE?=
 =?utf-8?B?UkpUK21PU2Faa3Q2RzZtc0p6QkpvOVpVQUNVL1lGZDhLc2R2aHJPTTNYQmF1?=
 =?utf-8?B?dzV6MTFtdGZjbXl2R1Y0TUZLNkxybUFUc1FqeUxWcUhJdGZOSS8vdzZsaGk3?=
 =?utf-8?B?dEsxS1hjei8vQlVmaEEvSVJ4dkorR0JsdEtoRVlvL1djWlBmOTV4L2owRU9t?=
 =?utf-8?B?bzEreUNpT0pGaGR2Y2lUc0djMFQrazJjK0JSSTczV2VjVm5ZMTlpbkMvWThh?=
 =?utf-8?B?dnFDbEtWT3IrdlFkdmtRM01xMUt2SUxMelNOa0VVdzhTa1MwcWJocGJkWW8y?=
 =?utf-8?B?VHFRd255SU9rOVE4a3gvNGNYNmFOLzVaMjhBaE9rK09OajFjTkhNZFVTNzFB?=
 =?utf-8?B?MVB2QytzeGROdkl4REFPUXlKSzhVRGpYRHVEdVVTRnVBVnBRR1hRMER0NzdP?=
 =?utf-8?B?QTJ0RnoxMzdHOEtMUGtnMWNIdUlkRFRsaFZ6U3ZQOGFYOHdQaG5QK0c1MzlS?=
 =?utf-8?B?Rks0eFptczhma29BN3BXMEFsUjFFV01PeDk4eUhBWVVBRzZsQW56elNTVGJh?=
 =?utf-8?B?Uk14OENyOEQvak1lV2F5dk5INEJZTkxXRjhLS3V5N1ZFalFVOC9peWpEWENG?=
 =?utf-8?B?TE1HMjNPMFZKK1g5Qkw1U3dvcjBIVC9XcjI3VmhtRExnbE1sOEpPWm84OTRy?=
 =?utf-8?Q?Oldl57HzpcNuUnecm6dCHuoiV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa6135d-e59f-43e0-3fd2-08dd77ee847c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 05:14:06.4663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUp9GtFYSLN/ZHo1CTFqi937NcjIbJcGBsT1yylNXtG48ZwfjXnb7LFWIH49rfmFo14g8aDSeqxOkbp34w7uHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3833
X-Proofpoint-GUID: TR-rxR0PHYQC0XZ_xzc3MUmlkiFkuJkz
X-Authority-Analysis: v=2.4 cv=E57Npbdl c=1 sm=1 tr=0 ts=67f753a0 cx=c_pps
 a=di3315gfm3qlniCp1Rh91A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=GEgqJZQb5VASKraZkkMA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: TR-rxR0PHYQC0XZ_xzc3MUmlkiFkuJkz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
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

PiBJbiBzeW1tZXRyaWMgYWxnb3JpdGhtIGNoYWluaW5nLCB3ZSBuZWVkIHRvIGNvbnNpZGVyIGJv
dGgNCj4gY2lwaGVyIGFuZCBhdXRoIGRhdGEgbGVuZ3RoIGZvciBjaXBoZXIgc291cmNlLg0KPiAN
Cj4gRml4ZXM6IDgyYWRiMTJhMWZjZSAoImNyeXB0by92aXJ0aW86IHN1cHBvcnQgYnVyc3QgZW5x
dWV1ZS9kZXF1ZXVlIikNCkNjOiBzdGFibGVAZHBkay5vcmcNCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUmFqZXNoIE11ZGltYWR1Z3VsYSA8cm11ZGltYWR1Z3VsQG1hcnZlbGwuY29tPg0KQWNrZWQt
Ynk6IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+DQoNCg==
