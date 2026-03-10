Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B46FD4F2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 20:02:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B40384060A;
	Tue, 10 Mar 2026 21:02:52 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
 by mails.dpdk.org (Postfix) with ESMTP id 23FB3402DC
 for <dev@dpdk.org>; Tue, 10 Mar 2026 21:02:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDdFjWXQ8sAn3sooZ8w2xGa6yN6zzErRv9cFgi7AKw43JPAmvotyb0WxnCGPl4090D//ZD+rBdHvCjgkWQDOGHSipGrqN5zbjQZxSiiy/ckMogoAck2cYI/gRz3diQQBe4g21hGquzWOeOgXiarz1FEhfjzVTD9ki9X2MQX65E5/Kkf0DjLz55BROpdPs6yqOmyuaEaZyUrEdJk+bGAZlaAVybf6GtyJ8c3W+QpQl3szWXhUTuI+sCjcgwRzawcy+RFhKOO1vdhN4HdtjecZR+6ZB54f5KcH9ml4MTFfpir96oaAFyHSwGb3bUK8LXuDwUJBxcxHRnBf65qgQORmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59eeBfaxlKkMOMKmwTiZuXR9Aqd2nyqbbyI/Fu1PfXc=;
 b=mkR5MOKo1WIrfJAYKCjxFHhIHfJPj46SPh07G48sbrrf9k+ZmGd4hsD5UsXy2OnlipMvSbDX/gLnZyGClkNWt9vKGpbRHBenKWApLOsMSC271KGpU2XElq+iL9DlUJVF3Ws5wxeXP1BQL+2IgNWFuvx9GJkRuqBdEHsiTp8E4mco+pxOWXGRlW+1r3f3koZSB8TXc8Nl+MXaDeh2A5sgwYZx1cDMUjXvsfAUBOhclK8Bpl2oBdpqGubOb19t2lPjGF5Kr2wAmk1z3p7MHChYIhKVfSdMcITUMOQ3CLn9NLaN97Sd3sRhqwJ1xHlo1Syb9lshWDKwEy73LpBa1ghtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59eeBfaxlKkMOMKmwTiZuXR9Aqd2nyqbbyI/Fu1PfXc=;
 b=NfbUNlzQmmORdGZOllJYHWAXQuyxgiF8O6/3adsemgnruLM6BoKRa3Ige56qKqjF8a8RoU8PgSVkuYEwWUZPgdJ2+UVEF3GTjJsdaEXsl6Zwbz9X+6WHnlIidoaV7x2Wsr+KBCqRaY8t8eg0V6GF383R6f07pTiqgmnpuV3GmXk1LSh9mIxnsvPDxjzol95e3k0N2DHjJTQBtFpDakNaY7u0r+dwz8mR74kG4YaXEEGIvWh7xdKYqWNn2rUZwsgBgqANhx3Y4oHEQrWLeNxSbsovRWW4SriVLQLXtuR9mJ5g9+H7pRM9agv9Seczd9L8Di4xCyyEFcXxitiVPiRqSQ==
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com (2603:10a6:102:f6::14)
 by DBAPR07MB6837.eurprd07.prod.outlook.com (2603:10a6:10:19b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 20:02:49 +0000
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8]) by PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 20:02:49 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "xavier.guillaume@ovhcloud.com"
 <xavier.guillaume@ovhcloud.com>
Subject: RE: [PATCH v2] net/af_packet: add multi-segment mbuf support for
 jumbo frames
Thread-Topic: [PATCH v2] net/af_packet: add multi-segment mbuf support for
 jumbo frames
Thread-Index: AQHcsAgUsrkjy9cDjkaeygeCApDKo7WnzRqAgABkBsA=
Date: Tue, 10 Mar 2026 20:02:49 +0000
Message-ID: <PA4PR07MB7280BF2BBE65E375F5A95FBE9046A@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20260309204910.1657193-1-sriram.yagnaraman@ericsson.com>
 <20260309210210.1665888-1-sriram.yagnaraman@ericsson.com>
 <20260310070251.17c934ea@phoenix.local>
In-Reply-To: <20260310070251.17c934ea@phoenix.local>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7280:EE_|DBAPR07MB6837:EE_
x-ms-office365-filtering-correlation-id: b97a9e5a-d5ca-442d-d26d-08de7ee00163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: d70HnUrGvvNH3M1iz6Pf+d60k6jJQslQ8tCKQhn7R/LXl7WVs2yKRxHJlu9bFjE9/UraPZ7/6ajCcbCQ+RVU0bzYClIAqvXcuAQ3hLOxekQwQFr7gCV41nn3733Usr4spM6BsAk0NeLslGrktg2208WG5Rglk5aqvTkAnpTdNuUtOOfyy35gh3pfmZR2QIeCCZKy78p/fADavvhImZ4xoe1HoT+zsl0EiCHGclbgB2NjnD9t9yZ86z7wpZJl298eB9kIqWdxSlF9l/UfVrLoV2R/QuCbOg3SE9gvScmXcahgfISTPOEcB+KNEvY+hO5iesrDBORoFh/y4tWtR+IboCsUwgnJYQj1l6JWB/tLbjpgXU9ttj8bGXjyaL/DMr7zSKc3kQagPNS5jSu2wVbxNNS5nU7FOk/QXozl/aPI9Q6u4zoCg9oYI/0csmPcxpI82KE1aPgoGsecnxKIRIFn1DWpMyo/JGsJ9qI+dI9Ym/fibFhuFAR8JKoKlKbSH8LmkDlAq847tCN2RySnCJUY9p+GR3g1OuV+yLv6Kb/S2Kh7syssgUI/1wf1ejk4hVMGmvIvUo0YTiC9FFdED0Oni4nubXN3HnqgIBxPT+Y+TcFx0uCrJ201k5IWG1qPo/PTqDumwe+Ohe7IMEE396xtxkxjZAdFOWrzMK9Pg4KyTsAQz5X0lvANilInMWjHxlD9EE+xda2CjrNhXmKMuJECaiGrIfA1aPvSXZRjzbuK5pFAVM98rAFwPHX2Pvhnf27nSEzOIfHgcHdj6dV8Wr0n9bcYvL7eW3Dc+Tbnjy1KzCc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7280.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmZkc0U3L3JtTlpLWGkrYTB1TXFlNkFZT3pkc2pCWVZTZjlOSGlVUlVwelhI?=
 =?utf-8?B?YTJIUmFSS2dqelc1bnpmOUdzV2I2a0JBODF2RXdhcTRJeVdYZHJUN1M0TUpU?=
 =?utf-8?B?WGdkb3ZVMm1RNEl3R3A0UFJUaDNIVWtobHpPdlpkOWhDSkRZa3RFU3BMdWpx?=
 =?utf-8?B?RWphaUllbVRuVDVMS1o1dlUxZWxxRk4rQ3N3VkIzcW5PME94eHFUSEEvNlZR?=
 =?utf-8?B?UlRQbXBPMk41Qzg1dVp5d1VqNFNUUERybWdHbGVMVWxSdWtGdjUvSDFXRzBK?=
 =?utf-8?B?d0FkSUtWVHNQa3Z6enNHbWRNL1NiTDRFRTJXSDBxOGVNRVN1WVVwWUJod24x?=
 =?utf-8?B?MEZhUTBjbktMZ0NGQWthSjJQcFh6cUJuS0djVDg2aTd1U3RtWmtJdXN0Zlky?=
 =?utf-8?B?eUFYU3hnN2NabEF4dm9JUCtoZk1JSlBUbVNmV291cDV2cnZtMjhRNStPUlFF?=
 =?utf-8?B?TFBYUDNPUmU2SXVLdkJpeitubFltLzZ2OFI3dWF2WXhvRjQvM0tSRFh1cXY1?=
 =?utf-8?B?OUNadlBmU1BNUzY2Rkh4VXdDcE9SVTVHaHMxb2NmeHJFcStMZ1VtbTRjOWJN?=
 =?utf-8?B?dS9HczNNa3lxYVdLa1phejRjOGhiTzRONkRnNjlFTlVqYU1TTEI2REpic2RV?=
 =?utf-8?B?d1ljUVphb3kxZDZBWERzWDJHOGNBMmIwYzcwWWFUUngvdVdET2xZSFo2Mzhz?=
 =?utf-8?B?eVhMRjE5MEFVSmhNZHpWcUFGdmd2VDduRkFGMFpMamlDVVQ1V1NXaEowRGpU?=
 =?utf-8?B?L1VvdXJrMUtRdWRMMEZSK1RKK09nM3VLN1VpKzU1dFJqRHIyeXVCRVZaK1dP?=
 =?utf-8?B?YVRXM1U5RGE2Nno1QU82dG8xMHBJeXJsNFdLRUp1bXZyQXRDenlyWE83TU1Z?=
 =?utf-8?B?eHl4cDhrakhDeGhVaVFSUXZYOTZLVFpjQkpzNU5hS2Nma3dkYmNTZUNPaGZG?=
 =?utf-8?B?R1FvNVZGV21lUzhTd2VtRUZobVU5RkdQamY2c0NWenVhSHFJUWM5NjlFTzRM?=
 =?utf-8?B?M3FnS0tDZVBkY2JrRml5OTZkdnlJZTYvandqUUhQejJxN09IMmlMQ09ZRUw1?=
 =?utf-8?B?T3BiaWFMZm9ERVJuYmNaSm1FYm9KNnVzMy8wTjk1WkljSFhBZk5SQTJmcFlu?=
 =?utf-8?B?bEFzUEhaaWNFR0NVU2ZuYWExSzhtYUV4OWNyN2ExUXd3Tm1pS1YycXFjRkJw?=
 =?utf-8?B?enVxMnFCbDZhVExJdkxSeWFRZkJSQ3R1NlhzVENLYU9jR0xjYWpzMFp0ZE1a?=
 =?utf-8?B?Q3MzQ3ArcldTanl6am1keXA3RXdpcHc5SDArc2w1anlvWTE3U2tDeXZOdUhV?=
 =?utf-8?B?VE9oOVQvc0t4MjVhTVBYSnpnb2tjNGRxM1ovUXJ0VXBGWGxyYWlMNTNHN05y?=
 =?utf-8?B?K3VGUEdDWkYzYytFc3k3UGxsM3JYQXNhN1VkdU96K0FjeXhoeU9RaWtKeWxS?=
 =?utf-8?B?T3grcEZuYW0wMHpsSTVRSS9sTUppSWFGdm9OOHdRNXphc2ZDNW5maFZZZkFi?=
 =?utf-8?B?UGQ5eWJTMHF6cXVYaG5NTnJQcnIyVUcwZFhqdGNNanVoeWlkR3R3cmZvS29Y?=
 =?utf-8?B?UHFJd2NZU3kwaFlYYzZ6NU12ZHdUemc2cXE5Y2REUjQycGdqcWlwaFl2UVRy?=
 =?utf-8?B?TXBoRmpXL3I2M0RCNkRVZVBGZGh2UGorS3JsWHArOHRueitBNG95NGdjR0E1?=
 =?utf-8?B?cUlma1J1TTFpSkVKNmV2ckZsUzVjZ0ZTSlBvOXVVRW9oS2Q1clZlUlpFeHFu?=
 =?utf-8?B?azlSUU1SRTlHekhtR29GZStyS2tJN2FBMWR4dk5ueUc1aFBmTHBuWm40SXFS?=
 =?utf-8?B?T3Q4dlp5QzlwNkFuZDdQTnVPbVN2Q2VGeXBUL3NQVTNITzBpU0ZKV052L2FH?=
 =?utf-8?B?UlR2MjQvSWhFdEJaUi8wMVppUnJwUTQvd1V1Q25ibTF1VjQrWHdvUmo2T1B2?=
 =?utf-8?B?MlpzQUdtRUxsTHJjWWNJemFCN3Rpa1VxRG0zVHhHZ1E0UkF4dUpLaEJwNWQ3?=
 =?utf-8?B?cUk2N0c3QlNST0N4VGYvRXl4THUxREdUcGs2dVRMakNFR2M2UlpEd0kwdzIx?=
 =?utf-8?B?M2lnSDFlTDhQNktFajdNaG9kNUJEYnI2cHFaZ1pTSnhlb09GQ3VQM3RBelJP?=
 =?utf-8?B?Z1F2U0tTUGg4M1hJY0VRTkJRZmJ1MXVBc3diOVY1Y3hoVHVVaVAwNEh1MFcx?=
 =?utf-8?B?MjVPZzJzdDYzbGxDUG5DR3IybER5aVVENFlVUEo0ZGY2L1N3K0U5bmZTSXAx?=
 =?utf-8?B?QXJ0K1p5SFBMSTllSVRBWkdJUzZNeEtPYUl6UTdSakQram1nZThvdWFPZ3BG?=
 =?utf-8?B?TlhqN0NhYnpMZ3dOWEdDU1FnQnIya2Q1bC90bFE3OXI4V3NZdVpCK0pRWmx5?=
 =?utf-8?Q?Dcaga6TnPNGWQJ8L3Dj8k9tJHJorkznD1hHehjYACk7Vz?=
x-ms-exchange-antispam-messagedata-1: UnPrSrS1GvafvD92lXxuT5zQ/AIYG6U8Gj4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7280.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97a9e5a-d5ca-442d-d26d-08de7ee00163
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 20:02:49.4210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9B08AK6Q/FwiEpj7F3UmgfBy45x1W5vpcBulIJzmh42KMBxqx4KB92r8xTjoj+AeyLOCZ+zMfYAx4hGA7//vW54IHXCFg4cusOYblmk80E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6837
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBUdWVzZGF5LCAxMCBNYXJj
aCAyMDI2IDE1OjAzDQo+IFRvOiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5A
ZXJpY3Nzb24uY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyB4YXZpZXIuZ3VpbGxhdW1lQG92aGNs
b3VkLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBuZXQvYWZfcGFja2V0OiBhZGQgbXVs
dGktc2VnbWVudCBtYnVmIHN1cHBvcnQgZm9yDQo+IGp1bWJvIGZyYW1lcw0KPiANCj4gT24gTW9u
LCA5IE1hciAyMDI2IDIyOjAyOjEwICswMTAwDQo+IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0u
eWFnbmFyYW1hbkBlcmljc3Nvbi5jb20+IHdyb3RlOg0KPiANCj4gPiBFbmFibGUganVtYm8gZnJh
bWUgcmVjZXB0aW9uIHdpdGggZGVmYXVsdCBtYnVmIGRhdGEgcm9vbSBzaXplIGJ5DQo+ID4gY2hh
aW5pbmcgbXVsdGlwbGUgbWJ1ZnMgd2hlbiBwYWNrZXQgZXhjZWVkcyBzaW5nbGUgbWJ1ZiB0YWls
cm9vbS4NCj4gPg0KPiA+IFRoZSBSWCBwYXRoIG5vdzoNCj4gPiAtIENvcGllcyBmaXJzdCBzZWdt
ZW50IHVwIHRvIG1idWYgdGFpbHJvb20NCj4gPiAtIEFsbG9jYXRlcyBhbmQgY2hhaW5zIGFkZGl0
aW9uYWwgc2VnbWVudHMgZm9yIHJlbWFpbmluZyBkYXRhDQo+ID4gLSBQcm9wZXJseSBtYWludGFp
bnMgbmJfc2VncywgbmV4dCBwb2ludGVycywgYW5kIHBrdF9sZW4NCj4gPiAtIFNpbGVudGx5IGRy
b3BzIHBhY2tldHMgb24gbWJ1ZiBhbGxvY2F0aW9uIGZhaWx1cmUNCj4gPg0KPiA+IFRoaXMgYWxs
b3dzIHJlY2VpdmluZyA5S0IganVtYm8gZnJhbWVzIHVzaW5nIHN0YW5kYXJkIDJLQiBtYnVmcywN
Cj4gPiBjaGFpbmluZyB+NSBzZWdtZW50cyBwZXIganVtYm8gcGFja2V0LiBObyBuZWVkIGZvciBj
dXN0b20gbWJ1ZiBwb29scw0KPiA+IHdpdGggbGFyZ2UgZGF0YSByb29tLg0KPiA+DQo+ID4gQWR2
ZXJ0aXNlcyBSVEVfRVRIX1JYX09GRkxPQURfU0NBVFRFUiBjYXBhYmlsaXR5Lg0KPiA+DQo+ID4g
RGVwZW5kcy1vbjogc2VyaWVzLTM0NTY3ICgibmV0L2FmX3BhY2tldDogZml4IE1UVSBoYW5kbGlu
ZyBhbmQgYWRkDQo+ID4ganVtYm8gZnJhbWUgc3VwcG9ydCIpDQo+ID4NCj4gPiBOb3RlOiBJbXBs
ZW1lbnRhdGlvbiBnZW5lcmF0ZWQgd2l0aCBBSSBhc3Npc3RhbmNlLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVyaWNzc29uLmNv
bT4NCj4gDQo+IFVzaW5nIEFJIHBhdGNoIHJldmlldyBmaW5kcyBzZXZlcmFsIGlzc3Vlcy4NCg0K
VGhhbmtzIGZvciB0aGUgcmV2aWV3LCBJIHdpbGwgZml4IHRoZW0gaW4gdjMuDQpQZXJoYXBzLCBJ
IHdpbGwgd2FpdCBmb3IgWGF2aWVyJ3MgY2hhbmdlcyB0byBiZSBpbiBtYWluIGJlZm9yZSBwb3N0
aW5nIHRoZSBuZXh0IHZlcnNpb24uDQoNCg==
