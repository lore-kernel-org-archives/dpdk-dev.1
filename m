Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C63C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 04:50:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 883E040E38;
	Wed, 21 May 2025 06:50:54 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
 by mails.dpdk.org (Postfix) with ESMTP id 0368540E34
 for <dev@dpdk.org>; Wed, 21 May 2025 06:50:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2j0mPJOgOj7SInPzEky9IBYn1zJwewamzhXjSdZSywq+P/KTdWXCVbWrob/SEk55r57mnz0MPpEzrqU9KJ99H0yFLMqHKEPLjpH2p0BVDAirQ05e9DV4k0PZeNnXNRm2jWvCW+5BF7VEc5TK2pKREe0qgbLclcob5ZK+w0vWtkOHST2rm8BZWJoyvB0ho+ZXtGHRYEJ7e1tT4z12qrg87ldqYjwoi/5Pf/z0TQcmIHVdcKs9z+Ib3nAaUZTCIc0IsIRUbQ34CQC4pwfvKjf5PdSvC/C2JrC0mok7nGzKtH7nAr2cdYMrxYkLT4yP+sU7P21/0TZusg3/w0KyomKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUxh/SxY72uQXJ2duXR/uHQ2OUxd84ia4w/lDB6bUDI=;
 b=rj87LiUsyH3st1+zUz6fxr87c+KAjB396p2dM9nh/tz3HuttrjAZRWGdqejetF3VQwKKxC4HHYztS5u+HfC2JVA9XZz/rLdYIU0kUUihMvyAxQYppCS1DD0GfqicHX9+lOr+la2CVKquEumd7EP8vsTiDqR0ju+GMiPOnw/tiBy8v8dSGADM15Z2qahL37jS6B+oYACaHQIJRONzUmNJaCAwPoGTDod0w/zvHViQEbwM9bo6/1W/dwTE5QKhygT5pgfJUgHaixycpHHDAdfPmGCZm5tofjxWDBR2DTNHfkUicQHpd71T6kYMvB+B9LDU+Kt9ri0JhJKkqW8dfM5xfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUxh/SxY72uQXJ2duXR/uHQ2OUxd84ia4w/lDB6bUDI=;
 b=FBXTboudTTPRzqv74065wfXqiT/XW6VCNP5taTEYlu0h/W6RxgPLPsMH1nHBdfjE6QWq27/Slal1KBRdO47223+7uSrqFyrh6YsgryykAZdh+H8mcjARDxOMxkj+dnd4p+9ECAPkEmu/wmIynSR4CKlU01i9nyf6WF1vTDIXNj90MopIP8XGfGxx52x41mZxTJ6sRxW5xZio3x8Z0lacd6suew+BB2ffashhWbt4W0yPXP8dQqBaay8NTuLMB8jsLy72i1rnGR4bCRqmIriA0lYL+aVrXG41Wq1ek9XQnnX6tz/OgA5nwlD8tpkXLx86GDA+ldjvtlt9bJUjwWkJwQ==
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 04:50:51 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 04:50:51 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: "Hemant Agrawal (OSS)" <hemant.agrawal@oss.nxp.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
Subject: RE: [PATCH 3/9] common/dpaax: support 12bit SN in pdcp uplane
Thread-Topic: [PATCH 3/9] common/dpaax: support 12bit SN in pdcp uplane
Thread-Index: AQHbyUtQ2YE4FaDi8kynZQLZizMlgbPbC4WAgAF3vMA=
Date: Wed, 21 May 2025 04:50:50 +0000
Message-ID: <AS8PR04MB81986BF3D7500274EF0A2FB3E19EA@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250520055133.506071-3-g.singh@nxp.com>
 <9e4ce500-e3e6-86a5-008c-013c8ff313af@oss.nxp.com>
In-Reply-To: <9e4ce500-e3e6-86a5-008c-013c8ff313af@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8198:EE_|PA4PR04MB7823:EE_
x-ms-office365-filtering-correlation-id: 5cab7ebc-7e37-437a-efab-08dd98230f9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZXpGZzhaczEwZVJEM3hWUFZEcG56TFJ5RHVHdzNmeU5kc1FkcU5PSFUzYjVK?=
 =?utf-8?B?dG5DNGVKWGZsa2FkU0FGTXByUFcxdkFYRU52SUZLekF3dVphSGJJSVhVbDlT?=
 =?utf-8?B?emtPVzZBRGRzVDRuTXkrZVlyZnlFNW5XNkpXSHZ3M1VMUzNVbjZFamVXL1Rh?=
 =?utf-8?B?eldybkhiUzJVbXFkbHBOb1V1NktabVh1NmdscER3YkplSHhFTGtxN0VGVndW?=
 =?utf-8?B?T2MzOFZGRTJ0UGZEbjgrc2ZxendvOFNkYk1MS0ZGaVcrRTc1TDBQeWNleGs5?=
 =?utf-8?B?bFRoV1FDUC9qZjJ2NCs2dStYZ2pGa0hZRFYrUFdmV2c2RERhL3k0OUNTbWMv?=
 =?utf-8?B?dW5KTEhBUGl6TVluSjJRRXJwZUtTdUpXMkoyUUZaM2FOdzdaakk2cWw3RUV3?=
 =?utf-8?B?VVZGTjh6bk5yK2JsZHpiNkR3ZHE4SG9oNDVnQ1k3bHFpOTBGZGlWWGwyVkxv?=
 =?utf-8?B?UzMzZUxzaEhLSTMyRDhVbkxBNWovOWRXMG9COWUwOE8yOGxyWTZPeTc0NFZr?=
 =?utf-8?B?bjIzaFRPdnE3RnlpcXgwbEpMY1g5bFhhYVZaaVhBS3NtMENRRjlZK3NrR1lD?=
 =?utf-8?B?TVpUVzY1UDZnMHdVU1F6UjhNaUVhYzlqMERDSGpBNjRwZ0JOODJva2tnTDRK?=
 =?utf-8?B?bUhESnJYam9PTnNKWWROL0tWZXNNTTlBaG93WTBSdHh2ZVB1R3dBQUdHVXV2?=
 =?utf-8?B?dGJlVys1TGlWeWZPK095bTNSeTNKazhYK3JCNlRrNmxaZ0ZVUFkybzVXbzdM?=
 =?utf-8?B?T3NMVWdFTTBwOTNPaUE1VXdobVJSY2xrbXpQRGRWRkJ3MWV0YnlRUmFuRHBY?=
 =?utf-8?B?VWdqYnJVR3UrQ1U4MHUvV3EzSW5zYlNKMEtsWm5vOGtFUndVd2szTDZBeFY1?=
 =?utf-8?B?SkpBU2l1VUlIWkxnSmJySEpUY1dDM1d3T01PRmFxKzJGeDJVN25VZ3ZCQzA3?=
 =?utf-8?B?Mm9qcUI1Y3ZCelcvVGV5REVoVDBFZ1R2TGZKSlFZcjA1VDdMc3c4RFY3NFBi?=
 =?utf-8?B?M0xDdEVQWmZHaEhRU2V2Zjd1MldqTStkcWwrQ3VJbzJ4VWhqT3hwOXFrY1NF?=
 =?utf-8?B?YXBkZkdTWTlXblE3OXRPZTN4MExVWkVhb3lwUEU0VDlaa2dvaHZzVHpsZjZ1?=
 =?utf-8?B?Q1JVYW5oQ0cvazhnbmkzSjEzeEhDRGdBeHhraGg3SWpKcnE2L0xXaHZ0Vlhi?=
 =?utf-8?B?RVdsY09ydnZ1UHZFZ0dQbmhrT3BlRmxtU29nNWpQSVVlZDFvZ3BKSG5oRnZt?=
 =?utf-8?B?WkpEUnFhdGdnaUV4eWZ4ZmRrc3YxNHF4WGh3bFRmREhSMEE0d0hwbjQzOG1N?=
 =?utf-8?B?Y09NM0Zia1JUeFdQdDZYL3lMeWs4N2EwSlV0UEdnY2FWQU8wNVVmUEZmV3F5?=
 =?utf-8?B?RFVjTWt5bUhPb1pvZnZEU1FyOTlLOXZGajdGS2ZyZkwvVy93L1ZNNlYrd3Ry?=
 =?utf-8?B?dGNOeGJsSTlYcmpLUzZaSUl5UXNETWtHVlgrWXFLY3BUUEhvTEhicFdySmh2?=
 =?utf-8?B?TXRGZVhkVWV4djQ2TFVNUTdOellSYUwxTGhkMm1rMHRlVkdPTzdjMFhBUHNi?=
 =?utf-8?B?VVdnaDlHZzRvQ0FnYWlzVERIVitiWHVvUWZIalZ0eHlrbXBEOElBYVp5NFdV?=
 =?utf-8?B?aWtPeU1yMU1JUjBUc1RqcWFMTzV0Wk9LV3MxK2Q1d3g5c2ErMGNOY3VCbmVY?=
 =?utf-8?B?UStxUlhHU24va1AxVms5Ni9QYVJLbzZBaWRYMTQwWVhtQ3BhejJVU1lUMEQy?=
 =?utf-8?B?RjljZi9sdjZpMmpkUE5PVHV5aWdmbVpSMGZTMldrOUgvU0RqR0FRRFFMK0Nu?=
 =?utf-8?B?N0l4MFlzVlJrT2t5TlE4YkprVkNmZldVcEtuSEh6cDJSRzZiYjgwS0NXZEpq?=
 =?utf-8?B?eDQvakllZVZLMEdxS3BnajJZNC8yRktKc0Q4SEEzb0Q5SnRMNkRLOVNBUU5O?=
 =?utf-8?B?bnVzN1hCTFg5VnE4U2RSZU9BaFlyVFVFRTlZM1hyZTVSTDM3c3JKdU9rS1Vw?=
 =?utf-8?B?RTRzUWJxLzNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REJrdXFUb0Iva2JER2pqNWxzb3l6TkRQWmprdEZLRzZsNW9VYW9SVEwydis1?=
 =?utf-8?B?aG9hS0ZaQ2R2YytsdzYwN3F2ZzJMN0FNallqNHBKRHB4bVZ5R2VEZXBmMy9J?=
 =?utf-8?B?Y3RzcFlBdDZWMzVDV2plYTYreklQVFZBSy8rNnZqeGFydW9ENlgyZlo0WEpM?=
 =?utf-8?B?cDloQ3hoZGNoblVjb21DNnFGQ05MSnJLa1FWOURxZWh1c1MvemVYNk9TZW5L?=
 =?utf-8?B?cnJKNUJpdHBqZ29yUk5QRUFJSWUwdFhrcFNaQ1FWTnp4UUU3bmNCR2tRUVRO?=
 =?utf-8?B?dlVRaWx1TXU3TnVzUE1XU2x1cU9QdVFwK1NZa25lWmZmTlFkKzQxUlVxNWYz?=
 =?utf-8?B?N1F5UU1KL0tvMjdYRld2Z1hmcEJDUlZEdUVPcUhkQTZ0Q0I1TFFidjlpb3px?=
 =?utf-8?B?akthUE5KeGRHWUFWUFVLeGkwaTJKNEhYYjh1SGZBSXZqS2FSb09EdGhjQW1r?=
 =?utf-8?B?T1NDYVpDWURSVEpWR0FwcEVOT3VCR3NQK0hyVFZ5WGUwaXVKUjcwZXYxMmRu?=
 =?utf-8?B?akJPa2VrcDV5UDZvN0MrSTNLMkdsZmVlNmoyT1JOZW1OYnJPajIzcUZJRDJo?=
 =?utf-8?B?Uk9DYXZvcnNIOENEbUZZMm84QkFNWXZKS0MzVndRWThIMEU2ZHJBRklyaWpy?=
 =?utf-8?B?RENXZm1YdjBtcDBBeFhQS01jcExZMTZnYytZUXBnUWRXTnhuWFY1LzJwNHZq?=
 =?utf-8?B?MEZweVdsYjQ1MUtKRlRNeURQdXhvMHJDdTJaTUI1ZGVNRjRxRWU2TlZRMVl0?=
 =?utf-8?B?cjc2RWpmVmZXaVZxUVNlT250NUVBdWFNVzZ2T1JSUEVDVWVYYnFYaVJkOW9H?=
 =?utf-8?B?aHNmMmhqMi95V0l6bmxmUUoyRzNnMnpOdXIxcGZxYk9FaG5VRWdId0pOTzQx?=
 =?utf-8?B?eVFrNldKL0FBaG5KUTQ5Zk5tVkZFaVpZMllhcVlMU3VqbXlUUUxNaHdZbVdU?=
 =?utf-8?B?MUlEYU1VTGFkS3BYNk1oRkNXUkJxQ293TFVyY2tPZnhFQmk4NFVnTWdrTFgr?=
 =?utf-8?B?TndQZ3kwcXVOS1hweUhCOGVhbzdmVnhzUGw1WGUvenRzVUNneC95UXdmYXN3?=
 =?utf-8?B?clBjdHNXbW1oRkJsWWliNUlmVCt6TjNBL1pjTHFQdUhuQjB4cXdZMzYzbzFx?=
 =?utf-8?B?MGtOV1FsaXZpRGZoT3VDV1lhQ3hFYjk0OGdBdzlkRCsvVHRZVVl1S1hjRnVt?=
 =?utf-8?B?YjFlcEYvdmxsUWFSMkd5L1JaQ2hVRmNHbkZYb05Hd2t6R3RqSWlwQ2NNZTF0?=
 =?utf-8?B?TmxZaVMwc3ZxNWJ2TVgybDdEdks4R1pGc3BvVzZUSjE2YnA3Z1cwRkl4SHdC?=
 =?utf-8?B?R1F6V2VncElwTkJ5Z0huQjJKZUJFVjA3djVYc2grWUpaY09sVFRTRDdBWEwx?=
 =?utf-8?B?UEFpMDNWQzNtcHhRcEYyV3BsVWxadkFKSGs3VzdSdjJicjArRW5VR0pqR2hx?=
 =?utf-8?B?MnB0Z3BVdFJBUUdGdVU4QWwzak12TnVpNGluQzZZWnhVRXNWZ0FiRllXOFFn?=
 =?utf-8?B?V1dRL29rc3hRU0tCUEt3Uy92Y0M3MjFjeE12Uko1ZlZPSHZSdjNSbTUxVmY0?=
 =?utf-8?B?MTZyNWUrblZJcUhlMVV2UUNrSWEvMFlmeW9VY1p0bjVYUFJuanB2Rnh4aTM2?=
 =?utf-8?B?N004YlZiUTJ5aFo3Q1JyeUF5cXVFd2Z2ZzAxZWFGczVOMXlyamRucnZhZC9m?=
 =?utf-8?B?RFN2Q1dzMmNXWlc1aERXTjkvNWRkb3BTd0c2NWJ3djVRZzI5dGQ3TkpjWVVI?=
 =?utf-8?B?d1JDZGM4cWhmY1U2MkEwczNwZHZLaS9XZ2FyVnhNYTdXWGRCUjFnZGlQTUly?=
 =?utf-8?B?TDdOOVFtZHFKUnVaTkwrc2J5OU9kdzh2QUNWaml3UTVpNzBSMWc3NjNqK3Q2?=
 =?utf-8?B?eWZJRitpSC96RFc1OThwSWhnaWowNkhHWmUzRXZqMU9xSEhjRVV0M2JDNVpo?=
 =?utf-8?B?NisvU21WVEpZTTFwa0VqeFRUQ0svb1Jaa01pRy9sZkVyeHpERkJIa2c3YThi?=
 =?utf-8?B?ZnJLWkI4ZjdZdGNLL1JlVU1MNWhpdXlSQlV4WEhQSTEvZnhTK0NwU3lnVGY1?=
 =?utf-8?B?WmlHR3BocVVrZDRScjloOU9rSGh4K2FESDVZKy9XSjVTZ2dIeEVsbFNhOXVa?=
 =?utf-8?Q?HPZY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cab7ebc-7e37-437a-efab-08dd98230f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 04:50:50.9166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4rWCV2asyogBQ8baLOHENHx2xbJ4xWHuhPUZbCryE8EDbu1QCCwGsErIVz8yt19w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVtYW50IEFncmF3
YWwgKE9TUykgPGhlbWFudC5hZ3Jhd2FsQG9zcy5ueHAuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBN
YXkgMjAsIDIwMjUgMTE6NDkgQU0NCj4gVG86IEdhZ2FuZGVlcCBTaW5naCA8Ry5TaW5naEBueHAu
Y29tPjsgZGV2QGRwZGsub3JnOyBIZW1hbnQgQWdyYXdhbA0KPiA8aGVtYW50LmFncmF3YWxAbnhw
LmNvbT47IFNhY2hpbiBTYXhlbmEgPHNhY2hpbi5zYXhlbmFAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAzLzldIGNvbW1vbi9kcGFheDogc3VwcG9ydCAxMmJpdCBTTiBpbiBwZGNwIHVw
bGFuZQ0KPiANCj4gDQo+IE9uIDIwLTA1LTIwMjUgMTE6MjEsIEdhZ2FuZGVlcCBTaW5naCB3cm90
ZToNCj4gPiB1cGRhdGUgcGRjcF9pbnNlcnRfdXBsYW5lX25vX2ludF9vcCgpIHRvIHN1cHBvcnQg
MTJiaXQgU04gc2l6ZQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogR2FnYW5kZWVwIFNpbmdoIDxn
LnNpbmdoQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2NvbW1vbi9kcGFheC9jYWFt
ZmxpYi9kZXNjL3BkY3AuaCB8IDEzICsrKysrKy0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jb21tb24vZHBhYXgvY2FhbWZsaWIvZGVzYy9wZGNwLmgNCj4gYi9kcml2ZXJzL2Nv
bW1vbi9kcGFheC9jYWFtZmxpYi9kZXNjL3BkY3AuaA0KPiA+IGluZGV4IGM5MGVmZjI2YTguLjU1
MTU5ZDUzZjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jb21tb24vZHBhYXgvY2FhbWZsaWIv
ZGVzYy9wZGNwLmgNCj4gPiArKysgYi9kcml2ZXJzL2NvbW1vbi9kcGFheC9jYWFtZmxpYi9kZXNj
L3BkY3AuaA0KPiA+IEBAIC0xOTg4LDEwICsxOTg4LDEwIEBAIHBkY3BfaW5zZXJ0X3VwbGFuZV9u
b19pbnRfb3Aoc3RydWN0IHByb2dyYW0gKnAsDQo+ID4gICAJCXJldHVybiAwOw0KPiA+ICAgCX0N
Cj4gPg0KPiA+IC0JaWYgKHNuX3NpemUgPT0gUERDUF9TTl9TSVpFXzE1KSB7DQo+ID4gKwlpZiAo
c25fc2l6ZSA9PSBQRENQX1NOX1NJWkVfMTIpIHsNCj4gPiAgIAkJU0VRTE9BRChwLCBNQVRIMCwg
NiwgMiwgMCk7DQo+ID4gLQkJc25fbWFzayA9IChzd2FwID09IGZhbHNlKSA/IFBEQ1BfVV9QTEFO
RV8xNUJJVF9TTl9NQVNLIDoNCj4gPiAtCQkJCQlQRENQX1VfUExBTkVfMTVCSVRfU05fTUFTS19C
RTsNCj4gPiArCQlzbl9tYXNrID0gKHN3YXAgPT0gZmFsc2UpID8gUERDUF8xMkJJVF9TTl9NQVNL
IDoNCj4gPiArCQkJUERDUF8xMkJJVF9TTl9NQVNLX0JFOw0KPiBob3cgdGhlIDE1IGJpdCB3aWxs
IGJlIGhhbmRsZWQgbm93Pw0KSnVzdCBhYm92ZSB0aGlzIGNoYW5nZSwgd2UgYXJlIGhhbmRsaW5n
IDE1Yml0IGNhc2UgdmlhIFBST1RPQ09MIGluc3RydWN0aW9uOg0KaWYgKChzbl9zaXplID09IFBE
Q1BfU05fU0laRV8xNSkpIHsNCiAgICAgICAgICAgICAgICBQUk9UT0NPTChwLCBkaXIsIE9QX1BD
TElEX0xURV9QRENQX1VTRVIsDQogICAgICAgICAgICAgICAgICAgICAgICAgKHVpbnQxNl90KWNp
cGhlcmRhdGEtPmFsZ3R5cGUpOw0KICAgICAgICAgICAgICAgIHJldHVybiAwOw0KICAgICAgICB9
DQoNCj4gPiAgIAl9IGVsc2UgeyAvKiBTTiBTaXplID09IFBEQ1BfU05fU0laRV8xOCAqLw0KPiA+
ICAgCQlTRVFMT0FEKHAsIE1BVEgwLCA1LCAzLCAwKTsNCj4gPiAgIAkJc25fbWFzayA9IChzd2Fw
ID09IGZhbHNlKSA/IFBEQ1BfVV9QTEFORV8xOEJJVF9TTl9NQVNLIDoNCj4gPiBAQCAtMjAwMCw3
ICsyMDAwLDcgQEAgcGRjcF9pbnNlcnRfdXBsYW5lX25vX2ludF9vcChzdHJ1Y3QgcHJvZ3JhbSAq
cCwNCj4gPiAgIAlKVU1QKHAsIDEsIExPQ0FMX0pVTVAsIEFMTF9UUlVFLCBDQUxNKTsNCj4gPiAg
IAlNQVRIQihwLCBNQVRIMCwgQU5ELCBzbl9tYXNrLCBNQVRIMSwgOCwgSUZCIHwgSU1NRUQyKTsN
Cj4gPg0KPiA+IC0JaWYgKHNuX3NpemUgPT0gUERDUF9TTl9TSVpFXzE1KQ0KPiA+ICsJaWYgKHNu
X3NpemUgPT0gUERDUF9TTl9TSVpFXzEyKQ0KPiA+ICAgCQlTRVFTVE9SRShwLCBNQVRIMCwgNiwg
MiwgMCk7DQo+ID4gICAJZWxzZSAvKiBTTiBTaXplID09IFBEQ1BfU05fU0laRV8xOCAqLw0KPiA+
ICAgCQlTRVFTVE9SRShwLCBNQVRIMCwgNSwgMywgMCk7DQo+ID4gQEAgLTIwNDcsNyArMjA0Nyw3
IEBAIHBkY3BfaW5zZXJ0X3VwbGFuZV9ub19pbnRfb3Aoc3RydWN0IHByb2dyYW0gKnAsDQo+ID4N
Cj4gPiAgIAlkZWZhdWx0Og0KPiA+ICAgCQlwcl9lcnIoIiVzOiBJbnZhbGlkIGVuY3J5cHQgYWxn
b3JpdGhtIHNlbGVjdGVkOiAlZFxuIiwNCj4gPiAtCQkgICAgICAgInBkY3BfaW5zZXJ0X3VwbGFu
ZV8xNWJpdF9vcCIsIGNpcGhlcmRhdGEtPmFsZ3R5cGUpOw0KPiA+ICsJCSAgICAgICAicGRjcF9p
bnNlcnRfdXBsYW5lX25vX2ludF9vcCIsIGNpcGhlcmRhdGEtPmFsZ3R5cGUpOw0KPiANCj4gV2h5
IG5vdCB1c2UgRFBESyBMT0cgQVBJcz8NCj4gDQo+IGFsc28sIHdoeSBub3QgdXNlIF9fZnVuY19f
ID8NCg0KcHJfZXJyIGlzIGRlZmluZWQgYXMgUlRFX0xPRyBpbiBkcml2ZXJzL2NvbW1vbi9kcGFh
eC9jYWFtZmxpYi9jb21wYXQuaA0KYW5kIF9fZnVuY19fIGlzIHBhcnQgb2YgaXQuDQo+IA0KPiA+
ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAgIAl9DQo+ID4NCj4gPiBAQCAtMjczNCw4ICsyNzM0
LDcgQEAgY25zdHJfc2hkc2NfcGRjcF91X3BsYW5lX2VuY2FwKHVpbnQzMl90DQo+ICpkZXNjYnVm
LA0KPiA+ICAgCQkJCQljaXBoZXJkYXRhLT5hbGd0eXBlID09DQo+IFBEQ1BfQ0lQSEVSX1RZUEVf
QUVTDQo+ID4gICAJCQkJCSYmICFhdXRoZGF0YQ0KPiA+ICAgCQkJCQkmJiBzbl9zaXplID09IFBE
Q1BfU05fU0laRV8xMikgew0KPiA+IC0JCQkJZXJyID0gcGRjcF9pbnNlcnRfY3BsYW5lX2VuY19v
bmx5X29wKHAsIHN3YXAsDQo+IGNpcGhlcmRhdGEsDQo+ID4gLQkJCQkJCWF1dGhkYXRhLA0KPiA+
ICsJCQkJZXJyID0gcGRjcF9pbnNlcnRfdXBsYW5lX25vX2ludF9vcChwLCBzd2FwLA0KPiBjaXBo
ZXJkYXRhLA0KPiA+ICAgCQkJCQkJT1BfVFlQRV9FTkNBUF9QUk9UT0NPTCwNCj4gc25fc2l6ZSk7
DQo+ID4gICAJCQkJaWYgKGVycikNCj4gPiAgIAkJCQkJcmV0dXJuIGVycjsNCg==
