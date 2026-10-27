Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB260A261D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=XmMMse92
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C8B9400D7;
	Tue, 27 Oct 2026 13:36:05 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 30E5B400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 13:36:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNiL+3qLFpakfR4MH5XqIEk19GHCB3z0egtBl+/ggX60V+Ql9+W9G89gfefcro38xNN0o+jG5Yo6c8nf5TYA49jbMG3KyKENa1MBQ9qFJLyfmxZsqbjFOjCd2plI5TJ0ROQfM0j1Irk6EI0gxALvhmXIwl/3AEDf0cqpUk87H4djEiXZ7Nx3THvW3p7jGqJ8Nx92lgjxo7/qqjijbGC4pyE3AwVpGtagksjcYyTGnafaMufCVds31P1LevCxWl/VB8fk9TmDNwh8EgpUBbugweGVOjHowOcCd6mwbFTVq6wHJh9dF2hoqUSdxhI49vMczpT0y4tP0j63HFhQ5rv2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGIvrpPSkkELMHO5bsKd2N2V99vvA3bGKME85KfFUrQ=;
 b=Aw9hYH5NluJy2+Nvwwop1TVRc+Jis2k880FiiIwVUyAjxXEfXKEKDbCFBl9Dl1HlCC62i6YMmafd3lpD2S0tdyPgzIF8mpfP4Os+meO+m6mGmYkrYK9nS0nR8DKcBPMz7t5GLnkco+mYKuZcW7JpZTRwH0fWVyv29N98XUFCtEuIVtomVkVE/uca4LhjakLVVHwB9J5dYbgY+Ujuft7dNWYROPJgFWn7LZukd2x980+8APT4fvmPhK061FIT7Vz/ayGp99P91AH+bKJi9dcPX7orxIIek/RT6Je7/OaTEl0kLPw4hPBSSw4jtWijPGKYxrjTX83e4p1ibSNBaszY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGIvrpPSkkELMHO5bsKd2N2V99vvA3bGKME85KfFUrQ=;
 b=XmMMse9206V+Wp+leUnHjRy4x2vUwJsMrzSftcHykXRtscuYrAfNSEwK6b5U5XfCbs1GOmLE+n6Covikgbo5lSju4h4Cl4gYKZD660wW8EY1hy3bVKyEOhmydFDAixJk8EZYKtw9TwaRFYWALMp4LbRQUsX1mQoKiErCkRMWrQTlshtGdx7f/sbhgwsqVi7NUoSbuw9DK+7aJsq88i2ba0GuuAHt3ynBR0mGagrCvFb5NkoX2eK1Ul4nYgWHHWyCOEPGypFEDhoYIzyZGHg/PG2S/kQ6pjx6JRicfqxDAAWJA17UoyDYriXzmiQJXcu5NldaRDhFLO0OmZ0QDHs5OQ==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AS8PR04MB8183.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:36:03 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 12:36:03 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 00/16] Device unplug and bus cleanup refactoring for NXP
Thread-Topic: [PATCH v2 00/16] Device unplug and bus cleanup refactoring for
 NXP
Thread-Index: AQHdZXVQPjp84Ztqy0K0ijKht6UOjrcRVFcw
Date: Tue, 27 Oct 2026 12:36:02 +0000
Message-ID: <GV1PR04MB10750EE7246351EBD7792D46189602@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-27T12:35:20.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|AS8PR04MB8183:EE_
x-ms-office365-filtering-correlation-id: 19afabed-075b-4da5-eab8-08df3426dcec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|23010399003|38070700021|11063799006|4143699003|56012099006|261022075727099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: o/jZSezRX8Z19sym8KiXPlYI6CDxdGQCU+0UoOI+OuIJDqSOLoG1JIrxyPgVilS7lkKNmo6yT9VyupTWk22NKPZTLMz93sU9i4epUqsXiQag4KoxeBhkXgLMQgQeJQhUj6gKjW3Vu9PvqkFY7d9KTV/KlR42mvxr7/qjCO+LMIy7FcSNvtZbDUR0smC7n6zAUbBzV+DaRJwOIcjeYpPlJwbV9Wx5l+sot/LMeDOuDVSnISQ+t8JMNPf7eGUXLpueQULESHLz7j80vr7c3jVvRjftiidOCo2OcU1ULrJ0McZmeYTC+NRlkGrJlFbnrRxo/axK5RFk/m4tJzcKBFlk91longHant9ATPw5G5uZFXCyIqZXsgjPQiczB4qZDZhIAcW1u+fVYsXSmu+9pDXp5hYUzG6fP0MaOrwNX6kety8PIKQjHr+D69vpmq7uYLi7yfBT2tSdwKkibP9E+lvA8j9ajLSbntzynT3zM0AVOGRZcnubZKf6WasIoOmQQ8jyJLvywjcqPtIiQ5dq1/OlR1IPLO2WyWuDO6LchGpYa51MxqMjU6aziX1fYnVdH9xmj0ivOHswXtNDzFvpP7NXIbMT2w30XGlqxuFdiEW3OehTRddQ7Az62YfoY5T631IQy49NxE5qDAI60z2hK8XQo2lQ/CcU34kHbLcWvhpvSz/VFa0pV8PnMUoA6c5DVJs4ONk3BuPxi5b7wJsmjVl8HWbOsS/gxF83pvI2iIQ3tM0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(23010399003)(38070700021)(11063799006)(4143699003)(56012099006)(261022075727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2tmcnQ5VFlZdk9KRjd0Uk56MnpDZVo1ZHRqc2VCd1dxM1ZBNDZvcFVXUmEr?=
 =?utf-8?B?T0JlWnRkUFJ1NVllc2Z3Y21iQkJkeXFsRmFMZk1xOWNiUSsrbnovYkhCSlhR?=
 =?utf-8?B?ZFBIQXRQeDM2SStSZngxakl1ejRvdk1xTERCdGlFUWhIVGFBZ2N6RXkrZHBj?=
 =?utf-8?B?ZnJRWWhQNklDUWhzaHpNVzhKdFlFQUNWR09MbTY2NEczbE5kY1RQc0NuZkIx?=
 =?utf-8?B?TENmbVc2SGQrNWNDZS8zcXR1TWIvOGR5UGlkL1lzRTJSSzIzNTl6R2YxWXlz?=
 =?utf-8?B?dWx5RUNyMm5ZR2tSZ3hINmVtTm1SVkZ0bzQvNjRkeExiTW1laG1qZzQ2VFEw?=
 =?utf-8?B?MHhNM04yL2lJcnVnMitKclAybVQ4OFFiZ2xiZGxTOVFpaVlTVjBJb3RqRWw1?=
 =?utf-8?B?ZGVuR0tVS0d0c1BPVEVwamtIaXU3aFBzZ21ZZkV5TkVFeGlYWEhndEM4L3dL?=
 =?utf-8?B?Z21qSmtHYUJFalVLVHE4c2UxWGVtYkthT3MxWExLSVh4M1h4S2NoUGdScm83?=
 =?utf-8?B?cnJtc2dqS3UrRmwxb1JqdkVJOFZHaWdhK096cXBObUdTSnNLZEQ0c2RmSjZp?=
 =?utf-8?B?VTF6cnN4TytzMGFWbGJSU3FYbTlacEVhSmIveThVVmszWkIzeit1ZnRJQXF5?=
 =?utf-8?B?ejBlb2VFWjVlNHorMGk2WVBKcmZBdXAvRXkvNVJKSnF4MFNvMWNMOG40UCts?=
 =?utf-8?B?a0cxS2dpVUo3MHNmMTE2WG42dDFNSjhvL1o5cVNkMDl0OEFud05XaDVCcDBT?=
 =?utf-8?B?dk1VSlFSUWRyZ1pNZWZ0dm5XOHVJWDl6c3NYRXBLK3MrU0NMT1NyVTdFaVRI?=
 =?utf-8?B?N0ROa2VwSHkyTnBFYllLNzRmV05wM1FVY0VvMG56Sll2ZWFHQnlJeW5FSTEv?=
 =?utf-8?B?dEpidy8wUUgwcm5CSUNkcmU3eWduYjQ1T3ZsMVlReDVnM045cnlGTmxyMDcr?=
 =?utf-8?B?c01lVTVGMVRIeU1HUmdMRlpod3h5cHpXQ21NZ2JvOFlzaDBQL2prN1BaWEFt?=
 =?utf-8?B?bjhCYXBpQ2prZjRtYktBTkQ3aEN2S0UxMExjQStTZ1UrcVdBbWxEY1NPNDZY?=
 =?utf-8?B?eitLeDBaaktkdzBMSTVNU3UwWHBYSmZQZkZqeURKODA1KzFOQ1FxQXNOc0Ex?=
 =?utf-8?B?NkNnMHRzK2VDZW80TFNsUnNPVlhBV21hcTNxcWhuZHY4RHAxVUV6dzZFUTR5?=
 =?utf-8?B?NTV6ZmVSdGRHRUJKdy9LNHMrLzNTbWk2MW1ja1lvVTI5SWhvOE9rT2xIZFow?=
 =?utf-8?B?alVSTjNYSStqUWtwN1FwVStuYU1MWjhLSTdHRDY3SS9zQkUycGVsUzA3bTR2?=
 =?utf-8?B?VGJncUZGL25WZTFXdnJ0RHdYQVhjamR0UTMrSkU1K2RYbzVSL0p5aEpNVGxZ?=
 =?utf-8?B?Q0pabVFCNWZEREd3YldlVy8ySHF6NjljbzJOTXk1QmdrQkl3cEE0ZjZzdVVl?=
 =?utf-8?B?QXdTWHUwOUJUWlBsQTY4NWZnSUdKRWUrQlhoUUNkT3AzVk1ZMS9UbkY5Mlh6?=
 =?utf-8?B?a0NnZDFJakdHcTVrbTdCYUNLdE9pRitXTU1CanJkY2pzQkswVnI3OCtXVndm?=
 =?utf-8?B?ck8zYVdjQVFlWFVHYXdUaGhCczc1aFozbjZXSU04VXdudHk1UmlKeHNZZXMv?=
 =?utf-8?B?OTNKQXhHYjJCZ0NSNDFMSVUwYkFjbWJQbG03WU9ZRG5IL0ZuUDVESFR2RWxY?=
 =?utf-8?B?VlFmVm9GRmIvQ0J3dnhnRDJ6S0lkaEx1bzRmN1F0WDUvc3ZIL0R3N2xwa0RN?=
 =?utf-8?B?bVpYZGc4eEtvdy9yZW9qSjd1VzRhRjFqVnViTENPT3hESmNsa2R4TW1CZndk?=
 =?utf-8?B?WWl0Sjk1NDR0cnlqZytUVUQ5ck1qZ09FYytpM2JJS0x6TndGMHlEUXc1bjFI?=
 =?utf-8?B?Q25tRm85OThabEw5dGN4U1N3dkdnTlAxZW1KdDJQYlJvWFdYM2lOdFJndStW?=
 =?utf-8?B?U3B2OWhLVEhTMHJQT3pUSW5aUEdjNiswL2Y5WHhRVDhYcDIreDdaQVVkWnBw?=
 =?utf-8?B?Skd5WDZlWWlrY1hqanBOUE55YXdzZk5rYVVzZzcxc2VnUW9GaGtsOXJKOWZr?=
 =?utf-8?B?c1hRUE91bTJJZkx6N3N5TmpicFg5NGFndk81V3BWcG9DN24zRU5LZ1l3SVdk?=
 =?utf-8?B?Y1ZIRGpkcnRkV3JmbEFIMlhWU1RuYU0wa3UxQTdudUdpY3ZEMThqNzBKUGFS?=
 =?utf-8?B?MldsTzlpODdDVjNSRnVZbnozN1hRSzNQZVFDSzlyNy8zNXZFcUdTN2FuMzdC?=
 =?utf-8?B?WnZVMm1jS2pPRnREV2ZMbWZXU285ckJRaVpQUGxVODA0cWlqUUJ2Z0ZqQjZN?=
 =?utf-8?B?UlhmaEZ3VmpWc3lLZmd5cE5GY2VjdGhSSHhmRnRDRFh6UThkZkNUZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19afabed-075b-4da5-eab8-08df3426dcec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 12:36:02.9464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Weyiv+ZhvDzUQ5FMQAvmO5HI8nuvNENTUQ8CBTuZNPXyq6Gl7H9B3qmklkiAoCco/ZOcNwyjfyypStSL5aJQ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4NCj4gU2VudDog
MjYgT2N0b2JlciAyMDI2IDIzOjQwDQo+IFRvOiBIZW1hbnQgQWdyYXdhbCA8aGVtYW50LmFncmF3
YWxAbnhwLmNvbT47IGRldkBkcGRrLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMDAvMTZdIERl
dmljZSB1bnBsdWcgYW5kIGJ1cyBjbGVhbnVwIHJlZmFjdG9yaW5nIGZvciBOWFANCj4gSW1wb3J0
YW5jZTogSGlnaA0KPg0KPiBIZWxsbyBIZW1hbnQsDQo+DQo+IFRoaXMgaXMgYSBmb2xsb3d1cCB0
byB0aGUgcmVmYWN0b3Jpbmcgc3RhcnRlZCBpbiAyNi4wNy4NCj4NCj4gTGlrZSB0aGUgbGFzdCB0
aW1lLCBvbmx5IGNvbXBpbGF0aW9uIGhhcyBiZWVuIGNoZWNrZWQuDQo+IEkgaGF2ZSBubyBoYXJk
d2FyZSB0byB0ZXN0IHJ1bnRpbWUuDQo+DQo+IE9uZSB0aGluZyB0aGF0IGNvdWxkIGJlIGJyb2tl
biBpcyBlaXRoZXIgdGhlIG9yZGVyIG9mIGRldmljZXMgaW5pdGlhbGlzYXRpb24sIG9yDQo+IGJ1
Z3MgaW4gdGhlIGRldmljZSBmaWx0ZXJpbmcgdGhhdCBJIHRyaWVkIHRvIHNpbXBsaWZ5Lg0KPg0K
PiBJIHdlbnQgd2l0aCB0aGUgYXBwcm9hY2ggb2Ygc3BsaXR0aW5nIHRoZSBkZXZpY2UgbGlzdCBi
ZXR3ZWVuIGludGVybmFsIGJ1cw0KPiBvYmplY3QgKHRoYXQgSSBjYWxsZWQgImNvbnRyb2wiIGRl
dmljZXMsIG1heWJlIGEgYmV0dGVyIG5hbWUgY2FuIGJlIGZvdW5kKSwgYW5kDQo+IG5vcm1hbCBi
dXMgZGV2aWNlIG9iamVjdCBmb3Igd2hpY2ggRFBESyBoYXMgYSBkcml2ZXIuDQo+DQo+IEkgZGlk
IG5vdCBnZXQgbXVjaCBmZWVkYmFjayBvbiB0aGUgc2VyaWVzLg0KPiBJJ2xsIGxldCBDSSBwYXNz
IG9uIHRoaXMgbmV3IHJldmlzaW9uIGFuZCBtZXJnZSBpdC4NCg0KU2VyaWVzLQ0KQWNrZWQtYnk6
IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPg0K
