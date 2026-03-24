Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069C4F54AD2
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E761640A67;
	Tue, 24 Mar 2026 17:16:42 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
 by mails.dpdk.org (Postfix) with ESMTP id A1D67402BE;
 Tue, 24 Mar 2026 17:16:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkZViD1f8eFBb5RYPN7mH5XLFBk/1lZfHJ/IOpGK+hmtvG1RzdOwqKIEDcgviXr8HGz4RQ6/nVFKK40jHfXoQFkmZwHE9qDi3xqnGqBcikAZ57BRtKGVl2wo6Zls6oWkBsasIPnzxzg15rb/jk00qYGWVr0/8fQjOftqccYY+4La2OJjieKfryjMvgC1Ja2mytX2jor4D2lNugZdQ9rrNuv84dgrmnEgMF4lGwVda9phxiA7udXOuetPshWrm7CxIa1sGyR79nsnMznf76EAAgzD3fY59ANKeM3f71pFGINH+nnb6KJaaGNVT/ekEJtxgipwYmBxXaVH8AriCUNXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htnWhD8TDDWi1ZLq2tN/5e6QsM15RhVrxu/HcBl/AbA=;
 b=fohRknosjfBP2IbWlK+LFl9eeTsgWbC+6TwCLvXUk0KTq2sJbWcIC6hvx04gZX7ivqsEweh5PQujAp07BfLMNC36NtOxC8iVlwg/S5vo5x3T1moRlz2XzdeaEDgG/aVyWvBfm27f5aewcMXsv1m+7XS8hxU7QY1inoagVmByg1298Oj50I2FGtoRWHzFmbw9edD2DwP0o+cvC4R7fVD9a18D8Cn/ilHux0ZP6HfI8p1ogZ2NzWrOQitAa0Fee10aV14jzDYzSnBYi9LP72zefsA5ubhTDqlH3wi90e0ZmtPQcJHpCdmBD7/IH4bEXev7SVB6U6QVIE/AaPjHC81SKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htnWhD8TDDWi1ZLq2tN/5e6QsM15RhVrxu/HcBl/AbA=;
 b=nPfgM4qeeXm4z86BXcRSuxCBQHYQroAjoMHBE4U4F3F1srG+WSbvXzP8ZTGIWp8jqz+JVGFRriXrZHcSs6YB8xYcLjeBnZhIiXJsaJwORAn0JZy9EUH1hd2a1zsfO08VSQ+yLCt8oCDEzlMtTpP7tTQs1/j+cA+shzk5AoFAuaj7HpbFUynZU5/Nmp4W1W6xb0rhN2QzS8aH2K5ADg5t8dLixIv9SVbAAqUYMbphainLvePv3GXn7jZJarpEr3kdQjETvew5RER6vyzCe5ZUnSV2qe+y8sTOa1NHOUlbhrEHHIKrwOR0LMT7sT7s2Way2OxVKMuXjI0VC7uZqQCdng==
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com (2603:10a6:102:f6::14)
 by PA6PR07MB11555.eurprd07.prod.outlook.com (2603:10a6:102:51c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 16:16:39 +0000
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8]) by PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 16:16:39 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "jgrajcia@cisco.com" <jgrajcia@cisco.com>, 
 "stable@dpdk.org" <stable@dpdk.org>, "bly454@gmail.com" <bly454@gmail.com>
Subject: RE: [PATCH] net/memif: fix multi-segment RX data corruption and
 truncation
Thread-Topic: [PATCH] net/memif: fix multi-segment RX data corruption and
 truncation
Thread-Index: AQHctV3cPNpSCJyr0Uey1zJfCugT/bW80A4AgAEYC9A=
Date: Tue, 24 Mar 2026 16:16:39 +0000
Message-ID: <PA4PR07MB72802482F71B3372E95997AB9048A@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20260316155918.3756017-1-sriram.yagnaraman@ericsson.com>
 <20260323163304.71a6a785@phoenix.local>
In-Reply-To: <20260323163304.71a6a785@phoenix.local>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7280:EE_|PA6PR07MB11555:EE_
x-ms-office365-filtering-correlation-id: d4e25aae-06bb-4cfb-46ab-08de89c0bb1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 9t0SJBQ+0DNoBhI4HigxR+0mPBfpikKO19VrsCqbU0xoUBS6v5o3oKSIOBl1rLkzDy+WHYgZdY9luEVv6pQM2TGQWc1NehnFE9tswwhAEL6VsSH2fIO6SKoDVKjjuPbPuCFSyTuJCHMIWCoa9iMtWxWJt6WUKP9/fMrLBtzpLh1dMsXVNScE3cwoFtnsEjql1uAdLAcMxOlvwzw8Mwzv4S0ms7lqxLWZlo820NBwmdwq1h4HulmAL4dfbTO0nWHwX37o7agF5sXaBCgLlH+wvxcCY61W/BGMhdbEvAUJ2Fq9uaOJwz6bQNExD3Dxk3eFIrMLuI9K29P6rcE5NIdFyuG1aDLZjawoDAIp0uWiDEt1rY9GPx4XXlppMHpe99jwoohTDhRTQhyhxyY2MHFKA/BiGgYTe48iILp1dqrNUeCJ2j0f2CYo6rIAe/vE7Jjm1bjAtKhZRCFWHgbQDSRu5JHK3WJ8xVLHHEqo8qWDQHCqpGh+dhBnPm7LkD+yV+DnlfYapGVyCG5MZ4FCBstQ7Oqew4DA7wSwjbVYCoRnCxEqgujrDpLprrWFLy7za7ePBk5tb5+qmedWUwMlGYsZzQZO8TQRmC+FtI5X6xb075UbJRuQkW+KN1gBjgTBGRlbfHa6aK/XgE4ZiqwAqwUpzv099enT5WJbv0CpUIJ83E3DmsOC3WYgVK5ipteFHVF800ImdosuPte1cujTW5ygqe+a0Dzw8UBzcBZmV2b4OiTgyjDrfHsbol+o7dsP6Kg52rGrbc8vANgeoJ3IouHYIOsLjm6/mEUpqLprCYlUv4c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7280.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2Y2UjkvbTQxZWdWM3ZhSlJYQy9CQkJ3QVJtNXVtaVEyWkYyb3daTHpYYWdN?=
 =?utf-8?B?YUJ1V1lLZEN2eFJMbDU0QlRBOG9RUmpGcTg1VlhWK3Aya1UxYWxnZWhWZmt0?=
 =?utf-8?B?WGNYY2hzZXBnaHMreG84M0RMb3BjMmM4TEtmVWg1dEliWWVGbFhIUE1Ub3Nt?=
 =?utf-8?B?ai9jZjVNYmxhRjJZY1VDblJiUndOTnRBM0lOaWF4bXZvZTMwSHlhM0lWdnJK?=
 =?utf-8?B?aEZUTnBZVHp4OGN1UGhHV2hURE9JNnAzc1VTV3ZyVjF0cnZ2SldPOXo0N0FE?=
 =?utf-8?B?WUJsRnczWjRUZXJ6MEFDaHRQUk5UeXhCV2dBRnhiR3lTRStXWGROTDlKVFdD?=
 =?utf-8?B?ZUZuZlY1RDBEQlBTTHYwSkJwbnloNzhvMlZ6M0ZTVStnblJjWjhGam90VzM1?=
 =?utf-8?B?UkpxZW5CVEdqaDdqRDhqVDZ4b3hRVjVBblpIRGhUaUhBWHpZTWZmT0NiYVhZ?=
 =?utf-8?B?dHJRV0xiRnVmRURUWm1PN1NadzFSOGJqZTlZclNBUHE3SDdNZ2lpc3U1bk8y?=
 =?utf-8?B?ekpCZXZ1WVJxNDBKb3RBdWRMNkdZcmtJc3lFN0JQaCtDZDVMTjI2K2ZIcm9y?=
 =?utf-8?B?VU9BTEFNc0Z3Q1lkWERhRTVTK0pxRzFNbWNZZHZKbld4bFdQY2VGdHM0MXR3?=
 =?utf-8?B?d2Rhay9NR1VqS0wxUnVycXlmNjhTM3RuOExCbG9SRWVNaFJMcXhtR0hVem1Y?=
 =?utf-8?B?T0FlNVJXM1JuUG40bWJTSVk2U0Z3M3FUeFN5bHd2STJ3MGlXRXMvbytQWDNq?=
 =?utf-8?B?NzB6dXZxVmRTVm91M1g0QktJeTNEd0hrbkhaWXlsOEdjNGdvTTZVMkQxdjVa?=
 =?utf-8?B?K29NMWxETmNCS3ljeUF2U1dVZHB2NXZ5eFZoYmppMlVXZXFUaUhLcjhDK1Rs?=
 =?utf-8?B?RWRFYnRLOXpBbndPcEJSeGNVUVBHUCt4SVA4Tm4xSlpKREVaVU11b2cwcGFv?=
 =?utf-8?B?S0tTSUQ0YUIxdFhIbE1PN0JFM0xoWnBxOUt2Y2h3S1hpWFRRQndhYi9rT0pl?=
 =?utf-8?B?U2Rxci8xSHAyTk8zUjEwRXZ4RlgzS1A2UU1IbnhtQWtEMkN3S0x6amFXRU9E?=
 =?utf-8?B?Y2Nmb1NLNDdjY1E1VTArMkYvZDJ5bE9wcFBHTEx3UDRpdE1jRzhacGtWMjBT?=
 =?utf-8?B?cWtnMm5INGd4VHZvSytIa1AvMUZaa0tFZkdPQ2dqcXpLMWI2TTAzbUVaVkJ5?=
 =?utf-8?B?MGxYQkgxQWNMMjBJbGI1akFqS0dVank5YW4xN1NJWVBlRWpMUXVWM3VLK3lP?=
 =?utf-8?B?RHBDMk80Q3R6Y0dLaUw1K1dGZXJBbXJsYjdPTXBOWFNrNElZVlY5UWd5ZHNO?=
 =?utf-8?B?bHJWMENqNE1hK1kyS3E2N25hYlV2TWtzdUN6YTZQZHZNaSt0YXM4MkpZVm5o?=
 =?utf-8?B?RndtMmVGWFZzWnFVR0tBbmNmbm93OWs1RCtnYUswMVo0LzZ6V1JLOWlhakds?=
 =?utf-8?B?VVh0SExTOTgxU0duT3dTNHgwVGlrWkJmUEFHdmFYRlBlU0U4OFAxRWFXalFz?=
 =?utf-8?B?cXVNdjVLQklBQWdxRHFsTkQ2Zkt5WVZNYU1icXNoY3lwak05ZW5LRm8valBm?=
 =?utf-8?B?Yi92eDByNklWaTR6c0tkWm9lUW9GMHpWL0diSEZpMkF2czJlb0pORU95cjFp?=
 =?utf-8?B?cVFpRHhkVlpmNW0vQ3RKWVNvbFRzcktvL2QyZHQ2VzFOUG5kS2lWR1BocGRh?=
 =?utf-8?B?UC8wazdDV3ZWN2VLWEU3RnJBV2xKVFlrWEtvREhDZjhrK096ditvRlFtLzVj?=
 =?utf-8?B?ZDF4Wm05MnRJTEFNQ3ZrakpIZXgzQXcyR0J1NWtmRE9pZm5MKzFRaDdOWlVV?=
 =?utf-8?B?czBzZDAvWllBQU90aGx2ZWxKZHJodXFpRnB5UzluYy9hc3B2aUJZdXhjRmND?=
 =?utf-8?B?UjBpcWltRHFDazhkblF5WTNaSVJ5NWRwNXRTVXlwUjJsMlp2bW93bjE4a1Rh?=
 =?utf-8?B?bzhBMDZTaEdCZERpbTkxWEk3V0M5K2o0dDZSTUxyUEwwdEdHMWxJbXZkcVZa?=
 =?utf-8?B?YVVFQlg0OFJrR0cwTGhLNFlGMGx6cXhEMExTZTVsZjVPOUVZejdDS2FBYWp6?=
 =?utf-8?B?S0VlMlNHWEJwcldmN3BFam56N1VrMG5IenY5TVF6WGtIK042Zm5IdGxNVy82?=
 =?utf-8?B?RmNjeTRmVzFiblJDT25ySC9MWEh6NU5wb2xpRmpkT28rcFl0Z3hON0RVa1Vp?=
 =?utf-8?B?cW5kblJId2dqTE1hczNTVUZONDN1anNoZkpkOHhkLzI1RmJvVFREa2ZVU1RW?=
 =?utf-8?B?Tjk5NTBIa1MzaVVza2FmVUlVT0VQUFZGZExQVTR2SURRNW11OUt5TndHNEVq?=
 =?utf-8?B?cEgxMHdHQkxta2JUS05OcTFScTRkVGxDRkJxV2ZQUnNvRWEwTHVFaTlvY2VK?=
 =?utf-8?Q?BxT9sSGnYeYyrLkZE7nE7GB8/a/WdmLTtpJHMftUzCFaa?=
x-ms-exchange-antispam-messagedata-1: VBCA+sgFE79yqLsfDsMNFQEypeW1k0z413E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7280.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e25aae-06bb-4cfb-46ab-08de89c0bb1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:16:39.8808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSpwgP2TgRObgntmUPF+IBHrlSE5vYg2Z99nDpIfghq3ZkVHzTEnUpLQwV55r7A0u4wxOosIA6gXUpI9ZkfuBr2nLosuDaMu2OCs9jS+AIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR07MB11555
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
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBUdWVzZGF5LCAyNCBNYXJj
aCAyMDI2IDAwOjMzDQo+IFRvOiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5A
ZXJpY3Nzb24uY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBqZ3JhamNpYUBjaXNjby5jb207IHN0
YWJsZUBkcGRrLm9yZzsgYmx5NDU0QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBu
ZXQvbWVtaWY6IGZpeCBtdWx0aS1zZWdtZW50IFJYIGRhdGEgY29ycnVwdGlvbiBhbmQNCj4gdHJ1
bmNhdGlvbg0KPiANCj4gT24gTW9uLCAxNiBNYXIgMjAyNiAxNjo1OToxOCArMDEwMA0KPiBTcmly
YW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXJpY3Nzb24uY29tPiB3cm90ZToNCj4g
DQo+ID4gRml4IGRzdF9vZmYgYmVpbmcgcmVzZXQgcGVyLWRlc2NyaXB0b3IgaW5zdGVhZCBvZiBw
ZXItcGFja2V0IGluIHRoZSBSWA0KPiA+IHNsb3cgcGF0aC4gV2hlbiBwcm9jZXNzaW5nIGNoYWlu
ZWQgZGVzY3JpcHRvcnMNCj4gKE1FTUlGX0RFU0NfRkxBR19ORVhUKSwNCj4gPiBnb3RvIG5leHRf
c2xvdDIgcmVzZXQgZHN0X29mZiB0byAwLCBvdmVyd3JpdGluZyB0aGUgYmVnaW5uaW5nIG9mIHRo
ZQ0KPiA+IGN1cnJlbnQgbWJ1ZiB3aXRoIGRhdGEgZnJvbSBzdWJzZXF1ZW50IGRlc2NyaXB0b3Jz
LiBNb3ZlIGRzdF9vZmYNCj4gPiBpbml0aWFsaXphdGlvbiBiZWZvcmUgdGhlIG5leHRfc2xvdDIg
bGFiZWwgc28gaXQgaXMgb25seSByZXNldCBvbmNlDQo+ID4gcGVyIHBhY2tldC4NCj4gPg0KPiA+
IEFkZCBib3VuZGFyeSBjaGVjayBpbiBib3RoIFJYIHBhdGhzIGJlZm9yZSBwcm9jZXNzaW5nIG5l
eHQgc2VnbWVudC4NCj4gPiBJZiBNRU1JRl9ERVNDX0ZMQUdfTkVYVCBpcyBzZXQgYnV0IG5fc2xv
dHMgaXMgMCwgZnJlZSB0aGUgaW5jb21wbGV0ZQ0KPiA+IG1idWYgY2hhaW4gYW5kIGV4aXQgZ3Jh
Y2VmdWxseSB0byBwcmV2ZW50IHJlYWRpbmcgYmV5b25kIGF2YWlsYWJsZQ0KPiA+IGRlc2NyaXB0
b3JzLg0KPiA+DQo+ID4gQnVnemlsbGEgSUQ6IDE2MDkNCj4gPiBGaXhlczogYWExN2RmODYwODkx
ICgibmV0L21lbWlmOiBhZGQgYSBSeCBmYXN0IHBhdGgiKQ0KPiA+IENjOiBzdGFibGVAZHBkay5v
cmcNCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBNaWtlIEJseSA8Ymx5NDU0QGdtYWlsLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXJp
Y3Nzb24uY29tPg0KPiANCj4gSXQgbG9va2VkIGdvb2QgdG8gbWUsIGJ1dCBBSSByZXZpZXcgc3Bv
dHRlZCBhbiBpc3N1ZS4NCj4gDQo+IA0KPiAtLS0NCj4gDQo+IE9LLCBzbyBteSBlcnJvciBmaW5k
aW5nIHN0YW5kcyBidXQgd2l0aCByZWZpbmVkIHJlYXNvbmluZy4gSGVyZSdzIHRoZQ0KPiBjb3Jy
ZWN0ZWQgc3VtbWFyeToNCj4gDQo+ICoqRXJyb3I6IERvdWJsZSBmcmVlIG9mIGBtYnVmX2hlYWRg
IGluIHRoZSBmYXN0LXBhdGggdHJ1bmNhdGlvbiBlcnJvciBwYXRoLioqDQo+IA0KPiBJbiB0aGUg
bmV3IHRydW5jYXRpb24gY2hlY2sgYWRkZWQgdG8gdGhlIGZhc3QgcGF0aDoNCj4gYGBgYw0KPiBp
ZiAodW5saWtlbHkobl9zbG90cyA9PSAwKSkgew0KPiAgICAgTUlGX0xPRyhFUlIsICJUcnVuY2F0
ZWQgcGFja2V0OiAuLi4iKTsNCj4gICAgIHJ0ZV9wa3RtYnVmX2ZyZWUobWJ1Zl9oZWFkKTsNCj4g
ICAgIHJ0ZV9wa3RtYnVmX2ZyZWVfYnVsayhtYnVmcyArIHJ4X3BrdHMsDQo+ICAgICAgICAgICAg
IE1BWF9QS1RfQlVSU1QgLSByeF9wa3RzKTsNCj4gICAgIGdvdG8gbm9fZnJlZV9idWZzOw0KPiB9
DQo+IGBgYA0KPiANCj4gYG1idWZfaGVhZGAgaXMgYG1idWZzW3J4X3BrdHNdYCAoYXNzaWduZWQg
YXQgbGluZSAzNTkpLg0KPiBgcnRlX3BrdG1idWZfZnJlZShtYnVmX2hlYWQpYCBmcmVlcyB0aGUg
aGVhZCBhbmQgaXRzIGVudGlyZSBjaGFpbi4gVGhlbg0KPiBgcnRlX3BrdG1idWZfZnJlZV9idWxr
KG1idWZzICsgcnhfcGt0cywgLi4uKWAgcHJvY2Vzc2VzIHRoZSBzYW1lIGFycmF5DQo+IHN0YXJ0
aW5nIGF0IGBtYnVmc1tyeF9wa3RzXWAsIHdoaWNoIHN0aWxsIGhvbGRzIHRoZSBub3ctZnJlZWQg
cG9pbnRlci4gU2luY2UNCj4gYHJ0ZV9wa3RtYnVmX2ZyZWVfYnVsa2Agd2Fsa3MgYG0tPm5leHRg
IGNoYWlucyAoY29uZmlybWVkIGluDQo+IGBsaWIvbWJ1Zi9ydGVfbWJ1Zi5jOjU3NGApLCB0aGlz
IGZyZWVzIGBtYnVmX2hlYWRgIGEgc2Vjb25kIHRpbWUuDQo+IA0KPiBUaGUgZXhpc3RpbmcgZXJy
b3IgcGF0aHMgYXQgbGluZXMgMzgzLTM4NiBhbmQgMzkxLTM5NCBkbyBOT1QgaGF2ZSB0aGlzIGJ1
ZyDigJQNCj4gdGhleSBkb24ndCBjYWxsIGBydGVfcGt0bWJ1Zl9mcmVlKG1idWZfaGVhZClgIGZp
cnN0OyB0aGV5IGxldA0KPiBgcnRlX3BrdG1idWZfZnJlZV9idWxrYCBoYW5kbGUgdGhlIGVudGly
ZSBjaGFpbi4gVGhlIGZpeCBpcyB0byByZW1vdmUgdGhlDQo+IHNlcGFyYXRlIGBydGVfcGt0bWJ1
Zl9mcmVlKG1idWZfaGVhZClgIGFuZCBqdXN0IGRvOg0KPiBgYGBjDQo+IHJ0ZV9wa3RtYnVmX2Zy
ZWVfYnVsayhtYnVmcyArIHJ4X3BrdHMsDQo+ICAgICAgICAgTUFYX1BLVF9CVVJTVCAtIHJ4X3Br
dHMpOw0KPiBgYGANCj4gDQo+IFRoaXMgd29ya3MgYmVjYXVzZSBgcnRlX3BrdG1idWZfZnJlZV9i
dWxrYCBhbHJlYWR5IHdhbGtzIHRoZSBjaGFpbiBvbg0KPiBgbWJ1ZnNbcnhfcGt0c11gLCBmcmVl
aW5nIGBtYnVmX2hlYWRgIGFuZCBhbGwgc2VnbWVudHMgY2hhaW5lZCBvbnRvIGl0LCBwbHVzDQo+
IHRoZSByZW1haW5pbmcgdW51c2VkIG1idWZzLg0KPiANCg0KVGhhbmtzIFN0ZXBoZW4sIGl0IGlz
IGEgZ29vZCBjYXRjaCwgSSBjb3JyZWN0ZWQgdGhpcyBhbmQgcG9zdGVkIGEgdjIuDQoNCj4gTm8g
b3RoZXIgaXNzdWVzIGZvdW5kLiBUaGUgYGRzdF9vZmZgIGZpeCBhbmQgdGhlIHNsb3ctcGF0aCBi
b3VuZHMgY2hlY2sgYXJlDQo+IGJvdGggY29ycmVjdC4NCg==
