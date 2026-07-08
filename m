Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7528CC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 06:38:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4C77402CC;
	Wed,  8 Jul 2026 08:38:04 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
 by mails.dpdk.org (Postfix) with ESMTP id 06C4D40041;
 Wed,  8 Jul 2026 08:38:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2OqxJfF9WTuSi650NYWCaDtGHMDZaNGcxPHOHoVEIcS+MszxyA9NfhSU3MjyVxiRXUkFQbhH6gAilt1zvwepHXtaCOW2JnEFYiRfsTyMP5+HrVJlpERDC3KnMTStLEFi+jpooHhPoMhpU0OvyfVqAAkX+0eW6FR1ZIZn3zc7M1qLscDLezcpqKVO1vNoDrM/3juRILBgJtKgw4PJG7crJiHI0uyMUZpMY1QDxJYaWCGy7mWVX5pxdvXxoQNHZsLVkqExPQroBXTldaWX8Lza8TYIHnDf4Ui3gINaJIqWWxFNs8UGXD8CRL3etg3BBk9TioeKc5aUGXHEVBpEWzPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp2qMh8M50FM5ttdOovFWfVNmc3vmHoStBHaSqNP3aM=;
 b=C4HVmZPe897V/waoAkrRbfbl/ZfXxYpIoxUzvegelrpVvyWX0sbmEkW+zX95rYWLfoNulUWB/qcCS78MybQnz4n7q3NwRCcrsnW/eyWqiakxFSFT1+X9YPsGzifm2Pv+h6YQDA/wqQEJPq2CrDyyHFp13fVHYNtw7+HWTY+prUL6zYi3Okxhxf1hgVngdNS8Xzfc/fsD1ahjWbWAqRgNb4YM0ipXdAn27YQ2e819MuBpb3LttbpEYsWu9PB75fMESgn//qajopXCm77P+5Z3sbkJBvFJ8KEZ540ceuhyd6hDGuGOgCDImc11crXtxAUhqe599QcOTXKifSjzVXCPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp2qMh8M50FM5ttdOovFWfVNmc3vmHoStBHaSqNP3aM=;
 b=gTiOjlPVo5re66du7QcZjRjNfijbFa7bASvXeBLcz4n5eVjdq6pAaZDmDxywmd3HJswDPL+Qzp/lCmLeOi+xYr33AVFa9R+XuKZrOvEGKQqUiA9QPHxkVq8h+TSQsUerdRGz9/RM5TCm7Wz0IDX4TlhPy6kyelvd1yk5U8CZCEnX1SAyAaHtWMfBtc6jq3nqHKCKCnvILZvpXaLIQzl6dUHf4diQvfmDO5yeFM7QQIlV6ffGJ872LtlNqFKRGS4Xc/FT/ZB5cdPoXcgc4KvvRS/Hbdq8ivs6Moofm57ClnE0JmiJM/yRXSHSfjvkd8h4bQVoRzwLJmofstDek7DA0A==
Received: from MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 06:37:59 +0000
Received: from MW6PR12MB7070.namprd12.prod.outlook.com
 ([fe80::4fc6:295e:d915:3efc]) by MW6PR12MB7070.namprd12.prod.outlook.com
 ([fe80::4fc6:295e:d915:3efc%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 06:37:59 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 "stable@dpdk.org" <stable@dpdk.org>, David Marchand
 <david.marchand@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH] build: fix libpcap detection with unusable header
Thread-Topic: [PATCH] build: fix libpcap detection with unusable header
Thread-Index: AQHdDhTbmToZ1A3iM0CC4CQTMU8Hm7ZiGjeAgAEMfEA=
Date: Wed, 8 Jul 2026 06:37:59 +0000
Message-ID: <MW6PR12MB70707673C99F020A595212EBB2FF2@MW6PR12MB7070.namprd12.prod.outlook.com>
References: <20260707133028.236546-1-mkashani@nvidia.com>
 <ak0KN_oZGU1WkPHm@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ak0KN_oZGU1WkPHm@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB7070:EE_|MN2PR12MB4342:EE_
x-ms-office365-filtering-correlation-id: 3360185d-2a0d-41d2-3433-08dedcbb7418
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|18002099003|4143699003|22082099003|11063799006|5023799004|56012099006|6133799003;
x-microsoft-antispam-message-info: yQZVOABbguaAV8vEXlon7k2/nZJb2+CU8dhng/EEbdZ0MeaWoSauKR5QQxTK76ig+h9ANQ0FRcbwM96OgBAO7AOxUiexmZYOsNEZ4qs+EyAsPrXqc+n7ArLfehOnXVlyoVIMcu/PHMzIk0SSnhqGRuvOHZjkUzc5ybKdGxMZjL8JO8G6+06RXkQ+BysHlqLs0M23xmPWSvF/zYSq9rYf8PlwWdICVrUk5be5c4ciICuC0+gTHLXEgCXu/2+gHsbLglIjB89R4aMOpiZgRK0n+j08d5SGkq7coddlFA4MySSZuKonUJJA/QYe3tWdop2RI//0Z0HGKtuNCF+8j2Rwgo223squDYWklUZRozHqPciwd25k7WAqSP/KlIHA3gfQJVdd1oKMD4JapPk+3DCYisHMhAq+C2kEEOcRvZ+i1WHaXBPWT8XtivZZy/nVjKGAYeNqTSMKa/cDJU12PezEdXevRoDETUjpXfyNDsRxOCyEXJ0tHDwsTepP2HhxZdw4PXIjJPIYdwQum77TnirF5ufXWX5myL1azK4SEghxGDNSHqxDYlLReQWKhFUpWM+yHYltpw7nFEjXhWx0g64uu0vvaIf7eLj8u73vaMqI0saZ01eYwPDskIKyEMIUiyyPkeTgHnd1We2ob1ZBhA3eHTi5MdTsNSlYpIJwin6NcufPjUDb9XAlrrgWttdekjNU73aTgEFvZaP/GjE9jEptHejQL+y0c9t8v9lse6W8Y/0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(18002099003)(4143699003)(22082099003)(11063799006)(5023799004)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjFPTXcyOWpyYlRQbE1ONkhhUFhCalBpQVZUdURBK29yaUpBaEZ3VlNEQTNs?=
 =?utf-8?B?K1hVeGtyTmxHaFdqUGlJTWxEcVBVb2k4SHp4UUswb09qWm5jVTJvVkJkYmdl?=
 =?utf-8?B?ZmU5THd3M202ZXNIVkk1MTI4R1p3bEhZbUdqUVNYMGN6NDBzcnluMzRUZHNm?=
 =?utf-8?B?bFByeEoyVmE4U1hxeTdIclRjelJoUXNjRVF3d3NzSEU3VENsYS9yMmdmby9V?=
 =?utf-8?B?T3huRUJ1N2xDWG9qR2hnZjBuK0FlWHpDaHJvY2h3RUpqVkNySVdTTitWS29H?=
 =?utf-8?B?SmYxVThROFNEVHl2MGpwZmRlenZZbURKc3BsOERHT0JUcnhoa0dwQ0hkUmVh?=
 =?utf-8?B?SGF4STAvQm1yS1gzWVNCV1N2c3hXbmR0SFJMQVZmWVlxVmFFY2FxVzhRQVpR?=
 =?utf-8?B?REZqL3N5Rlc0emZIK1ZJTHhZZEo3bkdMeFlhUkNLSWw1dmxqQk5CMWVQZXhE?=
 =?utf-8?B?OUFNRjVZVzFKNVpwUXJOa2hIUjJtWXJZeW5YRUtWNVlCak9rbmEyK3lUK3FQ?=
 =?utf-8?B?TVVveUpsV04wNzNUZnI1bTZvdlpuUStCZWcvNXZPQUNjWXdqZkV2Skl0Mnd2?=
 =?utf-8?B?SVE2bUlVS3BFUzVhRGVoUjk4TXczUXhWSTlEenh1K0Fnd2dWMDFhYmFrTTQ4?=
 =?utf-8?B?bThIL0J6Zkt4UVhPaklZQm94dDY3OVpyYWkyeTd3cDh6dis0Ri9rL0dSZDdV?=
 =?utf-8?B?QmNCNHcra08zaW5lQy9ab1c2M2Y2NnJDOXA5YjlIVEpmTWdPcnR3Zng5ajgv?=
 =?utf-8?B?aURNaVJoMTlQVUU1UnNmSTl5SUJRNFhMZDB0Wmc0OEZneURIelJBNUhCTmlT?=
 =?utf-8?B?UzdGLzlCZzhXNnY4RnAwM3FQb0doSndZeVdkdzFlbHFoOG5mQWhIUFoxc2FE?=
 =?utf-8?B?eXNKcklROW9wdklWdlhpdTR5UEkwamNUcXc5N01xdmdtdjJlN3kweXVsaGlO?=
 =?utf-8?B?MzlQYVgxalJ2bE5COGhlakZXcStlZ1hvVGFBR1I1YmJUZHQrSkNjZldGUUI3?=
 =?utf-8?B?dks3TjRMdFZ3bzMrS1RndDFVR0o1VjNseWtEY2tIQWdDb0dZaHY1L1hmcGNp?=
 =?utf-8?B?UmF6UXpST0VOVnkvbDU0Sk0zRTRmNk0rdlcvYmJZWWI3T3BuMzkzVUlGVGI1?=
 =?utf-8?B?ZFhQeTkyMzk0a1l4U0dhVm0wYXZnTCtONldxKzVUR0RYZXg3Tit6UDhmNHlk?=
 =?utf-8?B?emQ0Q1FaK0pnOHZ5ZEVmUUNyRk1SNzU2NUo3U1dnNFRSVkVZNTdvNTVDQmxD?=
 =?utf-8?B?QTBSVDgxNUFzVXY0NzI3NXZNVWVUMFpjQVd5RGtmVHl0M1M5VDFxcHo0a1pY?=
 =?utf-8?B?ZkdJNlhoc3dTS0p0aDdXeTh2UldRMGxiUUFQWUdtZnBHOG4xa0RsWXoxZTFm?=
 =?utf-8?B?MFJTaXNKamJYdzFQdytmR0lDa0RTQThKR0FkWWJjRDQxTHBOR3JqWlU5anpx?=
 =?utf-8?B?R3VzWW9Oc0RQN1MyZnFsS1lobFJuNU00bWJVUnpiUDFVcTZ1N3MvZkE3b0JK?=
 =?utf-8?B?VmdPSHhJYUZETnpJSjIyMHJ3NzBBaHl0em9oKytXTXNCbHE2b2lpZnZ1YTNE?=
 =?utf-8?B?djFBQjBoK2I4anJqUkUzSXdiMHZ5dU82RGxRQ2tHTUZZTExjM2xkZlRsUmJ0?=
 =?utf-8?B?UHpQdTZuVUJ4dEQwQnU1b3NnMk5pRlRXZ0JBSUVSdE1OSHZSR3hQelZ4Qjlq?=
 =?utf-8?B?ejB2bGgzQWhmdG5xTm9sUzBNcGpNZVAyUDVtc0ptVjNFeldBa0gyU016QVJ3?=
 =?utf-8?B?UWV2M0w1aTlxUytSNzhhSUlxQlpsTW9pNDRMTXIrNFowNkpLVWU2bjRNbnBG?=
 =?utf-8?B?c0t2TWNOYTFvdWJOWjZUTWt3SkkvZldGc1JzQ2h1RkhMaU9kaGtkV28wMll0?=
 =?utf-8?B?VUNqTFhPN3hyVnZlMUIxMW9LNEN2STkvanMwWFNSdFZVWExDdzdkMU5uQWdl?=
 =?utf-8?B?MlB5UHBwQnkzL3dCN1FiNTNhYzBQWHVSZGRMVlFJdlZ2dEJYMkM5akh1VWx3?=
 =?utf-8?B?Z3BqOGs2Mmx2MzFRMjZDZGs0YWQyOWJISTM4b2IyL3hJM0l1ajM1Y1dnMEhz?=
 =?utf-8?B?WDFySkVLWW9nSUNkUCtUYmxtaEFJa1A0ZTlybjFYMGUwZVNjSElFejl6YllI?=
 =?utf-8?B?L2tOUXFZT0FQb1d3b09CRElZRDluakh2MWY0RFV4NG84Y1NTbFZCNmN3dHNu?=
 =?utf-8?B?bzVGOElaYUphbE1ManY1eUpSNXdWUTZNOHk5ajdQbWJkTnpoS000MDlHK25h?=
 =?utf-8?B?TlBmc01NWU53clhKQlVVOXVCbituRzQxSlpNUmVzV0MvdnJUWFJIRk01ckJC?=
 =?utf-8?Q?dBiOrDIw3QAIJCX+vJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3360185d-2a0d-41d2-3433-08dedcbb7418
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 06:37:59.7636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9J7T8xGAt3BgNNnnxgVLfNHD7DJ25nO9FVGoegHLTgkJ1/MXQ4Ui7gq2iWCmTuJRZbnmofHkdmod0rYKWOJbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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

SGksIEJydWNlLCANCndlIGVuY291bnRlcmVkIERQREsgYnVpbGQgaXNzdWUgb24gVGVuY2VudCA0
LjYuDQpJdCBpcyBub3QgZXhwZWN0ZWQ7IHRoZSBwYWNrYWdlL2ltYWdlIGFwcGVhcnMgY29ycnVw
dGVkLiANClJQTSB2ZXJpZmljYXRpb24gY29uZmlybXMgdGhlIGhlYWRlcnMgZGlmZmVyIGZyb20g
dGhlIHBhY2thZ2VkIGNvbnRlbnRzLiANClRoZSBEUERLIGNoYW5nZSBpcyBzdGlsbCB2YWxpZCBi
ZWNhdXNlIG9wdGlvbmFsIGRlcGVuZGVuY3kgZGV0ZWN0aW9uIHNob3VsZCANCnRlc3QgZm9yIHVz
YWJsZSBkZWNsYXJhdGlvbnMsIG5vdCBqdXN0IGZpbGUgZXhpc3RlbmNlIGFuZCBsaWJyYXJ5IHBy
ZXNlbmNlLuKAnQ0KDQpSZWdhcmRzLA0KTWFheWFuIEthc2hhbmkNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29u
QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgNyBKdWx5IDIwMjYgMTc6MTYNCj4gVG86IE1h
YXlhbiBLYXNoYW5pIDxta2FzaGFuaUBudmlkaWEuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBS
YXNsYW4gRGFyYXdzaGVoIDxyYXNsYW5kQG52aWRpYS5jb20+Ow0KPiBzdGFibGVAZHBkay5vcmc7
IERhdmlkIE1hcmNoYW5kIDxkYXZpZC5tYXJjaGFuZEByZWRoYXQuY29tPjsgU3RlcGhlbg0KPiBI
ZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBidWlsZDogZml4IGxpYnBjYXAgZGV0ZWN0aW9uIHdpdGggdW51c2FibGUgaGVhZGVyDQo+
IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KPiANCj4gDQo+IE9uIFR1ZSwgSnVsIDA3LCAyMDI2IGF0IDA0OjMwOjI4UE0gKzAzMDAs
IE1hYXlhbiBLYXNoYW5pIHdyb3RlOg0KPiA+IFRoZSBsaWJwY2FwIGRldGVjdGlvbiBvbmx5IGNo
ZWNrZWQgdGhhdCB0aGUgbGlicmFyeSB3YXMgcHJlc2VudCwgdGhhdA0KPiA+IDxwY2FwLmg+IGNv
dWxkIGJlIGluY2x1ZGVkLCBhbmQgdGhhdCBhIHRyaXZpYWwgcHJvZ3JhbSBsaW5rcy4gTm9uZSBv
Zg0KPiA+IHRoZXNlIGZhaWwgd2hlbiBhIGRpc3RyaWJ1dGlvbiBzaGlwcyBhIGxpYnBjYXAtZGV2
ZWwgcGFja2FnZSB3aG9zZQ0KPiA+IDxwY2FwLmg+IGlzIGVtcHR5IChwcmVzZW50IGJ1dCBkZWNs
YXJpbmcgbm90aGluZykgd2hpbGUgbGlicGNhcC5zbyBpcw0KPiA+IGluc3RhbGxlZDogaGFzX2hl
YWRlcigpIHBhc3NlcyBvbiBhbiBlbXB0eSBmaWxlIGFuZCB0aGUgbGluayB0ZXN0IGRvZXMNCj4g
PiBub3QgcmVmZXJlbmNlIGFueSBwY2FwIHN5bWJvbC4gUlRFX0hBU19MSUJQQ0FQIHdhcyB0aGVu
IHNldCBhbmQgdGhlDQo+ID4gcGNhcC1kZXBlbmRlbnQgY29kZSAoYnBmX2NvbnZlcnQuYywgcG9y
dCBzb3VyY2Uvc2luaywgZHVtcGNhcCkgZmFpbGVkDQo+ID4gdG8gYnVpbGQgd2l0aCBlcnJvcnMg
c3VjaCBhczoNCj4gPg0KPiANCj4gV2h5IHdvdWxkIGEgZGlzdHJpYnV0aW9uIHNoaXAgYSBkZXZl
bCBwYWNrYWdlIHdpdGggYW4gZW1wdHkgaGVhZGVyIGZpbGUgZm9yDQo+IHBjYXAuaD8gSXMgdGhh
dCBleHBlY3RlZCBiZWhhdmlvdXIgaW4gc29tZSBzY2VuYXJpbyB0aGF0IEknbSB1bmF3YXJlIG9m
LA0KPiBiZWNhdXNlIGl0IHNlZW1zIHN0cmFuZ2UgdG8gbWU/DQo+IA0KPiAvQnJ1Y2UNCj4gDQo+
ID4gICBicGZfY29udmVydC5jOiBlcnJvcjogaW52YWxpZCB1c2Ugb2YgdW5kZWZpbmVkIHR5cGUN
Cj4gPiAgICAgICAgICAgICAgICAgICdjb25zdCBzdHJ1Y3QgYnBmX2luc24nDQo+ID4NCj4gPiBS
ZXF1aXJlIGFuIGFjdHVhbCBwY2FwIGRlY2xhcmF0aW9uIChwY2FwX2NyZWF0ZSkgdG8gYmUgdmlz
aWJsZSBpbiB0aGUNCj4gPiBoZWFkZXIgYmVmb3JlIGVuYWJsaW5nIGxpYnBjYXAgc3VwcG9ydCwg
c28gYSBicm9rZW4gb3IgZW1wdHkgaGVhZGVyDQo+ID4gZGlzYWJsZXMgdGhlIG9wdGlvbmFsIHBj
YXAgZmVhdHVyZXMgaW5zdGVhZCBvZiBicmVha2luZyB0aGUgYnVpbGQuDQo+ID4NCj4gPiBGaXhl
czogZDYwMjRjMGE2NzU3ICgiYnVpbGQ6IGNsZWFudXAgbGlicGNhcCBkZXBlbmRlbnQgY29tcG9u
ZW50cyIpDQo+ID4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TWFheWFuIEthc2hhbmkgPG1rYXNoYW5pQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGNvbmZp
Zy9tZXNvbi5idWlsZCB8IDUgKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2NvbmZpZy9tZXNvbi5i
dWlsZCBiL2NvbmZpZy9tZXNvbi5idWlsZCBpbmRleA0KPiA+IGQ3ZjVlNTVjMThmLi40YmZiODUz
NTc4MSAxMDA2NDQNCj4gPiAtLS0gYS9jb25maWcvbWVzb24uYnVpbGQNCj4gPiArKysgYi9jb25m
aWcvbWVzb24uYnVpbGQNCj4gPiBAQCAtMjkwLDcgKzI5MCwxMCBAQCBpZiBub3QgcGNhcF9kZXAu
Zm91bmQoKQ0KPiA+ICAgICAgIyBwY2FwIGdvdCBhIHBrZy1jb25maWcgZmlsZSBvbmx5IGluIDEu
OS4wDQo+ID4gICAgICBwY2FwX2RlcCA9IGNjLmZpbmRfbGlicmFyeShwY2FwX2xpYiwgcmVxdWly
ZWQ6IGZhbHNlKSAgZW5kaWYgLWlmDQo+ID4gKHBjYXBfZGVwLmZvdW5kKCkgYW5kIGNjLmhhc19o
ZWFkZXIoJ3BjYXAuaCcsIGRlcGVuZGVuY2llczogcGNhcF9kZXApDQo+ID4gKyMgaGFzX2hlYWRl
cigpIHBhc3NlcyBldmVuIHdoZW4gcGNhcC5oIGlzIGVtcHR5OyByZXF1aXJlIGEgcmVhbA0KPiBk
ZWNsYXJhdGlvbi4NCj4gPiAraWYgKHBjYXBfZGVwLmZvdW5kKCkNCj4gPiArICAgICAgICBhbmQg
Y2MuaGFzX2hlYWRlcl9zeW1ib2woJ3BjYXAuaCcsICdwY2FwX2NyZWF0ZScsIGRlcGVuZGVuY2ll
czoNCj4gcGNhcF9kZXAsDQo+ID4gKyAgICAgICAgICAgICAgICBhcmdzOiAnLURfR05VX1NPVVJD
RScpDQo+ID4gICAgICAgICAgYW5kIGNjLmxpbmtzKG1pbl9jX2NvZGUsIGRlcGVuZGVuY2llczog
cGNhcF9kZXApKQ0KPiA+ICAgICAgZHBka19jb25mLnNldCgnUlRFX0hBU19MSUJQQ0FQJywgMSkN
Cj4gPiAgICAgIGRwZGtfZXh0cmFfbGRmbGFncyArPSAnLWxAMEAnLmZvcm1hdChwY2FwX2xpYikN
Cj4gPiAtLQ0KPiA+IDIuMjEuMA0KPiA+DQo=
