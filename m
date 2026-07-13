Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BD4C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 11:05:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEA414027A;
	Mon, 13 Jul 2026 13:05:44 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by mails.dpdk.org (Postfix) with ESMTP id 4D3DA40276
 for <dev@dpdk.org>; Mon, 13 Jul 2026 13:05:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZvEMnD3vOZMJIKaBRu8DPR4d3ck6e1v6WtpMSQFkUirFsOeH8isI9s8jULKeaX1kInj5NP+gynUCvd1OHfL1MGbC8b2LgZGgoyFP1O6HH/2CxefZI0Gh7oZjGU44+zlIGTgBpu55VzukQvwEsG1ltwIqKQhAxS8O1wh6Mnlr7WYCYVUS0wwk3OJ+NcsVSGoQlvfXLO4dQKEzEGzPNrw5AGVl+I37HQqs2pZqQnvzgBmTlVkTlWVukeO6AM4LBngC6a8z6uzTg/Xh51a2ZguReo0Q9/lgE3u4gFj54KKUB9j/9Ne/VL/tZ1qkxsClfldQ/fMYteZxmVZgiecC8YGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGmds8tLrE36zOBcXE0nYNkJBIUuyErg8Gta5JocRFo=;
 b=oVFCE22/9/GSJA+RhT0ywkA9onrkqpUsWXyQz50XxGwaU0OIvn4l4hupQ+p63OrtINZgi5kYP12SdaJQvJ4urlPFQn8fNJlndo9ZknqnMcR3/dw1j3VowCyr/SueJGhq0BHG3kos4/G45vzTK1weNcYOiiB+vVBfQw+/kCAJ74RjYo4mJazH7/7HMyqL45YjlO0n910JfZIhOEdLrTWEt+pOaj5wJgrDZgXUFWvuAJwnvUPIX/Zq9Ftkz6Ll/V834nLFxCEpPF9wH0IPdyhhgbqlo1UUbG8YhP67tflHdx7IjPwmNzU/j91FjF5X1Y1tOAyux08JmpBUx1qQY8hJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGmds8tLrE36zOBcXE0nYNkJBIUuyErg8Gta5JocRFo=;
 b=GxM44jlRUA5Hb/WLzXOmEbncUo0/qLHdjQv9x99ktlF/Kpc7ZMFDbmazLUdPEnbV2hUzPkxTZ2BImOew6uMjJlb22LXVapgF9oN8oDIeUnDS4+pKFE7+kfe3SnAcunJq6aP20muSLLWg/F3+wpA/92cxNMJIAtBSf0CAi0k3IurW3NfKDIXecWJRQHXLB6ReVNU92S3PrDz1M/9qB7hzc4f9EBh9MfkaoP8EmMJw6fae5XX8BU1CdGAecBolWxoohbL7SvHbwF4Rd6eEwkfttkWNayBosGl0joQ0odrggdPVJFfoKozEhgCmPe5FmTmTN/xwml77xIxOsbHDIh+jpg==
Received: from PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 11:05:39 +0000
Received: from PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033]) by PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 11:05:38 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: Bruce Richardson <bruce.richardson@intel.com>, "NBU-Contact-Thomas
 Monjalon (EXTERNAL)" <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Slava Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: RE: [PATCH v4 0/4] add versioned symbols for recently stabilized APIs
Thread-Topic: [PATCH v4 0/4] add versioned symbols for recently stabilized APIs
Thread-Index: AQHdBLzfxvfBTfwh4kmvjBA1KJBeHrZUApCAgBdia5A=
Date: Mon, 13 Jul 2026 11:05:38 +0000
Message-ID: <PH0PR12MB70779D26817E22DC927E8860A4FA2@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20260625133311.1299705-1-dsosnowski@nvidia.com>
 <20260625160645.1341914-1-dsosnowski@nvidia.com>
 <CAJFAV8zwKcABUr5kWV429+k_r=Wr=eSkGTLDymogtysobXMAwQ@mail.gmail.com>
In-Reply-To: <CAJFAV8zwKcABUr5kWV429+k_r=Wr=eSkGTLDymogtysobXMAwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7077:EE_|DM6PR12MB4139:EE_
x-ms-office365-filtering-correlation-id: e82735bf-e9a5-4749-d0b4-08dee0ceac15
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: GZF1AwaeeatT+cDl3arG79rAarrQ8S2ucfxwh7UXGqAQtRjpjlYSc7/3ZdYAgN1M9DkAzGt+VpT7oGH8wPphlPkVQv4Z0stz0h0cWiRmLOY9w5UAvRlZK1xrBaZlB8Bv0pIw02qYusaStj1/aU7cGm39gutyx22BQEVWR9kNglZNnykSY/mxAsOHmeiGC3DkyojcLCLQ4hVgAzsJYWhjD+4k+prGykRLWumROUqR8Ngo1XvERQk3OSO9wtVsPTj+swOvixJKYhV08/1R/rxH73IPBscV7zdXtq/k9Ohv9Tl7Rl0b1ZK8V1rDTGCvjGTjf1ZOv8qK6Azds+mS8lzOLX44IO39RMQrsEJo6j1Yt+7NB3Al9Z02nwz9MiHDbuiSaM/aKkj1arYv7Ma8BAU5t6zbNpZcW6R4u//LTqNb0bRI50eKgfixYoQMqZCayxPYdDUOllHMfkx68WoVKiBTL3tNqYmGX1elpzDPihj8CPoS2m+z7eXvMKllHLXyfYyFjI0Gjoov5wjJSzfYXO0Ae2YgjHhXfhChprSsEy+wZkwSuNfbVWAlBrNNxnuM0gL2cYka1JLIE+dOlbZlFvVLXz1HlS6sYbvaM0zjySLuGBv/p9GhmkpcapPZUopp3OgwR9wtk3GLLlJOZtL+IBSEWHEtLbrvobtIzyfEpWdxdm2AfViDZVVtkC6dAIHzVpVJnx+i4fLhT86hNJa3igv15DYojdAclS2yvBG1N7Ca8H8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjJzNGQySjVzMXdJUW1qUExxWmZnZGxBZWpQcU0zM1FIQnlyMFFHRkIwc0J2?=
 =?utf-8?B?bmpOZGhiWjAvZUtqMjYxQ0FjcDUyUXNwam4yK3NtSng0UjdIZWVWNWhKSnVz?=
 =?utf-8?B?WEpMOTNmV3U4enZ0UUJ4cXJUTG5GblZXb1FEaEpkaWkvZ1E4TmNWWXFsR0x2?=
 =?utf-8?B?SVRZZmljOXYzZ2k1SFlIWnoyanJuQ3ZWR2xGeVRZSmVDZ1p1NFV1WkhDZDdo?=
 =?utf-8?B?NndYRnRQSGN6ZGwxL2h5eURWRTBLeEgxcXdnaCtjUS9ucmN1azdGWUNLMEo3?=
 =?utf-8?B?bXphTEw0U3IyZHZIUVp1TjA1bmQvendyQmxwMnJ2UU9LYXlKdmlwSkFyMGlp?=
 =?utf-8?B?MnNYdmpHUkw4bktVOS93R3lQbWdGVUNtc2tKUDBmam1CTUZIdmdEREFUOEtC?=
 =?utf-8?B?MDZRRzRZdmNja2FTY25nWTNQL1EzYk9HVlBTU0QydUFPMFRxNGN3bFpRRGtE?=
 =?utf-8?B?dzZhZzBNY0pzV0prT3lBVWdjbHFkeUs5bmpwUzQ0Q3loUGQvYzFjUHRRTG5u?=
 =?utf-8?B?ODdRSlV0aE8yVXVUZHRIYUJnTjVEMEdhOTVpVWN5Q0MwRTh4RTRoV0lBSU1C?=
 =?utf-8?B?WTBLd0s1TEcyaXlJMUlFYm5LcUdkZG1jcDlXSWNQTGgwaHduUTVZeWpIejZG?=
 =?utf-8?B?TEFZM1NmMEFpK2ZkU2VQK0FlKytGVmRYS3RBVm5seUh4bVhJTXRQaDJZNnhz?=
 =?utf-8?B?NVNheHdkL2FQVGJYNHNaK2FkTGczNnlzcDlnNUpVZW1tN2NZdE9ONDRnMjNj?=
 =?utf-8?B?QU1RMmorczhIMk1DanV1SlBwUURhQmdLL2lYWm5HMGdhM0JNbHBYZ1JGSU01?=
 =?utf-8?B?blZ0dzBCNzFIYnhaZzYxd09WK2wrUXlXQUhEWFdlUFFlWmExa0hOS2pDUCtM?=
 =?utf-8?B?MTVaUkcrMDdXb0hLZ1FJUUU0aTFCd3hvOWpXdytPeEF2SEhUTGppRU9IbG9C?=
 =?utf-8?B?cGd0dkZhWEFwNTNuVXpQOWhRQ2RiWjZxbzlsaUhUT2hHRlVRMDE5YVZEQ0d4?=
 =?utf-8?B?TUMyWUZNN25NcGFTdUhQR2pJQjJVQ1RidUp4NHhjUWZJYjRRVU1kUmRZVWc4?=
 =?utf-8?B?aXBnT1BZSUVIMlBWNVAwQ3ZjQ3RTd1lxTEpkOXpoMUkxK3pzVXQrenUwUnNN?=
 =?utf-8?B?aGY0aEJ0RjROSUN0ZGNXWVFiK0xLbEsrbmpIOUNhT045RDF1OERwOXFJbENQ?=
 =?utf-8?B?dzRCQ3pCbjVqajFscUZhdTgxMkFSQ0lIcUhHMFNBV2hYRFFTVFJTb2U1MS8w?=
 =?utf-8?B?dUpnNktoNnpJNStUclI1YWc1d0x5ZUwzUHVDSDhsNDBYcEhwSUNBdlhWWkVE?=
 =?utf-8?B?ZHd6Z2NZQ3d2K01GOWhyUTNGVi9LQjluTXBFR1d3dFBTemFRL3VwZ293dE9D?=
 =?utf-8?B?UTl0NFF4TmhiOE1xamdsNGRCS0tJN2o0aEgyeUNwaTJidG8wdDdDakU5TjhH?=
 =?utf-8?B?VDVXTmJCVGZoMERRMEdoMXZtRGVnTTBYK0hHMGUxSHZtdzVTV1UxeGFieGEw?=
 =?utf-8?B?QW5aYmNIWHFrUDg0SWFsVm9QcnMyWU5wd2hVVXZ2OWRZRGdtaXdBT3BvbEFO?=
 =?utf-8?B?enMwMmRldU5laDMyQlhmejliT04rL1FFTUI1NnA1c0pwS2g2Q0RLTEd4REJV?=
 =?utf-8?B?YmtPL0paamNjckl0aXpsWUZwUC9SN2x4d0Ria2R1V25va1RYejEyQjI1NXF3?=
 =?utf-8?B?cWgxeDB3U3JSek9lZHNkZVQwdFBKR3Z2ZzU2em9Rb2lESmZtL3prdjU4N3Zv?=
 =?utf-8?B?WmI4d0oxWHB0b0V4MGRibHU3eXdNSlpWOXExRHZKQTYyZFZzdk81TGVSKytw?=
 =?utf-8?B?WEJTMDQyMWRaYjBiK0hqSXFaa3NOdGtwTG92VGRPZGJHYlY2b25xSllkb3Js?=
 =?utf-8?B?U240T2dZbExjK0NPOE1xZDdaRzUxb3FkY1Y0dUs5YnlkeTNDVE5VUWpuZjZX?=
 =?utf-8?B?YTBrdEJFdkdFRGtQcnI2Z25sVEFPUGhYdUNOTFptV2hCeFJhOVo0OHE1QW5V?=
 =?utf-8?B?S1QzanI5dk56MDhad1B2b3A5ZnpUV0xDTkE2UlZMbGp0b0lhRExzeDBEekNa?=
 =?utf-8?B?TVZQc3lobVNvNVk4VWtyOGpnQkxIY2tmaFRvTTBmaVRJbmE3VVl1NWJzdlNT?=
 =?utf-8?B?eUNBb0E3NVk3bi81YkhlY0J3VWNENldFTEpTR0h5ZEJwZkhoTWxjSWp1dGoy?=
 =?utf-8?B?NGJCdjFaeUNXNENkT2RlSy91dnZ3ckF5TVdhOVVDOFZNa2Jid1ljZ1l6K3Uw?=
 =?utf-8?B?L0o5eUZmR2tYSW0wMW1BWExCM2ZHS3MyMUlMcWl2WkdLUDZHUEZTSGpYeDNS?=
 =?utf-8?B?N3g2bWNqN1F3QU8zcTZEMGoveitIQ1dQajJpY0tET1lZVWxxN0ZpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82735bf-e9a5-4749-d0b4-08dee0ceac15
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 11:05:38.7843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETfCUUOh/fs896MfwfqgfNxic6fbWPL5CVLdNCa2Hm4uSTkzzWQEM1SPImzvlF0+uAvhYRSvax7P6LU1CkMosw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTWFyY2hhbmQg
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgSnVuZSAyOCwgMjAy
NiAzOjU3IFBNDQo+IFRvOiBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25vd3NraUBudmlkaWEuY29t
Pg0KPiBDYzogQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+OyBO
QlUtQ29udGFjdC1UaG9tYXMNCj4gTW9uamFsb24gKEVYVEVSTkFMKSA8dGhvbWFzQG1vbmphbG9u
Lm5ldD47IEFuZHJldyBSeWJjaGVua28NCj4gPGFuZHJldy5yeWJjaGVua29Ab2t0ZXRsYWJzLnJ1
PjsgU2xhdmEgT3ZzaWllbmtvDQo+IDx2aWFjaGVzbGF2b0BudmlkaWEuY29tPjsgQmluZyBaaGFv
IDxiaW5nekBudmlkaWEuY29tPjsgT3JpIEthbQ0KPiA8b3Jpa2FAbnZpZGlhLmNvbT47IFN1YW5t
aW5nIE1vdSA8c3Vhbm1pbmdtQG52aWRpYS5jb20+OyBNYXRhbg0KPiBBenJhZCA8bWF0YW5AbnZp
ZGlhLmNvbT47IGRldkBkcGRrLm9yZzsgWXUgSmlhbmcgPHl1eC5qaWFuZ0BpbnRlbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMC80XSBhZGQgdmVyc2lvbmVkIHN5bWJvbHMgZm9yIHJl
Y2VudGx5IHN0YWJpbGl6ZWQgQVBJcw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9u
IG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIZWxsbyBEYXJpdXN6LA0K
PiANCj4gT24gVGh1LCAyNSBKdW4gMjAyNiBhdCAxODowOCwgRGFyaXVzeiBTb3Nub3dza2kgPGRz
b3Nub3dza2lAbnZpZGlhLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBNYWluIGdvYWwgb2YgdGhp
cyBwYXRjaHNldCBpcyB0byBhZGRyZXNzDQo+IGh0dHBzOi8vYnVncy5kcGRrLm9yZy9zaG93X2J1
Zy5jZ2k/aWQ9MTk1Nw0KPiA+IGJ1dCBpdCBhbHNvIGhhbmRsZXMgb3RoZXIgcmVjZW50bHkgc3Rh
YmlsaXplZCBzeW1ib2xzIGFuZCBoYXMgc29tZSBtaW5vcg0KPiBmaXhlczoNCj4gPg0KPiA+IC0g
UGF0Y2ggMSAtIEZpeCBSVEVfVkVSU0lPTl9FWFBFUklNRU5UQUxfU1lNQk9MIG1hY3JvIG9uIGNs
YW5nLg0KPiA+IC0gUGF0Y2ggMiAtIEFsbG93IGZ1bmN0aW9uIHZlcnNpb25pbmcgaW5zaWRlIGRy
aXZlcnMuDQo+ID4gLSBQYXRjaCAzIC0gVmVyc2lvbiB0aGUgZnVuY3Rpb24gc3ltYm9scyBzdGFi
aWxpemVkIGluDQo+ID4NCj4gaHR0cHM6Ly9naXQuZHBkay5vcmcvZHBkay9jb21taXQvP2lkPWU4
Y2FiMTMzNjQ1ZjU0NjZlZjc1ZTUxMTYyOWFkZDQzDQo+IGI2OGE1MDI3DQo+ID4gLSBQYXRjaCA0
IC0gVmVyc2lvbiB0aGUgcnRlX2Zsb3dfZHluZl9tZXRhZGF0YV9yZWdpc3RlcigpIGZ1bmN0aW9u
IHN0YWJpbGl6ZWQNCj4gaW4NCj4gPg0KPiBodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL2NvbW1p
dC8/aWQ9NGVlMmY1YzFjZWRmOWVlN2YzOWFmYTY2N2Y3MWIwN2Y0MA0KPiAwNGJhNWMNCj4gPiAg
IFJlc3RvcmUgRVhQRVJJTUVOVEFMIHZlcnNpb24gb24gZ2xvYmFsIHZhcmlhYmxlIHN5bWJvbHMN
Cj4gPiAgIHJ0ZV9mbG93X2R5bmZfbWV0YWRhdGFfb2ZmcyBhbmQgcnRlX2Zsb3dfZHluZl9tZXRh
ZGF0YV9tYXNrLg0KPiA+DQo+ID4gdjQ6DQo+ID4gLSBGaXhlZCBidWlsZCB3aXRoIG9sZGVyIG1l
c29uIHZlcnNpb25zLg0KPiA+DQo+ID4gdjM6DQo+ID4gLSBodHRwczovL2luYm94LmRwZGsub3Jn
L2Rldi8yMDI2MDYyNTEzMzMxMS4xMjk5NzA1LTEtDQo+IGRzb3Nub3dza2lAbnZpZGlhLmNvbS8N
Cj4gPiAtIEFkZGVkIHJlYnVpbGRpbmcgb2YgZHJpdmVycyB3aXRoIC1EUlRFX0JVSUxEX1NIQVJF
RF9MSUINCj4gPiAgIHdoZW5ldmVyIGZ1bmN0aW9uIHZlcnNpb25pbmcgaXMgZW5hYmxlZC4NCj4g
Pg0KPiA+IHYyOg0KPiA+IC0gaHR0cHM6Ly9pbmJveC5kcGRrLm9yZy9kZXYvMjAyNjA2MjQxMzEz
MzcuMTEyNzMyMy0xLQ0KPiBkc29zbm93c2tpQG52aWRpYS5jb20vDQo+ID4gLSBEcm9wIHBhdGNo
ZXMgaW50cm9kdWNpbmcgdmVyc2lvbmluZyBtYWNyb3MgZm9yIHN5bWJvbCBhbGlhc2VzDQo+ID4g
ICBhbmQgdGhlaXIgdXNhZ2UgKHBhdGNoIDQgYW5kIDUgZnJvbSB2MSkNCj4gPiAtIEVYUEVSSU1F
TlRBTCB2ZXJzaW9uIG9uIGdsb2JhbCB2YXJpYWJsZSBzeW1ib2xzDQo+ID4gICBydGVfZmxvd19k
eW5mX21ldGFkYXRhX29mZnMgYW5kIHJ0ZV9mbG93X2R5bmZfbWV0YWRhdGFfbWFzaywNCj4gPiAg
IGFzIGRpc2N1c3NlZCB1bmRlciB2MS4NCj4gPiAtIENoYW5nZSBjb21taXQgdGl0bGUgcHJlZml4
IGluIHBhdGNoICgyKSBmcm9tICJkcml2ZXJzIiB0byAiYnVpbGQiLg0KPiA+DQo+ID4gdjE6IGh0
dHBzOi8vaW5ib3guZHBkay5vcmcvZGV2LzIwMjYwNjIzMTEzNzUyLjExMDAwNzItMS0NCj4gZHNv
c25vd3NraUBudmlkaWEuY29tLw0KPiA+DQo+ID4gRGFyaXVzeiBTb3Nub3dza2kgKDQpOg0KPiA+
ICAgZWFsOiBmaXggbWFjcm8gZm9yIHZlcnNpb25lZCBleHBlcmltZW50YWwgc3ltYm9sDQo+ID4g
ICBidWlsZDogc3VwcG9ydCBmdW5jdGlvbiB2ZXJzaW9uaW5nIGZvciBkcml2ZXJzDQo+ID4gICBu
ZXQvbWx4NTogZml4IHN0YWJpbGl6ZWQgZnVuY3Rpb24gdmVyc2lvbnMNCj4gPiAgIGV0aGRldjog
Zml4IHByb21vdGVkIGZsb3cgbWV0YWRhdGEgc3ltYm9scw0KPiA+DQo+ID4gIGRyaXZlcnMvbWVz
b24uYnVpbGQgICAgICAgICAgICAgICAgICB8IDIxICsrKysrKysrKysrKysrKysrKysrLQ0KPiA+
ICBkcml2ZXJzL25ldC9tbHg1L21lc29uLmJ1aWxkICAgICAgICAgfCAgMiArKw0KPiA+ICBkcml2
ZXJzL25ldC9tbHg1L21seDVfZHJpdmVyX2V2ZW50LmMgfCAyMiArKysrKysrKysrKysrKysrLS0t
LS0tDQo+ID4gIGRyaXZlcnMvbmV0L21seDUvbWx4NV9mbG93LmMgICAgICAgICB8IDE4ICsrKysr
KysrKysrKy0tLS0tLQ0KPiA+ICBsaWIvZWFsL2NvbW1vbi9lYWxfZXhwb3J0LmggICAgICAgICAg
fCAgMiArLQ0KPiA+ICBsaWIvZXRoZGV2L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgfCAgMiAr
Kw0KPiA+ICBsaWIvZXRoZGV2L3J0ZV9mbG93LmMgICAgICAgICAgICAgICAgfCAxMyArKysrKysr
Ky0tLS0tDQo+ID4gIDcgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRp
b25zKC0pDQo+IA0KPiBMR1RNLg0KPiBTZXJpZXMgYXBwbGllZCwgdGhhbmtzIERhcml1c3ouDQo+
IA0KPiBQbGVhc2Ugc2VuZCB0aGUgcGF0Y2ggdG8gZHJvcCB0aGlzIGNvbXBhdCBpbiAyNi4xMS4N
Cg0KUGF0Y2hlcyBmb3IgZHJvcHBpbmcgdGhlc2UgY29tcGF0aWJpbGl0eSBhbGlhc2VzIGFyZSBv
biB0aGUgbWFpbGluZyBsaXN0Og0KDQotIGh0dHBzOi8vcGF0Y2hlcy5kcGRrLm9yZy9wcm9qZWN0
L2RwZGsvcGF0Y2gvMjAyNjA3MTMxMDU5MzUuMjQxNTItMS1kc29zbm93c2tpQG52aWRpYS5jb20v
DQotIGh0dHBzOi8vcGF0Y2hlcy5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNjA3MTMx
MTAxMDEuMjQyMTgtMS1kc29zbm93c2tpQG52aWRpYS5jb20vDQoNCkJlc3QgcmVnYXJkcywNCkRh
cml1c3ogU29zbm93c2tpDQoNCg==
