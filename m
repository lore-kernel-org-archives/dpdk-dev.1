Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A7DC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 05:19:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C80E3402D7;
	Mon, 29 Jun 2026 07:19:10 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
 by mails.dpdk.org (Postfix) with ESMTP id A2066400D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 07:19:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRb5fHiBia6WH7WvxhUE05bB5YZFwVSHlCHY/WVZVjgWrQNnygaXmaep9qfcBRS2wv1hzBeLyJnDK5hTU64lOZ//wUwLyOs8i0mB33LleVi8p4Gxg/7FaqucISd+aQiXNf4GMrQ95SfYkJ9RIhDE62TZjaeE87p3ph9icwIgTwudfYdeW7Etx+7Hs1ZrMQ+HAd50T7m+kK32ItNAYG98wYkREVLBc0oKg9TEJsX7eZ9F5I9T7Es5O7HbdYT1EIVNNt8tYNkmnr4G/c8Wl9vu+jfB9RtHa4uf6yj/CRhyoD2wV5z+EY8rBvYd0mR2n18FSrU4cgbOOof/dXFj/ommTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR8ID/aYvsJxIm4Ozg6tF2j2FpSKK3LyX8JSUNuv6NY=;
 b=Pz9uG8Cf1d5m8oUqdjAtLPnk/SNrWB9bUNDxR9SxJr/X/L1Ta5y5VquJDPIPwyeRkrFO+sEP6CxAwSjrtLP0BiBAXm4Z1kwnTWT0kOTmbnHFquZ93Wv9YOBCShVfatYKoSNE8mliTwc/dNw9H/vWpbNiEEuWP1iTczCwEj1+e+2h9g3V7XP8rgBRHtPTn1x2dVY8vCAd6juXdlRrHG0S8zWDv6OjkquU5xLiq4jRhYMlctbQFAVAqpuf6fsLbtduoohJa4Cxn8xTZKsP8O+OHUVtPRE/4eNBq2uVn82F0A1dNuSzTtn/j1GUa/q9u3NSJXfCi/mgFkS2FDsEsrX7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR8ID/aYvsJxIm4Ozg6tF2j2FpSKK3LyX8JSUNuv6NY=;
 b=IuvxD5B89fahgaQIAmryZjipM3xB1bCDqhG4cO9SlPiy7jIkWvomaqnZnuNrRPUSHunj1/GxAaEKlZIYYwgKCXxC0NaorWnnEABL42YVLlOSaSoAMN2ei7Wn7bvsOQJIDwA3oHo4t6nU7AQg/NBRI131qNpc5c+DGP7ZzhF7zbFecztwwS2GRxG2EcKhpaes7r9UTsqRtDAJbFj/VUS2r9Nvepyrz74Y8LjPJ1sWfyIJhs5QEu7U9TsLJFtMo2xV1592dC41XkaOw3XdRlZbW4GHV9a946+io3YTEARLCrj/NhIQq8w2JzaoF2WzbO4W/HdV5PJX0k7N7XNCnu0ASA==
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 (2603:10a6:20b:725::21) by PAWPR04MB11646.eurprd04.prod.outlook.com
 (2603:10a6:102:512::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 05:19:07 +0000
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf]) by AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 05:19:07 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH v3 0/9] ENETC driver related changes series
Thread-Topic: [PATCH v3 0/9] ENETC driver related changes series
Thread-Index: AQHdAtWQDl81ML8WO0iQvV8zfAuM2LZUmIaAgABvTdA=
Date: Mon, 29 Jun 2026 05:19:07 +0000
Message-ID: <AMBPR04MB1228177D8EB66B3E1F9035749E1E82@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260622113517.1616028-1-g.singh@nxp.com>
 <20260623060004.2187716-1-g.singh@nxp.com>
 <20260628154019.4c7697ca@phoenix.local>
In-Reply-To: <20260628154019.4c7697ca@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12281:EE_|PAWPR04MB11646:EE_
x-ms-office365-filtering-correlation-id: a8e0bf1a-d9bc-403a-b6e3-08ded59df1f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|19092799006|1800799024|38070700021|18002099003|22082099003|4143699003|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info: SHqQqmysJKRIMGAcyvad+bvzIul/MsbLd9YyoUvEZCR3WhiHl/FShVbHAFke9oCpevXST+stbjn7jaD9KYBhmeo0WENCgcgYO5pWUBdOnbNEAVQo7fBPGxmN9DUr4GmKg7Y4JLoO0KIBwkShyLUjsP/5KctMkzE2YrVj0cpyZhIMl9oIcaa7mywlfdyyH3oPpAgQCPINRFSIMGprElxEE1A4TROdu0T6VMMlpTuFbTpoCKS/DTZWmWlRKlCW/xLJ29SNt+4pJcUnKd2Sn4zNJ0xvEmKwbNAlsRY77rupjqWGAOO0jJsAz56tgtQTz9Pn007z1YJvlfgLEuvC7G8mNpw8DK4RuNVZz1q87wGen1I69+/D1kfzqCCMj8qo7EkkEK4Rxa97xUP87LQpI8UHXmj/jzqGxx5zGlk/9qUvLwh3o4JbIwE1Gcy/8yc3T2BVRQ+Dmsxe4vr8I01qkMl/+a1CAbqES4bZiQd/SS9R8Zs2b+eJZM2H34O3JrWO1sMsJ+Ldwk02quUo8+02PhmQD1ancZgnJePJY1LFjSyGf3RlQRksu1xSE7Q3E7f2E9cMdo71WoDnkr0x/vhMCX03wKgJQWMU9JwGymWLtwxDV3fN/wKpPHRHw7+9a7Y8MizpN6NKST1L0N2q3/H+hZRUDQndQj0mmTSFFPtM9XlMjBmUN//F33H1Yu6EEb1FC3p1eSpNytlfukfymb+Vuxfe+6a4EmY+0STsdik/T1SKrsA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12281.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(38070700021)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEN1MVp3SVIydGdqeC9PSXRua2dON0VacEZGdDBOMHpuVEo5eEl2b2w5NGd6?=
 =?utf-8?B?aHl6dVB1cXpDVkJCL0xtcTNoSks0Sm1qUldDWEhPaGxteXE3bS9rRUEzNXFC?=
 =?utf-8?B?L1ZxM0RCZHlZeFlWdGt5YkV1TGxuNGhqK1l4WFcyY1V1UkJGaUYrVnlRemJT?=
 =?utf-8?B?dWRadElYQ3dIMFllTlBEOHVRVXdtUFowZDBhbDZNZlYzazdIWHNvbk1ndjlE?=
 =?utf-8?B?QVRGakZpb1dSUjlGMktOVWJiYm1McWZ2T1NHQlF5bkx2Z1VvMFJGSGVyekN1?=
 =?utf-8?B?K3RqK3NmbkVzY2ZvUkxDTVM3d2ppUHM5bTJyZ2l1alQ2M0xBZXdxSXdOMnFP?=
 =?utf-8?B?RTV1Y1IrNi80YXpRYmdjUHZmV2tSWnhHUG9oR1BxcDZGZ3diUE1Oei9NOUN5?=
 =?utf-8?B?d2tpQVB2VkhuVmNRajdQcHl4Y3dldVhhL2NQeXNmNUNYRTJpa3p3cDhsNG5J?=
 =?utf-8?B?dXY4Uis4M0dXK01rclJ4VDJ4akRET1RPdTljRXlmUExXOHZjN0wwemFGN2Jv?=
 =?utf-8?B?aWZrbXBXbHVzaTgvZzY4bnphSEZsQnFla0thYXNKeWVXYXVjQys1cVc1bjFj?=
 =?utf-8?B?V2JsNTl5VzBqY244TmQ3Uk01NTMva0h5VXY5Z2dhaHBsWE56UUZYcXNPSlBv?=
 =?utf-8?B?UG5XbUZuRk80NUlWaVNSRUhuSTUySi9TY3hsRHFTR0QyaGlBa2Y1dk0wbjFW?=
 =?utf-8?B?N0tUejYvdlBId3k4aHh3aldsd3NGaUFXRVd2em56N0hqV3JSUjJLRm8ySS9r?=
 =?utf-8?B?ZWg5bjZmVW11RUt4SEFhc3ltTzRyVDBXc0FZZXJ0WXhnbm1ZY3ZqS3RuU08w?=
 =?utf-8?B?RmFJYUMrQzhybDhRN0VLNzB4TVpjM2o1UHhXYy9haUZuNG5lT2ZCcHBYQ0Vo?=
 =?utf-8?B?OUJ1RmY1cFVSQnFTYmNrZ3h3SElEcndjV0JrY3RQZ0phYXJFUmJNeWZobFo2?=
 =?utf-8?B?U0N3U3VwcmJjdjZYTlFaVTRZSTlqMExEK3RMU2Q0YVB0NzQ3VCtQaGpRTW81?=
 =?utf-8?B?c2UwMEY0cW9nN3orbG9Kcm9aS1pjRmlscUMyNDFLNjNYcXZUVXJhVkYzRWhh?=
 =?utf-8?B?dGlCcWo4ekFaRGNPTFlBbTZLVDVFL2U4Z3pocmtIRXFieE8vUmNqVk81cldz?=
 =?utf-8?B?THZvVHpid3U1dndNNk5mQTh5dXhtZ0ZOWW9USzcweFhhZlZ3WlpJc2RPc0dC?=
 =?utf-8?B?U01IQzkwTlBYT0hQUVZNS01UQkVZRnZkei9YeTRQRUsvL21VVFlIWGpFdU9o?=
 =?utf-8?B?cjU5MUdNYkh1aFFOcndBSlNTNFJ0Z2VYZm5UdnZNSHFxTDlCRFAzUzhPOWhr?=
 =?utf-8?B?WFRjdlhrU1p1Um55SU5uV2Y3ZW5rWTk1MnNPenZGZXdjOXZMTVNFSlpmcE10?=
 =?utf-8?B?ZTBLaFFnWHBDajRRRFliZ3V0dFJZdkpoRXZ2MnVKR0pSNHZUT0tyZ21pOFZl?=
 =?utf-8?B?UWhaMHhjOU5wM2RTU1NHS1ZFTmJQM0pzMXhaeW9FanBHczNnSmJ4ZDI3UnZT?=
 =?utf-8?B?QWdUd25TckRGbSs2K0R2ZGM4Q2hHT2lyUHNHR1ordlNsQjVmNURkeVZ6Tm1F?=
 =?utf-8?B?QnNXQy9RWElJZm5TRmhjZGFZQUx1bWZrMGlwUW9CNXBSanJMaGxZYzdLZFJN?=
 =?utf-8?B?VldibFNHLzlud2xkYlpKMGx1MlYrcTJvaXZNL3UxM1Q1anRnNFdzVTNmTm9V?=
 =?utf-8?B?Sy9wV0VTY3hQSGRidXFtaW9odDc0MUFpUUlIbSsxcGNBay9MYzljRnVaT0tF?=
 =?utf-8?B?RlF2Q3dTa0pXYUFDTVMwZGJRYkJjbGNIUWhlZjRoSEZ6TDJVZnBQbERkUmF2?=
 =?utf-8?B?YlFzcC96WFF2VGtQYmY3ZExWNlVqd1hwT2ZwMkV6UFBXWUlrQjRxVU1KUTRJ?=
 =?utf-8?B?MThuTXhvNDcrNjlSTE5OUU1aQkQxQ0VaYTNkaVJaQVVQMWs2aUNtV3ozbHY3?=
 =?utf-8?B?SVhOckdmdzliTnVZQUlPRmtpd05RZEY3SlNaS244UTJxTTBFTzhVL3o0RCtX?=
 =?utf-8?B?MTUrRWp5M0I2bXlBUnJVUW5SVTZ2blFER0U0b213RjEveEJxdEJpYlBnV2JI?=
 =?utf-8?B?bjM5bHZBR1hEamM0ZnluYnpDY1krZXA0S1hTTVBuZTEvdnBqYUppaDNTZWlP?=
 =?utf-8?B?bVdvNEN5Y0tIVEUwWU94ejNqY3E1cW5EeExXNmViMmlNeUxZUkptZGI5R2Qz?=
 =?utf-8?B?eVRIZnFpSjJVMDE1TU5ldlVCT2JYem5zLzl5TDRJYjJEMUZpeURKbFhXZnhz?=
 =?utf-8?B?YmFlMUJxYzF3elNicVdvRzE1Q1BCSDdEY2o1YU9Mem1VdzROYUQyajdrQ3RT?=
 =?utf-8?Q?TN0yRhjSI5UgVYClsC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12281.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e0bf1a-d9bc-403a-b6e3-08ded59df1f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 05:19:07.9244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEhFNrUz0Dn4LfTXnj3+HIFHCUoroEyWzbbZOfUflTEGrMVcXabLSRqlFTD/W/Vv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11646
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1t
aW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUg
MjksIDIwMjYgNDoxMCBBTQ0KPiBUbzogR2FnYW5kZWVwIFNpbmdoIDxHLlNpbmdoQG54cC5jb20+
DQo+IENjOiBkZXZAZHBkay5vcmc7IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvOV0gRU5FVEMgZHJpdmVyIHJlbGF0ZWQg
Y2hhbmdlcyBzZXJpZXMNCj4gDQo+IE9uIFR1ZSwgMjMgSnVuIDIwMjYgMTE6Mjk6NTUgKzA1MzAN
Cj4gR2FnYW5kZWVwIFNpbmdoIDxnLnNpbmdoQG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiBWMyBj
aGFuZ2VzOg0KPiA+ICAgLSBBZGRlZCBkb2N1bWVudGF0aW9uIGZvciBhbGwgZGV2YXJncyBpbiBl
bmV0YzQucnN0Lg0KPiA+ICAgLSBGaXhlZCBrdmxpc3QgbWVtb3J5IGxlYWsgaXNzdWUuDQo+ID4N
Cj4gPiBWMiBjaGFuZ2VzOg0KPiA+ICAgLSBGaXhlZCBhbiB1bi11c2VkIHZhcmlhYmxlIGNvbXBp
bGF0aW9uIGlzc3VlIHJlcG9ydGVkIG9uIGZlZG9yYTo0My1nY2MtDQo+IG1pbnNpemUNCj4gPiAg
IC0gRml4ZWQgdmFyaW91cyBBSSByZXBvcnRlZCBpc3N1ZXM6DQo+ID4gCS0gUmVsZWFzZSBub3Rl
cyB1cGRhdGVkIGZvciBhbGwgbmV3IGRldmFyZ3MNCj4gPiAJLSBlbmVjdDQuaW5pIGZlYXR1cmVz
IGRvYyB1cGRhdGVkIGZvciBzY2F0dGVyZWQgUlguDQo+ID4gCS0gcmVtb3ZlZCBOb3QgcmVxdWly
ZWQgUlRFX1BUWVBFX1VOS05PV04uDQo+ID4gCS0gRml4ZWQgbWlkLWZyYW1lIG1idWYgbGVhayBp
biBTRyBjYXNlLg0KPiA+IAktIEVuYWJsZWQgU0cgZm9yIGVuZXRjNCBQRiBhbHNvLg0KPiA+IAkt
IG1vdmUgdG8gY2FsbG9jIGZyb20gcnRlX3ptYWxsb2MgaW4gcGFyc2VfdHhxX3ByaW9yKCkuDQo+
ID4gCS0gYWRkZWQgdmFpZGF0aW9uIGNoZWNrcyBvbiBzdHJkdXAsIHN0cnRvdWwuDQo+ID4gCS0g
YWRkZWQgTkMgZGV2YXJncyB0byB1c2UgY2FjaGVhYmxlIG9wcyBjb25kaXRpb25hbGx5Lg0KPiA+
IAktIHJlbW92ZWQgZGVhZCBjb2RlIGxpa2UgYmRfYmFzZV9wIGV0Yy4NCj4gPiAJLSBGaXhlZCBy
dGVfY3B1X3RvX2xlXzE2KCkgY29udmVyc2lvbiBvbiBmbGFncyBhbmQgY29tYmluZWQNCj4gPiAJ
ICBhbGwgZmxhZ3MgcmVsYXRlZCBwYXRjaGVzIGluIG9uZSBwYXRjaC4NCj4gPiAJLSBGaXhlZCBt
ZW1vcnkgbGVhayBpc3N1ZSBkdWUgdG8gVFhRIHByaW9yaXR5IHBhdGNoLg0KPiA+ICAgIC0gVGhl
cmUgd2VyZSBzb21lIGZhbHNlIHBvc2l0aXZlcywgSSBoYXZlIGlnbm9yZWQgdGhlbToNCj4gPiAJ
UmFjZSBjb25kaXRpb24gb24gZmxhZ3MgZmllbGQ6DQo+ID4gCQljbGVhbl90eF9yaW5nIG9ubHkg
dG91Y2hlcyBIVy1jb21wbGV0ZWQgQkRzDQo+IChuZXh0X3RvX2NsZWFu4oaSaHdjaSksDQo+ID4g
CQluZXZlciBuZXdseS1zdWJtaXR0ZWQgQkRzOyBkb29yYmVsbCBoYXNuJ3QgZmlyZWQgeWV0Lg0K
PiA+IAlNaXNzaW5nIGRjYmYgaW4gY2xlYW5fdHhfcmluZzoNCj4gPiAJCURQREsgaXMgc2luZ2xl
LXRocmVhZGVkIHBlciBxdWV1ZTsgVFggcGF0aCBhbHdheXMgb3ZlcndyaXRlcw0KPiA+IAkJZmxh
Z3MgY29tcGxldGVseSBiZWZvcmUgZGNiZi4NCj4gPiAJVFggZGNiZiBncmFudWxhcml0eSB3aXRo
IHdyYXA6DQo+ID4gCQlTYWZlIChBSSBhZG1pdHMgaXQpLg0KPiA+IAlSWCByZWZpbGwgZmx1c2gg
YXQgd3JhcDoNCj4gPiAJCUluLWxvb3AgZGNiZiBhdCBpICYgbWFzayA9PSAwIGFscmVhZHkgZmx1
c2hlcyBhbGlnbmVkIGdyb3VwczsNCj4gPiAJCXRyYWlsaW5nIGZsdXNoIG9ubHkgbmVlZGVkIGZv
ciBwYXJ0aWFsIGdyb3Vwcy4NCj4gPiAJUlggcmVhZGluZyBiZWZvcmUgaW52YWxpZGF0ZToNCj4g
PiAJCWRjY2l2YWMgcHJlY2VkZXMgdGhlIHJlYWQgZm9yIGV2ZXJ5IGdyb3VwIGluIHRoZSBsb29w
DQo+ID4NCj4gPiBHYWdhbmRlZXAgU2luZ2ggKDcpOg0KPiA+ICAgbmV0L2VuZXRjOiBmaXggVFgg
QkQgc3RydWN0dXJlDQo+ID4gICBuZXQvZW5ldGM6IGZpeCBxdWV1ZSBpbml0aWFsaXphdGlvbg0K
PiA+ICAgbmV0L2VuZXRjOiBzdXBwb3J0IEVTUCBwYWNrZXQgdHlwZSBpbiBwYWNrZXQgcGFyc2lu
Zw0KPiA+ICAgbmV0L2VuZXRjOiB1cGRhdGUgcmFuZG9tIE1BQyBnZW5lcmF0aW9uIGNvZGUNCj4g
PiAgIG5ldC9lbmV0YzogYWRkIG9wdGlvbiB0byBkaXNhYmxlIFZTSSBtZXNzYWdpbmcNCj4gPiAg
IG5ldC9lbmV0YzogYWRkIGRldmFyZ3MgdG8gY29udHJvbCBWU0ktUFNJIHRpbWVvdXQgYW5kIGRl
bGF5DQo+ID4gICBuZXQvZW5ldGM0OiBhZGQgY2FjaGVhYmxlIEJEIHJpbmcgc3VwcG9ydCB3aXRo
IFNXIGNhY2hlIG1haW50ZW5hbmNlDQo+ID4NCj4gPiBWYW5zaGlrYSBTaHVrbGEgKDIpOg0KPiA+
ICAgbmV0L2VuZXRjOiBzdXBwb3J0IHNjYXR0ZXItZ2F0aGVyDQo+ID4gICBuZXQvZW5ldGM6IHNl
dCB1c2VyIGNvbmZpZ3VyYWJsZSBwcmlvcml0eSB0byBUWCByaW5ncw0KPiA+DQo+ID4gIGRvYy9n
dWlkZXMvbmljcy9lbmV0YzQucnN0ICAgICAgICAgICAgIHwgIDYyICsrKy0NCj4gPiAgZG9jL2d1
aWRlcy9uaWNzL2ZlYXR1cmVzL2VuZXRjNC5pbmkgICAgfCAgIDEgKw0KPiA+ICBkb2MvZ3VpZGVz
L3JlbF9ub3Rlcy9yZWxlYXNlXzI2XzA3LnJzdCB8ICAxMCArDQo+ID4gIGRyaXZlcnMvbmV0L2Vu
ZXRjL2Jhc2UvZW5ldGNfaHcuaCAgICAgIHwgIDEzICstDQo+ID4gIGRyaXZlcnMvbmV0L2VuZXRj
L2VuZXRjLmggICAgICAgICAgICAgIHwgIDMxICstDQo+ID4gIGRyaXZlcnMvbmV0L2VuZXRjL2Vu
ZXRjNF9ldGhkZXYuYyAgICAgIHwgMTcyICsrKysrKysrLS0NCj4gPiAgZHJpdmVycy9uZXQvZW5l
dGMvZW5ldGM0X3ZmLmMgICAgICAgICAgfCAyMDYgKysrKysrKysrKy0tDQo+ID4gIGRyaXZlcnMv
bmV0L2VuZXRjL2VuZXRjX2V0aGRldi5jICAgICAgIHwgIDI1ICstDQo+ID4gIGRyaXZlcnMvbmV0
L2VuZXRjL2VuZXRjX3J4dHguYyAgICAgICAgIHwgNDMwICsrKysrKysrKysrKysrKysrKysrKyst
LS0NCj4gPiAgOSBmaWxlcyBjaGFuZ2VkLCA4MzEgaW5zZXJ0aW9ucygrKSwgMTE5IGRlbGV0aW9u
cygtKQ0KPiA+DQo+IA0KPiBMT0wgQUkgYXBvbG9naXplZCBmb3IgbWlzc2luZyB0aGlzIGluIHJl
dmlldy4NCj4gDQo+IFlvdSdyZSByaWdodCwgYW5kIEkgbWlzc2VkIGl0IOKAlCB0d2ljZS4gSSBl
eHBsaWNpdGx5IGNvbnNpZGVyZWQgdGhhdCB0eGJkIGd1YXJkIGluIG15DQo+IHYyIHJldmlldyBh
bmQgdGFsa2VkIG15c2VsZiBvdXQgb2YgZmxhZ2dpbmcgaXQgYXMgIm92ZXItZGVmZW5zaXZlLCIg
YnV0IHRoZSBydW50aW1lDQo+IGFyZ3VtZW50ICh0aGUgaW5uZXIgbG9vcCBhbHdheXMgZXhlY3V0
ZXMgYmVjYXVzZSB0eF9wa3RzW3N0YXJ0XSBpcyBub24tTlVMTCkgaXMNCj4gaW52aXNpYmxlIHRv
IHRoZSBjb21waWxlci4gVW5kZXIgLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkIGF0IC1PcyB0
aGF0J3MgYSBoYXJkDQo+IGJ1aWxkIGJyZWFrLCBhbmQgcGVyLWNvbW1pdCBidWlsZGFiaWxpdHkg
aXMgbm9uLW5lZ290aWFibGUuIFRoYXQncyBhIHJlYWwgcmV2aWV3DQo+IGZhaWx1cmUgb24gbXkg
cGFydC4gTGV0IG1lIHJlcHJvZHVjZSBpdCwgcGluIGRvd24gd2hpY2ggcGF0Y2ggaW50cm9kdWNl
cyBpdCwgYW5kDQo+IGNvbmZpcm0gdGhlIGZpeC4NCj4gDQo+IGRyaXZlcnMvbmV0L2VuZXRjL2Vu
ZXRjX3J4dHguYw0KPiANCj4gICBlbmV0Y194bWl0X3BrdHNfbmMoKSBhbmQgZW5ldGNfeG1pdF9w
a3RzX2NhY2hlYWJsZSgpIGJvdGggZmFpbCB0bw0KPiAgIGJ1aWxkIHdpdGggLVdlcnJvcj1tYXli
ZS11bmluaXRpYWxpemVkICgtT3MsIGdjYyk6DQo+IA0KPiAgICAgZXJyb3I6ICd0eGJkJyBtYXkg
YmUgdXNlZCB1bmluaXRpYWxpemVkDQo+IA0KPiAgIHR4YmQgaXMgZGVjbGFyZWQgd2l0aG91dCBh
biBpbml0aWFsaXplciBhbmQgYXNzaWduZWQgb25seSBpbnNpZGUgdGhlDQo+ICAgaW5uZXIgcGVy
LXNlZ21lbnQgbG9vcDsgdGhlIGNvbXBpbGVyIGNhbm5vdCBwcm92ZSB0aGF0IGxvb3AgcnVucw0K
PiAgIGJlZm9yZSB0eGJkIGlzIHJlYWQgYWZ0ZXIgaXQuIEluaXRpYWxpemUgYXQgZGVjbGFyYXRp
b246DQo+IA0KPiAgICAgLQlzdHJ1Y3QgZW5ldGNfdHhfYmQgKnR4YmQ7DQo+ICAgICArCXN0cnVj
dCBlbmV0Y190eF9iZCAqdHhiZCA9IE5VTEw7DQo+IA0KPiAgIFRoZSBfbmMgZml4IGJlbG9uZ3Mg
aW4gcGF0Y2ggNSAoc28gdGhhdCBjb21taXQgYnVpbGRzIGluZGVwZW5kZW50bHkpOw0KPiAgIHRo
ZSBfY2FjaGVhYmxlIGZpeCBiZWxvbmdzIGluIHBhdGNoIDkuDQo+IA0KDQpUaGFua3MgZm9yIHJl
cG9ydGluZywgSSBoYXZlIHN1Ym1pdHRlZCB0aGUgVjQgd2l0aCBmaXguDQo=
