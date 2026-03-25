Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D386109C040
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:06:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5B2541101;
	Wed, 25 Mar 2026 19:06:38 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2182D402CE
 for <dev@dpdk.org>; Wed, 25 Mar 2026 19:06:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5JSXxnTZ5fvfv4cqG5/WEWu+msTybqwsQSYzDoLmZWpmGli9rXEKs+Gj7PU675Gva1McYxAC3tvYAKZ0rifZt1E1aBJD3Q0fH8N0xAienn5nqTvn+Eyw7GRYKaPNT5LExw0fFBOlo1WfGBI0mtRVcdU3rMlwWWJCq9SPWUf2gGrSX73iprste1ASSm3mG8D9erSZWczYBnO6oJ7FsozvMSGlKIvO7bJOB+qO/ta6zFKmUgcBFqx1hZ6MxF/hzBWo4RYwK3fTeOq7W1LcQntwceNC5815xc6Apc6+5hFeIaKdC/kRIZVb0QH/grxNsGwVpxicNIVej85ToyzHk1K1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r83KuHskiG7hchMHx1yG4kceogms8VzRKO+4BpPx6rE=;
 b=U09BhGLJbY9mRevut1fo2UjvqdCso+NLk3c9DaLP8fFnoqK7HD0l8q5wHEiUs1pCxuTRdtbYgbGF9hVOugPJm8Wn+ckbadGvhtW70gjZKkYbgVMlX5ap1CkeYL1wMZaVV5hFiUlBdQS7/3DwkhNgX2Cfg/7uAxl5K9soupNhUxT9yQXTIM/lKXU6mUu7noxp8x90ox3XtYhYmlpUayxAY/rXMkEDjJ7HsmXiZeWRvoVz8ExmHQ2nme1xUtrtb7ACyEoMrLicaSxfLx2JW+vkEyvNTwI1HzAIBiJegyJR54g9o4bLCB+xIZBiBrkGf2DW/7kf81+U0rW55eyGwdSp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r83KuHskiG7hchMHx1yG4kceogms8VzRKO+4BpPx6rE=;
 b=tSP7BOV39BkHd56BkJlDr03J/ZN+gbubSu1y4TBPKBl5Vt1voB05X5BJsQO0013ory+z2k+dl8iDsJhDhxuOt+C1KuX8FGGDSaO48zDM5tDh+ox6JveTvPFB92f2MxGMpqsmI38jqeQWf43AmgCVYTWvxTQKFIYS7PfZG8BCTJ+1D1BHq8cDtOM2mYKP9Cd3CvP03LIES6k3JSU2LhytfyR9ht2WCwciV4JcCBhIuof8NAE6Y9waXL6oTlcT9yuUwhZDv0G4kmT/7CWu4WJFBDnZLLbeo4rkV+WxrUPhtA/FmFI1XEvPF87zOfjCLmNa2klyn9hehaFuMnyoNd1iVQ==
Received: from CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 18:06:32 +0000
Received: from CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837]) by CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837%5]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 18:06:32 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Aman Singh <aman.deep.singh@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Raslan
 Darawsheh <rasland@nvidia.com>, Adrian Schollmeyer
 <a.schollmeyer@syseleven.de>
Subject: RE: [PATCH v2 1/2] app/testpmd: assign share group dynamically
Thread-Topic: [PATCH v2 1/2] app/testpmd: assign share group dynamically
Thread-Index: AQHcu69bxSllauY0YUWSh+us4PH+PbW/d0gAgAAVJOA=
Date: Wed, 25 Mar 2026 18:06:32 +0000
Message-ID: <CH2PR12MB954137C899E0FAE3B35F55C6A449A@CH2PR12MB9541.namprd12.prod.outlook.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
 <20260324165657.23945-1-dsosnowski@nvidia.com>
 <20260324165657.23945-2-dsosnowski@nvidia.com>
 <20260325094920.4e086ef0@phoenix.local>
In-Reply-To: <20260325094920.4e086ef0@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9541:EE_|IA0PR12MB8254:EE_
x-ms-office365-filtering-correlation-id: 89c74c2a-afb8-46ca-14ce-08de8a993f24
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: OZT40kCwfOSAjbAASgQwQGkcqZNy+y+90NC/OyVovVBlCNUwgnbY9o2XtZzYUOM7hBOk7ajc9eL/Fznm7AR4EbUuRbB+W/nJSDIJHqLenY6R8D4xula9jJlr5xIT6X6aQYDWv2qW9R2sWRYWMp15xnHjUE1+oOZbzKFUO6bJ8YQcgMP4lEKqQqdKMdaB6C4rj4Pgc2mo/eU1YUHh2j5soq0ItsN942P9jfTIVH8QZ0UtMduTeS+vcFdTqhneDSk9/a8J7uB+maKHlTuoHwlIUer4OjFMu39PfpjlMd9Nxi444oxwoTqskZzq5N0gyQP2HT8UcVK5NIjWatDILwebYCe3ocyFWCuoH2rUqeUBU1DD1rW/B3Etg/CBVGvdxWt7ccDmIrpQq3wmBIh2ZQvFkuHaAevb+0WzEkiyi7A5pdYWk09247vmYry+2NUAoOR5KYJmBoFFlL5I+zoLBj8Gqt2oDJ8LOfoQOR4gDjqQKed9SVxjKpplg/LpAjghmWsy9+cvmwzm5/KmGJvtCjKfhWnDoTRbvD38HEfizF+XJLV6OtVhBu1jJEGSao/jjW+5I2m7JBJfoXR+ZP+zEr1t0rZ8aRthtE4z0W45gLIlRK2KlXYDKMx+4oLyzBmXXFSyTECcRAdAbSpog+JsCHtSPSm5tf7a4+oNfi0w/aMiYGPJd3n5INq0TNbU+7Sc6mhIUB+pIziSAEZ4qhKUcO84F979djUVj6Wv4ioj6vAU+g8wK07FMSjt4xYWr5M9ee/ZXnGU+G7//fVnRXX8bqFHGCw19DFProfpBdk+eFCnvMc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9541.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0x2bXUrRG1pd1d0Y0ZCVXg0NGo1K0VocVl5dzZxOXhsdTBoQkxVOGtiMmlE?=
 =?utf-8?B?bUsxSXVGMlJhUDFDaVoyV0lFbUpvc1NuSXFka1hlam1qcnpJYkc3bG1vM1RL?=
 =?utf-8?B?Yko3UU15ZjNEZGFuUFVySVNxR2JUWjNTVm9OZFcrME95SVNjK1VReldIWDQ0?=
 =?utf-8?B?RnNESlhZd3ZyVk1qdXcvRWNSL3ZZNDBwV01DYXE5WXByd2hXbjc2MHRVcDZP?=
 =?utf-8?B?N1RoV1ZaY0pQbStSOEFibFY2ejVQeHNKcVpNUS9lUmZWRkwwVkhnU0JmMVl0?=
 =?utf-8?B?U0lFdVNtbHJVenBDVmJLVGhzNFkxT3paL2lBM0wvNUphYmpuOFh5SWp1Ums4?=
 =?utf-8?B?eHVFTXUvdHlQTVVPNVhjVkdBMGF5d29BK0NzdWpYenkrSmN1OXZjMTZ6bTc3?=
 =?utf-8?B?YlVkVEFOZW9rNHpFdlNpN1BWM09rcXE0Z0x3VUdRTXQ0K3hXL3ZSL1ZGd1Zn?=
 =?utf-8?B?SnJpQTltcGhzN2I5ZmdJSGlDTUJ3dXQzOFBaWUFqMXMwdERQTGkwOTh5OHVB?=
 =?utf-8?B?aGRsNThVcWpJME1XcWpVaFlNRFlLUzhaQW1VeGkwTWJjSk1xVlhDSXR6cUs1?=
 =?utf-8?B?NTNha1d5ZHl1ZVg5VHZieFI0eVBTdXh5UzhNYmVYaWNQKys2dDBwRnhwSnR0?=
 =?utf-8?B?akhhMWluWHQzTS9GTnA4OUpvcGV3clFvaHgyT2cxOWdRY1pQZ2VxZUV4NjdY?=
 =?utf-8?B?ejJScFFPM2F0TmxhNENHeFhqWGtRZy9nSDNXVVdoS0poa0xOOFFLMWZyTVh6?=
 =?utf-8?B?dkVmM3lGVFo2MTBnM3p2Ty9NaTBmZlRLVUF0b1oyYWRWZmZIUTlGTDh2bm5j?=
 =?utf-8?B?Q04rNDVkSzB5S0dWTTZvSU1CTEZRYVRkd0hIVVpBS2hNUlUzdFdvajVQMTNC?=
 =?utf-8?B?cTZTVXBHVERORllWQkRrYVVHaXgrYkVtVVdSOFVzelg2QTJyc1RCQUUrTW5L?=
 =?utf-8?B?Q0tsTHUwQU1oLy8vWitiVjlVVlY5RTRudzVJUmRZVlNZS3phN2hkdi9JS0Jr?=
 =?utf-8?B?citVVm5qUUNNZVh0Vlhnc2lCYkl0RXhnUzcyOWV1ZTNOdm83aWo0UklLN0lP?=
 =?utf-8?B?Wm1kWW1uVmdGTkpBUFRpdFFlL2RwWE9nU3FtcnAyWU5WRHNDOUVWb2JFVmpK?=
 =?utf-8?B?NWNrYUpzdkQveGllSVZYc1hrajZHaER6cGtjMmRqeTluK1pnMWJWUktDL3kr?=
 =?utf-8?B?MmhEMXJaRGQyZ3FacUJ4WXowVUJueEZDMSt2aXBYblRJVy9qalZkMUw1RWIw?=
 =?utf-8?B?UXBxbHZ4UWsvazA0dmhoWmsvVmZ6ZEZuY2RyNWxjY3d2VVM0RVh5eUhzWVVY?=
 =?utf-8?B?L25wTVVldXZDRmQ2R1JybjlDTUtPRlVqTW0wTG8yZitsdU5vZ0JpcG1xRUtx?=
 =?utf-8?B?cjJtYlBEbExpZXp2ekc0dDUxR0VjWDJ5OWRVRGhiSDA1MzRtU25MV0ZIczdr?=
 =?utf-8?B?a05hZGk2V3djbEJsWnRSODlBS3YvTW9PeDRBNmlVUkdrMVBmTi95MTFSZ2tu?=
 =?utf-8?B?YVFqSnhGSWhVMC9Ld09PM3dTbTRrdzNsQnZ1UWtQM1p3dVBzdUJEZjgrT3RD?=
 =?utf-8?B?UkJsQ3V4aUQ4ZWlkZWYveFBiY3NGbTNjc3ZxaVoyMzZSVS9ERWxzOUpBNnFD?=
 =?utf-8?B?cFgrOUYwMUVKQXNvbVdCaVZBenpORlphSUFxY2pzZEpXczh3bTM5NWpPLzVs?=
 =?utf-8?B?WlVxMndnYXQ0bVg1SmV2bVZJdXI3S2NSU283aWFnRTJQNURYdGx6aFFBS25F?=
 =?utf-8?B?NjZwRXZZM2ZXcnJFUERGbE1GZ0p2ZnB4MmZMNjFKVzVuSmhCa3dLY1gxQTlz?=
 =?utf-8?B?amJGQnNCSDZTbzdZeFI0c1ZFamhqM2RXVU1ablc5VmJPRlVHTXdxSnc5OVk2?=
 =?utf-8?B?TjFwR0FvM3g1NmlZSUhWNTAzcklWT1VQV2k1SVlCYjRuOFl1ZG42SC83enJN?=
 =?utf-8?B?dFBsQzZITUFlUHlkRVhSczRadXh4elF4ZWxGM2o1dzU1WFZpUXA2T24rdkRm?=
 =?utf-8?B?Ym05Q2t6L1NGMnQ4OXQ4T3ovUlBRQzFpRXRjRFU4UHJRY1pIWm80My84V1Jk?=
 =?utf-8?B?MmRGdERVOFMxL2txY3Y0SDBtZ0s0Q2kwQUxDQzhyWnQwZmRBNTFxUGZNcERu?=
 =?utf-8?B?RnArTGhEQy83dXhQam1DYkhHbUVXWUxBN1FlSUlZbGJFOVZNWU1WZm9tdy9z?=
 =?utf-8?B?MS9ZazNaeHNpYm9nbVA2WXpuQXhKK0ZMMUwwQ2hIVGM4Yis1dVYyWjYzTXFX?=
 =?utf-8?B?cnJuenFNc290eFhDVTBxeTZaWTZYQTRyR09VTWF3ZHg5aTg0REFGbU9Td09k?=
 =?utf-8?B?MzlFZVdua21JMHZ4aytaR1drTlRGZnJaOHJlZjQvczRrSmdtTmdmQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c74c2a-afb8-46ca-14ce-08de8a993f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 18:06:32.6504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DpL9Qjhp7GEM5f/rPZI5iwLXIliwR8rMk9v/8GmoaFEhAggRdQGcbN8gH3sOkvmBlnASypCyU9M/O/hwccsIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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
c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjUs
IDIwMjYgNTo0OSBQTQ0KPiBUbzogRGFyaXVzeiBTb3Nub3dza2kgPGRzb3Nub3dza2lAbnZpZGlh
LmNvbT4NCj4gQ2M6IEFtYW4gU2luZ2ggPGFtYW4uZGVlcC5zaW5naEBpbnRlbC5jb20+OyBkZXZA
ZHBkay5vcmc7IE5CVS0NCj4gQ29udGFjdC1UaG9tYXMgTW9uamFsb24gKEVYVEVSTkFMKSA8dGhv
bWFzQG1vbmphbG9uLm5ldD47IFJhc2xhbg0KPiBEYXJhd3NoZWggPHJhc2xhbmRAbnZpZGlhLmNv
bT47IEFkcmlhbiBTY2hvbGxtZXllcg0KPiA8YS5zY2hvbGxtZXllckBzeXNlbGV2ZW4uZGU+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBhcHAvdGVzdHBtZDogYXNzaWduIHNoYXJlIGdy
b3VwIGR5bmFtaWNhbGx5DQo+IA0KPiBPbiBUdWUsIDI0IE1hciAyMDI2IDE3OjU2OjU2ICswMTAw
DQo+IERhcml1c3ogU29zbm93c2tpIDxkc29zbm93c2tpQG52aWRpYS5jb20+IHdyb3RlOg0KPiAN
Cj4gPiBUZXN0cG1kIGV4cG9zZXMgIi0tcnhxLXNoYXJlPVtOXSIgcGFyYW1ldGVyIHdoaWNoIGNv
bnRyb2xzIHNoYXJpbmcgUngNCj4gPiBxdWV1ZXMuIEJlZm9yZSB0aGlzIHBhdGNoIGxvZ2ljIHdh
cyB0aGF0IGVpdGhlcjoNCj4gPg0KPiA+IC0gYWxsIHF1ZXVlcyB3ZXJlIGFzc2lnbmVkIHRvIHRo
ZSBzYW1lIHNoYXJlIGdyb3VwDQo+ID4gICAod2hlbiBOIHdhcyBub3QgcGFzc2VkKSwNCj4gPiAt
IG9yIHBvcnRzIHdlcmUgZ3JvdXBlZCBpbiBzdWJzZXRzIG9mIE4gcG9ydHMsDQo+ID4gICBlYWNo
IHN1YnNldCBnb3QgZGlmZmVyZW50IHNoYXJlIGdyb3VwIGluZGV4Lg0KPiA+DQo+ID4gMm5kIG9w
dGlvbiBkaWQgbm90IHdvcmsgd2VsbCB3aXRoIGR5bmFtaWMgcmVwcmVzZW50b3IgcHJvYmluZywg
d2hlcmUNCj4gPiBuZXcgcmVwcmVzZW50b3JzIHdvdWxkIGJlIGFzc2lnbmVkIHRvIG5ldyBzaGFy
ZSBncm91cC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgbG9naWMgaW4gdGVzdHBt
ZCB0byBkeW5hbWljYWxseSBhc3NpZ24gc2hhcmUNCj4gPiBncm91cCBpbmRleC4gRWFjaCB1bmlx
dWUgc3dpdGNoIGFuZCBSeCBkb21haW4gd2lsbCBnZXQgZGlmZmVyZW50IHNoYXJlDQo+ID4gZ3Jv
dXAuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25vd3Nr
aUBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiANCj4gQUkgcmV2aWV3IGZvdW5kIHRoYXQgdGhlIG9w
dGlvbiBkZWZpbml0aW9uIHN0aWxsIGV4cGVjdHMgYXJnLg0KPiANCj4gDQo+IFdhcm5pbmc6IE9w
dGlvbiBkZWZpbml0aW9uIHN0aWxsIHVzZXMgT1BUSU9OQUxfQVJHIGJ1dCBhcmd1bWVudCBpcyBu
b3cNCj4gaWdub3JlZC4NCj4gVGhlIC0tcnhxLXNoYXJlIHBhcmFtZXRlciBkZWZpbml0aW9uIGF0
IGxpbmUgMzU0IGluIHBhcmFtZXRlcnMuYyBzdGlsbCB1c2VzDQo+IE9QVElPTkFMX0FSRyhURVNU
UE1EX09QVF9SWFFfU0hBUkUpICh3aGljaCBtYXBzIHRvDQo+IG9wdGlvbmFsX2FyZ3VtZW50IGlu
IGdldG9wdCksIGJ1dCB0aGUgcGFyc2luZyBub3cgdW5jb25kaXRpb25hbGx5IHNldHMNCj4gcnhx
X3NoYXJlID0gMSBhbmQgaWdub3JlcyBvcHRhcmcuIElmIGEgdXNlciBwYXNzZXMgLS1yeHEtc2hh
cmU9NSwgdGhlIHZhbHVlIGlzDQo+IHNpbGVudGx5IGRpc2NhcmRlZC4gVGhlIG9wdGlvbiBkZWZp
bml0aW9uIHNob3VsZCBiZSBjaGFuZ2VkIHRvDQo+IE5PX0FSRyhURVNUUE1EX09QVF9SWFFfU0hB
UkUpIHRvIG1hdGNoIHRoZSBuZXcgYmVoYXZpb3IsIGFuZCB0aGUNCj4gZG9jdW1lbnRhdGlvbiBu
b3cgY29ycmVjdGx5IGRvY3VtZW50cyBpdCBhcyBhIGJhcmUgZmxhZy4NCg0KRml4ZWQgaW4gdjMu
DQoNCj4gDQo+IFdhcm5pbmc6IHNoYXJlX2dyb3VwX3Nsb3RzIGVudHJpZXMgYXJlIG5ldmVyIGNs
ZWFyZWQgb24gcG9ydCByZW1vdmFsLg0KPiBUaGUgc2hhcmVfZ3JvdXBfc2xvdHNbXSBhcnJheSBn
cm93cyBhcyBuZXcgKGRvbWFpbl9pZCwgcnhfZG9tYWluKSBwYWlycw0KPiBhcmUgc2VlbiwgYnV0
IGVudHJpZXMgYXJlIG5ldmVyIHJlbW92ZWQgd2hlbiBwb3J0cyBhcmUgaG90LXVucGx1Z2dlZCBv
cg0KPiBjbG9zZWQuIE92ZXIgbWFueSBob3RwbHVnIGN5Y2xlcyB3aXRoIGRpc3RpbmN0IGRvbWFp
biBJRHMsIHNsb3RzIGNvdWxkIGZpbGwgdXAuDQo+IEluIHByYWN0aWNlIHRoaXMgaXMgYm91bmRl
ZCBieSBSVEVfTUFYX0VUSFBPUlRTIChkZWZhdWx0IDMyKSBzbyBpdCBpcw0KPiB1bmxpa2VseSB0
byBiZSBhIHJlYWwgcHJvYmxlbSwgYnV0IGFuIFJURV9BU1NFUlQgd2lsbCBmaXJlIGlmIGl0IGRv
ZXMgb3ZlcmZsb3cNCj4g4oCUIHdvcnRoIGEgY29tbWVudCBub3RpbmcgdGhpcyBsaW1pdGF0aW9u
Lg0KDQpGYWxzZSBwb3NpdGl2ZTogVGhpcyB3YXMgYWxyZWFkeSBoYW5kbGVkIGluIHYyLg0KV2hl
bmV2ZXIgcG9ydHMgYXJlIHJlbW92ZWQsIGFueSB1bnVzZWQgc2hhcmUgZ3JvdXAgaXMgY2xlYXJl
ZCB0aHJvdWdoIHRyeV9yZWxlYXNlX3NoYXJlX2dyb3VwcygpLg0KDQo+IA0KPiBJbmZvOiBEb2N1
bWVudGF0aW9uIGdyYW1tYXIgbml0Lg0KPiBJbiBydW5fYXBwLnJzdCwgIlRoaXMgZW5naW5lIGRv
ZXMgUnggb25seSBhbmQgdXBkYXRlIHN0cmVhbSBzdGF0aXN0aWNzDQo+IGFjY29yZGluZ2x5IiDi
gJQgInVwZGF0ZSIgc2hvdWxkIGJlICJ1cGRhdGVzIi4NCg0KRml4ZWQgaW4gdjMuDQoNCkJlc3Qg
cmVnYXJkcywNCkRhcml1c3ogU29zbm93c2tpDQo=
