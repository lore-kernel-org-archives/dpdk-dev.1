Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB643C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 12:13:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3E0E4021E;
	Mon, 21 Jul 2025 14:13:43 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023137.outbound.protection.outlook.com
 [40.107.44.137])
 by mails.dpdk.org (Postfix) with ESMTP id 022844014F;
 Mon, 21 Jul 2025 14:13:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Frn5FaENambCCjqqkEerLsFM/p8xdtvwnpKWv4kgudd/zS00X74nOLH9gyB5FrfRbptimnhPIEHaM+tK7XL7/GtE197SUzTgokJVioG/2NB1+wGf920ktxs9M+w0V6153HkJjHVFFtvhs4ZUww0cwuy0lB0HCU1GRj1wqUtEJJsOvlgBXGM+Pdu/3yDgOeNETulufhbNOQOrUTG2FMxigALr8ouWfxierk7mNHfmGUt0GewLapjy+F3DUaavAgnRkzriPbHKYICKOaM89VBTchskFhzq/sAZEsFPLO/P3/kq+LwgokqCr85H4oqs3Ret4+x2LSR+pu4AiyF49aDw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiTYnMnyeIZIS/QSjEZsr4oZ9x5QfuOuY/kk9xjbw/E=;
 b=KKMDC+mNRprWye44bY+dyeqRNQewzgOtPP4QiodYe4CCC3EaTnwLtkw1nj8xEHe91g53a5gu8iAFg5OUEJYupRxVmGKZoddgOFa5TQWDrZPpjjndXWagCUAwZFHGUQHfRvEWK0Srs9z/MEGtsXBnZHM1IXcEQgvOE+pw0CUPHgEssYcAzQtjnLpH5R/wJVN1nt4ctwRQ6WfM0YSW22VZAj4hwSy2mb87U2ecZ6C0RPb6S5Me+52z5cCKBXOYzu4+xHOJmHskSR/1foYZFlYms6PpyHt037bVV+HkdG8vb1isQ507fadRMLBsl/266Kh6JjjsRfJG5bYpbJjXDkTPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiTYnMnyeIZIS/QSjEZsr4oZ9x5QfuOuY/kk9xjbw/E=;
 b=DPtSLQcSbgTQ3KmblmXRQ4LnYFvTWxCIj3DOOWo3SPmnNHdSh8K/TAJq9bW8H3/EygMLgTnEFFQHi18igOrz5NXi7EwsPJ9UlAV1zoUSsODz/FzKXiIS/78l0GUKcusze7mB6odbBcR9A+zFfUaTaVBgi6EBUC6TVSh2Mojk5+hadnGOQj9QRhxVKxwKo01WLNxLCJ5JGGs0GNhmDoVO/3eQM0QqlB9F2mjk4N8DODW9StXGeLh1py/fEYKCTrC2HRLRjfHiR8L5r0UgqlBFwXzGuBhI9qAs0aWO7lrhqcc7W2ODXt9JQqhSC6h2ZhjJGWe1YNQqAiYjK6caNtX/2w==
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by SEYPR06MB6203.apcprd06.prod.outlook.com
 (2603:1096:101:c4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 12:13:36 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%4]) with mapi id 15.20.8922.037; Mon, 21 Jul 2025
 12:13:35 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "ferruh.yigit@amd.com"
 <ferruh.yigit@amd.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, "stable@dpdk.org" <stable@dpdk.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGV0aGRldjoga2VlcCBwcm9taXNjdW91cy9hbGxt?=
 =?utf-8?Q?ulti_value_before_enabling?=
Thread-Topic: [PATCH] ethdev: keep promiscuous/allmulti value before enabling
Thread-Index: AQHb+jXguLJDEhl3L02NGXjBJoEGnrQ8e5WAgAABKvA=
Date: Mon, 21 Jul 2025 12:13:35 +0000
Message-ID: <KL1PR0601MB556788BFC98F8A212F2F6921905DA@KL1PR0601MB5567.apcprd06.prod.outlook.com>
References: <20250721115139.46728-1-sunyang.wu@jaguarmicro.com>
 <3628442.V25eIC5XRa@thomas>
In-Reply-To: <3628442.V25eIC5XRa@thomas>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5567:EE_|SEYPR06MB6203:EE_
x-ms-office365-filtering-correlation-id: 7ede74cc-4d45-4f6a-4fcb-08ddc85004b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L29qbG9MT2RMbTZGVWlDVGNhNUp0cTdEaGZxSzkrVFM4alRxa01ReU9TZTMw?=
 =?utf-8?B?czdZVk5YVnFBeldjSEVmTWEwRkhjdlZSOHd0aVNBYXRDcXpkZ25CUG8yYnRH?=
 =?utf-8?B?WTlsck1iNDZNQkdzM2lrSkNtVzE5QWZsZHl4T3d2K0lXYWpRUlJNMXdLSVFh?=
 =?utf-8?B?OEQzQm03emJxK2NEQ1I5ck1UVjlTK2hCalBsemRjbEcxU1BUYmQ3TlhDM3hz?=
 =?utf-8?B?cTV6QjdLTXhCeVRkZ3dxd3kxN0ZKOHZzRHhJMkV2RWYyTVZEMy9aZi9LekM5?=
 =?utf-8?B?d0dCU3pWQVNXR0dZWi9yeEN0OUZIMHRHOXR3ZURQQVRBQzRCRHBXV2xzalpv?=
 =?utf-8?B?emRZRlQ5ZS9tN3BtNWFZRzZOOGRCVUxzb1R1OVVJMkQ3c0RRNjNQYVo4cVda?=
 =?utf-8?B?aHoydzMxdmUvWSt1VWw1Ly85RGFKd2NYZ3EvRkFMMGE1bEZSa2c1REp6Z3Vq?=
 =?utf-8?B?K0V5dDNlNGtvUURYcmNRYmg5M0JDN3FCdWgzaDVxOWFHY3lzZXBnQ3hadHpa?=
 =?utf-8?B?aFJkVXNoWHZxakVNUVJ6Sjdvd1BpTitIM01wbkNCdkptdTFXaEQ3NlNGbmpW?=
 =?utf-8?B?K2FPbittcnBpR2ROa1BreHBrODZsUVFzdFhJWE5teHlpZUpSREVsMEZ1T2M3?=
 =?utf-8?B?R0dsQkJWU08vUGFxbzcxRld2eWllWGVjenlqK0JvOVZnSklvdkZCUkFuV0xx?=
 =?utf-8?B?cTVtcFJhN2kycXJ3WGJsdDJOaVNGdiswOTkvNHZVQkVuSEhuTzd1ZGJwbkV0?=
 =?utf-8?B?NWFiVjJEa0hrMWpUeENTYlZKWmovWGwwMXdsZUtOQlFxcndKaEh3Mnlld203?=
 =?utf-8?B?aHduZW9MRTloMG8rU0JQTFhIUTVYMVBnemZNM3Fjeks5WE8xOGhWWDJSczNh?=
 =?utf-8?B?VHdpQ1FBb1ZacG9Ga0U4a2JkNVlGNnZwZktpRnVXci9QczVGNXBsUXU3ZUtZ?=
 =?utf-8?B?cGlDNmdWR0ZISGU5M0c5eDJzcVVPdVprWnRiQ1RtRG5XVDNQN0ZuakJPbXp0?=
 =?utf-8?B?V3ppaHgxUDhSeHh4MHNpckRQRzdzMmYvc1NjYnVIekl2RGhDVGgvWFMrTC9X?=
 =?utf-8?B?YUxxRlRCQ1dZbmJ3RTVWdnNiTEF6bE1KNERMcjkzN3RwMHVMZ1YrWmhhQkVk?=
 =?utf-8?B?TXFlMXU2VU50T2s3R0ducFg5WWQrdU80R2dHRUlkWFAvcnRJc0xpS1VKaWdW?=
 =?utf-8?B?Z1NVMXB5N0t6aW1Rbi8rbnVXN20wM2p0cVRESitJWlFEUGZoUkY2VlcwSWpl?=
 =?utf-8?B?N2dQY1FoblVzR0tYRG5CMFk1b2Vjc054eGRRb0ZKN2xldVdlMGhXRFd4MnR2?=
 =?utf-8?B?REhEZnJ2dWMzcHVyb1VJZXFnY05GTmRDUUZWZEhHVmZtd0VaQmR6T3hNL3h1?=
 =?utf-8?B?RVVrTW9CTDZ4a2tvTFhDWllQVzVyZ20ycjFJUHcvMjFRMXlvbmo2d0tSMkkw?=
 =?utf-8?B?OUlpN3dSZGhjN2ZGSUxFN0N3YTh5MXArRFljQk5JNS9zbncyTE4wMWkwR3F4?=
 =?utf-8?B?TWlZV1dVOUdPTW5XTEFrQU13TnJaaVVwSXdMQ1kvQ2k5SklnV1JvcHV6d1V5?=
 =?utf-8?B?eGhtL1dveWVnRXJlbUFsSitEaDJETnZ3V2c4NDFDQUN5OFp6eUZTa2ZrZ0Zi?=
 =?utf-8?B?c2hjKzhZWlViYXJyZmtxWHI3eEVxNjBLN09FR1FDZXdZM3ZYcjJSY2NmWUxG?=
 =?utf-8?B?cEFDdWc3YWVhVVRGSWpYdC91WGN3U1RlRjVsV3pYL3p3RjNSUXA5R0VueG1t?=
 =?utf-8?B?Qzg3TThCSS9rUVZicmtqTEJlaE9YSDZ4RlZOdGRVai8rRVMrQlp6c2tpdG5t?=
 =?utf-8?B?TGVvYi9MVVVFS0hablJUM0orVXU5T0hDczVzUkQ2UERFSjZ5NUdvMk41ZTd2?=
 =?utf-8?B?YzdIVmRPRUwzNTFaMTdmalYwYjN0cjhEYXhCbldyYlNLSGdwaHArdjJEdzlW?=
 =?utf-8?B?UElqVUgvclF5ekdKek5OYlhtY3pVamxHWGw2NXhtUXFEeGZkcm9tajdXOSsx?=
 =?utf-8?B?aW52VWpTQllRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2FzQk1QZTU5aXdRdDBnMUUzY25uWHJjVDQ5VU03QS9VTTFxQ3FWUVNuZ2tX?=
 =?utf-8?B?L28wcmJiajNiR1dVeFVNNC9Ma3pLc1kxTjVhUDNGb0RuZHNrZFZLSnVNY3FG?=
 =?utf-8?B?a2tBKzRwRWF6MGE3cE1XZ1pYdGFKSSsxeFZqOGhRUHdjY2VtbGFTUHpWMWJ0?=
 =?utf-8?B?bjcvNEM3MUlXZk45RUFYR1poSFlvTG1TZGhNcmZadU81UEZ3VEtRZnpVWnds?=
 =?utf-8?B?Q1NwaUdWS1VpTmJxZGVIdXZZbGNZQ3EwbVNFU3ZyVUR6TC8rOWdMdEVHUE5X?=
 =?utf-8?B?UW5oSSt3ZnlLZytjcWZENzhrRCt4cDBuSytuT3lTMHRtRWRPc1FZVlduaUtG?=
 =?utf-8?B?MTV6T1dXYzd6aXRpa29SK0FIZGwzWmd6cUJaK3lUTG5TL2Y1T3NGS1U0QWpS?=
 =?utf-8?B?NUF0YmlGL3FwVDFMek4yaC9uTkMzSUdxdXBqc05YTFVrc0ptbW5ocm1ZbEZN?=
 =?utf-8?B?cytQNTJTMEhoUEVpa20rekZqRUZqZFdKbVdHbVRiZ3d1Q2ViTTNKNjc5bVQ3?=
 =?utf-8?B?eFduYUZLK0pOU3VYbEhtYkc0NnkyUE1QZFFqQmJSemVlWGZEZCtnZ0FVUGhK?=
 =?utf-8?B?aC80d3BRdGxFaW1BQ2NHRlp3VFgxbktHaGhXM3daaHhvMGhiRG4wbkdLODNL?=
 =?utf-8?B?SnlzS045Yzl5NzlhdjR3V3lRNUg2RUNKV01EZjlXc3RPQTFKWmJaeWhiMVdx?=
 =?utf-8?B?eDRXN0NJWElURVhsVEhwOTBoaUIzZ242WXN6NUc4cFg5MkYyQ0dNYys0WFRa?=
 =?utf-8?B?UDVpUjQwRVAvbjBWKzJSdkdoTDN3cnFoblV5akdNUWc3Q2h6eTNlbHRKRXV3?=
 =?utf-8?B?bUJuUk5nTSsyS05UelJPM1d6VlFrOWpTS2NGYXg1c29pYTE1bzlVTkwwQ2hB?=
 =?utf-8?B?NVJRUEhnTmJEKzMwazBOTzRZKzU4OWNlN2x6NGk4b3VXd3Z3SyttVnkvVkJV?=
 =?utf-8?B?aU4rVzB4aThXSVY5aktYakFaNDBzNEVGMUp1Q2luZHZ3ay9GQlh4WjA0cnNr?=
 =?utf-8?B?aXgvam16L2djSnh0dzVWLzZTODR5L3hNZEphRUVvSk95MVJ6Rkdwa2JuQU8y?=
 =?utf-8?B?R1FzTzNlTjVLVy81MFkvbUJvUGNtTkpGQS9yaTNMVDN1eEJHaVFoTUt0T0Nw?=
 =?utf-8?B?eTV3YzZGMlhQWVpQMEVMajZ2VWNlODNJTDJ6ejRyL29qYVNHa2N0Z1pyZVpS?=
 =?utf-8?B?cDRJdDRzSTM3YmRoQnVyaktHM2tKTi94bWxSb2cvVzVvdFkyR3cyeFNuSm5O?=
 =?utf-8?B?eFZteWw4SUZtVUF6ajFCcVlKS1k2dTN3NUk2RmRNQW81T0xJeW5TU2NFM0kv?=
 =?utf-8?B?NzNlRWxiMDJpTVJEcTB0UGpWSXE2OFZObXd1YnFGQk96UHpsdmdSLzhRUTg1?=
 =?utf-8?B?QWlhazlQMlVYSEpEQmZSdURBU2lWUjQ0MnlzeWZnc0VPbWt2c2NFRkhBZlBt?=
 =?utf-8?B?Wjg0NHg4Z0xGVm9pWFVnMVZCWXBHdzQxMExXSVVrUUFtSGREY3ZneGdWTlll?=
 =?utf-8?B?dkhnZWxScllTSnpGRE5HWFdQb2JqbUd6enYrOGgreHB2dzluaDJ2L1I1Z0xN?=
 =?utf-8?B?Y2l0bXh0QkxydlM3d2NhQmF1c29OUTlON2ZVb3dIdm1iYVFBRG1wTFRhUzFu?=
 =?utf-8?B?cXFYQlZDUFdBMHljV2ljZHRSM1lJRC8wckNlZzBCSG9pRHJNdDFtTXR5c0ZY?=
 =?utf-8?B?TmYrS1grRGJ6eUpxWGVCdmtrQ3AvYVZMejFXMEppUWRSbk85eTFHbTJYZDFH?=
 =?utf-8?B?ejZ4Y3ZHS2VOeE1icDFROUk0cnpMNVV2OHdBanVQbURTek8weVJCcnZOUEtq?=
 =?utf-8?B?cXIrSTZRcnZ2WWR3SUVlQUU2TmplKy9OeHhFR2FSTGd4K0U0dmIrTnpHcjNx?=
 =?utf-8?B?a25Cd0Mwc2FVc3piVktjK2VPK2ltMnE2MXJTbzFUMHZRN0hEUmxxZ2Z3V0NW?=
 =?utf-8?B?MU54ODFhOWQ2djRDWk1qZEM5Vk1lNTRXSDlsaHZSU24vQjdKWjVnTGQ0MVN2?=
 =?utf-8?B?TzJXLy9aa3UvVnB5ZHVpNzlmdHFuajNpMWhkUDNwUC84WmhtV2s5dUdKYnNx?=
 =?utf-8?B?YUZwNjZObGpJN1QwaUh0Z3RXTzVUN0xRNFpkQzNSd0xRN3l6RTEzZWxwdDZk?=
 =?utf-8?Q?mmCXd/1E7WWzcnCy+Pa+Nja/b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ede74cc-4d45-4f6a-4fcb-08ddc85004b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 12:13:35.7677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2quC/XYdpKKvNAPDFum9ocA3wTA/L8GeYWrEiGzc8GWWcX9IimzjiOInvtcI93erSqkMeM66ntSH6Y696CRIiMs4d6dwM/8ieESlU3jdO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6203
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

SGksIFRob21hczoNClRoYW5rcyBmb3IgeW91ciBub3RlLiBUaGUgbWFpbiBwdXJwb3NlIG9mIHRo
aXMgbW9kaWZpY2F0aW9uIGlzIHRvIGFsaWduIHRoZSBoYW5kbGluZyBsb2dpYyB3aXRoIHRoZSAi
ZGlzYWJsZSIgZnVuY3Rpb25zLA0KYWltaW5nIHRvIGVuaGFuY2UgdGhlIG92ZXJhbGwgY29uc2lz
dGVuY3kgYW5kIG1haW50YWluYWJpbGl0eSBvZiB0aGUgY29kZS4NCg0KUHJldmlvdXNseSwgdGhl
IGhhbmRsaW5nIG9mIGZhaWx1cmUgc2NlbmFyaW9zIGluIHRoZSAiZW5hYmxlIiByZWxhdGVkIGxv
Z2ljIGRpZmZlcmVkIGZyb20gdGhhdCBpbiB0aGUgImRpc2FibGUiIGZ1bmN0aW9ucy4gDQpXaXRo
IHRoaXMgYWRqdXN0bWVudCwgYm90aCB3aWxsIGJlaGF2ZSBtb3JlIHVuaWZvcm1seSBpbiBleGNl
cHRpb25hbCBjYXNlcywgd2hpY2ggc2hvdWxkIHJlZHVjZSBwb3RlbnRpYWwgY29uZnVzaW9uDQpk
dXJpbmcgZnV0dXJlIGRldmVsb3BtZW50IG9yIG1haW50ZW5hbmNlIGNhdXNlZCBieSBpbmNvbnNp
c3RlbnQgbG9naWMuDQoNCkJlc3QgcmVnYXJkcywNClN1bnlhbmcNCg0KMjEvMDcvMjAyNSAxMzo1
MSwgU3VueWFuZyBXdToNCj4gVGhlIHZhbHVlcyBvZiB0aGUgcHJvbWlzY3VvdXMgYW5kIGFsbG11
bHRpY2FzdCB2YXJpYWJsZXMgYXJlIHNldCBhZnRlciANCj4gY2FsbGluZyB0aGUgZHJpdmVyLCBh
Y2NvcmRpbmcgdG8gdGhlIHJldHVybiB2YWx1ZS4NCj4NCj4gRml4ZXM6IDQwMGQ3NTgxODI2NiAo
ImV0aGRldjogY2hlY2sgZGV2aWNlIHByb21pc2N1b3VzIHN0YXRlIikgDQo+IGRlNWNjZjA3NzVh
ZSAoImV0aGRldjpkbyBub3RoaW5nIGlmIGFsbC1tdWx0aWNhc3QgbW9kZSBpcyBhcHBsaWVkDQo+
IGFnYWluIikNCj4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTdW55
YW5nIFd1IDxzdW55YW5nLnd1QGphZ3Vhcm1pY3JvLmNvbT4NClsuLi5dDQo+ICAgICAgIGRpYWcg
PSBkZXYtPmRldl9vcHMtPnByb21pc2N1b3VzX2VuYWJsZShkZXYpOw0KPiAtICAgICBkZXYtPmRh
dGEtPnByb21pc2N1b3VzID0gKGRpYWcgPT0gMCkgPyAxIDogMDsNCj4gKyAgICAgaWYgKGRpYWcg
PT0gMCkNCj4gKyAgICAgICAgICAgICBkZXYtPmRhdGEtPnByb21pc2N1b3VzID0gMTsNCg0KSSBy
ZW1lbWJlciBzZWVpbmcgdGhpcyBzdHJhbmdlIGJlaGF2aW9yIG9mIHJlc2V0dGluZyB0aGUgdmFs
dWUgaWYgZmFpbGVkLg0KQW5kIGl0IGlzIGRvbmUgZGlmZmVyZW50bHkgaW4gdGhlICJkaXNhYmxl
IiBmdW5jdGlvbnMuDQoNCkJ1dCBpdCBpcyBub3Qgc28gd3JvbmcsIGJlY2F1c2UgaWYgaXQgd2Fz
IGVuYWJsZWQsIHRoZSBmdW5jdGlvbiByZXR1cm5zIGVhcmx5Lg0KU28gdGhlIHZhbHVlIGNoYW5n
ZXMgb25seSBpZiBpdCBpcyBzdWNjZXNzZnVsLg0KDQpXaGF0IGlzIHRoZSBpc3N1ZSB5b3Ugb2Jz
ZXJ2ZT8NCklzIGl0IGEgcmV3b3JrIHRvIG1ha2UgdGhlIGNvZGUgZWFzaWVyIHRvIHVuZGVyc3Rh
bmQ/DQoNCg0K
