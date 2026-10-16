Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DFDCCF2C6
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 20:00:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC5DC402E7;
	Fri, 16 Oct 2026 21:59:22 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
 by mails.dpdk.org (Postfix) with ESMTP id 83D3B40291;
 Fri, 16 Oct 2026 21:59:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf4SzcMGKsNXZEEBhwq5dQEMnv8/ye384J7e22cBZgbxZ+u1E0GHYOZhhpTch+xluZ2cHnGdpKjCK0xfb5qdpYRpJCCvwbqYcRQfbn+oLTlw4rRpd2G/vsZ1tVPbxMqQ1PZFIc4whXXUP+00ZMD0Q835Z3lTVPrHwi5iyTTGlzt1kO2Sv4cyPxTuZwDTZTkP4KeJO9ISzLXLdW5mK46eblBQ3JzNoz7si64vmBFKIs7Zd13R+Lby3uOL7O8h6xHUkJWtPy5I2TzxEGZZf0yDlrZ5xK2A+ayela5Zc5rx+VW2WOJ40pe3ZyehDEMkFaBHIl54/9qfUxndzuPmbUQTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WF4j/w6loFnJCYkv7U5r3DgqwfXirI9SgwGzbCR9V0=;
 b=UwGLWqL80MdTXtzJmd/FAXNnzMclsY0TPUph6B5FCxrq0F5XRTlbqHP736DG1RX3nxFwr6yWDrryKmIczq0Zt2ovDIrM2vQOTDCAtpd9CyGiNu7cFPj0rWnP7t4QhfHFj3UQNOuhHdJsMRr6S3EiDnIj6b1eJ0k7sDRzob7Kg32QPZ5LUbyTahigWb23me9Vg787qQlx3XJz10gbpOaBJgD6X6h58MOdZUBNtjO3/+M2zuf9K0RkLfqh5tJGuty/AwjjibR89+jQmQtxpUZ2uwrCmM5GoVtVDEOjsUT8uG7+zvJJRVE+wMib2HfdkAn4Z1GNWYKwFcSfBmpQHRY3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WF4j/w6loFnJCYkv7U5r3DgqwfXirI9SgwGzbCR9V0=;
 b=Vc92Qx9j6HAuMZTK/zclRgy6xSoSc84bbJUOuDSIjjNGKIwGznw9Xg07KrD4BssOZVbiEsEzhpUOwYaWioeukNlyHzHeKCwecHEK+6s6tJeaYaYy7mzypc3FFcwYAbvhUy9r/ecvIvEJPUhm7ITkDENvEmWhb64pSYONMfyifDq11CRelYMHZMaZ/QeZG0AYjT6DQqv6VkFEaidk5QApYjEckM83wDqCtxbAqJ4de9ThDjNOoht8AWnuGHlZhMZZhelJQhtHBZTkpprm4KOTNpcyt0N+8/FJw3aiGPCUgOVtanWUfm4qS7BCjW+AimVgerBPDG1Pew18BiTCbAMIbQ==
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com (2603:10a6:102:f6::14)
 by PR3PR07MB6700.eurprd07.prod.outlook.com (2603:10a6:102:6d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 19:59:20 +0000
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8]) by PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8%3]) with mapi id 15.21.0472.015; Fri, 16 Oct 2026
 19:59:19 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3 0/9] net/memif: lifecycle fixes and unit test
Thread-Topic: [PATCH v3 0/9] net/memif: lifecycle fixes and unit test
Thread-Index: AQHdXXji1XvzcJ7H4UmRIXmnNVrDa7cAZh6AgAAwJQA=
Date: Fri, 16 Oct 2026 19:59:19 +0000
Message-ID: <PA4PR07MB7280323716DFEA6907777721909B2@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
 <20261016100523.74067d8a@phoenix.local>
In-Reply-To: <20261016100523.74067d8a@phoenix.local>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7280:EE_|PR3PR07MB6700:EE_
x-ms-office365-filtering-correlation-id: 20ee6b5e-ebc0-49c0-3526-08df2bbff768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|4143699003|56012099006|38070700021|11063799006|261009223027099003|22082099003|10067099003|18002099003|6133799003|10063799003;
x-microsoft-antispam-message-info: 6DbmK8a0nFF9thAR2xPMZt18m77pZzheQisjM11Uw7Z3bJTEHWToX5dAxnPd8k3vSPSdDl25vmMYYpTL9a+Rls4hK11kJSJWK7b7qEu0XSuumTF2AEkW96zT9FZGzKpE093dMSdw6lu1odcJQmTD3wBRganGkpuNWog3kCabH5ttmwBB6CktiFhaSUnCWPv3qyb7lKGcJi2XPSMjRx3vSuB1MCFHpceMCmeE/MsXRlBqNaXM2Msk5VjWyGJEnNRWO5sAXGjhsP/i1xcMzqdfOp6IDipLaHRa/VDCicrAz1WaNGzfiQqcIRxq4LYgvo6s9nv/irmIY4PpUxlb1l2dnab9x7j0tfzL0pj5dc4eNo/xAQeJ0ioSV2uZKdlxH45go7S1jXBxP8beGfc8DaAYhihq9MqPjWISpRA/2V3c70mmFxOwm0AOZ4ZPbYcLPSR11/3FmlL2Ubpcm7wne4JBFN/QHDhzvCw9KsCYV42GeoQFoubkMk26r1TVMh1P7thO2Kb0+l4YtzYfHhg/1tqIPSuexagbE6U0/96sBGfsl7rdhxjzqtM+LiVf/sylmfr/fXwinFtzTpU8xhNb6S4LZbnLtmrIq2FuARqwAMZen66L8qXZejqcmykfKJNiY55ks2yMNQtAJYU38P2Bf3n0qM7epXz9xHjV4z5zv+XuWAdxn/CvAeulGuNxbEqc9UpVdiFgofa1aLQ2fDyMETtjqOU3jyAEgVNvUPZETGkn5qg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7280.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(38070700021)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003)(10063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sml0MXFzRitPLzBTdkhYSTR0UUFQbTQ5bVdXQXN6MkgrbmZwYU8rWEhadGNl?=
 =?utf-8?B?aHlJaU5wTGtQMmp4d2oyUlpzbGg2YURLVWpUb1luR0hyeGFzdUw2V3h5SWtD?=
 =?utf-8?B?YXJFRi95TzEwajdXU2NhTk12YWRpUzhNa2w3QmdWVGpSRTBlR1QyN09vU3ZX?=
 =?utf-8?B?L3ViODAxK2lDeTBkM2YwWmUzSy9HVUhPaXZIbGtHUjV6dUJmVXFGVllaUzNp?=
 =?utf-8?B?YkdUYWxsTDRvcDJKZE5EOThlU2NuSXljMko4M2tiVGo2ZHdWZ3dXSU1oYWFQ?=
 =?utf-8?B?c3FIa3BlODVqMzNIYklSeUdzbTZnc3lOcjZqNGdENzVxV0g0QWF1aWhtTWpn?=
 =?utf-8?B?YkFteG50ZjNnbC9lUExQdjMrMHF1YzgvUlFlM0dyYy9CSy9qRzVBOFhFMFha?=
 =?utf-8?B?UmZlKzVEbkNFWm9UVHdaOE5QeDFVaDIya3MwMWZuSjBiaEhZNk5rTVpkY1pn?=
 =?utf-8?B?aGVqWmZ2Mm5zNmJpL0lScUlhUDFYeERvODNTSEl0TlE1ZHhiNVh0dnRzcTJF?=
 =?utf-8?B?bzVKZEptQ0xuNCswZHhqVlhGRWtRS2ViYjZBTjh1V2N6WFJGa3c5K0l1bFI3?=
 =?utf-8?B?QjA4enprdmZFTm9ZbmNyQi91MWNRK1NSRm9pQjBzL0pxd0ZzVks3VnpSZGZB?=
 =?utf-8?B?dGdPcHc0MnNITTVwTlhkOWZ1aXE4QWVZYlFtREE2Nlc5bEluK0hoVXRrNERi?=
 =?utf-8?B?L2xPUkZsbDFkVmJGZW1XVnc2b1N0aG93dXgzY212Rmx6a0JscGFIT3BHT3J6?=
 =?utf-8?B?ZDhtTUxOaW03S0g1bWlSQTNIZ2xHb2phTnBYVGo4MVZJTTZPTEFNN1Z0dlkz?=
 =?utf-8?B?QVdrMUpoN3Yva1ROemFrZzUrVXpOUVZ6cDcyQ0FzbDh4WW5tRllGZXpPSGJH?=
 =?utf-8?B?NVRnSmJUZDQveTEzeUlUM3g1S1lBMnRnakhoRHZzODFHODh5cSt0NGZTZHFK?=
 =?utf-8?B?azh4b3BSVktDaE9MR0YwY25XaEZJK0RYSjVxZDBGTndpaXEzT3JJelQ5K1BM?=
 =?utf-8?B?ajNGOEFoL3BIVytPTTFTTG8rQmpTRkMzUSszenE5Y2s4ZmcvV2piRjFHTlF4?=
 =?utf-8?B?b3FndkhYc1ovZ2g2Z1VoV0ZxWmp6NXc4VDBvbkJvejMxWFVUVDY5VEF3SFUz?=
 =?utf-8?B?ZU9kdmp3TTVmMVlrb3hMbFlnU2dJb3l3V3EydlNJTHdBYzlxKzdBaTJGeHcz?=
 =?utf-8?B?T2VsdHUxUGdBbDd2dXkxQkRLWkRsdkkxa3Y3QytsRUE1SjJGQmgyK1FKcDN1?=
 =?utf-8?B?VGRxR05hYVBEZm5DQURFT3R4cHFBdmZpOHpFSEQzL08vOFJIK0dFdVZndzZY?=
 =?utf-8?B?TzFUV1VjQTJ1QlpnL1dpSnFOQVVBZ1YrNlVVcWVSMmRIUDZLeEVmNkx6elpZ?=
 =?utf-8?B?c09hck1pbERiMWF2a3h1ZmV3RmdPM2VNdzdUbkU0MldxNGpuS1p5eHM3TEda?=
 =?utf-8?B?TUZ3ajA4SkY5eVZraU9yRk5FeUdKSU0vVGxjS0JzTm5GRy9kLzVIN09PZU1S?=
 =?utf-8?B?dlhsdmdva1M3dUxwQmgzdHBidTM0TVFHWVJLS3dodzdFT0ZmQWlDNXJDNkdW?=
 =?utf-8?B?RnhvUlI4ckVUM0ZRa2xaNTVINDhFYjkrK0cwL0VEdG84cEljVlU4YmVqMTcr?=
 =?utf-8?B?V2VCdEtGSUF5MnkyS1lSaDNKMC9jOHRzNkc2akNTLzVWY0QyanpGTkZ2elJR?=
 =?utf-8?B?bFB6cEZhRWF2emN3dEpXM3NWSWRJVk5qeWpMNVJrNE9CVjREdGsrRWZpTU8z?=
 =?utf-8?B?ZFE0R2swc0dqN3JFNTN0T0pXaFdoWi8zVTNmM1FhVHVRZi8wZnVPTXRocE85?=
 =?utf-8?B?dkpMcDRwcXlzZnorNjZMVTUzdVJiVUxjREpGdzdsdFVzTnd6dHRreWZhRmNl?=
 =?utf-8?B?RE95Mjg5bjRtWjNUWUFuUlc3NEJwWGlSNk91MEtIK3FHYTMwbHNsM1Vzd1Ux?=
 =?utf-8?B?Nkdka3lKLzVpTnlaUzhJWWdlRk9PeW1OTHJxTGQ4YzVxMTM4NzV3elhOWnhp?=
 =?utf-8?B?YkE2YXVSY2hwb0VnYjJOVUpVamw0MDFTNHNUMEpCVVV5QjgvOC9IUW9STmoz?=
 =?utf-8?B?NnVXWml5aVdzWmo2bTluV0k1UHZWZXBsRGhsb3BtRlZJb2h4T3Z6aW1aRWJE?=
 =?utf-8?B?Kzk5bWJQdThzQ3FJOXpLT083OW9YZFlma1F3MnpPT3VicThSc2ZhSk1GMTFn?=
 =?utf-8?B?VEVJaWozcEkyR253bnlNcWVsc2ZXODFIUlFFY1J0RWlQZCtZYWxhS3RzbVVl?=
 =?utf-8?B?N1BISVg1RHp0TlIwOXlzUHJiMktrcFlGQndtRmNHbEFycFlTWi9KNTVaWGY0?=
 =?utf-8?B?VmxmOGZwcmFIajBIMkQzYnZFZWNkYkxKa0RPUFBXSWZhTC84REhHVmNsSG5M?=
 =?utf-8?Q?4JL37JibdWipRK6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7280.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ee6b5e-ebc0-49c0-3526-08df2bbff768
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 19:59:19.8927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfzJK3R9NiKvR5k4AAippl9EK8TGuk7FHSWTmINsCWy+NzRATF+gahX0m1aG7qVVlILSXWO6+gahGwfbzHhHSE5zWBE89oJmSDFjiEEmfTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6700
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
c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgMTYgT2N0b2JlciAy
MDI2IDE5OjA1DQo+IFRvOiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXJp
Y3Nzb24uY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBKYWt1YiBHcmFqY2lhciA8amdyYWpjaWFA
Y2lzY28uY29tPjsgc3RhYmxlQGRwZGsub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC85
XSBuZXQvbWVtaWY6IGxpZmVjeWNsZSBmaXhlcyBhbmQgdW5pdCB0ZXN0DQo+IA0KPiBPbiBGcmks
IDE2IE9jdCAyMDI2IDE2OjE1OjQ4ICswMjAwDQo+IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0u
eWFnbmFyYW1hbkBlcmljc3Nvbi5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGlzIHNlcmllcyBmaXhl
cyBhIHNldCBvZiBlcnJvci1wYXRoIGFuZCBsaWZlY3ljbGUgYnVncyBpbiB0aGUgbWVtaWYNCj4g
PiBQTUQgYW5kIGFkZHMgYSB1bml0IHRlc3QgZm9yIHRoZSBkcml2ZXIuDQo+ID4NCj4gPiBUaGUg
Zmlyc3QgZWlnaHQgcGF0Y2hlcyBhcmUgZml4ZXM6DQo+ID4NCj4gPiAgLSBndWFyZCBldGhfbWVt
aWZfdHgoKSBhZ2FpbnN0IGFuIGVtcHR5IGJ1cnN0IChuYl9wa3RzID09IDApOw0KPiA+ICAtIGNs
b3NlIGZpbGUgZGVzY3JpcHRvciAwIGluc3RlYWQgb2YgbGVha2luZyBpdDsNCj4gPiAgLSBkbyBu
b3QgY2xvc2UgdGhlIEVBTC1vd25lZCBtZW1zZWcgZmQgaW4gemVyby1jb3B5IG1vZGU7DQo+ID4g
IC0gZnJlZSB0aGUgTUFDIGFkZHJlc3MgYWxsb2NhdGVkIGR1cmluZyBwcm9iZSBvbiBmYWlsdXJl
Ow0KPiA+ICAtIHVud2luZCBhIHBhcnRpYWxseS1jcmVhdGVkIGRldmljZSBvbiBjcmVhdGUgZmFp
bHVyZTsNCj4gPiAgLSByZWZ1c2UgY29ubmVjdGlvbnMgb24gYSBzdG9wcGVkIHNlcnZlciBzbyBp
dCBkb2VzIG5vdCBjb21lIHVwIG9uIGENCj4gPiAgICBzdG9wcGVkIHBvcnQ7DQo+ID4gIC0gZGlz
Y29ubmVjdCBvbiBjbG9zZSBzbyBhIHN0b3BwZWQgc2VydmVyJ3MgY29udHJvbCBjaGFubmVsIGlz
IG5vdA0KPiA+ICAgIGxlYWtlZCwgYW5kIG1ha2UgbWVtaWZfZGlzY29ubmVjdCgpIHNhZmUgb24g
YSBuZXZlci1zdGFydGVkIGRldmljZTsNCj4gPiAgLSBmaXggZXRoX21lbWlmX3R4X3pjKCkgcmV0
dXJuaW5nIDY1NTM1IG9uIGFuIGludmFsaWQgaW50ZXJydXB0IGZkLg0KPiA+DQo+ID4gVGhlIGxh
c3QgcGF0Y2ggYWRkcyBhIG1lbWlmIFBNRCB1bml0IHRlc3QgKGFwcC90ZXN0LA0KPiBtZW1pZl9w
bWRfYXV0b3Rlc3QpOg0KPiA+IGEgc2VydmVyL2NsaWVudCB2ZGV2IHBhaXIgb3ZlciBhIGxvb3Bi
YWNrIHNvY2tldCBjb3ZlcmluZyBkZXZfaW5mbywNCj4gPiBsaW5rIHN0YXRlLCBzdGF0cywgc2lu
Z2xlLXNlZ21lbnQgbG9vcGJhY2sgKHNsb3cgYW5kIGZhc3QgcGF0aCksDQo+ID4gbXVsdGktc2Vn
bWVudCBsb29wYmFjayBhY3Jvc3MgYSByaW5nIHdyYXAsIHN0b3Avc3RhcnQgcmVjb25uZWN0LCBl
bXB0eQ0KPiA+IFR4IGJ1cnN0LCBjbG9zZSB3aXRob3V0IHN0b3AsIGFuZCBhIHN0b3BwZWQgc2Vy
dmVyIHJlZnVzaW5nIGEgcGVlci4NCj4gPg0KPiA+IFZlcmlmaWVkOiBtZW1pZl9wbWRfYXV0b3Rl
c3QgcGFzc2VzIDExLzExOyBlYWNoIGNvbW1pdCBidWlsZHMgd2l0aA0KPiA+IC1Ed2Vycm9yPXRy
dWU7IGNoZWNrLWdpdC1sb2cgYW5kIGNoZWNrcGF0Y2ggYXJlIGNsZWFuLg0KPiA+DQo+ID4gVGhh
bmtzIHRvIFN0ZXBoZW4gSGVtbWluZ2VyIGFuZCB0aGUgYWktY29kZS1yZXZpZXcgYm90IGZvciB0
aGUgcmV2aWV3cw0KPiA+IHRoYXQgc2hhcGVkIHRoaXMgc2VyaWVzLg0KPiA+DQo+ID4gdjM6DQo+
ID4gIC0gUmViYXNlIG9uIG1haW4sIHBpY2tpbmcgdXAgcnRlX2ludHJfZmRfY2xvc2UoKSBmcm9t
DQo+ID4gICAgZDkxOTFmNjg0YyAoImludGVycnVwdHM6IGFkZCBoZWxwZXJzIHRvIGNsb3NlIEZE
Iik6IHBhdGNoIDIga2VlcHMNCj4gPiAgICBvbmx5IHRoZSBvd25lZC1mZCAiPj0gMCIgZml4ZXMg
bm90IHN1cGVyc2VkZWQgYnkgdGhhdCBoZWxwZXIsIGFuZA0KPiA+ICAgIHBhdGNoIDcga2VlcHMg
dGhlIE5VTEwtcXVldWUgZ3VhcmRzIGFib3ZlIHRoZSBydGVfaW50cl9mZF9jbG9zZSgpDQo+ID4g
ICAgY2FsbHMuDQo+ID4gIC0gTmV3IHBhdGNoIDY6IHJlZnVzZSBjb25uZWN0aW9ucyBvbiBhIHN0
b3BwZWQgc2VydmVyLiBUaGUgc3RhcnRlZC0NCj4gPiAgICB0aGVuLXN0b3BwZWQgY2FzZSBpcyB0
aGUgYWN0dWFsIHRyaWdnZXIgZm9yIHRoZSBjb250cm9sLWNoYW5uZWwNCj4gPiAgICBsZWFrOyBk
ZXZfc3RvcCBub3cgc2V0cyBFVEhfTUVNSUZfRkxBR19ESVNBQkxFRC4gKHYyIHBhdGNoIDYvNw0K
PiA+ICAgIGRlc2NyaWJlZCB0aGlzIGFzIG5ldmVyLXN0YXJ0ZWQsIHdoaWNoIHdhcyB3cm9uZy4p
DQo+ID4gIC0gUGF0Y2ggNyAoZGlzY29ubmVjdCBvbiBjbG9zZSk6IHJld29yZCB0byB0aGUgcmVh
bCB0cmlnZ2VyIGFuZCBrZWVwDQo+ID4gICAgdGhlIGNsb3NlLXRpbWUgZGlzY29ubmVjdCBhcyBh
IGJhY2tzdG9wLg0KPiA+ICAtIFBhdGNoIDMgKG1lbXNlZyBmZCk6IGFsc28gc3RvcCBjbG9zaW5n
IHRoZSBFQUwtb3duZWQgZmQgaW4NCj4gPiAgICBtZW1pZl9jb25uZWN0KCksIG5vdCBvbmx5IG1l
bWlmX2ZyZWVfcmVnaW9ucygpLg0KPiA+ICAtIFRlc3Q6IG5ldyB0ZXN0X21lbWlmX3N0b3BwZWRf
c2VydmVyX3JlamVjdHNfcGVlciBjb3ZlcmluZyBwYXRjaCA2DQo+ID4gICAgKGZhaWxzIHdpdGhv
dXQgaXQpOyByZXdvcmQgY2xvc2Utd2l0aG91dC1zdG9wIHRvIHdoYXQgaXQgYWN0dWFsbHkNCj4g
PiAgICBjb3ZlcnMgKHRoZSBOVUxMLXF1ZXVlIHNraXApOyB2ZXJpZnkgdGhlIGZ1bGwgZmFzdC1w
YXRoIHBheWxvYWQuDQo+ID4NCj4gPiB2MjoNCj4gPiAgLSBQMTogY29ycmVjdCBGaXhlcyB0YWcg
KFR4IGZhc3QgcGF0aCwgbm90IG9yaWdpbmFsIGRyaXZlcik7IG1vdmUgdGhlDQo+ID4gICAgZW1w
dHktYnVyc3QgY2hlY2sgYWZ0ZXIgdGhlIHJpbmcgPT0gTlVMTCBibG9jay4NCj4gPiAgLSBQMjog
c3BsaXQgdGhlIG1lbXNlZy1mZCBjaGFuZ2UgaW50byBpdHMgb3duIHBhdGNoIHJhdGhlciB0aGFu
DQo+ID4gICAgd2lkZW5pbmcgdGhlIGNoZWNrIHRvICI+PSAwIi4NCj4gPiAgLSBQNCAoTUFDIGxl
YWspOiBkb2N1bWVudCB0aGUgc2Vjb25kYXJ5IC0xIC0+IC1FTk9NRU0gY2hhbmdlLg0KPiA+ICAt
IFA1ICh1bndpbmQpOiBhZGQgRml4ZXM6IG11bHRpLXByb2Nlc3Mgc3VwcG9ydC4NCj4gPiAgLSBO
ZXcgcGF0Y2g6IGZpeCBldGhfbWVtaWZfdHhfemMoKSBib2d1cyBUeCBjb3VudCBvbiBpbnZhbGlk
IGZkLg0KPiA+ICAtIFRlc3Q6IGFkZCB0byBNQUlOVEFJTkVSUzsgcmV0dXJuIFRFU1RfRkFJTEVE
IChub3QgU0tJUFBFRCkgb24gcHJvYmUNCj4gPiAgICBmYWlsdXJlOyBhZGQgYSBkZWZhdWx0LWJz
aXplIHBhaXIgdG8gY292ZXIgdGhlIFR4IGZhc3QgcGF0aDsgc2V0DQo+ID4gICAgcmluZyBzaXpl
IHZpYSByc2l6ZSBhbmQgZml4IHRoZSBzdGFsZSBjb21tZW50cy4NCj4gPg0KPiA+IFNyaXJhbSBZ
YWduYXJhbWFuICg5KToNCj4gPiAgIG5ldC9tZW1pZjogZ3VhcmQgYWdhaW5zdCBlbXB0eSBUeCBi
dXJzdA0KPiA+ICAgbmV0L21lbWlmOiBjbG9zZSBmaWxlIGRlc2NyaXB0b3IgemVybw0KPiA+ICAg
bmV0L21lbWlmOiBkbyBub3QgY2xvc2UgRUFMLW93bmVkIG1lbXNlZyBmaWxlIGRlc2NyaXB0b3IN
Cj4gPiAgIG5ldC9tZW1pZjogZml4IE1BQyBhZGRyZXNzIGxlYWsgb24gcHJvYmUgZmFpbHVyZQ0K
PiA+ICAgbmV0L21lbWlmOiB1bndpbmQgcGFydGlhbCBkZXZpY2Ugb24gY3JlYXRlIGZhaWx1cmUN
Cj4gPiAgIG5ldC9tZW1pZjogcmVmdXNlIGNvbm5lY3Rpb24gb24gc3RvcHBlZCBkZXZpY2UNCj4g
PiAgIG5ldC9tZW1pZjogZGlzY29ubmVjdCBvbiBkZXZpY2UgY2xvc2UNCj4gPiAgIG5ldC9tZW1p
ZjogZml4IGJvZ3VzIFR4IGNvdW50IG9uIGludmFsaWQgaW50ZXJydXB0IEZEDQo+ID4gICB0ZXN0
L21lbWlmOiBhZGQgbWVtaWYgUE1EIHVuaXQgdGVzdA0KPiA+DQo+ID4gIE1BSU5UQUlORVJTICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGFwcC90ZXN0L21lc29uLmJ1aWxkICAg
ICAgICAgICAgICB8ICAgMSArDQo+ID4gIGFwcC90ZXN0L3Rlc3RfcG1kX21lbWlmLmMgICAgICAg
ICB8IDc1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9uZXQv
bWVtaWYvbWVtaWZfc29ja2V0LmMgIHwgIDEwICstDQo+ID4gZHJpdmVycy9uZXQvbWVtaWYvcnRl
X2V0aF9tZW1pZi5jIHwgIDc2ICsrLQ0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDgxMiBpbnNlcnRp
b25zKCspLCAyNyBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0IGFwcC90ZXN0
L3Rlc3RfcG1kX21lbWlmLmMNCj4gPg0KPiANCj4gDQo+IFN0aWxsIHNlZSB3YXJuaW5ncyBmcm9t
IEFJDQo+IA0KDQpUaGFua3MgZm9yIHJldmlld2luZywgc2VudCB2NCB3aXRoIHRoZSB3YXJuaW5n
cyBmaXhlZCBub3cuIA0K
