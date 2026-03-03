Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB76BD58E49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 03:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1398402B0;
	Tue,  3 Mar 2026 04:56:41 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11023120.outbound.protection.outlook.com
 [40.93.201.120])
 by mails.dpdk.org (Postfix) with ESMTP id 1A2BD402AB;
 Tue,  3 Mar 2026 04:56:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsjwhcSz9shM0u8qJhFIXB6o+FwGchL88Y+QTLqkolgIeQhHDx7aelV6npn6XWSG5cA3XPddKmRt1b96rJRd5Cmh37sm15M43tO1vS4cX3OaVXi8/0ha+0BNoUFsC9fxeer5flOgopzHVCMWxuFKNHXHjxD33zIYLudbOvSv6+j1Kwpkt7ihtmrBXWZTbOjALuZCeoI1Xs1Enid5axyaqznG8IgFUa+Pn5F1Z5h8RLyAQ18kJdYHa6wSje8bO+K3G84N8NiolSNnozuIdDOWtF+VBFnb8kBhc1ersAXBKv80Fqp7zoMMxfeR064DuRXJrtN2F60cs7kYj1p9f7nFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwNP9M/VBj7aLgZ8CrlY3/mSKuOthcy2z4adM7JLUi0=;
 b=NHA4iX1ZNPgLtqiQdB7pIdO524XqSLCOKP6rvhpxg+qvXUb4cgjvN3avaa/6Ss/3BZ3ST584M/pUkOLXTXd46djY3BCjMKBZGoEEchIK+hvXa7RKJTQZNJYFvSBubCMytzFhIIb34zXa1iuzOiU7bm9aQZamz7kW6khbbVXHVahWr4Iei2QWQgl1VMxe1nurKiVqg+yZvNuFcR963iHssGbSfuUneXHuf+llmjY2Cu14BzdurI3AdLoQGDrPxc77pUvsXqPfyo8oUZTwrdQozLyofAwNpYYf+09euGE6EeqpfE8yd8qVUGzBLM91fkHAsD0nZerEuSvHwb+lEIy8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwNP9M/VBj7aLgZ8CrlY3/mSKuOthcy2z4adM7JLUi0=;
 b=IHd5pIg34BDNhpzBtVSEv9CXprRD3cAMP6cWUJgQWKjePviSnwA7xBJQfx0RJ1i3At9m7UAUJSk2ziypcNBbc8fHeqnD+b6W6iG1+OpSmzcJpmLHiPZf1UhOMverFfEUCm00xqQq4KfawCDQSuqFTgIqE8QXExSQIN+J6dyX4GE=
Received: from LV2PR21MB3374.namprd21.prod.outlook.com (2603:10b6:408:14c::21)
 by LV9PR21MB5190.namprd21.prod.outlook.com (2603:10b6:408:2f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.2; Tue, 3 Mar
 2026 03:56:23 +0000
Received: from LV2PR21MB3374.namprd21.prod.outlook.com
 ([fe80::f2b8:576a:8c2f:ae46]) by LV2PR21MB3374.namprd21.prod.outlook.com
 ([fe80::f2b8:576a:8c2f:ae46%5]) with mapi id 15.20.9678.006; Tue, 3 Mar 2026
 03:56:37 +0000
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>, Wei Hu
 <weh@microsoft.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3 0/6] net/netvsc: bug fixes and runtime queue
 reconfiguration
Thread-Topic: [PATCH v3 0/6] net/netvsc: bug fixes and runtime queue
 reconfiguration
Thread-Index: AQHcqrkFuif/qdaJ9UWdWWMw5NKburWcLc5g
Date: Tue, 3 Mar 2026 03:56:37 +0000
Message-ID: <LV2PR21MB3374BD187483851C6BE74936CE7FA@LV2PR21MB3374.namprd21.prod.outlook.com>
References: <20260303025403.269182-1-longli@microsoft.com>
In-Reply-To: <20260303025403.269182-1-longli@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d416a4a8-78ef-4307-8b81-aa598b04b7d7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-03T03:55:50Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR21MB3374:EE_|LV9PR21MB5190:EE_
x-ms-office365-filtering-correlation-id: 17abb02d-20f7-4970-683f-08de78d8de52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: RGSAZ/JabQTZWO+sD2vB774100JMkLEFGRSC+c0qqcnFW7hsAfHqTxx4Mjq2YzW8CnfpqX/sEElUwt+IPg3itfbApUUSyPzoi1GNoWtoSIjuOX0InK7He4OPu/3ErQ6WlM7aeEUT/xaVO01fcMTwJsC0/Z/RfKMEVBK2PVLpNuhRgb5KY/9jPwqfeGy9c/9XMfwe5tYcUqGtg6zuseXiCL2+4NlAtoU9PwK2ehyHQycZm/+4ONSep6qK8tcYsL3SglPvqUJJFTWGUQ1LtR/MeRYNs1dQou1dVTyOk8ZmFEywcnNVj/BVo3Fv6S8aMjRSyDRiUSJRVkxvNzE7URT0ZYsMsyelO1q+akucICj73itEQwsJ5EoGC/mw0+Lt6doBWByDx1lpxRR4aRljh25RQYCDO79s///0YhFcpvjNiJVFcz3R/+16txt259nixi3UU6WlaYRD0azXOAU3PevhGJY2KPoCM4OaDi2LbawBB3CJpUhmUJuMZD1BGH+m+B8487zACBfngE55JAcZYjjOIjlU4g1JLrNnoNBDMouOBsXEToqng8sUKXD0gEzeJV1apEn3+EXZcQHpmQqZYPEKfNqCH4fdeqr1ta2qO4T3crCvcBD/r9qonzRGib0HwjqZ8h0MZAK3wLK9qu4VWqi4c2By71qn7O7YvKgdyL997tcBHAoOfiszco1dwzuEq2KA1aa24Nzp9APq1qrMgMLZklEDW+u2Cqa9MwnfgKVQY0OEl7AJIbbb11qRXk0AdL+0YaJOGzKaFcCR2FlelNAO/zZ19/mrqi0r4QTUzXP0F70=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR21MB3374.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkNkb2xMU2t2aU1rMFRYQTNVWWlJKzYwcG5jaWo5K1loaktudjBFNUhSQU8x?=
 =?utf-8?B?WG9wNXZtRFhsdUx5dFdNK3BwVURiTXpoaUhXTFNUSzB2ek53cmc3RFNYZUxN?=
 =?utf-8?B?ZFovNnhPcWRxU0R3ZmJTZjNqYW4rRlBibWovaDIxM3hmd3hub2dST2ZldldQ?=
 =?utf-8?B?bXd0ekRSeXpHM0kwSnNKbWtRS283Q3NaUEZrZ0NyREUvZHRYOE9nbGFibmRU?=
 =?utf-8?B?eTdoYzhCdzd6UFp5V05zMkYrajV1cmkzbkxCMFpaNGlXM1cwdGdRTng2Zm1z?=
 =?utf-8?B?RWhvOWsvZzhiMDU0MmZuT3NDOFdIWWozVFpJS2Qyc3Y1Q0hHSElyd1I4bUEw?=
 =?utf-8?B?MHh1ajRTaW16Mkp3SnJVeE8xOW5BcU5xZmJmcGVBZkpJdWhCMDNDc2NFQWhN?=
 =?utf-8?B?RDdqYi9YNDM4cy9ZUTJuaVB5SndUZ3Q0MkZna1FuK050bUZqeHRJZzUyeU1i?=
 =?utf-8?B?QkVQSUZoZTNRbzErOWdmNTFLWFZ4YzBYQXUyUlllL1p6SEtyTkI5Sm55alRx?=
 =?utf-8?B?QU9OeVBKakQ1cGNxUGZ0bk42T29TN1pCOTBMbm9SbGFPZjN2UHg0YldrM3Z1?=
 =?utf-8?B?TGdXcXFUNFJ3OERxRUJIYWpMUDlRMzZTWCtieERLZFVhMEJwSUZQbktudHcw?=
 =?utf-8?B?SE9Pbjh3SGU4c255eGFvLzNzbkZVL25XN3RkbDFKTFFIa21Rc1UyKzRrczdB?=
 =?utf-8?B?SFVEVFZnMDFiL0UwVDlqaFpIaitRVUdMZERKbVUrUXFHMUhZenVJdmtjNytk?=
 =?utf-8?B?dGxlTnRvU091N21kNlplMWVKRlI3MzFKQkhIQWxHZGoyTW54enlmWjBaMHRJ?=
 =?utf-8?B?cmx3VXYvZE5MZmJsdU85Q2owNnZoa0RKM3JhcXB6cTRNVzBYQ0FNSElFSXl2?=
 =?utf-8?B?TGhhWmxYOHBwcDVIcTdKQjFVcUtHQ0RkQ3Nudkk4dGNWWWxzTXRPcXdmb1hu?=
 =?utf-8?B?SE9oL0lzRmlacmdnQXR4b1JDVUFmaFB3dmlEQ0w3VnEvbVRISnBwMVlwdGFV?=
 =?utf-8?B?dTcyYVZOMm8zUW5QcFJCeSt5MnBHMTFXYmk1bWJGNVRpQSsyRjd2cC9vYXJa?=
 =?utf-8?B?L1lTS2dydjBwRGZZRVkvRlVySGxZSitaSXJ5OTFxa3BwNUp4bS9WVDVTWFhu?=
 =?utf-8?B?SE5LOXE5cFRVemc5NEsvTyt2bEJrU09SZWRhaGl3cW1pQWowMEpnUDRVNGoz?=
 =?utf-8?B?YlNablZBcWRaQVY0ck03bVhLbElGRTJOdkk3MDIvbDJ6RHo1bHN1SkpBcGZz?=
 =?utf-8?B?UGxJY00xRmthTDVRUmhvTU5xdUJGeU55RzBYemNOZ3ozS0xLN0hqZkdJRjN0?=
 =?utf-8?B?RGFDYTZxd2dwbnNzelhPM0k4Y2xhM2xiUGlJemE0OEZxSzlobG43a2tTb3dI?=
 =?utf-8?B?dTF5d1V5bTVVVEJvQmpQZml0QjVQRWRsV04vZ3ZFSjRWeW9rUlRPMUgxYWxi?=
 =?utf-8?B?eEEwdm9LdWoyaU9ubEsvbiszV2VRNUpjTzlFV2JzY2RnN2J5KzcrajcrTERK?=
 =?utf-8?B?dGpyNythUGl3N1VEQy82ZVJLaXNUbUpGdUFZYzFaZHc4OGJUWW5FQ2hva1l5?=
 =?utf-8?B?ZHE1eXg1WlU1SGJLeUVmMjZzL29OZmU0Wk93YVBpcU9xMnNwNkFnUEdrM21w?=
 =?utf-8?B?Q2RFY1Z6eGxYSlk0alJlOUMzcEZmN1h5U2VVM3l4QXNXc1VhdldLdTdLdWZw?=
 =?utf-8?B?QWVDUk8zWHRmaVl3emxpK24zWnp5YTBvN3piSFdMVllMYTQ5enkrWVdrQzFH?=
 =?utf-8?B?S1dIcEEvSitJMEt5NUhJSEtRNG9xRWRrZHU5alB2OUhZVENpSVdycTQyeFJn?=
 =?utf-8?B?cGkvWXRQM21vc0VBRFBVRzZ1WTBMeGJEd0FlY3dsTVc0dkxmdy8zazQyU1ps?=
 =?utf-8?B?dFNPU3MydlE5MnpncEhtQ3dVOFhpWVJJT2cyRU1CclUxSStLOXdoSEVuL0Q3?=
 =?utf-8?B?SXdTKzAyZEpVYXZmVi82alBMN2xSd0pZZ28rS3RueEJwN0lja3puaDRweXRZ?=
 =?utf-8?B?ajh6OVJGQVBVZEhQS0FMQXZWTEF4LzY4TFBYbDZJbzJHSGszYy9ITDhtOUVF?=
 =?utf-8?B?dU9Cc3NEOWNFdWhDNTZkaUZQUndoZ2l4cDdLeS9SVDdBcEV3MThGZ0U4NWZv?=
 =?utf-8?B?cGJMeW90UnlNVkJxQkxoNEJOWDJ3RDk3ZlJyZEE2dXRUYU9qakE1Rms5dis3?=
 =?utf-8?B?MUhRSEs3OUdXaWRDYXF2MmZ6ME5DQjhjOXJqRndscHpud1hQc2Zwb0puTGZ0?=
 =?utf-8?B?b3FVNC9McHdibWdWbkhnQk12dW10dm9QdWRkcWtXdDQ0c1pKa0k5MVRkZVgw?=
 =?utf-8?Q?NouEBd7x3ci6j7+4gg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17abb02d-20f7-4970-683f-08de78d8de52
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 03:56:37.1341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBtwYm7Uzv83btQAvpyc7GhrfdYYMpIP2W6mfgI8WS66hP95exE0/F8wNAp3o5diuNwqAAquUdd1yWPp00b6jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR21MB5190
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTG9uZyBMaSA8bG9uZ2xp
QG1pY3Jvc29mdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMiwgMjAyNiA2OjU0IFBNDQo+
IFRvOiBkZXZAZHBkay5vcmcNCj4gQ2M6IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyBMb25n
IExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT47IFdlaSBIdQ0KPiA8d2VoQG1pY3Jvc29mdC5jb20+
OyBzdGFibGVAZHBkay5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYzIDAvNl0gbmV0L25ldHZzYzog
YnVnIGZpeGVzIGFuZCBydW50aW1lIHF1ZXVlIHJlY29uZmlndXJhdGlvbg0KPiANCj4gVGhpcyBz
ZXJpZXMgZml4ZXMgc2V2ZXJhbCByZXNvdXJjZSBtYW5hZ2VtZW50IGJ1Z3MgaW4gdGhlIG5ldHZz
YyBQTUQgYW5kIGFkZHMNCj4gc3VwcG9ydCBmb3IgcnVudGltZSBxdWV1ZSBjb3VudCByZWNvbmZp
Z3VyYXRpb24uDQoNClBsZWFzZSBkaXNjYXJkIHRoaXMgc2VyaWVzLiBEaWRuJ3QgcGFzcyB0ZXN0
cy4NCg0KSSB3aWxsIHNlbmQgdjQgYWZ0ZXIgY2xlYXJpbmcgYWxsIHRlc3RzLg0KDQpMb25nDQoN
Cj4gDQo+IFBhdGNoZXMgMS01IGFyZSBidWcgZml4ZXM6DQo+ICAgMS4gU3ViY2hhbm5lbCBsZWFr
IG9uIGRldmljZSByZW1vdmFsIOKAlCBzdWJjaGFubmVscyBhbGxvY2F0ZWQgZHVyaW5nDQo+ICAg
ICAgY29uZmlndXJlIGFyZSBuZXZlciBjbG9zZWQgaW4gdW5pbml0Lg0KPiAgIDIuIERvdWJsZS1m
cmVlIG9mIHByaW1hcnkgUnggcXVldWUg4oCUIGhuX2Rldl9mcmVlX3F1ZXVlcygpIGFscmVhZHkN
Cj4gICAgICBmcmVlcyBodi0+cHJpbWFyeSwgdGhlbiB1bmluaXQgZnJlZXMgaXQgYWdhaW4uDQo+
ICAgMy4gSW5pdCBlcnJvciBwYXRoIGxlYWtzIOKAlCBodi0+cHJpbWFyeSBhbmQgaHYtPmNoYW5u
ZWxzWzBdIG5vdCBmcmVlZA0KPiAgICAgIG9uIGZhaWx1cmUgYWZ0ZXIgYWxsb2NhdGlvbi4NCj4g
ICA0LiBFdmVudCBjYWxsYmFjayBsZWFrIOKAlCBkZXZpY2UgZXZlbnQgY2FsbGJhY2sgbm90IHVu
cmVnaXN0ZXJlZCB3aGVuDQo+ICAgICAgcnhmaWx0ZXIgb3IgdmZfc3RhcnQgZmFpbHMgaW4gaG5f
ZGV2X3N0YXJ0KCkuDQo+ICAgNS4gTVRVIGNoYW5nZSBwYXRoIGxlYWtzIOKAlCBtaXNzaW5nIGNo
aW1uZXkgYml0bWFwIHRlYXJkb3duL3JlYnVpbGQsDQo+ICAgICAgcnhidWZfaW5mbyBsZWFrLCBh
bmQgVk1CdXMgY2hhbm5lbCBjbG9zZSBiZWZvcmUgZnJlZS4NCj4gDQo+IFBhdGNoIDYgYWRkcyBy
dW50aW1lIHF1ZXVlIGNvdW50IHJlY29uZmlndXJhdGlvbiB2aWEgcG9ydCBzdG9wL2NvbmZpZ3Vy
ZS9zdGFydCwNCj4gd2l0aCBmdWxsIE5WUy9STkRJUyBzZXNzaW9uIHRlYXJkb3duIGFuZCByZWlu
aXQgd2hlbiB0aGUgcXVldWUgY291bnQgY2hhbmdlcy4NCj4gDQo+IHYzOg0KPiAtIFNwbGl0IGlu
dG8gNiBwYXRjaGVzOiA1IGJ1ZyBmaXhlcyAocGF0Y2hlcyAxLTUpICsgMSBmZWF0dXJlIChwYXRj
aCA2KQ0KPiAtIE5ldyBwYXRjaCAyOiBmaXggZG91YmxlLWZyZWUgb2YgcHJpbWFyeSBSeCBxdWV1
ZSBvbiB1bmluaXQNCj4gLSBOZXcgcGF0Y2ggMzogZml4IHJlc291cmNlIGxlYWsgaW4gaW5pdCBl
cnJvciBwYXRoDQo+IC0gTmV3IHBhdGNoIDQ6IGZpeCBldmVudCBjYWxsYmFjayBsZWFrIG9uIHJ4
ZmlsdGVyL3ZmX3N0YXJ0IGZhaWx1cmUNCj4gLSBOZXcgcGF0Y2ggNTogZml4IHJlc291cmNlIGxl
YWtzIGluIE1UVSBjaGFuZ2UgcGF0aCAoY2hpbW5leSBiaXRtYXAsDQo+ICAgcnhidWZfaW5mbyBs
ZWFrLCBtaXNzaW5nIFZNQnVzIGNoYW4gY2xvc2UgYmVmb3JlIGZyZWUpDQo+IC0gUGF0Y2ggNiAo
cmVjb25maWcpOiBmaXggc3ViY2hhbl9jbGVhbnVwIHRvIGNhbGwgaG5fcm5kaXNfY29uZl9vZmZs
b2FkDQo+ICAgc28gZGV2aWNlIHJldGFpbnMgb2ZmbG9hZCBjb25maWcgb24gcGFydGlhbCBmYWls
dXJlDQo+IC0gUGF0Y2ggNiAocmVjb25maWcpOiBmaXggcmVjb3ZlcnkgcGF0aCB0byBzZXQgaHYt
PnByaW1hcnktPmNoYW4gYWZ0ZXINCj4gICByZS1vcGVuaW5nIGNoYW5uZWwsIHByZXZlbnRpbmcg
dXNlLWFmdGVyLWZyZWUgb2Ygc3RhbGUgcG9pbnRlcg0KPiAtIFBhdGNoIDYgKHJlY29uZmlnKTog
YWRkIGhuX2NoaW1faW5pdCBpbiByZWNvdmVyeSBwYXRoIHRvIHJlYnVpbGQNCj4gICBjaGltbmV5
IGJpdG1hcCBhZnRlciBzdWNjZXNzZnVsIHJlY292ZXJ5DQo+IC0gRml4IEZpeGVzIHRhZyBvbiBw
YXRjaCA1IHRvIHBvaW50IHRvIGNvcnJlY3QgTVRVIHN1cHBvcnQgY29tbWl0DQo+IA0KPiB2MjoN
Cj4gLSBTcGxpdCBzdWJjaGFubmVsIGxlYWsgZml4IGludG8gc2VwYXJhdGUgcGF0Y2ggd2l0aCBG
aXhlcyB0YWcgKHBhdGNoIDEpDQo+IC0gRml4IHJlaW5pdF9mYWlsZWQgcmVjb3Zlcnk6IHJlLW1h
cCBkZXZpY2UgYmVmb3JlIGNoYW5fb3BlbiB3aGVuIGRldmljZQ0KPiAgIGlzIHVubWFwcGVkIHRv
IHByZXZlbnQgdW5kZWZpbmVkIGJlaGF2aW9yIG9uIHVubWFwcGVkIHJpbmcgYnVmZmVycw0KPiAt
IE1vdmUgaG5fcm5kaXNfY29uZl9vZmZsb2FkKCkgdG8gYWZ0ZXIgcmVpbml0IGJsb2NrIHNvIG9m
ZmxvYWQgY29uZmlnDQo+ICAgdGFyZ2V0cyB0aGUgZmluYWwgUk5ESVMgc2Vzc2lvbiBpbnN0ZWFk
IG9mIGJlaW5nIGxvc3Qgb24gdGVhcmRvd24NCj4gLSBVc2Ugd3JpdGUgbG9jayBpbiBobl92Zl90
eC9yeF9xdWV1ZV9yZWxlYXNlKCkgdG8gcHJldmVudCByYWNlIHdpdGgNCj4gICBjb25jdXJyZW50
IGZhc3QtcGF0aCByZWFkZXJzIGhvbGRpbmcgcmVhZCBsb2NrDQo+IC0gUmVzZXQgUlNTIGluZGly
ZWN0aW9uIHRhYmxlIHRvIHF1ZXVlIDAgaW4gc3ViY2hhbl9jbGVhbnVwIGVycm9yIHBhdGgNCj4g
LSBGaXggbXVsdGktbGluZSBjb21tZW50IHN0eWxlIHRvIGZvbGxvdyBEUERLIGNvbnZlbnRpb24N
Cj4gDQo+IExvbmcgTGkgKDYpOg0KPiAgIG5ldC9uZXR2c2M6IGZpeCBzdWJjaGFubmVsIGxlYWsg
b24gZGV2aWNlIHJlbW92YWwNCj4gICBuZXQvbmV0dnNjOiBmaXggZG91YmxlLWZyZWUgb2YgcHJp
bWFyeSBSeCBxdWV1ZSBvbiB1bmluaXQNCj4gICBuZXQvbmV0dnNjOiBmaXggcmVzb3VyY2UgbGVh
ayBpbiBpbml0IGVycm9yIHBhdGgNCj4gICBuZXQvbmV0dnNjOiBmaXggZXZlbnQgY2FsbGJhY2sg
bGVhayBvbiByeGZpbHRlciBmYWlsdXJlDQo+ICAgbmV0L25ldHZzYzogZml4IHJlc291cmNlIGxl
YWtzIGluIE1UVSBjaGFuZ2UgcGF0aA0KPiAgIG5ldC9uZXR2c2M6IHN1cHBvcnQgcnVudGltZSBx
dWV1ZSBjb3VudCByZWNvbmZpZ3VyYXRpb24NCj4gDQo+ICBkcml2ZXJzL25ldC9uZXR2c2MvaG5f
ZXRoZGV2LmMgfCAyNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ICBkcml2
ZXJzL25ldC9uZXR2c2MvaG5fdmYuYyAgICAgfCAgMTYgKystDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDIzNCBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuNDMuMA0K
DQo=
