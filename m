Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAEF606A32F
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Pqs6TvfL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CE64400D7;
	Tue, 27 Oct 2026 12:20:57 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
 by mails.dpdk.org (Postfix) with ESMTPS id D476E400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 12:20:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3mtuThOCjP+cr7MBzHUyGPz9XGD98PcjqNrX1OikVBJwQK91L/0iR9iChVgqpKsLZAkz/krnYI/Ijfe6uzFvHXeTJj8fccv+PFgvmT4gzJxSP+aj23OI0+UQE2yDzfsWV1JA3zw5hGFq+gskd0NZA1OZSlvXGZGGLgANgs6z0IyCSGtiVb1qkAdfit2VNbWinekwS4tzrtTVzuntXthTSa7+cX0U4/504iCNAVZ8vFAe4GjrVtv6ap38+LmUn7Vqrq9u8eufxuSq9uGoezss4XVGjjwKrd8LUWXIGhDG8BihLJSfvFU1ROo0NSZ1+qFBg10VjkPOLVxMI5NaXEeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Jkf1ZHovo3fbAJVVHIlzq6RN8sqlk4/KTlNSPmlS/Q=;
 b=R0bJ4lZwKMP/8BPaqU3KetREoLCMZk5e6tDucIJnd5+WWCKRAUahNJpOf6XqTUltObpPdS3MhvmIV3Ld+Yh321OyBcrk/XyZEGp8vQtVBHsMXHj+RzLqBadHWW/gHF0XDuf2IULR89s6J3v3fV+WAXcRuS2ZJcXme8ABQ0FrMQfR4wUmiy6XESy7xRIf6jhCaz1oC4mhFPsbQ1wOc3VpKv3lHPfY2kOOnjvnGf393C4daZvKdSzurb2vpFUFX9gkbK7tKsXb0Xa5lfNvAKnaPxnPpLAZLHVQFIQadabOPsw+vcpDCrUfQQIOZCZO0+uezVfv8/mlolUcQrwthPcskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Jkf1ZHovo3fbAJVVHIlzq6RN8sqlk4/KTlNSPmlS/Q=;
 b=Pqs6TvfLGIw5DFAufXkdJ3RQb9CVdBnD0q1aHI2WHqq1FHFZ7fHPLA0n/hcpAvXCZtQMJY2FRwlADzqTIIY3gUzf4pNI5z+RRyrcm02O/834T/9dBFfAKBnM3qhs2IxKvDZs27dYxFZH3euawA44Rh0brXz6MNolDuc9pPnG7azWZJzPjYX4UtU3+DG67km1DSQFi1mNO1VYslHhWvSKgK4Piq54KMy6qCtFR4sY8AlIpzEko331nJ4qDgQuU0EflZFqYC2511j4efC4XFeXb/eXKL5TqVkBY0KygTmLz/Ac0RlagaMUcHxsoxIiyTeaB3SsyPlFHMz/WH/FT7YxbA==
Received: from AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19)
 by GV1PR04MB058055.eurprd04.prod.outlook.com (2603:10a6:150:3c0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:20:54 +0000
Received: from AS8PR04MB8293.eurprd04.prod.outlook.com
 ([fe80::44ae:6a51:3b80:4418]) by AS8PR04MB8293.eurprd04.prod.outlook.com
 ([fe80::44ae:6a51:3b80:4418%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:20:54 +0000
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: David Marchand <david.marchand@redhat.com>
CC: Hemant Agrawal <hemant.agrawal@nxp.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXT] Re: [PATCH 00/16] Device unplug and bus cleanup refactoring
 for NXP
Thread-Topic: [EXT] Re: [PATCH 00/16] Device unplug and bus cleanup
 refactoring for NXP
Thread-Index: AQHdXAMSNSOrYyw/Ckauj6Ac8xGWwrcDIIOwgAyDayCAAI6ogIABHRGA
Date: Tue, 27 Oct 2026 11:20:53 +0000
Message-ID: <AS8PR04MB8293761B787C44B139BFE8F1E5602@AS8PR04MB8293.eurprd04.prod.outlook.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
 <GV1PR04MB10750AE0102EC1FDDC8E2E0C389992@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <AS8PR04MB82937F10CD26FDD07AA3AFABE5612@AS8PR04MB8293.eurprd04.prod.outlook.com>
 <CAJFAV8yKvC3rzwvK1LfraGx+ztV3Y_WNqiscom3JQTTj7uiPFg@mail.gmail.com>
In-Reply-To: <CAJFAV8yKvC3rzwvK1LfraGx+ztV3Y_WNqiscom3JQTTj7uiPFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-27T11:10:56.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8293:EE_|GV1PR04MB058055:EE_
x-ms-office365-filtering-correlation-id: c20af682-03dd-402b-7393-08df341c5d59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|19092799006|1800799024|261022075727099003|261022105027099003|10067099003|56012099006|261026140227099003|18002099003|22082099003|261026121527099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: EjrrZ4LiE4SxKy3YWqvCork1sNsSJL2f92lpQSDsQqsIgHyIqLwc/LH90j8lx5tYjULi0MPw0o7rYgE1c7yQZeps8aOtxXBL1I0w93KKuQRk8t0c3BBHvkyl/gaE7DU+KUZsRuUwCH/nDOEG3D7gZT77jlDn0k4yirtD7m1+nuNNYXHPYwj+uadxayKFBwVS/1Jhr5NPRC2VMO8Od+T/9oAC4kkZoR49nFUYRrAYbVM3RZjlvMHCd/9dm5UQgOVuvD8/HeDD3o53Rw1XEFtcHwolUWA/WGAxNjSAfvdqRL/aFR0T6Fwo69h9Lj3zmxiU3HIrpz95p8XZ7DLS5t/QCnOSfdlE+dyYAtVgyhq89UT01950S9UjKOVjqxELaSpdtCSdFIVOdwGJxCmlPDmVxFw1NMde87OoUyfwa9eDgsVvU6Hz8XtGkIgRA60iw1sPGFF5skLSy7m6FWCqF7NVBXZFHJlOcyy4bBg3KXKW/rfIsr4qjRu5B1CA0ofzjXfXapV0jyRXfCdGYACwf3rvL17EZjUS/uT3/iM9q7R5kLOrItSUS1CVyUPrv9AhPfe3DazDJdhlkei3SBa4By/M4+JYg4WxzoXHO+i5KtmBk5K+TbiYyIujlKJ5gB8Chm6F1+u2QDy4AllHy6YrYe0tIQyfsZCmpb7GtIJrUqE2a4DLRc47mOnCPMQxfCq6S3Ab/KLUQW4RyMREKo3uD3zR2s49mQHrYD9W2/IW00ZaEcw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8293.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(261022075727099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(18002099003)(22082099003)(261026121527099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1d4UWVSMm4xSytjZWJrbmVxZEhIWE1yM3NRZEpUejFhMVZ5Y1JDOWxXMGwr?=
 =?utf-8?B?Y3ZpRTdMbVBOMkRVV3NqaUFxMlVQbzcwb093SUtvTXBuYzhmQjZnLytVbXJX?=
 =?utf-8?B?ekNIVGhKeHRJNjBsRGJ6clNZSlRwWFUvSjdBR1Fnc3pwT2NoTDl5MkdjSGl4?=
 =?utf-8?B?S0k0UnBtcXdhR0l3WmRmOW5EeGVYUytLb2c1S3hVVVcxSnBTYktqVHJCMUd6?=
 =?utf-8?B?dWZxYjlsK2FTVGF5ZXZxdHNZZlRLemFMU1lyZzIzeWllME1heENoWHdOMnRh?=
 =?utf-8?B?czY4aEJWMm0vdEVBcjcrMXovcHJRbllRVWh0U01OTHNVcHhpYTVFQUNvYWFZ?=
 =?utf-8?B?QnVzN3Nxak1EWGZyRVltVnNvTkx2a1JWNG9najdPaFI0b2xvaFVMcVJ4NDVD?=
 =?utf-8?B?V2wzMURRTERVKzJzV3BNN2JtakJ5NHNXZUp3b1ZKUFRsM1hmbzdFN0F1U1gw?=
 =?utf-8?B?MWtqTElsN1RmeUsrbjM2cERMZ0tUb2lQR1ZtVHJrSGE4WkdMM2xMTGlXUVlF?=
 =?utf-8?B?K3RyOWJZOHNlbGtqZkkrNUlrTGFrb0xJUXIrcnczaUdDNWtGN1E0aDRKQ1o2?=
 =?utf-8?B?WDU2RmtQUllmcFp4N0ZpWmh0Q0hvUnV3OW4yMGdGOVk1R0F3OFcxVDU2Y0Nt?=
 =?utf-8?B?eEN3UjYrU0k1SGRVeEZJa0ZDQ2Q4eVRWd2dyS1RjQWhIU2lkaFZiaU9hU0dJ?=
 =?utf-8?B?L3JFWjlEaE1MUklGZFZ0Tjh3UjlVTG1hQVNHd3dGNlhvbGFhMDdWT1VnWHhh?=
 =?utf-8?B?d3RoK1JJZk4yMGlZdW5QY2pDMXFta3N6ZS9JL2NJektsaE4ya3BMSDR6eGhi?=
 =?utf-8?B?Rjl4bitxcGtiZjhxZDBIV05zMUt1ZXd5Zmd5NVhmQmlXa1N3QVI1NjBkVTZR?=
 =?utf-8?B?eFRWRldQb3piWWE2MzNZcXF3WkxSRStEUTZLVERPK3lMRHEyMi9vc1JhT2NS?=
 =?utf-8?B?NTM0ODRyZXZkeUhXYWdxVzQ0OW1qbFZ4Vk1vWFNreWlKV0IwcXNjekE0Nkdi?=
 =?utf-8?B?b1BwZDRvcmRiRFZrWjdkQ3Y1bVd5WWtqeWFrd3djcUlOT25HM0p3aytqVUhW?=
 =?utf-8?B?cDc4Z0RrQXUxa0lhNG95K0FKOVhoTTBWZnlzOWNSK1dxbk1QRk5SeEhlOTFX?=
 =?utf-8?B?VjVQbjNMUzBJcDloVFR6NFl2WUNuT0pXb2tETFF5YVM2K1ZUdjd3STNBRG4y?=
 =?utf-8?B?dnZrb3hjUjlqWS9sTWFpZDNHbVJxRUVuYWt3VEQveTJhbWd4SDMvTkJVMmg1?=
 =?utf-8?B?ZUh6eXV4UEx3RUdVNTZscFFKblM2dnY2NEFpaEV4cmhkOTZUSUpvNnRXbXZv?=
 =?utf-8?B?OW9STHNSaDBwenFlNFA3UTBuRE1PRm12eHRDWXo5NWp3ZGN0d0lsL0FUekxD?=
 =?utf-8?B?RzE1YWRkY3RWbnlMVlJtQ1NjbmJBR2NQMVJaL2ZYOXFDRmtydU80SmY4L3Qx?=
 =?utf-8?B?N21GSHBOa3E5dlBDVUdSSDFQWEM3TmRKbDh3V0p0SUpiY1hDN2hsQkNGd3Uv?=
 =?utf-8?B?OUpqZHFXVEk0SW9oYnlFZy9iU0xFZUFoVStHRldPUExpeU16WXRuMEdHUXlz?=
 =?utf-8?B?M3liRWMyckpzNmkzU0kzdkZQVE91L2R0N1VROE1VYVhENVpjaXpLWGVvQXNQ?=
 =?utf-8?B?ellRbStFU2FEQlY4MVVpaXN0WllLeXo0TytoWnlZSVA2S20rTUdlK3lyMHlw?=
 =?utf-8?B?RGlDNGxuMmdRbHh2M3JKM3NRcjVVcWxrODFVRFZsNWw4WGo5clZScm1xQXdS?=
 =?utf-8?B?cEtIbWNqdTE0RXZiTm45aDVUSnMyZElidFBReWpWUXpnVFFzTXl5MndtZ0hj?=
 =?utf-8?B?T1hzS0lxQk9NNU9YSmVxVERMNTBoYlorZVQ2NFVwNUZpT25UM3RSOThLRU1v?=
 =?utf-8?B?aHhKbTl1U2hhaE5yWHEyeEtSS2wrUFlleXpXU09WeEVTVGRiZ3hqYjdORXMx?=
 =?utf-8?B?VHRscnBjcGdZR2pwbTJEWDJBZGRwMXNmamZER040R0F6M1F6aTNYVGQ0UmxL?=
 =?utf-8?B?dkptZDFWOXNwRlhETGFhNWk4OVdPVXFaSk1rd3FpRHlOOENTZVZkWTRqL2I1?=
 =?utf-8?B?YVl2SWExZ2wrY2RuN3pPUHpNdFN6UlVENEgxc0RFbTl4OFlVMEtveHptM0lz?=
 =?utf-8?B?a0dPMVkxSmpYRTVxRVpieDhJQU9RcExxaDk0SlNvb3VhS0FaL1I4VTNRa1ZV?=
 =?utf-8?B?Mm02VXJmV0ppaHVOblBTZmVpOVhvaGlrSUdxMEFoOGgvYnJYc3JlWmNJTW5V?=
 =?utf-8?B?R2cxK2dKTkVnNnJabnJnTWd4UFFyYnJaMjk2UHFNaTlTVUpTNTRvVUtTYkU0?=
 =?utf-8?B?V3NUYmhBTTBrdXZVVEJPVmxTRlRJeU9OZm5sczcvWmVnQkJGT0RSZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8293.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20af682-03dd-402b-7393-08df341c5d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 11:20:53.9326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1avOoHGyjReDMC2uiYuoRNc1D8VbSx9Qy2BN040dnwgBG1s1CpMJLoV18NH4PBbvs91TOPxWS/THaMZVi6gWe9JJT7caZuh5UQ0M77+/Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB058055
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgRGF2aWQsDQoNCkkgdGVzdGVkIHRoZSBwYXRjaGVzIG9uIG15IHNpZGUuIFRoZXkgd29yayBj
b3JyZWN0bHksIGFuZCBJIGRvbid0IHNlZSBhbnkgaXNzdWVzIGR1cmluZyBhcHBsaWNhdGlvbiBj
bGVhbnVwIG9yIGNsb3N1cmUuDQpUaGUgY2hhbmdlcyBsb29rIGdvb2QgZnJvbSBteSB0ZXN0aW5n
Lg0KDQpUaGFua3MsDQpQcmFzaGFudA0KDQoNCk5YUCBDb25maWRlbnRpYWwNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVk
aGF0LmNvbT4NClNlbnQ6IDI2IE9jdG9iZXIgMjAyNiAyMzo0MQ0KVG86IFByYXNoYW50IEd1cHRh
IDxwcmFzaGFudC5ndXB0YV8zQG54cC5jb20+DQpDYzogSGVtYW50IEFncmF3YWwgPGhlbWFudC5h
Z3Jhd2FsQG54cC5jb20+OyBkZXZAZHBkay5vcmcNClN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0gg
MDAvMTZdIERldmljZSB1bnBsdWcgYW5kIGJ1cyBjbGVhbnVwIHJlZmFjdG9yaW5nIGZvciBOWFAN
Cg0KQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3
aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQs
IHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzIGVtYWlsJyBidXR0b24N
Cg0KDQpIZWxsbywNCg0KT24gTW9uLCAyNiBPY3QgMjAyNiBhdCAxMDo0MSwgUHJhc2hhbnQgR3Vw
dGEgPHByYXNoYW50Lmd1cHRhXzNAbnhwLmNvbT4gd3JvdGU6DQo+DQo+IEkgYW0gbm90IGFibGUg
dG8gYXBwbHkgdGhlc2UgcGF0Y2hlcyBvbiBuZXh0LW5ldC1tYWluLg0KPiBDb3VsZCB5b3UgcGxl
YXNlIGNoZWNrIGlmIHJlYmFzZSBpcyByZXF1aXJlZD8NCg0KVGhlIG9ubHkgY29uZmxpY3QgSSBz
ZWUgd2l0aCBuZXh0LW5ldCBpcyB0aGUgbWFjcm8gY2hhbmdlcyBvbiBkcGFhX2J1cy5jLg0KDQpT
ZW5kaW5nIGEgc2VyaWVzIGJhc2VkIG9uIG5leHQtbmV0LW1haW4gd2lsbCBsaWtlbHkgZmFpbCBp
biB0aGUgQ0kgYXMgaXQgd2lsbCB0cnkgdG8gYXBwbHkgb24gbWFpbi4NCihidXMgZHJpdmVycyB1
cGRhdGVzIGFyZSBzdXBwb3NlZCB0byBnbyB0aHJvdWdoIG1haW4pDQoNCkknbGwgcmVzcGluIGZv
ciB0aGUgcnRlX2ludHJfZmRfY2xvc2UgY2hhbmdlcyBpbiBtYWluLCBJIHB1c2ggYSByZWJhc2Vk
IGJyYW5jaCBpbiBteSBHSC4NCg0KDQotLQ0KRGF2aWQgTWFyY2hhbmQNCg0K
