Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC13C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:22:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B8F740E4D;
	Wed, 21 May 2025 08:22:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9552A40E34
 for <dev@dpdk.org>; Wed, 21 May 2025 08:22:30 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KNkIPb015649;
 Tue, 20 May 2025 23:22:27 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3purk6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 23:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoEJdWaZ1L/4oQjXCa9qhgBqPxYuhuI+wsL6bUTtTKMxGB6du774KlZvO5VVDZaM7uatewIo+PzsgDkLf5rFQbr5jEJNTfJeyfyzylPcDSNn7DC1FVzE3mJ3nphPmrSfZOdcaWblUm2bBAw/Fi5c5oh42Mq6GKQImv4zg3DapuQ3KbNW8BCxnd3yUNC7fZIR5efoa4x8vh+BJvf0/L2x/0x4K07/48wcx5WbTDlMsADV//ddAC6Zi7jiJPHjVUXfwoR+Killc4iYwb2hGKroQZVbER4xIgqIsV3d+j0f6KY2NWI4XPaWccsd6qQLjgS/h0uuW8eD6y21JyUjvp0U6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX+uPXMuA8LWDI84TV/AJxmVUheJhYB9mqDzlRCTVNo=;
 b=mph2725cUT+Qo+VV0MChwU5h4PrpXEpTO5RLCto+040Kdzs/NoIn5iO8T4Oqhsexq49l28lBClI3DENCezWF8V6id22uiHurGMEt4O0Ejw0m5ZEdEdtq8P5Px8fTkWRWoVVA1PDv24p25JNSxHGw+kalusJ7oTMR+s96AwGyRh1U1np7zTJ/dX9LVv1uYwPzkxJkum7hASEnpuS4zXDtcfIwqDc/qSZqMMsOkk+pIFrnokhnxEIzE/OSOn1ItZb9PVH1MVCxFrpnNTi3izXLE3hwqIQEclOOf1mqPas4vNKcSk7oaHm+m1p1Qv/5v8sX1FbwgdaZHXs182PjrBEJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX+uPXMuA8LWDI84TV/AJxmVUheJhYB9mqDzlRCTVNo=;
 b=aIMApAv/Yr6dyITDbKZQw8wSwMo22BjqjyGrnIoX8NiTCfp4YeTsEADv7nTMiQefhhVVz20A+cFELamA+ptRlSbLHO3WDQBHzOyd2H7FvOo12pMDgCiQu3vvBJweMDMZUDmNOtN3xs/Er5wf7QDI2x5sth+TEuaTP9FmF8/VqH8=
Received: from SJ4PPF18AE1ADF7.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f0d) by LV8PR18MB6045.namprd18.prod.outlook.com
 (2603:10b6:408:230::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:22:17 +0000
Received: from SJ4PPF18AE1ADF7.namprd18.prod.outlook.com
 ([fe80::453e:c08:d666:9e26]) by SJ4PPF18AE1ADF7.namprd18.prod.outlook.com
 ([fe80::453e:c08:d666:9e26%3]) with mapi id 15.20.8678.028; Wed, 21 May 2025
 06:22:17 +0000
From: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH v6 1/2] ethdev: support RSS based on RoCEv2
 header
Thread-Topic: [EXTERNAL] Re: [PATCH v6 1/2] ethdev: support RSS based on
 RoCEv2 header
Thread-Index: AQHbvYKUT5suUqIUc0yzBdaIP3AWJ7PbuXyAgAD8hyA=
Date: Wed, 21 May 2025 06:22:17 +0000
Message-ID: <SJ4PPF18AE1ADF75C98EEC48F063DA7A3F8AC9EA@SJ4PPF18AE1ADF7.namprd18.prod.outlook.com>
References: <20250505053304.3288290-1-kirankumark@marvell.com>
 <20250505055717.3697335-1-kirankumark@marvell.com>
 <20250520081709.105c8b84@hermes.local>
In-Reply-To: <20250520081709.105c8b84@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPF18AE1ADF7:EE_|LV8PR18MB6045:EE_
x-ms-office365-filtering-correlation-id: bb90f69d-685f-49b9-dd4e-08dd982fd5aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?Q042UXVQeHBxajVEUXRtdnBRMkVycEgyMHpLMnVvOEpVSlVZbTBkREs2RU1u?=
 =?utf-8?B?aFdnekJjbURrSG5QV2ZhVWFNUkFib2plTWxndDVtZXhnUEc3WFdkZDNSS2Ew?=
 =?utf-8?B?NE5BWGZxVXpFZ2kyOXNHd2o2NXJHOE0yMHp4WUN0ZW9LTWVLTHphNEw5d3pM?=
 =?utf-8?B?bzhxbGxVT01pS1VXYWdCaERXN3dNQmdBVHF6SURERURLeU1SQXBGajBwTmxP?=
 =?utf-8?B?aXN1d1ZpS1V6L0xyMm4rd25hY0l3dVFQVTBHTFM3Q3ZYRGxIOE8yV0R1MWdG?=
 =?utf-8?B?NzZJQ3V6cEk0MEJYeUtKbFVhcjV2amNPTnNnYU4zYlBBdk9obFMrWHZ2cDY4?=
 =?utf-8?B?UGg4MDdVL0tBSjBWM3VwcDJYSFAyUlRLcHh3Zk1oQmljYlYxWHhsT1lXdXNU?=
 =?utf-8?B?Q0ExL1hmd01oRWhwZWcrT2RnRkM5cy92MWtybFJGaUIxd0JJWXZ5M3VRVWpG?=
 =?utf-8?B?aEUzNDM4ZE42WlkwQzk3c1ZVSUJxa1Z1akZKaU1IcFNua1U4cG1FR1dsYnll?=
 =?utf-8?B?aHpIOU93ZDhuVFExK0hvNDhmQzRnTnlHRzVDVit3SHZuNU5kd0JZSitRUjln?=
 =?utf-8?B?eGhicjVBWEJZemlnS0NSUHFLWEZQRTZjVnZUUlBEcDdrcWVibzhCQmp4YjFW?=
 =?utf-8?B?THJad25EMzE2SzRqMVRNRzE5ckVJWXRvRUQ0SlVRZXUvaHJSblUvWElZSjdM?=
 =?utf-8?B?dy9uMGdIOHEwLzJEaVZQbjhGLzM5eXJxc1A0ZkllYzdrYmhJcWNJZzRvMmNx?=
 =?utf-8?B?Y3o5SmRCK0pBOGxFWG42N1YvUk4vYnEzSkh3Um5ROXhBSS9OcTA3L1NYRkRh?=
 =?utf-8?B?ekMvREVRYlQxWGN3M3d1ekI0TjA4WWduZzI0MUIvOWZJMFpEMmJrNUR3aEpI?=
 =?utf-8?B?NmNHQnJ0WU9zQ0NKdllVUkhFVUN4L0FKMkx4N05NemtlZGNHVnBuQTdJL0Vj?=
 =?utf-8?B?UWR2S2dkNnlMTzlrZ3AyOVVYZUZCZzRUNFFMRGlHaGJXMFIzTE1jRFA3Z25w?=
 =?utf-8?B?MXNrc1RmUFEyUWJ5c1ZDSjA4clJyNDBCNkh3Z0ljVE80R1ZNTGdhSXJzNnh1?=
 =?utf-8?B?TTBDWWg3Q2ZOUWVzLzM3SFBOWTRaS0F6ZTVnTU9kU3AzcjQ4TlBSZXFHMm5l?=
 =?utf-8?B?a0tyTDlsaXRBeU1Lb3lYaXBXZVQwamZ5V29LR0M2R1QydXFScUpubVVTMEda?=
 =?utf-8?B?MzJsY2NnTW1uVmtZZTUxOHRmanZ6MHVjYUN3cHIrSERGNkdCcWJrazAvNlQ4?=
 =?utf-8?B?Q2lHTHRkUlljNVllOWs4VDhvNkFzZzhKaU1mQzZaZ1hWRmtJZUxVOGpOdVFv?=
 =?utf-8?B?eGp4R3ZTZ1JveGV5YUc0VDN0dTE0cGNBYUF0U1VlUk5FWkZJbm83M0sramdW?=
 =?utf-8?B?RWpQTC8rOHVaYkZ1UFF4UXVGSkFVdUpLSTdtTTBoYm5iNzRMVFEwM0NkSGZ2?=
 =?utf-8?B?Qm1rK2hyMnRMdVpJVE5kYjhldlY1L2VpblVuc2JwUUNOS25MN01TcVRZVUlU?=
 =?utf-8?B?Y2dGVnRnL0NMVFdaNlVpcGR3U0l6NDlTOU9qLzVpWTI0OWhxWmgxeURGcmNC?=
 =?utf-8?B?TEJ3Q205bm81LzZLZDlLSVhBOTFMcGNxYWJXK0lwWVNxQW1wOHpzQmdkWXM1?=
 =?utf-8?B?YitEQmQxYWxGdGtMQzQvOHJWUTZiTDhiV0E5d0paQ202Q1RBVDZvTDhVUkZN?=
 =?utf-8?B?REVpV3kzM1lTbkNYUjNzMkNSektjVGlNUXg2WldPb2c3SGFlcjF5aFJpNVNw?=
 =?utf-8?B?Zzc3OGx1cUc0VzE5NjlOVUhYR0VIUE80UldYT3VMRjJ1KzJGN04rZlFpdXYx?=
 =?utf-8?B?eHBtRTJYSkFicWk1Z0NkYmhJWGx4akw4ZVBXamdPRytYN2V2eEVmYzZPMFdy?=
 =?utf-8?B?R1pHOHMxRi9ZUGtJWmVNRkhzQnM3c1YrS1kzS0R6VGpyaGVTNDNFdnJnajdB?=
 =?utf-8?Q?BAj3Tsk7K+0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPF18AE1ADF7.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnRYY3NjekMycUNaSVpaWnh3TVNqTUtPWlBMcmJxQUVsalB2bU8wb2hrNWxR?=
 =?utf-8?B?RDNRbUQ0VU5XWjRZTkRKMDhYakl0Z2Jpb29Eb3Y1emhtM2huNmZyS2UyQ2dF?=
 =?utf-8?B?UVloOUZOL0Y1QVB0UnhPMldCRE9xQWRWRThkUDFTTVpNSlRxN1VYbk9uVC8x?=
 =?utf-8?B?dmNxaEVIbmpwSVN2bTE2Ym80a0NILzZRZk9oZTlTaklvb2h2ZEc3aXFmSEY0?=
 =?utf-8?B?ZjNmV0orOHRPK3gwU0tPemxZQmZtdW9kM25yMnZ4azJGRVhyYmoyT0xDUksr?=
 =?utf-8?B?b3lXRFcxYmtlR1cwQzR3c1JrS0pDbkNjZFJGZkQzSmJtRXBUNllkaEdxSVp6?=
 =?utf-8?B?dURFTXNWTzB5dlp5ZURERXoxcEtrMUxubEJkcjNhcGdxbVJSZnB2NldxS0lk?=
 =?utf-8?B?eml6dGFXRXRzaFN4YzU2RjhjaGh0N3pGS1FsTDY4SU41Y2w1OEUzYXM0UzBx?=
 =?utf-8?B?ckVFS3ppMnFMTjRSakFjQnRxOHJpSlBHTjRjWTEvVGQ3Zkd0ZWY2RExMLys0?=
 =?utf-8?B?b3MxczRQK3RpL2VzN0FUMVZ6SUpEeDBIYXdnTmVDUHJmRlJIS2hTVEt1Q01Q?=
 =?utf-8?B?TzBkRTJob29XanJkL2dCME1TWUxRWlhLNCtMaUlxRzBjV2RyYXVPRjBsZ3k3?=
 =?utf-8?B?b2JNYVhMMFdGZ2MyTlArR2d1QkFKZUF5NEVLRGtnS1cvTFpOSWQxaDRzN2h4?=
 =?utf-8?B?bFNxUVVnRFNFUllvZEJ2anNHUkcyaTBaRGVUSjRTcXo1RWxaWmhwRUI2QTVQ?=
 =?utf-8?B?WTQzRG9YYkphZzRDdTRnV3Bkc1hNeGZhL0tqTThHRk1Ya1pydWQwV2x0L0xS?=
 =?utf-8?B?VDErVUU3MXQ3K1J5QUc4VXpzOFA3U2xPbmZheEJsR3l4ZHJKVmJENHYxa0pS?=
 =?utf-8?B?K3R1Wnl3MkJDU3gzazd1K2IzcGZrd3dXQi9XS3JJTjFHUG9NVXBOU2pUbmdG?=
 =?utf-8?B?b2NmL0E2c0VKaThLa1JJSTAyVHFaNFpVajA2S1NiMnJYUWdZU0dEZ2FSWFBa?=
 =?utf-8?B?WmdMQlZYSGo4L0pBdm5LYmIrRmMxeFJEN0dKam9xL0xWVlJ6MUI5NHVESkd0?=
 =?utf-8?B?ZkdpZFQrcS9DK2djVHVuT1lUbURwQjdmWE1TajFibTEwS01jencxS29nekRH?=
 =?utf-8?B?RCtWb1c2ajRYQ1crdTIrOWNJS1RjY3MxS0c1ZjQwTms4OFJYVU5ZN09TRVk4?=
 =?utf-8?B?cHZ6cXB6YXVYVFgzZCs1WFlvN3RRWDNJMTJjRzFidVMvVnc3RzJXNmxhS3pR?=
 =?utf-8?B?WDNtMW92ZUlndVlWdFZvWlZtU2ZKbEFxRXdUVUsyYlRtOHUxZHFTQjdiRFZ6?=
 =?utf-8?B?QkZNM2tJTXpGZGw5UmJYM2tNTk8zSTZmWWt2YXEyazJuYXZES1h4QS9Zclho?=
 =?utf-8?B?Z21SYkljNU5TbE5LS1lwd0JINGFFR1Z5Sy9FMVZLRzFLbkhITVo4YmRuU1Ra?=
 =?utf-8?B?NFc1blBab2RydzdEdjd2end3cUw5ZVp5TjdFcDYyekdVWTdVcmJuK1ZYNVcr?=
 =?utf-8?B?SzhSK3lXSHpCbEVNVHFXT3lUT3M1Sy9ETjdYRCtuak04Wk9tek11a1EySjRh?=
 =?utf-8?B?OTdsZzZNTnVoV3RDYzN0cnlMampMRHRrN1p5cjNwRjNyaWNIUjFTUGxXTjR4?=
 =?utf-8?B?d1FyZUd2S1VWQkl3L0hrcE9LbkJXdXVFeEN3bDgveENqUnlaUlYrS0RCb0lH?=
 =?utf-8?B?V1JmU0ZmV2t2ak1BSHkxb0JtZjUxdHdkNlJzQUh5WUN3dU5xT1ExU29iTVJr?=
 =?utf-8?B?eDZBYWFpOTZ2NTE0SmV6dkZETlNHUHpqWFNCRHg0N2NSTlI4cDBHclJ3OWV1?=
 =?utf-8?B?ekI1VW5UazdsenFuV21YaWNZSjg3R2M0ZVJIMk83L3dPWGpOV0JpcmpGWEl1?=
 =?utf-8?B?cGs4MWpQUXpJNHNaYThlc2wvM1R3bzh6SnBHQjBjY0ZHYUdoaEdTc0U0dFdo?=
 =?utf-8?B?T3BXS1o5VDQyUTdmQkVybHhHNHJqaXgzS1YyVEJpVFpmQkNUNXRLZFhuL1NM?=
 =?utf-8?B?UGs4MjQvRFV3MTRhUDE5cFZkYnVQYXF5RnlsbDFLWVczbFEwcE1CdzlGS3k2?=
 =?utf-8?B?QUJwdzlZNjU3c01IOWpEZFdpQWYvNjlITjRZVUhGc2hTRW10TjhCU3dMeWxU?=
 =?utf-8?Q?HMdhBrB/jIRudmFgVAZZDoLHJ?=
Content-Type: multipart/alternative;
 boundary="_000_SJ4PPF18AE1ADF75C98EEC48F063DA7A3F8AC9EASJ4PPF18AE1ADF7_"
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPF18AE1ADF7.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb90f69d-685f-49b9-dd4e-08dd982fd5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 06:22:17.2060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rl3rPSqaOc3DtInBI3+fORBlIXmaRnrR+LqL4JMOodzRCqgeMuxVP6EfCHC3lYkwU9QJbF2NtAVXqt/6qVxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6045
X-Authority-Analysis: v=2.4 cv=SMtCVPvH c=1 sm=1 tr=0 ts=682d7122 cx=c_pps
 a=GoGv2RwMe+/7w9MjyR+VRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=jZVsG21pAAAA:8 a=M5GUcnROAAAA:8
 a=QyXUC8HyAAAA:8 a=bt5KbKNvAAAA:8 a=zd2uoN0lAAAA:8 a=pK7X0mNQAAAA:8
 a=8rWy6zfcAAAA:8 a=dtRhXEUe8RYxJtPwphMA:9 a=QEXdDO2ut3YA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=Lll6bzLl9I5ircxO5O8A:9
 a=gtF3YfeBeBYzKwRB:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10 a=lqcHg5cX4UMA:10 a=3Sh2lD0sZASs_lUdrUhf:22
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=5HA-qpC1VU4iIGLgRoNS:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: q83oW3AUk7KQUgSt9yQWKLaj-rDkaLlk
X-Proofpoint-GUID: q83oW3AUk7KQUgSt9yQWKLaj-rDkaLlk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA2MSBTYWx0ZWRfXwTjDsIe8dcrk
 8gH0Dnka1xat3/yVr97kVFxmCpVFz/emYpX9ogkhJOeDBMEyWPkMvTUdBDpNsFy2waUjVzCUSjn
 nCNTmKtqD72NFkTyy3+wn2G1oPKT2zXoa/Q+bfArYuvt+qc8vt8we/4Lb6QfdWRCQsQps/eBKfj
 0tjy1dcpb16cShKWDnUmJkDSBG1cg3UAp8s8SupXBIHJh4reHelxc5FhihErTXHyuyrP5tVmToW
 KRAhIue+AO+GG55umWW50VpCGEJEGztLSqfqfSLgTBAUqGCPSWxij4DS28S18ryNJZgKmk0mWnK
 SNID4awzD3XyLjlxkFmDS17Q4Xai9bZLaflwfprtnABwQa4lj1QoJ4tZVRu//A0CqhlXti6klmF
 9xFnrsw7wnkp8alMmeWQ2RNSh7GI6GJ0QyVDR4EU3SlBoYRnU7f2YdFA8Ta1pnKtJ+/Ou+X2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
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

--_000_SJ4PPF18AE1ADF75C98EEC48F063DA7A3F8AC9EASJ4PPF18AE1ADF7_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Tuesday, May 20, 2025 8:47 PM
To: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
Cc: Aman Singh <aman.deep.singh@intel.com>; Thomas Monjalon <thomas@monjalo=
n.net>; Ferruh Yigit <ferruh.yigit@amd.com>; Andrew Rybchenko <andrew.rybch=
enko@oktetlabs.ru>; dev@dpdk.org
Subject: [EXTERNAL] Re: [PATCH v6 1/2] ethdev: support RSS based on RoCEv2 =
header

On Mon, 5 May 2025 11:=E2=80=8A27:=E2=80=8A15 +0530 <kirankumark@=E2=80=8Am=
arvell.=E2=80=8Acom> wrote: > @@ -149,6 +151,7 @@ const struct rss_type_inf=
o rss_type_table[] =3D { > { "l3-dst-only", RTE_ETH_RSS_L3_DST_ONLY }, > { =
"l3-src-only", RTE_ETH_RSS_L3_SRC_ONLY


On Mon, 5 May 2025 11:27:15 +0530

<kirankumark@marvell.com<mailto:kirankumark@marvell.com>> wrote:

> @@ -149,6 +151,7 @@ const struct rss_type_info rss_type_table[] =3D {

>           { "l3-dst-only", RTE_ETH_RSS_L3_DST_ONLY },

>           { "l3-src-only", RTE_ETH_RSS_L3_SRC_ONLY },

>           { "ipv6-flow-label", RTE_ETH_RSS_IPV6_FLOW_LABEL },

> +        { "ib_bth", RTE_ETH_RSS_IB_BTH },



Please follow convention of other options. Use minus instead of underscore.

Consistency matters.



Ack. Will change it.



> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_note=
s/release_25_07.rst

> index 093b85d206..d1293893be 100644

> --- a/doc/guides/rel_notes/release_25_07.rst

> +++ b/doc/guides/rel_notes/release_25_07.rst

> @@ -55,6 +55,10 @@ New Features

>       Also, make sure to start the actual text at the margin.

>       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

>

> +* **Added new RSS offload types for IB_BTH in RSS flow.**

> +

> +     Added ``RTE_ETH_RSS_IB_BTH`` macro so that the IB BTH header can be=
 used as input set for RSS.

> +



Please add reference to the relevant standard and expand the acronym

at least one place in the documentation.



Ack. Will do.





> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h

> index ea7f8c4a1a..edcd6b75b5 100644

> --- a/lib/ethdev/rte_ethdev.h

> +++ b/lib/ethdev/rte_ethdev.h

> @@ -602,6 +602,7 @@ struct rte_eth_rss_conf {

>

>  #define RTE_ETH_RSS_L2TPV2             RTE_BIT64(36)

>  #define RTE_ETH_RSS_IPV6_FLOW_LABEL    RTE_BIT64(37)

> +#define RTE_ETH_RSS_IB_BTH                        RTE_BIT64(38)

>



Why is the acronym IB_BTH rather than ROCEV2?

Wouldn't it be clearer if it followed convention?



This is to keep in sync with RTE_FLOW_TYPE_IB_BTH

--_000_SJ4PPF18AE1ADF75C98EEC48F063DA7A3F8AC9EASJ4PPF18AE1ADF7_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Stephen Hemminger &lt;stephen@=
networkplumber.org&gt;
<br>
<b>Sent:</b> Tuesday, May 20, 2025 8:47 PM<br>
<b>To:</b> Kiran Kumar Kokkilagadda &lt;kirankumark@marvell.com&gt;<br>
<b>Cc:</b> Aman Singh &lt;aman.deep.singh@intel.com&gt;; Thomas Monjalon &l=
t;thomas@monjalon.net&gt;; Ferruh Yigit &lt;ferruh.yigit@amd.com&gt;; Andre=
w Rybchenko &lt;andrew.rybchenko@oktetlabs.ru&gt;; dev@dpdk.org<br>
<b>Subject:</b> [EXTERNAL] Re: [PATCH v6 1/2] ethdev: support RSS based on =
RoCEv2 header<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"mso-line-height-alt:.75pt"><span style=3D"f=
ont-size:1.0pt;color:white">On Mon, 5 May 2025 11:</span><span style=3D"fon=
t-size:1.0pt;font-family:&quot;Arial&quot;,sans-serif;color:white">=E2=80=
=8A</span><span style=3D"font-size:1.0pt;color:white">27:</span><span style=
=3D"font-size:1.0pt;font-family:&quot;Arial&quot;,sans-serif;color:white">=
=E2=80=8A</span><span style=3D"font-size:1.0pt;color:white">15
 +0530 &lt;kirankumark@</span><span style=3D"font-size:1.0pt;font-family:&q=
uot;Arial&quot;,sans-serif;color:white">=E2=80=8A</span><span style=3D"font=
-size:1.0pt;color:white">marvell.</span><span style=3D"font-size:1.0pt;font=
-family:&quot;Arial&quot;,sans-serif;color:white">=E2=80=8A</span><span sty=
le=3D"font-size:1.0pt;color:white">com&gt;
 wrote: &gt; @@ -149,6 +151,7 @@ const struct rss_type_info rss_type_table[=
] =3D { &gt; { &quot;l3-dst-only&quot;, RTE_ETH_RSS_L3_DST_ONLY }, &gt; { &=
quot;l3-src-only&quot;, RTE_ETH_RSS_L3_SRC_ONLY<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"mso-line-height-alt:.75pt"><span style=3D"f=
ont-size:1.0pt;color:white"><o:p></o:p></span></p>
</div>
<div>
<pre style=3D"white-space:pre-wrap"><span style=3D"font-size:12.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif">On Mon, 5 May 2025 11:27:15 +0530<o:p></=
o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&lt;<a href=3D"mailto:kirankumark@marvell.com">kirankumark@marvell.com<=
/a>&gt; wrote:<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; @@ -149,6 +151,7 @@ const struct rss_type_info rss_type_table[] =
=3D {<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;l3-=
dst-only&quot;, RTE_ETH_RSS_L3_DST_ONLY },<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;l3-=
src-only&quot;, RTE_ETH_RSS_L3_SRC_ONLY },<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;ipv=
6-flow-label&quot;, RTE_ETH_RSS_IPV6_FLOW_LABEL },<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;ib_bth&quot;, =
RTE_ETH_RSS_IB_BTH },<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">Please follow convention of other options. Use minus instead of undersc=
ore.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">Consistency matters.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-ser=
if">Ack. Will change it.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/r=
el_notes/release_25_07.rst<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; index 093b85d206..d1293893be 100644<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; --- a/doc/guides/rel_notes/release_25_07.rst<o:p></o:p></span></pr=
e>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; +++ b/doc/guides/rel_notes/release_25_07.rst<o:p></o:p></span></pr=
e>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; @@ -55,6 +55,10 @@ New Features<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Also, make sure to start the a=
ctual text at the margin.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></sp=
an></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;&nbsp; <o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; +* **Added new RSS offload types for IB_BTH in RSS flow.**<o:p></o=
:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; +<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; Added ``RTE_ETH_RSS_IB_BTH`` macro so th=
at the IB BTH header can be used as input set for RSS.<o:p></o:p></span></p=
re>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; +<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">Please add reference to the relevant standard and expand the acronym<o:=
p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">at least one place in the documentation.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-ser=
if">Ack. Will do.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h<o:p=
></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; index ea7f8c4a1a..edcd6b75b5 100644<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; --- a/lib/ethdev/rte_ethdev.h<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; +++ b/lib/ethdev/rte_ethdev.h<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; @@ -602,6 +602,7 @@ struct rte_eth_rss_conf {<o:p></o:p></span></p=
re>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;&nbsp; <o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;&nbsp; #define RTE_ETH_RSS_L2TPV2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_BIT64(36)<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;&nbsp; #define RTE_ETH_RSS_IPV6_FLOW_LABEL&nbsp;&nbsp;&nbsp; RTE_BI=
T64(37)<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; +#define RTE_ETH_RSS_IB_BTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; RTE_BIT64(38)<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;&nbsp; <o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">Why is the acronym IB_BTH rather than ROCEV2?<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">Wouldn't it be clearer if it followed convention?<o:p></o:p></span></pr=
e>
<pre><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-ser=
if">This is to keep in sync with RTE_FLOW_TYPE_IB_BTH<o:p></o:p></span></pr=
e>
</div>
</div>
</div>
</body>
</html>

--_000_SJ4PPF18AE1ADF75C98EEC48F063DA7A3F8AC9EASJ4PPF18AE1ADF7_--
