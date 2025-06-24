Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD816C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 06:22:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20147402A3;
	Tue, 24 Jun 2025 08:22:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D334440264
 for <dev@dpdk.org>; Tue, 24 Jun 2025 08:22:42 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O5BsrU031489;
 Mon, 23 Jun 2025 23:22:42 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47fnnbr4jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 23:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s25axeF/s0iGwifmgw8iGU8HZKnPrYI8gl9msqB2Dj5xUvZ4D5mv4EkmovQErz8QSCIpxE3CZeZplEZ2SV4LLE/ddvGPESF6/npRr+1fCcJjxapb5uXaKPDyZma0cBq2iNMmUCuZM+5MhYboAFBvAwq7q5KLdye0iUjzKdJhWxYOxwLG1gr3cva+H0BoiH1AmkDXE/dhjtPnIxgBjp6Jjwoy6+iTJu15IX1MumNe0YhZBw2DBPJx49Rm/FETfIE9DZe+h/e9QBR2ukKATfN2lEDZW1g7+gA6Gs6/tQ+o5R+WL9oCtwMFYn5DPurSan/AyOVani5/7+noT9L6rZYXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiUzfttMHfq3lb/CgYplwtaIplcE/m//kDD0bPYMOno=;
 b=GYRTqwC7wLJPf5cM3XzG/CRuhRDbl1l5dIT1pOlutebtk6o/+jfE6HzuImnJpV6dq4cY+mRWeCUFzde+XJmlfUhbVD+xHX6FObMVsU9yx2igD43TFjanYxr8maouUMzk1P9dBYSdqS20x73XA/aee2ZhS0Z9kmwGv8CJqZBa4L4QcU4YOwTOVHlygZ2pKWBgHnJkLNAL5mbd22pMc1ICPDFutl1whX65mPZqDRb1OS0vI0nSeNZ2BPtpFKK2svlVT8E5YGlBQaVndGa6wZzdnQZ+b67RFTAZTPE3QQ3xu2uF3Dv+6hH0gF0bYzBXBLKmYhvqPzu1pz6uc8D8kdStOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiUzfttMHfq3lb/CgYplwtaIplcE/m//kDD0bPYMOno=;
 b=V6URsj3rS+E2MljcK8gyooRguHnPGqCMf/eGCC7uJ4BgFxl14KBaiMEES4crdRHWSeKD6a4vEuJ6LZk6gEFa+yP0pjzeBKsIliccQDPeuSUXlmFU5HPNhCzq/Ul8bEV2+Qujn7I/uFRZl4VKmAZsl1E3Fka9MHtaZ6jaVuonf0o=
Received: from SJ4PPF0C545507B.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f09) by PH3PPF8DC9EB40F.namprd18.prod.outlook.com
 (2603:10b6:518:1::cb1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 06:22:38 +0000
Received: from SJ4PPF0C545507B.namprd18.prod.outlook.com
 ([fe80::6979:6c36:2018:80fe]) by SJ4PPF0C545507B.namprd18.prod.outlook.com
 ([fe80::6979:6c36:2018:80fe%8]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 06:22:38 +0000
From: Amit Prakash Shukla <amitprakashs@marvell.com>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>
CC: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "g.singh@nxp.com"
 <g.singh@nxp.com>, "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>,
 "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "conor.walsh@intel.com" <conor.walsh@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, Pavan Nikhilesh
 Bhagavatula <pbhagavatula@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] doc: announce DMA configuration structure
 changes
Thread-Topic: [EXTERNAL] [PATCH] doc: announce DMA configuration structure
 changes
Thread-Index: AQHbrr+P63XCBer43kKx5qaPq8ZkN7QSQuKA
Date: Tue, 24 Jun 2025 06:22:38 +0000
Message-ID: <SJ4PPF0C545507BB640772878BB9BAC8D6EC878A@SJ4PPF0C545507B.namprd18.prod.outlook.com>
References: <20250416110541.10358-1-pbhagavatula@marvell.com>
In-Reply-To: <20250416110541.10358-1-pbhagavatula@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPF0C545507B:EE_|PH3PPF8DC9EB40F:EE_
x-ms-office365-filtering-correlation-id: c6090b58-d197-4135-02ee-08ddb2e78430
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OEpSb0QrTVZmVEMzVTlHR3c4V3UvbDFpdTNFaEZZSEcvdzRPM29KWFdlazFD?=
 =?utf-8?B?V2FGcVdkM1F3SUJYUUM2NkRzWi9FVVl4QjJKa1NNYmdUeFpXZ0xNcFo1dEY3?=
 =?utf-8?B?b2EySUxsUWFqaVRRNnZjUmZmTUJWSXdZWlNva1VPcGZQTnBvU2xkbGUrejJs?=
 =?utf-8?B?dFFaZUorN09NVks0SERXZ25sNHFSRTJVMGVISHV1ZmJVMXVxOEJuVkhUN2ZR?=
 =?utf-8?B?QXQwN0pGM1pzSVl4U09MQkpzVUVvMmdyVjgvdGpMMzl0Tlc5QWxFaEtFamk3?=
 =?utf-8?B?SFNpZi9SQk1pd1g0clRSZ3ZQdmVhd0Q1V21wT3V3NFhkaHpGem82b0VMMEFY?=
 =?utf-8?B?dlgyMUZuRFAwTWVOaE9aT0RrM1NGT2kzRzZRY29kNUc3NGdWWlY2enk5OUc1?=
 =?utf-8?B?UmsrOFJ1VitkMDhhVXlmTWRPRHVnckZRYVNzRWlIc0FYMWU0TDE5T0V6cjNq?=
 =?utf-8?B?d1pjNjR0TFBHMnQvdzB2T1ZWZ0RYSHA4M2RaeS93MFZZVm1XeFJkMFZqcDVU?=
 =?utf-8?B?c1ZzWmFhSFBwU2Q5S1VNdDFEbXhNeGRVdExGTk5PZUdMdnRmUWlacDRUcFdX?=
 =?utf-8?B?aTk2SkNkYko4S29UUTdnWkFmaEpvRjBRZ1lNbUoxMGVWc2orNHZTSFZVRGZN?=
 =?utf-8?B?TDllWkJ0Y2UzbnIwWFR0RVR3cCt0ODhPUjhUZ1J2Vm9vcFUwTWducWo3WUE4?=
 =?utf-8?B?amZYWTQzMEVML0lhVWNMWTRMemJVOEtyNFgzOGFZSTNjSEtweFZxTmZxa0Nm?=
 =?utf-8?B?R09zdXYyaWY0NSs1VGZ6bWlueDZxZEJ6dGNUUkJwK25zTllPcEM2UDNzbUJi?=
 =?utf-8?B?R1NRcXlTYU0wcmpObnJsMnQzM05XRzNzenM1ay84Rk8wTExPTzRHSll2YVdR?=
 =?utf-8?B?TE5uejQrZFl0eHl5Mm1Mejhibk8yMXE1Vk02dHErcWRlWFBEd0lmeXF6aEZC?=
 =?utf-8?B?R0x3RkxTeWMrTXg0MjExdDV3cnBXckZpUkNEaGNkaWVWQitUZWMxcnZEVllJ?=
 =?utf-8?B?SnhBbWFwdkJCb3lZWUpsM29ESW11RnU2QVJJaWU4K1Fmd2NIOTBTSVlUNnlu?=
 =?utf-8?B?M0ZndENEcXpoaFlVaGhOL2F3MzNGQm1SVEpDTWtaaGFCaGhkYytVaXlXSWxm?=
 =?utf-8?B?cEtRRkd3YUV2V3l1cElPaktFTGd6S0gxOWxlVmJLc2cwYU5hTWF6akUwWm5J?=
 =?utf-8?B?aHFNcEM2eVFWeE54VlNNTzRFaGZ0ZGpNS0lObGVORUo1b0orVFFLMHcraGN3?=
 =?utf-8?B?eVZuTnNFYWMrN2szMlZab1B1SUQzYysrSDZJN2YxVEZOaENuM0J5RjJ6OHow?=
 =?utf-8?B?dmQrYzl1RHl5MmFSTUoxQXRVOVB6bjhybXNBMVNEVVIrNGdKTkwwVjMvNzdn?=
 =?utf-8?B?b2tTaGMzUkRWYjhxdXNnaEVqZzF2cmFaMk0zWEZIUjhEMms3Z0hiU3pNS3RS?=
 =?utf-8?B?bzdFek9JNjFWNFpibEVYeHE1U044K01rQ1JwRER1Tit4TmE5NElJRmNoVUY2?=
 =?utf-8?B?TUJwWStraEJ6WWhXSjhwaUJVT0NkTysxSXRQSzNNbGFXV0haUGVvOFZDOVV0?=
 =?utf-8?B?dW94cUZaSWROVDBwQWc4SVBUUkZ1MTZWeFZZWnc3WlJhUTI1SFl4b0pMdndU?=
 =?utf-8?B?bDR6ZDBHMGdLSXk3dzIwNXE4VlVmMjMxYWhtQnB3NWhZTTVvTXc1Wkk0TW80?=
 =?utf-8?B?akZleUdsK09NZGhtcGVNVHliY3ZzUk8rNjRmRHA1aEt1dytseWEzVGNXRzZL?=
 =?utf-8?B?eGNWV1FvRDJ1aS94bUJUMkVLYjhycmV6dVB0ckZ6NWZXWDZwTkRCZ2YyQnVT?=
 =?utf-8?B?YXZQQm1lM0JyQVRkOHBJdHI5MGFHWlBhNHpMdFRCSDFRcWQzWkhOaDRnNnlk?=
 =?utf-8?B?b0t0ODR6ZzNRNXhKUFlTN1BBRFZhOFBGWmYwWmp4ZVFlTk5ZSGVMbHN2ME9p?=
 =?utf-8?B?Y0UyS3FGTVIrdFQ3OVlLMEJha3hyUVRjNVRTeHEyTjR0djNWTFh6dUM4dWU3?=
 =?utf-8?Q?vcVBHCzeLfqFJ510ktkkAp84OE/eiU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPF0C545507B.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlVaTzh5UndZVmgyRE8rTURnZ2ZiSmR0akNBU2RIa3JaaVhYVkpDZGFBMU5Y?=
 =?utf-8?B?QlFYTTU3UFc3Ri90WmtrdURSR2FXMnZrRUY4M29VT1gwazBDQ2xXUU5ub21S?=
 =?utf-8?B?cFVYeXpacTRuMHBGYXRTQmZKaE5NT3ZxWjY4b00ralIvRksrK1lPeWtuVlFk?=
 =?utf-8?B?V0xFellNUG9MK21UVnM5VTZneTJiQlIvRzA1YkUwMDloa1Y4eWh0dmJYYm9X?=
 =?utf-8?B?Nk1ENm9jK2JYK3FmMmJxR05Kc1ZyczNyK0hNdEtzYXl5dEdENUZLTzBIc1Nq?=
 =?utf-8?B?ZlRlRkV0U0YzQ0M0ZjFETVFPMGtwUjlKbmJQOUY5WjNVOGswY1FEVis5YlE2?=
 =?utf-8?B?VE1nUUxHRDhVdzBjZFdvQ01xQVo4bTM3ZlBDWThHU0ErdW8rdzNsdDJTeURW?=
 =?utf-8?B?QmI4dG9tM0lWLy92bVhjL0RrKzU0djU3V3h3ZzdjM0ZQcDIwSFcvM2xNUTlL?=
 =?utf-8?B?OHQxYVEwYlFhbE1DenVnKytWQ0ZhY1BKUjUwNWltVzBFeUdMZDFzaTc2dnpM?=
 =?utf-8?B?T2tIUWdBL3YyMHV6MjFyS2lMS2FoK0RYRW0wSEw1ZTI1MWtQZndadGpEZUht?=
 =?utf-8?B?bFYxN1hDU1JSTldCQllXNU9BMk0zcHFVa1krMDV1czRaak5idW8yMm9kemtp?=
 =?utf-8?B?K01SNHNGN1lqcmNNbjlLTTJrL21XdjJVeUFzd1JuR3dMSmsyQ0hYQjZrZjRo?=
 =?utf-8?B?Y3dWRE1NanVrcXRLUWtnd3hBd21ndEcrV0RYYWFwTUtnSnMzRC9EckZ1OEhY?=
 =?utf-8?B?SWNNb0lua3VRcEJrM2N3L3VhdXA3OFhVd3lqaGc0SDN3dkQ2Q3VtQi9nR2No?=
 =?utf-8?B?bjZNUHZBUGxibG43REpyUlJ2Q21IMmhyMVRmYkxyQyszUWdpN3cvOXRZTXgr?=
 =?utf-8?B?SkFiY3NycGxBQkt3cnQvM0RUTmtyejNSZlVqMEdyeGxSUWdmV0RNbG5xSGJL?=
 =?utf-8?B?VDUrTHluN0tYWnNhR1lmcW1xaXpaRjB3Z2o0Y1QvdW9weDlpaHY0UHh4RFlY?=
 =?utf-8?B?K2VmV3JQcW5NYWZXT2lxM3M2K2p6WnIyMXN1SXJZdHhOaUZiOWFHbGpPZXNG?=
 =?utf-8?B?bEhEM2R3a3I0LzBBTVh0VDlld2xNZ3hUSWFwdXRXazl2WWdOTnR2dzYyL1Rt?=
 =?utf-8?B?aGRqa0VsMkhXaDFkUGdqbWNYQU0rQnFwTlh6UzkreXBNbDQ5Q0N6dG5Ucm1z?=
 =?utf-8?B?QXQwWlR5enZyK0UwSlQzRVJrMVI3VlB5enVSTVIwTVgyZTVJVElXTmJVMGRR?=
 =?utf-8?B?ZVQvd3R5aGxpYmJLYmxnUTBLVVIvR1dwSnBPeGNONUZNOXljMDBMS0l0TUVJ?=
 =?utf-8?B?NG1mTzQrR2phNkpYL2QwbTJnQXFWRVRQdXNBSUlVa29jcjZsNy9IeGFKMVlL?=
 =?utf-8?B?NDY1cHVjVU03V1B1SThNdDk3VWdQQzZhNzk4ckFxQy93ZUo0YlQ5YUY4WnI4?=
 =?utf-8?B?OHBZMzd2YTgya0xieEZjVVhpNkk5M1NXcC9KdXY1YmEwSTl3djhhMDRydFlF?=
 =?utf-8?B?azRWT3ptTXRCWk5xL25wdGgzU3M5bzAwYklFTDVJT3F6YTk4dGZ4TkUvMTcv?=
 =?utf-8?B?RHdNN2tvMXp4UkpmamZTWWtoMUw1aXpiakxxUG1sVTd2d2xQRTIrTkJsbnU2?=
 =?utf-8?B?dlY2WHBRWjFxTGRmam91TDRFVWFJMWtJVmpNN01hMm10Sm1HY3BnZ2NtNkp3?=
 =?utf-8?B?R2Qvc0FwM2h0bFkwQ0Jkc1A1Zitab3pvc2M0SWUxWUVjQzZJblhpbUtaTVZw?=
 =?utf-8?B?M0hzMUJwL1NRUjV5dVRQcTdSYTd3b094VVAwWm9zOGxiVWZqVzhxYXZxVENO?=
 =?utf-8?B?YVhRUzQvcFM4cDZuRjRMZC90REdKS1pXelhnL2FKcnM4MHphV24wbHpjbDRM?=
 =?utf-8?B?VncyVGdXOG5jMGk5ODI5QVkweGNwdVREMGxwbjYvZi9lUUtwYlh3OTlOQW5l?=
 =?utf-8?B?dGdkMUFabk5WcUxwWWtEZEZLSG81RkxYZG83d0lkaFVTSG9rNFVJVmpJcUtj?=
 =?utf-8?B?bmtnU05qcnJSdHROUFE4WXk3SmVuVmV2ZytzZ3R1N0xzZk1jdk5mbTZ3UU1B?=
 =?utf-8?B?MlZOaTF4aUpuMGxUMTdML01HbHNrWlBJbWhWOTYrbXNBWkdZSDZCSTBIa0hM?=
 =?utf-8?Q?lw2TqsXVDYoeY4F6VJm2aRLF7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPF0C545507B.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6090b58-d197-4135-02ee-08ddb2e78430
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 06:22:38.1258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRB/ZFXjsMkeLOHEDe8oOW/uWXq/9zlN9XI2203gLIyOJzQBsI2s82KiI5qbsIF4R47NmVqm+QztQ/IES839YiRlxGvkRZcaT8MfxNYN2BA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8DC9EB40F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA1MyBTYWx0ZWRfX0K/3PoFohqoV
 pYpqQ/aXYIwoq40wmYisQ4yBInA8ejxMrvDP33Mfgl6Ihag58QODF8b+ojtxqw4pYV8JMD64GUv
 QoCbxYHklNN6vuuk8g2sGMlvPNLC0q/CRl9dLKLSPnrgBik3ruxyDh4r7DQVDpM+pSBE3U2s8Ko
 TKoE+r5cpW6LQOVMJKz65ZDcaj/XUZOyA6OUSDnObaHnikjtmdibKOkr6bLi1t1T8ZxIs3BIOnP
 brd5LZpIJV7uebDwn7IehZRNPHlgKtDuIJkei1CExJM4F1i/5yw7/8tC4V4+l2p5srUF3jEPIaC
 PXtCtQpZJz4+oR/0VlWV8JjUt5XDfBALu/nSvCIwY8+5UzFt9JR+2XRKuFgc22xDlqjzIgkgCq6
 HxEYgIS/gMb0DsDdZN22nTvakVOdmXa3f+3rXSrrXclszheTOWwnI+cRWGYmOXSoo9upxN/t
X-Authority-Analysis: v=2.4 cv=IPECChvG c=1 sm=1 tr=0 ts=685a4431 cx=c_pps
 a=IZO86lbbsIDzssvVtBV1Qg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=M5GUcnROAAAA:8
 a=8AirrxEcAAAA:8 a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8
 a=dnWkpfBXLDa12dVJGjQA:9 a=PRpDppDLrCsA:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=ST-jHhOKWsTCqRlWije3:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: Sup1-NSUddgaoRuKm2L51f0ojyfljmaH
X-Proofpoint-ORIG-GUID: Sup1-NSUddgaoRuKm2L51f0ojyfljmaH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
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

QWNrZWQtYnk6IEFtaXQgUHJha2FzaCBTaHVrbGEgPGFtaXRwcmFrYXNoc0BtYXJ2ZWxsLmNvbT4N
Cg0KDQpGcm9tOiBwYmhhZ2F2YXR1bGFAbWFydmVsbC5jb20gPHBiaGFnYXZhdHVsYUBtYXJ2ZWxs
LmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE2LCAyMDI1IDQ6MzYgUE0NClRvOiBKZXJp
biBKYWNvYiA8amVyaW5qQG1hcnZlbGwuY29tPg0KQ2M6IFZhbXNpIEtyaXNobmEgQXR0dW51cnUg
PHZhdHR1bnVydUBtYXJ2ZWxsLmNvbT47IGcuc2luZ2hAbnhwLmNvbTsgc2FjaGluLnNheGVuYUBu
eHAuY29tOyBoZW1hbnQuYWdyYXdhbEBueHAuY29tOyBmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbTsg
YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb207IGtldmluLmxhYXR6QGludGVsLmNvbTsgY29ub3Iu
d2Fsc2hAaW50ZWwuY29tOyBHb3dyaXNoYW5rYXIgTXV0aHVrcmlzaG5hbiA8Z211dGh1a3Jpc2hu
QG1hcnZlbGwuY29tPjsgVmlkeWEgU2FnYXIgVmVsdW11cmkgPHZ2ZWx1bXVyaUBtYXJ2ZWxsLmNv
bT47IGFuYXRvbHkuYnVyYWtvdkBpbnRlbC5jb207IGRldkBkcGRrLm9yZzsgUGF2YW4gTmlraGls
ZXNoIEJoYWdhdmF0dWxhIDxwYmhhZ2F2YXR1bGFAbWFydmVsbC5jb20+DQpTdWJqZWN0OiBbRVhU
RVJOQUxdIFtQQVRDSF0gZG9jOiBhbm5vdW5jZSBETUEgY29uZmlndXJhdGlvbiBzdHJ1Y3R1cmUg
Y2hhbmdlcw0KDQpGcm9tOiBQYXZhbiBOaWtoaWxlc2ggPHBiaGFnYXZhdHVsYUDigIptYXJ2ZWxs
LuKAimNvbT4gRGVwcmVjYXRlIHJ0ZV9kbWFfY29uZiBzdHJ1Y3R1cmUgdG8gYWxsb3cgZm9yIGEg
bW9yZSBmbGV4aWJsZSBjb25maWd1cmF0aW9uIG9mIERNQSBkZXZpY2VzLiBUaGUgbmV3IHN0cnVj
dHVyZSB3aWxsIGhhdmUgYSBmbGFncyBmaWVsZCBpbnN0ZWFkIG9mIG11bHRpcGxlIGJvb2xlYW4g
ZmllbGRzIGZvciBlYWNoIGZlYXR1cmUu4oCKDQpaalFjbVFSWUZwZnB0QmFubmVyU3RhcnQNClBy
aW9yaXRpemUgc2VjdXJpdHkgZm9yIGV4dGVybmFsIGVtYWlsczogDQpDb25maXJtIHNlbmRlciBh
bmQgY29udGVudCBzYWZldHkgYmVmb3JlIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNo
bWVudHMgDQrCoMKgaHR0cHM6Ly91cy1waGlzaGFsYXJtLWV3dC5wcm9vZnBvaW50LmNvbS9FV1Qv
djEvQ1JWbVhrcVchdGczWjFmOFVBblZhMU0tY21kMzY3cFN5NTBvYUc1aS1lclBueGhyZmtwX2xU
RkRHcnkwLXVDUW5iUHhUck1KUTlRaERDZEdURmgyMXRhMEhZQ1dMQmxrM3ZnNXk4ZklTd2lFMWhB
JMKgwqDigIwgDQoNCg0KWmpRY21RUllGcGZwdEJhbm5lckVuZA0KRnJvbTogUGF2YW4gTmlraGls
ZXNoIDxtYWlsdG86cGJoYWdhdmF0dWxhQG1hcnZlbGwuY29tPg0KDQpEZXByZWNhdGUgcnRlX2Rt
YV9jb25mIHN0cnVjdHVyZSB0byBhbGxvdyBmb3IgYSBtb3JlIGZsZXhpYmxlDQpjb25maWd1cmF0
aW9uIG9mIERNQSBkZXZpY2VzLg0KVGhlIG5ldyBzdHJ1Y3R1cmUgd2lsbCBoYXZlIGEgZmxhZ3Mg
ZmllbGQgaW5zdGVhZCBvZiBtdWx0aXBsZQ0KYm9vbGVhbiBmaWVsZHMgZm9yIGVhY2ggZmVhdHVy
ZS4NCg0KU2lnbmVkLW9mZi1ieTogUGF2YW4gTmlraGlsZXNoIDxtYWlsdG86cGJoYWdhdmF0dWxh
QG1hcnZlbGwuY29tPg0KLS0tDQogZG9jL2d1aWRlcy9yZWxfbm90ZXMvZGVwcmVjYXRpb24ucnN0
IHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9kb2MvZ3VpZGVzL3JlbF9ub3Rlcy9kZXByZWNhdGlvbi5yc3QgYi9kb2MvZ3VpZGVzL3Jl
bF9ub3Rlcy9kZXByZWNhdGlvbi5yc3QNCmluZGV4IDM2NDg5ZjZlNjguLjg1NGRiOTZjMDggMTAw
NjQ0DQotLS0gYS9kb2MvZ3VpZGVzL3JlbF9ub3Rlcy9kZXByZWNhdGlvbi5yc3QNCisrKyBiL2Rv
Yy9ndWlkZXMvcmVsX25vdGVzL2RlcHJlY2F0aW9uLnJzdA0KQEAgLTE0MiwzICsxNDIsOSBAQCBE
ZXByZWNhdGlvbiBOb3RpY2VzDQogKiBidXMvdm1idXM6IFN0YXJ0aW5nIERQREsgMjUuMTEsIGFs
bCB0aGUgdm1idXMgQVBJIGRlZmluZWQgaW4NCiAgIGBgZHJpdmVycy9idXMvdm1idXMvcnRlX2J1
c192bWJ1cy5oYGAgd2lsbCBiZWNvbWUgaW50ZXJuYWwgdG8gRFBESy4NCiAgIFRob3NlIEFQSSBm
dW5jdGlvbnMgYXJlIHVzZWQgaW50ZXJuYWxseSBieSBEUERLIGNvcmUgYW5kIG5ldHZzYyBQTUQu
DQorDQorKiBkbWFkZXY6IFRoZSBgYHJ0ZV9kbWFfY29uZmBgIHN0cnVjdHVyZSBpcyB1cGRhdGVk
IHRvIGluY2x1ZGUgYSBuZXcgZmllbGQNCisgIGBgcnRlX2RtYV9jb25mOjpmbGFnc2BgIHRoYXQg
c2hvdWxkIGJlIHVzZWQgdG8gY29uZmlndXJlIGRtYWRldiBmZWF0dXJlcy4NCisgIFRoZSBleGlz
dGluZyBmaWVsZCBgYHJ0ZV9kbWFfY29uZjo6ZW5hYmxlX3NpbGVudGBgIGlzIHJlbW92ZWQgYW5k
IHJlcGxhY2VkDQorICB3aXRoIHRoZSBuZXcgZmxhZyBgYFJURV9ETUFfQ0ZHX0ZMQUdfU0lMRU5U
YGAsIHRvIGNvbmZpZ3VyZSBzaWxlbnQgbW9kZQ0KKyAgdGhlIGZsYWcgc2hvdWxkIGJlIHNldCBp
biBgYHJ0ZV9kbWFfY29uZjo6ZmxhZ3NgYCBkdXJpbmcgZGV2aWNlIGNvbmZpZ3VyYXRpb24uDQot
LSANCjIuNDMuMA0KDQo=
