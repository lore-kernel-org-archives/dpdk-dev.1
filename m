Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62A7CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:08:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 260564021E;
	Mon, 13 Oct 2025 09:08:42 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
 by mails.dpdk.org (Postfix) with ESMTP id 73FE94013F
 for <dev@dpdk.org>; Mon, 13 Oct 2025 09:08:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkJBmN0Crggre9lnl2MIGD3FoGape4sp+bhXmCAP9FV29u9wH2kgn4/J9fC3qrA2mHybdDjKuh4EyEW4w7veE8063k+8iBCL58ij1AVycn5wiCo2DxpPupYH+h/bTG0fWKaCixhyaXdD4hd2bt8lgn4Srh+vNi34hyk4DPhp+X7JfIUenk4Ly8YQdxzLPfGtVlCrfGwyeGoVMjTgycd6FC4juixpqMUt6IrqRSWfOMgTXeIG8lFazZEsN0fciktEJpFnuCyXMRWkZpRViJd6fLkdIlyh22LcT5NSmVUx9v5e9E1VfjhaTj4t7DD64tMTz6KaWecgDJvwjCJ1Zfat7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RC/x6FYidk1jL6/kCLoBVohBFcym5IpBuzC2AqRzR4=;
 b=WLUkMt9lh9Iwf/SvY4jpgyYo+m4DBZ3f3aeZ+rAJQzq/OjM6QYmZXH4l1w601T57cPjfIEIpRKFQLwnRxMEW9g4mmVvR2Ul4f0SujlOz7PdOrcPWQGhGJpWLJwydlgzbaa0m8KDONuiHnpoBd3VCtOjYeaTMVcSGvGTlD+8u7uk5ICfEA3e6BUW+uFtUUfa0YA8GJ8IFiZoRENXVxFyyLQMvEq0yzUP5PE5qy0ljdCdvCwUnndXLo8MJ8pMNgcGI+ifCK54ZjbTu+Ylr3emAUMxVxK4KslPV28PcZRmyHZD/o+5s2F5Mu9vaOHeYyD+LFJLkEpBNMoGUVt9GqwZw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RC/x6FYidk1jL6/kCLoBVohBFcym5IpBuzC2AqRzR4=;
 b=hY4zdoyRaZ9GtI1otnhhgszcfLtzqLUmCrSv1x/RELN+hxdxrPSP4MHkWS7Ds5agZb4YrkTppg8QS8CEmh0xSf9U3iIjUcIW3WlFyhqSSDd3aJ3OYmUDp0abuFxEgyvoFvHdGzfAw2mOQoIqZXJcbwefVrVGaxRciXIMHWyHLUyLhbYie3bagXcCjaHzH2SGQLkbRDagCSXQplLR4mpauxB616Rbeos5xZh6BCdbW4ZwF/jBk1yaEGrUz7KaH+sRx/Gso2aGYEf0a0QLrNQKsdflUR/mSTFJ/sAJWI4qadq+H3pIG+l212j4+htNZ4jlFE9bX/5hxm+oMygjW7Qd9w==
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA4PR04MB9590.eurprd04.prod.outlook.com (2603:10a6:102:26f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 07:08:39 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:08:38 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: "Hemant Agrawal (OSS)" <hemant.agrawal@oss.nxp.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
CC: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: RE: [PATCH v2 5/5] net/dpaa: Fix coverity issue
Thread-Topic: [PATCH v2 5/5] net/dpaa: Fix coverity issue
Thread-Index: AQHcOA0DpAXCNFNuxkCCyAU5+Cgv3rS5k9kAgAYcKsA=
Date: Mon, 13 Oct 2025 07:08:38 +0000
Message-ID: <AS8PR04MB81987B4C79A51D99A35A00DFE1EAA@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
 <20251008043519.2461707-1-g.singh@nxp.com>
 <20251008043519.2461707-6-g.singh@nxp.com>
 <87aaf909-e17c-47c7-a83e-acf61d2fdb03@oss.nxp.com>
In-Reply-To: <87aaf909-e17c-47c7-a83e-acf61d2fdb03@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8198:EE_|PA4PR04MB9590:EE_
x-ms-office365-filtering-correlation-id: 241ff165-5c80-4c7b-937a-08de0a275598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UnpoY1F0MFcrcDFRQWJrWHpEdUtlcE96enJ2M3Y1UlRRa0ErL014UnpqTGFh?=
 =?utf-8?B?UkowbVhsYmd3NFZKdTZ1T0g3eU8wQit3c1dtK3lzaU1maTM5VlIwT2lFQXY0?=
 =?utf-8?B?T094SjhwS2lOd3JITWdhNGw2VTM2RUpwL1NPTUJ1TFBaN0pEWEt3cy9nSHUw?=
 =?utf-8?B?M0tna1FDblNHSHRHZ203STNCZjl3VE41cjZUUkxtWWNKbUw2N1pacFBxRWIw?=
 =?utf-8?B?QkJDaWd0M3B5WGd5UzZZZUJ1QndYbW1qRjRidnN6ZDJrTGtDU3JuWkZzS3Y0?=
 =?utf-8?B?YUFsMjBhV0NMblF2TVA2UVphVmF4d2JCcWF1U2xyT1E4ZXdnTEZFaXpIOEVM?=
 =?utf-8?B?NXEvNThyazU5NXdEOERKYjhyUkRQZWNmNlF2U0YxY2NjNmQxN2ZNVC9VYXhB?=
 =?utf-8?B?UHpzbitYSkFRV0pRRVZ4bFBleXBVcnpBV2w0b3A0bm91UGM1OXdTQnhleUpH?=
 =?utf-8?B?TlBtNHIxVDVJb0Z3VTNqVGRlS1Q4UWh3MGJZSllBMU02MCtYbmZWeVJId0xp?=
 =?utf-8?B?RUozTHBHZlRVVE44Sm14ZUJXcmk2Z2JJWlB5WXJxTlY3SUgvMjd0ZzhwbE9Q?=
 =?utf-8?B?WmN0eGxIMU1PdmQxODNEVzBoaENwRFVvc1ZwSFRRb1RzK2RNcGRMbVI4Rzk1?=
 =?utf-8?B?VGVRNjhSbUxOTjluc1AwSGpLdzhZaEQrY0dtR01JQ2hxSnFjVmMyeE1Nam9P?=
 =?utf-8?B?OWt5c2tEWUtMbDk3dGNYSnVUM2xuTFZmdVFtN09UTG5tMkw1aEJsUy9BNXpB?=
 =?utf-8?B?RUNKTDduRWxDTVQ1cjloajM1RThNVGtWS1NvUlFMaThBWmw5VUVnRGk4NmRG?=
 =?utf-8?B?TmovTGRVSlYvV3dBbHgrV1ZoYWFKYStHQ0xGN1pwSUNicDY4VG8zMUhOZk1m?=
 =?utf-8?B?aktxQmN1Wms1cE1kVjZyenI5ajdiVEUvTFduMUlzU3p4WkNSZ0wrVDRoc0R1?=
 =?utf-8?B?QkFrS1B5b09Fcloxd2JYSGxUUUd4cmNiYytKWFJ5N3FvVDViUTlFa2UvVVB6?=
 =?utf-8?B?QkgxK2ZDR3dvQW1RSGd4TjllOWNSWldEaDFsMDZZVUdSRmNZN3hIOGo1WlFT?=
 =?utf-8?B?SXI1cUY2N0lVZ2wyVFRHMEhzYUI4UXlHVWg1Vi85eTRZdndKYjlYMFQzK0Z3?=
 =?utf-8?B?bXhvT1VGcUV2ZStheFU5YlRGR01pOCtEYzBBbXpmbHNheDJwTWVBWHAwbDJL?=
 =?utf-8?B?N1B2YWpySUQrejFhajkybjdLSk1CV1NFaUpwR1VXemt5SEx2UjMybUJXdDlK?=
 =?utf-8?B?VGZLa1dsVWdvMjJ6ajRhV0pwVGhqRWovaTNRZFg1MEthSGhZbmJKa3p0c2tl?=
 =?utf-8?B?VEdDNTNJaGVBQllnYWNBZ1RjaXU5SUUwd29ZZlZBNWJaSFpNYXVTaC9KdHJ2?=
 =?utf-8?B?d0lrTTBVWWJNZGtoeVJQS2h6N1BMZkNxUUN0Y0xwVWtLdnAwZmoxSEhtUnNY?=
 =?utf-8?B?WXo5WkYyTGlWckduQi9zdnIwbXNFSkd6KzFIN2poNkVaRm1NSG1MbHFIR1RV?=
 =?utf-8?B?VytkT1RROGRPM09Kb2ljcWtYYzdTSjBrRklMV2xOKzUyK3lwZkg4QmttT3hC?=
 =?utf-8?B?bkxtVnB4amdzNGYvRjZySldNMmdkNkhGY1ZSRFp0NkpMcWVLdjB4ZlpFa1J1?=
 =?utf-8?B?ZUZqdDk2Z095VHFNV0xyS0RGOGlJYStuK3V2SDJnYVRIUWwwdEhZemhWNXJq?=
 =?utf-8?B?Z0VaTHQ5bmNFQm5XWFpRNTdGZUFFWTMrRk5WR08wZDNlRmh1N0M5OHNmMlpx?=
 =?utf-8?B?cWlDa0hEZXZud2lZSFFuWFlQUzA5enJqcE5EY0Fza2IrQmtBQjcvNWpjR2Uw?=
 =?utf-8?B?aFB4eDdodUZiVlpvaWNESmwveExaeXNJS1g4dmRGTlViakNwUzhQdjJTcFdV?=
 =?utf-8?B?Sjc1S01valFRU2l2c1hKTWFCTEQ2WmU2OXBwS1FIbUtuNlY1elc2M3Zrd2dy?=
 =?utf-8?Q?2j2zobPMZh1tcH3Fw+DDKh2O8SgJxG7X?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTk2bWJJNm11QTFsZnE5clJqaW1CV1gyajdKMG1rUElSOHVHYnFaMnJVWkpr?=
 =?utf-8?B?am81VXFaQnFTM0hIYkZDV3IzVFlPMVBpY3hBZVRqOHBUTEgzaFlyeHNIQkpX?=
 =?utf-8?B?UEpCclE3MTVwL29qOElzZU5TbEF0WkZtTDhYNWpmMkh3K252QUpJVHc2NUVF?=
 =?utf-8?B?QU9JNDBSNjRYUkNOeUU3UitqMklBUDhlbnFMOForT3NJOGI2Mk1WbkV0RTJD?=
 =?utf-8?B?amdWV3g0TDNSdUlnMFNTMHYxdkNTZ2JyNk5PMWlhejJGMFFHbUt1RlVCQUgz?=
 =?utf-8?B?Z09BR1FCWVFBTGpEVTNYVGdTSzRFSW5VUm1FRTN4aXVsVzBvSDEyWkMvV0hl?=
 =?utf-8?B?K2dVQ2d1WUs0cXY0ZFNPcGNMZURWWnNpTDZJT0tLc1g1K1djSW11LzBPa1Bw?=
 =?utf-8?B?WnF3ZGt2cGMvaFBkQjRqUU9uVTJGSncvMWIvSjZheExMWEtVd0xKekNFdWhB?=
 =?utf-8?B?U0ZxNEtpTzBwT0JwYlhCSXhUMUVtemJlUnE1by9RMThMZ0c3WmxTVEYxMjJ6?=
 =?utf-8?B?ZTBVRGN4SWdoVDBuMDg5dE9ZTFhoQlcyb05GQ1VLckhPTjBsTmdMNDM2b3Y0?=
 =?utf-8?B?NXNWWEk4aEVYc1VFQkd4WGRVbzg5amlYa0ZwT3lNb2VXQ1NRVUxxQUkyNndv?=
 =?utf-8?B?MXBtY2R1cDF4TFo3VndORTZIS0FVaGlsVklGOCs5UDJGVnJRV0loN2JWL0Yz?=
 =?utf-8?B?dnNUN1E4RFZkWG9leEVFZ0ZRaHFCSVpZSWNhKzhLVlBjWEVYS1dzTjdpNGRo?=
 =?utf-8?B?WEF0TkRoK1QybFR2WVhjS2dkOXYyM2JsU016dVpENG5HRTFGTjNPUGdnem9i?=
 =?utf-8?B?c0FyT0E4eXlaVSs5dkVmMjRGM1FCTko1dE5VSVI4SUt3NThnc3p2VXJBeC9D?=
 =?utf-8?B?YnVQeVdkTXJSZGlLWi9qbzBMRHBVcEJ6ZGo2Wi93bW43OTBnb2VabEV0eTZP?=
 =?utf-8?B?VXlTMVdDVWRuNWpqSjN0V2s4aWJyZnFrMi9sTkJ2Skc2dnRCemE1NHUwZHNQ?=
 =?utf-8?B?Y2JISlZpeUNLb1lhd3BzU1dKR0dSZmxCdVl1b1puWGZ3YnJlSGxMKzB6Sjky?=
 =?utf-8?B?UVRRQ0dmYzdKaGxlS3prRW0yNmdrL3h6VnhPRkJLTWdKeXhxK283czRSL2pw?=
 =?utf-8?B?MDVCai9zaVB1VHlNbGdMRTN1VXhYV01aTHBXSnNQVmZ0aHF6N1JmQks3Vnlo?=
 =?utf-8?B?SHJTWUE2R0x6UjNZQkpjZ1o2UUh4SjZBbC83MzV1ZThqSUg0RVZyM3dpWURu?=
 =?utf-8?B?aHdHb0dIVXdSb1lKK3dGRkJEZ05mYTlQODRtdHZvdXdFV05GTGo1bWtPdHRv?=
 =?utf-8?B?TGFqN0xwL0t2NUdkYXRmQkNTSU5ES2pENmVHd0J4V3Q3cHNWZEg0STh4R0NZ?=
 =?utf-8?B?U05KZ1p2L2ZkaDRtYWJma0NPTkRVbHFqQnR5NVVqNDVmc0cxZFU4S0pBV05y?=
 =?utf-8?B?VFIwMm5DODFrNm05QjgyRGVLWE5DOEZWTmdHVlk3TDZXQVNQOXUxQjlCUCt2?=
 =?utf-8?B?V0lkNjQyVUdUZzRrZjQvMlNQelBhRnkxZ2V2a1kvVWVVZEpFUVlpRFVVaGFQ?=
 =?utf-8?B?REtCUHVObFBvdG80d0U0c3huY3drWkUzMndXaVBOVndPWm1Zd0g4NStyRTZ6?=
 =?utf-8?B?U3ZDY2Y0QVVrdUFsbkNYWkV2VG1YVytQN2ZDb0E5cjNDZlRVV0FVdmZ2bU1N?=
 =?utf-8?B?TSs5cmJDWFgwenBFMUQ4RmRsUTR0N0hZUnl1UWJSejFySGNrVUtYNkxpWHd3?=
 =?utf-8?B?WFBpZzlLQVFkUFpQaDBKRzJqSE9uTUxVSjVNVTl3WnY5c0o3Y1ZMaHlvUFNs?=
 =?utf-8?B?SGlIZlhLeW5VaTVMN3VuMzF0dzBZaEVTWkVySEp5SFVmVDV3WnI1T3huOEsw?=
 =?utf-8?B?YTJoR1I2cS9SNm9TeXFNVkZlNUs0c0RySFJaaGZtYkxaeUhmaHJ3SDlaTGNO?=
 =?utf-8?B?UElBSXJnREJSZ0NmUzlWQXVXQmtoWTdiYWcyV25Jc2N5TVBxNXpUKy8zQXNC?=
 =?utf-8?B?cEFaUm02ZndST2lZTEVlRCs4ckNyVnREMk1EQUc5OGxmTVljY0UwdUVYdTFM?=
 =?utf-8?B?S0JNVkVlVitvZ1ZHaU9SanBkK29LS0orRy9CdGVFYWlQbDMzSENxV2QwbHdU?=
 =?utf-8?Q?fKSA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241ff165-5c80-4c7b-937a-08de0a275598
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 07:08:38.8676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrpRxABhT8JHyJ1YwA8qWl/mCEIOJF5rHkdVEJ9wS/r5KiHFlhR7WUOlBiPEAhRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9590
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

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZW1hbnQgQWdyYXdh
bCAoT1NTKSA8aGVtYW50LmFncmF3YWxAb3NzLm54cC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBP
Y3RvYmVyIDksIDIwMjUgMzoxOSBQTQ0KPiBUbzogR2FnYW5kZWVwIFNpbmdoIDxHLlNpbmdoQG54
cC5jb20+OyBkZXZAZHBkay5vcmc7IEhlbWFudCBBZ3Jhd2FsDQo+IDxoZW1hbnQuYWdyYXdhbEBu
eHAuY29tPjsgU2FjaGluIFNheGVuYSA8c2FjaGluLnNheGVuYUBueHAuY29tPg0KPiBDYzogVmFu
c2hpa2EgU2h1a2xhIDx2YW5zaGlrYS5zaHVrbGFAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiA1LzVdIG5ldC9kcGFhOiBGaXggY292ZXJpdHkgaXNzdWUNCj4gDQo+IA0KPiBPbiAw
OC0xMC0yMDI1IDEwOjA1LCBHYWdhbmRlZXAgU2luZ2ggd3JvdGU6DQo+ID4gRnJvbTogVmFuc2hp
a2EgU2h1a2xhIDx2YW5zaGlrYS5zaHVrbGFAbnhwLmNvbT4NCj4gPg0KPiA+IEZpeCBSZXNvdXJj
ZSBsZWFrIENJRDozNjI3ODcgaXNzdWUgcmVwb3J0ZWQgYnkgZXh0ZXJuYWwgY292ZXJpdHkgdG9v
bC4NCj4gDQo+IFRoaXMgaXMgaW50ZXJuYWwgTlhQIGNvdmVyaXR5IGlzc3VlP8KgIGNhbiB5b3Ug
YWxzbyBhZGQgZGV0YWlscyBhYm91dCB0aGUgaXNzdWUgaGVyZT8NCj4gDQpObywgVGhpcyBpc3N1
ZSBpcyByZXBvcnRlZCBieSBEUERLIENvdmVyaXR5IHNjYW4gdG9vbDogaHR0cHM6Ly9zY2FuNC5z
Y2FuLmNvdmVyaXR5LmNvbS8jL3Byb2plY3Qtdmlldy82ODg2OC8xMDA3NT9zZWxlY3RlZElzc3Vl
PTM2Mjc4Nw0KSSB3aWxsIGFkZCBtb3JlIGRldGFpbHMgaW4gY29tbWl0Lg0KDQo+IA0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogVmFuc2hpa2EgU2h1a2xhIDx2YW5zaGlrYS5zaHVrbGFAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0L2RwYWEvZHBhYV9mbG93LmMgfCA2ICsrKy0t
LQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kcGFhL2RwYWFfZmxvdy5jIGIvZHJp
dmVycy9uZXQvZHBhYS9kcGFhX2Zsb3cuYw0KPiA+IGluZGV4IDJhMjJiMjNjOGYuLjQxN2I5YjZm
YmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZHBhYS9kcGFhX2Zsb3cuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L2RwYWEvZHBhYV9mbG93LmMNCj4gPiBAQCAtMSw1ICsxLDUgQEANCj4g
PiAgIC8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBCU0QtMy1DbGF1c2UNCj4gPiAtICogQ29w
eXJpZ2h0IDIwMTctMjAxOSwyMDIxLTIwMjQgTlhQDQo+ID4gKyAqIENvcHlyaWdodCAyMDE3LTIw
MTksMjAyMS0yMDI1IE5YUA0KPiA+ICAgICovDQo+ID4NCj4gPiAgIC8qIFN5c3RlbSBoZWFkZXJz
ICovDQo+ID4gQEAgLTg4OSw5ICs4ODksOSBAQCBpbnQgZHBhYV9mbV9pbml0KHZvaWQpDQo+ID4g
ICAJLyogRk0gUENEIEVuYWJsZSAqLw0KPiA+ICAgCXJldCA9IGZtX3BjZF9lbmFibGUocGNkX2hh
bmRsZSk7DQo+ID4gICAJaWYgKHJldCkgew0KPiA+IC0JCWZtX2Nsb3NlKGZtYW5faGFuZGxlKTsN
Cj4gPiAtCQlmbV9wY2RfY2xvc2UocGNkX2hhbmRsZSk7DQo+ID4gICAJCURQQUFfUE1EX0VSUigi
Zm1fcGNkX2VuYWJsZTogRmFpbGVkIik7DQo+ID4gKwkJZm1fcGNkX2Nsb3NlKHBjZF9oYW5kbGUp
Ow0KPiA+ICsJCWZtX2Nsb3NlKGZtYW5faGFuZGxlKTsNCj4gPiAgIAkJcmV0dXJuIC0xOw0KPiA+
ICAgCX0NCj4gPg0K
