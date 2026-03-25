Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D4F109C059
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 19:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D854415D7;
	Wed, 25 Mar 2026 20:00:42 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11021091.outbound.protection.outlook.com [52.101.57.91])
 by mails.dpdk.org (Postfix) with ESMTP id 57F9A402CE;
 Wed, 25 Mar 2026 20:00:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gqvu31dFQ5sDmhUdA3gYZqMvpSVdkCRLLKYhOZi9HXZzX53Wkqicuyihbees78o2h7v7Qm5bfDFzBMunyiRPt2Fr9XqnTOkzoZuiSlCojWAEt0sL4bmaVTBr8CBlvnEbP0V5cYJTKPHi+F5Lgt/CHvKDargb/TpyP6AIiaSnp5e1Q50AjQoH6OtNPDebbBA8BQhB3nIXbei30Nmj6XAmAYu7b/bz7gTGdG4wNq2qz1Nc3l7Rx/wGu0ACph01BawEmaarD1QbZ5zQZcIqxyifejn8WoR9xgdBVWH/rztK3b00MXU4LTiEUblrjqCaCjhaWpGCHs/O3Q648UA7cKqQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYb5LmvCU62MxBJabB3FmQsMP21spq0euYRwtAS+J4o=;
 b=kXnlQcMnHQSnedVICpVnDBRWOVxIuOqdaTyYYbZk6qtKM9XBb3SGThVdwF54PFCO04S6ZPsnCPj/9vZgr3xszpIcS9IN2HLQispVfVU8m4ocB7LU/ffabYXZTrOcvWTCQ9oYxNqq5/GpjIbztsK66CjyjOHNnMgqyPGvrN9uuU/K+n0YPS718Jqz89Lx2sk5vTgHUUwe7oRx0p0nSu6LDiT0beYORjPvVPVLkTTCDISTYhtG/zfOXzWyeae7fK2Ter4NrEwFVLnPMrZvf9PiI31e9DEcWoYwU6HJu51yRfxcyMWWsfCnxgmq9LuPXbGDyMPBka8lz5jKhHSEAff+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYb5LmvCU62MxBJabB3FmQsMP21spq0euYRwtAS+J4o=;
 b=b6HszLjSF9ZGVNDtGfGDFVLIRpTBbGwG7t4golQG1cI0tauns8J4KdUiMPgsiEnYKWzkT2wl2voSH2MkDhDclaQg0R/xKmqCjJn/OL49mkc1Igg7aD3YpMljacpT5i3WiY4C7pZrmryfbypyWHOud2ysHzLHex8O8Lkcf8EIRSs=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV9PR21MB5642.namprd21.prod.outlook.com (2603:10b6:408:2e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Wed, 25 Mar
 2026 19:00:38 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 19:00:38 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2] net/netvsc: switch data path to
 synthetic on device stop
Thread-Topic: [EXTERNAL] Re: [PATCH v2] net/netvsc: switch data path to
 synthetic on device stop
Thread-Index: AQHcux/FuvWyFG8Wd0C0L6QRRHzv+LW92IIAgAHEcIA=
Date: Wed, 25 Mar 2026 19:00:38 +0000
Message-ID: <SA1PR21MB668358FDD9B676668BA524EFCE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260323234957.1780150-1-longli@microsoft.com>
 <20260324090048.1db4dcfc@phoenix.local>
In-Reply-To: <20260324090048.1db4dcfc@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=40c3818e-cc3a-4c1b-8f2b-1379a107a7e1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-25T19:00:07Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV9PR21MB5642:EE_
x-ms-office365-filtering-correlation-id: 3672b0cf-79eb-4a00-929f-08de8aa0cdfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: o6AJdZ7aIGMgJv8ia0a/Xwf6K6sP9Ze/0Vtssx0oR80AvWiXctvfZW0XHYbzWr2ZzPwqundsEmxmU19S3bpQKmxIButFljnXZJbKhMTHz90YbzolEjAfauOOpJN+pz4e4qBsoy/JEghFoP7cPbdUZpVUI3Q8itS0GigA3hgdhKmZF6IPjH3APEXoVuEuT3wgqD6hJ7ACQyu7IUmyxtz/XyGjPdJHCQy2SNB1s0+DnXdgZ/ua2KGd5+X0U3fv3WbY//Mp8t+7pgxTIGNyyABcXWjbK4ABk1KFyJ5qiKFZ4kadquq4lBlGh8Misw26ewiWwhsW3FRRTfeETmz87bo6ZCVWm2/4b2Bz5GiWmWG1WMIaphnY0CGeIDvF066tY1+Gl+4JxW4aB3wJld9GftmrDGe1qeeYJKvv+bNO2ys4MS9caOYCQW5YHV+JPjEE+dsjcVRJDe13wurbr6O1pBIaFnZs8Q8RvYeXCHYIyFC2LWFEaf8/ccvzM597gWZ/u11nNZwziwKlocqsR7s7s/LDTuJ742XgsKOYjoeTWfwBYa2E2g3HIwQotAAwLMVhJN2+XalqwT1zCzJ7ev9GpdZ1QxZ+AdYVCz/Zvw/bLRI7U2UOrwTVZOn3T3NCEgUac2WTmMti6GWZEBYxMvgNa8XC+pTHDsFWPY8wGEbNTEsYaf5Ofe3RH+SoQrLB6SlDKAArzoI5cxOXitC+qG22Uw7pE3bZHnoTTsloYD77mP0W0/9UFI8nZOX8/6uQ4UsRpntFziHTZFfUmzCZlaA8nzcPbKtFY6rvhbHWxe3Rrntmuak=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGZOL085Mkx3QWJveWs3MmZtS2N3dFNSK2prZE1haVJVaFF2SGNLeTVSd1RZ?=
 =?utf-8?B?UXdqL3k1d1BxZE1DQmRhb2FiMkRYcXR2SC9JbThoTWdld1UxcTdsUms3R3pC?=
 =?utf-8?B?cVg2WDd6KzZHWTRNTStOcDBGUGRUcmdURC82WEs5eERwRU5kUEp2Zkl6eC9B?=
 =?utf-8?B?ZE8rVFBOR2YwR2ZPcXZsQ3ZSaWgxd0w1M256NEFtUGRaRnBUTzNSWjYrVnNI?=
 =?utf-8?B?Wlc0NVVydGkxbjV4VDhtWlZlQktJZm5ZOUtYR1hveWlaLytsd1lBZGY3UXMy?=
 =?utf-8?B?cXNCeTlZbVR2UHJiSEdLeS9FYTBhcE03eGgzMk1FMFI2UHdPcmVjMXExQjVp?=
 =?utf-8?B?R3oxQmxMZkJ6dXI1d2srQy93RHMraUVrZzdMby8zOFNYWTY1eHhkZ2NSMVBP?=
 =?utf-8?B?Z2laVnc0ME9kN3JhZ20xWHhuZ0tXR01PcDdMNXRUTVFTSGorYU0xdmNVOFJh?=
 =?utf-8?B?aGVCVXBxWGc2amNOaEpsTlVWb1phR1FaeGV2amNOajNsazlCWXRhdE1xYnMy?=
 =?utf-8?B?Syt3V2VEMUh6V29EbnVqR0FaeVFwNy9ydlRGNUlkVGk3SjhZRlVRVFZPTld4?=
 =?utf-8?B?Z3pDTEdOVUxFdFFyOGM0ODhkRklreEV3NGl6cURyZUZyNzFSbUZLSTgvbUxi?=
 =?utf-8?B?dHprYk5SVVluQjkxeGVlQ0kzVTdvYzYvWWNSazFGN1Mxc0pNSHBwVEZLZUlv?=
 =?utf-8?B?dkVMSXc0eHV1TWNIYVY0NGdLKzlLMDVqcHhySXF6RjlmTUhLdzY5MVZCd01P?=
 =?utf-8?B?KzBaNlhtS2d6Vlc5K0laemJtMWpoTWlkbS9NUlhucDBFcVVVSDJZam1WV2xk?=
 =?utf-8?B?UVB3dW56QWE3di82cEdDUjIrcGJjZ2tRYi9UVUgxQTEyaklRcFN1SHRNSkl0?=
 =?utf-8?B?QUljLzlSNmV1MjBaRk45SlZKRitpSG1EVENIS1hqK1BBOE5WYzVmWXBQazI3?=
 =?utf-8?B?NVVLSHJ0a3oyYlZIeG5GaHUyWmFzTWoxaEJOeDFvUlF3S2xualJJUXJld09V?=
 =?utf-8?B?UUpQRFBwUktIM0ZtNWtZV0EwUkpHbFlwSTUrSnNVVkZLd044QUthMHV2ejJT?=
 =?utf-8?B?VDd6aWJITHNTQVhqU0llc3RPdzdTYnM3cFN0MGhFajVxOVBqOEZsQnRHVXcr?=
 =?utf-8?B?MDJ2a01JcHU1TVMwNTNFTHdNMzdvM3dKK2p3ZFhxdkRuaEp5S0tCbkFJTExG?=
 =?utf-8?B?Z2tFdnJwelVzam1MQjF3RHNkcDk4L21sVXJybjhlTHYvMHNRUkNYUEQzbzY1?=
 =?utf-8?B?S0lBenVDV1JUM2dHNnhsaE9zS2VyeUEyQVVWbXdyNWlVV25zcUVLaEszVGR1?=
 =?utf-8?B?aEh3SEdvemYzQmZaTkM0R2p2NDZ2cDNCZkZJUldpamhkOW5uUStmV2ZjTVh6?=
 =?utf-8?B?YWhGVlNmNGNlT1lUVmsvMnBFbTBxN3ByRThvQ2krcHdhMG0rVUdMbk16VGRC?=
 =?utf-8?B?VjduMnk1OXNQNXZKOXA2dWhDQmE3dDRXV0UwMGhtUEdBK0had0NIL0dqajNv?=
 =?utf-8?B?WjNDUW5jYXh2VVdaNDFmbUR6STgrSWxoMjNqQkFsUW9sTUQrRXIrNGJ1Nmpj?=
 =?utf-8?B?WURxSDNsUU1Fd2NyZlA2U0lxU1VxV3hPcGhWYVFJL0pjUklIUFVvbmFoZ2t4?=
 =?utf-8?B?SFhGTnF5K0s2OEJMcTVNNWthRGVSOGxoTXUvQkpHb3VJZENRSEEwZk1ZRklh?=
 =?utf-8?B?VXowdHFybHNTQ1VlTnUyNE5ycVBGN0loVjVTM2FJWDNHRm1OOFIwRU56T211?=
 =?utf-8?B?U1JXZ1REeWlBTk1leEVWU2x6cmNZRm5LMXNGTm9yeDZDMm5NeHNoRW5xbzhj?=
 =?utf-8?B?VktvSzNlaVIrTUphaU5KSDN4UDRZTzEreWNsa3FvbDBPSG9SRWlEVytwYk9v?=
 =?utf-8?B?TmxrL3lmNG56Q2pmQ1gvRXNDSEN0eHJCdWx6eDQrWFJIZ0VlSFV0N0drWVN0?=
 =?utf-8?B?bXJ2bDFFN2xLeFhidEFycE83OG5lNTBVcUtaTmoydThnN2dJSjhRblNGeTMx?=
 =?utf-8?B?TENRZHBDa3dmR241L0xIbVBlZUtuNUxsUWlENUdZSGtyTC9INUJ2MVkxTFZ1?=
 =?utf-8?B?eEpaam44WWxjVGw0VzhUTnozL2RLdllzbnpMc3F4V0p1SUsra0t5Wk9IVmYr?=
 =?utf-8?B?cTdDaHhXVlhSVmFFVnhONWdLcGtOU2J2cmt4YXhlVy85K0NjcW9uekozMEpr?=
 =?utf-8?B?MW40bHNlcC9nMytaRnpkMVpHRXJWZi9ET3E3dEpJRlZOUXBCUGRGZVBqdWo5?=
 =?utf-8?B?Y054ZjdjN042K2lOMXRmd012bzc1WHBGV0lEODVpanlnRzQ3SnpuZ1lMdUhu?=
 =?utf-8?Q?RVbcTA26ksHE88QVfy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3672b0cf-79eb-4a00-929f-08de8aa0cdfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 19:00:38.8037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VloYnfHGFBtdcXStPbKMyvuj/ACmZSGFYLKHCEY5c6ZWpwZU58vuU2jRZMPJwLQOxsMAqNfjb/sICdYDmLXblA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR21MB5642
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

PiBPbiBNb24sIDIzIE1hciAyMDI2IDE2OjQ5OjU3IC0wNzAwDQo+IExvbmcgTGkgPGxvbmdsaUBt
aWNyb3NvZnQuY29tPiB3cm90ZToNCj4gDQo+ID4gV2hlbiBEUERLIHN0b3BzIGEgbmV0dnNjIGRl
dmljZSAoZS5nLiBvbiB0ZXN0cG1kIHF1aXQpLCB0aGUgZGF0YSBwYXRoDQo+ID4gd2FzIGxlZnQg
cG9pbnRpbmcgdG8gdGhlIFZGL01BTkEgZGV2aWNlLiBJZiB0aGUga2VybmVsIG5ldHZzYyBkcml2
ZXINCj4gPiBzdWJzZXF1ZW50bHkgcmVsb2FkcyB0aGUgTUFOQSBkZXZpY2UgYW5kIG9wZW5zIGl0
LCBpbmNvbWluZyB0cmFmZmljDQo+ID4gYXJyaXZlcyBvbiB0aGUgTUFOQSBkZXZpY2UgaW1tZWRp
YXRlbHksIGJlZm9yZSB0aGUgcXVldWVzIGFyZSBmdWxseQ0KPiA+IGluaXRpYWxpemVkLiBUaGlz
IGNhdXNlcyBib2d1cyBSWCBjb21wbGV0aW9uIGV2ZW50cyB0byBhcHBlYXIgb24gdGhlDQo+ID4g
VFggY29tcGxldGlvbiBxdWV1ZSwgdHJpZ2dlcmluZyBhIGtlcm5lbCBXQVJOSU5HIGluIG1hbmFf
cG9sbF90eF9jcSgpLg0KPiA+DQo+ID4gRml4IHRoaXMgYnkgc3dpdGNoaW5nIHRoZSBkYXRhIHBh
dGggYmFjayB0byBzeW50aGV0aWMgKHZpYQ0KPiA+IE5WU19EQVRBUEFUSF9TWU5USEVUSUMpIGlu
IGhuX3ZmX3N0b3AoKSBiZWZvcmUgc3RvcHBpbmcgdGhlIFZGIGRldmljZS4NCj4gPiBUaGlzIHRl
bGxzIHRoZSBob3N0IHRvIHJvdXRlIHRyYWZmaWMgdGhyb3VnaCB0aGUgc3ludGhldGljIHBhdGgs
IHNvDQo+ID4gdGhhdCB3aGVuIHRoZSBNQU5BIGRyaXZlciByZWNyZWF0ZXMgaXRzIHF1ZXVlcywg
bm8gdW5leHBlY3RlZCB0cmFmZmljDQo+ID4gYXJyaXZlcyB1bnRpbCBuZXR2c2MgZXhwbGljaXRs
eSBzd2l0Y2hlcyBiYWNrIHRvIFZGLg0KPiA+DQo+ID4gQWxzbyB1cGRhdGUgaG5fdmZfc3RhcnQo
KSB0byBzd2l0Y2ggdGhlIGRhdGEgcGF0aCBiYWNrIHRvIFZGIGFmdGVyIHRoZQ0KPiA+IFZGIGRl
dmljZSBpcyBzdGFydGVkLCBlbmFibGluZyBjb3JyZWN0IHN0b3Avc3RhcnQgY3ljbGluZy4NCj4g
Pg0KPiA+IEJvdGggZnVuY3Rpb25zIG5vdyB1c2Ugd3JpdGUgbG9ja3MgaW5zdGVhZCBvZiByZWFk
IGxvY2tzIHNpbmNlIHRoZXkNCj4gPiBtb2RpZnkgdmZfdnNjX3N3aXRjaGVkIHN0YXRlLg0KPiA+
DQo+ID4gRml4ZXM6IGRjNzY4MGU4NTk3YyAoIm5ldC9uZXR2c2M6IHN1cHBvcnQgaW50ZWdyYXRl
ZCBWRiIpDQo+ID4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+IA0KPiBBSSBzcG90dGVk
IHRoYXQgcmV0IGlzIG92ZXJ3cml0dGVuIG9uIGVycm9yIHBhdGgNCg0KSSBoYXZlIHNlbnQgdjMu
DQoNClRoYW5rcywNCkxvbmcNCg0KPiANCj4gDQo+ICoqUGF0Y2g6IFtQQVRDSCB2Ml0gbmV0L25l
dHZzYzogc3dpdGNoIGRhdGEgcGF0aCB0byBzeW50aGV0aWMgb24gZGV2aWNlDQo+IHN0b3AqKg0K
PiANCj4gVGhlIHYyIGFkZHJlc3NlcyB0aGUgdHdvIGlzc3VlcyBmcm9tIHYxIHJldmlldzogYGhu
X3ZmX3N0b3AoKWAgbm93IG9ubHkNCj4gY2xlYXJzIGB2Zl92c2Nfc3dpdGNoZWRgIG9uIHN1Y2Nl
c3MsIGFuZCBgaG5fdmZfc3RhcnQoKWAgbm93IHN0b3BzIHRoZSBWRiBpZg0KPiB0aGUgZGF0YXBh
dGggc3dpdGNoIGZhaWxzLiBCb3RoIGZpeGVzIGFyZSBjb3JyZWN0Lg0KPiANCj4gKipXYXJuaW5n
OiBgaG5fdmZfc3RvcCgpYCDigJQgYHJldGAgZnJvbSBmYWlsZWQgZGF0YXBhdGggc3dpdGNoIGlz
IG92ZXJ3cml0dGVuDQo+IGJ5IGBydGVfZXRoX2Rldl9zdG9wKClgKioNCj4gDQo+IFdoZW4gYGhu
X252c19zZXRfZGF0YXBhdGgoaHYsIE5WU19EQVRBUEFUSF9TWU5USEVUSUMpYCBmYWlscywgYHJl
dGANCj4gaG9sZHMgdGhhdCBlcnJvci4gQnV0IGV4ZWN1dGlvbiBmYWxscyB0aHJvdWdoIHRvIGBy
dGVfZXRoX2Rldl9zdG9wKClgLCB3aGljaA0KPiBvdmVyd3JpdGVzIGByZXRgLiBUaGUgY2FsbGVy
IGxvc2VzIHRoZSBkYXRhcGF0aCBzd2l0Y2ggZmFpbHVyZSDigJQgaWYNCj4gYHJ0ZV9ldGhfZGV2
X3N0b3AoKWAgc3VjY2VlZHMsIGBobl92Zl9zdG9wKClgIHJldHVybnMgMCBkZXNwaXRlIHRoZSBk
YXRhcGF0aA0KPiBzd2l0Y2ggaGF2aW5nIGZhaWxlZC4gSWYgdGhlIGludGVudCBpcyB0byBhbHdh
eXMgc3RvcCB0aGUgVkYgcmVnYXJkbGVzcyBvZiB0aGUNCj4gc3dpdGNoIHJlc3VsdCAocmVhc29u
YWJsZSksIHRoZSBkYXRhcGF0aCBlcnJvciBzaG91bGQgYmUgcHJlc2VydmVkIHNlcGFyYXRlbHks
DQo+IG9yIHRoZSBmdW5jdGlvbiBzaG91bGQgcmV0dXJuIHRoZSBmaXJzdCBlcnJvci4gU29tZXRo
aW5nIGxpa2U6DQo+IA0KPiBgYGBjDQo+IAkJaWYgKGh2LT52Zl9jdHgudmZfdnNjX3N3aXRjaGVk
KSB7DQo+IAkJCXJldCA9IGhuX252c19zZXRfZGF0YXBhdGgoaHYsDQo+IE5WU19EQVRBUEFUSF9T
WU5USEVUSUMpOw0KPiAJCQlpZiAocmV0KSB7DQo+IAkJCQlQTURfRFJWX0xPRyhFUlIsDQo+IAkJ
CQkJICAgICJGYWlsZWQgdG8gc3dpdGNoIHRvIHN5bnRoZXRpYzogJWQiLA0KPiAJCQkJCSAgICBy
ZXQpOw0KPiAJCQl9IGVsc2Ugew0KPiAJCQkJaHYtPnZmX2N0eC52Zl92c2Nfc3dpdGNoZWQgPSBm
YWxzZTsNCj4gCQkJfQ0KPiAJCX0NCj4gDQo+IAkJZXJyID0gcnRlX2V0aF9kZXZfc3RvcCh2Zl9k
ZXYtPmRhdGEtPnBvcnRfaWQpOw0KPiAJCWlmIChlcnIgIT0gMCkNCj4gCQkJUE1EX0RSVl9MT0co
RVJSLCAiRmFpbGVkIHRvIHN0b3AgZGV2aWNlIG9uDQo+IHBvcnQgJXUiLA0KPiAJCQkJICAgIHZm
X2Rldi0+ZGF0YS0+cG9ydF9pZCk7DQo+IAkJaWYgKHJldCA9PSAwKQ0KPiAJCQlyZXQgPSBlcnI7
DQo+IGBgYA0KPiANCj4gVGhpcyBwcmVzZXJ2ZXMgdGhlIGZpcnN0IGVycm9yIHdoaWxlIHN0aWxs
IGF0dGVtcHRpbmcgdG8gc3RvcCB0aGUgVkYuDQo+IA0KPiBFdmVyeXRoaW5nIGVsc2UgbG9va3Mg
Y29ycmVjdC4gVGhlIGxvY2sgdXBncmFkZXMgZnJvbSByZWFkIHRvIHdyaXRlIGFyZQ0KPiBhcHBy
b3ByaWF0ZSwgdGhlIGNvbmRpdGlvbmFsIGxvZ2ljIGluIGBobl92Zl9hZGRfdW5sb2NrZWQoKWAg
Y29ycmVjdGx5IGRlZmVycw0KPiB0aGUgZGF0YXBhdGggc3dpdGNoIHdoZW4gdGhlIGRldmljZSBp
c24ndCBzdGFydGVkLCBhbmQgYGhuX3ZmX3N0YXJ0KClgIHByb3Blcmx5DQo+IHJvbGxzIGJhY2sg
dGhlIFZGIHN0YXJ0IG9uIGRhdGFwYXRoIHN3aXRjaCBmYWlsdXJlLg0KDQo=
