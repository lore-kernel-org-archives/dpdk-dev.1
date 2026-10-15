Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B68FCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:42:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D181E4064C;
	Thu, 15 Oct 2026 16:42:24 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
 by mails.dpdk.org (Postfix) with ESMTP id 0E700402E7;
 Thu, 15 Oct 2026 16:42:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoRZgzYQjr5T2ShxrdpZozaLCrfDz2kXI+zC+rCqlmS1knIloKx7NYoN6qM6zhIcT3azcgBbhNyIWcKrJGkXHiuMVbWrATQBfl6DLEEs+vL9zWqESa0z0MB5RpkBaNvTI7bYCX312eDMo3qApE5w3UTTwJxAIHOonApqVHMhVpBGr4VmTqqfodPbcmVhKereHCMdbd5cPkg/7FKCaWTOiZe3HnezYjlz1d+qwCtMOqCctF59NjtQs5gdNFa4Nea4cXznGYGXn2X+4Odzh33XmRtxLYg2ZMfK9d6Ge+27toXIAw3YgQd05SVf/3YlDBGGbniXVg/Q1U+qw3SFi/64Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtYsgSc9+FXwnXaLSAYouOiCOqShTFgP9SawOX8J7TE=;
 b=y7ntB6Rt9pJCgeOBfY8V9Zg8ZDHqIoPRQBFLwmOGUZGwge0wQJryLKcG6uUgoNHeWVCqFhcrAWPgNcl8eWdlUslRpIDd/xq+bDUrEyxXxmo9mpzeOELkY9EEuvpUpPJCu0Ff/2evgcnmTD8A3cpHSWEtN+Rb+jKOHqxP8jIREM4g++NtMFG9xCww5WjkBCLOK/JfpXZSRUDnPhed/I9qj2IqnFXz8b3p56+ltnyA26g+x83KSgyJiJUNoJ0Tn583ue9W+rohdwhYY6vQND6x6ziaWe4p1EN73EMM+QhZXzMOqqld00x7VwytoIES8IGuo02A2ZGoV5I2ePVs/3TPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtYsgSc9+FXwnXaLSAYouOiCOqShTFgP9SawOX8J7TE=;
 b=dWqmYgxPC8+BFgkLk2BxzyYZHseJQUALU7zE0KReh6wjqyn3EsmYRBH/OV7uiNkxBLC0dRQlufjNxlOKqmeGGEb09y0TNTPe14EmgqGatmzK4QizGZ+Xc7paqCniRMqlcnzhI6czV792GAAbF0+jdznNFNbrozrO1pFoV1HbWheMHmdItLeOOAJOFxLHddcIW76FKdjUT/DkdaTLSYu7CpfkSMHDs5m6cWtAVwTAIYLSdoCNcj9T+2h2FBkijUQ1ljG4EQqTZJvjiVvY6CrjGiXGi/HV5wCR9OhA0jG17nlzVbxRft8MiW8PZqEt9GujIrFthkujoyKLof2a1gyNgw==
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com (2603:10a6:102:f6::14)
 by PA4PR07MB8597.eurprd07.prod.outlook.com (2603:10a6:102:26e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:42:20 +0000
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8]) by PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8%3]) with mapi id 15.21.0472.015; Thu, 15 Oct 2026
 14:42:20 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 0/6] net/memif: lifecycle fixes and unit test
Thread-Topic: [PATCH 0/6] net/memif: lifecycle fixes and unit test
Thread-Index: AQHdW7w5nVObconBhEq0kAPEqDMyX7b97bGAgADA/DA=
Date: Thu, 15 Oct 2026 14:42:20 +0000
Message-ID: <PA4PR07MB7280B8238B90003EB47A5B1A909C2@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
 <20261014200925.6c35e94a@phoenix.local>
In-Reply-To: <20261014200925.6c35e94a@phoenix.local>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7280:EE_|PA4PR07MB8597:EE_
x-ms-office365-filtering-correlation-id: 5e2726fd-cf66-44c9-cc58-08df2aca8457
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003;
x-microsoft-antispam-message-info: qH50JOgIXZHXqYaSXT2nBlyfPDyaznV3MRS9kcN20QmEhtBkf+wcbAwELP7GqvSK64Qu1gh2m8bVdrIEkVPr07u+3+odRTHZWjNvUdBK2ux8q8CH0LdUmYb0XP+5/kgz7XmqzEZcr43iVlByF+Wz2c3dWnmzvr8bCoFkMXe8ZmWNaB2EOVSpweQOsf/A0Epnnr1V+CDgAfXJRLuBfkR2DdaP7a1kDXy5BiYnTx4DYVqXauPxdw44CyuE4P0iYjuREjY5WBYnOx9KGzToxcHE7QxXFHh53ddNjcqJs1KRBjqZ6zPNTWwatXn6eUQ3Rw5YvFPHogQ2/AFVZtCyE0P5d+CdSS6q79TfXEW+R9GaOfsWp5HahkXOTGHM4HapsUlZyDEolQJAhC9lkGQkVHPzahQNHDPk9i46tbdH6FNhb3MPrJnHVNVm+Ftb4z9n6kJyAXjqZOo0wHZpdRUMnurqAcxfNZSvQALF7EJkcEQznOo9Izb6DI68ijMkuIRy8hwp+JEbPowXDh0edgc789UbcyLUmGSeqsJ7j28pPo3TyFr29pkznCeUNp+eqY54uk7BvrDVuSaxwMrZAapUmj68q7pLFBkCpBMRa7LVTUZ8mL/CVy5zL/vztGcgZpN/W5xP8a0br5d2bjqFgOPHk9D3lk9Ah+WRrHawdWm6NzvQ4PTTcqtniiW78QOi8W6qlwmngvT8eMnFiInXUmAZXU8ax2If6RRjHYDmivoxO0pUC2k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7280.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDBvakExb1cyMzBSS0ZwREU1VjVwRmRGQ3FhMC85aUJjZzFXUXNWYkdDZkdJ?=
 =?utf-8?B?MXJ5cTl1NEY3bGVRT2QvZy9YUGRCZCtuZGpsTSs4b0dTaU84WmE1R1BCZ1R2?=
 =?utf-8?B?MFI2RDE2T3ZGemVCOUZHM2xxek1MZURBVU43WlNtdXdEMmZCMGM4U2t2SUxY?=
 =?utf-8?B?VncrUU1BaklSdEJqOEhiZWNrWHJoMWs5bEN3amQyd2lYbGZ0Q29obUtvaXc0?=
 =?utf-8?B?aXZhVUowV01sT2NyVE5POXVGWDJyMlA0ZjBjVnpJV0EvN0Z6NjU0L0JUMEg1?=
 =?utf-8?B?Mm00WGtlcEJjSXFlVzJROVZNMy96U2xsWUUwcDhpWnd2RWx4d29RaXNTQUF5?=
 =?utf-8?B?SFZuZVV6QnpweGc0RGdYTVpoQVJxZWtiMzUzR0pkZU5uVG1uaFFjdVV4Y3A5?=
 =?utf-8?B?VFdiZFlIV2dqZDMwNmZYV2hDelQvaGpmTy8vY2dzbWRucTc0T3hmYmNtRGZ5?=
 =?utf-8?B?N3hKK0RtTDdPWFhsMElzQm9nejhWazlyaU51WUtKc2JobjBnOUxZbmg5VFBQ?=
 =?utf-8?B?dy9XTmhZYVpSemhrZThKeGJOaWY2L0VRaENYYnd0VkwvaVd1N0IwOENUb2xs?=
 =?utf-8?B?R1hSdUIyOTZmMHYxWi9zMlhOMVRNMFhzYnUyMTJzbE1RUjJla2VXbnpSVksx?=
 =?utf-8?B?KzY0REN4NUJaazM5SWtDVUY4T3VST2RLNVhxRklDL2ZqT3NVeElJTDFTMWhF?=
 =?utf-8?B?am9aRnlKZHArTXllczRXdklrS3VlLzJPdnVkcWNPazU1RURGNVVYclZPeXox?=
 =?utf-8?B?YXVJZFF5RjFqUUREUEhmdGFmZy95a09mRkFaMXRsTkY5RlNHVjFDYkw5S044?=
 =?utf-8?B?cHE0NExpeDVidkx4Zm1na2ZGOWI3SjdvZnIvTERyOTk2MU52eXA4VXltY2tH?=
 =?utf-8?B?dFBiWXlUM3ZiVVl4RE1TbDdHZVE1aktBTU9GeVBLVGNpVVlqKzRobE1EZGZs?=
 =?utf-8?B?dXBKZ2dzMHF3QWRJVm5hMlQ5N3RzNFdocDE5Rm5qOTBKU3JnWTNRbFVvTmk0?=
 =?utf-8?B?MzB5emx0MEZIRVNQV21zZW9VTEJiRkJvSk91NXZrd1FMMnFJSDVXVzJDNFky?=
 =?utf-8?B?b2Nadm5xR2FkYTlWWURVRXdTbDMrZWQ4d2Q3TlNocG1MY2t5U3BHSXhxOWpI?=
 =?utf-8?B?anRSMDE5Zm0zYTRrMUJQWDAvdDF6aElqREkwSms5WktWdGhvUUg1Z3ZoUSsr?=
 =?utf-8?B?K3hSYzJwQmNZT3h4L3B0VlV6RVdyNWNPem03YlU0ZFdvMlIvQWdoT0ovMUFn?=
 =?utf-8?B?cFYwdUJRYWh6NTNYQVhGR1ROYWdBMFZPa1g5TTV6V3JlWWtidE5nME1mUkRQ?=
 =?utf-8?B?ZWpQT0lGVHZMWDdaUzYwQXRsamtlSy9lQTIzaHp2d2paS0pHUGh3U0pUVjdk?=
 =?utf-8?B?QmNqV3ZwdUVyWmJPamF1WFEvSDhTS2VsN3A1d1lML1B0UWllN3BMdEdMY1o1?=
 =?utf-8?B?R3liLzBzOU16VjdZUnVWUEJOZ2VKRmIzMlBkYUpYWXova214MGFzbFNtNmZq?=
 =?utf-8?B?ZkRSdUR0di9PNm03MlNGaWtMN0hVYk9PZlpjVUlvTTE0WjhrR0hyejBTOWQx?=
 =?utf-8?B?eVpCbzE4bWpTNFdiWVUzYkJEWGhDam56NlA2SjV3ejlaZEU3UGhHbGFqck04?=
 =?utf-8?B?SnR5OXRwbzhJa0huTSt4TnFXaWl4RHczbjZzR2oxTk1VRHJHVkExeEVESjlz?=
 =?utf-8?B?bm51Nk5Idkh0VmhleTlnYVgrQzR0QzdlZGp2akNaUno4M01NUXI5Y3dSZFZk?=
 =?utf-8?B?Y3g5Vkk3U01rK0lCU3pQdTVQeHBuU25oWnFwT0lCc3A3MkRnMmIrTFl2dUt0?=
 =?utf-8?B?UzMwLzcrTVVDWFBEdWlkUDV1YXpBL2RzNUZXWVRwdGRESGUyanFPNGhFZk9Y?=
 =?utf-8?B?RUwwZDRyeWdCamJZUEVaOGZWbndpRlVFbWVtNFVlKzd0NFVwQkJ2dCtNOE56?=
 =?utf-8?B?Ris1c3cvbUlQdTJQV3llQzRqOFVOK3VaejRXZm9sTU5qMElwYXhCV0gvaG1a?=
 =?utf-8?B?N24rOTNrYlVQMUhBUGU0bXBTR1pMUXlrWkFpRWFjNVdKQUpRbGtzc2NQb2tt?=
 =?utf-8?B?RmRCYVFjcWhRcUVWOWZjMjYwNVRVdDNPNTlEOHhocVNVd3lBaVhiZUFYTDJF?=
 =?utf-8?B?WjlHTm0wczNwbmJ0c0l2UWFoVkpTTHMrOTFxZmJoSDJrdFZUNEl0OVhvSk1P?=
 =?utf-8?B?c0dnUjVtMDBmb2Q2RFBHWmtyNkJ5L1FFZHlmbnp0a1pOOWtTRFdMT1RWRTdO?=
 =?utf-8?B?RHA0dVlTa0I0N1hxK2pmYnlFL1NZTkVmeG54SDVoUEMrb3F5MDdYZnRxY2wx?=
 =?utf-8?B?VXVuSWJrQXJEUjg2SlV4K29XOWd3V2pRYUk5QUsyOEVsYTJtb2YxcWJONXEz?=
 =?utf-8?Q?Np/QbuRfHEq22Qac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7280.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2726fd-cf66-44c9-cc58-08df2aca8457
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 14:42:20.1874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FGLsox3IQ1WDAW1e1riuJElwFH6fXpmHNTtbCWlJvQIq0zP/VRwY5qlvNb2hUbU0LgocqjL+VPahR2fPqKOJ+skDAY79GhdwUpI3tyA/DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8597
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8
c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCAxNSBPY3RvYmVy
IDIwMjYgMDU6MDkNCj4gVG86IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBl
cmljc3Nvbi5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7IEpha3ViIEdyYWpjaWFyIDxqZ3JhamNp
YUBjaXNjby5jb20+OyBzdGFibGVAZHBkay5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzZd
IG5ldC9tZW1pZjogbGlmZWN5Y2xlIGZpeGVzIGFuZCB1bml0IHRlc3QNCj4gDQo+IE9uIFdlZCwg
MTQgT2N0IDIwMjYgMTE6MTI6NTEgKzAyMDANCj4gU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55
YWduYXJhbWFuQGVyaWNzc29uLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoaXMgc2VyaWVzIGZpeGVz
IGEgc2V0IG9mIGVycm9yLXBhdGggYW5kIGxpZmVjeWNsZSBidWdzIGluIHRoZSBtZW1pZg0KPiA+
IFBNRCBhbmQgYWRkcyBhIHVuaXQgdGVzdCBmb3IgdGhlIGRyaXZlci4NCj4gPg0KPiA+IFRoZSBm
aXJzdCBmaXZlIHBhdGNoZXMgYXJlIGZpeGVzOg0KPiA+DQo+ID4gIC0gZ3VhcmQgZXRoX21lbWlm
X3R4KCkgYWdhaW5zdCBhbiBlbXB0eSBidXJzdCBzbyBhIHplcm8tY291bnQgY2FsbA0KPiA+ICAg
IHJldHVybnMgYmVmb3JlIHRvdWNoaW5nIHRoZSBidXJzdCBvciB0aGUgcmluZzsNCj4gPiAgLSBj
bG9zZSBmaWxlIGRlc2NyaXB0b3IgMCBpbnN0ZWFkIG9mIGxlYWtpbmcgaXQgKHRoZSBjbG9zZSBw
YXRoDQo+ID4gICAgdGVzdGVkIGZvciBmZCA+IDAgaW5zdGVhZCBvZiBmZCA+PSAwKTsNCj4gPiAg
LSBmcmVlIHRoZSBNQUMgYWRkcmVzcyBhbGxvY2F0ZWQgZHVyaW5nIHByb2JlIHdoZW4gYSBsYXRl
ciBzdGVwDQo+ID4gICAgZmFpbHMsIGluc3RlYWQgb2YgbGVha2luZyBpdDsNCj4gPiAgLSB1bndp
bmQgYSBwYXJ0aWFsbHktY3JlYXRlZCBkZXZpY2Ugb24gZmFpbHVyZSBpbiBtZW1pZl9jcmVhdGUo
KSwNCj4gPiAgICByZWxlYXNpbmcgdGhlIHBvcnQgYW5kIHRoZSBwcm9jZXNzLXByaXZhdGUgZGF0
YSByYXRoZXIgdGhhbg0KPiA+ICAgIHJldHVybmluZyB3aXRoIHRoZW0gcmVnaXN0ZXJlZCBhbmQg
bGVha2VkOw0KPiA+ICAtIGRpc2Nvbm5lY3QgdGhlIGRldmljZSBvbiBjbG9zZSBzbyBxdWV1ZXMg
YW5kIHNoYXJlZCByZWdpb25zIGFyZQ0KPiA+ICAgIHRvcm4gZG93biwgYW5kIG1ha2UgbWVtaWZf
ZGlzY29ubmVjdCgpIHNhZmUgdG8gY2FsbCBvbiBhIGRldmljZQ0KPiA+ICAgIHRoYXQgd2FzIGNv
bmZpZ3VyZWQgYnV0IG5ldmVyIHN0YXJ0ZWQuDQo+ID4NCj4gPiBUaGUgbGFzdCBwYXRjaCBhZGRz
IGEgbWVtaWYgUE1EIHVuaXQgdGVzdCAoYXBwL3Rlc3QsDQo+ID4gbWVtaWZfcG1kX2F1dG90ZXN0
KSB0aGF0IHN0YW5kcyB1cCBhIHNlcnZlci9jbGllbnQgdmRldiBwYWlyIG92ZXIgYQ0KPiA+IGxv
b3BiYWNrIHNvY2tldCBhbmQgY292ZXJzIGRldl9pbmZvLCBsaW5rIHN0YXRlLCBzdGF0cywgc2lu
Z2xlLSBhbmQNCj4gPiBtdWx0aS1zZWdtZW50IGxvb3BiYWNrLCBzdG9wL3N0YXJ0IHJlY29ubmVj
dCwgZW1wdHkgVHggYnVyc3QsIGFuZCBjbG9zZQ0KPiB3aXRob3V0IHN0b3AuDQo+ID4NCj4gPiBW
ZXJpZmllZDogbWVtaWZfcG1kX2F1dG90ZXN0IHBhc3NlcyA5Lzk7IGNoZWNrLWdpdC1sb2cgYW5k
IGNoZWNrcGF0Y2gNCj4gPiBhcmUgY2xlYW4gYWNyb3NzIHRoZSBzZXJpZXMuDQo+IA0KPiANCj4g
QWZ0ZXIgd2Fsa2luZyB0aHJvdWdoIGNvZGUgd2hlbiB1c2luZyBib25kaW5nIGV0Yywgc29tZXRp
bWVzIGFwcHMgc2VuZCAwDQo+IHBhY2tldHMgYXMga2VlcGFsaXZlIHRpbWUgY2FsbC4NCj4gDQo+
IEFJIGRpZCBmaW5kIHNvbWUgb3RoZXIgdGhpbmdzIHRvIGFkZHJlc3MuLg0KPiANCj4gU2VyaWVz
IGFwcGxpZXMgY2xlYW5seSB0byBtYWluICgyYTU4ZjZlKSBhbmQgYnVpbGRzIGF0IGV2ZXJ5IGNv
bW1pdCB3aXRoIC0NCj4gRHdlcnJvcj10cnVlLiBOb3QgcnVuLiBObyBlcnJvcnM7IHdhcm5pbmdz
IGJlbG93LCBzbyBubyBSZXZpZXdlZC1ieSB5ZXQuDQo+IA0KPiANCg0KVGhhbmtzIGEgbG90IGZv
ciB0aGUgcmV2aWV3LCBzZW50IHYyIG5vdyB3aXRoIGZpeGVzLg0KdjIgaW5jbHVkZXMgYWRkaXRp
b25hbCBwYXRjaGVzIGZvciAiRUFMLW93bmVkIG1lbXNlZyBmaWxlIGNsb3NpbmciIGFuZCAiYm9n
dXMgVHggY291bnQgb24gaW52YWxpZCBpbnRlcnJ1cHQgRkQiLg0KIA0K
