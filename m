Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A5CA5FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 04:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23A4A4060F;
	Tue,  6 Oct 2026 06:15:44 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
 by mails.dpdk.org (Postfix) with ESMTP id 9E0EE402D9
 for <dev@dpdk.org>; Tue,  6 Oct 2026 06:15:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnOepoR9yhcw0QsXAWyNJYd0cjckpbhI0JqoDTtbDij+77EmHO+WZRhsHH+d5uP9UDHwP3WXJr41RedlWZc1XAwzpHcDlBx07F6puNyQBQHTqF5UiBMtvdfK3hfrEoqan5eBc6DDyMx2UF7w+jxj2V1bsdzL5POhbJaFlfAbdigWahPSyD97z5HThDhoCnQVqsZQ0Ui9dizgbvA0O96RZbXfilfAM6KWSzMcuutdtuOtslu4by9wO4vVm9tOT/iDYycD6TssdusQap/B/qAie5oJBXw/BgksdEMVDxSIHjcT4jgKxaEebHC31BH2n+lUPTVadXTxrw4IdkB/yVVfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTctH7lCpfbR/uWCQPIrmmJycOiGUz3qk+jQPrmA/w8=;
 b=cpgDZN8SbTbU4rPQpMHLp3ITUIbhBtVXHhcX9LjANqCMDqG3ZAjoBAunmpJXW6nnHWspHOXmeyLEpXCJ9Lqk8mzvGo8NEnY7F5r03uwDXGRsuOvaLfmIYwc3w/ttZBTzp0VGV9A02KOPbEIVE9IMoc6Ko7LCvQp67RuUOPAo+JIgpKv4x0bIVNcqfYJlvDcIE+ezeJmMd6YOxcpGLE1GnozofZs97+JIxzfHNdHl6Q0Mh8gzGqK6G6inkTrmkLDfGN2fjgTtRbjzx6OgUIPweJmlrcN07RY3Y02U0+zO1OIKf1LBQKZ2XDW1WXaU5ubt4WjKc0pW7SmdA5hq0BkCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTctH7lCpfbR/uWCQPIrmmJycOiGUz3qk+jQPrmA/w8=;
 b=XEBVnr3Ddb6LK75wdlVfQW+w8fxlnYFjm+mSestLezf0QvjcrcAKyj/xQwLfHrjYxCGgLjm2Inj3SQlrZtzo939yEDhPMbzZvU+FWOGvkjr/B7Puhm46AyPjoyYmQnvswUDhQiQLjRbGueoc3tXStnyUuDc2qOCc4xM/4ys7H5IGHwrgQrHmen8rMGAP8d94ZNbb+g6Z4zSMk4BztgK6nNpMV9+Ab5+D+CDHOtHm3Qc0IdJxBhth9VILorqZ7ZhXGU58/NvsdLIfTDOslub1X0+ALLAJMFAiVCuTBFNWrhSqAAxWcdqni7JwsTlit6fUePsyPbVaDG/bBa01tpapaA==
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 (2603:10a6:20b:725::21) by GVXPR04MB288886.eurprd04.prod.outlook.com
 (2603:10a6:150:3a4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 04:15:38 +0000
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf]) by AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 04:15:38 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Hemant Agrawal <hemant.agrawal@nxp.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [EXTERNAL] [PATCH v2 5/6] crypto/dpaa2_sec: add support for env
 variables
Thread-Topic: [EXTERNAL] [PATCH v2 5/6] crypto/dpaa2_sec: add support for env
 variables
Thread-Index: AQHdUKp4GXyKW0tLsUmTSLhKJrtgebbvT/CAgACg2eA=
Date: Tue, 6 Oct 2026 04:15:38 +0000
Message-ID: <AMBPR04MB1228199C928BCE356E477E49CE1952@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260810112951.2879825-1-g.singh@nxp.com>
 <20260930070809.1929564-1-g.singh@nxp.com>
 <20260930070809.1929564-6-g.singh@nxp.com>
 <CO6PR18MB4484B210020584C2AF24137ED8962@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484B210020584C2AF24137ED8962@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-06T04:13:36.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12281:EE_|GVXPR04MB288886:EE_
x-ms-office365-filtering-correlation-id: f16054f1-7c87-4053-aa36-08df23607a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|19092799006|1800799024|366016|6133799003|18002099003|22082099003|10067099003|3023799007|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: qg0XkrPXvxUKow8zKykdf1qw3e2EfEnyRZyxcyIQrlsWuWAIYHhTW3ZLhILaaM6T5SifspgKb25sQzb7UJdVf2wJg+0AlXER3beQ7KQUFu3SufYm324N1iQ6Mmyn27xUzxgWPIK9cMWLEoSFrRT1wxhDdMwYRBKKpgPsdGwZWMgg55BPATqx0+UrZjdi08SLQ6wPviD3vpz12gOJnzPK7cKQV5R4uej3LnLXClLH+vwA4DHkVlr78rexi57M68JPwX0YRBim5/bvXHAAOw2J4c1uKl7Vjv4KZ6jgAFalFH9Em0O6rnjA1mVdd6NirVwnjBGbafw1+Q9QqXhng3KwgUpBqz7WQoVVG1CL46olrGqES/S1PyZbmdtXHmFiiqGACjpEoylplJxgZRjnzs1n8oOMHFMj29m0Ocj0Xs98KtBIeTxMT3J0+ELSqu0WfYqoFznfaM2oBeKetjjv5gjOlRVdQSFozA7C/aPfxLxo7AS9GkDCAv+03lWSjIXLOyNMSvp89WSpdzmMk9OQxIn0lxb37p1aa1hGpEwogmjxeQu0LmdPpN2y7E8yHOAqPji3lOVij2x8VyyhdA/oDDqrZDV0HEexStKxg+c+jj9cVOH/N8iFg2OTVBY7KKM59O+Zkr1mSfGqc6dfQ1lsPeo2aMR5x1H+z/lRT/VCp08uJc9LspISd+pA5djEXfP0tAbW33TQmCiGx1p2XVfpDmb8UScQNyfTkAbbiwrmWBqoxMI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12281.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(19092799006)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWlNYmxuZHVpZUFwNk85ZGZtNTA5bGQzRjBrbklUU1plc0owcldJRXFkd28w?=
 =?utf-8?B?NzZueDVwWkFiSC9qcEYwOXhueXZXaDlyOG1OeHNtWnF3V3pEK0V5dEZBd1Jv?=
 =?utf-8?B?blgzWWZwN2x4YXYvOEh5K1dRbEJWNGtLZGNhRVYxZitWMmRveks1MDNJY1hz?=
 =?utf-8?B?NStKOEorUHJtR1BUajF3RmdtZFNkSTUwYXhURkxsSENuMmdjL1JXeUJwTjJM?=
 =?utf-8?B?MXVaU1ZCWGNTVllJbERFV1NoNGpIazdFMmxVV29tUGxSeGZpcG9ndXR3Vmls?=
 =?utf-8?B?R1RmcWg0cFlMNmpDTlNGT1JReUEydFRaR0tJYkNsY204SXEwaStyTkJ6SmlY?=
 =?utf-8?B?dVBtckJEVTBrRHRYcjIvTW1ieXpHcVVzZzdUcWhTMk92ZWxja2hSaDZ2eTdY?=
 =?utf-8?B?cy9zYTh5NzNnbDNLQUwrSHJWR1krZTZ4MDRoaHVOY0QvdGg4bHd1c1JrVnJx?=
 =?utf-8?B?THRFbFY2SGt1MVJpdnpHR1FLZi9lalhvNDhqWWovZEI1Sk81N3dqVGlOazdk?=
 =?utf-8?B?N3huRDFia1JEOTF2cUk3dnRGU0lyVHdaK25EZ3pKTHhNam1XY293UHZ1eHBI?=
 =?utf-8?B?alVlSjZzV1dVMEJKem1sZlMwWCtKTWpqNHhTUGZXQ050YkxhV3crQlVtQ2gx?=
 =?utf-8?B?ekRKekd2a2JYT0M0VFk2S3d5YXZBcHN3aFVrbStIMHBOVjZvN2lsZis5bkVT?=
 =?utf-8?B?S1RacTBrMVFhZitwdHQ3RU1YcjZwYWtOVVQwOEJTYTEzOUoxdGZkK1BhYmsw?=
 =?utf-8?B?STFQc1NPMTAwOGxGOEVPTDZMU0JwK0k4UXM4aHhjUFA2YVNXUEpOM0VvREE2?=
 =?utf-8?B?U0cveHptVi82UFBFdnZJZXBZemRTcFFKNC9KUXA4S2Y0dyt0bER5WGdoNmls?=
 =?utf-8?B?MFUvTnVKN0RZeThXUnNEeklCbjc2TTJmVHJoUGFIZ3BZc05xVElYd056c01y?=
 =?utf-8?B?YXBxMGZvRFI2c1BmcXVtMjNFWFlrb21Cc0ttTEdtRUJleE1wRnlSSXZHMGdQ?=
 =?utf-8?B?b1l5cEIyQ2pvV2E3aytNQ1RzU0ROSkQyNWsxMlZKUURWL2pla1dOdzhCNmtJ?=
 =?utf-8?B?WkZmN2JFdG9QS0ZzVmc4OU9aeGR2Rk5zQTRzR1ZUbGsrUTU0V3ZSZ1NIUnhQ?=
 =?utf-8?B?RFhGSDQwOEcrOGNsWFh4RlBiZ1pwWDRJZ2phOVJEMUNsbURzbkxDUlU5NEdy?=
 =?utf-8?B?OGc5OGYwbTF4MTFXaUhLS2paazdkRXJ2U0RlNFRHcFdQUXJKV1pnaUswZUJh?=
 =?utf-8?B?WnRWRENkYllvb2hoK2ZNRlN6Y2ppZWxFWndCUzBMNGl1aFVWd2lrQnNqcER6?=
 =?utf-8?B?Z25xWndKbDJCTjRCVHFwbFZQdm5iaGk4Mko0bGlUZW1jNk52azNFMjVRK1Z3?=
 =?utf-8?B?TG5pM2VPR0dYV2UweWNYNFFHbDNBbGdia3k2VGw3UmlOb1VWTTdvak0yQ1lB?=
 =?utf-8?B?dWhQWC9JYlNXZm5mNzJwRUFZRzBFS1hqeDZObkVtTkE2TVVKOGR3ZytnRENI?=
 =?utf-8?B?ekRXNFVvTUppd1Q4aldSZUFsOW5jblM4dGRaRWNqTmM1eWNubm0zZzd5Z1dh?=
 =?utf-8?B?ejMxZHRLVW1rb0g3UFhIbDRCd3doWHNkNHRYQzdLcFhPa3QwSXFIZ0t2KzQx?=
 =?utf-8?B?eXA4cnkxd0hKVFc5UW8rb3J0YkZ2MlFLNVBxZHVRWVZ0dHFwRXJ4dFg0Tk1Z?=
 =?utf-8?B?dUFEOGxXQlpKYnJjWW9KdWpzRDU1cG1DcEh4LzRiUE4zbU5DSkZ0SmpRK1E2?=
 =?utf-8?B?azJYSWhULzFUbVpDTERwdzU4dXVOWnhTZUd3dnZ5SnFlMXF3OWNCZmg0WjFj?=
 =?utf-8?B?SGFNc0h6TW5qMmkvVUtXY3VGMVZ1UEJndDhRY3EzQzU2cHdrSnF1YnNJTDk5?=
 =?utf-8?B?SGREU2NmRE9KbHJGRzhvQ0FoODlUb3IwYXpTa3J2ZlV1Y2tXNVFHR0tQRGxW?=
 =?utf-8?B?WHdWS0c0RkZ5WVl2WEJ5T3IrWm0xbUxhRkwwaS9JMDVza1prMkFwQjZzQWdX?=
 =?utf-8?B?UFNQZFVoa0thL0cvTTIwSUJaVVRFZ2dkVXcrQVVzK1hZa05POXo5YjRLT1VG?=
 =?utf-8?B?UTd5QjVOMm96NjBqUytXYTQrbDdpSVltTlozenVVUTc2ZjFsWkFaT3pvUHZi?=
 =?utf-8?B?cHp2VmtPVEV1aXFRQml5VmtpdVdSTHV0ak1sY1Z6dUpqWWxTMzIxTXViNDBX?=
 =?utf-8?B?cFYzb0lqRHhMMlk0cmFlUFYrYUt2N2VFTGVzMjUxRXJNY2lBUG45S2RObHM3?=
 =?utf-8?B?cWhVa1Qxam1zRTRhY1dZMU1BTFZ6ckpjWG1Jamx3TFJyQXpzRmlnakppcmc1?=
 =?utf-8?Q?0QhDU1yLmM+Aquuoyg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12281.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16054f1-7c87-4053-aa36-08df23607a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 04:15:38.7509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agTiki6irX6lO/H+ZDBQoTw3gkXr/GH+WQXTyYYYiWfBu4UJeOxuu8UkWF4h3EiM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB288886
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

SGksDQoNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBBa2hpbCBHb3lhbCA8Z2FraGlsQG1hcnZlbGwuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBPY3RvYmVyIDYsIDIwMjYgMTI6MDggQU0NCj4gVG86IEdhZ2FuZGVlcCBTaW5naCA8Ry5TaW5n
aEBueHAuY29tPjsgZGV2QGRwZGsub3JnDQo+IENjOiBIZW1hbnQgQWdyYXdhbCA8aGVtYW50LmFn
cmF3YWxAbnhwLmNvbT47IFN0ZXBoZW4gSGVtbWluZ2VyDQo+IDxzdGVwaGVuQG5ldHdvcmtwbHVt
YmVyLm9yZz4NCj4gU3ViamVjdDogUkU6IFtFWFRFUk5BTF0gW1BBVENIIHYyIDUvNl0gY3J5cHRv
L2RwYWEyX3NlYzogYWRkIHN1cHBvcnQgZm9yIGVudg0KPiB2YXJpYWJsZXMNCj4NCj4gPiBBbGxv
dyBkcml2ZXIgY29uZmlndXJhdGlvbiB2aWEgZW52aXJvbm1lbnQgdmFyaWFibGVzIGFzIGEgZmFs
bGJhY2sNCj4gPiB3aGVuIGRldmFyZ3MgYXJlIG5vdCBwcm92aWRlZC4gQWZ0ZXIgcHJvY2Vzc2lu
ZyBkZXZhcmdzIChvciB3aGVuDQo+ID4gZGV2YXJncyBhcmUgYWJzZW50KSwgY2hlY2sgRFJJVkVS
X1NUUklDVF9PUkRFUiBhbmQgRFJJVkVSX0RVTVBfTU9ERQ0KPiA+IGVudmlyb25tZW50IHZhcmlh
YmxlcyB0byBzZXQgZW5fbG9vc2Vfb3JkZXJlZCBhbmQgZHBhYTJfc2VjX2RwX2R1bXAuDQo+ID4N
Cj4gPiBUaGlzIGxldHMgdXNlcnMgY29uZmlndXJlIHRoZSBkcml2ZXIgd2l0aG91dCBtb2RpZnlp
bmcgRUFMIGFyZ3VtZW50cywNCj4gPiB1c2VmdWwgaW4gZW52aXJvbm1lbnRzIHdoZXJlIGNvbW1h
bmQtbGluZSBhY2Nlc3MgaXMgcmVzdHJpY3RlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEdh
Z2FuZGVlcCBTaW5naCA8Zy5zaW5naEBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkb2MvZ3VpZGVz
L2NyeXB0b2RldnMvZHBhYTJfc2VjLnJzdCAgICAgICAgIHwgMTIgKysrKysrKystDQo+ID4gIGRy
aXZlcnMvY3J5cHRvL2RwYWEyX3NlYy9kcGFhMl9zZWNfZHBzZWNpLmMgfCAyNw0KPiA+ICsrKysr
KysrKysrKysrKysrKy0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZG9jL2d1aWRlcy9jcnlwdG9k
ZXZzL2RwYWEyX3NlYy5yc3QNCj4gPiBiL2RvYy9ndWlkZXMvY3J5cHRvZGV2cy9kcGFhMl9zZWMu
cnN0DQo+ID4gaW5kZXggZjk1YzYyODJiYi4uOTI1ZDMzNzFiZiAxMDA2NDQNCj4gPiAtLS0gYS9k
b2MvZ3VpZGVzL2NyeXB0b2RldnMvZHBhYTJfc2VjLnJzdA0KPiA+ICsrKyBiL2RvYy9ndWlkZXMv
Y3J5cHRvZGV2cy9kcGFhMl9zZWMucnN0DQo+ID4gQEAgLTEsNSArMSw1IEBADQo+ID4gIC4uICBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogQlNELTMtQ2xhdXNlDQo+ID4gLSAgICBDb3B5cmlnaHQg
MjAxNiBOWFANCj4gPiArICAgIENvcHlyaWdodCAyMDE2LDIwMjYgTlhQDQo+ID4NCj4gPg0KPiA+
DQo+ID4gQEAgLTE4OCw5ICsxODgsMTkgQEAgYWxvbmcgd2l0aCBvdGhlciB1c2VmdWwgZGVidWdn
aW5nIGluZm9ybWF0aW9uDQo+ID4gbGlrZSBzZXNzaW9uLCBxdWV1ZSwgZGVzY3JpcHRvciAgZGF0
YS4NCj4gPiAgZS5nLiBgYGZzbG1jOmRwc2VjaS4xLGRydl9kdW1wX21vZGU9MWBgDQo+ID4NCj4g
PiArQWx0ZXJuYXRpdmVseSwgc2V0IHRoZSBlbnZpcm9ubWVudCB2YXJpYWJsZSBgYGRydl9kdW1w
X21vZGVgYCB0byB0aGUNCj4gPiArZGVzaXJlZCBtb2RlIHZhbHVlLiBUaGUgZW52aXJvbm1lbnQg
dmFyaWFibGUgaXMgdXNlZCBhcyBhIGZhbGxiYWNrDQo+ID4gK3doZW4gdGhlIGRldmFyZyBpcyBu
b3QgcHJvdmlkZWQsIHdoaWNoIGlzIHVzZWZ1bCBpbiBwcm9kdWN0aW9uDQo+ID4gK2Vudmlyb25t
ZW50cyB3aGVyZSBtb2RpZnlpbmcgRUFMIGNvbW1hbmQtbGluZSBhcmd1bWVudHMgaXMgbm90IHBy
YWN0aWNhbC4NCj4gPiArZS5nLiBgYGV4cG9ydCBkcnZfZHVtcF9tb2RlPTFgYA0KPiA+ICsNCj4N
Cj4gSSB0aGluayBTdGVwaGVuIGhhcyBwb2ludGVkIG91dCB0aGF0IHRoaXMgaXMgYmFkIHByZWNl
ZGVudC4NCj4gRFBESyBoYXMgYWxyZWFkeSBhIHdheSB0byBjb25maWd1cmUgdG8gYXZvaWQgZW52
IHZhcmlhYmxlcy4NCj4gSXQgaXMgbm90IGNsZWFyIHdoeSB3ZSBuZWVkIHRoaXM/DQo+IFdoaWxl
IHRoZXJlIGlzIGEgd2F5IHRvIHNldCBlbnYgdmFyaWFibGUsIGJ1dCBjYW5ub3QgY2hhbmdlIGNv
bW1hbmQgbGluZSBhcmdzPw0KPiBJcyB0aGlzIGEgZGVidWcgdGhpbmc/DQoNClRoaXMgaXMgbWFp
bmx5IGludGVuZGVkIGZvciBkZWJ1Zy9kaWFnbm9zdGljIHVzZS4gTWFueSBvZiBvdXIgY3VzdG9t
ZXJzIGRvIG5vdCBleHBvc2UgRFBESyBjb21tYW5kLWxpbmUgYXJndW1lbnRzIGFuZCBpbnN0ZWFk
IHVzZSBhIGZpeGVkIHNldCBvZiBFQUwgcGFyYW1ldGVycyBidWlsdCBpbnRvIHRoZSBhcHBsaWNh
dGlvbiBvciBkZXBsb3ltZW50IGZyYW1ld29yay4gSW4gc3VjaCBjYXNlcywgYW4gZW52aXJvbm1l
bnQgdmFyaWFibGUgcHJvdmlkZXMgYSBzaW1wbGUgd2F5IHRvIGVuYWJsZSB0ZW1wb3JhcnkgZGlh
Z25vc3RpY3MgaW4gdGhlIGZpZWxkcy4NCg0KVGhhdCBzYWlkLCBJIHVuZGVyc3RhbmQgdGhlIGNv
bmNlcm4gYWJvdXQgaW50cm9kdWNpbmcgYW4gYWx0ZXJuYXRpdmUgY29uZmlndXJhdGlvbiBtZWNo
YW5pc20uIElmIHRoZSBwcmVmZXJlbmNlIGlzIHRvIGtlZXAgY29uZmlndXJhdGlvbiBzdHJpY3Rs
eSB0aHJvdWdoIGRldmFyZ3MsIEkgY2FuIHJlbW92ZSB0aGlzIHBhdGNoLg0K
