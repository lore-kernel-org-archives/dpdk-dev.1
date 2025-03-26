Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D513BC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 17:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF6D1402E3;
	Wed, 26 Mar 2025 18:07:03 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 08E55402CD
 for <dev@dpdk.org>; Wed, 26 Mar 2025 18:07:01 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QElcu2005920;
 Wed, 26 Mar 2025 10:07:01 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45mbfj9exy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 10:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adSJk5Q2I3CiUuNhKmRbs62ejtrPfBWgimJsi9ebjAdP4Yt+yTeYuEp1TH9al4wLp3eJqXUnr+tZTREeTQ/OyZOV+Ilc9HRvbWgL56dAzhyVBiKkPRJ3YCMLKZcZ7rYuH8tNwumW8V0tuuIh7w9IWJvqlSzp4riF7uhF0ewUq8tXzShCWD6VRZWFt0dLTJkmq/rCBYtkb0IYzTUSKL8W7h+rISv00HczZyq6z+0UGn08XAWnyBOexxqvMppKYsnA1fdQg8jKFeZ7f0ep6LxEtfGQRtB7C+40HrIZpMa8krqQiVS6iC3PvX4l7XANzH2gYCvzqZoMquWt/eGrENFSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8NJxUsLprgbAVt6t1X3Mb6THLeGCzakLGIIyMSw++w=;
 b=qocnxbDdzIpEf8tYTv5EUhi8iLmfE23VsstVhzFeFspJP45LH/3mzSkGWYOIs4Q4+f30ypKif35iGdiQgojVZ6zsOCVp3ji1uJMeqPtpSu0ylFpwPvyq+fJyJlJajGi/Be3H2EwDShNw1IPOHteIeVG+OOmw6H2R3jLqPP2+04qDm0j5vDRxhZCpzU9HAO/GRpJEBB53YPhkhVJhyUCEDxVtZ8dSKrpY9yXrHye+ZDGCi8CYgbVafoxYARrGWieI4HqWq4oxdyMagCUObneKbJ/l/xJe/qOAMsbgoamv+jpzjLIOQ+HxZTmo7fOr1pjZ2NJ2/2RaBvV/LCkwBsSNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8NJxUsLprgbAVt6t1X3Mb6THLeGCzakLGIIyMSw++w=;
 b=jylJznSZIJIun5YAjuV9L9KwfXGd2Hd4na/wnc8BYqqVXyp3/IiSjabSd0A3RG3/C7AtHmz1i4208TU1quUltUITWXwrQ6ZbkhWxemKaYTNstMm+7MzK5vgeb3ckcm/AFWpRM282Nm7Em5ZNuryd/Euo+9EHrS0CNbKOPdZHMYc=
Received: from CO6PR18MB4084.namprd18.prod.outlook.com (2603:10b6:5:349::18)
 by CH0PR18MB4116.namprd18.prod.outlook.com (2603:10b6:610:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 17:06:58 +0000
Received: from CO6PR18MB4084.namprd18.prod.outlook.com
 ([fe80::c296:9e34:99f6:944d]) by CO6PR18MB4084.namprd18.prod.outlook.com
 ([fe80::c296:9e34:99f6:944d%4]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 17:06:57 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pravin.pathak@intel.com"
 <pravin.pathak@intel.com>,
 "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>,
 "mattias.ronnblom@ericsson.com" <mattias.ronnblom@ericsson.com>,
 Jerin Jacob <jerinj@marvell.com>,
 "liangma@liangbit.com" <liangma@liangbit.com>,
 "peter.mccarthy@intel.com" <peter.mccarthy@intel.com>,
 "harry.van.haaren@intel.com" <harry.van.haaren@intel.com>,
 "erik.g.carrillo@intel.com" <erik.g.carrillo@intel.com>,
 "abhinandan.gujjar@intel.com" <abhinandan.gujjar@intel.com>, Amit Prakash
 Shukla <amitprakashs@marvell.com>, "s.v.naga.harish.k@intel.com"
 <s.v.naga.harish.k@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>
Subject: RE: [RFC 0/2] introduce event vector adapter
Thread-Topic: [RFC 0/2] introduce event vector adapter
Thread-Index: AQHbnlERxD6+fefFi0+yzb1o8jemJLOFo5ww
Date: Wed, 26 Mar 2025 17:06:57 +0000
Message-ID: <CO6PR18MB4084EBB953C30015BCB7183CDEA62@CO6PR18MB4084.namprd18.prod.outlook.com>
References: <20250326131441.5965-1-pbhagavatula@marvell.com>
In-Reply-To: <20250326131441.5965-1-pbhagavatula@marvell.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4084:EE_|CH0PR18MB4116:EE_
x-ms-office365-filtering-correlation-id: 3c497be1-6eaf-436f-dad4-08dd6c889dff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MktpU0ZFZGpOaU9xNHJFTGg4aTZXNFdRSU9aeW1iWUVmbmFBTzh6bERNZFh5?=
 =?utf-8?B?ZU5Td2pNczQ1L3dYOWx0WU9TSUtMVThyelBpbGVLYmdzR3kreERCbkorZWMy?=
 =?utf-8?B?WmNucFg1RXZTTjM0K3Qxd2R2eUR3YTdWUHlKL2RRZjNmc1poa2dXNUdXQzRC?=
 =?utf-8?B?c2YvR3VMbnl6TDJSQU9xWXZYb0tlWjN5UkQ3M252dkdBUHhnUnAxdVFMNFR2?=
 =?utf-8?B?RUVnOUF3VWZBZWJ2ZlpyUzh5OEpuMEhydHZzWFBNc0g2ZGFIQ1VrUFlKTG1i?=
 =?utf-8?B?U1V3c1Y3cmV1eVpNL3p3djdnek5xc2Q3bVlRMEpacisrb05hVjJENnZ1emFI?=
 =?utf-8?B?UUhHU0dTTXBvcDZGV1hWazdkWmYrSENmL3g0Z0NBMkZPdVJoRFNka2JIWGV4?=
 =?utf-8?B?NGFvdlh2eHBlVWJsN1lDcXlucmNFYnUwdDh2MHNmZi9pTGxaVko4WXl1anRE?=
 =?utf-8?B?WVpBd1dYekV5SUdZZWYydkZjZHBlblU2Z2E0bldCRUU5R05XNTJ5RXYrNG5T?=
 =?utf-8?B?UTlrZkZjcmxhUmhLdGJZbXAyVXJUeHIvTG9kb3cvMWN6NW90V0ZMNzM2ek9R?=
 =?utf-8?B?Qlh4QU5ObzU5WE5YVEZKRkx6RFUyQ1h3Rnk1bWZ3dWtpZy9vM2o4dnFlVWdD?=
 =?utf-8?B?cW1wZ1V5QW5wSkF6TjFFVmZaY1g2T0xZdElMTVZnRmVTaWxXNE1KZGw5RVJI?=
 =?utf-8?B?My9DMGlzUmh4RzdaTEc5c2tiMksvdDdqNVltbDZWaCt2R0JiRHAxODR1U2dn?=
 =?utf-8?B?VDdRQnJOMmZVcFpHbG9WTy9KT0NNN3FFbnprNmRNLzN0aDJBR0E1a0I0NDZa?=
 =?utf-8?B?c25sTkg5b0huQkhJcGFQeXphdFF1QzlCaW9BcUMvcTVEV2VadFc3NWN4a2xY?=
 =?utf-8?B?b2diUDRZbXpuNmNXQWdGT2xRb1NhR0l3SVg1Y0l1MExaQkxVZUI1V0VvKy90?=
 =?utf-8?B?QUJNVG16NFJQKy9GWjBpclgvWWRtU3FOTW9zQ1h4ZUpjeUh0a3JBNjRvMmpY?=
 =?utf-8?B?d0Q0b3V2TEhWU2ZLN05vaGp6OHlPdTRZMDZxSXZZc2ZTa2lycmJMUVc0V2ww?=
 =?utf-8?B?OHpabHg1bWMwUmY5WnVwVjdwSWQvNElWOC9GdTNMeVk5ZXRRSjcvWWZXOGUx?=
 =?utf-8?B?U1FKRGZweDBlenRzK1lYVVgvdlZKREEzTFAwT0VJczA5N0J6SS9VOVUxZm9r?=
 =?utf-8?B?ZnYxLzNENTF2R0RGc1p1V3NLMXNzS1VHR3dmNHpkQnVaRlFXNzdyVXg3WXcw?=
 =?utf-8?B?RllzWGRnSEdpRkt2SytGOEd1Z2pQL2VlZVcxTGVtWDhsTFRiYno5OVdFZGlj?=
 =?utf-8?B?R1JnYk8zejJkRkZKQ3VPVUFFcG44YTlieEV3RStRM2ZTSEpSYy9QbGFFSVpk?=
 =?utf-8?B?R1czd09WV0ROcUx3ZW4xRjIrYjV5OHc4T2tONENSTnJ1S3BQUnptNWdnbm03?=
 =?utf-8?B?VjlOVDlJNlVhZUxYNHVBUTRUMTdGUDlmZVpkbmpiTnNlR1BpdDFXWjFUZWJ3?=
 =?utf-8?B?RDJGeXVENlVIbkZvbGViK1ZGOUZRN2NIRU1PUXp4L3J1cW90OVpzaS9SdVNU?=
 =?utf-8?B?OEV0cFU4T1pGdFVnV293cGg5eXliRkY4aWxVZE5LbExZUDF5cHlKM0U4cUw2?=
 =?utf-8?B?TE5WdTBJK2wrQTF3TnJzclRBWlFUalczRWNJM2YxWHBab0ZHS1JUMm5IbzN0?=
 =?utf-8?B?N2lBNHBZUWRUdzYxaFBoOWVmdjR5SXMrNmg2WkpycHEvOFZaUEkyWE9SYXJ0?=
 =?utf-8?B?Q2ZjMTRUYzE3VnBHSnByVUl5K1BIbjBUYjF6d1BtSDFoTWdDRXdUWXRFNzJw?=
 =?utf-8?B?UHFaOUx4QXU3QnQ0dkVUTjlaMjB2bklDcGN5Y3MrQmRnR1o3UTVpWlBocHVq?=
 =?utf-8?B?U20rV1p0bmVJQmh2QmZrVW01clhOa0xVcFBWK1FHUi9QZVNCMURhUXJGNVNP?=
 =?utf-8?Q?B/VtjUUb8SLf/195f9tw8C4IR7bbrws3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4084.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU04b25XS0h1cXovZWhKcTh1TTBMTnNNQUg0aWFiNXpEYkxsK1QrZHBiMFpV?=
 =?utf-8?B?SWhLY2dqWXVCbEUyTWVORVNDY3F6c0E4NDIxUmphc0Vsa09mT3UwYUpzTWNv?=
 =?utf-8?B?SE1qdmFHb3JyaythSG5aenJycEc5RzdhdUhwaTJCSUFRVEY0T0RlNUxXeGJT?=
 =?utf-8?B?QnU4NW5PWnVUZE1QMW5teG5uYi8vSFZjMDhLMHhtbXI5TnhJY3diTlc2RTBX?=
 =?utf-8?B?c1lRSGFnaHZRMHEwNTdQaFp4Tnpnd1ZicnF1TFd2MzVQaEgvOWxsT0RkQ2wx?=
 =?utf-8?B?QnVTYnZBOW5MdUVjb0xnenVPTlRYSVdLbTFXYUpodkZRdmJ6c21sajdtSTZp?=
 =?utf-8?B?NHdiNnkvSWc2cVF1TnB0MldCRm0xUHBSOUNBVWNjNmtCTVhsa29IdjhCaitH?=
 =?utf-8?B?MDlqK2wvMmdTcUhUNkhDOEJRTzhwK1RkZW5uL2hGRVc2TzlLZ00xR0N0YjVU?=
 =?utf-8?B?Uk9PdjlqK0d2N3h2aVBhd3plcmVibmNjV2FMbTNZN1pCd1NndHdlYlFMSWxD?=
 =?utf-8?B?SG5XWkhVTGdGblJOcXVNN3ZIWFFIV3J6ejBhN3dIWHB5bXIwUUNKYlNjelY2?=
 =?utf-8?B?YzdwclpORHVaRzNvODRQVW5HL0lVeURLY1JUTGdzby9IVy84K1AxSlFBWTdp?=
 =?utf-8?B?Vnl3ZFpVZWM1b2ZVSEhWSzRsVG5HaXFQYXdvdVBlUmMrcjl1OFg5c25uUXRn?=
 =?utf-8?B?bjAwZk0rVVpNWTlZWnc4NkMxYmljWDZhak5tcDc2MHNpNURySWFLOGF6M2dX?=
 =?utf-8?B?Y3VoL0lmcUNmbDVhRmpVRUlZMWlSL2JtOEQ3OFVUdVA1TC96RU9KSXZtVzh6?=
 =?utf-8?B?TDAyZXhQdnlWZUtLYU1TY0ZDenRGZ013M0RBY2daU2U0eCs1dHVsK0MxU1ll?=
 =?utf-8?B?N0FEaEhROGtjVElndm8wWDg3SUlEWGNNcGQxd3VDL1JRU1ZiMWlUQ013aTlG?=
 =?utf-8?B?RzZ1Rlg3aVl2NFBPRU9QNVA1a1hieGlSU0hpUWxRTHQ0TXJGc1pGYzZjNmJ2?=
 =?utf-8?B?RmpEZmVDZGhqdXhmWDNHcDlrMFdobXhPSUVOa1Jhblp0QVBqWUJ1ZWo0ZlA1?=
 =?utf-8?B?djRDOFhoSnRwSTBsQ2dPeWxqR1QvVTVXOVJzR0dlekRYMjBpemorVkMzNGdr?=
 =?utf-8?B?OXZqc1BEblZiU2RWWXhlUUR2S0RkZ1ZBTWlhVWVZc2h1STVRMERvbzZxZGVL?=
 =?utf-8?B?UVVyc0xESGdldnZkV3hmMG5zUE9yY1V1Q3JUMzRuaGRVME0veGErRlFaRTQr?=
 =?utf-8?B?UkJvcTNPYURIa0tFb0ZSQ2Zja08ydG9ZSmpDTDZjNzgrY3FkbHVjRDgzTndz?=
 =?utf-8?B?SURxb3Z6WnIrZlFjaGE1cTNLU2FyTzlVNVZBYjJEMmpYTWFqaUp4L25LL3V1?=
 =?utf-8?B?aSt2NkFZa3VFdkcxOUIxSWl0MkxsZ2g2VU8zdnMyNlRLR3lSQXV1bHlvMzJM?=
 =?utf-8?B?ME5qdVJvVDJvZk9XeGp1UVNaYUp1US8wZ0dMdFhjT1gvK1BpSXZuVDQrU3R4?=
 =?utf-8?B?d0sxdU81dU9za0NYTlVmTDArWUpxd2Y4azdZN1U5NDlMTmsvYUNtRGZCcnlw?=
 =?utf-8?B?c3NSNkQrRjNwayttTDVNd2trUkFWWEdWTWdHOHlOcVBCRDlsRDJoMEloRlow?=
 =?utf-8?B?eUw1VDlSL2dOY3RuUWhSS1VEcWJMclJZaVBrdlUvcTBiRUJEYnVSdVdUeHhj?=
 =?utf-8?B?ME5qUHdnejV1K1hOMzBxN1NyOHlhdUlFTmtyVTNUVFNHb0ZkNGxkKy9ZZXY4?=
 =?utf-8?B?bTNNdkhrNGpFMGZIYzlCVHBUa3FoUVpObU1TeDhrekhIOE93MkRaRmJwODNT?=
 =?utf-8?B?NXd4WTFlSjh4VUpQYlJmS2wvRFN6ZmdvK1VuSW81UUg3TWxyU0hXd3VtNytC?=
 =?utf-8?B?dE5QSWhibjFZOFN2SXFXajdmRE9iZ1dmcGx4NmhpdEZPaWl2aWMxdlBleEdp?=
 =?utf-8?B?aGZvamUyWlN1S1Q1RzVpWVlDQlpPYSs0cUhKclhDMGF1bFNnMjUrYTk5M3hn?=
 =?utf-8?B?ZWtaNXR6TllQSnE2VFBwV0ZGY1VmNDVDc09xWmZUWmJQZ1pXWWo0VTRxdW1z?=
 =?utf-8?B?MTB3SnFvbC9Tb1BxODV5MGVtbkFrZjdObVpKOEtxVVZHRWxsSEE1bGQwaHJO?=
 =?utf-8?Q?3BYWX/nw/XJ8Td+Cc4PhC8DMS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c497be1-6eaf-436f-dad4-08dd6c889dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 17:06:57.8014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTYgE2VjzZoR1FkEabvaOB3Me/pmLSDPJtRd5igWIIYNSMzZ19HFG0MR1jnZavu1aO9JC9AwH5efaeIA4fgdE7Ka3BzUq6WuKrhbXcBkmmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4116
X-Proofpoint-ORIG-GUID: moX9rg1SnnyYFGYwu9Z_FM2lqh2lH-QR
X-Authority-Analysis: v=2.4 cv=auuyCTZV c=1 sm=1 tr=0 ts=67e43434 cx=c_pps
 a=GbYsmhbcUJoGoLxTsnc7yA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=IbGdPB5uXuQgz75ziwYA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: moX9rg1SnnyYFGYwu9Z_FM2lqh2lH-QR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
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

KysNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBwYmhhZ2F2YXR1bGFA
bWFydmVsbC5jb20gPHBiaGFnYXZhdHVsYUBtYXJ2ZWxsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBNYXJjaCAyNiwgMjAyNSA2OjQ1IFBNDQo+IFRvOiBKZXJpbiBKYWNvYiA8amVyaW5qQG1hcnZl
bGwuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBQYXZhbiBOaWtoaWxlc2ggQmhhZ2F2YXR1bGEN
Cj4gPHBiaGFnYXZhdHVsYUBtYXJ2ZWxsLmNvbT4NCj4gU3ViamVjdDogW1JGQyAwLzJdIGludHJv
ZHVjZSBldmVudCB2ZWN0b3IgYWRhcHRlcg0KPiANCj4gRnJvbTogUGF2YW4gTmlraGlsZXNoIDxw
YmhhZ2F2YXR1bGFAbWFydmVsbC5jb20+DQo+IA0KPiBUaGUgZXZlbnQgdmVjdG9yIGFkYXB0ZXIg
c3VwcG9ydHMgb2ZmbG9hZGluZyB0aGUgY3JlYXRpb24gb2YgZXZlbnQgdmVjdG9ycw0KPiBieSB2
ZWN0b3JpemluZyBvYmplY3RzIChtYnVmcy9wdHJzL3U2NHMpLg0KPiANCj4gQW4gZXZlbnQgdmVj
dG9yIGFkYXB0ZXIgaGFzIHRoZSBmb2xsb3dpbmcgd29ya2luZyBtb2RlbDoNCj4gDQo+ICAgICAg
ICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkA0KPiAgICAgICAgICDilIIg
IFZlY3RvciAg4pSc4pSA4pSQDQo+ICAgICAgICAgIOKUgiBhZGFwdGVyMCDilIIg4pSCDQo+ICAg
ICAgICAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCDilIINCj4gICAgICAg
ICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQIOKUgiAgIOKUjOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkA0KPiAgICAgICAgICDilIIgIFZlY3RvciAg4pSc4pSA
4pS84pSA4pSA4pa64pSCICBFdmVudCAgIOKUgg0KPiAgICAgICAgICDilIIgYWRhcHRlcjEg4pSC
IOKUgiAgIOKUgiAgUXVldWUwICDilIINCj4gICAgICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSYIOKUgiAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
mA0KPiAgICAgICAgICDilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJAg4pSCDQo+
ICAgICAgICAgIOKUgiAgVmVjdG9yICDilJzilIDilJgNCj4gICAgICAgICAg4pSCIGFkYXB0ZXIy
IOKUgg0KPiAgICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgNCj4g
DQo+ICAgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkA0KPiAgICAg
ICAgICDilIIgIFZlY3RvciAg4pSc4pSA4pSQDQo+ICAgICAgICAgIOKUgiBhZGFwdGVyMCDilIIg
4pSCICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+ICAgICAgICAgIOKU
lOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCDilJzilIDilIDilrrilIIgIEV2ZW50
ICAg4pSCDQo+ICAgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCDi
lIIgICDilIIgIFF1ZXVlMSAg4pSCDQo+ICAgICAgICAgIOKUgiAgVmVjdG9yICDilJzilIDilJgg
ICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgNCj4gICAgICAgICAg4pSCIGFk
YXB0ZXIxIOKUgg0KPiAgICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lJgNCj4gDQo+ICAtIEEgdmVjdG9yIGFkYXB0ZXIgY2FuIGJlIHNlZW4gYXMgYW4gZXh0ZW5zaW9u
IHRvIGV2ZW50IHF1ZXVlLiBJdCBoZWxwcyBpbg0KPiAgICBhZ2dyZWdhdGluZyBvYmplY3RzIGFu
ZCBnZW5lcmF0aW5nIGEgdmVjdG9yIGV2ZW50IHdoaWNoIGlzIGVucXVldWVkIHRvIHRoZQ0KPiAg
ICBldmVudCBxdWV1ZS4NCj4gDQo+ICAtIE11bHRpcGxlIHZlY3RvciBhZGFwdGVycyBjYW4gYmUg
Y3JlYXRlZCBvbiBhbiBldmVudCBxdWV1ZSwgZWFjaCB3aXRoIGl0cw0KPiAgICBvd24gdW5pcXVl
IHByb3BlcnRpZXMgc3VjaCBhcyBldmVudCBwcm9wZXJ0aWVzLCB2ZWN0b3Igc2l6ZSwgYW5kIHRp
bWVvdXQuDQo+ICAgIE5vdGU6IElmIHRoZSB0YXJnZXQgZXZlbnQgcXVldWUgZG9lc24ndCBzdXBw
b3J0DQo+IFJURV9FVkVOVF9RVUVVRV9DRkdfQUxMX1RZUEVTLA0KPiAgICAgICAgICB0aGVuIHRo
ZSB2ZWN0b3IgYWRhcHRlciBzaG91bGQgdXNlIHRoZSBzYW1lIHNjaGVkdWxlIHR5cGUgYXMgdGhl
IGV2ZW50DQo+ICAgICAgICAgIHF1ZXVlLg0KPiANCj4gIC0gRWFjaCB2ZWN0b3IgYWRhcHRlciBh
Z2dyZWdhdGVzIG9iamVjdHMsIGdlbmVyYXRlcyBhIHZlY3RvciBldmVudCBhbmQNCj4gICAgZW5x
dWV1ZXMgaXQgdG8gdGhlIGV2ZW50IHF1ZXVlIHdpdGggdGhlIGV2ZW50IHByb3BlcnRpZXMgbWVu
dGlvbmVkIGluDQo+ICAgIHJ0ZV9ldmVudF92ZWN0b3JfYWRhcHRlcl9jb25mOjpldi4NCj4gDQo+
ICAtIEFmdGVyIGNvbmZpZ3VyaW5nIHRoZSB2ZWN0b3IgYWRhcHRlciwgdGhlIEFwcGxpY2F0aW9u
IG5lZWRzIHRvIHVzZSB0aGUNCj4gICAgcnRlX2V2ZW50X3ZlY3Rvcl9hZGFwdGVyX2VucXVldWUo
KSBmdW5jdGlvbiB0byBlbnF1ZXVlIG9iamVjdHMgaS5lLiwNCj4gICAgbWJ1ZnMvcHRycy91NjRz
IHRvIHRoZSB2ZWN0b3IgYWRhcHRlci4NCj4gICAgT24gcmVhY2hpbmcgdGhlIGNvbmZpZ3VyZWQg
dmVjdG9yIHNpemUgb3IgdGltZW91dCwgdGhlIHZlY3RvciBhZGFwdGVyDQo+ICAgIGVucXVldWVz
IHRoZSBldmVudCB2ZWN0b3IgdG8gdGhlIGV2ZW50IHF1ZXVlLg0KPiAgICBOb3RlOiBBcHBsaWNh
dGlvbiBzaG91bGQgdXNlIHRoZSBldmVudF90eXBlIGFuZCBzdWJfZXZlbnRfdHlwZSBwcm9wZXJs
eQ0KPiAgICAgICAgICBpZGVudGlmeWluZyB0aGUgY29udGVudHMgb2YgdmVjdG9yIGV2ZW50IG9u
IGRlcXVldWUuDQo+IA0KPiAgLSBJZiB0aGUgdmVjdG9yIGFkYXB0ZXIgYWR2ZXJ0aXNlcyB0aGUN
Cj4gUlRFX0VWRU5UX1ZFQ1RPUl9BREFQVEVSX0NBUF9TT1ZfRU9WDQo+ICAgY2FwYWJpbGl0eSwg
YXBwbGljYXRpb24gY2FuIHVzZSB0aGUgUlRFX0VWRU5UX1ZFQ1RPUl9FTlFfW1N8RV1PViBmbGFn
cw0KPiAgIHRvIGluZGljYXRlIHRoZSBzdGFydCBhbmQgZW5kIG9mIGEgdmVjdG9yIGV2ZW50Lg0K
PiAgICogV2hlbiBSVEVfRVZFTlRfVkVDVE9SX0VOUV9TT1YgaXMgc2V0LCB0aGUgdmVjdG9yIGFk
YXB0ZXIgd2lsbCBmbHVzaA0KPiBhbnkNCj4gICAgIGFnZ3JlZ2F0aW9uIGluIHByb2dyZXNzIGFz
IGEgdmVjdG9yIGV2ZW50IGFuZCBzdGFydCBhZ2dyZWdhdGluZyBhIG5ldw0KPiAgICAgdmVjdG9y
IGV2ZW50IHdpdGggdGhlIGVucXVldWVkIHB0ci4NCj4gICAqIFdoZW4gUlRFX0VWRU5UX1ZFQ1RP
Ul9FTlFfRU9WIGlzIHNldCwgdGhlIHZlY3RvciBhZGFwdGVyIHdpbGwgYWRkIHRoZQ0KPiAgICAg
Y3VycmVudCBwdHIgZW5xdWV1ZWQgdG8gdGhlIGFnZ3JlZ2F0ZWQgZXZlbnQgYW5kIGVucXVldWUg
dGhlIHZlY3RvciBldmVudA0KPiAgICAgdG8gdGhlIGV2ZW50IHF1ZXVlLg0KPiAgICogSWYgYm90
aCBmbGFncyBhcmUgc2V0LCB0aGUgdmVjdG9yIGFkYXB0ZXIgd2lsbCBmbHVzaCB0aGUgY3VycmVu
dCBhZ2dyZWdhdGlvbg0KPiAgICAgYXMgYSB2ZWN0b3IgZXZlbnQgYW5kIGVucXVldWUgdGhlIGN1
cnJlbnQgcHRyIGFzIGEgc2luZ2xlIGV2ZW50IHRvIHRoZSBldmVudA0KPiAgICAgcXVldWUuDQo+
IA0KPiAgLSBJZiB0aGUgdmVjdG9yIGFkYXB0ZXIgcmVhY2hlcyB0aGUgY29uZmlndXJlZCB2ZWN0
b3Igc2l6ZSwgaXQgd2lsbCBlbnF1ZXVlDQo+ICAgIHRoZSBhZ2dyZWdhdGVkIHZlY3RvciBldmVu
dCB0byB0aGUgZXZlbnQgcXVldWUuDQo+IA0KPiAgLSBJZiB0aGUgdmVjdG9yIGFkYXB0ZXIgcmVh
Y2hlcyB0aGUgY29uZmlndXJlZCB2ZWN0b3IgdGltZW91dCwgaXQgd2lsbCBmbHVzaA0KPiAgICB0
aGUgY3VycmVudCBhZ2dyZWdhdGlvbiBhcyBhIHZlY3RvciBldmVudCBpZiB0aGUgbWluaW11bSB2
ZWN0b3Igc2l6ZSBpcw0KPiAgICByZWFjaGVkLCBpZiBub3QgaXQgd2lsbCBlbnF1ZXVlIHRoZSBv
YmplY3RzIGFzIHNpbmdsZSBldmVudHMgdG8gdGhlIGV2ZW50DQo+ICAgIHF1ZXVlLg0KPiANCj4g
IC0gSWYgdGhlIHZlY3RvciBhZGFwdGVyIGlzIHVuYWJsZSB0byBhZ2dyZWdhdGUgdGhlIG9iamVj
dHMgaW50byBhIHZlY3RvciBldmVudCwNCj4gICAgaXQgd2lsbCBlbnF1ZXVlIHRoZSBvYmplY3Rz
IGFzIHNpbmdsZSBldmVudHMgdG8gdGhlIGV2ZW50IHF1ZXVlIHdpdGggdGhlIGV2ZW50DQo+ICAg
IHByb3BlcnRpZXMgbWVudGlvbmVkIGluIHJ0ZV9ldmVudF92ZWN0b3JfYWRhcHRlcl9jb25mOjpl
dl9mYWxsYmFjay4NCj4gDQo+ICBCZWZvcmUgdXNpbmcgdGhlIHZlY3RvciBhZGFwdGVyLCB0aGUg
YXBwbGljYXRpb24gaGFzIHRvIGNyZWF0ZSBhbmQgY29uZmlndXJlDQo+ICBhbiBldmVudCBkZXZp
Y2UgYW5kIGJhc2VkIG9uIHRoZSBldmVudCBkZXZpY2UgY2FwYWJpbGl0eSBpdCBtaWdodCByZXF1
aXJlDQo+ICBjcmVhdGluZyBhbiBhZGRpdGlvbmFsIGV2ZW50IHBvcnQuDQo+IA0KPiAgV2hlbiB0
aGUgYXBwbGljYXRpb24gY3JlYXRlcyB0aGUgdmVjdG9yIGFkYXB0ZXIgdXNpbmcgdGhlDQo+ICBg
YHJ0ZV9ldmVudF92ZWN0b3JfYWRhcHRlcl9jcmVhdGUoKWBgIGZ1bmN0aW9uLCB0aGUgZXZlbnQg
ZGV2aWNlIGRyaXZlcg0KPiAgY2FwYWJpbGl0aWVzIGFyZSBjaGVja2VkLiBJZiBhbiBpbi1idWls
dCBwb3J0IGlzIGFic2VudCwgdGhlIGFwcGxpY2F0aW9uDQo+ICB1c2VzIHRoZSBkZWZhdWx0IGZ1
bmN0aW9uIHRvIGNyZWF0ZSBhIG5ldyBldmVudCBwb3J0Lg0KPiAgRm9yIGZpbmVyIGNvbnRyb2wg
b3ZlciBldmVudCBwb3J0IGNyZWF0aW9uLCB0aGUgYXBwbGljYXRpb24gc2hvdWxkIHVzZQ0KPiAg
dGhlIGBgcnRlX2V2ZW50X3ZlY3Rvcl9hZGFwdGVyX2NyZWF0ZV9leHQoKWBgIGZ1bmN0aW9uLg0K
PiANCj4gIFRoZSBhcHBsaWNhdGlvbiBjYW4gZW5xdWV1ZSBvbmUgb3IgbW9yZSBvYmplY3RzIHRv
IHRoZSB2ZWN0b3IgYWRhcHRlciB1c2luZw0KPiB0aGUNCj4gIGBgcnRlX2V2ZW50X3ZlY3Rvcl9h
ZGFwdGVyX2VucXVldWUoKWBgIGZ1bmN0aW9uIGFuZCBjb250cm9sIHRoZSBhZ2dyZWdhdGlvbg0K
PiAgdXNpbmcgdGhlIGZsYWdzLg0KPiANCj4gIFZlY3RvciBhZGFwdGVycyByZXBvcnQgc3RhdHMg
dXNpbmcgdGhlDQo+IGBgcnRlX2V2ZW50X3ZlY3Rvcl9hZGFwdGVyX3N0YXRzX2dldCgpYGANCj4g
IGZ1bmN0aW9uIGFuZCByZXNldCB0aGUgc3RhdHMgdXNpbmcgdGhlDQo+IGBgcnRlX2V2ZW50X3Zl
Y3Rvcl9hZGFwdGVyX3N0YXRzX3Jlc2V0KClgYC4NCj4gDQo+ICBUaGUgYXBwbGljYXRpb24gY2Fu
IGRlc3Ryb3kgdGhlIHZlY3RvciBhZGFwdGVyIHVzaW5nIHRoZQ0KPiAgYGBydGVfZXZlbnRfdmVj
dG9yX2FkYXB0ZXJfZGVzdHJveSgpYGAgZnVuY3Rpb24uDQo+IA0KPiBQYXZhbiBOaWtoaWxlc2gg
KDIpOg0KPiAgIGV2ZW50ZGV2OiBpbnRyb2R1Y2UgZXZlbnQgdmVjdG9yIGFkYXB0ZXINCj4gICBl
dmVudGRldjogYWRkIGRlZmF1bHQgc29mdHdhcmUgdmVjdG9yIGFkYXB0ZXINCj4gDQo+ICBjb25m
aWcvcnRlX2NvbmZpZy5oICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgbGliL2V2ZW50
ZGV2L2V2ZW50X3ZlY3Rvcl9hZGFwdGVyX3BtZC5oIHwgIDg3ICsrKw0KPiAgbGliL2V2ZW50ZGV2
L2V2ZW50ZGV2X3BtZC5oICAgICAgICAgICAgIHwgIDM4ICsrDQo+ICBsaWIvZXZlbnRkZXYvbWVz
b24uYnVpbGQgICAgICAgICAgICAgICAgfCAgIDMgKw0KPiAgbGliL2V2ZW50ZGV2L3J0ZV9ldmVu
dF92ZWN0b3JfYWRhcHRlci5jIHwgNzYyDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
bGliL2V2ZW50ZGV2L3J0ZV9ldmVudF92ZWN0b3JfYWRhcHRlci5oIHwgNDY5ICsrKysrKysrKysr
KysrKw0KPiAgbGliL2V2ZW50ZGV2L3J0ZV9ldmVudGRldi5jICAgICAgICAgICAgIHwgIDIzICsN
Cj4gIGxpYi9ldmVudGRldi9ydGVfZXZlbnRkZXYuaCAgICAgICAgICAgICB8ICAgOCArDQo+ICBs
aWIvZXZlbnRkZXYvdmVyc2lvbi5tYXAgICAgICAgICAgICAgICAgfCAgMTMgKw0KPiAgOSBmaWxl
cyBjaGFuZ2VkLCAxNDA0IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIv
ZXZlbnRkZXYvZXZlbnRfdmVjdG9yX2FkYXB0ZXJfcG1kLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBsaWIvZXZlbnRkZXYvcnRlX2V2ZW50X3ZlY3Rvcl9hZGFwdGVyLmMNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBsaWIvZXZlbnRkZXYvcnRlX2V2ZW50X3ZlY3Rvcl9hZGFwdGVyLmgNCj4gDQo+IC0t
DQo+IDIuNDMuMA0KDQo=
