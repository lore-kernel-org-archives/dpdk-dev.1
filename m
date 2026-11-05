Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF660A2609
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ericsson.com header.i=@ericsson.com header.a=rsa-sha256 header.s=selector2 header.b=m+gVjq7N
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37F6A40DF8;
	Thu,  5 Nov 2026 11:08:38 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
 by mails.dpdk.org (Postfix) with ESMTPS id C0BB340296;
 Thu,  5 Nov 2026 11:08:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MY0yf86zJxLsyMv8HTDBZWEm52tgFEl6dSqQN+WZFGqGXcVT4buT/On7zEjjI/ZsdTVliZZl7EmTO07L82Pp7tYgH/AVBU7Vm1Q56o1jixzo48+x1j91VGXQicpoMZuXFWwtRftcWaKQEeMcBzuPR0MJMsQDGA8a3iY1no6TpCzhOQ1GCAlchiX/5JpVCPZYir2NzYTyBPsO2YHKIuXn5bz6mtQ/fgaa+efRU5LZhgLmK+maNACYEL1D/ibGDVc56kdjvBvgx8X3iA6vNrB1rR87Ru0eoA3sN+OHThfWmy/5LlvJB+FBFAC7X1IXGXgp2q5x6M9Zb3ihMPO4i4bbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adHLADDKg2TuMJ1SPRjE9ZLJlGk4Ju8o/7fwCHXpQp4=;
 b=KyH/disWMgMdLpEzO4AVtI8UsInaKfhIyshUwqwkVo0I3fN9QbYOBLOpUbyMuSbTCsXihvlmhniEuMfIj7FkSyavvq0R2FxneFqAH1CtP8MkCUDihXqCos0YlAmLIyfZXQzTcamAM9sp3YSl5y9exqoIy5oLAVI3Pm7tmfkKhVqBFRTJnyrxEIsMaRnfAwHo/oTltWcLGdMbFyVyEU1z7q7EHZ5fmhNvxb1ZUE16piu81XzGUn9k5LYJ3DtyMEOw+gumu9GbdLyf+jp0fTzl/88zPgfxrhis+sFh9po7dU0MnIcsVYrG7MKCB6LLR4QgONohhyKZmiignyK1VkfN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adHLADDKg2TuMJ1SPRjE9ZLJlGk4Ju8o/7fwCHXpQp4=;
 b=m+gVjq7NxEHmOFpI40AzTI2Ce5G1ulHvvoJZQy2fDpfHF8Ti6RvVl0XluHw/7evIhtrlvctpDpwx+1yHH+sNxgni/0MDvKeiOvl7P2cZR2kcf9kXTNf8C3JnMoZjUleapAdh1DX9J2e/thgfwuZgNfEi8Xgv2eQ07QHrnxyCpdwyeg/LeC1FnleBhJQv4CTwSqMJNKriUedFU03RPV1m78JEBPm46VO6fun9WCQbCJlmGFnaGoAI/6praFZ7rx+8oHP2xWy5TFtEH/LsfKqGfwmhqEhzeEVdGz7nlcmkr6OKGfIQclbvEpTJJjKUldsOdAdy2muZyLWUGXVeP71Qdg==
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com (2603:10a6:102:f6::14)
 by MMZPR07MB757581.eurprd07.prod.outlook.com (2603:10a6:190:3b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 10:08:35 +0000
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8]) by PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8%3]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 10:08:35 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>,
 Stephen Hemminger <stephen@networkplumber.org>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] net/memif: fix race between interrupt thread and stop
Thread-Topic: [PATCH] net/memif: fix race between interrupt thread and stop
Thread-Index: AQHdaFiOAsXZQzgcvEymvb0680UP27ceJlgAgAEd6oA=
Date: Thu, 5 Nov 2026 10:08:34 +0000
Message-ID: <PA4PR07MB7280AF59CED8646B54E326CE90772@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20261029100329.3cb8fa14@phoenix.local>
 <20261030102218.3489371-1-sriram.yagnaraman@ericsson.com>
 <CAJFAV8wtffcwSuLdc6Xt3wrBXS4htcctU2q1x87kf5piHCgZzw@mail.gmail.com>
In-Reply-To: <CAJFAV8wtffcwSuLdc6Xt3wrBXS4htcctU2q1x87kf5piHCgZzw@mail.gmail.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7280:EE_|MMZPR07MB757581:EE_
x-ms-office365-filtering-correlation-id: aa60eae6-e40b-4358-f672-08df3b24c0dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|18002099003|22082099003|261102123227099003|4133799003|38070700021|56012099006|4143699003|261026121527099003|261021123027099003|5023799004|261022115727099003|11063799006|261022105027099003|261026140227099003|261026130827099003|261028144727099003|261009223027099003|261021121427099003|261021133027099003|261021130227099003|261022113327099003|261022075727099003|261026135527099003|261021135927099003;
x-microsoft-antispam-message-info: CSpR7KHPEsw0XvV7cjv5jcIsw/7yPr0W4MQo06tFJmNlFoVuISg6fPEEwkkbCfy6XBQz9i1t5G0EHml+1yUUchyoKNLz/JIpDsndyKt6u4ZMSh7oM3KO6HRFS0l5o/ljQnzk9YikdFIgtI5i5vIVKT+f3u3gwuJnnYt0ux/fy7Zlnni9pSMT1wrbR/jQY9ZTIImRY1mzYAe9m7lnwqj0ZKHP7Q3/4+fDLas6sdJZ24FMPFtw3DVTFumNa7uQDs7N0+wPDjJx1W+g3DyXpOlz7W0IgNK2EyynR+Y5UIACWKJeic7Q76EKA/WCTSDOBF+zUzH9BlpLy8edtavKWel6OAK+7ItT6F30JlQuPsLVP0AB4EgETcI6x4q4u5ZFg7xWi9oQStSxs7hN+vKpfx3VMCHn3S0aFCBdsxIxVOi+H1vP3nZ3OISAAlrf4TG68XR8Hy2LPnZEDd3pHqlPb7UyQXoRjfFYB+emn0EnnOGwf6th5ZROYZKQfC7ub0hAw/cSU47qh4PwWFczeBEwlHbIMENKIZ0CMbbPf4EY087whrLl4rNhZfGoRB2RDSEnA4HKUThfc++megVlhRNtGPZwjrTRL5E44K3zzpDKIV1zMn90JPBrHNqHLpFx9qkU5HpbquRZFfN/iH8vDb1T6Wa8D3mNrWk46S2MVLOAikldhrj2cQr/Z8fMZ0vQEDlp4Cc1hC9BZcK4bn9kPINH8Vyw1o53vfqthkbjWozVU+a5ph8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7280.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(261102123227099003)(4133799003)(38070700021)(56012099006)(4143699003)(261026121527099003)(261021123027099003)(5023799004)(261022115727099003)(11063799006)(261022105027099003)(261026140227099003)(261026130827099003)(261028144727099003)(261009223027099003)(261021121427099003)(261021133027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261026135527099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V01PMVFxbmVHaXR3T1UrOWJWRFNTOGRMMkpkb0YvaDNjQWgydWIrcGtkdjlU?=
 =?utf-8?B?a1pJNEExUFVmZWNsR2VZWVVZM3A3ZERLRDdTVU8wQ01UQXJyYUlxYVNmdnN2?=
 =?utf-8?B?SkpPdlc0YndUTURBcEZNQnh2d25HSWpIa05Ub05TS3dFOWpobnZSakxVRG85?=
 =?utf-8?B?eWYzdTZxNnpNNlpFVmhSNmFSV1U3bjZ4VVQyVHdHMTVDeXcyL3g2TXFkcHZk?=
 =?utf-8?B?M1B1MkJ1cEFhQjRMdngyVGJYSUxCRjIvL1h1NEJwK3p3dDV0V1VlbWpHdHM2?=
 =?utf-8?B?TmZEQmxGQ0FGWkMvWGZLSEN5NDdocVYwNVlvMmtrSUlDWFdCZW1tdmRYMFoz?=
 =?utf-8?B?TmtCUGN4K2RqdmlrLzU4cUh1Zlg3c213dGp5MTJlVktYZURJeU9DYk1kRk5y?=
 =?utf-8?B?L2JiUUR6dThoRTlQNDY2MTRKL29WVytaY0pPYmxOSWxGNk9aMmVySjNhUTVM?=
 =?utf-8?B?ZzI0dDVoSThmS1VqcUhGRFVhVTN6NlR6VUxtcDQ5V0J5NWFkNDVUNnhJd1V3?=
 =?utf-8?B?aXAvSDBHZ2syVS9hNjZuLzlZUVhIcERwWTZGTlBpUE0xOG5MZlk3cTladUEz?=
 =?utf-8?B?bVJlM2J0eWt0N09zOEFsVGFBbnBKNGtMczFheDNEc1ZXaWZCWmd4aXJodmRp?=
 =?utf-8?B?NDllWTdDUFlUK0lMQ3BQQ29RYTMwMkc0anpTbFBjMnVJOFNqaytYS2RuNTl1?=
 =?utf-8?B?Mm5DSXQwUnlZOGRveEVJUG90ZmRmV1N3eHlFaFovTHFBejhYenhTTWEvOXVS?=
 =?utf-8?B?dHNaTkdIMmRPZmhQT2hUdE1HdnhqUVNQL1NaWTVSWXRMbGtBaExpaTFjaW9N?=
 =?utf-8?B?QkdkT1h4RnZXRUY5UzRNZDcwVDFxREVqV0NpWmJrNU5peGo3N3BuT0hRWnNT?=
 =?utf-8?B?blo1OHhhT1VBNHlFN2tFYllncWhQQk5wVVZGMEtjVHNQQ0tnY09aM2NEZ1F6?=
 =?utf-8?B?K3VXdVc2b1ArcDBpYlg0T05jNU8xbEhlQ2YxU2gvVE54TTdHQWRaS3NqdUZr?=
 =?utf-8?B?a1l4ZmNDV2tZMzFNL1ViQkFTVGVDTmRiVW1hTjQ5c2lDOURDYVg1UUgwZDNu?=
 =?utf-8?B?TFZ4bDdBdi84ak1rdVVWVG1vTEw5SDkrVlRHbm1Gc1Bycmh3dldpTUtrNE83?=
 =?utf-8?B?M1FVU3BSQTFYOEgvajdoQWpnck9vM2lSZDdWcXB4eE5pTHFLbG9SK1ZaL1FG?=
 =?utf-8?B?bjdFNGpqakY0ZkJwM1o3cDNvOVRGWERXVU00VHBldENaTnFMVEEzL0RDakNH?=
 =?utf-8?B?akJOeHh5ZXNJRitlYkIrY0FicDNNcjhlcWx1M21CZm4rWnVnN1hWOWpSRWxi?=
 =?utf-8?B?YW81dmt6dnpnVU9VcUFWRGVuS0psWm02RFdidy9HQTBTYUoycVE0dTBlaXNz?=
 =?utf-8?B?aVlzR2krcmFIanhYQXBNY3RucW51WndXZTJKY2RhK3NvYTBHRkt5TVNaRWlC?=
 =?utf-8?B?bXJHNkhzMmRsVGVNQVRXbTRncXBnK0t3aVlOWUFMdXZMRXpkQjNaWHZJdHJ4?=
 =?utf-8?B?YVkyUDhoMU9TVXczVGRVek1TVGM4Q2YxYlFZdDVHclorblhMRXpMWXYvQk81?=
 =?utf-8?B?Y0tiY2tjWEJmOEdJYXAybTUyKzk5RGUzUDIxeDhJWFhOL3QrNmZmRDNHUU9L?=
 =?utf-8?B?L2xqRDQ4THBOQ0g4UEgzRk9nVGsvdUJQVkxIZEpMWTYrMmVPMG55QmJjTDlB?=
 =?utf-8?B?U1ZzV0xCUXdVclNtc0tSbDRYNHY4Y2pJaHREQ1lxeTNUWTRxRzBHYzBaL2ZO?=
 =?utf-8?B?ZTRLc0pJenF2TmJGZXAyMHgxdUVBbDBHenAwTnZnZlRVdWg1UVVPTkZ3bVVV?=
 =?utf-8?B?NDZGWC9GRFZtTXB1ekNSbk9KZFBsWkVkVHp1UWY2Y29kVXRONk42cGs0ZFly?=
 =?utf-8?B?c2Z6REZ3bmFzNXI5NUYzWTgyOWhRRWtQbzBzRW82eFZGQkNvazJTbHJVUHIz?=
 =?utf-8?B?c1h3VzVVQXdyK1pTNkMyUUwycG9WbGl0anllNWZpdVRBNitSQUtVUmM1YnZQ?=
 =?utf-8?B?OWpYWWk4TWt4UTJMeDJZeVlhTTBLVURsSGlEYUsydi91QU9haENwWlo0T3dz?=
 =?utf-8?B?SmRxQ2djMmt5cGd0TnhMbmxvUlVsU2czbDlMMGlGK3RwZCsrQWpFSGdPV1dl?=
 =?utf-8?B?YmNMOU15bllFTU5qSmRsVitFTXdVN1NTaFdETE9SZjhCYkxsdXJaZmR4MDZz?=
 =?utf-8?B?ZjZtS2R5QkRWQVVNYWJ4endjN3BIc0taempPMzBTakN1N3hPMy91dDF4TTJ2?=
 =?utf-8?B?MHdSM0c4VzJyZVB1aExDTEs0K3hwMFFjUHFaQVFKaE85V1ZRc2pDQXZhaURB?=
 =?utf-8?B?UnJsdytHTlF6aVVXVWEycklkdGZzM3NvZ211bWpyZGFUVTNod0FDc2MwVHJN?=
 =?utf-8?Q?jyuPi4hbOw3WqEh4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7280.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa60eae6-e40b-4358-f672-08df3b24c0dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 10:08:35.0093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSptTLfA4bnU+pZB4rDHc+b4I0it7k9ByB4HWMtnEJWMwFM95LLpZ3+qP7rl9igQO8RmRsVRpKV1l2xyTreLhMw+kOY9YzGgtudmurdfnjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR07MB757581
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTWFyY2hhbmQg
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgNCBOb3ZlbWJl
ciAyMDI2IDE3OjQzDQo+IFRvOiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5A
ZXJpY3Nzb24uY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBKYWt1YiBHcmFqY2lhciA8amdyYWpj
aWFAY2lzY28uY29tPjsgU3RlcGhlbiBIZW1taW5nZXINCj4gPHN0ZXBoZW5AbmV0d29ya3BsdW1i
ZXIub3JnPjsgc3RhYmxlQGRwZGsub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG5ldC9tZW1p
ZjogZml4IHJhY2UgYmV0d2VlbiBpbnRlcnJ1cHQgdGhyZWFkIGFuZCBzdG9wDQo+IA0KPiBPbiBG
cmksIDMwIE9jdCAyMDI2IGF0IDExOjIyLCBTcmlyYW0gWWFnbmFyYW1hbg0KPiA8c3JpcmFtLnlh
Z25hcmFtYW5AZXJpY3Nzb24uY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBjb250cm9sLWNoYW5u
ZWwgY2FsbGJhY2sgcnVucyBvbiB0aGUgaW50ZXJydXB0IHRocmVhZCBhbmQgY2FsbHMNCj4gPiBt
ZW1pZl9kaXNjb25uZWN0KCkgd2hlbiB0aGUgcGVlciBoYW5ncyB1cC4gTm90aGluZyBvcmRlcmVk
IHRoaXMNCj4gPiBhZ2FpbnN0IGFuIGFwcGxpY2F0aW9uIHRocmVhZCBzdG9wcGluZyBhbmQgY2xv
c2luZyB0aGUgc2FtZSBwb3J0LiBXaGVuDQo+ID4gdGhlIHBlZXIgb2YgYSBsb29wYmFjayBwYWly
IGlzIHN0b3BwZWQgZmlyc3QsIHRoZSBjYWxsYmFjayBjYW4gc3RpbGwNCj4gPiBiZSBydW5uaW5n
DQo+ID4gbWVtaWZfZGlzY29ubmVjdCgpIHdoaWxlIHRoZSBwb3J0IGlzIGNsb3NlZCBhbmQgcmVs
ZWFzZWQsIGFuZCB0aGVuDQo+ID4gZGVyZWZlcmVuY2VzIGRldi0+ZGF0YSB3aGljaCBpcyBOVUxM
LiBTZWVuIGFzIGEgU0lHU0VHViBvbiB0aGUNCj4gPiBpbnRlcnJ1cHQgdGhyZWFkIGR1cmluZyBt
ZW1pZl9wbWRfYXV0b3Rlc3QgdGVhcmRvd24uDQo+ID4NCj4gPiBEZXRhY2ggdGhlIGNvbnRyb2wg
Y2hhbm5lbCBpbiBtZW1pZl9jY19kZXRhY2goKSwgY2FsbGVkIHdpdGhvdXQgY2NfbG9jazoNCj4g
Pg0KPiA+ICAgLSB0YWtlIHBtZC0+Y2MgdW5kZXIgY2NfbG9jayBzbyBvbmx5IG9uZSBjYWxsZXIg
b3ducyBpdDsNCj4gPiAgIC0gb24gdGhlIGludGVycnVwdCB0aHJlYWQgKHRoZSBjYWxsYmFjayBp
dHNlbGYpIGRlZmVyIHRoZSBmcmVlIHRvIHRoZQ0KPiA+ICAgICBwZW5kaW5nLXVucmVnaXN0ZXIg
Y2FsbGJhY2ssIGFzIGJlZm9yZTsNCj4gPiAgIC0gb24gYW4gYXBwbGljYXRpb24gdGhyZWFkIHdh
aXQgZm9yIGEgcnVubmluZyBjYWxsYmFjayB3aXRoDQo+ID4gICAgIHJ0ZV9pbnRyX2NhbGxiYWNr
X3VucmVnaXN0ZXJfc3luYygpIHNvIHRoZSBkZXZpY2Ugc3RheXMgdmFsaWQgdW50aWwNCj4gPiAg
ICAgaXQgcmV0dXJucywgdGhlbiBmcmVlLg0KPiA+DQo+ID4gbWVtaWZfaW50cl9oYW5kbGVyKCkg
bm8gbG9uZ2VyIGRpc2Nvbm5lY3RzIGEgZGV2aWNlIHRoYXQgaGFzIGFscmVhZHkNCj4gPiBkcm9w
cGVkIHRoaXMgY2hhbm5lbDogaXQgc3RvcHMgcG9sbGluZyB0aGUgZmQgYW5kIHJldHVybnMsIGxl
dHRpbmcgdGhlDQo+ID4gd2FpdGluZyBhcHBsaWNhdGlvbiB0aHJlYWQgZnJlZSB0aGUgY2hhbm5l
bC4gT25jZSBtZW1pZl9jY19kZXRhY2goKQ0KPiA+IHJldHVybnMgdGhlIGhhbmRsZXIgY2Fubm90
IHJ1biBmb3IgdGhlIGRldmljZSwgc28gdGhlIHF1ZXVlIGFuZCByZWdpb24NCj4gPiB0ZWFyZG93
biBubyBsb25nZXIgbmVlZHMgY2NfbG9jay4NCj4gPg0KPiA+IEZpeGVzOiAwOWM3ZTYzYTcxZjkg
KCJuZXQvbWVtaWY6IGludHJvZHVjZSBtZW1vcnkgaW50ZXJmYWNlIFBNRCIpDQo+ID4gQ2M6IHN0
YWJsZUBkcGRrLm9yZw0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IFN0ZXBoZW4gSGVtbWluZ2VyIDxz
dGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gPiBTdWdnZXN0ZWQtYnk6IFN0ZXBoZW4gSGVt
bWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
cmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXJpY3Nzb24uY29tPg0KPiANCj4g
VGhpcyBkcml2ZXIgZGVhbGluZyB3aXRoIGludGVycnVwdCBoYW5kbGUgaXMgcmVhbGx5IGNvbXBs
ZXggKHNvbWUgbG9naWMgc2hvdWxkDQo+IHByb2JhYmx5IG1vdmUgZWxzZXdoZXJlLi4uIGxpa2Ug
YW4gYWxhcm0gaGFuZGxlciBtYXliZSkuDQo+IA0KPiBJZiB0aGUgaXNzdWUgaXMgYSByYWNlIGJl
dHdlZW4gYW4gYXBwbGljYXRpb24gcmVxdWVzdGluZyBkZXZpY2UgY2xvc2UsIGFuZCB0aGUNCj4g
aW50ZXJydXB0IHRocmVhZCBpbnZva2luZyB0aGUgaW50ZXJydXB0IGhhbmRsZSBjYWxsYmFjaywg
dGhlbiBpdCBtZWFucyB0aGF0IHRoZQ0KPiBkZXZpY2UgY2xvc2UgaXMgbm90IHByb3Blcmx5IHVu
cmVnaXN0ZXJpbmcgdGhlIGludGVycnVwdCBoYW5kbGUgaW4gdGhlIGZpcnN0IHBsYWNlLg0KPiBT
byBteSBndXRzIHRlbGxzIG1lIHRoYXQgc29tZXRoaW5nIGxpa2UgdGhpcyBzaG91bGQgaGVscDoN
Cj4gaHR0cHM6Ly9ldXIwMi5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGcGF0Y2gNCj4gd29yay5kcGRrLm9yZyUyRnByb2plY3QlMkZkcGRrJTJGcGF0
Y2glMkYyMDI2MTEwNDE2NDE1My4xNjc0MzINCj4gOS0xLQ0KPiBkYXZpZC5tYXJjaGFuZCU0MHJl
ZGhhdC5jb20lMkYmZGF0YT0wNSU3QzAyJTdDc3JpcmFtLnlhZ25hcmFtYW4NCj4gJTQwZXJpY3Nz
b24uY29tJTdDNmZhNjNkZmVjOGE2NDljYzhlMDAwOGRmM2E5MmIyNzclN0M5MmU4NGNlYmZiZg0K
PiBkNDdhYmJlNTIwODBjNmI4Nzk1M2YlN0MwJTdDMCU3QzYzOTI5NDA3MzkzMDkzNDkyOCU3Q1Vu
a25vDQo+IHduJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdM
akF1TURBd01DSQ0KPiBzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZR
JTNEJTNEJTdDMCU3QyU3QyU3QyZzDQo+IGRhdGE9MW5zbnlyY1kwcnhBZ3NRSTF3NU5xRVZOYk14
Sm5pcEo4VVRyRThqM3kxcyUzRCZyZXNlcnZlZD0wDQo+IA0KPiANCj4gLS0NCj4gRGF2aWQgTWFy
Y2hhbmQNCg0KVGhlIGFib3ZlIHBhdGNoIGlzIGNvcnJlY3QgYW5kIG5lZWRzIHRvIGJlIHRha2Vu
IGluLCBidXQgaXQgZml4ZXMgdGhlIGxpc3RlbmVyIHNvY2tldCBwYXRoIChzb2NrZXQtPmludHJf
aGFuZGxlIC8gbWVtaWZfbGlzdGVuZXJfaGFuZGxlciBpbiBtZW1pZl9zb2NrZXRfcmVtb3ZlX2Rl
dmljZSkuDQpGcm9tIHRoZSBsb2dzLCBJIGZlZWwgdGhlIENJIGF1dG90ZXN0IFNJR1NFR1YgaXMg
YSBkaWZmZXJlbnQgcmFjZTogdGhlIGNvbnRyb2wgY2hhbm5lbCB0ZWFyZG93biAoY2MtPmludHJf
aGFuZGxlIC8gbWVtaWZfaW50cl9oYW5kbGVyKSByYWNpbmcgbWVtaWZfZGlzY29ubmVjdCgpIGZy
b20gZGV2X3N0b3AuDQoNCkFueWhvdywgSSBhbSB3b3JraW5nIG9uIGEgc2ltcGxlciBmaXggZm9y
IHRoZSBzZWNvbmQgcmFjZSAoYXNzdW1pbmcgeW91ciBwYXRjaCBkb2Vzbid0IHNvbHZlIHRoZSBD
SSBjcmFzaGVzKS4NCg==
