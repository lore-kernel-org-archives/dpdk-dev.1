Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7408BCCFA18
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 12:59:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D010402CD;
	Sat,  8 Nov 2025 13:59:37 +0100 (CET)
Received: from us-smtp-delivery-199.mimecast.com
 (us-smtp-delivery-199.mimecast.com [170.10.129.199])
 by mails.dpdk.org (Postfix) with ESMTP id 556644021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 17:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solace.com;
 s=mimecast20180618; t=1762534661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Ug/3ZZBpjbEwC2n1H1aSeIMefa/QzzRu49g+Bf/tk8o=;
 b=NgZPcMt4h9X0VCUYiB0Y8RhErOH/XbBVxx0JA2zYX3Mq3Ot+4u5VALgoajO54C8qGKiGxb
 uzIg1XQQO2K0v7JXnPSIUpXt3ZNn9NI3DPDnKXbuc6HQqWoJacjxnGuHNFhCWDSZV91Z15
 TC76+swgKEe02CJXtOwg+xcEOcQ8h4I=
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11020141.outbound.protection.outlook.com [52.101.85.141])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-6VXSuHPxODGwsEOVI5P18w-1; Fri,
 07 Nov 2025 11:57:40 -0500
X-MC-Unique: 6VXSuHPxODGwsEOVI5P18w-1
X-Mimecast-MFC-AGG-ID: 6VXSuHPxODGwsEOVI5P18w_1762534659
Received: from SA1PR01MB8295.prod.exchangelabs.com (2603:10b6:806:389::18) by
 PH0PR01MB994285.prod.exchangelabs.com (2603:10b6:510:38e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.13; Fri, 7 Nov 2025 16:57:37 +0000
Received: from SA1PR01MB8295.prod.exchangelabs.com
 ([fe80::fc86:3650:bc50:fa0e]) by SA1PR01MB8295.prod.exchangelabs.com
 ([fe80::fc86:3650:bc50:fa0e%3]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 16:57:37 +0000
From: Rami Neiman <rami.neiman@solace.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Duane Pauls <Duane.Pauls@solace.com>
Subject: =?big5?B?UXVlc3Rpb246IFdoeSBkb2VzbqGmdCBydGVfcmluZyB1c2UgZG91YmxlLW1hcHBl?=
 =?big5?Q?d_VMA_to_eliminate_wraparound_logic=3F?=
Thread-Topic: =?big5?B?UXVlc3Rpb246IFdoeSBkb2VzbqGmdCBydGVfcmluZyB1c2UgZG91YmxlLW1hcHBl?=
 =?big5?Q?d_VMA_to_eliminate_wraparound_logic=3F?=
Thread-Index: AQHcUAdEFyv3lBIccEmtmK06UZiWXA==
Date: Fri, 7 Nov 2025 16:57:37 +0000
Message-ID: <SA1PR01MB82954E1727004B247E462C269BC3A@SA1PR01MB8295.prod.exchangelabs.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR01MB8295:EE_|PH0PR01MB994285:EE_
x-ms-office365-filtering-correlation-id: f50bf778-ea29-4451-d9cf-08de1e1ec11b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700021
x-microsoft-antispam-message-info: =?big5?B?NTNGRkFRUWdSa3pWNDluK2IvaFpCazNrRnpYSUVJb3lpQ3hzdU56dHJFdWJERlUv?=
 =?big5?B?Wisza0JsRE9qWkhpZFNDcHAvOEoxTzl1ak9BWjFXeWxod0pnUlQ1YTZldXVaV1NM?=
 =?big5?B?OGV3QmlGOTJpV0M3SXI0ZzFXa0JoU1pMTmRvdkxjVThsY2NGdzJCU1RJUllNQnFa?=
 =?big5?B?b0VGVWtnUnV2WGNpdWFnT3pmMW9JR3JkZTMzUG9WamJZYWFmOGJkQUpHZWNKdE50?=
 =?big5?B?MW1EQWJJOFBFbVpTbnBBRjIxQUVna1MxK0xUWlN1akJ4cVRoNlZVQnFmbWFnUnZT?=
 =?big5?B?NEJQQkppUlowci9ra2JIT3FDK29GU3lUWk9RNk9mODl6ZFJaNzNXbFJuSk1reTJO?=
 =?big5?B?NjVVLzlxVUc0dTk4RHBUdFB6SkpETkVtYVRWNjhSbm1BaWRVTlFXSlJYTDBZNzZD?=
 =?big5?B?dTZXeHo5cWJob3pIdkVENEMxQlFwR2QwVS9ubEpZZjBVNzRZZ0JlVUlBTlZreVlu?=
 =?big5?B?Vy96SkdRRnFOY2tlUkZub1ZIN3FGRXpjUldEUFBxb0NmUU9vQWZwd1Yvck14MDhS?=
 =?big5?B?akoyVkNqcDhmc2NLWjZpU0w4eTFqMVkxZWVhUmRQZEpDKzF4QlJQckhGRnlBaTRB?=
 =?big5?B?bnZLRGFRUVplaHZoZUtsQnQ4YkxlNVhzVFZqQW5STTJjZHRrVE5HTlc5dENSQU9s?=
 =?big5?B?WmRsUVU1R1A4eWZlWmFra05EaEZIWVRncGMyVW5Lay8yTVl6TGQzT0xmeGV6blA4?=
 =?big5?B?MHI4REJiRzdmYUVXSXNKOHZZVTNZcE03eUdoZmZ1dnc1T20yOXBtNi9VMnVzZFBj?=
 =?big5?B?anJzMVJUR1daL05CcnhnaUxyazZKU0VBM0VLR2RGSzVKR2tqZk9Zd2Q2QWtGbndF?=
 =?big5?B?ZlpIQXBRbXM4WmNFK1duS3lSVER3YkNsVXYraVIxSW9CRlU5VmU4cVcxTFozdlBu?=
 =?big5?B?cm5nNFN4aHRjUzFxbDFycTBSOWJ1ODNDbjlJcC9VcVpYd045RjhIWVNPQVJubkcv?=
 =?big5?B?cEJkWGN0cThvZmZ5THFRaExGSlBYMUZtVmgyd25yb3lvMlNvRXRPTjBIam9XcEFN?=
 =?big5?B?Mm1rT3JtQlplNnBIc0IydDIramlDdnRIMitDZlhDTTlnTzUwWUlrdkszOVBKUTA0?=
 =?big5?B?OTVwNkQvbnhoSGljQzU1ZThlcWZ6czhMTFBqZ04vT2xCNE9wRmpuTFNXWW43V0xq?=
 =?big5?B?M1JwMjlJZTllN2FTRU90K1NHamlBL0lzSEhhbER0SHhUbi8xT1ZvMXFzMWVUa3JP?=
 =?big5?B?L0R1MHFwcmlyVDYvWVVPSU1ldWRkd2ZGUE5TVWtnTjFrK1N6ZnZ2M09aYldJWXAy?=
 =?big5?B?SWl0MUJWaWhSZ3JrYjIxZERBYnJ6ZWtSc1JuRXBGTERXL1lhWWhUL2NENGtaUC8x?=
 =?big5?B?ZHdWazdVbHdRWEozdGlrYVN6N3JRTTZva2lLSEhMR3RkaE5qZ2dRNzlHUm5FMmkr?=
 =?big5?B?dk9oUDhSQllxMTh4UW1UbTlNYXhzbmZEUnFHS1djdjBhanQ2RmM0czFQdi9XNFRi?=
 =?big5?B?SDk0dFVYUG9RM0pDUTZTNUl2cnQydEJlSFo4ZklFV3NORTBrYjRGQVhvYWlxL09w?=
 =?big5?B?eUlBZHp3RzFkbU80Q0d2VTZML05jUXRxbmliSVk0alZid01UZUgyaEYzVmpyUFc0?=
 =?big5?B?RlVpTGtRbDNPa2dvOTllWXZnMmJxVVZHZ0x2T2dYVmNsTmxDcldvOE5Famw0R3Bj?=
 =?big5?B?bFN0S0tacGZhMGRsdUVUNnFSVnRacVRPVGhpcEkxanZqRkV2YXhzTXUrRG5mUk5K?=
 =?big5?B?YWZKbkRHUmZSNlZzZkEvbWhSUHZtaDRKVVVyaTR1NjdCRlRlMXZtK0R0aDE2eXpT?=
 =?big5?B?WVJMcmFwUEFIbWlrMm1nVmdYSG1jSWFVY0FxYmdrMnA0UTJQUEQwODM1ZU8yeENK?=
 =?big5?B?SVltUjNrZXlxOUNsNXRRdmVYYWVSTVVsYTNoQi9lVGlJeEZPS2ZRU2s3VDNVMW84?=
 =?big5?Q?2ayRvbxU9Prayh/OcERMnOIfgJcAl7EaBCSzbM7/O/F7uy3f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SA1PR01MB8295.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700021); DIR:OUT;
 SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?aCt3RG1YY21uUTdxcWpBKzA2N2VLSG5iUG9kOW5jVUxROWtKWDl3ZDg0L2JyTTBM?=
 =?big5?B?MFRBSFRod2hrZkxxOWtMc2x5WGdxWmZxSVFvMlJBeFExZ2tXSFVzQzZKU3dHeGhj?=
 =?big5?B?dEovTlpUYkphR0tRNWhCVGlQbFVrS0NoSnRzMU4zVzhBK1REbjNBcVV4T2xGNlVh?=
 =?big5?B?SFpKRUJUckc4WHpGVUUycDBNb2g4M0p3Q010bFhWRitoNHVWb3Y5MEVpSFFzUVhE?=
 =?big5?B?K0dIdXhra2U0MS9TZytyaDFUU0RFUysvbkRZYytQZ1FtN05hYW85cDhNcnh3OTRa?=
 =?big5?B?ZFNhZ08rWVhTbHJ1S0taYjJRSVhQZGhMN0pTV3JUN2NoVzNNcWt6cnd0aFNZQzB6?=
 =?big5?B?bVRsaWxoa3o5M3FqdFArY09NT3hUZlhCRURidGJXMytObWdXT09NdHU5M3l0UHVH?=
 =?big5?B?NzlwNElkeXluL20zaU9xSzNzdEVkQ2ZiYk5MSFp3UkhpTUQxZEZTYnpVaWNPVnZz?=
 =?big5?B?RXY3a3o1QlZUWG5qSC92NndUUWRVYjZTOERXeGlzUWY4bU9adTFWaUhmUXpzK1F1?=
 =?big5?B?R2NDZTRmSmdIUmZhbzNhejUvbEw4M2hKRElvQ0EvSXA5Nmh4d29nazR5SUZCZ1Bi?=
 =?big5?B?eDVoNTRNdEtmdU1QV3kwbzZnSThSTW02UFFWdThNN0ZUaVRBaklZZU5WcDR6VVJS?=
 =?big5?B?cVdTckk0dXE0T0s0ZStoQkZ2Yzh1N1EwSzNSOFhULzQySUVRbHpSRmlMdUFsdmFt?=
 =?big5?B?MkdXZHRDemhkK1lXWUFLRkNJNWYyK2NQYmZqUnVGNXVwUU5UQS9wNVJNVkNtK2FK?=
 =?big5?B?UG5DcUdjZTJEVnNlNzYzU2VLMG1PWnVrd0R6TEY1QXc5Rkh0R0Z5WWdyNk1UcVpB?=
 =?big5?B?RG5KUElUcW5Pa05iVGVyQkZpUGZjWlhtTDZUdE9QaE1xM2ZpWTI4aEZVU2ZoUlFh?=
 =?big5?B?YUwxam1yZUV0c1l5cE1ncStld2VZZUFTcEZaWXBDZmtDTWlKZFUvMWoxWVlTUWJx?=
 =?big5?B?N2k0QUxaVjFYQUtaZzVlSXY4YVBtYnZxZlFBUkVLQndVY2piRTJiMWtPS3h0YzI1?=
 =?big5?B?dzh0dHFQUE1jSmNtMFV4eFl5UVBtaWtyLzdWazV5aDhkQzVxaXVSUEFUcmVITkI3?=
 =?big5?B?VkgweEJrYzJwZ0xDenJsSUROdFRvbGQ0ZzBpbmRWWVNPUnBWQlBuTUdMMkNQQXM1?=
 =?big5?B?UlF2WmNSa0xISUMyNDdJanpFVDRMV3NpWGxpUU5KSGtjLzVVZUIra3hQckVqUHRR?=
 =?big5?B?WlI4ditPUEh1RXVVSmRpTm4vSkRiS3NFbEVUWFMwYVJySEQ1bEF5cUtnekxNK1lp?=
 =?big5?B?U0VCYUhwWVUzaTY5aDJRbWF4M3NtTWFKNlVFa0tMRVM4Rk5mUUowMHJJSVBmT1hH?=
 =?big5?B?ejJnckpuaElFcU8rL2lUb3JJM2pLOE1UM1RlTkRiaERBQzEzU09oTjhJd3kwTVZG?=
 =?big5?B?RXlZQ3ova3ZXT2JjU0NpNDdqMjQ3YUcrYlQzN2p2aXRrNmRneGNwS2ZYNUllVzVS?=
 =?big5?B?R0M0ZFFWejNXZGxJTjErQVlzOGp2LzFrWXVsRlVBY2R2SDY5YzY3dzdBUFcyTnla?=
 =?big5?B?NVNqdE52UTgzb1RUUEdHMTlRZUJXU2QxWXFodHlIU0VKUytRNGlwWEIzR2VobUZj?=
 =?big5?B?TnIrcWFmaGpORksyd3NxRFkwTHUyS3JuUDltNFFiYW1EYjJoaURTeHRpTlVLWWVp?=
 =?big5?B?c094bFZiUWFmNkdFMlo4aXBXMmU2Y09VZWR5Yzk2UlJnVFBMelQwRGZZZ1dxT0NZ?=
 =?big5?B?TnZ1Szh3V3d5T1VYUWs1akZWZnRIcVNqY05zWkNydGhPUmNFOEFTVWJyUUpaVGVP?=
 =?big5?B?MFJ6MHVaWmUzd1M0Nk5BcmVsM09jMCtWUVVORytCNEJZc0RXYmoyaDR4ZHVWOEtx?=
 =?big5?B?enpWOXZ1UmxRbnJSWHN2NEVTN1FMRTE5SlByT1pJS0N5clRZRzZ2cnNyOFcybjJE?=
 =?big5?B?aVVpN1hkRXlzcE5uZTR4aGxPQ01UY0gvdG85VitGMTVmRHduZytwcG9MQXoydDEr?=
 =?big5?B?Wk8rQ2NGZHNTRzdtOFZLaytCVHJ0VmlhMXpTWWJjN1FTeFlCTDRiTlcvSy9FM0xD?=
 =?big5?Q?RxousB0uE8LoWxRJ?=
MIME-Version: 1.0
X-OriginatorOrg: solace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8295.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50bf778-ea29-4451-d9cf-08de1e1ec11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 16:57:37.0821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ce001ea4-74b1-40fc-9184-edb4a21a35d5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyulPwY+65MUGNVhm97e9u1FMo9p5Ty4r6ezjBUy9G7FWNtcydDwb/0YlKwpWeEWs1GNFSeM2MIgbRQQS2+Xxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB994285
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hUbETn_RCPi52azOSwzicULUsWdjqZMf9_meTlDc-Dw_1762534659
X-Mimecast-Originator: solace.com
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_SA1PR01MB82954E1727004B247E462C269BC3ASA1PR01MB8295prod_"
X-Mailman-Approved-At: Sat, 08 Nov 2025 13:59:34 +0100
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

--_000_SA1PR01MB82954E1727004B247E462C269BC3ASA1PR01MB8295prod_
Content-Type: text/plain; charset=BIG5
Content-Transfer-Encoding: base64

SGkgYWxsLA0KSSBoYXZlIGEgZGVzaWduIHF1ZXN0aW9uIHJlZ2FyZGluZyBydGVfcmluZyB0aGF0
IEkgZGlkbqGmdCBmaW5kIGEgaGlzdG9yaWNhbCByYXRpb25hbGUgZm9yIGluIHRoZSBhcmNoaXZl
cy4NCk1vc3QgbW9kZXJuIGhpZ2gtcGVyZiByaW5nIGJ1ZmZlcnMgKGUuZy4gc29tZSBOSUMgZHJp
dmVycywgc29tZSBEQiBxdWV1ZSBpbXBsZW1lbnRhdGlvbnMsIGV0Yy4pIGVsaW1pbmF0ZSB3cmFw
LWFyb3VuZCBicmFuY2hlcyBieSB0YWtpbmcgdGhlIHJpbmehpnMgZWxlbWVudCBhcnJheSBhbmQg
bWFwcGluZyB0d28gY29uc2VjdXRpdmUgVkEgcmFuZ2VzIHRvIHRoZSBzYW1lIHBoeXNpY2FsIGJh
Y2tpbmcgcGFnZXMuDQppLmUuIHlvdSBhbGxvY2F0ZSBOIGVsZW1lbnRzLCBjb21taXQgZW5vdWdo
IHBhZ2VzIHRvIGNvdmVyIE4sIHRoZW4gY2FsbCBtbWFwIChvciBlcXVpdmFsZW50KSBhZ2FpbiBp
bW1lZGlhdGVseSBmb2xsb3dpbmcgaXQsIHBvaW50aW5nIHRvIHRoZSBzYW1lIHBoeXNpY2FsIHBh
Z2VzLiBTbyBmcm9tIHRoZSBDUFWhpnMgUE9WIHRoZSBlbGVtZW50IGFycmF5IGlzIGxvZ2ljYWxs
eSBbMCAuLiBOKjIpIGJ1dCBwaHlzaWNhbGx5IGl0oaZzIHRoZSBzYW1lIGJhY2tpbmcuIFRoZXJl
Zm9yZSBhIGJhdGNoIHJlYWQvd3JpdGUgY2FuIGFsd2F5cyBiZSBkb25lIGFzIGEgc2luZ2xlIGNv
bnRpZ3VvdXMgbWVtY3B5L0NMRC9TVE9TIHdpdGhvdXQgY29uZGl0aW9uYWxzLCBldmVuIGlmICho
ZWFkK2J1bGspIGV4Y2VlZHMgTi4NClBzZXVkbyBpbGx1c3RyYXRpb246DQoNCltwaHlzIGJ1ZmZl
ciBvZiBOIHNsb3RzXQ0KVkE6IFswIC4uIE4pIC0+IHBoeXMNClZBOiBbTiAuLiAyTikgLT4gc2Ft
ZSBwaHlzDQoNCg0KRm9yIG11bHRpLWVsZW1lbnQgZW5xdWV1ZS9kZXF1ZXVlIGl0IGVsaW1pbmF0
ZXMgdGhlIKGnaWYgd3JhcCCh9yBzcGxpdKGoIGNhc2UgZW50aXJlbHkgoVggeW91IGNhbiBhbHdh
eXMgbWVtY3B5IGluIG9uZSBjb250aWd1b3VzIG9wLg0KUXVlc3Rpb246DQpJcyB0aGVyZSBhbiBl
eHBsaWNpdCByZWFzb24gRFBESyBkb2VzbqGmdCB1c2UgdGhpcyB0ZWNobmlxdWUgZm9yIHJ0ZV9y
aW5nPw0KZS5nLg0KDQogICoNCnBvcnRhYmlsaXR5PyAoaHVnZXBhZ2VzIC8gVkZJTz8pDQogICoN
CmluYWJpbGl0eSB0byByZWx5IG9uIG1tYXAgdHJpY2tlcnkgZm9yIGh1Z2VwYWdlIGJhY2tlZCBt
ZW16b25lcz8NCiAgKg0KTlVNQSBsb2NhbGl0eSBjb25zaWRlcmF0aW9ucz8NCiAgKg0KaGlzdG9y
aWNhbCByZWFzb246IGZpcnN0IGdlbiByaW5nIGRpZG6hpnQgYnVsayBlbnF1ZXVlIHNvIHRoZSBi
cmFuY2ggZGlkbqGmdCBtYXR0ZXI/DQogICoNCnJlbHVjdGFuY2UgdG8gYWRkIFZBIGFsaWFzaW5n
IGJlY2F1c2Ugb2Ygc2VjdXJpdHkgLyBpbnRyb3NwZWN0aW9uIHRvb2xpbmcgLyBBU2FuIGlzc3Vl
cz8NCg0KSSBqdXN0IHdhbnQgdG8gdW5kZXJzdGFuZCB0aGUgYXJjaGl0ZWN0dXJhbCB0cmFkZSB0
aGF0IHdhcyBtYWRlLg0KQmVjYXVzZSBvbiA2NC1iaXQgTGludXgsIGRvdWJsZS1tYXBwaW5nIGEg
MaFWMiBNQiByZWdpb24gaXMgcHJldHR5IHRyaXZpYWwsIGFuZCBidWxrIG9wcyBpbiBEUERLIGFy
ZSBleHRyZW1lbHkgY29tbW9uIKFYIGl0IGZlZWxzIGxpa2UgYW4gb2J2aW91cyBtaWNyb2FyY2hp
dGVjdHVyYWwgd2luIGZvciB0aGUgoadob3QgcmluZ6GoIGNhc2UuDQpTbzogaXMgdGhlcmUgYSBj
b25jcmV0ZSBibG9ja2VyPyBvciBzaW1wbHkgoadubyBvbmUgcHVzaGVkIGEgcGF0Y2ggYmVjYXVz
ZSBjdXJyZW50IHBlcmYgd2FzIKGlZ29vZCBlbm91Z2ihpqGoPw0KUG9pbnRlcnMgdG8gcHJpb3Ig
bWFpbGluZyBsaXN0IGRpc2N1c3Npb24gLyBwYXRjaGVzIHdvdWxkIGJlIGFwcHJlY2lhdGVkLg0K
VGhhbmtzLA0KUmFtaSBOZWltYW4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
CkNvbmZpZGVudGlhbGl0eSBub3RpY2UNCg0KVGhpcyBlLW1haWwgbWVzc2FnZSBhbmQgYW55IGF0
dGFjaG1lbnQgaGVyZXRvIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIHdoaWNoIG1h
eSBiZSBwcml2aWxlZ2VkIGFuZCB3aGljaCBpcyBpbnRlbmRlZCBmb3IgdGhlIGV4Y2x1c2l2ZSB1
c2Ugb2YgaXRzIGFkZHJlc3NlZShzKS4gSWYgeW91IHJlY2VpdmUgdGhpcyBtZXNzYWdlIGluIGVy
cm9yLCBwbGVhc2UgaW5mb3JtIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZGVzdHJveSBhbnkgY29w
eSB0aGVyZW9mLiBGdXJ0aGVybW9yZSwgYW55IGRpc2Nsb3N1cmUsIGRpc3RyaWJ1dGlvbiBvciBj
b3B5aW5nIG9mIHRoaXMgbWVzc2FnZSBhbmQvb3IgYW55IGF0dGFjaG1lbnQgaGVyZXRvIHdpdGhv
dXQgdGhlIGNvbnNlbnQgb2YgdGhlIHNlbmRlciBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBUaGFu
ayB5b3UuDQo=
--_000_SA1PR01MB82954E1727004B247E462C269BC3ASA1PR01MB8295prod_
Content-Type: text/html; charset=BIG5
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi all,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I have a design question regarding <code>rte_ring</code>&nbsp;that I didn=
=A1=A6t find a historical rationale for in the archives.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Most modern high-perf ring buffers (e.g. some NIC drivers, some DB queue im=
plementations, etc.) eliminate wrap-around branches by taking the ring=A1=
=A6s element array and mapping
<i>two</i>&nbsp;consecutive VA ranges to the same physical backing pages.</=
div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
i.e. you allocate N elements, commit enough pages to cover N, then call <co=
de>mmap</code>&nbsp;(or equivalent) again immediately following it, pointin=
g to the same physical pages. So from the CPU=A1=A6s POV the element array =
is logically
<code>[0 .. N*2)</code>&nbsp;but physically it=A1=A6s the same backing. The=
refore a batch read/write can always be done as a single contiguous memcpy/=
CLD/STOS without conditionals, even if (head+bulk) exceeds N.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Pseudo illustration:</div>
<pre class=3D"elementToProof"><div style=3D"font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);" class=3D"elementToProof"><code>[phys buffer of N =
slots]=0AVA: [0 .. N) -&gt; phys=0AVA: [N .. 2N) -&gt; same phys=0A</code><=
/div></pre>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
For multi-element enqueue/dequeue it eliminates the =A1=A7if wrap =A1=F7 sp=
lit=A1=A8 case entirely =A1X you can always memcpy in one contiguous op.</d=
iv>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>Question:</b></div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Is there an explicit reason DPDK doesn=A1=A6t use this technique for <code>=
rte_ring</code>?</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
e.g.</div>
<ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation" c=
lass=3D"elementToProof">
portability? (hugepages / VFIO?)</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation">i=
nability to rely on
<code>mmap</code>&nbsp;trickery for hugepage backed memzones?</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation">N=
UMA locality considerations?</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation">h=
istorical reason: first gen ring didn=A1=A6t bulk enqueue so the branch did=
n=A1=A6t matter?</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation">r=
eluctance to add VA aliasing because of security / introspection tooling / =
ASan issues?</div>
</li></ul>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I just want to understand the architectural trade that was made.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Because on 64-bit Linux, double-mapping a 1=A1V2 MB region is pretty trivia=
l, and bulk ops in DPDK are extremely common =A1X it feels like an obvious =
microarchitectural win for the =A1=A7hot ring=A1=A8 case.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
So: is there a concrete blocker? or simply =A1=A7no one pushed a patch beca=
use current perf was =A1=A5good enough=A1=A6=A1=A8?</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Pointers to prior mailing list discussion / patches would be appreciated.</=
div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks,<br>
Rami Neiman</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<hr>
Confidentiality notice <br>
<br>
This e-mail message and any attachment hereto contain confidential informat=
ion which may be privileged and which is intended for the exclusive use of =
its addressee(s). If you receive this message in error, please inform sende=
r immediately and destroy any copy
 thereof. Furthermore, any disclosure, distribution or copying of this mess=
age and/or any attachment hereto without the consent of the sender is stric=
tly prohibited. Thank you.
</body>
</html>

--_000_SA1PR01MB82954E1727004B247E462C269BC3ASA1PR01MB8295prod_--

