Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DABB10A62C8
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 13:01:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3477542D83;
	Thu, 26 Mar 2026 14:01:13 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
 by mails.dpdk.org (Postfix) with ESMTP id C3BF24026A
 for <dev@dpdk.org>; Thu, 26 Mar 2026 14:01:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYvP7m6JTLrb71CCtxVTdeA9rPJjBlf+d36jcN+j8oDG0arW5RM9a3quWmsfxCoyeQ6KxFvupK2dMe16yvQ+Y5lPN03hJ6tbsMUXlNgX2NlPxVe8arFeolxljjf1zH2/6Kr7gBDkMHIaBghXKfZ738ZH+YKDVi/9sZjOsNW/9knlf7NXq1UIlKNLfrFiJlCsLTwyvK2fJHZtkWZY3Boag/4RbAp7YVpV05AjeQZDsn5Yw/r2X3xCI5v+CreZ3ppni2o2cqCO77ulh1pKff//lAGc7ahAKDWv9YfAqCA5hPdWOFC19P6V0XCXffe5z2nk8DSJnRgHgJqARrHVFbBwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvS2aO6Xjs8Qt4lUaUl7BA8tuggalxdGb+q194tAGlU=;
 b=iah+ZSsAOZR2Npp34AO/Na+jH7St/eZvKmgBl4c3dy1lxxygBZKL+xwHLhmgwWBTMpDCE4H705aL9G77uKHjUESriQdl+ZoT/3xXjMHT12v3jBrqmfeab8FgUxmkQHwYmllMt+Owd/YsDaj3jApblLCtNkuS/2bdXy5ddFd/DeI3Au2OgvflzbQV1QwS/cLWdXxX2Gwpr4wE1zYHIpuqtUFIh6Y0RpoPzqnogjvU43DKQDlSJcGS8UfTgvnsv+dRPy4aqF/QElADzu0qI5AQ4odiMC2hgXriH9KtCVq/3rP+z6eWj58TOSjKaH8psqBQE/0eR/YyCuM8IiPgIekQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvS2aO6Xjs8Qt4lUaUl7BA8tuggalxdGb+q194tAGlU=;
 b=TNHWUOmz5YuM2PXk1E6Kyev/IMwwfi2qMN5n6hP4i0bazm4/p3v0roh7AQnJ5mHA6OxLCjh5VGvOGAAbc6Us+Kbosg1ZouGsp+yV+G1ZT1vMmmJ9cqDwvnsBbP901ERL3PHUGaeZmSswugk9otbNTT1ep50NwkRMxFpIgWOep1jUjrf7npgXGo6D2QeJ+hgbNi/yNgHENQVmgYaCbGwebgmN/sjD2+vJecBUBOTp4D3YiAhALF8LvY9wUH2ML29DE0cVMD0OhRsygjZx6NteU8Os0FoifY2T3pDu2LzKhYRWFU6iAEPMp78fXNPmkeL1vsC2LYcS9Mrm+R95UBfHrA==
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com (2603:10a6:102:f6::14)
 by GVXPR07MB11466.eurprd07.prod.outlook.com (2603:10a6:150:325::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:01:08 +0000
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8]) by PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8%4]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:01:07 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "xavier.guillaume@ovhcloud.com"
 <xavier.guillaume@ovhcloud.com>, Robin Lin L <robin.l.lin@ericsson.com>
Subject: RE: [PATCH v6] net/af_packet: add Rx scatter for jumbo frames
Thread-Topic: [PATCH v6] net/af_packet: add Rx scatter for jumbo frames
Thread-Index: AQHcu6t1e+iee4QupkuebL0joNRAQrW/gzYAgAFGbTA=
Date: Thu, 26 Mar 2026 13:01:07 +0000
Message-ID: <PA4PR07MB728050D0661E8D9BDA669FBB9056A@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20260318094726.1284454-1-sriram.yagnaraman@ericsson.com>
 <20260324162952.2827453-1-sriram.yagnaraman@ericsson.com>
 <20260325103156.1742d922@phoenix.local>
In-Reply-To: <20260325103156.1742d922@phoenix.local>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7280:EE_|GVXPR07MB11466:EE_
x-ms-office365-filtering-correlation-id: 297d7f2d-333b-4e41-195e-08de8b37bf0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: VnMDhc+qHkkyApDBhsan2laMRZjUkerR4s+LnqgUIGDCGeg9NaMzls+scWU4kGzEUPSlVszCBw068oytZdgw99yL7OvF/JhsqKYCHp2ty6ZrSJ0Oew+M4C4ZtDj7L0sXSkGcTP/smnihkMsxegD57oJfCRlRzOxSQ4T9wWp4s0fJlZas7SQdPQEnqFvDX25aVKJZk4zdcpJOZCvh4oS/+h2NeFAhnNHhhKC6uHYcZXNaPknfcfIHPqJMuEdlqEY2Odt7GoxChiXpOVJ8lby61T2bjaJEQXXX4MSp0GRuaEO9lIP6fEV05zTGvkJpCXRfZHFZgba7FHSN95iQifNW7T+5KRPzY7te90DaEpRhen992F7wHp9OBhxV45kRdtPaBZ/EfJVrQc93+yB3y4B8Cw9f4m7gfmmO4pUAsBkDcMp2MC4YPJ0bu/Y6qerERDTos0e34RU6i+dRNyCZa8dOGh8qfC9X60JzyX/6/DvoHlXkjkOeysa2jyAEc/fO85uTdTW5HgdQgCBM7HgozTA9igqjmJPjDopIEb3zwQvtc4U0iVCwNWG6nGRqpn4jn4wuuaYN0vz0ziLfUNwBxNR1rCCIW+3aLPAzsL7fQrNSmTmLWES9r4yzI8yNMqNJtfJNWYMhqN2hsauA/CJ3VnjFy938kJDFB5rbuZKI4zuzLzVucem1v2L2hcBeP09nuemUySUCT0l4Akc6DWJEVj7lOUToyJ0CbM0rAc7OFtV68UnBO4brWNzYsfaK/UhCKo1wi0hGpcAW+Ftr3Fi6ZPxNxSmOGxiqyophMFaPIaZD1SQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7280.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjlCMGdhZ1dma1VNdmxwS1hydktreFNYTmhid3RTWGl3Zk0yRFZGamxRTFhX?=
 =?utf-8?B?WXRHazlJalpPR05ub2tpRU12aEJjYkN2MTFyR2RvVkZDK1Urc1JBMkhJQUJy?=
 =?utf-8?B?amlFZncyY3VjcmM0T2JTak1YNUdWSjFmTXJBWDRiOVJ1Ry9LaVBNVVc1SHNp?=
 =?utf-8?B?VGZBUVBwWE42cWlQZkp2aWRBdVNZclNSbnM5c3pjNXNUbm55SDFoSW1abFJz?=
 =?utf-8?B?NFZLZ05QNExRSS9LZlREM2MwYmgzWmE0b3NoL3h6dU1uZVZUaEJzWmI0T1NB?=
 =?utf-8?B?UXZjRWR1Wkg5MzBqTFVFQng2eHd0VHZ0ZWVodUE2QWhQa1QwdU9TOUJDL29G?=
 =?utf-8?B?U2dZWUt1SjRDUGQyNml6REcwcjdaZk1qNzB4Qm5wc1AxN3ZKYnE0bWRCK0dl?=
 =?utf-8?B?b2pud2tBWXVsclFMNjVjMHVxNXNKWlpSRURZZkM5ajhvNzR1VUFmMVkyREpP?=
 =?utf-8?B?UUtveUdCUkRDL3hmZ2lZbmplRGw5ZmhVSlJpNC93WkFoUmtJbWVPT09MMXJG?=
 =?utf-8?B?enliUEFNS0NsWS90YUMwWDBwZHNILzhvYW1yMzJJeFc3VDBJN3hadmRmNkhm?=
 =?utf-8?B?S3hIOFNqWG1McUViUkFoYmRwTCt3NktZN0pVd0gyZ0RqTWxYRjRBbFFOTTk1?=
 =?utf-8?B?R2RXVU1CL3RWVzNxZlRJOEdiZEtqWTNoTytZbTFXdWxDTlVmaHQ3d3N2cEJz?=
 =?utf-8?B?Y2Q1Wkd4M3NsckNEN1FCWlN2a2FDK0JRdTNtb3BNdUJCdHpaVjIwQWlMTHlW?=
 =?utf-8?B?NFBiaDRtWnhsN1IzNkx2RnE5MEpoWHluTlRDamRtVy8rRXByOTBQU1YxUnE1?=
 =?utf-8?B?d0RMT2ZFRWRtWWFRNTRsV01kZjUzSE9vbmp0NnRkVG9vcUh2cUxpcHFKSDB2?=
 =?utf-8?B?dUxpaVhtQWt6T0FMcEtoQ2FKUmRDdmZtWGU0MkFvb0RVZzBwcWVDOUxvWmN2?=
 =?utf-8?B?djAwd3BZbXpoNUVRZjNxWEhkY05XSHZDZHBsekppOXlRR0NpNGovMkFkVVBR?=
 =?utf-8?B?WjF5d0tsRDgreHdxU1NzdW5VNXRUWkFuaVc0cWMvMU83cjZQUDNvL3N0Q1pD?=
 =?utf-8?B?S0hObTdIZkVzWVU4R0dqanlEa3N1b3FodDg0SUJPUXp0THFET0M4cUdvWG1U?=
 =?utf-8?B?Q3dabGtaSC9rbi9QR1lzVnRUQ3ljTExuVDNTS1RRSFVmSWxaNGxuUGdJcHJl?=
 =?utf-8?B?VGlQRFVUbitRTi8zT1pJWCtBUVUybmtVR3grcHFNL0N4bm9FNENzTENiZGcz?=
 =?utf-8?B?S0IzUjFoa0o2VTNrK1U0dzJTRDJKWVlSR3FFMTBUbVBBVlhQM0xweENSS21z?=
 =?utf-8?B?RXlRdU9KTTRJRGtjUEVOdG9nODR2dzFkSmREdzFKeE50K0pXZHdqNTBaRm1P?=
 =?utf-8?B?S0ltZlVOWmhha3dHNFgrN1BOUVl1OFhjNG1nRFQwM2VDREtSKzVaYU5YVTlj?=
 =?utf-8?B?aDNIZGRvSVJZeTU2WVE4TnFLdHZBdlVFTUZSRGN0S3p2ZE5PRk15VVIzTFA0?=
 =?utf-8?B?Z3pNcW1QYmttV2JmcXVRZnkyWk9PaGZJNjZHTzVvV3FhL0lZcU4vQ2lMWmR5?=
 =?utf-8?B?MmpndTJOMWFMTnZJcE01ZjBmWlNWRWI1UGIxdHBqYzRTajVQb2dXMnBOcnJS?=
 =?utf-8?B?L2xhYjlYMDRKNUxya1JmVzdQRmR5OTl3Z2ZaN2lnOFZDWDJHVlVCTlNiOG5S?=
 =?utf-8?B?Q1FXNmpQU3VmUmExZzg3K21EVGx5RHhNdk9OekEyTTdtSVhkekpnbUh1UFFE?=
 =?utf-8?B?MWNKdFh6dVloU1Rld3R1OXdNY1BOY25Tckl3VDlJUVNma2FmSUJMY3RwcUJD?=
 =?utf-8?B?cEpESW9IWkM0VUFwOWw0dzcyUHJoY0F0YS9QVThrYTZsZitGMTRjb0Z0TnFH?=
 =?utf-8?B?Uit2dmE2c3FZemRCelVwTTRZd08zQlFMQ29Cd1RKNld2OGNzMCs1V1dCem9T?=
 =?utf-8?B?V3hiOTJKNGFHc05LblRmaSsvVWtXVEFYOFViZkdwY05yVXFWZXZvVWszOGUr?=
 =?utf-8?B?MDVZWldKVE5hQ2hUQUNlYzJHTzhTL3pJSmdQSjV3VlhBNUFDeDVUS09vVUVk?=
 =?utf-8?B?MXJxbUtONkVyUVU5OHFpbm1DVTRlL1pDTUZybFZ4YlZCZWNEcWVpZHFqOFFq?=
 =?utf-8?B?U2plYzI3KzFkWkE5U2JTdXVFT2hVeVc3Uk9nZWpmRm1pd2tQREVEUEZGV09a?=
 =?utf-8?B?VVRlWUg1WGNOTHdzb1VrZTlXWk1zcktGY3UreXh4NXdWTUtsQS9Fd2tsaTZI?=
 =?utf-8?B?OTMyUkZsSnhUVGNvMGVHTld5WUNDTUFNeUx1U1RaN2owZm8zUlRzY0ZyR21B?=
 =?utf-8?B?Q25ydVdLb09Zd21GNmRiOVFyNWpsRmNZK1lFTE1EYmJJNTJJWjhvYzNISzJq?=
 =?utf-8?Q?qZ5+xURyaXYdDZgj/u1cM8Vw811JM1Y+n3pTtAt7mJPXg?=
x-ms-exchange-antispam-messagedata-1: 0k0KYvVE/6dvx3YqpA+yTs+DvKHIX53njfQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7280.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297d7f2d-333b-4e41-195e-08de8b37bf0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 13:01:07.7836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4W5yjPNpcoQuXT66y31N7j/lAXq/HxPfgOtFbb2HmkCUg/cRqzlQHEqjRMCPT5B/79ZmtRlJRZzHz6djia/+ZJge9BzipSz8WrbDOEI2uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB11466
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
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDI1IE1h
cmNoIDIwMjYgMTg6MzINCj4gVG86IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1h
bkBlcmljc3Nvbi5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7IHhhdmllci5ndWlsbGF1bWVAb3Zo
Y2xvdWQuY29tOyBSb2JpbiBMaW4gTA0KPiA8cm9iaW4ubC5saW5AZXJpY3Nzb24uY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY2XSBuZXQvYWZfcGFja2V0OiBhZGQgUnggc2NhdHRlciBmb3Ig
anVtYm8gZnJhbWVzDQo+IA0KPiBPbiBUdWUsIDI0IE1hciAyMDI2IDE3OjI5OjUyICswMTAwDQo+
IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBlcmljc3Nvbi5jb20+IHdyb3Rl
Og0KPiANCj4gPiArLyoNCj4gPiArICogQ29weSBwYWNrZXQgZGF0YSBpbnRvIGNoYWluZWQgbWJ1
ZnMgd2hlbiBpdCBleGNlZWRzIHNpbmdsZSBtYnVmDQo+IHRhaWxyb29tLg0KPiA+ICsgKiBSZXR1
cm5zIDAgb24gc3VjY2VzcywgLTEgb24gbWJ1ZiBhbGxvY2F0aW9uIGZhaWx1cmUuDQo+ID4gKyAq
Lw0KPiA+ICtzdGF0aWMgaW50DQo+ID4gK2V0aF9hZl9wYWNrZXRfcnhfc2NhdHRlcihzdHJ1Y3Qg
cnRlX21lbXBvb2wgKm1iX3Bvb2wsIHN0cnVjdCBydGVfbWJ1Zg0KPiAqbWJ1ZiwNCj4gPiArCQlj
b25zdCB1aW50OF90ICpkYXRhLCB1aW50MzJfdCBkYXRhX2xlbikgew0KPiA+ICsJdWludDE2X3Qg
bGVuID0gcnRlX3BrdG1idWZfdGFpbHJvb20obWJ1Zik7DQo+ID4gKwlzdHJ1Y3QgcnRlX21idWYg
Km0gPSBtYnVmOw0KPiA+ICsNCj4gPiArCW1lbWNweShydGVfcGt0bWJ1Zl9tdG9kKG1idWYsIHZv
aWQgKiksIGRhdGEsIGxlbik7DQo+ID4gKwlydGVfcGt0bWJ1Zl9kYXRhX2xlbihtYnVmKSA9IGxl
bjsNCj4gDQo+IFZlcnkgbWlub3IgcGVyc29uYWwgcHJlZmVyZW5jZSBoZXJlLiBJIHByZWZlciBh
dm9pZGluZyB1c2luZw0KPiBydGVfcGt0bWJ1Zl9kYXRhX2xlbigpIGFuZCBydGVfcGt0bWJ1Zl9w
a3RfbGVuKCkgc2luY2UgdGhleSBhcmUgcmVhbGx5DQo+IG1hY3JvcyBhbmQgdGhlIHVzZSBvZiBk
YXRhX2xlbiBhbmQgcGt0X2xlbiBkaXJlY3RseSBpcyBjbGVhcmVyIGluIGNvZGUgdGhhdCBpcw0K
PiBtYW5pcHVsYXRpbmcgb3RoZXIgbWJ1ZiBmaWVsZHMuDQo+IA0KDQpJIGFncmVlLCB3aWxsIGtl
ZXAgaW4gbWluZCBmb3IgZnV0dXJlIHBhdGNoZXMuIFRoYW5rIHlvdSBmb3IgYXBwbHlpbmcgbXkg
cGF0Y2hlcy4NCg0KPiBBcHBsaWVkIHRvIG5leHQtbmV0DQo=
