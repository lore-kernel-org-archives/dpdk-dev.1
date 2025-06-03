Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD73C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:34:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16F0540DD7;
	Tue,  3 Jun 2025 16:34:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 06F0A402C8;
 Tue,  3 Jun 2025 16:34:48 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553A4ws8012365;
 Tue, 3 Jun 2025 07:34:48 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2134.outbound.protection.outlook.com [40.107.93.134])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 471xyyggec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 07:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET3FAxqMqnuqGandsrwP7orCmivJoaexTPGwWMDB3w1j4YWT3qdtLcFyL9eG+5OVbv8slfYwdqRAhgn/KW6FpYwDj5YPtI3pnbEa1o/oGExEr7J/sk0CK40Me6e+s71gkAzCd9P1gIsqsfpCdeNqysekN/ruvWbzGJvwQ3GWHrOEZjyG7LJQisTInXxZR5Eu16LXte4diWPjhSzygN41gzkXhsQWkByTGr9ReLBeTAfS6bXPUCfOPKuwBqg/LzAPYdppKne1GJvU8UXk2VO8OT2NTWGtWJztycCnFAAB7jMBTh0fSq5cO9bInv9RjCY5jzthAKw/sCuvFsHDdLSckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeXSoAmezSv8bTnueEvUZryW3lpm5oAWrGQo8iDeKP8=;
 b=k/jBNkvEXsJhzD7h5VfPLVWB/baS+RRMZUNyvzf9iVVL9sEfFe6GE58kM+5VA0ebBpDij+OOx5aNgSxIeRnKE8DlVX/BHckpLbe59rKgmn1KyTshycGuAtqFBvm2hrK99C7LmwMpvfi9RNjOnM4TUCrmmS7VH2DHoCJWz6zHKNDqV80GGOM4ew3S8YKb8WxEs0rRRApFlhqBrk3t8cC8ZyScU+/TXtHnPf6sH/wqv25tuljLnMU7464IjpBVqHDQrXR3ABuB5nHQ8NYpdckD6wdBnyzv8DvvghEwvJEHONscgUQ+OjmQP2Fq7laYz4IdmA6B07bTHGTIYapDL5ZvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeXSoAmezSv8bTnueEvUZryW3lpm5oAWrGQo8iDeKP8=;
 b=TlurepZi553IBz3npRE1HfOb2o4rbUUpWDh2NA9HfQKVFxFlMm2S5Ehr+yWz7Q0xNYVQXxb3/ZiDyMz4fgJ9G1fPc1tsWGQyXuMQQ1iSLpjIVhVMbxCT4Cg/4OlNOTrVUH+t2K6Je+j/d/0X7zFdqyVAgXXCtVpdsp15x2eZBi4=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA1PR18MB5423.namprd18.prod.outlook.com (2603:10b6:208:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 14:34:40 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 14:34:40 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, Jay Zhou <jianjay.zhou@huawei.com>, 
 Fan Zhang <fanzhang.oss@gmail.com>, Chenbo Xia <chenbox@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "roy.fan.zhang@intel.com"
 <roy.fan.zhang@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] crypto/virtio: add request check on request
 side
Thread-Topic: [EXTERNAL] [PATCH] crypto/virtio: add request check on request
 side
Thread-Index: AQHby+vEczI5m+4uOk+XEGzTkviz87PxkVUA
Date: Tue, 3 Jun 2025 14:34:40 +0000
Message-ID: <CO6PR18MB4484536F2CA28CE85612BDA9D86DA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250523140450.75543-1-radu.nicolau@intel.com>
In-Reply-To: <20250523140450.75543-1-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA1PR18MB5423:EE_
x-ms-office365-filtering-correlation-id: 5d0c84cb-96ce-4d1f-be94-08dda2abc655
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QzM5aDRyV2xOeGtBTUp1cEw3LzVqbEdpcVU2ZW9nTG1LblpIbDZabEdRZXV2?=
 =?utf-8?B?YkJGTDU1K3piSS85a1ZiWEJCNzVmMzhKa0w2VVMwbVFGTlNoY2hhZjQxTFRZ?=
 =?utf-8?B?Uy9jdjJxaVNIZTRtVmk0TVNPWTNKUk8zQ1JYMEppa0pSbHdDWkpQcm4vQTdV?=
 =?utf-8?B?ZTBjdVdtNjM2NlZjbHhGQ25nQ1ZBNGUvUzRTNVJ2SWJ6TmErVXU3NHo5RXhH?=
 =?utf-8?B?b05tRytsdWdPN3NWQXhKaitwQmlhVWhZQzgyTnpIZUcvdUo0MTVFM1JKaEZi?=
 =?utf-8?B?MDdPb0dYUUZJeVpLaldWTCtsaEJ3VGpuMEJwc0FrdXp2L2p2ZHFqV0FZTFpE?=
 =?utf-8?B?amc3UExGVXZEQU1ZelNXdHFSRVp3NGpjK0FzYzFtRjhjU3gyeHJDZWw1MzNj?=
 =?utf-8?B?WGIzVjFuZzRlcC9IZHplVU1pNE5ZdDdWVDRWSXJKS0xLTG5ReHd6OXVQS3Zn?=
 =?utf-8?B?OGNMcExFb0E2UVd0RjdvUjVLdmZEOHBBQnBjTkxHUlJUOGFJdENDS1dSTXRZ?=
 =?utf-8?B?VG5pRTlzS1NxY2Q5MW03L0tQdUZsVWNJY0xvYU4xdStGcFlqRjZoMEJ6aDl0?=
 =?utf-8?B?UWhaa2E1VFZlRkFzdlJ6d3pBN3BITTVacGJSNjI4SzNUTVVheWFEZjA0Rnlk?=
 =?utf-8?B?SHVTODBHNldjT2lsNHpWb2FCRXRKNnkyL0dmUEdKaDV0WU1DOGV4dTdOeXR3?=
 =?utf-8?B?SFllQXZPQ05KeGtZcGk3OEk2RTFJU29Rd0ZLZHIxdWVVUGNQRTBNWHQreDlC?=
 =?utf-8?B?UVp1RVp0eHhyQW0wZW9PM2RGRVkzQjhxbXFFcFZ0MTl1dW94SXZScXlMdUVB?=
 =?utf-8?B?NHc4OEE1NDRJMjk3S0h2Nm5WTkZ3MEFCaGFLak8rR2F5NkFKLzg3NDB1Y2ps?=
 =?utf-8?B?a0Q2YWxVV2lwS1ZaRy85OUg3MFVwTm9scFBvOFlOaEs5OG5URC8zbGl2OGJV?=
 =?utf-8?B?Wkg1YkIxb094NFEzL2s4VW1zNkVTREVCNzlHWGlFM1dEWTI0QTZyUGgxaytD?=
 =?utf-8?B?aklaNGZ6MXZHb0djNDVwcGxzZ3hqaWpGVXBFZW1UbGhObjBRNHd3bzk0aktY?=
 =?utf-8?B?RGxnYmpFZnp6Y3ZHYlduTGFLZG5kVkI3SjVXWk9Dem9rZE0xRjBQUVVWVVRD?=
 =?utf-8?B?LzdsbklVTUxKMnRFRXFaK3NOYjkwMXkxdDJvaUp5RzUwRlRUQXNOQmQ4OERu?=
 =?utf-8?B?MUFTKzB2NVhvK2JVZjBVMStUTHdZdEdTcTlQOGgxQzdQQXF2NGxCN1pXTVVO?=
 =?utf-8?B?ZjNwaGpVLytqOGc2d2xKeVF1TWlUdXRYZlJFK3Z4T2p3bFZqQUNWQlArRG1X?=
 =?utf-8?B?dkxUL3IrSlpZZUYwc01QYm14RWZIb0Exb2hVTGZvN0srdkxId1BmTHRrTktK?=
 =?utf-8?B?TFhEZVZGOU1vR3VMUnV1KzlBcnNEQ05TYURaU2lxcWlyR0tqVTNiQUZNRzVM?=
 =?utf-8?B?SDdjejMxNkJLWEFKZUthcjdxbXhWL0syNUVGd3lwa21rSDBHM0d0enBxdlVJ?=
 =?utf-8?B?RkYxT2ExNk5BcDB2V0tUMjRCbE1ybm5vb1ZzdGsxT3dHTTRlakVmYlRsT3Nz?=
 =?utf-8?B?aEJpSDB2dXI0TEJhL21MV20wdVVaVmJaV04vZkhvdlRjVHIrL2pIdHQrUTFS?=
 =?utf-8?B?dldIVWJiSERscGNnK1VDNXF4VEZDam5WajIrZ05TMlI1SEJDbzUydFNJSDRD?=
 =?utf-8?B?ZWhuc3FDazIwWU05aEx6M2ZldzEvdTIzdFd6aHpnSUJ5emsvRE1zMXM1Y3RN?=
 =?utf-8?B?VnVhNzN3NCtDRHBBY1lGNVMya3pvSWlId2w4cllnQ1A4N01hZ1Q5bHRMcW1Q?=
 =?utf-8?B?M0pSdmJ0U2lDQ3lsRUJBVUoxV1E2eXcwb3VtZzFubzRGeHpBbS9ZVWhhY3pH?=
 =?utf-8?B?ejh1K0VjRUZzc3FQUEVPS3dBaHlmalFFd2JNdHduaVp3K3NYS0pnZDZRTU9F?=
 =?utf-8?B?NGt5bnR6VkdzSWQxbVp5Sm9sYzZTOG9iUi9ZQ3VLT2Uzc0RVK3BFVThuWjVS?=
 =?utf-8?Q?hjMreVbAYrqsz4aMn4+qIzDujjbUn0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnRlbWhvZ1JnSjg5d1lXTVlzTFZVSTRsQkdhUVhGWlczUTZOVHVnL09LYlJT?=
 =?utf-8?B?bVd5dktPMHd2QkpOTTZveVJEWTJyUk5NKy85ZVBFQ3BHTU13WnlUZS95YmlT?=
 =?utf-8?B?NTZ2T2g0NmFUdVI0aDR1dDlsTFBaQ25JU0dmSDVNNTNnbU1ENHJiZHRyeFAw?=
 =?utf-8?B?Yi9SWmNFYzJXMnVQbUFaaFA5MUtyWThYbjdheWlRVE9YanZSd1hJQmpGclh1?=
 =?utf-8?B?S2Y0NjRmeTdhbm1vTWhNZ1JGRitzWkh3aXpDWk9wRmVuQlNuSkJ2Mk9hWERy?=
 =?utf-8?B?WGx1Y3I0TlNrY2NOODhXVFRRN3dyeXcwQ1dtbC8zOHFkL2dZc1BGRTlvcDhV?=
 =?utf-8?B?dkZjYjc3VnFBaFU4MVU1TG5mdkVIL0YrMmpsOC94cm1qb0FYZzlnUm9sUGdx?=
 =?utf-8?B?OHVEYVFjV3UxMVA3TzFiMTdJcFJ3VjFhaDBQTHdMQjViQWw1V3FwQ2VUWXIz?=
 =?utf-8?B?OE1za2tkUTlaVEtVYW4wSHF1NnhiUGdka1BPcE5aOGFSR3RHRUgxeE1uZlR0?=
 =?utf-8?B?YnZ3Z0NlM1FaUWRaZ2huWVJsZmhJT2FKVmFFZ0pBeGI0NWJITmJRVXl0V3Qx?=
 =?utf-8?B?MlZGazBIRkZzRGxIN3R0VWZ0ZnMyem1NWE1iVm9pTjl5UmdpMVVpNnF6L01v?=
 =?utf-8?B?dXlxbk9YUEx3YmpPMklRNnVJZ1hDS28yZTZyL0ZydG9vdTNRQzVjakdTN0J6?=
 =?utf-8?B?U0kyNncvMlVHWUhDUk5aZ2pEK1JkZnRYNkdjMHBnbUsxbE8wUThhaFFnU3Bo?=
 =?utf-8?B?VkE3blE1SzZOSXdGaHZkbHpYQXB0WVh0aXhjbXpESlpJOVpIVEpubTlIZmVm?=
 =?utf-8?B?UWFuUC9ZeEwyOFpNRUJoakFrMmxQZlFOcThSVDV5cG4zcFluK0NNODhlelll?=
 =?utf-8?B?cktQRmVGNFo0bko4WmtzQmJKWHQ3NzJiaFFTaGlhN09vd1BGYjJ0N2RObmxQ?=
 =?utf-8?B?NWZtOFNZaDBEOEZQWFVqWU9YTXJIQ1QyVGlwSGpkaGg4TUI5MmZLOHFYR3ZB?=
 =?utf-8?B?OE0vY25HckVSYmdlb2VIT2hOMll6czIxMkhWcVlDcUhjSHo4cnYwa1NNc2NK?=
 =?utf-8?B?MEhVazZDdnRZUDFEVmtjT0NTRGxQYUVuenpWbnVkUjRvQTYwbHVUNXVZUmxu?=
 =?utf-8?B?dXBrc3FKRnFZWTRLMTlDWk1INGZieGdWNWY5ckFhdzNPTXIyTEJyM1NiS1Fi?=
 =?utf-8?B?Z1ZLSnVVSHV4TUducW5kbDRlMWdTa2sybFJlR2lXZnRhVTFSWU1BZ2ZlaEhF?=
 =?utf-8?B?VWVJcGdEUnFleU9WUy9DTTBuN3RLZkltYTJ2K291K2kwWmIvZ3FsM092TkU1?=
 =?utf-8?B?VG9nazFGT0FIcEQyVWNhY1k4MVpCU3ZkWGs4ajV6QzJjbGwwNmw1ZWdlY3FR?=
 =?utf-8?B?K1NGemNBQ1NmdGJRZWhkZmxQZStmNUlnQmY4YnJ0VXc4ekFPZkViSVZSdUhU?=
 =?utf-8?B?RUF2cDkxRnlpWmVvNHFiVGZFbTdlS3NXLzQ4OVplUUJlZGRVRTdtcUE4SE1k?=
 =?utf-8?B?aTdWTFFpZ1N2ei9oZkdUeTZXM01Za2w1ZHVoQmZyeVlHWjRBUnNreHdnd3R2?=
 =?utf-8?B?MWxmUk41SmRJVXMzUnYxUk9ZS3poOWU1QmNBcHVHYk5RYzUrSCtmYlRpTEdJ?=
 =?utf-8?B?MEhnUTdhd2MzOHlIa2dUOE1VcGpjTTBhVHU5ZFQrUHdSY2EweUNaTzFmWUpI?=
 =?utf-8?B?TDNlZC9WekpxZlBzMWl4eWlXdmg3RldsRXZ6a2tuRkYweWlLRG9vcWw1cWlF?=
 =?utf-8?B?Q29rR0kvVFR6Y0JNYzFZZmt1enNNbUxEN0pIN3d5V2psNXhuUmhGV3JESmp6?=
 =?utf-8?B?UlFiYVdpTTE5N29NZGJmalNKWnUrWG1hNmc4NEppaHZtUEl6cWJkbTNwMVFL?=
 =?utf-8?B?ZG9BMDNSMCtGSVQxSkVabVk4R05xcEV5SDkwOGErRFJzWTBZc0RnZnp4TXhZ?=
 =?utf-8?B?OTFkUitDZVF4T3NzSzhXMllJb0lmd3VaTW9TK2taV2dwSGRhV2xNSklYNlUx?=
 =?utf-8?B?NWk1SkZUeDZNVUQrOWNSditmWDVjSE8vYTlRZ2JJaDIzMGliOVNlaURRbVdC?=
 =?utf-8?B?S1JmWVFoeUNQZzc4SnNNaVNXeG5hL3JydW9TZmJzZEJib01rWDM4dEhDdGsx?=
 =?utf-8?Q?C7oU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0c84cb-96ce-4d1f-be94-08dda2abc655
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 14:34:40.6821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IejsrLt51CKGnvngKdlqIKKTvc8kk91sLmkQjeP6W1TOsxLr/qI32izKeVLB7cwJUH1VGBtGRmjNekzQ/6v2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5423
X-Authority-Analysis: v=2.4 cv=DsNW+H/+ c=1 sm=1 tr=0 ts=683f0807 cx=c_pps
 a=MbbdNVLKh5Pakk4fpNOBUA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8
 a=TJmTqdmYJ7r1u-mzBO0A:9 a=QEXdDO2ut3YA:10 a=MagX2lkpxjIA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: OQId4ddmY0GHgaAdOvmcgQ8TvMkK3WT7
X-Proofpoint-GUID: OQId4ddmY0GHgaAdOvmcgQ8TvMkK3WT7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEyNyBTYWx0ZWRfX4mXNAD92CITb
 6lKYcj2CGls8iRj5LxFUoDl7ctzZBQQiUE0NwNtMZPdjKYRhqgAPkIFkntdPlPiRSBmzrdmSq+w
 lUU9NFwAI2VoRmsLHn+GE/QHwkQeAAGUrloO9L4XmGzBC6Y/ntFBzIJDmruNoLDMAru7eD4jjEv
 plSzibqb+j5fHPLWcDENEOf0t8ztBQk8eYBiwOGzny31ATMtU1+5uCFEOGuigHwGt3Qnf5sI1YG
 Ya3UPWzkwmH2m07s2ANUJr8fBjJbp1gx9yCoAK6gpQDIwI1kuzPGXnSc771S6OvOAcqknaaoSn8
 WjOsGyh+FXQH1qbh697FgWw/VXc30P8lQch+Dw0pzrqJB0c6chNDe5D604nUAQfwehqJlWEqcfE
 oEKHfJC7iOP7wKdJP06HeunfflCTx4LqYbTQa2s2Gxe3iAWQPiCbJAnl3rFhjZYL66EcPMMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

PiBBZGQgc2FtZSByZXF1ZXN0IGNoZWNrcyBvbiB0aGUgcmVxdWVzdCBzaWRlLg0KPiANCj4gRml4
ZXM6IGIyODY2ZjQ3MzM2OSAoInZob3N0L2NyeXB0bzogZml4IG1pc3NlZCByZXF1ZXN0IGNoZWNr
IGZvciBjb3B5IG1vZGUiKQ0KPiBDYzogcm95LmZhbi56aGFuZ0BpbnRlbC5jb20NCj4gQ2M6IHN0
YWJsZUBkcGRrLm9yZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkdSBOaWNvbGF1IDxyYWR1Lm5p
Y29sYXVAaW50ZWwuY29tPg0KDQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NClRoYW5rcy4N
Cg==
