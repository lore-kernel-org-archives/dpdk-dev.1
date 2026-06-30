Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A588C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 09:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D2754025E;
	Tue, 30 Jun 2026 11:50:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0E68E4021E
 for <dev@dpdk.org>; Tue, 30 Jun 2026 11:50:04 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9nFrH235066; Tue, 30 Jun 2026 02:50:04 -0700
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022110.outbound.protection.outlook.com [52.101.53.110])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f3uwfb4av-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 02:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgyRNbYWkbQ5nJEB9b4pNgwz1/cCnAOCnu7UZEJhg3njED0AfxzVfpw+K9jGYOfpaWyXzUTfmTMDzFFKEoZG2WIz+g2wIvIRUoMGkLWqUHQJCgKdPPI03BDKalYsBsymWzpv51CA6AHu1jpp4DKqomoM5ymwFI3qCYKwYD1cW7CT/KRpr1/K/PzJ6EDoMZ84ByXgRpMDYvgzJmCMcKpaqV6cVMdhhbSJs0hun8zhzRM0QqY97byC9Ink+Z8k26L9hd2aQWz/EgnE7V50YTFsGxPr+y5PEd1lYUZbahHUgo6qAGNayfXsw8pgZ5fSV5QY8buHAhQFpYaI4V1trGkW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqQRZ0FBkqgFbZhGdGVJix/WIIFeQ2pNkUSPLUKQ8pw=;
 b=E9mIt5vllmWVwIwftOSJHUdR5o3QOKAEtnxbnPeDVj3yR/qb22GLzAX2a/P85JU0QSeTH1qbUJFpKXE5bvTdOZ+j2S37YdbokBMxAWH1WLs2/6xQa+iGvG7VvXCBLnWDBuPPJQ09oHTw2x9XTggXCHKKZWqRjussG3XB/7+PVVyMX/bRN/XBEAj1/HM6l+JPumKS2KzfQ05fZ739Ey+os+5Ulex0IxDfKmPgSIWHjPj5SE44X6pHmb7oIdybV+4nP5OgsZBMxoS4WnZLv+GWKB7LVSNuGGHNPY+ItYyU/OOgMw7kqnFnjuusez/ENh0WQ6bVaTJ16SmFTEGAAFiydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqQRZ0FBkqgFbZhGdGVJix/WIIFeQ2pNkUSPLUKQ8pw=;
 b=IJlJfrBF3KUQo+AKNSx9RXMMhG07gf8E3oHmzd8c6/n0TflK7AeIlIjn2jyRdWA3MI5oLLaCBkvx1apd49ekoc1RKURSlK/uo1+Wqq6yFZkuBEuEO+0zqJHEKgxW31l0TXfO1FC/gWWNtT0i0oCplMnVaTg9gS7h5hHGtf5WZVY=
Received: from PH7PR18MB5177.namprd18.prod.outlook.com (2603:10b6:510:156::9)
 by SA3PR18MB5602.namprd18.prod.outlook.com (2603:10b6:806:39b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Tue, 30 Jun
 2026 09:50:01 +0000
Received: from PH7PR18MB5177.namprd18.prod.outlook.com
 ([fe80::2781:49f8:1d96:14d8]) by PH7PR18MB5177.namprd18.prod.outlook.com
 ([fe80::2781:49f8:1d96:14d8%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 09:50:01 +0000
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v2 6/6] crypto/octeontx: use timing-safe RSA
 signature verification
Thread-Topic: [EXTERNAL] [PATCH v2 6/6] crypto/octeontx: use timing-safe RSA
 signature verification
Thread-Index: AQHdB/mxAWM6b0WX7ECsGoWaXX7W6bZW20Tg
Date: Tue, 30 Jun 2026 09:50:00 +0000
Message-ID: <PH7PR18MB5177F6A753B8FCC3366269BFA8F72@PH7PR18MB5177.namprd18.prod.outlook.com>
References: <20260625160200.24170-1-stephen@networkplumber.org>
 <20260629190027.2071745-1-stephen@networkplumber.org>
 <20260629190027.2071745-7-stephen@networkplumber.org>
In-Reply-To: <20260629190027.2071745-7-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5177:EE_|SA3PR18MB5602:EE_
x-ms-office365-filtering-correlation-id: 7802dbb4-70ab-4dbf-d89b-08ded68cf409
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info: 0xnwARahOiJ+brawn/S0QXu5EV/+pjQ+vlbkRA/Ed7x5YlBq5ZUecq0r3rZAvL3p9UoSQ9onV/e58Ffjgi4Ihrt+Yos4qZfE+Rpk/+paWA0X5L1aaivxUPMJrDVzZEqcKR50dcBFNYUIUBbDnw0pVVIkAjNb8PzxxMp95ZPYdY5Nvt4Ac2+m9/6podfgX/5GlAEjKQdgVfG8T4aXYHjBKXFdCt6uxTFo/RYSQ0P0YuGBqNn57J1sJrp9T4Ef8mmNSd7erBhd6DObC0BAaM7dCdGxQBAvpfWy6kkmN7iTtDxNBdSyF2OcdfFLTuNGdBKH8PEQ3kJ7oPWTgbMlyzgyHnvHWNtCeSoBeRkexhiT4i0XnqSP4rNKJVak6gL3S0ipQ/TJU0wZBf1UQTLXbPg2QMOpBWpFZo9qKnaFvfs8i9gyNyzEWDmi88apxzYmMOM4KZKeDvtvfwGJRzdOKKuZWxwB/FurhTe4dhYg/Zm/f3c6jf+KQcTTSMfWxlxCNaKtxErsT7L8d041E1ae6UyHkdDyaw7rvrviyUYTnWiHqC7ju+Mqm04RI0Vr4PimzA79k+vFiu1QW/Pyb3R4HWi/HAOXYqgiNdH8L8Ei/1Kqxwqa5PjXCXebk0Ke/PgCnqzJ9JQDIOT4+q/++6Iq4jwbiniqbnjT7o9Z26tdHbMvU0SY23A3qOA51MX7JRk77XANEFvXqRqU80duu/MtGuibkoq05q1zj8ZnD6rQ9FzwR5I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR18MB5177.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1NRQjlpb2R2VHY1L0xYMHd3MjNIZmpqY3dEVURpU1J0ay9FaDVEeTZNK3hW?=
 =?utf-8?B?bFd4SUIxeFRURXRFZmNJOElpMURUU3U4TVliUlFPNjdSNThyRTE2eDJQMjV6?=
 =?utf-8?B?OEhFVjZHZm5TM09aTm8xMWRzSE9CN3NudWVrZmxVamJqM1dYV3NNMmFLMkNl?=
 =?utf-8?B?WDg5YSswVklhdWFMSm9wT1JjZ2hxaHF2czdiQjVDdFZBcFhZbW5nL2kwMStr?=
 =?utf-8?B?bHA2b0NWOGF2SHlEWER6OHJGZ1dBcGp2R3kzZFBBQVAvK0xMZXZqSUkzaUFT?=
 =?utf-8?B?ZTlHcU1qZ2JqcEtlT1pUQjVFL2pkTUQrdnBINU1ObmZ3cXp0WnZwQms4cWhY?=
 =?utf-8?B?T29tUm9UN3huaWRMMXJEMnY5MVk0cC8yRlVLVTRjRDlGdkJ2SjErcE1UeXlS?=
 =?utf-8?B?dVU3TU5QUE9VU2swYU5WSGdFMUswM0FOT0U3amNGOFlDL2tYL01udzFHTldO?=
 =?utf-8?B?TjBSSjJIelErK3JNbktpTVNlanJwd0hyQjQySmowMGs5ZkpjS0Yxc2M1T1hF?=
 =?utf-8?B?Z1E0a2JlUDU2TWd3Y2xXSnhFZmMzb2E1dmlsQ20xUFdJaU5qeElwTzZDd0U1?=
 =?utf-8?B?RjBLWGZRYzg0cng0QVZEdW1kNXNBTnltL2VWZUNIOEVVSk9jYXo0SXRrQThQ?=
 =?utf-8?B?UXdUMFRxak5DV1JEUFFzdncwUnBIWXAwdWhJVURQM25NNzNiYy9IaURLcXB6?=
 =?utf-8?B?YVNnMlR2a2RuQ1ltSzNvK2RNYTdVZWpYOGV4SDNYeHFyc0RKa1VmdnFiUGlh?=
 =?utf-8?B?ZWlOSnU1b1lOMTdBTk9iOXI2Q0wvTkFKeWV2YlVHTnN4T0pjWkxaaUc3S0c3?=
 =?utf-8?B?MGRrbHQ5bmhXYUVtbTdvZXVuZTNZZVNpSUJtajgycDdwODlvdjdEa1lpSDVm?=
 =?utf-8?B?TEhJWHdXM0orZE9ncDdnQ3BUSTVGeEhxOEs2TjZBeUhkMCtMRjZHVDZzem5S?=
 =?utf-8?B?TE41Y09xV0N2QUlTbWtEbTNFb3hBMmsrcFB3ek5ja0R5SjBaN0phakIzSHdK?=
 =?utf-8?B?U0VlckZTTkFGd0NyVVNTNXJZMFV2US9wT3dMaVVxam4veTFoNW5LcXE2ZzFL?=
 =?utf-8?B?ZHdQVWhQb285SGVkYmk3ZURZRmV6TDVDK0IySUNodmUzOUxKVjdYOVZxWlJv?=
 =?utf-8?B?VWdwd0IzckJOU2oyaTJ0dU1xRElqY1YvK2x2eVRxcHA0UG1CUCt1emVGaFll?=
 =?utf-8?B?YVZEbmtaRmMraVNodktRclFkOStzOC9iOStSdjVEWmRURVJHNU9FalNtRnFH?=
 =?utf-8?B?K1k1dDBaUCtMTnJzS290M240bldWVVpCTHNyRHB3ZVFrN2NTNzZZeTZVdmJI?=
 =?utf-8?B?bUVKNkFCSDVUZFJ3UFM1RmxJWkljOHA1TVRaMkJzM0pXZW9lUFlRWmJvemli?=
 =?utf-8?B?bmRJQlRRS3hZMXp0UFZ6dDVvbnhTV1MyNXM1WGV3SnA3RlFoNTdpSmhneUF6?=
 =?utf-8?B?ZDlqSERTRUNmV1ZUVzlCZnJzZmxaRk9hY2NHSk5qYlpuUzNwN1ZHY0x4OGFp?=
 =?utf-8?B?aEIxQzlVT0ZZUWtCQlUxK3NWcDZ6SXFIMURQSGVqQ0FFMHdITC90T2N3MHpr?=
 =?utf-8?B?MENVdGYvd1ZWM1o1YUhDZHBxb2hFMFNmWUVwTHZqYWJEKzMwQjRlRHBkOUpO?=
 =?utf-8?B?clRsMjFxQnhMUGtPallLMEZHcjVpLy8vVFdhNEhBQUFuOGhkTDREYi90Unla?=
 =?utf-8?B?bWE1Zk5SM21qUGQ0dnJOdHZhZ2oyTC9rRm5IS2JpR0ZsbW5CZXIzSTZmMzVu?=
 =?utf-8?B?SHFZcUNzL29oTnZISVFaZmNnMFpUZkVBeFFUSEZoTGI1YkJTZVkrL1BPTmVh?=
 =?utf-8?B?b2YrTlFEUlZucm5qN3gvemhScjl5d3phcHhTcmRIOFFic3hyc3FHMGhteUU2?=
 =?utf-8?B?Y2p3MDVlRkJHSGsxUTBobUhFWVZOdEprczRaYjcyajNBdnBQMWl1Q1FVdXJr?=
 =?utf-8?B?QTlST1U4aEhRTkcxVGNIMTBrN3BBTzBrS0hkNy91OGtmc3BHWG05dS9sQWMw?=
 =?utf-8?B?VjRXSTVYeWxGWWpkbjJHVm4rU3VCdGVibWM5dmZJUFFZVkxuSVRyQ0FKRlVQ?=
 =?utf-8?B?THE3L1l6R0w1UzFuVEowZGRQRXh6bHYxdE11YzZTMUVBVWNBRVEwS1ZIZ1pF?=
 =?utf-8?B?OFRyQ0UwZW52bHJpSUx1Z3hGYmhqQkxzVldUTXBtYjJFbVEyblhwYWRVNHlv?=
 =?utf-8?B?UGVWMVJlRkFBSXJWdVlLZHppdzU1b3NQMzdXQ0IxS1BCbW96Q0lNSVBrS0po?=
 =?utf-8?B?N01JKzF4SU5hV2ZVNDdFWFh6NVQ3N1dJd2QvRzU4Y0FJYmJxdThUbHZkOEJz?=
 =?utf-8?Q?9ysAhFvcLVyotwS7AB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Qzljd7p7HnT3OaXdq9lVY7A2fmYYVuLcdaYq5YLjPlKMnHwO7F+CoLgb+bgjurvx5laT7dwDp0jLBOKQdH4taAQSoq5w7zIM+y/1L5OXVxEDUZ79VyS7QMmCObcinV1oBf31LIicSHA2AM8YqJY1t1BQKCGLdHRLNd4RyP6eiXZQ3tgpQcFA6N4DfXmEIQL76/fjcv9mlF8G+Q8xGp5JDVO/4q008WcPGPeFHp6DsAvS6wEpcwv7ZWYV+Pdi4w1zhq1Ormvxiq2xWZucklkFVgU5i+FqpXbn+OqZCLSvP2rjyX54Ex0XJyMM/zISt8hLpQAJDAwbt8ZFB9VON/+nTg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5177.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7802dbb4-70ab-4dbf-d89b-08ded68cf409
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 09:50:01.0824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuRJvfVDzC/bVG/wK0Kvq1u35IC8PDwoMLswu6Tn2reqhODX+HUgOcan+0pc52IrhZ11dnudELOS1Q51YsnSmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5602
X-Proofpoint-ORIG-GUID: ZA-3i9kzIYUEgoO-_4WIt1IkhETplbV-
X-Authority-Analysis: v=2.4 cv=WNJPmHsR c=1 sm=1 tr=0 ts=6a43914b cx=c_pps
 a=E5lcl6OKqxSDDTEGn4Qc9w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=jZVsG21pAAAA:8 a=8rWy6zfcAAAA:8 a=DsG2BGXdSIjkg0v4wooA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: ZA-3i9kzIYUEgoO-_4WIt1IkhETplbV-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4OCBTYWx0ZWRfX9oZg6XvSZP2u
 1QD5dsqv29b0/7Jzh52QvKneGOkr/PZjJ54Fde9SC8fjFtIKIkra3SZS7wHFtI7LQdAwQeghifp
 otBeJQgnvHAn65zLJXhIsShEyGG4CypGygwz3lnp4OvqEHqol7nAOD+SGej+o8WudVFfGd/0FB/
 qULZPrwKRnJMdGP28YrNC43VgXgdL0ARqh1KBWxL6N7druek1nE5BcXXpl9zDQaqYqT5ZBY3W2i
 Uz0JueeLfXbBCsxaGY6qclUMaOECVoN915pmw3GHJHd0sRv5+qShb9uHK69yVzCtn7KqITlqPyR
 GTVF5ziMT4lcN2+eGoIXStN5I19kGW8FyAGNQqm0RasgsWtS56PuS/AMKkIptBTvWfJZg0Wo4zg
 tUIdHtPE1P+bU0+F/TSueuaMiNHBwHFlnz917yENE79hrqHZWeDhCbMVBbiOL3EyHIEPcD/+mxz
 rnmKtX9qZsBG8Xxm1Aw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4OCBTYWx0ZWRfXzWYrYRW9OMrN
 e5w6SUgoGuvBQWIb85PH4cKN/aBhoTiNjEqkEuE0AMWa2VKVwJIR2qRLyZOgsNNAfJSg/RfFGhd
 vf+PGdzZ9XUB2rh+BEj8N2GzejqsWL4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
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

QWNrZWQtYnk6IFRlamFzcmVlIEtvbmRvaiA8a3RlamFzcmVlQG1hcnZlbGwuY29tPg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVw
aGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAzMCwgMjAyNiAx
MjoyOSBBTQ0KPiBUbzogZGV2QGRwZGsub3JnDQo+IENjOiBTdGVwaGVuIEhlbW1pbmdlciA8c3Rl
cGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+OyBBbm9vYiBKb3NlcGgNCj4gPGFub29iakBtYXJ2ZWxs
LmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0ggdjIgNi82XSBjcnlwdG8vb2N0ZW9u
dHg6IHVzZSB0aW1pbmctc2FmZSBSU0ENCj4gc2lnbmF0dXJlIHZlcmlmaWNhdGlvbg0KPiANCj4g
UmVwbGFjZSBtZW1jbXAoKSB3aXRoIHJ0ZV9tZW1lcV90aW1pbmdzYWZlKCkgd2hlbiB2ZXJpZnlp
bmcgUlNBDQo+IHNpZ25hdHVyZXMgdG8gcHJldmVudCB0aW1pbmctYmFzZWQgc2lkZS1jaGFubmVs
IGF0dGFja3MuDQo+IA0KPiBUaGUgY29tcGFyaXNvbiBhdCBkcml2ZXJzL2NyeXB0by9vY3Rlb250
eC9vdHhfY3J5cHRvZGV2X29wcy5jOjc0Mg0KPiBpcyB1c2VkIHRvIHZlcmlmeSBSU0Egc2lnbmVk
IGRhdGEgYWdhaW5zdCBleHBlY3RlZCBtZXNzYWdlIGNvbnRlbnQuDQo+IFVzaW5nIHJlZ3VsYXIg
bWVtY21wKCkgZm9yIGNyeXB0b2dyYXBoaWMgdmVyaWZpY2F0aW9uIGNhbiBsZWFrIGluZm9ybWF0
aW9uDQo+IGFib3V0IHRoZSBjb21wYXJlZCBkYXRhIHRocm91Z2ggdGltaW5nIGRpZmZlcmVuY2Vz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29y
a3BsdW1iZXIub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvY3J5cHRvL29jdGVvbnR4L290eF9jcnlw
dG9kZXZfb3BzLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL29jdGVvbnR4
L290eF9jcnlwdG9kZXZfb3BzLmMNCj4gYi9kcml2ZXJzL2NyeXB0by9vY3Rlb250eC9vdHhfY3J5
cHRvZGV2X29wcy5jDQo+IGluZGV4IGQ2ZDFiMmNlYTkuLjQwZjU2NWNkNzggMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvY3J5cHRvL29jdGVvbnR4L290eF9jcnlwdG9kZXZfb3BzLmMNCj4gKysrIGIv
ZHJpdmVycy9jcnlwdG8vb2N0ZW9udHgvb3R4X2NyeXB0b2Rldl9vcHMuYw0KPiBAQCAtMTIsNiAr
MTIsNyBAQA0KPiAgI2luY2x1ZGUgPHJ0ZV9lcnJuby5oPg0KPiAgI2luY2x1ZGUgPHJ0ZV9tYWxs
b2MuaD4NCj4gICNpbmNsdWRlIDxydGVfbWVtcG9vbC5oPg0KPiArI2luY2x1ZGUgPHJ0ZV9tZW1v
cnkuaD4NCj4gDQo+ICAjaW5jbHVkZSAib3R4X2NyeXB0b2Rldi5oIg0KPiAgI2luY2x1ZGUgIm90
eF9jcnlwdG9kZXZfY2FwYWJpbGl0aWVzLmgiDQo+IEBAIC03MzksNyArNzQwLDcgQEAgb3R4X2Nw
dF9hc3ltX3JzYV9vcChzdHJ1Y3QgcnRlX2NyeXB0b19vcCAqY29wLA0KPiBzdHJ1Y3QgY3B0X3Jl
cXVlc3RfaW5mbyAqcmVxLA0KPiAgCQl9DQo+ICAJCW1lbWNweShyc2EtPnNpZ24uZGF0YSwgcmVx
LT5ycHRyLCByc2EtPnNpZ24ubGVuZ3RoKTsNCj4gDQo+IC0JCWlmIChtZW1jbXAocnNhLT5zaWdu
LmRhdGEsIHJzYS0+bWVzc2FnZS5kYXRhLA0KPiArCQlpZiAoIXJ0ZV9tZW1lcV90aW1pbmdzYWZl
KHJzYS0+c2lnbi5kYXRhLCByc2EtPm1lc3NhZ2UuZGF0YSwNCj4gIAkJCSAgIHJzYS0+bWVzc2Fn
ZS5sZW5ndGgpKSB7DQo+ICAJCQlDUFRfTE9HX0RQX0VSUigiUlNBIHZlcmlmaWNhdGlvbiBmYWls
ZWQiKTsNCj4gIAkJCWNvcC0+c3RhdHVzID0gUlRFX0NSWVBUT19PUF9TVEFUVVNfRVJST1I7DQo+
IC0tDQo+IDIuNTMuMA0KDQo=
