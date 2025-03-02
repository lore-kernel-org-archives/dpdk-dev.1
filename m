Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA05C19F32
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 11:30:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED2B040291;
	Sun,  2 Mar 2025 12:30:53 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id BF5264027F
 for <dev@dpdk.org>; Sun,  2 Mar 2025 12:30:51 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522BQk6Z016730;
 Sun, 2 Mar 2025 03:30:50 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4540fu9gmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 03:30:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=un4cB5W4sDM6GCbp7yohFmJfiQJKj+fAGJUksCJcWc9BGKmc2LpIpNq7pyx7uzyd6U7jf3lkjTqAOhfi6EMiVr3BfRSbIsQvDslngPl8+hwSds3sD/mASXTA+Vxy8KmZUVVbMbOYq076hRx+IApi1NOpNjZmKh5TNY6S26GGD98gOZs35pBZOSm3YHgXJVqGd1KVaqvIAWFq3pV8l0A771Im1JQvTNCXGD+8UBHZQldHOfPXFLrFBR5Rp4i8M77MiYwyjEzvjh5e8BCXJigFeculY77wh8sxNEQlH3ffJqyZ4WJc/ix8FS/gNiyyoZobvS7Z4xz/xjE/3Uud4NxPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXlTkFxZ5lhisgecKTNrAAYm7msLDtijY2VWU5VSJTw=;
 b=ffMrvx/CouNFeUFJgE9M4jRpl8aVREHHx0lNFJdBG4Bwr5bLTZrBUJyKh4JRlGo5We3yoS27wAb4+JWOCbfhQPvOKNVYNztdX53Mf2prX9/ex+t+vZSol5YAaFe3RgUbDHX546lCzwzniWqcHx/BYqD+kD11W+19ucfIZ+Kj9MFTkAFcpat8ms7YXwi0qctqygkN316jQ81x/8HeiLQrIQJqpZ4gn+9FvqngMfoPfKS6SdilQ4W1ZID74e2nRWNclPe81+6EpEQYtv+rdn/jLUPu5m+m5AzxhDQ5giSNuuA/XV5HI/pJdOWXFEphtOfQaOMqh5A8wLKHiKsR9JumVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXlTkFxZ5lhisgecKTNrAAYm7msLDtijY2VWU5VSJTw=;
 b=cnR5btSFhuRoYXyw9ROHliBy5X9h+cPF0mjEwmaG0+R9vJB0/XyNN3k1Iw6Z4/njcSONfTvdjA1zPvEI2kJt2jkYIoZ0WbVCXt0ywKYM/e8/xrR2HWuYLnY7zdcAkmpjkQJWcg9ZYB1JkDf9lazuS6ljMSv08LN7RfOR0GCxNTw=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by BN9PR18MB4169.namprd18.prod.outlook.com (2603:10b6:408:133::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Sun, 2 Mar
 2025 11:30:46 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 11:30:44 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Luka Jankovic <luka.jankovic@ericsson.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "mattias.ronnblom@ericsson.com"
 <mattias.ronnblom@ericsson.com>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>
Subject: RE: [EXTERNAL] [RFC v7 4/4] eventdev: documentation for atomic queue
 and atomic atq tests
Thread-Topic: [EXTERNAL] [RFC v7 4/4] eventdev: documentation for atomic queue
 and atomic atq tests
Thread-Index: AQHbgtRNVDPR426QdkKP56ciR+XpR7NfxQ4w
Date: Sun, 2 Mar 2025 11:30:44 +0000
Message-ID: <BY3PR18MB478540973234B08A4A6AB96CC8CE2@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250124095937.1436673-1-luka.jankovic@ericsson.com>
 <20250219134325.1195531-1-luka.jankovic@ericsson.com>
 <20250219134325.1195531-5-luka.jankovic@ericsson.com>
In-Reply-To: <20250219134325.1195531-5-luka.jankovic@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|BN9PR18MB4169:EE_
x-ms-office365-filtering-correlation-id: 969c9fc4-5577-452b-e51e-08dd597dabb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Q0FoUUwwK1NqVmpoa3lHRXYxWDZaSS9wb3FJeDJBbW5DbWQwWmM1NEg4OG1v?=
 =?utf-8?B?ZFdKY1lSVjJOdmpNZ3I2RndhV2oxbnlwM2YwSk9sVVpwTkh3cVY5UVJ5UlU0?=
 =?utf-8?B?ZEp2ZTdlVzdlZDZvNmVCUGxnZ3JaR3poUWtwY1hHOHRlSFBJTWVadStKSUhv?=
 =?utf-8?B?OGZXNjdsaGpQdFM4N2V2Ulg4TGlhc2xWUDYyVUR0cU5nQnluZHBTTWFMSjNp?=
 =?utf-8?B?eCt6ZFNmRGFNdkhwVWpiUUR6MWVSNEFpOXNtNnJJUlFJVS9DOXpmdjA3V0FX?=
 =?utf-8?B?UDlTNlFSVzB0aVViSjhXS1VUYWhmY0V0SVFIb3pKNVZpd0xRTmpRM0JkT2x5?=
 =?utf-8?B?ak9qeHZEVDJHcXpDY3NOQmRkc01qd0dwWXRaemxhelYxMGVBa2UxWVByWG9h?=
 =?utf-8?B?UnVGRWd2R3N3bVd1VWJVcVZZdXhsWGJJZkl1ZlpodXlNR0x0akNhRUtGSytt?=
 =?utf-8?B?YjZGa0ZuZXN5YWFRMGVLMDU4MGwzUlZDQVFJMHU5ZkQzUXhiS1graXZGRDBJ?=
 =?utf-8?B?N0R4Ykg0RHI5UUVqdU8zTS9BSGxVZ0JjeWpDZEtxZk9BNUJZdW85V2xHOHBu?=
 =?utf-8?B?NW1sOVZOWWRZc0hHVmdVRWNhNjFYQVBFRWxlM3UrZUdWWDFNN21PdUp4UHY4?=
 =?utf-8?B?M216RkN0cDR4MFhNZEF2Tm9KL3UycHNhUXRXNXFwMU4yMlpWWWtxVzhFK1lq?=
 =?utf-8?B?ZUdCSlZkSUFOd05vbzJjZWNiOXkyUmpYN3VjZnFGa3UzWDN5UjhPa0FqeWFl?=
 =?utf-8?B?RTVnTG9Bb2oxTjRNaE1KZ2NNTXRkNlZzYXhOZVdLRUt2M0pJRVRISlBoeFVO?=
 =?utf-8?B?czl1SlFXWHI0K1l3TUt3aUVvTHVsSEt5ZXBGVm9ENDdEUE56MXpsUFp6M1g0?=
 =?utf-8?B?MTZSaTMvOUFpSDRGbE4vVk8yemtUcHVGV2tvVlM0MmdmSjEyc0RuVWdVUCtT?=
 =?utf-8?B?ajc2TEtZQlorclpHUGlnVTVlcXZTQWpMNDUvUU9hUUhENEtiZUVFWVdIVUxW?=
 =?utf-8?B?ZWsxOE1jVXhXeFVyd2tXdTZYYWZ2K2VUZmdNQkJLRWNreERkeEpEVFMrSmFm?=
 =?utf-8?B?bUY4MDNUZzNKcFUxWCtLZWsxN1NudVRPVFFtQ1dISXIrMFh1MHhLQVBKZTNk?=
 =?utf-8?B?aDVCc0k3ZS9BMUIyNDNYdkd6dlRiRUNEdTZCampCZlVFcVVWUFl0M0NoTlk0?=
 =?utf-8?B?L3ViYkxEY05BdFVOTG1YT1Q0N0IxcGRvT2ZSU3RqWU95NHRBRy9ONDRabG5B?=
 =?utf-8?B?Q2VWUDRoanphak5VeEZRb2k2elN4TkJsRkJsVUlpSEcxbU5nM3dBc2VLM0VM?=
 =?utf-8?B?bjFuNU1EZzhrQzdWTlk0OGVybHppK2xod1hsOHE4aW84d1BIMktVa2pNNytK?=
 =?utf-8?B?c0tiMXlFUlZOZ1kwUDFkSzdidVdXMThReUFvdEJwbkhHS1AybWRsVWJTOHow?=
 =?utf-8?B?a0JNY250aityZU1VWjF1amhub3c5cDJQY0JPVmpWVHF0Nk45ZEQ1N1hhN2NP?=
 =?utf-8?B?blFnUTIrdHhGQ2FQb3ZpZHlYaTNOWGdFMFV4aTQwei9oTnRtZW01eVdYK0lI?=
 =?utf-8?B?T0JvZ09KR1FDMlpYVDFXQVpCeWU1a0pXeE1BVEkwdXQwUE84Y3FOZkxXMFlM?=
 =?utf-8?B?VGcyYnBuRURIcVg4Y3h2Sk93ZlhNemlGNnZaZ0N1WXJqdk9FK2FqRHQ3SkRS?=
 =?utf-8?B?b3ZibWlnYTRPb0licHVhM1U0eTBTbzI3WHVLS3lUU2VsWWs2djl1Sld3Ni9j?=
 =?utf-8?B?bFYwbkM1MTFieTVQTDk4MmZ3dzlLdEt6T2FueHYxOFgyYi9lcC9PeFpKSHJI?=
 =?utf-8?B?Z3cwbk1EQlgxSXgzcS9XM3BYQVBMbFNqZnQrR2ZXNWxCYzJ6djJRZUNtb0hG?=
 =?utf-8?Q?OM/YXa2CIATHB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkRqM1VmTnFoSTgwLzBKV1dTeGxybVg0QUJVcEFnMEpJR0tXMFJzRGVFelJi?=
 =?utf-8?B?MHN3dVYwU0UybGUvWTVjeGFYeFFaRHpYRUp0YnhsYlluQVduYXpyOTdsQmox?=
 =?utf-8?B?NXN0QXRyS3VNOTA1T1FLTkdDZ0tOODZ4cjlKVlUyRk1pNHZLejlrU1RHRklY?=
 =?utf-8?B?V0VqajdJQWpZSlJUUmRnbUs2SFBVUjNVTXJvMXdvQllOVWxsaEdtWXBMTmNB?=
 =?utf-8?B?bXJxK2NxVHB2RWJMWml3WThFVERPVUxwMVlWK3BkM0c0ZUU0MzA3L1dxZFJQ?=
 =?utf-8?B?UXF5NHh1R3FpcVpvWXd3NFcxTkc2L2NwU2Y1U2JJTlhGMktMV2tpa1M0bnRM?=
 =?utf-8?B?SGtNRHE3YktWVElrblVkbVhudXY2bUpUalVqWFMvd09aRGFsWmVIT0VFRGNn?=
 =?utf-8?B?amt5ZlcxTkwvRFRBM2dVKzc4MndjR0RWWHpJbmtFWEg5bEVnYk1jSTFKQ1la?=
 =?utf-8?B?aVlhYjYwVWpWa2hSVEZod0wyajFhaVBXalFNSVRCcDhrbUt1Q0lsVTJGYTMx?=
 =?utf-8?B?Q2NIeUVyejlvdWxKUXhnSk5iR3VJTXU3SXMrTUk2aVI0RFY3bEV5dHdFVFlj?=
 =?utf-8?B?a21QQnUwU0FNVWE4czlzdXdVRVFhWGhRbVZxcVdZbWRxVEtwdUpOVFRqWTNT?=
 =?utf-8?B?cmYwQWhBaGZmOVd1djZKbnk1bytWczVaQ3k4NzIrSlJNVURhbTJBbFJoYjYx?=
 =?utf-8?B?TWV4b2dvajF3U0hmMWhweGhrWW5YMlkyZEthY3J2VGV6VXZDbnQxMC9scUh5?=
 =?utf-8?B?TnpTOXlpYjdmc3piUDhIajRCY1JaMWIrV2I3bGZiNWZCR1FqcnF6UTNJbk44?=
 =?utf-8?B?UURURE83S2hqajBtb3BvRlNhaHBsZVRLVU5wZjBHK1RqYmg4R3M0THRxaTA3?=
 =?utf-8?B?N2kxRmtZbmFjYU16OWZ0N3lkKzJrMEpBUmlmM01RTHZGWnE2bmRZVXYvVjU5?=
 =?utf-8?B?UG5rUnVSN0VKakhzRW4yWFhHQ0hlYmZleEVtak1HQjBrY2pPWjVXWklpVWRW?=
 =?utf-8?B?TGd2V3RtYlZTVnRKcGltejZWY2NROVdSQU5Ka3BlNkRZbzNDN0JDZlp1Ujg4?=
 =?utf-8?B?MlFoVmwvdEk3YXovMkdzMC8rOUZTYzVBUm1FR0JtT0hvM29WZCtsN0ZFUjJK?=
 =?utf-8?B?NVhJOXZNUThTeG9xeS8xa2VGOVRYNFJRSkVSd0Fuc1I1OEcxVktXd0R0WkRM?=
 =?utf-8?B?OWIrTVhlWnpUMU1UaGdESEtLZmswc2xTODJuSE9CTWVGVk1SeTRkWDFweWlF?=
 =?utf-8?B?dFVvcFdhdUVOTGN6aUYwS00rbUlSSUdpeVduM1hTbzVqSnJnbTRGNy9rT1BW?=
 =?utf-8?B?ZkFuVGFIK0tlWHlsS1ZNclg2YXJlNTlBL1BtY242VkVUNHdUbmpxNW5LazJT?=
 =?utf-8?B?MXpyd1NldjhHTjhFdUhVeXhrOER2RFhUMENvNnpvczdVOERuYmRaVnF4c0Z0?=
 =?utf-8?B?VkZDT3pMSml1L3NqYlNlZ0VlVFp3NGhQTnhvcG11NFBkVVhKYjlxdGFUSmRY?=
 =?utf-8?B?UHhmKzFORmw3SUpJMGVzMzk1MmdGb01sUjJUVG5mTU9oNHJ5YnhIc1F4MmVz?=
 =?utf-8?B?Skl4ckZzYnEwSEM3dU94WTF4ZTM4UGM4QkFld3R1ZXJQVEJaRDRxd3NFK0lz?=
 =?utf-8?B?dlk5Y1JsL0wxL3NpVFJlSnhjRER4RGwvOG04UDQwNHRUdmRGenEwUGJRRGF0?=
 =?utf-8?B?eEtoUTJzVHY2MmVmb1JqcjZVYjFGODR4YnFTeTI0OTFBYWwyQlRyR1JwU09W?=
 =?utf-8?B?QW5NREZ4dW9ocGp6MlhqWmhNekMvcnVBN0c3Qi9OODhxay9nLzNta0N0d2NZ?=
 =?utf-8?B?V0Z3L3NhZlUraFdVTC82UnVxUHJPcWRBTEYyb3FYNnJ3N3lhb0ZjeE1icVhy?=
 =?utf-8?B?UGZmKzl6Y3ZMbldjV1lSeTdDZEpjdEEvenlIdjIzTWhhNFZaOWNUUk5kSWdR?=
 =?utf-8?B?bGx0MGpxc1BpSXpiaUdwOE1sTklLZ2VISkFvVTZRMHNwNG9kZ3l4UlZORHIr?=
 =?utf-8?B?UVRwZWlLUmxMRmU3bXQ5eVk1N2drR21oMU5NVEdHSWZ6Z1hHekhjeHhmWHNX?=
 =?utf-8?B?MU42cG11ZFRTWkpJaW5obnlhVWNBbThhL085bUlIK0NJbUZ0cWJNN0UrQ0p5?=
 =?utf-8?Q?lh8Y=3D?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969c9fc4-5577-452b-e51e-08dd597dabb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 11:30:44.2505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9DW2APJd4K720Swungu3npY8LPAVklGBKj/tqQ3hEaeyaakLNbiyU60lbYKhEipowEZQi9TfMp8c7d/WNOaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4169
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 8WDFYEiW_g0191EyxpgQXjE7Opd48WWi
X-Authority-Analysis: v=2.4 cv=e5P8Sbp/ c=1 sm=1 tr=0 ts=67c4416a cx=c_pps
 a=19NZlzvm9lyiwlsJLkNFGw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=0FD05c-RAAAA:8
 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=O9rMLvU1OJ3WHwl7zg0A:9 a=QEXdDO2ut3YA:10
 a=l1rpMCqCXRGZwUSuRcM3:22 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 8WDFYEiW_g0191EyxpgQXjE7Opd48WWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_02,2025-02-28_01,2024-11-22_01
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



> -----Original Message-----
> From: Luka Jankovic <luka.jankovic@ericsson.com>
> Sent: Wednesday, February 19, 2025 7:13 PM
> To: luka.jankovic@ericsson.com
> Cc: dev@dpdk.org; Jerin Jacob <jerinj@marvell.com>;
> mattias.ronnblom@ericsson.com; Pavan Nikhilesh Bhagavatula
> <pbhagavatula@marvell.com>
> Subject: [EXTERNAL] [RFC v7 4/4] eventdev: documentation for atomic queue
> and atomic atq tests
>=20
> Add relevant documentation and figures to the tools/testeventdev page. Si=
gned-
> off-by: Luka Jankovic <luka.=E2=80=8Ajankovic@=E2=80=8Aericsson.=E2=80=8A=
com> ---
> ..=E2=80=8A.=E2=80=8A/tools/img/eventdev_atomic_atq_test.=E2=80=8Asvg | 1=
588 +++++++++++++++
> ..=E2=80=8A.=E2=80=8A/tools/img/eventdev_atomic_queue_test.=E2=80=8Asvg
>=20
> Add relevant documentation and figures to the tools/testeventdev page.
>=20
> Signed-off-by: Luka Jankovic <luka.jankovic@ericsson.com>
> ---
>  .../tools/img/eventdev_atomic_atq_test.svg    | 1588 +++++++++++++++
>  .../tools/img/eventdev_atomic_queue_test.svg  | 1701 +++++++++++++++++
>  doc/guides/tools/testeventdev.rst             |  155 ++
>  3 files changed, 3444 insertions(+)
>  create mode 100644 doc/guides/tools/img/eventdev_atomic_atq_test.svg
>  create mode 100644 doc/guides/tools/img/eventdev_atomic_queue_test.svg
>=20
> diff --git a/doc/guides/tools/img/eventdev_atomic_atq_test.svg
> b/doc/guides/tools/img/eventdev_atomic_atq_test.svg
> new file mode 100644
> index 0000000000..0459d9f649
> --- /dev/null
> +++ b/doc/guides/tools/img/eventdev_atomic_atq_test.svg
> @@ -0,0 +1,1588 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!-- Created with Inkscape (https://urldefense.proofpoint.com/v2/url?u=
=3Dhttp-
> 3A__www.inkscape.org_&d=3DDwIDaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D1DGob
> 4H4rxz6H8uITozGOCa0s5f4wCNtTa4UUKvcsvI&m=3DM3r2ERBtjmi60SQwe4KmEK
> enw-0hf6i8FVOIwMDD-XJGI68GEM0VHT6uaBX7LbDB&s=3DM_QEMF-
> 40ilGHAYdpbAk1KrRdJ_xTLerpibmujj7qxM&e=3D) -->
> +
> +<!--
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2017 Cavium, Inc

1) make it as Ericsson copy right with correct year in all files
2) Remove RFC tag
3)Add Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com> to all patches
4)No need to have separate doc patches, Please move the doc changes to rele=
vant patches
5)Update release notes about this feature
6) Fix following checkpatch issues[1]

Good to merge next version.


[1]
[for-main]dell[dpdk-next-eventdev] $ ./devtools/checkpatches.sh -n 4

### [PATCH] eventdev: atomic common for test-eventdev app

WARNING:BRACES: braces {} are not necessary for single statement blocks
#255: FILE: app/test-eventdev/test_atomic_common.h:65:
+       if (atomic_locks =3D=3D NULL) {
+               evt_err("Unable to allocate memory for spinlocks.");
+       }

WARNING:BRACES: braces {} are not necessary for single statement blocks
#259: FILE: app/test-eventdev/test_atomic_common.h:69:
+       for (uint32_t i =3D 0; i < num_locks; i++) {
+               rte_spinlock_init(&atomic_locks[i]);
+       }

total: 0 errors, 2 warnings, 241 lines checked

### [PATCH] eventdev: add atomic queue test to test-evnetdev app

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#63: FILE: app/test-eventdev/test_atomic_queue.c:35:
+               RTE_ATOMIC(uint64_t) *const outstand_pkts,
                                     ^

WARNING:LONG_LINE: line length of 114 exceeds 100 columns
#115: FILE: app/test-eventdev/test_atomic_queue.c:87:
+                               atomic_queue_process_stage_1(t, &ev[i], nb_=
flows, atomic_locks, expected_flow_seq,

total: 1 errors, 1 warnings, 237 lines checked

### [PATCH] eventdev: add atomic atq to test-eventdev app

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#63: FILE: app/test-eventdev/test_atomic_atq.c:34:
+               RTE_ATOMIC(uint64_t) *const outstand_pkts,
                                     ^

total: 1 errors, 0 warnings, 223 lines checked

