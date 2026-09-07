Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C571C79F89
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 09:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D92814027F;
	Mon,  7 Sep 2026 11:36:18 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
 by mails.dpdk.org (Postfix) with ESMTP id B7F1540041
 for <dev@dpdk.org>; Mon,  7 Sep 2026 11:36:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6RNuynY+awogDN7582T4P2QZvyY/v353EhNxCyDDp+yhcOvFhiVrvOy/qe8w1xTPJgPGLxdvh12Wvydn3L3akJVER8+J5htCA6lrxjOcIzvYxqHBL8p3mtmSfQZV8XjRLy6KMOPEIj7RLazR72PGD2oF1sYXTc7+z14mXxQp5JnKaN/gqi3XJ1qrSb8vAtoEvsaApRCO+3pNOF0T3rVEVv5mabmVtqpZio7dg5MFbEXcKourtpELQjl5A354pdzYRlTIGi/Swq/Gq3S5YIhaosCtKOx9Cs0mrt4gwKhzzLdyifhq63tOy8ABEKC/T5WlL0W1/x4TcvYlAF0Yk4h+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox17xPNP6pTZj84mLqMnBgFRw+Vn7o2H0EoQGHyNIqk=;
 b=UBa8N8JNMyF2WpaEY9SivB4/7Zx0ul9AVVPVCxxpoVqKVJLMu/J/vejQDVRklsi4JZwC90Lgc4/LGbOjkGIxdmsTOGAB2UCoY7hzJ8hffNli7XB5e8DXkABSRURUYvUKvEDWvwmppCsK0N7sjy9OXJY81YSWbRCTJPx2h65gGBtAzcm6EA4FfLuTZvKWexdhM7I8XhPhDygz+dlfobi2xUf3CfznVyzef5P12A/fUeSJWmdM2TLR5jD0IF7jJStRJDbTtGlu80C3GZUGbG2Uk2n5lCc5lvD1uM6fgO9GtPQGgfQLVtWlAzcGHQOwj5TvEE2PD3NJTzLKY0/Qw9r28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox17xPNP6pTZj84mLqMnBgFRw+Vn7o2H0EoQGHyNIqk=;
 b=Vzht6ACeZvMeBnawzqNRkfqBeDKSRC13itrZLk/1hx2NefgQgQ+i9XdPOsMgbFxI38fou9K+3soor4s5trsxIP8sJ0kcPTr4JvV3M32Z5MZMplk3UBahkYHTAzHa62Rf1MTPJUP1Ur7/GxGrOqPli+jC1okQqY61yUFCCu7Pt0hl4hRVn2EQWYKoUc26INTQLZKCdllauVpJ0OOk+N3WhMsFrPmueV7pW7AyAw7byOClsyCdLh/Qeswe0Yk5uUD1ejEV8tPCM5uzrYl/fD4PG0gKOXwDzAJPaX3C+a+kICZvSWLTaNvuW9lsZUEbSF/n8085wZFPhy1YhZgRj3mk4w==
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 (2603:10a6:20b:725::21) by DU4PR04MB10459.eurprd04.prod.outlook.com
 (2603:10a6:10:56b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:36:11 +0000
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf]) by AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf%4]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 09:36:11 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH v12 15/15] net/enetc4: add WRR Tx scheduler devarg for VF
 rings
Thread-Topic: [PATCH v12 15/15] net/enetc4: add WRR Tx scheduler devarg for VF
 rings
Thread-Index: AQHdMTHeOSKL59i9V0adrOoD+KelAba9PysAgAW0fjA=
Date: Mon, 7 Sep 2026 09:36:11 +0000
Message-ID: <AMBPR04MB12281ADC78B3A57B4DAC360A4E1B22@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260821055643.1359277-1-g.singh@nxp.com>
 <20260821055643.1359277-16-g.singh@nxp.com>
 <20260903111938.6164ae05@phoenix.local>
In-Reply-To: <20260903111938.6164ae05@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Enabled=True;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SetDate=2026-09-07T09:27:01.0000000Z;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Name=NXP
 Public; MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_ContentBits=3;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12281:EE_|DU4PR04MB10459:EE_
x-ms-office365-filtering-correlation-id: a155e48c-7a37-4fea-4b7f-08df0cc373d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|23010399003|366016|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 0FLSQ7xnNf3xHciWzClFkQQyiNxNq0jNrLaHWH3f6CLo0Y+ftTzWJc3hWCuxSOL+/mv+4Z1RLUTwKStm+gec86bGGKBpuoGAsojhp1AY2L8QBwMnGnz9LhLmB3W5QEjZx7q0sHQKCftRMYbPaRoVwGSrNy1PvGV+vI56WI4CvNLrSUpTdZP6sMX3en211WGY86uQW8NqWO5IbNLp/bQSz/d5bghpa4m2BEaYORFtgloroVuwiLdpAQEG3XQm2jSV+787ad1JeYXTz4LLFUy/m0bus0Um7B5vq/JhiZLFT7grnSFmUX0LXyzFchdVfC0qg3P8rpuDLMDroGtyBcOnVrB5QawhqxE+GB9Jy4O59SPVb2mzfxdYT0aRUb2OFaJ0G/YkK67FPK8atSpJ8cHGc5aYnnMzScc15k0JR304xmvF3JugsyTqsIhEruV8XP1joiVIuVUYuqmy2yGqFeCjm4hMxzwMPSznGvvEavuG5AI5nMrL+/AhNoaod/Cme0mAzoONy6LsQvcyeyNj+/c4kbVLnihu6eH2tRdEiZfYwvVlUg6qvPKKocINrg4yWqk6l+04URsSjYWeV22eEkYFCP8a88Ut3lW4pOyuc+0F4bYPB3/gvQm6f2eKBE5P+OofyYhtloWcL0qh0+EEn4U4a8/RTdWQnDT9xR8K2xJuQVg0Ppk7Tsvs7lxwtm1UnnBi1kRGEKzpyRWOnzxWmNZLOxVEP5mcRByITCZBCDDC3Bk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12281.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUhzVyt2QmtNM1M0bWpoSTVkVmxTWXc2Qmo0K3d0eE8rVjd0NkY1YWRISjgv?=
 =?utf-8?B?c3hVSmYxQ1o5S2txUEhLYWJHbjVsWnZJZGFLMjhndVZCK1NQN0JadzdsLzdn?=
 =?utf-8?B?U2JrQTl4QjNNZmpBRmhMcU96NkdjNGdMUHdTMmVFY1JmbzRlQ2dwQ281Y3c1?=
 =?utf-8?B?OVNHSTRtc0cveTJpRlhWanY5ZEZlbS95amt2aUZXUGNaTUsrcnlhMDNGSFV0?=
 =?utf-8?B?bVA5MzFIZzdmVHhWT1FmSkRiODlhQzFQQlVYVVl0dVJXbENQQ1VzYURMYk9I?=
 =?utf-8?B?bklrWmlvanVRbzRGZFdxRHR5cm5aOFNpeVR1dGZTOUZJTXVxdk9BbjNaQzBi?=
 =?utf-8?B?WlpqRWlVVzA4YVVUR1NWMHNKTW1hRWN1bWhzeVdUOHBLU1Y5Z1JKRXFYdkth?=
 =?utf-8?B?VjFLVjdsaVVRWDBwMS9QV2JBYnhLN04rZEZ6QkdiTmZZcDFTR0dKaHptMVJY?=
 =?utf-8?B?dFlsYVVVSUdSZjlWc0ZPakdTS1BTdEdrYjVvSkxYTGdmbjZ5T0U1S1Z3MDVp?=
 =?utf-8?B?V3RNeHpzMG9CeFFxL0N4ZnMwR2M3Yjk1eVA0VTJvdVowZkFPQXFtU0lIbEJs?=
 =?utf-8?B?VjYvUGlrTXNDOVlueUwrSjZBcDVpcGFQYmFjWktLUHZuSFd5N1VqQ1JxMEcx?=
 =?utf-8?B?WGcwNlFMcFV2d3hjMkxrMjhVUXQ2WERpYklmNnF6QnpCenpteGp5V1g4cmhJ?=
 =?utf-8?B?dE9GbE5XTU1sTzJuZXJxYTg4TGRnTnA0blRocEQrTElVL2JBMTdiUTliYkZk?=
 =?utf-8?B?SDlHTXBkVHVaRXBGMit0S3pKSFZZUmFFa29ydDB0emtrQU45Q2p5YVpWeXBY?=
 =?utf-8?B?cmpKbFlkMUlNMXA5OFhTR0NkdSs0WEtTYWp2bVBwdkx6M2U4NnZiQ3FLSjRX?=
 =?utf-8?B?WnI2aUpmTkJvR1pRVVJ2YUFIWFZkYjVnclhDMHE1SFNTOUVtNGFqeHlpWFZZ?=
 =?utf-8?B?L2kvc284a2NYeFVTbDB5M2t0MXZUNlYvUDcrbXdSTVZVNXhjSlEybTlyRjU5?=
 =?utf-8?B?ZEUvVGpWdGpkWVVWRURLUmRxY3dheGtucng4bWczUW5BSUJvZnVYeFBHaSts?=
 =?utf-8?B?V29qMllxcTduSEg1K3NCOVpxRktQcGxPZVBVWkVZdnFVUDBMRXo2RDRxcTdZ?=
 =?utf-8?B?QVB6Q0J6bDVyc1pQWnBuK1NIVTVHaUcvdklRd0FGVXVIWjVzdnhPTDJlVjhD?=
 =?utf-8?B?ckV0aWtmc0FBenhPNkM4YkkwUnAwOUVLTGw0dzJxYlhleXhGbnJqTnYrRk1H?=
 =?utf-8?B?MENJVGNOUU9zVWN0Mm8yQWFkRlVCYWgxUFViK2xybnpMa2c0ekdqTmpNaEpq?=
 =?utf-8?B?dm02dW91TXVkSUlNTUszTWxQTnFvdXBkaWl4S3RRR21SWHhBZmg2Z0VVcS9a?=
 =?utf-8?B?eVo2bVIrclI3eDQzcmZZa0FjVHlGWW85NFAzaDhwM0IxNFoyZWN6ZVA4STBZ?=
 =?utf-8?B?MU1wWitMdkY5UzdrQnBpNUFjWGhJOXY1dUNyNG5nU0lHcDkxOEM2VDl0dzBN?=
 =?utf-8?B?YW0zNXEzRm5kd3ZjMnYvZ2tOdkdwM1pzS0xSbGdyckg3RzNqK1FFVlROZ2xX?=
 =?utf-8?B?VVh5a2JTVjB4U29pMjVlSUN0dmNMQU9xRExlbW5rYUJ5UVBMRG1nR1I0aFNq?=
 =?utf-8?B?bUpHWnRaa1ZIYlVjWlVoYmlZVHRBTExZL2I4VG1DTjdKZDNFUzJBK2NVcmpt?=
 =?utf-8?B?Z3RnaUZESXRLQUJveTJQc05yMTFQbmpKK0tSY1JmcXBxb1NiS2NiaGcvaENy?=
 =?utf-8?B?TGx5NnYvdnFNTTUzemY3SFVTOGNjR3I1ZjNOZG5sanhOU0dJWXFiOXZjYWUr?=
 =?utf-8?B?ZllLZmNlZUtDZkJjbmpaSlVwMlY1L1AwQjB5RWcyQnMzSGlHNFk0MDQ0UEVo?=
 =?utf-8?B?bGVUZlRabmhKUUZEcVR4ellubUNudnl3N2RhaG1jSDc3bS9IQ2ZjLzJBWGg4?=
 =?utf-8?B?V0lhSFFZQmsyaWhLbXJCclplVE9wT3RkVTNyMFlwZE8xOGZVd1BwNWZqa0t0?=
 =?utf-8?B?OUc4aXBoNWd4U0VOSnZMSkthRjQzTmFzZDg0L2htcEU4VlNERGhxeXZqcmoz?=
 =?utf-8?B?WHZERGpoK3NmT0dseUhkTVF4WUlzNnByMkI4UkpUam5kdHlYNjRwUndDYVBK?=
 =?utf-8?B?NUYxdWxJMENMbDFnV29mMUdVUG9jc3AxdFEva21ESWN6WWx3YzM2QTNlVXk1?=
 =?utf-8?B?a0dFV0dsbUdXQjE4Sm9UV2VGZG5KNSs4OVdEaVcyOVJ4bzBidEtveU10N0pI?=
 =?utf-8?B?dERqSU0xT1NtUXA1THVNM0REeVluY0FsRkZUVEhZUXhjd1pqZHRDOUtjNkVK?=
 =?utf-8?Q?wzqYC9CnhC+wn+Yphj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12281.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a155e48c-7a37-4fea-4b7f-08df0cc373d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:36:11.1268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWk7b46YmliaPTVHVQBS52XJRW+ROtFqoIZsmFH65n4F0QVkz73YBcVhs/zPZYKz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10459
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

SGksDQoNCg0KTlhQIFB1YmxpYw0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6
IFRodXJzZGF5LCBTZXB0ZW1iZXIgMywgMjAyNiAxMTo1MCBQTQ0KPiBUbzogR2FnYW5kZWVwIFNp
bmdoIDxHLlNpbmdoQG54cC5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7IEhlbWFudCBBZ3Jhd2Fs
IDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMiAxNS8x
NV0gbmV0L2VuZXRjNDogYWRkIFdSUiBUeCBzY2hlZHVsZXIgZGV2YXJnIGZvciBWRg0KPiByaW5n
cw0KPg0KPiBPbiBGcmksIDIxIEF1ZyAyMDI2IDExOjI2OjQzICswNTMwDQo+IEdhZ2FuZGVlcCBT
aW5naCA8Zy5zaW5naEBueHAuY29tPiB3cm90ZToNCj4NCj4gPiBBZGQgZW5ldGM0X3R4cV93cnIg
ZGV2YXJnIHRvIGNvbmZpZ3VyZSBwZXItcmluZyBXUlIgd2VpZ2h0cyBpbiB0aGUNCj4gPiBORVRD
IExFQUYtbGV2ZWwgVHggc2NoZWR1bGVyIChUQmFNUiByZWdpc3RlciwgYml0cyBbNjo0XSkuDQo+
ID4NCj4gPiBUaGUgTkVUQyBUeCBzY2hlZHVsZXIgaGFzIHRocmVlIGxldmVsczoNCj4gPiAgIC0g
Uk9PVCAocG9ydC9UQyk6IHN0cmljdCBwcmlvcml0eSArIENCUyAoUEYvcG9ydCBzcGFjZSkNCj4g
PiAgIC0gTUlEICAoU0kvVlNJKTogIFdCRlMgc2hhcGluZyAoUEYgc3BhY2UpDQo+ID4gICAtIExF
QUYgKFR4IEJEUik6ICBzdHJpY3QgcHJpb3JpdHkgKyBmcmFtZS1iYXNlZCBXUlIgKFZGL1NJIHNw
YWNlKQ0KPiA+DQo+ID4gVEJhTVIgaXMgaW4gdGhlIFZGIG93biBTSSBzcGFjZSwgc28gbm8gTGlu
dXggUEYgaW52b2x2ZW1lbnQgaXMgbmVlZGVkDQo+ID4gZm9yIFBSSU8gb3IgV1JSIGNvbmZpZ3Vy
YXRpb24uDQo+ID4NCj4gPiBDaGFuZ2VzOg0KPiA+IC0gZW5ldGNfaHcuaDogYWRkIEVORVRDX1RC
TVJfV1JSX01BU0ssIEVORVRDX1RCTVJfV1JSKG4pIG1hY3Jvcw0KPiBmb3INCj4gPiAgIFRCYU1S
IGJpdHMgWzY6NF0sIGFuZCBFTkVUQ19UQk1SX1BSSU9fTUFTSyBmb3IgYml0cyBbMjowXQ0KPiA+
IC0gZW5ldGMuaDogYWRkIHR4cV93cnIgcG9pbnRlciB0byBlbmV0Y19ldGhfaHcgc3RydWN0DQo+
ID4gLSBlbmV0YzRfZXRoZGV2LmM6IGFkZCBwYXJzZV90eHFfd3JyKCkgYW5kIHdpcmUgRU5FVEM0
X1RYUV9XUlIgZGV2YXJnDQo+ID4gICB0aHJvdWdoIGVuZXRjNF9nZXRfZGV2YXJncygpIGFuZCBl
bmV0YzRfZGV2X2NvbmZpZ3VyZSgpOyBhcHBseSBXUlINCj4gPiAgIGJpdHMgaW4gZW5ldGM0X3R4
X3F1ZXVlX3NldHVwKCkgYW5kIGVuZXRjNF90eF9xdWV1ZV9zdGFydCgpDQo+ID4NCj4gPiBVc2Fn
ZToNCj4gPiAgICMgc3RyaWN0IHByaW9yaXR5OiByaW5nIDAgaGlnaGVzdA0KPiA+ICAgLWEgMDAw
MjowMDoxMi4wLGVuZXRjNF90eHFfcHJpb3I9IjN8MnwxIg0KPiA+DQo+ID4gICAjIFdSUiAyOjQ6
MSBvbiBzYW1lLXByaW9yaXR5IHJpbmdzDQo+ID4gICAtYSAwMDAyOjAwOjEyLjAsZW5ldGM0X3R4
cV9wcmlvcj0iMXwxfDEiLGVuZXRjNF90eHFfd3JyPSIyfDR8MSINCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEdhZ2FuZGVlcCBTaW5naCA8Zy5zaW5naEBueHAuY29tPg0KPiA+IEFja2VkLWJ5OiBI
ZW1hbnQgQWdyYXdhbCA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT4NCj4gPiAtLS0NCj4NCj4gVGhp
cyBpcyBpbiBuZXh0LW5ldCBub3cgYXMgaXMsIGJ1dCB5b3Ugc2hvdWxkIGZpeCB0aGUgYXJnIHBh
cnNpbmcgY29kZSBub3QgdG8gdXNlDQo+IHVuc2FmZSBzdHJpbmcgaGFuZGxpbmcgZnVuY3Rpb25z
Lg0KPg0KPiBzdHJ0b2soKSBpcyBub3QgdGhyZWFkIHNhZmUsIHVzZSBzdHJ0b2tfcigpIG9yIG90
aGVyIG5vbi1kZXN0cnVjdGl2ZSBwYXJzaW5nLg0KPiBhdG9pKCkgYW5kIGF0b2YoKSBleGNlcHQg
Z2FyYmFnZSBhbmQgZG9uJ3QgZG8gb3V0IG9mIHJhbmdlIHRlc3RpbmcgYW5kIHRha2UNCj4gbmVn
YXRpdmUgdmFsdWVzOyB1c2Ugc3RydG91bCgpIGhlcmUgaW5zdGVhZC4gUHJvYmFibHkgc2hvdWxk
IGhhdmUgYSBEUERLIHN0cmluZw0KPiBmdW5jdGlvbiBmb3IgdGhpcyBsaWtlIHJ0ZV9zdHJfdG9f
dTMyKCkgZXRjOyBtaWdodCBnZXQgdG8gZG9pbmcgdGhhdC4NCj4NCj4gTmV3ZXIgdmVyc2lvbiBv
ZiBjaGVja3BhdGNoIChpbiBweXRob24pIGZsYWdzIHRoaXMgYXM6DQo+DQo+ICMjIyBbUEFUQ0hd
IG5ldC9lbmV0YzQ6IGFkZCBXUlIgVHggc2NoZWR1bGVyIGRldmFyZyBmb3IgVkYgcmluZ3MNCj4N
Cj4gRVJST1I6IFtGT1JCSURERU5fVE9LRU5dIFVzaW5nIHN0cnRvaygpLCBwcmVmZXIgc3RydG9r
X3IoKSAobm9uLXJlZW50cmFudA0KPiBzdGF0aWMgc3RhdGUpICMgIGRyaXZlcnMvbmV0L2VuZXRj
L2VuZXRjNF9ldGhkZXYuYzo3NjoNCj4gKyAgICAgICAgICAgICBzdHIgPSBzdHJ0b2soTlVMTCwg
InwiKTsNCj4NCj4gRVJST1I6IFtGT1JCSURERU5fVE9LRU5dIFVzaW5nIHN0cnRvaygpLCBwcmVm
ZXIgc3RydG9rX3IoKSAobm9uLXJlZW50cmFudA0KPiBzdGF0aWMgc3RhdGUpICMgIGRyaXZlcnMv
bmV0L2VuZXRjL2VuZXRjNF9ldGhkZXYuYzoxMDc6DQo+ICsgICAgIHN0ciA9IHN0cnRvayhpbnB1
dF9zdHIsICJ8Iik7DQo+DQo+IFdBUk5JTkc6IFtGT1JCSURERU5fVE9LRU5dIFVzaW5nIGF0b2ko
KS9hdG9sKCkvYXRvZigpLCBwcmVmZXIgc3RydG9sKCkvc3RydG91bCgpDQo+IHdpdGggZXJybm8g
YW5kIGVuZHB0ciBjaGVja3MgIyAgZHJpdmVycy9uZXQvZW5ldGMvZW5ldGM0X2V0aGRldi5jOjc1
Og0KPiArICAgICAgICAgICAgIGh3LT50eHFfcHJpb3JbaSsrXSA9IGF0b2koc3RyKSAmIEVORVRD
X1RCTVJfUFJJT19NQVNLOw0KPg0KPiBXQVJOSU5HOiBbRk9SQklEREVOX1RPS0VOXSBVc2luZyBh
dG9pKCkvYXRvbCgpL2F0b2YoKSwgcHJlZmVyIHN0cnRvbCgpL3N0cnRvdWwoKQ0KPiB3aXRoIGVy
cm5vIGFuZCBlbmRwdHIgY2hlY2tzICMgIGRyaXZlcnMvbmV0L2VuZXRjL2VuZXRjNF9ldGhkZXYu
YzoxMDk6DQo+ICsgICAgICAgICAgICAgdyA9IGF0b2koc3RyKTsNCj4NCj4gdG90YWw6IDIgZXJy
b3JzLCAyIHdhcm5pbmdzLCAwIGNoZWNrcywgMTAyIGxpbmVzIGNoZWNrZWQNCg0KQ291bGQgeW91
IHBsZWFzZSBzaGFyZSB0aGUgbGF0ZXN0IGNoZWNrcGF0Y2gucGwgc2NyaXB0PyBJIHRyaWVkIHRo
ZSBvbmUgZnJvbSBrZXJuZWwgdjcuMy1yYzIsIGJ1dCBJJ20gbm90IGFibGUgdG8gcmVwcm9kdWNl
IG9yIHNlZSB0aGVzZSBlcnJvcnMuIElzIHRoZXJlIGFueSBzcGVjaWZpYyBjb21tYW5kIG9yIHNl
dHVwIHJlcXVpcmVkIHRvIHJlcHJvZHVjZSB0aGVzZSBpc3N1ZXM/DQoNCkFsc28sIHdvdWxkIHlv
dSBsaWtlIG1lIHRvIHNlbmQgdjEzIGFmdGVyIGZpeGluZyB0aGlzLCBvciB3b3VsZCBpdCBiZSBz
dWZmaWNpZW50IHRvIHNlbmQgb25seSB0aGUgdXBkYXRlZCBwYXRjaDoNCiJuZXQvZW5ldGM0OiBh
ZGQgV1JSIFR4IHNjaGVkdWxlciBkZXZhcmcgZm9yIFZGIHJpbmdzIj8NCg0KDQo=
