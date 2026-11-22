Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8168606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=UjQRhjEY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5155402D5;
	Sun, 22 Nov 2026 22:47:31 +0100 (CET)
Received: from SY2PR01CU004.outbound.protection.outlook.com
 (mail-australiaeastazolkn19011063.outbound.protection.outlook.com
 [52.103.72.63])
 by mails.dpdk.org (Postfix) with ESMTPS id B7C6A402CC;
 Sun, 22 Nov 2026 22:47:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsnMw+CtbpAWs9Qe9AExwPQBwVA1Q7//VsXVGh80FYts8RkUSHKAE+dJzKu7a6zFonFquERiJ1wWQIU++UHmMOuqXb3RVQ26OWcGCbfTxNDi8ZOnCog3uq0bOTYMDVJYa+fcsMMwY1mie2krjR/lBMOlBd+TMQpiD1zqd+vVNJUUvA9YLKuXBkuUns31yTJ8sZw1n3Kaf0+QsCORSdbgCDs5AoZuAPtIQUuiv5etKV4St76ODfadDwqIb5pnwxW2qr8uFUfJzU2ZBGJ6mi48O3QmLEmy1yMlOeCQQpKPeoy0lCQXvBIVLeHHY6ywWqBHTS3F/1QM2CgHeiUxsQ3nzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW2epN+ETjTgtaKy/dBRDmnDgfLNruCAM4aoZYT6AGA=;
 b=fjA+S+uF4uRpLNfJ139rEKIUMZIP7Kq+vUXvaqVvlhtpY4ekKHQMXe3P0knRYd6tQf5RQ73YRZ8AfAPznxS1BfgSJsxCssn/Z3b8w7wNyukkZhEzwBaidyuIaBXOzVOwa1bn8PWt9rKWbUIxczMl1f1R33PyhScHMzqrytL6r2FTJ2eFPRMBFvWOxVLOmrXPgYbG1TKddCOGFc9gIjX+cMdf3GovGH7YXgnrpVd4zWoSnZW7Q47MyUS4oef/QwcyZpsbww5MCo/nuSOZW9NHi3RmqrucqMXnk5BUxLHhPLZYpdh7jWfmt5JI8uhWhYnX85ORXxNlAJmyN38ycFtS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW2epN+ETjTgtaKy/dBRDmnDgfLNruCAM4aoZYT6AGA=;
 b=UjQRhjEYES6HmaEycCUeJ9EP4rtTmtligNNf29qEZMx9OOn3Y01GnT/SttfOw7YjDs4V3SvgaoqvDPv/7pMXyJ6ZJO6hfiBZzq0wfO/D3YiF102BNTC3gjIRjKg5ExJv4p6xoUHgXnlaMQwyKDW/fg0HpO9kKUo4nXTsBq+2M4IwvfqddNg7CvT0nGKW+ioEyEJw4SyM/9p3MIRFFxOhKnGkC1n4Fn33iQ7jENC64UCfCneSbxPxnYvoa1ZEf6MRBdmQa9sAXSgCXIjfyV0BwRkzu+2pICFC25+79Hf0qic8LvA1eLp6TFkXl1dzC2lftZIgOtVCcbrYfsuBkFmn6Q==
Received: from MEUP300MB0221.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:21c::13)
 by CB2P300MB1549.AUSP300.PROD.OUTLOOK.COM (2603:10c6:140:b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Sun, 22 Nov 2026 21:47:23 +0000
Received: from MEUP300MB0221.AUSP300.PROD.OUTLOOK.COM
 ([fe80::4f06:1657:f3e8:b93]) by MEUP300MB0221.AUSP300.PROD.OUTLOOK.COM
 ([fe80::4f06:1657:f3e8:b93%5]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 21:47:23 +0000
From: Wenyu Su <PriceClaptrap@hotmail.com>
To: "shaibran@amazon.com" <shaibran@amazon.com>, "evgenys@amazon.com"
 <evgenys@amazon.com>, "amitbern@amazon.com" <amitbern@amazon.com>,
 "atrwajee@amazon.com" <atrwajee@amazon.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, Jan
 Medala <jan.medala@outlook.com>
Subject: [PATCH] net/ena: fix out-of-bounds Tx prefetch
Thread-Topic: [PATCH] net/ena: fix out-of-bounds Tx prefetch
Thread-Index: AQHdessO6MvYnwJ/Q0KuSnmOLNXeNw==
Date: Sun, 22 Nov 2026 21:47:23 +0000
Message-ID: <20261122214722.48761-1-priceclaptrap@hotmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEUP300MB0221:EE_|CB2P300MB1549:EE_
x-ms-office365-filtering-correlation-id: eee6eda6-fa3f-46e0-36ab-08df48e23109
x-microsoft-antispam: BCL:0;
 ARA:14566002|39105399006|25010399006|4140399003|13031999006|24021099003|15080799012|38102599003|20031999006|5062599005|31061999003|19110799012|8060799015|8062599012|40105399003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: =?utf-8?B?WWxneHNQaDRWV25VSkdVWFBVbjZGYkw1Q3Ywb3RXTGdhUWJDcmFWVXJIbEI3?=
 =?utf-8?B?RnY5QnRUeDBicE9yRWNlRjFFVHFZNmIwcVlvUU1KakxqWTZXNHQyQmUvTjBD?=
 =?utf-8?B?azd4cm5hcHcyRFgrQWYwQ1NYcE5sZmw0WFJWdFFQOW5TVUNIdFVlc2thMk1k?=
 =?utf-8?B?elpJeVpYK1BCRkd3WlU2L2FubCtEc3RDYk5oWjNidFB3WktaTlNPeDNWN3Ru?=
 =?utf-8?B?NVBJMktQSmZwNlBVR1h1aGNoUnFjdWg3N3hZbEZ4R2s0Z3RjdHNNeGVHOG5S?=
 =?utf-8?B?ZGZpWVR6Vk45Q2R4SEl1eXhLakNVMWRQVHVCR2pPNGpEZHB0Mis0dUFWUk9P?=
 =?utf-8?B?VWZacmZhMEFIVG5wTjEzQU04YUh5ajRhMDVTWXFMd1duNWowb0UzZGNoMlpK?=
 =?utf-8?B?cVRuOUVET0JnQXRMMU1peWt1NzBYanl5by8wWEI2VzFYVnhlcUczYjVIZHVM?=
 =?utf-8?B?U1NoRDhJclFyVEFPMnNJYjhXdDhYRFAzamNZOGIvVS9tT29qckt1UnoySUFL?=
 =?utf-8?B?aHNQQmErcW1NckxZSnlEcjNkNnhHSmRlTkVyTENuMUFnV0NuOUk4dHExZ1Ez?=
 =?utf-8?B?TVpWRXlrMlo5R2RrOTZBUVIwdldkYUhWUjBNR0hlam9sS1YxTk51alBERVVi?=
 =?utf-8?B?U3R4NnpWNEtiempqWTNJMVZnOGVGZ2U5Q3FyMGNJNE4yOWZKYVJwREUxV2k0?=
 =?utf-8?B?RUQ4YUxLVTd4MHprL0UwdVp2ZnhCam1JZ04zaER2aVFxc01NYUZ3cCtmY2Zk?=
 =?utf-8?B?NEs4UGtsbC84QVBtdU5EMTFxMUsyVW8xQ1VCU0FZTTJEOEhJMXRCSlU5YkRm?=
 =?utf-8?B?SE5vVUlyQWZ0bEtEUmF0cVJtSkhYSlo1UEVBRGpOVC9UY2NUbytNLzRaUlhQ?=
 =?utf-8?B?emdENVR5bjdhclo3cUpGMmhRM3lhbzdYMXh5MjVxZkZya2ZyL0gyYkNrQnl1?=
 =?utf-8?B?ZlNtem93Q3FYTkFhZ1F5SUJUdjRENzFXL21qbm55aXFRWGg4QndzcDBtTVAx?=
 =?utf-8?B?WldCTW1nQkFHdS84M0xvVjhJUEZhd3RPOW1sR293V2RFb1ROamlodG52Rlhh?=
 =?utf-8?B?eXBQTWE4dEpwWnZPdjhhWlZIUWtmWUo2d2Z5RnJDSll2ZTE0dGJZTHpKRnlW?=
 =?utf-8?B?VEdFRERIbjRyMXNlbGdhdXMyUWZsMjhXaHpZNzlZa2JaYkpiMjV2bWlUcWNO?=
 =?utf-8?B?V3VaWmZLM0U2SDh6ZDlLNSszOW9pOHpldTdjV1VtUzV6RFh0dmtJcXJuSGE0?=
 =?utf-8?B?NWM3YXhaS1BvOXJpdno2ZGg3dHVycWNBTU5vekxZR0lJQklCNkQ0RkdWRFB4?=
 =?utf-8?B?aGJ0MWFRUlFwZmhuT1NjNDFtRjllQ2pUR2c4ZWs5Rmlqc2Z3ekNUbThzdFZZ?=
 =?utf-8?B?eUIvOUhLcWlML1pPT0kyWHFIQWtEYnAvdDk2aEtXcko2L1FBWllmMUcwa3FN?=
 =?utf-8?Q?dqfICfO+?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1A1b3FSMmN0a2hYeWtFbFNSdkdWTk00YUhjYSs3Lys5QTRWa2pXcDZtc0RD?=
 =?utf-8?B?QmN3ZXZJMlE1YjVnU3I5ZWZtVzFGVWF2UnNTNXdIcU5SalY1YmhWbFpheCtT?=
 =?utf-8?B?VkcvSDhGNDFLcFg1dVYzUVhLOVFXZ21ZZmQ0dlZCVGI3WFlxR0NIZGpvVGxL?=
 =?utf-8?B?MU11RHorZmRLYjhRUHp4RjFpRnFMQ0tHT3ZEOXpkVGlqSDdnTTA4aXdueGR5?=
 =?utf-8?B?b3Zya1k2UjNqY0xNZ2RzUTNHRmtqZ0lNMzRMK3ZjQ3ZTV2pzeFBsSVhWcWdC?=
 =?utf-8?B?bFQvYkpoVndwa1JSaFBheXJKbVpFd1Q1Y3RJYnB0YmV2Q0toN1dTTWNqWld4?=
 =?utf-8?B?YXJTUVNVWVVlVE82bzhRcTY0OVMrN29Tb1dSUmtKQjJydVdsRGg1Z3BycXhm?=
 =?utf-8?B?cXNqdGZxbXRXNU83YXRUb24wdmZMdE44OEE5L21YUlBTV2xqdE9nYUkwNFp1?=
 =?utf-8?B?T3JleWFzSG1vMGczMk9OVWJva29KTmM3S2dteDFnUVVkT1ZzcXZpelpJbW5K?=
 =?utf-8?B?d0tUdm8wRk1JVVVvc3JCcWRpUzVmSGN4cGVRL1pIWjBRenRCNTZpZnFHeVQr?=
 =?utf-8?B?QTg0RlJBZTZOcGMyeVdNWWJLRm9henprNkpvdkErRERWZldzQlU2d21TRHVG?=
 =?utf-8?B?MWF5T1ZLQk5tYmpmZkR6UGJDRjUwT3FhRHV0b2QyYmR2RGVrWkgxMGZ6M0Fo?=
 =?utf-8?B?MkNFdm1xQ25vaDJJVGJoVitpOWFTNmcwK2UyN1B5Ti9oT1BYUEk1YStZNU9n?=
 =?utf-8?B?c25nVTVDai9acFZ2bFJpSlkvc1p4bElYYzhIWHc3N1JyeXNLL09iQWRkRFQ3?=
 =?utf-8?B?djI1UXdFbTkwREQzOStnaXJIVVdQSzlhblI0REd5M1VkMGZST3BobUV0Y1RL?=
 =?utf-8?B?dmhjWjlnZVZHckplZldwankxdy9NektCODIzMVlsUDRqQnZpU2RWRjZXNTBq?=
 =?utf-8?B?SEJpT0krSzBnQXZsbU9zOGl6USt4Y1Z1Mi94amtPaklaaGZTYVV3TjA3UFZS?=
 =?utf-8?B?QW40b1hmdnBCdmFnT0dEOHZZUXAwbHlGSDRDbnlESmVCR29NWkNZOWFzQVgx?=
 =?utf-8?B?emtjYWdqN04xTG1TUDFiVzdZeGQ2VE1GNngxV1pXa0ZmYms0Z3FjK1pXcmVm?=
 =?utf-8?B?UHMrMU13OXRralJkY3E4ajJZQnZXSGN2TDgwZHNDWndwUmZqdXVGRk1CMVNm?=
 =?utf-8?B?Qjd1QmYxWVpCam9yYTNyMTRIT2FBdHJPbHFXKzR5S2MySXdkVjZVR3ZleDBl?=
 =?utf-8?B?elYrM3hqSVBvdTJ4blZkRXB0V0lSb2dQMFJQUGthZ01xT2ZEd1ZMQU1OVVZ6?=
 =?utf-8?B?bUdoNmFnNnJaSkxmQXJZbWZEamhPTnVvNllUazgxaUxFSFpaKzRYUVRvRnBr?=
 =?utf-8?B?amx0SkNtS1NlVzlFZk9DREloU1pjNFhMZWkzd2U2TDNiN0hDeWVXbzlIYXJh?=
 =?utf-8?B?UjBobnNSaU1lWkk0bER0alVCcEQ3eEpuVnlxMXpQWC8vQU1HTk9teUYwNm84?=
 =?utf-8?B?L1JidDE4WlhEVGFkRk1sNVZydForV2R4NnEwUEx0N05RVDVrK3pnWFlxTTEy?=
 =?utf-8?B?MW5Zb044UmNNRUpMN0ZYL01hU2NnZGRlRWpSblJlRW9OemxWbnpiK0NQc1dP?=
 =?utf-8?B?cmxDNmR5TFp5WWNiME1kQkJTcFowM3dKRlBsYVZ2M3dlcWRabGhzSklKb21n?=
 =?utf-8?B?Q0g4cDBwVjZLeWlsN3hIVHA2MGNRQWdXeWNTL083M0poeU9Ud3g0S29BeDE0?=
 =?utf-8?B?ZWd6SHlCMzI2Wncvdjlab3U2ODMzekJZeXdFVzhwME5QUUhnUFNqMmhRWW52?=
 =?utf-8?B?T1dYNlJYbnBVUW1wZ2wrR1RrU0VwV3VubDBkeWRnNTZuS0VoY3dlY0p5NXds?=
 =?utf-8?Q?bFkiLAomGf4GC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-4606f.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEUP300MB0221.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: eee6eda6-fa3f-46e0-36ab-08df48e23109
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2026 21:47:23.1622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CB2P300MB1549
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIFR4IHByZWZldGNoIHVzZXMgdGhlIGRlc2NyaXB0b3IgcmluZyBtYXNrIHRvIGluZGV4IHRo
ZQpjYWxsZXItcHJvdmlkZWQgcGFja2V0IGFycmF5LiBUaGlzIGNhbiByZWFkIGJleW9uZCB0aGUg
ZW5kIG9mCnRoZSBhcnJheSBuZWFyIHRoZSBlbmQgb2YgYSBidXJzdC4KCk9ubHkgcHJlZmV0Y2gg
d2hlbiB0aGUgbG9va2FoZWFkIGluZGV4IGlzIHdpdGhpbiB0aGUgYnVyc3QuCgpGaXhlczogMTE3
M2ZjYTI1YWY5ICgiZW5hOiBhZGQgcG9sbGluZy1tb2RlIGRyaXZlciIpCkNjOiBzdGFibGVAZHBk
ay5vcmcKU2lnbmVkLW9mZi1ieTogV2VueXUgU3UgPHByaWNlY2xhcHRyYXBAaG90bWFpbC5jb20+
Ci0tLQogLm1haWxtYXAgICAgICAgICAgICAgICAgICAgICB8IDEgKwogZHJpdmVycy9uZXQvZW5h
L2VuYV9ldGhkZXYuYyB8IDQgKystLQogZHJpdmVycy9uZXQvZW5hL2VuYV9ldGhkZXYuaCB8IDEg
LQogMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvLm1haWxtYXAgYi8ubWFpbG1hcAppbmRleCBhMDA5NmZiOTdhLi5iMGFjMTdlYTBj
IDEwMDY0NAotLS0gYS8ubWFpbG1hcAorKysgYi8ubWFpbG1hcApAQCAtMTg3NCw2ICsxODc0LDcg
QEAgV2VudGFvIEN1aSA8d2VudGFvY0BtZWxsYW5veC5jb20+CiBXZW53dSBNYSA8d2Vud3V4Lm1h
QGludGVsLmNvbT4KIFdlbnhpYW5nIFFpYW4gPGxlb253eHFpYW5AZ21haWwuY29tPgogV2VueHVh
biBXdSA8d2VueHVhbngud3VAaW50ZWwuY29tPgorV2VueXUgU3UgPHByaWNlY2xhcHRyYXBAaG90
bWFpbC5jb20+CiBXZW56aHVvIEx1IDx3ZW56aHVvLmx1QGludGVsLmNvbT4KIFdlcWFhciBKYW5q
dWEgPHdlcWFhci5hLmphbmp1YUBpbnRlbC5jb20+CiBXaWt0b3IgUGlsYXJjenlrIDx3aWt0b3Iu
cGlsYXJjenlrQGludGVsLmNvbT4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2VuYS9lbmFfZXRo
ZGV2LmMgYi9kcml2ZXJzL25ldC9lbmEvZW5hX2V0aGRldi5jCmluZGV4IGMyZDAxOTRlNTEuLjdl
YTZkZWVhNzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2VuYS9lbmFfZXRoZGV2LmMKKysrIGIv
ZHJpdmVycy9uZXQvZW5hL2VuYV9ldGhkZXYuYwpAQCAtMzQyNSw4ICszNDI1LDggQEAgc3RhdGlj
IHVpbnQxNl90IGV0aF9lbmFfeG1pdF9wa3RzKHZvaWQgKnR4X3F1ZXVlLCBzdHJ1Y3QgcnRlX21i
dWYgKip0eF9wa3RzLAogCQlpZiAoZW5hX3htaXRfbWJ1Zih0eF9yaW5nLCB0eF9wa3RzW3NlbnRf
aWR4XSkpCiAJCQlicmVhazsKIAkJdHhfcmluZy0+cGt0c193aXRob3V0X2RiID0gdHJ1ZTsKLQkJ
cnRlX3ByZWZldGNoMCh0eF9wa3RzW0VOQV9JRFhfQUREX01BU0tFRChzZW50X2lkeCwgNCwKLQkJ
CXR4X3JpbmctPnNpemVfbWFzayldKTsKKwkJaWYgKGxpa2VseSgoc2VudF9pZHggKyA0KSA8IG5i
X3BrdHMpKQorCQkJcnRlX3ByZWZldGNoMCh0eF9wa3RzW3NlbnRfaWR4ICsgNF0pOwogCX0KIAog
CS8qIElmIHRoZXJlIGFyZSByZWFkeSBwYWNrZXRzIHRvIGJlIHhtaXR0ZWQuLi4gKi8KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2VuYS9lbmFfZXRoZGV2LmggYi9kcml2ZXJzL25ldC9lbmEvZW5h
X2V0aGRldi5oCmluZGV4IGIyMDRiMDc3NjcuLmJkMjVjZmY4Y2EgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L2VuYS9lbmFfZXRoZGV2LmgKKysrIGIvZHJpdmVycy9uZXQvZW5hL2VuYV9ldGhkZXYu
aApAQCAtNjAsNyArNjAsNiBAQAogI2RlZmluZSBFTkFfTUFYX0NVU1RPTUVSX01FVFJJQ1MJNgog
CiAjZGVmaW5lIEVOQV9JRFhfTkVYVF9NQVNLRUQoaWR4LCBtYXNrKSAoKChpZHgpICsgMSkgJiAo
bWFzaykpCi0jZGVmaW5lIEVOQV9JRFhfQUREX01BU0tFRChpZHgsIG4sIG1hc2spICgoKGlkeCkg
KyAobikpICYgKG1hc2spKQogCiAKICNkZWZpbmUgRU5BX0hBU0hfS0VZX1NJWkUJCTQwCi0tIAoy
LjM5LjUgKEFwcGxlIEdpdC0xNTQpCgo=
