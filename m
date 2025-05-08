Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF82AC3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 13:53:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED5714026C;
	Thu,  8 May 2025 15:53:43 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id F419C4026B
 for <dev@dpdk.org>; Thu,  8 May 2025 15:53:41 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548DrflB016085;
 Thu, 8 May 2025 06:53:41 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46gsq28j8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 06:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJR1Ik+/vBxSi4mFkYRxonsIm/KwtlGC4SbbPwXLEbieNKxJ6+0I3+06FVhNxD3yrWQ+adjYrYl30SSBtnHWV74IfVmF2LFcFc9qJzdlUgZXC0IUvPszo5UYG2j3BAjUGyL/wUdioEM0pxYrQyxD+FbPLsvtdvpnuEozG6LI1pscikUvKjMcs3qSZ/GE9E5Iz6J4l0g8FHzwPVfFKHN+tbuVS9psZTmDhyFvRyt+3rzOyeHxQYDNlWd5df4rGauNAPrDHcE3ML0t6kzOM8IeXyLealoMvw1kh+1rQ7UeR5ZsU48+1m8IJBhifo77YYHESysXaCamFoCv+T61j09pZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqkg9G054/fmipaCN6zOTJJ15uE+EQjmYi9Jk8A/B84=;
 b=LA/hlFou83a4CKM6+EF6ZNad9iKVidbjhwPnqV2ZbjkJ23uGo2v1P3P2jI+lEPj4Xjc7FY7zLrubS4w/KqrJXIYi5amd5r2VQCPoxmRcOk1h4VyDeVfKuUtLZoGFVidZdiU8Zt/4nmum2Kgq9hE+ArzaDniNqwd9TxWy2zCuk5oDuRH9GBZSlm8KwOaCRJWDoUdl3Si2nuGngnE8nHzw1ZcpaI/KRnjwneqFTFz+MCO6rw141iRYa2rWDcgnIpcYXyZozTLFOgkuAKzVGX9vhDGrge/Mhs0pfeI8JQb9F+hsrztVvJgQfbrMQZuRORODYxag1rfnU2FMa6zs7Jul+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqkg9G054/fmipaCN6zOTJJ15uE+EQjmYi9Jk8A/B84=;
 b=GpzalLzDDjW3jdx8edDW4giUZInaVOoBgEgjLYQrVSlrPz5j2n5R4nHMNRNhTGgjlEsERCS3vFX4GPv1tZltBm+zvuwLG/ksnj+NTMAIUnV/gyiOX13bv8/WjuTwUJkbgKHkW1pdzXZBy8K0eGdLddaQKOcbzgzvUCZTUTp3Sdc=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by MN0PR18MB6040.namprd18.prod.outlook.com (2603:10b6:208:4a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 13:53:33 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 13:53:33 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Changqing Li <changqing.li@windriver.com>, David Marchand
 <david.marchand@redhat.com>, Sunil Kumar Kori <skori@marvell.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: |FAILURE| pw153190 [PATCH V3] Add new tracepoint
 function for type time_t
Thread-Topic: [EXTERNAL] Re: |FAILURE| pw153190 [PATCH V3] Add new tracepoint
 function for type time_t
Thread-Index: AQHbuY+7fo4eC9nvfESKIiSp8RhV6LPEF+WAgAJicwCAAlGOkA==
Date: Thu, 8 May 2025 13:53:33 +0000
Message-ID: <BY3PR18MB47853116D8C07076A91BAC3CC88BA@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250430013431.2056969-1-changqing.li@windriver.com>
 <20250430024403.2690306-1-robot@bytheb.org>
 <d498a836-e6eb-43b8-9ea3-bdb98ae4aaf8@windriver.com>
 <CAJFAV8zk=gzCagoU7c4=dsXcEFnLjiqrWxwTWANa-U77Uj=Taw@mail.gmail.com>
 <e6ca8bfc-06dc-4844-9b2d-f44436050165@windriver.com>
In-Reply-To: <e6ca8bfc-06dc-4844-9b2d-f44436050165@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|MN0PR18MB6040:EE_
x-ms-office365-filtering-correlation-id: b75dbf24-8a38-43f2-9cc7-08dd8e37b8de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YURic244QXhnMXJDV1NYVmE2aldQSjVqSmhuMlZ3ZVAxb0p5N0dnU29DRC9F?=
 =?utf-8?B?MnV1RFFiWXpWbEJQME5oUG1SSEdFTzlYM2RqUGZxR2V1dFh1QzFzV245eDc4?=
 =?utf-8?B?R3ZSNTZDRFhZMGpDNXN1dTlNbEtlQldvNncvUkxIL1ZXL0FDeGlXS3daMWtG?=
 =?utf-8?B?UDNuUjhnK1V2bGNMVnp3SW1RNUd6bzc4UXFzbUtRYkxIazkyQWV6Z3ltelpk?=
 =?utf-8?B?M2R1QkhQTWVOZGRuWmkxS01pNnl3U2crSERab29zVWxlWGNwc1RhOUhRT1Yy?=
 =?utf-8?B?bHp6RytMTHV1aUh2ZWF1SWp0RWYrTmRJZEptTUNqRmlCTlYrWDNhUjNpOVRt?=
 =?utf-8?B?TUd0bjhBbFBkNytZSzhGWFNNYW85M0had3RSOEtLL0xaVDB0S2VWVmovZHF3?=
 =?utf-8?B?RUt3bnBhNlQxWExTN1pwVnlGNmRjU3dCNTFzN0hZVVZYRzZZTjNEVGNUaGNF?=
 =?utf-8?B?REhydk5PUE00Q1l6MEJXNmNOeGduMDlPSGYyV1oydWRkYkRIMlhCRFM0L3pk?=
 =?utf-8?B?QW44TEx2QlBrMlVwcTFGa1gwN2lScWNvNkRCMmRUejhZZWlHKysvTUhjaVlL?=
 =?utf-8?B?QXVtQ09RTUwyTk5FUVR3Zkw0Z2lqMklhaDFleTlNOVNvODc2S1BjVjNOOEo0?=
 =?utf-8?B?U2NuaDN4QW5tazM3YzdlUUJmZ1N6YURCcFYzN3BIb1ZXKzlWdlRQcHYxTFVk?=
 =?utf-8?B?Zjhwak82UC9Ob2lHa25qNVlDL2VpdjZGdThyTGsyTUs2aERkVVRpNkZpWDN4?=
 =?utf-8?B?ZDdmL1VWSnU0d0dkaVY2ZTV6dkcrWjE0cVRDT3VuZzFaU3VkSFg5clI5eVlG?=
 =?utf-8?B?dlZSdmhYUk5MSDduVkVJeXkvZzZqd1hwMWR4STlxajVxZllSaDM3OUNTOHZ4?=
 =?utf-8?B?ZE9nU1BEaXFXTkh5RE9tajJodW1QYkd1bGkrZitmc0g4SVlONXV6UDE4ZXRC?=
 =?utf-8?B?YzFsWVhUVVdQbGlvUGVyUlhWTVhhaVRnb096a0grb28xWmxvU0x3eUY3bGRq?=
 =?utf-8?B?b2w4cWxraHBTc2phekRXbTlCS0xnb09LNkswL0VzdlVRTDlHZ0JtK1o0eXpx?=
 =?utf-8?B?Rm5SY0Rma3RsRzU5cEROdXRkd0RPM1hIYzVWazBGN3ZSQnVKV3VEbEtRWUNt?=
 =?utf-8?B?Nmh2dWtMMHhvSFU4SVI0MXFIOVE5cnA5K0xxUFBZaE1mbUZEcHY0N3lPWUJL?=
 =?utf-8?B?N3dHZFUxOXY5RGpNOXRQQXQ0U0puMFFtU1ozeVRtK1RBc2lJVXNEVVdmMlIx?=
 =?utf-8?B?VENnTUF6eHpEM0tQU0dMTzBrL3BYSEdBenR4K3hVNzkxclJzb2g1a3d6Tlkr?=
 =?utf-8?B?M1BTOFozVTh6Nm5EMzZ1N0t4Q1VJelE3eWdnTlZ3QzFZQzRLMTNEQzZuN3g2?=
 =?utf-8?B?aGliRlBrUzkrSCs0ZHNNWHZRRCtaWDNTajRCN2czb2pFY3RpWEcrVk1PY0V1?=
 =?utf-8?B?NnZUM0pybGlQbHNCWTNDOVZ6dWNqVUM4SGoxV0Y1aEZtZVRidHFuTXRCbWhr?=
 =?utf-8?B?MU5VZTlSTWs4OVNHNHYwZ0toZkVpK2YyZ3VkT3d6YlFxYWIyT21YSHZTWlc5?=
 =?utf-8?B?TDBTZ0pKOFo4eWUzTEFDNUJVbEdpenFiZS9CQzRta3Q2Q0dtM0Fha1hxa3Z1?=
 =?utf-8?B?QzRGWmo3dXU3NzAva215TUIwMjRjUGh5WXJrWjJucVowUGk5M2c4MjFGMk1i?=
 =?utf-8?B?elVHTmxxRG9oRkIrVEl0dnZrTnRTbFJaeFZLSkZyMlRoQlZWVzNUdUZDdVE5?=
 =?utf-8?B?V3JKUGM5eWo5MUNLdmxCWDd3VXR4RytaUkFaWVovTko1VXU0dXVMNStYWWw0?=
 =?utf-8?B?QmoxVWJCYWRHN2xRb3ZVWktSUFNpcjdPNUFNTktpckQyY1pFZVRLaFFqcndU?=
 =?utf-8?B?V1JMMFFYcFhMbDJuVExuMFhlZ3YrWWNtYVBGeGpUQS9DdURwNlZMdUdrSFlM?=
 =?utf-8?Q?VIxU0oN7R4E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dktJSzBjUXp0TGpYUldJRkpmV3VhbDJ3RWNDQjZqaUlKL3djMlFpTmVESDRy?=
 =?utf-8?B?SW8wN3JYSmhOMjVwZmJoTFZOdFNlMXA5VWlhVFZEcG5weDJpbGQ5Z3RvbWtX?=
 =?utf-8?B?YlZCVjJxbUxEK1BKUTJYUllCOG5qQUxzUzVQN0pIK3ZPeU92ZkM5SGFUZGh4?=
 =?utf-8?B?Q2tlQjNieUhKU0ZnblJnbXVUYmQwTFlzamlibTEvZHlRU2RDK2s3d2c2UTlw?=
 =?utf-8?B?ZVp1cGJNQVR5SlhWbGtRdVRzdDJVWXp5UDFzS3FheVhyYkRzNW5DQkNDd0FZ?=
 =?utf-8?B?YmtESFVvbnc3K2VYMlBDeWpxUm52eTNRK0VIS0s2T3dsUXhIbDFMUGxGemN2?=
 =?utf-8?B?MzVUTUN3c1JWeHVMN09qOThRTTluckFuVzJJRGh6ckVxNGZ0T2VScitaY0N0?=
 =?utf-8?B?RjRMRUxzRTVFK3JMOXVzdXduTS9wUmJTU2dGVkFxcDNqdUxlT0J2WXhkaHp2?=
 =?utf-8?B?TXB4ak1EMEVIbVRoUXR4WVEzbS9jakM0VTEyYVhBdmViNXhSWDkyWHF0QW9D?=
 =?utf-8?B?clVYcWRrMVBOeThqaU01TlFYbmdVaHVVcFcxMlUrMko3RFpHdWRXbXpGL3VE?=
 =?utf-8?B?TmVpdEk0ZVhrZENRK09CaU82QUdkSmxCcXRHVWpMMjdxNzVUN3IvR2JNbkYz?=
 =?utf-8?B?Q3dBVXlNMy92V0toR1QvSGIwQ1J1OXpzK3FOSEw0V2ROZWsvWXBBK3NxUkV0?=
 =?utf-8?B?NG5peTVUOGRSdnZTeGdGSlE3bmZDWFUzNHRjTThQdmZnVlVrTjdBaFN6Q1Nt?=
 =?utf-8?B?SkVOTDNaTGJVcHIxOFpET1UvcjVSVXlGNUIyVDZ6eXA1d0RUQXNsN1dPNWg4?=
 =?utf-8?B?eGRWTHpXaGxrUHlubkc2RC9tNmF4S1dHcGVUYVJQTTBLUTUxdUtXSkh5MFND?=
 =?utf-8?B?Q28ya3pod2tZZVhTNkp3aGdyRm12WEhUS1RBeWo5NkxOakdYVndLTWZmc0Rq?=
 =?utf-8?B?c3daR2s5T3FDdUx3eGpWUE13azNZTVFVanM3QXFMS2dFZEpQTXFMcGJaSHNp?=
 =?utf-8?B?MUo2emM4bnVkR2dYY1hpTFA4UWJZR1VOSkpJalFXUnBZTCtpZm9lR2N1dUUx?=
 =?utf-8?B?MngyNTgwOGYvcmFnMnpNR1JveENNWEI4bE9lVzRRQmJjV2QwdGgzNjZpYjR0?=
 =?utf-8?B?N0d3aWZucngvMzVWWlkvaklVK2c3T0xBenJ5YjVNWjVReG55Uzg0ZS90OGts?=
 =?utf-8?B?RlE0UjJiK2NNUS9QODVhOVJHWGk5UmsydUlsaUwvUmN4Y3dHc3p6SmxYZ3lQ?=
 =?utf-8?B?NGZoUGRORXVKUXdpNGZBUStmd1psb0JoNEtPaUhMWGJxY0RiNWcvaEtLd0lZ?=
 =?utf-8?B?UHJFMCtqRzByRmFvbTBvclAzZWZuTnM2NUttaXFqeXNsZ1BTekthd1l3TDQ1?=
 =?utf-8?B?NjNyZDdINmdlWnV0MFNXN1d3aTl0VURTcGtrVnRjYkRNY21WYUdJQWZkQ1R0?=
 =?utf-8?B?OWdESjJPVnFOdk5OS3kzWXdEYzBCS1I5VjRQSlVSc0RNZ2h0MmpCMjVmV1Bw?=
 =?utf-8?B?aHZBamtWYk85elVQVzdqT2xNUjF4QVpEcU9ibys1Q2xJdnFMVmNicjFjbEJj?=
 =?utf-8?B?NzAvZHIyT0RsSWo2VFNmQ01Md09JNnkxVnlUNXVkbUVWWFhPemkxenpVTU9H?=
 =?utf-8?B?M20vaWZIclJGbFFxSVRvMHUwc1p2VWZONTJhLzU1QUQ1Z0pVVUpZSnJrZXgr?=
 =?utf-8?B?QzRPQ2ltLzZxM01Pa0JXbVFvWnFhK3YvWXNnaEhFNlhnSHM2UkRteWlXRG5m?=
 =?utf-8?B?emxZOVlvenNIYzJ1dmE2SzNxS3d3d1kxSSttN2VndVQ4VGZxMCsraGQ1Z0ha?=
 =?utf-8?B?eFVSR2FYQ05sb1BiTEt3MTgzWlZua2ZSYllZaUhZbGhxSTRTazlDUUh3K3Bn?=
 =?utf-8?B?Mk9CU3R3UFVWajJWZVlRZzJ2Nkw1SkoxYjlqeFZuSzZJdlRiWG1Zd0pJZXVw?=
 =?utf-8?B?TVlxV2ViK2xLYXhRRlh3RnJtRVZqUVV5aHdNaThWZFpSeEs2Y0lnUTRhakk4?=
 =?utf-8?B?eVJ2QzNxbkVYckV4S0YwbTFseE9FT21vTk9sYUR2OGRDYU9NYUR1MmpUNUJm?=
 =?utf-8?B?ZkJRWmFFMGZGYW1FS2M2ZkR4L2lNekwvU1BsMkdTbjVzVEVpK1dBR0Fmenlw?=
 =?utf-8?Q?2URQDMPvcMfFC3yu0+0XIAvMi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75dbf24-8a38-43f2-9cc7-08dd8e37b8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 13:53:33.2111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0c8qhnyHcyT0qLxW/J0ShUqw9HIPnZH61928KNAqGVKOmSVyVzj0kYNs8vByTPGuKH2HYqpuLujSUvUSdZnVMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB6040
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDExNyBTYWx0ZWRfX8x4CLa3kW6Ex
 YeaDx38nExmkC0BIBX+gLxGP4AcM42Qbe++K3aBrF/0nh1Rq/lM2O/DhEEUJ1RqIsRmDhrR+L3I
 OCLRpaijsvDEWxKeHbKRpbqapyhyc93i90lhMQEOeSQyqrrQxOBSdzinaFwc9rbstyf8xHZ0as/
 OCwkNz+2ujF/mfs9XN9PuKfYdRTNCfuB/HjBN50H0O+u2zPblWJeSQCAq3LqzFsyp8pw+2T9ugF
 K6F6riBw5DSsnTlQ+ttwh03N3/fKJVbJy4JkmjtN9fgimT0CFjaQe6XvKjZzLLh0k0+xHUNefor
 Rt03dT9Hlodh5sASOLMA54gYHJHt99YjE6GwATrxZonoo2BiOuK3EeLoy2m67kwGB03bpi/rw+H
 YMo7SJkOKPwbo32vQc6myqviVd1+EBvEF2Qsp91H9CJW9TTiyFCy1BG3DHLHc9TtzXrVVIun
X-Proofpoint-GUID: O3cNA0bWcFoLgrf3ZNeHLFHuMZSMH971
X-Proofpoint-ORIG-GUID: O3cNA0bWcFoLgrf3ZNeHLFHuMZSMH971
X-Authority-Analysis: v=2.4 cv=cYDSrmDM c=1 sm=1 tr=0 ts=681cb765 cx=c_pps
 a=e6lK8rWizvdfspXvJDLByw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=DnJVbuqOAAAA:8 a=f9wg9kJk9zlVhBACJloA:9
 a=QEXdDO2ut3YA:10 a=Sz6ghim2xQgRqd81wKBx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
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

PiAJCUknbSBuZXcgdG8gdGhpcyBwcm9qZWN0LCBhbmQgaGF2ZSBubyBjbHVlIGFib3V0IHRoZSBm
YWlsdXJlLA0KPiBjb3VsZCBleHBlcnRzIGF0IHRoaXMgcHJvamVjdCBwcm92aWRlDQo+IA0KPiAJ
CXNvbWUgaGVscCBhYm91dCB0aGUgZm9sbG93aW5nIGZhaWx1cmU/DQo+IA0KPiAJCSsgc3VkbyBi
YWJlbHRyYWNlDQo+IC9ob21lL3J1bm5lci93b3JrL2RwZGsvZHBkay9idWlsZC9hcHAvdGVzdC9z
dWl0ZXMvcnRlLTIwMjUtMDQtMzAtQU0tMDItDQo+IDI1LTIxDQo+IA0KPiAJCUVycm9yOiBhdCBs
aW5lIDI4MTk6IHRva2VuICJ0aW1lX3QiOiBzeW50YXggZXJyb3IsIHVuZXhwZWN0ZWQNCj4gSURF
TlRJRklFUg0KPiAJCUVycm9yOiBFcnJvciBjcmVhdGluZyBBU1QNCj4gDQo+IA0KPiAJSSB0aGlu
ayB0aGlzIHRpbWVfdCB0eXBlIHlvdSBhZGRlZCBpcyBub3QgZGVzY3JpYmVkIGluIENURi4NCj4g
CUhhdmUgYSBsb29rIGF0IDIxMTQ1MjFjZmY5MSAoInRyYWNlOiBmaXggc2l6ZV90IGZpZWxkIGVt
aXR0ZXIiKS4NCj4gDQo+IAlDb3B5aW5nIHRoZSB0cmFjZSBmcmFtZXdvcmsgbWFpbnRhaW5lcnMg
d2hvIHdpbGwgaGF2ZSBhIGJldHRlciBpZGVhLg0KDQoNCg0KdGltZV90IGlzIG5vdCBkZWZpbmVk
IGluIENURiBzcGVjLiBTZWUgaHR0cHM6Ly9kaWFtb24ub3JnL2N0Zi92MS44LjMvI3NwZWNpZmlj
YXRpb24uDQpZb3UgY2FuIGNyZWF0ZSBuZXcgdHlwZSB1c2luZyB0eXBlYWxpYXMgd2l0aCBpbnRl
Z2VyIG9yIHN0cnVjdHVyZSBhcyBiYWNrZW5kIHR5cGUuIFNlZSBtZXRhX2RhdGFfdHlwZV9lbWl0
KCkgaW4gRFBESyBjb2RlIGJhc2Ugd2hlcmUgd2UgY3JlYXRlZCBuZXcgdHlwZXMuDQoNCg0K
