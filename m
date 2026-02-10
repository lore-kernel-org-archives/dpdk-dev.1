Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73ACEA8126
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:11:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13E63400D7;
	Tue, 10 Feb 2026 16:11:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CC1C9400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:10:58 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AC6M3f510734; Tue, 10 Feb 2026 07:10:58 -0800
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021130.outbound.protection.outlook.com [52.101.52.130])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c84cw0chv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 07:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXGb6ITBjkMf12qUGsyE9qJvTXa+7cYO1PbTi4D8PQAbV8Oil3AS6urL54QaH3oFjQA1yvCncM6zAfvjwgicZq6QPMiBLrKsi555ty2dgeZiLIOkuXzUvA3zaCx1+twj87LxqK1TADVHgG/Mfc5ElLEfuwL6cZCPLAfgU9A6X4TtMCwCEQyXv71+J+47PEds0T6DWkBdwR2fCYsNqkY5B4vIvX7zDgxKt1sGVUQKh+dzSYyutC8UJDXZkx4+WapvuDEzzYcNgMEXS29DPEdXzXAeZPIQVtH+JsaZQ534lBDhNQJ5gAWCI0aNpdnOUL2MaLMe0dDZi+SyuWol6g1BKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVhmT3Mn5PzGul+Yb2usJnliRsLQvMKCkd229pl8A1c=;
 b=IkFSBdC5F2T6zfNnYaHXcZ6j69EY3yDsh+cvon5wA44f/uBzdhFxR3CFLmmxOPl9Gqgll62e2dZQcsMenmkWWHfVs/bkgmvQkE8ly0qrweneOCT3QvWRzlx53zGCgKy/bVshza7EaDAo4g8Ed4YgMdFiuds0JweaCcU1+TszY54ZdRBGQvgfqXLN1DxhsX5PeFZbbuz486dbduvhhm5RaAfcsKwwjGjuOHVu3e2h7MhWwmOPQPPwkmF+rD1DLL4s8PDSmp3KUHEcBN7cvnOqxiL+BvmpkQmH/LlXTr6BnTrTEe+uCCO2LHt5iZVIvIG824kd3bi72URIdBLmqSzXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVhmT3Mn5PzGul+Yb2usJnliRsLQvMKCkd229pl8A1c=;
 b=v6N79O5zr2jeONDFknBaSWcIysHSsc/OyWvoCtUx+Se97YVYsxw9fpFY7bmsnSAZDaIZG7g8G38Fo7BOP3sxKpbuZHLoL5qQ72dRfKBW5scVhMppQwhcsbSJyP4wISqbRyZrDCvKhbK+FSzeco9F6D1QNM4Rh+KeDRxijiPLxvA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS2PR18MB927570.namprd18.prod.outlook.com (2603:10b6:8:32d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Tue, 10 Feb 2026 15:10:55 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 15:10:55 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Emma Finn <emma.finn@intel.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v3] crypto/openssl: Add support for SHAKE algorithms
Thread-Topic: [EXTERNAL] [v3] crypto/openssl: Add support for SHAKE algorithms
Thread-Index: AQHcj3TTE6L2H2j/PkK7v+MQnYaasLV8Hu6g
Date: Tue, 10 Feb 2026 15:10:55 +0000
Message-ID: <CO6PR18MB4484F3A23A3D9D7845BF81C2D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260108153330.2441799-1-emma.finn@intel.com>
 <20260127100741.3845554-1-emma.finn@intel.com>
In-Reply-To: <20260127100741.3845554-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS2PR18MB927570:EE_
x-ms-office365-filtering-correlation-id: 4650eb8e-a395-4572-80d3-08de68b696a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eGlvTXpzcnBlVEh1cERta2RFd3dZOHBHQVdPS0c3OFA4Y2Zuc0E4VTg0YUJX?=
 =?utf-8?B?UUw3MlovdTBKRXR3TG03MW9mRUM4MU14a0MrVlNmdmVHWVBMYzNycDcvUVhV?=
 =?utf-8?B?MzJ4NzkxY1IzWnFRdXBGOUI2ZEVXUHU3RzhZalozWWVTWXpOR0ZXUk4yTE9E?=
 =?utf-8?B?bEQwYWdlbXQyRWo5dHpDejkxMi80OHZEdGRWbmFrem9JWDBHcW1DQTc0NDJx?=
 =?utf-8?B?eHU1eVN1dkRrS2wwTTlVOWdKWTVCTmsxL3NxcVl0eXBmSklWbElFb2lSOHVi?=
 =?utf-8?B?Ly9sMTkydEZVQzlBbVJITE9CUVV5YXVtZ3RNSHROVXJaVUpHeWdoeTNyK1VK?=
 =?utf-8?B?WHFuWWI1VkF6a09MclRNdXdYVnNpbW9sYnRZTzZrNFlRWjkyZkhpUGR3TUFT?=
 =?utf-8?B?dkdsTGRKUFpjWnpQVHdMVjlFRC9Fc0Z4eUcwSEE0WkJIZ1l2U3pUUHVLcHhu?=
 =?utf-8?B?ekxTZUlKam9iQ0tuY0t1UndWSUd3ZVkvaXlkVm5LUWd6YmhoR3F3Zzc4SWxM?=
 =?utf-8?B?ckNaamVDOXkzTUZ2dW5hcDY3SjcyUC9kRGlUU3B1aG9MaDRQWkJsMFZmRnlu?=
 =?utf-8?B?STVINEQ2ZUFqSGRmN2FCUVZ3UHlpU2s3T3VYek4rN2xVZDFrM3BOK2JobU1h?=
 =?utf-8?B?TE44Z3RPS3FnaXRIQUk1NjZFTDhPN0pXNXh1bFI3b293aWNjNTBQeUVqdEp4?=
 =?utf-8?B?V3owYWx0RnpBNC9KSW9SSEVIbFNvNWNVY3pDcXBXTDJlSUNzbXk5QmJrdXYv?=
 =?utf-8?B?cmdmSjlHUEJYeXNYUmN2a3pwUEg2QWVzVHFFOHRmNU5YcEdoU3oyNUhHV2xO?=
 =?utf-8?B?UFY1ZEw2ckVNUzl6blZuU3dxWmpCbGZHZnJRSnNadnBiNE5ON1VsU0FiWktB?=
 =?utf-8?B?V241MlFOb2JxZ2tseFNIU3cyWm5yQUZoTEtGME5NQ2lCdU95ZFFPYmcrNm1m?=
 =?utf-8?B?SVhIV2haWWZ5RjlWbVNsQWJQaGpSeFRkUUVlQXUrVFdnVHdUbEJTb0JTTXpj?=
 =?utf-8?B?Qk9WUkxjVEdRNng3TEFVd0thbkN6bnJhNTZKRkNaSWdQejlUZ05DMnlySStu?=
 =?utf-8?B?RUF5c1IwS1Z4bVVPZE83SFdpUVBUTiswZHRLWmNHdlV5ZUtvZzZwWFpMT2ZT?=
 =?utf-8?B?dFVxNWlUUitRM3Y2R2FWSGxMMVBCeWZPd2VnamJOekVMTU1Ya2FGOU5IaGt3?=
 =?utf-8?B?eTVEZnRvbDFvWkRxZ245RjEvV0lMYWxEcHo2czNYN080YmtyMEpxVitJNHdk?=
 =?utf-8?B?TFcxUVpSenVWM3ozQ3ZMVVJaQU12ZjhySUdZdTF6S1ZOdGVxbzJ2emVrR0kw?=
 =?utf-8?B?QzJZVzB5NTQ2aTFLQXZDZHdvYmMrOUVnWTdyRHV5SlFmenB2QUVXeFlEWHBT?=
 =?utf-8?B?bDY5dFc1TllZSWs2UkJONmZXNFBldWNSQldGbUtISWllS3NyVFYxcEZ1WGs2?=
 =?utf-8?B?WXdqeVdwWUNpR3NGNTNwUGdWSC9ySXdSWFFzc0FaZVBOQ0d5YmJ5ZWgvWktv?=
 =?utf-8?B?M0hkWHJSNTJUbnhUOWNMckltQXp4dG5RdXJsbFdsa0ZRVjUzWm9lVmkwNndO?=
 =?utf-8?B?VnozOWovYVNtdnVpV05HVjNBWTlSUWlpMEY0QkJPdjFYZU9qTVVsZUVZWE11?=
 =?utf-8?B?dDhPd3QwU3ErVWUwcS9zR0sxTFloVitTZmFlYzlGUlBaU3Z4VjZWaC96ZzNt?=
 =?utf-8?B?RkdBTG1LNVZSTW8wZFFOQVF3SDRaM0gwVm5Va0ZBQ0xmUGZnMHM2a3NsRTN0?=
 =?utf-8?B?ZHlYcGgzT2lrWEN5SEpXQ09jeXEyVzNFdHFBbHoxQjhadnRIS2F4ZmdJZGFv?=
 =?utf-8?B?Y0JuWUxKZWd1L2V0THRob3AzSXZ1eVhnM2FSTW1HQlVaOWRua0xFcXJ6bjRT?=
 =?utf-8?B?QzkxQ0FRaGpCVDBlYnk5KzVpZ0R3bEJWcGJmdWVZM0dXYUVYaTNuWkp2TlE4?=
 =?utf-8?B?VGx2eVU5SFpPVjFaa2FIY2FreThTaDBXaUJBYW9ZUjY5dzBNQVdYRVNLUGZM?=
 =?utf-8?B?c2s3VkRublM1NHdidGl1a1ZNMTVETjZOUHNIZmJLWlJEK0tSc2lIb21wU1pP?=
 =?utf-8?B?M0cvVkNZR1E1MDBCeGVCaTZyUmhvOUlZQ3ZsRGtRaWJLVi93SXVyVkdiaGM2?=
 =?utf-8?Q?xxaJV9dAZ2/pVd/k6C5thrfOb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2o4VEtMeXpMRTllb0Q3N3BxUkx6bUNLeGVWZkw4eWVvbzdOTndoKzhCdHJO?=
 =?utf-8?B?NWpXeUV0djd4RS9rUUxQRVd1UWpETmdRdC9DZnpIRC9PUFFVMXMvR0VHbTVi?=
 =?utf-8?B?c0pua0t5MWtxZmRydS9nUTBJdFBtQ0tFRGdIZHRtK1RtTVE5ajZEcnR2aUR4?=
 =?utf-8?B?cDZIWWFZUjVoVVpEc2R2SEM4ZzBQT0FKLzdGeEdOcTNLTG4xSEFBU2Z4bDRy?=
 =?utf-8?B?RlpjRzVUb256QlI4bE5KL2hVOW9HcWJyY0R3TFRrK3VZNEQxMXRIajdRYity?=
 =?utf-8?B?MVpTcTNCM3EySWhsT3dNRldmcG93K0RuTk9GUzNVdG5JU2FyNmVvSzJuY282?=
 =?utf-8?B?UmR5Y0gyZUE3ZEw4cEpSWkkzQ3NKN05UQTBvOEVJaUhKZE9HOWdQNmRxZE4v?=
 =?utf-8?B?YmEwVklHcE55aEZNZDB1d3UzV2E0RWlRMVF2czc0ejEvYkwwc2diakRFbjdy?=
 =?utf-8?B?bVFrRU5nVVFMYXBmb0RkbnQvWGFiekpWTWRiYUdyOEJkdDJxb2RyOUFiaDVo?=
 =?utf-8?B?ZWpOblVaTlNmREVKWFBObmZDVlpLUEc3RVJsWktKRFAvMGhVblgzb0lJeGZD?=
 =?utf-8?B?Z0V2cisvaXRVZGI4dlcxSnltTjJvZmFnSTYrVGRIVkpPMXhRODdmbjhPN1dp?=
 =?utf-8?B?S01Dd2pUNDJ5LzduTWZaQnRLQVpwV2ZpLzdCVkRtZUZtRWV1SEhlU2pldG82?=
 =?utf-8?B?eUxBcy92Rkc5ZjZjbUJaL2NIYUdoeEVLeXZoMEdtdkRSQjlGUE5DK2k3YmhZ?=
 =?utf-8?B?TGJhRGlCR0NSelc5aFN5TSt0RHRHTXQxWVNmeXdHMUc0MVVsMnpkWWx5dzRV?=
 =?utf-8?B?elpxTVBWd1RnR1UvVEFrYzFxQ3p5YVV0M2dLTnFvT01uUXBIcTVUNEpIZ0JI?=
 =?utf-8?B?YWhJRjBUaWRiam1ZTTZ6eEZjQ0ZCSEc4bXFwMjgxYU83TWE0OWpObXBtMzV1?=
 =?utf-8?B?REJ0SlUwOEV3SUhjUU1DekpvRGFnVXJWRWdNUGk3MHVWQ2NxS011MCtjNXov?=
 =?utf-8?B?VldrRkhZaFZGVFd2ZVU3akk0c3A2djNTQ2NtMXpIY2xQR0NZVEdrb2tDQUZF?=
 =?utf-8?B?K3NQUHlVZGpoVTZyOGFERGRwUUVlREJ2L2pNU3BoS0pJaDlMQ1NYNW10YWts?=
 =?utf-8?B?L2o2U3FvR054OGFpZEZOdExnM1k2bm93ZDVlKzZJaHpwRXdCMDBUNjhlQ2tj?=
 =?utf-8?B?cFoyZEFBSStCb1pseXN2eTJlOHV0ZUU4MDdVeXB2UCtsRkR5d2RIdnp3a2lQ?=
 =?utf-8?B?cTJiWXViY0tqVkQwNFJwUG9qU09ZTUJyWmd5TTIrbmVDODd5bkd2SFlWQmRy?=
 =?utf-8?B?enhkVDYwUFh5UTErd0paVHJoWlRkY1hoLy9YVSs2MnRDTitlYUVwUUZ1QnNT?=
 =?utf-8?B?a2xBVWZ4Rmh4NHRoMCtCSzYrU3FLckVaaTllekV4azhUQVI2N1dEamVyaUVm?=
 =?utf-8?B?RDhUWHdQYlc2SDQ2QUovQzVVNkw5Zmt4K1FibjVDdFNkcTR0OXJXT0ZrTDVG?=
 =?utf-8?B?WU5vSjJ4ZDN0c0VqRGI5bmNTR2EzM1IwY3oyYlAraHR0N0Jod25sbXFMUVkx?=
 =?utf-8?B?dy9rcE9Hd3MyUGM2QXRtYTlxUzJBWVB5VStvTk9qUXlvT3F2SklMTG85TEQ0?=
 =?utf-8?B?RUNSYUNHcXdDSlk5am50NmxBWmdNcVovK2YwTXAyMHhlV2NnbnFCd3pORHB4?=
 =?utf-8?B?UDlBb1ZiVE5xOVVRQUxzZmlJbTZ1Ry9BZDJjYkd2TUJLajVESnVWa3k1T0Qw?=
 =?utf-8?B?QjZLYWdFUlF0RGpZZWdBRjk2ZlFLR2ZoR0ZrYlRzUTVnN3RSdjhPcVI5USs0?=
 =?utf-8?B?OHloZGFoNGRjOGRZdjJjdmlQUkQzdzM2eG5SYkk5MitqUWRjdGNOTWhmV2Rw?=
 =?utf-8?B?Q2xsb0J5OGpCdlhvYlJRSDdnNGtva0pOTXROS1JSUWhWWkU5ejhvS3BtWVkr?=
 =?utf-8?B?TWRSV0J0alprc1cwa0RKL1o0dVU3OEZYeS9nQzdXRXY5TnVQUm5XRTJYOUZn?=
 =?utf-8?B?TVhCMzJLUW5sOCtRd21CS1ZHYWJwMzZqbHBLcExCWjMyb1NBR2pYbWFpdmhu?=
 =?utf-8?B?bkZHaUMxeFRmcHhZRlZEb2UzSWRMTUVwbW8xOThjQThpVHNUdEcyVmE5Uk9z?=
 =?utf-8?B?YnR0clZ6Q0tZeFc2TTJ6T0hqa0JoWm1jVHh4OVNqS3h1TzViZHBJcC93dlFQ?=
 =?utf-8?B?WnMzTHJlQVYzeG9UYXE3aWJZcTJRQXQ1Tnh6S2hVKytIcmxEU2ZMZnoyTC84?=
 =?utf-8?B?T2w1YUQwUXhNMGkwaXJNZ3JnWkI2WFVIL3ZGdjZrOU83VFhIbitFRFZjbEVM?=
 =?utf-8?Q?Yp5C95NqG7psxkq7pg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4650eb8e-a395-4572-80d3-08de68b696a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 15:10:55.3234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8D913yvmpiGy3elhrmZd2rns6Apgnyt20kF02OsIUkt655pE1bolO692l+qXweznc/LaiHJsMMlJx5IbRvKPww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR18MB927570
X-Authority-Analysis: v=2.4 cv=YsIChoYX c=1 sm=1 tr=0 ts=698b4a81 cx=c_pps
 a=0+nbxk2pwnolPG6y4jTXag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=aFtGNCwJAAAA:8
 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=5QPiE0UUtRj0hdxkoSkA:9 a=QEXdDO2ut3YA:10
 a=37_LVEjxSQTuOH1zQYhg:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: tn7bHT1XJhGefPr3rIEbIZV30rOX7E6D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyOCBTYWx0ZWRfX+gNG23PdG1H4
 t+8/u6KfMh9bCbzVZ0sEoWrl8zqlG5Yq51OxvOU+w6JRHvI+gIH4+Xy1YIQugehN8klwzLpERUK
 ug4Di4CBybDHLLnRbL/3FaqpQMYPAl/L5A5FOz3P/YbtVNea+OU5iMA5X7ffNQt8NF91rxIuxBI
 Lmtc3y3ni7Tj0XN8AyRz8YOh/Cd4e1h3vbEHKrYKAXkqtHH1kCwFwPfUrlDU1PYJg74VFa5NtCF
 SdUincrplTfcjEtNWHIuP7MJ17wOWBanSVxLognOtL3OAzOy5W+fgQT7YUFg/F01z1xPa6RTNHm
 qKE0CeaiEAnuvYdHhdyrFc4AeELhrNHizXGLNqzl3J+prKJYONVoZVOifUlZqBMSQdt3n5lVpFs
 LqgDaHxMeg+D95ptlVBtDeVY3U4wQ9a0XU2PWTF44vfQOewwdPeQT1kd4yNBlrExOuOzR/pXWJJ
 l0uRRljSwdJHtncD4tw==
X-Proofpoint-ORIG-GUID: tn7bHT1XJhGefPr3rIEbIZV30rOX7E6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
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

PiBPcGVuU1NMIDMuWCBoYXMgc3VwcG9ydCBmb3IgU0hBS0UsIEhlbmNlIGFkZGluZw0KPiBTSEFL
RS0xMjggYW5kIFNIQUtFLTI1NiBzdXBwb3J0IHRvIHRoZSBPcGVuU1NMIFBNRC4NCg0KU2luY2Ug
T3BlblNTTCAxLjEuMSBpcyBFT0wgKGh0dHBzOi8vb3BlbnNzbC1jb3Jwb3JhdGlvbi5vcmcvcG9z
dC8yMDIzLTA5LTExLWVvbC0xMTEvKQ0KQ2FuIHdlIHJlbW92ZSB0aGUgaWZkZWZzIGluIGZ1dHVy
ZSBmb3IgdmVyc2lvbiBjaGVja3MgYW5kIHVwZGF0ZSB0aGUgbWluaW11bSANCk9wZW5TU0wgdmVy
c2lvbiBzdXBwb3J0ZWQgaW4gRFBESyBhcyAzLjA/DQoNCklmIG5vIG9iamVjdGlvbiBjYW4geW91
IHNlbmQgZGVwcmVjYXRpb24gbm90aWNlIGluIHRoaXMgcmVsZWFzZSBhbmQgZG8gdGhlIGNsZWFu
dXAgaW4gbmV4dCByZWxlYXNlPw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbW1hIEZpbm4gPGVt
bWEuZmlubkBpbnRlbC5jb20+DQo+IC0tLQ0KPiB2MjoNCj4gKiBGaXhlZCB1bnVzZWQgZGlnZXN0
X2xlbmd0aCB2YXJpYWJsZQ0KPiB2MzoNCj4gKiBVcGRhdGVkIGRvY3VtZW50YXRpb24NCj4gLS0t
DQo+ICBkb2MvZ3VpZGVzL2NyeXB0b2RldnMvZmVhdHVyZXMvb3BlbnNzbC5pbmkgICB8ICAyICsN
Cj4gIGRvYy9ndWlkZXMvY3J5cHRvZGV2cy9vcGVuc3NsLnJzdCAgICAgICAgICAgIHwgIDIgKw0K
PiAgZG9jL2d1aWRlcy9yZWxfbm90ZXMvcmVsZWFzZV8yNl8wMy5yc3QgICAgICAgfCAgNCArKw0K
PiAgZHJpdmVycy9jcnlwdG8vb3BlbnNzbC9ydGVfb3BlbnNzbF9wbWQuYyAgICAgfCAzNiArKysr
KysrKysrKysrKy0tDQo+ICBkcml2ZXJzL2NyeXB0by9vcGVuc3NsL3J0ZV9vcGVuc3NsX3BtZF9v
cHMuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDg1IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KDQpBY2tlZC1ieTogQWtoaWwgR295YWwg
PGdha2hpbEBtYXJ2ZWxsLmNvbT4NCg0KQXBwbGllZCB0byBkcGRrLW5leHQtY3J5cHRvDQo=
