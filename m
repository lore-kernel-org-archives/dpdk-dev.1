Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E8606A322
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ericsson.com header.i=@ericsson.com header.a=rsa-sha256 header.s=selector2 header.b=DC2q//xN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C19840613;
	Fri, 30 Oct 2026 12:15:52 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013020.outbound.protection.outlook.com
 [40.107.162.20])
 by mails.dpdk.org (Postfix) with ESMTPS id AE18A40285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 12:15:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L74Y4wis67cuXtc9oun8TWcMb7m2XwZc0jJPk2m+N4Ayu/Vs4ptAeNmwBpPZbf4r6FWd+vJB5n4+gvMhL5e4W7r5Oaxr7E/hFrR+H0jTHiEBcI8W2uKBS/0+eUe8tPjqm+EeoTOCeM+C6XLMmx1XWmMopwbPTzP5/9a3oCSU449EZ7k2MTxn1sXHbUZe7gtpoPgHDBdySMYy93xG+l6T6xEAwg2lHmkYkBqxQGafMVsX9YuJx+uNe35dE6IAaAovLNVNrasOtLKoUxOEDoxx7JkLHv1d5nWb+XNKmQkXeclEdmqT+1ZQGNUIuv2VgRPLdsnl4abcZhwAE9m4MfRQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl1ROUjrnUrKlGSbTypzzOIAWYUbIgfDwJj3k9yzqtI=;
 b=Rmrh9a3/LFIWmS5qqCJt0DRK8vbbM1+OYbqFLMGezLyhdMxA0YaoBb2Os0FzqVvgHvRMfkyut+cwAxEQ6gL1fIE6/9XtPtwoC55LEswDiZj4lRPKlQqrUcVtrl5jtltFSatmby4GouS9dPboI6/hmY4jLHK9EMlhbRom+HmJTC3oMofhOPYQu8QoILOq+BNFLNwBkVuw46jQqX4EMFuWyxxkYJFHxQ3SWtGNkT90HcWXgAO1QiowelPMqmkB9c6/KRbrVA9t5j1L+4mKzppGj1NaImFLOoyIcNc3WHySRFsbreegp+O2AHgpe+r5t9LOjbDwISloRuqRHLytZdCEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sl1ROUjrnUrKlGSbTypzzOIAWYUbIgfDwJj3k9yzqtI=;
 b=DC2q//xNTkLW9W8/JncB3ny+7nUg+7GvYlveV8qXGomKypt3KTQEAXBALOc8ZazkyEwA+6veAqT3z/JEAVcFQd31ftzhUMqCJ8RvdNnRI99EjGGYl9JR52LdSC1JAtexIyqDOew6itwjYzAHxPVtNshMipK864RDhZgfBU/IGYyB+yZ8nmAOK9I3cwXz35iVWlxnA2wDr6gGHKW9aN0CbPrQFoEJ8ZOzgxRHgVNHVsa29ivDQwMTDcysJzLRBcSOV2FyyD77bvvR4YoDd78se0VdOuJ9kPi1hunTG+rTFqI5wq5hIKmZGpq3RNmGuq0KFGGbIfTC89fyXDp+x3MfPg==
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com (2603:10a6:102:f6::14)
 by PA4PR07MB7488.eurprd07.prod.outlook.com (2603:10a6:102:c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 11:15:49 +0000
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8]) by PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8%3]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:15:49 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: memif test failures on next-net
Thread-Topic: memif test failures on next-net
Thread-Index: AQHdZ8dyFLSKNwe9T0em42rlKmvL6bcV766Q
Date: Fri, 30 Oct 2026 11:15:49 +0000
Message-ID: <PA4PR07MB728043B3C9727B8DA7ABF6DB906D2@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20261029100329.3cb8fa14@phoenix.local>
In-Reply-To: <20261029100329.3cb8fa14@phoenix.local>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7280:EE_|PA4PR07MB7488:EE_
x-ms-office365-filtering-correlation-id: cd4a838a-123e-407c-14b4-08df367726ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|56012099006|261009223027099003|261028144727099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: St9YeedcsuzWy2VMGPRGb9kcTcXdRySevZfjztZLn3TPTw5dLo8qX1aSrejLA+xygUsKnQ+vIuGbU4SzNE+VXPFm/i1068sHbsmgSN0u7Cn8mHpwknQ+A42GDIL5acoOWtqCa2tiFlwthGq1+NESR9x2ICmAfFnKvmcs/el0pc+lQBU1wjmyf0YHiXKkYYxncwO6x8ENiEsoCXAZn9dgXelooEc2zroYfuwou0Sxm+ESLdc3CCxSpfRaJj8WFjrEHCyVU6Tv/1ZHHdPM/liAFS353Sx7Cb9GXvCt9CHm+jdL/+x8ENheSCPmLsamarkPrH9p41rOjKeDF+hSrtFlyx7NlD7Gw5H2PNaBBBPECxoIBkBkldPtMJ89SlYIRIuSNhbvy7TgpR7FyKuKcM+7RWxVBqEL4J4Fmtb1aT9LX3ai2YQQDTiHEasinDFVUWQYbwB4n/18UAZ3/059d9mpKGUCz2csCns1k11BpeArpezChYtyRFJxpndvClu47eXZs9ekv+I7elzKdt/HA42Z/Y/7FOPu6OtfcEJEbzTX2LQWk+3N5OQ/SjQhS1rfsX4huvOxp90Leziy6YZrVw8rIVeWSKpIcgF9vAeKyrcGII8qbaLkJtAO6/EjvTbaKZU46BLlxMxgslLKrFm/itH1KgAP/vNig6k5C27Ap18+uGY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7280.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekVJc1ZkbjdOOEh5QTVTVll5SEpjUXZxQkFzb1Z1UFpVdGNkcnorVHdhV3pm?=
 =?utf-8?B?UG5BMHlUWFQvVzR1NlY0c1lHZDBzb2g2N0V4VG5UbU13ajVhUUlSNEJxeFB5?=
 =?utf-8?B?NzFPWkl0aW5lbTlsZnVweUs5WHVTMVpqSzltNW1mdXMzUUl5NnU5UGRHVHFJ?=
 =?utf-8?B?VFFsNXpjUS84REJMZm5Ra016eXNWVmViVkRPVmJBeGMrUlZ0MzZMbnNKRFN1?=
 =?utf-8?B?aUlNQklTTzk1ZGs5c2gwMFAzZW9EUVA5OHc5M3ZpNjRBSU53TVFsSi9heW5Z?=
 =?utf-8?B?M3F3U01yY3dGOSs4YkdrVjlMME1aU29yUkh1Y3M2K29GVGxwVmZUZ1k5SGp6?=
 =?utf-8?B?eTFqVGhHRGF4RWMxOGNNREpqNm0yaVZQelIwcmt2TmxvMjVnQ3BhWjJiSCtF?=
 =?utf-8?B?UWVDOWEwN2JuU3ZzbnNnU3lLQlN5WjhaRldCTms2Mzc0YmJNWlNLSVQrUnkv?=
 =?utf-8?B?TnRWQmxKb2U3bHZCdlZKZDR0Nm11Zno0Vk84bTExakJPUEhiRUwzQ1J4QXZt?=
 =?utf-8?B?SlpKdm0wdnVxcGlNbVNKYkQyUDVZWEpBaDRwZ1ExMFRTRGpoVTU0RGMySVl6?=
 =?utf-8?B?NVV4V3NoVTBiT1REWi9KME0vekMwUWVUTmlGait2b01FUGgvYk9xSXQ0WEkr?=
 =?utf-8?B?UzBKRUJQSmN2OEtTaVhxZGZOMnVBdDFUZnpXcm0vNjlsbHlhd21JdldrK0p1?=
 =?utf-8?B?NGdzcEt4ZWVEWlVpak81alQwWjkvdmFHQkM3bXhnNjluRjl3dndxbENDSmd5?=
 =?utf-8?B?b1BwUWtKRFhHOFZqU1I1Z0twK3ZkZEdqV2JZemZpc3NIK2h0ZHhoTzM5REE5?=
 =?utf-8?B?VmFwYnh6bnJ5OE5IRFFLbktLS0NDbzF2dWNJSEhOYWFtMTFhZEUvU0kzclFL?=
 =?utf-8?B?ZDRsS3B1M0o1TVBrNE5hRDdCck5wRGp6RzEyMkJvajMyczYyVEMvSHpvM1ZR?=
 =?utf-8?B?VXozMm93OXQ4T2FWUFQvbzVTaGM3Q3JjWGpEelgwUmFmQkJ2ckhVNjRkQ0sr?=
 =?utf-8?B?N09VbVhFbEk1diswcjFHV0w5dy83L0VnNXl2RnBpcFdJd1NaSjllYWhYa1hR?=
 =?utf-8?B?MUJzaFVud1BSekl4R2pzM0hSTU1xbVYwbmNRUVA4ekxNenVaVmZnb20rcTRw?=
 =?utf-8?B?Q0ZUWE9McjdoeitEY0IzYjFIZEZ2SndsaVhJTHlKOVF2SVFDKzVVbm1BbDZ5?=
 =?utf-8?B?T3BabXN1NEd0RFZ6Wk9UM1djNmlPVW5QSW9USWxWQVJNNFJLZ0NFWWRqMXMz?=
 =?utf-8?B?MjhGUkk1dERQRXp6NjY2VDJ3SldLN2F0bGhIKzA2cWM1VFlZdzhNUW5NVzFY?=
 =?utf-8?B?bFRhTFhGYWx5a0dTTVBqQS93aHk4eTBFYThxdko0RkhKaXpscG5BS0pUbnFG?=
 =?utf-8?B?czdQTlRWT3E3dWkxM0xYR0xERlNXR0d0TXdHMUJ4ejNWaE1Za1BBSTlZeTU1?=
 =?utf-8?B?Mk53Vm4vOXllUnVDSnJxeXFPelYxOTl4VEpiZ1NWaVF0WFNvWkpqSWdjTkQ3?=
 =?utf-8?B?ZGZDRzJMcVlEOEtNRXFDOCt1c2xrM2FKaStEYzVZU1YvTm5PK3V4RnNGdHJN?=
 =?utf-8?B?THBIUGQvdHkvbTdkWG5sbU9qQlpqSGRYcjNEc2xKaTVqcTMyUCttQzlpQ3ZE?=
 =?utf-8?B?aGNmVDdnbkpGS0NpN21XY1VoK2J1clRQU1p1aXZKdVM3UEZDUUZNbDJlZ3BO?=
 =?utf-8?B?b0J4dDdyWHV3M3M2YjM3RWY0RHYvdzZrNWN4eVUyMFhQZldRak5RR0M3S0hh?=
 =?utf-8?B?amtLamlPNFl1ejVlTCtadm1VbDR2K2VMZXAzaG1VbDRXbU5jdUZhTnVza0dJ?=
 =?utf-8?B?ZTUrQk81N3FacGNmd0YzSHZHM2VDcFBPR3ZoT2MxZHkyaXNlbjZCY05ub0w4?=
 =?utf-8?B?eEFyUFNMWkdyTW44WGZyWmFuSSszZnhxTExsQ0hBeWZoOTYvdk1JZFFTRHVY?=
 =?utf-8?B?dmErYk5BaHlRV1QySG1MdWpxaWtCaEh6ZlFvRUhOWjJPRjBFOEJER0FkT0lZ?=
 =?utf-8?B?V2ZBNkh6alBTTVRiY1NobVNkU3pkSXRydnBLc3ltekdReEFrZ3RkNC9CeGo4?=
 =?utf-8?B?SU1oOTh0ODJGRkozK1lESzRmMXhEQ2szVmNxU3dCTUtKS0dtMXREL08xQjgx?=
 =?utf-8?B?R245Uk5TRFBJbnN1UVVLV3hvSDFRR01lT3FNRTZ2aWg0MmtSUE5IQ081NG10?=
 =?utf-8?B?eDE5ZkRyVkZpYi9LR1IyNTU0REp3R3U4Y0MyczJyQXAyL2JWVUVESWYvZ1pT?=
 =?utf-8?B?N2puQWU3SnkvNENUVlM2NDQ0L0dwbUdnTE1PbVlubzV2aXlVd2Yxb0NvWHg2?=
 =?utf-8?B?RE5wM3FIWlFwVHArMkJBYUYxT0hjUlN6K3V2OXlVeUE3dldoWjZRZHoyWDJt?=
 =?utf-8?Q?83xawxc7A5KGnUEI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7280.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4a838a-123e-407c-14b4-08df367726ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 11:15:49.1780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7sw682bMMscGux/u67PNKir2d1Tc0ykP0OQEhUGj0I192cpd6g3A4jotX8nrq4vavg2C8GcLG7Xdga0TbwohjvE58qV0ZXyKGop1veaCG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7488
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8
c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCAyOSBPY3RvYmVy
IDIwMjYgMTg6MDMNCj4gVG86IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBl
cmljc3Nvbi5jb20+DQo+IENjOiBkZXZAZHBkay5vcmcNCj4gU3ViamVjdDogbWVtaWYgdGVzdCBm
YWlsdXJlcyBvbiBuZXh0LW5ldA0KPiANCj4gVGhlIG1lbWlmIGF1dG90ZXN0IGlzIGZhaWxpbmcg
aW4gQ0kgZm9yIG5leHQtbmV0Lg0KPiANCj4gQUkgc3VnZ2VzdHMgdGhhdCB0aGUgaXNzdWUgaXMg
bWlzc2luZyBzeW5jaHJvbml6YXRpb24uDQo+IFRoZSBwcm9wb3NlZCBwYXRjaCBzZWVtcyB0byBo
YXZlIG1lcmdlIGNvbmZsaWN0cywgYW5kIEkgY2FuJ3QgcmVhbGx5IHRlc3QgaXQNCj4gd2VsbC4g
UGxlYXNlIG1ha2UgdXAgc29tZXRoaW5nIGJldHRlci4NCj4gDQoNClNlbnQgaHR0cHM6Ly9wYXRj
aGVzLmRwZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI2MTAzMDEwMjIxOC4zNDg5MzcxLTEt
c3JpcmFtLnlhZ25hcmFtYW5AZXJpY3Nzb24uY29tLyB0aGF0IGFwcGxpZXMgY2xlYW5seSBvbiBu
ZXh0LW5ldCBmb3ItbWFpbiBicmFuY2guDQpJIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0aGUgU0VH
ViB3aXRob3V0IHRoZSBhYm92ZSBmaXgsIDMvMTAwIHRpbWVzLCBhbmQgd2l0aCB0aGUgZml4IDAv
MTAwIHRpbWVzLiANCg==
