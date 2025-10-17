Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622F0CCD19A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 11:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8843F40658;
	Fri, 17 Oct 2025 13:05:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D91D240269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 13:05:30 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HA9mGK007997;
 Fri, 17 Oct 2025 04:05:30 -0700
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022142.outbound.protection.outlook.com [52.101.53.142])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49uksrg365-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 04:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCBMREG+NX/yNxDSA0TRguWcrf5gatHbZGq/DIJAalnPbiqp3FZxPLia5fBgRFSQUQcYSZdlz9e2nmDcrDO13fnxzCU3FJTZh0FI2MZV3YveIW6pJeOfpt0pC8nq4hvAa9MTMWurum7B2L6L/MPhfqkbT5Hdcmwwt6GJyMtHZ7DMy8J9aBD67Ab/2aFwaEdtK60Dmyc1cniKP+9lqBOoNlsFETfyK8CkRCLExx0jEVQTRWb/O2gRzHae/uPMjyw6Px/ozh7th1vArzjoRMCJJNaV3KD1JZQyMixMnJjuhOU5dgKn2PB6odONfkcSEfgWc1VT0y1P0ViuLp0trOHCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RbOEA4JWj0/YNPPHvhWD0gp0BSzLLkre02Nm4qJ8JQ=;
 b=riy3Kd5irtKdfeaWe6iLYfBAK4Q3Z3LI4HNIzmWG2Tcxv8UnjyTBCeSSKmOEm821gzftIzIjJ7bmLhUq8Yb1agbyRNHFnTTxfgcsLl4K///cCi0pXEtWzycVX9/2/pbFG8NmecyOzf3YHDBIq336E/q+Jf4I24qKgEp1MGnOTngXt8anVK3eJQoRnmQ7sDtscC5z6DD0FIAM9H2hEhbPC46EeZE00e9y0+1OcjQbZLAmKr6A3TYIeVPPJwUr/bYDAp8IXXDgtwUCBbwc6x2kkMqau0iZxQ9MM3GHyVfDiNeuF1gm4AyXPT32hggwSMBeZSyEk/V/bel2DtYfcEYM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RbOEA4JWj0/YNPPHvhWD0gp0BSzLLkre02Nm4qJ8JQ=;
 b=W7JdsDomhDw+SMlCk7AWzmH1fLbDWHi79PfG89stm+4BoQmtcIXAvFR5NmGpWfXetf8WJbrpx18QQ/0/KeD9jbVXXa4zDKeVmNjbROIpAqdT3SQb7PJKV0TciwokQxblm28BztUBUQJVGg4bI4jtryUCCU5T1vr49FL3OwRzlM8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MN0PR18MB6071.namprd18.prod.outlook.com (2603:10b6:208:4a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 11:05:26 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 11:05:26 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Nawal Kishor <nkishor@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH] rawdev: fix device ID retrieval function
 prototype
Thread-Topic: [EXTERNAL] Re: [PATCH] rawdev: fix device ID retrieval function
 prototype
Thread-Index: AQHcPmoPe3b0ds0hwUSJ4W1tknh4l7TEa0IAgAHASwA=
Date: Fri, 17 Oct 2025 11:05:26 +0000
Message-ID: <CO6PR18MB4484E2A16377DE1CE297E953D8F6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250924055654.1986682-1-nkishor@marvell.com>
 <2509677.g5d078U9FE@thomas>
 <DS0PR18MB52705A2144204E371DDC6EC4B2E9A@DS0PR18MB5270.namprd18.prod.outlook.com>
 <3733472.U7HbjWM52l@thomas>
In-Reply-To: <3733472.U7HbjWM52l@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MN0PR18MB6071:EE_
x-ms-office365-filtering-correlation-id: b7128372-833f-4597-75b5-08de0d6d138d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dVFoK0VyajF3RkYxQzdUTndxdHlVdk5HbDhlZVFHaHp1Rm9aejYvcTlnTTVz?=
 =?utf-8?B?WFlrRHhqNDZrSitSUFZpRzJMTWY5dHRpYUl1ZkxiQTlvUXdsd2o1Uy9OQVhR?=
 =?utf-8?B?Rk1zTDNCWmxBOFIwSFpRSXUyUG9QVU1XRDVHalc1ZnVYRUM2Rm40ajRkKyto?=
 =?utf-8?B?LzFmNlJyQkVJZ2lsZ3g3aDVqZ0piT1lTT3laTHlVTFZDTlVxaFlPaVJneXlY?=
 =?utf-8?B?UFRRRjZEenBHRlNnSEdxNzd3b2czdGk3dmhYSlpnVzl4R2NnRFhnMlBDa0Fk?=
 =?utf-8?B?cEtRUTZlb0IwMEswZ0IrRlR2VFIwWEFKa0MrbjNUYUZYNUtNL29ObWJhVnZw?=
 =?utf-8?B?bHpXT0dRVllXMTkzbDdGczN3TDd5TzY4L0VlMDY2WWgwRUJTeE8vM2xkd2VY?=
 =?utf-8?B?dkV6L1RDN0t5a2lCK2w4TXo0b0pJWGhBRXhHYVVwdmwzQmExZjJkdWpqNkFQ?=
 =?utf-8?B?eHlvVGxuVTFrSE5MMEZ6WWYzWDVJaU94ZDlCTnFIMWtjRExmQnNUcHY4VnR4?=
 =?utf-8?B?Uk9UMUh6T0hxdzdWaDRLQm44VFk3bDhMNUMyeW1OQmR3S0xNWnpMUzkzSnVW?=
 =?utf-8?B?MEhzekgvWCt4cW91enl3K3ovT2ZVQ1owb1lJR2VWYVo1RWY4Z3dZTStpZFlB?=
 =?utf-8?B?QWliL0pqZ0ZFZlBqWTg3Z2RzWStLaHd1WlhuRFFEeWhoc0Z5Q1lFU05FMjFF?=
 =?utf-8?B?QWxMU1NKNjFhOWJNRlVyZmVEM3hBaGp5MHNpOStCRURSL290Q2tmZUhHd0Y0?=
 =?utf-8?B?VGtLNkFOQ0NKN3lNVHQ4WVdGY0M1T1FweHo1SzUxNmF1UkNNYkU0VXJSbW5C?=
 =?utf-8?B?MDNFMEwxaVlFd2R4WFlUVnBpRE12ZVlpOTBNQ3NIZGtINFpsL1o4UEpuNkk1?=
 =?utf-8?B?N0U1eUg5bzQ5TFhIRXA0R0cvTjQ3d3UrTGszbUJmY0dZNXp1OGVhWUVpb3B5?=
 =?utf-8?B?akpFK1lMdVNrM3JKNXRtYm1DMUV2K3ppNHh2MjBYRlZiVUF3R3hUcUgyTDJs?=
 =?utf-8?B?QWFOSzhtU2hoUkxRYUlwVnAvVFFQUnN2TGxEdlAzNm90V0FVSnMxcnhkRnoy?=
 =?utf-8?B?R24wVkxKNFllRGJKR2tUUUp5SHlSWnRRa0YzUkVpT0ttK3h3WEkwcHZtT1dJ?=
 =?utf-8?B?VHpvZFdRLzZGSkk0MDlrdEhkZ3BzWXZyMkppMzY0T0NMcFhDNzRJM0ZXdG4w?=
 =?utf-8?B?UEZxQVQ1UHZHVDluK1NaTnQrSWNMZ0I5YVpZdUpkT3kzTHlEcDUzTlkvbis3?=
 =?utf-8?B?dTBmLzV0QldYQkRmR2FQdXQzc3VGVkRoVzB4ejBOemtVcHZ3RFdWVkVqMjQ3?=
 =?utf-8?B?SzY3aHAzV1JYT2t4aVc2d0ViS28vMHJRR0tBazJJWTBZQWY1Wk1iZEpRZzZz?=
 =?utf-8?B?MHhCY1RLa2lPZlM4bkszcXNHM1d6MGdRL0trNUNKOVdVU3B3WW9VOGZFSitm?=
 =?utf-8?B?cGs0endOVnh1QU92bWNtai81bVYzc2o2bC9nQiszUHVDWHFValFtcVJ2SnJV?=
 =?utf-8?B?VHlMd0xaMTB1SjN6SjV4dERlYnFWdHVmYVFXTUdkU3Z0UUZKdTkvcCtDRDBq?=
 =?utf-8?B?b2V6UWJKVEt1ZGVmSUUwQ0srTXNVRFMxTWE2UjRMNUZXaHhvanoxdDlOSUdL?=
 =?utf-8?B?dVhnUEU1enYrZEc3THdnSmsxd3ZMN0FCSzgrT3RoUW5abVpnZ2NEWCtkd2da?=
 =?utf-8?B?N21pbEtaRGJ2UGxpY2h2cU1SMERYTWVseDNHYSs4OTFGa1YzeXozTEh6ZnFN?=
 =?utf-8?B?Vm1scnM2Y2FKTCszbVJaNFVVaUt4Zi9FVng0NU52UXI1MnBrK1piQzFIOVJm?=
 =?utf-8?B?UVVqTjJMdkxHVWtLTnpRMnM5ZEtPcUhOVm8yMmJXaWg5b1Uwb2Q0aXRIZTBY?=
 =?utf-8?B?SEphSjNmWFJWU0d0UlZWMFhOdGg5S3lWckRqT1ovcHd0L0Z3YmlQQVVZWGN0?=
 =?utf-8?B?Yk9IZjFVcGY5OXhpWVlhVTVMTFdUSStWdG5hcUduNVdnWkdiQWsvbElJbFhH?=
 =?utf-8?B?K3JpYStRbllPemR6TmhhUmVib3Jpc01mTEpCUEg3YVk0K1VIaFFUeEp0cWgz?=
 =?utf-8?Q?uV+UFZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVpaeUdINjAvTGZ6eUNsZmpMa0tWQ2ltTjNVeXFXd1NlZ2R2TmRyRmttVG5I?=
 =?utf-8?B?NE9VK2dObDR0RGIzYnlOa1VHNzRHNE1FcHJzbEsvRHpJSnRweE1sR3hFSk9R?=
 =?utf-8?B?VEh1NEd6ekd4MlZOZXVIYmJGNk5FSS9IMEhqVzVIcGVPQ1FoRkRSUVNCdVpS?=
 =?utf-8?B?c0hJandZVlFTTlBEbnpDdU1ZREhkVW5tOU1RQXYvNDI5Vzg3Y3lhUVZqTmRL?=
 =?utf-8?B?b2ZVL25BUXltWVVZRFNjZ2JuZmc2YTRQdG5KMlhnMTZ2T3B3S2dYNWY2QXg1?=
 =?utf-8?B?UkV5TmJwdWNNNVZ2UDVHMnhaWDFuS1N6ZlBUMTN6a2h5ZmF4bDU1WGVCdisw?=
 =?utf-8?B?Y1p0WW9JUzcrWG51ejBjeE1ZMlc1dkljSDVtQTB6NEFVWVA3SytpNFdYQTFY?=
 =?utf-8?B?MCtkUy9NU0NzTythZFdvbkZtdTY3ZCtLS0x0cG90RFYwbnJ2aGtvNFd1cnYv?=
 =?utf-8?B?OU9FdHZTVGtnV2o4LzhjTU0zaUxtRDBURFJnUWF4YkJTZFZVVmtLWS85VGM2?=
 =?utf-8?B?TWgrMHZtS0d5aXpBemRrUkJFclBHdkVlSUpmVklmOHM2RmE0UmhiQ3hQc2Zw?=
 =?utf-8?B?Nnlxa0V3VHRvYmlTZ05zSU5UcEZ2aWN0NUFWUlNmRlZHMkIvME1na2h3TG9J?=
 =?utf-8?B?bU5kUnFSMi8rck96QnJUN0xEQytkOFJkY05OcVphNVB3RnFyWkJYeExBY3E0?=
 =?utf-8?B?SURNZXRVc2IzWExDZHhhcTlIT3NQUll2czhESTZ6MVNmMXB5SHVXMkQyUmlu?=
 =?utf-8?B?b211aEg0R3N6VDJWRUVKTUgrTUxSa2tndjZ4eE5JaTVpV0lEQmZLYlFwL3JQ?=
 =?utf-8?B?NkxyeGlrN1krTFc0Vk9ockdFMGV5TzdUSTFnKytSYVBhbXh0SDNOMkhJRUNM?=
 =?utf-8?B?QWhnOGtvdW5YZDA4aXh5RWtkaEVWdnJvaUZlbzc3enJhZGlVVEVBTE1XSmVG?=
 =?utf-8?B?bVoyMGZYMGRvcXRKOWF1S0pwdVM0VHBrV1NMRmF4QzZyZ0ZSdFp3dzhKYisz?=
 =?utf-8?B?N0JrbUFKMEFvMExQbmFJSVNmSmVSbFczbk5KblRvYnFVRHpvNW9OQy8yYmtG?=
 =?utf-8?B?M0U0azhGbU9yY3lQMGFzalpOM3ZYVElmcGgyaHRUQUYvNWVhR1pRY3J5dHFX?=
 =?utf-8?B?Y3FMWDFOOHZta2duSHJKd1NNeXdkUDduUUZQdS9BZVVHRHNuV2g5T05heWhG?=
 =?utf-8?B?aks3WWQ5bDNOU0txMlUvVlBUSnUwUlFWaE91NWdxd2s4WWV3dXdNNk9hYTl3?=
 =?utf-8?B?ZWZERzhjSGtNbUR4a003V1RXVXczaE9YVE5vbFNlMjFjN1RabDZxL3A4QWd4?=
 =?utf-8?B?a1ZTd0J4VmdxTDZXYVZYMFAwcFVBTXlqMmsxWDZjMkM2cHY3N2YzVXhlR0dD?=
 =?utf-8?B?d2xxeEw5OCs2eUtaNXFRdm5rdVZHa08xak9MQU16cXE5UGErcC8vWVF1S25l?=
 =?utf-8?B?Wjc0WUtwWHNVYnpyK2xMUzdmK2JwbVBPRW5zSWp0cldVaG5DL1E5TDRGczlC?=
 =?utf-8?B?TlJLOFNnVE9aWWhiQ0Q4UDBWSWxJWlJLWE92L0xpSzdyWkRFRTZTRXlKa1p5?=
 =?utf-8?B?Sk5OczZvNHZKelRVZEUwN0R1SmU2YnZGc1lKN21LbU5JSlNLajA1bkxiMmtR?=
 =?utf-8?B?ekhyOFFxSUwrWjY1aVR2ZG9wRU1BcTRWODNMbDJ2Yi90YlkrL0M4eUluRUlt?=
 =?utf-8?B?a1B5YWRyd3VFa01pdXJTakF3bzNpalRpM094eUFkalFNT0phOERUVEtvNk1J?=
 =?utf-8?B?a0N1M0J2NFRjVTFuQkx4WFVhMEpwbHMxVjNjQnVyajhCTzJaWkQ2VDlKdDBh?=
 =?utf-8?B?WTlJdDFpaUlnT282QmErNVROQ0pMak9LZXVZOVVYeWkwUnI5eWZML0xuckxQ?=
 =?utf-8?B?WGFYMDkvYzVlTStUYS9GdVhYK3pLR200MHdBSWo1ZnRYSUswc0pMTEJtQnBp?=
 =?utf-8?B?YzVOcnUrbDVjZzRPRXVHTEV4MStYR0VCS3VPNnRWSjNGckFVUGk4YndXbjlv?=
 =?utf-8?B?UDVWV0U1TkF4azd4OExUTkFzdzFlcEVYNXoxMWR5L2lENEtnVnhmSi9zNTdE?=
 =?utf-8?B?RzN6aVFyczkzSEtEL05EYzN3S0NieE90MGNZU1dmdTFtVHJwUDRzQ05VQ29I?=
 =?utf-8?Q?Ey8M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7128372-833f-4597-75b5-08de0d6d138d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 11:05:26.3327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6xIvAjmOMVsro2Z5QZRzBF0HXWuJW669WWGUwW3JuM3oXHN2qf3Wk4Br7dA1QAfPu4LM0kxuTKZ1T6usih97Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB6071
X-Authority-Analysis: v=2.4 cv=O6U0fR9W c=1 sm=1 tr=0 ts=68f222f9 cx=c_pps
 a=3xBwYUWp8GiLX146WrkxpA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=y-uq2EpwT5cuG6ak1FwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EbNPyS0Xou3XCTXWJOj17d8vkXYElLWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDA3NSBTYWx0ZWRfX4Kizgc98h7Ws
 WbQbKoXR18J7ajySB8tfUQGaef2P1NmzP+yUuaaCamzCkS/QJVtSi0PUEx2eu4OiaxuU5sUDJxf
 V3lugnTM/50UfrwHn3E8FNGo1PKshgu8OfoUmLeWyns0et0UFx2CovlkGQINOCQoc/gZ6uZVh6C
 2qPY7CL4QYXigagLmyGZKCrN0MaLePYeO5OsuaeuxW/NecCax4jYcbpJrpyQprwaaibIQaqwBDd
 l1c+QrRzNYP+80IXSUKRCjOaRk1XiQDqDJeGcQm5axhvW38PzFe3t6I7E4hLibzJYxdES0ronTQ
 vsia9Yz2oyEs8cdl8/zkVXnm4rGqKjcMMGmBwKoXq9exCX0ZS/XBhCrdOUUJ0Fjg5FWP1NtH5pm
 Qvag2DCGt89jCYyHGbLnEj5t5ga8+w==
X-Proofpoint-ORIG-GUID: EbNPyS0Xou3XCTXWJOj17d8vkXYElLWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
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

SGkgVGhvbWFzLA0KPiAxNi8xMC8yMDI1IDA4OjU2LCBOYXdhbCBLaXNob3I6DQo+ID4NCj4gPiA+
PiBGaXhlZCBydGVfcmF3ZGV2X2dldF9kZXZfaWQoKSBmdW5jdGlvbiBwcm90b3R5cGUgYW5kIGl0
cyB1c2FnZS4NCj4gPiA+DQo+ID4gPldoYXQ/IFdoeT8NCj4gPg0KPiA+ID5bLi4uXQ0KPiA+ID4+
IC11aW50MTZfdA0KPiA+ID4+ICtpbnQNCj4gPiA+PiAgcnRlX3Jhd2Rldl9nZXRfZGV2X2lkKGNv
bnN0IGNoYXIgKm5hbWUpOw0KPiA+DQo+ID4gPk90aGVyIGZ1bmN0aW9ucyBoYW5kbGUgZGV2X2lk
IGFzIHVpbnQxNl90LCBzbyB3aHkgY2hhbmdpbmcgdGhpcyBmdW5jdGlvbj8NCj4gPg0KPiA+IFRo
ZSBzcGVjIHNheXMgdGhhdCBydGVfcmF3ZGV2X2dldF9kZXZfaWQoKSByZXR1cm5zIG5lZ2F0aXZl
IG51bWJlciBpbiBjYXNlIG9mDQo+IGZhaWx1cmUuDQo+ID4gQnV0IGluIHRoZSBkZWZpbml0aW9u
IGl0IGlzIHJldHVybmluZyB1aW50MTZfdCB3aGljaCB3aWxsIG5ldmVyIGJlIG5lZ2F0aXZlLCBo
ZW5jZQ0KPiBjaGFuZ2VkIGl0IHRvIGludC4NCj4gPg0KPiA+IElmIHRoaXMgaXMgbm90IGFjY2Vw
dGFibGUsIHdoYXQgZml4IHdpbGwgeW91IHN1Z2dlc3Q/DQo+IA0KPiBZb3Ugc2hvdWxkIGNoYW5n
ZSB0byBpbnQxNl90IGZvciBhbGwgcmF3ZGV2IGlkIHBhcmFtZXRlcnMuDQo+IA0KV29udCB0aGF0
IGJlIGFuIEFQSS9BQkkgYnJlYWsgZm9yIGFsbCB0aGUgQVBJcz8NCldlIGhhdmUgYSBzaW1pbGFy
IHJ0ZV9jcnlwdG9kZXZfZ2V0X2Rldl9pZCgpIGFuZCBydGVfZXZlbnRfZGV2X2dldF9kZXZfaWQo
KSBBUElzIHdoaWNoIA0KcmV0dXJuIDwwIHZhbHVlIGluIGNhc2Ugb2YgZmFpbHVyZSBhbmQgYSBw
b3NpdGl2ZSB2YWx1ZSBmb3IgdmFsaWQgb25lcy4NCmRldl9pZCBpcyBkZWZpbmVkIGFzIHVuc2ln
bmVkIHZhbHVlIHdoaWNoIGlzIGJlaW5nIHVzZWQgZXZlcnl3aGVyZSBpbiBhbGwgQVBJcyBvZiBj
cnlwdG9kZXYsIGV2ZW50ZGV2IGFuZCByYXdkZXYuDQpUaGUgbmVnYXRpdmUgdmFsdWUgaGVyZSBp
cyBqdXN0IHRvIGRlbm90ZSB0aGF0IHRoZSBBUEkgZmFpbHMgdG8gcmV0cmlldmUgZGV2X2lkIGFu
ZCBhcHBsaWNhdGlvbiBzaG91bGQgdGFrZSBhY3Rpb24gYW5kIG5vdCBwcm9jZWVkIGZ1cnRoZXIg
d2l0aCB0aGF0IHZhbHVlLg0KQ2hhbmdpbmcgZGV2X2lkIHRvIGEgc2lnbmVkIHZhbHVlIGluIG15
IG9waW5pb24gaXMgbm90IG5lY2Vzc2FyeSBqdXN0IGJlY2F1c2UgdGhpcyBBUEkgbWF5IHJldHVy
biA8MCB2YWx1ZSBvbiBmYWlsdXJlLg0K
