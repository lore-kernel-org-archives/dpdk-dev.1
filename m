Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC6606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ericsson.com header.i=@ericsson.com header.a=rsa-sha256 header.s=selector2 header.b=GnR5vKk7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 976FB4060F;
	Thu,  5 Nov 2026 12:23:14 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
 by mails.dpdk.org (Postfix) with ESMTPS id 8892940296;
 Thu,  5 Nov 2026 12:23:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7Din4g1rrP9qVdxMQz59gPFoddsTmSHb09Wl6tfnXWgp0PIgQ0Zii08jlrLg+SUy0iEY/64u+CHT3QHSfeiwI0iNfdaVdiOwwYHUO1s6r/yeiW0nhQ4YWwtu4kOJdUs13CLhdllqx9ykH7Dch0BHfoCp4LROjWYaaEURpLpzQCWvDJ6WR6GovhcysrcTINIjZ2mgsM5qGZvfAjOSoC11fQ247Yz+jg6++0VZ/lUkk8U5JzZAphnjQxl+tesIwiMyV2iGtEg5Waln5nEuiwpxF//0XA+oTH6H27x596sEy21YH2rrggTCaCpanL6ax7QLQs8yN0ji270+Z9aTOITAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07pV6EJ/MpA+Nqr7DoXzMIvdkNf9MiNfgagDaNA3kTE=;
 b=t8A+kNEMeSOvymxLWXK+rrxXPel0ibfTYkRhR7ctFl2x9UupKAiRiEZr4mHrE+kp5/dUToDcwMG8/KN226xn0Hggiu9O3TMF1fWFd9GWmPxz/JJWaARYQolFkmmmnDXnCgCr5+XDX8K4yrt7BJct4o9tJX3PpypS90VQYLRVUC2mRUdx+dBUzHC5D2yHKvfsNm6fIQQjkOAjP7RBB+x09ghymqIoTdLnmO1Y1WOoh8kRcAJXrGP6/mjudsntqlHGReoXKr9l5TvkBaGdg8+lMbzjB5jeDxhWeF0zmXKkLd+b4Me7VhaSBvlj3dt2FLsxQPV3abqChYKMSP3Wj5bvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07pV6EJ/MpA+Nqr7DoXzMIvdkNf9MiNfgagDaNA3kTE=;
 b=GnR5vKk7B8mO49O4DEaeuMZ/fkOLG9dMLaeliDvkzkFKVHUbYnrqURZbMoo/SpgjW6Sx8+RH7TM5wtmNaiosBxPfyBoyrLCRaQ2TGt27W1Yt/z//T14yJeyz2cIlzz0VP0okh+EPWRak+yyBE+YxQAfdM66sB801GTV3rq6EeI4JEp6tMolO/NAx1Jhw3Mx1EAJ9nMRAfv1rY9RZtjXTEd0ncguWX3NU8e3nWa1uZU8Yhzq/zTkRmCEHrPlgGCsypgl1a5QIUilhUNti12tvLezzDCbZEUlatH+KZAeoPGlsVuGaq+qTRfLMwqgft4h2YYZJTNr/f/ZnVZQ+f66dKg==
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com (2603:10a6:102:f6::14)
 by VI1PR07MB6270.eurprd07.prod.outlook.com (2603:10a6:800:139::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 11:23:11 +0000
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8]) by PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8%3]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 11:23:11 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>,
 Stephen Hemminger <stephen@networkplumber.org>, "stable@dpdk.org"
 <stable@dpdk.org>, David Marchand <david.marchand@redhat.com>
Subject: RE: [PATCH] net/memif: fix race between interrupt thread and stop
Thread-Topic: [PATCH] net/memif: fix race between interrupt thread and stop
Thread-Index: AQHdaFiOAsXZQzgcvEymvb0680UP27ceHFoAgAFCllA=
Date: Thu, 5 Nov 2026 11:23:11 +0000
Message-ID: <PA4PR07MB7280A13D4D4F52BD476CF4D590772@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20261029100329.3cb8fa14@phoenix.local>
 <20261030102218.3489371-1-sriram.yagnaraman@ericsson.com>
 <eY-Q6aGOSBGpqOvPieWp8g@monjalon.net>
In-Reply-To: <eY-Q6aGOSBGpqOvPieWp8g@monjalon.net>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7280:EE_|VI1PR07MB6270:EE_
x-ms-office365-filtering-correlation-id: 52bd86b9-43e5-41fd-18ed-08df3b2f2cdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|10067099003|38070700021|4143699003|56012099006|11063799006|5023799004|261021121427099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261009223027099003;
x-microsoft-antispam-message-info: wyIwQJMg8+n4nNsPML4ormoewN9ZSXKGGRqaDHGRhGJ3SlB9TTAwUsViQtqz7NB+or3K8Sa3owLLpaXhRuG4ykPfhIx3t6HxGhHFY8850DPF2npTwF8MGIg9SgeJ1WSEMLPiK0g/9G6ILopNY2ABttnvMA+iajZQiELEa6XpCO+AMJoVzNQELy9IoWSIu2opiASOAU6iS8hbJdrVCeg/2IDbMbTzrQBlYaosCupp9k/Giq4V1tEe/mELlf5dOT17o/+JpxCEINMsSLJvAnt4nkhzqm4EQ4VxU8I9NasWQD+6dDn58m+PRYHRnorEQKobuLfZVId8KivPf49ryen7fl4G7zUnKxmba8dMycUX45Hsywmt/BGIGe/LhmDaBl0JBEEbkWq4QtQiQyl77UIDP3VqSK+nc2jHL7iF58n9aaFqcF9+2lmna9R/HKUZZIoZJgsJieMCW4QxdQzAD3mx/HzUYFav5WXDydL62Tcaq+7ZtOa76gIOZ0mxL8ufM2I2BMaTWy4bw+jcycK4mQvCujZtely2BFgCuf0crTomxqMicn6na97ARe26wv62NZw2STMZlLZhzpAVCIeXIY8Kaoh9Ke5a6OhcaGX+P9mb/zmusG/KkbfB92B5llW89v77yTcfbPwAs8Bp/MdLQD9L4bNAr/H+JysK8xOosOxzRIk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7280.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(56012099006)(11063799006)(5023799004)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE1WeGxYcVBsRjVSakE4WXRocndJMTVQamdXVjFBUTBCT3h5dzlyakgyeGc2?=
 =?utf-8?B?YlpQWDl1czFua242a0lLNXRxMkF1ZHpsbk1DNk8zd0ZQY1NrQVljOE1FZjFq?=
 =?utf-8?B?QzRKOVpoRXFRaFNPMlk4T0IrMFBxY2p2dkJoUFB2cStBY1ZnVDF0dGVEOVc0?=
 =?utf-8?B?ZG9SQW9lUllwTDdQMEdnVU1YaVdlSXhuSlhxNDZybnpmUmE2T0crT1kxQk9T?=
 =?utf-8?B?QnR0OW5nbnVkT0hLNndybVJBWkxtK0VFSFpxdENscktUb2xoSHRkQ3U3VCtx?=
 =?utf-8?B?NTRHU2pnTEJiZHF6RExRRlNTNnBTQVI0Y3p1MUowK3hYSUFqUDVhazBvejQv?=
 =?utf-8?B?SzhzZGhnUlhnUUZBSmczcWFya0dQL1QwVmhLWVlTaEo2TkNBdGxoRHFGTldq?=
 =?utf-8?B?bW5QSFRyMWJsMFV4dFdteEJOOWxjT1ZEWVZDclF2Q3JjZGM2b2FaWkZSRWJ4?=
 =?utf-8?B?MWVaNGFYVEQrWDhVQ2ZUc3JHVTlveU9OTXZDQ001bm40SkJUL3ZRZkc2OUNl?=
 =?utf-8?B?RWV2QUpGUGhZSzNSRERJQ2tJckNic09UcVNYY2JEckhKNk53aW8xbFR3ckJz?=
 =?utf-8?B?d2F3Y1JwREozYzR3K3hKY09FSldpb0xVT2IrMS9McVNYWk5oQWlOd0JPL2xp?=
 =?utf-8?B?bmxFb2gyR09aQkhtdTNXMjJqYTFNWnZDdmlCLytqRjdhNDdRR2RtOU83S1pN?=
 =?utf-8?B?Zklvc1FlL0hUK1dQbUdRait3QnlieEJ6VjlaVmtkVmpjT1B1dkNwcWNxNnNP?=
 =?utf-8?B?dUVzOStrL3p5NnNqT29OdE0zMlJZeVpKeU51TEhTQ1FFSGtIanFSMzlYa2gx?=
 =?utf-8?B?RXl6dUhOQnZiUVVrYmwxSzk0Z0dhUkFsczdBRDB4bGRxbFhUNk4xdTNXa0Ny?=
 =?utf-8?B?clJZbzZDNjdUeHUwMzBrV3Y4SWVXamZkZGpvVjlUSVRPOEdVNURobHR2cngz?=
 =?utf-8?B?YVBGRkhWMzNmeGQ1U3Q1dmtkbzVBVnJJT3M1VjhHWVYrTkQ5a1pHZVF3Uk4y?=
 =?utf-8?B?VlJJUlJoNm41aG5PYjBjMEkrd2lqdjlmbWJmTEQreEZreHFmd3hBMjJKb2gz?=
 =?utf-8?B?ZVV2NkxPcTFhbHVVSlhYN0ZZUHd2NUxaZWpMZGdlMVJYVTE5ajhwdVpFUjRv?=
 =?utf-8?B?V3IzMmVVUlFraSs4VDFEOTdxVlBiT3gwSDNnLzRsRGkzeHhjckFzbVc5dVU3?=
 =?utf-8?B?TlBNOWUwMklDRms5MTVyUzBKRzcvTmVuc3g5dnpTTXJYa0RLdjdZVVF0cVR2?=
 =?utf-8?B?cHJlOUtGNG9jTlF1MmxJazNkWFQ4ZmJlV0ExNHRpUFA1L09LUVQrdDZQL3Ji?=
 =?utf-8?B?NE9xMHJITXBQMTdYYzZHd3hEY0N6a2dvRG1xTFE5L3o2L2xwOVp4TElrcE5W?=
 =?utf-8?B?WHdWTUtuNXFGK1hYbEIyclpXNEtWOU1mZzdsZmc1WWg4N0c0Y2NmY3FScU83?=
 =?utf-8?B?eFJqRiswVDJKTnVPUTBQQnFNSU5VZSttbmh2M2ZGM1RMUnhqKzBWRS9qNjVh?=
 =?utf-8?B?OUdpdk1Bam9mamZzdWwyVElWTDZIZ3h5R05vQmpxWHR3YkNnMnVSTGUyV1kv?=
 =?utf-8?B?R2Z6VmtNT3dUZFNMWVp3T0NDSndPWDJSTHBxZEVwV3NWT0FUTXVuRVBsY2U4?=
 =?utf-8?B?Qm5INHNBdzhGQkFSRlBRQlkrQ29ZZWQ0TGdMN1hmSnlheGRVdTVid2dzR3Qw?=
 =?utf-8?B?VExzaGhWUTEyZTZrZ2hKVzdIeGFLd2M2UUVSS29KbXgxMndpQnF3RFJMZXpS?=
 =?utf-8?B?RER4ZlFlN244bXRHSVlVT3hFTnhOTDNKeStzTFJHOWI2NjZRdVZyQ204by85?=
 =?utf-8?B?SEkrc3V3UGxsSURzYVpXN0pWejBQRXY4Rk1QYitHWHZ4OFQzMFRJKzVVMlF6?=
 =?utf-8?B?SEZFcTdzTWh5YlFMWnorUlFkdVppdTFiR2FTaXB5QWZWZkQxQUcvOExoTm5s?=
 =?utf-8?B?cVhoWjRRdHRaRDNGNjdFd2x1Yi9rOEVIcE5ra3NZQzFsSDVVMVNGRTl1RUVU?=
 =?utf-8?B?Y2JFOTdtMU1pUjBYa3E5aXk3QzF2VkVzb2NMbTdFYjBGNDN6RWI0cjdoSHVJ?=
 =?utf-8?B?LzdCVFZrWVZyT2lZOWEyYnE5aHUrT3I0L01pbDNBRjVsaGJJRCtSa2M5N1Ey?=
 =?utf-8?B?M0NwMEtQZk1WQWxCOFVnbGs1dXN5QWI1ZDJqNWtZZEllRUhvNFlodXlMUjJl?=
 =?utf-8?B?Slppb0t4RkpFdHdOMEV0Qjd4MjFoQ21pS1JNRy9sbExWeFMyUEtiRGIrVHRC?=
 =?utf-8?B?SGRxYnU0MzFYK2JoMFJIYWNQbm1yRkhkQ1JCcmw0Q2dWNTJCYXlBQncvZmtO?=
 =?utf-8?B?aDVBSGRaeEViU2hIM1pyZWpud2hPZllxdHZlTG5RNTZSRjd3OU1tTk5IR0t2?=
 =?utf-8?Q?pDEWXvBxTJBnJbe0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7280.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bd86b9-43e5-41fd-18ed-08df3b2f2cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 11:23:11.1916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daUw7V6suxJfpwYbX+1FIHWkLdw0HIVf6f0P4yBtsOpuQrMVuAnRkHhwv+70yR58RxkSSMjeBx47Xp3rBeHafczSnuZ19jfKuKBD1vpMLRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6270
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIE1vbmphbG9u
IDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KPiBTZW50OiBXZWRuZXNkYXksIDQgTm92ZW1iZXIgMjAy
NiAxNzowNw0KPiBUbzogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVyaWNz
c29uLmNvbT4NCj4gQ2M6IGRldkBkcGRrLm9yZzsgSmFrdWIgR3JhamNpYXIgPGpncmFqY2lhQGNp
c2NvLmNvbT47IFN0ZXBoZW4gSGVtbWluZ2VyDQo+IDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9y
Zz47IHN0YWJsZUBkcGRrLm9yZzsgRGF2aWQgTWFyY2hhbmQNCj4gPGRhdmlkLm1hcmNoYW5kQHJl
ZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG5ldC9tZW1pZjogZml4IHJhY2UgYmV0
d2VlbiBpbnRlcnJ1cHQgdGhyZWFkIGFuZCBzdG9wDQo+IA0KPiBIZWxsbywNCj4gDQo+IDMwLzEw
LzIwMjYgMTE6MjIsIFNyaXJhbSBZYWduYXJhbWFuOg0KPiA+IFRoZSBjb250cm9sLWNoYW5uZWwg
Y2FsbGJhY2sgcnVucyBvbiB0aGUgaW50ZXJydXB0IHRocmVhZCBhbmQgY2FsbHMNCj4gPiBtZW1p
Zl9kaXNjb25uZWN0KCkgd2hlbiB0aGUgcGVlciBoYW5ncyB1cC4gTm90aGluZyBvcmRlcmVkIHRo
aXMNCj4gPiBhZ2FpbnN0IGFuIGFwcGxpY2F0aW9uIHRocmVhZCBzdG9wcGluZyBhbmQgY2xvc2lu
ZyB0aGUgc2FtZSBwb3J0LiBXaGVuDQo+ID4gdGhlIHBlZXIgb2YgYSBsb29wYmFjayBwYWlyIGlz
IHN0b3BwZWQgZmlyc3QsIHRoZSBjYWxsYmFjayBjYW4gc3RpbGwNCj4gPiBiZSBydW5uaW5nDQo+
ID4gbWVtaWZfZGlzY29ubmVjdCgpIHdoaWxlIHRoZSBwb3J0IGlzIGNsb3NlZCBhbmQgcmVsZWFz
ZWQsIGFuZCB0aGVuDQo+ID4gZGVyZWZlcmVuY2VzIGRldi0+ZGF0YSB3aGljaCBpcyBOVUxMLiBT
ZWVuIGFzIGEgU0lHU0VHViBvbiB0aGUNCj4gPiBpbnRlcnJ1cHQgdGhyZWFkIGR1cmluZyBtZW1p
Zl9wbWRfYXV0b3Rlc3QgdGVhcmRvd24uDQo+ID4NCj4gPiBEZXRhY2ggdGhlIGNvbnRyb2wgY2hh
bm5lbCBpbiBtZW1pZl9jY19kZXRhY2goKSwgY2FsbGVkIHdpdGhvdXQgY2NfbG9jazoNCj4gPg0K
PiA+ICAgLSB0YWtlIHBtZC0+Y2MgdW5kZXIgY2NfbG9jayBzbyBvbmx5IG9uZSBjYWxsZXIgb3du
cyBpdDsNCj4gPiAgIC0gb24gdGhlIGludGVycnVwdCB0aHJlYWQgKHRoZSBjYWxsYmFjayBpdHNl
bGYpIGRlZmVyIHRoZSBmcmVlIHRvIHRoZQ0KPiA+ICAgICBwZW5kaW5nLXVucmVnaXN0ZXIgY2Fs
bGJhY2ssIGFzIGJlZm9yZTsNCj4gPiAgIC0gb24gYW4gYXBwbGljYXRpb24gdGhyZWFkIHdhaXQg
Zm9yIGEgcnVubmluZyBjYWxsYmFjayB3aXRoDQo+ID4gICAgIHJ0ZV9pbnRyX2NhbGxiYWNrX3Vu
cmVnaXN0ZXJfc3luYygpIHNvIHRoZSBkZXZpY2Ugc3RheXMgdmFsaWQgdW50aWwNCj4gPiAgICAg
aXQgcmV0dXJucywgdGhlbiBmcmVlLg0KPiA+DQo+ID4gbWVtaWZfaW50cl9oYW5kbGVyKCkgbm8g
bG9uZ2VyIGRpc2Nvbm5lY3RzIGEgZGV2aWNlIHRoYXQgaGFzIGFscmVhZHkNCj4gPiBkcm9wcGVk
IHRoaXMgY2hhbm5lbDogaXQgc3RvcHMgcG9sbGluZyB0aGUgZmQgYW5kIHJldHVybnMsIGxldHRp
bmcgdGhlDQo+ID4gd2FpdGluZyBhcHBsaWNhdGlvbiB0aHJlYWQgZnJlZSB0aGUgY2hhbm5lbC4g
T25jZSBtZW1pZl9jY19kZXRhY2goKQ0KPiA+IHJldHVybnMgdGhlIGhhbmRsZXIgY2Fubm90IHJ1
biBmb3IgdGhlIGRldmljZSwgc28gdGhlIHF1ZXVlIGFuZCByZWdpb24NCj4gPiB0ZWFyZG93biBu
byBsb25nZXIgbmVlZHMgY2NfbG9jay4NCj4gDQo+IEl0IHNlZW1zIHRoZSB0ZWFyZG93biBpcyB0
b28gbXVjaCBjb21wbGV4Lg0KPiBXZSBjYW4gcHJvYmFibHkgbWFrZSBzb21ldGhpbmcgc2ltcGxl
ciB3aXRoIGEgcmUtZGVzaWduLg0KPiBJJ20gbm90IHN1cmUgYWJvdXQgYXBwbHlpbmcgdGhpcyBi
aWcgZml4IG9uIHRvcCBvZiBhIGZyYWdpbGUgZGVzaWduLg0KPiBJJ20gYXdhcmUgaXQgbWF5IGJl
IGEgYmlnIHRhc2suDQo+IFRlbGwgdXMgaWYgeW91IHRoaW5rIHRoZSB0ZWFyZG93biBjYW4gYmUg
YmV0dGVyIGZpeGVkIGVhc2lseS4NCj4gDQo+IE90aGVyd2lzZSBJIHN1Z2dlc3QgZGlzYWJsaW5n
IHRoZSBtZW1pZiBhdXRvdGVzdCBmcm9tIHRoZSBmYXN0IHRlc3RzIHNlcmllcw0KPiB3aGljaCBy
dW5zIGluIENJLg0KPiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gDQoNCkkgYWdyZWUsIGEgcmVkZXNp
Z24gaXMgd2FycmFudGVkLiBGb3Igbm93LCBJIGRpZCwgd2hhdCBJIHRoaW5rLCBpcyBhIGJldHRl
ciBmaXg6IGh0dHBzOi8vcGF0Y2hlcy5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNjEx
MDUxMTIwMjYuNDMyMDE1LTEtc3JpcmFtLnlhZ25hcmFtYW5AZXJpY3Nzb24uY29tLw0KSWYgd2Ug
Y29uY2x1ZGUgdGhhdCBldmVuIHRoYXQgaXMgdG9vIGNvbXBsZXgsIHdlIGNhbiBkaXNhYmxlIHRo
ZSBtZW1pZiBhdXRvdGVzdCBmb3Igbm93LCBJIGNhbiBzZW5kIGFuIFJGQyBmb3IgYSBzbGlnaHRs
eSBiaWdnZXIgcmVkZXNpZ24gbGF0ZXIuDQo=
