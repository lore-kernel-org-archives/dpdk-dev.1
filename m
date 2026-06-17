Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAF3CD98EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 09:16:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 047D540289;
	Wed, 17 Jun 2026 11:16:14 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
 by mails.dpdk.org (Postfix) with ESMTP id C3D534027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 11:16:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHu8o9AierOlHmxE4uzbM/cgctm4WiY4xlf07JI74N6OZDeeLpRBuF/cpoKbJ3ytjAwwoNZKCwAzHWVYpEznGXsPqboW7cf3n+1kY15sk4SkhRa0YdLrU843OZBTwB/tb6ROwSNXDNCoM+5p28Ym+C2lBkd8ht0rn+PCpZOnPC5IEDtRk+UpJ4L+c3k0M4hUvmwc+qjhu3eUEwfROCulmPerxK/T/nx6Mt9RsE9S7lQmqrrSxhztYEhuw+DKrVWcGgWpRtDATcNG0kVegVrmL2BN2RcNtsjZq3DBoqTYDpCZ1BI/y0jBZKofcDbdAs14M4GmQGY5bBKiSHzLkLP0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrIV2LQkYum25Ry8a4FeDkAGWsD9d5F3DwxvVLeIOW0=;
 b=Nfi6qNTNNkqBRvRyKYHEiQAaahA27t8MRKG6wGD51uIDhyDn8v6N5iM4+/CiDR95meNTMEqj+BULc/7QMfBZ8ylfQiH/GNNKiu3uEWfzj616A78TFWWFRgZwW7G0YjwpjwG1LdGdp94emmPYo0+jliQWPjBWf2hRInf593MLRbeUNJfZYaHqbTpDMX58EswTxRR4/4gZ5ppbc31JZC28FRYB9h5iHYE4EdcKi3Qis/tWkR6oM+pleImxHIEVtDf/91X7U2aVBfSaXM4A1cUk0jiV3Xg9oDNbosCFJ4mVl8I+YuTrN18gNPRyWCKf5X1ocvgi4Yk+hPW9t7YYafI9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrIV2LQkYum25Ry8a4FeDkAGWsD9d5F3DwxvVLeIOW0=;
 b=k3/uZhiVODibRnEP54mY264k1jcBWjivnS6WY+MqxCj5JWJ78kZv2RnVuCJlwtV+0XldKZa3ZRPfW0Vj5VtNocdpn3Y5pdD4kKt/SMYujzNChLWjZKZZ5fJjo5S0fmqtMHH5D+oc+dFdtTa1a4fFSKwuKEJLmDcApgR9HpU5H078Fb6vlwTb/cq8ik71gEgKn4lzzDEnssc+BsgVJf2feW2y01Ja4Y39fYwxLkZgcgbo9B4HXjdbHIg2Ng+qlqImpPPRnKUudg1k6Ha0exekKaU6LQhHOR6WKbG6Gk27L3GZ6TitmPijumOQOP7eR2gbac89LML2+QYcKVVt66x8mQ==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DU2PR04MB8885.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 09:16:11 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 09:16:11 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 00/13] Bus cleanup infrastructure and fixes
Thread-Topic: [EXTERNAL] [PATCH 00/13] Bus cleanup infrastructure and fixes
Thread-Index: AQHc+Ycnx7I50bbSlEufJa+An+FilLZAA0iAgABOloCAAHVmAIAADlAAgAGrEKA=
Date: Wed, 17 Jun 2026 09:16:10 +0000
Message-ID: <GV1PR04MB10750ECC2CA25C4BA7B78309389E42@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <SA1PR21MB6683D20ADEE7D476EBE59CC8CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
 <SA1PR21MB6683AEB004DF96D48ACDAD51CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
 <CAJFAV8wL8K=gD1f7CAAuY8_7tz4CdR_hPn4j4xP3Nb2sfnrjqA@mail.gmail.com>
 <CAJFAV8z9XmpRfbidbqmrpFtQW_+04V5Qx7GWAP1p9-hY+xu_yw@mail.gmail.com>
In-Reply-To: <CAJFAV8z9XmpRfbidbqmrpFtQW_+04V5Qx7GWAP1p9-hY+xu_yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|DU2PR04MB8885:EE_
x-ms-office365-filtering-correlation-id: 0c789e86-aed4-4356-0783-08decc511299
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|19092799006|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: e35H/1R7JwyoxRXtoaNT2NWafuPkUMgTvzPz02T5hwDCPriwdVoNCbtQLool0eXkh8ilAwh5zLIvFgzIzJ38qe/cVZvZOTo1H4G7OioHIRzYxZr3oW50xzY9ZZq7t8mKzdx/befOj2BPlcLlUWBxlV8iPdFelcpNOKpexRQRqS3pwxvg+eNdtscmEAjadPtfhYMlBbhHCuxUKrffOMNgloYsXsU0KcjLCR4sKIFYQ5GBZyWQ42T3rKS6FYL3flIsidFo1/QlGE4dGbnuk0PE6qqRm2I2tOwGnMZk9w4+BfsRlI+sNBjrfOJOxgIxH/EXoveMCcAllrnnIuo6K/9o4lK+KNWUA8CcENdX17CGse4u8GBlqIYIQgqgLkWS4ASWlUgJ2cdbZarS3uTtnJf5R45oEGjiuAJSNUJwOFZ5TUN9FCZDIpGvJGng7j1KwHYT+x6QIPbm43kWoonwPIrcVbPtucNfBabfk0VF54XDMFkSR94Vy7SiYTVyPX+clGjNQdMxu821LRPi/xGOPU65jhZXKi2AjMzUq7GEr2AMK2qIZpFThktMUsfBPZ5Tb8cauUGx+7ah1riu0WXYHCJkvt0amIhOO2HxKqoteGzxUlNlqu6U1pca2vII25ExrLBO1jz0sNT+jiSpjDt8EZSYE+EwPNRwI2c6Ka0O+8XKrs5BoMldwQTUkDbBsyibHMkxPgemUBMSNSwUt2eqGoRBZfEo3lDtvyoZ/FpYK/c9kTnFCl04z/LC0CMnPfxV9H55
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGt5eUdJdGowb0NiMm0xZU1KYVdNQ2k4U2dvUW4yK0hPYzl4cnZBenFoT2NM?=
 =?utf-8?B?djMvWFN0YlFwem9QMkpJeitvWWY1TjNwbnBXNU5UendRaDBDZFN3bnZRQnVk?=
 =?utf-8?B?dkRaWXRJd3hPdnpVeEYrK2FIaTJxNzdOVENnT2dQM0xoTlArS2I0U2lBYnJW?=
 =?utf-8?B?LzB1TFR3Rng4UWVvV2s4Q0oydnB4cW43bDlFVW5HYjFFb09XRGw1K2FKQnNG?=
 =?utf-8?B?Y2lJOGZhSDgvaFpYRTRVM2hYRmZ5bVp6T3NYQW1oUWtmQWFnOTFPb3FDL0U1?=
 =?utf-8?B?TThIazFseEhjeHJrZzJYNTVGS3czY0svcHU3L2p5a2NIUW40Y0hKZzQ0dHR4?=
 =?utf-8?B?Y2dpWlg4bm1jNXhKV01YS3J1b2NYZjMvT2E5ZFF4MmROWUJjOENvMHN3enBw?=
 =?utf-8?B?d1prYUVCTVQvQ1k4NzBzTS9YQlVMUURVNjE2MUhjaFZ0OG11RFVGeEpjdWEv?=
 =?utf-8?B?T2ovSmI1elhEaDRrSmRYOHNvYVk4VmZCdWNZT2M5TWdSZGtCekVjWlZQYkdt?=
 =?utf-8?B?ZUJSb1RZNk5zMG9NaGE5dkp0NWU0TW5oVDZCcFBnYVdCTFJMWFYrbUhINm0z?=
 =?utf-8?B?aytqOTRHc3k3OGN0K0FqaVVTZFlwNGlrVnV2cXlZSW9UMlh0eDkwSWw4STUx?=
 =?utf-8?B?WnhVNDZwOGE5cXNJLzZVbU5ESnloRUg2R1RJMTM1ZUdSc3FUZDdxSVNmNlh2?=
 =?utf-8?B?cHc3SHZPd09PaHVzbVA2TlVGdWNUMkhCTUtsSXlwQnR0Ymhqc3dRdVV3NXov?=
 =?utf-8?B?RnF4cUZYaUlLZzJwRGhZWDVKTVVzbjA4cWIwdVVRNXlLL2ZlMVZZRVBXRncy?=
 =?utf-8?B?RWhKMVlCUHFFRTcvTEhYR2IvZml2KzR6VG1IWUtWQmR5a29WTFJsdGZPSElv?=
 =?utf-8?B?Z2dGT3RPQVNBN2VrdWdhZ1UxOXEvUVBSaDZjQkNXcVJSSGsvbk9ZWmNLK3RY?=
 =?utf-8?B?Y1diYzNHaE8xR2VNQUlvalZOUldyTWZ5MWtvN0k1UmZ1NitzcVJ5Z1hOSis3?=
 =?utf-8?B?am0zbmZSWDlLQzZnVXA3ZGdFbUxKZWtYVW1lT0FrSVNlZTBzTUFaSklQQWJK?=
 =?utf-8?B?WmNtaUJ2eFFkajhRYXpDbFN1VTVDc0hMQ2ZtMGpVbmtjT205aWxKTjQwTUJE?=
 =?utf-8?B?M2dCT1p1ZXdPRE01WXRJK3FQV29FTFVrR1lyQ3AzOGdGWjJnOW90cDBmTGFz?=
 =?utf-8?B?ZUhYT3RxU01DdkxlUFVNZ3VjekJwdFZyYWVPcEN1RHNZcHhHdUorYUV4UCs1?=
 =?utf-8?B?bFZpdWdwSXZWTjdCd2VlOTdTcGV6ajJVeGtoY3M1SEYrdUJOcVl2bG1LTlJP?=
 =?utf-8?B?QmJsYXVkYjhRODQvZVYxcFJCNThJM0h6cG5MNElvTEd5MUhuZGp0NWtCdGpJ?=
 =?utf-8?B?N1h5bFY1RGMrcFY1Ykxkc3VvL3NWTUtPTE9xdFhkUlk0NW5QQVNLcWJoSGlY?=
 =?utf-8?B?d2lsc2tTdnU4TWtLQ2xZRmdUU2FaNnVPdHlKMGZpKytkWTQ2SlZlbGo3MmVH?=
 =?utf-8?B?SFprbjVUN1U0RzJiWjNQM3c0ZElWNjRPbDRMU1hDVk5aT0JsdWU3Ull1a1k0?=
 =?utf-8?B?VU1HWGJPOWE3UXQ4QzdpV3VXRlcvMlpXdy9nK3lSNmo2SzZRb1c1U2oxSlUz?=
 =?utf-8?B?UVhib1RDeUh3d0NxRWM1cGttSGtpYmVVWHJiTGJTeVZTM004Rmk5S1ZGZnhG?=
 =?utf-8?B?Q3dxVTdqVTU2dVptaHd1a2RBcU1NZmt1cFkvd2szazN6ZStlYWpnVFM1eW9R?=
 =?utf-8?B?KzlTOXJtaTkyRUFNYWxBeDRHTGNadmw0b0NmSE5yS2VWSFA1WWdGQ3dGSjJl?=
 =?utf-8?B?WEo2bTg2bUU2UDN0Um9zUzRpWXVWdGNsc2tGdUE1YVhrakRLYnZxUHc5eWFk?=
 =?utf-8?B?N0tWVXdDN1RNaFVmUU5NMkRKMVFvQU54TmhHMDEwL3FBWDBJaWl1QXNxY25T?=
 =?utf-8?B?U0pESjdrbVZFRU9GYU44d1Y2YVp5akJOWW9DQVBwaCsxdFI2Y2ZVSmU4TG5r?=
 =?utf-8?B?THVhY1FGdEJoSFgwSjhZdzNCd2pDcHJvaDRYUG5oblU4YWhpcDBEL0hXZ2p4?=
 =?utf-8?B?ZElQTktNUUxvTHBTYllvNngzQmV0eTIwdlhacGJ1SW91OHN1R0ZheUVhTis0?=
 =?utf-8?B?UnhSWkN6cjd1aGtiR3JCczlKWlVBMjFtVC9Cb3hwR2ErMjhZWm9yaHlma0dW?=
 =?utf-8?B?U2RsVUlVek4yNlFJVTJ4OGtrZ3hteTcxaXNreEZzZmg4M3BvMStnSXBWOVVI?=
 =?utf-8?B?RDRoMnRiVDBCd2VTa3I4aTVtbXdBT2tEWmhFQjE1YStzZFh6cUlrb1NuL3BU?=
 =?utf-8?B?bzRkUnhPRVhWUXcyNkxXZC96SEx0VXZJRUxhYSszUzR3dGtBZ2Y5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c789e86-aed4-4356-0783-08decc511299
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 09:16:10.9040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k311XwpeSjnhLwo/d2cTpnEeb8bM1lbUv1z2zmoMfqK+BSkVRDclu+LH5Jun17w8SbUdZOrm5OgA2ZRpy2B3tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8885
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhdmlkIE1hcmNoYW5kIDxk
YXZpZC5tYXJjaGFuZEByZWRoYXQuY29tPg0KPiBTZW50OiAxNiBKdW5lIDIwMjYgMTM6MTcNCj4g
VG86IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPg0KPiBDYzogZGV2QGRw
ZGsub3JnOyB0aG9tYXNAbW9uamFsb24ubmV0OyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsN
Cj4gYnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb207IGZlbmdjaGVuZ3dlbkBodWF3ZWkuY29tOyBM
b25nIExpDQo+IDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtFWFRFUk5B
TF0gW1BBVENIIDAwLzEzXSBCdXMgY2xlYW51cCBpbmZyYXN0cnVjdHVyZSBhbmQgZml4ZXMNCj4g
SW1wb3J0YW5jZTogSGlnaA0KPiANCj4gT24gVHVlLCAxNiBKdW4gMjAyNiBhdCAwODo1NSwgRGF2
aWQgTWFyY2hhbmQNCj4gPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gT24gVHVlLCAxNiBKdW4gMjAyNiBhdCAwMTo1NSwgTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29m
dC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIHNlcmllcyByZWZh
Y3RvcnMgdGhlIGJ1cyBjbGVhbnVwIGluZnJhc3RydWN0dXJlIHRvIHJlZHVjZQ0KPiA+ID4gPiA+
IGNvZGUgZHVwbGljYXRpb24gYW5kIGZpeCByZXNvdXJjZSBsZWFrcyBpbiBzZXZlcmFsIGJ1cyBk
cml2ZXJzLg0KPiA+ID4gPiA+IEl0IHNob3VsZCBhZGRyZXNzIHRoZSBsZWFrIFRob21hcyBwb2lu
dGVkIGF0Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIGZpcnN0IHBhcnQgb2YgdGhlIHNlcmll
cyAocGF0Y2hlcyAxLTgpIGFkZHJlc3NlcyBzZXZlcmFsDQo+ID4gPiA+ID4gYnVncyBhbmQNCj4g
PiA+ID4gPiBpbmNvbnNpc3RlbmNpZXM6DQo+ID4gPiA+ID4gLSBEb2N1bWVudGF0aW9uIGFuZCBs
b2cgbWVzc2FnZSBpbmNvbnNpc3RlbmNpZXMgZnJvbSBlYXJsaWVyIGJ1cw0KPiA+ID4gPiA+ICAg
cmVmYWN0b3JpbmcNCj4gPiA+ID4gPiAtIERldmljZSBsaXN0IG1hbmFnZW1lbnQgaXNzdWVzIGlu
IGRtYS9pZHhkIGFuZCBidXMvdmRldg0KPiA+ID4gPiA+IC0gUmVzb3VyY2UgbGVha3MgaW4gUENJ
IGFuZCBWTUJVUyBidXMgY2xlYW51cCAobWFwcGluZ3MgYW5kDQo+ID4gPiA+ID4gaW50ZXJydXB0
cykNCj4gPiA+ID4gPiAtIFNpbXBsaWZpZWQgZGV2aWNlIGZyZWVpbmcgaW4gTlhQIGJ1c2VzIChE
UEFBIGFuZCBGU0xNQykNCj4gPiA+ID4gPiAtIERlZmVycmVkIGludGVycnVwdCBhbGxvY2F0aW9u
IHRvIHByb2JlIHRpbWUgKE5YUCBidXNlcywgVk1CVVMpDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBU
aGUgY29yZSBpbmZyYXN0cnVjdHVyZSBjaGFuZ2VzIChwYXRjaGVzIDktMTApIGludHJvZHVjZSB0
aGUNCj4gPiA+ID4gPiBnZW5lcmljIGNsZWFudXANCj4gPiA+ID4gPiBmcmFtZXdvcms6DQo+ID4g
PiA+ID4gLSBSZWZhY3RvcnMgdW5wbHVnIG9wZXJhdGlvbnMgdG8gYmUgdGhlIGNvdW50ZXJwYXJ0
IG9mDQo+ID4gPiA+ID4gcHJvYmVfZGV2aWNlDQo+ID4gPiA+ID4gLSBJbXBsZW1lbnRzIHJ0ZV9i
dXNfZ2VuZXJpY19jbGVhbnVwKCkgdG8gY2VudHJhbGl6ZSBjbGVhbnVwDQo+ID4gPiA+ID4gbG9n
aWMNCj4gPiA+ID4gPiAtIEFkZHMgLmZyZWVfZGV2aWNlIG9wZXJhdGlvbiB0byBzdHJ1Y3QgcnRl
X2J1cw0KPiA+ID4gPiA+IC0gQWRkcyBjb21waWxlLXRpbWUgdmVyaWZpY2F0aW9uIHRoYXQgcnRl
X2RldmljZSBpcyBhdCBvZmZzZXQgMA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIGZpbmFsIHBh
dGNoZXMgKDExLTEzKSBjb252ZXJ0IHJlbWFpbmluZyBidXNlcyB0byB1c2UgdGhlDQo+ID4gPiA+
ID4gZ2VuZXJpYyBjbGVhbnVwDQo+ID4gPiA+ID4gaGVscGVyOg0KPiA+ID4gPiA+IC0gRFBBQSBi
dXM6IGFkZCB1bnBsdWcgc3VwcG9ydA0KPiA+ID4gPiA+IC0gVk1CVVMgYnVzOiBzd2l0Y2ggdG8g
ZW1iZWRkZWQgZGV2aWNlIG5hbWUgYW5kIGFkZCB1bnBsdWcNCj4gPiA+ID4gPiBzdXBwb3J0DQo+
ID4gPiA+DQo+ID4gPiA+IFRoZXJlIGlzIGEgaHVuZyBvbiB2bWJ1cyBkdXJpbmcgZGV2aWNlIHNo
dXRkb3duIGFmdGVyIGFwcGx5aW5nIHRoZQ0KPiA+ID4gPiBzZXJpZXMsIEknbSBsb29raW5nIGlu
dG8gaXQuDQo+ID4gPg0KPiA+ID4gVHVybmVkIG91dCB0byBiZSBhIHRlc3QgaXNzdWUuIFBsZWFz
ZSBzZWUgbXkgY29tbWVudHMgb24gcGF0Y2ggMDgsIHRoZQ0KPiBwYXRjaCBzZXQgdGVzdGVkIHdl
bGwgYWZ0ZXIgdGhhdCBmaXguDQo+ID4NCj4gPiBUaGFua3MgYSBsb3QgZm9yIHRlc3RpbmchDQo+
ID4NCj4gPiBJJ2xsIGZpeCB0aGlzIHJlZ3Jlc3Npb24gaW4gdGhlIG5leHQgcmV2aXNpb24uDQo+
IA0KPiBGeWkgSGVtYW50LCB0aGlzIHNlcmllcyBoYXMgYSBzaW1pbGFyIHJlZ3Jlc3Npb24gZm9y
IGRwYWEvZnNsbWMgYnVzIChpbnRlcnJ1cHQNCj4gaGFuZGxlIGFsbG9jYXRlZCB0b28gbGF0ZSBp
biB0aGUgZGV2aWNlIHByb2JpbmcgZmxvdykuDQo+IFRoZSBpbXBsaWNhdGlvbnMgc2VlbSBncmVh
dGVyIHRoYW4gZml4aW5nIHZtYnVzIHRob3VnaCwgYXMgSSBhbSBub3cgZmluZGluZw0KPiBidWdz
IG9uIHRoZSBjbGVhbnVwIHNpZGUgKGludGVycnVwdCBldmVudGZkIGFyZSBuZXZlciBjbG9zZWQs
IGZvciBleGFtcGxlKS4NCj4gDQo+IEknbGwgdGhpbmsgYWJvdXQgaG93IHRvIGZpeCBpdCBpbiB0
aGUgbmV4dCByZXZpc2lvbiwgb25lIG9wdGlvbiBtYXkgYmUgdG8gbGVhdmUNCj4gZHBhYS9mc2xt
YyBhbG9uZS4uID8NCj4gQnV0IGluIHRoZSBsb25nIHJ1biwgYWxsIGJ1cyBkcml2ZXJzIHNob3Vs
ZCBiZWhhdmUgY29uc2lzdGVudGx5Lg0KPiANCj4gSSdsbCBnZXQgYmFjayBpbiB0aGlzIHRocmVh
ZCBvbmNlIEkgaGF2ZSBhIGJldHRlciB2aWV3IG9mIHRoZSBzaXR1YXRpb24uDQo+IA0KDQpISSBE
YXZpZCwNCglHaXZlIG1lIHNvbWUgdGltZSB0byBnZXQgdGhpcyB0ZXN0ZWQgb24gdGhlIGhhcmR3
YXJlLiANCg0KUmVnYXJkcw0KSGVtYW50DQoNCj4gDQo+IC0tDQo+IERhdmlkIE1hcmNoYW5kDQoN
Cg==
