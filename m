Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047E7CCA490
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 10:35:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FCE54064A;
	Sun, 18 Oct 2026 12:35:04 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
 by mails.dpdk.org (Postfix) with ESMTP id 0388740276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 12:35:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1uGDtBvIjITV37ryqjAUDpq9thAScRQU0OsP+Pop5wEepNkAUgxonbQ2tGxEZYOllTTC94m8p3VqiW0rUnMwnwDUSRsFVprfWWeXc5mySwsp5H8NkHCgsGeMmPByCBNJ87WA+Si8Vss2YyJem2EY7zPA3Oyvl1bI7+TeOHHTdhv5VqP/i7RcEz60QTRh7p2Xr006gMXUxn+T763oLuluiRTPcUe0pdslir98b81gCh3OOG2VE7jX4jRwwK5RjsgkDSOYHWvdo3F84alp7OPBjZY1Lu9lVAkoo7ArNZ1FlwM+c54npZAbXohZ0z8zEcTK0TSyiyGAhbAxWIFggU0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRD/F/6+K198TpBDvGqkK+TH7FHMymzvhaVUb09ZLbs=;
 b=bDR8iC4hbvajKnSCOUX3joTWoxnGVbSd5voMKKP8oVeBGmahy8lT07ysf6ouLbhYQ5YVRSlfyjgODM9pxCEnf3ljgeQcxKuCFq3Pr9RLvW4yzNYl/B9KO6cbZ+HYBat55FWCARmrildbf4Q1LIokBKJPtY94p3ApzXNtRTUim7KQ0WmUEdmYuvb0bjQj9F4nNWLPWrjCXLP6rs6f1pau127ufgTZZ+aKed3KfYUO8J4joZMGO6QbjXr1pDHCayxBNfMORxjF8VGU000uo2aHVDhOuEcZxD7LxAirVr9Kpsr5TIOAfLYVfmAnWY4g/xYdZ74MIY5nrxwhCbxxUv4Ttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRD/F/6+K198TpBDvGqkK+TH7FHMymzvhaVUb09ZLbs=;
 b=QnjpVPgjrUFWe74Y/8A+dNRUC113ZK8wvtMEyS+TOYq5Epr5+HWewwjVwjhOd8PfD/Ak0cNRXYCNK3ziPEuDtco6jjzDupN9A5u3mq+tECOCK3Owqa876u43RvVIFCxCVsKM1U+3Y65/7QSAzyW0K+E6L50mULDEbml09kE+MShdEeP1ihzQrofPbb7ik7mK2RDN3kv/1//wYii+ZG1Iq1OP8eFJl1IXvzvr1AJ1KYwgJltJjmEHWny6bzmKr1pdTce1YtmGbIiS3gCiMogV0B6hFDTDr+dHIlxGZf0j9kql/4C3AQqqBCrR4AY4bh8dxsduzk5+ufLWB0Kkj9e2pg==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by BR0PR04MB591767.eurprd04.prod.outlook.com
 (2603:10a6:2c8:33::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 10:34:59 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0522.013; Sun, 18 Oct 2026
 10:34:59 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 Prashant Gupta <prashant.gupta_3@nxp.com>
Subject: RE: [PATCH 00/16] Device unplug and bus cleanup refactoring for NXP
Thread-Topic: [PATCH 00/16] Device unplug and bus cleanup refactoring for NXP
Thread-Index: AQHdXAMSNSOrYyw/Ckauj6Ac8xGWwrcDIIOw
Date: Sun, 18 Oct 2026 10:34:59 +0000
Message-ID: <GV1PR04MB10750AE0102EC1FDDC8E2E0C389992@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
In-Reply-To: <20261014174001.1830726-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: prashant.gupta_3@nxp.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-18T10:34:34.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|BR0PR04MB591767:EE_
x-ms-office365-filtering-correlation-id: 3051e0ab-2fe5-42ce-f0a0-08df2d037595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|23010399003|366016|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: AcRF4va07pRZvduWoTWoeJbkJqmQ2GRmHMJq3cesVAgUcwCq9sACzKCsJNRb1iBzarW4g+9jOxex6MOMW5QlGLfFlMIKZzhBOKb9HNV30x8IcIzFbwIwfcbiBQgpPYeUgvXvSrJoZVNRJCmD106p+JnhoHYlj/dKZ8UzspGkH72Ry/5P1UyLhXtIwVTVr3zK/+MUZ4TXAv9BL1Roeimn/GeSHuLKYXYS4YohrkHWBKnHtIrpo8HU0fzdO9l/1OKPdFfOwacUHdaq/T7fHjWJwHwh7gqFWyoyhpIHizrpWbc6bpgbvCL15CR0iwAXLC1jrm+Yo/28S1LJ3+OEBkrd9M+bTJJ+Yp1lEaQ9T5kQ2EkgTzj/4ahfXXtjetRneT3KmASLL79xw2l1AZMxJVuQRSjRqARFo2ygYlX6mT84I6Xzuoa0kXd5BfX4ewR081J2qV7E26yjbckpTXpP31ZwrRj/YcTycCiCdtQ2cpEnnYfczhrFFtCj1VA3VnR0E7CJAP0Fw2GgSckKht+jhwDzx/c3v8R0MtHbryuQqYpo4FML1uAISLGnKkKO8eMUMA1L7eR7zhu6MUoBLHgUwhbKQgMWbj5CBw7lFqXYUYWMEDBK/Hqi6oQnWxWdqqjmsm9G7BNPRBV4hWY+ukL11jDrydBt+/dfhD/96qiHWaU5NeCzKIBYTzyEF2PQsIWXfV6z+aEtlIptqlx1dyXUScGDQ2kn5Yn78RlhV/OyUIl2QoI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(23010399003)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djVtb3dPYVNkUmp6OHpJNVpRNThlUXdGWjZlTjJyTUdwRlNzT0dZTzFEQmN3?=
 =?utf-8?B?aTZJOWRTUXpaQ1oyV1h3QkF5RER2b0lMQUQ4VlZjeTkwdFNyMFFGVWhWYVlY?=
 =?utf-8?B?eFNjc0tLUnF3WmpEcG1FWG1FQmh3MUZMVXNsUGNhNFlTRlRyRDhGNTJiekJo?=
 =?utf-8?B?eE9yNjhpdE9JWWUvTzdVQ21kRTl2c053MEdIRml0VWVSelFJa2dJL0FaL3Fu?=
 =?utf-8?B?bEhVZXZsdGtheXNvWmdzZHV6MjNsYmszVmk4ejY5dFVqU2VmUENBenFRN0oz?=
 =?utf-8?B?VFcrUWt5b0hHL3FQQXlKUFM3NWRkZzlEQ0pvUUVRMWNCNVJOckg4WXB0ZEtm?=
 =?utf-8?B?OHVPNURhT0QzSTE3c1A0TlVBNmpZOGVEdFlWZE5zai9YMFdqd0IyT0pNK3pE?=
 =?utf-8?B?c0NoOGgvNWZNdmM2QWgzUUhvam9TWVozTGl4V2d0QmdHYXFaV0xwUlUwenVH?=
 =?utf-8?B?OFdTeTZldUJUcm5xSzFkWmE2VnpuL3NJWlJRMXg3SmF6dktvT2lCc0pYQjlj?=
 =?utf-8?B?WkZqSGVQQUF0SE50emlJNk1aam81cEVZUThlYWsrdHBNZ25JeHIwcGhUVUhh?=
 =?utf-8?B?ZysvZ2pBb3BGeENHN3dhQXJoNG53VTE1VFBVYlNVZk5iZFVHVldsTWpMOTlz?=
 =?utf-8?B?cGZXT2lINWNPcmx3WWNPbEdzQ3Y0Z2RHbWphMjdScmFuS2tPaFF6SEdaa0VW?=
 =?utf-8?B?b0RlbHZjUG1pYldlT1llczNFN0piQTdLWEE1OHlBdjluSkVZWVZNOW9YSUE1?=
 =?utf-8?B?di9wVEtxSVZSRzRlNWQ2ZXh3S3hzTzJTT0d2SHNueG10NUtKQk9ObStzVkFy?=
 =?utf-8?B?Sm11bTJzakQ3eDFqYmNEVkxZTGEvZ0ZhTzM5WDk0cUxUZWQ0VFpWcytocHJl?=
 =?utf-8?B?TjVIV1RVZTJsZjE0SGlwcFRhVVhSRHJwa0lkTWpSWXZhOUdQekxXa1k0aGxP?=
 =?utf-8?B?N0pxRU5LcjFDR3lLM3RjUjRmc1lUM2h3QVpCSlB3S3l3ZldUQ25tdWJWa0Vl?=
 =?utf-8?B?OGFpcnRCcHFsYmRtMEN3WlNmN3dvYW8wMDlDeHJzbTFsMlFnOUN6d3RwS29t?=
 =?utf-8?B?cW10VjIyRE9MNWJIRlF4SE02UGRjQnc4ZFAxQXBzS21jd2JrSS9QVys4TFBB?=
 =?utf-8?B?Z2g3N0tVOVR3S0NndGd2RU1oZzZyeTcwUERUTHF2M3phNHlNN0hWekZ3cjg5?=
 =?utf-8?B?bkVYaUNyeEpaRjlzV1pYR1ZyaWZZeng4YUxtWWN5OXkyWGF1Q2RTZGoyUFJT?=
 =?utf-8?B?WFBWWHBiU3MxeGJ3QXNtL25aY0p1VHdkSTFUV0JjR1k5OE9KZXdJdExFYzk5?=
 =?utf-8?B?cEtsL2xTcHExUnZzS3FsdXlwZVk1L2lnWDZtWnB5YUg0TklZQXRGNmhMcE5J?=
 =?utf-8?B?RkFueE9va2h0K3dMVjRRVThwWU1NV3psRWJISjlpckZkbkk3c3Y1SmVlZWFX?=
 =?utf-8?B?UjhtTjVPVG0vazd6RWZjaWp3OHU5Tkl2Q3dVWi9JMWgwc3pkRmIxQXlBWVJ3?=
 =?utf-8?B?ak5uUS9BRnNucjBtdUlhT3dQczlUUng5NUhlbWtjcHVuK3lhQStySFZVVVVi?=
 =?utf-8?B?Y1oydnJPQWZuNkIzOERwMVVEajlKUE5JOC8xVTVabWxUUzlxbkdWZ3dWTERJ?=
 =?utf-8?B?dTh6azFOWGkvTG9QcDRzZXUyOXBxSDRhb2RFNS8yd2dhRWV6MnQ2bmNjaitv?=
 =?utf-8?B?d0dtV3diVzl6NFlFRlZBZTRnWmdXM1JzUnBSM0g5UDh5TWNna2YwVUJVamRv?=
 =?utf-8?B?ZTg0bndBQWtIUTVvZjM1c1RZeWVvdCthL05uTVRhc1dKVkZpS2FTRkl6cHN3?=
 =?utf-8?B?aEhDVUJIVGZCR24xdHIzOTdYSGNIRkFVU1FRZ29kM2ZydG5yN08vQi8rQnk0?=
 =?utf-8?B?elZQMkVFNUNOenl4TVBSdmRzeGI0SG1pMEVkY3dCVUZWK09wNFdRWm0wQnRt?=
 =?utf-8?B?Z3ZUODZBckNyZC8yQjRDaXRyRGdQWVhpcDk1SE9CMk45MWdNKzlySWk4MHRH?=
 =?utf-8?B?RmtyL0tMWUtwcXB0MTBrcHRrdHNPYVI5azcvNngxdDZKVER0cTM1NUFUYitp?=
 =?utf-8?B?Rm9VK1dkK0R4OGtHSDRoYndkV0hpd3lnbDhPRGNkWUhUTWN3VUtYOE5IZkR6?=
 =?utf-8?B?MC80M1pYTFFDWks2ZS9IVXRZRjdpazM3TnVJb1cwUFdDTUk0ZDRHb3h2RkVm?=
 =?utf-8?B?ZXFYQWFEZTdqSHZaNWZkcVAvYUgzSC8vNGFKenJNL2FUc1dHMm1KV1NJbGpu?=
 =?utf-8?B?VzlNdzM4OXBlQTUzbzd5VzFrUkdIZy9zK0ZkK3B3aUFhS3ZtMk5VMGlxK1Jt?=
 =?utf-8?B?MVVRUmgraytZZlh0YkRQMHJ3d2JTdVBLUzVJaFdjdmhaRFU3NFlrdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3051e0ab-2fe5-42ce-f0a0-08df2d037595
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2026 10:34:59.0478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aO4A6L5aFvDYagUG/J/85D93G4vzu0eeqZlUvXxP4qC3naFYtHYm+KCTaWdptBNaGZ3mMoDtKwtx/Rg1fSvexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB591767
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

SGkgQFByYXNoYW50IEd1cHRhDQoNCiAgICAgICAgUGxlYXNlIHNoYXJlIHlvdXIgdGVzdCByZXN1
bHRzDQoNClJlZ2FyZHMNCkhlbWFudA0KDQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhdmlkIE1hcmNoYW5kIDxkYXZpZC5tYXJjaGFuZEBy
ZWRoYXQuY29tPg0KPiBTZW50OiAxNCBPY3RvYmVyIDIwMjYgMjM6MTANCj4gVG86IEhlbWFudCBB
Z3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPjsgZGV2QGRwZGsub3JnDQo+IFN1YmplY3Q6
IFtQQVRDSCAwMC8xNl0gRGV2aWNlIHVucGx1ZyBhbmQgYnVzIGNsZWFudXAgcmVmYWN0b3Jpbmcg
Zm9yIE5YUA0KPiBJbXBvcnRhbmNlOiBIaWdoDQo+DQo+IEhlbGxvIEhlbWFudCwNCj4NCj4gVGhp
cyBpcyBhIGZvbGxvd3VwIHRvIHRoZSByZWZhY3RvcmluZyBzdGFydGVkIGluIDI2LjA3Lg0KPg0K
PiBJIHRvb2sgc29tZSB0aW1lIHdpdGggbXkgYmVzdCBBSSBmcmllbmQgdG8gY2xlYW51cCBEUEFB
IGFuZCBGU0xNQyBidXMNCj4gZHJpdmVycy4NCj4NCj4gTGlrZSB0aGUgbGFzdCB0aW1lLCBvbmx5
IGNvbXBpbGF0aW9uIGhhcyBiZWVuIGNoZWNrZWQuDQo+IEkgaGF2ZSBubyBoYXJkd2FyZSB0byB0
ZXN0IHJ1bnRpbWUuDQo+DQo+IE9uZSB0aGluZyB0aGF0IGNvdWxkIGJlIGJyb2tlbiBpcyBlaXRo
ZXIgdGhlIG9yZGVyIG9mIGRldmljZXMgaW5pdGlhbGlzYXRpb24sIG9yDQo+IGJ1Z3MgaW4gdGhl
IGRldmljZSBmaWx0ZXJpbmcgdGhhdCBJIHRyaWVkIHRvIHNpbXBsaWZ5Lg0KPg0KPiBJIHdlbnQg
d2l0aCB0aGUgYXBwcm9hY2ggb2Ygc3BsaXR0aW5nIHRoZSBkZXZpY2UgbGlzdCBiZXR3ZWVuIGlu
dGVybmFsIGJ1cw0KPiBvYmplY3QgKHRoYXQgSSBjYWxsZWQgImNvbnRyb2wiIGRldmljZXMsIG1h
eWJlIGEgYmV0dGVyIG5hbWUgY2FuIGJlIGZvdW5kKSwgYW5kDQo+IG5vcm1hbCBidXMgZGV2aWNl
IG9iamVjdCBmb3Igd2hpY2ggRFBESyBoYXMgYSBkcml2ZXIuDQo+DQo+IEkgdGhpbmsgaXQgaXMg
d29ydGggdGVzdGluZyBhbmQgZml4aW5nLCBhcyBpdCB3aWxsIG1ha2UgdGhlIHR3byBOWFAgYnVz
IGRyaXZlcnMNCj4gc2ltaWxhciB0byBvdGhlciBidXMgZHJpdmVycyAoYnV0IGtlZXAgdGhlIHNw
ZWNpYWwgSU8gZGV2aWNlcyBoYW5kbGluZyBpbnRlcm5hbCB0bw0KPiB0aGUgRlNMTUMgYnVzIGZv
ciBleGFtcGxlKS4NCj4NCj4NCj4gLS0NCj4gRGF2aWQgTWFyY2hhbmQNCj4NCj4gQ2hhbmdlcyBz
aW5jZSBSRkMgdjI6DQo+IC0gcmViYXNlZCwNCj4gLSBmaXhlZCBpbnRlcnJ1cHQgY2xvc2luZywN
Cj4NCj4gQ2hhbmdlcyBzaW5jZSBSRkMgdjE6DQo+IC0gZml4ZWQgRkQgbGVhayBpbiBidXMvZHBh
YSBwcmUgZXhpc3RpbmcgY29kZSwNCj4gLSBmaXhlZCBkZXZpY2UgbmFtZSBsZWFrIGluIGJ1cy9m
c2xtYyBwcmUgZXhpc3RpbmcgY29kZSwNCj4gLSBmaXhlZCBvdGhlciBsZWFrcyBmb3VuZCBieSBB
SSByZXZpZXcsDQo+IC0gc3BsaXQgRFBBQTIgZGV2aWNlcyBpbiB0d28gbGlzdDoNCj4gICAtIG9u
ZSBsaXN0IGluIHRoZSBidXMgb2JqZWN0IGZvciBkZXZpY2VzIGZvciB3aGljaCBhIGRyaXZlciBl
eGlzdHMsDQo+ICAgLSBvbmUgbGlzdCBsb2NhbCB0byB0aGUgZnNsbWMgYnVzIGNvZGUgZm9yIGlu
dGVybmFsIHJlc291cmNlcyB0aGF0DQo+ICAgICBhcmUgaW5pdGlhbGlzZWQgb3V0IG9mIHRoZSBF
QUwgLyBidXMgZnJhbWV3b3JrLA0KPg0KPiBEYXZpZCBNYXJjaGFuZCAoMTYpOg0KPiAgIGRyaXZl
cnMvYnVzOiBjbGVhbnVwIGRldmljZSBmcmVlaW5nIGluIE5YUCBidXMgc2Nhbg0KPiAgIGRyaXZl
cnMvYnVzOiBmaXggRkQgbGVhayBkdXJpbmcgc2NhbiBpbiBOWFAgZHJpdmVycw0KPiAgIGJ1cy9k
cGFhOiBhbGxvY2F0ZSBpbnRlcnJ1cHQgZHVyaW5nIHByb2JpbmcNCj4gICBidXMvZHBhYTogc3Vw
cG9ydCB1bnBsdWcgYW5kIHVzZSBnZW5lcmljIGNsZWFudXANCj4gICBidXMvZnNsbWM6IGZpeCBk
ZXZpY2UgbmFtZSBsZWFrDQo+ICAgYnVzL2ZzbG1jOiBmaXggbWVtb3J5IGxlYWtzIGluIHNjYW4N
Cj4gICBidXMvZnNsbWM6IGZpeCBwZXIgdHlwZSBkZXZpY2UgY291bnQNCj4gICBidXMvZnNsbWM6
IGZpeCBzb21lIFZGSU8gZGV2aWNlIEZEIGFuZCBtZW1vcnkgbGVha3MNCj4gICBidXMvZnNsbWM6
IGZpeCBpbnRlcnJ1cHQgbGVhayBpbiBEUElPIGNsZWFudXANCj4gICBidXMvZnNsbWM6IHNpbXBs
aWZ5IGRldmljZSBwYXJzaW5nIGluIHNjYW4NCj4gICBidXMvZnNsbWM6IHJlbGVhc2UgcmVzb3Vy
Y2VzIG9uIHByb2JlIGZhaWx1cmUNCj4gICBidXMvZnNsbWM6IHJlZmFjdG9yIGRldmljZSBmaWx0
ZXJpbmcgZm9yIG11bHRpcHJvY2Vzcw0KPiAgIGJ1cy9mc2xtYzogbW92ZSB1bnBsdWcgZm9yIHNv
bWUgZGV2aWNlIG91dCBvZiBWRklPDQo+ICAgYnVzL2ZzbG1jOiBjYWxsIFZGSU8gc2V0dXAgZm9y
IHNvbWUgZGV2aWNlIGZyb20gYnVzIGxheWVyDQo+ICAgYnVzL2ZzbG1jOiBhbGxvY2F0ZSBpbnRl
cnJ1cHQgZHVyaW5nIHByb2JpbmcNCj4gICBidXMvZnNsbWM6IHVzZSBnZW5lcmljIGNsZWFudXAN
Cj4NCj4gIGRvYy9ndWlkZXMvcmVsX25vdGVzL3JlbGVhc2VfMjZfMTEucnN0ICAgfCAgIDQgKw0K
PiAgZHJpdmVycy9idXMvZHBhYS9kcGFhX2J1cy5jICAgICAgICAgICAgICB8IDE0OSArKysrKy0t
LS0NCj4gIGRyaXZlcnMvYnVzL2ZzbG1jL2J1c19mc2xtY19kcml2ZXIuaCAgICAgfCAgIDQgKy0N
Cj4gIGRyaXZlcnMvYnVzL2ZzbG1jL2ZzbG1jX2J1cy5jICAgICAgICAgICAgfCA0MDQgKysrKysr
KysrKysrKysrKy0tLS0tLQ0KPiAgZHJpdmVycy9idXMvZnNsbWMvZnNsbWNfdmZpby5jICAgICAg
ICAgICB8IDQwNyArKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9idXMvZnNsbWMv
ZnNsbWNfdmZpby5oICAgICAgICAgICB8ICAgNiArDQo+ICBkcml2ZXJzL2J1cy9mc2xtYy9wb3J0
YWwvZHBhYTJfaHdfZHBpby5jIHwgICAxICsNCj4gIGRyaXZlcnMvYnVzL2ZzbG1jL3ByaXZhdGUu
aCAgICAgICAgICAgICAgfCAgIDYgKw0KPiAgOCBmaWxlcyBjaGFuZ2VkLCA1OTIgaW5zZXJ0aW9u
cygrKSwgMzg5IGRlbGV0aW9ucygtKQ0KPg0KPiAtLQ0KPiAyLjU0LjANCg0K
