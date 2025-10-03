Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200A9CCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 18:47:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6405A402BB;
	Fri,  3 Oct 2025 20:47:30 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 885CA402BB
 for <dev@dpdk.org>; Fri,  3 Oct 2025 20:47:28 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593G4avM023196;
 Fri, 3 Oct 2025 11:47:27 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020119.outbound.protection.outlook.com [52.101.46.119])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49jhpagamk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 11:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeOhEMb2z3r2nd50V+O5ALr5qKCwZ/lhFI+fIxvFL8oepXLAVyHrC9d0yfyThlP/oSElwSfxU9BfcegwJPWkAiZnFqoa7ve+hiOrBYWvOUqG3uWxAqPS6L694JSZpp/MwAFLQcOalqPMXb9RsFeHuKqMqeIQgQQsKghc6ZbQ1Bp5rIgygDxP/Uua8U6BR7GiVHbslq8I2+AJY6b+/D17/S2cwmrriApP0O5ZMu1UlIjwif1oOz3Bc6piBrhvT+CplzJ05bdaDRe1DmCa9xYy1v83c4KIplenUXheKO7PMSGrzBZyvHf7DtYtFXJOFChzbWV556ysUwBfcI/gq0KQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N6FuSvOkQHQhmMiDa/QcYAoOI8ccSQ5B5kbIXEdlHI=;
 b=GokpFT3PcuEHuLxzF2Yxx80K6ED3sjgWOReyZWBIQjqR1zpHl+Edf2pS4+rehBKXC4yvtqstewfYONFUAYxHc2YNNGOcdO0HntEoiMdHsa3JpJmjDWJRSEefcQrXmjuSsnwBKUXgk77NXjJquJ0ccLYsnAEZWv0wDlqqW1qUGcRx+OaC7JwBYsNLfnXgmvyXUoUTP0u5X1YZ5ppiW7NyQKDiJjLAG34l5SkAw938UdkNQW+Pf7w1KvNiOBhEDIUNRZhjuq6G2YWq+bQATbiL570N/4WfXW8LhVBXV8sda/mJbq4a8MCtSke7g0UZLbgEy9NacvV+v3diWY02asAfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N6FuSvOkQHQhmMiDa/QcYAoOI8ccSQ5B5kbIXEdlHI=;
 b=Kzq+jT6ESMFzwRrb/TKEo9lY5OCfNLV2cY+Lv02BTd1Lg/58uF8Ivwf9zoRWRpMCO8pN61V4QrsyNChoibPZtNETiesUK3G4/crVGzgAgIHmptxfVgmWoqFN9vyGKqUX4w2afhT+hhMZ8Scd3J3APxYq0USz7zy1EKCjXvG+DqA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA6PR18MB6316.namprd18.prod.outlook.com (2603:10b6:806:416::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 18:47:20 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 18:47:20 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sameer Vaze <svaze@qti.qualcomm.com>, Fan Zhang <fanzhang.oss@gmail.com>, 
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 1/3] compressdev: support for dictionaries
 and PDCP checksum
Thread-Topic: [EXTERNAL] [PATCH v2 1/3] compressdev: support for dictionaries
 and PDCP checksum
Thread-Index: AQHcNIYTTW/JHXlU4kqR3voc8YiCxLSwwjfg
Date: Fri, 3 Oct 2025 18:47:19 +0000
Message-ID: <CO6PR18MB4484CA4CD683706DA702B1D1D8E4A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
 <20251003165132.3201643-1-svaze@qti.qualcomm.com>
In-Reply-To: <20251003165132.3201643-1-svaze@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA6PR18MB6316:EE_
x-ms-office365-filtering-correlation-id: d50456f3-7548-4086-b266-08de02ad485f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MVVqZytOYXlackVDM2RoeGRObnQzOUpJTmE2cXVZNUduVVl1blVyTURvdGY5?=
 =?utf-8?B?S2RteTY4NnVQZnduUzV5KzlZUWRZU2RHalR5RHRjdnpQdXYxYUVkS2ZJMXNu?=
 =?utf-8?B?N0I1VGxmYnNKd3NDYi8xVncySUREeWdsYVBzNHpucUI0MWhNWWlNTTZUUXE2?=
 =?utf-8?B?YXgvWGtqeVhSOHpIVTNWTHlIcHlqSFRncUYwcGJjUTBoY3hQTFhVNUdBRFhB?=
 =?utf-8?B?WDBDSXpCZmZyUE9KRE96U1EvcFI4cDBwekc1enJrV2RoT0dVRFFyUEhxc0o3?=
 =?utf-8?B?OWZKazVVdG1HckdUMERMU0puOFRHTkxYTmpWWGsyVkE1NzF3bFlSV1k4ZSsr?=
 =?utf-8?B?Z0d2ZTYxaHVVaWlxNWllbmYrRHhuZlY4amtYT2F2NzZ0cFF3Z3dPQnc0Q3Zw?=
 =?utf-8?B?SnhpSFU5SmNaWlRTQVU5dzA2ejl1OGhud3QyeUNFZzdrUFB0bUI3SGF4WFlE?=
 =?utf-8?B?eExtK3UrTTROY0JGK1FvOWJhSGF2dkI5S3ZiZ0pkYnpESDc4WjlJTWYzeVpm?=
 =?utf-8?B?eWk0WFgxbmF1ZldIdFZ0ZmZ5Y01kczR2YU5VUEVSNjNUQ3pLa1hpNkZ3blZ6?=
 =?utf-8?B?ajVnTTZYZHR2bGRUY3JWZVVsTS9CeC95M3JMYWFRa05xVDVzSVB0YzFsazVG?=
 =?utf-8?B?NzdYWFBRYnVZM3J3L0xRRXZwa3JFY1lCemNSOHV0REtIakh3UjNEQlEySmFF?=
 =?utf-8?B?WElHWHJhYjk1SGZMUndZcUtZT3lUcUVVU2VNdDh1eFdWc1FEVCtNR242MFlF?=
 =?utf-8?B?K3BEMHNhUWx6SHhNQXBBam96NzJLUGhjbXpzWmtWbEx1aWFDeUpwOEQzcmRn?=
 =?utf-8?B?aEdoRkJjZkFaZ05YMlRoMFdWZkFMMEtyeFYyKzJCemZOMmpHM2JnWnZSZ05J?=
 =?utf-8?B?NTZGd3FoQjRwRzEzYVZEYUpTU3Z5M0JEZW94Sit3bHYvYTZKblZqRWhPUjNm?=
 =?utf-8?B?UUw4cmVVMDViM2pWQ2lKL1ZaUktlOC9iLzZuR3kwVWhZeEdSV0NmRnNqYnpY?=
 =?utf-8?B?SEZXTFRoaTBsMEJaYjV0dXh1UE5CNnl2YmlDNXY1OW15MnhMUFB5U0JKUmdL?=
 =?utf-8?B?WWR5Q1RyejMrcGdCY1lCUEhETG5iZXdmSjFXem9VTzdIMm4rR3QrMzdsais1?=
 =?utf-8?B?MzNyQTJuQ0FpcUxKQnkwYUNEQjVFQUtxT0dyOVQ1SE5jYy92WXZWV1FLelRM?=
 =?utf-8?B?RGJzeVNna1BTZGEvNTAxaXlySzFBbEZ0eGQ5QVFSWkhCdTJqejdWVTFEMFZI?=
 =?utf-8?B?WDdWbVdlQVphVDZKZUg3MU1hRFpIbVpTdmZmUHBkSHJJYThmanRuUE40ODJK?=
 =?utf-8?B?TjllMjdtYTBiajcvalV2bFJ0TW1tL0xpNGNBeGVBOG5ORWIyZmhuamNvWkZw?=
 =?utf-8?B?cklLZHhmaEtvVmkreHN0T1RiT3VFdVFQQU9lbXRmc3duRmN6Q2VrWjU3YmZX?=
 =?utf-8?B?YTlzNHlxMk9Pa1pYUTArSFYvaTRESFlkcVJ6WFRiU2R6eVM4akFIMjY1MUo2?=
 =?utf-8?B?NjFaWTRNbm1WUElnZk5vUVZVOUpiUDlwb1dSWFV6SW9pTTdQbmRrekgvS0xk?=
 =?utf-8?B?SVZ6WTFzMEpuREVRYllONjhSNEZzMGJ2UjB2TjFxaGs5c1NURXBVamJqeENW?=
 =?utf-8?B?eHpjd3V5RFJLK0ZJNHA0U1dPQTI5U1J3Slhuamg0UndYTmxHYzBaWFM5cWdI?=
 =?utf-8?B?dmZXNmVmbEJRU0dDTGlWbldKOGxBcmdvcDZTMHVRbFhmZ1d1aUxJN05UVTZW?=
 =?utf-8?B?eFM1dmQ1N0wycytnZmFzL1R0d01nd2JlcDY0VGNuS2lFcWxKbVZsUjIxcFFF?=
 =?utf-8?B?eVk3RE5XTENYR0JwNHh2ZGVRUE5aRjlsL0U2NnF1bm5UeTcyVjhEMFI2ODFo?=
 =?utf-8?B?cms3NHU2MjZRUVJVQVlXUDE4TDlqVW5BT2NlRDlPdWhNOVh6bkxaQmgwNHdE?=
 =?utf-8?B?ZTNJQlhHQnl1N1NCQzQyL3VNQ1c2YmorM1NIaURoZFdJWE9mS2IwYit3aEtu?=
 =?utf-8?B?UTNTOUUrdDlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnpKdElpMklHS0wzVUFzTlA2d1pwQ3BraXZYVDlBcW8vYmFua3JDMThRRFhu?=
 =?utf-8?B?eHNQN2htRnJyU3piam9TaExLejZVWElkdUJMSUZwdkZoTUUzUnhIbk1UZEJj?=
 =?utf-8?B?Wnoyd0w3UG9keHRkeHVFcFE4NmdiQzdwdHRxeVhvR0x1TnJEMUtmVzc1TVJo?=
 =?utf-8?B?RldmclI5VmJHMzJ1djhhZGY0SlRYc0VUTzZ1Mzh6MFk3YkRTaHh5bEdpN0pr?=
 =?utf-8?B?VERFL2dHT08vYlNyWFhFZytveXc3aXppMVZid2lvYkRUWml6KzBOZWJyUCs3?=
 =?utf-8?B?ZTUvT0szeG9FZi9KaklRMGxXc0V4UnJYcFlFYjN3djRlNks1TWZlVGxVbnU0?=
 =?utf-8?B?SUdPNnlyMWdpcEh5em5LUm0zNU1IYyt4OXhqQUlRUWxSZzMyaXp1R2Q5S2My?=
 =?utf-8?B?WXVmZE91OWFUYnFzSmpFdjh5ZWExZ0ZHNURKbmNMbnZ4K3RpVGNucHUwcmdH?=
 =?utf-8?B?LytIUW8rUWZWK0hSVlVzMGZ3NkRnUEt3ck9VTWIwcE9mRW42Q3pjeFNNZ01Q?=
 =?utf-8?B?TjU5bzl6UjRQc1RnV2hTZkRueG1HeGtVV1N4TDIxd08wcThXTGNEK2N4eThZ?=
 =?utf-8?B?YnE1VUhoRVk1SUxSM1Q0NkVKdzV6WTk1MGZ2V05zdnNSM0hqRkZCK3JBMzFM?=
 =?utf-8?B?TmIwazMzbU04T1E0VXMxbmk2ZFIydk9SMnpIamtnZHd6ek4yL1JwMGJQNnhm?=
 =?utf-8?B?SktkbkVYcVRJTklFckxqdGhNMHBwTU9LSU1xeHo5dE9Td3NoUWR4cFJqRjhR?=
 =?utf-8?B?ekpWS0E3cHNKcmNqN1BLUi82YmxBeFFTcnNsS2tvdTVSNm5aZUxsMWErNUp2?=
 =?utf-8?B?RnpBVGtsNTZUdGJjSFNWbllSYUlpbW5idUFYb0x2NzR2THB6L2VkMVVxNFF4?=
 =?utf-8?B?Mm1rUVkycFNsL1hubjhIRmd5K2l5VkloT1FZL2tnOVhGamtNWjdTYXp4ZWxV?=
 =?utf-8?B?RFpPUXFSTCtGSmNvZHQyWloxUGk3T29PQVdkUHhzSzN6WVRqWFZ4cFlPOUl3?=
 =?utf-8?B?OE04SmlITlUxRXEyYmN0b0JWQkphWGxFY1BhZkpqQjI4MWlpWkJuaVVmM3U1?=
 =?utf-8?B?Qm9FVWwxRE9DTTIrNzlYZlZpbzVqZng3M3VxVTR0TkhpNHA1bGlCOHJBN2JU?=
 =?utf-8?B?T1hlbmtTeW9DQlRWQk41Vm5GYVBiRmZ6ek41Q2RrbEpFNjFJTVlKeHpoVG1E?=
 =?utf-8?B?VlUrdXRUdy9pQ0htZzJhUmtPamE2V2NWalBpUUtRemViZUdxR0lQQTJjd2Z1?=
 =?utf-8?B?dEIvRVhmMnNXL3hITWFVdkM2SUdHbE5Xcm5ScXRtWnVsK2ZXL3JPVUdvOFVM?=
 =?utf-8?B?MkJ4QVVYdlVDMU9KNzlHY0VSVU5GRmsvelhPYnJtVDZwOE95a0g5aHVZUjBJ?=
 =?utf-8?B?RUJEV0M1b3B6NkJ1ZW9WZ0tBZnFLMWE0VVd6ZFJ0ZTk4cE40Q2w4QW1NWUZU?=
 =?utf-8?B?WU0vV3VDL2lIQ1VIWHlodUhSVi9MVThCRGFENlFURlMzY2h5SnhaazBTZDFh?=
 =?utf-8?B?V2UvUXYrYzFEMVlKVU5NY3hFelZ4OS9JL3ZCTTg3U05HdG5ZME9yaEtqa1Qv?=
 =?utf-8?B?bkgrUzlUUkZqN2lRTXE3d0F5NDFoQ0pwK29oTE9Rek42MTVtdzZtOVlFS3Fo?=
 =?utf-8?B?NEQweXlaZFVPRTNTd05rQTBmaUZaQlVPTzcya0FldkJ5dUpsT2QrMjRKbjBB?=
 =?utf-8?B?bDRGNkZQTWpER0YvSnU3cktkc215LzNKcVFqcmg2YmlScU81bE1Wd2dIdDJF?=
 =?utf-8?B?YzZ3Qlp1S3RITXR5UTVsZGt4T2loZGNiY3k3SkZ2a1ZuOVNSV1A1SFVMejZz?=
 =?utf-8?B?YTRuQWRzbnFDbWVmQWlXSVVJR3kvMGJGRDNRRjF3SzByTTBmT3FjM29PNHF0?=
 =?utf-8?B?MWdESmJBejdCaVRDUUdGdVRLenFDWXdQS2xxSHF4djVkOVlKbGRKRjN0dE1x?=
 =?utf-8?B?OUV6amVzbWE0WTVXNW1aZ3JnMC8zUXk3Rk4rMHBuNmI5K29PaGRKRkhoR29y?=
 =?utf-8?B?cjJTTXJqNTR0cTU2NEpPTWNNZWs5dE5FcW1LMEdFTUUzMVBaYTczVFdDYXB3?=
 =?utf-8?B?L2oyZ1N5VmJrVUYyTnA5RkdvMXBrUXpJbFU3R042NG1OZHl6bEhMMDhYdUpV?=
 =?utf-8?Q?bi4Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50456f3-7548-4086-b266-08de02ad485f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 18:47:19.9251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fU6Jh/0hrU68+k8I+dsLiMjvpZLfZSwUWX/29rTAN3TOjMtyjkzwVmrVRX68AVgHkQOrCofGjwaDBXZYVxQNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6316
X-Proofpoint-GUID: rT4y6B3031ab1DIq0qGJlJM54JddgYTX
X-Proofpoint-ORIG-GUID: rT4y6B3031ab1DIq0qGJlJM54JddgYTX
X-Authority-Analysis: v=2.4 cv=Xrn3+FF9 c=1 sm=1 tr=0 ts=68e01a3f cx=c_pps
 a=dV5UnTNaioTBtvBhj0ZdMg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=RpNjiQI2AAAA:8 a=EUspDBNiAAAA:8 a=ug8mWqatfnKqdughOcUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDEzMCBTYWx0ZWRfXxnN+wmvZyifC
 MCMe/+O7Li522DATSZ5j5pEun4Yb+iGYrNnBxF3LtVEOZkS2hSdnknFTXv0WMCWIIIldFH75ASZ
 OvL7imFpT8qsMPvFts+esq9zmwP58tYzE7TiDOgaY85OfLaeKNVA6rUKEgt28O0WyowhXxYEYgH
 BEbjUOnXxRBh4ccjShR9Cf3Ry/Yak4xxpcTH8/6NNeATC7Kcwa6nEHT1+kMB4GdSmzOvg4i9EHa
 x3+MzOUqwsSK5TLqjM81GNgAiYvkXV1x/1La78Ixf484zXdnEB3XWUiWm3rUEGSKwSRNJ8HhNf4
 8GQUxeG7yU1G5MbuTUF7im4noM0YygSj+j8BUYk6Kczmt9WeyHvnscJDB+7jgRM4weYTR+4wypJ
 U8rgiRBbhgVCWKUBJa0O0JlvvSYXMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_06,2025-10-02_03,2025-03-28_01
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

PiBBZGRzIGRlZmluaXRpb25zIGZvciBQRENQIGNoZWNrc3VtcyBhbmQgYXBpcyB0byBwYXNzIGlu
DQo+IGRpY3Rpb25hcmllcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2FtZWVyIFZhemUgPHN2YXpl
QHF0aS5xdWFsY29tbS5jb20+DQo+IC0tLQ0KPiB2MjoNCj4gKiBNb3ZlZCBkaWN0aW9uYXJ5IHBh
cmFtcyB0byBkZWZsYXRlIHBhcmFtcw0KPiAqIEFkZGVkIGluZmFsdGUgcGFyYW1zIHRvIHVuaW9u
DQo+IA0KPiAgbGliL2NvbXByZXNzZGV2L3J0ZV9jb21wLmggfCAyNiArKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9saWIvY29tcHJlc3NkZXYvcnRlX2NvbXAuaCBiL2xpYi9jb21wcmVzc2Rldi9y
dGVfY29tcC5oDQo+IGluZGV4IDk2ZDliMjc2ZGQuLjI1ODM1ZDU4OWQgMTAwNjQ0DQo+IC0tLSBh
L2xpYi9jb21wcmVzc2Rldi9ydGVfY29tcC5oDQo+ICsrKyBiL2xpYi9jb21wcmVzc2Rldi9ydGVf
Y29tcC5oDQo+IEBAIC0xMDEsNiArMTAxLDEwIEBAIGVudW0gcnRlX2NvbXBfb3Bfc3RhdHVzIHsN
Cj4gIAkgKiBpcyBub3QgYW4gZXJyb3IgY2FzZS4gT3V0cHV0IGRhdGEgdXAgdG8gb3AucHJvZHVj
ZWQgY2FuIGJlIHVzZWQgYW5kDQo+ICAJICogbmV4dCBvcCBpbiB0aGUgc3RyZWFtIHNob3VsZCBj
b250aW51ZSBvbiBmcm9tIG9wLmNvbnN1bWVkKzEuDQo+ICAJICovDQo+ICsJUlRFX0NPTVBfT1Bf
U1RBVFVTX0NIRUNLX1NVTV9WQUxJREFUSU9OX0ZBSUxFRCwNCg0KUGxlYXNlIG1ha2UgdGhpcyBh
cyBSVEVfQ09NUF9PUF9TVEFUVVNfQ0hFQ0tTVU1fVkFMSURBVElPTl9GQUlMRUQsDQoNCj4gKwkv
Kio8IENoZWNrc3VtIHZhbGlkYXRpb24gZmFpbGVkLiBFaXRoZXIgY2FsY3VsYXRlZCBkb2VzIGNo
ZWNrc3VtIG5vdA0KPiBtYXRjaA0KPiArCSAqIHRoZSBvbmUgcHJvdmlkZWQgb3IgdGhlcmUgd2Fz
IGFuIGVycm9yIGNhbGN1bGF0aW5nIHRoZSBjaGVja3N1bQ0KPiArCSAqLw0KPiAgfTsNCj4gDQo+
ICAvKiogQ29tcHJlc3Npb24gQWxnb3JpdGhtcyAqLw0KPiBAQCAtMTY2LDYgKzE3MCwxMCBAQCBl
bnVtIHJ0ZV9jb21wX2NoZWNrc3VtX3R5cGUgew0KPiAgCS8qKjwgR2VuZXJhdGVzIGEgeHhIYXNo
LTMyIGNoZWNrc3VtLCBhcyB1c2VkIGJ5IExaNC4NCj4gIAkgKiBodHRwczovL3VybGRlZmVuc2Uu
cHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtDQo+IDNBX19naXRodWIuY29tX0N5YW40OTcz
X3h4SGFzaF9ibG9iX2Rldl9kb2NfeHhoYXNoLQ0KPiA1RnNwZWMubWQmZD1Ed0lEQWcmYz1uS2pX
ZWMyYjZSMG1PeVBhejd4dGZRJnI9RG5MN1NpMndsX1BSd3BaOVRXDQo+IGV5M2V1NjhnQnpuN0Rr
UHd1cWhkNldOeW8mbT1acUtUTmhPMlVuN0lXWlVvbTg2ejk0RDlJbi0NCj4gTkFHSzZFYnM2cmtK
d2dxSkhEX2lYc2RIaEk3WkpPUF9tcGNETSZzPUwzWTAzVFhHam1LWFRvVVhNTTlaWTRKdA0KPiB1
TnFBU1I5aG1pNmZHdE9pcF9jJmU9DQo+ICAJICovDQo+ICsJUlRFX0NPTVBfQ0hFQ0tTVU1fM0dQ
UF9QRENQX1VEQywNCj4gKwkvKio8IEdlbmVyYXRlcyBjaGVja3N1bSBhcyBkZWZpbmVkIHVuZGVy
IFVwbGluayBEYXRhIENvbXByZXNzaW9uDQo+ICsJICogY2hlY2tzdW0gYXMgZGVmaW5lZCBpbiB0
aGUgM0dQUCBQRENQIHNwZWNpZmljYXRpb24NCj4gKwkgKi8NCj4gIH07DQo+IA0KPiAgLyoqIENv
bXByZXNzaW9uIEh1ZmZtYW4gVHlwZSAtIHVzZWQgYnkgREVGTEFURSBhbGdvcml0aG0gKi8NCj4g
QEAgLTIwMSw2ICsyMDksMTAgQEAgZW51bSBydGVfY29tcF9mbHVzaF9mbGFnIHsNCj4gIAkgKi8N
Cj4gIH07DQo+IA0KPiArI2RlZmluZQlERUZMQVRFX01BWF9XSU5ET1dfU0laRQkoMVVMTCA8PCAx
NSkNCj4gKw0KPiArI2RlZmluZQlERUZMQVRFX01JTl9XSU5ET1dfU0laRQkJKDFVTEwgPDwgOCkN
Cg0KSSB0aGluayB5b3UgbWlzc2VkIHRvIGFkZHJlc3MgdGhpcyBjb21tZW50Lg0KVGhlc2UgbWFj
cm9zIGFyZSBkZWZpbmVkIGluIGV4dGVybmFsIGhlYWRlciBmaWxlcyB3aXRob3V0IGNvbW1lbnRz
IGFuZCBleHBsYW5hdGlvbg0KQWJvdXQgd2hlcmUgYW5kIGhvdyB0aGVzZSB3aWxsIGJlIHVzZWQu
DQoNCj4gKw0KPiAgLyoqIENvbXByZXNzaW9uIHRyYW5zZm9ybSB0eXBlcyAqLw0KPiAgZW51bSBy
dGVfY29tcF94Zm9ybV90eXBlIHsNCj4gIAlSVEVfQ09NUF9DT01QUkVTUywNCj4gQEAgLTIyOCw2
ICsyNDAsMTggQEAgZW51bSBydGVfY29tcF9vcF90eXBlIHsNCj4gIHN0cnVjdCBydGVfY29tcF9k
ZWZsYXRlX3BhcmFtcyB7DQo+ICAJZW51bSBydGVfY29tcF9odWZmbWFuIGh1ZmZtYW47DQo+ICAJ
LyoqPCBDb21wcmVzc2lvbiBodWZmbWFuIGVuY29kaW5nIHR5cGUgKi8NCj4gKwl1aW50OF90ICpk
aWN0aW9uYXJ5Ow0KPiArCS8qKjwgUG9pbnRlciB0byBtZW1vcnkgY29udGFpbmluZyBkaWN0aW9u
YXJ5IHRvIGJlIHVzZWQgZm9yIGRlZmxhdGUNCj4gb3BlcmF0aW9ucyAqLw0KPiArCXVpbnQxNl90
IGRpY3Rpb25hcnlfbGVuOw0KPiArCS8qKjwgTGVuZ3RoIG9mIGRpY3Rpb25hcnkgdG8gYmUgdXNl
ZCAqLw0KPiArfTsNCj4gKw0KPiArLyoqIFBhcmFtZXRlcnMgc3BlY2lmaWMgdG8gdGhlIGluZmxh
dGUgYWxnb3JpdGhtICovDQo+ICtzdHJ1Y3QgcnRlX2NvbXBfaW5mbGF0ZV9wYXJhbXMgew0KPiAr
CXVpbnQ4X3QgKmRpY3Rpb25hcnk7DQo+ICsJLyoqPCBQb2ludGVyIHRvIG1lbW9yeSBjb250YWlu
aW5nIGRpY3Rpb25hcnkgdG8gYmUgdXNlZCBmb3IgaW5mbGF0ZQ0KPiBvcGVyYXRpb25zICovDQo+
ICsJdWludDE2X3QgZGljdGlvbmFyeV9sZW47DQo+ICsJLyoqPCBMZW5ndGggb2YgZGljdGlvbmFy
eSB0byBiZSB1c2VkICovDQo+ICB9Ow0KPiANCj4gIC8qKg0KPiBAQCAtMzIxLDYgKzM0NSw4IEBA
IHN0cnVjdCBydGVfY29tcF9kZWNvbXByZXNzX3hmb3JtIHsNCj4gIAkgKiBzZXR1cCBvZiBzdHJl
YW0gb3IgcHJpdmF0ZV94Zm9ybSBzaG91bGQgZmFpbC4NCj4gIAkgKi8NCj4gIAl1bmlvbiB7DQo+
ICsJCXN0cnVjdCBydGVfY29tcF9pbmZsYXRlX3BhcmFtcyBpbmZsYXRlOw0KPiArCQkvKio8IFBh
cmFtZXRlcnMgc3BlY2lmaWMgdG8gdGhlIGRlZmxhdGUgYWxnb3JpdGhtICovDQo+ICAJCXN0cnVj
dCBydGVfY29tcF9sejRfcGFyYW1zIGx6NDsNCj4gIAkJLyoqPCBQYXJhbWV0ZXJzIHNwZWNpZmlj
IHRvIHRoZSBMWjQgYWxnb3JpdGhtICovDQo+ICAJfTsgLyoqPCBBbGdvcml0aG0gc3BlY2lmaWMg
cGFyYW1ldGVycyAqLw0KPiAtLQ0KPiAyLjMxLjENCg0K
