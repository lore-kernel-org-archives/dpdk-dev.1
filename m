Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BD5CDB47F
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 09:22:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B68A440280;
	Thu, 25 Jun 2026 11:22:39 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by mails.dpdk.org (Postfix) with ESMTP id 33BD54025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 11:22:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hw5QN/8Xi3EitF06fz1wHNt/oKWYT31F/wEnN/istluylH1H1ORmb2dYXxDEaRzjgecxalBuVrfxKbdimcbUJY7kKFEP2DJ90v/sQNUaRfJJJudQ81RhCnu3qydPfR8BgBPSEiIoROQVkKAFgNmcbvNdzXnnZuTiXYc439Uztmw5PkWvKqd5dp9ldkAZK1h/NjQWGJGvwugQgQpfGQVzMtGvwg8+n3xy83w58e4MEi8a7WDBMbdagwutEUE9lh2LLa/Jy9+jcGtuxAxCHFALWqmZq5yY9l5nR/EFsa8hi7jibHjJe7MdXHxi6sZjegnQ5gBvwt4s22QM21QvRhvAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOUxptDJZdk0tLj76fbvHHxyKjin5DRW65lJerXd1XA=;
 b=iIFFDKaTPhqG3ZZqJPvvGqUxDnNUt12xkefyh+GmTHAqIJaUcqmWsWhVzJwVS+93/WrDIKIQT13boRewDU2ryFuNzXXcnU8dlXoADcj1wCfqX0TAG4eXQ2QJYfqtx/p9JeqzUoWch8iHlkl0IsBDtm3GT/YL2pwROCSNFiDepUtOJ9JUbkDUghjbgirKHWurLOE+DM7UJcvFQb4qawrI/hf/urESFL425zGiRccoO/XvdYJR7UZGFq+WbX74p3ToXzyPfAwHSwPgGeP4mPdPxH5rGeEn96V1QXnkSuuyR67nKAdNI6Z8cC8IXgfXzUy9xHwM5HpJbrxczjYNBhAEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOUxptDJZdk0tLj76fbvHHxyKjin5DRW65lJerXd1XA=;
 b=M8ACiF+Z40nV2kfPMWmfRNg0aFDQ6MfxcUKcbrmm0fFTj4WteAGoX1LprjncXN7ITCr7BnFomISt6yopm/mhxom+LdZggO07f03xjH98ItiXs2C5O5p29aSxg2//mDPvEZLnVaTqT4KvEkA0hzyuF1okTtxYrzQVOv4bDu1appfyC9XiqL0zDYvOt/IK7mjWWc3+9YeBtt6F/O99JJY8ryvaHR96sQdYx5+kC4jAj5fgk0a3JSmzJ6TckFuHoZh+tk/mPfHO00z4Yo5pspT2s+8Hf2ViuFrqPi7CLs5Mh8ulWyc/OP2ZsLKqdqd97A53fa5w7RXDpS/qiBXTUKmBvQ==
Received: from CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 09:22:32 +0000
Received: from CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837]) by CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837%7]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 09:22:32 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: Bruce Richardson <bruce.richardson@intel.com>, "NBU-Contact-Thomas
 Monjalon (EXTERNAL)" <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ori Kam <orika@nvidia.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: RE: [PATCH v2 4/4] ethdev: fix promoted flow metadata symbols
Thread-Topic: [PATCH v2 4/4] ethdev: fix promoted flow metadata symbols
Thread-Index: AQHdA9uLoXB+Ivd/H0uH/lYFtYiQw7ZO5TiAgAAbHsA=
Date: Thu, 25 Jun 2026 09:22:32 +0000
Message-ID: <CH2PR12MB95411641F9919F10450EF4F6A4EC2@CH2PR12MB9541.namprd12.prod.outlook.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-5-dsosnowski@nvidia.com>
 <CAJFAV8wZhj+WRGY5sWYQSHFHA_7XNhCNS7Hqf5xSzAEt3U6z+Q@mail.gmail.com>
In-Reply-To: <CAJFAV8wZhj+WRGY5sWYQSHFHA_7XNhCNS7Hqf5xSzAEt3U6z+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9541:EE_|MN0PR12MB6053:EE_
x-ms-office365-filtering-correlation-id: 154d7da4-b0bf-4220-216b-08ded29b4960
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: rCv0uGZX3tqGTFC/s4JunUOEs2NC7yxhPRrxIad+qpNdXXZAkUKqk3D0vIRkZfBaL7IuLpGwZs9CHmhuoNdsUHXkSjYFydnWcWgCKs/NI6UaUku7udPd+a/WWbZyGSX0/iOBv+Aap2M4pDCDwTnzdsi0mY4Vu4KpOOH+P5m1Y7QTpc3iYpweKL7zZYXO5oNbuq+krni+EmOnaFHcK7fvUjw0xWltL1r67k1tv6fHm/+hN6s9KZ3cIZxrxXCYgYPfLqahBdvFsxE4AEGoicV/p19PrAnv+v2XDrE07wO6CRq8GjuR/AtNtLlBIfGCBXwhDI+gcwK7XYpZVYR5zlkOlI05gjs4luqN0BaZYcRitOz3dr8GKG+jMnPqsb2qc3M54SEjpPdw2rVThEUjXKTTFWcknjVimHxzHPdWwP8CNFeEIgYnf/J7ELX1FVXN2aMU4ng67PzCHWzR6YubHca3uMvRfRxKYVxVNMTQClJXdu2WPcidGcffM1WwNSCK76xYyP+yohhtoWbv3tWymzrL6sfmNVWGU0XFz5Kv1uKqUDQ51DiRXS7oo8PX/6RXon+HacemO9ZV/Oa4WUtGw+UMHT1ixFrSF6rr2xEOHhdPUhRsT4I84j/+24c156srec6p6/t21idjs9lcHPVg+MJ7ovDB/d9NrWxBWwFnOYIJnGHMEbNp1Q4T+2bjwzarPATrXFyfBIeoEckW73aw4Ch6RX8VDEw/dctC4/SsRl3DhSE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9541.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b21xZ2hjN3QrOERMNlF5bjZKamRsaEp1Y3orcUg1aXViNFpBRkZ3NTZTOWdt?=
 =?utf-8?B?c2o0cERxOHZjMEFvMENTakRBNE96NUNIZHJjeEd3S0FRckZMa0ljeUtPV0Iw?=
 =?utf-8?B?REdZNWJFOXFBSEJ1NzdpcnJrUjUxdVN3eTUxUTdaWUVPYWZuUTBvdldzM0xw?=
 =?utf-8?B?YjBZSFFIblpxOGZzbFJKekdqeHFHY25ld2x1NldyTEZPNDEwVlc0NFd4QmVE?=
 =?utf-8?B?SFlpWmFrUklUWXB3L29RZy9WalVhcXp5SkJXYWQ5d3VONTdDSjlJa0lJeHBL?=
 =?utf-8?B?RU9aKzdNN2hPQlZ1bzNHTFFIRExySmh0OTY2ZUpqakx6S0lvRTZpQkZlaXFp?=
 =?utf-8?B?TE9BaHhFelQvcEdtci94cXFUa1BzWFdsVmRnZk5oZHU1LzRhb01wbjhNNitS?=
 =?utf-8?B?dVpGN2RyTFJnUVBjZHFyNjN5a1lmWlJvZTZXenNvOVBndFU5UWdLTWFuL0ww?=
 =?utf-8?B?bXQxaW9saHRUa3YxVlgxbEpVM1JoOHlSUnZpNi9tNjlteWdqZE1TaUNhM0NJ?=
 =?utf-8?B?Zkp2WHJocC9YMVRnNFJha2VRM0hpUHYwVEx4djFXdW85VjdJTE9hZFY0dXNU?=
 =?utf-8?B?ZDdGbUl1bWFzaTNJbWtxMmY2RE9IK0hwL1pHaHFIbXFRK1NOUi9mMS92K1di?=
 =?utf-8?B?cTEwaWxHckNyZG9MODhBNzh5bVRMRG5VR01kWU5lWk1hQzlQWXZBbVB4WFhB?=
 =?utf-8?B?V0xaNVZzUU91RmI4U25zelRraHF0dFhkTjVvVVZERUpzN0RUNWhWeDlwa09Q?=
 =?utf-8?B?dllOTmp4ak51aVE1VERQRU5YYUxOZjBOQklra1FCMTVjaU5uOTBIWkw2aklR?=
 =?utf-8?B?dVRzSHd5VzBtTDJ5dzZKeUcxeWttSG9hMVFqUS9QdXd5K1l3dEJZYVZKZlVx?=
 =?utf-8?B?bHFjTmVVK2I3UE01N2lXbzkrU2dKY25JQlBEb0xkVDNkQVBpZm5BRTRKdjZ4?=
 =?utf-8?B?aFQvYytIdmVlNGdIbS9obXlxUmRPWElDV25pRXlzdUtzYVhXZENIUnpzdTVC?=
 =?utf-8?B?eEtkYnVCWURkRXRZWXVBV1lsR1JZUzQyV1B3TnRncGhmRHBuTEt5VDQrVTRy?=
 =?utf-8?B?Vk0wR0E3ZEJzdjYwdkI4ZDQzY3dKRXZUcmw3VS83dldJdEUyM242WXBYMjBK?=
 =?utf-8?B?Vmk4TUQ5NmlmWjRYalhXRDlaWVp2NkwrRlhlb2tuUGx1OXRmOXRhNnBBUkZ6?=
 =?utf-8?B?Sm5NY2xZSUxjcVp6UVdFTUxwK1k2S3RETHhHQnRwQUtQNWV4MzhaUGppeDVa?=
 =?utf-8?B?MmpKZm1lWVRTbWs4bjNpd3NUcHhid3ZwYmxNQWJZek95cGEraSt4VzRkdSt2?=
 =?utf-8?B?TzdZL1Jnd0YzOEJtSWZVODY2dnhPRnRsUkFjY0YzQ3lNNmFYWTV5c2xMUkxz?=
 =?utf-8?B?dHY4VUMySGhOKytZbzFReWFzVG5kaVdWenFLVFpCZ1pBc1phbVc1SUJJYzNs?=
 =?utf-8?B?NTAvRjl6T2Y4Nk9QeXZrNVdickJhQkUyNHlJYkxtUHVVeVZEM29JVlREckJZ?=
 =?utf-8?B?T0VsdjEwczF5RDBCL3NKVUVYTzZMcnB3cjRkUFF1enp6T0lSa3pCRlFLQ2dK?=
 =?utf-8?B?anVBVEtoUWdmMTIrU1kxbkdicU1RY2gza1owNEM4M2QvdmYvZmkwUFVzd0Rq?=
 =?utf-8?B?NnJzOEtpS2sxSmtqQTZYMHBuWUVycXNQdm1Ed2xOMnpiREFBcXJ6UE1FZEhT?=
 =?utf-8?B?RFBLQXNBWk5NWlQ5WUx5WHpZajlTMDJzV0dIS2lsbmVyVVZwc05zKzJwUEZQ?=
 =?utf-8?B?b01rR3J3MEliK1ZFWmVaUGJYSWZLM2t6dHhFSHNIMk5uaUVWUXlhY0EzSW8w?=
 =?utf-8?B?bGJwZTNuZWlRWWxhY2FwT0QwL3pZQ0YvblNJTUc0czR1UmtvdTRmckhIaGZ3?=
 =?utf-8?B?MlhxVG5yNXJoSE15a0cvOGx5THE2YmtjNTNoTGY4WGoxNUdEbkFOVWgzWjNO?=
 =?utf-8?B?SVYwbml0UTlPT1VZK0ZqVENVYWZJazNtRUNMRS91dTN6eDArajFpOG5QL2Zo?=
 =?utf-8?B?bEgveFdIZTk1TDZYSjlteWp4cENSRmx4OGZBRXBPYVB0OW4wUTQ2akVoOUxE?=
 =?utf-8?B?eEVZeWdlTmNCcHZhK29qYVlrbDZHVEphZjlxUE9Ld2M5dEVCSERUVGNQdUVu?=
 =?utf-8?B?Nm84bXBpeDNZbnNyS3VLQk1jRmJLckMrSnhZWC9JTkVMME1sM0NqR1ZkWmlu?=
 =?utf-8?B?citwdVR5YzNnSVpOMkd4ZGo2Yk1iT0dWZGRiVFExVzBndzJOTytKZ205YUpn?=
 =?utf-8?B?alRYYnhlbDJiRjFMTGVyVFJnWmViQ0FNRUtEOHkzRHpCc081U3pKZCtSK2Nl?=
 =?utf-8?B?SlpXUW9CQThkL1U5bTBoRzd2NzZaY3lpek1yMklwU0swYVptRTZUZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154d7da4-b0bf-4220-216b-08ded29b4960
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 09:22:32.5402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uc7MEfbyw1OvchWvqKyA58eJ+LymGgO4bjejxLCLKQ4IBi+Gjyl7mbqZTYf4jgVJUoYlHwImb+sbeGN/K+xDkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
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
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDI1LCAy
MDI2IDk6NDUgQU0NCj4gVG86IERhcml1c3ogU29zbm93c2tpIDxkc29zbm93c2tpQG52aWRpYS5j
b20+DQo+IENjOiBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT47
IE5CVS1Db250YWN0LVRob21hcw0KPiBNb25qYWxvbiAoRVhURVJOQUwpIDx0aG9tYXNAbW9uamFs
b24ubmV0PjsgQW5kcmV3IFJ5YmNoZW5rbw0KPiA8YW5kcmV3LnJ5YmNoZW5rb0Bva3RldGxhYnMu
cnU+OyBPcmkgS2FtIDxvcmlrYUBudmlkaWEuY29tPjsNCj4gZGV2QGRwZGsub3JnOyBZdSBKaWFu
ZyA8eXV4LmppYW5nQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA0LzRdIGV0
aGRldjogZml4IHByb21vdGVkIGZsb3cgbWV0YWRhdGEgc3ltYm9scw0KPiANCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBPbiBXZWQsIDI0IEp1biAyMDI2IGF0IDE1OjE1LCBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25v
d3NraUBudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9mZmVuZGluZyBjb21taXQgc3Rh
YmlsaXplZCB0aGUgZm9sbG93aW5nIHN5bWJvbHMgcmVsYXRlZCB0byBmbG93DQo+ID4gbWV0YWRh
dGE6DQo+ID4NCj4gPiAtIDEgZnVuY3Rpb24gc3ltYm9sOg0KPiA+ICAgICAtIHJ0ZV9mbG93X2R5
bmZfbWV0YWRhdGFfcmVnaXN0ZXINCj4gPiAtIDIgdmFyaWFibGUgc3ltYm9sczoNCj4gPiAgICAg
LSBydGVfZmxvd19keW5mX21ldGFkYXRhX29mZnMNCj4gPiAgICAgLSBydGVfZmxvd19keW5mX21l
dGFkYXRhX21hc2sNCj4gPg0KPiA+IEFueSBhcHBsaWNhdGlvbiB1c2luZyBleHBlcmltZW50YWwg
ZmxvdyBtZXRhZGF0YSBzeW1ib2xzLCB3aGljaCB3YXMNCj4gPiBsaW5rZWQgZHluYW1pY2FsbHkg
YWdhaW5zdCAyNS4xMSB2ZXJzaW9uIG9mIGV0aGRldiBsaWJyYXJ5IGFuZCB1c2luZw0KPiA+IGN1
cnJlbnQgdmVyc2lvbiBvZiBldGhkZXYgbGlicmFyeSB3b3VsZCBmYWlsIHRvIHN0YXJ0IG9uIHN5
bWJvbCBsb29rdXANCj4gPiBlcnJvcjoNCj4gPg0KPiA+IC90bXAvZHBkay0yNS4xMS91c3IvbG9j
YWwvYmluL2RwZGstdGVzdHBtZDoNCj4gPiAgIHN5bWJvbCBsb29rdXAgZXJyb3I6IC90bXAvZHBk
ay0yNS4xMS91c3IvbG9jYWwvYmluL2RwZGstdGVzdHBtZDoNCj4gPiAgICAgdW5kZWZpbmVkIHN5
bWJvbDogcnRlX2Zsb3dfZHluZl9tZXRhZGF0YV9vZmZzLCB2ZXJzaW9uDQo+ID4gRVhQRVJJTUVO
VEFMDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHJlc3NlcyB0aGF0IGlzc3VlIGJ5IHJlc3Rvcmlu
ZyBFWFBFUklNRU5UQUwgdmVyc2lvbiBvbg0KPiA+IHRoZSBnbG9iYWwgdmFyaWFibGVzIHRvIGtl
ZXAgQUJJIGNvbXBhdGliaWxpdHkgWzFdLg0KPiA+IFJlbGF0ZWQgaW5saW5lIGhlbHBlcnMgYW5k
IHZhcmlhYmxlIGRlY2xhcmF0aW9ucyBhcmUga2VwdCBhcyBzdGFibGUNCj4gPiAoaS5lLiwgbm8g
X19ydGVfZXhwZXJpbWVudGFsIG1hcmtlcikuDQo+ID4gRVhQRVJJTUVOVEFMIHZlcnNpb24gd2ls
bCBiZSByZW1vdmVkIGZyb20gdGhlc2UgZ2xvYmFsIHZhcmlhYmxlcyBpbg0KPiA+IDI2LjExIHJl
bGVhc2UgY3ljbGUgb24gbmV4dCBBQkkgdmVyc2lvbiBidW1wLg0KPiA+DQo+ID4gU3RhbmRhcmQg
ZnVuY3Rpb24gc3ltYm9sIHZlcnNpb25pbmcgaXMgYWxzbyBhcHBsaWVkIG9uDQo+ID4gcnRlX2Zs
b3dfZHluZl9tZXRhZGF0YV9yZWdpc3RlcigpIGZ1bmN0aW9uLg0KPiA+DQo+ID4gWzFdOg0KPiA+
IGh0dHBzOi8vaW5ib3guZHBkay5vcmcvZGV2L203czNqbDI1NjZraWJiYXByMm1mYTJpYzJvcHVj
NmI0b2syZzY3ajNpbDUNCj4gPiBkZ2R1emloQGN6NXdjZHN0Yjc1bi8NCj4gPg0KPiA+IEJ1Z3pp
bGxhIElEOiAxOTU3DQo+ID4gRml4ZXM6IDRlZTJmNWMxY2VkZiAoImV0aGRldjogcHJvbW90ZSBm
bG93IG1ldGFkYXRhIEFQSSB0byBzdGFibGUiKQ0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IFl1IEpp
YW5nIDx5dXguamlhbmdAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhcml1c3ogU29z
bm93c2tpIDxkc29zbm93c2tpQG52aWRpYS5jb20+DQo+IA0KPiBBY2tlZC1ieTogRGF2aWQgTWFy
Y2hhbmQgPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IA0KPiBPbmNlIHRoaXMgc2VyaWVz
IGlzIG1lcmdlZCwgY291bGQgeW91IHNlbmQgYSBwYXRjaCBhZ2FpbnN0IDI2LjExIGRyb3BwaW5n
IHRoaXMNCj4gY29tcGF0IGFuZCBtYXJraW5nIHRoZSB2YXJpYWJsZXMgYXMgc3RhYmxlPw0KPiBJ
J2xsIG1hcmsgaXQgYXMgZGVmZXJyZWQgaW4gcGF0Y2h3b3JrLCB0aGlzIGlzIGp1c3QgdG8gaGF2
ZSBhIHJlbWluZGVyIHRvIGNsZWFuIHRoaXMNCj4gdXAuDQoNCk9mIGNvdXJzZSwgSSdsbCBzZW5k
IGl0IG9uY2UgbWVyZ2VkLg0KDQpCZXN0IHJlZ2FyZHMsDQpEYXJpdXN6IFNvc25vd3NraQ0K
